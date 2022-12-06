Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB796442F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiLFMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiLFMIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:08:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D21054C;
        Tue,  6 Dec 2022 04:08:12 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670328490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOchanOPT3T0rVYg76BTFT5x8A0i2ssn7xjg7cU7rxM=;
        b=hizXk9UtkbIMwyGTvGhaGw+ur1NmQ++i8IvREyxa01nMiTNKqM358HeqcM7nmCXf6tq+4m
        kAdee5lyKv5lMtRirM/V7xV9PDW7Uh95PkX1J+1SVzo6tERYDcKpdQRAAstft5BgnNXFEK
        VYb4i4tjZvME8ngrPbqI78sl5CPJmWMjyHA5ZwcWt94K9NH5RRxcdrTbyZTBBOCT31dXBs
        5HDcMdjVzsr3r3ro2mjXSW3QtsPAJFxAfOJKYBxoe50vYTMqbBjoH6PMj/BpsmY2rCzixW
        Eye+ZrrOhGZMMc99udiI4lpsUOIGOrNiUSCNZMYwjJbgJ6Rx0JLzgdY+at48NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670328490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOchanOPT3T0rVYg76BTFT5x8A0i2ssn7xjg7cU7rxM=;
        b=7JhFV7EGr8y99Ay5PQGR08/BewXnw4DPgoTHp1ZMKTVoUVueEyoQ13iXdHX47dbFMpr4yu
        UlCOD/wM7BPC7FDA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>, lirongqing@baidu.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        tony.luck@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle-haltpoll: Disable kvm guest polling when
 mwait_idle is used
In-Reply-To: <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
References: <1670308998-12313-1-git-send-email-lirongqing@baidu.com>
 <CAJZ5v0gG93BXZWOcRVpng_EN-h4+sOyUqTc1XRt4xZkqMnaZZw@mail.gmail.com>
Date:   Tue, 06 Dec 2022 13:08:10 +0100
Message-ID: <87mt80g2fp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06 2022 at 12:59, Rafael J. Wysocki wrote:
> On Tue, Dec 6, 2022 at 7:43 AM <lirongqing@baidu.com> wrote:
>>
>> +bool is_mwait_idle(void)
>> +{
>> +       return x86_idle == mwait_idle;
>> +}
>> +EXPORT_SYMBOL_GPL(is_mwait_idle);

No, this is just another adhoc check, which scratches ONE particular itch.

>> @@ -111,6 +112,9 @@ static int __init haltpoll_init(void)
>>         if (!kvm_para_available() || !haltpoll_want())
>>                 return -ENODEV;
>>
>> +       if (is_mwait_idle())
>> +               return -ENODEV;
>> +
>
> So perhaps you could make default_enter_idle() be a bit more careful
> about what it calls as the "default idle" routine?

Correct. arch_cpu_idle() is the one which should be called.

Thanks,

        tglx

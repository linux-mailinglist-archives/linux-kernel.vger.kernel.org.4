Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838C95EF8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiI2Pal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiI2Pag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:30:36 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C15A17E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J0QcEJZH30kfY+NXeRpDRgwnLNBhUJp4WTBwQ7RFJsY=; b=j+WVuCijoeRPHWW+1n4j2MYdiN
        DeWB2p9VOb6ydPgi8oYp1Ec1eQ7GC7ftQ1vXUPFFmqj7aSiXJoL2lBBxh6xjmcPNESrbFshJWdEAK
        bPOnQix1spOxUhimvEATAmlYnJqRGXhu1S61lzm531RA/GLtd6WyVTKNuuP4iYVAqCLAxW4snIWDJ
        lmAohSMREX27ohra+buIcyAIsceyglNBQfKJHxunL/QFEB1ehZ/lSZa6uONYPpdn+KR6ivbGTf5OW
        azgTcKyzz+QBi5wmZUk0IJT2qG4wyUkporLaOs3xGv3J3ZaGXo3SZqxr7MdX4hTCiCcprQFw5mCUn
        PY5oR0UQ==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1odvUX-00GgKu-LH; Thu, 29 Sep 2022 17:30:25 +0200
Message-ID: <7917fde2-a381-5404-c5ae-6ffd433f85ec@igalia.com>
Date:   Thu, 29 Sep 2022 12:30:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, tony.luck@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <24f31510-5b33-ada5-9f0e-117420403e8c@intel.com>
 <1c742ae1-98cb-a5c1-ba3f-5e79b8861f0b@igalia.com>
 <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <cc8d0101-73b9-b286-a7a7-e9305cdc1bd9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 12:17, Dave Hansen wrote:
> [...]
>> Hi Dave, thanks for your response. I really appreciated your reasoning,
>> and I think it's a good argument. In the end, adding misery would harm
>> the users that are unlikely to be able to fix (or at least, fix quickly)
>> the split lock situation, like games or legacy/proprietary code.
>>
>> I have a revert removing the misery ready and tested, let me know if I
>> should submit it.
> 
> I'm a bit of a late arrival to the split lock party, so I'm a bit
> hesitant to merge any changes immediately.
> 

OK, agree that we could indeed gather more opinions, like Thomas' and
other interested parties. But...


> How about we give it a few weeks and see if the current behavior impacts
> anyone else?  Maybe the best route will be more clear then.

...I disagree in just letting it fly for weeks with all players of God
of War 2 running modern Intel chips unable to play in 5.19+ because of
this change.

Certainly we have more games/applications that are impacted, I just
don't think we should wait on having 3 userspace breakages reported, for
example, to take an action - why should gamers live with this for an
arbitrary amount of time, until others report more issues?

Cheers,


Guilherme

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA83973A0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFVM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjFVM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBFF199D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687436840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erLEJFFmN1Si57UTDFO+md6AnHLgrWd6t+5xkKTrdTo=;
        b=WjAEYcDddX2z0wcR9meFjGolps5fzbDl5zzg0qgO/+oPReM/XSSQhZlWlfnHl/OSJsfWec
        QD1tHe+9KMphF27z/U/HjXmKCmci6lwTLSTwwZrs2H3/eIrnL8QqHjz+ZGaKhWpx4Q7tO3
        yzBDJY1bm2LE4CNqsjN18IedeYnvtGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-guJMTKOAPz-lqf1ByoKNRw-1; Thu, 22 Jun 2023 08:27:15 -0400
X-MC-Unique: guJMTKOAPz-lqf1ByoKNRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3692E83FC20;
        Thu, 22 Jun 2023 12:27:14 +0000 (UTC)
Received: from [10.22.17.29] (unknown [10.22.17.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 663244087C70;
        Thu, 22 Jun 2023 12:27:13 +0000 (UTC)
Message-ID: <921e1b98-af36-1f51-5abe-dea36425b706@redhat.com>
Date:   Thu, 22 Jun 2023 08:27:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/3] x86/idle: Disable IBRS when cpu is offline
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
 <20230622003603.1188364-2-longman@redhat.com>
 <20230622054053.uy577qezu5a65buc@treble>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230622054053.uy577qezu5a65buc@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 01:40, Josh Poimboeuf wrote:
> On Wed, Jun 21, 2023 at 08:36:01PM -0400, Waiman Long wrote:
>> +/*
>> + * naitve_play_dead() is essentially a __noreturn function, but it can't
>> + * be marked as such as the compiler may complain about it.
>> + */
> FWIW, we could in theory do so by marking the smp_ops.play_dead function
> pointer as __noreturn, but it would be tricky to teach objtool how to
> understand that.
I added the comment here because I had taken out the MSR restoration 
code. We can always replace that later on if there is a better way to do 
that.
>
>>   void native_play_dead(void)
>>   {
>> +	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
>> +		this_cpu_write(x86_spec_ctrl_current, 0);
>> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>> +	}
> Can update_spec_ctrl() be used instead?

Yes, the code is similar to what has been done in update_spec_ctrl(). 
Using it, however, will require exporting the function either by putting 
it into a public header or making it a global function.

Cheers,
Longman

>


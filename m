Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1227B70DB08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjEWK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjEWK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B39119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684839462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ0nZCW3MFVFDtLFej2MU/t6cdsfnpL0O0gs9bg+QYI=;
        b=Cskz0EIC+ZMfiWZ4eGKIFw/7zSKbcmE2ecbZpDMBxW7/CT+No/qtaiDgydpraRm0crXJ//
        Iz2neoqAPRmGW7hM6IXpCYYgWUGbbYfmGkMx16fr7Kh07pqx/BJd/nFIMjXg3KXeNczZ6w
        P/JD965F32d2tvUiKMBlUAqZfm6LxDs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-4mKdDR5CM-6nt9ploTM4kQ-1; Tue, 23 May 2023 06:57:41 -0400
X-MC-Unique: 4mKdDR5CM-6nt9ploTM4kQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-96fa4c724fdso416731066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839460; x=1687431460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ0nZCW3MFVFDtLFej2MU/t6cdsfnpL0O0gs9bg+QYI=;
        b=glKoMCKuvHCRer6LwHeKv2m82fG4huWIRejUaLznT97/BHRNNXbm3YR/5/jk1UC5+Z
         lBnVqzdNjpn3H/i8Y7+5SENiSixnWp1BHDWcPNfaS9ImtgS4Gi2mfzEzWVEV4bFQM8I6
         TtHQQWMMjR/Tc1+MKWxCvK3tQAeyv/L0m0Bf2x6qQXvlRFGV4+c5qsT29RFzUCPTBztU
         9UJph1dJdXE8WPPSyy1/DkrL552FubW9tYCqIXpv7C3y9Ph1gyDa7CaB3uPplu8h8Bb1
         6Hpk0smZKwETxZ+ZH/Uobyqd0orNXhcPMcwhiQS+WS0EXQwfK5KShNy07TxbYLU+6toy
         TgUQ==
X-Gm-Message-State: AC+VfDxmr4q6K90MOiHHaZNnp/10k42SjGm4vf9SSU+ejg9eTU4+AAtH
        PhRZ7/hYjht0MJowvYK15tmhElbBwD7l5X3iRcGUurxfTxOChj6BvGuFpXzi5HGEbutkWhVKsoZ
        t+sZiiPL+B5+VnX4I2qi/i+KZ
X-Received: by 2002:a17:907:930d:b0:96a:2dd7:2ee0 with SMTP id bu13-20020a170907930d00b0096a2dd72ee0mr12333146ejc.5.1684839460693;
        Tue, 23 May 2023 03:57:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5R/ny+kGH/gT+o4UMnrnlpA/YR5sLcCvHjVcj1Knsevjc+AmvFA0QzN4E8hMQb2lZmbCi4lA==
X-Received: by 2002:a17:907:930d:b0:96a:2dd7:2ee0 with SMTP id bu13-20020a170907930d00b0096a2dd72ee0mr12333128ejc.5.1684839460372;
        Tue, 23 May 2023 03:57:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090616d400b009662c57b4ffsm4332344ejd.96.2023.05.23.03.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:57:39 -0700 (PDT)
Message-ID: <4897786d-e34a-38b9-3dd1-26571bcab54f@redhat.com>
Date:   Tue, 23 May 2023 12:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86/intel/ifs: Annotate work queue on stack so
 object debug does not complain
Content-Language: en-US, nl
To:     David Arcari <darcari@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230523105400.674152-1-darcari@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230523105400.674152-1-darcari@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/23/23 12:54, David Arcari wrote:
> Object Debug results in the following warning while attempting to load
> ifs firmware:
> 
> [  220.007422] ODEBUG: object 000000003bf952db is on stack 00000000e843994b, but NOT annotated.
> [  220.007459] ------------[ cut here ]------------
> [  220.007461] WARNING: CPU: 0 PID: 11774 at lib/debugobjects.c:548 __debug_object_init.cold+0x22e/0x2d5
> [  220.137476] RIP: 0010:__debug_object_init.cold+0x22e/0x2d5
> [  220.254774] Call Trace:
> [  220.257641]  <TASK>
> [  220.265606]  scan_chunks_sanity_check+0x368/0x5f0 [intel_ifs]
> [  220.288292]  ifs_load_firmware+0x2a3/0x400 [intel_ifs]
> [  220.332793]  current_batch_store+0xea/0x160 [intel_ifs]
> [  220.357947]  kernfs_fop_write_iter+0x355/0x530
> [  220.363048]  new_sync_write+0x28e/0x4a0
> [  220.381226]  vfs_write+0x62a/0x920
> [  220.385160]  ksys_write+0xf9/0x1d0
> [  220.399421]  do_syscall_64+0x59/0x90
> [  220.440635]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  220.566845] ---[ end trace 3a01b299db142b41 ]---
> 
> Correct this by calling INIT_WORK_ONSTACK instead of INIT_WORK.
> 
> Fixes: 684ec215706d ("platform/x86/intel/ifs: Authenticate and copy to secured memory")
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Jithu Joseph <jithu.joseph@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans





> ---
>  drivers/platform/x86/intel/ifs/load.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index 61dffb4c8a1d..e6ae8265f3a3 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -208,7 +208,7 @@ static int scan_chunks_sanity_check(struct device *dev)
>  			continue;
>  		reinit_completion(&ifs_done);
>  		local_work.dev = dev;
> -		INIT_WORK(&local_work.w, copy_hashes_authenticate_chunks);
> +		INIT_WORK_ONSTACK(&local_work.w, copy_hashes_authenticate_chunks);
>  		schedule_work_on(cpu, &local_work.w);
>  		wait_for_completion(&ifs_done);
>  		if (ifsd->loading_error) {


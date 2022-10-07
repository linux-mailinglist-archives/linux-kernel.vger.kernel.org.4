Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58AE5F7E43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJGTnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJGTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:43:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CAACAE69
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:43:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g10so1533749qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqgk7vTnYRdgM+TBPIIE0L5bk7Y3lTOw+hP6zTPy1KM=;
        b=avtqMfUEcHFO1JfCRrFH72Cg2hchtm2k8yPK73wOY6Jxi0eDk58mZxoWnUrOmLFXQ1
         mQ1oA83th6sfCOm1bysSU52JYrsQjc6mwg9Re0gM9eOg8ICUiKUIa5Hil9px5jRMqQ9E
         e2tQ9+YTcrkiDko4X051GiCCC+QNzjMr4ByBnrl6wm9wYNzkC5UvpShq7ijG831N0iBP
         NmP9jXobbx7S8M2tRf9XK5yJ/V2EzZDBZIyFglBGaDQG06sAKD2QUZM85LjGJ+CK4m+7
         5NVD/NGCyThZdKMtrpuOpPxd0YZB5rUmcQWC8RSYmiS3kJ3S+ZIxgXN6NQ0FENHq7pWk
         a3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sqgk7vTnYRdgM+TBPIIE0L5bk7Y3lTOw+hP6zTPy1KM=;
        b=UfuBba+cXWi2ojBTbG1f0vZ3jP43lCiWMidOFeglbEHLUfLHfM/DFLR+rL0Tjs0OYq
         67EYhacpM8oIhi6EglVHmano2Kl+iXhrr9IdF2osULIbzrgGrQVIOW0SvoJ3Hz1FJJzT
         cAJgQFDvDoBfe/appElYyHk3zL+F9hJHUXmtcDnXbCJKvZqTUqxmYgLvTyJPUwwHd78n
         f4fTIajHz/i9OOmaR3rV9uOpNsHNafnizsW/xGgMTG+fJf/ULw6zYnpLBHk2TSMDISNx
         rJ5gM/g56cZ7sWuS5MsoqBzobVRZi3IarzR/qaORdVs+KgTLOru0sHDYAqEdwnjee6Pl
         c8AQ==
X-Gm-Message-State: ACrzQf19amP2hq5gaWFMvNb2Z9X30J/5Ld48R5mtRbNYwp7UrgoXu/fe
        /WnJnPJxJY++gPEUvOvXlzAXshaDcA==
X-Google-Smtp-Source: AMsMyM5xOXbI645N/nUn8wJtxRDISFGE1jRSLqkpwvvIvI1uwBUoF8NeY9/djTCGvticrw2n/hAyTQ==
X-Received: by 2002:a05:622a:150:b0:35d:4775:53be with SMTP id v16-20020a05622a015000b0035d477553bemr5623336qtw.35.1665171823795;
        Fri, 07 Oct 2022 12:43:43 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id w2-20020a05620a444200b006ce1bfbd603sm2857969qkp.124.2022.10.07.12.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:43:43 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:fa3f:9b5b:700:c1ba])
        by serve.minyard.net (Postfix) with ESMTPSA id 3D4621800BD;
        Fri,  7 Oct 2022 19:43:42 +0000 (UTC)
Date:   Fri, 7 Oct 2022 14:43:41 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
Subject: Re: [PATCH 1/3] ipmi: fix msg stack when IPMI is disconnected
Message-ID: <Y0CBbRqGPDU3g9hQ@minyard.net>
Reply-To: minyard@acm.org
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
 <20221007092617.87597-2-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007092617.87597-2-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:26:15PM +0800, Zhang Yuchen wrote:
> If you continue to access and send messages at a high frequency (once
> every 55s) when the IPMI is disconnected, messages will accumulate in
> intf->[hp_]xmit_msg. If it lasts long enough, it takes up a lot of
> memory.

The IPMI driver really wasn't designed to handle this sort of thing.  If
there is a BMC there, it should be there except when it's rebooting,
which should only take a few seconds.  Which is what this is all
designed to handle.

> 
> The reason is that if IPMI is disconnected, each message will be set to
> IDLE after it returns to HOSED through IDLE->ERROR0->HOSED. The next
> message goes through the same process when it comes in. This process
> needs to wait for IBF_TIMEOUT * (MAX_ERROR_RETRIES + 1) = 55s.
> 
> Each message takes 55S to destroy. This results in a continuous increase
> in memory.
> 
> I find that if I wait 5 seconds after the first message fails, the
> status changes to ERROR0 in smi_timeout(). The next message will return
> the error code IPMI_NOT_IN_MY_STATE_ERR directly without wait.

So basically, you will stay in error state until the BMC recovers.  The
KCS state machine will reject messages until the state machine detects
that the BMC is working again.  I think this is ok.

Have you tested that if the BMC comes back that the driver recovers and
works?  Looking at the code it seems to be the case, but can you test to
be sure, if you have not already?

Also, the following is in start_kcs_transaction():

	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
		dev_warn(kcs->io->dev, "KCS in invalid state %d\n", kcs->state);
		return IPMI_NOT_IN_MY_STATE_ERR;
	}

You probably need to remove the (kcs->state != KCS_HOSED) part of this
now.  Would you agree?

-corey

> 
> This is more in line with our needs.
> 
> So instead of setting each message state to IDLE after it reaches the
> state HOSED, set state to ERROR0.
> 
> After testing, the problem has been solved, no matter how many
> consecutive sends, will not cause continuous memory growth. It also
> returns to normal immediately after the IPMI is restored.
> 
> The verification operations are as follows:
> 
> 1. Use BPF to record the ipmi_alloc/free_smi_msg().
> 
>   $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc
>       %p\n",retval);} kprobe:free_recv_msg {printf("free  %p\n",arg0)}'
> 
> 2. Exec `date; time for x in $(seq 1 2); do ipmitool mc info; done`.
> 3. Record the output of `time` and when free all msgs.
> 
> Before:
> 
> `time` takes 120s, This is because `ipmitool mc info` send 4 msgs and
> waits only 15 seconds for each message. Last msg is free after 440s.
> 
>   $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc
>       %p\n",retval);} kprobe:free_recv_msg {printf("free  %p\n",arg0)}'
>   Oct 05 11:40:55 Attaching 2 probes...
>   Oct 05 11:41:12 alloc 0xffff9558a05f0c00
>   Oct 05 11:41:27 alloc 0xffff9558a05f1a00
>   Oct 05 11:41:42 alloc 0xffff9558a05f0000
>   Oct 05 11:41:57 alloc 0xffff9558a05f1400
>   Oct 05 11:42:07 free  0xffff9558a05f0c00
>   Oct 05 11:42:07 alloc 0xffff9558a05f7000
>   Oct 05 11:42:22 alloc 0xffff9558a05f2a00
>   Oct 05 11:42:37 alloc 0xffff9558a05f5a00
>   Oct 05 11:42:52 alloc 0xffff9558a05f3a00
>   Oct 05 11:43:02 free  0xffff9558a05f1a00
>   Oct 05 11:43:57 free  0xffff9558a05f0000
>   Oct 05 11:44:52 free  0xffff9558a05f1400
>   Oct 05 11:45:47 free  0xffff9558a05f7000
>   Oct 05 11:46:42 free  0xffff9558a05f2a00
>   Oct 05 11:47:37 free  0xffff9558a05f5a00
>   Oct 05 11:48:32 free  0xffff9558a05f3a00
> 
>   $ root@dc00-pb003-t106-n078:~# date;time for x in $(seq 1 2); do
>   ipmitool mc info; done
> 
>   Wed Oct  5 11:41:12 CST 2022
>   No data available
>   Get Device ID command failed
>   No data available
>   No data available
>   No valid response received
>   Get Device ID command failed: Unspecified error
>   No data available
>   Get Device ID command failed
>   No data available
>   No data available
>   No valid response received
>   No data available
>   Get Device ID command failed
> 
>   real        1m55.052s
>   user        0m0.001s
>   sys        0m0.001s
> 
> After:
> 
> `time` takes 55s, all msgs is returned and free after 55s.
> 
>   $ bpftrace -e 'kretprobe:ipmi_alloc_recv_msg {printf("alloc
>       %p\n",retval);} kprobe:free_recv_msg {printf("free  %p\n",arg0)}'
> 
>   Oct 07 16:30:35 Attaching 2 probes...
>   Oct 07 16:30:45 alloc 0xffff955943aa9800
>   Oct 07 16:31:00 alloc 0xffff955943aacc00
>   Oct 07 16:31:15 alloc 0xffff955943aa8c00
>   Oct 07 16:31:30 alloc 0xffff955943aaf600
>   Oct 07 16:31:40 free  0xffff955943aa9800
>   Oct 07 16:31:40 free  0xffff955943aacc00
>   Oct 07 16:31:40 free  0xffff955943aa8c00
>   Oct 07 16:31:40 free  0xffff955943aaf600
>   Oct 07 16:31:40 alloc 0xffff9558ec8f7e00
>   Oct 07 16:31:40 free  0xffff9558ec8f7e00
>   Oct 07 16:31:40 alloc 0xffff9558ec8f7800
>   Oct 07 16:31:40 free  0xffff9558ec8f7800
>   Oct 07 16:31:40 alloc 0xffff9558ec8f7e00
>   Oct 07 16:31:40 free  0xffff9558ec8f7e00
>   Oct 07 16:31:40 alloc 0xffff9558ec8f7800
>   Oct 07 16:31:40 free  0xffff9558ec8f7800
> 
>   root@dc00-pb003-t106-n078:~# date;time for x in $(seq 1 2); do
>   ipmitool mc info; done
>   Fri Oct  7 16:30:45 CST 2022
>   No data available
>   Get Device ID command failed
>   No data available
>   No data available
>   No valid response received
>   Get Device ID command failed: Unspecified error
>   Get Device ID command failed: 0xd5 Command not supported in present state
>   Get Device ID command failed: Command not supported in present state
> 
>   real        0m55.038s
>   user        0m0.001s
>   sys        0m0.001s
> 
> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_kcs_sm.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
> index efda90dcf5b3..e7f2cd10e5a6 100644
> --- a/drivers/char/ipmi/ipmi_kcs_sm.c
> +++ b/drivers/char/ipmi/ipmi_kcs_sm.c
> @@ -122,10 +122,10 @@ struct si_sm_data {
>  	unsigned long  error0_timeout;
>  };
>  
> -static unsigned int init_kcs_data(struct si_sm_data *kcs,
> -				  struct si_sm_io *io)
> +static unsigned int init_kcs_data_with_state(struct si_sm_data *kcs,
> +				  struct si_sm_io *io, enum kcs_states state)
>  {
> -	kcs->state = KCS_IDLE;
> +	kcs->state = state;
>  	kcs->io = io;
>  	kcs->write_pos = 0;
>  	kcs->write_count = 0;
> @@ -140,6 +140,12 @@ static unsigned int init_kcs_data(struct si_sm_data *kcs,
>  	return 2;
>  }
>  
> +static unsigned int init_kcs_data(struct si_sm_data *kcs,
> +				  struct si_sm_io *io)
> +{
> +	return init_kcs_data_with_state(kcs, io, KCS_IDLE);
> +}
> +
>  static inline unsigned char read_status(struct si_sm_data *kcs)
>  {
>  	return kcs->io->inputb(kcs->io, 1);
> @@ -495,7 +501,7 @@ static enum si_sm_result kcs_event(struct si_sm_data *kcs, long time)
>  	}
>  
>  	if (kcs->state == KCS_HOSED) {
> -		init_kcs_data(kcs, kcs->io);
> +		init_kcs_data_with_state(kcs, kcs->io, KCS_ERROR0);
>  		return SI_SM_HOSED;
>  	}
>  
> -- 
> 2.30.2
> 

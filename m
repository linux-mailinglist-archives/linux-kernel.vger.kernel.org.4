Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD585F8AC8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJILDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJILDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:03:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283F324F12
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 04:03:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y1so5310717qky.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dbdT1fyoxz0ZKUiKRzaIkaLuVSiAy7vPSgmI6IuHfs=;
        b=hAVJxqTJcIA+AGHX33TgPtb8bzhiU68fARX9DrPPM+KUeX86FYvZAX9Ws+retEg541
         t9Qxy3ZcWJvsVwKgAjTiIt8ipMMyGItOm7FOX6lOw19K4bpTAIaJ1PXkkjkK1GAMHjHJ
         fP04lPA5PGSqJtKz6OnbNkM+sFGincMTphkKD3RD0FilYX8ff/7/dSGXOaesbIcWjwmi
         dTwAFZOyX6jd/etxC3UMoGnDru4RewIDfJYOFLHG+jH6mCFD9MWQEKH59xEhT3UCQ5W2
         wiEyPQrkvpRhog5NiaCULO9FdSG3qxBeDNlFDN6ffT+JJqMkVNPuHY3aS26EM6h/DSYG
         n4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9dbdT1fyoxz0ZKUiKRzaIkaLuVSiAy7vPSgmI6IuHfs=;
        b=cTH5tJ0gYq3Ornl9wMA774FUj9N+cOevKvUYII+zF6Tid21G86UK7LJqAo0TosXiTt
         swjxhfjvDhUiQ/Ros9VtMoo/VRF0CqqoIPSoL5CEK5zpvHfb/cJQdPUkrK+MfMLESGFd
         aLQ3RXaV5ItvJiKNd5I4mJ58EIaMja0F+e6Bu4oV67xCNHkNV659/TOkFKTEBCPZTJZH
         CmWi9J3bRojQ3MXJ0qLtUkjm5/Ct7SJzjKF1LUyzPOy4Zz3rHToLo0LC7feM2jzx7g+1
         +/HJ9CNLyQyy7I+CQTY5sLhQkfJs9jl6akUu+u6Q7q4/eSQGWHLoEwCvlVUM6fTyhLnz
         5XFg==
X-Gm-Message-State: ACrzQf3cvt8/QZaG2m+stzu2b/Wp3u2b5UUaUizH+xr5Fom1VehRlS9X
        w1OMbJM3bE2wfVExMtuCbw==
X-Google-Smtp-Source: AMsMyM68qQwKl9WcQ0dRk6zM+DRSBdySH2nkZ5nQtpOz/BmpIq1RIoYhStiNWHLaQxyIX5LzpfFtdQ==
X-Received: by 2002:a05:620a:a9c:b0:6ec:f03:9e5b with SMTP id v28-20020a05620a0a9c00b006ec0f039e5bmr3264831qkg.628.1665313416483;
        Sun, 09 Oct 2022 04:03:36 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id w2-20020a05620a444200b006ce1bfbd603sm7379158qkp.124.2022.10.09.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 04:03:35 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2773:7ac8:f513:30ba])
        by serve.minyard.net (Postfix) with ESMTPSA id BDACE180015;
        Sun,  9 Oct 2022 11:03:33 +0000 (UTC)
Date:   Sun, 9 Oct 2022 06:03:32 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
Subject: Re: [PATCH v2 1/3] ipmi: fix msg stack when IPMI is disconnected
Message-ID: <Y0KqhKYvf+aKLY1+@minyard.net>
Reply-To: minyard@acm.org
References: <20221009091811.40240-1-zhangyuchen.lcr@bytedance.com>
 <20221009091811.40240-2-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009091811.40240-2-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 05:18:09PM +0800, Zhang Yuchen wrote:
> If you continue to access and send messages at a high frequency (once
> every 55s) when the IPMI is disconnected, messages will accumulate in
> intf->[hp_]xmit_msg. If it lasts long enough, it takes up a lot of
> memory.

This is queued for 6.2.  Thanks.  I already had the other two patches
queued.

-corey

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
> In addition, the HOSED state should also count as invalid. So the HOSED
> is removed from the invalid judgment in start_kcs_transaction().
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
>  drivers/char/ipmi/ipmi_kcs_sm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
> index efda90dcf5b3..ecfcb50302f6 100644
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
> @@ -270,7 +276,7 @@ static int start_kcs_transaction(struct si_sm_data *kcs, unsigned char *data,
>  	if (size > MAX_KCS_WRITE_SIZE)
>  		return IPMI_REQ_LEN_EXCEEDED_ERR;
>  
> -	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
> +	if (kcs->state != KCS_IDLE) {
>  		dev_warn(kcs->io->dev, "KCS in invalid state %d\n", kcs->state);
>  		return IPMI_NOT_IN_MY_STATE_ERR;
>  	}
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

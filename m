Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A15F7E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJGTsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGTsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:48:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FB103D98
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:48:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a25so3420198qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psXOmlC6m+ehjo/V3khCZ2CkeIJwNZoruUBgNGYKZoA=;
        b=FcXpaDPa8K/ZuBkT5RCD+dTyteZGncqAv6NgRo3Bxn9DcjsRcykK8eOytBIQUUz4Nt
         vG2hMZIGG6IPoSelDOHuel+RIB2kXN5SWfDNCwEYM6T9umPTbiYnFGyxqYq2BHjc0+0T
         NK9/qdkD12B+Fp8MuYoyzRSqu4mdXvaMMQUVEFRBlXiv9lKKBNU0v3CxZlEbIjk1Pdwy
         3Tyn4ju5O69ly9ZuasYBbEThmsmrj9zf2DeD4xyZ9RFoRdkrboylGftCMsgcsD4ljHYS
         abnVogUgpN0xSdjHXqPUyzhuJjQyDS3B6MFNSxYJjY8HpxzcOiFDBy65aolLFD5YvQUj
         ANIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psXOmlC6m+ehjo/V3khCZ2CkeIJwNZoruUBgNGYKZoA=;
        b=VbcFSc3SdikZrj2Plnhd++vl1h4k438xVixxpC/Qo9BzaMW/91e5NVxV0wrc8fQw8K
         w6ZNEAsNb9ZpyB4pd6He3TYhU6q9tCbUObETxBV3yZq/uSdOyfD+oDAYPMeKvGV6gkNP
         K8HdR0U6DggW05mISa6doieAx5VZ02oD9eVjZq2VWnrbnEgbYyk5iJlviNWLIl4mp6f/
         RTXB3nhUmHXHveTs4NCrftiSHUJgZfLqr3XTeeaJ6vncBLaQGcGwTZloP99CQkiEf2pV
         lQydFge6NrToNE7cEv97BCjWnl1Yzh+9x/Wowv6XR0ikoyHnZvpSAuUoLRsUEAKXN0vX
         ABaA==
X-Gm-Message-State: ACrzQf3D1dWMfWCHFAgH5hNKy1h42mtBhAk3D2pyzy0z04RrItPSX6vM
        X5w9FdBxbzs/OB7asysCMw==
X-Google-Smtp-Source: AMsMyM578hMC2Wh663MdKq3LxH3Ftrc+SMxMPGCDVLvBH1y+gW/8yn8XN0RNwYSG4rzhF/4NlR7I3Q==
X-Received: by 2002:a05:622a:100f:b0:35d:862:7d87 with SMTP id d15-20020a05622a100f00b0035d08627d87mr5624724qte.328.1665172091977;
        Fri, 07 Oct 2022 12:48:11 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id bk5-20020a05620a1a0500b006af3f3b385csm2823097qkb.98.2022.10.07.12.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:48:11 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:fa3f:9b5b:700:c1ba])
        by serve.minyard.net (Postfix) with ESMTPSA id EDD2E1800BD;
        Fri,  7 Oct 2022 19:48:10 +0000 (UTC)
Date:   Fri, 7 Oct 2022 14:48:09 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
Subject: Re: [PATCH 2/3] ipmi: fix long wait in unload when IPMI disconnect
Message-ID: <Y0CCeW1GtiCk0XdQ@minyard.net>
Reply-To: minyard@acm.org
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
 <20221007092617.87597-3-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007092617.87597-3-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 05:26:16PM +0800, Zhang Yuchen wrote:
> When fixing the problem mentioned in PATCH1, we also found
> the following problem:
> 
> If the IPMI is disconnected and in the sending process, the
> uninstallation driver will be stuck for a long time.
> 
> The main problem is that uninstalling the driver waits for curr_msg to
> be sent or HOSED. After stopping tasklet, the only place to trigger the
> timeout mechanism is the circular poll in shutdown_smi.
> 
> The poll function delays 10us and calls smi_event_handler(smi_info,10).
> Smi_event_handler deducts 10us from kcs->ibf_timeout.
> 
> But the poll func is followed by schedule_timeout_uninterruptible(1).
> The time consumed here is not counted in kcs->ibf_timeout.
> 
> So when 10us is deducted from kcs->ibf_timeout, at least 1 jiffies has
> actually passed. The waiting time has increased by more than a
> hundredfold.
> 
> Now instead of calling poll(). call smi_event_handler() directly and
> calculate the elapsed time.

Yes, you are correct.

I've included this for 6.2, and added:

  Cc: stable@vger.kernel.org

I would like it to soak for a bit.

-corey

> 
> For verification, you can directly use ebpf to check the kcs->
> ibf_timeout for each call to kcs_event() when IPMI is disconnected.
> Decrement at normal rate before unloading. The decrement rate becomes
> very slow after unloading.
> 
>   $ bpftrace -e 'kprobe:kcs_event {printf("kcs->ibftimeout : %d\n",
>       *(arg0+584));}'
> 
> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 6e357ad76f2e..abddd7e43a9a 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2153,6 +2153,20 @@ static int __init init_ipmi_si(void)
>  }
>  module_init(init_ipmi_si);
>  
> +static void wait_msg_processed(struct smi_info *smi_info)
> +{
> +	unsigned long jiffies_now;
> +	long time_diff;
> +
> +	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
> +		jiffies_now = jiffies;
> +		time_diff = (((long)jiffies_now - (long)smi_info->last_timeout_jiffies)
> +		     * SI_USEC_PER_JIFFY);
> +		smi_event_handler(smi_info, time_diff);
> +		schedule_timeout_uninterruptible(1);
> +	}
> +}
> +
>  static void shutdown_smi(void *send_info)
>  {
>  	struct smi_info *smi_info = send_info;
> @@ -2187,16 +2201,13 @@ static void shutdown_smi(void *send_info)
>  	 * in the BMC.  Note that timers and CPU interrupts are off,
>  	 * so no need for locks.
>  	 */
> -	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
> -		poll(smi_info);
> -		schedule_timeout_uninterruptible(1);
> -	}
> +	wait_msg_processed(smi_info);
> +
>  	if (smi_info->handlers)
>  		disable_si_irq(smi_info);
> -	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
> -		poll(smi_info);
> -		schedule_timeout_uninterruptible(1);
> -	}
> +
> +	wait_msg_processed(smi_info);
> +
>  	if (smi_info->handlers)
>  		smi_info->handlers->cleanup(smi_info->si_sm);
>  
> -- 
> 2.30.2
> 

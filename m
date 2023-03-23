Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A926C6BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjCWPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCWPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:10:49 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB428215
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:09:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w25so4295066qtc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679584181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tb1BxFDMWIwYyE3mGYT4kIpa6dwDU7IN2Q3Lg+kVDaU=;
        b=Ebzo+rx6WkXL2yPi+RAyOVTZV4s2Ap4yztsDrMTjIwFdNFp5i5x6mRi1t8L+cIIgn2
         DiiXxWk0etnqtk88O/PZtQGZObhI0so0tih4bi7l7bxb/UmRQmXjKXKm6dab7gL+ZHYE
         A3N6KwKH6AXjZTdMC1IGG2GSJ/mvsVCeP1rqVA3R1CYsjmA27fbnyHOOhsUjjQ+h9K2I
         JJABexmxQ5+5njH4T8fe4VpCYPmlAS4w0aaKU0e2EBg5GoOVVMIM5AY9MtMHTvwnKbEr
         uTMNUMhGzJKfFWSmESM4MwNu3bbMOynVKJ2HqvvCAtRE9LGX6sp8k3Wrrbs4JuNllD6F
         hvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679584181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb1BxFDMWIwYyE3mGYT4kIpa6dwDU7IN2Q3Lg+kVDaU=;
        b=ObH5gcE1XGpmjx1puytx9tjHYzj50uJAtCe+BI8sF4mrtjNwNwY+gwa6jpvO760Qol
         a5Svg22uA2gNFk8Z86Pamlg4oSiT1uqhXE9vLDN9FWo3IzxqzDNaRp8aa8XR+l+pdoJj
         SQSDHScc+3mC7TuukAXk5bQsGJGOAsrW+ztTm6jNS/HmQ9gsK/I4qNtVGdOsdpL5jgo0
         vLF2tJSfB1Ykh4f/+/szCX/ssuMSJ9nHFzOMsiDn7U+I6NbX50FoKgCrYUgHSny3/EAB
         dB7KRtbWolEbkJsQiG3l7FxhkRRKe+AeqD+6SzPc6yXQnO2sRBCWYC7Qpnl7s7qbft2H
         SD5Q==
X-Gm-Message-State: AO0yUKVYdEJOiOvowtHW7x9dTsWMCysfgHDhhEDatg1w69J2XjlmrDhT
        A6ujhG2CkiLg2VsaOL3o2/xmfA==
X-Google-Smtp-Source: AK7set+ZusE2fmFm6/Avhfr7T0zw3l5ZYr9SvDabG59zJ1eq1hXswlFQZPpQ4C6OqSJmlfiW/hZNCA==
X-Received: by 2002:a05:622a:1456:b0:3d4:17dc:3fed with SMTP id v22-20020a05622a145600b003d417dc3fedmr11131376qtx.46.1679584181015;
        Thu, 23 Mar 2023 08:09:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85157000000b003b848759ed8sm11834276qtn.47.2023.03.23.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:09:40 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:09:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        surenb@google.com, brauner@kernel.org, chris@chrisdown.name
Subject: Re: [PATCH v2 3/3] sched/psi: allow unprivileged polling of N*2s
 period
Message-ID: <20230323150939.GA737760@cmpxchg.org>
References: <20230323103350.40569-1-cerasuolodomenico@gmail.com>
 <20230323103350.40569-4-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323103350.40569-4-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:33:50AM +0100, Domenico Cerasuolo wrote:
> @@ -151,6 +151,14 @@ struct psi_trigger {
>  
>  	/* Deferred event(s) from previous ratelimit window */
>  	bool pending_event;
> +
> +	/* Used to differentiate destruction action*/
> +	enum psi_aggregators aggregator;
> +};
> +
> +struct trigger_info {
> +	struct list_head triggers;
> +	u32 nr_triggers[NR_PSI_STATES - 1];
>  };
>  
>  struct psi_group {
> @@ -186,8 +194,7 @@ struct psi_group {
>  	struct mutex trigger_lock;
>  
>  	/* Configured polling triggers */
> -	struct list_head triggers;
> -	u32 nr_triggers[NR_PSI_STATES - 1];
> +	struct trigger_info trig_info[NR_PSI_AGGREGATORS];
>  	u32 poll_states;
>  	u64 poll_min_period;

Thanks for trying out this variant, but I think this is grouping up
unrelated things, and that makes the code more difficult to understand
and maintan.

The *only* thing that's shared between those two is the
update_triggers() part. trig_info[PSI_AVGS] doesn't use trigger_lock.
It also doesn't use poll_task, poll_wait, poll_wakeup, poll_scheduled,
poll_min_period, polling_next_update and polling_until. All these
things are specific to the rt polling thread.

The rename in the previous version is a bit churny, but it's justified
in order to keep unrelated things separate / make it obvious which
parts belong together, and who is reading and writing which fields.

So my vote would be on the previous version.

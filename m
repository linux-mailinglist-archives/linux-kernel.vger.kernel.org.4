Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5680770096E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbjELNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240963AbjELNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:49:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC1B12EA9
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:48:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso31157515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683899337; x=1686491337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67+i61jguyp+ViZ9g6BdKZA7MoS8H9z+3IWq9oh/QL4=;
        b=OwLBvsSCAL4IKqngbyeoNx/oUbfIXwpu3OvJhWUAlVCiT6A9dVvRwxpOuPJqfIbT/6
         PrRcyqgLS3++Foa3bBtNBv/pj2lvZa83iigcr+fC8lrKrUMNsAQzjyEy+PMw5OMm/Mhf
         xF0yyGQzDsuSOMbxKBHHyAFAEKrz+LS4Fyu3wgjp0bEG6ZAZ6d6zsvotf2t02PXSwHRW
         FfnDosgrkDUWBd8K4VTIE+ETIO+fdaZ1mayOHMPSoB8rpU8IPhOHJYHvOjr5iMGiPkQF
         8qstkH9p0C0OucOJviu7r6yDgaQ9C5Z5Y9EfGtbIHXO5xfXzDSrQ5BQ6gaa5O1McMXua
         2pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899337; x=1686491337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67+i61jguyp+ViZ9g6BdKZA7MoS8H9z+3IWq9oh/QL4=;
        b=FXTYfKzsRFPOA9O3cQKzGFvM1+Bz7t4dAgmCJKxTXcRgvXGtfirs0ctotJqr15iRhh
         lx1NshdEP6Tu9782ZrD/j5lOSfj6wswuX9w7Dy52VBcbo43uqVJtMlvOp6j4pVxlaq7P
         WqwbnK/FBI1xqV0xPvfMXoG4+t7anaX51JPXu6R3i67tWtxlYn5CUG5BuZ0I6QTqKEEF
         1DUnFmUfnTy/Nv0dTW8bhfhmle/IsYcz7WsijnBU1slNp5ty6iWUQatcZCm7tZZl/ECR
         f7bepQSr4u50abI7Bv/UJdrAyh1nAbXH5UpPB1pwcFusLSrcLdQPtHYVwt8yBUNQ7I8n
         SO+Q==
X-Gm-Message-State: AC+VfDxGlFNjwpNvkeN7vxt/UpiAx4gwLAHzElJZ3NxGo3vYAMBg4zOy
        yjLsZo0FopWVe0ankAaFAHGGxg==
X-Google-Smtp-Source: ACHHUZ587vmfUkFwUYJByiVpeFrZ7RH44sF7IGxP8ERhwrP7uly1qe+BtE/g9t78xP4zh4ZmSj7afw==
X-Received: by 2002:a05:600c:2198:b0:3f4:253b:92a9 with SMTP id e24-20020a05600c219800b003f4253b92a9mr11929533wme.30.1683899337069;
        Fri, 12 May 2023 06:48:57 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003f4272c2d0csm13894413wmi.36.2023.05.12.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:48:56 -0700 (PDT)
Date:   Fri, 12 May 2023 14:48:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 07/10] kgdb: Expose default CPUs roundup fallback
 mechanism
Message-ID: <20230512134853.GA216623@aspen.lan>
References: <20230419225604.21204-1-dianders@chromium.org>
 <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419155341.v8.7.I21d92f8974c8e4001a5982fea6c98da1bed33ef5@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 03:56:01PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
>
> Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
> mechanism to a particular archichecture as a runtime fallback if it
> detects to not support NMI roundup.
>
> Currently such an architecture example is arm64 supporting pseudo NMIs
> feature which is only available on platforms which have support for GICv3
> or later version.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  include/linux/kgdb.h      | 12 ++++++++++++
>  kernel/debug/debug_core.c |  8 +++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 258cdde8d356..87713bd390f3 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -199,6 +199,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
>
>  extern void kgdb_call_nmi_hook(void *ignored);
>
> +/**
> + *	kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
> + *				 round-up CPUs
> + *
> + *	If you're using the default implementation of kgdb_roundup_cpus()
> + *	this function will be called.  And if an arch detects at runtime to
> + *	not support NMI based roundup then it can fallback to default
> + *	mechanism using this API.
> + */
> +
> +extern void kgdb_smp_call_nmi_hook(void);

Concept looks sensible but this is a terrible name for aa command to
round up the CPUs using smp_call... functions. Whilst it is true it that
kgdb_roundup_cpus() does use kgdb_call_nmi_hook() internally that
doesn't mean we should name functions after it. They should be named
after what they are do, not how they do it.

Something more like kgdb_roundup_cpus_with_smp_call() would be a much
better name.


Daniel.

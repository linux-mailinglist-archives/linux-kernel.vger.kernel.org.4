Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43927126C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbjEZMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjEZMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:36:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2543599;
        Fri, 26 May 2023 05:36:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C845F1FD66;
        Fri, 26 May 2023 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685104611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p+/ryCc/jVqNC/x4M8331SF9oIVJd7A5Ujt5a8BQi9E=;
        b=WY+EmfEaF350yIwkRzxDP07Zk1RN8/tkWscLlzLc2PycMGLXJj8n5hELkbGzRMj/D9KtF3
        /3KpgjaMthlb/0GiErFArvBIX8U1yQN4eZgsPgX0weH9CeM2WMH88SeowIWT0yBXf9E4tJ
        0wJdkKI48GEwTErxBH8J6Dm+ghVFuyk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5CBE2D3BD;
        Fri, 26 May 2023 12:36:50 +0000 (UTC)
Date:   Fri, 26 May 2023 14:36:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch
 to detect if perf can use NMIs
Message-ID: <ZHCn4hNxFpY5-9Ki@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-19 10:18:39, Douglas Anderson wrote:
> On arm64, NMI support needs to be detected at runtime. Add a weak
> function to the perf hardlockup detector so that an architecture can
> implement it to detect whether NMIs are available.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> While I won't object to this patch landing, I consider it part of the
> arm64 perf hardlockup effort. I would be OK with the earlier patches
> in the series landing and then not landing ${SUBJECT} patch nor
> anything else later.
> 
> I'll also note that, as an alternative to this, it would be nice if we
> could figure out how to make perf_event_create_kernel_counter() fail
> on arm64 if NMIs aren't available. Maybe we could add a "must_use_nmi"
> element to "struct perf_event_attr"?
> 
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -234,12 +234,22 @@ void __init hardlockup_detector_perf_restart(void)
>  	}
>  }
>  
> +bool __weak __init arch_perf_nmi_is_available(void)
> +{
> +	return true;
> +}
> +
>  /**
>   * watchdog_hardlockup_probe - Probe whether NMI event is available at all
>   */
>  int __init watchdog_hardlockup_probe(void)
>  {
> -	int ret = hardlockup_detector_event_create();
> +	int ret;
> +
> +	if (!arch_perf_nmi_is_available())
> +		return -ENODEV;

My understanding is that this would block the perf hardlockup detector
at runtime. Does it work with the "nmi_watchdog" sysctl. I see
that it is made read-only when it is not enabled at build time,
see NMI_WATCHDOG_SYSCTL_PERM.

> +
> +	ret = hardlockup_detector_event_create();
>  
>  	if (ret) {
>  		pr_info("Perf NMI watchdog permanently disabled\n");

Best Regards,
Petr

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD885B4788
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIJQmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 12:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIJQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 12:42:14 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0F4B498;
        Sat, 10 Sep 2022 09:42:12 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id d189so6891763ybh.12;
        Sat, 10 Sep 2022 09:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZqI4OlIgIZ5cpLwqoHNWIUQovElvcVSI1HcDoSTyFws=;
        b=tCEaXnKpoEcoLr3dCJuubbhGHFWWXSGBJcXK29bit44jiew1VWciJ1Cv4rhVn+7Uod
         uEhYZGsFINbwUOIhpMiT5TLdk9RfOq4SYrx/BPDy/8t0jEfg4iIwS8chuRvIJFs7TvQ6
         u8bm6T1Ihmgc1xry9BveNpjEEUP9xojaBb9Vo2l6SQd5kiPcg/971Q3uU35VrduY/tNF
         zGgLBpCE3Wv+wXwNWiBvMaeJ134mgPIu4fEu4XHExCxZHcpiZ0c6Qz2a2Hr6WyfKD7ys
         XkcNhLVwPd8O3jVQfdHIxQ5PBY+Dgm4aof5pjGpwsnqUJ9m2u6WHKkik3A18eABZ/GGo
         m81g==
X-Gm-Message-State: ACgBeo1GrTXii6usAvAPPhKZ9sJmiB0B7Ak+aQHPBbnEpfmY/AVNwmsW
        kDZ60p6Fn/6Opsqb/ym2czWYZ+0w5mDdLhSnxKfcGK8x
X-Google-Smtp-Source: AA6agR5mPjKgxAJoJY102qMtCRe6yj35q87pOhCrRiw5k6yY4LIjE+3I/SsZkJkH+MhAD6huEepJXLvCXnRH5BKeb4s=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr16676332ybm.137.1662828132121; Sat, 10
 Sep 2022 09:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <003901d8c22d$02447f70$06cd7e50$@telus.net> <003c01d8c22f$4a8e2270$dfaa6750$@telus.net>
In-Reply-To: <003c01d8c22f$4a8e2270$dfaa6750$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:42:01 +0200
Message-ID: <CAJZ5v0hgw+1AEm6kZhMGgPBzPXr_fWZV_ViJScF4GDejrE2rYw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Add Tigerlake support in no-HWP mode
To:     Doug Smythies <dsmythies@telus.net>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "M. Cagri Ari" <cagriari@pm.me>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 10:29 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Users may disable HWP in firmware, in which case intel_pstate wouldn't load
> unless the CPU model is explicitly supported.
>
> Add TIGERLAKE to the list of CPUs that can register intel_pstate while not
> advertising the HWP capability. Without this change, an TIGERLAKE in no-HWP
> mode could only use the acpi_cpufreq frequency scaling driver.
>
> See also commits:
> d8de7a44e11f: cpufreq: intel_pstate: Add Skylake servers support
> fbdc21e9b038: cpufreq: intel_pstate: Add Icelake servers support in no-HWP mode
> 706c5328851d: cpufreq: intel_pstate: Add Cometlake support in no-HWP mode
>
> Reported by: M. Cargi Ari <cagriari@pm.me>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 57cdb3679885..fc3ebeb0bbe5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2416,6 +2416,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         X86_MATCH(SKYLAKE_X,            core_funcs),
>         X86_MATCH(COMETLAKE,            core_funcs),
>         X86_MATCH(ICELAKE_X,            core_funcs),
> +       X86_MATCH(TIGERLAKE,            core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --

Applied as 6.1 material, thanks!

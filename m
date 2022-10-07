Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65E5F72BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiJGC1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJGC06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:26:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9794CAE77
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:26:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c24so3364309plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 19:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPHVJY2ueAqpNgrqrCrpctoZrug85xo5yVkYEHuY5DY=;
        b=cQGxp4bwSHS43zhiI265SPL7AYWSJgZGyOzeR3n+hnWt/hsqup8zu1EhS/c4QBwMOg
         mP1ALztZLHCEgFZIXcg0SWho9i0cFvcFVvmW2qpjt35SZrDfgheW8JdCpHRZhvbbvOCP
         ZzlqvllxCP80G6nkqQOgOzQjVm/Amcx2DrzAxCcjf7rn7xZQ6xyOyFb+r6t3Ok404J7a
         tMtY0f0/efymk+Wfcpga4mqTTCLKeDbNuMreR8rBOUAlOnL57KPzHeZEzfQQlTxh2yMA
         c6/m/ROfyXMyjHT5xnBG0dUs0N+zSTme5icAIA4UhGD7AoHsrZDfUqeZMfYMw7z2Ulcr
         wwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPHVJY2ueAqpNgrqrCrpctoZrug85xo5yVkYEHuY5DY=;
        b=KxVOSa4WkVBAkpDb0WD61UxEIPSjPtDd6fjtGIgEv2xvA/++jiJbCi/CX1Urp7oPKw
         fptj5NjpBKZhMrAHqVxkEgu1bI188FLYss76DHMYnQSVj+LN/Ig5pBKGEcU1FGwemC/X
         clKrX3wpSNWZPgOIcNNWU7oazKBrDgA93BgBfqGWV5R+J0HMKM+eYe9V9RvPv9i4m/fX
         YJNMm5EsWnDe3PLuIPIXVKyV01tYSoTXIFg+rexzANXNL50YlSwf1AbFig3pFYH8Fw7U
         Sq7jqnAQ4j/YFabKT/w3Gw63Bi0ajBOWQopSZqPRl31j2It+Yn/dANLb7lnYPmrRr3WQ
         beGw==
X-Gm-Message-State: ACrzQf1nzHPZb72pyM+8llrAhe3j7WuJti5JVp8t8gyt/oM41+6kmAiO
        ISlLqQvuc0eX6GRGXeJeO1fV6w==
X-Google-Smtp-Source: AMsMyM7B/FaVDCpT0IV4y3wihdJtWVWwBQ1T1WMOxcCTvud3vye7SZz0y4Cr1yFvOA83H6BoKpEIyw==
X-Received: by 2002:a17:902:b591:b0:178:bb0c:78af with SMTP id a17-20020a170902b59100b00178bb0c78afmr2794721pls.55.1665109616103;
        Thu, 06 Oct 2022 19:26:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b0017f64ab80e5sm306435plx.179.2022.10.06.19.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 19:26:54 -0700 (PDT)
Date:   Thu, 06 Oct 2022 19:26:54 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Oct 2022 19:26:38 PDT (-0700)
Subject:     Re: [PATCH] drivers/perf: riscv_pmu_sbi: add perf_user_access sysctl
In-Reply-To: <20220826151556.1708879-1-heiko@sntech.de>
CC:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-fa9049b7-e36b-4202-bded-11f1ba2ae124@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 08:15:56 PDT (-0700), heiko@sntech.de wrote:
> Add a sysctl similar to the one on arm64 to enable/disable
> access to counter CSRs from u-mode on RISC-V.
>
> The default is of course set to disabled keeping the current
> state of access - to only the TIME CSR.

Sorry for being slow on this one, but IMO this is the wrong way to go: 
this was pretty clearly described by the PDFs as a non-optional 
instruction when we committed to uABI stability, and there's userspace 
binaries that use these instructions.  I know the ISA folks changed 
their minds about these being in the base, but that doesn't mean we can 
break userspace.

If you're worried about a side channel from the high resolution timers 
that makes sense, but we can sort that out without breaking userspace: 
we just trap the counter accesses and handle them in the kernel with 
less precision.  We'll need to do that in the long run anyway, as 
there's no way to make sure these are implement.  That all applies to 
the time counter as well.

I'd also argue this should be a prctl(), as that'll allow users to flip 
it on/off for specific processes.  We can make it sticky to deal with 
the side channels, but at least starting with a per-process flag will 
let us avoid breaking compatibility for everyone.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |  6 +--
>  drivers/perf/riscv_pmu_sbi.c                | 43 ++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ee6572b1edad..efd4bc385e7a 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -894,15 +894,15 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
>  The default value is 8.
>
>
> -perf_user_access (arm64 only)
> -=================================
> +perf_user_access (arm64 and riscv only)
> +=======================================
>
>  Controls user space access for reading perf event counters. When set to 1,
>  user space can read performance monitor counter registers directly.
>
>  The default value is 0 (access disabled).
>
> -See Documentation/arm64/perf.rst for more information.
> +See Documentation/arm64/perf.rst for more information on arm64
>
>
>  pid_max
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 6f6681bbfd36..7aab8d673357 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -41,6 +41,8 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>  	NULL,
>  };
>
> +static int sysctl_perf_user_access __read_mostly;
> +
>  /*
>   * RISC-V doesn't have hetergenous harts yet. This need to be part of
>   * per_cpu in case of harts with different pmu counters
> @@ -640,13 +642,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	return IRQ_HANDLED;
>  }
>
> +/*
> + * Depending on the perf_user_access setting, enable the access
> + * from usermode either for all counters or for TIME csr only.
> + */
> +static void riscv_pmu_update_user_access(void *info)
> +{
> +	csr_write(CSR_SCOUNTEREN, sysctl_perf_user_access ? GENMASK(31, 0) :
> +							    0x2);
> +}
> +
>  static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
>  	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>
> -	/* Enable the access for TIME csr only from the user mode now */
> -	csr_write(CSR_SCOUNTEREN, 0x2);
> +	riscv_pmu_update_user_access(NULL);
>
>  	/* Stop all the counters so that they can be enabled from perf */
>  	pmu_sbi_stop_all(pmu);
> @@ -785,6 +796,32 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>  	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>  }
>
> +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
> +			int write, void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	if (ret || !write)
> +		return ret;
> +
> +	on_each_cpu(riscv_pmu_update_user_access, NULL, 1);
> +
> +	return 0;
> +}
> +
> +static struct ctl_table sbi_pmu_sysctl_table[] = {
> +	{
> +		.procname       = "perf_user_access",
> +		.data		= &sysctl_perf_user_access,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= riscv_pmu_proc_user_access_handler,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>  {
>  	struct riscv_pmu *pmu = NULL;
> @@ -834,6 +871,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_unregister;
>
> +	register_sysctl("kernel", sbi_pmu_sysctl_table);
> +
>  	return 0;
>
>  out_unregister:

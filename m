Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EAD6F1795
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbjD1MU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbjD1MUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:20:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F27A5584
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:20:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so16638762a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682684441; x=1685276441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnnxJC/OUshYooHsz1QQh8YEyfrU6zYiR5EaHZYQGjo=;
        b=hcKmT1rZfUbs6SLCw+L707tSSylwm0tH/5kdN29nzQaSEwAi5o2Ivg8aJLxY8G8mco
         00BnIge4SNFj0DkPpKyYGvCIkNpxDOJvU4UKiw8O0AwqRODRTumCOc6CH6dnZ9Th/63y
         CzpFQ8l3MXQUef72IZ6PPRD3sO0PcWDKWhmbHRLix2LGN5ywMYur+Asjg6HkojUMbknk
         6SjglWxiU2MlXFom7TGCLZY9H87Ikzc1/+jqGbQmTtQTYmmCAXDMUp8LBWDWDCmmlVsI
         7T+QqclJhKv4orvLKf9MiGIHMuh+eRkQ6IFkiwQc6uzy8lgw12cAo/VaE/x8sDq7suLK
         Tntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684441; x=1685276441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnnxJC/OUshYooHsz1QQh8YEyfrU6zYiR5EaHZYQGjo=;
        b=Po4ALwYIf7R8diKzSL7YQGmmZ1OaVSUJS252EjNcpdDXdUVJvmqRJk/TTtYd0ELw7N
         mzCzJplpJsVxqAy0owYAoFP8ahzn4Xt2D7JA6RpGPTpISPqb85zYFvup9mB6L6T/t9No
         IT5A17Ja6e4PrXKdd8CKCkWN9YUvC9Uen3pypAKbtxTjAQXe92p1IHyIrfZM7q7vEBhQ
         4KP96K9QT7xtnNhf8CIwCN2Y9e99nSDACU4/9xQHk5QfWQbaEoR0o2RWiS+CWP8xMjhN
         MUHY7hvGcUWyp4EbHrdVU5CoChYZezCry/ThQkXVdiN+NA25+JZwWWBNRLJUvAzpszS2
         cjnw==
X-Gm-Message-State: AC+VfDz8g1ZYMrk7l+9VAbDJoE/x5aRevRK4O8hEIM79zZwGemvb0V+g
        ccdvEJVMqiLcCqRqeVTnfO0bIRuVdEiE47ZTpwg=
X-Google-Smtp-Source: ACHHUZ67lj31zawW4SweLmq4ntxfryIPZgNl0tp/ZKZj7OlnH5rbmtwB/XFRUH3BF83fWHs9dYDy5Q==
X-Received: by 2002:a17:906:728e:b0:94e:6eb3:abc4 with SMTP id b14-20020a170906728e00b0094e6eb3abc4mr9678802ejl.4.1682684440749;
        Fri, 28 Apr 2023 05:20:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0095ec8dfc439sm4358565ejb.166.2023.04.28.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:20:40 -0700 (PDT)
Date:   Fri, 28 Apr 2023 14:20:39 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Cc:     linux@yadro.com, Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf: RISC-V: Limit the number of counters returned
 from SBI.
Message-ID: <nz7dxazar52et54ia6kgl3onsuevq62pm4lffdfcnsrxgormga@a62zyukdxyj6>
References: <20230428110256.711352-1-v.v.mitrofanov@yadro.com>
 <20230428110256.711352-2-v.v.mitrofanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428110256.711352-2-v.v.mitrofanov@yadro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:02:56AM +0000, Viacheslav Mitrofanov wrote:
> Perf gets the number of supported counters from SBI. If it happens that
> the number of returned counters more than RISCV_MAX_COUNTERS the code
> trusts it. It does not lead to an immediate problem but can potentially
> lead to it. Prevent getting more than RISCV_MAX_COUNTERS from SBI.

I recall suggesting we do this during the KVM PMU review, but I guess we
forgot.

> 
> Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 70cb50fd41c2..0183bf911bfb 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -867,6 +867,11 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  		pr_err("SBI PMU extension doesn't provide any counters\n");
>  		goto out_free;
>  	}

Need blank line here

> +	/* It is possible to get from SBI more than max number of counters */
> +	if (num_counters > RISCV_MAX_COUNTERS) {
> +		pr_warn("SBI returned more than maximum number of counters\n");
                                               ^ the

This should be a pr_info.


> +		num_counters = RISCV_MAX_COUNTERS;
> +	}

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

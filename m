Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0469D16B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjBTQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjBTQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:37:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792320070
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:37:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f13so6393538edz.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JAySITZlmEgUkttA/h6vqlRMnlxL91ZjoXWKBJM6nM=;
        b=LKl3QhZg9GAGzzVxe6CvgIpZKXYAQ9dPVtEwmVtX4ukhthYLVCpyyU6DNG1kHTRsPz
         kniAQG8p82fQCtWzCdAUZ+N371kNtEipPHBBE04gt9LQST9I8N9gJ/5q6YrZRcabF8we
         4Dq8Rx+a8ewT75TAMxXzcDZwxFvwn7i3NNfGHVfuahq7DqauUTbw3/vA5TiKOhS6Ibbr
         aiy+jdDk5Jdlv3pNTdBKvjKIK2o5rj5BsTTS1xxwt47GsjVvb8C/Omb/BC6NqiyQWLsd
         LixLGBK2fPBuUkU7kWaFI6ICl0aDykcsrev13d4TWY26Q/ehkn9dZ58RMlww/cnP02dp
         +r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JAySITZlmEgUkttA/h6vqlRMnlxL91ZjoXWKBJM6nM=;
        b=df5e2zDy6RmbalCBebqoW+p0zbLoywydZOd/ZhxVAFpFz3kmAPMzkIKz9fDuyGUJda
         UhSCUEgCy67sesGWN+KXabjT4mzFL1UOcI3563yniV6Xqj4Wr0034QcyIGnhrd+UrjSB
         mUgNNJM4Kpb8TZosWVGbSeadSZidGB+kygsBXg2bEBgZbwro1IXIxOwsmNm9exxDEnBB
         zK62Dx2GThcmjOKp3lcgTzD8pMESNP0C0ZEv0lk21TM4/b5HUsN9VmnOBbkfWf+KQWGH
         CMWEuvmUM2rTj5rk7ZKYIob4DLORTVJh1TUNV5umti5xmw1WVRfrjs7s1IO/9y9MKtjf
         BlVA==
X-Gm-Message-State: AO0yUKWg8BqR5s0rsaTdMnag81nRTxhA9BTDz4dnqmQnlfiuU9VWVkh5
        h1SYVEc036buewKX2IQFO0lELg==
X-Google-Smtp-Source: AK7set82YiGvX/cWolc8nVufXVUBsto1fiyPC9tIHH8kYkvGmOF/V3SGDTBeP7VxsOXKKXyTQ7gKNA==
X-Received: by 2002:a17:906:308a:b0:8b1:81eb:159e with SMTP id 10-20020a170906308a00b008b181eb159emr11651891ejv.7.1676911027113;
        Mon, 20 Feb 2023 08:37:07 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id kg19-20020a17090776f300b008be0b7242d5sm3450061ejc.90.2023.02.20.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:37:06 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:37:05 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 09/21] RISC-V: smpboot: Create wrapper smp_setup()
Message-ID: <20230220163705.kodx5r7codd4ri2c@orel>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-10-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216182043.1946553-10-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:50:31PM +0530, Sunil V L wrote:
> smp_setup() currently assumes DT-based platforms. To enable ACPI,
> first make this a wrapper function and move existing code to
> a separate DT-specific function.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/smpboot.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 00b53913d4c6..26214ddefaa4 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -70,7 +70,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	}
>  }
>  
> -void __init setup_smp(void)
> +static void __init of_parse_and_init_cpus(void)
>  {
>  	struct device_node *dn;
>  	unsigned long hart;
> @@ -116,6 +116,11 @@ void __init setup_smp(void)
>  	}
>  }
>  
> +void __init setup_smp(void)
> +{
> +	of_parse_and_init_cpus();
> +}
> +
>  static int start_secondary_cpu(int cpu, struct task_struct *tidle)
>  {
>  	if (cpu_ops[cpu]->cpu_start)
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF9D5FC1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJLIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:24:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922AE10FD2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:24:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id l22so23439011edj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7lFb5VGMrKqGiWjpUWI9EzMjINze79jE20NYZw+7BU=;
        b=TctAz9U0qNsHioaodZojAQZGpjFhs7VtnS40MlUDZia2UD8j8P3/HITlY6h0GU2PF1
         zD0AG/q5mkc9TbXnI5A1y0cWwcySzp9vRfy17G5kNjkT4vzFPe25TRAjyoaaAZESMNgk
         +RjUYGe7FUO8Y+9AIEMXsYrm9DAhRD0sJyzuPPsYkh9H6LSC6FFbLFAaxUuyNYYEKAFl
         8PmGbiBhxlT91BcI7rlG5YrugMGCayRMKEocR0WFLpei9+x3iSkkxNkeFQcz6O4XuQyt
         Upe706L0oD/6qpdjAYsjz5cIYRBaK1t+PgyyNClo5lAmilTgWPiSwuLhn1RVdygK6lUO
         cYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7lFb5VGMrKqGiWjpUWI9EzMjINze79jE20NYZw+7BU=;
        b=PFEp5tUL1fnE+4NkYnyUs7h2ItkTMn58yXt2N184I/qJHV5Tsfe3DiFDJ8A3kX1Ku4
         FEhWAGc41lxiVKQNwO+sz0qcIhgXaHAcx0hMYJmAD34xYvnX5WyZIU2e1RYTqLP+m4NC
         GkrM202MFUALO+VUZZ4efpEIcwA7sZbHCKD9A4g1yIHaj8ugZrnLLsLvz6a+p+MxWtMp
         pmTxz+AzIv3jvVTowOIxepTIB+/3NKpctges5okvxwv3ArmkWHAzuvmSju010OMfJjBS
         lOBZ4QSBTsz2FWfpiuviearpSLDAuXS7Dj+OkajVTGGHlOr8JkPMy9u0M8ssRXYZhmbu
         19Wg==
X-Gm-Message-State: ACrzQf0yKscNp5Wr7OCclc/8CQIryiPkEVz0/CJNsH+MItTkiYv7iveg
        YDHq0SF05SuUYPxsV8TW7V7mew==
X-Google-Smtp-Source: AMsMyM4jbe+TfSx7fdWP2zz12rYd/aqcNJgUyHFTLLdyLDStYwLjjEel6kVanW16OU+uXqnqwFPaMw==
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr26207769edb.102.1665563064130;
        Wed, 12 Oct 2022 01:24:24 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id l25-20020a50d6d9000000b0045723aa48ccsm10618900edj.93.2022.10.12.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 01:24:23 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:24:22 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221012082422.uavybxdfmv4xkhxi@kamzik>
References: <20221012081905.1800640-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012081905.1800640-1-ajones@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:19:05AM +0200, Andrew Jones wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
> 
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }
> 
> which will issue the warning when reading /proc/cpuinfo. Ensure no
> warning is generated by validating the cpu index before calling
> cpumask_next().
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---

Forgot the changelog...

v2:
  - Added all the information I should have in the first place to the
    commit message [Boris]
  - Changed style of fix [Boris]

>  arch/x86/kernel/cpu/proc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..94ac02c8dd6f 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> +	if (*pos >= nr_cpu_ids)
> +		return NULL;
> +
>  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
>  	if ((*pos) < nr_cpu_ids)
>  		return &cpu_data(*pos);
> -- 
> 2.37.3
> 

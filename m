Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10C724BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbjFFSrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjFFSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:47:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA01BDC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:46:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565a66a5d84so92700827b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686077200; x=1688669200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vjpQ/gPzw4IAJmjKfdYy1HzHlAdIXHWfCI3TgMZlwU=;
        b=ypxK+3K3Wqh9SEziB1wlVd3OXIxJkoZxUU29TjkP4NQfcmqUjYpzEI0ZCaGkW9laDX
         nlSauA7rwSDQTkXavXsmp2sFJQwjlS7Z7N8rlBs/HGdQAO+X6saXMRiRUwSZ2QsSo8Oc
         ECKz0m4J/WylJgGkqyV5saqIXdWNicH0E5miuOcb2beDdzJkL1jGRsJny8+chyiyklgQ
         m+6gNf7c7+JO4bl04XWNNlAxUEa93DKd5AkQ/W0WvN3qWS3eOJLtq97gP2573eH0BSnR
         WYCeeAcpO+8GjAkkxNN3FK7QMMh35AWVvnzwEGVp6iTvwWiflZuLsF3V/vEcbQwBnBIi
         Eknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077200; x=1688669200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vjpQ/gPzw4IAJmjKfdYy1HzHlAdIXHWfCI3TgMZlwU=;
        b=ChVLUejd1QIQcou8ab3sUBQXiRBYewl3vx+Go4a7IjM+kIp6ubc2LgAkdtEjlQtgOH
         icIW8uS+vDmsymKQw5U4mzgd9/ME6kHAFaov7GGz2WB/JDVEg/W+TRjwt0TwiERs9gaD
         fIaTqiaDp3ATsBB6FJgAZG5wwQWR44wO5OVN5gUlKtLs+Na13D5OPtcX8/OQyC5c/aDW
         yLlYY+nbHTnoy3EwLSdLpYjNuLgV4F6sb4pzIfCkfM6B+BWC6qmuqv3Vpw+TQ62+yiw7
         DluXJ/H+AUSxst5fhgSgklUimcfCpuj9GF72MWd8HKWXpSAf45TY5nMJXtO1Gr08Xa1V
         JLbw==
X-Gm-Message-State: AC+VfDxmHXIxdxZwupEqOHWARAvC7jIj+znsS4YIeMftRsm32YRetfFA
        zcFWdv1S3Pac51Hrw0a71Xk/3z+hUfk=
X-Google-Smtp-Source: ACHHUZ7D4X5yRQTBWsHRPpLKxwHpepmjLlEx5mAwqv7Ydx6p+XrFcpF8l2408/KWu4GJ21U8881K0JtJPa4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b619:0:b0:565:b20e:5b28 with SMTP id
 u25-20020a81b619000000b00565b20e5b28mr1565461ywh.8.1686077200223; Tue, 06 Jun
 2023 11:46:40 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:46:38 -0700
In-Reply-To: <20230522161249.800829-3-aleksandr.mikhalitsyn@canonical.com>
Mime-Version: 1.0
References: <20230522161249.800829-1-aleksandr.mikhalitsyn@canonical.com> <20230522161249.800829-3-aleksandr.mikhalitsyn@canonical.com>
Message-ID: <ZH9/Drgo+sDYTGIG@google.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: enhance info printk's in SEV init
From:   Sean Christopherson <seanjc@google.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     pbonzini@redhat.com,
        "=?iso-8859-1?Q?St=E9phane?= Graber" <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023, Alexander Mikhalitsyn wrote:
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index cc832a8d1bca..fff63d1f2a34 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2224,7 +2224,6 @@ void __init sev_hardware_setup(void)
>  		goto out;
>  	}
>  
> -	pr_info("SEV supported: %u ASIDs\n", sev_asid_count);
>  	sev_supported = true;
>  
>  	/* SEV-ES support requested? */
> @@ -2252,10 +2251,16 @@ void __init sev_hardware_setup(void)
>  	if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
>  		goto out;
>  
> -	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
>  	sev_es_supported = true;
>  
>  out:
> +	if (boot_cpu_has(X86_FEATURE_SEV))
> +		pr_info("SEV %s (ASIDs %u - %u)\n",
> +			sev_supported ? "enabled" : "disabled", min_sev_asid, max_sev_asid);
> +	if (boot_cpu_has(X86_FEATURE_SEV_ES))
> +		pr_info("SEV-ES %s (ASIDs %u - %u)\n",
> +			sev_es_supported ? "enabled" : "disabled", 1, min_sev_asid - 1);

The min should print '0' if min_sev_asid<=1, otherwise the output will be

	SEV-ES disabled (ASIDs 1 - 0)

which is confusing.  That would also align with what gets printed out for SEV
when it's not supported at all (min==max=0).

No need for v3, I'll fixup when applying.

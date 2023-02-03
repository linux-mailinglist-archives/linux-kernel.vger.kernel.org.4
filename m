Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7F68A16C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBCSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjBCSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:17:10 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFA279B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:17:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u9so1809552plf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 10:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2JXp3707ROK/aH3TnNjGXJEpujY2l7c5/rrxx85BRg=;
        b=sU595YSl2eFiBxpCpCVoQwM2jfLYhOe/R8YXDn/k8xPajB4XsdQFFtyVsyXm2A8bVZ
         BdLX4xcGbVcyTFw3FNaxThLPD/PrqlXUMKpJ7h32x3mKBAjW9gzV0iIUChz3Pvj+TP3e
         MeYW97CKVdVWcKeZdzT46HHqnk3wMyNtPr/4+vonT8hJvfmFWbsET/RCIoWW+4QZYaKK
         Y8Tg6YAuwy4OhYT9bz1zU5cWZTpEWQCaLGzqoFaAqRZLkql+1ExYP2XXHGFBru2tVY1S
         djFxYj+DklKpK8ijlZCJ4a22FjUWQ5Inv+bSpJPwiKLCKMG32WIZT2BAANJXMox6Luvx
         l9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2JXp3707ROK/aH3TnNjGXJEpujY2l7c5/rrxx85BRg=;
        b=nTSQpwjGKpBjSaz56K3C9Kq6K+3phyQOR15OGgJyPnzDCLVofeodlSyZDgqko24zxn
         PZYdtBXdXDfpE5V98o9N6cdDEy9cs786ch3BNfBUgs2510wUOf2YYUMU9DjsozlGsuLF
         +kAi5Aa1qmfuH3EVvblEkj08Xgn2MsOa+1CaRznPMTefnICLCiWka8Qjqg8tye8+K0YB
         D6ihYGZrTs5X8MYBHyxeyzQIJfufMB6ThAoPyhDT3Jf96QT2o1B78rnfsVPoUNG7S3Wn
         S0D5+EbKFidVcmKGttJ4GtsTVlIMkpveDwKL4UUuUMiap0A4vOrSYsl5CIC87Ck9Axea
         laXg==
X-Gm-Message-State: AO0yUKXXpes7EIah74alLSlyuYN6EHAn5vO97UcD0iKrvHxt+ErtNZTX
        aJB6REGoa5HnVTjhTFGKb5QfvPQa8/L9iE2/h6M=
X-Google-Smtp-Source: AK7set+apdBfly7qo8sySTAPEnbWQcdm8AsxwXbBOWxeOkrgZ36lbpZK1kkPbake9U7Md3iK2CbCDw==
X-Received: by 2002:a17:903:1392:b0:198:af4f:de05 with SMTP id jx18-20020a170903139200b00198af4fde05mr277679plb.5.1675448228890;
        Fri, 03 Feb 2023 10:17:08 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k9-20020aa79d09000000b005813f365afcsm2083721pfp.189.2023.02.03.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 10:17:08 -0800 (PST)
Date:   Fri, 3 Feb 2023 18:17:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com
Subject: Re: [PATCH v6 06/11] x86/smpboot: Support parallel startup of
 secondary CPUs
Message-ID: <Y91PoIfc2jdRv0WG@google.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
 <20230202215625.3248306-7-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202215625.3248306-7-usama.arif@bytedance.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023, Usama Arif wrote:
> @@ -1515,6 +1530,17 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>  
>  	speculative_store_bypass_ht_init();
>  
> +	/*
> +	 * We can do 64-bit AP bringup in parallel if the CPU reports its
> +	 * APIC ID in CPUID leaf 0x0B. Otherwise it's too hard. And not
> +	 * for SEV-ES guests because they can't use CPUID that early.
> +	 * Also, some AMD CPUs crash when doing parallel cpu bringup, disable
> +	 * it for all AMD CPUs to be on the safe side.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_32) || boot_cpu_data.cpuid_level < 0x0B ||
> +	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))

Obviously not your fault, but CC_ATTR_GUEST_STATE_ENCRYPT is a terrible name.
TDX guest state is also encrypted, but TDX doesn't return true CC_ATTR_GUEST_STATE_ENCRYPT.
I.e. this looks wrong, but is correct, because CC_ATTR_GUEST_STATE_ENCRYPT really
just means "SEV-ES guest".

> +		do_parallel_bringup = false;
> +
>  	snp_set_wakeup_secondary_cpu();
>  }

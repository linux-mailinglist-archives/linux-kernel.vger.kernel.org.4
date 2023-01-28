Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8367F368
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjA1A64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjA1A6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:58:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FBF83244
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:58:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id d10so4257513pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adhZONprSgHvq/iWA6LGej7RxHGp4Pgkk8Hdc5mddh4=;
        b=HbkaEy2j0neTxWmsd5I1T9OqO+hxH4sJ/NhB6WrIcjSk9UOt7wH96r9ATzPc4F2AGL
         vqItE1UJL0Vf+d1ssv2MHPXsJmkYyDx6bvz6vwRR4LFAahY5uMuQ2LlDGvjkaBcxYwIr
         kkl/bryaCLq5rjub7PvkM6xgOcwdcWYt9CfPHtFT108k3/DVRQGeP8VHb9UB+z1c732n
         uA5q7TMAuh48IJn2oqZQBcPvDwrXGt9e0952lBhPysdWoUvzPgs78iTvSDoPp7XwMnbE
         W7g+qvHqG5w7Nr3r413iq5RI0IykMJG9OAfnSo0lNi2VH5jUn9yOQloKEgOM2Z6nK397
         EbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adhZONprSgHvq/iWA6LGej7RxHGp4Pgkk8Hdc5mddh4=;
        b=FMIjBwvG3sO0dFev77kBH8qrlzK1nMQS1apS4Ab8S4qDXBccoNdX1kbbRzydQHEUzK
         Qan00JSDdBRPEpXSj1Z4WUXYY006Y7dNNZv4MCYvsGCz27nCf3K8fA/Aqy8SA/yBKm7r
         dGrSuGBqCzgA3cuPUBfPw/w6zqYuGe97V4Wla7pK5I+LDKiwmpKKFsn09Er5jJTkStX0
         gplk7ouLDN0dXO917YPx80/GYh7dC969z3+aAd4c4fW2cM21xY43ElPa2Kl2cBhy8EDB
         Uo2rAEql1/tyhsGmN4/UKVdnH4+HrRfeDEm3Ci0g1cpEO5KnG/xNV7nQgAnlrI787MhO
         7K6g==
X-Gm-Message-State: AO0yUKVKpa8HL5mq76xOUfoATFZsVK7ak8Ml9qgDgLKpJkeUqN85mygO
        Pcn5ojgtp8hH59Tp9p9y9Asr4Q==
X-Google-Smtp-Source: AK7set9hALKiPYyUkWqTdKUuqjI9VmdPkXyDEJ9KD4b3L2MWGx0VJjqROD8NLsBzh6c1cvhtX4d4nA==
X-Received: by 2002:aa7:858a:0:b0:576:9252:d06 with SMTP id w10-20020aa7858a000000b0057692520d06mr217105pfn.0.1674867532333;
        Fri, 27 Jan 2023 16:58:52 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c62-20020a621c41000000b00580cc63dce8sm3194268pfc.77.2023.01.27.16.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:58:51 -0800 (PST)
Date:   Sat, 28 Jan 2023 00:58:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 05/11] KVM: x86: emulator: stop using raw host flags
Message-ID: <Y9RzSJuGmIQf1kxA@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
 <20221129193717.513824-6-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193717.513824-6-mlevitsk@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022, Maxim Levitsky wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f18f579ebde81c..85d2a12c214dda 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8138,9 +8138,14 @@ static void emulator_set_nmi_mask(struct x86_emulate_ctxt *ctxt, bool masked)
>  	static_call(kvm_x86_set_nmi_mask)(emul_to_vcpu(ctxt), masked);
>  }
>  
> -static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
> +static bool emulator_in_smm(struct x86_emulate_ctxt *ctxt)
>  {
> -	return emul_to_vcpu(ctxt)->arch.hflags;
> +	return emul_to_vcpu(ctxt)->arch.hflags & HF_SMM_MASK;

This needs to be is_smm() as HF_SMM_MASK is undefined if CONFIG_KVM_SMM=n.

> +}
> +
> +static bool emulator_in_guest_mode(struct x86_emulate_ctxt *ctxt)
> +{
> +	return emul_to_vcpu(ctxt)->arch.hflags & HF_GUEST_MASK;

And just use is_guest_mode() here.

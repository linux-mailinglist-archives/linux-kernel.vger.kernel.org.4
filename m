Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA77473E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGDOSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjGDOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:18:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B938E1B2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:18:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbca6a9ae4so270965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688480294; x=1691072294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eS9MwUiGBcqynGVE0FeA/+dAT/8VCpi0aohdmN5v6Zg=;
        b=sCUFOvokkesjF48j8RLtdFxTj4gLtePGOpeB71O/AHp13/U4OK6wSukOxneHGZt7QP
         ugKFzsydFXJeVVKaxyqHd+973UnuqK/GYOSjd18eaYtgHEa+4ZIK2pNzEeGI3STZrX5Q
         rgA1yHTZpRfUAguLuGAxIVroUfzk8YFU5fz3RmrM13fUum0dmUaUV9wD8cr4GnOs6Ax4
         gY1dE52UpgVPUUbVsnjT47zP5rwiD551sDDd75Q/nzwAzeoYXYiBN2KBBHh5nFVcw3MN
         bfnfr7TyikfppuRMink13/KRQpXdliOKf/vDv/+mVbDejIole33v34f52tGJlWnuyS1F
         w96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480294; x=1691072294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eS9MwUiGBcqynGVE0FeA/+dAT/8VCpi0aohdmN5v6Zg=;
        b=eXknvOI6Yz3yUJNo41ult4MBmNsMye9vMqfmxN7aRdpIvNLp7yXgHUzt8Dz2eNtB3H
         5avt1FEjVmNk5Z0EM6CmjWgDzWsj0JhFcYaq/X5aw8vaiZS4mEe1FUBqCrUrHiS0XmFN
         Hs4QLAQ/l368wX1dY4OdcDwvYoyMrpigWwa3GeWguaop5mFehXrztdWqv4YMikcilFg0
         a3WaFhDet7raGJDsue6JsrK3jvYqQ4FQYiqOieC8lx88q0pJnv8KcZcU09O79kgW2m5O
         kNTak6WxjwR8DpJvyfcnnUzhqA75aZtJR3hzZd2AcLR4AjwkshZne71h8yvSz4bwcwh2
         rlHw==
X-Gm-Message-State: ABy/qLbm/Ih5BVsyH+FGtfeySxOjnB043VNl2xaEQH3WnWHOevdBtDjF
        IZN4Mk5gSsavWG//WxrKvalhEA==
X-Google-Smtp-Source: APBJJlFy++WqAbmLwJsZUhEhnywQSW5qCv8OEwfmtYtSMRmsV+V5O1kVPJuwdWa99ShJ4T4/oUOPcg==
X-Received: by 2002:a05:600c:548d:b0:3f1:70d1:21a6 with SMTP id iv13-20020a05600c548d00b003f170d121a6mr81040wmb.0.1688480293964;
        Tue, 04 Jul 2023 07:18:13 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b00314374145e0sm5614126wrt.67.2023.07.04.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:18:13 -0700 (PDT)
Date:   Tue, 4 Jul 2023 14:18:09 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, tabba@google.com, qperret@google.com,
        will@kernel.org, catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com
Subject: Re: [PATCH v3] KVM: arm64: Use BTI for nvhe
Message-ID: <ZKQqIYRrckLlXqkx@google.com>
References: <20230530150845.2856828-1-smostafa@google.com>
 <20230704134136.a5znw4jupt5yp5kg@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704134136.a5znw4jupt5yp5kg@bogus>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Jul 04, 2023 at 02:41:36PM +0100, Sudeep Holla wrote:
> On Tue, May 30, 2023 at 03:08:45PM +0000, Mostafa Saleh wrote:
> > CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
> > However, the nvhe code doesn't make use of it as it doesn't map any
> > pages with Guarded Page(GP) bit.
> > 
> > kvm pgtable code is modified to map executable pages with GP bit
> > if BTI is enabled for the kernel.
> > 
> > At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configuration
> > (SCTLR_EL1.BT1) set in bti_enable().
> > 
> > One difference between kernel and nvhe code, is that the kernel maps
> > .text with GP while nvhe maps all the executable pages, this makes
> > nvhe code need to deal with special initialization code coming from
> > other executable sections (.idmap.text).
> > For this we need to add bti instruction at the beginning of
> > __kvm_handle_stub_hvc as it can be called by  __host_hvc through
> > branch instruction(br) and unlike SYM_FUNC_START, SYM_CODE_START
> > doesn’t add bti instruction at the beginning, and it can’t be modified
> > to add it as it is used with vector tables.
> > Another solution which is more intrusive is to convert
> > __kvm_handle_stub_hvc to a function and inject “bti jc” instead of
> > “bti c” in SYM_FUNC_START
> >
> 
> I was chasing a bug in linux-next yesterday with protected nVHE(pKVM) and
> cpuidle enabled. The system fails to boot. I just bisected the issue to this
> patch and also saw this patch landed in the linus tree yesterday/today.

One of the challenges of BTI is that we need to add explicit BTI instructions
for assembly code. I checked the code to make sure that nothing was missing,
but maybe this is not the case.
Can you please share more about the issue (is ESR a Branch Target Exception,
call stack...) if possible.
Also, is this with CONFIG_ARM_PSCI_CPUIDLE?

> Not sure if this is something to do with the fact that pKVM skips to
> __kvm_handle_stub_hvc in __host_hvc.
__kvm_handle_stub_hvc is called from __host_hvc with "br x5"
That's why "bti j" was added at the beginning of __kvm_handle_stub_hvc,
so this should be fine.

> Let me know if you want be to try something.
> 
> -- 
> Regards,
> Sudeep

Thanks,
Mostafa


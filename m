Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6336BB52C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjCONvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjCONvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:51:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F81C33C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:51:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o8so4427195lfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678888259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6h4ERbssRm4LMMhoCr7ocyGUGSfvn0Dwi4wvvYbcJ8=;
        b=tUrMhx/EWygjkZ9/hDSlhoGrmjiQ++CTz7r0V0DOGzdDbI8IPqCBuv9E6jTMw6zXjH
         y+ILtfGZgeiehKRbPqJos+7ob+xi2Bb9Q+3sIRtkLZGjbo0ohLtLIAcIu5xnl1Qv4mTs
         Uv3kD2R4peNCUw8dZOZr7xeIZ0pwyqRg20FYUxoNVcrnCPxtIaQm63Y2pBC4L6YYKWu9
         /Q+LNdC4HsUjMUtcSfZSehUw27dV0XpyhIkLgbBuGQMIFrSZztWtIRqYHOwmS+bGb9XE
         DK/19zKI81E76XOyDXXwHamkYVc1garQPgFV8GVfzCq0Eehv2foHdd4v39eR97uwXPSD
         FG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6h4ERbssRm4LMMhoCr7ocyGUGSfvn0Dwi4wvvYbcJ8=;
        b=Fi+iNdTyqVfKBNRbq3e+bTKh9z15Cy00O6Bx41+cvfHFnyu3YcQ/XVXV9aH1uFiFFc
         SFkWRLOrpr+Ir/wFJcvCyHej7+/NGb+liw516nqBXMqEjVofHAUItCVaOYnGADoNqdGr
         oBJyZyFwn7WUoqzqQGDfVxl3DDDn2rgAXXEb3z9DEdLbPekfOV3o5geziySGXIoS7M59
         2irjjbWEQBrCvofCqLL0w+cSWisEAjM9Z6oLwWXJ+9Jwu+biijIGwsE2Fo5hviEL1TXA
         H0jJlK1jkFznKHeerTPm4PXM+3iqQcAmyupku9zevDZzvZ2GsBPC7SLuGL5A9ashZkZa
         tUmQ==
X-Gm-Message-State: AO0yUKVtwUgwnQP4ysjynWTOy1gPjx5rqoeB3weXnsKwD24jXEP+Xr3o
        rjVSeQMPrJxHQ7HmFZd8kRBQ+PCpeQI4tHWpcFcWnw==
X-Google-Smtp-Source: AK7set+NNTkYt2/d+MgEjUvarKLQKaS8YVNi6mXQadcgIPQNNFZDexhH24VlBFoWVdIbuy/oPMYT5XonhlGPvPlh0TI=
X-Received: by 2002:ac2:48ac:0:b0:4db:b4:c8d7 with SMTP id u12-20020ac248ac000000b004db00b4c8d7mr2010159lfg.2.1678888259137;
 Wed, 15 Mar 2023 06:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221214194056.161492-1-michael.roth@amd.com> <20221214194056.161492-39-michael.roth@amd.com>
In-Reply-To: <20221214194056.161492-39-michael.roth@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 15 Mar 2023 07:50:47 -0600
Message-ID: <CAMkAt6oYxP0S7WQmVx-z+jjpjPDZQSKdEM5pvXKU3kao4WNjgg@mail.gmail.com>
Subject: Re: [PATCH RFC v7 38/64] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_START command
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        luto@kernel.org, dave.hansen@linux.intel.com, slp@redhat.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        bp@alien8.de, vbabka@suse.cz, kirill@shutemov.name,
        ak@linux.intel.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, ashish.kalra@amd.com,
        harald@profian.com, Brijesh Singh <brijesh.singh@amd.com>,
        Josh Eads <josheads@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> +/*
> + * The guest context contains all the information, keys and metadata
> + * associated with the guest that the firmware tracks to implement SEV
> + * and SNP features. The firmware stores the guest context in hypervisor
> + * provide page via the SNP_GCTX_CREATE command.
> + */
> +static void *snp_context_create(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +       struct sev_data_snp_addr data = {};
> +       void *context;
> +       int rc;
> +
> +       /* Allocate memory for context page */
> +       context = snp_alloc_firmware_page(GFP_KERNEL_ACCOUNT);
> +       if (!context)
> +               return NULL;
> +
> +       data.gctx_paddr = __psp_pa(context);
> +       rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_GCTX_CREATE, &data, &argp->error);
> +       if (rc) {
> +               snp_free_firmware_page(context);
> +               return NULL;
> +       }
> +
> +       return context;
> +}
> +
> +static int snp_bind_asid(struct kvm *kvm, int *error)
> +{
> +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +       struct sev_data_snp_activate data = {0};
> +
> +       data.gctx_paddr = __psp_pa(sev->snp_context);
> +       data.asid   = sev_get_asid(kvm);
> +       return sev_issue_cmd(kvm, SEV_CMD_SNP_ACTIVATE, &data, error);
> +}
> +
> +static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +       struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +       struct sev_data_snp_launch_start start = {0};
> +       struct kvm_sev_snp_launch_start params;
> +       int rc;
> +
> +       if (!sev_snp_guest(kvm))
> +               return -ENOTTY;
> +
> +       if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
> +               return -EFAULT;
> +
> +       sev->snp_context = snp_context_create(kvm, argp);
> +       if (!sev->snp_context)
> +               return -ENOTTY;

This was reported-by josheads@. Its possible that userspace can
repeatedly call snp_launch_start() causing the leak of memory from
repeated snp_context_create() calls, leaking SNP contexts in the ASP,
and leaking ASIDs.

A possible solution could be to just error out if snp_context already exists?


+       if (sev->snp_context)
+               return -EINVAL;
+



> +
> +       start.gctx_paddr = __psp_pa(sev->snp_context);
> +       start.policy = params.policy;
> +       memcpy(start.gosvw, params.gosvw, sizeof(params.gosvw));
> +       rc = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_START, &start, &argp->error);
> +       if (rc)
> +               goto e_free_context;
> +
> +       sev->fd = argp->sev_fd;
> +       rc = snp_bind_asid(kvm, &argp->error);
> +       if (rc)
> +               goto e_free_context;
> +
> +       return 0;
> +
> +e_free_context:
> +       snp_decommission_context(kvm);
> +
> +       return rc;
> +}
> +

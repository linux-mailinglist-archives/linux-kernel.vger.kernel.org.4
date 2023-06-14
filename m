Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7672CC14
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjFLRIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbjFLRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:08:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0564610D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:08:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f61efe4584so113e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686589703; x=1689181703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPHA2iInW/5MWEIDY5sRw7hsczk67ay7y9vys8rDT34=;
        b=JGfnzKQxNy5ZG+svk3pKWyN7ndYnw6Cg9NfAVLy+p80Ss4DBGYrgTioADx2kTru1sI
         Jiw4Cq4n4CvBniPpQdYSG0bgvTXC/lCBZWwzRI7ImGoniwCx5RT1mmyE3fAVGSZuo6rl
         kOLCwE/HMFlIkIC68lxhIo0g1ynyfizgcrAin0y7fQOFLdZJL5qPtHBMIMc9HeTz8j3C
         FV6Fe3V1rWxDiUqDjzbJEvoouy9sNYhVLzaF2X0FSyMHSmG8McHmXGU1sd5SgwDQWOqk
         lh1TtdgZNNeeCJXKMM8jvJSHzd5f0xl+QTVGjqiepFPlYV7S5SME39tqQGLNNvDwTNuQ
         OaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589703; x=1689181703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPHA2iInW/5MWEIDY5sRw7hsczk67ay7y9vys8rDT34=;
        b=HUEN7wXbLvoOr2RScqwwM5bDYYTAsY1x5CrL3g4lAyW3pE9QckyIlpdeoDJxlgVefb
         QNWYSpkwXOxOY5dFUAVkwL7x6urVMToMUYuipCiz5tdByFkH9Rsf20uuuyyNMF7IfpMo
         zfXNo4JgFBUngRdCshgO+J27g2Nwgt0WVXYZfTMx9qdZ62NbxSzKamCtT+fewyYMo6pS
         M/gu+OBH0KDcdP4Fhrc/fWyRdS4PWKpPTNpRxPK2XBF90pfdBGRWmA5x++dVqIIpItuH
         bfXedkMtKojv8hJNvEDdRwtZb1pcwu3qhKF15+QaAiwYTrn28du9q1bRHJg5sMc6e8R9
         NdqQ==
X-Gm-Message-State: AC+VfDydQ1qtMs4HovTyEj3p6YNznV1eJDW+X96G6oE6tOrJpwXfWaed
        e8uacCBHcuQQOtBqnNl+70+WuesolizAk2+3c23teg==
X-Google-Smtp-Source: ACHHUZ75qxKnzvhiDDf0D5IcWH78fHsJ5oE2uWNN4sR3H9U9eFd+mPr5PWjgybS2SATgWNhLMY+e7X97TQ0uvb78OYc=
X-Received: by 2002:ac2:4c39:0:b0:4f6:1722:d73a with SMTP id
 u25-20020ac24c39000000b004f61722d73amr147507lfq.5.1686589702990; Mon, 12 Jun
 2023 10:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230612042559.375660-1-michael.roth@amd.com> <20230612042559.375660-30-michael.roth@amd.com>
In-Reply-To: <20230612042559.375660-30-michael.roth@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 12 Jun 2023 11:08:11 -0600
Message-ID: <CAMkAt6qQ73ah0UW2sTh8CYNgMhWRMQ7bVxH5bWpVfCR-ncnZuQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 29/51] KVM: SVM: Add KVM_SEV_SNP_LAUNCH_START command
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, jarkko@kernel.org, ashish.kalra@amd.com,
        nikunj.dadhania@amd.com, liam.merwick@oracle.com,
        zhi.a.wang@intel.com, Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


I commented on a  previous series but I think the bug is still here. I
think users can repeatedly call KVM_SEV_SNP_LAUNCH_START to have KVM
keep allocating more snp_contexts above.

Should we check if the VM already has a |snp_context| and error out if so?

>
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3161A38F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKDVrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiKDVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:47:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19432A941
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:47:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c25so8178233ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynHbSwtftGcDZ0ZBGT0uW2zYajkGXRN5hX6qRZIXJXw=;
        b=l14PcGhfIZyjGqsOHUC43WaAzKTtHd93G8wURkRvW+6QPOwUwW2SWEe/9nXsT1JXIW
         Plcy+XomBYnNyn7b3I90OAl+nQFhi35O3Yr9TbDkAe9Lw/IjiO65h1ARmuLUBk5kekw9
         651o0P7Dhakox1noRUyWQ1YqXXAPdKH+DQmVAQgqqPbyU57QUhSujE9DSpikAAPun63z
         BHBZRxab/Y4QDydoG0UQY0z7tFEtS1vSjH5ZErTiCoXCJWUsCoVt/8XykZd2oU6jw3J9
         GzEMKSV0g2ZxBd47sBGw0/GwlPr/Dj1SGG+JQZfn+RVALvcc6ASB/fbQ8FZ3Zd4AS/Z5
         6VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynHbSwtftGcDZ0ZBGT0uW2zYajkGXRN5hX6qRZIXJXw=;
        b=y3gofjtVdJ/rrKZ+9QyccHkW7I9uaTipXmJgZb9ciuloVKsQBVfNanpOo1gyE10FQL
         5y+I2CU4Hmd9uXFPKcEeMSCAGgI9JmM1TV/Eab8LYb9J3AM2urHd2R54nj2lOK4kYUzR
         Fbrwabp7B7i5XngUqutrhyNaQjDx4KPvSHSh4hj6F3nBXUMS8AN4XDv6AtYaqFAhdYzw
         hi4NbWBilatHN/nILKfQpWbR+wtD2Y58GHyMhXug9+s9eYnUhjiGOHYpykpwrk0+3Ubq
         Df8OGaMhfjx++cMep+qQrnutFZ4XuCBMInuiKbttTk7ZC7nDKh1l+c/MfVOBcc18Y5b6
         ZFYA==
X-Gm-Message-State: ACrzQf1pVZRRo5hlVrecPMdS+UFE+bc98nRQM0OSHeAb8YLXxxFJQ/mI
        vpYGCUp3NY3if6TyNiZre0a2kfNae11CR+2X6DcycA==
X-Google-Smtp-Source: AMsMyM6HiN9hN0iDXoUkt48/SN7u4mfak3cU8cNNZW77W02/zcC0HaTu6dVMxk16SfBkvKIOQ+wNEd3B3PGIVOs9kz8=
X-Received: by 2002:a2e:58e:0:b0:277:9f5:3538 with SMTP id 136-20020a2e058e000000b0027709f53538mr13503376ljf.445.1667598464030;
 Fri, 04 Nov 2022 14:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221104201616.2268815-1-dionnaglaze@google.com> <20221104201616.2268815-4-dionnaglaze@google.com>
In-Reply-To: <20221104201616.2268815-4-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Nov 2022 15:47:31 -0600
Message-ID: <CAMkAt6oPMgAEewMDaf+gdJ+D5bXe6dZX0ty0nGp_NWgaymxXcg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] virt: sev-guest: Remove err in handle_guest_request
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Haowen Bai <baihaowen@meizu.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Nov 4, 2022 at 2:16 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The err variable may not be set in the call to snp_issue_guest_request,
> yet it is unconditionally written back to fw_err if fw_err is non-null.
> This is undefined behavior, and currently returns uninitialized kernel
> stack memory to user space.
>
> The fw_err argument is better to just pass through to
> snp_issue_guest_request, so we do that. Since the issue_request's
> signature has changed fw_err to exitinfo2, we change the argument name
> here.
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
>
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>  drivers/virt/coco/sev-guest/sev-guest.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index d08ff87c2dac..5ebf87651299 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -322,9 +322,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>
>  static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
>                                 u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> -                               u32 resp_sz, __u64 *fw_err)
> +                               u32 resp_sz, __u64 *exitinfo2)

I was off before, but handle_guest_request() is actually the function
Borislav suggested tweaking. Why don't we update
handle_guest_request() to take snp_guest_request_ioctl here since we
are already updating all the call sites in the next patch.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97FC61A69E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKEBdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKEBdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:33:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF0A1BE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:33:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x21so8649845ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oR/InUrXOe7yk14B+Mxcpxd6wu/G3OFX0GGtAQGh368=;
        b=UaCeIDLGKOn/QbUIQxCCQpPVrmH3J8zixvw1r67Hliv6209H4stTJXWx+7GKrgn/IZ
         aEtsKJmDiX/9NdKd6cqFy5wrwft/xB6gNMHeoCbN5NmmeYgYmKFw7nXgiHpSEfR0AwEF
         pJoPV6Sva8frWteYHp6RWPJbZI7ERAVWzaKr7lb+SQKpuJq0XwMpGgEbqI24EzXBPXN6
         nRJZEF1YWTRtnfutL+z2JwA7qKmm0xkDjzY+5S1tJffYOf6K94F304HRD3eMvx5JXmTs
         Zructnxt6CMiQFhKL4NlJx2DPCl6/VWitXF7WeAj/GHJGciiPbl8HWoSMJWK4GoEqkQe
         qsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oR/InUrXOe7yk14B+Mxcpxd6wu/G3OFX0GGtAQGh368=;
        b=ksr5FfyJxk2W+bSm1a9eYDsk8WGxShVAKHIfNv2aJHPfkXTXPb3XICi59SUtw9xR0t
         t+fZyHQUtLR/e8wuPS0/s5TmtLKIwhCtCt/CtYzoqhfnfz9xgtAtbDP3h6ahQPbqgZ1R
         ZdXqgpF8Nz4O/6eG55FXXmz1dseUkFlCvKAcFx6nlFPTG0JTVSL7gDdS9WxtN9BS0J8t
         UxGp27gIJM+KPu9DLXmW0lKmz1/IoxOOVqzhnBSl2Zb0Z94LbZc0Ya45zEua6E9djMN2
         XNq9NsVFlxI3UIqB4+jfv8oYoArVpfLxAqG7sczvvAElHVW9xGcjrMv7UpmOkfVd9AVe
         6Ehw==
X-Gm-Message-State: ACrzQf1NhgPR6X+Br5NKQDAFIp7SVT3U3KurMgnaLmN/VF7PlQTC96tI
        yNZjdD9Kwt9FjyBO6i6sWHLgAjaRUavDTnsHDbMbLA==
X-Google-Smtp-Source: AMsMyM73cbVvc/1lGdp1HPG0yhWpYLf6Muf9TsKFKVbeypLH//rkKE5/wb8p0tr8Aa16FbKtFNHsXnB13j+IeThzYdY=
X-Received: by 2002:a2e:58e:0:b0:277:9f5:3538 with SMTP id 136-20020a2e058e000000b0027709f53538mr13703152ljf.445.1667611993868;
 Fri, 04 Nov 2022 18:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com> <20221104230040.2346862-3-dionnaglaze@google.com>
In-Reply-To: <20221104230040.2346862-3-dionnaglaze@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 4 Nov 2022 19:33:02 -0600
Message-ID: <CAMkAt6oCnHWbDBnrszw3rSBHmLj8Mqou0m6Sjt0Ov67QNd5kHg@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] x86/sev: Change snp_guest_issue_request's fw_err
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
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

On Fri, Nov 4, 2022 at 5:01 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The GHCB specification declares that the firmware error value for a
> guest request will be stored in the lower 32 bits of EXIT_INFO_2.
> The upper 32 bits are for the VMM's own error code. The fw_err argument
> is thus a misnomer, and callers will need access to all 64 bits.
>
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's previous unsigned long*.
> The signature change requires the follow-up change to
> drivers/virt/coco/sev-guest to use the new expected type in order to
> compile.
>
> The firmware might not even be called, so we bookend the call with the
> no firmware call error and clearing the error.
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Venu Busireddy <venu.busireddy@oracle.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Michael Sterritt <sterritt@google.com>
>
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Peter Gonda <pgonda@google.com

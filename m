Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77607186EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjEaQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEaQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:00:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64BC188
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:00:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae64580e9fso150185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685548843; x=1688140843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jQizT3789+tzYGzFzi9rOBnlAA578Vym/bEurZh4F8=;
        b=fQJtlUVO5o8GmB1eRmttqmvmmcc46VFk4c/tkzc/nnhg1SYo8it57DEYbAuBM6cbpp
         DUBN3kQtsi90jFoZxvqiBa166l+ieFgieyYn7JusMbK5qAjRdoYXaCJu/sc++XVLVuzZ
         p1AP8FzjF6OlvyRYChmL0fzFXbEZscm1JzZ8gTxPocnKA/D9jx/byo81JgVY+FqQDwBs
         OdBHCuXNITdbQ8GHlTY+1l7UG+9WzJ9tIxKX8n182RkEPUUjWVb0ut10/W7hHgRE6v7m
         XVi7jfmqeCTUoYlxorje7sbT/7hw1U7gI0g+lDen9vAL67S3s0vD3t+nPB1QxhdtdqIb
         m83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548843; x=1688140843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jQizT3789+tzYGzFzi9rOBnlAA578Vym/bEurZh4F8=;
        b=liI/GG1uC1EpZ3XzAHgY9+eODZTnYt5gIw9+SaVK20QkRj8XhyMEEwsbcHTNtnbApT
         73zFX5JPLgFsTomzgSWf766EW78hgRchAdMmz63bugRIilr7noTlJrj3LANDqFAiC4VA
         N0mlxaEnHrNaLR+H3PN6eSKgrBYmLnf3uoxMH20Y3hCjPnLmvDgDY5lgoR+9c8MiIWj4
         DU8M4HajvAbUiIslAg1oaSRrd7PRf9rBGByc3iyhbCFCoLuIlthG3lMhQqGA247Aa1kx
         wT0WP/Cu1RwaiKPJpDk6tqYpxmRO2htHycc8Z2jxmMTMjpc3hHLHsxLmc4x0DR9G7MMa
         BH7w==
X-Gm-Message-State: AC+VfDzoVSygRCG7yGIGfQofTZO88UHPtDFspcJ9otvwQoexV+TuPpEo
        KpxeABkmkeFcGAWwsxhn11/sn9QDtMlJxWnmpdslow==
X-Google-Smtp-Source: ACHHUZ6v9ZyrwLiqRyB1L3BSfb2a0QQr6088gOM46Cc2b6mGn38qdpOnAVLgmNl0cEAfE5CbNPQEz7GvXIjTedOVe9U=
X-Received: by 2002:a17:902:f115:b0:1af:fc6e:f9f3 with SMTP id
 e21-20020a170902f11500b001affc6ef9f3mr215929plb.12.1685548841407; Wed, 31 May
 2023 09:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230531155821.80590-1-jon@nutanix.com>
In-Reply-To: <20230531155821.80590-1-jon@nutanix.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 31 May 2023 09:00:30 -0700
Message-ID: <CALMp9eSv0ZnHcnKhQg7ZLgmmSy62o_TQo2smPDRtx4wSNKTN+w@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: restore vmx_vmexit alignment
To:     Jon Kohler <jon@nutanix.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 8:59=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
> Commit 8bd200d23ec4 ("KVM: VMX: Flatten __vmx_vcpu_run()") changed
> vmx_vmexit from SYM_FUNC_START to SYM_INNER_LABEL, accidentally
> removing 16 byte alignment as SYM_FUNC_START uses SYM_A_ALIGN and
> SYM_INNER_LABEL does not. Josh mentioned [1] this was unintentional.
>
> Fix by changing to SYM_INNER_LABEL_ALIGN instead.
>
> [1] https://lore.kernel.org/lkml/Y3adkSe%2FJ70PqUyt@p183
>
> Fixes: 8bd200d23ec4 ("KVM: VMX: Flatten __vmx_vcpu_run()")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> CC: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Jim Mattson <jmattson@google.com>

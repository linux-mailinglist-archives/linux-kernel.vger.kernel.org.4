Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788986FBDC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEIDqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjEIDqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:46:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60493AA8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 20:46:04 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b983027d0faso7021530276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683603964; x=1686195964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heI6wD+fRYtkZA7vvjU6+YVyZT4dFVGT3j8tdiHIFbk=;
        b=WVVeeXL+crNCpKv0OvJoozBZPP1RrEdHMojK0ZVf+NV5Unc7dqSTg1Rh5DD/EXHV/6
         Hbtn1iwbMcKJ0Q+p66hu3AQ5nyMMisv3ORTVS73CxwjNKSo/dAb9Ei5ielbuaETHed1J
         zlJwTCPEDzwA5wubx7F5QqSC8OsiebANCQWpNuI836b0doLi1qrIKy60/JxJW4LqQZZH
         WO0T+T+RnIYQV5JXlHY322CB0voYnpHvn2Q0M+3bxsrvqwXB0TLJ7aZEdpdQIJMFEM/k
         M18q4vHN5viXsYYGJ/Vr66+vmM5PzPu+7CcyWyXahpYY4uswv7oZ7pPiTUGgk1P/u3tB
         re3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683603964; x=1686195964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heI6wD+fRYtkZA7vvjU6+YVyZT4dFVGT3j8tdiHIFbk=;
        b=EPNctgt/4BO6+6KHUplvSMRIMUfvUVds5QsUA/qsB62+izu8tdrYmkm+0NpA+52Z8U
         Nm6q8qmkxtl0E9ROCqKoUhRjOaPyhBGvZPTOR9xenGFXjcD3SuIWAdFqHowLtrN0vEvK
         YTC3ozoRQUUjbvzfOXpwiVRSIb4IRIpkPBLn9zJ2iZjgnjDi0lHb69wQKnXwVAPxEFki
         aJj110T5TYrOBlnx321FutdxuhLseQSl6B4HS27ElaIHQ+lITCsQZo25ZxBzhSPBvrjH
         wout6mBVBZL2xIhL0ZajV8N7PcFmvqAOeXqJ3IQY6M93ESy5n64K09FabtOvkFGwoNm4
         YhFg==
X-Gm-Message-State: AC+VfDynMRZHiydBUm9l+870tpQQiG0Ase2orese8259KMMOvFI+We66
        WJcgCFUvCXvSDhZpZ7vEN3iUMZT903FvPFz92zojEg==
X-Google-Smtp-Source: ACHHUZ6BXIumyb22hMEKrqwVERlTg3Gi82E1Wx1OzLAKN+UGFPvJGZZNrhiqWcKABGepS/mm1xwsv8n49RNf1H7czak=
X-Received: by 2002:a25:20d:0:b0:b9e:33a3:f8b4 with SMTP id
 13-20020a25020d000000b00b9e33a3f8b4mr12510089ybc.48.1683603963978; Mon, 08
 May 2023 20:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230509032348.1153070-1-mizhang@google.com>
In-Reply-To: <20230509032348.1153070-1-mizhang@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 8 May 2023 20:45:27 -0700
Message-ID: <CAL715WJJHqZcFURC1h2qa0yyH-cK-T1wxuYnBN7fcVB67kMmbw@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: VMX: add MSR_IA32_TSX_CTRL into msrs_to_save
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
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

On Mon, May 8, 2023 at 8:23=E2=80=AFPM Mingwei Zhang <mizhang@google.com> w=
rote:
>
> Add MSR_IA32_TSX_CTRL into msrs_to_save[] to explicitly tell userspace to
> save/restore the register value during migration. Missing this may cause
> userspace that relies on KVM ioctl(KVM_GET_MSR_INDEX_LIST) fail to port t=
he
> value to the target VM.
>
> In addition, there is no need to add MSR_IA32_TSX_CTRL when
> ARCH_CAP_TSX_CTRL_MSR is not supported in kvm_get_arch_capabilities(). So
> add the checking in kvm_probe_msr_to_save().
>
> Fixes: c11f83e0626b ("KVM: vmx: implement MSR_IA32_TSX_CTRL disable RTM f=
unctionality")
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---

Sign... missed the following two Reviewed-by...

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

Since this is probably the final version, I hope Sean or Paolo would
help add them up before merging it. Appreciate your help. Thanks.

-Mingwei

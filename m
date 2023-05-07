Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE766F996E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjEGPlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEGPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:41:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEC517FC5
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 08:41:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9619095f479so573083266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1683474066; x=1686066066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmK4ZniIrv5NS2FCqVeO/kd1xlzXIt8FyXsfoSYtXMw=;
        b=fYjW3S6vBFo99DDejJ6dR3DOce/OvLlfqo/HdJ4jcvOr8u+y5mXdVuavzATqKorwsa
         Bgq9gfHaOfH3tKznswFAkGDv9e0tMFFrjrMDp7Hve7O8AeYO0ODHqC34PjYAotzscRam
         xIAiPV7psVblPakLMz75r1Qbr39aeiK4bDdoDMQFPgjPsmGKvDBksxSpedFueKgJYPdh
         GrwbmT7RbXER7GdRD9DJBMjawnobXY8E1kYF1qhud6Kl9KsOdu6uG+dARF3LjGR1rwbn
         mA6JqNfIgDbq+Y13VWHBDCfq+fTdFwhVDkOIPf0FTO//CNnrk+b0KbQzoV/+0yTzPKWf
         2Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474066; x=1686066066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmK4ZniIrv5NS2FCqVeO/kd1xlzXIt8FyXsfoSYtXMw=;
        b=YuxFj7UCClHGGyxNx9i3s35gf6FFRTltPLnsiP0JKCuJlo6ucCDuatmQ0hs/lz//vk
         9GXn/4U1lyfbYosAWufSzT8ovp5JSuvFD7A/3kmtOAguTaI0tm5cjWNTjDOuuMJDxnyZ
         +jq+4fRtTYKR22jfNx5Advn3KP0QYeEBy1jRoxpunQqfn3ANA5HzPiKXUsDdC5yttN5r
         3zX+9HlJp7k3EZSsJllrBvQQ9mj4bJBYBFKFJPGsNvlAYqISvwqCqtfhaFLO4jV1IDMj
         HW1gMwzYWp/HVe8jKO/3RBQsyR41siIHuISoAhTrjCwjzMcNY7KFF6PaQFb87ee6NYis
         LRfw==
X-Gm-Message-State: AC+VfDwFmzfUG5OiLRNdGeZ2+PQtf6rqBvPhBECb7gYUTqVdbx1BvQUg
        WRo347MydTJXLCqfevqUFb/aw2S66uDodW36hI1j7g==
X-Google-Smtp-Source: ACHHUZ7LUfU0XgBCGz0+Z2idQCcP3BYRP2y6TVXSPJEs3131X/HL0Il9vnwl4JmH7cB3Dq9LYkObnyKL9fSVjvPtZNg=
X-Received: by 2002:a17:906:d554:b0:94f:e98:4e94 with SMTP id
 cr20-20020a170906d55400b0094f0e984e94mr6621340ejc.47.1683474066326; Sun, 07
 May 2023 08:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <202305061710302032748@zte.com.cn>
In-Reply-To: <202305061710302032748@zte.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 7 May 2023 21:10:54 +0530
Message-ID: <CAAhSdy0fzEi7iOTk3+xS2TaryxXB5=Fy4Qp0k++U_Qq+wJktig@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: use bitmap_zero() API
To:     ye.xingchen@zte.com.cn
Cc:     atishp@atishpatra.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 2:40=E2=80=AFPM <ye.xingchen@zte.com.cn> wrote:
>
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> bitmap_zero() is faster than bitmap_clear(), so use bitmap_zero()
> instead of bitmap_clear().
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/tlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index 0e5479600695..44bc324aeeb0 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -296,7 +296,7 @@ static void make_xfence_request(struct kvm *kvm,
>         unsigned int actual_req =3D req;
>         DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
>
> -       bitmap_clear(vcpu_mask, 0, KVM_MAX_VCPUS);
> +       bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
>         kvm_for_each_vcpu(i, vcpu, kvm) {
>                 if (hbase !=3D -1UL) {
>                         if (vcpu->vcpu_id < hbase)
> --
> 2.25.1

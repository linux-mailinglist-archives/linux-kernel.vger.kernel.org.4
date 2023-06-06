Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8C7235C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFFDbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFDbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:31:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590912D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:31:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977d6aa3758so310399966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1686022297; x=1688614297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wndiCL3ooX0unGrdnlGJh/CooZNsl4DJY/nw60Bvyg=;
        b=4TRPlzmgxwVP4N8fCb9RZqV8HP2cOLntI5VkdodB0q2HH1Nh3nliJ06uBXogZqvlRh
         n0Ux0Sg/MwrolvFP0BlIZBqOOMuEawIj0/4iHJnz2AIIkh4EIpYwcXNQY2yHffTqjSwK
         ub+KmHvGOASUEhHANwD2GWK/czhgqWLIZoor/CjWQvsmNZQN1GHtz0V73BNKvrpIIbWQ
         LhOMozGqRslMCUgEf9ZBTaJ0JI3fUmRe9u/AQWBayZYhtLGZZw5d+Zn+Ztmx4VxC8PHV
         UM58F5k1N9OCzT7+2aZrnm9+mMUeANgphTgzhJX8R8/6kx2zFDHtzkqYhNcSJ2RMkScc
         vF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686022297; x=1688614297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wndiCL3ooX0unGrdnlGJh/CooZNsl4DJY/nw60Bvyg=;
        b=ECyT+xL1fQzwAZrdn2v4ngrsFyWmmOspbFTOvXBGZKpAtMYN1ts9hZRrF4wWjO3re9
         QU0xT40aEPYn9Dhz79moufayIaTnCMPv7QWJ03Eoo852Yo4diItFrOtejQxP1rS5QofH
         uzH4kZBa0iv6ECuz7vo2uTsfEudteL7FNi9Oy2sBPp3O2FCMSwX9Heo6v3a/Ub6F7AL4
         hRaHNQQtgFAFGOCT1gfYDtQRP2n/xLH9xiqTcsdqmTLv0Fe+l66c3CirhwfiwGrDy/4Z
         FJUYct/quZuVavbhBoZSzyLwBxlfdQ4TPO4n++WwVQFwht8Pqv2bPiefbKnO2mZ2LwuM
         1pYA==
X-Gm-Message-State: AC+VfDyE25tKYRsahCrkdJkQxPUNtSa0ICE6m5y0jSIOKOrE6RUrrv8c
        3qcswXoHxjkNfwj8z6uooPjFcxbZSYV+i6lMwq5jcg==
X-Google-Smtp-Source: ACHHUZ7QVZa3RQDP+a9VtfAzcQwf4YFT2UhxLoxBDM/IYolOEXUPpKLOggoV+GzyCKjIgfGl5Xi5Ec22NKzBN859hBs=
X-Received: by 2002:a17:907:c11:b0:973:8afb:634a with SMTP id
 ga17-20020a1709070c1100b009738afb634amr899934ejc.54.1686022296937; Mon, 05
 Jun 2023 20:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <202305061710302032748@zte.com.cn>
In-Reply-To: <202305061710302032748@zte.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 6 Jun 2023 09:01:25 +0530
Message-ID: <CAAhSdy3isg4788uz=fP6DCTD3LgVbXz9Ud7aoi2VmEbRKYkW6w@mail.gmail.com>
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

Queued this patch for 6.5

Thanks,
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

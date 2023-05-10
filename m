Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409706FDF47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjEJNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEJNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:54:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E0D077
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:54:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115eef620so50283879b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683726850; x=1686318850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFTA+YHZar4Oz118gxD97aBFq0XerCtarrUCLUvjDhs=;
        b=NwW8HStLzcBGBWuhkxk3VYdAOnMpFI2yVJn1HJKOAl5bEHTPYu039z1bmncU6S5wZo
         +WXR6OYkF5YJLRun7lQXumWV2fSLFkwEvAwT/L1R7orgVcScwqJTSHqdcjxc/Wr2mIAZ
         8HenVCgm7/dEKgFfyxt4/q+06b6OUjWM9QuQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683726850; x=1686318850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFTA+YHZar4Oz118gxD97aBFq0XerCtarrUCLUvjDhs=;
        b=CC6EMYKCUOs/J6zH/qgW/QWxLunC/buwv1TXRaHakPMqOJUusBSQND6jVcOkcD8SzC
         7VVF6lfiAujMmZKnODwRK566sfiFPj2zsGkwLYPZD31iJy0VtVdA3DHP7OGVGHVWrqex
         pKJSfYRgQrhquceWDVpiFin0ywu4B2CAowODmnE4wt0dI1nVFEz2iNyZDanFSVE14N+0
         pEy+kuiXSafCoGjEYvpyLOtrNcS/NRK1aNUc2HN2MYEXVmUXpqDA/fr0HNWlfJA9BMGm
         4cZzRC00Pkka+r+6I4zDV+zKbp+HRsO9+yowde3Vsarj6i1m+iHD1JEnmCs8v9+3RRJX
         kvvQ==
X-Gm-Message-State: AC+VfDzo0EcaHrK4y6guNJKjY6YQykW1qoeYN00SqkqFf9Oc4g+XB3KX
        lbuug92Z4DqOOhgjVufsjKtWwMPSzRBtanTql4MRIg==
X-Google-Smtp-Source: ACHHUZ5J5Jk+JR6vuoapdbfhTHTzByT7L2jYTyWvA7dlnjqSjg46nP3g1TEKz0R0p2jwesvA/x0xSlQ6S6J4X7O41mQ=
X-Received: by 2002:a17:90a:8186:b0:24e:3e07:9e27 with SMTP id
 e6-20020a17090a818600b0024e3e079e27mr20903759pjn.10.1683726849913; Wed, 10
 May 2023 06:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230508164650.3217164-1-revest@chromium.org> <11481869-52a9-037a-c7a4-ebbc7d426229@huawei.com>
In-Reply-To: <11481869-52a9-037a-c7a4-ebbc7d426229@huawei.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 10 May 2023 15:53:58 +0200
Message-ID: <CABRcYmK_J83T6C+9tqaQ1R5BfQ0D7FQQDFK5h7_UwBEcbu2QsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64,bpf: Support struct arguments in the BPF trampoline
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 9:07=E2=80=AFAM Xu Kuohai <xukuohai@huawei.com> wro=
te:
>
> On 5/9/2023 12:46 AM, Florent Revest wrote:
> > @@ -1799,7 +1799,7 @@ static int prepare_trampoline(struct jit_ctx *ctx=
, struct bpf_tramp_image *im,
> >        *                  [ ...               ]
> >        * SP + args_off    [ arg1              ]
> >        *
> > -      * SP + nargs_off   [ args count        ]
> > +      * SP + nregs_off   [ arg regs count    ]
>
> For description consistency, should arg1 ... argN in the previous
> lines also be changed to arg reg 1 ... arg reg N?

Sure, sounds good :) I'll send a v2

(for some reason your email ended up in my spam folder, lucky I noticed it)

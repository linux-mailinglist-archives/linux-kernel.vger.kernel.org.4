Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A622728A03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjFHVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHVNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEF32700
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C4761806
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC468C4339B;
        Thu,  8 Jun 2023 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686258794;
        bh=cuIyjEnaDDKHWGPHVUVqPlwF4bbvZEjknCMBtvezLbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ALVinRIPZX+aFLgYXJ1Y/B16Nx2vpf8qAeAYJAlZHd63Aqmhp/805FB0GKKb8xtev
         rF2tmBPV6MInMRnTKmm7J5G1zYaAjq+otXimabF7SOUbl+URABHZwxl82oKVBQdsiZ
         vJoYriJZCkqNadHyXZ56BXxtrPkCg3pKopX2uyfkJLK7Uqeh1qDBJuRc4Yd1SHuqlW
         Zs+mVQQWNEh5Ox7iCGm9bP4Ojzls+A/5ke/4H3T6rTSaFjEmnsc2sVFLLEv3aTUhZ1
         7IA0Sa3jMzfAykjvKWFS4tvF950x8qLt2LKCUBgHHcMEnr/E6d7WBH4sP4BfvhVu6h
         kooPumpvbDGmA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso1358524e87.0;
        Thu, 08 Jun 2023 14:13:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDxXzXvAwugc2w1hJiQmcVmuleE6wX97a142OYX54Jc7VCbTYvwf
        eCykNGssjfPT7uG0OLh3Rrby2Gy9fLaQG4AYJt8=
X-Google-Smtp-Source: ACHHUZ5ud7Gh0ZQHPz/7bKTDcYVMi7EmZvDrF5a/DPE65AoGzomb84FF9oB2EqMwVEhhKqnsv9CkvARkh3bT9/ckq80=
X-Received: by 2002:a2e:9009:0:b0:2b1:b0d2:5f03 with SMTP id
 h9-20020a2e9009000000b002b1b0d25f03mr3772006ljg.15.1686258792914; Thu, 08 Jun
 2023 14:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230607091814.46080-1-puranjay12@gmail.com> <20230607091814.46080-4-puranjay12@gmail.com>
 <CAPhsuW7soOQasGw5fHB2qTeJnqR4ZrGBodyO87k=vg=TYqCsWA@mail.gmail.com> <CANk7y0ihF2RvwGXK0p0gOaGrMoPxfb6fcfn3-J40zn8LS8vROQ@mail.gmail.com>
In-Reply-To: <CANk7y0ihF2RvwGXK0p0gOaGrMoPxfb6fcfn3-J40zn8LS8vROQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 8 Jun 2023 14:13:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4KBYvE8oPz+4tF0_7zFoLhO-86Dh1LfZTiW1t59ty24g@mail.gmail.com>
Message-ID: <CAPhsuW4KBYvE8oPz+4tF0_7zFoLhO-86Dh1LfZTiW1t59ty24g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, catalin.marinas@arm.com,
        mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 9:51=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Hi Song,
>
> On Thu, Jun 8, 2023 at 6:28=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Wed, Jun 7, 2023 at 2:18=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> > >
> > [...]
> > > +
> > >  static inline int epilogue_offset(const struct jit_ctx *ctx)
> > >  {
> > >         int to =3D ctx->epilogue_offset;
> > > @@ -701,7 +716,8 @@ static int add_exception_handler(const struct bpf=
_insn *insn,
> > >                                  struct jit_ctx *ctx,
> > >                                  int dst_reg)
> > >  {
> > > -       off_t offset;
> > > +       off_t ins_offset;
> > > +       off_t fixup_offset;
> >
> > Please add some comments for these two offsets.
>
> Here I am using two variables because I need to change from the RO
> buffer for calculating offsets
> to the RW buffer for writing.
>
> Earlier, a single variable could work because it was being reused for
> calculating the second offset
> after writing the first one. Here, I can't re-calculate using the same
> variable because I have to change
> to the RW buffer, and using the same variable would need changing back
> to the RO buffer.
>
> So, I am calculating both offsets first, changing to RW buffer and
> writing both offsets.
>
> But I will add comments explaining what these offsets are being used for.

Thanks for the explanation! These comments will be useful for future work.

Song

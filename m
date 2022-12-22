Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A0653ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiLVCnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVCnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:43:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B74AE6F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:43:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66E0D619B5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE931C43396
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671677025;
        bh=yxnzZUA0xjvsbpIhYk19s4CAr9dBFI/3AXajE2I3niY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZEo16t/oY4uc67H0inWRDfJHROl7twTZBNn7dCPZ86UtHrB5rtQLraHE3tgjCIr23
         2TsVa9/WGWP1DKIDumt/6C6w1GiHo1LiI/sEO1izPjWf37B8i2as/kFnKLRekrrZ3s
         7DjFGHEL4NKEdgdI3/MZSP10wQ5TSjWRh0+P6tiSkhICQ60eW0DKZUFKKzIBuNJBEp
         MW4h5mfrQvK+aY+vf16w5WEDilz1ZWScgYTHwVF79nK4jWtVKa2Ge/65bUxbPb6TKj
         +4MxpRP3Q/Q8/rNCfTM9r3EmXsM/5/k1JchCETyLzF4wgLVJon8pnYxXcP2wu8WOjx
         lnH/1YFa41bWA==
Received: by mail-ed1-f50.google.com with SMTP id i9so1152283edj.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:43:45 -0800 (PST)
X-Gm-Message-State: AFqh2kqPsCuhbTctiOCUzp3Vaq2nHh357xaLVwAoL3Gufxb2sq8nggND
        bOrJWU6Z5kGlFXd+ac8jJvCN9qrselazdMy67LA=
X-Google-Smtp-Source: AMrXdXs6Nk5eiVeyzwxOygjsZZ8dYQcPxJ4ZE8LFyieWNnm14AVVOQQkloslgTt3QfLMJQWkVasAKO6bP04pZHMr1Gg=
X-Received: by 2002:a05:6402:d72:b0:475:de4a:3740 with SMTP id
 ec50-20020a0564020d7200b00475de4a3740mr368067edb.117.1671677023985; Wed, 21
 Dec 2022 18:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20221120101049.2078117-1-guoren@kernel.org> <Y3tPEDvM3aVJmVxF@wendy>
 <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com> <20221222001902.zcbwlvqaitvsfb33@mail.google.com>
In-Reply-To: <20221222001902.zcbwlvqaitvsfb33@mail.google.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 22 Dec 2022 10:43:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSBLk9+V5hvXTNWWi9m7W7PxNNrMo_YgbZNia5oE=7X6Q@mail.gmail.com>
Message-ID: <CAJF2gTSBLk9+V5hvXTNWWi9m7W7PxNNrMo_YgbZNia5oE=7X6Q@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, changbin.du@intel.com, zong.li@sifive.com,
        rostedt@goodmis.org, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 8:19 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hello,
> Does this patch get merged into riscv tree now? This problem has been there for a long
> time. (I suppose you have received my previous reponse.)
You could take the patch and update it to v3 with your SoB :)

>
> On Mon, Nov 21, 2022 at 07:09:45PM +0800, Guo Ren wrote:
> > On Mon, Nov 21, 2022 at 6:13 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> > >
> > > On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel.org wrote:
> > > > From: Changbin Du <changbin.du@gmail.com>
> > >
> > > > Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> > > > Cc: Changbin Du <changbin.du@gmail.com>
> > > > Co-developed-by: Guo Ren <guoren@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Cc: Zong Li <zong.li@sifive.com>
> > > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > > ---
> > >
> > > Hey Guo Ren,
> > >
> > > FYI you're missing a SoB from Chanbin on this patch. They gave one in
> > > their v1 though so you should be able to re-use that?
> > I'm waiting for his SoB. I don't think I could directly use his SoB in
> > v1. I need him to confirm my rewritten commit log for lockdep
> > analysis.
> >
> > >
> > > Thanks,
> > > Conor.
> > >
> > > > Changes in v2:
> > > >  - Rewrite commit log with lockdep explanation [Guo Ren]
> > > >  - Rebase on v6.1 [Guo Ren]
> > > >
> > > > v1:
> > > > https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
>
> --
> Cheers,
> Changbin Du



-- 
Best Regards
 Guo Ren

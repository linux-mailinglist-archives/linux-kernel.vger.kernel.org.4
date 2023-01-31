Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48713682E16
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjAaNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjAaNgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:36:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E59279B6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:36:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADDC0B81C98
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57649C433A0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172173;
        bh=3IHph7JXJE4U1T0QYoP+aCYRh1+skz/PldK61wiSFVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=akLJxoEW2cMETHB9J+GhwTuvx4RDeBgwk48piOnR528rNCO3YPzeeLvkEM9FqWgN+
         7jIbMm8sQMECSXVjLiEBBaxzqRDwwfTInqrgfXgNRiR8tsrBac7p884aWQk/gkAVux
         YmbA7X36Fh/CljwA+1YMKCcjRExREFvO+/VqvgggKxbVizv+AJnTginHc4lgiXgpcc
         q/JkkEMkB9KpYq/jX6hztKq/b3rKLtqlYf7n7I/f3VjkW6tgq3uaVhgR4ki/rDQ9re
         TuYogNodGLxqm15ROahKgJ28OVd7DAUfGtoGZS5CPD9zVeN5r9mS5qHIwm22sfI+Ui
         QBYjrNd9N2pTw==
Received: by mail-ej1-f53.google.com with SMTP id m2so41182045ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:36:13 -0800 (PST)
X-Gm-Message-State: AO0yUKUqMJIntYkdNqozJs2ZOOoQbRDt8yWkOJ0Wwjx+G+WvmUHpkE9J
        Jji7cf3RM87Ef05A1NyFPbjDATV54jrBzeS2F4A=
X-Google-Smtp-Source: AMrXdXularVT6h3tPHLAheU0aHvep+fEiLo4QFlkkLB+2daB8tr4RIXB1T48JoOBlAV3tLtA7jTDEduJJz6SdKO9Y0Q=
X-Received: by 2002:a17:906:770d:b0:877:e1ef:e49a with SMTP id
 q13-20020a170906770d00b00877e1efe49amr6547828ejm.147.1675172171455; Tue, 31
 Jan 2023 05:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20230126170607.1489141-1-guoren@kernel.org> <20230126170607.1489141-2-guoren@kernel.org>
 <87357sjkv8.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87357sjkv8.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 21:35:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS3s6EANWGSeykAGes=+MFbCAFxy5d0NFS+ynwRoQcCRA@mail.gmail.com>
Message-ID: <CAJF2gTS3s6EANWGSeykAGes=+MFbCAFxy5d0NFS+ynwRoQcCRA@mail.gmail.com>
Subject: Re: [PATCH -next V3 1/2] riscv: jump_label: Fixup unaligned
 arch_static_branch function
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, jrtc27@jrtc27.com, andy.chiu@sifive.com,
        zong.li@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 7:57 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> guoren@kernel.org writes:
>
> > From: Andy Chiu <andy.chiu@sifive.com>
> >
> > Runtime code patching must be done at a naturally aligned address, or w=
e
> > may execute on a partial instruction.
> >
> > We have encountered problems traced back to static jump functions durin=
g
> > the test. We switched the tracer randomly for every 1~5 seconds on a
> > dual-core QEMU setup and found the kernel sucking at a static branch
> > where it jumps to itself.
> >
> > The reason is that the static branch was 2-byte but not 4-byte aligned.
> > Then, the kernel would patch the instruction, either J or NOP, with two
> > half-word stores if the machine does not have efficient unaligned
> > accesses. Thus, moments exist where half of the NOP mixes with the othe=
r
> > half of the J when transitioning the branch. In our particular case, on
> > a little-endian machine, the upper half of the NOP was mixed with the
> > lower part of the J when enabling the branch, resulting in a jump that
> > jumped to itself. Conversely, it would result in a HINT instruction whe=
n
> > disabling the branch, but it might not be observable.
> >
> > ARM64 does not have this problem since all instructions must be 4-byte
> > aligned.
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>
> Nice catch! And I guess this is an issue for kprobes as well, no?
> I.e. in general replacing 32b insns with an ebreak. This is only valid
> for natural aligned 32b insns?
>
> @Guo I don't see the point of doing a series for this, and asking the
> maintainers to "pick this patch to stable, and the other for
> next". Isn't that just more work for the maintainers/reviewers?
If these two patches are separated, they are all fixup that issue and
competed with each other. Making my patch an optimization patch must
depend on it. That's why I put them in one series.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5A6F8078
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjEEKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjEEKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD851816A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 989A263C33
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDDC4339E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683280899;
        bh=Ec2ll/P9tx8U/dBQxy3ZG+nUnHx39GhJcsKwfUcl+ek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FJV0yXgxVbxDUT5oHwfpctONYlQwh1inVw1hkoxqIIo7Xh7XU5qLGV96M88uSYps+
         80ePmkd9mKM0Ta/x82WIzmee0PJRCyknqJh9pvhhuX3AqENGJmm6gqOJpp7lpu9IrQ
         vX39SaZEKkZVfvL2UlYoUS7lLaxnA8G5TAIdNFWvy0Zln0jvRXeVf4MeGZ2AniAZFu
         XrN89rpEZ97kXZYAENJvyqcDkjq9NVrNmnBiDnhmExLluGn6BjmPp8qchvt9PM8FQt
         bRDRT0T9y79aB2p/sPFLSXGAnY5XaPKAsLWsX6Fc96a/76QWHKSKic8/DH39VCXcqO
         aR+f2BdJwb6uA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso2779489a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 03:01:38 -0700 (PDT)
X-Gm-Message-State: AC+VfDzHb60Mq+L3byLS6RAjzifkzIeg0l/GqLcv4l9zqFreCahxUIBo
        5a0GHa5U/7VOks2CotIol6slSzOSRYkBFaiJ9vY=
X-Google-Smtp-Source: ACHHUZ6cv5uf8DA2g1qYJdz+yn4p/ZuvFXjDqZGWthSuaLRL+DOJ0hmeFjGg+R/3lP7VI9aiX9CexZ4uVLWUqCuC9dg=
X-Received: by 2002:a17:907:2687:b0:961:a67:29c with SMTP id
 bn7-20020a170907268700b009610a67029cmr616582ejc.70.1683280897147; Fri, 05 May
 2023 03:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1682214146-3756-1-git-send-email-yangtiezhu@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 5 May 2023 18:01:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRqdP-RVSMshwzJuAcm1bBeg1-wZU_k_Oo409=O4QZR-w@mail.gmail.com>
Message-ID: <CAJF2gTRqdP-RVSMshwzJuAcm1bBeg1-wZU_k_Oo409=O4QZR-w@mail.gmail.com>
Subject: Re: [PATCH] riscv: uprobes: Restore thread.bad_cause
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for fixup.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sun, Apr 23, 2023 at 9:42=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> thread.bad_cause is saved in arch_uprobe_pre_xol(), it should be restored
> in arch_uprobe_{post,abort}_xol() accordingly, otherwise the save operati=
on
> is meaningless, this change is similar with x86 and powerpc.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index c976a21..194f166 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -67,6 +67,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, s=
truct pt_regs *regs)
>         struct uprobe_task *utask =3D current->utask;
>
>         WARN_ON_ONCE(current->thread.bad_cause !=3D UPROBE_TRAP_NR);
> +       current->thread.bad_cause =3D utask->autask.saved_cause;
>
>         instruction_pointer_set(regs, utask->vaddr + auprobe->insn_size);
>
> @@ -102,6 +103,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprob=
e, struct pt_regs *regs)
>  {
>         struct uprobe_task *utask =3D current->utask;
>
> +       current->thread.bad_cause =3D utask->autask.saved_cause;
>         /*
>          * Task has received a fatal signal, so reset back to probbed
>          * address.
> --
> 2.1.0
>


--=20
Best Regards
 Guo Ren

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46B70899D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjERUgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:36:07 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D3192
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:36:06 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75939de402dso138068085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684442166; x=1687034166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6vIPAnAXiIbE7GxQKjikvJFrDID6ufWVHNuBxI6IrI=;
        b=cEg9d8yCjGNfJ7R9+SQYM7j2Qz7M7RPSjNPdJd97UtAlGbH4Z6lroTI3W2AmSrEMoa
         qI89k1uJoTbNshNGAgaFHmn6PzoQA0pXbkqExPqu82ze18BRp8ib1vM4FbDvh+W2xyFi
         qALtqHA4fxPOSWJidFYWmgBYQpK70rzDHNzjNNyELW0BfdPWiyokFSrrU7xd5Ya6mL3o
         fxFvvmewKSVOGKEfKCxVD+waLG8wfI51XL/V4t6xy8hFJ6v23iGzqVP1nOebLRGXGYRo
         EFBHzeK406RZYRSaE60gQysNZpOcOJ71NVYG2xVqEpv++fvgtRi+io6m7pEwqKCoElAr
         iq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684442166; x=1687034166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6vIPAnAXiIbE7GxQKjikvJFrDID6ufWVHNuBxI6IrI=;
        b=GNOUNoF5waBtVP6mEPKNdYuQWZlw4/Y0ajs+5xel6QcGzir+HBx1Fe9oAra0k0Wo23
         XB3erplyTgy6DFdhRstoEFdFnH7U8jvCnlBgc6JKKRnGmhVxG1qeVBBqm9gRv8Wc76eW
         79QjnNVlANhcaF/WKiFMK+hy7Coz4uw7Wfh5zqZZ1CDIsTxad2P/OwKYXAM23vIphqHo
         jDPHSTTkDuDo7eypyJI5OGEWP75U7n03V1oL9jksIu2dfwWFl9quauClDTayQc34GaSA
         Zf5HOx9uWmP0xXlNrBkDgCIPf4ZSXSTW/EA+BOvRorzZ1muZVqvqAJMmX3AzgkIJDK1w
         Ii/Q==
X-Gm-Message-State: AC+VfDza6iiBXSyNixDJC+60d+3KuGH23n0oiBiCbTsDt41LzmBmaBMZ
        EuX0y85s19oVxNeGEnQxoqbJcgaVe0g7LnGRnrYv/+cWrRGViLU2nUg=
X-Google-Smtp-Source: ACHHUZ7WExvI+Xshuj4W3JmhZ1tqQei2xC1xFX0rWe+rcTPjADMLUcLi9zESF1fvqdWVrLvuAY6CWj6RvQYC+XYXxlo=
X-Received: by 2002:a05:6214:2506:b0:622:6015:8e7d with SMTP id
 gf6-20020a056214250600b0062260158e7dmr514537qvb.50.1684442165603; Thu, 18 May
 2023 13:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230518035321.1672-1-angus.chen@jaguarmicro.com> <20230518130221.81e8e1f474cfbfd6c93712c5@linux-foundation.org>
In-Reply-To: <20230518130221.81e8e1f474cfbfd6c93712c5@linux-foundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 May 2023 13:35:54 -0700
Message-ID: <CAKwvOdmtnpETT4P88NZKAtLNvj4kJ7MtotAwNJSdh7WVxa_xJA@mail.gmail.com>
Subject: Re: [PATCH] init: Add bdev fs printk if mount_block_root failed
To:     Andrew Morton <akpm@linux-foundation.org>,
        Angus Chen <angus.chen@jaguarmicro.com>
Cc:     masahiroy@kernel.org, vbabka@suse.cz, peterz@infradead.org,
        paulmck@kernel.org, rppt@kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Thu, May 18, 2023 at 1:02=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 18 May 2023 11:53:21 +0800 Angus Chen <angus.chen@jaguarmicro.com=
> wrote:
>
> > Attempt to printk all bdev fstype as root gives the following kernel pa=
nic:
> >
> > [    1.729006] VFS: Cannot open root device "vda" or unknown-block(253,=
0): error -19
> > [    1.730603] Please append a correct "root=3D" boot option; here are =
the available partitions:
> > [    1.732323] fd00          256000 vda
> > [    1.732329]  driver: virtio_blk
> > [    1.734194] Kernel panic - not syncing: VFS: Unable to mount root fs=
 on unknown-block(253,0)
> > [    1.734771] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #53
> > [    1.735194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.10.2-1ubuntu1 04/01/2014
> > [    1.735772] Call Trace:
> > [    1.735950]  <TASK>
> > [    1.736113]  dump_stack_lvl+0x32/0x50
> > [    1.736367]  panic+0x108/0x310
> > [    1.736570]  mount_block_root+0x161/0x310
> > [    1.736849]  ? rdinit_setup+0x40/0x40
> > [    1.737088]  prepare_namespace+0x10c/0x180
> > [    1.737393]  kernel_init_freeable+0x354/0x450
> > [    1.737707]  ? rest_init+0xd0/0xd0
> > [    1.737945]  kernel_init+0x16/0x130
> > [    1.738196]  ret_from_fork+0x1f/0x30
> >
> > QEMU command line:
> > "qemu-system-x86_64 -append root=3D/dev/vda rootfstype=3Dext4 ..."
> >
> > This error is because ext4 is not buildin and request ext4 module fail.

Cool! I'm glad this got picked up; I personally find it confusing when
trying to start from something like an allnoconfig build then start
enabling configs then hitting this panic; it's unclear to users that
they are missing the config for the FS they are trying to load and on
first glance looks like something much worse is going wrong.  In that
sense, I view this as a win. Thanks for the patch!

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

I wish the commit message showed an example of the panic after the
patch, to contrast the before vs. after.

> >
> > As a hint, printk all the bdev fstype available for prompts.
> >
>
> Seems reasonable.  I reworded the changelog a bit:
>
> : Booting with the QEMU command line:
> : "qemu-system-x86_64 -append root=3D/dev/vda rootfstype=3Dext4 ..."
> : will panic if ext4 is not builtin and a request to load the ext4 module
> : fails.
> :
> : [    1.729006] VFS: Cannot open root device "vda" or unknown-block(253,=
0): error -19
> : [    1.730603] Please append a correct "root=3D" boot option; here are =
the available partitions:
> : [    1.732323] fd00          256000 vda
> : [    1.732329]  driver: virtio_blk
> : [    1.734194] Kernel panic - not syncing: VFS: Unable to mount root fs=
 on unknown-block(253,0)
> : [    1.734771] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc2+ #53
> : [    1.735194] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.10.2-1ubuntu1 04/01/2014
> : [    1.735772] Call Trace:
> : [    1.735950]  <TASK>
> : [    1.736113]  dump_stack_lvl+0x32/0x50
> : [    1.736367]  panic+0x108/0x310
> : [    1.736570]  mount_block_root+0x161/0x310
> : [    1.736849]  ? rdinit_setup+0x40/0x40
> : [    1.737088]  prepare_namespace+0x10c/0x180
> : [    1.737393]  kernel_init_freeable+0x354/0x450
> : [    1.737707]  ? rest_init+0xd0/0xd0
> : [    1.737945]  kernel_init+0x16/0x130
> : [    1.738196]  ret_from_fork+0x1f/0x30
> :
> : As a hint, print all the bdev fstypes which are available.
>
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -427,8 +427,19 @@ void __init mount_block_root(char *name, int flags=
)
> >               printk("VFS: Cannot open root device \"%s\" or %s: error =
%d\n",
> >                               root_device_name, b, err);
> >               printk("Please append a correct \"root=3D\" boot option; =
here are the available partitions:\n");
> > -
> >               printk_all_partitions();
> > +
> > +             if (root_fs_names)
> > +                     num_fs =3D list_bdev_fs_names(fs_names, PAGE_SIZE=
);
> > +             if (!num_fs)
> > +                     pr_err("Can't find any bdev filesystem to be used=
 for mount!\n");
> > +             else {
> > +                     pr_err("List of all bdev filesystem:\n");
> > +                     for (i =3D 0, p =3D fs_names; i < num_fs; i++, p =
+=3D strlen(p)+1)
> > +                             pr_err(" %s", p);
> > +                     pr_err("\n");
> > +             }
> > +
> >               panic("VFS: Unable to mount root fs on %s", b);
> >       }
> >       if (!(flags & SB_RDONLY)) {
>
> And I added a little fix.
>
> --- a/init/do_mounts.c~init-add-bdev-fs-printk-if-mount_block_root-failed=
-fix
> +++ a/init/do_mounts.c
> @@ -434,7 +434,7 @@ retry:
>                 if (!num_fs)
>                         pr_err("Can't find any bdev filesystem to be used=
 for mount!\n");
>                 else {
> -                       pr_err("List of all bdev filesystem:\n");
> +                       pr_err("List of all bdev filesystems:\n");
>                         for (i =3D 0, p =3D fs_names; i < num_fs; i++, p =
+=3D strlen(p)+1)
>                                 pr_err(" %s", p);
>                         pr_err("\n");
> _
>
>
> This function now uses a jumble of printk() and pr_err().  Perhaps
> someone will go through and rationalize all of this sometime.
>


--=20
Thanks,
~Nick Desaulniers

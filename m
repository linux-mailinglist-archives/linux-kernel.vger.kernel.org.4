Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB9613093
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJaGkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:40:08 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CC9FCE;
        Sun, 30 Oct 2022 23:40:05 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p184so9042105iof.11;
        Sun, 30 Oct 2022 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTTmgU0K33bBo7jfwrU7Z3z+T+XngmxYab/NvTmXwa4=;
        b=CIS6QD1tPwtZiiXTNhoJZkkQoIuW7pIjOK9wzjJeNX5Eaa4faz5K95xQyA2hQkeaQ4
         Bc+zDgeOmZGlkUgOW2bwcnHkwpQBeYLJZQcPc7C3F8+E8UYPIQVrBQ7coWc+6kPPTPqL
         /x0m0kwnDdosiEDLst3o7zsE1JREoBZe7uUFfN+N3c0qII6bG8ifZLBE0qCAbFoik+KE
         F/ly1e6DboZqKXjIDJUHmAGGh+cW3LvkMn460+ZyU6kpfwh2WSqGSoJwUbFe350gO3yO
         KXX44PC9kzNkiX8M9jmRXiSzbXL58qhdl4qryUohOP3+6VHsb/YIHzC2ReHGeCHoM6pu
         h4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTTmgU0K33bBo7jfwrU7Z3z+T+XngmxYab/NvTmXwa4=;
        b=dPrW+sKOTQ7nZaAAEDjvCoS9GXVYgjJ3uAoTojPy8V/vViyQW8WMRnFokPXREUD42f
         1TWJVuushxU3bhUtZ63AIjm3QQ6/cQZFWRK4RXSCLOE7wCj0RL3zk5Cqs7I4fVHONMLw
         M18zHSL+Jf0mjei2K82NWHif8OFNWkruhXMzbPeXXHhqwErlAWSoytqam1x4AieFXwyu
         zZlJNsG1DsalJlUenlXAKDI1xM/KSvIxStkrPUNca9lf4shAK+Myyal6gK7mm9Mi+Odn
         CSSnByhqGh7Y14+cZU2wYEJ9ZVQTNbtAfnU6zcuQ67J6I5tFUB+KTOrIcWk01sAJaXRi
         4czA==
X-Gm-Message-State: ACrzQf1bH2Az1l2dAiUJmHnkIdgTE7PaSnM9h3JoPQwJFLH4y7NpD8wG
        GLBLXotOSZBiJiK5jc1AA6ehM3fJ76048SXFUu8=
X-Google-Smtp-Source: AMsMyM7W0AZqQiNUWnr3tRvz+ffWqKpfOUMzankcD1+7Lr809OsJ731dz5zBGLAGYt4YEmVO4Jf/9a44d2Pw2K6X8Hg=
X-Received: by 2002:a05:6602:1691:b0:6bc:659d:5fe3 with SMTP id
 s17-20020a056602169100b006bc659d5fe3mr6035590iow.71.1667198404887; Sun, 30
 Oct 2022 23:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221028084919.21654-1-gengcixi@gmail.com> <Y1udKz/0UpVJb++p@kroah.com>
In-Reply-To: <Y1udKz/0UpVJb++p@kroah.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 31 Oct 2022 14:39:28 +0800
Message-ID: <CAF12kFsmnDzdozM4KAr-Ah+3ZZGWWVXx+zyy4W5sLFqikT6xhQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Fix dentry leak in dwc3_gadget_free_endpoints
To:     Greg KH <gregkh@linuxfoundation.org>, brucechen251@gmail.com
Cc:     Thinh.Nguyen@synopsys.com, bruce.chen@unisoc.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 17:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 28, 2022 at 04:49:19PM +0800, Cixi Geng wrote:
> > From: Bruce Chen <bruce.chen@unisoc.com>
> >
> > When using debugfs_remove_recursive leaks a dentry with
> > a hotplug stress test, the phone runs out of memory.
> >
> > Thus fix the issue by using the newly created debugfs_lookup_and_remove=
().
> >
> > Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >  drivers/usb/dwc3/core.h    | 1 +
> >  drivers/usb/dwc3/debugfs.c | 3 ++-
> >  drivers/usb/dwc3/gadget.c  | 4 +---
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > index 8f9959ba9fd4..ba3ecaa7f06c 100644
> > --- a/drivers/usb/dwc3/core.h
> > +++ b/drivers/usb/dwc3/core.h
> > @@ -1261,6 +1261,7 @@ struct dwc3 {
> >       u8                      num_eps;
> >
> >       struct dwc3_hwparams    hwparams;
> > +     struct dentry           *root;
>
> You forgot to document this new variable.
>
> And name it a bit better?
>
> >       struct debugfs_regset32 *regset;
> >
> >       u32                     dbg_lsp_select;
> > diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> > index f2b7675c7f62..b9af4a81f51d 100644
> > --- a/drivers/usb/dwc3/debugfs.c
> > +++ b/drivers/usb/dwc3/debugfs.c
> > @@ -911,6 +911,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
> >       dwc->regset->base =3D dwc->regs - DWC3_GLOBALS_REGS_START;
> >
> >       root =3D debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
> > +     dwc->root =3D root;
> >       debugfs_create_regset32("regdump", 0444, root, dwc->regset);
> >       debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
> >
> > @@ -929,6 +930,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
> >
> >  void dwc3_debugfs_exit(struct dwc3 *dwc)
> >  {
> > -     debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root)=
);
> > +     debugfs_remove(dwc->root);
> >       kfree(dwc->regset);
> >  }
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 079cd333632e..6d6c188fcbea 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -3172,9 +3172,7 @@ static void dwc3_gadget_free_endpoints(struct dwc=
3 *dwc)
> >                       list_del(&dep->endpoint.ep_list);
> >               }
> >
> > -             debugfs_remove_recursive(debugfs_lookup(dep->name,
> > -                             debugfs_lookup(dev_name(dep->dwc->dev),
> > -                                            usb_debug_root)));
> > +             debugfs_lookup_and_remove(dep->name, dwc->root);
> >               kfree(dep);
> >       }
> >  }
> > --
> > 2.34.1
> >
>
> I don't think this is the full fix.
>
> Below is a patch that I've had in a tree that I need to push out (along
> with the other 33 debugfs_lookup patches) that should resolve this for
> this driver in a more complete way.
>
> Can you try this version instead?
We test OK by using the following patch. thanks.

Best Regards
Cixi Geng
>
> thanks,
>
> greg k-h
>
> ---------------------
>
>
> From 49b893792579af1bea46c5004759cb35475c4fca Mon Sep 17 00:00:00 2001
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Fri, 2 Sep 2022 16:41:39 +0200
> Subject: [PATCH 06/34] USB: dwc3: debugfs_lookup() fix
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/dwc3/core.h    |  2 ++
>  drivers/usb/dwc3/debug.h   |  3 +++
>  drivers/usb/dwc3/debugfs.c | 19 ++++++++-----------
>  drivers/usb/dwc3/gadget.c  |  4 +---
>  4 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8f9959ba9fd4..582ebd9cf9c2 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1117,6 +1117,7 @@ struct dwc3_scratchpad_array {
>   *                  address.
>   * @num_ep_resized: carries the current number endpoints which have had =
its tx
>   *                 fifo resized.
> + * @debug_root: root debugfs directory for this device to put its files =
in.
>   */
>  struct dwc3 {
>         struct work_struct      drd_work;
> @@ -1332,6 +1333,7 @@ struct dwc3 {
>         int                     max_cfg_eps;
>         int                     last_fifo_depth;
>         int                     num_ep_resized;
> +       struct dentry           *debug_root;
>  };
>
>  #define INCRX_BURST_MODE 0
> diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
> index 48b44b88dc25..8bb2c9e3b9ac 100644
> --- a/drivers/usb/dwc3/debug.h
> +++ b/drivers/usb/dwc3/debug.h
> @@ -414,11 +414,14 @@ static inline const char *dwc3_gadget_generic_cmd_s=
tatus_string(int status)
>
>  #ifdef CONFIG_DEBUG_FS
>  extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
> +extern void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep);
>  extern void dwc3_debugfs_init(struct dwc3 *d);
>  extern void dwc3_debugfs_exit(struct dwc3 *d);
>  #else
>  static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
>  {  }
> +static inline void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
> +{  }
>  static inline void dwc3_debugfs_init(struct dwc3 *d)
>  {  }
>  static inline void dwc3_debugfs_exit(struct dwc3 *d)
> diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> index f2b7675c7f62..850df0e6bcab 100644
> --- a/drivers/usb/dwc3/debugfs.c
> +++ b/drivers/usb/dwc3/debugfs.c
> @@ -873,27 +873,23 @@ static const struct dwc3_ep_file_map dwc3_ep_file_m=
ap[] =3D {
>         { "GDBGEPINFO", &dwc3_ep_info_register_fops, },
>  };
>
> -static void dwc3_debugfs_create_endpoint_files(struct dwc3_ep *dep,
> -               struct dentry *parent)
> +void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
>  {
> +       struct dentry           *dir;
>         int                     i;
>
> +       dir =3D debugfs_create_dir(dep->name, dep->dwc->debug_root);
>         for (i =3D 0; i < ARRAY_SIZE(dwc3_ep_file_map); i++) {
>                 const struct file_operations *fops =3D dwc3_ep_file_map[i=
].fops;
>                 const char *name =3D dwc3_ep_file_map[i].name;
>
> -               debugfs_create_file(name, 0444, parent, dep, fops);
> +               debugfs_create_file(name, 0444, dir, dep, fops);
>         }
>  }
>
> -void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
> +void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
>  {
> -       struct dentry           *dir;
> -       struct dentry           *root;
> -
> -       root =3D debugfs_lookup(dev_name(dep->dwc->dev), usb_debug_root);
> -       dir =3D debugfs_create_dir(dep->name, root);
> -       dwc3_debugfs_create_endpoint_files(dep, dir);
> +       debugfs_lookup_and_remove(dep->name, dep->dwc->debug_root);
>  }
>
>  void dwc3_debugfs_init(struct dwc3 *dwc)
> @@ -911,6 +907,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
>         dwc->regset->base =3D dwc->regs - DWC3_GLOBALS_REGS_START;
>
>         root =3D debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
> +       dwc->debug_root =3D root;
>         debugfs_create_regset32("regdump", 0444, root, dwc->regset);
>         debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
>
> @@ -929,6 +926,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
>
>  void dwc3_debugfs_exit(struct dwc3 *dwc)
>  {
> -       debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root)=
);
> +       debugfs_lookup_and_remove(dev_name(dwc->dev), usb_debug_root);
>         kfree(dwc->regset);
>  }
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 079cd333632e..404bb7ee61a8 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3172,9 +3172,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 =
*dwc)
>                         list_del(&dep->endpoint.ep_list);
>                 }
>
> -               debugfs_remove_recursive(debugfs_lookup(dep->name,
> -                               debugfs_lookup(dev_name(dep->dwc->dev),
> -                                              usb_debug_root)));
> +               dwc3_debugfs_remove_endpoint_dir(dep);
>                 kfree(dep);
>         }
>  }
> --
> 2.38.1
>

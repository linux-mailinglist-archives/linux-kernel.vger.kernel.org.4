Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633C72BD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjFLJuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjFLJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:50:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8159E6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b1fdab9d68so218135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686562514; x=1689154514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29GQz4N1RuYE3YAahRNzsPBKqNihkCK7xJvEQHxVFP8=;
        b=h5PXdrEXv3zRjkg/o1XhxWAB8orJ+9cw1KEkb5ZfVk54k7CDl58HC3ZT13QTFKKljA
         9eyR3GgiTntD4bEDoiL8LfajNUDevgkS5amQXFd8KlyStubkhdnitkm9rN0DJ+/l+qMc
         gKAhq08hcqqYwpLb6pNUFFLhk2ZIEmrh9c3G29zVIh04p+8SW9mHw4JP7I7rOgJlxJf4
         CRfJhAqu9RlgloFE9x0RLhD7vOWOaqBSQef6WHA6qivk6f92tXVvTTXa24d7A+yEg84G
         dBgYgR/IR6jiKQKRFqwB18u84Cf5RoMggL0CNWTi9cCY8ytvVP/ylbxOCFII3gTFDyEq
         T3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562514; x=1689154514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29GQz4N1RuYE3YAahRNzsPBKqNihkCK7xJvEQHxVFP8=;
        b=ixcRiKR30WreEZSm/oP0bbAtJtM7MvFJ7r2q92NkE5xgOKW9b1kTJFpSl6jc9rdIO+
         Hjazt4Hj2BXe/2Dd2UkXmFhI3q/GjKJi08y8BVaW/XjU9z6HarIsK+GAAiOFeu8dFFRA
         s36JUwIhG7JU3SSB2uz9XOIdsl+cuuGL/KxKkQ/GMSZGQ3Xnv+M2Wb/fPm05WawkC//U
         IjAsm4bOnD7F38V2bKYW+QmP3/eQ8vxkEPodlRtwILVjFs9DBipSps9T/N6Lq5PobN0w
         AbeZJvtAkjziXHE0fUyEMr+9yRTelb+H5O9SieoOYSehvV8lHTkz2OX+yTBk4+9APaLc
         +4Fg==
X-Gm-Message-State: AC+VfDwLz8wlbkf0UrdnkTAjzMjFV6Yp3QIOV/klzk00C9cwD21i7FVC
        ufOsQYlOwMKOxQDAtj1wws3l5YSEhUWTmQoymRwhEg==
X-Google-Smtp-Source: ACHHUZ6VSzU+28jYfHnh9y19cPzK91DF4XYimogK8gfXPdG66/VYDFjMtNdF9daKFihp7vh32DX1VfValI2Pu7/TNrw=
X-Received: by 2002:a17:902:e849:b0:1b1:d1fe:e73 with SMTP id
 t9-20020a170902e84900b001b1d1fe0e73mr229259plg.8.1686562514065; Mon, 12 Jun
 2023 02:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230609131355.71130-1-jordyzomer@google.com> <20230609131355.71130-2-jordyzomer@google.com>
 <ZITKoBzJq+Y5Hi9Z@equinox>
In-Reply-To: <ZITKoBzJq+Y5Hi9Z@equinox>
From:   Jordy Zomer <jordyzomer@google.com>
Date:   Mon, 12 Jun 2023 11:35:03 +0200
Message-ID: <CABjM8Zf_xSNirWzMFVi816CuZAdRT-9edOpX0j526fQXNUm7xg@mail.gmail.com>
Subject: Re: [PATCH 1/1] cdrom: Fix spectre-v1 gadget
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com,
        linux-block@vger.kernel.org
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

Thanks both! I assumed array_index_mask_nospec was the same as
array_index_nospec. I'll send a V2 your way soon :)


On Sat, Jun 10, 2023 at 9:10=E2=80=AFPM Phillip Potter <phil@philpotter.co.=
uk> wrote:
>
> On Fri, Jun 09, 2023 at 01:13:55PM +0000, Jordy Zomer wrote:
> > This patch fixes a spectre-v1 gadget in cdrom.
> > The gadget could be triggered by,
> >  speculatviely bypassing the cdi->capacity check.
> >
> > Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> > ---
> >  drivers/cdrom/cdrom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 416f723a2dbb..3c349bc0a269 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -233,6 +233,7 @@
> >
> >  ----------------------------------------------------------------------=
---*/
> >
> > +#include "asm/barrier.h"
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> >  #define REVISION "Revision: 3.20"
> > @@ -2329,6 +2330,8 @@ static int cdrom_ioctl_media_changed(struct cdrom=
_device_info *cdi,
> >       if (arg >=3D cdi->capacity)
> >               return -EINVAL;
> >
> > +     arg =3D array_index_mask_nospec(arg, cdi->capacity);
> > +
> >       info =3D kmalloc(sizeof(*info), GFP_KERNEL);
> >       if (!info)
> >               return -ENOMEM;
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
>
> Hi Jordy,
>
> Thanks for the patch, much appreciated. Sadly, as Pawan has already
> pointed out, array_index_mask_nospec actually changes the behaviour of
> this function, such that 'arg' would no longer be an array index.
>
> In addition, it seems to have triggered the kernel test robot with an
> alpha build error.
>
> Regards,
> Phil

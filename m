Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D856CF880
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC3BKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC3BKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:10:49 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FB05B92
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:10:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-53d277c1834so326698797b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trHb4ZOG7XU5ZjiWJc1P83x2prz9WeqvxotCOi1K6Ow=;
        b=DS/uhgZThWHoOTi9eBksq5fEsaIGz7ngHca8dbA8p8bF7mQD8TH7k9rtmQR8pc9/kw
         5csXEDiz0NNIXY4cG7rj4I9hXaTbcEkzCKr0l6Lk57uogUjfT5DFjLOvT8J93GlHkU9F
         QqRveaP0eHdQ3h234e/3IDC0YpBf09gnLVp1WVFmVjYkdh5djkRH7Fk8FW/kAvel6Eh4
         uWKfYMvJ0E7cv9W3N8nWb3MT3Wbml+pU0ZZVzREjvQpTfHgMf9nUy8YAgJ35Tg/n7B9m
         Fq2RsVdlSubBCk3ntpmHELGXrkhlGRz8gsUiPD9WQUDIxl18CKGmABMgjVoLYiv8o8VW
         rjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trHb4ZOG7XU5ZjiWJc1P83x2prz9WeqvxotCOi1K6Ow=;
        b=0KRD5j1bXxR3dBWgxU014uvPnYOVTElPmQ4NYquxN9FBsxXO/ocfmHdu/8qC7rIcBb
         kzk4v4OdVmWCQ+Q8dfDosTfnabxSqUuqY+QWxadGcIMYAbObeYOMdkr/m0zw/PF0G/T8
         dVAAntGqepSv43Sx2WR5Rox20j+yPVOqPt48njoXJiBa+kXJuwPa2KkWocuwVV/UbVzA
         4j1yA6JR6m39WGv8dFPK9QVE05u09RIfRwKJ2DQzSy+aEc85Xw9RLTwHjA+w4+p/HApo
         PGZoKJTfLqu639sV6BEs7M2gSFvi9/zPJp7QjUZXF6/D3bGoLjxb6jvdi/P6wH1i20zI
         vzZQ==
X-Gm-Message-State: AAQBX9ewkTVhU6JsGldObjKXMYx57czvjyVh9NKNNhudvj+eZodlN1fQ
        jIpXR149RBq384aPFZIDRa30qRiEIkEdcbyEv+kf
X-Google-Smtp-Source: AKy350YFd9HgM1JadFaOcawRIMLYxQxdwNgPA5DDSFpKyb0PXktJ6Z52BAMcyyw/1+BhkBiBeS99qbIG3x1DxfMmdA0=
X-Received: by 2002:a81:c406:0:b0:546:8e4:703f with SMTP id
 j6-20020a81c406000000b0054608e4703fmr4919710ywi.8.1680138641366; Wed, 29 Mar
 2023 18:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-3-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-3-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:10:30 -0400
Message-ID: <CAHC9VhT3PpgTzUdGEdn4Jg8=91PFzto5w+9ZnQRJgxnTCc9hMg@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] LSM: Maintain a table of LSM attribute data
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 6:47=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> As LSMs are registered add their lsm_id pointers to a table.
> This will be used later for attribute reporting.
>
> Determine the number of possible security modules based on
> their respective CONFIG options. This allows the number to be
> known at build time. This allows data structures and tables
> to use the constant.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  2 ++
>  security/security.c      | 44 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 38 insertions(+), 8 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 58828a326024..aa84b1cf4253 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -513,6 +531,16 @@ void __init security_add_hooks(struct security_hook_=
list *hooks, int count,
>  {
>         int i;
>
> +       /*
> +        * A security module may call security_add_hooks() more
> +        * than once. Landlock is one such case.
> +        */
> +       if (lsm_active_cnt =3D=3D 0 || lsm_idlist[lsm_active_cnt - 1] !=
=3D lsmid)
> +               lsm_idlist[lsm_active_cnt++] =3D lsmid;
> +
> +       if (lsm_active_cnt > LSM_COUNT)
> +               panic("%s Too many LSMs registered.\n", __func__);

In addition to the fixes needed to resolve the bug identified by the
kernel test robot, I think it might be wise to do the @lsm_active_cnt
check *before* potentially adding it to the @lsm_idlist array.

>         for (i =3D 0; i < count; i++) {
>                 hooks[i].lsmid =3D lsmid;
>                 hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> --
> 2.39.2

--
paul-moore.com

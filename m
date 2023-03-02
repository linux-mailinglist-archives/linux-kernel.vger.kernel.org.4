Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D316A7979
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCBC0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCBC0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:26:07 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3CA38031
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:26:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso1355222pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 18:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677723964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kZhp2tKo46U38ss1g+Tr12yiIRs24hB+InVptDfZko=;
        b=Ngt4aMkBbFynugEGmeXivW0MGt97hNWmyZvta0AYdKJoKEmYux9Ut6I76AzioRRbt+
         v8xMEfjMJkSCPgeTdcTOVp1kWGQmHh9VQDm36VGwe2ay4U/TzI965QBf72fZPFg4yxna
         X9oiACKEmVj9+ch9Pbs63eYNwqns0E27JpTfH1iHXNI7wuDQemukVyzTXSQ8IysosiNq
         R++5bGICu/67hZOMwjIYDFRbyBGkimzxhkfA/lLptKR4VxvNkO6hpIeNWI+z1lGOzJCI
         3oivxaOHEFkmBC4zSi7X2HuGuyoERx3ojw/aL96huRmuJHPWBr3tdKpG5iQwrpUsassW
         5ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677723964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kZhp2tKo46U38ss1g+Tr12yiIRs24hB+InVptDfZko=;
        b=xduEVucuztJqsDcgHbvQLROP8NJm3zBRBtl1f4GD+lmtQ+CWDCiXom3M8va24Cj99i
         deM3snBXVxSXavJRoI2xQTt0azxtB6KJmWKzsyaJV/u7/0prEoEUHtQ6NmQDDyhLkv6N
         db/vHdx279gZvMCQyPX1zOZOAzMNHeDFfBLkbP/L0JwJ8xAnW5mTBz53Ybh3MCXy3v2Q
         G8qoaARAh1mEhNUQ1ld6g1SP76NhMatI5uC5JYFyFPpWfayFM+blY7EhNVSaGaL7T/Jz
         iVvF8Z7rwJFtp8DBc5o9lw+DLRqRNWt1cH7nZuunOZsUCkIwPiIAC1EPkSTKt0zY8MhD
         yR2A==
X-Gm-Message-State: AO0yUKUNawjh0luydM5mouJHzrIN3tXh404rcJMceEXVc4xzwJwFZKOv
        MjsuIATZMAM8ZwmBg9H1mjFukgpswAdY9zkn306x
X-Google-Smtp-Source: AK7set9WUw3+7nNvCV3Bh3Gll8iuNqsjHAmQe9Tu1euD/45Z6kjZ9of1ysLgcadbAHHlepgnWkqpZweQJ53NX5QDgk0=
X-Received: by 2002:a17:903:2587:b0:19a:80b9:78ce with SMTP id
 jb7-20020a170903258700b0019a80b978cemr250097plb.0.1677723963655; Wed, 01 Mar
 2023 18:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20230301113415.47664-1-michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <20230301113415.47664-1-michael.weiss@aisec.fraunhofer.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Mar 2023 21:25:52 -0500
Message-ID: <CAHC9VhQ_zvTqck4A7HvqH2rcwxuato_9nVWMk_Yf=ip3q9omgA@mail.gmail.com>
Subject: Re: [PATCH] dm verity: log audit events for dm-verity target
To:     =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        gyroidos@aisec.fraunhofer.de, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        "maintainer:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AUDIT SUBSYSTEM" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 6:34=E2=80=AFAM Michael Wei=C3=9F
<michael.weiss@aisec.fraunhofer.de> wrote:
>
> dm-verity signals integrity violations by returning I/O errors
> to user space. To identify integrity violations by a controlling
> instance, the kernel audit subsystem can be used to emit audit
> events to user space. Analogous to dm-integrity, we also use the
> dm-audit submodule allowing to emit audit events on verification
> failures of metadata and data blocks as well as if max corrupted
> errors are reached.
>
> The construction and destruction of verity device mappings are
> also relevant for auditing a system. Thus, those events are also
> logged as audit events.
>
> We tested this by starting a container with the container manager
> (cmld) of GyroidOS which uses a dm-verity protected rootfs image
> root.img mapped to /dev/mapper/<uuid>-root. We than manipulated
> one block in the underlying image file and reading it from the
> protected mapper device again and again until we reach the max
> corrupted errors like this:
>
>   dd if=3D/dev/urandom of=3Droot.img bs=3D512 count=3D1 seek=3D1000
>   for i in range {1..101}; do \
>     dd if=3D/dev/mapper/<uuid>-root of=3D/dev/null bs=3D4096 \
>        count=3D1 skip=3D1000 \
>   done
>
> The resulting audit log looks as follows:
>
>   type=3DDM_CTRL msg=3Daudit(1677618791.876:962):
>     module=3Dverity op=3Dctr ppid=3D4876 pid=3D29102 auid=3D0 uid=3D0 gid=
=3D0
>     euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) =
ses=3D44
>     comm=3D"cmld" exe=3D"/usr/sbin/cml/cmld" subj=3Dunconfined
>     dev=3D254:3 error_msg=3D'success' res=3D1
>
>   type=3DDM_EVENT msg=3Daudit(1677619463.786:1074): module=3Dverity
>     op=3Dverify-data dev=3D7:0 sector=3D1000 res=3D0
>   ...
>   type=3DDM_EVENT msg=3Daudit(1677619596.727:1162): module=3Dverity
>     op=3Dverify-data dev=3D7:0 sector=3D1000 res=3D0
>
>   type=3DDM_EVENT msg=3Daudit(1677619596.731:1163): module=3Dverity
>     op=3Dmax-corrupted-errors dev=3D254:3 sector=3D? res=3D0
>
> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> ---
>  drivers/md/dm-verity-target.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

This looks reasonable to me from an audit perspective.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.=
c
> index ade83ef3b439..8beeb4ea66d1 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -16,6 +16,7 @@
>  #include "dm-verity.h"
>  #include "dm-verity-fec.h"
>  #include "dm-verity-verify-sig.h"
> +#include "dm-audit.h"
>  #include <linux/module.h>
>  #include <linux/reboot.h>
>  #include <linux/scatterlist.h>
> @@ -248,8 +249,10 @@ static int verity_handle_err(struct dm_verity *v, en=
um verity_block_type type,
>         DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
>                     type_str, block);
>
> -       if (v->corrupted_errs =3D=3D DM_VERITY_MAX_CORRUPTED_ERRS)
> +       if (v->corrupted_errs =3D=3D DM_VERITY_MAX_CORRUPTED_ERRS) {
>                 DMERR("%s: reached maximum errors", v->data_dev->name);
> +               dm_audit_log_target(DM_MSG_PREFIX, "max-corrupted-errors"=
, v->ti, 0);
> +       }
>
>         snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=3D%d,%llu",
>                 DM_VERITY_ENV_VAR_NAME, type, block);
> @@ -340,6 +343,11 @@ static int verity_verify_level(struct dm_verity *v, =
struct dm_verity_io *io,
>                 else if (verity_handle_err(v,
>                                            DM_VERITY_BLOCK_TYPE_METADATA,
>                                            hash_block)) {
> +                       struct bio *bio =3D
> +                               dm_bio_from_per_bio_data(io,
> +                                                        v->ti->per_io_da=
ta_size);
> +                       dm_audit_log_bio(DM_MSG_PREFIX, "verify-metadata"=
, bio,
> +                                        block, 0);
>                         r =3D -EIO;
>                         goto release_ret_r;
>                 }
> @@ -590,8 +598,11 @@ static int verity_verify_io(struct dm_verity_io *io)
>                                 return -EIO;
>                         }
>                         if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DAT=
A,
> -                                             cur_block))
> +                                             cur_block)) {
> +                               dm_audit_log_bio(DM_MSG_PREFIX, "verify-d=
ata",
> +                                                bio, cur_block, 0);
>                                 return -EIO;
> +                       }
>                 }
>         }
>
> @@ -975,6 +986,8 @@ static void verity_dtr(struct dm_target *ti)
>                 static_branch_dec(&use_tasklet_enabled);
>
>         kfree(v);
> +
> +       dm_audit_log_dtr(DM_MSG_PREFIX, ti, 1);
>  }
>
>  static int verity_alloc_most_once(struct dm_verity *v)
> @@ -1429,11 +1442,14 @@ static int verity_ctr(struct dm_target *ti, unsig=
ned int argc, char **argv)
>
>         verity_verify_sig_opts_cleanup(&verify_args);
>
> +       dm_audit_log_ctr(DM_MSG_PREFIX, ti, 1);
> +
>         return 0;
>
>  bad:
>
>         verity_verify_sig_opts_cleanup(&verify_args);
> +       dm_audit_log_ctr(DM_MSG_PREFIX, ti, 0);
>         verity_dtr(ti);
>
>         return r;
> --
> 2.30.2

--=20
paul-moore.com

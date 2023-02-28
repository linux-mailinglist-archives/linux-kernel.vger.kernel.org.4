Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489266A5629
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjB1JxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjB1JxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:53:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2CFF23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:53:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy6so37413489edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112; t=1677577986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCPDxUFfY0WOQaiU03i9rlfBh+ujxxsXqzEK39bk5JY=;
        b=2JxBz1uvQxFsj0bkyum1nBfcCzQcKvlSCIkPta9g4KCeCk7XG9wyxpf4/RgyRue5rd
         NFeUnDYrYIZlkugUA/6UUWO/oFHDdgnseQhXt15Go0HCdguUIcEqVI1MfYP1zYpALXv4
         V9BV8ivtmopGgOMA4k9GVhurib4iUY4oMWTN7fJ2GngZnvA0c4uAL+ooxa9arG7gK3aw
         oF0U5eGTQ/MkFhZiJ0KOGTifu1Pkbq9hob+9Uqdfn+zJkLexMpug+7jloK7raI0a+lGb
         eiiMQKIOl/qQZrB79rRFv5+OoPJ5VkSGYz9k2DWblQsOWO3OU428kZUcnQA74VLrUCub
         YYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677577986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCPDxUFfY0WOQaiU03i9rlfBh+ujxxsXqzEK39bk5JY=;
        b=RK6NdU0dVF3ojDAM+mWwolnNgDG1WQfehb8K898jeyxkdhJ2BSnuNfhNI9h0DnXgl8
         pt2nV4egA3B/NAWZnPSUB1ziSpB9cghYr5rgp7ke/xP2CoOguP3SIsEESOaKhRpljMP2
         lzuKq4GRZj78E6t7h49A7taKZReuX1WFRD0ySV2btIrWBTsdSKZghQAkfZJqDZoGwhwQ
         iJSYWgLVkmcgaqxLFapd0sm24WUZNxWVFK0Do+V11jq83j6lR8kjHf62+UCPmtZwQEhn
         Kz/6MXtMZQaA86qWFMWyOhCGEXbM6sgRTBxVENWsxwga0IyihLaDNB/ugrKL5X8YHhFA
         DaaQ==
X-Gm-Message-State: AO0yUKUOkR1JxFGpvcmFXaRxeQfR5YLnIKuCz2YSTLdd29B1OWBUznwX
        Vg4vS0piWrVAsIf/RA5ez2lSe/kq+F273bNLomBGsDDzlBimNrwxn58=
X-Google-Smtp-Source: AK7set+Vrv7QhEB4E6E3JuEK3Bp36lmD000k/cNjNQgecZ2uEAvEV5PvR+sQph8Qo2LYdM0NnREbXaCpY3PQpmOjRUk=
X-Received: by 2002:a17:906:6993:b0:8ae:1078:722f with SMTP id
 i19-20020a170906699300b008ae1078722fmr880177ejr.9.1677577986536; Tue, 28 Feb
 2023 01:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20230224200502.391570-1-nmi@metaspace.dk>
In-Reply-To: <20230224200502.391570-1-nmi@metaspace.dk>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 28 Feb 2023 10:52:55 +0100
Message-ID: <CANr-nt3oe0LBycFbAQCN_-ehBxnSUw3jyv590sDe8GM6wn0fGg@mail.gmail.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 9:06=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> Add zoned storage support to ublk: report_zones and operations:
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET

Reset all is missing, right? Might as well define that before there are
users of the ublk<->ublksrv interface.

>
> This allows implementation of zoned storage devices in user space. An
> example user space implementation based on ubdsrv is available [1].
>
> [1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d92e=
680dc718cc1f6d
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
> Changes since v1:
>  - Fixed conditional compilation bug
>  - Refactored to collect conditional code additions together
>  - Fixed style errors
>  - Zero stack allocated value used for zone report
>
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302250222.XOrw9j6z-lkp@int=
el.com/
> v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metas=
pace.dk/
>
>  drivers/block/ublk_drv.c      | 150 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  18 ++++
>  2 files changed, 162 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6368b56eacf1..37e516903867 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -20,6 +20,7 @@
>  #include <linux/major.h>
>  #include <linux/wait.h>
>  #include <linux/blkdev.h>
> +#include <linux/blkzoned.h>
>  #include <linux/init.h>
>  #include <linux/swap.h>
>  #include <linux/slab.h>
> @@ -51,10 +52,12 @@
>                 | UBLK_F_URING_CMD_COMP_IN_TASK \
>                 | UBLK_F_NEED_GET_DATA \
>                 | UBLK_F_USER_RECOVERY \
> -               | UBLK_F_USER_RECOVERY_REISSUE)
> +               | UBLK_F_USER_RECOVERY_REISSUE \
> +               | UBLK_F_ZONED)
>
>  /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DIS=
CARD)
> +#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DIS=
CARD \
> +                            | UBLK_PARAM_TYPE_ZONED)
>
>  struct ublk_rq_data {
>         struct llist_node node;
> @@ -187,6 +190,98 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
>
>  static struct miscdevice ublk_misc;
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void ublk_set_nr_zones(struct ublk_device *ub)
> +{
> +       const struct ublk_param_basic *p =3D &ub->params.basic;
> +
> +       if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
> +               ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_secto=
rs;
> +}
> +
> +static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> +       const struct ublk_param_zoned *p =3D &ub->params.zoned;
> +
> +       if (ub->dev_info.flags & UBLK_F_ZONED) {
> +               disk_set_max_active_zones(ub->ub_disk, p->max_active_zone=
s);
> +               disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> +       }
> +}
> +
> +static int ublk_revalidate_disk_zones(struct gendisk *disk)
> +{
> +       return blk_revalidate_disk_zones(disk, NULL);
> +}
> +
> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +                            unsigned int nr_zones, report_zones_cb cb,
> +                            void *data)
> +{
> +       struct ublk_device *ub;
> +       unsigned int zone_size;
> +       unsigned int first_zone;
> +       int ret =3D 0;
> +
> +       ub =3D disk->private_data;
> +
> +       if (!(ub->dev_info.flags & UBLK_F_ZONED))
> +               return -EINVAL;
> +
> +       zone_size =3D disk->queue->limits.chunk_sectors;
> +       first_zone =3D sector >> ilog2(zone_size);
> +       nr_zones =3D min(ub->ub_disk->nr_zones - first_zone, nr_zones);
> +
> +       for (unsigned int i =3D 0; i < nr_zones; i++) {
> +               struct request *req;
> +               blk_status_t status;
> +               struct blk_zone info =3D {0};
> +
> +               req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, =
0);
> +
> +               if (IS_ERR(req)) {
> +                       ret =3D PTR_ERR(req);
> +                       goto out;
> +               }
> +
> +               req->__sector =3D sector;
> +
> +               ret =3D blk_rq_map_kern(disk->queue, req, &info, sizeof(i=
nfo),
> +                                     GFP_KERNEL);
> +
> +               if (ret)
> +                       goto out;
> +
> +               status =3D blk_execute_rq(req, 0);

Pingponging with userspace to retrieve thousand(s) of zone states is
very inefficient, so I don't think we
want to define the report zone ublk uapi to be one-zone-per-call.

Also, just overloading REQ_OP_DRV_IN with report zones instead of
defining a zone-report specific call does
not seem future proof - there might be a need to do other
driver-specific calls in the future.

Virtio blk implements reporting in a better way - se
virtblk_report_zones (that just got merged in Linus tree)
The same type of interface should be possible for ublk.

Cheers,
Hans

> +               ret =3D blk_status_to_errno(status);
> +               if (ret)
> +                       goto out;
> +
> +               blk_mq_free_request(req);
> +
> +               ret =3D cb(&info, i, data);
> +               if (ret)
> +                       goto out;
> +
> +               /* A zero length zone means don't ask for more zones */
> +               if (!info.len) {
> +                       nr_zones =3D i;
> +                       break;
> +               }
> +
> +               sector +=3D zone_size;
> +       }
> +       ret =3D nr_zones;
> +
> + out:
> +       return ret;
> +}
> +#else
> +void ublk_set_nr_zones(struct ublk_device *ub);
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> +int ublk_revalidate_disk_zones(struct gendisk *disk);
> +#endif
> +
>  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  {
>         struct request_queue *q =3D ub->ub_disk->queue;
> @@ -212,6 +307,9 @@ static void ublk_dev_param_basic_apply(struct ublk_de=
vice *ub)
>                 set_disk_ro(ub->ub_disk, true);
>
>         set_capacity(ub->ub_disk, p->dev_sectors);
> +
> +       if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +               ublk_set_nr_zones(ub);
>  }
>
>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> @@ -268,6 +366,9 @@ static int ublk_apply_params(struct ublk_device *ub)
>         if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>                 ublk_dev_param_discard_apply(ub);
>
> +       if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_=
PARAM_TYPE_ZONED))
> +               ublk_dev_param_zoned_apply(ub);
> +
>         return 0;
>  }
>
> @@ -361,9 +462,13 @@ static void ublk_free_disk(struct gendisk *disk)
>         put_device(&ub->cdev_dev);
>  }
>
> +
>  static const struct block_device_operations ub_fops =3D {
> -       .owner =3D        THIS_MODULE,
> -       .free_disk =3D    ublk_free_disk,
> +       .owner =3D THIS_MODULE,
> +       .free_disk =3D ublk_free_disk,
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       .report_zones =3D ublk_report_zones,
> +#endif
>  };
>
>  #define UBLK_MAX_PIN_PAGES     32
> @@ -499,7 +604,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq=
,
>  {
>         const unsigned int rq_bytes =3D blk_rq_bytes(req);
>
> -       if (req_op(req) =3D=3D REQ_OP_READ && ublk_rq_has_data(req)) {
> +       if ((req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_=
DRV_IN) && ublk_rq_has_data(req)) {
>                 struct ublk_map_data data =3D {
>                         .ubq    =3D       ubq,
>                         .rq     =3D       req,
> @@ -566,6 +671,26 @@ static blk_status_t ublk_setup_iod(struct ublk_queue=
 *ubq, struct request *req)
>         case REQ_OP_WRITE_ZEROES:
>                 ublk_op =3D UBLK_IO_OP_WRITE_ZEROES;
>                 break;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       case REQ_OP_ZONE_OPEN:
> +               ublk_op =3D UBLK_IO_OP_ZONE_OPEN;
> +               break;
> +       case REQ_OP_ZONE_CLOSE:
> +               ublk_op =3D UBLK_IO_OP_ZONE_CLOSE;
> +               break;
> +       case REQ_OP_ZONE_FINISH:
> +               ublk_op =3D UBLK_IO_OP_ZONE_FINISH;
> +               break;
> +       case REQ_OP_ZONE_RESET:
> +               ublk_op =3D UBLK_IO_OP_ZONE_RESET;
> +               break;
> +       case REQ_OP_DRV_IN:
> +               ublk_op =3D UBLK_IO_OP_DRV_IN;
> +               break;
> +       case REQ_OP_ZONE_APPEND:
> +               /* We do not support zone append yet */
> +               fallthrough;
> +#endif
>         default:
>                 return BLK_STS_IOERR;
>         }
> @@ -612,7 +737,8 @@ static void ublk_complete_rq(struct request *req)
>          *
>          * Both the two needn't unmap.
>          */
> -       if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE=
) {
> +       if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE=
 &&
> +           req_op(req) !=3D REQ_OP_DRV_IN) {
>                 blk_mq_end_request(req, BLK_STS_OK);
>                 return;
>         }
> @@ -1535,6 +1661,15 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd=
 *cmd)
>         if (ret)
>                 goto out_put_disk;
>
> +       if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +           ub->dev_info.flags & UBLK_F_ZONED) {
> +               disk_set_zoned(disk, BLK_ZONED_HM);
> +               blk_queue_required_elevator_features(disk->queue, ELEVATO=
R_F_ZBD_SEQ_WRITE);
> +               ret =3D ublk_revalidate_disk_zones(disk);
> +               if (ret)
> +                       goto out_put_disk;
> +       }
> +
>         get_device(&ub->cdev_dev);
>         ret =3D add_disk(disk);
>         if (ret) {
> @@ -1673,6 +1808,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *c=
md)
>         if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
>                 ub->dev_info.flags |=3D UBLK_F_URING_CMD_COMP_IN_TASK;
>
> +       if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +               ub->dev_info.flags &=3D ~UBLK_F_ZONED;
> +
>         /* We are not ready to support zero copy */
>         ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
>
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 8f88e3a29998..074b97821575 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -78,6 +78,10 @@
>  #define UBLK_F_USER_RECOVERY   (1UL << 3)
>
>  #define UBLK_F_USER_RECOVERY_REISSUE   (1UL << 4)
> +/*
> + * Enable zoned device support
> + */
> +#define UBLK_F_ZONED (1ULL << 5)
>
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
> @@ -129,6 +133,12 @@ struct ublksrv_ctrl_dev_info {
>  #define                UBLK_IO_OP_DISCARD      3
>  #define                UBLK_IO_OP_WRITE_SAME   4
>  #define                UBLK_IO_OP_WRITE_ZEROES 5
> +#define                UBLK_IO_OP_ZONE_OPEN            10
> +#define                UBLK_IO_OP_ZONE_CLOSE           11
> +#define                UBLK_IO_OP_ZONE_FINISH          12
> +#define                UBLK_IO_OP_ZONE_APPEND          13
> +#define                UBLK_IO_OP_ZONE_RESET           15
> +#define                UBLK_IO_OP_DRV_IN               34
>
>  #define                UBLK_IO_F_FAILFAST_DEV          (1U << 8)
>  #define                UBLK_IO_F_FAILFAST_TRANSPORT    (1U << 9)
> @@ -214,6 +224,12 @@ struct ublk_param_discard {
>         __u16   reserved0;
>  };
>
> +struct ublk_param_zoned {
> +       __u64   max_open_zones;
> +       __u64   max_active_zones;
> +       __u64   max_append_size;
> +};
> +
>  struct ublk_params {
>         /*
>          * Total length of parameters, userspace has to set 'len' for bot=
h
> @@ -224,10 +240,12 @@ struct ublk_params {
>         __u32   len;
>  #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
>  #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
> +#define UBLK_PARAM_TYPE_ZONED           (1 << 2)
>         __u32   types;                  /* types of parameter included */
>
>         struct ublk_param_basic         basic;
>         struct ublk_param_discard       discard;
> +       struct ublk_param_zoned         zoned;
>  };
>
>  #endif
>
> base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
> --
> 2.39.2
>

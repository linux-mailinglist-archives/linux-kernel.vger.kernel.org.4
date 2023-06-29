Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77963742303
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF2JOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjF2JO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:14:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396701FD8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:14:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso536876a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688030062; x=1690622062;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlzZ1d2/ORYP6oELjqeVaw3L6f3qL4E3exq1P6nXQ4Y=;
        b=f51H0e4WnUL+0G/JvKX4bYk7GF9oHr4kElYMQfASC+6mzkQv4STqpKXQVheRY4pWKn
         3Nwvo4aWt3VFWB0QRz3YOyN3882Mb5+ZNadDkL8a7eLjx+5ncCkocr2cHGVl2rUArQkM
         S7AZ5XTAhyTXeQbScIC89txcoe8dmUtc8VbBqBmwQmNHPz7x6GdahsW5GI3JBndjPsub
         dqsQDiC6hyvMRzrYoDD/2DyZouUZYWQyUo8Ys2hjif1EKd152T2PvG6we54hpHsSOh0P
         AGPNRjawCopT+dNyIodbeCx9I2XSLlIN5Lvvdktvs1DtH3k7QeyoS2akRqfm9/gPQKHy
         aHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030062; x=1690622062;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DlzZ1d2/ORYP6oELjqeVaw3L6f3qL4E3exq1P6nXQ4Y=;
        b=PPyb8+s72DT1+eikYX4+ZpVVD+mHY89yRm1t3SdS4etde1SuQ3E0BcIHZeC7au5v8u
         gGArauRYi7l6kGtVJeXWeUQ4+AVsLyaI3mcRB3oaVUCEbjlI52FZXyRMN+nqh/1S+UFr
         70ymFL12oYSFgvn32ZIPewYHZ1LppcwZqlkJu6tkAj/5D5+O7HUZtT50op+idOs6OfUc
         0hq6qiou6i2fObIBIrxnK+BXhwaJTEP/uBUUGO/OGGucElZfRhWkrubpB/4fn0KyZ1QD
         McR1b0XuNPjwOI8Hl8N35hyiGcquxFKUjiufO+dzDZaepMJdnkXBbtMMLSUHoLXGLXE9
         +jZA==
X-Gm-Message-State: AC+VfDwollVWsS1fjbVXrJknHUPL7jGniv1g2PGdI6iBe3xSMtbkBXrO
        5yZgCnkBqdVRiSmbwsXbnwMnyg==
X-Google-Smtp-Source: ACHHUZ7kftnMYz+Nq46s2BIp8BFyHSySvFCiv6/NuXbM8BEVAPomaGvHnoqQhGZ75MitAA7pW7eBFA==
X-Received: by 2002:a05:6402:1389:b0:51a:441f:75d7 with SMTP id b9-20020a056402138900b0051a441f75d7mr23853109edv.6.1688030062122;
        Thu, 29 Jun 2023 02:14:22 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id b16-20020aa7c6d0000000b0051d7f4f32d6sm5465499eds.96.2023.06.29.02.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:14:21 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
 <be52be54-3178-082c-4bfc-7702308a0012@kernel.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Date:   Thu, 29 Jun 2023 09:50:17 +0200
In-reply-to: <be52be54-3178-082c-4bfc-7702308a0012@kernel.org>
Message-ID: <87ilb6y6j9.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 6/29/23 04:06, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> Add zoned storage support to ublk: report_zones and operations:
>>  - REQ_OP_ZONE_OPEN
>>  - REQ_OP_ZONE_CLOSE
>>  - REQ_OP_ZONE_FINISH
>>  - REQ_OP_ZONE_RESET
>>=20
>> Note: This commit changes the ublk kernel module name from `ublk_drv.ko`=
 to
>> `ublk.ko` in order to link multiple translation units into the module.
>
> You probably could rename ublk_drv.c to ublk.c to avoid that and keep the=
 module
> name as it was, ublk_drv.ko.

OK, will change.

>
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  MAINTAINERS                    |   1 +
>>  drivers/block/Kconfig          |   4 +
>>  drivers/block/Makefile         |   4 +-
>>  drivers/block/ublk_drv-zoned.c | 144 +++++++++++++++++++++++++++++++++
>>  drivers/block/ublk_drv.c       |  64 +++++++++++++--
>>  drivers/block/ublk_drv.h       |  15 ++++
>>  include/uapi/linux/ublk_cmd.h  |  14 ++++
>>  7 files changed, 239 insertions(+), 7 deletions(-)
>>  create mode 100644 drivers/block/ublk_drv-zoned.c
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ace71c90751c..db8a8deb5926 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21555,6 +21555,7 @@ S:	Maintained
>>  F:	Documentation/block/ublk.rst
>>  F:	drivers/block/ublk_drv.c
>>  F:	drivers/block/ublk_drv.h
>> +F:	drivers/block/ublk_drv-zoned.c
>>  F:	include/uapi/linux/ublk_cmd.h
>>=20=20
>>  UCLINUX (M68KNOMMU AND COLDFIRE)
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index 5b9d4aaebb81..c58dfd035557 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -402,6 +402,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>>  	  suggested to enable N if your application(ublk server) switches to
>>  	  ioctl command encoding.
>>=20=20
>> +config BLK_DEV_UBLK_ZONED
>> +	def_bool y
>
> This can be "bool" only.

I did it like this because I wanted BLK_DEV_UBLK_ZONED to be set
automatically to "y" when BLK_DEV_UBLK and BLK_DEV_ZONED are enabled.
BLK_DEV_UBLK_ZONED has no menu entry. If we change it to "bool" it will
be default "n" and we would have to make it appear in menuconfig to be
manually enabled.

Isn't it more sane if it is just unconditionally enabled when
BLK_DEV_ZONED and BLK_DEV_UBLK is enabled?

>
>> +	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
>> +
>>  source "drivers/block/rnbd/Kconfig"
>>=20=20
>>  endif # BLK_DEV
>> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
>> index 101612cba303..bc1649e20ec2 100644
>> --- a/drivers/block/Makefile
>> +++ b/drivers/block/Makefile
>> @@ -37,6 +37,8 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+=3D rnbd/
>>=20=20
>>  obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk/
>>=20=20
>> -obj-$(CONFIG_BLK_DEV_UBLK)			+=3D ublk_drv.o
>> +obj-$(CONFIG_BLK_DEV_UBLK)		+=3D ublk.o
>> +ublk-$(CONFIG_BLK_DEV_UBLK)		+=3D ublk_drv.o
>> +ublk-$(CONFIG_BLK_DEV_UBLK_ZONED)	+=3D ublk_drv-zoned.o
>>=20=20
>>  swim_mod-y	:=3D swim.o swim_asm.o
>> diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zon=
ed.c
>> new file mode 100644
>> index 000000000000..ea86bf4b3681
>> --- /dev/null
>> +++ b/drivers/block/ublk_drv-zoned.c
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
>> + */
>> +#include <linux/blkzoned.h>
>> +#include <linux/ublk_cmd.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "ublk_drv.h"
>> +
>> +void ublk_set_nr_zones(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_basic *p =3D &ub->params.basic;
>> +
>> +	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
>
> If UBLK_F_ZONED is set but chunk_sectors is not, that is a bug on the user
> driver side, no ? So an error message about that would be nice instead of
> silently ignoring the zoned flag.

Yes, I'll add a check to `ublk_validate_params()`.

>
>> +		ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_sectors;
>> +}
>> +
>> +void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +
>> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
>> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>
> You do not need to check if the max_active_zones and max_open_zones value=
s are
> sensible ? E.g. what if they are larger than the number of zones ?

I don't think it will be a problem. I assume you can set them to 0 to
indicate infinite. If user space sets them to more than the actual
number of available zones (that user space set up also), user space will
have to handle that when it gets a zone request for a zone outside the
logical drive LBA space. I don't think the kernel has to care. Will this
break anything kernel side?

>
>> +	}
>> +}
>> +
>> +int ublk_revalidate_disk_zones(struct gendisk *disk)
>> +{
>> +	return blk_revalidate_disk_zones(disk, NULL);
>> +}
>
> I do not think this helper is needed at all (see below comment on the cal=
l site).

This is required because the prototype for `blk_revalidate_disk_zones()`
is not defined when BLK_DEV_ZONED is not defined. Without this helper
for which the prototype is always defined, we will have a compile error
at the call site.

>
>> +
>> +/* Based on virtblk_alloc_report_buffer */
>> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
>> +				      unsigned int nr_zones,
>> +				      unsigned int zone_sectors, size_t *buflen)
>> +{
>> +	struct request_queue *q =3D ublk->ub_disk->queue;
>> +	size_t bufsize;
>> +	void *buf;
>> +
>> +	nr_zones =3D min_t(unsigned int, nr_zones,
>> +			 get_capacity(ublk->ub_disk) >> ilog2(zone_sectors));
>> +
>> +	bufsize =3D nr_zones * sizeof(struct blk_zone);
>> +	bufsize =3D
>> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
>> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT=
);
>> +
>> +	while (bufsize >=3D sizeof(struct blk_zone)) {
>> +		buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>> +		if (buf) {
>> +			*buflen =3D bufsize;
>> +			return buf;
>> +		}
>> +		bufsize >>=3D 1;
>> +	}
>> +
>> +	bufsize =3D 0;
>
> This is not needed. This should rather be "*buflen =3D 0;".

Yes, this an ugly oops.

>
>> +	return NULL;
>> +}
>> +
>> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +		      unsigned int nr_zones, report_zones_cb cb, void *data)
>> +{
>> +	struct ublk_device *ub =3D disk->private_data;
>> +	unsigned int zone_size_sectors =3D disk->queue->limits.chunk_sectors;
>> +	unsigned int first_zone =3D sector >> ilog2(zone_size_sectors);
>> +	unsigned int done_zones =3D 0;
>> +	unsigned int max_zones_per_request;
>> +	struct blk_zone *buffer;
>> +	size_t buffer_length;
>> +
>> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
>
> This is repeated a lot. So a small inline helper ublk_dev_is_zoned() woul=
d be nice.

Yes, thanks.

>
>> +		return -EOPNOTSUPP;
>> +
>> +	nr_zones =3D min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
>> +			 nr_zones);
>> +
>> +	buffer =3D ublk_alloc_report_buffer(ub, nr_zones, zone_size_sectors,
>> +					  &buffer_length);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +
>> +	max_zones_per_request =3D buffer_length / sizeof(struct blk_zone);
>> +
>> +	while (done_zones < nr_zones) {
>> +		unsigned int remaining_zones =3D nr_zones - done_zones;
>> +		unsigned int zones_in_request =3D min_t(
>> +			unsigned int, remaining_zones, max_zones_per_request);
>> +		int err =3D 0;
>> +		struct request *req;
>> +		struct ublk_rq_data *pdu;
>> +		blk_status_t status;
>> +
>> +		memset(buffer, 0, buffer_length);
>> +
>> +		req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
>> +		if (IS_ERR(req))
>> +			return PTR_ERR(req);
>
> You are leaking buffer.

=F0=9F=91=8D

>
>> +
>> +		pdu =3D blk_mq_rq_to_pdu(req);
>> +		pdu->operation =3D UBLK_IO_OP_REPORT_ZONES;
>> +		pdu->sector =3D sector;
>> +		pdu->nr_sectors =3D remaining_zones * zone_size_sectors;
>> +
>> +		err =3D blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
>> +					GFP_KERNEL);
>> +		if (err) {
>> +			blk_mq_free_request(req);
>> +			kvfree(buffer);
>> +			return err;
>> +		}
>> +
>> +		status =3D blk_execute_rq(req, 0);
>> +		err =3D blk_status_to_errno(status);
>> +		blk_mq_free_request(req);
>> +		if (err) {
>> +			kvfree(buffer);
>> +			return err;
>
> You are repeating this a lot. Use a goto to cleanup on error.

Ok

>
>> +		}
>> +
>> +		for (unsigned int i =3D 0; i < zones_in_request; i++) {
>> +			struct blk_zone *zone =3D buffer + i;
>> +
>> +			err =3D cb(zone, i, data);
>> +			if (err)
>> +				return err;
>> +
>> +			done_zones++;
>> +			sector +=3D zone_size_sectors;
>> +
>> +			/* A zero length zone means don't ask for more zones */
>> +			if (!zone->len) {
>> +				kvfree(buffer);
>> +				return done_zones;
>> +			}
>> +		}
>> +	}
>> +
>> +	kvfree(buffer);
>> +	return done_zones;
>> +}
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index e519dc0d9fe7..88fa39853c61 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -57,12 +57,13 @@
>>  		| UBLK_F_USER_RECOVERY_REISSUE \
>>  		| UBLK_F_UNPRIVILEGED_DEV \
>>  		| UBLK_F_CMD_IOCTL_ENCODE \
>> -		| UBLK_F_USER_COPY)
>> +		| UBLK_F_USER_COPY \
>> +		| UBLK_F_ZONED)
>>=20=20
>>  /* All UBLK_PARAM_TYPE_* should be included here */
>> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
>> -		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
>> -
>> +#define UBLK_PARAM_TYPE_ALL                                \
>> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
>>=20=20
>>  struct ublk_uring_cmd_pdu {
>>  	struct ublk_queue *ubq;
>> @@ -209,6 +210,9 @@ static void ublk_dev_param_basic_apply(struct ublk_d=
evice *ub)
>>  		set_disk_ro(ub->ub_disk, true);
>>=20=20
>>  	set_capacity(ub->ub_disk, p->dev_sectors);
>> +
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> +		ublk_set_nr_zones(ub);
>
> So if the user is attempting to setup a zoned drive but the kernel does n=
ot have
> CONFIG_BLK_DEV_ZONED=3Dy, the user setup will be silently ignored. Not ex=
actly
> nice I think, unless I am missing something.

We have this in `ublk_ctrl_add_dev()`:

	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
		ub->dev_info.flags &=3D ~UBLK_F_ZONED;

User space is supposed to check the flags after the call to know the
kernel capabilities.

>
> Also, repeating that "if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))" for all zone
> related functions is very verbose. Stub the functions in ublk_drv.h. That=
 will
> make the main C code lighter.

Not sure what you mean "stub the functions". Like so:

@@ -216,8 +216,7 @@ static void ublk_dev_param_basic_apply(struct ublk_devi=
ce *ub)
=20
 	set_capacity(ub->ub_disk, p->dev_sectors);
=20
-	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
-		ublk_set_nr_zones(ub);
+	ublk_config_nr_zones(ub);
 }

And then in the header:

void ublk_config_nr_zones(struct ublk_device *ub)
{
	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
		ublk_set_nr_zones(ub);
}

Or something else?

>
>>  }
>>=20=20
>>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
>> @@ -269,6 +273,9 @@ static int ublk_apply_params(struct ublk_device *ub)
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>>  		ublk_dev_param_discard_apply(ub);
>>=20=20
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM=
_TYPE_ZONED))
>> +		ublk_dev_param_zoned_apply(ub);
>
> Similar comment as above. If the user tries to apply zoned parameters to =
a non
> zoned drive, no error reported...
>
>> +
>>  	return 0;
>>  }
>>=20=20
>> @@ -439,6 +446,7 @@ static const struct block_device_operations ub_fops =
=3D {
>>  	.owner =3D	THIS_MODULE,
>>  	.open =3D		ublk_open,
>>  	.free_disk =3D	ublk_free_disk,
>> +	.report_zones =3D	ublk_report_zones,
>>  };
>>=20=20
>>  #define UBLK_MAX_PIN_PAGES	32
>> @@ -553,7 +561,8 @@ static inline bool ublk_need_map_req(const struct re=
quest *req)
>>=20=20
>>  static inline bool ublk_need_unmap_req(const struct request *req)
>>  {
>> -	return ublk_rq_has_data(req) && req_op(req) =3D=3D REQ_OP_READ;
>> +	return ublk_rq_has_data(req) &&
>> +	       (req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_DR=
V_IN);
>>  }
>>=20=20
>>  static int ublk_map_io(const struct ublk_queue *ubq, const struct reque=
st *req,
>> @@ -637,6 +646,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue=
 *ubq, struct request *req)
>>  {
>>  	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
>>  	struct ublk_io *io =3D &ubq->ios[req->tag];
>> +	struct ublk_rq_data *pdu =3D blk_mq_rq_to_pdu(req);
>>  	u32 ublk_op;
>>=20=20
>>  	switch (req_op(req)) {
>> @@ -655,6 +665,35 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
e *ubq, struct request *req)
>>  	case REQ_OP_WRITE_ZEROES:
>>  		ublk_op =3D UBLK_IO_OP_WRITE_ZEROES;
>>  		break;
>> +	case REQ_OP_ZONE_OPEN:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_OPEN;
>> +		break;
>> +	case REQ_OP_ZONE_CLOSE:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_CLOSE;
>> +		break;
>> +	case REQ_OP_ZONE_FINISH:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_FINISH;
>> +		break;
>> +	case REQ_OP_ZONE_RESET:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_RESET;
>> +		break;
>> +	case REQ_OP_DRV_IN:
>> +		ublk_op =3D pdu->operation;
>> +		switch (ublk_op) {
>> +		case UBLK_IO_OP_REPORT_ZONES:
>> +			iod->op_flags =3D ublk_op | ublk_req_build_flags(req);
>> +			iod->nr_sectors =3D pdu->nr_sectors;
>> +			iod->start_sector =3D pdu->sector;
>> +			iod->addr =3D io->addr;
>> +			return BLK_STS_OK;
>> +		default:
>> +			return BLK_STS_IOERR;
>> +		}
>> +	case REQ_OP_ZONE_APPEND:
>> +	case REQ_OP_ZONE_RESET_ALL:
>> +	case REQ_OP_DRV_OUT:
>> +		/* We do not support zone append or reset_all yet */
>> +		fallthrough;
>
> Not OK ! zone append is mandatory for zoned block devices. So zone append
> support needs to come with this patch. reset all can be a different patch=
 as
> that is optional.

I will merge the patches. I thought it would be easier to review when split.

>
>>  	default:
>>  		return BLK_STS_IOERR;
>>  	}
>> @@ -708,7 +747,8 @@ static inline void __ublk_complete_rq(struct request=
 *req)
>>  	 *
>>  	 * Both the two needn't unmap.
>>  	 */
>> -	if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE)
>> +	if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE &&
>> +	    req_op(req) !=3D REQ_OP_DRV_IN)
>>  		goto exit;
>>=20=20
>>  	/* for READ request, writing data in iod->addr to rq buffers */
>> @@ -1835,6 +1875,15 @@ static int ublk_ctrl_start_dev(struct ublk_device=
 *ub, struct io_uring_cmd *cmd)
>>  	if (ub->nr_privileged_daemon !=3D ub->nr_queues_ready)
>>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>=20=20
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> +	    ub->dev_info.flags & UBLK_F_ZONED) {
>
> Same comment as above about error return instead of silently ignoring the=
 zoned
> flag for the CONFIG_BLK_DEV_ZONED=3Dn case.
>
>> +		disk_set_zoned(disk, BLK_ZONED_HM);
>> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_=
WRITE);
>> +		ret =3D ublk_revalidate_disk_zones(disk);
>> +		if (ret)
>> +			goto out_put_disk;
>
> This should be all a helper ublk_set_zoned() or something.

Ok =F0=9F=91=8D Unfortunately this block of code is split up in the zone ap=
pend
patch. I will see what I can do, maybe 2 functions.

>
>> +	}
>> +
>>  	get_device(&ub->cdev_dev);
>>  	ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>>  	ret =3D add_disk(disk);
>> @@ -1997,6 +2046,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *=
cmd)
>>  	if (ub->dev_info.flags & UBLK_F_USER_COPY)
>>  		ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
>>=20=20
>> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
>> +		ub->dev_info.flags &=3D ~UBLK_F_ZONED;
>
> Arg, no. The user should be notified with an error that he/she is attempt=
ing to
> create a zoned device that cannot be supported.

As I wrote above, this is part of the ublk uapi. This is the way user
space does kernel capability check. User space will check the flags when
this call returns. @Ming did I understand this correctly or did I miss some=
thing?

>
>> +
>>  	/* We are not ready to support zero copy */
>>  	ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
>>=20=20
>> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
>> index f81e62256456..7242430fd6b9 100644
>> --- a/drivers/block/ublk_drv.h
>> +++ b/drivers/block/ublk_drv.h
>> @@ -50,6 +50,21 @@ struct ublk_rq_data {
>>  	struct llist_node node;
>>=20=20
>>  	struct kref ref;
>> +	enum ublk_op operation;
>> +	__u64 sector;
>> +	__u32 nr_sectors;
>>  };
>>=20=20
>> +void ublk_set_nr_zones(struct ublk_device *ub);
>> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
>> +int ublk_revalidate_disk_zones(struct gendisk *disk);
>> +
>> +#ifdef CONFIG_BLK_DEV_UBLK_ZONED
>> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +		      unsigned int nr_zones, report_zones_cb cb,
>> +		      void *data);
>> +#else
>> +#define ublk_report_zones NULL
>> +#endif
>> +
>>  #endif
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd=
.h
>> index 471b3b983045..436525afffe8 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -176,6 +176,11 @@
>>  /* Copy between request and user buffer by pread()/pwrite() */
>>  #define UBLK_F_USER_COPY	(1UL << 7)
>>=20=20
>> +/*
>> + * Enable zoned device support
>
> Isn't this for "Indicate that the device is zoned" ?

User space sets this flag when setting up the device to enable zoned
storage support. Kernel may reject it. I think the wording is
sufficient. Could be updated to:

"User space sets this flag when setting up the device to request zoned
 storage support. Kernel may deny the request by clearing the flag
 during setup."

>
>> + */
>> +#define UBLK_F_ZONED (1ULL << 8)
>> +
>>  /* device state */
>>  #define UBLK_S_DEV_DEAD	0
>>  #define UBLK_S_DEV_LIVE	1
>> @@ -242,6 +247,7 @@ enum ublk_op {
>>  	UBLK_IO_OP_ZONE_APPEND =3D 13,
>>  	UBLK_IO_OP_ZONE_RESET =3D 15,
>>  	__UBLK_IO_OP_DRV_IN_START =3D 32,
>> +	UBLK_IO_OP_REPORT_ZONES =3D __UBLK_IO_OP_DRV_IN_START,
>>  	__UBLK_IO_OP_DRV_IN_END =3D 96,
>>  	__UBLK_IO_OP_DRV_OUT_START =3D __UBLK_IO_OP_DRV_IN_END,
>>  	__UBLK_IO_OP_DRV_OUT_END =3D 160,
>> @@ -342,6 +348,12 @@ struct ublk_param_devt {
>>  	__u32   disk_minor;
>>  };
>>=20=20
>> +struct ublk_param_zoned {
>> +	__u32	max_open_zones;
>> +	__u32	max_active_zones;
>> +	__u8	reserved[24];
>> +};
>> +
>>  struct ublk_params {
>>  	/*
>>  	 * Total length of parameters, userspace has to set 'len' for both
>> @@ -353,11 +365,13 @@ struct ublk_params {
>>  #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
>>  #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
>>  #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
>> +#define UBLK_PARAM_TYPE_ZONED           (1 << 3)
>>  	__u32	types;			/* types of parameter included */
>>=20=20
>>  	struct ublk_param_basic		basic;
>>  	struct ublk_param_discard	discard;
>>  	struct ublk_param_devt		devt;
>> +	struct ublk_param_zoned	zoned;
>>  };
>>=20=20
>>  #endif


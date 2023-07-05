Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C51748246
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGEKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjGEKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:36:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188AAB2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:36:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so7836405a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688553406; x=1691145406;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS/yvgtg0kW1I34fegUKrBBniz83pK6Ffc+8jPNMrhI=;
        b=NAd3uwvO6P00ddatdb/jY1rogkfTarAWU0mKx7GSAI55WP1YaDXFbEmzypIKKOU2fw
         O1piW1vPX2VJFRAlxQf+JYCzO+Cv2cFenWO1Gqz7irv60s6S4yA8AHdUQ2kJJBj1OUUH
         V06Ob1NuXJlCq6K20/KRKoancTnoTSxa4OM5kfKx69OIE6QHX++n/NAAN/fSkRplqX8M
         DgCP8cFsMPPY66LKpKFDlWkRHgIdXXU3SBicAxWYT+u21c5f31oqdzIMRaI1YnTPF5Tg
         DOiIVLuHrE0ImKh8kGTqS7yxiL66CWotCZ3SAEnYHK+CGYLFVx7ofRO56kqRWiwRvX1c
         PsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688553406; x=1691145406;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kS/yvgtg0kW1I34fegUKrBBniz83pK6Ffc+8jPNMrhI=;
        b=QUlrY6cPVvGAXad1rSJg9AXkwom4Ab7D6FlKg4OUz4+S++kHIkeJt0ET4Ci9/nCxfC
         jB8z5PPU0sPZ0pllMZvM8rvg6CJJVnvHiC2jgGmkrjnOVZlbanMyJQpS6xK05+/2dgCQ
         sYjGklOa5zT3b8jYxkrfplWbbsiJkWcigdpAWCUTBHVlloFNIESRkRHzJrNDJlGJXc0+
         wWihFtOVUiZsANBedZ/JDy7SLDSfzSWvYjnz1Kx58rpE0eIo9J8x/e4uMTnmqeylFGJR
         6um14PlXsc7d/dGKQXUj6BDpze80QWnql3xrWAHCAYOiS7PVnks8s8kwhJZ0s2VyXPEx
         JBcg==
X-Gm-Message-State: ABy/qLbFYdcP04mfjDLeOQRHRdhqQtOkxkLc2oyU3TFIfXFp22NMFcrS
        q+0eFET2Wj6eLTKN+i/BxDco2Q==
X-Google-Smtp-Source: APBJJlHZRKMbHMYpS9H7ORssK3XRm/pfUXvjsN7Xjv6jkHiv1tGVKPDYl/3I2HSCikyqILauWt9iEw==
X-Received: by 2002:aa7:c60c:0:b0:514:9df0:e3f3 with SMTP id h12-20020aa7c60c000000b005149df0e3f3mr13398988edq.0.1688553406287;
        Wed, 05 Jul 2023 03:36:46 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a17-20020a50ff11000000b0051a4fcf7187sm12684019edu.62.2023.07.05.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:36:45 -0700 (PDT)
References: <20230704165209.514591-1-nmi@metaspace.dk>
 <20230704165209.514591-6-nmi@metaspace.dk>
 <9defb3f0-7085-e056-364f-ee78da0b829a@kernel.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 5/5] ublk: enable zoned storage support
Date:   Wed, 05 Jul 2023 10:29:50 +0200
In-reply-to: <9defb3f0-7085-e056-364f-ee78da0b829a@kernel.org>
Message-ID: <87a5wad4qt.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 7/5/23 01:52, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> Add zoned storage support to ublk: report_zones and operations:
>>  - REQ_OP_ZONE_OPEN
>>  - REQ_OP_ZONE_CLOSE
>>  - REQ_OP_ZONE_FINISH
>>  - REQ_OP_ZONE_RESET
>>  - REQ_OP_ZONE_APPEND
>>=20
>> The zone append feature uses the `addr` field of `struct ublksrv_io_cmd`=
 to
>> communicate ALBA back to the kernel. Therefore ublk must be used with the
>> user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
>> available. Without this feature, ublk will not allow zoned storage suppo=
rt.
>>=20
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  MAINTAINERS                   |   1 +
>>  drivers/block/Kconfig         |   5 +
>>  drivers/block/Makefile        |   1 +
>>  drivers/block/ublk-zoned.c    | 225 ++++++++++++++++++++++++++++++++++
>>  drivers/block/ublk.c          |  92 +++++++++++---
>>  drivers/block/ublk.h          |  72 +++++++++++
>>  include/uapi/linux/ublk_cmd.h |  28 +++++
>>  7 files changed, 410 insertions(+), 14 deletions(-)
>>  create mode 100644 drivers/block/ublk-zoned.c
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1f193cd43958..8277f3e3e8e9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21553,6 +21553,7 @@ M:	Ming Lei <ming.lei@redhat.com>
>>  L:	linux-block@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/block/ublk.rst
>> +F:	drivers/block/ublk-zoned.c
>>  F:	drivers/block/ublk.c
>>  F:	drivers/block/ublk.h
>>  F:	include/uapi/linux/ublk_cmd.h
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index 5b9d4aaebb81..2d76e9693c2d 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -373,6 +373,7 @@ config BLK_DEV_RBD
>>  config BLK_DEV_UBLK
>>  	tristate "Userspace block driver (Experimental)"
>>  	select IO_URING
>> +  select BLK_DEV_UBLK_ZONED if BLK_DEV_ZONED
>>  	help
>>  	  io_uring based userspace block driver. Together with ublk server, ub=
lk
>>  	  has been working well, but interface with userspace or command data
>> @@ -402,6 +403,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>>  	  suggested to enable N if your application(ublk server) switches to
>>  	  ioctl command encoding.
>>=20=20
>> +config BLK_DEV_UBLK_ZONED
>> +	bool
>> +	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
>
> I do not think this line is needed.

Seems you are right =F0=9F=91=8D

>
>> +
>>  source "drivers/block/rnbd/Kconfig"
>>=20=20
>>  endif # BLK_DEV
>> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
>> index 38f2229623a8..6c700936d427 100644
>> --- a/drivers/block/Makefile
>> +++ b/drivers/block/Makefile
>> @@ -39,5 +39,6 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+=3D null_blk/
>>=20=20
>>  obj-$(CONFIG_BLK_DEV_UBLK)			+=3D ublk_drv.o
>>  ublk_drv-$(CONFIG_BLK_DEV_UBLK)			+=3D ublk.o
>> +ublk_drv-$(CONFIG_BLK_DEV_UBLK_ZONED)		+=3D ublk-zoned.o
>>=20=20
>>  swim_mod-y	:=3D swim.o swim_asm.o
>> diff --git a/drivers/block/ublk-zoned.c b/drivers/block/ublk-zoned.c
>> new file mode 100644
>> index 000000000000..6ddde2ac63e3
>> --- /dev/null
>> +++ b/drivers/block/ublk-zoned.c
>> @@ -0,0 +1,225 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
>> + */
>> +#include <linux/blkzoned.h>
>> +#include <linux/ublk_cmd.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "ublk.h"
>> +
>> +
>
> extra blank line not needed.

=F0=9F=91=8D

>
>> +static int get_nr_zones(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_basic *p =3D &ub->params.basic;
>> +
>> +	if (p->chunk_sectors)
>> +		return p->dev_sectors / p->chunk_sectors;
>
> This one is likely causing the build bot warning about __udivdi3 being un=
defined.
>
>> +	else
>
> No need for the else.
>
>> +		return 0;
>> +}
>
> Overall, I would reverse this:
>
> static int get_nr_zones(const struct ublk_device *ub)
> {
> 	const struct ublk_param_basic *p =3D &ub->params.basic;
>
> 	if (!p->chunk_sectors)
> 		return 0;
>
> 	return p->dev_sectors >> ilog2( p->chunk_sectors);
> }
>
> And given that for a non-zoned drive chunk_sectors should be 0 as well (u=
nless
> it is used by regular ublk), this function will return 0 zones for regular
> devies, and it does not depend on CONFIG_BLK_DEV_ZONED.

Ok for the edit. Not sure about moving to ublk.c since it is actually
static linkage without a prototype in the header.=20

>
>> +
>> +int ublk_set_nr_zones(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_basic *p =3D &ub->params.basic;
>> +
>> +	if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
>> +		return -EINVAL;
>
> This is a little odd. Why would p->chunk_sectors be 0 if ublk_dev_is_zone=
d() is
> true ?

It is a "defensive programming" check. It should not happen because we
validate this when parameters are set from user space and we should not
be able to get here if parameters are not set.

I think it enhances clarity and intention while helping mitigate
potential problems from future refactoring and edits. It's also not in a
hot path.

But I can remove it =F0=9F=91=8D

>
>> +
>> +	if (ublk_dev_is_zoned(ub)) {
>> +		ub->ub_disk->nr_zones =3D get_nr_zones(ub);
>> +		if (!ub->ub_disk->nr_zones)
>> +			return -EINVAL;
>> +	}
>
> This is the only hunk you should need.
>
>> +
>> +	return 0;
>> +}
>> +
>> +void ublk_disk_set_zoned(struct ublk_device *ub)
>> +{
>> +	if (ublk_dev_is_zoned(ub)) {
>> +		disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
>> +		blk_queue_required_elevator_features(ub->ub_disk->queue,
>> +						     ELEVATOR_F_ZBD_SEQ_WRITE);
>
> zone size (chunk_sectors) ? max open and max active zones ? max append se=
ctors ?
> It would be nice to have all that set in the same place.

Yes, that makes sense.

>
>> +	}
>> +}
>> +
>> +void ublk_zoned_commit_completion(const struct ublksrv_io_cmd *ub_cmd,
>> +				  struct ublk_io *io, struct request *req)
>> +{
>> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
>> +		req->__sector =3D ub_cmd->addr;
>> +	io->flags &=3D ~UBLK_IO_FLAG_ZONE_APPEND;
>
> Clearing the flag can be inside the if. But this helper is not needed at =
all.
> Nothing in it depends on CONFIG_BLK_DEV_ZONED so you can open code it in
> ublk_commit_completion(). For the !CONFIG_BLK_DEV_ZONED case, you will ne=
ver
> have a zoned device, so you will never see UBLK_IO_FLAG_ZONE_APPEND being=
 set.

I put it behind the config check to not add the instructions to this
path in case they are not required. I'm fine with open coding it as well =
=F0=9F=91=8D

>
>> +}
>> +
>> +int ublk_revalidate_disk_zones(struct ublk_device *ub)
>> +{
>> +	int ret =3D 0;
>> +
>> +	if (ublk_dev_is_zoned(ub))
>> +		ret =3D blk_revalidate_disk_zones(ub->ub_disk, NULL);
>> +
>> +	return ret;
>
> Variable ret is not necessary.

Right =F0=9F=91=8D

>
>> +}
>> +
>> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +	int nr_zones;
>> +
>> +	if (ublk_dev_is_zoned(ub) && !(ublk_dev_params_zoned(ub)))
>
> extra parenthesis around ublk_dev_params_zoned(ub) are not needed.

Thanks =F0=9F=91=8D

>
>> +		return -EINVAL;
>> +
>> +	if (!ublk_dev_is_zoned(ub) && ublk_dev_params_zoned(ub))
>
> This one could be an || condition with the previous if. But overall, cann=
ot this
> be simplified to:
>
> 	if ((!ublk_dev_is_zoned(ub)) && (!ublk_dev_params_zoned(ub)))
> 		return -EINVAL;

I don't think that is the same. The EINVAL should be hit when the xor of
the two checks is true. I considered doing that but decided the one I
submitted is more clear. I also considered combining the checks in one
conditional statement, but I liked two statements better. Compiler
should be cleaver enough to optimize.

>
> ?
>
> Not sure as this is not clear. If ublk_dev_params_zoned() is false, I do =
not see
> how ublk_dev_is_zoned() can be true...

This checks for user error. User might set UBLK_F_ZONED during
UBLK_CMD_ADD_DEV command but might fail to set zoned parameters
(UBLK_PARAM_TYPE_ZONED) during UBLK_CMD_SET_PARAMS command. Or the other
way around. Setting zoned parameters on a non zoned ublk device should
also result in an error.

>
>> +		return -EINVAL;
>> +
>> +	if (!ublk_dev_params_zoned(ub))
>> +		return 0;
>
> Shouldn't this be first ? That would simplify the previous ifs...

No, because we want to check that the user did not set zoned parameters
for a regular device.

>
>> +
>> +	if (!p->max_zone_append_sectors)
>> +		return -EINVAL;
>> +
>> +	nr_zones =3D get_nr_zones(ub);
>> +
>> +	if (p->max_active_zones > nr_zones)
>> +		return -EINVAL;
>> +
>> +	if (p->max_open_zones > nr_zones)
>> +		return -EINVAL;
>
> 	nr_zones =3D get_nr_zones(ub);
> 	if (!nr_zones ||
> 	    p->max_active_zones > nr_zones ||
> 	    p->max_open_zones > nr_zones)
> 		return -EINVAL;

I think this makes the code less readable, and compiler should be smart
enough to do this for us anyway. If you insist I will change =F0=9F=98=8F

>
>> +
>> +	return 0;
>> +}
>> +
>> +int ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +
>> +	if (ublk_dev_is_zoned(ub) && !(ublk_dev_params_zoned(ub)))
>> +		return -EINVAL;
>> +
>> +	if (!ublk_dev_is_zoned(ub) && ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +
>> +	if (!ublk_dev_params_zoned(ub))
>> +		return 0;
>
> How many times do you need to check these ? these are checked in
> ublk_dev_param_zoned_validate() already. And given the name, I would assu=
me that
> the parameters were validated before being applied.

I'll remove the checks.

>
>> +
>> +	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>> +	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>> +	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_appe=
nd_sectors);
>> +
>
> Shouldn't this all be in ublk_disk_set_zoned() ? Or even better, merge th=
ese 2
> functions together.

Yes, you are right.

>
>> +	return 0;
>> +}
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
>
> 	ublk->ub_disk->nr_zones

Thanks =F0=9F=91=8D

>
> But ublk_report_zones() does the capping of nr_zones already. So it shoul=
d not
> be needed at all here.

I would leave it in so that potential future callers of this function
get no surprises, but I get the sense that you don't prefer that kind of
checks. Hard no to leaving it in or OK to have it?

>
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
>> +	*buflen =3D 0;
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
>> +	int ret;
>> +	struct blk_zone *buffer;
>> +	size_t buffer_length;
>> +
>> +	if (!ublk_dev_is_zoned(ub))
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
>
> Nit: splitting the line after "=3D" is the more usual way.

Alright. I am using clang-format and for some reason it likes the other
way. I wonder if there is a config option for that behavior.

>
>> +		struct request *req;
>> +		struct ublk_rq_data *pdu;
>> +		blk_status_t status;
>> +
>> +		memset(buffer, 0, buffer_length);
>> +
>> +		req =3D blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
>> +		if (IS_ERR(req)) {
>> +			ret =3D PTR_ERR(req);
>> +			goto out;
>> +		}
>> +
>> +		pdu =3D blk_mq_rq_to_pdu(req);
>> +		pdu->operation =3D UBLK_IO_OP_REPORT_ZONES;
>> +		pdu->sector =3D sector;
>> +		pdu->nr_sectors =3D remaining_zones * zone_size_sectors;
>> +
>> +		ret =3D blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
>> +					GFP_KERNEL);
>> +		if (ret) {
>> +			blk_mq_free_request(req);
>> +			goto out;
>> +		}
>> +
>> +		status =3D blk_execute_rq(req, 0);
>> +		ret =3D blk_status_to_errno(status);
>> +		blk_mq_free_request(req);
>> +		if (ret)
>> +			goto out;
>> +
>> +		for (unsigned int i =3D 0; i < zones_in_request; i++) {
>> +			struct blk_zone *zone =3D buffer + i;
>> +
>> +			ret =3D cb(zone, i, data);
>> +			if (ret)
>> +				goto out;
>> +
>> +			done_zones++;
>> +			sector +=3D zone_size_sectors;
>> +
>> +			/* A zero length zone means don't ask for more zones */
>> +			if (!zone->len) {
>> +				ret =3D done_zones;
>> +				goto out;
>
> You should only need to "break" here. The reason is that the report call =
may
> have been short, but that does not mean that the overall report request f=
rom the
> user has been served yet.

Yes.

>
>> +			}
>> +		}
>> +	}
>> +
>> +	ret =3D done_zones;
>> +
>> +out:
>> +	kvfree(buffer);
>> +	return ret;
>> +}
>> diff --git a/drivers/block/ublk.c b/drivers/block/ublk.c
>> index 0b1ec102aaae..c97a8f14f8a9 100644
>> --- a/drivers/block/ublk.c
>> +++ b/drivers/block/ublk.c
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
>> @@ -137,7 +138,7 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>>  		UBLK_TAG_BITS_MASK;
>>  }
>>=20=20
>> -static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>> +static int ublk_dev_param_basic_apply(struct ublk_device *ub)
>>  {
>>  	struct request_queue *q =3D ub->ub_disk->queue;
>>  	const struct ublk_param_basic *p =3D &ub->params.basic;
>> @@ -162,6 +163,8 @@ static void ublk_dev_param_basic_apply(struct ublk_d=
evice *ub)
>>  		set_disk_ro(ub->ub_disk, true);
>>=20=20
>>  	set_capacity(ub->ub_disk, p->dev_sectors);
>> +
>> +	return ublk_set_nr_zones(ub);
>
> This is odd. Why is this not called only under a "if (ublk_dev_is_zoned(u=
b)" ?

The call is a noop if not ublk_dev_is_zoned(). I will hoist the check to he=
re to
enhance clarity.

>
>>  }
>>=20=20
>>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
>> @@ -191,6 +194,9 @@ static int ublk_validate_params(const struct ublk_de=
vice *ub)
>>=20=20
>>  		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
>>  			return -EINVAL;
>> +
>> +		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
>> +			return -EINVAL;
>>  	} else
>>  		return -EINVAL;
>>=20=20
>> @@ -209,20 +215,24 @@ static int ublk_validate_params(const struct ublk_=
device *ub)
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>>  		return -EINVAL;
>>=20=20
>> -	return 0;
>> +	return ublk_dev_param_zoned_validate(ub);
>
> Same here.

In this case we need to make the call no matter what, in order to do
some sanity checks on the parameters. It is an error to set zoned
parameters when the ublk device does not have the zoned flag.

>
>>  }
>>=20=20
>>  static int ublk_apply_params(struct ublk_device *ub)
>>  {
>> +	int ret;
>> +
>>  	if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
>>  		return -EINVAL;
>>=20=20
>> -	ublk_dev_param_basic_apply(ub);
>> +	ret =3D ublk_dev_param_basic_apply(ub);
>> +	if (ret)
>> +		return ret;
>>=20=20
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
>>  		ublk_dev_param_discard_apply(ub);
>>=20=20
>> -	return 0;
>> +	return ublk_dev_param_zoned_apply(ub);
>
> Same.

Right.

>
>>  }
>>=20=20
>>  static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
>> @@ -392,6 +402,7 @@ static const struct block_device_operations ub_fops =
=3D {
>>  	.owner =3D	THIS_MODULE,
>>  	.open =3D		ublk_open,
>>  	.free_disk =3D	ublk_free_disk,
>> +	.report_zones =3D	ublk_report_zones,
>>  };
>>=20=20
>>  #define UBLK_MAX_PIN_PAGES	32
>> @@ -506,7 +517,8 @@ static inline bool ublk_need_map_req(const struct re=
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
>> @@ -590,6 +602,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue=
 *ubq, struct request *req)
>>  {
>>  	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
>>  	struct ublk_io *io =3D &ubq->ios[req->tag];
>> +	struct ublk_rq_data *pdu =3D blk_mq_rq_to_pdu(req);
>>  	u32 ublk_op;
>>=20=20
>>  	switch (req_op(req)) {
>> @@ -608,6 +621,37 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
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
>> +			return BLK_STS_OK;
>> +		default:
>> +			return BLK_STS_IOERR;
>> +		}
>> +	case REQ_OP_ZONE_APPEND:
>> +		ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
>> +		io->flags |=3D UBLK_IO_FLAG_ZONE_APPEND;
>> +		break;
>> +	case REQ_OP_ZONE_RESET_ALL:
>> +	case REQ_OP_DRV_OUT:
>> +		/* We do not support zone append or reset_all yet */
>> +		fallthrough;
>
> Wrong comment. Append support is above it.

Thanks

>
>>  	default:
>>  		return BLK_STS_IOERR;
>>  	}
>> @@ -661,7 +705,8 @@ static inline void __ublk_complete_rq(struct request=
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
>> @@ -1025,6 +1070,8 @@ static void ublk_commit_completion(struct ublk_dev=
ice *ub,
>>  	/* find the io request and complete */
>>  	req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>>=20=20
>> +	ublk_zoned_commit_completion(ub_cmd, io, req);
>> +
>>  	if (req && likely(!blk_should_fake_timeout(req->q)))
>>  		ublk_put_req_ref(ubq, req);
>>  }
>> @@ -1324,7 +1371,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
>>  			^ (_IOC_NR(cmd_op) =3D=3D UBLK_IO_NEED_GET_DATA))
>>  		goto out;
>>=20=20
>> -	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
>> +	if (ublk_support_user_copy(ubq) &&
>> +	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
>>  		ret =3D -EINVAL;
>>  		goto out;
>>  	}
>> @@ -1447,11 +1495,14 @@ static inline bool ublk_check_ubuf_dir(const str=
uct request *req,
>>  		int ubuf_dir)
>>  {
>>  	/* copy ubuf to request pages */
>> -	if (req_op(req) =3D=3D REQ_OP_READ && ubuf_dir =3D=3D ITER_SOURCE)
>> +	if ((req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_OP_DRV_I=
N) &&
>> +	    ubuf_dir =3D=3D ITER_SOURCE)
>>  		return true;
>>=20=20
>>  	/* copy request pages to ubuf */
>> -	if (req_op(req) =3D=3D REQ_OP_WRITE && ubuf_dir =3D=3D ITER_DEST)
>> +	if ((req_op(req) =3D=3D REQ_OP_WRITE ||
>> +	     req_op(req) =3D=3D REQ_OP_ZONE_APPEND) &&
>> +	    ubuf_dir =3D=3D ITER_DEST)
>>  		return true;
>>=20=20
>>  	return false;
>> @@ -1780,6 +1831,8 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub, struct io_uring_cmd *cmd)
>>  	ub->dev_info.ublksrv_pid =3D ublksrv_pid;
>>  	ub->ub_disk =3D disk;
>>=20=20
>> +	ublk_disk_set_zoned(ub);
>> +
>
> This really needs to go inside ublk_apply_params() I think.

Yes

>
>>  	ret =3D ublk_apply_params(ub);
>>  	if (ret)
>>  		goto out_put_disk;
>> @@ -1788,8 +1841,12 @@ static int ublk_ctrl_start_dev(struct ublk_device=
 *ub, struct io_uring_cmd *cmd)
>>  	if (ub->nr_privileged_daemon !=3D ub->nr_queues_ready)
>>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>=20=20
>> -	get_device(&ub->cdev_dev);
>>  	ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>> +	ret =3D ublk_revalidate_disk_zones(ub);
>> +	if (ret)
>> +		goto out_put_disk;
>> +
>> +	get_device(&ub->cdev_dev);
>>  	ret =3D add_disk(disk);
>>  	if (ret) {
>>  		/*
>> @@ -1950,6 +2007,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd =
*cmd)
>>  	if (ublk_dev_is_user_copy(ub))
>>  		ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
>>=20=20
>> +	/* Zoned storage support requires user copy feature */
>> +	if (ublk_dev_is_zoned(ub) &&
>> +	    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !ublk_dev_is_user_copy(ub)))=
 {
>
> CONFIG_BLK_DEV_UBLK_ZONED ?

Yes, although it the same in this translation unit because of kconfig.

>
>> +		ret =3D -EINVAL;
>> +		goto out_free_dev_number;
>> +	}
>> +
>>  	/* We are not ready to support zero copy */
>>  	ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
>>=20=20
>> diff --git a/drivers/block/ublk.h b/drivers/block/ublk.h
>> index fcbcc6b02aa0..b78ab43cea82 100644
>> --- a/drivers/block/ublk.h
>> +++ b/drivers/block/ublk.h
>> @@ -45,6 +45,10 @@
>>   */
>>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>>=20=20
>> +/*
>> + * Set when IO is Zone Append
>> + */
>> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
>>=20=20
>>  struct ublk_device {
>>  	struct gendisk		*ub_disk;
>> @@ -89,6 +93,9 @@ struct ublk_rq_data {
>>  	struct llist_node node;
>>=20=20
>>  	struct kref ref;
>> +	__u32 operation;
>> +	__u64 sector;
>> +	__u32 nr_sectors;
>>  };
>>=20=20
>>  struct ublk_io {
>> @@ -100,9 +107,74 @@ struct ublk_io {
>>  	struct io_uring_cmd *cmd;
>>  };
>>=20=20
>> +static inline int ublk_dev_params_zoned(const struct ublk_device *ub)
>> +{
>> +	return ub->params.types & UBLK_PARAM_TYPE_ZONED;
>> +}
>> +
>> +static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
>> +{
>> +	return ub->dev_info.flags & UBLK_F_ZONED;
>> +}
>> +
>>  static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
>>  {
>>  	return ub->dev_info.flags & UBLK_F_USER_COPY;
>>  }
>>=20=20
>> +#ifndef CONFIG_BLK_DEV_ZONED
>
> CONFIG_BLK_DEV_UBLK_ZONED

Thanks

>
>> +
>> +static inline int ublk_set_nr_zones(struct ublk_device *ub)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void ublk_disk_set_zoned(struct ublk_device *ub)
>> +{
>> +}
>> +
>> +static inline int ublk_dev_param_zoned_validate(const struct ublk_devic=
e *ub)
>> +{
>> +	if (ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>> +static inline int ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	if (ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>> +static inline void
>> +ublk_zoned_commit_completion(const struct ublksrv_io_cmd *ub_cmd,
>> +			     struct ublk_io *io, struct request *req)
>> +{
>> +}
>> +
>> +static inline int ublk_revalidate_disk_zones(struct ublk_device *ub)
>> +{
>> +	return 0;
>> +}
>> +
>> +#define ublk_report_zones (NULL)
>> +
>> +#else
>> +
>> +int ublk_set_nr_zones(struct ublk_device *ub);
>> +void ublk_disk_set_zoned(struct ublk_device *ub);
>> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
>> +int ublk_dev_param_zoned_apply(struct ublk_device *ub);
>> +void ublk_zoned_commit_completion(const struct ublksrv_io_cmd *ub_cmd,
>> +				  struct ublk_io *io, struct request *req);
>> +int ublk_revalidate_disk_zones(struct ublk_device *ub);
>> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +		      unsigned int nr_zones, report_zones_cb cb,
>> +		      void *data);
>> +
>> +#endif
>> +
>> +
>> +
>>  #endif
>> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd=
.h
>> index a32810c8ef2b..13b76e665aed 100644
>> --- a/include/uapi/linux/ublk_cmd.h
>> +++ b/include/uapi/linux/ublk_cmd.h
>> @@ -176,6 +176,12 @@
>>  /* Copy between request and user buffer by pread()/pwrite() */
>>  #define UBLK_F_USER_COPY	(1UL << 7)
>>=20=20
>> +/*
>> + * User space sets this flag when setting up the device to request zone=
d storage support. Kernel may
>> + * deny the request by returning an error.
>> + */
>> +#define UBLK_F_ZONED (1ULL << 8)
>> +
>>  /* device state */
>>  #define UBLK_S_DEV_DEAD	0
>>  #define UBLK_S_DEV_LIVE	1
>> @@ -235,7 +241,20 @@ struct ublksrv_ctrl_dev_info {
>>  #define		UBLK_IO_OP_DISCARD		(3)
>>  #define		UBLK_IO_OP_WRITE_SAME		(4)
>>  #define		UBLK_IO_OP_WRITE_ZEROES		(5)
>> +#define		UBLK_IO_OP_ZONE_OPEN		(10)
>> +#define		UBLK_IO_OP_ZONE_CLOSE		(11)
>> +#define		UBLK_IO_OP_ZONE_FINISH		(12)
>> +#define		UBLK_IO_OP_ZONE_APPEND		(13)
>> +#define		UBLK_IO_OP_ZONE_RESET		(15)
>>  #define		__UBLK_IO_OP_DRV_IN_START	(32)
>> +/* Construct a zone report. The report request is carried in `struct ub=
lksrv_io_desc`. The
>> + * `start_sector` field must be the first sector of a zone and shall in=
dicate the first zone of the
>> + * report. The `nr_sectors` shall indicate how many zones should be rep=
orted (divide by zone size to
>> + * get number of zones in the report) and must be an integer multiple o=
f the zone size. The report
>> + * shall be delivered as a `struct blk_zone` array. To report fewer zon=
es than requested, zero the
>> + * last entry of the returned array.
>> + */
>
> Long lines and first line is not "/*"

I swear I read somewhere 100 character line limit, but I see quite
clearly it says 80 in the style guide. I wonder why checkpatch.pl did
not complain.

>
>> +#define		UBLK_IO_OP_REPORT_ZONES		(__UBLK_IO_OP_DRV_IN_START)
>>  #define		__UBLK_IO_OP_DRV_IN_END		(96)
>>  #define		__UBLK_IO_OP_DRV_OUT_START	(__UBLK_IO_OP_DRV_IN_END)
>>  #define		__UBLK_IO_OP_DRV_OUT_END	(160)
>> @@ -335,6 +354,13 @@ struct ublk_param_devt {
>>  	__u32   disk_minor;
>>  };
>>=20=20
>> +struct ublk_param_zoned {
>> +	__u32	max_open_zones;
>> +	__u32	max_active_zones;
>> +	__u32	max_zone_append_sectors;
>> +	__u8	reserved[20];
>> +};
>> +
>>  struct ublk_params {
>>  	/*
>>  	 * Total length of parameters, userspace has to set 'len' for both
>> @@ -346,11 +372,13 @@ struct ublk_params {
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


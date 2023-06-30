Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B68744029
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjF3QyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjF3QyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:54:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0B3AAF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:54:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51dfa0771cdso11502a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688144052; x=1690736052;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaNsiiD4Bxi7FstRFg2227ah95lDCZQpkjuVDC175qg=;
        b=foG67OticlKNVtWaP/A2PzT7D/ta/cw6hluGxBO6+wfz7piVPAFPkPTjQzlEIEccLU
         mOHomDKOllwVn6lV5FbFJXjLmRYGj6NWX77lsgTW8fH2oX3Sc9VYRz41lfoLGcFLzYZ0
         fj4iHV/XiD7ALtp8y0zDBDdK0F7CZEUSrufrwVpd97WFth0fTK8rxo7+OAlx6soLJaul
         12JJMtEunTzqBL91BARznPcMocpPPwZG/ijuWMh8xbwyf6jEF782QnWWch/ifxF1fO8K
         nUv1ZPuR7ucnNNg0Ra5L2CMp3WQx5LWkiVvMJVUg/z6GRE5vXrv9fsEAxStqt+hM9H3Y
         /VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144052; x=1690736052;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FaNsiiD4Bxi7FstRFg2227ah95lDCZQpkjuVDC175qg=;
        b=ThIAemOCu31T1+aOPBo7Hzb8inohHry7ASGipXN45MPMLQItuQvRMwVzMjufy4zKwb
         jbBgk+oDpXU5CaC+FIv/9yVinMoOr8+Qs77mrTVMR3Hnb+KJX6XRU2XYMCQWbW9IebIa
         6cf8vL9tPloyn9tZ7LwU/5qpIBkOdKqA4pA/WiHApbJNzKfVzC/emH7+Xcpm44nFh1Cu
         j1WkvvFWwZKajo0rJiQGAm5pVarq0G7AiPwrNMan2lio1CStHYRt8G0hUCPrz0pq0w62
         VIUutupdal1eg590xOvoy/iIBxoyjsSK2k28bSeDF7nU0VNZ6EU8UPhSZW5uRhLr9AUV
         yZ5g==
X-Gm-Message-State: ABy/qLadXk+naRgpi9V7yDa73ZCuCcZt5hUvxmbP/EUUo/q5GAA9tDpg
        LAyeSzSLQo6zBDuvgRKk6hdHug==
X-Google-Smtp-Source: APBJJlEur5ef4S9PQ/MEvKZm99ocQMPnpN602S3NlfDTa4KYWTVgjAT7+hlRf9lTWrI+2Z9/MMlyMQ==
X-Received: by 2002:aa7:c2c3:0:b0:51b:f669:9df3 with SMTP id m3-20020aa7c2c3000000b0051bf6699df3mr1964918edp.4.1688144052261;
        Fri, 30 Jun 2023 09:54:12 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm6892728edb.39.2023.06.30.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:54:11 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
 <ZJzu1ECR3Cp+IW+5@ovpn-8-18.pek2.redhat.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Date:   Fri, 30 Jun 2023 18:51:32 +0200
In-reply-to: <ZJzu1ECR3Cp+IW+5@ovpn-8-18.pek2.redhat.com>
Message-ID: <87ttuodh71.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Wed, Jun 28, 2023 at 09:06:48PM +0200, Andreas Hindborg wrote:
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
>> +	}
>> +}
>> +
>> +int ublk_revalidate_disk_zones(struct gendisk *disk)
>> +{
>> +	return blk_revalidate_disk_zones(disk, NULL);
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
>> +
>> +	bufsize =3D nr_zones * sizeof(struct blk_zone);
>> +	bufsize =3D
>> +		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
>> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT=
);
>
> This means 'blk_zone'(includes any sub-field type) is reused as part of u=
blk's UAPI,
> and it is smart, please document it around UBLK_IO_OP_REPORT_ZONES's defi=
nition.

Will do =F0=9F=91=8D

>
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
>
> This way is part of UAPI UBLK_IO_OP_REPORT_ZONES, please document it
> around UBLK_IO_OP_REPORT_ZONES.

OK =F0=9F=91=8D

>
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
>
> As Damien commented, zone append needs to be moved into this patch,
> so zoned depends on user copy feature, and you can simply fail to
> add device if user copy isn't enabled.
>
> So the above 'iod->addr =3D io->addr' can be removed.

Thanks =F0=9F=91=8D

>
>> +			return BLK_STS_OK;
>> +		default:
>> +			return BLK_STS_IOERR;
>> +		}
>> +	case REQ_OP_ZONE_APPEND:
>> +	case REQ_OP_ZONE_RESET_ALL:
>> +	case REQ_OP_DRV_OUT:
>> +		/* We do not support zone append or reset_all yet */
>> +		fallthrough;
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
>> +		disk_set_zoned(disk, BLK_ZONED_HM);
>> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_=
WRITE);
>> +		ret =3D ublk_revalidate_disk_zones(disk);
>> +		if (ret)
>> +			goto out_put_disk;
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
>
> Maybe you can simply borrow virtio_blk_zoned_characteristics definition
> here, and make several reserved words.
>
> But that is fine, given six u32 should be flexible enough compared with
> virtio_blk_zoned_characteristics.

I agree, this should be enough. One field will go to max append size, so
20 bytes left.

Best regards,
Andreas




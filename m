Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96CE74BD35
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 12:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGHKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 06:04:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E51BD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 03:04:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so44390461fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688810685; x=1691402685;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iQP2zIENZYVV/Y5StXC7ilmyyGjXSSC5Ulrd49gqdg=;
        b=d6J9Pdb5Bvy1NO4Ad20Szu9kGl7GF8YuydLT/O3/m8OlOYdv1+aHce18EXTMs9M2oj
         GeP3IkkZo1u+6AJPVgvDLrTET6mU5xQP3v9qourmeP/a2ZxtH0Ev4N8pDStDxObJ8NiJ
         8Qc6qDBuHssmx2hAr1Lu+XSnQkNRtVBFHZoqlTMfJVAeEebYmm/zA52M3590B1/mrrsO
         aVqdaJculoAWZnWLty9NvVRbkrzYD0UhFomgxK7jE8VNp7GzNlE/K2lED8s+ocr5b66T
         WHV4axrF80EPY5iGfV7AVlumXPBeQNJDfQ8r3WEoyv5cHRpIbHslMyV1xYlg7B3S6qlI
         n3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688810685; x=1691402685;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0iQP2zIENZYVV/Y5StXC7ilmyyGjXSSC5Ulrd49gqdg=;
        b=C0Q85fBAjZha/YDxcN0D0ZX39yXP9H01IryMurTSuMguA43qzvCVKS8ll0n8So0yTq
         0yjzLzFf6xLOSMLBPqp5o9dcEKRfHTyxiqrhtLvTQMr94NbKEMJc7U55+jAdoMr9fwYK
         P4bYby14n5mN5JKM158JhO47pGgBZ/vd1uEyOJfuRbp9CMQyvCV3XHXknu6+/pIuCd9p
         C1gw0AyITPtl4SIhcWxzcVFlMiDN267JfQCJ9eRLChrjk1l5W7DsXWn7wC/Y4wHosT9u
         UH2I+/UI9z44kkFac88AYRrLgXmXIgj9bHNWLBk8HV39r1h1uHiwRasJoj+Ugcpe8/eA
         tEPQ==
X-Gm-Message-State: ABy/qLao41gXJ2y9zFjZMPKJDMaQCDqihaBSzShp4jpENNf1C5/DOxuL
        2nG00exQ1FesobhYqe9NBMkBig==
X-Google-Smtp-Source: APBJJlGTEyKu/DDfNJQmooZiNT7TNBSuoJ127jBuffODAyaByi50EO+jebuW0wqawSFBnU3ExIo5JA==
X-Received: by 2002:a2e:99d2:0:b0:2b6:e0b0:ce04 with SMTP id l18-20020a2e99d2000000b002b6e0b0ce04mr5056870ljj.17.1688810685008;
        Sat, 08 Jul 2023 03:04:45 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id i6-20020a2e8086000000b002b6e121cf1fsm1140085ljg.4.2023.07.08.03.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 03:04:44 -0700 (PDT)
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-4-nmi@metaspace.dk>
 <ZKfwBzXC3CAo7cyY@ovpn-8-34.pek2.redhat.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v6 3/3] ublk: enable zoned storage support
Date:   Fri, 07 Jul 2023 17:04:41 +0200
In-reply-to: <ZKfwBzXC3CAo7cyY@ovpn-8-34.pek2.redhat.com>
Message-ID: <87sf9yzpl4.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Jul 06, 2023 at 03:09:30PM +0200, Andreas Hindborg wrote:
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
>>  drivers/block/Kconfig         |   4 +
>>  drivers/block/ublk_drv.c      | 341 ++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/ublk_cmd.h |  30 +++
>>  3 files changed, 363 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>> index 5b9d4aaebb81..3f7bedae8511 100644
>> --- a/drivers/block/Kconfig
>> +++ b/drivers/block/Kconfig
>> @@ -373,6 +373,7 @@ config BLK_DEV_RBD
>>  config BLK_DEV_UBLK
>>  	tristate "Userspace block driver (Experimental)"
>>  	select IO_URING
>> +	select BLK_DEV_UBLK_ZONED if BLK_DEV_ZONED
>>  	help
>>  	  io_uring based userspace block driver. Together with ublk server, ub=
lk
>>  	  has been working well, but interface with userspace or command data
>> @@ -402,6 +403,9 @@ config BLKDEV_UBLK_LEGACY_OPCODES
>>  	  suggested to enable N if your application(ublk server) switches to
>>  	  ioctl command encoding.
>>=20=20
>> +config BLK_DEV_UBLK_ZONED
>> +	bool
>> +
>>  source "drivers/block/rnbd/Kconfig"
>>=20=20
>>  endif # BLK_DEV
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 8d271901efac..a5adcfc976a5 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -56,22 +56,28 @@
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
>> +#define UBLK_PARAM_TYPE_ALL                                \
>> +	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>> +	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
>>=20=20
>>  struct ublk_rq_data {
>>  	struct llist_node node;
>>=20=20
>>  	struct kref ref;
>> +	__u32 operation;
>> +	__u64 sector;
>> +	__u32 nr_sectors;
>>  };
>
> Please put "operation" and "nr_sectors" together, then holes
> can be avoided.

Got it =F0=9F=91=8D

>
>>=20=20
>>  struct ublk_uring_cmd_pdu {
>>  	struct ublk_queue *ubq;
>>  };
>>=20=20
>> +
>
> ?

Sorry.

>
>>  /*
>>   * io command is active: sqe cmd is received, and its cqe isn't done
>>   *
>> @@ -110,6 +116,11 @@ struct ublk_uring_cmd_pdu {
>>   */
>>  #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>>=20=20
>> +/*
>> + * Set when IO is Zone Append
>> + */
>> +#define UBLK_IO_FLAG_ZONE_APPEND 0x10
>> +
>>  struct ublk_io {
>>  	/* userspace buffer address from io cmd */
>>  	__u64	addr;
>> @@ -184,6 +195,31 @@ struct ublk_params_header {
>>  	__u32	len;
>>  	__u32	types;
>>  };
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
>> +static int ublk_set_nr_zones(struct ublk_device *ub);
>> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
>> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub);
>> +static int ublk_revalidate_disk_zones(struct ublk_device *ub);
>> +
>> +#ifndef CONFIG_BLK_DEV_UBLK_ZONED
>> +
>> +#define ublk_report_zones (NULL)
>> +
>> +#else
>> +
>> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>> +		      unsigned int nr_zones, report_zones_cb cb, void *data);
>> +
>> +#endif
>
> Please merge the following "#ifdef CONFIG_BLK_DEV_UBLK_ZONED" with the
> above one, then you can avoid the above declarations. Meantime, we don't
> add code after MODULE_LICENSE().

Ok =F0=9F=91=8D

>
>>=20=20
>>  static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
>>  {
>> @@ -232,7 +268,7 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>>  		UBLK_TAG_BITS_MASK;
>>  }
>>=20=20
>> -static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>> +static int ublk_dev_param_basic_apply(struct ublk_device *ub)
>>  {
>>  	struct request_queue *q =3D ub->ub_disk->queue;
>>  	const struct ublk_param_basic *p =3D &ub->params.basic;
>> @@ -257,6 +293,11 @@ static void ublk_dev_param_basic_apply(struct ublk_=
device *ub)
>>  		set_disk_ro(ub->ub_disk, true);
>>=20=20
>>  	set_capacity(ub->ub_disk, p->dev_sectors);
>> +
>> +	if (ublk_dev_is_zoned(ub))
>> +		return ublk_set_nr_zones(ub);
>> +
>
> The above change can be moved into ublk_dev_param_zoned_apply() which
> is always done after ublk_dev_param_basic_apply().=20

Ok

>
>> +	return 0;
>>  }
>>=20=20
>>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
>> @@ -286,6 +327,9 @@ static int ublk_validate_params(const struct ublk_de=
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
>> @@ -304,19 +348,26 @@ static int ublk_validate_params(const struct ublk_=
device *ub)
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>>  		return -EINVAL;
>>=20=20
>> -	return 0;
>> +	return ublk_dev_param_zoned_validate(ub);
>
> Please follow current style of:
>
> 	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
> 		return ublk_dev_param_zoned_validate(ub);
>
> Then you can avoid lots of check on ublk_dev_params_zoned().

Ok, but then I need


	if (ublk_dev_is_zoned(ub) && !ublk_dev_params_zoned(ub))
		return -EINVAL;

here to check if user is forgetting zoned parameters for zoned ublk dev.
Or do you want to drop this check?

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
>> +	if (ublk_dev_params_zoned(ub))
>> +		return ublk_dev_param_zoned_apply(ub);
>> +
>>  	return 0;
>>  }
>>=20=20
>> @@ -487,6 +538,7 @@ static const struct block_device_operations ub_fops =
=3D {
>>  	.owner =3D	THIS_MODULE,
>>  	.open =3D		ublk_open,
>>  	.free_disk =3D	ublk_free_disk,
>> +	.report_zones =3D	ublk_report_zones,
>>  };
>>=20=20
>>  #define UBLK_MAX_PIN_PAGES	32
>> @@ -601,7 +653,8 @@ static inline bool ublk_need_map_req(const struct re=
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
>> @@ -685,6 +738,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue=
 *ubq, struct request *req)
>>  {
>>  	struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
>>  	struct ublk_io *io =3D &ubq->ios[req->tag];
>> +	struct ublk_rq_data *pdu =3D blk_mq_rq_to_pdu(req);
>>  	u32 ublk_op;
>>=20=20
>>  	switch (req_op(req)) {
>> @@ -703,6 +757,37 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
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
>
> BLK_STS_NOTSUPP should be returned, since in future we may support it,
> and userspace need to know what is wrong.

Ok

>
>> +	case REQ_OP_DRV_OUT:
>> +		/* We do not support reset_all and drv_out */
>> +		fallthrough;
>>  	default:
>>  		return BLK_STS_IOERR;
>>  	}
>> @@ -756,7 +841,8 @@ static inline void __ublk_complete_rq(struct request=
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
>> @@ -1120,6 +1206,11 @@ static void ublk_commit_completion(struct ublk_de=
vice *ub,
>>  	/* find the io request and complete */
>>  	req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>>=20=20
>> +	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND) {
>> +		req->__sector =3D ub_cmd->addr;
>> +		io->flags &=3D ~UBLK_IO_FLAG_ZONE_APPEND;
>> +	}
>> +
>>  	if (req && likely(!blk_should_fake_timeout(req->q)))
>>  		ublk_put_req_ref(ubq, req);
>>  }
>> @@ -1419,7 +1510,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
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
>> @@ -1542,11 +1634,14 @@ static inline bool ublk_check_ubuf_dir(const str=
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
>> @@ -1883,8 +1978,12 @@ static int ublk_ctrl_start_dev(struct ublk_device=
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
>> @@ -2045,6 +2144,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd =
*cmd)
>>  	if (ublk_dev_is_user_copy(ub))
>>  		ub->dev_info.flags &=3D ~UBLK_F_NEED_GET_DATA;
>>=20=20
>> +	/* Zoned storage support requires user copy feature */
>> +	if (ublk_dev_is_zoned(ub) &&
>> +	    (!IS_ENABLED(CONFIG_BLK_DEV_UBLK_ZONED) || !ublk_dev_is_user_copy(=
ub))) {
>> +		ret =3D -EINVAL;
>> +		goto out_free_dev_number;
>> +	}
>> +
>>  	/* We are not ready to support zero copy */
>>  	ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
>>=20=20
>> @@ -2629,3 +2735,214 @@ MODULE_PARM_DESC(ublks_max, "max number of ublk =
devices allowed to add(default:
>>=20=20
>>  MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
>>  MODULE_LICENSE("GPL");
>> +
>> +#ifdef CONFIG_BLK_DEV_UBLK_ZONED
>> +
>> +static int get_nr_zones(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_basic *p =3D &ub->params.basic;
>> +
>> +	if (!p->chunk_sectors)
>> +		return 0;
>
> There isn't zoned device if the above check fails, so no
> need to check it.

Ok, but this is called from `ublk_dev_param_zoned_validate()` to
validate user sets params correct. Should we not report error to user
space during parameter validation if user space sets chunk_sectors to
zero for zoned device?

>
>> +
>> +	/* Zone size is a power of 2 */
>> +	return p->dev_sectors >> ilog2(p->chunk_sectors);
>> +}
>> +
>> +static int ublk_set_nr_zones(struct ublk_device *ub)
>> +{
>> +	ub->ub_disk->nr_zones =3D get_nr_zones(ub);
>> +	if (!ub->ub_disk->nr_zones)
>> +		return -EINVAL;
>
> Is nr_zones one must for zoned?

Zero zones for a zoned storage device is not allowed, as far as I am
aware. Am I mistaken?

>
>> +
>> +	return 0;
>> +}
>> +
>> +static int ublk_revalidate_disk_zones(struct ublk_device *ub)
>> +{
>> +	if (ublk_dev_is_zoned(ub))
>> +		return blk_revalidate_disk_zones(ub->ub_disk, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +	int nr_zones;
>> +
>> +	if (ublk_dev_is_zoned(ub) && !ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +
>> +	if (!ublk_dev_is_zoned(ub) && ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +
>> +	if (!ublk_dev_params_zoned(ub))
>> +		return 0;
>
> The above can be simplified as single check if we follow current
> validate/apply code style:
>
> 	if (!ublk_dev_is_zoned(ub))
> 		return -EINVAL;

If we do that we will not be able to check if user space sets the
`UBLK_F_ZONED` flag without setting zoned parameters. Should I validate
that at call site or drop the check?

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
>> +
>> +	return 0;
>> +}
>> +
>> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +
>> +	disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
>> +	blk_queue_required_elevator_features(ub->ub_disk->queue,
>> +					     ELEVATOR_F_ZBD_SEQ_WRITE);
>> +	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>> +	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>> +	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_appe=
nd_sectors);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Based on virtblk_alloc_report_buffer */
>> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
>> +				      unsigned int nr_zones, size_t *buflen)
>> +{
>> +	struct request_queue *q =3D ublk->ub_disk->queue;
>> +	size_t bufsize;
>> +	void *buf;
>> +
>> +	nr_zones =3D min_t(unsigned int, nr_zones,
>> +			 ublk->ub_disk->nr_zones);
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
>> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
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
>> +	buffer =3D ublk_alloc_report_buffer(ub, nr_zones, &buffer_length);
>> +	if (!buffer)
>> +		return -ENOMEM;
>> +
>> +	max_zones_per_request =3D buffer_length / sizeof(struct blk_zone);
>> +
>> +	while (done_zones < nr_zones) {
>> +		unsigned int remaining_zones =3D nr_zones - done_zones;
>> +		unsigned int zones_in_request =3D
>> +			min_t(unsigned int, remaining_zones, max_zones_per_request);
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
>> +			/* A zero length zone means no more zones in this response */
>> +			if (!zone->len)
>> +				break;
>> +
>> +			ret =3D cb(zone, i, data);
>> +			if (ret)
>> +				goto out;
>> +
>> +			done_zones++;
>> +			sector +=3D zone_size_sectors;
>> +
>> +		}
>> +	}
>> +
>> +	ret =3D done_zones;
>> +
>> +out:
>> +	kvfree(buffer);
>> +	return ret;
>> +}
>> +
>> +#else
>> +
>> +static int ublk_set_nr_zones(struct ublk_device *ub)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> +	if (ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +	return 0;
>
> Please move the check outside by following current code style, then:
>
> 		return -EINVAL;
>

Ok, but then we move the check for user applying zoned params to
non-zoned device when CONFIG_BLK_DEV_ZONED to call site?

>> +}
>> +
>> +static int ublk_dev_param_zoned_apply(struct ublk_device *ub)
>> +{
>> +	if (ublk_dev_params_zoned(ub))
>> +		return -EINVAL;
>> +	return 0;
>
> It is enough to change=20
>
> 	return -EINVAL;
>
> directly.

Ok

Best regards,
Andreas

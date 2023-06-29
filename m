Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2B742354
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjF2JfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjF2Je4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:34:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FD4268A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:34:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d884a22e7so536628a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688031292; x=1690623292;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NxgmXX2xIduxBfUkp7Mrc8DoEv4aFObuF1TYwqmn08=;
        b=XxR6ecbl/YFtilZt3QKzZugeNznYC63gzer275tItQyaXLPRXmpNzqdcVFLaJ8gOuC
         dJQ5lKRvt0YvKwCCXy9Bbb1XbQo4aKCm04t2rucyuiLy7ixTc3SrZlBHdHJiMSmh+QBt
         MWzfCxaUZ58cSPdr9/Iqhe/4U7JJvB+M3tdFPyxKmXNXDKos1fWYL650lOCxDHcUETai
         AtSVdqfkmkMJbhtbhKBaR4inUXX+UKaLtWoIJe5jl3QEXU8MvdjAzR0kXVebpzPzkC9a
         fFI7Pk6xOE4RkaGAd9/wr5xyBF1yfy/6yG4PcBRxAYNqaYfjheBQ+Vcc8dbY8te9ZEBe
         xhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688031292; x=1690623292;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+NxgmXX2xIduxBfUkp7Mrc8DoEv4aFObuF1TYwqmn08=;
        b=kV+fWjZMLm2Pg8WDl2mU3kO+XFTs8UbaGxkIMrraWkqYAsm9PqZmjwGPUBc0btqUDg
         YDxaJzFyUZBNnFOHX8tGB8c9BLXWFaO7eJbJle0eRyholN4ERiJfGnIJmkyaNPcIi8it
         ray5ia0LFh96D8iU8BRsYXWglXwjjX8+x8qrvmxUATe4xdUMaZfCU4WuBI9XI5TxrPBq
         KmbsjH3JYq9f5LyASHzxdBdXecBJHkdSXf0Ky4it1HrLSl2qiNiZJk2nYF/A6ccz/2z9
         GPs4h1Ps70EHDuQWVLklIC1Aof63jCAmm9iJmKcUlSlY3uBNuuDaX0DsHqnynki1hLuE
         OhhQ==
X-Gm-Message-State: AC+VfDw0HYrqtuoTwNsDBVXhbxrd98ilxnHKbMIs8so3/m1GV0RPnUTA
        W3lF24K5NwlvJ7AgT0sK1Bneyw==
X-Google-Smtp-Source: ACHHUZ64i2MMBMjEy27nWO3IccAcvxFtMGhDkmw/XpsiTIa2OcDx8oydo5jJvQGOcpGRxu8R8U2MYA==
X-Received: by 2002:a17:907:2bce:b0:98e:2097:f23e with SMTP id gv14-20020a1709072bce00b0098e2097f23emr9512205ejc.77.1688031292229;
        Thu, 29 Jun 2023 02:34:52 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id d1-20020aa7d5c1000000b0051d9ee1c9d3sm396013eds.84.2023.06.29.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:34:51 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-5-nmi@metaspace.dk>
 <ZJzwcG2gIxXh8HbE@ovpn-8-18.pek2.redhat.com>
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
Subject: Re: [PATCH v4 4/4] ublk: add zone append
Date:   Thu, 29 Jun 2023 11:17:07 +0200
In-reply-to: <ZJzwcG2gIxXh8HbE@ovpn-8-18.pek2.redhat.com>
Message-ID: <87edluy5l3.fsf@metaspace.dk>
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

> On Wed, Jun 28, 2023 at 09:06:49PM +0200, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> Add zone append feature to ublk. This feature uses the `addr` field of `=
struct
>> ublksrv_io_cmd`. Therefore ublk must be used with the user copy
>> feature (UBLK_F_USER_COPY) for zone append to be available. Without this
>> feature, ublk will fail zone append requests.
>
> Given zone append is a must, please fail to add device in case of zoned
> and !user_copy, then we can make fast IO code path clean.

I will squash the patches and reject zone support if not user copy is
enabled =F0=9F=91=8D

>
>>=20
>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  drivers/block/ublk_drv-zoned.c | 11 +++++++++
>>  drivers/block/ublk_drv.c       | 43 ++++++++++++++++++++++++++++++----
>>  drivers/block/ublk_drv.h       |  1 +
>>  include/uapi/linux/ublk_cmd.h  |  3 ++-
>>  4 files changed, 52 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zon=
ed.c
>> index ea86bf4b3681..007e8fc7ff25 100644
>> --- a/drivers/block/ublk_drv-zoned.c
>> +++ b/drivers/block/ublk_drv-zoned.c
>> @@ -16,6 +16,16 @@ void ublk_set_nr_zones(struct ublk_device *ub)
>>  		ub->ub_disk->nr_zones =3D p->dev_sectors / p->chunk_sectors;
>>  }
>>=20=20
>> +int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
>> +{
>> +	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> +
>> +	if (! p->max_zone_append_sectors)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>  void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>>  {
>>  	const struct ublk_param_zoned *p =3D &ub->params.zoned;
>> @@ -23,6 +33,7 @@ void ublk_dev_param_zoned_apply(struct ublk_device *ub)
>>  	if (ub->dev_info.flags & UBLK_F_ZONED) {
>>  		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
>>  		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
>> +		blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_app=
end_sectors);
>>  	}
>>  }
>>=20=20
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 88fa39853c61..6a949669b47e 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -107,6 +107,11 @@ struct ublk_uring_cmd_pdu {
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
>> @@ -230,6 +235,8 @@ static void ublk_dev_param_discard_apply(struct ublk=
_device *ub)
>>=20=20
>>  static int ublk_validate_params(const struct ublk_device *ub)
>>  {
>> +	int ret =3D 0;
>> +
>>  	/* basic param is the only one which must be set */
>>  	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
>>  		const struct ublk_param_basic *p =3D &ub->params.basic;
>> @@ -260,6 +267,13 @@ static int ublk_validate_params(const struct ublk_d=
evice *ub)
>>  	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
>>  		return -EINVAL;
>>=20=20
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> +	    (ub->params.types & UBLK_PARAM_TYPE_ZONED)) {
>> +		ret =3D ublk_dev_param_zoned_validate(ub);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	return 0;
>>  }
>>=20=20
>> @@ -690,6 +704,11 @@ static blk_status_t ublk_setup_iod(struct ublk_queu=
e *ubq, struct request *req)
>>  			return BLK_STS_IOERR;
>>  		}
>>  	case REQ_OP_ZONE_APPEND:
>> +		if (!(ubq->dev->dev_info.flags & UBLK_F_USER_COPY))
>> +			return BLK_STS_IOERR;
>> +		ublk_op =3D UBLK_IO_OP_ZONE_APPEND;
>> +		io->flags |=3D UBLK_IO_FLAG_ZONE_APPEND;
>> +		break;
>>  	case REQ_OP_ZONE_RESET_ALL:
>>  	case REQ_OP_DRV_OUT:
>>  		/* We do not support zone append or reset_all yet */
>> @@ -1112,6 +1131,12 @@ static void ublk_commit_completion(struct ublk_de=
vice *ub,
>>  	/* find the io request and complete */
>>  	req =3D blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
>>=20=20
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>> +		if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
>> +			req->__sector =3D ub_cmd->addr;
>> +		io->flags &=3D ~UBLK_IO_FLAG_ZONE_APPEND;
>> +	}
>> +
>>  	if (req && likely(!blk_should_fake_timeout(req->q)))
>>  		ublk_put_req_ref(ubq, req);
>>  }
>> @@ -1411,7 +1436,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
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
>> @@ -1534,11 +1560,14 @@ static inline bool ublk_check_ubuf_dir(const str=
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
>> @@ -1867,6 +1896,12 @@ static int ublk_ctrl_start_dev(struct ublk_device=
 *ub, struct io_uring_cmd *cmd)
>>  	ub->dev_info.ublksrv_pid =3D ublksrv_pid;
>>  	ub->ub_disk =3D disk;
>>=20=20
>> +	ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>
> I guess the above line change isn't necessary?

It needs to go before the call to `ublk_revalidate_disk_zones()` because
that does IO to the disk in the form of a call to `report_zones()`. So I
can move it down a little bit.

Best regards,
Andreas

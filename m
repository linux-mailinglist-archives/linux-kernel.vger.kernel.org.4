Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D37439A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjF3Kf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjF3Kfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:35:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AD3ABA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121308; x=1719657308;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=qTusLHyVTGnjh/L9D8Btp4DY65QPFUcuGa+ASmIA3Vc=;
  b=S9E+/4jrqD7J8CZO1RXGYOnCwfvVpqzBGTgFoL+PlUh8vnw7HVq8RT1r
   vMiB8YdGzNfXSidLPp/MAGXqNXk0w76X8r41ihOKQJVgCTLKvErO6ot4G
   KUgkUC2u6Q65UIcCOAqwjTi51cAWximbFR1fDqgiUb2rnKS01LgYC5x2J
   mN19BtIoYRv77EyIwG8cguiuNFcz1hH1yGgfvcG/0uyV0HiZL6W/8s1NS
   g3SwpHiLtjqu7SBXs5BdJW/LkkxLrj3T4ozz5IX8y/GQ5hYFUKMiEtyLK
   8k3CJjwW5kR3wMrERl7TRoSEHs21yHkOt7+vSYP0q6FO/J6Y5kMHKuVO0
   A==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="237238631"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:35:04 +0800
IronPort-SDR: RnCFRU7pPCE8+Jl+1AVX+/t/SzXRwokznJwcXXjpOPXp5vu0knj3QgcXlNLqZG48FYEgsFZXyO
 0CyXY2V+UruPZYUmZ6uLMqzn6pMiM3yBjydurr8mMEZthUB3NHJqAaweSuN+OdQc5bSDpsvABy
 CF/+/NKZ5ToCbZyxDh2V4HxcMwMx2KBd4/cV4yoOBRq39j/RIOD71InVUUlusEmb/xyuP0SJIR
 c2sBZBJ3VV3J0seVjJgouvzVd54AOXQZptBQNHXIwyczlLoH0iKeQm1RrnRwHKjFQWPdaNwu/m
 2v0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:49:19 -0700
IronPort-SDR: vOuD3Luxl/Y+8WX+8KdBcaSFqKai7E5QYh7eSENYSoSD4+7Y20iUJpLUBsgFLXtTXXR6vbI1gm
 5tMvUXiD2d0evc45D4/5TJT6LKWUnwNgTSubdpz5dshGQ3HfjcX8G9y9L/iHudywg9Ef588Fq0
 2PwQSiGTHc9tGsxncAKHW34QRvsxEVPDsJ9RILdLCg2A1IUqGHBjnBCvH1gYnq5Y1G40Pc38hN
 cAwEJuH5+zKLxgDM0Kj/7vyyF0oEJGmWMCgJLbzP3GJsdIehYhA/hSMmgwh09MColtfNFvewoE
 yR8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:35:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4QssCC6sVWz1RtVn
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:35:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121288; x=1690713289; bh=qTusL
        HyVTGnjh/L9D8Btp4DY65QPFUcuGa+ASmIA3Vc=; b=Wv0gUC5INXkk8Vj3prTXP
        L+Ft5Pa8+OyuzJ3a0+wwoqpmgTObcGXJH6zcnIgaB9+REpkeRjMdd0wrDnmGpRay
        e0T/eGkX7zj0sfh2wwTepe0y3AXshEuq0tlmXWP7Urhy5FUh+2qvXHVCjaoPBpFU
        pxO4gnM+u1+rZwwttObKJCcFS7O5uwn/YQRsSf8T3efUH8W1JTFhxJXnK6rWIliZ
        Dh9of1P+NkMVy9kHPV84oBs3Ci4nBx7tZckbv12OsMEWDg1dvKwW2UsKdER2lzYZ
        Bq2yjR6YRomzJbAwV0BnMN+vylzZofdk9NqASZSDp8c2CrrpKZHnzd65c09tK/dV
        Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o0eJN3EiOzYF for <linux-kernel@vger.kernel.org>;
        Fri, 30 Jun 2023 03:34:48 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4QssBw2zs9z1RtVm;
        Fri, 30 Jun 2023 03:34:48 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:04:48 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans.Holmberg@wdc.com, Aravind.Ramesh@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@infradead.org,
        Matias.Bjorling@wdc.com, a.hindborg@samsung.com,
        linux-kernel@vger.kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, minwoo.im.dev@gmail.com, ming.lei@redhat.com
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
In-Reply-To: <62426D68-1E01-4804-9CFC-A1146770F362@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
 <62426D68-1E01-4804-9CFC-A1146770F362@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <623b588e451bb41785375cc0711114c8@opensource.wdc.com>
X-Sender: aravind.ramesh@opensource.wdc.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andreas Hindborg <a.hindborg@samsung.com 
> <mailto:a.hindborg@samsung.com>>
> 
> 
> Add zoned storage support to ublk: report_zones and operations:
> - REQ_OP_ZONE_OPEN
> - REQ_OP_ZONE_CLOSE
> - REQ_OP_ZONE_FINISH
> - REQ_OP_ZONE_RESET
> 
> 
> Note: This commit changes the ublk kernel module name from 
> `ublk_drv.ko` to
> `ublk.ko` in order to link multiple translation units into the module.
> 
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
> <mailto:a.hindborg@samsung.com>>
> ---
> MAINTAINERS | 1 +
> drivers/block/Kconfig | 4 +
> drivers/block/Makefile | 4 +-
> drivers/block/ublk_drv-zoned.c | 144 +++++++++++++++++++++++++++++++++
> drivers/block/ublk_drv.c | 64 +++++++++++++--
> drivers/block/ublk_drv.h | 15 ++++
> include/uapi/linux/ublk_cmd.h | 14 ++++
> 7 files changed, 239 insertions(+), 7 deletions(-)
> create mode 100644 drivers/block/ublk_drv-zoned.c
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ace71c90751c..db8a8deb5926 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21555,6 +21555,7 @@ S: Maintained
> F: Documentation/block/ublk.rst
> F: drivers/block/ublk_drv.c
> F: drivers/block/ublk_drv.h
> +F: drivers/block/ublk_drv-zoned.c

nitpick: checkpatch.pl gives a warning on the ordering of the files.
WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic 
order

> F: include/uapi/linux/ublk_cmd.h
> 
> 
> UCLINUX (M68KNOMMU AND COLDFIRE)
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 5b9d4aaebb81..c58dfd035557 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -402,6 +402,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
> suggested to enable N if your application(ublk server) switches to
> ioctl command encoding.
> 
> 
> +config BLK_DEV_UBLK_ZONED
> + def_bool y
> + depends on BLK_DEV_UBLK && BLK_DEV_ZONED
> +
> source "drivers/block/rnbd/Kconfig"
> 
> 
> endif # BLK_DEV
> diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> index 101612cba303..bc1649e20ec2 100644
> --- a/drivers/block/Makefile
> +++ b/drivers/block/Makefile
> @@ -37,6 +37,8 @@ obj-$(CONFIG_BLK_DEV_RNBD) += rnbd/
> 
> 
> obj-$(CONFIG_BLK_DEV_NULL_BLK) += null_blk/
> 
> 
> -obj-$(CONFIG_BLK_DEV_UBLK) += ublk_drv.o
> +obj-$(CONFIG_BLK_DEV_UBLK) += ublk.o
> +ublk-$(CONFIG_BLK_DEV_UBLK) += ublk_drv.o
> +ublk-$(CONFIG_BLK_DEV_UBLK_ZONED) += ublk_drv-zoned.o
> 
> 
> swim_mod-y := swim.o swim_asm.o
> diff --git a/drivers/block/ublk_drv-zoned.c 
> b/drivers/block/ublk_drv-zoned.c
> new file mode 100644
> index 000000000000..ea86bf4b3681
> --- /dev/null
> +++ b/drivers/block/ublk_drv-zoned.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com
> <mailto:a.hindborg@samsung.com>>
> + */
> +#include <linux/blkzoned.h>
> +#include <linux/ublk_cmd.h>
> +#include <linux/vmalloc.h>
> +
> +#include "ublk_drv.h"
> +
> +void ublk_set_nr_zones(struct ublk_device *ub)
> +{
> + const struct ublk_param_basic *p = &ub->params.basic;
> +
> + if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
> + ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
> +}
> +
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> +{
> + const struct ublk_param_zoned *p = &ub->params.zoned;
> +
> + if (ub->dev_info.flags & UBLK_F_ZONED) {
> + disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> + disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> + }
> +}
> +
> +int ublk_revalidate_disk_zones(struct gendisk *disk)
> +{
> + return blk_revalidate_disk_zones(disk, NULL);
> +}
> +
> +/* Based on virtblk_alloc_report_buffer */
> +static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
> + unsigned int nr_zones,
> + unsigned int zone_sectors, size_t *buflen)
> +{
> + struct request_queue *q = ublk->ub_disk->queue;
> + size_t bufsize;
> + void *buf;
> +
> + nr_zones = min_t(unsigned int, nr_zones,
> + get_capacity(ublk->ub_disk) >> ilog2(zone_sectors));
> +
> + bufsize = nr_zones * sizeof(struct blk_zone);
> + bufsize =
> + min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
> + bufsize = min_t(size_t, bufsize, queue_max_segments(q) << 
> PAGE_SHIFT);
> +
> + while (bufsize >= sizeof(struct blk_zone)) {
> + buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> + if (buf) {
> + *buflen = bufsize;
> + return buf;
> + }
> + bufsize >>= 1;
> + }
> +
> + bufsize = 0;
> + return NULL;
> +}
> +
> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
> + unsigned int nr_zones, report_zones_cb cb, void *data)
> +{
> + struct ublk_device *ub = disk->private_data;
> + unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
> + unsigned int first_zone = sector >> ilog2(zone_size_sectors);
> + unsigned int done_zones = 0;
> + unsigned int max_zones_per_request;
> + struct blk_zone *buffer;
> + size_t buffer_length;
> +
> + if (!(ub->dev_info.flags & UBLK_F_ZONED))
> + return -EOPNOTSUPP;
> +
> + nr_zones = min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
> + nr_zones);
> +
> + buffer = ublk_alloc_report_buffer(ub, nr_zones, zone_size_sectors,
> + &buffer_length);
> + if (!buffer)
> + return -ENOMEM;
> +
> + max_zones_per_request = buffer_length / sizeof(struct blk_zone);
> +
> + while (done_zones < nr_zones) {
> + unsigned int remaining_zones = nr_zones - done_zones;
> + unsigned int zones_in_request = min_t(
> + unsigned int, remaining_zones, max_zones_per_request);
> + int err = 0;
> + struct request *req;
> + struct ublk_rq_data *pdu;
> + blk_status_t status;
> +
> + memset(buffer, 0, buffer_length);
> +
> + req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> + if (IS_ERR(req))
> + return PTR_ERR(req);
> +
> + pdu = blk_mq_rq_to_pdu(req);
> + pdu->operation = UBLK_IO_OP_REPORT_ZONES;
> + pdu->sector = sector;
> + pdu->nr_sectors = remaining_zones * zone_size_sectors;
> +
> + err = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
> + GFP_KERNEL);
> + if (err) {
> + blk_mq_free_request(req);
> + kvfree(buffer);
> + return err;
> + }
> +
> + status = blk_execute_rq(req, 0);
> + err = blk_status_to_errno(status);
> + blk_mq_free_request(req);
> + if (err) {
> + kvfree(buffer);
> + return err;
> + }
> +
> + for (unsigned int i = 0; i < zones_in_request; i++) {
> + struct blk_zone *zone = buffer + i;
> +
> + err = cb(zone, i, data);
> + if (err)
> + return err;
> +
> + done_zones++;
> + sector += zone_size_sectors;
> +
> + /* A zero length zone means don't ask for more zones */
> + if (!zone->len) {
> + kvfree(buffer);
> + return done_zones;
> + }
> + }
> + }
> +
> + kvfree(buffer);
> + return done_zones;
> +}
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e519dc0d9fe7..88fa39853c61 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -57,12 +57,13 @@
> | UBLK_F_USER_RECOVERY_REISSUE \
> | UBLK_F_UNPRIVILEGED_DEV \
> | UBLK_F_CMD_IOCTL_ENCODE \
> - | UBLK_F_USER_COPY)
> + | UBLK_F_USER_COPY \
> + | UBLK_F_ZONED)
> 
> 
> /* All UBLK_PARAM_TYPE_* should be included here */
> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> - UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
> -
> +#define UBLK_PARAM_TYPE_ALL \
> + (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
> + UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
> 
> 
> struct ublk_uring_cmd_pdu {
> struct ublk_queue *ubq;
> @@ -209,6 +210,9 @@ static void ublk_dev_param_basic_apply(struct
> ublk_device *ub)
> set_disk_ro(ub->ub_disk, true);
> 
> 
> set_capacity(ub->ub_disk, p->dev_sectors);
> +
> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> + ublk_set_nr_zones(ub);
> }
> 
> 
> static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> @@ -269,6 +273,9 @@ static int ublk_apply_params(struct ublk_device 
> *ub)
> if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
> ublk_dev_param_discard_apply(ub);
> 
> 
> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types &
> UBLK_PARAM_TYPE_ZONED))
> + ublk_dev_param_zoned_apply(ub);
> +
> return 0;
> }
> 
> 
> @@ -439,6 +446,7 @@ static const struct block_device_operations ub_fops 
> = {
> .owner = THIS_MODULE,
> .open = ublk_open,
> .free_disk = ublk_free_disk,
> + .report_zones = ublk_report_zones,
> };
> 
> 
> #define UBLK_MAX_PIN_PAGES 32
> @@ -553,7 +561,8 @@ static inline bool ublk_need_map_req(const struct
> request *req)
> 
> 
> static inline bool ublk_need_unmap_req(const struct request *req)
> {
> - return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
> + return ublk_rq_has_data(req) &&
> + (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
> }
> 
> 
> static int ublk_map_io(const struct ublk_queue *ubq, const struct 
> request *req,
> @@ -637,6 +646,7 @@ static blk_status_t ublk_setup_iod(struct
> ublk_queue *ubq, struct request *req)
> {
> struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
> struct ublk_io *io = &ubq->ios[req->tag];
> + struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
> u32 ublk_op;
> 
> 
> switch (req_op(req)) {
> @@ -655,6 +665,35 @@ static blk_status_t ublk_setup_iod(struct
> ublk_queue *ubq, struct request *req)
> case REQ_OP_WRITE_ZEROES:
> ublk_op = UBLK_IO_OP_WRITE_ZEROES;
> break;
> + case REQ_OP_ZONE_OPEN:
> + ublk_op = UBLK_IO_OP_ZONE_OPEN;
> + break;
> + case REQ_OP_ZONE_CLOSE:
> + ublk_op = UBLK_IO_OP_ZONE_CLOSE;
> + break;
> + case REQ_OP_ZONE_FINISH:
> + ublk_op = UBLK_IO_OP_ZONE_FINISH;
> + break;
> + case REQ_OP_ZONE_RESET:
> + ublk_op = UBLK_IO_OP_ZONE_RESET;
> + break;
> + case REQ_OP_DRV_IN:
> + ublk_op = pdu->operation;
> + switch (ublk_op) {
> + case UBLK_IO_OP_REPORT_ZONES:
> + iod->op_flags = ublk_op | ublk_req_build_flags(req);
> + iod->nr_sectors = pdu->nr_sectors;
> + iod->start_sector = pdu->sector;
> + iod->addr = io->addr;
> + return BLK_STS_OK;
> + default:
> + return BLK_STS_IOERR;
> + }
> + case REQ_OP_ZONE_APPEND:
> + case REQ_OP_ZONE_RESET_ALL:
> + case REQ_OP_DRV_OUT:
> + /* We do not support zone append or reset_all yet */
> + fallthrough;
> default:
> return BLK_STS_IOERR;
> }
> @@ -708,7 +747,8 @@ static inline void __ublk_complete_rq(struct 
> request *req)
> *
> * Both the two needn't unmap.
> */
> - if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
> + if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
> + req_op(req) != REQ_OP_DRV_IN)
> goto exit;
> 
> 
> /* for READ request, writing data in iod->addr to rq buffers */
> @@ -1835,6 +1875,15 @@ static int ublk_ctrl_start_dev(struct
> ublk_device *ub, struct io_uring_cmd *cmd)
> if (ub->nr_privileged_daemon != ub->nr_queues_ready)
> set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> 
> 
> + if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> + ub->dev_info.flags & UBLK_F_ZONED) {
> + disk_set_zoned(disk, BLK_ZONED_HM);
> + blk_queue_required_elevator_features(disk->queue, 
> ELEVATOR_F_ZBD_SEQ_WRITE);
> + ret = ublk_revalidate_disk_zones(disk);
> + if (ret)
> + goto out_put_disk;
> + }
> +
> get_device(&ub->cdev_dev);
> ub->dev_info.state = UBLK_S_DEV_LIVE;
> ret = add_disk(disk);
> @@ -1997,6 +2046,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd 
> *cmd)
> if (ub->dev_info.flags & UBLK_F_USER_COPY)
> ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
> 
> 
> + if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> + ub->dev_info.flags &= ~UBLK_F_ZONED;
> +
> /* We are not ready to support zero copy */
> ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
> 
> 
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> index f81e62256456..7242430fd6b9 100644
> --- a/drivers/block/ublk_drv.h
> +++ b/drivers/block/ublk_drv.h
> @@ -50,6 +50,21 @@ struct ublk_rq_data {
> struct llist_node node;
> 
> 
> struct kref ref;
> + enum ublk_op operation;
> + __u64 sector;
> + __u32 nr_sectors;
> };
> 
> 
> +void ublk_set_nr_zones(struct ublk_device *ub);
> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> +int ublk_revalidate_disk_zones(struct gendisk *disk);
> +
> +#ifdef CONFIG_BLK_DEV_UBLK_ZONED
> +int ublk_report_zones(struct gendisk *disk, sector_t sector,
> + unsigned int nr_zones, report_zones_cb cb,
> + void *data);
> +#else
> +#define ublk_report_zones NULL
> +#endif
> +
> #endif
> diff --git a/include/uapi/linux/ublk_cmd.h 
> b/include/uapi/linux/ublk_cmd.h
> index 471b3b983045..436525afffe8 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -176,6 +176,11 @@
> /* Copy between request and user buffer by pread()/pwrite() */
> #define UBLK_F_USER_COPY (1UL << 7)
> 
> 
> +/*
> + * Enable zoned device support
> + */
> +#define UBLK_F_ZONED (1ULL << 8)
> +
> /* device state */
> #define UBLK_S_DEV_DEAD 0
> #define UBLK_S_DEV_LIVE 1
> @@ -242,6 +247,7 @@ enum ublk_op {
> UBLK_IO_OP_ZONE_APPEND = 13,
> UBLK_IO_OP_ZONE_RESET = 15,
> __UBLK_IO_OP_DRV_IN_START = 32,
> + UBLK_IO_OP_REPORT_ZONES = __UBLK_IO_OP_DRV_IN_START,
> __UBLK_IO_OP_DRV_IN_END = 96,
> __UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
> __UBLK_IO_OP_DRV_OUT_END = 160,
> @@ -342,6 +348,12 @@ struct ublk_param_devt {
> __u32 disk_minor;
> };
> 
> 
> +struct ublk_param_zoned {
> + __u32 max_open_zones;
> + __u32 max_active_zones;
> + __u8 reserved[24];
> +};
> +
> struct ublk_params {
> /*
> * Total length of parameters, userspace has to set 'len' for both
> @@ -353,11 +365,13 @@ struct ublk_params {
> #define UBLK_PARAM_TYPE_BASIC (1 << 0)
> #define UBLK_PARAM_TYPE_DISCARD (1 << 1)
> #define UBLK_PARAM_TYPE_DEVT (1 << 2)
> +#define UBLK_PARAM_TYPE_ZONED (1 << 3)
> __u32 types; /* types of parameter included */
> 
> 
> struct ublk_param_basic basic;
> struct ublk_param_discard discard;
> struct ublk_param_devt devt;
> + struct ublk_param_zoned zoned;
> };
> 
> 
> #endif
I applied the patches and verified it compiles with and without the 
CONFIG_BLK_DEV_ZONED flag.
Working on creating a ublk device also.

Regards,
Aravind

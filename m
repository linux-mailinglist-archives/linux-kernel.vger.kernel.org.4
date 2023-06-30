Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C065674399A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjF3Kel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjF3KeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:34:20 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73A63596
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121259; x=1719657259;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=Z5g4xvdBfyHP2dJZJe+ZeqXoJOTR+VtidURylkcbwpQ=;
  b=mhkwin8Q9s/heuaDnjdhNAHJ4HAIW7NnyEmvwm94NeVERxFlVlslJU8P
   dKdJ8Xc/no0jX5B0FXHRf/wbrmFFGQpFORr2KHliMpMqDK0UOTbcVoZXx
   uG6solWp/sELrwCHwfJfO6S2GIdv2c35T4WkY4pAhSF1S035t8MHcrcCJ
   bj0hyDQliQa5E0aWyrdOLAnoFmDgDYv58IqTEoXNZKqBbWP0szu0JwtCa
   WbnSjKXGjtCgwvkdQmBtIGvVYXrbnLgg7fMUGEKAOZ83828zBx5baYYu7
   uDC09dBLEvonOwwU15MNelgqlc6WGQGVHFY8Yo0FKWb2dTji2LNb9gzk6
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="235292451"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:34:19 +0800
IronPort-SDR: Bf067JFHzqANCIi00nXZHI4cOWsOMZSwtIo+cmp+SSUmy19vYC1uvd0taA1zmyG8U/bLWOC5SJ
 4xYxDKUUEYyeo7QxEWAfLl3scO/Oyoq1G4uCUak7XOPr78zmLSB2v+YrE8dB/F8PwSBzX06l+Q
 R2Sb+GF/vHaiuk/AGO5itGrUYrekwer4IPuCvAKTojHCmN9GDKQsi+I6Hzg2QDsS0w0XCIcpSO
 n9qQB45c2o7Ch1BGQB60HlOzrfOGaRo74l9nKRiSZrCZ//3hthvFyjmm8sbexYjK74yXqFFECB
 S9U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:48:32 -0700
IronPort-SDR: NJX/UPkf+ngqOJLABWyk+2b2OUIBAwy9NMV4SqQZFCfH5ZvJ+GGPAC95n7477jEbsoQZhCKC8+
 lBxWXTVooumBlnmH+5MIIMIA5eipbU6ilC2I47xdxZy4kOjpulYP2X7TdfTR4mYDlFVpKf/nzu
 DKDNn2wJ+RSd3gGgh5A4owTWNTxAKCqtUFu/DW7SRSNZYKrDDn+I5njgyjx01IdNswmoZOrXf7
 hun+spPRGS1Mx3yOtclDST4RWM41NIP/V5MsJLwUuk2DCGugzmZmeUsvrMweJuazhi9ph1ImST
 vnU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:34:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4QssBK0hZdz1RtVq
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:34:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121241; x=1690713242; bh=Z5g4x
        vdBfyHP2dJZJe+ZeqXoJOTR+VtidURylkcbwpQ=; b=GCI67IkBXSkAfj4h4EyaR
        LrYfACmQUY2Cu9JkCwQvFKzvQJwfxZ5klGWbBpPh9GpSq8c1leEwWQTiTa2aDMPX
        lEM94OAmLOdNOx7eH1NnzChmTLlojtmAEQsScjcyaLhYRzH7pqOMOzQwTEq6Fj0l
        4A+uewxvdI3ytxKv65XoFEaSogems5ga0F04rzbDVbXjVH3znkHNzPyfrWBfo2Cm
        gm2G/JTZ48nA7OUjEi599W05yjU2pStpf5ShtNMbkX13PudDhRUC6ZiIE1Wbxx2M
        sFaojx1gImZk51WlKKvmFl/TOFkYZgsFoilv5nEax9f8P3xl2jM+NdBZZd3TtOdQ
        g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0vnpIV1TStbE for <linux-kernel@vger.kernel.org>;
        Fri, 30 Jun 2023 03:34:01 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Qss9y1l01z1RtVn;
        Fri, 30 Jun 2023 03:33:58 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:03:58 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans.Holmberg@wdc.com, Aravind.Ramesh@wdc.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@infradead.org,
        Matias.Bjorling@wdc.com, a.hindborg@samsung.com,
        linux-kernel@vger.kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, minwoo.im.dev@gmail.com, ming.lei@redhat.com
Subject: Re: [PATCH v4 2/4] ublk: move types to shared header file
In-Reply-To: <6BEB9EA7-7445-498E-9492-21BC2B5D8B19@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-3-nmi@metaspace.dk>
 <6BEB9EA7-7445-498E-9492-21BC2B5D8B19@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <9b9c64db3cbe0afa87cb152e99c1c5e1@opensource.wdc.com>
X-Sender: aravind.ramesh@opensource.wdc.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
> This change is in preparation for ublk zoned storage support.
> 
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
> <mailto:a.hindborg@samsung.com>>
> ---
> MAINTAINERS | 1 +
> drivers/block/ublk_drv.c | 45 +-------------------------------
> drivers/block/ublk_drv.h | 55 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 57 insertions(+), 44 deletions(-)
> create mode 100644 drivers/block/ublk_drv.h
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27ef11624748..ace71c90751c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21554,6 +21554,7 @@ L: linux-block@vger.kernel.org
> <mailto:linux-block@vger.kernel.org>
> S: Maintained
> F: Documentation/block/ublk.rst
> F: drivers/block/ublk_drv.c
> +F: drivers/block/ublk_drv.h
> F: include/uapi/linux/ublk_cmd.h
> 
> 
> UCLINUX (M68KNOMMU AND COLDFIRE)
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1c823750c95a..e519dc0d9fe7 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -45,6 +45,7 @@
> #include <linux/namei.h>
> #include <linux/kref.h>
> #include <uapi/linux/ublk_cmd.h>
> +#include "ublk_drv.h"
> 
> 
> #define UBLK_MINORS (1U << MINORBITS)
> 
> 
> @@ -62,11 +63,6 @@
> #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
> UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
> 
> 
> -struct ublk_rq_data {
> - struct llist_node node;
> -
> - struct kref ref;
> -};
> 
> 
> struct ublk_uring_cmd_pdu {
> struct ublk_queue *ubq;
> @@ -140,45 +136,6 @@ struct ublk_queue {
> 
> 
> #define UBLK_DAEMON_MONITOR_PERIOD (5 * HZ)
> 
> 
> -struct ublk_device {
> - struct gendisk *ub_disk;
> -
> - char *__queues;
> -
> - unsigned int queue_size;
> - struct ublksrv_ctrl_dev_info dev_info;
> -
> - struct blk_mq_tag_set tag_set;
> -
> - struct cdev cdev;
> - struct device cdev_dev;
> -
> -#define UB_STATE_OPEN 0
> -#define UB_STATE_USED 1
> -#define UB_STATE_DELETED 2
> - unsigned long state;
> - int ub_number;
> -
> - struct mutex mutex;
> -
> - spinlock_t mm_lock;
> - struct mm_struct *mm;
> -
> - struct ublk_params params;
> -
> - struct completion completion;
> - unsigned int nr_queues_ready;
> - unsigned int nr_privileged_daemon;
> -
> - /*
> - * Our ubq->daemon may be killed without any notification, so
> - * monitor each queue's daemon periodically
> - */
> - struct delayed_work monitor_work;
> - struct work_struct quiesce_work;
> - struct work_struct stop_work;
> -};
> -
> /* header of ublk_params */
> struct ublk_params_header {
> __u32 len;
> diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
> new file mode 100644
> index 000000000000..f81e62256456
> --- /dev/null
> +++ b/drivers/block/ublk_drv.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _UBLK_DRV_H
> +#define _UBLK_DRV_H
> +
> +#include <uapi/linux/ublk_cmd.h>
> +#include <linux/blk-mq.h>
> +#include <linux/cdev.h>
> +
> +struct ublk_device {
> + struct gendisk *ub_disk;
> +
> + char *__queues;
> +
> + unsigned int queue_size;
> + struct ublksrv_ctrl_dev_info dev_info;
> +
> + struct blk_mq_tag_set tag_set;
> +
> + struct cdev cdev;
> + struct device cdev_dev;
> +
> +#define UB_STATE_OPEN 0
> +#define UB_STATE_USED 1
> +#define UB_STATE_DELETED 2
> + unsigned long state;
> + int ub_number;
> +
> + struct mutex mutex;
> +
> + spinlock_t mm_lock;
> + struct mm_struct *mm;
> +
> + struct ublk_params params;
> +
> + struct completion completion;
> + unsigned int nr_queues_ready;
> + unsigned int nr_privileged_daemon;
> +
> + /*
> + * Our ubq->daemon may be killed without any notification, so
> + * monitor each queue's daemon periodically
> + */
> + struct delayed_work monitor_work;
> + struct work_struct quiesce_work;
> + struct work_struct stop_work;
> +};
> +
> +struct ublk_rq_data {
> + struct llist_node node;
> +
> + struct kref ref;
> +};
> +
> +#endif

LGTM

Regards,
Aravind

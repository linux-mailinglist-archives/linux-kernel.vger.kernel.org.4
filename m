Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9A74397C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjF3Ke1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjF3KeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:34:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDC1358A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688121249; x=1719657249;
  h=mime-version:date:from:to:subject:in-reply-to:references:
   message-id:content-transfer-encoding;
  bh=ceBKz4A31miCsZPF9j9ZqKKds3qsGqNNGbiRMwK3xMk=;
  b=K10plyYc8Q5vTzgHKWD7IUrNnLU+cY4wstTtc2bS9UQCLEEu5pypSkxR
   9CjS0OoaWF51GfmKAbe4mKX3BDGY1jlDA+wZBSj7nDYGVIyjOn3Pqru6d
   qaIOelRRzhla1Oi52vAoN/TB3JK20wYGzAyE7lpPAxKVxBIUe243YIbxd
   fsSZGoG/iIHJNWRNeK3Pqu+cBGpExkMq04dnI84mnb28Hf/ssvF1cQSRs
   J9UN8sB0IIHcY3ZNSdQceiO3XprZX308Cymclf3dejBb8UYYmlHAi6Jsh
   vUFlV+1/54sYB58Jb7cUFyMUaaSrCDTchDbbloGIm8bL6DJYKhRF0Bz+i
   A==;
X-IronPort-AV: E=Sophos;i="6.01,170,1684771200"; 
   d="scan'208";a="241584341"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2023 18:34:07 +0800
IronPort-SDR: hsdF/YGBpmK5Qwq5ZuSufM8300OqOAVBzHY/4kqS90qmbAQ197uXHEBC0QvuePcxTmP0KsrQH7
 1aom+fJ1Sr6sIlmidw+8BMF/zoQrsKYv+xqkNKmYpyVOuT2yHi5gTkxBAsgBHueLYK2ahsk9wT
 fn+RC58eEW5peD/Za9HZmxM/yeUQYBwbe9DwkyfsS4txkyXM236M0FcL2BsZH/WvpgjB9nVTJ1
 d/lsZWVfNeXpuPrN7a2yQQUHPd7MwRKdEWtjOLe3H7NISDm7Cs6kUkZ+9LaJdmzv+miMu984qT
 NM8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 02:42:42 -0700
IronPort-SDR: BB/MP/DP9PYG2W8ozfSUvfosXIO1Tb3sHvHTNsZAycCfu2mf5plwhkng046DNLz7bdpgY7nBi/
 pCogec2t0JHZpi4sWufPyz7m9dnoThepfNXZx2w8rzukEAyM3PMmZHuOdNdkHzQQPaic8pCsih
 GBFElw8JW4IH6iryx3MkYbji8FwWnsDbbyk0Xw3pQBdbWdZX3RbBHX+wDrKZoowPAz5gRyeFMw
 PHxPZfubYmBHey30ywTL1QZKtZObkaCCO6gsf4h13lcsM5w7HwMlVtX9QPxjY18OjrvMsYyRXW
 9ug=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2023 03:34:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4QssB70jcMz1RtVq
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:34:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :message-id:user-agent:references:in-reply-to:subject:to:from
        :date:mime-version; s=dkim; t=1688121232; x=1690713233; bh=ceBKz
        4A31miCsZPF9j9ZqKKds3qsGqNNGbiRMwK3xMk=; b=maa8O8GQIguT3uhBLbP6u
        F36t6iHtVDrmF2+JaIqv/+7i3ka+G8H2fWjYZArBnpA0FOd58vKzhCpbapY90QZo
        9de7y2wugJBPX8iDBxJ//psz/InvWIHmDF4aoM6e0qzwdFXJuMc5cle0J6geSbwH
        r0+RaaGSg5AQ6i+Sn9uO826UAXyV2eEBwoqr7gAj84cThoDu+gjBFi7mOa558o+7
        ViTZp4gXih4/PNVzCiLkb8voiCJ7TvpKZUscX0UnA4EhpKCm+g0pDzAIGx2P/xYR
        q/TR/I3jsUX9qir1UUHkOPcBN0kF/yxAOOKYZec/15MsdZl9U5WpPjniEuSq3kx+
        Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FVkOV8h4GkPf for <linux-kernel@vger.kernel.org>;
        Fri, 30 Jun 2023 03:33:52 -0700 (PDT)
Received: from localhost (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Qss9k4K3Sz1RtVm;
        Fri, 30 Jun 2023 03:33:46 -0700 (PDT)
MIME-Version: 1.0
Date:   Fri, 30 Jun 2023 16:03:46 +0530
From:   aravind.ramesh@opensource.wdc.com
To:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        hch@infradead.org,
        =?UTF-8?Q?Mat?= =?UTF-8?Q?ias_Bj=C3=B8rling?= 
        <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
In-Reply-To: <83E5C27A-9AEF-4900-9652-78ACFF47E6B0@wdc.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <83E5C27A-9AEF-4900-9652-78ACFF47E6B0@wdc.com>
User-Agent: Roundcube Webmail
Message-ID: <a7bb663d522cde468b868e8e77110217@opensource.wdc.com>
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
> This change is in preparation for zoned storage support.
> 
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com
> <mailto:a.hindborg@samsung.com>>
> ---
> include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/include/uapi/linux/ublk_cmd.h 
> b/include/uapi/linux/ublk_cmd.h
> index 4b8558db90e1..471b3b983045 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
> __u64 reserved2;
> };
> 
> 
> -#define UBLK_IO_OP_READ 0
> -#define UBLK_IO_OP_WRITE 1
> -#define UBLK_IO_OP_FLUSH 2
> -#define UBLK_IO_OP_DISCARD 3
> -#define UBLK_IO_OP_WRITE_SAME 4
> -#define UBLK_IO_OP_WRITE_ZEROES 5
> +enum ublk_op {
> + UBLK_IO_OP_READ = 0,
> + UBLK_IO_OP_WRITE = 1,
> + UBLK_IO_OP_FLUSH = 2,
> + UBLK_IO_OP_DISCARD = 3,
> + UBLK_IO_OP_WRITE_SAME = 4,
> + UBLK_IO_OP_WRITE_ZEROES = 5,
> + UBLK_IO_OP_ZONE_OPEN = 10,
> + UBLK_IO_OP_ZONE_CLOSE = 11,
> + UBLK_IO_OP_ZONE_FINISH = 12,
> + UBLK_IO_OP_ZONE_APPEND = 13,

Curious to know if there is a reason to miss enum 14 here ?
And if UBLK_IO_OP_ZONE_APPEND is defined along with other operations
better to define that in patch 3 itself.

> + UBLK_IO_OP_ZONE_RESET = 15,
> + __UBLK_IO_OP_DRV_IN_START = 32,
> + __UBLK_IO_OP_DRV_IN_END = 96,
> + __UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
> + __UBLK_IO_OP_DRV_OUT_END = 160,
> +};
> 
> 
> #define UBLK_IO_F_FAILFAST_DEV (1U << 8)
> #define UBLK_IO_F_FAILFAST_TRANSPORT (1U << 9)

Regards,
Aravind

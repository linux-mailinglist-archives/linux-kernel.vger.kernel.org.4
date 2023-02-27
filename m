Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C96A45E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjB0PUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjB0PUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:20:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA7D332;
        Mon, 27 Feb 2023 07:20:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so10471411pjb.1;
        Mon, 27 Feb 2023 07:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Onz2c2NIK49Q2oK4K1CBA+0jCO26p8/NO+zVp/buPx4=;
        b=jm9vGz1zx6zbS56CjdsilirxVAsIO2VN4oS57YQk+Fo3vIJXhhGs3wG5r2gVY063XQ
         K6lKgfWneDUqIPSoqEBv5042bPDj6l0fZ7LIf1+XfDSpphg+p6ghukVNWzvUFL25gXSz
         oMVsQVQBhtyhIS7ZlP2n3M2SntSPPyx3o6644AOeImCq/s3XrT4UNMjgSZTMwE15A2TK
         Ri3GoWvjc9Xkl6RnyZrXNVj/hNhIdPscBI3LdNSioW6895dgxbHakTJNqoiPMTKVtw3X
         vixZG3D/Q6F7M0K9UVL3YkO8vZ924AIFAxf0vk4cb9Cq1hk/5r6C8EAxJsWIfLZJ3GTm
         pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onz2c2NIK49Q2oK4K1CBA+0jCO26p8/NO+zVp/buPx4=;
        b=aKPAwm+Wxwg/eJ0yGX2wHZ584ZkVhug42baBbBCOOsX/QdbmeIANkiPy8/dD1Jwjzw
         3VoncnNOUF5f23OSc403SiYq/UskRn0R3wv00Qoe2aPBKj9HqlmM+gDT+QHP92R0uCLl
         YQHZQoIbOJX+p/elCwExKcw8U5DJE+cX/F8LkJoQtpEqlAjuvPAf4uXLUp54SiLX7orL
         OCww0EumUNIfGGiNywS5yCof2dF2neOlwB/RJj1HveiWon6EcZNXR8a7/wWag9NXmmgz
         ngzUBt2NOpsxn940dgBjssBut4LWfzjlVbhFAyuXpbnIBsOpIXatxQ5EPgQY9NUXaShw
         eOzQ==
X-Gm-Message-State: AO0yUKUUb9OWBzFSdwWIepPvJyg61qPgaBsxW3Mgf+mla473w1rc0IUn
        ZVQizRUC/OUGfUIi4KeO4Tw=
X-Google-Smtp-Source: AK7set+se+idSnOuhRIcdxAxQKP1I0Jxn8vkheSk/TXZEjn8SnodiBxjX3D9ydRvgxBtKvOfM1J/bA==
X-Received: by 2002:a17:903:41c6:b0:19d:1a8e:836f with SMTP id u6-20020a17090341c600b0019d1a8e836fmr3549127ple.27.1677511242911;
        Mon, 27 Feb 2023 07:20:42 -0800 (PST)
Received: from minwoo-desktop ([1.237.94.73])
        by smtp.gmail.com with ESMTPSA id v13-20020a170902e8cd00b001963a178dfcsm4754525plg.244.2023.02.27.07.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:20:42 -0800 (PST)
Date:   Tue, 28 Feb 2023 00:20:35 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Message-ID: <Y/zKQx6IRirQpoIf@minwoo-desktop>
References: <20230224200502.391570-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230224200502.391570-1-nmi@metaspace.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-24 21:05:01, Andreas Hindborg wrote:
> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> +			     unsigned int nr_zones, report_zones_cb cb,
> +			     void *data)
> +{
> +	struct ublk_device *ub;
> +	unsigned int zone_size;
> +	unsigned int first_zone;
> +	int ret = 0;
> +
> +	ub = disk->private_data;
> +
> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
> +		return -EINVAL;
> +
> +	zone_size = disk->queue->limits.chunk_sectors;
> +	first_zone = sector >> ilog2(zone_size);
> +	nr_zones = min(ub->ub_disk->nr_zones - first_zone, nr_zones);
> +
> +	for (unsigned int i = 0; i < nr_zones; i++) {
> +		struct request *req;
> +		blk_status_t status;
> +		struct blk_zone info = {0};
> +
> +		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> +
> +		if (IS_ERR(req)) {
> +			ret = PTR_ERR(req);
> +			goto out;
> +		}

Can we just return directly just like above (-EINVAL)?

if (IS_ERR(req))
	return PTR_ERR(req);

> +
> +		req->__sector = sector;
> +
> +		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
> +				      GFP_KERNEL);
> +
> +		if (ret)
> +			goto out;

If we really have to use goto here, then I think we have choices:
put blk_mq_free_request(req); here or put it to the out: area.

> +
> +		status = blk_execute_rq(req, 0);
> +		ret = blk_status_to_errno(status);
> +		if (ret)
> +			goto out;
> +
> +		blk_mq_free_request(req);
> +
> +		ret = cb(&info, i, data);
> +		if (ret)
> +			goto out;
> +
> +		/* A zero length zone means don't ask for more zones */
> +		if (!info.len) {
> +			nr_zones = i;
> +			break;
> +		}
> +
> +		sector += zone_size;
> +	}
> +	ret = nr_zones;
> +
> + out:
> +	return ret;
> +}

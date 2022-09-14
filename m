Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7F5B8D90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiINQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiINQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5308816A1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663174369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FvOBdsojWCJABXZCp0RY/6Mq8SyzuH3awK4wP3zanGs=;
        b=e9MNSNkD0+1hqnmimwc1EodrrG2KhRbojFoYu4DV02fD3dosPbGxszhtuFOVditSKlfSOn
        nqSrAEKq4fZTMhsf765d1btT0aZvau0PnR7+5TN5YxjcmVZXzjOiAvcKHuu1OkgfXvCw7s
        5ZOF/XfIMKX2cW9yqXzeltwS8sKmsAo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-XGz6dK1gPmq-4rUQS5ht-A-1; Wed, 14 Sep 2022 12:52:48 -0400
X-MC-Unique: XGz6dK1gPmq-4rUQS5ht-A-1
Received: by mail-qk1-f198.google.com with SMTP id bm38-20020a05620a19a600b006ce9b8892b8so934232qkb.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FvOBdsojWCJABXZCp0RY/6Mq8SyzuH3awK4wP3zanGs=;
        b=4r8esXlotevyvhU0mQuqmHhui5My95uwEDsLnchb8RvCfp2kjOg85khqeJ0ZO9HyD1
         XkNSjtCFNSHJljyF2Hl53y+J6Z9iZ0QCkT9Apfk91qfI5Lw049h6iyG7YmFt+/uWPBfX
         92Kpi2Rb2aZ7KcLgPpMNVCAZs1F8Hq1yL1BUd3QSfU4m+w1TAbLDSfJUV543juTTiHY3
         XcHS/GAd4uiZ9fXKmiEUPyJZhnFlZNig6WFjguhjiNSdkOwN5HJS/tb/mNIzpB8yJnL1
         udWATrPOFaC2poXYBmCZbKMbh7UQAiOnAGk6G7ejhp9UH/mon2t4nT9Zjk8+pBSkxJYz
         A37w==
X-Gm-Message-State: ACgBeo2LJtdlyeX0+NXKmTm5mHFWxu4OgY8z0qbbpe70tNPPsxIcb3m8
        SfI4dgQmDBJbKJvlElxdyv8XIvQXFUvI7aOaPUJFiFg8EeRWdu2IPJ3Us9n7ogYgR2v+V119QEC
        sQQpmedS372N1M4DecuetVX8=
X-Received: by 2002:a05:620a:752:b0:6cd:d01f:9ae8 with SMTP id i18-20020a05620a075200b006cdd01f9ae8mr18106601qki.647.1663174368102;
        Wed, 14 Sep 2022 09:52:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7OhtIaLAfMpS1s3ldH71rZneL17H9vxVroz5KeWXEFxcJUMafg4zdP+aYPnGrtT3D+VdfmQQ==
X-Received: by 2002:a05:620a:752:b0:6cd:d01f:9ae8 with SMTP id i18-20020a05620a075200b006cdd01f9ae8mr18106584qki.647.1663174367856;
        Wed, 14 Sep 2022 09:52:47 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a2a1100b006ce9e880c6fsm449286qkp.111.2022.09.14.09.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:52:47 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:52:46 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, snitzer@kernel.org, linux-kernel@vger.kernel.org,
        Johannes.Thumshirn@wdc.com, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        gost.dev@samsung.com, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v13 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YyIG3i++QriS9Gyy@redhat.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5@eucas1p2.samsung.com>
 <20220912082204.51189-14-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082204.51189-14-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12 2022 at  4:22P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes.
> 
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> value.
> 
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
> 
> Device layout :-
> zone capacity = 3M
> zone size = 3M
> 
> |--------------|-------------|
> 0             3M            6M
> 
> Target layout :-
> zone capacity=3M
> zone size = 4M
> 
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
> 
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
> 
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zoned /dev/nvme<id>'
> 
> The target does not support partial mapping of the underlying
> device as there is no use-case for it.
> 
> Note:
> This target is not related to dm-zoned target, which exposes a zoned block
> device as a regular block device without any write constraint.
> 
> This target only exposes a different zone size than the underlying device.
> The underlying device's other constraints will be directly exposed to the
> target.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> ---

<snip>

> diff --git a/drivers/md/dm-po2zoned-target.c b/drivers/md/dm-po2zoned-target.c
> new file mode 100644
> index 000000000000..a48955faa978
> --- /dev/null
> +++ b/drivers/md/dm-po2zoned-target.c

<snip>

> +/*
> + * This target works on the complete zoned device. Partial mapping is not
> + * supported.
> + * Construct a zoned po2 logical device: <dev-path>
> + */
> +static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> +{
> +	struct dm_po2z_target *dmh = NULL;
> +	int ret;
> +	sector_t zone_size;
> +	sector_t dev_capacity;
> +
> +	if (argc != 1)
> +		return -EINVAL;
> +
> +	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
> +	if (!dmh)
> +		return -ENOMEM;
> +
> +	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
> +			    &dmh->dev);
> +	if (ret) {
> +		ti->error = "Device lookup failed";
> +		kfree(dmh);
> +		return ret;
> +	}
> +
> +	if (!bdev_is_zoned(dmh->dev->bdev)) {
> +		DMERR("%pg is not a zoned device", dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	zone_size = bdev_zone_sectors(dmh->dev->bdev);
> +	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
> +	if (ti->len != dev_capacity) {
> +		DMERR("%pg Partial mapping of the target is not supported",
> +		      dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	if (is_power_of_2(zone_size))
> +		DMWARN("%pg: underlying device has a power-of-2 number of sectors per zone",
> +		       dmh->dev->bdev);
> +
> +	dmh->zone_size = zone_size;
> +	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
> +	dmh->zone_size_po2_shift = ilog2(dmh->zone_size_po2);
> +	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
> +	ti->private = dmh;
> +	ti->max_io_len = dmh->zone_size_po2;
> +	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
> +	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
> +
> +	return 0;
> +}

The above error paths need to unwind the references or any other
resources acquired before failing.  Please see other targets for how
they handle sequencing of the needed operations (e.g. dm_put_device)
in the error path by using gotos, etc.

> +
> +static int dm_po2z_report_zones_cb(struct blk_zone *zone, unsigned int idx,
> +				   void *data)
> +{
> +	struct dm_report_zones_args *args = data;
> +	struct dm_target *ti = args->tgt;
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	zone->start = device_to_target_sect(ti, zone->start);
> +	zone->wp = device_to_target_sect(ti, zone->wp);
> +	zone->len = dmh->zone_size_po2;
> +	args->next_sector = zone->start + zone->len;
> +
> +	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
> +}
> +
> +static int dm_po2z_report_zones(struct dm_target *ti,
> +				struct dm_report_zones_args *args,
> +				unsigned int nr_zones)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	sector_t sect =
> +		po2_zone_no(dmh, dm_target_offset(ti, args->next_sector)) *
> +		dmh->zone_size;
> +
> +	return blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
> +				   dm_po2z_report_zones_cb, args);
> +}
> +
> +static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
> +			  blk_status_t *error)
> +{
> +	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		bio->bi_iter.bi_sector =
> +			device_to_target_sect(ti, bio->bi_iter.bi_sector);
> +
> +	return DM_ENDIO_DONE;
> +}
> +
> +static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	limits->chunk_sectors = dmh->zone_size_po2;
> +}

Are you certain you shouldn't at least be exposing a different
logical_block_size to upper layers?

> +
> +static void dm_po2z_status(struct dm_target *ti, status_type_t type,
> +			   unsigned int status_flags, char *result,
> +			   unsigned int maxlen)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	size_t sz = 0;
> +
> +	switch (type) {
> +	case STATUSTYPE_INFO:
> +		DMEMIT("%s %lld", dmh->dev->name,
> +		       (unsigned long long)dmh->zone_size_po2);
> +		break;

Wouldn't it be worthwhile to expose the zone sectors (native npo2 vs
simulated po2?) You merely roundup but never expose what you're using
(unless I'm missing something about generic "zoned" device
capabilities).

Mike


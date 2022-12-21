Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E26536E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLUTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiLUTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959424F39
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671650166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oziG1chFC2ZM07+R9uNqeu7rPi/qIDF9DD7uMEf+XEc=;
        b=F3t3XisD9VLixBDA7+YX3wVGcDOXODqrbepMRKb9yXQD4G8xZICOywV5AR8mSAwJj4UT9d
        Y6kzrCxCond5g0SD4wS2N0t23Vfit/HwDxf875l6QkufIVFjz6p/3VHAt4ZTGApOyh6wYS
        Dc7+Hm4PDp9dl+jkalxDtPcayKXGz3g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-gwddKEBOPRifL_nGIWB5ZA-1; Wed, 21 Dec 2022 14:16:04 -0500
X-MC-Unique: gwddKEBOPRifL_nGIWB5ZA-1
Received: by mail-ej1-f71.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso11114575ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oziG1chFC2ZM07+R9uNqeu7rPi/qIDF9DD7uMEf+XEc=;
        b=OVSZJUzqe7bbqDZHFpcB34Y3kbUSdxwoa3cvZLXNXYLszz4rfBurEKaxy7mVbv5c7a
         HgPn8KsC8KX9959QB3tsS8hg4rqdPR3n6ALr9xINQannGucaXsatVTJkfZWdwL5RckBW
         TaPvkUq3dXM9YB0TPyZAEs1ovGGpjBvrLWljB2HuYKMqErcnC1jjPmchQuKsL61AAW3i
         w5Aq/H1MXZOZxvEbWOyVfDD4FuA+HoO2I93DDsj8U4fcn4BEmNwrsZbkdOS/AIAvH6/+
         gnabvpUA9CNzt/tPKKsA/ZmBJivbAx8B37xxlOqfN1Yyy9sW3GZnRjoYPDIGFLto2l/b
         U3bw==
X-Gm-Message-State: AFqh2krJwLOtbegfnE0Le2I6OG4D3IjShjtMKdjOD79IvqxN8GbkXOKI
        bw2x7UfskmQ2vkQ2yD/g3CDjpuZAztSyMYpMiZiIeIzMBMKWmmHIqppZ2U0cS8rNjeeOH7xNUzg
        f16SmnvVgmHUSNNmnDUAcIdqE
X-Received: by 2002:a17:906:2b16:b0:81b:f931:cb08 with SMTP id a22-20020a1709062b1600b0081bf931cb08mr6654971ejg.47.1671650162802;
        Wed, 21 Dec 2022 11:16:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtYgpQRoajpgpg88+32ygzHFWgzyaQ5djHehL3dJahxgz4ZK1NR86JbdFjj+nGQkHTx6xrXhg==
X-Received: by 2002:a17:906:2b16:b0:81b:f931:cb08 with SMTP id a22-20020a1709062b1600b0081bf931cb08mr6654959ejg.47.1671650162588;
        Wed, 21 Dec 2022 11:16:02 -0800 (PST)
Received: from redhat.com ([2.55.175.215])
        by smtp.gmail.com with ESMTPSA id mh11-20020a170906eb8b00b007ad69e9d34dsm7460122ejb.54.2022.12.21.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:16:01 -0800 (PST)
Date:   Wed, 21 Dec 2022 14:15:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-block@vger.kernel.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED
 check
Message-ID: <20221221141451-mutt-send-email-mst@kernel.org>
References: <20221221145433.254805-1-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221145433.254805-1-lstoakes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> virtio zoned block device support is added by commit 0562d7bf1604
> ("virtio-blk: add support for zoned block devices") which adds
> VIRTIO_BLK_F_ZONED to the features array in virtio_blk.c but makes it
> conditional on CONFIG_BLK_DEV_ZONED.
> 
> In it virtblk_probe() calls virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)
> unconditionally, which invokes virtio_check_driver_offered_feature().
> This function checks whether virtio_blk.feature_table (assigned to
> the static features array) contains the specified feature enum, and if not
> _causes a kernel panic_ via BUG().
> 
> This therefore means that failing to enable CONFIG_BLK_DEV_ZONED while
> using virtio is a guaranteed kernel panic. Fix the issue by making the
> feature test also conditional on CONFIG_BLK_DEV_ZONED.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

I think this was fixed by
Message-ID: <20221220112340.518841-1-mst@redhat.com>


> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ff49052e26f7..94d210b10ebb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1580,7 +1580,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
>  		err = virtblk_probe_zoned_device(vdev, vblk, q);
>  		if (err)
>  			goto out_cleanup_disk;
> -- 
> 2.39.0


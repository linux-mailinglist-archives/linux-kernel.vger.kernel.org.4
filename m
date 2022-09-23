Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4205E7CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiIWOXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiIWOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E3213F739
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663943009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtMta5sZ7F8zj2gNZ2FUjMLqWdc2TCa8gGZwFvL5igI=;
        b=aYX7wOfswgVM4YQfQbOoM2q04BjNYwzKtoQjas3BcJq4veSejrV1YIhwfuIEcPyc6hQjhc
        GOeyOSu9cspMY8TlVUtAYZ+qqbTFgNh8atYwclRCifbf11glVV9kU+HRnvt5C80S/uMdlQ
        Mx6KkuLFXh+Kg0W5RkHesQaeEnRugug=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-XYXiCPg5NdiMR7t7hb2ySg-1; Fri, 23 Sep 2022 10:23:28 -0400
X-MC-Unique: XYXiCPg5NdiMR7t7hb2ySg-1
Received: by mail-qk1-f200.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so109773qko.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MtMta5sZ7F8zj2gNZ2FUjMLqWdc2TCa8gGZwFvL5igI=;
        b=uUojrMfsFX+6PR+Fppi6khwFKnOxJjQPjQ18VvBAOhoBCYvjp2QemNvYAVQo6WIKf6
         u38mjU61c34pbov505doKbPMA5qJp4s0LnmLMhLeQZHV8sb0BXV2radXblvYR8zRlND8
         FEaw3FE14y7V+eGhpuwRHvZtQDxbDu6HQgNT4BB9Nr86zHN5ROMnwt/tZkiPV8MfGjkl
         FrIbKahswcForfuRo4LVtOOTRYMk7pGpf9Fns5WD5k7OXLnAsuEfotQRbWqTxOU1WR9U
         J7GNwjTU85WL7o+o0HfnV1cJ7GOwJg9VaheP7cIPyWrb7FGCSQvh+fLHB4Vh7Gdg9aB8
         7CSg==
X-Gm-Message-State: ACrzQf0VhvQoQ8nrEROzEC5W4Eu8eXI2RtYe8bzr4y/zXCJGplWHM+GY
        46z+vgMojbm3kzDp2tUQtnHqS+aGotp3kEHRjuYUZ0D/Xj7JRcXl93PklEj2UBE43+vIKaXUOfu
        uc5jbeeynnaadJEYHp6sSnAo=
X-Received: by 2002:a37:ef18:0:b0:6ce:175f:409a with SMTP id j24-20020a37ef18000000b006ce175f409amr5781682qkk.572.1663943006715;
        Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7XaeBSmIgCS5xVoX7O37KV2Q4BatIbL+4W7934TQWhD9AMaj+EBoxQ49sZN/jgeEabR6YtNA==
X-Received: by 2002:a37:ef18:0:b0:6ce:175f:409a with SMTP id j24-20020a37ef18000000b006ce175f409amr5781650qkk.572.1663943006470;
        Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id y26-20020a37f61a000000b006ceb933a9fesm5847674qkj.81.2022.09.23.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:23:26 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:23:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 2/8] dm: Add support for block provisioning
Message-ID: <Yy3BXc9wf4PH6Rby@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-3-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-3-sarthakkukreti@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15 2022 at 12:48P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Add support to dm devices for REQ_OP_PROVISION. The default mode
> is to pass through the request and dm-thin will utilize it to provision
> blocks.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/md/dm-crypt.c         |  4 +-
>  drivers/md/dm-linear.c        |  1 +
>  drivers/md/dm-table.c         | 17 +++++++
>  drivers/md/dm-thin.c          | 86 +++++++++++++++++++++++++++++++++--
>  drivers/md/dm.c               |  4 ++
>  include/linux/device-mapper.h |  6 +++
>  6 files changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 159c6806c19b..357f0899cfb6 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -3081,6 +3081,8 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
>  	if (ret)
>  		return ret;
>  
> +	ti->num_provision_bios = 1;
> +
>  	while (opt_params--) {
>  		opt_string = dm_shift_arg(&as);
>  		if (!opt_string) {
> @@ -3384,7 +3386,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
>  	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
>  	 */
>  	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
> -	    bio_op(bio) == REQ_OP_DISCARD)) {
> +	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
>  		bio_set_dev(bio, cc->dev->bdev);
>  		if (bio_sectors(bio))
>  			bio->bi_iter.bi_sector = cc->start +
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 3212ef6aa81b..1aa782149428 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	ti->num_discard_bios = 1;
>  	ti->num_secure_erase_bios = 1;
>  	ti->num_write_zeroes_bios = 1;
> +	ti->num_provision_bios = 1;
>  	ti->private = lc;
>  	return 0;
>  
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..b7f9cb66b7ba 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1853,6 +1853,18 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
>  	return true;
>  }
>  
> +static bool dm_table_supports_provision(struct dm_table *t)
> +{
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->num_provision_bios)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

This needs to go a step further and verify a device in the stack
actually services REQ_OP_PROVISION.

Please see dm_table_supports_discards(): it iterates all devices in
the table and checks that support is advertised.

For discard, DM requires that _all_ devices in a table advertise
support (that is pretty strict and likely could be relaxed to _any_).

You'll need ti->provision_supported (like ->discards_supported) to
advertise actual support is provided by dm-thinp (even if underlying
devices don't support it).

And yeah, dm-thinp passdown support for REQ_OP_PROVISION can follow
later as needed (if there actual HW that would benefit from
REQ_OP_PROVISION).

Mike


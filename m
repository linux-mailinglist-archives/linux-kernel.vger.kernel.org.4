Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18A762CD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiKPVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiKPVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4A6BDC6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3w8sc6ccmIuZ5y2kueBPTj95unxJJNUHkbfTdAl9rzY=;
        b=TFhRjr3LYz/8XIDHpbY0xURtczjgR9p/vJbyg57CeU3TQbFZ3ROfje9WZjSlvnM3rTzl2p
        EaRIqRwrl17o0A6KsIO64KVLCFGkljTFNRB/vxqjiDIJbsl9IeJreqrjBaNe1yOku5eiHg
        dLalMgCHnjyBR1IkFZxgxWmaplepABU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-Y0vRPlu2Px2fDqKyT12gsA-1; Wed, 16 Nov 2022 16:49:59 -0500
X-MC-Unique: Y0vRPlu2Px2fDqKyT12gsA-1
Received: by mail-qv1-f72.google.com with SMTP id mh13-20020a056214564d00b004c60dd95880so2147qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w8sc6ccmIuZ5y2kueBPTj95unxJJNUHkbfTdAl9rzY=;
        b=xZvGS3+/2KZwKXWzN594gkm/DCubmK+wbEpcsYuWbsxuye4UCavLv7LWlkALTW2//g
         T27/iNXfAEp/umFVK9OIKrF3ha69ehXUGeUrDSzLcSTtpZVghZOUdgGSD8R4dFBIzk1G
         uNP3kxbysStgw32phHpvqOBVvs5iQ9SJtnarRXaZ16kzvaM5MvgEMv6q71YjR2G1EjNl
         WuxvjfCFgbFNq58Gt/I/eVYFHm1eaW1dvvMZBiX+PNHdeir8w9DgmWLNWJ0RMiX+bGY5
         yVqIpHtD2yMTvSJRjK4r7rbtyRc5+yUJxat2yXSF32EzOsJURcE4t7cT6j2gKK3MHKqk
         XRQw==
X-Gm-Message-State: ANoB5plzDTkmLxHi0Rx4JDSQsxQMLtmNrkl6UwUdtA5ODDBtnPGLKL8K
        6e6xZYqftudOKtQyQhxFrS7dUXD9OEKa4/mYc1+qd7UctBr24N0ucIfi96SejdASTXkdHS6EcSG
        sFYPMYA0iV187Qg02cPYd66s=
X-Received: by 2002:ad4:40c1:0:b0:4bb:84ba:a413 with SMTP id x1-20020ad440c1000000b004bb84baa413mr4745qvp.100.1668635398948;
        Wed, 16 Nov 2022 13:49:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4BnT2ggUvkeRYRo5Emt1G4E8xePLqRg/4lNDVcvpLW30ftub/O923iYrtX29gcyNWbOz9JeA==
X-Received: by 2002:ad4:40c1:0:b0:4bb:84ba:a413 with SMTP id x1-20020ad440c1000000b004bb84baa413mr4725qvp.100.1668635398766;
        Wed, 16 Nov 2022 13:49:58 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8699a000000b003a50b9f099esm9307666qtq.12.2022.11.16.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:49:58 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:49:57 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 06/10] dm: track per-add_disk holder relations in DM
Message-ID: <Y3VbBeuQvOLKH81a@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-7-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-7-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> dm is a bit special in that it opens the underlying devices.  Commit
> 89f871af1b26 ("dm: delay registering the gendisk") tried to accommodate
> that by allowing to add the holder to the list before add_gendisk and
> then just add them to sysfs once add_disk is called.  But that leads to
> really odd lifetime problems and error handling problems as we can't
> know the state of the kobjects and don't unwind properly.  To fix this
> switch to just registering all existing table_devices with the holder
> code right after add_disk, and remove them before calling del_gendisk.
> 
> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


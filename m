Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17F96FE4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEJUB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED83C0D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC72962EB9
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 20:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E5FC433D2;
        Wed, 10 May 2023 20:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683748881;
        bh=Id9taxsP+MRJIkexnLUvkZQ0UnMehHLrjhjdzSpNcvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aa+xtLo7pT0SICiA96xQy4I56D4Q84OEzN7RooA/cSj2p5FmuezQkEwhOqWbXeqZ6
         Ybdv9D/2v6MbaBTT+FS3CrogpYGyRLd6hMutyVr61bWzNagGf3q1+E6m3DkyBf4TvK
         OO9Ulh1Rb0fwhNv/T/OnDyIb6hRsFGoxsDWyyhjXWo9h8O40H7EKMEFsSIo7n37PHh
         7nru1maSpEjp6ol220pcLqj5K2uxaZslIn8Y6A6vwpI+iRwiS2G/jCxRpDObNqvIUt
         2uqWFNBp6GoHYR1vq9JiV/xlvsHmWeV8X332wZ45DoM186f7AJSJViWI0RS18wMh44
         osqyLAVIvzuWQ==
Date:   Wed, 10 May 2023 22:01:17 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Add missing documentation for structure fields
Message-ID: <ZFv4DfUcipQAII5R@kernel.org>
References: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
 <20230510120332-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510120332-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 12:04:21PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 10, 2023 at 02:23:12PM +0200, Simon Horman wrote:
> > Add missing documentation for the vqs_list_lock field of struct virtio_device,
> > and the validate field of struct virtio_driver.
> > 
> > ./scripts/kernel-doc says:
> > 
> >  .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> >  .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> >  2 warnings as Errors
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  include/linux/virtio.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b93238db94e3..0b2b82ee3220 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> >   * @config_enabled: configuration change reporting enabled
> >   * @config_change_pending: configuration change reported while disabled
> >   * @config_lock: protects configuration change reporting
> > + * @vqs_list_lock: protects @vqs.
> >   * @dev: underlying device.
> >   * @id: the device type identification (used to match it with a driver).
> >   * @config: the configuration ops for this device.
> > @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
> >   * @feature_table_size: number of entries in the feature table array.
> >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > + * @validate: the function to call to vaidate features at probe time.
> 
> typo
> 
> and this is called before probe actually not at probe time

Thanks, how about the following?

* @validate: the function to call to validate features

> >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> >   * @scan: optional function to call after successful probe; intended
> >   *    for virtio-scsi to invoke a scan.
> 

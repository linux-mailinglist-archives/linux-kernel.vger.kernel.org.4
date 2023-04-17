Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001806E4B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjDQOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDQOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA1F8692
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681741246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kX2QbjQkNKFUG0HI//3ah0FMVuwyYgCsq8gdQgA9+DY=;
        b=AcHAcjSs2X3fR5KZXVd94ELymd1JUmtFOxS3krsqm44hgdBjDCWTGnOviD0sCRHANHVG2z
        rjO/WBXX+LHzbvknSp8q0UcrKA8RvMQ/exSq0dJCLS5v1xcs2YnmgT1sUKeAIlj7pgK5vc
        D8AzHnLZlhGVbGvauiLsRuL5wuUlWes=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-ejlV0ahjPnOX_EOCLLd0sQ-1; Mon, 17 Apr 2023 10:20:43 -0400
X-MC-Unique: ejlV0ahjPnOX_EOCLLd0sQ-1
Received: by mail-il1-f200.google.com with SMTP id b9-20020a923409000000b00326156e3a8bso7248049ila.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681741242; x=1684333242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX2QbjQkNKFUG0HI//3ah0FMVuwyYgCsq8gdQgA9+DY=;
        b=CYgD1+PXPdDk9PgZDz2ZOrSfYoc5OcZDTLHlfK0a4sRsbxFKh9uC/9EaOO557o3c7c
         pVIIogCsQ0HXHz7nsytoyuXC8VgUDfcQ+koe4WI7AUlVuUuX1QIttzO5eezk6NIsdVh3
         kf6SVnG8+26uFiI4BaYLSBTHVeM5YWGasJS1RSZyVc8+ZxInvxjNTyijeB98IFob6HjR
         YRDKGCMQJfz/yRw4d4K7CmZLp3hXFjnz8CQtLRfAs3mylwmT9Uod4UU95v8otRMS1EKr
         XPLQtuWdVKNzCELtaLqKavWkI73BljzihukIjimc6lapobix8YqtvgXIf68Hs8dp2Wdr
         Ssdw==
X-Gm-Message-State: AAQBX9c6szi+uGzHbomJ3oNhIetUY13rKIrFQ1jRO+lK6MYxOhIyjPS4
        7ASf5XKWBn8NfL59tPPMfxERDmjnbzgVO1CfS4Py337oSNmSksH5qA5RSP4kXoZlJrI7jsskdDg
        XeHmeRQpd/juCbwPphbiXI2zH
X-Received: by 2002:a6b:6005:0:b0:760:ec52:254d with SMTP id r5-20020a6b6005000000b00760ec52254dmr3675139iog.2.1681741242424;
        Mon, 17 Apr 2023 07:20:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350bMGBwWtdzEZLE6LUMmtCHKf9b8M1jQWBOqR4lTGDGrgfArjIr2Yv/7d5NYkeWmN2JehMBRxg==
X-Received: by 2002:a6b:6005:0:b0:760:ec52:254d with SMTP id r5-20020a6b6005000000b00760ec52254dmr3675122iog.2.1681741242233;
        Mon, 17 Apr 2023 07:20:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y14-20020a02730e000000b0040611a31d5fsm3454447jab.80.2023.04.17.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:20:41 -0700 (PDT)
Date:   Mon, 17 Apr 2023 08:20:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <masahiroy@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>, <git@amd.com>,
        <harpreet.anand@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH v3] vfio/cdx: add support for CDX bus
Message-ID: <20230417082040.16e0ac18.alex.williamson@redhat.com>
In-Reply-To: <20230417083725.20193-1-nipun.gupta@amd.com>
References: <20230417083725.20193-1-nipun.gupta@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 14:07:25 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> +static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
> +			   unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> +	unsigned long minsz;
> +
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +	{
> +		struct vfio_device_info info;
> +
> +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		info.flags = VFIO_DEVICE_FLAGS_CDX;
> +		info.flags = VFIO_DEVICE_FLAGS_RESET;

Whoops, I think you mean |= for the latter one.  Thanks,

Alex


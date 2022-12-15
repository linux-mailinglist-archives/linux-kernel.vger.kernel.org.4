Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36F64D4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOBPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLOBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:14:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96479554EB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:14:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g10so5225369plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zL+Tdk+zCs8TNT7g6HIaDXRKNhigXeKBHzTFkpkj2gI=;
        b=UapGBTztJgPfjtfzXdgNAR9cPneWdf2FVDpFiB7Ypqb05B/VgDq/V/llETgCRqnXWE
         zIgINj2kFsj4glPxOBDilt3SXxhzkEsbyKJNDAkTEmJ0OSHqfjMEeO5mc6uv16xCf8EC
         vAuEHiWTdh8X4XdRNCQrfRzZ3o0XwAtRBgL/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL+Tdk+zCs8TNT7g6HIaDXRKNhigXeKBHzTFkpkj2gI=;
        b=HrzMycj7bBkofl17ggqjYFDc2gFLjLy3PVLnMZUL3bbrqny41YBp0r7mISRjOoPQ0c
         HHat+lwJZ+nrY3xFlJfa1axIX210gtuiA/rlxto7aDyeKc7fuX+bN1HaDqAheE8QVBMm
         DbYrGnZC30LMHkv1BCkWxNwC7iX1KoJydbVN9V896BcWQMy3txXcQkX4dtDS6AD7eHz0
         DJlBm6jwjyfQ9nqspVO7uJU89B4df+WyVn6Zi+eFIMMDLOLMt1Koj+vU3sDwB5oGv4d0
         6nFHLkLfeDG7tMTyIFJx4uKqiejrneK6eNgDo+LlL/d65YvR8doEkUcaR6uXFX5l52tP
         dCkQ==
X-Gm-Message-State: ANoB5pmKx3D1o/0VxfGLpTNW5O0wIDcuSOh3vkmqxG9hsHSq7j5sBWj+
        Ie9DA4CAyVInmZOuZVrpKXzc8A==
X-Google-Smtp-Source: AA0mqf4dzoANwHiq9DDjTNy8sJ66CZ8Ke5Yjs7gvMynAYN7lBFOtJ+6+OdroCuy2+6wLko9U2Hdq/A==
X-Received: by 2002:a05:6a20:9c89:b0:9d:efbf:7876 with SMTP id mj9-20020a056a209c8900b0009defbf7876mr31924066pzb.43.1671066898121;
        Wed, 14 Dec 2022 17:14:58 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id a10-20020aa794aa000000b00576df4543d4sm429133pfl.166.2022.12.14.17.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 17:14:57 -0800 (PST)
Date:   Thu, 15 Dec 2022 10:14:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Yunke Cao <yunkec@chromium.org>, Ming Lei <tom.leiming@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Do not alloc dev->status
Message-ID: <Y5p1DVWXuYSzkRO4@google.com>
References: <20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/14 14:37), Ricardo Ribalda wrote:
[..]
> +struct uvc_status_streaming {
> +	u8	button;
> +} __packed;
> +
> +struct uvc_status_control {
> +	u8	bSelector;
> +	u8	bAttribute;
> +	u8	bValue[11];
> +} __packed;
> +
> +struct uvc_status {
> +	u8	bStatusType;
> +	u8	bOriginator;
> +	u8	bEvent;
> +	union {
> +		struct uvc_status_control control;
> +		struct uvc_status_streaming streaming;
> +	};
> +} __packed;
> +
>  struct uvc_device {
>  	struct usb_device *udev;
>  	struct usb_interface *intf;
> @@ -559,7 +579,7 @@ struct uvc_device {
>  	/* Status Interrupt Endpoint */
>  	struct usb_host_endpoint *int_ep;
>  	struct urb *int_urb;
> -	u8 *status;
> +
>  	struct input_dev *input;
>  	char input_phys[64];
>  
> @@ -572,6 +592,12 @@ struct uvc_device {
>  	} async_ctrl;
>  
>  	struct uvc_entity *gpio_unit;
> +
> +	/*
> +	 * Ensure that status is aligned, making it safe to use with
> +	 * non-coherent DMA.
> +	 */
> +	struct uvc_status status __aligned(ARCH_KMALLOC_MINALIGN);

	____cacheline_aligned ?

I don't see anyone using ARCH_KMALLOC_MINALIGN except for slab.h

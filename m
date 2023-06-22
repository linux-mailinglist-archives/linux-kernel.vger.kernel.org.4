Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E303873ACB4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFVWvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjFVWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:51:18 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA41BD3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:50:38 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6300465243eso209806d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 15:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687474237; x=1690066237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9x9QfSSVUpTeAWdqCixUHSwi7foPPLLpLOSUdEXv8WE=;
        b=WUvGAV6sUSx4GZ+ymKgR2k6r8qrSDXV1628oH4zeSpiqHZ2DJBG+e0eej38xUsEjSe
         NL1hq5K+W/reggbSTNkHcsRZBaFUY7KfhNdnRF8FCrTjghcCx9Ss3/sAZbF5tdp0H31f
         80Xr0WVubOYPzkqLczVCyo/vl1Ef8FOpsjL/XeqDAICkwvcGf4bGX6kG5/gyT1MvO+LF
         txxc/lr/xJh6yoIIHIzKhRy60Vm8lBK6jb+8p50txGYSey+b3caNOb9VbRj65mT29WF0
         M3exU1ApLfAyRdTW2v5TzpHVdeY7guX3UDA0Amg+zm/AM8EqD8H58qNXLrro5hxLoREj
         PyjA==
X-Gm-Message-State: AC+VfDy8rMFHgqcRxI92/lbYdE5tuaTngwL9mud5CmIXniu4bMD06zfj
        siymYfzF8KFoQOIBC/yc4fQy
X-Google-Smtp-Source: ACHHUZ5wU337FIxFIJZQbmKE670bOEaoz4yGFxNkDChOmuLZrnAXBAhPW8u4+uoVVHUQbDgFJVqDGA==
X-Received: by 2002:a05:6214:20ae:b0:62f:fe87:67e9 with SMTP id 14-20020a05621420ae00b0062ffe8767e9mr21122003qvd.44.1687474237072;
        Thu, 22 Jun 2023 15:50:37 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id i20-20020a0cf394000000b0063013c621fasm4263594qvk.68.2023.06.22.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 15:50:36 -0700 (PDT)
Date:   Thu, 22 Jun 2023 18:50:35 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] device-mapper: Avoid pointer arithmetic overflow
Message-ID: <ZJTQO5sk3ugSrXjz@redhat.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
 <20230603145244.1538-3-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603145244.1538-3-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03 2023 at 10:52P -0400,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> Especially on 32-bit systems, it is possible for the pointer arithmetic
> to overflow and cause a userspace pointer to be dereferenced in the
> kernel.
> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> ---
>  drivers/md/dm-ioctl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc..64e8f16d344c47057de5e2d29e3d63202197dca0 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -1396,6 +1396,25 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
>  {
>  	static_assert(_Alignof(struct dm_target_spec) <= 8,
>  		      "struct dm_target_spec has excessive alignment requirements");
> +	static_assert(offsetof(struct dm_ioctl, data) >= sizeof(struct dm_target_spec),
> +		      "struct dm_target_spec too big");

I'm struggling to see the point for this compile-time check?
Especially when you consider (on x86_64):

sizeof(struct dm_target_spec) = 40
offsetof(struct dm_ioctl, data) = 305

Just feels like there is no utility offered by adding this check.

SO I've dropped it.  But if you feel there is some inherent value
please let me know.

Thanks,
Mike

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40C63A671
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiK1KyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiK1KyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F74175A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669632801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDfD1JOkqPMGxzR8BVcFFJShtzyZOZFKwtYn5KBR2Gs=;
        b=brGz8uhL34UtHRMJvGbNGARrBUmm73I7Y+Oqz5jRgHNJ5TF2j6bSodYnabg3Mfi/O+C+rk
        A5HVagftFg3jsRUTV7h4HNxRVOhR6MfJkpLIVZ3y++oZHociVA2NpNuGQ0/W82yg67fI68
        +TEp71NTN7l1r1KuMiCn7+aw/iA3iek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-4a2mxg1SPjOSyCLpzMoOqg-1; Mon, 28 Nov 2022 05:53:20 -0500
X-MC-Unique: 4a2mxg1SPjOSyCLpzMoOqg-1
Received: by mail-wm1-f72.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so6141953wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDfD1JOkqPMGxzR8BVcFFJShtzyZOZFKwtYn5KBR2Gs=;
        b=bgXHGGsu0+wK+k6UvpKYc8BvCqCOH5DW+AioEasTcM8xL/onx5gwxStu5nkhX1b2iQ
         i9UR7Ab/Vl00ZFEtG1W6W+s60sdqbh3txlGkYp4ZKU9r0RpkT1yfgefjd4ScR9CqRx9y
         g9JSXA/26QtXg9QH0uEc52VerZNWzsnkuiVHJojm7W0r1yZgWa2jDBVqyk2hLI+XVLbK
         RRlTfsV/0jVhi4kqdwKM1v97FA32Ab24WDlWbTft9bnfDSmSf5Jr7qqcX2o8pG/HQXeK
         L7XlrnbQdSMrW+gPr5X+ShbGuOOhUdF7/55EBbAdZnLdIU/LyPeFzthJjyU6K5NtcQLd
         tJIw==
X-Gm-Message-State: ANoB5pmZ1qhN2KP+oxGJnQ4CUIJceymdnP5ZAjiu5Flg8MPWMRUZ+dP6
        CtKcMXAFffyi8dreqLz/ZA+6qrEcbcoe/Fa5axeGIvxo8bY2+iTRWStWcKLaQaZ6KsLDThklESD
        /wg4SfQXydU5BhAEf42/wrwDW
X-Received: by 2002:a05:6000:181:b0:241:c6f9:3e5a with SMTP id p1-20020a056000018100b00241c6f93e5amr21815620wrx.157.1669632798959;
        Mon, 28 Nov 2022 02:53:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6gWk1ySTRc2DfRA9Ss8vYdNRCoIrlRwT5xJgp0LUb00UHbS4nCbgmdTHrvXKHl8njzMTuT8w==
X-Received: by 2002:a05:6000:181:b0:241:c6f9:3e5a with SMTP id p1-20020a056000018100b00241c6f93e5amr21815603wrx.157.1669632798764;
        Mon, 28 Nov 2022 02:53:18 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id k17-20020a05600c1c9100b003c6b874a0dfsm19180098wms.14.2022.11.28.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:53:18 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:53:12 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
>Add a limit to 'config->vq_num' which is user controlled data which
>comes from an vduse_ioctl to prevent large memory allocations.
>
>This is found using static analysis with smatch.
>
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>---
>v1->v2: Change title of the commit and description, add a limit to
>	vq_num.
>
>Note: I think here 0xffff is the max size of vring =  no: of vqueues.
>Only compile and boot tested.
>---
> drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
>index 35dceee3ed56..31017ebc4d7c 100644
>--- a/drivers/vdpa/vdpa_user/vduse_dev.c
>+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>@@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
> 	if (config->config_size > PAGE_SIZE)
> 		return false;
>
>+	if (config->vq_num > 0xffff)

What about using U16_MAX here?

Thanks,
Stefano

>+		return false;
>+
> 	if (!device_is_allowed(config->device_id))
> 		return false;
>
>-- 
>2.38.1
>


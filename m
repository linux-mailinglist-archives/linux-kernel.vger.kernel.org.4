Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E326693A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbjAMKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjAMKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2549DE08D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673604080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EczEE9EexjVmlZw39NUVKXIGqT7ZbUsB1oWT/kRdJFY=;
        b=Q9agzKqq/qeeLGjpwDePvfVm/TD/KR0SX3nIgBOO/RsriazZEoXk6rpEgoLjlbTg3emWUP
        EBbWinavwq/etksc7BN5v3doK9/NYs36DQZsKBWpAxTA/fHUabdNINH/49qqigASmn4hwM
        2+zzlsnEbHnyG4Pp/jgaCoIr5RSgu3A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-nsg2xUxxPPiOgNYNX2HCkw-1; Fri, 13 Jan 2023 05:01:18 -0500
X-MC-Unique: nsg2xUxxPPiOgNYNX2HCkw-1
Received: by mail-wr1-f69.google.com with SMTP id g24-20020adfa498000000b002bbeb5fc4b7so3451422wrb.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EczEE9EexjVmlZw39NUVKXIGqT7ZbUsB1oWT/kRdJFY=;
        b=wxmYzMIc2xLSbAgCjpXO8DyajR2k9o9s+SCdmB1iVltUsJRwwUaZ8wsmz1s6oTNyWQ
         TfG21NObgo8qPd2J9Jf/Ce0lOPS9081SAzbehoteju8x/cVZ71SyRwpKgMYd7AX2LDIG
         OyMI0/jXvTkq9xaFn+YNwer3zJMI+gzQdiPHJ+XV0/Wyc6mAA8jDgGBly1e8tWmCoB6J
         1w07c3vE9JtyXJOP2F4LZGvHQy98wSPo2iCSq4DgHiB/Lgig+p0R7EF6/yNlrHezme+9
         ld2QkL3vmexp4Do24PjnRcybeZu65DkEPQBAoICgRmAkSaL1O7OIhWA/r4rAeup56vDC
         8GEg==
X-Gm-Message-State: AFqh2kqHeKwieCWTV50KPSGRcjnAjv+Cp0YI7hQufR0N8tIRrJ0V6uke
        Ki0FlC/M2og42OlZTHP/LktgUnSe0wkfqX2YDJM91tJvKGw+LSGxI0KDTJUjCX9Uy2QD4thZKt9
        DJC8RCLUJF4ow6VIKy81weCtg
X-Received: by 2002:a5d:640d:0:b0:2bd:e5d5:78ca with SMTP id z13-20020a5d640d000000b002bde5d578camr437850wru.26.1673604077138;
        Fri, 13 Jan 2023 02:01:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXusl9tAUcjB8IanuOa9qP/xbsfov7bLo4IM93BQPLAyHtEc1TcEnk77dREtGbmxr3vg/WJRxw==
X-Received: by 2002:a5d:640d:0:b0:2bd:e5d5:78ca with SMTP id z13-20020a5d640d000000b002bde5d578camr437833wru.26.1673604076912;
        Fri, 13 Jan 2023 02:01:16 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it. [79.46.200.244])
        by smtp.gmail.com with ESMTPSA id j14-20020adff00e000000b0024cb961b6aesm18126891wro.104.2023.01.13.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:01:16 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:01:13 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     sebastien.boeuf@intel.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH v6 1/4] vdpa: Add resume operation
Message-ID: <20230113100113.cdnkwrbqkktp3gnc@sgarzare-redhat>
References: <cover.1672742878.git.sebastien.boeuf@intel.com>
 <6e05c4b31b47f3e29cb2bd7ebd56c81f84b8f48a.1672742878.git.sebastien.boeuf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6e05c4b31b47f3e29cb2bd7ebd56c81f84b8f48a.1672742878.git.sebastien.boeuf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:51:05AM +0100, sebastien.boeuf@intel.com wrote:
>From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
>Add a new operation to allow a vDPA device to be resumed after it has
>been suspended. Trying to resume a device that wasn't suspended will
>result in a no-op.
>
>This operation is optional. If it's not implemented, the associated
>backend feature bit will not be exposed. And if the feature bit is not
>exposed, invoking this operation will return an error.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
>---
> include/linux/vdpa.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 6d0f5e4e82c2..96d308cbf97b 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -219,7 +219,10 @@ struct vdpa_map_file {
>  * @reset:			Reset device
>  *				@vdev: vdpa device
>  *				Returns integer: success (0) or error (< 0)
>- * @suspend:			Suspend or resume the device (optional)
>+ * @suspend:			Suspend the device (optional)
>+ *				@vdev: vdpa device
>+ *				Returns integer: success (0) or error (< 0)
>+ * @resume:			Resume the device (optional)
>  *				@vdev: vdpa device
>  *				Returns integer: success (0) or error (< 0)
>  * @get_config_size:		Get the size of the configuration space includes
>@@ -324,6 +327,7 @@ struct vdpa_config_ops {
> 	void (*set_status)(struct vdpa_device *vdev, u8 status);
> 	int (*reset)(struct vdpa_device *vdev);
> 	int (*suspend)(struct vdpa_device *vdev);
>+	int (*resume)(struct vdpa_device *vdev);
> 	size_t (*get_config_size)(struct vdpa_device *vdev);
> 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> 			   void *buf, unsigned int len);
>-- 
>2.37.2
>
>---------------------------------------------------------------------
>Intel Corporation SAS (French simplified joint stock company)
>Registered headquarters: "Les Montalets"- 2, rue de Paris,
>92196 Meudon Cedex, France
>Registration Number:  302 456 199 R.C.S. NANTERRE
>Capital: 5 208 026.16 Euros
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.
>


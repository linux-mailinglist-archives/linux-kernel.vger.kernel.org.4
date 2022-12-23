Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF2654D86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiLWIfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiLWIfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B05FA7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671784506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=accKtY0Nk1Ttaf4aO5Gw1z4PmDYGpk3kZSawW3XXd1Q=;
        b=JpXN9XLDZj2+mtYNzx78152EDvho0cwa6bdHwTHm9sEW/QYe83V4u24YWfK1tiCgzaLDw2
        Bf39zWmVcigfzVVNPUriHNX0M1iCQTpsZ+Dq2dcEt5rqlyoLmOEVQGHly1fKw9CgV221qX
        Dh94qd7mEVTDqU3lXB62ImSjAlw8Y98=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-TM4EohMpPqOyi_hzRZAZCA-1; Fri, 23 Dec 2022 03:34:50 -0500
X-MC-Unique: TM4EohMpPqOyi_hzRZAZCA-1
Received: by mail-qk1-f198.google.com with SMTP id r6-20020a05620a298600b007025c3760d4so2814848qkp.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=accKtY0Nk1Ttaf4aO5Gw1z4PmDYGpk3kZSawW3XXd1Q=;
        b=fTWTD6BzsA+J3IpU0VXUnD6v+Jl1sMXbWIaGXUIPRhF7WFW7uTxyy0ktDOtEfkdehq
         ypEhOvP+AKZgpJdUxIg0LhyWpAYsYZQlbjM2ER6nNXtEHvGk6+agHML0RAId76nFH1R6
         aIvRkgnwy85NK4QoK+lg4P+uXYe6dfQF+qCBxQ34yLpz4GzVqxJVZBDZXuRYZbZ1hZVL
         tPzOTnUyvWggmiSeNfvYLcic9sXVjiTyjFaB3R/IOvHkKc80k7Z62tXXes9rbfX+nLdQ
         1BzP4an0eTB76h7Gz+4xSCRdmS0IrZEdS4s9FWPxpKGeZUOLrNigoo1baQ0WaEn2GFDS
         OfRQ==
X-Gm-Message-State: AFqh2komT/1/nr8+TZBSS6lL5NjfJWeE5ohh6/LOPCbl8jFrNmzVFIHg
        Fr6cFysejcTYTawGpNkdfdjDCtQgtoWvUhV24P5XRiOhJqZ0s959oIj7YqxqqyPJ0TXtXlKmiee
        BRftKNlOwAsClSSqVutMd6iQm
X-Received: by 2002:ac8:128b:0:b0:3a5:758d:8f5e with SMTP id y11-20020ac8128b000000b003a5758d8f5emr10118193qti.19.1671784489760;
        Fri, 23 Dec 2022 00:34:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtjtxBh1bt1R2fuChJ76Ci/Ml0xv4HnrzrtR0IqAjJOWxujwVSOJ2YmUjszjU0SYlzviRkIpw==
X-Received: by 2002:ac8:128b:0:b0:3a5:758d:8f5e with SMTP id y11-20020ac8128b000000b003a5758d8f5emr10118180qti.19.1671784489516;
        Fri, 23 Dec 2022 00:34:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-34-11-215.business.telecomitalia.it. [79.34.11.215])
        by smtp.gmail.com with ESMTPSA id t15-20020ac86a0f000000b003a569a0afcasm1658112qtr.66.2022.12.23.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 00:34:49 -0800 (PST)
Date:   Fri, 23 Dec 2022 09:34:42 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/4] vdpa_sim: support vendor statistics
Message-ID: <20221223083442.g2uby76ggfupwqyf@sgarzare-redhat>
References: <20221223055548.27810-1-jasowang@redhat.com>
 <20221223055548.27810-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223055548.27810-4-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 01:55:47PM +0800, Jason Wang wrote:
>This patch adds a new config ops callback to allow individual
>simulator to implement the vendor stats callback.
>
>Acked-by: Eugenio Pérez <eperezma@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 ++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
> 2 files changed, 17 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 341da107e7da..45d3f84b7937 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -424,6 +424,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> 	return 0;
> }
>
>+static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
>+				struct sk_buff *msg,
>+				struct netlink_ext_ack *extack)
>+{
>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>+
>+	if (vdpasim->dev_attr.get_stats)
>+		return vdpasim->dev_attr.get_stats(vdpasim, idx,
>+						   msg, extack);
>+	return -EOPNOTSUPP;
>+}
>+
> static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> {
> 	return VDPASIM_QUEUE_ALIGN;
>@@ -710,6 +722,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> 	.set_vq_ready           = vdpasim_set_vq_ready,
> 	.get_vq_ready           = vdpasim_get_vq_ready,
> 	.set_vq_state           = vdpasim_set_vq_state,
>+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
> 	.get_vq_state           = vdpasim_get_vq_state,
> 	.get_vq_align           = vdpasim_get_vq_align,
> 	.get_vq_group           = vdpasim_get_vq_group,
>@@ -743,6 +756,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> 	.set_vq_ready           = vdpasim_set_vq_ready,
> 	.get_vq_ready           = vdpasim_get_vq_ready,
> 	.set_vq_state           = vdpasim_set_vq_state,
>+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
> 	.get_vq_state           = vdpasim_get_vq_state,
> 	.get_vq_align           = vdpasim_get_vq_align,
> 	.get_vq_group           = vdpasim_get_vq_group,
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index 51c070a543f1..d2a08c0abad7 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -48,6 +48,9 @@ struct vdpasim_dev_attr {
> 	work_func_t work_fn;
> 	void (*get_config)(struct vdpasim *vdpasim, void *config);
> 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
>+	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
>+			 struct sk_buff *msg,
>+			 struct netlink_ext_ack *extack);
> };
>
> /* State of each vdpasim device */
>-- 
>2.25.1
>


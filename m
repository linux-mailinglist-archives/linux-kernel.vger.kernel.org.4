Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CAD654D96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiLWIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiLWIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8AF357A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671784674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tibs9pd8jDUt8h9x80aD1hAsOpHzVYssW4T7EsRgLKw=;
        b=caOknhJ/rsn18c+4tmtGTy6vr7Ftr/l0linSokVdOCIN6DjosPshnUd9DIIMON1pcljpUz
        cQqf8VtoXMTKu1Ku1zMIM3UeqZJgRIE4dz7kSOGcLNMf3wZHVcjIynDa89lnJw4M67N/s8
        ieSLl7C33sZhkGsjiyHWexCe10ye2Z8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-163-Wy93MgJLP--BS3QcZ2CiKA-1; Fri, 23 Dec 2022 03:37:52 -0500
X-MC-Unique: Wy93MgJLP--BS3QcZ2CiKA-1
Received: by mail-qv1-f71.google.com with SMTP id o13-20020a056214108d00b004c6fb4f16dcso2194995qvr.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tibs9pd8jDUt8h9x80aD1hAsOpHzVYssW4T7EsRgLKw=;
        b=fjMLw5b7tr963seEBk+q7w1FnVnhBiEsxOYKf7he50EA6GhKJzgyWsjbjePWyOeNGf
         CGS2E7DgZbcZjk+ftYRw8tWLhi7aiYo8+XJoFmmTjeI4wxbc941IoTtP24PY+p3Qg4Pp
         SykZmgS7IgUbMUR2zswMI9i61VTkZaeW2RvDpFZvMbSkWedfuCu8TXqRIQnHtiwyPtF7
         nqdtp2cOuKFtolNGGFNeawswK7AcAVu91vv4Y8c8jhb6d59re2k/799eD7GUX67pmKss
         EvLow76rir1mteEAZG0mReXDGejyczsI6Uyc9df0m4kWPm9aCbLlzNwaikSfB481cD3t
         M0tQ==
X-Gm-Message-State: AFqh2krRSqIo4ND5Vp4HxTkKXuLuAbOP6/ktzILjdHLZm8y5ZVpejb/z
        Ym7LWmxy9Rqgx9j9Dq+mV2l7vT9dHUyCxfSJIgQhYqg3eRYmO1Ss36mEuE1lPHSIUqWvJ+t0RD1
        /OjQ3JIZFQu8BRw1tAHcL/Fqj
X-Received: by 2002:a05:622a:ca:b0:3a8:1677:bc39 with SMTP id p10-20020a05622a00ca00b003a81677bc39mr15027593qtw.52.1671784672377;
        Fri, 23 Dec 2022 00:37:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtXAVeXCU7Z60xZ2A/kTwDtBLtl+RNfota7X4YVBNcGaGNzEeuXfc2pR1Fu4/OKNHnHA84nbg==
X-Received: by 2002:a05:622a:ca:b0:3a8:1677:bc39 with SMTP id p10-20020a05622a00ca00b003a81677bc39mr15027565qtw.52.1671784672018;
        Fri, 23 Dec 2022 00:37:52 -0800 (PST)
Received: from sgarzare-redhat (host-79-34-11-215.business.telecomitalia.it. [79.34.11.215])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006a6ebde4799sm1898693qko.90.2022.12.23.00.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 00:37:51 -0800 (PST)
Date:   Fri, 23 Dec 2022 09:37:44 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/4] vdpa_sim_net: vendor satistics
Message-ID: <20221223083744.ny3yy3rdh2bftm6c@sgarzare-redhat>
References: <20221223055548.27810-1-jasowang@redhat.com>
 <20221223055548.27810-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223055548.27810-5-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 01:55:48PM +0800, Jason Wang wrote:
>This patch adds support for basic vendor stats that include counters
>for tx, rx and cvq.
>
>Acked-by: Eugenio Pérez <eperezma@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 219 ++++++++++++++++++++++++++-
> 1 file changed, 213 insertions(+), 6 deletions(-)

Little typo in the commit title s/satistics/statistics

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index 5abd4efd9028..e827708adcca 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -15,6 +15,7 @@
> #include <linux/etherdevice.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
>+#include <net/netlink.h>
> #include <uapi/linux/virtio_net.h>
> #include <uapi/linux/vdpa.h>
>
>@@ -37,6 +38,34 @@
> #define VDPASIM_NET_AS_NUM	2
> #define VDPASIM_NET_GROUP_NUM	2
>
>+struct vdpasim_dataq_stats {
>+	struct u64_stats_sync syncp;
>+	u64 pkts;
>+	u64 bytes;
>+	u64 drops;
>+	u64 errors;
>+	u64 overruns;
>+};
>+
>+struct vdpasim_cq_stats {
>+	struct u64_stats_sync syncp;
>+	u64 requests;
>+	u64 successes;
>+	u64 errors;
>+};
>+
>+struct vdpasim_net{
>+	struct vdpasim vdpasim;
>+	struct vdpasim_dataq_stats tx_stats;
>+	struct vdpasim_dataq_stats rx_stats;
>+	struct vdpasim_cq_stats cq_stats;
>+};
>+
>+static struct vdpasim_net *sim_to_net(struct vdpasim *vdpasim)
>+{
>+	return container_of(vdpasim, struct vdpasim_net, vdpasim);
>+}
>+
> static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
> {
> 	/* Make sure data is wrote before advancing index */
>@@ -97,9 +126,11 @@ static virtio_net_ctrl_ack vdpasim_handle_ctrl_mac(struct vdpasim *vdpasim,
> static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
> {
> 	struct vdpasim_virtqueue *cvq = &vdpasim->vqs[2];
>+	struct vdpasim_net *net = sim_to_net(vdpasim);
> 	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> 	struct virtio_net_ctrl_hdr ctrl;
> 	size_t read, write;
>+	u64 requests = 0, errors = 0, successes = 0;
> 	int err;
>
> 	if (!(vdpasim->features & (1ULL << VIRTIO_NET_F_CTRL_VQ)))
>@@ -115,10 +146,13 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
> 		if (err <= 0)
> 			break;
>
>+		++requests;
> 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov, &ctrl,
> 					     sizeof(ctrl));
>-		if (read != sizeof(ctrl))
>+		if (read != sizeof(ctrl)) {
>+			++errors;
> 			break;
>+		}
>
> 		switch (ctrl.class) {
> 		case VIRTIO_NET_CTRL_MAC:
>@@ -128,6 +162,11 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
> 			break;
> 		}
>
>+		if (status == VIRTIO_NET_OK)
>+			++successes;
>+		else
>+			++errors;
>+
> 		/* Make sure data is wrote before advancing index */
> 		smp_wmb();
>
>@@ -145,6 +184,12 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
> 			cvq->cb(cvq->private);
> 		local_bh_enable();
> 	}
>+
>+	u64_stats_update_begin(&net->cq_stats.syncp);
>+	net->cq_stats.requests += requests;
>+	net->cq_stats.errors += errors;
>+	net->cq_stats.successes += successes;
>+	u64_stats_update_end(&net->cq_stats.syncp);
> }
>
> static void vdpasim_net_work(struct work_struct *work)
>@@ -152,8 +197,10 @@ static void vdpasim_net_work(struct work_struct *work)
> 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
> 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
>+	struct vdpasim_net *net = sim_to_net(vdpasim);
> 	ssize_t read, write;
>-	int pkts = 0;
>+	u64 tx_pkts = 0, rx_pkts = 0, tx_bytes = 0, rx_bytes = 0;
>+	u64 rx_drops = 0, rx_overruns = 0, rx_errors = 0, tx_errors = 0;
> 	int err;
>
> 	spin_lock(&vdpasim->lock);
>@@ -172,14 +219,21 @@ static void vdpasim_net_work(struct work_struct *work)
> 	while (true) {
> 		err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
> 					   &txq->head, GFP_ATOMIC);
>-		if (err <= 0)
>+		if (err <= 0) {
>+			if (err)
>+				++tx_errors;
> 			break;
>+		}
>
>+		++tx_pkts;
> 		read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
> 					     vdpasim->buffer,
> 					     PAGE_SIZE);
>
>+		tx_bytes += read;
>+
> 		if (!receive_filter(vdpasim, read)) {
>+			++rx_drops;
> 			vdpasim_net_complete(txq, 0);
> 			continue;
> 		}
>@@ -187,19 +241,25 @@ static void vdpasim_net_work(struct work_struct *work)
> 		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
> 					   &rxq->head, GFP_ATOMIC);
> 		if (err <= 0) {
>+			++rx_overruns;
> 			vdpasim_net_complete(txq, 0);
> 			break;
> 		}
>
> 		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
> 					      vdpasim->buffer, read);
>-		if (write <= 0)
>+		if (write <= 0) {
>+			++rx_errors;
> 			break;
>+		}
>+
>+		++rx_pkts;
>+		rx_bytes += write;
>
> 		vdpasim_net_complete(txq, 0);
> 		vdpasim_net_complete(rxq, write);
>
>-		if (++pkts > 4) {
>+		if (tx_pkts > 4) {
> 			schedule_work(&vdpasim->work);
> 			goto out;
> 		}
>@@ -207,6 +267,145 @@ static void vdpasim_net_work(struct work_struct *work)
>
> out:
> 	spin_unlock(&vdpasim->lock);
>+
>+	u64_stats_update_begin(&net->tx_stats.syncp);
>+	net->tx_stats.pkts += tx_pkts;
>+	net->tx_stats.bytes += tx_bytes;
>+	net->tx_stats.errors += tx_errors;
>+	u64_stats_update_end(&net->tx_stats.syncp);
>+
>+	u64_stats_update_begin(&net->rx_stats.syncp);
>+	net->rx_stats.pkts += rx_pkts;
>+	net->rx_stats.bytes += rx_bytes;
>+	net->rx_stats.drops += rx_drops;
>+	net->rx_stats.errors += rx_errors;
>+	net->rx_stats.overruns += rx_overruns;
>+	u64_stats_update_end(&net->rx_stats.syncp);
>+}
>+
>+static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>+				 struct sk_buff *msg,
>+				 struct netlink_ext_ack *extack)
>+{
>+	struct vdpasim_net *net = sim_to_net(vdpasim);
>+	u64 rx_pkts, rx_bytes, rx_errors, rx_overruns, rx_drops;
>+	u64 tx_pkts, tx_bytes, tx_errors, tx_drops;
>+	u64 cq_requests, cq_successes, cq_errors;
>+	unsigned int start;
>+	int err = -EMSGSIZE;
>+
>+	switch(idx) {
>+	case 0:
>+		do {
>+			start = u64_stats_fetch_begin(&net->rx_stats.syncp);
>+			rx_pkts = net->rx_stats.pkts;
>+			rx_bytes = net->rx_stats.bytes;
>+			rx_errors = net->rx_stats.errors;
>+			rx_overruns = net->rx_stats.overruns;
>+			rx_drops = net->rx_stats.drops;
>+		} while (u64_stats_fetch_retry(&net->rx_stats.syncp, start));
>+
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+					"rx packets"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_pkts, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx bytes"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_bytes, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx errors"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_errors, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx overrunss"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_overruns, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "rx drops"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      rx_drops, VDPA_ATTR_PAD))
>+			break;
>+		err = 0;
>+		break;
>+	case 1:
>+		do {
>+			start = u64_stats_fetch_begin(&net->tx_stats.syncp);
>+			tx_pkts = net->tx_stats.pkts;
>+			tx_bytes = net->tx_stats.bytes;
>+			tx_errors = net->tx_stats.errors;
>+			tx_drops = net->tx_stats.drops;
>+		} while (u64_stats_fetch_retry(&net->tx_stats.syncp, start));
>+
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx packets"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_pkts, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx bytes"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_bytes, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx errors"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_errors, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "tx drops"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      tx_drops, VDPA_ATTR_PAD))
>+			break;
>+		err = 0;
>+		break;
>+	case 2:
>+		do {
>+			start = u64_stats_fetch_begin(&net->cq_stats.syncp);
>+			cq_requests = net->cq_stats.requests;
>+			cq_successes = net->cq_stats.successes;
>+			cq_errors = net->cq_stats.errors;
>+		} while (u64_stats_fetch_retry(&net->cq_stats.syncp, start));
>+
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "cvq requests"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      cq_requests, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "cvq successes"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      cq_successes, VDPA_ATTR_PAD))
>+			break;
>+		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME,
>+				  "cvq errors"))
>+			break;
>+		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,
>+				      cq_errors, VDPA_ATTR_PAD))
>+			break;
>+		err = 0;
>+		break;
>+	default:
>+		err = -EINVAL;
>+		break;
>+	}
>+
>+	return err;
> }
>
> static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
>@@ -243,6 +442,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 			       const struct vdpa_dev_set_config *config)
> {
> 	struct vdpasim_dev_attr dev_attr = {};
>+	struct vdpasim_net *net;
> 	struct vdpasim *simdev;
> 	int ret;
>
>@@ -253,10 +453,11 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
> 	dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
> 	dev_attr.nas = VDPASIM_NET_AS_NUM;
>-	dev_attr.alloc_size = sizeof(struct vdpasim);
>+	dev_attr.alloc_size = sizeof(struct vdpasim_net);
> 	dev_attr.config_size = sizeof(struct virtio_net_config);
> 	dev_attr.get_config = vdpasim_net_get_config;
> 	dev_attr.work_fn = vdpasim_net_work;
>+	dev_attr.get_stats = vdpasim_net_get_stats;
> 	dev_attr.buffer_size = PAGE_SIZE;
>
> 	simdev = vdpasim_create(&dev_attr, config);
>@@ -269,6 +470,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	if (ret)
> 		goto reg_err;
>
>+	net = sim_to_net(simdev);
>+
>+	u64_stats_init(&net->tx_stats.syncp);
>+	u64_stats_init(&net->rx_stats.syncp);
>+	u64_stats_init(&net->cq_stats.syncp);
>+
> 	return 0;
>
> reg_err:
>-- 
>2.25.1
>


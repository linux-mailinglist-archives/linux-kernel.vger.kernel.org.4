Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A97773E3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFZPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFZPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8FCF3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687794210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHL9J0eB4Sdz9Nc78m+y6P53irdo4gKn3Uc9907MynE=;
        b=E6vZE2Ay603xU0EqKUnRdTjBAS/tBz1h9Q46xuSpZOI0ii/k4fkYdt1LG5SImJ5zaSbaoT
        2tQI6ETAIwlLslNcvlJ3HMuQrVtBytSOGb5OBDr4OexHPRDw+AMlAU60hOiWWgKsuktqlM
        4Ru9/WC8GnzaZfRjKTGBWmNK8pfqk6A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-sjB-GcaFMwmKpJ9_2AxWqA-1; Mon, 26 Jun 2023 11:43:26 -0400
X-MC-Unique: sjB-GcaFMwmKpJ9_2AxWqA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7659cb9c3b3so139099985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794200; x=1690386200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHL9J0eB4Sdz9Nc78m+y6P53irdo4gKn3Uc9907MynE=;
        b=YyJhIhFPdcb3hLD/W7hyjGgCQiDd+ze/PrlWwtwEIIslbE8FrxzBN7FL5P90tmAXml
         fukqcuIjpdyHBt5ddlXveZctbaz8tY8YJyPCm1/OMLMRLH8NrCM2fd2/g5RXp5iVCSy+
         OEZMxvWffltapIKgHGeVFhS0qalUiJQecN8wtz/PTuaP3bkZxDkCETo77/ykdruwfJeU
         d+SQGbHtJTqycVTfLefbYVPHAYSxT2CBdOyfqcQCCJV4Z1CgfXAXykWHm0hqeLqcARHN
         NdG7sQTj4sgS1XcEre12/+udSWkT4S9nP8UVpo5PoRWjIzWzadocSPz1/mYyqiTxNELV
         6vVQ==
X-Gm-Message-State: AC+VfDyP6xUUVjoQUrwE7z3/gqU8XjBSfJplfi/+v23cFMMLwbPgm7k3
        rUq94Tg+aixzl2iYQtUPeKnQAoul2sFwUtira+LpZyELRiEpIQVmYaoddbKIIza2hg/ldcQ3ygo
        e0pqdLIKqlkwJVwrCPZavGMoM
X-Received: by 2002:a05:620a:24cf:b0:765:a828:7d02 with SMTP id m15-20020a05620a24cf00b00765a8287d02mr4274655qkn.24.1687794199780;
        Mon, 26 Jun 2023 08:43:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7wo4oIIXt+M60hxTpJtMEqYtBvIw+eoptPK+6HuXbpu6oq7q8v2GIbBoAcgQwaiCeGYHwlTw==
X-Received: by 2002:a05:620a:24cf:b0:765:a828:7d02 with SMTP id m15-20020a05620a24cf00b00765a8287d02mr4274641qkn.24.1687794199542;
        Mon, 26 Jun 2023 08:43:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b00761fae866c7sm2807410qkj.76.2023.06.26.08.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:43:19 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:43:14 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 04/17] vsock/virtio: non-linear skb handling for
 tap
Message-ID: <gp4xniaudmgaeij677g4eylbizhjtk6e7l5modpxb2dwqygnse@5ceugoevrtht>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-5-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 11:49:26PM +0300, Arseniy Krasnov wrote:
>For tap device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 31 ++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 5819a9cd4515..0de562c1dc4b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -106,6 +106,27 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,

`const struct sk_buff *skb` should be better also to understand that
the function copy data from *skb to *dst.

>+						void *dst,
>+						size_t len)
>+{
>+	struct iov_iter iov_iter = { 0 };
>+	struct kvec kvec;
>+	size_t to_copy;
>+
>+	kvec.iov_base = dst;
>+	kvec.iov_len = len;
>+
>+	iov_iter.iter_type = ITER_KVEC;
>+	iov_iter.kvec = &kvec;
>+	iov_iter.nr_segs = 1;
>+
>+	to_copy = min_t(size_t, len, skb->len);
>+
>+	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+			       &iov_iter, to_copy);
>+}
>+
> /* Packet capture */
> static struct sk_buff *virtio_transport_build_skb(void *opaque)
> {
>@@ -114,7 +135,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	struct af_vsockmon_hdr *hdr;
> 	struct sk_buff *skb;
> 	size_t payload_len;
>-	void *payload_buf;
>
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
>@@ -122,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 	payload_len = pkt->len;
>-	payload_buf = pkt->data;
>
> 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
> 			GFP_ATOMIC);
>@@ -165,7 +184,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
> 	if (payload_len) {
>-		skb_put_data(skb, payload_buf, payload_len);
>+		if (skb_is_nonlinear(pkt)) {
>+			void *data = skb_put(skb, payload_len);
>+
>+			virtio_transport_copy_nonlinear_skb(pkt, data, 
>payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}
> 	}
>
> 	return skb;
>-- 
>2.25.1
>


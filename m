Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E84699774
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBPObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBPObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:31:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754848E29
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676557835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9oWDCNYoCRLAFAE2xiwQxbVwQjtrOQMjZPhjji0izk=;
        b=EBDJcNW0tzaNkcuBS4Kd8UdQ4+xgN+Bj4wsoU0KR2ubsgDOgxJ4ZBfy4p5bbtZIXntN9R2
        CfSlKBgUUlKxL8CozG1P+9rCPeCGkkZd0F/JQGLC3850J8ediYYZhLk0N6zmlwFiB7AL0B
        gEZmNdUC54wr8CaEp82r6C0rOMmmFZQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-dye4niuiN5O0TBbMgnyAvQ-1; Thu, 16 Feb 2023 09:30:34 -0500
X-MC-Unique: dye4niuiN5O0TBbMgnyAvQ-1
Received: by mail-qt1-f197.google.com with SMTP id hf20-20020a05622a609400b003abcad051d2so1278339qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9oWDCNYoCRLAFAE2xiwQxbVwQjtrOQMjZPhjji0izk=;
        b=bL776pBaSbnOi3HXdEvnDGaV/xlVx+DHkzLMAyAuyNP0knQsXg6gx5n5m18RLMrdo3
         9MiIHaS6HT24Hiry6XR4QoArSQRPhvdCN9WdaMTEztFJL2+ZLd8kYetKEZbX8oMm/Oh1
         syWZ3RY+59YplZQoY4+fh58oxPjzmLytcCxRqBLm0y/tEyJCM4DRC3KUnK/Ribuxi1eG
         guFGLfEWjL+3GIXv56c5nrnAs5SkvOdk1F9Lxm/WKJBogpY4zB3bjfomgZAty2cMnSTh
         ukLn0V/IBRBlfHAJyIXqzRn62idmmIpFcX3rj5kCIjo7bvuVvPBEUmfNUKPV18Tn07fq
         6H+A==
X-Gm-Message-State: AO0yUKVLq0frOA/9BCeCry59CKNY1tbB85JiQgXSCRf2cLOsQqQLT9sV
        GQyqLxBKRpHPQeKpe0FY5BGVdrHRfJ8MONzssOCReeUfg91Vn/INESYnB1bW5nxJtegS7hXqLE4
        mJsVwrTqO52obXb2U+Na8Jkte
X-Received: by 2002:ac8:5849:0:b0:3bd:15d4:ff65 with SMTP id h9-20020ac85849000000b003bd15d4ff65mr661133qth.40.1676557833572;
        Thu, 16 Feb 2023 06:30:33 -0800 (PST)
X-Google-Smtp-Source: AK7set8XJTsnTm0VaIJmbJX3VcXHUhxxi2M8Gpe8tbPNcNIuLHAOsiSc/znHPpsq3YpeBFeBz2CWkQ==
X-Received: by 2002:ac8:5849:0:b0:3bd:15d4:ff65 with SMTP id h9-20020ac85849000000b003bd15d4ff65mr661093qth.40.1676557833268;
        Thu, 16 Feb 2023 06:30:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it. [82.57.51.167])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0073912c099cesm1258386qkd.73.2023.02.16.06.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:30:32 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:30:27 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 06/12] vsock/virtio: non-linear skb handling for
 TAP dev
Message-ID: <20230216143027.yg737u2ndiwwatm2@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <ebee740a-95df-ed52-6274-a9340e8dc9d2@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ebee740a-95df-ed52-6274-a9340e8dc9d2@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:59:21AM +0000, Arseniy Krasnov wrote:
>For TAP device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 43 +++++++++++++++++++++++--
> 1 file changed, 40 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a1581c77cf84..05ce97b967ad 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -101,6 +101,39 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(struct sk_buff *skb,
>+						void *dst,
>+						size_t len)
>+{
>+	size_t rest_len = len;
>+
>+	while (rest_len && virtio_vsock_skb_has_frags(skb)) {
>+		struct bio_vec *curr_vec;
>+		size_t curr_vec_end;
>+		size_t to_copy;
>+		int curr_frag;
>+		int curr_offs;
>+
>+		curr_frag = VIRTIO_VSOCK_SKB_CB(skb)->curr_frag;
>+		curr_offs = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>+		curr_vec = &skb_shinfo(skb)->frags[curr_frag];
>+
>+		curr_vec_end = curr_vec->bv_offset + curr_vec->bv_len;
>+		to_copy = min(rest_len, (size_t)(curr_vec_end - curr_offs));
>+
>+		memcpy(dst, page_to_virt(curr_vec->bv_page) + curr_offs,
>+		       to_copy);
>+
>+		rest_len -= to_copy;
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += to_copy;
>+
>+		if (VIRTIO_VSOCK_SKB_CB(skb)->frag_off == (curr_vec_end)) {
>+			VIRTIO_VSOCK_SKB_CB(skb)->curr_frag++;
>+			VIRTIO_VSOCK_SKB_CB(skb)->frag_off = 0;
>+		}
>+	}
>+}
>+
> /* Packet capture */
> static struct sk_buff *virtio_transport_build_skb(void *opaque)
> {
>@@ -109,7 +142,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	struct af_vsockmon_hdr *hdr;
> 	struct sk_buff *skb;
> 	size_t payload_len;
>-	void *payload_buf;
>
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
>@@ -117,7 +149,6 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 	payload_len = pkt->len;
>-	payload_buf = pkt->data;
>
> 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
> 			GFP_ATOMIC);
>@@ -160,7 +191,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
> 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
> 	if (payload_len) {
>-		skb_put_data(skb, payload_buf, payload_len);
>+		if (skb_is_nonlinear(skb)) {
>+			void *data = skb_put(skb, payload_len);
>+
>+			virtio_transport_copy_nonlinear_skb(skb, data, payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}

Ehm I'm a bit confused. Maybe we need to rename the sk_buffs involved in
this function (pre-existing).

We have `pkt` that is the original sk_buff, and `skb` that it is 
allocated in this function, so IIUC we should check if `pkt` is 
nonlinear and copy its payload into `skb`, so we should do this 
(untested) chage:

@@ -367,10 +367,10 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
         skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));

         if (payload_len) {
-               if (skb_is_nonlinear(skb)) {
+               if (skb_is_nonlinear(pkt)) {
                         void *data = skb_put(skb, payload_len);

-                       virtio_transport_copy_nonlinear_skb(skb, data, payload_len);
+                       virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
                 } else {
                         skb_put_data(skb, pkt->data, payload_len);
                 }

Thanks,
Stefano

> 	}
>
> 	return skb;
>-- 
>2.25.1


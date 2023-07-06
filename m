Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081DB74A286
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjGFQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGFQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C471BE3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688662280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awb+7AXpmYzXz/qezLtg4yD0Vv3mvjeFgM0SYmrlPEU=;
        b=HsLZ+nDWDBa/iWBtDeptV2UdmcW/i7aTPN9OvEFVay0ZIL5p+EPc5LBPMefqL5tSof9HCK
        ylI+N4zWDmD3ssMxcuSgw67mdenITzBgiqm7YrJNN/5wa55lDH/h71yL5UN3EJdscAUl40
        bwyMRTXyHDNF1uM3xctkbbfrLB/l2So=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-gLhUDD4cNnaXvxswmkGZXg-1; Thu, 06 Jul 2023 12:51:18 -0400
X-MC-Unique: gLhUDD4cNnaXvxswmkGZXg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355cf318so68955666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662277; x=1691254277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awb+7AXpmYzXz/qezLtg4yD0Vv3mvjeFgM0SYmrlPEU=;
        b=XC0vhknrYLR/0Z7EY2/f6EIf759YRoN4L8Uxl2RTn1Beyh2/nXjl5eyPR5miESO4n9
         E9pbfPStq4Q3EZEf/k5f3XN/0B4XtkCGSLv0C4HRQhJm41EiItM5JgNLTEVc/hi60+5N
         46nZFcThXaOclx9cA3NvgbPKHScYs+jgUoO1dm8ma/sxb5uUu/CBUKK41hHZ2+AHIGHx
         3VOTuwQBrqMUiYWhcQNPtNG1VxbT4D6dihgZ98vi65kc2ajHpFhyr9rnBUzDvn/DSfuB
         OX5BVHOsbNPlAZ55+US3GJ9EwmQhsBFabn7Xr+Q24kkKCWLBkte9Fwg3zHhWXGYCDM32
         e3Zg==
X-Gm-Message-State: ABy/qLZjSUT8GuAgBKaigsnWplt7xnOUTCCQfFwsPlzX6/+rq5Mo496J
        QwbY2BWOSjTg1uQU5n5YFixcxjVPF5kp19A0szbRzN5sq0IgVv5KMupn4VuRfElot7RPXqxMoLW
        aBvwupGMh/IhITtZi59YQ0w/1
X-Received: by 2002:a17:906:7499:b0:992:630f:98b4 with SMTP id e25-20020a170906749900b00992630f98b4mr2090422ejl.7.1688662277387;
        Thu, 06 Jul 2023 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcjZ/elRu3NDEvZe9dL5bPtGnyqQvkazpE91J90ogdTAnM9Wru1mlG0RExbfNcoTXT5+NKlw==
X-Received: by 2002:a17:906:7499:b0:992:630f:98b4 with SMTP id e25-20020a170906749900b00992630f98b4mr2090395ejl.7.1688662276897;
        Thu, 06 Jul 2023 09:51:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id m18-20020a170906849200b0098f33157e7dsm1042403ejx.82.2023.07.06.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:51:16 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:51:14 +0200
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
Subject: Re: [RFC PATCH v5 04/17] vsock/virtio: non-linear skb handling for
 tap
Message-ID: <3klk75my4waydbvy7sa5muwattknjq2nify2myrucib5yb6maz@4a2swpu55lhv>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-5-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 09:39:34AM +0300, Arseniy Krasnov wrote:
>For tap device new skb is created and data from the current skb is
>copied to it. This adds copying data from non-linear skb to new
>the skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Make 'skb' pointer constant because it is source.
>
> net/vmw_vsock/virtio_transport_common.c | 31 ++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e5683af23e60..dfc48b56d0a2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -106,6 +106,27 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	return NULL;
> }
>
>+static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
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
>+			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>+		} else {
>+			skb_put_data(skb, pkt->data, payload_len);
>+		}
> 	}
>
> 	return skb;
>-- 
>2.25.1
>


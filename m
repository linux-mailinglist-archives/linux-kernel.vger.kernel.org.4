Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED787622870
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKIK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiKIK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472BB13E85
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667989512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yog0hcuy+DRZPETd9YkKxOoct4jxmNsATV6V9Xx3MWc=;
        b=Cubzxsp/FhdnicGCbhVeu3i8DFdv7sJKe48wsnkZMoQp7Hvgc1+gTA+spZ+aO3T13aChYp
        XCqZeEC9QcOT8MOzop+Pwni7Qv2zkK7Cpq4grURXR2I38IACB64iJgShINi3+0gf+4AT3X
        seVrIsp9h3SN0sk9trc1CdPCY0fFV7g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-a84Ps9UiM9OGtc6ujvbODQ-1; Wed, 09 Nov 2022 05:25:11 -0500
X-MC-Unique: a84Ps9UiM9OGtc6ujvbODQ-1
Received: by mail-qk1-f197.google.com with SMTP id u6-20020a05620a430600b006e47fa02576so15465333qko.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yog0hcuy+DRZPETd9YkKxOoct4jxmNsATV6V9Xx3MWc=;
        b=8EPBN0vyKbbeh/RraqnvwyomMfP/vpj1c5M9F03Gm8TplCHCTUYy+PHV8j1RPhgoKY
         FtOYMTITwwrVGFjsA7wof6qaGE6a6OMgjXEDsXXFXI8qx83uQd/tOMMxMVfhA4I0rng3
         8hvmM9Zz2Ljbm0Mc6gN8Loy/UEBDDm3bnMaKJDHjpZrojv1ZAzBxwTaBh8c6DSbtZFaH
         sALb/Gin7E5msKpgJGhsw0cdfbBwlutY7kFlbiPfGYFBGSivytM/UCtAlNnZkKT4BTTW
         dwwGclYf1Gbpv7RLpwVAL9+nyfijISL2+M4zC8tuPr5ncMIwJV0DfMQqeyhfR3xnSDJ4
         PXWQ==
X-Gm-Message-State: ACrzQf3nOV+6W3aUIjLswEN7S4VPbLNQjuxVXgvl0jOgYPAzvKe0UfoE
        WJgpLDXQdJKB53QVKMp3X0z3grikxaPxoUhAMfq7iwUnn1EAakochWcQ2STY6pffCBpAv3sQIJS
        d8mid/4mN/F2ZVooWFmDOuVIa
X-Received: by 2002:a05:622a:12:b0:3a5:6899:5add with SMTP id x18-20020a05622a001200b003a568995addmr20183668qtw.629.1667989510777;
        Wed, 09 Nov 2022 02:25:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7dHRvHahxNPyxd5cXNPDwYDthvEkrvK4CouVYmtTTQjEql4SHBFw0gbhGAtAaO5z7i7a0AnQ==
X-Received: by 2002:a05:622a:12:b0:3a5:6899:5add with SMTP id x18-20020a05622a001200b003a568995addmr20183656qtw.629.1667989510546;
        Wed, 09 Nov 2022 02:25:10 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id bj10-20020a05620a190a00b006fa313bf185sm10827522qkb.8.2022.11.09.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:25:09 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/2] vringh: fix range used in iotlb_translate()
Date:   Wed,  9 Nov 2022 11:25:02 +0100
Message-Id: <20221109102503.18816-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109102503.18816-1-sgarzare@redhat.com>
References: <20221109102503.18816-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vhost_iotlb_itree_first() requires `start` and `last` parameters
to search for a mapping that overlaps the range.

In iotlb_translate() we cyclically call vhost_iotlb_itree_first(),
incrementing `addr` by the amount already translated, so rightly
we move the `start` parameter passed to vhost_iotlb_itree_first(),
but we should hold the `last` parameter constant.

Let's fix it by saving the `last` parameter value before incrementing
`addr` in the loop.

Fixes: 9ad9c49cfe97 ("vringh: IOTLB support")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 11f59dd06a74..828c29306565 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1102,7 +1102,7 @@ static int iotlb_translate(const struct vringh *vrh,
 	struct vhost_iotlb_map *map;
 	struct vhost_iotlb *iotlb = vrh->iotlb;
 	int ret = 0;
-	u64 s = 0;
+	u64 s = 0, last = addr + len - 1;
 
 	spin_lock(vrh->iotlb_lock);
 
@@ -1114,8 +1114,7 @@ static int iotlb_translate(const struct vringh *vrh,
 			break;
 		}
 
-		map = vhost_iotlb_itree_first(iotlb, addr,
-					      addr + len - 1);
+		map = vhost_iotlb_itree_first(iotlb, addr, last);
 		if (!map || map->start > addr) {
 			ret = -EINVAL;
 			break;
-- 
2.38.1


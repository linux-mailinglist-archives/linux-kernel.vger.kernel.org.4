Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC865210C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiLTMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiLTMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:52:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB510B70
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=k0FAg6XXcHdMfc8oVO4atET5WnhQYSLiwHFy9PK81fE=;
        b=TuqQSVhGLDXNhqVlsVPL5rU0XOqt3bZpqyBAiEOoM8DzRZrMRgRNoEHvGfeUgt7ykBBTky
        JRg9YqQLLvZ1j1ye+wkbmkowZ32fUyVdvdI0IAYqCXhPu/SrgU5xNkcMirJLZoYDsAeVxW
        pq4T5LX7brNwK+8lCyLZEcK9a87Evuc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-aNq0_PHSNNSoAoFbJ6Sq-Q-1; Tue, 20 Dec 2022 07:52:07 -0500
X-MC-Unique: aNq0_PHSNNSoAoFbJ6Sq-Q-1
Received: by mail-qt1-f200.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso5488764qtb.17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0FAg6XXcHdMfc8oVO4atET5WnhQYSLiwHFy9PK81fE=;
        b=jR+0Io1s7WXSmczzMIu4USu5p4JMbTEIe4bARpeZe0IrUhpbdxn+d96nOIv6ljij7L
         k26gMH96sXQr+hEzcMkmh8y5jayf2GA6FzC1XfQZsCq2C5jHBEYLW2l5ekEsJFSN6GbQ
         Wz9g70Ks2OjvwdmNphSJq55x3MnGUiXKb8jdggGqBdzDJQ8eeg3r72AedvdloEtrKonQ
         qC2rY/ya6M2nKAHeGrRZWbeiO2QbbxwHeEwSJx13IejvF+vOfR0DTbPi1KwzLUicDD/q
         j/LeqwiGTmZqTtgBOv249sDQKBTlOt6xNlOuXYZcjNUexLt58CU+p82XYlW1NXv214eT
         HIlg==
X-Gm-Message-State: ANoB5pmfXkX7zSkmG9HWiV5WUbcNQ1xMhJa0b9ZnmWVSzJVe/M1rdLPd
        kV0a34ErPpatKLAyG2w0HvCq/6JlpEWrEQgYJ+jnLRXIkSW2NldT2kODL34MSX19e1jCRtFawz0
        CuvBgoy3ZFOgFBu9VVluBT7lpAjbTutXqXQEJ7UdunmLwI08XCnRCXSnOWdNaVqrAXjHi0w==
X-Received: by 2002:ac8:6bc4:0:b0:3a8:1d3c:47e9 with SMTP id b4-20020ac86bc4000000b003a81d3c47e9mr43531127qtt.48.1671540726846;
        Tue, 20 Dec 2022 04:52:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OPTSizknvCW8hT8hFc92s3UWJz2R3Fi5ZFpNOvn/FDZ7TfsX9i098IAGzf0JLhm5JkP5L8A==
X-Received: by 2002:ac8:6bc4:0:b0:3a8:1d3c:47e9 with SMTP id b4-20020ac86bc4000000b003a81d3c47e9mr43531096qtt.48.1671540726541;
        Tue, 20 Dec 2022 04:52:06 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id r17-20020ac84251000000b003a50ef44a77sm7507788qtm.28.2022.12.20.04.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:52:06 -0800 (PST)
Date:   Tue, 20 Dec 2022 07:52:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH] virtio_blk: zone append in header type tweak
Message-ID: <20221220125154.564265-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio blk returns a 64 bit append_sector in an input buffer,
in LE format. This field is not tagged as LE correctly, so
even though the generated code is ok, we get warnings from sparse:

drivers/block/virtio_blk.c:332:33: sparse: sparse: cast to restricted __le64

Make sparse happy by using the correct type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 73cd5db0d7d5..dc577e8bfa30 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -104,7 +104,7 @@ struct virtblk_req {
 		struct {
 			u8 status;
 			u8 reserved[7];
-			u64 append_sector;
+			__le64 append_sector;
 		} zone_append_in_hdr;
 	};
 
-- 
MST


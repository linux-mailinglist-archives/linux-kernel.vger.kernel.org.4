Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A736C60800F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJUUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJUUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:44:14 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED0106E16;
        Fri, 21 Oct 2022 13:43:55 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso5022525fac.6;
        Fri, 21 Oct 2022 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/G6LFbUeYMFO24FKBVvek1cF9UzLOlkGDVPRHkS0zAY=;
        b=S7AEiAYCKYwxCC/ExzsIRek1gu+DwJbib9fX8RuXb2r8ukfVzwUlfbXmtJsKgiPgUA
         2tRNij8vld4g7B0fqfFgo10fQdISvjSsWSZdRdrf1qPHBFFCtNKgqVtC7wNO97tCjZTs
         uA49dV+qF61GwU7Hwk6WwzouxO58Az8waIeHNsG7auIhf4Qozf8TfoDrDqgqcvWw5w7r
         7GspdrS5+hiAEgrRXQxSe4zlts9QdcvblScJIDMZ6JKZXljT0svL9+LyuP5UpWvkMOKC
         iHtBm1pEA8kl8t+p9Qgh+m7QGgBaN06BV4ykIDdrL26jHIZUEWdmzGZhtT4UNbjzKjEG
         JGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/G6LFbUeYMFO24FKBVvek1cF9UzLOlkGDVPRHkS0zAY=;
        b=nzyNiyPYxx6XSdJdrcwOKoibDOb/veMO98mUYjptH7oJgrVnGD8hIPZOiaefVdl2cT
         7IIHqu3YscUZn/qPrxm1xVsh9QX5U+xUVU0dG37GqJiCxPCJLNpg0QxD7KZVAunfNo/9
         lcNfPBSY3DZl8wH84de+x8z2pCkxGSVs35BB0fBYRrN+0OSQCPlGtPx1DsWgic9Vhdsf
         CE/4c/i4Ydj/FdyMIdqNjP5Oj9TqtuzHWEp15SOxph4euB0acSHlXk1i0eAl5KHTWHno
         /nzc9B5FDzH9MNeEa36W1gisAbQtOGP2DJLZMejkFt9IMS5AY4I9jq05NhfyeNOgbdWo
         a11A==
X-Gm-Message-State: ACrzQf0+RiJ3TmJY/ouGK2hWpYbWfO7LxwCX/TNV4PcfKAIgCRH+WQJe
        2fKbvPRKqFftb/MR7pkbdLibbCb3ZRAUWA==
X-Google-Smtp-Source: AMsMyM7EPWs+ShRsVXmYTg+a53hB9cUiENnafXWh0Llkzges/ZtwBWrbJJOPp/bOi0r0tBjyXkaOyg==
X-Received: by 2002:a05:6870:5249:b0:137:2c18:6866 with SMTP id o9-20020a056870524900b001372c186866mr24429669oai.15.1666384957937;
        Fri, 21 Oct 2022 13:42:37 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:1855:fc19:f361:478a:f673])
        by smtp.gmail.com with ESMTPSA id z20-20020a056871015400b0011f22e74d5fsm10670933oab.20.2022.10.21.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:42:37 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Suwan Kim <suwan.kim027@gmail.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
Date:   Fri, 21 Oct 2022 17:41:26 -0300
Message-Id: <20221021204126.927603-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtblk_map_data() function returns negative error codes, however, the
'nents' field of vbr->sg_table is an unsigned int, which causes the error
handling not to work correctly.

Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/block/virtio_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..291f705e61a8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 					struct virtblk_req *vbr)
 {
 	blk_status_t status;
+	int num;
 
 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
 	if (unlikely(status))
 		return status;
 
-	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
-	if (unlikely(vbr->sg_table.nents < 0)) {
+	num = virtblk_map_data(hctx, req, vbr);
+	if (unlikely(num < 0)) {
 		virtblk_cleanup_cmd(req);
 		return BLK_STS_RESOURCE;
 	}
+	vbr->sg_table.nents = num;
 
 	blk_mq_start_request(req);
 
-- 
2.34.1


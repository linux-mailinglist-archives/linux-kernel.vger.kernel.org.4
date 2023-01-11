Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C361665A29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjAKLbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjAKLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:30:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D0B1ED
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B238661C44
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48ECC433EF;
        Wed, 11 Jan 2023 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436642;
        bh=V+8wEdwTeBfWKOuKLnNsrHjcNV02ld2/uoosp2OJQrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKFWNtzfVuJdXWx1cZMVTAR+crfJ5Iyil/cRG4A5VSH8HeWe7VWFKbpFF7K+F6Dxp
         htolbomAiq5o5/KuTntFmmXFTYPB6W5QHFWR4dWxuBcnqVTo/rlSg0jdc6Co6CvrSy
         K6TS25j4tkxDvqROXKHhjovV2A7CfVhE90m+umTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 11/16] virtio: move dev_to_virtio() to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:13 +0100
Message-Id: <20230111113018.459199-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=gregkh@linuxfoundation.org; h=from:subject; bh=V+8wEdwTeBfWKOuKLnNsrHjcNV02ld2/uoosp2OJQrw=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p5cYS1/cl7W7Ky0jzmHgkJS152c8fVvqMYRA1NBqUfB nY93dcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEjKMZFly4OzXlpOC1ux/2yC74On 11jpuF9lOG+TF7Fd516j3oK7gR3jPnUXVerZHbXQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core is changing to pass some pointers as const, so move
dev_to_virtio() to use container_of_const() to handle this change.

dev_to_virtio() now properly keeps the const-ness of the pointer passed
into it, while as before it could be lost.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/virtio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dcab9c7e8784..2b472514c49b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -127,10 +127,7 @@ struct virtio_device {
 	void *priv;
 };
 
-static inline struct virtio_device *dev_to_virtio(struct device *_dev)
-{
-	return container_of(_dev, struct virtio_device, dev);
-}
+#define dev_to_virtio(_dev)	container_of_const(_dev, struct virtio_device, dev)
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status);
 int register_virtio_device(struct virtio_device *dev);
-- 
2.39.0


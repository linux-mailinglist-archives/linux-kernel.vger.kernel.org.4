Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD89169A42A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 04:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjBQDNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 22:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQDN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 22:13:29 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8AE54D07;
        Thu, 16 Feb 2023 19:13:27 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676603605;
        bh=LH/xXQeQJ9b7IeJuEOdjjtQYgBVktXb3iGO/ZdlJOBM=;
        h=From:Date:Subject:To:Cc:From;
        b=KXponZxzed7GavKW502p8mcvKO0FOWeQc0gC3KGhtKnTieSpIzxOGx4RcNwtP9q2V
         Da5TbqsKtmApQqJBCZIBKN4esnXw8ZRd0v6nH3jLrkXTze4QkoBxIvLEzwnSSAgAiO
         O5RBqn0q9mHHXy8IPdxDXuvwncX+BNeBmifOnfwk=
Date:   Fri, 17 Feb 2023 03:13:22 +0000
Subject: [PATCH] dma-buf: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230217-kobj_type-dma-buf-v1-1-b84a3616522c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANHw7mMC/x2N4QqCQBAGX0X2dwveCRW9SkTseZ+5ZafcZSjiu
 7f0cwaG2aggKwpdqo0yvlp0TAbuUFHbS3qANRqTr31Te3fi1xie9886geNbOMwdi4cc5SwuoiH
 rghRwyJLa3so0D4PJKaPT5T+63vb9B9H91jl4AAAA
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676603602; l=1123;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LH/xXQeQJ9b7IeJuEOdjjtQYgBVktXb3iGO/ZdlJOBM=;
 b=rrQjbf58nObPJhR+ovNy9W4vuE/7AyhUZbdHvb87cT7IzWpI5BE8fvDeBIg0KoH+pxoX+KbT4
 AUKjKj2iHEEA1TlXGTuWeExpnYQ4BbfzgcccPlk4wjhwdMr80F2E6uM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/dma-buf/dma-buf-sysfs-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
index fbf725fae7c1..6cfbbf0720bd 100644
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
@@ -112,7 +112,7 @@ static void dma_buf_sysfs_release(struct kobject *kobj)
 	kfree(sysfs_entry);
 }
 
-static struct kobj_type dma_buf_ktype = {
+static const struct kobj_type dma_buf_ktype = {
 	.sysfs_ops = &dma_buf_stats_sysfs_ops,
 	.release = dma_buf_sysfs_release,
 	.default_groups = dma_buf_stats_default_groups,

---
base-commit: 3ac88fa4605ec98e545fb3ad0154f575fda2de5f
change-id: 20230217-kobj_type-dma-buf-a2ea6a8a1de3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


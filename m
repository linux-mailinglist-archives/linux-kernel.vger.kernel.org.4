Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7404F64679E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLHDQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLHDQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:16:29 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9945389314
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 19:16:26 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowAAXmewGV5Fj8eepBQ--.45513S2;
        Thu, 08 Dec 2022 11:16:22 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     robin.murphy@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] drm: mali-dp: Add check for kzalloc
Date:   Thu,  8 Dec 2022 11:16:21 +0800
Message-Id: <20221208031621.3274-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAXmewGV5Fj8eepBQ--.45513S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw4fCr1kKFyUWFyxAw13Jwb_yoW8Jry7pr
        48trZakr95ZF45KrZrAa1kurn8Ca9IvFyxKFykWw15uw10g3s8AF4kKas8Wa1UJrZxJr1a
        yanFqF4fZFn0kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
        xVWUAVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUeGYpUUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As kzalloc may fail and return NULL pointer, the "mw_state" can be NULL.
If the layout of struct malidp_mw_connector_state ever changes, it
will cause NULL poineter derefernce of "&mw_state->base".
Therefore, the "mw_state" should be checked whether it is NULL in order
to improve the robust.

Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/gpu/drm/arm/malidp_mw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index ef76d0e6ee2f..fe4474c2ddcf 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -72,7 +72,11 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	else
+		__drm_atomic_helper_connector_reset(connector, NULL);
 }
 
 static enum drm_connector_status
-- 
2.25.1


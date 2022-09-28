Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4775ED4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiI1GYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiI1GYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:24:49 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17B234331C;
        Tue, 27 Sep 2022 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PRqQy
        Goq9wOWzgyinUTHIHWFfyBK2VGJdHeSaidSayw=; b=SQtzEpegast2VoLmoC6v9
        9AEvPVntyyr+cyLnxxT8nOeoRWsUbqk0nTZatEgwv83GL9klT1OtUyirragTHymZ
        7ljUr7qRuAmM2ZWK+8540BytbCIy4pYhpG5PXqmO5HoX9D7c6ZybPBseg9B4CM99
        G6L4ZSyGXWPBFXT1wgF5M4=
Received: from localhost.localdomain (unknown [36.112.3.106])
        by smtp3 (Coremail) with SMTP id G9xpCgBHz4BH6DNjsnURhA--.18298S4;
        Wed, 28 Sep 2022 14:23:10 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     gregkh@linuxfoundation.org, tzimmermann@suse.de,
        andriy.shevchenko@linux.intel.com, javierm@redhat.com,
        sam@ravnborg.org, steve@sk2.org, noralf@tronnes.org,
        u.kleine-koenig@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] staging: fbtft: core: fix potential memory leak in fbtft_probe_common()
Date:   Wed, 28 Sep 2022 14:23:01 +0800
Message-Id: <20220928062301.6399-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBHz4BH6DNjsnURhA--.18298S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrury8Ww1UtFW3WrWrXF15twb_yoWfCrXEvw
        1jvryxJrW8Cwn2kw48KFW5XFWSvr1fZr4rJFyUtas8Xay5ur15J3ykXwsxKa1Ut3yjq34S
        kr4rJr4jgw15WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpnQ7UUUUU==
X-Originating-IP: [36.112.3.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPg6KjFxBuOAwbgAAst
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fbtft_probe_common() allocates a memory chunk for "info" with
fbtft_framebuffer_alloc(). When "display->buswidth == 0" is true, the
function returns without releasing the "info", which will lead to a
memory leak.

Fix it by calling fbtft_framebuffer_release() when "display->buswidth
== 0" is true.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/staging/fbtft/fbtft-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index afaba94d1d1c..ecf595aff786 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -1225,6 +1225,7 @@ int fbtft_probe_common(struct fbtft_display *display,
 
 	if (display->buswidth == 0) {
 		dev_err(dev, "buswidth is not set\n");
+		fbtft_framebuffer_release(info);
 		return -EINVAL;
 	}
 
-- 
2.25.1


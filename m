Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69697663ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjAJIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjAJIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:20:05 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF51B42E04;
        Tue, 10 Jan 2023 00:19:59 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.14])
        by gateway (Coremail) with SMTP id _____8AxW+qsH71jprEAAA--.2135S3;
        Tue, 10 Jan 2023 16:19:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.14])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxTuSiH71jGUoXAA--.5900S2;
        Tue, 10 Jan 2023 16:19:54 +0800 (CST)
From:   yangyinglu <yangyinglu@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        yangyinglu <yangyinglu@loongson.cn>
Subject: [PATCH v1] usb: handle warm-reset port requests on hub_init
Date:   Tue, 10 Jan 2023 16:19:38 +0800
Message-Id: <20230110081938.30308-1-yangyinglu@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxTuSiH71jGUoXAA--.5900S2
X-CM-SenderInfo: 51dqw5xlqjz3o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvdXoW7Gw47GryxZFy3GF1xJr43Wrg_yoW3Arg_Ca
        4UWayxur1SyF17uryqv34FvFW0ka9IvFykZFZxtwsxXr4j9rs2yryxZr9Yvw17ZrWUur9x
        Aa1DWry5uF48ujkaLaAFLSUrUUUUYb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        C7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07jTq2NUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB-C storage device not detected on USB 3.0 host when
plugged in after boot, so need to warm-reset port

Signed-off-by: yangyinglu <yangyinglu@loongson.cn>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 77e73fc8d673..bd4496b80c2d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1159,7 +1159,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		}
 
 		/* Make sure a warm-reset request is handled by port_event */
-		if (type == HUB_RESUME &&
+		if ((type == HUB_RESUME || type == HUB_INIT2) &&
 		    hub_port_warm_reset_required(hub, port1, portstatus))
 			set_bit(port1, hub->event_bits);
 
-- 
2.20.1


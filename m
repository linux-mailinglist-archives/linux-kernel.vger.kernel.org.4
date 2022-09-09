Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5E5B4072
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiIIUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiIIUVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97EAB4F8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662754900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kTmFwjHdd6+ItQzjjW7E8XOZYRWV20W1ZUoai6+hbpY=;
        b=b+FPzFCfTHIittWhMxlw/I2J1nVKS41Yww3CgpTBaU4q2aX/nam6xPp/tLittdnp0fqfqm
        Mc5ZLB1tYVv5ALWEvljdzYvZk77qkW0ujojENIoedPPJ4bokUprhV0qOefcnlxDL6TKGmU
        JyVjCIEky9AZabkwsIWdYmW6GDHu8Tw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-5xGWCX6yMJKi2CGIFnYV_w-1; Fri, 09 Sep 2022 16:21:36 -0400
X-MC-Unique: 5xGWCX6yMJKi2CGIFnYV_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4CAA101A56D;
        Fri,  9 Sep 2022 20:21:35 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853AE492C3B;
        Fri,  9 Sep 2022 20:21:35 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     linux-input@vger.kernel.org
Cc:     Mark Pearson <mpearson@lenovo.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthew Haughton <snafu109@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Input: synaptics: Enable InterTouch for the ThinkPad P1 G3
Date:   Fri,  9 Sep 2022 16:21:26 -0400
Message-Id: <20220909202127.141761-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while trying to debug some unrelated issues: this laptop has
the ability to use rmi4 but doesn't by default. So let's fix that.

Tested locally, including mouse buttons, on my ThinkPad P1 G3. This might
also enable the X1 Extreme G3, but I don't have such a system to test
locally (presumably Mark can chime in if that's the case).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Mark Pearson <mpearson@lenovo.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 434d48ae4b12..9ad03a592ceb 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -182,6 +182,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0099", /* X1 Extreme Gen 1 / P1 Gen 1 */
 	"LEN009b", /* T580 */
 	"LEN0402", /* X1 Extreme Gen 2 / P1 Gen 2 */
+	"LEN040f", /* P1 Gen 3 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
-- 
2.37.2


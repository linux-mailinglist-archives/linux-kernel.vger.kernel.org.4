Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEED74D24B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGJJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjGJJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:51:42 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CBE6E;
        Mon, 10 Jul 2023 02:48:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6b886456f66so2577931a34.0;
        Mon, 10 Jul 2023 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688982504; x=1691574504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGz8+IC70d256D98s3UkooXpKb6O9hQKDllGM7BVdAY=;
        b=mdSyE6hzeu/hvw8FSZ+A3gftTlWP92a9q17rdDNg65uIAOSgPqe7knBIMJBsMF5Xma
         uAp5grYIC5jiwerfBpF1GWeGUS6P8vk18ls6S1hAH/OH/Q3zhKYltcB/xw6DFYu7OJoc
         P0k6w9vfNYWXEVUQiqD1kpezvVfcmWvWHa3MHJPhjU8Zn/1IZTGjPRPfNgRYtyOQoBjZ
         jMdmcSyuSwavrjG88xTT5+FR3dXOo6U/Xt7GuBQ86HEouUiFcAIboXVLcM3EWyC6F4r9
         es8lXkbd9SELj0AIuLckmEmDxJEgmwSyzRZrKq1lN5ot06ujjRnkxJ/tYIhHchVNCF2P
         Pc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982504; x=1691574504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGz8+IC70d256D98s3UkooXpKb6O9hQKDllGM7BVdAY=;
        b=WcQNOLm+1xGei0X2wuEGb46ZNlPzD7lQkGKrTSYIv0/1QCt/EDPOgQ7F41MUxV9h76
         Bh1g+moV/UwzP7Ftk/SYMD24sIY+m1NSOWpjN3D7ExSZK0qzvSwGi2fCbOThviEz1mVw
         H1Bvm2z5ngSU8f/gWKXph8b/ld/KXDarFRNOOti+IJp20hB48m66jZ3jsfiLRr8jVPDN
         I/V70vO1O7h1lcHdNvmZs7wchDFe/qMQVG/TYOw0jTieufEh4WlGCousPplZJYil7YpR
         bQ+kOFo1Ge8GP67lE3soJ+tsSvRqAl/s9gm4VPiFhmDDQ6P3QupNGbBss+2F7ussDDDi
         +L5g==
X-Gm-Message-State: ABy/qLbuW02KTQS2TUV+JHgdiBD/l1qn9AMGBbmOcXeVFAqhPOOe8oeM
        rzfBbO7sY0Adw1PLq5ABx6s=
X-Google-Smtp-Source: APBJJlHqmYU1MiGWHBr6Gk/LMFOQOyGl4wGn6PSFPOOlMRoi+38ece62Adgwv523afyvaq7Cy44iIg==
X-Received: by 2002:a05:6870:5610:b0:19a:695:15a5 with SMTP id m16-20020a056870561000b0019a069515a5mr11451916oao.25.1688982504442;
        Mon, 10 Jul 2023 02:48:24 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.84])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a1a1200b00265b9178a73sm1745780pjk.6.2023.07.10.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:48:23 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     michael.chan@broadcom.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH RESEND net-next] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
Date:   Mon, 10 Jul 2023 17:47:47 +0800
Message-Id: <20230710094747.943782-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
to clear the unnecessary noise of "kfree_skb" event.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..d84ded8db93d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -685,7 +685,7 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 next_tx_int:
 		cons = NEXT_TX(cons);
 
-		dev_kfree_skb_any(skb);
+		dev_consume_skb_any(skb);
 	}
 
 	WRITE_ONCE(txr->tx_cons, cons);
-- 
2.40.1


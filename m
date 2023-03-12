Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C136B6C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCLWsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:48:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FED32E4D;
        Sun, 12 Mar 2023 15:48:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ne1so7200321qvb.9;
        Sun, 12 Mar 2023 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678661317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYIG2TIps/UChe2tmlcHWvW9bzPS2sZ9r5iw2+hEA+k=;
        b=JPVY1ePc1a3gjwTW8x47phBxj6NqlY9yiADR1dVl/xI9bbeO/sG01Cm6cfZu9+o+fB
         sfiTKThIMGhjo8YjUJWVefvRJQsoMhLu2eznPndD8obBGY8jcAp/A7pmnFrCbLByJUpz
         rkGaV41VkxnPS9HnqN8EnJryCGRObKC26pKkgoD5PIyjRz66lR8/XLNiNXsntwZawZ6B
         rBS9+6U45dACma4BCt/S1r5qfXg1L51OALkuAF9H9JyRBUemR+xBBhJvhWJS7pDPkKaa
         RKXVQEDk3numuPfloGw0jpKh/tAvQM+N3FD0OhCS9TPHpLoFjyHVffxGaOsBwfHmG8lm
         Sn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678661317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYIG2TIps/UChe2tmlcHWvW9bzPS2sZ9r5iw2+hEA+k=;
        b=uRPwjzwoG3bu2volrUl4Wt5UjsAbA4TfWu9lmzUNegLsGiMl5NyPr0iJcHoE5566+O
         sONppnenk9MPGBDlnq8UG7Pe8uT/oDGFRh+zK1Dh8+4yymqar9skQ9L7zvy2vkZ2T4ay
         OfX6qh3VAuVoYjAzoTiuxFpNEAmUiQrMjJjl5/xbTDbW4llMl2BQCdCkuL8bVQzTgJKg
         ZuczBQgKV3yq9iHO7wjt4CFXyKd30GUM4neUFFdszjjMnEwHyE3yYHss/ccQm+zlbCwU
         EAhyUimTCKuXI9QdxaRdkWhieTpgrNWXt0yjWXS+/LKzuGKlFzRmu4t0fMHzr6jJzCOb
         N1oA==
X-Gm-Message-State: AO0yUKXCeu/cmFpfuiCptHtynamfSMR8spDf37SFYl2Db+rDn45qgNFl
        Ok9o7FPX8jwsmReW/eDmSg4=
X-Google-Smtp-Source: AK7set9AiFeN6g8qYlrBWkb4Li+WIUQsejl/BbRGfYJiZl25n0i3OhEhEBJqL47CeGzMMJ37Kgpcow==
X-Received: by 2002:a05:6214:238e:b0:572:5a16:51c0 with SMTP id fw14-20020a056214238e00b005725a1651c0mr10317950qvb.16.1678661317054;
        Sun, 12 Mar 2023 15:48:37 -0700 (PDT)
Received: from localhost ([72.138.97.66])
        by smtp.gmail.com with ESMTPSA id m6-20020aed27c6000000b003b62bc6cd1csm4416792qtg.82.2023.03.12.15.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 15:48:36 -0700 (PDT)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.chen@kernel.org
Subject: [PATCH v3] usb: gadget: epautoconf: claim smallest endpoints first
Date:   Sun, 12 Mar 2023 18:48:36 -0400
Message-Id: <20230312224836.297793-1-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 2.39.2
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

UDC hardware may have endpoints with different maxpacket
size. Current endpoint matching code takes first matching
endpoint from the list.

It's always possible that gadget allocates endpoints for
small transfers (maxpacket size) first, then larger ones.
That works fine if all matching UDC endpoints have same
maxpacket size or are big enough to serve that allocation.

However, some UDCs have first endpoints in the list with
bigger maxpacket size, whereas last endpoints are much
smaller. In this case endpoint allocation will fail for
the gadget (which allocates smaller endpoints first) on
final endpoint allocations.

To make endpoint allocation fair, pick up smallest
matching endpoints first, leaving bigger ones for
heavier applications.

Keel old behavior when "wMaxPacketSize == 0" because
it's a special case. In this case a gadget driver wants
to use a whole available MaxPacketSize of claimed
endpoint. Since it doesn't know what MaxPacketSize
may be in a particular UDC endpoint, it just
relies on epautoconf core and gets what's available

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---

v3: updated commit msg, rebased onto latest gregkh/usb-next
v2: rebased onto latest balbi/next branch
v1: https://lore.kernel.org/lkml/20200629200551.27040-1-ruslan.bilovol@gmail.com/

 drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index ed5a92c474e5..086bb46e3f5a 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	struct usb_ep	*ep;
+	struct usb_ep	*ep, *ep_min = NULL;
 
 	if (gadget->ops->match_ep) {
 		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
@@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
 			goto found_ep;
 	}
 
-	/* Second, look at endpoints until an unclaimed one looks usable */
+	/*
+	 * Second, look at endpoints until an unclaimed one looks usable.
+	 * Try to find one with smallest maxpacket limit, leaving larger
+	 * endpoints for heavier applications
+	 */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
+			if (desc->wMaxPacketSize == 0)
+				goto found_ep;
+			else if (!ep_min)
+				ep_min = ep;
+			else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
+				ep_min = ep;
+		}
 	}
 
 	/* Fail */
-	return NULL;
+	if (!ep_min)
+		return NULL;
+
+	ep = ep_min;
 found_ep:
 
 	/*
-- 
2.39.2


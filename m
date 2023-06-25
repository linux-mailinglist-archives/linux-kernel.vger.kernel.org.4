Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA92A73D290
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFYQvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFYQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:51:00 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4AB7;
        Sun, 25 Jun 2023 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687711854;
        bh=ULx3wX+XMVeigercXBoqPiB3jqlbn7oDvMIMzYZ5TSs=;
        h=From:To:Cc:Subject:Date;
        b=CfMvs3gT3j+jBSrb5D+jtbtPtE0EwU1kx3p/zd/OlN3Q4VGKNVTqbRo0QYtM8waIJ
         QJigxzIlDOKS9bUFOJe8H1O7PHQ1kaoCvd4EVeIV4FRlb1ZMMUwcQm5UOJpbKnmyOw
         TxUkmyDRUjtCcMa+DfJ+iMDdFCwtHpdKV0xi4GbE=
Received: from localhost.localdomain ([122.14.229.236])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id A9A2A055; Mon, 26 Jun 2023 00:42:26 +0800
X-QQ-mid: xmsmtpt1687711346tg34imyg9
Message-ID: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
X-QQ-XMAILINFO: NUoqT9CRNGLktLe03EA26suTrp/6WoKbh3uyq6gI6Laf3iYIlrsVt+j5hNNtSs
         fLYRD/A6zL8h6i2kOPpD0flQHcJ3x4+RjEmPTOqeGMR4MF7djfr9nTzfyy16d5sITFmOouzOuVdT
         m5BeNGvLZrTqLTl1rVfMjZQlIJ3YhzNLm/hDWbzLWirEJAIveTRSQy0tMVEDJV4hRdlT/KmZELnc
         jUGvGqyEN4+q8UUX3pGzFn35Atc+U/I2rFqq1D7h3sPX22e/BXi2FYQCanbwor0ESnL1dDs3s2fU
         ayeNk4h7cM2xEeeIC95x7cF+S7JX1+IF17gfEFDU+vBEvPi+IouiHT2jqI7rIhS5WNWohdVaqRzf
         MpyzRW11ay4nC6JvrHAr8p8YlaeeZGr+GxU8RtR2IwwneFejF/EtjnkmTjHTw3Ha/zUge7JnEgWd
         dPmrzqEBLjNti4CJsm0q2gxmupNN3jNSNJGzrok9k58vjttdeLLSZPkdeALLuvHauydujeeFI7Q6
         QhIGoB/ZXKfkUBWLy9qfbbKelYm8DIVG/ZtS5iPZfMdbtXjEwIZZ744A9oC4nU2O9og2NxB97cqp
         addINjibYwepbHwcBsJu/xT1yGXlxb1MEoOtxlLIxVa9MkROjFySkhD3TJSesjfkXdImPOFTWJEr
         Fq4QJz5x3o11fsbccWPVBqijqjm15K3u7APd5YcvarTD+DMyTBkJ5k7J4qchCQW/OYr1XQinnMPQ
         wmL/NBImn52FIkeFzE5jtoa43dOOqo80IGAsSAEqRqpyNW2jEADsdWGMvJXy2ORocIIir2Qs9HxE
         GUeSacyIb7QdAgxh5DZHN18GsO9bId+GnsUEhQcARu5kinI8H7VsbAZlWuuOC3wi6njBJySUlnlM
         SpN8QltQpHNAa6hHOexNgHacdalcJE2prZkyN0TqE1e58hB+yfbT8i/daQdtA91xsSpSElfpE83g
         l9ZYvyMQ0swsLePKVdDDJpjZZeKG2o/NzG0mrGAD8nfy/HJsMUFx+lfwfomt+h8HgPQ4WT+I4=
X-QQ-XMRINFO: M0RWTeBkoNRBR1Uh12iQNRvA1CSLhD8+1Q==
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     jgross@suse.com
Cc:     gregkh@linuxfoundation.org, xen-devel@lists.xenproject.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] xen: fix potential shift out-of-bounds in xenhcd_hub_control()
Date:   Mon, 26 Jun 2023 00:42:18 +0800
X-OQ-MSGID: <20230625164218.7134-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix potential shift out-of-bounds in xenhcd_hub_control()
ClearPortFeature handling and SetPortFeature handling.

wValue may be greater than 32 which can not be used for shifting.

similar patch:
https://patchwork.kernel.org/patch/12162547

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/usb/host/xen-hcd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xen-hcd.c b/drivers/usb/host/xen-hcd.c
index 46fdab940092..c0e7207d3857 100644
--- a/drivers/usb/host/xen-hcd.c
+++ b/drivers/usb/host/xen-hcd.c
@@ -456,6 +456,8 @@ static int xenhcd_hub_control(struct usb_hcd *hcd, __u16 typeReq, __u16 wValue,
 			info->ports[wIndex - 1].c_connection = false;
 			fallthrough;
 		default:
+			if (wValue >= 32)
+				goto error;
 			info->ports[wIndex - 1].status &= ~(1 << wValue);
 			break;
 		}
@@ -527,6 +529,8 @@ static int xenhcd_hub_control(struct usb_hcd *hcd, __u16 typeReq, __u16 wValue,
 			xenhcd_rhport_suspend(info, wIndex);
 			break;
 		default:
+			if (wValue >= 32)
+				goto error;
 			if (info->ports[wIndex-1].status & USB_PORT_STAT_POWER)
 				info->ports[wIndex-1].status |= (1 << wValue);
 		}
-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94992740BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjF1Iek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:34:40 -0400
Received: from m12.mail.163.com ([220.181.12.214]:51146 "EHLO m12.mail.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235496AbjF1Ibv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TZ63D
        hoeDCYyBIbyvSorhwvX2zStbpYvqashuoDCgeQ=; b=PCaFIRrNDL2QDhpv5cWAJ
        by/lH8bxQpMCrCbUpNXBwCr66VEGPn4PoHvA3G+XOaQgpfjFDNIbzieBYPibZpl8
        lMA+28ZcPCOvGFe7jhar7j3n+5KuMn5hHimQH3AkHCzIIUFtprEbKXprSphB5GR3
        eMbYipNr3P8JlL2jNnUhqk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wCntAEV7JtkwE1oBA--.64150S4;
        Wed, 28 Jun 2023 16:15:27 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     leoyang.li@nxp.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc
Date:   Wed, 28 Jun 2023 16:15:11 +0800
Message-Id: <20230628081511.186850-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCntAEV7JtkwE1oBA--.64150S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur1rtFyrCw43Kw4DGryUKFg_yoWfJrb_u3
        WUWrs7Wr17Ww129r17Za1Svr9293WkZ3Wkua4vqr9rAa45G3WfJryDXFs5Ca17uF43WFn5
        A3yDJ3sIkw1SqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU822MUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR+cC2B9nNSTkQAAsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 3b1cc8fa30c8..f4e5cbd193b7 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1959,6 +1959,8 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
 		struct qe_ep *target_ep = &udc->eps[pipe];
 		u16 usep;
 
-- 
2.37.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B178697766
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjBOHdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBOHdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:33:23 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBC028D31
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:33:18 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230215073316epoutp023ef27ac4d1e3ea4af7d65de2c4929127~D7x16P5h51830218302epoutp02N
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:33:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230215073316epoutp023ef27ac4d1e3ea4af7d65de2c4929127~D7x16P5h51830218302epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676446396;
        bh=RF/xzastbc895o4SA8/7HdvL35TK9YhPjdbYmMRhRTA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TGFovSsHkBawJ/N/Y3SH2VBfaXVy47p3kN9CaaEAzlEBG7zvJqoYxhYSZo7q+VArh
         C64ISMCCr1j9RT/mmS+7q27XsIKlu8h6GRkJtrlVBy5bmeUHfsG9ifiUxotI+1QMvL
         GOIq6F1OJUq7LYYflqxYEYzbPJW4M4Cb2vAu0ly0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230215073315epcas1p4335c5fb91495fc9bfd60a52fd5806a14~D7x1p3HLt2115921159epcas1p4Y;
        Wed, 15 Feb 2023 07:33:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGqYl1zxKz4x9QK; Wed, 15 Feb
        2023 07:33:15 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.BD.54823.ABA8CE36; Wed, 15 Feb 2023 16:33:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230215073314epcas1p18f4c784aa53ec77537c2dbd596014af7~D7x0lt9ag1246812468epcas1p19;
        Wed, 15 Feb 2023 07:33:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230215073314epsmtrp1adb93e54e45a08890d8579311f48f207~D7x0lHpJ52895528955epsmtrp1M;
        Wed, 15 Feb 2023 07:33:14 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-85-63ec8ababa31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.89.17995.ABA8CE36; Wed, 15 Feb 2023 16:33:14 +0900 (KST)
Received: from VDBS1418.vd.sec.samsung.net (unknown [168.219.244.30]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230215073314epsmtip19d854a30cac03c74690c39ff33a72540~D7x0bfPdY1295712957epsmtip1I;
        Wed, 15 Feb 2023 07:33:14 +0000 (GMT)
From:   Bumwoo Lee <bw365.lee@samsung.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Bumwoo Lee <bw365.lee@samsung.com>
Subject: [PATCH] kernel/irq/manage.c: print irq name when unbalanced irq
 enable.
Date:   Wed, 15 Feb 2023 16:32:17 +0900
Message-Id: <20230215073217.18269-1-bw365.lee@samsung.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmru7urjfJBg0H+SxOrFnEZHF51xw2
        i82bpjI7MHu8O3eO3aNvyypGj8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        zAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM1oPHmUsmMJTseXEBPYGxkucXYycHBICJhL3v/5g
        62Lk4hAS2MEocerkPkYI5xOjROvrHawQzmdGiV0L37HDtOz9eYIFIrGLUWLm5p3sEM4vRoln
        K9rBqtgENCT2XGxgA7FFBNwkunq/g9nMAmoSD1ZtBKsRFgiS+NozAyzOIqAqcXV1OxOIzStg
        JTF9zSc2iG3yEt3//rBAxAUlTs58wgIxR16ieetsZpDFEgKL2CX+Ht4C1MwB5LhIrNpsBNEr
        LPHq+Baoq6UkXva3QdnpEiuv3IGycyRe329nhLCNJd69XcsMMoZZQFNi/S59iLCixM7fcxkh
        1vJJvPvawwqxiVeio00IokRZovvBCyYIW1Ji8dM7UBM9JG48msIKYgsJxErs2nKMeQKj/Cwk
        z8xC8swshMULGJlXMYqlFhTnpqcWGxaYwiM1OT93EyM4rWlZ7mCc/vaD3iFGJg7GQ4wSHMxK
        IrzCT18kC/GmJFZWpRblxxeV5qQWH2I0BQbvRGYp0eR8YGLNK4k3NLE0MDEzMrEwtjQ2UxLn
        Fbc9mSwkkJ5YkpqdmlqQWgTTx8TBKdXA5Lx0RnX0DrUy37p6gYaFe6UvVs+uMjxuZnNy2sk3
        R3avEvzwRWlidLxfdcGrzwmfOrzuWxhU3n50MnDptlN5ckx2E3lVOZ7m7Vj5YuqTa7zXDa6s
        uikXl/q79RbXK2HmW+wLJh/nebSUbe+qY3zHedI7IlR27Dg7dU6POKNb67V3QYvW9Sq+aqlK
        5JTo1N7Pxh8k5ScU15B/p77WZ7blzLY192yYT/25dMLBxlRzqVlX3I891jNjO1bN0Td89HTJ
        Im1eof8i731n7NrMvH0vn4hpT9rUqkPrrFxmXXkmN1Pmj/mGkN3FsRsrnv4K5TC7EbD957RJ
        f5jVW4pZWfgmLv4y/cFjhWh28Y35Lt8kdJRYijMSDbWYi4oTAWf+rJL0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTndX15tkg19XNS1OrFnEZHF51xw2
        i82bpjI7MHu8O3eO3aNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgyWg8eZSyYwlOx5cQE9gbG
        S5xdjJwcEgImEnt/nmDpYuTiEBLYwSjx98spFoiEpMTZ5Y/Yuxg5gGxhicOHiyFqfjBK3L55
        kBmkhk1AQ2LPxQY2EFtEwEPi1+EVYL3MAmoSD1ZtBOsVFgiQ+HvHGiTMIqAqcXV1OxOIzStg
        JTF9zSc2iFXyEt3//rBAxAUlTs58AjVGXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xY
        YJSXWq5XnJhbXJqXrpecn7uJERxmWlo7GPes+qB3iJGJg/EQowQHs5IIr/DTF8lCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MM3h3PBig+xZD56Wrz/s
        xQPuqSrMFebr9luuItnzWubnbaVzjyPaklU+vVmT3sy0dIm5Y9T3Tdbv+1+uvPm59sYdiVt/
        j7t4PGVf+bFnUrHURLHN/j6l59U2qSU+u37n2xet/1uvLPXetsS3tiv3myt7cvkJj9b0NNPL
        C82PuEgszuoQ7wts7ZIt9hXy/Lur7eXBvsn+kudY+mJNhGfLc8z0YDs5wzyrSiPwtcy3dkn2
        QMfY4v0vbyZl99dMmfPlpJDA8XuC7R3f9c4Evf8kxvBoT9OXB1unv2iM/K7Wc1roWLC/vKum
        Ku/Xb+9+Nd5v6dW1+RtieVYq96BV94S3l+YtfPTKI1FdY4aZxPsHLEosxRmJhlrMRcWJABmj
        ZK+iAgAA
X-CMS-MailID: 20230215073314epcas1p18f4c784aa53ec77537c2dbd596014af7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230215073314epcas1p18f4c784aa53ec77537c2dbd596014af7
References: <CGME20230215073314epcas1p18f4c784aa53ec77537c2dbd596014af7@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make easy for debugging,
let's print desc->name at the time of the problem.

[3-32714.6377] Unbalanced enable for IRQ 69 (2800000.sdp_dvde)

Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
---
 kernel/irq/manage.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8ce75495e04f..161138998d8d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -781,8 +781,8 @@ void __enable_irq(struct irq_desc *desc)
 	switch (desc->depth) {
 	case 0:
  err_out:
-		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",
-		     irq_desc_get_irq(desc));
+		WARN(1, "Unbalanced enable for IRQ %d (%s)\n",
+		     irq_desc_get_irq(desc), desc->name ? desc->name : "Null");
 		break;
 	case 1: {
 		if (desc->istate & IRQS_SUSPENDED)
@@ -823,7 +823,8 @@ void enable_irq(unsigned int irq)
 	if (!desc)
 		return;
 	if (WARN(!desc->irq_data.chip,
-		 KERN_ERR "enable_irq before setup/request_irq: irq %u\n", irq))
+		 "%s before setup/request_irq: irq %u (%s)\n",
+		 __func__, irq, desc->name ? desc->name : "Null"))
 		goto out;
 
 	__enable_irq(desc);
@@ -907,7 +908,8 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 		}
 	} else {
 		if (desc->wake_depth == 0) {
-			WARN(1, "Unbalanced IRQ %d wake disable\n", irq);
+			WARN(1, "Unbalanced IRQ %d (%s) wake disable\n", irq,
+				 desc->name ? desc->name : "Null");
 		} else if (--desc->wake_depth == 0) {
 			ret = set_irq_wake_real(irq, on);
 			if (ret)
-- 
2.35.1


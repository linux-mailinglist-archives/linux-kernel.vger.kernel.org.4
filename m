Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACE25E9A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiIZHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiIZHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:08:39 -0400
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244D357E5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664176046;
        bh=DAdxeF0Jy1h05TSKR77+DI1s+EbnLB6RMzd5CjjIMI0=;
        h=From:To:Cc:Subject:Date;
        b=bq+SW9QCmSyFhEjQUCg6snQLGnlOGU6V/q0mWNy56qLoVf3xURZDomyZ5/hoxuQwD
         en+3+RlrZkOL34ECtm/oXWHHCLA1J3CGDsBpcm+lHzbZf9x/PbIRhdc2K9/EY3qKHS
         ylo+Punia7pPWHNusCz60qdXfl1Oa3Z9TViI5cHg=
Received: from localhost.localdomain ([59.172.176.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 1D73F6C3; Mon, 26 Sep 2022 15:07:23 +0800
X-QQ-mid: xmsmtpt1664176043t9cs56w36
Message-ID: <tencent_F11EC221954CFE8F406298A3732539562809@qq.com>
X-QQ-XMAILINFO: OAh6HToZKqQ0zSZ9HRPu4udPWaib+M7I2nFX9YEE+peFB78SgoB3waUpmcQ97b
         ojDDQWev7IpvQVV1oNifDMFJ0Wi9ZV7Mcgs2dubrmQI4/fhjZoksfLZeOzogl2eXcbZEJlhbsyLD
         2D2un/EfRp+gnfseb6eviY/5UJpuBvjXwTnIWKUzKxvwzndSQaRszrorl7zzfDiXkKofXeTVq0fJ
         MviqsqVUDHXRFAJJjgTirLFwFvqvm7+H6Ta/qZTQc97BnKKZxB1u0jonebHdYG3Ll1y5mEFs8r4o
         qz0B7gLwAfDh+b5UuYqz3gqgz4c1d1Ci310XfvfOt5myPT7+hMjh+V2S3i3VNSFNh/jNBNU8nLFu
         W1ZxY7oKr1w3uN9Tq+p8nxmBC2q9cQFvs88cpouJvDnbf+rjagKRbcfqB6c5/1evCb3gRqGWbn5Y
         vvLG9EyEbGmQ0h8vLZVaHlwJJKmLLrFWtN+cCVZuFxXLXNsx7+kt7IfZ2FX8BtAkNUm3adYo5WJd
         cXFbfUHXcnqfoAciGU4+gMFLbxgyW+k4Ylzdo3W/5cqcuf99a09pG7gN+9du/4m4Y1vqNm3N6yxG
         +27EvcQ2lxawQL5bjDDdcln+D0QTUy4YgaB1MiY7zQPmf5BwwWypfLq8+Mnr7cRv/MPojOhzF3bH
         s+7YzsZwc9IAmdZKppEFqVZ5WAe87htgbnravi22UyA+srKP9lPlqCjhyH5lQO8qnEz8q68R5DGh
         sSVODf67HO5pkeVRsrIQsFVbp3xelJAVFA0jEeTJrN+8d/QfHV/atfJZW5RIBKJrrUyzXK7LYa/L
         e1v2kTEfGROcRpk/SSbz7Nytw2HWBvQ5VlBp29XRaHudf90QjJDe0OlTqubBEz97MdAzzWLb0wyJ
         UN4M8BtdHcyaalpRgfIZ/Waebamej5FkTSjTOxrd5Os4tev28FdjQZ2jpXg+eLJRaYfA7hn6rkMc
         sEW8LTaeve/qhZlC03yQT3BBW0bwJb2TtVem2583Qzumwutxn17SX5H5ac8aaKi9ywBGDBwDG8NY
         rZI12wIjbkdQ95IP4OSFMV94zkBs4g4uJjIhiZjRU5AwJBtVFkkqA61ILscCQz0Ovell7Mxg==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: rtl8712: fix potential memory leak in _r8712_init_xmit_priv()
Date:   Mon, 26 Sep 2022 15:06:05 +0800
X-OQ-MSGID: <20220926070605.3363-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In _r8712_init_xmit_priv(), if `pxmitbuf->pallocated_buf` is allocated in
failure or `r8712_xmit_resource_alloc(padapter, pxmitbuf)` fails, then it
just returns -ENOMEM but not releases the previous allocated resources,
which can lead to various memory leaks.

To fix them, this patch unifies the error handler in the above function.
Note that if `r8712_xmit_resource_alloc(padapter, pxmitbuf)` fails, we
first call `kfree(pxmitbuf->pallocated_buf);` before goto the error
section so that we do not need to concern the failed item.

As there is no proper device to test with, no runtime testing was
performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
v2->v3 update the description.
 drivers/staging/rtl8712/rtl871x_xmit.c | 27 ++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345b..dcf3f76 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -117,11 +117,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto free_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -130,12 +127,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
 		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+			goto free_xmitbuf;
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
-		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
+			kfree(pxmitbuf->pallocated_buf);
+			goto free_xmitbuf;
+		}
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +145,18 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i--) {
+		r8712_xmit_resource_free(padapter, pxmitbuf);
+		kfree(pxmitbuf->pallocated_buf);
+		pxmitbuf++;
+	}
+	kfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
-- 

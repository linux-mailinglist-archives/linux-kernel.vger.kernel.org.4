Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C855B6E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiIMNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiIMNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:25:09 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2424167DF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1663075502;
        bh=tKBeLzzduMcJ2xyjvXECgZEYzh5G5fX2iEY9DXOhEvo=;
        h=From:To:Cc:Subject:Date;
        b=Z1tnJqefYecVBe2YrjoHXl7ap+zijkMd87FLE75nWw0Vs+SpLmHlGM3VTHWUnIUy7
         2gQrX4hR6PcN/cDP6BmcFAUoJxEqCUDdxpT4AZVQIJ0njS5esf3Gi0LlZLpxmPvpH1
         WJ5wSlqkM1L+1RV0QcdVBN6YiEk8buCoMce0SxVg=
Received: from localhost.localdomain ([113.57.80.61])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 63B064E3; Tue, 13 Sep 2022 21:24:59 +0800
X-QQ-mid: xmsmtpt1663075499to3s5e6wz
Message-ID: <tencent_DB57E4F270F4539485C32B05FDAF8394310A@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwROWwfJomQifEGwo2y52og5ZUKGHHXcLbvEdXnjVaSekj5Q3DtY
         f+ec5zYBR3jtZ+/542QwOi6WbVECojatOG74eO4VB6CGE6eiEWserR/d29n8+b1gq6in3Zpk8UIt
         3haZeE0nDMfVzaKTigIEhPa/4GJEmbK0lEwtiQaMqJavdJS8EoAVwiLgj3injUVfVS/wq81b316L
         W2D5Z3qZs28BJdGG1hhHjC7CNax3O9kCJfrpXmv93RZHScz0/1jK6y4oWuftJHKhZ0bWr2ewaWa7
         aUZSEuADCQo8c5pQttGechZD1Y/2NWnrj3a5H+qmfgSBu02WnsvWh6zV3TvP0FMyMrfoGRSO5iET
         HN5kf3AkT1j1jM9/fRjBdLXfDSEnDQUsAfQ72n+JtU5h3BIAY4QW9VKtU6wwLVIpefiZhW3fKhcU
         D52dizTHjziUW0DTeHbantgxSxleC+u1GThpLch9A18Axxb31nPJHdmzQWWJq0ZlW9y8P8mwr8A5
         dWs6xDbXsOTyNz+7/SY8mWCYW5DM9/stF2lsJjjlQ1FbexEoI9OiCZJaLB2kpjJenZNm+1omKct3
         iEeaB+J3Jucm0/2RfD/bf/LhOWgFJb56VMK2JrJk1B7T8fDeSEZrz2AVesFgNVIJwlxjTJF/xU4n
         16XxgEd+jnlGM/tpV9JSCwtwBQ6hEWU5BWamd3u4Kn9gzFgltXV915/kO+I8HxFmorMAhZKLxKNO
         Woi4rxS9w6CVTg0WIezSWEjAS7xVs0XB4/KFO18v/11/iZh0TQtcr/zLg625bQCspzdzuetJ9l3u
         aJZLM4KfllngosZfhloJdUnZ+Q+hMkr/rfBTWUGv4dd2r5sDuVL25vPcqgKTNq6HlqyYacVWaFDh
         ssiSR4WhJnZyIVnmdZbXyE9XwGhovnaCc75cPrMXTpnHsNkjAfEhBZk7h5XgzSKDhFIuYVSkXK8R
         cYK7FUGhw8UUd7vlPTwGwX0S0WDKY8rpSjziqVWgHNyelp0wqbTlY6Zk3gNx04e5A4WjCzGoz6m5
         t/AzmhgQ==
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v4] staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Tue, 13 Sep 2022 21:24:05 +0800
X-OQ-MSGID: <20220913132405.4387-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In _rtw_init_xmit_priv(), there are several error paths for allocation
failures just jump to the `exit` section. However, there is no action
will be performed, so the allocated resources are not properly released,
which leads to various memory leaks.

To properly release them, this patch unifies the error handling code and
several error handling paths are added.
According to the allocation sequence, if the validation fails, it will
jump to its corresponding error tag to release the resources.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description and adjust the sequence of patches.
v2->v3 None to this patch, but some to another patch in this series.
v3->v4 rebase the original series and merge them due to the missing check
for kzalloc() in rtw_alloc_hwxmits() had been added.
 drivers/staging/r8188eu/core/rtw_xmit.c | 30 ++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 9c39d08..9e70c79 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -134,7 +134,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -156,7 +156,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			msleep(10);
 			res = rtw_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL)
-				goto exit;
+				goto free_xmitbuf;
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -174,7 +174,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_xmitbuf;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)ALIGN((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -191,7 +191,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		res = rtw_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
 		if (res == _FAIL) {
 			res = _FAIL;
-			goto exit;
+			goto free_xmit_extbuf;
 		}
 
 		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);
@@ -202,7 +202,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (rtw_alloc_hwxmits(padapter)) {
 		res = _FAIL;
-		goto exit;
+		goto free_xmit_extbuf;
 	}
 
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
@@ -226,8 +226,26 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtl8188eu_init_xmit_priv(padapter);
 
-exit:
+	return _SUCCESS;
 
+free_xmit_extbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+	while (i--) {
+		rtw_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
+	i = NR_XMITBUFF;
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i--) {
+		rtw_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	vfree(pxmitpriv->pallocated_frame_buf);
+exit:
 	return res;
 }
 
-- 

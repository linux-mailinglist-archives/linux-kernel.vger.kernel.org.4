Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6495E9B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiIZIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIZH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:59:36 -0400
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9E2644
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664178962;
        bh=BLAzL3cBx/MYrBjV9n4BPhL0NhU2tBdsskwjNCqJgVs=;
        h=From:To:Cc:Subject:Date;
        b=SvFg+sduZouhYsWj5iePMsOyNUUYaz+DV3wF+48/bLWjXikFqCV0VJZOfFHcbZqOy
         jgxWDbdSkV9lqxv/2fC/AiGU17WvZjODQIbTaPRNseMwQMEfzqxZQoYAUWis8rNWZT
         eODxt0cu4E4NDzd4wBQtFk2wVvNvGz7MoJgddFOo=
Received: from localhost.localdomain ([59.172.176.188])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id DFBB9610; Mon, 26 Sep 2022 15:55:59 +0800
X-QQ-mid: xmsmtpt1664178959ty43hhfds
Message-ID: <tencent_F8100CE69CDC080E218AEF7033A5CCFF2507@qq.com>
X-QQ-XMAILINFO: NY7OhsirbEL36waAZPzGmqkpFKnnwmYIhOCQFF3TTTQuwa/dubz0TmyRkrIDXL
         K3Y6MG3YHc3mXJrMJEIRyVXowqd/NWUtct9V5YTlA11sqmX90WmgjES9Gati82LBFCwi8DtDeBi/
         8yTbbP34a7FyNl+xcfeVkT9fXi6Dht+u8b1KqflppxfNIcoTUXlLLq+8z/SKFJzQJ32FYAi2f9EG
         fz9AGuEQ/88eZ5PmCXaSuBCE+/W0Rru58xagUaxpd540iIS33d1UGZsWahberkV5Z7pvxyYlH4oz
         MjThxWmtZebAdLrp/jyL/XHhQc5fqcx+EML2D5GCFx/IaDlCNJnxEDVa4w7EMtIdPbso9rajF/8s
         /49Yh7olZnAc6KZtei3JEDa3ArTn6I5NhZLjfpDL3k6g+TeSNnlWOBzqDcXXx3P8yi3l9YRS04PQ
         fpfMZ+0zoH2j6I6wFL6j3Xoa8ngSKHZ7mDjs+nzMRCl/9CjOSkgd8llu9HhmMUU67YIAtOVkTEm8
         ZLfkQEE0nlGWV17BoQ6BuNuUC0lbHm9zJxlDEszGawg60piV56UGJbF1j0W2TGVnsttn9U8IMNDq
         +LtmzgQxw8z7mYPRBPz6jxkGwgbnx6pQRMEwz3dEy8H/DYTp2vVfQplyvrg13opSFc3TI/Sjl3HC
         K0FpdB+22CpleTtD0MLewqflWYLlTtrRXhc1KYvZ5fdFUltWj/J7CvyAWYm6Qzg5G85zQHt7U3ee
         dRubQFEnmOlF00PgOo2iQYeM/j4/MgWR1Yh9QGFC+obn7B+tN9C1vssBknFS5rdRmk4XIAtFomOR
         bIZCDVrlXIbDnzYUozfMyZz28vVp1Ekxscs8h7nw4YPxTFmowtao77u0Xx8ZoLXE9mkwd3ZkJm/z
         Md5e3CYVwZdf/uT2kg+QfWUxyi0SmAutv02n5f/TsPoaQWQcp6O8qm6d1m/Y80Tez3ydHLSeB+iy
         +p4iEH1hIiJpteimfxw0RfAvmg7FeGVba1k+rfvKSTpCJZWv7b1kfEabLbQSlJqFTOM42JLzm0il
         H5qXD7XQWIEOPvtyQxL4shlsjnv19kO0OKjbr7Pne0bnIN/r39Rq7elH/Zt8AXZg4yBIoLMw==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: rtl8723bs: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Mon, 26 Sep 2022 15:54:57 +0800
X-OQ-MSGID: <20220926075457.3500-1-xkernel.wang@foxmail.com>
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

In _rtw_init_xmit_priv(), there are seven error paths for allocation
failures without releasing the resources but directly goto `exit`, while
the exit section only executes `return res;`, which can lead to various
memory leaks.

To properly release them, this patch unifies the error handlers of
_rtw_init_xmit_priv() and several error handling paths are added.
According to the allocation sequence, each error will jump to its
corresponding error handling tag.

As there is no proper device to test with, no runtime testing was
performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
v2->v3 update the description.
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 50 +++++++++++++++++------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 528f920..b288b04 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -112,7 +112,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -132,7 +132,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ), true);
 			if (res == _FAIL)
-				goto exit;
+				goto free_xmitbuf;
 		}
 
 		pxmitbuf->phead = pxmitbuf->pbuf;
@@ -162,7 +162,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	if (!pxmitpriv->xframe_ext_alloc_addr) {
 		pxmitpriv->xframe_ext = NULL;
 		res = _FAIL;
-		goto exit;
+		goto free_xmitbuf;
 	}
 	pxmitpriv->xframe_ext = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->xframe_ext_alloc_addr), 4);
 	pxframe = (struct xmit_frame *)pxmitpriv->xframe_ext;
@@ -195,7 +195,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_xframe_ext;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -210,10 +210,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->buf_tag = XMITBUF_MGNT;
 
 		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, MAX_XMIT_EXTBUF_SZ + XMITBUF_ALIGN_SZ, true);
-		if (res == _FAIL) {
-			res = _FAIL;
-			goto exit;
-		}
+		if (res == _FAIL)
+			goto free_xmit_extbuf;
 
 		pxmitbuf->phead = pxmitbuf->pbuf;
 		pxmitbuf->pend = pxmitbuf->pbuf + MAX_XMIT_EXTBUF_SZ;
@@ -240,10 +238,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			pxmitbuf->buf_tag = XMITBUF_CMD;
 
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, MAX_CMDBUF_SZ+XMITBUF_ALIGN_SZ, true);
-			if (res == _FAIL) {
-				res = _FAIL;
-				goto exit;
-			}
+			if (res == _FAIL)
+				goto free_cmd_xmitbuf;
 
 			pxmitbuf->phead = pxmitbuf->pbuf;
 			pxmitbuf->pend = pxmitbuf->pbuf + MAX_CMDBUF_SZ;
@@ -255,7 +251,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	res = rtw_alloc_hwxmits(padapter);
 	if (res == _FAIL)
-		goto exit;
+		goto free_cmd_xmitbuf;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -267,6 +263,34 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtw_hal_init_xmit_priv(padapter);
 
+	return res;
+
+free_cmd_xmitbuf:
+	while (i--) {
+		pxmitbuf = &pxmitpriv->pcmd_xmitbuf[i];
+		if (pxmitbuf)
+			rtw_os_xmit_resource_free(padapter, pxmitbuf, MAX_CMDBUF_SZ + XMITBUF_ALIGN_SZ, true);
+	}
+	i = NR_XMIT_EXTBUFF;
+free_xmit_extbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+	while (i--) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMIT_EXTBUF_SZ + XMITBUF_ALIGN_SZ), true);
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
+free_xframe_ext:
+	vfree(pxmitpriv->xframe_ext_alloc_addr);
+	i = NR_XMITBUFF;
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i--) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ), true);
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	vfree(pxmitpriv->pallocated_frame_buf);
 exit:
 	return res;
 }
-- 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7953B5B52B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 04:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiILCux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 22:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiILCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 22:50:50 -0400
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF824BFD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662951044;
        bh=zHTVtpw1jtLKj4pje3/qkGFPlBtGbzFh4Fdpl+NRNPM=;
        h=From:To:Cc:Subject:Date;
        b=VS9pqvhUF9C9vphfM1RJg5mx/UCGQ/vVsMUqFeapDV8nVGvpVzwQRoxHCfPwIY48O
         +OsPqQj1xNFXJvgHPpOawDJWbFW9OK3rl0q9N3GvyROuBF91JVPG72dizKvxR0Rilc
         BDypkNo/eLFedyTqTltPB7cW1u4AvFSCOwAsvXuk=
Received: from localhost.localdomain ([113.57.80.61])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id CA98DA1D; Mon, 12 Sep 2022 10:50:41 +0800
X-QQ-mid: xmsmtpt1662951041tdf95majj
Message-ID: <tencent_3B46EE3287288555389AD2EC3F388827B306@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoePOtkVOiY2I0IevAwjw2WMg/aHjUmw8pBjti2+8Jb2a5HiqlA0
         TuzscuPoVyVj7FsEq22rOibB0ip5D6DLD63dTqn3owzewkn9S2a7CmnLTKYmwfftfS5pdUVSxA29
         4wZuYGwNHTUGPytaYZBnVHBUrmfCdibQxCKH+rIVxgkKNUZrHEs404dS51Rzsu2WHyR0CReRUedl
         NWJ2gJtH7D5Y6wbGWRuYmTtDvykLZyUSYcvQKcfB9OKJVMLqgFtjALaCNRx4jL9sMjS8+1U3xrCB
         4H/IVt4QzDydDTGTcpsw/GfWp5M0OjfDIcKxInl9hhtjb6oMmH2komhKp47I5Zu5/zKCHOQUZzAA
         c87H+3sN67c7vPKTWBw1CEeQuAZRz1DX1gqmKz1nLEjQzIpD96HXlfiGygDZcYBNLE6wBW54lSr2
         YKTjz8rSg8+1OOF4h476VQRkliLkcTCiS3lQ0xONM1+qUvPvVBpKfUVIDKWLb7QkRE/U2ZJyeCVH
         ho8sElhCpLFda83gJJLLWB9D7sIVHd+hIzRsBHLfW+4vMwVDQDFQXTNNc6JFxFsVNWywW2OF1qlQ
         4n4dSkVIW02MeChjDMD3R+d0AwapOaakgB2D/txmvd08la4k6eDmva7QKs1KRlBiOT1gaf1f8xnH
         0Lu4qfo5BJ6ipRoH2tUaKJlsrOSdX5Tx+H7dC36aprq/ntBbr+6N+xA/0X0nIXf0xqBIikCvpMgf
         YkN5dHdlIgOgLVx356/lEoZiOKb9CGMMDdQPZIbhAZVVSvlggVH0dKt6YdVDm1kH5xKXxgDg363x
         IHggS7D0TDfYZ6cM7lnjcG52o6OlvcM+Q64ESTAn1wKukm2JBT7zPXgoy2HHc33EuDbaeB6Sb7jP
         U6lWEuapTeUBxSj6GT22gAUCeD9M5ytE9c2Z03gfSg3pWbidaqSM7pJMZSRgQI9mfRV95h/tz0rJ
         LvlnFP6+3NG8ti/2HRshmPZAR86rWm4JAHuzYo2PlpnA9qzuhyCKrVpD1fi0jwZlq3uGTkMqg=
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v5] staging: r8188eu: add kfree() on an error path of rtw_xmit_resource_alloc()
Date:   Mon, 12 Sep 2022 10:50:26 +0800
X-OQ-MSGID: <20220912025026.4149-1-xkernel.wang@foxmail.com>
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

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_xmit_resource_alloc(), if usb_alloc_urb() fails, then the memory
`pxmitbuf->pallocated_buf` which is allocated by kzalloc() is not properly
released before returning.
So this patch adds kfree() on the above error path to release it in time.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
v2->v3 rebase.
v3->v4 update the description.
v4->v5 rebase and update the corresponding subject and description.
Note that the original function name was changed, so the subject of this
patch is updated from "[PATCH v4] staging: r8188eu: fix potential memory
leak in rtw_os_xmit_resource_alloc()" to "[PATCH v5] staging: r8188eu: add
kfree() on an error path of rtw_xmit_resource_alloc()".
In addition, thanks to Philipp Hortmann for his testing and advice.
 drivers/staging/r8188eu/core/rtw_xmit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 67f9c05..9c39d08 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -44,8 +44,10 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
 	pxmitbuf->dma_transfer_addr = 0;
 
 	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxmitbuf->pxmit_urb)
+	if (!pxmitbuf->pxmit_urb) {
+		kfree(pxmitbuf->pallocated_buf);
 		return _FAIL;
+	}
 
 	return _SUCCESS;
 }
-- 

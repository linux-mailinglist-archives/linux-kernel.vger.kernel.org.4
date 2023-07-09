Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83F74C128
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 07:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjGIFuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 01:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGIFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 01:50:22 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6EE4D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 22:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688881810;
        bh=HwcrTUcQaK+nP1jmqN22G3yOOzPJDfVlMUtckg/KrqM=;
        h=From:To:Cc:Subject:Date;
        b=OTs697UtvEaGGblA4C9/pVJwf+v6QX5WDJdmTB2BWfRNImsdzq9cwybVMMVcC6a2E
         hMigDJ8pVdMybAEiJygwbD10QPzR+FK0R2w1JkXsg61DMtJaIIjSIw+58vSyWAY14l
         axijB/nwCZ8KOv+PzJB0XCTZco5OQBhsi3cmC404=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id C88130EF; Sun, 09 Jul 2023 13:50:08 +0800
X-QQ-mid: xmsmtpt1688881808tcewaqfua
Message-ID: <tencent_5153B668C0283CAA15AA518325346E026A09@qq.com>
X-QQ-XMAILINFO: NyLRYIXSGAqGCejzGNrVsJO+yHH+nG25nZ7agwhLA8xneRLEhcez02mp+AXksu
         KFC76/pVZVIVKceSHjNRnTxen4uGwC3l0Czm6H2BUX/uO6nL/eFOrG8pd+doynGVEZNzp0Da5ryU
         U2v6XnFA3kuT7gqpe85h9PqH+ZRGRI5rFZ1BuveMs3rB35Xkl1WHs6FmoAA1FEtV93j/AsXL2umF
         Mzh6hEXlmJCkoLnwN3gWBloL8pcVbud4DX+7xRSvdWyagB2EIOvTwyjuyqtsq6xw3SUJVBKVPzJ9
         OcUeeIe+mVN4st3RxZ9U5hRItoGUuJ73eGdhnOmieia7PnLU2WLtgg3QSkLme4287bTqrmNTW7gw
         rq85ihSNeDSdkQNuWWn89aFoAI6g8ip9D2hRPS4cjdMQUqU7pLfIS3/sWdzyIn65WjXt+HnImf2G
         nCThagF5ulsbTvqbri8+g+IPjKYx7AqkZvfIIgNtxij6u+pVxFM/xMbAEQeWb+Ul5e78xH9SZgOC
         mw5Gx1AkvuzFe5nOydKjOytZIPnqUlAIIYEsGoVp9kG39C255uErgXq7Mv4/1M6gatcF+y9s2LhC
         Ut/aKKFiQ3GnDvxwnb80QHTtIJmrr5GD6NEL6EY9/DImofU17/7PBGNHUx3fD8WmdOPqy0VjmlxN
         hrZ6uiRnvgEwh7ylZGxDDfAjkbOwpzyxAn62o53OXmrdqLsc/7Q2Z59B8Y+tzXV880baDNLot68+
         oB3k2n+PMwTsd1KsHezQcnLd+jjcrOV3wN312lrAspwbqVzSZiF/j8FY/i4/yCLkj2gDrHGEFaS3
         zIJ+y1oNLaAbCBCzN2OweXfPrNGmB4NIv8zJyht4cAt5FfD1fmS0pS5b9b/qY1ZEv9R/X4BHmoHm
         mvNVB7GTjKv1YCduuYySRKgM17g8jT81pMGfywvbsNElaLb6qX+8c+kdg/ypfyofhAiqChdh15q2
         5SqAr+fBfm2i0kIOg7m25bedn7b4cXvX8Piq31LrQF9gqeYd5grnt+Rd/PX5Zb
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     gregkh@linuxfoundation.org
Cc:     error27@gmail.com, xu.panda@zte.com.cn,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()
Date:   Sun,  9 Jul 2023 13:50:07 +0800
X-OQ-MSGID: <20230709055007.794710-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "exc->key_len" is a u16 that comes from the user.  If it's over
IW_ENCODING_TOKEN_MAX (64) that could lead to memory corruption.

Fixes: b121d84882b9 ("staging: ks7010: simplify calls to memcpy()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index e03c87f0bfe7..0fb97a79ad0b 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -1583,8 +1583,10 @@ static int ks_wlan_set_encode_ext(struct net_device *dev,
 			commit |= SME_WEP_FLAG;
 		}
 		if (enc->key_len) {
-			memcpy(&key->key_val[0], &enc->key[0], enc->key_len);
-			key->key_len = enc->key_len;
+			int key_len = clamp_val(enc->key_len, 0, IW_ENCODING_TOKEN_MAX);
+
+			memcpy(&key->key_val[0], &enc->key[0], key_len);
+			key->key_len = key_len;
 			commit |= (SME_WEP_VAL1 << index);
 		}
 		break;
-- 
2.30.2


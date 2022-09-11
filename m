Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E853E5B4D95
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIKKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIKKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:45:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F787220EA
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z21so8907480edi.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=BiDnhWQR6g6Mj6136/H/ZREAE6myEKa/wQMFwuUDLyQ=;
        b=eRATwTDb4tdZl8oa9NPKs8lcb0bCZCR2qPAK+hhwflqa+1bjo8vEqFT62P2dNrR91T
         VeG7EAcrDCeBLmtLmiVar8MHMUJM1ZNd2Pnocpo/BN52kAqshEQ2wyMYA40CPCpQ5Reo
         l9j6MvTe+woEFXtCuCeXES9JoWfzA2aNKsQ0E87nBzTPEzRp0d0GOPKMWkeTHLHhSXfo
         a/kzf3+FFNVamDb18sry+56J+4y7Z/SMBUGZtTAhDDtO3s1n+vhwyb701vygyeim9boG
         aUxHVthaozlWrdFHvZmMxap/ElLmqOXGpkXzff8Za7Bu6p3nnLk/649NKsggI9leQ0x9
         mjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BiDnhWQR6g6Mj6136/H/ZREAE6myEKa/wQMFwuUDLyQ=;
        b=TTyUex1XrPWqu70NawE+0SvW412IkUwVuqrpr4xEs5bymw5JuK2IqmxwQHjhYp2pV8
         Lu+CR0ts7OKe0WOmkx3qLCqkHRNFhPhQG2vgUWS5oWpCK1vBtAqW9taFmwR0WLJW6cmi
         yAPv2gfNr8b8s8i4/1jjQPVwYsuu2twbFv0Vpq9PBLCutDcosb8UJ/DY8Xghlv2zf8qw
         psCg0NU5/wT6aLOjFzdPsqPimNy5jREsB8LCtbEUGArtITPTuYnyiJvq1ga9KROiJRbG
         mU5ujF6dteWe5kR+frPKcLAu3RFRwdnqdFv52tvd+8DQnlaX8kQXhZhCtyVWzDTCdkq4
         wciw==
X-Gm-Message-State: ACgBeo2POCw9lucgFum1IKcmGphozexE/wOdMeOFpAP/uoKcdgNgciWw
        0LkgxXZVh9rxeL4jqkFkEkmsiPzZ3so=
X-Google-Smtp-Source: AA6agR7diDymzbq2G68+mWq3Lvc6HGGKCvrDd/8LzkIi42v4ywsAulBhrUOfN+7r9ZDHAVhpeGASXQ==
X-Received: by 2002:a05:6402:254b:b0:451:2b1d:d82c with SMTP id l11-20020a056402254b00b004512b1dd82cmr8013158edb.343.1662893144040;
        Sun, 11 Sep 2022 03:45:44 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906314700b007708130c287sm2840318eje.40.2022.09.11.03.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:45:43 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:45:42 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] staging: vt6655: Cleanup and rename function
 MACvSaveContext
Message-ID: <f514711695f1eafde9996edcc246da2adcd5f9c5.1662890990.git.philipp.g.hortmann@gmail.com>
References: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function MACvSaveContext to vt6655_mac_save_context to avoid
CamelCase which is not accepted by checkpatch.pl. Remove unnecessary
declaration of function and make function static. Change declaration of
cxt_buf to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 6 +++---
 drivers/staging/vt6655/mac.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 567bc38ecfa9..092b1fffcfa1 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -14,7 +14,7 @@
  *      vt6655_mac_set_short_retry_limit - Set 802.11 Short Retry limit
  *      MACvSetLongRetryLimit - Set 802.11 Long Retry limit
  *      vt6655_mac_set_loopback_mode - Set MAC Loopback Mode
- *      MACvSaveContext - Save Context of MAC Registers
+ *      vt6655_mac_save_context - Save Context of MAC Registers
  *      MACvRestoreContext - Restore Context of MAC Registers
  *      MACbSoftwareReset - Software Reset MAC
  *      MACbSafeRxOff - Turn Off MAC Rx
@@ -181,7 +181,7 @@ static void vt6655_mac_set_loopback_mode(struct vnt_private *priv, u8 loopback_m
  * Return Value: none
  *
  */
-void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf)
+static void vt6655_mac_save_context(struct vnt_private *priv, u8 *cxt_buf)
 {
 	void __iomem *io_base = priv->port_offset;
 
@@ -303,7 +303,7 @@ bool MACbSafeSoftwareReset(struct vnt_private *priv)
 	 * reset, then restore register's value
 	 */
 	/* save MAC context */
-	MACvSaveContext(priv, abyTmpRegData);
+	vt6655_mac_save_context(priv, abyTmpRegData);
 	/* do reset */
 	bRetVal = MACbSoftwareReset(priv);
 	/* restore MAC context, except CR0 */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index f7d00a251677..1752905d7df0 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -553,7 +553,6 @@ void vt6655_mac_set_short_retry_limit(struct vnt_private *priv, unsigned char re
 
 void MACvSetLongRetryLimit(struct vnt_private *priv, unsigned char byRetryLimit);
 
-void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf);
 void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf);
 
 bool MACbSoftwareReset(struct vnt_private *priv);
-- 
2.37.3


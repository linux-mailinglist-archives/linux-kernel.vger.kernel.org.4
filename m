Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8467427C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjASTOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjASTNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:13:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9648BA85;
        Thu, 19 Jan 2023 11:12:37 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r205so2495461oib.9;
        Thu, 19 Jan 2023 11:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9IUy7GLABZ5KCsScXO19g5oGUisQlGEvz/MbBgHRXn0=;
        b=UpNfO+fLo0XtRNq+Zjx0IvXDu61ZVqKlEhHq5TH7jefsHQFH8m7qeJvJa5NBXqflIY
         LiZStuvaYyz9nQAr/njjPZxgqSDCu2HSAA0mu3VEq1BBU2lq0NyzLus46sephBrBwZ+H
         JB5Nr7nZpyDM4yN0fwHBHqwnWobnYP0T4rFNt0zC4HqfOx2RdoYZTeHyFwSKPbQHqE9Z
         6Z8ZwBcJlTvUSdionPgEFDNkgujetb30X3cI8j7k7UUbwbrejSwU4cYF1BZSdbEOkbxK
         PX4j5pT//oReOn/yhDleAzoB2jkD7ef2KKfTicRU3NDTUY4mXcvXo3VVnlJoqLXIofMy
         Hf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IUy7GLABZ5KCsScXO19g5oGUisQlGEvz/MbBgHRXn0=;
        b=qpCNBOmA/EGtOynr3gbAPVLxMoMKYlxft4xnBcqn6u41wQvpibhBDDA7b8NIjtdJbF
         qKVuNeyHsqK7kuc8jzAPk3zO+R+U0A8eXQZ7cdTi8PzPFmixvkfPrTuVygGrULbhAumG
         QOOWPRLkt2546QmjTzbzTJ4MLQKnWeizcxi/mUbzF+e/ou95uuY3ICKkBbAWwGCsEZxW
         GArg41WBx+oW66hcrsae3aSIQqv1GKf4vmnTxWA/OTDYMTBSRrRmHzGHizM5YSUr7T30
         QmDv9fgv5OuS08MooYsEDFQzc+jn/IiyzRTH3SUX+Vbg10NG/X2rPPc9eUyQ33DmM2EP
         mL9A==
X-Gm-Message-State: AFqh2kq65YNyZNFYTcBTDIKw2GIicB65UdLQ06Egn0UuiEb/3xHzKqll
        C8+Fv3GolOF4X01EICcCgbg=
X-Google-Smtp-Source: AMrXdXsz2qG9hNhQ2wRQBsd7Jr3zo+UJhvpVrm4FIJlPBrR9O/h7c7M4pfciMirVcNLa5MRC2rzPcg==
X-Received: by 2002:aca:3402:0:b0:36a:3a8a:212d with SMTP id b2-20020aca3402000000b0036a3a8a212dmr4224163oia.45.1674155554544;
        Thu, 19 Jan 2023 11:12:34 -0800 (PST)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o9-20020a0568080f8900b0035e461d9b1bsm18431209oiw.50.2023.01.19.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:12:34 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: [PATCH] staging: r8188eu: Fix some endian problems
Date:   Thu, 19 Jan 2023 13:12:19 -0600
Message-Id: <20230119191219.12080-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse lists the following warnings:

  CHECK   drivers/staging/r8188eu/core/rtw_mlme.c
drivers/staging/r8188eu/core/rtw_mlme.c:1197:49: warning: incorrect type in
					 argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    expected restricted
					 __le16 [usertype] mstatus_rpt
drivers/staging/r8188eu/core/rtw_mlme.c:1197:49:    got unsigned short
					 [assigned] [usertype] media_status_rpt
drivers/staging/r8188eu/core/rtw_mlme.c:1275:57: warning: incorrect type in
					 argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    expected restricted
					 __le16 [usertype] mstatus_rpt
drivers/staging/r8188eu/core/rtw_mlme.c:1275:57:    got unsigned short
					 [assigned] [usertype] media_status
  CHECK   drivers/staging/r8188eu/core/rtw_mlme_ext.c
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58: warning: incorrect type
					 in argument 2 (different base types)
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    expected restricted
					 __le16 [usertype] mstatus_rpt
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6842:58:    got unsigned short
					 [assigned] [usertype] media_status

The second argument of rtl8188e_set_FwMediaStatus_cmd() needs to be in CPU
order, not little-endian; however, when it uses that value to call
FillH2CCmd_88E() the parameter must be in little-endian order as that
value will be sent to the firmware. Note that the conversion from LE to CPU
order was le16_to_cpu() rather than the correct cpu_to_le16.

The definition of FillH2CCmd_88E() is revised, and the proper conversion
routine is used.

Note that the original code performed one byte swap on the secong argument
of FillH2CCmd_88E(), and got the correct answer even though the semantics
were very wrong.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Reportewd-by: Gaurav Pathak <gauravpathak129@gmail.com>
---
Greg,

I intended this patch as an example for Gaurav, but as it has not been
resubmitted, I am sending it to you. If you thing he deserves to be the
author, then please edit the patch before applying. Thanks, Larry
---

 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     | 4 ++--
 drivers/staging/r8188eu/include/rtl8188e_cmd.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 8310d7f53982..788904d4655c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -193,9 +193,9 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 
 }
 
-void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
+void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, u16 mstatus_rpt)
 {
-	u16 mst_rpt = le16_to_cpu(mstatus_rpt);
+	__le16 mst_rpt = cpu_to_le16(mstatus_rpt);
 
 	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
 }
diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
index 1e01c1662f9a..c785cf8ed683 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -85,6 +85,6 @@ void rtl8188e_Add_RateATid(struct adapter *padapter, u32 bitmap, u8 arg,
 void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state);
 
 void CheckFwRsvdPageContent(struct adapter *adapt);
-void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt);
+void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, u16 mstatus_rpt);
 
 #endif/* __RTL8188E_CMD_H__ */
-- 
2.39.0


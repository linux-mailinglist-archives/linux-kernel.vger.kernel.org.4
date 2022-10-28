Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598D9611203
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJ1M5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJ1M5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:57:03 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60E1BFB89
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666961809; bh=lEKw0VqbwNuC4XyGnQEaICgfcwjW+MBtFkkBkwVWc8g=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=fw9vbUfl0GLTtNJvI3oQ8w344HMaf8qj6dQ0A2U8lEACBgT05HOSlvlL/0Du57HMU
         dh5/jiMiA+0EEkTO0Jmy8C7lwvYRZEbk8aMeqvM70sjoNRSnXgtW4aPgEMD813vXyt
         rg7CbB9o6tVOrbVOtlx1ZC/7fgwIhIIJnH1Q7xq8=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Fri, 28 Oct 2022 14:56:48 +0200 (CEST)
X-EA-Auth: pe0cS9Nh5+DFLxMvYTNXZ7QsyNRGy9Cnw4vNHRK9I2lj3ljt7IUlsKPP45XMfG19xntHkZm9KYARn2cEYHeWGmaiTImTctmY
Date:   Fri, 28 Oct 2022 18:26:42 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: Use flexible-array for one length array
 member
Message-ID: <Y1vRivFfRD6VoBt/@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexible-array member should be used instead of one or zero member to
meet the need for having a dynamically sized trailing elements in a
structure. Refer to links [1] and [2] for detailed guidance on this
suggestion.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Issue identified using coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/r8188eu/include/odm.h         | 2 +-
 drivers/staging/r8188eu/include/wlan_bssdef.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 89b01dd614ba..e2a9de5b9323 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -166,7 +166,7 @@ struct odm_ra_info {

 struct ijk_matrix_regs_set {
 	bool	bIQKDone;
-	s32	Value[1][IQK_Matrix_REG_NUM];
+	s32	Value[][IQK_Matrix_REG_NUM];
 };

 struct odm_rf_cal {
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index 831c465df500..33177de194eb 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -179,7 +179,7 @@ struct ndis_802_11_status_ind {

 struct ndis_802_11_auth_evt {
 	struct ndis_802_11_status_ind       Status;
-	struct ndis_802_11_auth_req  Request[1];
+	struct ndis_802_11_auth_req  Request[];
 };

 struct ndis_802_11_test {
@@ -291,7 +291,7 @@ struct pmkid_candidate {
 struct ndis_802_11_pmkid_list {
 	u32 Version;       /*  Version of the structure */
 	u32 NumCandidates; /*  No. of pmkid candidates */
-	struct pmkid_candidate CandidateList[1];
+	struct pmkid_candidate CandidateList[];
 };

 struct ndis_802_11_auth_encrypt {
@@ -304,7 +304,7 @@ struct ndis_802_11_cap {
 	u32  Version;
 	u32  NoOfPMKIDs;
 	u32  NoOfAuthEncryptPairsSupported;
-	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[1];
+	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[];
 };

 u8 key_2char2num(u8 hch, u8 lch);
--
2.34.1




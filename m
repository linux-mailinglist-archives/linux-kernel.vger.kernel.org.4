Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD160D239
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJYRGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiJYRGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:06:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ADB110B0B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso12420407pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnolCiMBjl8qX8ASTYaNnJALNGKZaQCXHfWumAnTsTM=;
        b=lVs5bh8/oQHRESDcFisg9lo7D0bWmjFZK7WMEzSUE/Wupu20lHGa8ZZ0swCrET1kp6
         EUESeWrnWtmUczokeCku2Lr6VYmVHBfWvEb9AjdujPeP5FWQz/wfPM1mBxqBFLyp+zG3
         tLdkucVzgvsuzHpY21/fbkCzppL7mgsVOKUNs8QShrobxdhOxu+aP3I3Z5M8EzJzeR8r
         ufvTd81wt8hru+wiQ9PiTEVDHyq0MsvGHh+lRCkGiwaODf9MwuD4t5GpQzt4khykYs9R
         Do8MaGZ+PJfMrwCItQMoDnjkQR7/Mwga5iEScE7wceQzXWKw+U7Iiv0DTJ0N0G6pXXAd
         PlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnolCiMBjl8qX8ASTYaNnJALNGKZaQCXHfWumAnTsTM=;
        b=ezfrdI8Ar6gC4LogflQW6auW2Q+Y6jfBxd4k9pqjvksBFh+Uo0scIrqPFeccx3zoFw
         1wJeJqmZV/1TY9XDWiIVaWY0qXGkHPw/CAGpq+95kV97dh5esXz0XfJDJo+C+CQCp2UP
         eFcUMrD0SzRsCTyzBTkxrgDAxWZmIrzXc/wwTORyOluTggSnrjTUt39s0QWqe9qVnSVn
         MeMAeKLMO2wJEPH3nmwNhVC9nZznOlDD4hpeFP9ibDveV5ZorCzbfuYE5YxkGHt4clBx
         nExtLK2nMhEQS2hiUP6fQn1KrdA+FOMoEU+sRK2mojE/z7OJKuHvvorSKklyMSEs7YBI
         S9ng==
X-Gm-Message-State: ACrzQf1YITnX9HRIYsXbwD1GfZCg/xkdBOmPGCsFzeRZ5jxwRXSbERNj
        M8RpW6qI/Fj2d+VrtuBF2iY=
X-Google-Smtp-Source: AMsMyM46RVO00ix50JydjeIEAt2SD42HXOx4aWmmfYUD4jW0NJEXO4dyTBPbyt8gECZ5QFcE/GYQlQ==
X-Received: by 2002:a17:902:e750:b0:17f:71fa:d695 with SMTP id p16-20020a170902e75000b0017f71fad695mr39684804plf.105.1666717598588;
        Tue, 25 Oct 2022 10:06:38 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id a1-20020aa794a1000000b0056bcf0dd175sm1592373pfl.215.2022.10.25.10.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:06:37 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v3 3/4] staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
Date:   Wed, 26 Oct 2022 02:06:20 +0900
Message-Id: <20221025170621.271903-4-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025170621.271903-1-tegongkang@gmail.com>
References: <20221025170621.271903-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return 0 directly instead of storing it in a variable.
This can prevent cocci warning as follows:

  Unneeded variable: "pull". Return "0" on line 298

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 8e4a5acc0b18..6d1f56d1f9d7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -149,7 +149,6 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
 
 static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
 {
-	int	pull = 0;
 	uint	qsel;
 	u8 data_rate, pwr_status, offset;
 	struct adapter		*adapt = pxmitframe->padapter;
@@ -295,7 +294,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
 
 	rtl8188eu_cal_txdesc_chksum(ptxdesc);
-	return pull;
+	return 0;
 }
 
 /* for non-agg data frame or  management frame */
-- 
2.34.1


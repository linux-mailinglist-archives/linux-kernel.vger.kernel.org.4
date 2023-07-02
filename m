Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A317745034
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGBTHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGBTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4B2C5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688324773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xsRDdmtq5Our5WATjThYRnHQTqs5zu3TQW1oubRlwjw=;
        b=BFgOTOlRPdo89VfpxsGKUlPrnc/IbgRhDU08abK+OVzcjidM27mBMVOXANEOotZoY1Xqow
        vVsXe7Cwc9LDJrC8wJKtWBE0rP1vFTQh7RtMe29K7rS6kK36FbMwP4jx/XUGWA422BzasG
        tVpSH8FHy3H3NIuKlQSL/OjFMwN+DfQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-Pr6ElycNOY6dJBm-Sj6gyQ-1; Sun, 02 Jul 2023 15:06:12 -0400
X-MC-Unique: Pr6ElycNOY6dJBm-Sj6gyQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635eeb952b8so41255406d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 12:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688324771; x=1690916771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsRDdmtq5Our5WATjThYRnHQTqs5zu3TQW1oubRlwjw=;
        b=RCvXnvgSraRMFb5Pe6M/GLgz1Awhod9+nuU825kcpYgdwRS/HGTeQ3MEb/ssZryQSG
         AZDstqx9pi2Y+BfrfiH7hmdZUp9KRM5BgvLB1/nDI+fvFHcLrdQ4lOmXteKl4EFSL4AD
         0nxHgD8zRVQ63SDmucDYRRJ3pn5w0HQr0Jz2Av8M4jxqAVDmil8jFuDMiBE6NM+zRu5U
         UTSmb2yz6bAjxao4/CC+LVSJsr1aHu8coPcbLCoJFcwnvuIXkWp2KVY2q5NouEoyIFEi
         D9jAP31Sx27NUMm7O6yWsqewwH9na1s1OqI/b660F8RXh5g9BTyY8jBiJnGVgXKg4fVL
         vRkg==
X-Gm-Message-State: ABy/qLbtASnHi0QGSF5SknSzOvH1PVV9mRzFd5M5uHRzqFIuSeuiI68i
        OMYJ32JMW3m10PSIfG2sHx2nv5D2VbeUJoP7no8dshmZv9kB7ltHG7ChsKF+U4KWVo+OxeENJRw
        m81e0SnUDRcT3lwHftxF/RInq
X-Received: by 2002:ad4:5fcd:0:b0:636:39ed:4dce with SMTP id jq13-20020ad45fcd000000b0063639ed4dcemr12491748qvb.20.1688324771654;
        Sun, 02 Jul 2023 12:06:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHHwkDf+q0k6HfatFZaR5G1pfLmXHURWAiK2OHvHS8ulozJIkbfjTuy/u9kGBcgR9l7lGiJBg==
X-Received: by 2002:ad4:5fcd:0:b0:636:39ed:4dce with SMTP id jq13-20020ad45fcd000000b0063639ed4dcemr12491729qvb.20.1688324771450;
        Sun, 02 Jul 2023 12:06:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b00765aa9e3499sm7592804qkk.135.2023.07.02.12.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 12:06:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] thunderbolt: set variable tmu_params storage class specifier to static
Date:   Sun,  2 Jul 2023 15:06:08 -0400
Message-Id: <20230702190608.3441704-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/thunderbolt/tmu.c:30:3: warning: symbol
  'tmu_params' was not declared. Should it be static?

This variable is only used in its defining file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/thunderbolt/tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index 1269f417515b..c789024d7ffe 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -19,7 +19,7 @@ static const unsigned int tmu_rates[] = {
 	[TB_SWITCH_TMU_MODE_MEDRES_ENHANCED_UNI] = 16,
 };
 
-const struct {
+static const struct {
 	unsigned int freq_meas_window;
 	unsigned int avg_const;
 	unsigned int delta_avg_const;
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF85B37A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiIIMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiIIMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F763AB02
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:18:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m1so2214520edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Tcj9zdEuhhwwc+19W7KyuMTeuqCemH8yB/Q5e9nu8aA=;
        b=QJxqTxB//D87aPuiZfpZ5VujODmr6Zn7XTUdwOc9fB7P++LBDU6mZ5MyPB3filboiV
         3QdtP/VQuoOT6v1Amv1a4hZ1jKAfJlN/9HqbXqmHT41NJpE30/3fubB7OH+lNLRM4z2B
         nQzKDW23vFo83M4VlpOExEGMPpLjeefE0pGi0G77AGb5GnW2WkMbFh6+TXebQ9ugKTvi
         NWhYU1FnmKwrFWOPZW7GNwol2T0ILIeBQsEDYMGFxMxZ6wPT0soA/hjuwzBNgCOztft4
         TqZ1qaaDz72BmobxjK+vp0+LaU/FSRf5OZVLYlCpSMiXZ0fLzWs14bctFAP8EU9TzfW+
         n0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Tcj9zdEuhhwwc+19W7KyuMTeuqCemH8yB/Q5e9nu8aA=;
        b=lo93TmJejOWRF/0q/Ha8H2pCZUajdpb2ulb4DxI1KIk0ueVke4rpIVFkcnxMUVpRYo
         oT26HIdAapaWwSxSGX4I39pOtgKbjrp29FJgpNXtX5Qaa73HQrqi2yN4BWajEqj5QvP2
         K1lSJJSQvlf/NTCb/SrSHKbxEOmiN/fhXjrjSLM0m+a/JafOR1AuL8bU2Me3pDwO3ft1
         t7o1skz+3ZK+i8MfRG2Tsf+mF2P1iQeWUDpBAev9JSDnbr2chzpgkMNyX20LAqc2tvij
         plNZJkAQEuM96b5t3SbBsKK9dPjzoaPoN1CFkXVoy77SQnGx5CauXsLhilLPLW14Ugxr
         ooJA==
X-Gm-Message-State: ACgBeo04k3Aa0Z0Lbc8U7WbcBH9l54VNmYpYj/5zXI2Wl/01fBEJKUk9
        PACZhyde2OazQKX7vP6TAIrdALU+Zms=
X-Google-Smtp-Source: AA6agR7tG4OqK0nNY0mWWPRkvmCx6vmHSl4Auf4Q6D2X/J23GoevX7VhHbkYiUTqyfiLEpEzMQzThA==
X-Received: by 2002:a05:6402:1a4d:b0:44e:221d:d1dd with SMTP id bf13-20020a0564021a4d00b0044e221dd1ddmr11469097edb.267.1662725914920;
        Fri, 09 Sep 2022 05:18:34 -0700 (PDT)
Received: from localhost.localdomain (wlan-244090.nbw.tue.nl. [131.155.244.90])
        by smtp.gmail.com with ESMTPSA id p17-20020a170906785100b0073bdb2f6f28sm167143ejm.217.2022.09.09.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:18:34 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 2/2] staging: vt6655: use memset to make code clearer
Date:   Fri,  9 Sep 2022 14:17:56 +0200
Message-Id: <e545c514608bbef296baa37417d2c5af4403ee4c.1662724786.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662724786.git.namcaov@gmail.com>
References: <cover.1662724786.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A line of code sets the entire struct vnt_rdes0 to zero by treating it as
unsigned int. This works because sizeof(unsigned int) is equal to
sizeof(struct vnt_rdes0) (4 bytes). However it is not obvious what this
code is doing. Re-write this using memset to make the code clearer.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 3397c78b975a..34a65a92d602 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -867,7 +867,7 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
 		return false;
 	}
 
-	*((unsigned int *)&rd->rd0) = 0; /* FIX cast */
+	memset(&rd->rd0, 0, sizeof(rd->rd0));
 
 	rd->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
 	rd->rd0.owner = OWNED_BY_NIC;
-- 
2.25.1


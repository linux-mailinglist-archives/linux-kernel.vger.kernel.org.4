Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EA46B851E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCMWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCMWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:47:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C387DA8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:47:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r15so27719608edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9MmR4Fr1wEZcYJSTx2GTu6KpmAYC+ytQi2ef1yhiNY=;
        b=FRE7CYku/c6ERZDOHGzdq/FzlC+UHqtMuf5h8jrHPYW34DPFcPoAEigzKEr8yb9ZFW
         R4gZA0NhrooNgyA1i3LzuaxMJ5vjaOiLKjxBVbT0IH5A1WCWphmZ0cUfxrtSTlPmyBi7
         TDZk2vqWA5qzobJNPvJRuuNb6u1I6/27co6PKixB7GkC1BNzdrWw+EfQT8eY5vf+1q/I
         dYwfS18MeSCdsI4txx1hBpcjwqDkwUSGDQQ/aAf1czvJgVeHGui2rVS8YuH+b/rJ5Stu
         TUfy3iGyWQr7uVlTq40DQzKeFLivehOIxoK5Kh7MMvc3/bAkmr4TC4zqxIcXPL+Oejaq
         b4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9MmR4Fr1wEZcYJSTx2GTu6KpmAYC+ytQi2ef1yhiNY=;
        b=OiVE6U8BpM6nIHlc/bK92dhpS0Fzqbw5D3I2CTCScyxOe8BQjZFxGjq4ZZ2sYo65nc
         GqTYF5YXdEY0HnMMGyV+Fll/MHBw4gxxwR+MSa111xhmvWIQGmFv/UmL8F4o8c3/gK8O
         WZUOCjNp0orT0zNfk8zTDekp3+pcuvtBuWk8efq/wGVaWg2PT2vDxGdRo7D74/l+V97E
         ZrqmFo8aP13hycvzQ9pT0/hMc3+W+3rO0qMcCpE1M0pMOzSJ3ZULYRc/+bj/f4XmXy29
         KA8dffyUufAi3nFptGFkwPV0az37PufgFG/jrCBOMfQfK99oXK9T9x4lBBieHlvFA4e1
         9oBQ==
X-Gm-Message-State: AO0yUKV5L7igq2TPh1nEPZR10mZRU8TF9WVE1EwL6+OW1ijnirL+R1HN
        BwthggylyM+wpRiTZm0et8w=
X-Google-Smtp-Source: AK7set/lHm9jtll06aMNqvCOy3aH8w8VJcmQ8/81auVCfFaHsERNvXRe4ab5G6/Qndp7EFt93Ct//w==
X-Received: by 2002:a05:6402:1d54:b0:4fb:ac81:49bf with SMTP id dz20-20020a0564021d5400b004fbac8149bfmr6958040edb.4.1678747589456;
        Mon, 13 Mar 2023 15:46:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id s23-20020a50ab17000000b004f1e91c9f87sm299296edc.3.2023.03.13.15.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:46:29 -0700 (PDT)
Date:   Mon, 13 Mar 2023 23:46:27 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: Replace RF90_PATH_C in test
 expression of for loop
Message-ID: <f9af7a3d3e608206a4aa4ba2bd377b9201111b3f.1678740713.git.philipp.g.hortmann@gmail.com>
References: <cover.1678740713.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678740713.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace RF90_PATH_C in test expression of the for loop with the variable
that is commonly used. This avoids false hits when searching for usage of
RF90_PATH_C and therefore improves readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index db26e431f8b7..fb4eede0470a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1514,7 +1514,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		return;
 
 	if (!prev_st->bIsCCK && prev_st->bPacketToSelf) {
-		for (rfpath = RF90_PATH_A; rfpath < RF90_PATH_C; rfpath++) {
+		for (rfpath = RF90_PATH_A; rfpath < priv->num_total_rf_path; rfpath++) {
 			if (!rtl92e_is_legal_rf_path(priv->rtllib->dev, rfpath))
 				continue;
 			if (priv->stats.rx_rssi_percentage[rfpath] == 0) {
-- 
2.39.2


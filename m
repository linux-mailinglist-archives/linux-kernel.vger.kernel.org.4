Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CB6BFABA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCROPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCROO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:14:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52B846AE;
        Sat, 18 Mar 2023 07:14:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso12018575pjb.0;
        Sat, 18 Mar 2023 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679148895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ie63cbXEy8BAbd5KVjjijgBU9GTxqxjV4iB878fCIoI=;
        b=TfrtD2Sabn81lmn99KSIbRlFfr7VGeREmmqCcR+Z/a08xn1SbXAoRoN02J5uT+Ypmm
         BsflJgryeaHIPgVbZbHwjebUUMVpRy34EmyTLIWfS3lGi6DGjKL2Kiyvr3vC2FZ9b6jc
         5KQxSKDgGtSRsdimRDN11A1Z6TXEiFBocRIh6NqzOoiwd0nLXaeXAOdNPpgISyMMSWb8
         Cr7opaM0p/FSMX0HXN3rxaOoNqpk//20hOEzvCVbOIddkSO2vZbylVceq1MyVQlE0GLq
         HMBf0d0IRCY3Fv5GfaHuEX2N/Uf3En6BMgj5gDSoUovqr9wVddB6p8M88K9tNXWjQ4fc
         D4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679148895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ie63cbXEy8BAbd5KVjjijgBU9GTxqxjV4iB878fCIoI=;
        b=Q5+hCwTqNDscLVYy1mrzjAZvGfkr/zgyVzdE4e78XzxQSxp6sWXSuQ4OP8P/DLTykH
         4F1F8IJhmIiSDq4mU1qiy6WBzED+5AJcI2+ZlO7GDB8kyyxuYcB5I/oxMP0iyWu+qYxE
         WKUjin6RKf4EJUCRUCOBTUhHwPCUydrhkDf3McXkKtpxeV1n3C8XNjlSFGZYK+5/oS+2
         pLIcVa/XCjNX2q6CnIK+VJwtFJjEwwykUi9epV39K61iyXa67rKpY43j7PNaOOZFbaJK
         T3TNSFXnpQs1Og19F5x+n+gxciq1iWTdYhsRrri010hnVZZOxT1frXoDCxDXQ0THeF8x
         lMkw==
X-Gm-Message-State: AO0yUKUo1CAXQ5DnijtHXnUwpFq08O3cML//09UuTg9zUs9qp0+f+0cW
        5GVgmIT3gYRDpEX4oCVBDoU=
X-Google-Smtp-Source: AK7set9pDaIiV5oyE+oL92o3+T7xCiiXmh4zYO6MPB75EV4hMWBAHzzfCK4y75iVUth2tqOTfklfYg==
X-Received: by 2002:a17:902:f28d:b0:19a:ad2f:2df9 with SMTP id k13-20020a170902f28d00b0019aad2f2df9mr8286493plc.55.1679148895214;
        Sat, 18 Mar 2023 07:14:55 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b0019a96a6543esm3345867plb.184.2023.03.18.07.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 07:14:54 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] ASoC: cs35l41: Add 12288000 clk freq to cs35l41_fs_mon clk config
Date:   Sat, 18 Mar 2023 22:14:39 +0800
Message-Id: <20230318141440.29023-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 8 cs35l41 speaker amplifier connected to TDM
in my Xiaomi Mi Pad 5 Pro tablet. In this case, it's necessary
to set 12288000 (48000 * 32 * 8) clk freq for it.

rate=48000, slot_width=32, slots=8.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 sound/soc/codecs/cs35l41.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 9ec01a5f09ca..6ac501f008ec 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -150,6 +150,7 @@ static const struct cs35l41_fs_mon_config cs35l41_fs_mon[] = {
 	{ 5644800,	16,	24 },
 	{ 6000000,	16,	24 },
 	{ 6144000,	16,	24 },
+	{ 12288000,	0,	0 },
 };
 
 static int cs35l41_get_fs_mon_config_index(int freq)
-- 
2.39.2


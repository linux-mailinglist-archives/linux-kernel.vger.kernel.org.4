Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC6065C28E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjACO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjACOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:55:46 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D531209F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:55:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u9so74406297ejo.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgmkxpqJyM32/nscplImRhu54DAKw5l22AaUH8QIVjM=;
        b=tL2ZtKvOKr8GsSiNzT6HtvXKQzHNy5yXMQchI6xlaOeKOY4LzuvukcFfCFrhSjgsgr
         qFELHhcsGdq8qqIDyAY48SWFHlpNwvCs0bE/87KGS99zNAUD6yhzuiMcjUaNe35jJnfF
         9nYBCkh4GoDV0ZjGmrqoeRbmDCRzH3riaXBQa66FcgeQ1Zp1Cx2wbcnuNZDvs4Z7byyz
         fcxMlJEfQdgZnLCRK+g3jJy9KO2MwPP2ateNFqqAS7uS76Ol1jxVlNUte34T+07Ox0be
         I3txtr9ikkxUwgfOHXUnfIXCS4r/gLyZFSCPnbSN5F1YkGOwkERNHFxz5/D19LIIbKvN
         d0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgmkxpqJyM32/nscplImRhu54DAKw5l22AaUH8QIVjM=;
        b=V/ZN9eW1myN7EqQLhxZIEEVRJETnD60SZUb2VY39LLEbq3fbasGaenOoX/1Ncg/wZp
         i0SyMpKnQ+fbwZBLH4cEWYGST2Cl7Bm+KQDctP+aSzwB3FZ2lGqLZQmRIyfmExl7ELgF
         7ZRRR4UDVkvxtHdTttxY3rD4giUsDUwSnYAy7KhWHypPt0fcmtR44Qeu85bc7N87qq0p
         VFP8dtEOWQKvy1HDr/tTF0/owQkFsOfnb8zHQAGXEQNOKcn7n/cvzT9xvfLlzc4M/Ee0
         5Orr4+xnF/Q38NP8l5iR8O4WddPO+h/zQ/HQiLTpsusePqsc4smarqvYaCD7Y6ZENN+G
         GFDw==
X-Gm-Message-State: AFqh2kqzge5Xyhl6tEVIAeqlP094SRki/JcX2RQtENLztT4FwEK7St8y
        fuvY/rTE/te8nk1ln+DVimXVCw==
X-Google-Smtp-Source: AMrXdXthqpuEe63lXh45UrIXw1Pm+fDkSr40eSGLWJI3kokdasjArLGSfqNYUTQjHK0cWva36m/e7Q==
X-Received: by 2002:a17:906:430a:b0:7c1:54b9:c688 with SMTP id j10-20020a170906430a00b007c154b9c688mr37090174ejm.60.1672757734461;
        Tue, 03 Jan 2023 06:55:34 -0800 (PST)
Received: from localhost.localdomain (mob-5-91-46-2.net.vodafone.it. [5.91.46.2])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b007c16fdc93ddsm14122595eja.81.2023.01.03.06.55.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:55:34 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com,
        Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V13 REBASED 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Tue,  3 Jan 2023 15:55:03 +0100
Message-Id: <20230103145503.71712-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230103145503.71712-1-paolo.valente@linaro.org>
References: <20230103145503.71712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Upon the invocation of its dispatch function, BFQ returns the next I/O
request of the in-service bfq_queue, unless some exception holds. One
such exception is that there is some underutilized actuator, different
from the actuator for which the in-service queue contains I/O, and
that some other bfq_queue happens to contain I/O for such an
actuator. In this case, the next I/O request of the latter bfq_queue,
and not of the in-service bfq_queue, is returned (I/O is injected from
that bfq_queue). To find such an actuator, a linear scan, in
increasing index order, is performed among actuators.

Performing a linear scan entails a prioritization among actuators: an
underutilized actuator may be considered for injection only if all
actuators with a lower index are currently fully utilized, or if there
is no pending I/O for any lower-index actuator that happens to be
underutilized.

This commits breaks this prioritization and tends to distribute
injection uniformly across actuators. This is obtained by adding the
following condition to the linear scan: even if an actuator A is
underutilized, A is however skipped if its load is higher than that of
the next actuator.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d42a229b5a86..815b884d6c5a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4767,10 +4767,16 @@ bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd, int idx)
 
 /*
  * Perform a linear scan of each actuator, until an actuator is found
- * for which the following two conditions hold: the load of the
- * actuator is below the threshold (see comments on actuator_load_threshold
- * for details), and there is a queue that contains I/O for that
- * actuator. On success, return that queue.
+ * for which the following three conditions hold: the load of the
+ * actuator is below the threshold (see comments on
+ * actuator_load_threshold for details) and lower than that of the
+ * next actuator (comments on this extra condition below), and there
+ * is a queue that contains I/O for that actuator. On success, return
+ * that queue.
+ *
+ * Performing a plain linear scan entails a prioritization among
+ * actuators. The extra condition above breaks this prioritization and
+ * tends to distribute injection uniformly across actuators.
  */
 static struct bfq_queue *
 bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
@@ -4778,7 +4784,9 @@ bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 	int i;
 
 	for (i = 0 ; i < bfqd->num_actuators; i++) {
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_actuators - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1


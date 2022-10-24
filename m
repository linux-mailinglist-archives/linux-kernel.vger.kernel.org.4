Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A840960B18E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiJXQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiJXQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:27:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F536784;
        Mon, 24 Oct 2022 08:13:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so8081408wrh.1;
        Mon, 24 Oct 2022 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLvEf6cgm6sbQwXMxy/K8YYDKY0VqrhdGwpIdzPVH88=;
        b=BXqxvyJx37nuxTzExYLJzUYDjNDJHiRMEWZr5/N0KD/wXa3Z8nqCIAS8Ga5wJBhmjo
         qernecX4jmVm1Hw4o9kqWvEljFarITLtcT9Pis97MIvK3PdSs78xp6pdeEADH3f4QvYB
         RDGUJ3dJLj4YpWwFj+woEgB59vg0EcVSzVBYuUGsfxtj8P3QtxXNcjYO1g/R+pAGQRk2
         yz53bTms6FtOaoW0uk692Rqgcc9zdK5qJf/KKce+qma2zbAzNeUZ+lpmFZMQ6f2BIfy8
         FLdz0q0yduzNkrCZX7ncd/Fug8Vyb278JdRvc/U1S15QXjNskQEAla4lm6MiiKWo11pv
         +X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLvEf6cgm6sbQwXMxy/K8YYDKY0VqrhdGwpIdzPVH88=;
        b=eVG+KKN5KMBboB9azDd3jy/IJ2a3nTnyIOdeA8ucANEG11dwJ+DqPoaqMtL5FUg7pH
         eRoJi9fHF+mGhTv35TFSIkYs/FfzZ6xtnXHAQc8m/dhd8v+YNPX2pPK3YBlbXTjQRq62
         F6WsMQV5PIU0lZIY40rqE6wO2BJLtwv1kP+NnhReUSjFJe3gbm16547mf/HCscLIWIe0
         /HA6HinBWN9FXw7dLGSyuWpqFpV9z964747ulM4F1JpveTZWtZy/NZgexJtd1ZPU+fEy
         6aZdRizqKseCm1C39M/k5empoRKYvzx5YxiKUlK2yYa9vk6g4jLZ1Yh17mnU1/3p4+82
         IL5Q==
X-Gm-Message-State: ACrzQf0WzDCFAQwv0a8yuC8VQSDr5qac2+v2bVQ3dJAdICB92crVkS4Q
        DjwEeWZ6r9pFAZWI+KSDu08oYBwct2yQdKDQ
X-Google-Smtp-Source: AMsMyM5u1eInNT1r9xcmMJ5uXkwfkGtcne6ly9VzSeiUg9N5Tp/rAgzc+v1zRziRe+O4HB8npZ25Qw==
X-Received: by 2002:a5d:5503:0:b0:236:1722:845d with SMTP id b3-20020a5d5503000000b002361722845dmr15307415wrv.351.1666621795315;
        Mon, 24 Oct 2022 07:29:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm26037895wra.88.2022.10.24.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 07:29:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-core: remove variable n, turn for-loop to while-loop
Date:   Mon, 24 Oct 2022 15:29:54 +0100
Message-Id: <20221024142954.2162920-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable n is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it. This allows the for-loop to be replaced with a
while-loop.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/dvb-core/dvb_demux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/dvb_demux.c
index 83cc32ad7e12..398c86279b5b 100644
--- a/drivers/media/dvb-core/dvb_demux.c
+++ b/drivers/media/dvb-core/dvb_demux.c
@@ -233,7 +233,7 @@ static int dvb_dmx_swfilter_section_copy_dump(struct dvb_demux_feed *feed,
 {
 	struct dvb_demux *demux = feed->demux;
 	struct dmx_section_feed *sec = &feed->feed.sec;
-	u16 limit, seclen, n;
+	u16 limit, seclen;
 
 	if (sec->tsfeedp >= DMX_MAX_SECFEED_SIZE)
 		return 0;
@@ -262,7 +262,7 @@ static int dvb_dmx_swfilter_section_copy_dump(struct dvb_demux_feed *feed,
 	/* to be sure always set secbuf */
 	sec->secbuf = sec->secbuf_base + sec->secbufp;
 
-	for (n = 0; sec->secbufp + 2 < limit; n++) {
+	while (sec->secbufp + 2 < limit) {
 		seclen = section_length(sec->secbuf);
 		if (seclen <= 0 || seclen > DMX_MAX_SECTION_SIZE
 		    || seclen + sec->secbufp > limit)
-- 
2.37.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210406697AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbjAMMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbjAMMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:13 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F73E847
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ss4so44745136ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SGWONfVHjklNBkXRu6sFYgnXokffLko1IC/BWEcSP8=;
        b=Joe7Sd9Hx4Gf2vwVgdgILntRRgbEjXOg1uMsmUrBuUlBqw+V6tmmR9kV6DLRp8BlK1
         ceDmU736RBaVBZoQ+8FYfrrs5IvOy6tR8uirV7ddw9x5vp2qzik8heDc2f8Y1mkueEl+
         dIelEVxs3O0T5iWPpLTmXn5E/l8duiVzSlpf4rpgk5Ad6eEN0JZNFjZp6ikSwLSFDbpS
         rHQISTWVPR9ijUstQljd8vTV3syLFWn6W0YrGY/O/ra3yRXVHoxF5lxlNEL+6TQBS7gw
         V8mffcjHc18bXEs3wF7sbNgTx206HqTvVfHJgHilmfgjWVi+2thqLCLj/mlHGai9WXPh
         uNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SGWONfVHjklNBkXRu6sFYgnXokffLko1IC/BWEcSP8=;
        b=CCAurj+xENk64mze/NaSb4F/S/odtaKvLHlIMj8MJRIpyg5HOEIQOqU+ZgmdEd/JA3
         95a53oo8zlXfZDX7d6njeHkr+9aEKW7BsheZl6Jt3nopQJ7pgbfEpupf3ZzePequ3+yS
         w2zQ0ajwPxADDh5/wuEad7jCzG1LCxF3YFJw1/CTxirxyxvxqeEeC8BofzDGelnJxPS3
         5Q/j3zHkgtfiKxTUkBzToi98ml1CSWevNcQZMM8VQ5TZ+1XQbh+42sBLVcRRohHFqBvX
         Qjf4C2E9WRj1dG9bC4E0E0mK/y/58RDVDumKW0NiqjcZZ8afjsE+iwliIYTHIh0ZwOTz
         xvkA==
X-Gm-Message-State: AFqh2kqUqJ7PwF3Ot6tvjcrDTAMD0ZqtoLeJS4uwmo7Q60tLdQnCthAa
        ZEF8nLVUB0QNIdOmuWNO4JkpEA==
X-Google-Smtp-Source: AMrXdXvuKKjhYnwWG7p48seWblhNni3qNMosJbFSWpWw/FpYs9PxwOjAk6HwAAJ51o4yQVkK9jURSQ==
X-Received: by 2002:a17:906:5042:b0:841:e5b3:c95f with SMTP id e2-20020a170906504200b00841e5b3c95fmr67054967ejk.29.1673613345846;
        Fri, 13 Jan 2023 04:35:45 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:45 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 4/8] drbd: remove unnecessary assignment in vli_encode_bits
Date:   Fri, 13 Jan 2023 13:35:34 +0100
Message-Id: <20230113123538.144276-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_vli.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 1ee81e3c2152..941c511cc4da 100644
--- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -327,7 +327,7 @@ static inline int bitstream_get_bits(struct bitstream *bs, u64 *out, int bits)
  */
 static inline int vli_encode_bits(struct bitstream *bs, u64 in)
 {
-	u64 code = code;
+	u64 code;
 	int bits = __vli_encode_bits(&code, in);
 
 	if (bits <= 0)
-- 
2.38.1


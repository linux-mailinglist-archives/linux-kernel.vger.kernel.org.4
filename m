Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2836EDBC0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjDYGjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjDYGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:39:18 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD56D129;
        Mon, 24 Apr 2023 23:39:17 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1878f1ebf46so3592465fac.1;
        Mon, 24 Apr 2023 23:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682404757; x=1684996757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+bVwaGaITtfF8e/BFCRYIjC8ycF9nPnM49EIwyquBc=;
        b=g/q5Snq7OUJrXsULi1qzScoCj5La0SDWjF4BfiS82rXB048O/pAxd5A9x5zKdk4vpj
         ildbjkLbrMtN/DlgrhigNdb2PUeqjwYuNElBR/4WtjqQ/WMMI9IpU9FChmuxY7/q+WWd
         HboEqH25ubtvxGkxGjMQcFTpUb847umSsjxk7zgjcqTfnUm0OE920H8HT/7wMVeGS7ac
         8MKW9uVp5wA5lFk6QGMiHCm16z700Km/9zHN/RgVkXRNnAuJPt0A/u/KMQ5AJYVgaH0r
         er9SZuVxffS/AwMnS+4tr639C12kCpqZeg9eFeQM0t4/s882yfFKz7yfCmArda9ylWKg
         Jd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682404757; x=1684996757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+bVwaGaITtfF8e/BFCRYIjC8ycF9nPnM49EIwyquBc=;
        b=Gk5FhVFc1fhJn7G+fsYxgRxmVYgkzIAbNW0W385MA27noYibQTT6vlE6l1UDXvslbF
         HzOJz0HWg3L9jOm57ytq3T9EbXUHDgcsR2Rx8MuZeHYTgayaeDpmYvnQxBUChsjnLTGF
         bTStt/P1+UY5RFDRbfkzEbSSok/RUiF19yVfHm23OPVdL7GYAh1C8jM/2hWjZMqCH6YZ
         R3xnYImmUgv2M28B9K/UG6nw2EhuBwLFEUp4Cy9GOaJ+PKJxmvYV02oCqb3hgoil+QiC
         +2TseEl/VBB4YOQEFbzHbZ3yggTPcv2l6bjnns/6jSYVrUgSksWXaUIQmFLbeykx9Cnm
         zwPA==
X-Gm-Message-State: AAQBX9fxXUw8Ih6t0d7KYE/C/wGUFJzDAWUJ6Cyc9LtOxej1PIRIT/OO
        z/WFqUdfbhDiFnhFU71slDq9UtFwqhM=
X-Google-Smtp-Source: AKy350Y4qG07sSuFnxiuvFNW68G7GTQLNnbHu9rucVaVj8cJkm2JdcUgn0tR8wxen+M8rUox9ULMTg==
X-Received: by 2002:a05:6870:40d4:b0:18e:ab89:5401 with SMTP id l20-20020a05687040d400b0018eab895401mr2863249oal.59.1682404756634;
        Mon, 24 Apr 2023 23:39:16 -0700 (PDT)
Received: from localhost ([2600:1700:7130:4fa0::48])
        by smtp.gmail.com with ESMTPSA id z10-20020a4a984a000000b005413e617935sm5655411ooi.15.2023.04.24.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 23:39:16 -0700 (PDT)
From:   Fae <faenkhauser@gmail.com>
To:     markgross@kernel.org
Cc:     jorge.lopez2@hp.com, kai.heng.feng@canonical.com,
        rishitbansal0@gmail.com, dhould3@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fae <faenkhauser@gmail.com>
Subject: [PATCH] hp-wmi: add micmute to hp_wmi_keymap struct
Date:   Tue, 25 Apr 2023 01:36:44 -0500
Message-Id: <20230425063644.11828-1-faenkhauser@gmail.com>
X-Mailer: git-send-email 2.40.0
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

Fixes micmute key of HP Envy X360 ey0xxx

Signed-off-by: Fae <faenkhauser@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 873f59c3e280..6364ae262705 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -211,6 +211,7 @@ struct bios_rfkill2_state {
 static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
 	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
 	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
 	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
 	{ KE_KEY, 0x2142,  { KEY_MEDIA } },
-- 
2.40.0


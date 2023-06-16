Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE5733081
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjFPL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbjFPLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:55:54 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A1D2944
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:55:54 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B93F3F0F8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686916553;
        bh=uEciiZDYLaCZOmEM1cxPY7+VzbXKRsNbeBnxrBRt1fI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PhlPyt8SOCdVZ0ZK5YJBRo1zMJ+vSpqHhVyIAI2wbvm2tnkUVKlhUcJhk9qWMf5MD
         yYNLWSED4yKS5NI5iK8nd3nieoYtItBKXtHpQbYiWEkmnI4ALAX2f13NoDqK7OYan+
         ZmqwnAO2dIPzGs9k1hpWtNgQZd5lq0ZW8+WDAO0cUrpwbKULUBeXsupRlBiLF2aIuQ
         D/n7xsNOA5NN9FyHfwZbnutpYfzGxBoopXn5uL/77QfR073fA8CQQxs0BVTG+xcyXy
         MX/5spq/eKjz5iiHpGpOBLuPqLL1KsZxPbN7KbkoqizJKiu8b27lBKlAbY/tTIKEro
         MUuRr4ivwC/yQ==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30fbaeec4c1so253112f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916552; x=1689508552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEciiZDYLaCZOmEM1cxPY7+VzbXKRsNbeBnxrBRt1fI=;
        b=TZ/lyFdR0oXTO5MxZKTVdUCC4lkJUgkXJTdh5V0bqC+vjkOTv8qnG05N8asZd6J4cL
         +j84WxTg1D6+LrU9/O8IPHwyms8HCG+3EDUpNeeX6EtgcTJ6RLyVPzoeXnESlI79Myz8
         cXuV0qG9wTwVdpc6WJFVTHnerTai22AjMDoiP927Imhj2+BEwDlog3X7/boabsE987Tj
         PeJYlj2DpM0mgbFidOwzfrg28MYbNklN3tJCE+cElwrx9jo08CDvn/tysGV6fBzXbGCs
         SiRPvdNC8oGEo6DTw+afLfuFfNlyk4h9m7YzrB7QBrsYZmh68Px2aY6rmSMR+4USZ2jX
         TMww==
X-Gm-Message-State: AC+VfDw8DmGO5O4pviba1MNtzqveNqh9bdJS90Ed2Kq9ozuf6Rnqe2/k
        7WJrD8mckMJEoTj4uR7NsYMw9E/6zTcEivPoCDSA8KRFsWJMK233EP/BhMsLN81oSFpbTIhVUNS
        XgZWAYnpElw/sVLxwmkdjRHSksTqe8Ogyywn4yrbr8w==
X-Received: by 2002:a5d:5684:0:b0:311:1bd3:6c7b with SMTP id f4-20020a5d5684000000b003111bd36c7bmr1096687wrv.32.1686916552711;
        Fri, 16 Jun 2023 04:55:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5h4jzXqaMa6s7e/pNspXURO7AdL2UkpBAzpZd13x4UDJcUHCyPAzddYxyJdkh8rhByn3QcXg==
X-Received: by 2002:a5d:5684:0:b0:311:1bd3:6c7b with SMTP id f4-20020a5d5684000000b003111bd36c7bmr1096676wrv.32.1686916552430;
        Fri, 16 Jun 2023 04:55:52 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d404f000000b0030fcf3d75c4sm9516016wrp.45.2023.06.16.04.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 04:55:51 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] ASoC: rt5677: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 13:55:49 +0200
Message-Id: <20230616115549.1011903-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 sound/soc/codecs/rt5677.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 3bf019b3f700..c8fb98e3406f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5712,3 +5712,5 @@ module_i2c_driver(rt5677_i2c_driver);
 MODULE_DESCRIPTION("ASoC RT5677 driver");
 MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
 MODULE_LICENSE("GPL v2");
+
+MODULE_FIRMWARE("rt5677_elf_vad");
-- 
2.37.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D266DDB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjAQMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjAQMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:34:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27A36B15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:34:42 -0800 (PST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9480E3F5D0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673958880;
        bh=Dr9R5dfY2nTTstdwaC++TmcM/uDTBZdBUz78esGlC00=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=RmLlJ3yB9hECoctWew2F4AlEb0NubEgeud2JD4koWPHTZhs4J8LZuQcahIpKQdEiY
         WdyOanMF4rb6wrEU3wfk6GshoQ4knC+O2xTQ+N5TuXS1slqwY8X1sT5zhEn5j6pQ5w
         LuIOWCi3bcG/pTpEcpu834J7I5IZ1+t/hWehlEfqOoK7lrQu+YoHOGw28mDdajGK60
         fyKSvQLddg4c7xQHmvPUV+yJXQpGTLrnLOfkhwPWp0hB7GP39SeAdhsHNg8yacl1pV
         IIarvEV9Z+DOIIa7oyrZvZi1k5oOoskWsIMeNgTEQlZZzNSvYZQQttlzHoSI239yL/
         6fdy7S8imJqZg==
Received: by mail-pj1-f70.google.com with SMTP id oo13-20020a17090b1c8d00b0022936a63a22so6750902pjb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr9R5dfY2nTTstdwaC++TmcM/uDTBZdBUz78esGlC00=;
        b=paiQbkZUq57I51g6v11iQf0kuR08n+WBMi0LP6mpnNMG9kP7OTq1lt5zIVfu9z1CyE
         1gEkoxnoNiklSzGOMfKI1w8FWcYGGNinIQjB28n+q8B4GgPEVKQDKGpXAaZSFLltBIw3
         9ZxIvAyIMxGmrMJdcJRowYhJiMXWDz1gCFMyRo/1G3nUz9Tz+C5HhO0BhnxUBtFq9VXR
         ezv8V/FeOXtTFh36MjvjmbFXKX3oovDEd6ScwoolamIzILi97t/0nOCNcibS6pjZJXkb
         UFW5SQiOvyt8zQvUuaeiDgC2UO79oVxv9oumcIVoEGeS41Dh/84lKm4+XSIbaXHi72l3
         y3Lw==
X-Gm-Message-State: AFqh2koER4ijZAAGO8GUT+nixCuEIKvnau2soTJaGal1cDm+bifN4yTq
        DsdflTUCrA4VvdKOk8EtSv9W8GSKkEa8VujieEaOySjs25KcwdjHBpvgxYgr+e5Adv7JHN+jEmJ
        tm4Mp6rfnwMNbZCxSa+EaYjmrp7Fse2x1FEB4VNYFXQ==
X-Received: by 2002:a17:903:41d2:b0:194:8293:7aed with SMTP id u18-20020a17090341d200b0019482937aedmr4803361ple.6.1673958879123;
        Tue, 17 Jan 2023 04:34:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvx1PIXSEHmS/z7z5lb8KgmnS5yWSwxFE1DXqNZzoijW82rL44xDXdWbSzbhs1ZKeFHCrvm3g==
X-Received: by 2002:a17:903:41d2:b0:194:8293:7aed with SMTP id u18-20020a17090341d200b0019482937aedmr4803333ple.6.1673958878803;
        Tue, 17 Jan 2023 04:34:38 -0800 (PST)
Received: from canonical.com (2001-b011-3007-1498-1355-049d-ac04-c0c3.dynamic-ip6.hinet.net. [2001:b011:3007:1498:1355:49d:ac04:c0c3])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902bb8200b001949c680b52sm3090850pls.193.2023.01.17.04.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 04:34:38 -0800 (PST)
From:   Koba Ko <koba.ko@canonical.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-wmi: Add a keymap for KEY_MUTE in type 0x0010 table
Date:   Tue, 17 Jan 2023 20:34:36 +0800
Message-Id: <20230117123436.200440-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms send the speaker-mute key from EC. dell-wmi can't
recognize it.

Add a new keymap for KEY_MUTE in type 0x0010 table.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 0a259a27459f6..502783a7adb11 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -261,6 +261,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
 	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
 
+	/*Speaker Mute*/
+	{ KE_KEY, 0x109, { KEY_MUTE} },
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },
 
-- 
2.34.1


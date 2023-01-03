Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2F65BD7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjACJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjACJxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:53:43 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34BB5A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:53:42 -0800 (PST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A3029418E6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672739620;
        bh=yHJKB+fSNEIK3AP5YIvFqV8vwGwGNgGxp7RxKevK/jQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Hxif4Dq850RtQe/u/zmco55q/Rfo24mrhBL2Iibfzt4Z5uDu3zAZBfwsRBWl8yOJ5
         yvHQj+3WIqqaM3drrccnK1wWnnUQfqKPNGXqlzjAzmgA5asWO5e96y/8VvS3IlHTk6
         7pOd3oYvJjBpCd+Y7/jCkqH+NUwgw+axBvyTJwjlN61XB7yQcl+N43nE/0ea1GwE0C
         58aaLx4Fnzs2YKo4TPa+CYaK4/XN/1ZG3WdL6Ma8mlHMw3kOp2tf/YNloJql4+YBEE
         gIB90hYI7EE1OlWZrUIXoYL5y9urCsbXgpxrouF83zpVLEQbRfB+oahAZ7Y6oqiXf6
         ICIwkVW3lwQnw==
Received: by mail-pf1-f200.google.com with SMTP id k21-20020aa78215000000b00575ab46ca2cso14076335pfi.20
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHJKB+fSNEIK3AP5YIvFqV8vwGwGNgGxp7RxKevK/jQ=;
        b=TyrL3EguPtr/gk7Q44vEuQC0dRnNgUDIumxvbBgWMJ3y5fv0cg0DAQLiKvUMlME2nj
         8oIpdMGW3cUrbEGGzQu4HjMacKY+8yuCIWc0eH4cgxYW7Id3uHCKCy7x7m8OPJtf6DVp
         OgupoKSfGJV/D5nx6FjJf0dWLuZx4aIZqXg8J6SKXGN5l3GtdRar2AsjFzfNRWeWglRn
         KkVXTEY+FwXZXbAAgais2FCagGyLgLWNPOfPcga0SKOHeKRSzdZe+PRx4HR3v7Ny+IxP
         c1M4KYRGFKtJpMZ6tITJHg40IeAzYf/ZUKFE1c+kpyJxuW6IRQ12kEOInxrchiU2eoRR
         7zVA==
X-Gm-Message-State: AFqh2krElI5w7ZS3yEWXXGOqCV/FCrQLtta6lj3tRRWCUTc8depZVH8v
        tfK4+skemgkP/kjoElESi8PCV/dFISleu5zbOGXvFHQ0dAO32TK1AI0+su8rz6INc1+4siiUybX
        mpVpW8ayExF9S34TViLCsWm0kGaOBdrvVJVKTsOwaWw==
X-Received: by 2002:a05:6a00:1485:b0:57f:ef11:acf6 with SMTP id v5-20020a056a00148500b0057fef11acf6mr54271125pfu.8.1672739618885;
        Tue, 03 Jan 2023 01:53:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtaPaDrufHUdaK6arDfIwoov0wJ4tFTXKqQo+uUewMj+DvO4wiTj4XJGjVUYJJYVhBM0ei7SA==
X-Received: by 2002:a05:6a00:1485:b0:57f:ef11:acf6 with SMTP id v5-20020a056a00148500b0057fef11acf6mr54271106pfu.8.1672739618339;
        Tue, 03 Jan 2023 01:53:38 -0800 (PST)
Received: from u-Precision-5560.mymeshdevice.home (2001-b011-3817-354b-917f-f33f-4816-b377.dynamic-ip6.hinet.net. [2001:b011:3817:354b:917f:f33f:4816:b377])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79ad3000000b005811c421e6csm15210748pfp.162.2023.01.03.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 01:53:37 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH] ALSA: hda - Enable headset mic on another Dell laptop with ALC3254
Date:   Tue,  3 Jan 2023 17:53:32 +0800
Message-Id: <20230103095332.730677-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another Dell Latitude laptop (1028:0c03) with Realtek
codec ALC3254 which needs the ALC269_FIXUP_DELL4_MIC_NO_PRESENCE
instead of the default matched ALC269_FIXUP_DELL1_MIC_NO_PRESENCE.
Apply correct fixup for this particular model to enable headset mic.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3794b522c222..f75d26acf5ee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9239,6 +9239,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0b1a, "Dell Precision 5570", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x0b37, "Dell Inspiron 16 Plus 7620 2-in-1", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
 	SND_PCI_QUIRK(0x1028, 0x0b71, "Dell Inspiron 16 Plus 7620", ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS),
+	SND_PCI_QUIRK(0x1028, 0x0c03, "Dell Precision 5340", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0c19, "Dell Precision 3340", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1a, "Dell Precision 3340", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1b, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
-- 
2.25.1


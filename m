Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A876463CB21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiK2WjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiK2WjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:39:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EDB391FA;
        Tue, 29 Nov 2022 14:38:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d1so24393758wrs.12;
        Tue, 29 Nov 2022 14:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzd1y7/3VtA/Hnru2/D87vDSTFTR6fS36X/4ULjUqag=;
        b=OdiGfjWYy+vziTOEML/WOPfHUhY5/7Wu19xuWjVxsRlpVwsZTjxqxP+AWB30y+Zh0O
         Mf82A+w35WHGxHlSlHX8ZcRPb7KhvVvvc7iaX3Vq48P/gXTItDAnYvMGCuyytSuCPFis
         DrswD/YpyqL1n/vOKLFrLpNqB0sz8J3KxCpwatpmENEogrY0xYO3EPFjZONZkmJDjWC4
         TnIRpqhiSLmHjgeGCoJI1Ai5hG22lD53bEyaPwaYF6O3+3o2ruCpW9O6h8/uUOglWYpf
         FWYJ0mUmR4RMyJnJGO0OV3jh528br8exLAwHi0+J8UCJIvSz2yOnvOvrndgA2e15FBJU
         IPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzd1y7/3VtA/Hnru2/D87vDSTFTR6fS36X/4ULjUqag=;
        b=1bE+84ND7+WaiARLr5EuHDp337ZROHu4nZ6BqrOuHq6gtEzkUqIsIOkzxKZ8hAiWra
         jYSpMOQgDmKuLU3qBoGDVSVL+rBfQKlsqjvkurChFpAqs6zhdVwB70VUu9c2anEQlrRW
         BgjKtDQLyTB8eZTK9zFK4Ako1NJ9o3RZ6+ljWUySI012u1PiNn7CFQf6flD6TIUxB9Jb
         HvlCpSUPQU6aBoL4d4xrRvXBG+d1Qo0XbISlyQcjI3tpsgkM5tTRSKlRYeSevnvQLl27
         RXd/sJxe4FhDCYQoqihvFJZSHCPVDejdGEVg1IXxRyXwRtHHyeBa8ODacr2cneeZ2LRD
         Dz0A==
X-Gm-Message-State: ANoB5pmRHDCG5ZPv2B6RXDNK76w00KV+cWGASupjjPpcj2xiHenR56nB
        DteMvGkEyJpK5U55WM6v5Hs=
X-Google-Smtp-Source: AA0mqf66gF1k0TkON0nx4iEXcTPnz9Uru6KaHq/pKQPsATI/GjqlbGC+2jKZ5CmMzm1ViH6VTLYEpg==
X-Received: by 2002:adf:fe47:0:b0:241:9aea:4396 with SMTP id m7-20020adffe47000000b002419aea4396mr37016699wrs.438.1669761537119;
        Tue, 29 Nov 2022 14:38:57 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s4-20020adfecc4000000b002421f89df39sm3594347wro.37.2022.11.29.14.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 14:38:56 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] firmware: dmi-sysfs: make pr_info messages rate limited
Date:   Tue, 29 Nov 2022 22:38:55 +0000
Message-Id: <20221129223855.1005674-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Currently if a process repeat repeatedly reads the dmi sysfs raw event log
/sys/firmware/dmi/entries/15-0/system_event_log/raw_event_log when GPNV
support is missing or using an unknown access method the kernel log gets
spammed with info messages. Make the messages rate limited to reduce the
message spamming. Triggered when running sudo stress-ng --sysfs -t 5m.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/firmware/dmi-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 66727ad3361b..9b6ce172175c 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -418,10 +418,10 @@ static ssize_t dmi_sel_raw_read_helper(struct dmi_sysfs_entry *entry,
 		return dmi_sel_raw_read_phys32(entry, &sel, state->buf,
 					       state->pos, state->count);
 	case DMI_SEL_ACCESS_METHOD_GPNV:
-		pr_info("dmi-sysfs: GPNV support missing.\n");
+		pr_info_ratelimited("dmi-sysfs: GPNV support missing.\n");
 		return -EIO;
 	default:
-		pr_info("dmi-sysfs: Unknown access method %02x\n",
+		pr_info_ratelimited("dmi-sysfs: Unknown access method %02x\n",
 			sel.access_method);
 		return -EIO;
 	}
-- 
2.38.1


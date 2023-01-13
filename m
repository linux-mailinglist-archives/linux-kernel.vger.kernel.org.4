Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2D669ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAMQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjAMQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:56:25 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C3D26C5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:56:16 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id k4so22792271vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TOZ2XXqS0p7ft3IrzNrVta3tYhszOavdjeGJQ4dCn8k=;
        b=MBOddXeYiZqcidLAeKir46cRJsI/dSEbGP+R7EM2jqabnjoLy6eWPZQ8R3KDN2unkC
         YknhoVm0yuTpp1gYD3640UlKsC6F1dKMvORGg0IepWdBvNkb7M4YvmCHOYYg2o12p/5C
         nYQfznuYAuoEzciyKdMlW9RcIlG2+049Gl4kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TOZ2XXqS0p7ft3IrzNrVta3tYhszOavdjeGJQ4dCn8k=;
        b=qDuGaeRcWCjZfnRNfl6tI9sB8yA14VIpqEIuBaoi109b2AdrTEAXb0OMYvQnJwVUcM
         DJ81gC6JoKZnkB+LmLkPDfBW0V6RSJzbfHeeOmdLwEg5QQnYCsdgfmYP0cmn217liP6a
         r78gjyFLcP8R231fI1rC4Ad9zcg8bx+yubkgVuakpxNkrHHpG/vCl/XeWGGg6/f4eFzT
         StGp0JPKaKO8AnzpF0lPOPkXBFkA/CcASo3CZEKxsnDj1myewEyfCt4upiGNE/8LOXTr
         FQel4lbtpxjt1AwJA5aL/mH6h1QYEjfeU/CYP7cRVhcKuJFr/U7WNZKZqrBILc3w7coE
         ssmQ==
X-Gm-Message-State: AFqh2kpDVXyLr9DM/6iG3aUmXLdd8prg5m7/Iim7y/nQKIxFGXYSvM4m
        eBeDXm4ZrujQcrqXY+geBgOgZ02CFX3cQUfeNimIgQ==
X-Google-Smtp-Source: AMrXdXtA4jJhbap9Mesgi8AFhu+BzYgf1NF+0+LILeIyGvLezURePTUOrnBbv4PeaVdpL8R78SDOMA==
X-Received: by 2002:a05:6102:510e:b0:3d0:dafe:9e57 with SMTP id bm14-20020a056102510e00b003d0dafe9e57mr9244569vsb.26.1673628975033;
        Fri, 13 Jan 2023 08:56:15 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm13018930qkb.116.2023.01.13.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:56:14 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Fri, 13 Jan 2023 11:56:11 -0500
Subject: [PATCH] um: put power options in a menu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-umpower-v1-1-faa1459f7ab3@pefoley.com>
X-B4-Tracking: v=1; b=H4sIACuNwWMC/x2NywqDQAwAf0VydmEf2oe/Ij3EbVpzcJVEqyD+u
 2uPwwzMDkrCpNAUOwj9WHlMGVxZQOwxfcnwOzN464N1LphlmMaVxIS7jZV/1E+81ZDrDpVMJ5hi
 f/UD6kxyiUnow9t/0b6O4wR7aiR2cgAAAA==
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673628974; l=663;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=gLu5+b7mdNXFx8A5ZK+VNsmqzaiQBj+qX4NXuo5RyRE=;
 b=qBQxQSZ3UYV8DOtEChK0c5gvyxQKmXVdcCWG+2ylzNq1O2S4pN9rRXq8UEdHHrJw+wXh2Ojg7LS+
 XDKm421CBIcXLzu6aX9ISdvvt61jR0H8BODLTABtkLWhQ83/dwJ+
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because having them all dumped at top-level is a bit messy.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 arch/um/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ad4ff3b0e91e..65bc4c5f2e64 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -242,4 +242,8 @@ source "arch/um/drivers/Kconfig"
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
+menu "Power management options"
+
 source "kernel/power/Kconfig"
+
+endmenu

---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230113-umpower-370c42859a65

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>

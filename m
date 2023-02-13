Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5055693F38
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjBMH53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMH51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:57:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B4422A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:57:26 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 24so7562193pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHJhiuRiqcFrsMSI4ugI2BOz+NSM+ro+gE1w6zVpdyI=;
        b=LwZ/sKRzDFxjgmVtGLG6VES6M86sDeHn1sB1X609wpG94R/o0z9PEfDEvOkk+WSM9U
         R6B08yRzbGXdnhC/dNtXoug6mH0k4y4QI4FkMIqE5ytFvA0Cwhx7/2CIhYXPaje/d1Tq
         6U+jWY258loP6HwtfH9SmYIMY+v63CQHHzz3xVb2/MhGWYRXUx8ZQWS2tP3T/TndSuAT
         sv5hycb+JIt/Ygnk6IuEj3BH/We8dhnSbtLdT2XcCnfzl/dYuDSmS6Lxs7OAwjO3dhC0
         jaWQyBTo3qMDR/940X93jTILihyUfybzXE3TUkwViPGPC4O1dWPb/nj+JHn0GF47E510
         cYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHJhiuRiqcFrsMSI4ugI2BOz+NSM+ro+gE1w6zVpdyI=;
        b=tpIegj6XZ22FoVcYDJPLnWCmEM+Fujo5qwndlhoz2Negn88e+3VTTzPikrjI+dKekU
         3CXsUXOeoBZOMFt37UakpsuIVnsVC36yQ3qhgPIKHMB/gW/rJVE/3LFHhyTmTzLfQEbO
         gdMu5Q2FXUF6FdyGbL2xUVfiAIZ9Y+hp07OC3HFC36k6EnXRp8+JPH+aWMs+hsycxsjV
         HmkBtFg/WhXxSQLXQFtVkcI21uPkQ5KPWJIqNg7CX0z51z/6umam9unvWhwTN7zgq8jm
         S9gTBfxrNuJFAoJgMOZ3ta4JdUkhQ+d4AFtS5zAId35l5yCJlphmdw/t2SMtK4tT86Mh
         DKQw==
X-Gm-Message-State: AO0yUKWBPD/8sFBD226sztPSB00Q1NagkN9Wjb5jmmNUZkOyXPAdx/Tl
        IwlPYLAkbs3YXppgDo3JZf+hNw==
X-Google-Smtp-Source: AK7set9LE8GPOhtY+B1RcIiH1yuIiy0jL2qeqKDiUlM0tAifpAsNTHw/az3I4uhlO37/K0cCECo23w==
X-Received: by 2002:aa7:9ad6:0:b0:5a8:ab62:28fc with SMTP id x22-20020aa79ad6000000b005a8ab6228fcmr3620669pfp.9.1676275046246;
        Sun, 12 Feb 2023 23:57:26 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00588e0d5124asm7255959pfn.160.2023.02.12.23.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:57:25 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v5 0/1] Add Ufispace NCPLite platform device tree
Date:   Mon, 13 Feb 2023 15:57:18 +0800
Message-Id: <20230213075719.37276-1-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ufispace NCPLite platform device tree, and add the compatible
string in dt-bindings files.

Changes for v5:
- add "Reviewed-by: Andrew Jeffery"

Changes for v4:
- revise the tags

Changes for v3:
- add "Acked-by: Krzysztof Kozlowski"

Changes for v2:
- modify node name to generic one and check with dtbs_check
- send-email without confidential mode

Jordan Chang (1):
  ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

-- 
2.39.0


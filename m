Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BEF6A121A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjBWVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBWVem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:34:42 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67058493;
        Thu, 23 Feb 2023 13:34:40 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id p6-20020a4ab386000000b005252182b0e0so371006ooo.6;
        Thu, 23 Feb 2023 13:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0MLEdfogFCirLJv4TSRtYx1XikEIZ4JT62jkkkDm98=;
        b=FvTqIUmGwrN1zrk+5UHgm6jrvUmwGd3XKVDM2DxdBv+oIF0ngaB6lNuKLYv5+b8X8B
         qNpoPeSrCUkDSnoyGRz4NOBnqoxhRrAXpO3J49hJX/6TZr56SYaj0XtEz2Cj0tGmyPsl
         /RWVHh14a/D5b2KL1tQLylvlasrGUTPFPJauxdtgA3OAFI5uNZQItENIHcPmwA+SouO5
         cyfj6iR4BeUFkXQyxkHZsd1tpl2jfTf+tuzP+hblOmv5X55wVD+Vck06RlPlEoYeeNGH
         mphj7e8PPf1AhHLCT6SfIc08bn0ewgDtQqgbfPY5gwKJT9cT2jk0GrWUCe4ns4QrYyUu
         4ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0MLEdfogFCirLJv4TSRtYx1XikEIZ4JT62jkkkDm98=;
        b=ZgHt08DiS7dFFOwlXl1UBXqyHYRhOGAeRb+PNePcvrgDh1IKjmmkASxPr7F2GGc0p1
         M8JdpGi3VDfJ+bqB2jKJozwc1cbTI25dd1gtf5uprDfzXDd+V3VBBTbgwtoYgTPj5DUX
         VF6igr3SQA0iTVa060abFHUZsWnAY7QI99+S4lt7O2UJpTZ2zvaDzd+Pi+qdEZapmKjQ
         tumQGT3GCNtbBJPMUNToU6/DxKo0PFIlbn7Y0lvOYHNLjYqI88fwMjc0rpHIln3yj94p
         MYHVpjc9dqF/l6+a4aHuW2/w0Qj1JNjpo0HEc8ovd/WlqhmNzZpI3WPRgxglJMXzNz1E
         Qdbw==
X-Gm-Message-State: AO0yUKVHSt2LFu96bz25GEd+LwshfMSgwEEOrejeQUYjLIhXFvTVadEj
        ssgo0I4a8/HzB5v2s+T/Kh4=
X-Google-Smtp-Source: AK7set89e81XBaD9GNiMN6/H0V7uVRMc/0p7/e8HCQGkMtlnumVOHvYubDROdzuLW7kpBSwJQ2R1vw==
X-Received: by 2002:a4a:3902:0:b0:525:c84:50b with SMTP id m2-20020a4a3902000000b005250c84050bmr4890042ooa.1.1677188080028;
        Thu, 23 Feb 2023 13:34:40 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:e42b:73d3:ba1a:1b32])
        by smtp.gmail.com with ESMTPSA id r1-20020a4ae501000000b00524fe20aee5sm2903976oot.34.2023.02.23.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:34:39 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/2] of: populate of_root_node if not set (alternate)
Date:   Thu, 23 Feb 2023 15:34:16 -0600
Message-Id: <20230223213418.891942-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This series is a different implementation to achieve the goals of
https://lore.kernel.org/r/20220623105044.152832-1-clement.leger@bootlin.com

In order to apply overlays or create new nodes under the root node, the
kernel expects of_root to be set. On some system where a device-tree was
not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
then we will end up with a null of_root. This series adds support to
create this root node using a builtin dtb and removes the manual
creation of the root node done in unittests.c.

Changes since version 2: (patch 1/2)
  - change of __dtb_empty_root_* from "void *" to "uint8_t []"

Changes since version 1: (patch 1/2)
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix typo in of_fdt.h: s/of_setup/setup_of
  - unflatten_device_tree(): validate size in header field dtb_empty_root
    that will be used to copy dtb_empty_root
  - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE

Changes since version 1: (patch 2/2)
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix formatting error (leading space) in patch comment

Frank Rowand (2):
  of: create of_root if no dtb provided
  of: unittest: treat missing of_root as error instead of fixing up

 drivers/of/Kconfig        |  7 ++++++-
 drivers/of/Makefile       |  2 +-
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
 drivers/of/unittest.c     | 16 ++++++----------
 include/linux/of_fdt.h    |  2 ++
 init/main.c               |  2 ++
 7 files changed, 49 insertions(+), 13 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

-- 
Frank Rowand <frowand.list@gmail.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FE69EDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBVDz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjBVDz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:55:26 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9322D31E23;
        Tue, 21 Feb 2023 19:55:24 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso1294055otj.12;
        Tue, 21 Feb 2023 19:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pAyrr3tjGMd0qtnc7KKEB1MvbiiQcGAi5Pfup+ljo=;
        b=jv2M0b81SI0HTCxOYcIbT/hc2S/LyuaZawZejDGMG/T1cok7BlR4kqnM87YGfsA0Vm
         5JD/6bcR9G7Z9HQ7D8Od2VQU+IwZKB5V3TVrMZZnLw68zmf2iz6siCuT9mNtXYZKwE8O
         4QcTq1zuGeK7PyrSpNrWeh9ukGNwvSLyVkmd0hfPqKwNqbOlRBZAfI5f5rk4ZaDfKAja
         n2kc6MK+R38aHraD/3b1PHFnY4oKjd3DDf7Sqt4SJ3dbdoXA9wT3yA6jI+ohC/5tbGRI
         x73dxSU8aqaxfIhX9tNFh6cP1Yo4Xe5PIz/HsG+uxStM6oUchok0I3RhxQ4q6gFJvpDw
         EObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3pAyrr3tjGMd0qtnc7KKEB1MvbiiQcGAi5Pfup+ljo=;
        b=XQbM44v63Fl2mNwWV1wmABoi5kfK0vvmRi7ykU8Uh3UcBEU1n3BObaXJ806kQtBwbx
         0niDk3xSxMhxAlyxPa9bLmWoJW+YKVF8XfEXHtdtVV3IEwD8Y3utQyV63RaXuhK6fWS9
         JUlSumtQ7DUzeAOCa9eZL65rgBZxMhtXmaOUuMu3res2rnY7X2ZvStr61qS3JLfP1VtN
         +/rus+adL2rwbthAJwpC3nWYUG9FoRm0C/It7m7J939wzDJYZlHxOQsDSQMw5hl/Pk4L
         Uys4kGjUqIaahtajvc0bfjhe+/ElinzNX4YiX0wtAUM/LSQdLaS/F+3SZdeWbxw6CbKm
         +ADw==
X-Gm-Message-State: AO0yUKVGNKb0tpzJXjFQt87FWkMXk5GPlKdBGPfXolsgNFPmNtv59GEh
        qmBAOaTXelUZEO9PVQMuvWw=
X-Google-Smtp-Source: AK7set8gCMJofk5FSNIVizKaPjHBXwg6a14aA/jWm1NshHn/1XJz7UUM21Z3hcZLxvbk2GNgV2whJA==
X-Received: by 2002:a9d:7253:0:b0:68f:2134:9a3a with SMTP id a19-20020a9d7253000000b0068f21349a3amr3275627otk.30.1677038123862;
        Tue, 21 Feb 2023 19:55:23 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:70ac:b1e4:53db:3994])
        by smtp.gmail.com with ESMTPSA id y6-20020a056830070600b00684cbd8dd49sm533404ots.79.2023.02.21.19.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 19:55:23 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/2] of: populate of_root_node if not set (alternate)
Date:   Tue, 21 Feb 2023 21:54:50 -0600
Message-Id: <20230222035452.803375-1-frowand.list@gmail.com>
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


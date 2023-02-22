Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48969FE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBVWLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjBVWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:11:43 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4F47408;
        Wed, 22 Feb 2023 14:11:24 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id nv15so9872799qvb.7;
        Wed, 22 Feb 2023 14:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pAyrr3tjGMd0qtnc7KKEB1MvbiiQcGAi5Pfup+ljo=;
        b=U453HkBgtIxIhKlxE7l3ga5fcRHQ4WQm93Msa0OJWxM1rAVtXsXfu9yzazznIop2Eg
         +MrIjRyl9wALqyp3h1T2e9V4RKsjf1VWHzi/428otRspYDBJLS2A7czfUJfdxaHEhEFz
         q14AMzF1RYjdtO6mDAUV15bTfXkBXyJTDGqTXLsAmVPZCJ6Vl/zlgL5v392qasLMaacN
         fgcxBHH+aLp2Kny0KMHuQ7UJ7F5YT18J/BA/GRWM0Ykpx5BXj+y61HPLGhdIlTJIkw/P
         oU1K2abCLxnGChLFgxnqvNaU9WS/tP9k3/kicyBVfpM5/ZGPP5syJJzHS3FZfc26d1Ny
         fuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3pAyrr3tjGMd0qtnc7KKEB1MvbiiQcGAi5Pfup+ljo=;
        b=agY6+332ixVzsqNHZExnIGpnm3S1qFfZxg7HgVceAkO6StVtc0fJwWF5iaDCrT3I2l
         KlVuos3M524D7LKYYn1ZiquRXNYAARrrImAYfvzX0MHb5u1uuwB3kTIsT550vMa/3cOp
         pUIYHZDAIjbtl06VfiznjFGmyAomuGu53v3OfgUo6bdW7BnQZvurkFWEzxPbmO9g0ri2
         dL0eTNoRjbr4MKFh8fi0ws5YjXAzed8vIIHcyoikJZLn4l/KSjcbqnycF82RpRQI/OAy
         WLZ3Jzd0Cd12U9+4cb7ELv/gduQedb6djb6IaJa8vkDk/umZBMY7mXwhOYGRvSmkLoMK
         kWBA==
X-Gm-Message-State: AO0yUKX6eXVeIIp+7MABAwN+AzpBxxly2ZnlGdelQzfH+sK5BqJUKKfd
        J+wcflxlfULX9yObZ9wBzV4MvFQ3k6c=
X-Google-Smtp-Source: AK7set+f0if3MgPReshSA7N7CpMmiddN0nF+lQh8pF41I8Vp7Q8ibOuhAKT4/j2fW98IeQZbiDm8/A==
X-Received: by 2002:a05:6214:27ea:b0:53c:818f:b093 with SMTP id jt10-20020a05621427ea00b0053c818fb093mr20634475qvb.19.1677103883405;
        Wed, 22 Feb 2023 14:11:23 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:70ac:b1e4:53db:3994])
        by smtp.gmail.com with ESMTPSA id a83-20020ae9e856000000b0073f7f1618e8sm6334294qkg.51.2023.02.22.14.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 14:11:22 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/2] of: populate of_root_node if not set (alternate)
Date:   Wed, 22 Feb 2023 16:10:49 -0600
Message-Id: <20230222221051.809091-1-frowand.list@gmail.com>
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


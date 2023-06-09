Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B155E72A1E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFISOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFISOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:14:19 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B903584;
        Fri,  9 Jun 2023 11:14:18 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77a103c5ebbso88544339f.3;
        Fri, 09 Jun 2023 11:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334457; x=1688926457;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brZOF7nrehUE/8Yor4NXyNlyFxJnESdJnOV2gg85IiQ=;
        b=gyOqcsla4WwH4NIzipZa3GRqjYfNCMLZjfVWu8jNTqJnAiQufsrMwPMu3kYIyvumx9
         AQt83FTzFzLbS2rxJhi2qzk7P7ZV3kVCHyBU5pkXU4JLN/wwm+AYWdDUtOzTPzxbGQXp
         IPdYPqk78nzeRHNcsHB90S67whK96eb7p9bhHGFifaM1c+BtuBMnivGWUrWpEJjJ28B8
         8i1/Ac5q8lw9maTA3iaPatzA/WhCFppJcIWbSZ6AyyCCvo/4jg7taX6lq94BtCkWkq38
         h0ewTgNrQ3a2BY9SgDQ8AR81FoZNge2Jk7FQzwxXSiUT07Xxqh3Wks2/ryEmEqMskxnx
         lXYg==
X-Gm-Message-State: AC+VfDxZOhzkmvTPS1vs2/Z0KaY0cOqElUwDu3cnDiQBgGI6GV/5h8lq
        2nVmaYMRQRkpkQ0xuEWQREBKwE4YSg==
X-Google-Smtp-Source: ACHHUZ6doK9IogLe2mxLOxpEj9piJPyTQY+TK0cR3dRLOragM+7vMmknwhXaY7Q60nMLuD6SaOVr4g==
X-Received: by 2002:a92:cacd:0:b0:33a:5bb5:f8f6 with SMTP id m13-20020a92cacd000000b0033a5bb5f8f6mr1901668ilq.18.1686334457532;
        Fri, 09 Jun 2023 11:14:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a3-20020a92c703000000b0033568b32890sm1235046ilp.24.2023.06.09.11.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:14:16 -0700 (PDT)
Received: (nullmailer pid 1681126 invoked by uid 1000);
        Fri, 09 Jun 2023 18:14:15 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/4] clk: Fix/cleanup mvebu CPU DT node accesses
Date:   Fri, 09 Jun 2023 12:13:44 -0600
Message-Id: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhrg2QC/3WNyw6CMBBFf8V07Zg+EIwr/8OwaGEKDbWYqTQaw
 r87snd5Tu7JXUVGCpjF9bAKwhJymBODPh5EN9o0IISeWWipjTS6gUdBt0AXJ/DhjRl8ZZWpz95
 K1wiunM0IjmzqRu7SEiPLJ+G+ZnNvmceQXzN99teifvb/QVEgoTKXHpXUNfr+NiEljKeZBtFu2
 /YFoQCWg8QAAAA=
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a couple of fixes and clean-ups to use preferred CPU accessors
rather than directly parsing DT "reg" properties. It's part of a larger 
effort to remove open coded parsing of "reg". The existing code is 
fragile depending on the CPU architecture details and is wrong for 
arm64 (though the dts files are also wrong).

Compile tested only.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Add patch 4 previously posted here: 
  https://lore.kernel.org/all/20230406010738.1269781-1-robh@kernel.org/
- Rebase on v6.4-rc1
- Link to v1: https://lore.kernel.org/r/20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org

---
Rob Herring (4):
      MAINTAINERS: Add Marvell mvebu clock drivers
      clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
      clk: mvebu: Iterate over possible CPUs instead of DT CPU nodes
      clk: mvebu: Use of_address_to_resource()

 MAINTAINERS                             |  1 +
 drivers/clk/mvebu/ap-cpu-clk.c          | 16 ++++++++--------
 drivers/clk/mvebu/armada_ap_cp_helper.c |  8 +++-----
 drivers/clk/mvebu/clk-cpu.c             | 14 +++-----------
 4 files changed, 15 insertions(+), 24 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230327-mvebu-clk-fixes-f4a1365fa0b7

Best regards,
-- 
Rob Herring <robh@kernel.org>


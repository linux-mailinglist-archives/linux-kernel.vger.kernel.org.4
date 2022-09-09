Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B725B3BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiIIPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIIPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:24:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562F1EEC2;
        Fri,  9 Sep 2022 08:24:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q9so1878390pgq.6;
        Fri, 09 Sep 2022 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/TVYg9gxnjxr72JuEtFu8ksh5BgzWE/f1gnQNq1u/+E=;
        b=VZuMHW81VVjpNX+Vyjnt4rACUL/5z92qHU7Areuz90DZsHDK9vUwGkHFFuXT/0VytH
         b4zhpdCSf3qmerCOHVABawhAcECIabcCGVfAbnj45cGTO+1Y2hbA6af6nG9NROwdZiXZ
         L0PI9hl3xg5Ist5NHfo7Z56lLXG1kM2aOjhDGSZCKWNG1JhXOf7niByXekmBL2hQElDj
         BAbWpyDQ4+U20VNP3yzazNLHqdQTsAV3CEzwGr49yElYyja8af9qXQMO6VG5/U97R5xu
         icKMZJHVcdWuy6tr9YVsBGGdbSN6T+xf3LM9bFk/+Q9oaKPVjxKaWHeHh34+lW1ei1dh
         y0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/TVYg9gxnjxr72JuEtFu8ksh5BgzWE/f1gnQNq1u/+E=;
        b=0aF/esXdynbHv+QALBkHftNYLya45Wy7aQUOqBRc5AelypnrEnptXo4WAeaS6bQDjq
         dd8RUVLMHX0zwbgH7nThp7tjWN18lSPpQjeV0+5sqWk/72VWEh8OBm5yJaR6/cyMiVq5
         K4PQ45Ff4ckGSOtMRGd40iADbxHyKY8Q97xePBs6VQcolJqFu9ttXn1Yl3cppnv8bcMs
         TYeFMfjcqcmvySmLm/54EJ8ZK5DTa/U7zC4uJDIfVjA+Vd9C9jO67aPyvrGl65YVTNCp
         3cMfaYAfOF8xtTQyxfJ6UMORITPXSRC1CMjWQ6BkurSzqm65/wPFCD7Iv5y4lD5+j1Cy
         Tf+g==
X-Gm-Message-State: ACgBeo0U7kLjIkxu87PtgxQN3lZOop/kaPW/nF/OLl9MWhH1sqj3sWVy
        UPdzJD+BwlAVbyhNmz2g0/M=
X-Google-Smtp-Source: AA6agR5kZ1IFNHNFWBwHIpburBXe/NmIxjCCshqr15P4T2/+4qYY48Ic0fifdCh4McVkvVnW1MDO0A==
X-Received: by 2002:a63:84c1:0:b0:434:b9db:b9d with SMTP id k184-20020a6384c1000000b00434b9db0b9dmr12768520pgd.397.1662737080891;
        Fri, 09 Sep 2022 08:24:40 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id p20-20020a63e654000000b00434abd19eeasm604006pgj.78.2022.09.09.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:24:40 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RESEND][PATCH V8 0/2] Add ums512 clocks and relative bindings file
Date:   Fri,  9 Sep 2022 23:24:19 +0800
Message-Id: <20220909152421.278662-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

This patchset is add the UMS512 clocks support

v2 changes:
  adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
  compatibles to fix match failed logs in the dt_binding_check.
  add the property license and copyright notice.

v3 changes:
  fix wrong indentation and hint: "maxItems" is not needed with an "items"
  list when use the latest dtschema.

v4 changes:
  move the syscon bindins from clk to glbreg yaml file by pickup 
  chunyan's patch for global registers bindings
  fix the comments from Krzysztof in v3 patchset
  add the Acked-by: Krzysztof in patch v4 3/4
  fix the  warning Prefer "GPL" over "GPL v2"

v5 changes:
  Add review tags.
  fix the comments in ums512-glbreg.yaml.

v6 changes:
  No more send the patch 1/4 and 3/4 in V5 for applied by Stephen
  change GPL to GPL v2 license
  fix the lack of space in some "{" and "}"
  add check error for sprd_clk_regmap_init.

v7 changes:
  Resend the patchset after the cross-tree patch merged
  use the absolute path for the mfd refs of patternProperties

v8 changes:
  add the const property for address-cells and size-cells.

Chunyan Zhang (1):
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Cixi Geng (1):
  clk: sprd: Add clocks support for UMS512

 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   71 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2202 +++++++++++++++++
 4 files changed, 2280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c

-- 
2.34.1


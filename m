Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEA5B3092
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiIIHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiIIHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:38:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE011B020;
        Fri,  9 Sep 2022 00:35:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t65so814500pgt.2;
        Fri, 09 Sep 2022 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=84egTDT1/lAGh+ekFxVhTTrXVTkSlhCJVYW1hdORQu8=;
        b=NMlJkcQ6a08q1uCn1snYIqPbZSZ82Um4jzZ8T+2UQFz3Pj0jIbG3JcMbMppG6NRJt2
         sIAW07T5t0eJwaCYoPlzDtvCq1Vgsxt9zgOKa1bnnp1jxCPQaV+YBQnvIsve1jCXDQl+
         /HTmBVOd1BOvUzWfCgDlVk+pivf83ioAcYX1EIcSYJOOPyFPV240Menio2/3zcA7Ud+R
         iVllGl4hzohF2O5a/c++/csZ7SZ+xw+c00rIyUckDTxaNV6SafFJ7lFCCzvc3Xe1r45g
         w+6adFvwc+ae+Wa48ZhEQcb4RymIZ8OqlMW4rKIQzaUwVyS0Wj7JysSI67/h26U3TR0G
         eabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=84egTDT1/lAGh+ekFxVhTTrXVTkSlhCJVYW1hdORQu8=;
        b=s0kZCLclf9cbC7wfOFdNG8V8PgTjbhTOOFRMMRXw8ekBoP3XhU6U8Meekbtk+NSjAw
         2iXr4fLxr70rNs5Uv52s/OzwI6iemhLPCu1S1x7aZnXb5TEs8xYzDGlXeW3Jc9Ez9tfG
         TTVszq0R4GWTR51y3AEkaXSoBwRXdcJo4l91IHh73Uk1iNM7PjcItZQUjFMiHOz7H5Nv
         6ouVnGEN/k8hLJzBFsqIXPRjnSPyPmq9wY/PuetSl9x0c2mMmkvQAFV9zdOpoM/JWaqe
         YdVowTesoFjEGY1wIxXGnafeTeukqvNqSl5bTCB/9JB2olFMZENTp4PeXuH19p4qLHuZ
         pqPw==
X-Gm-Message-State: ACgBeo3Oc9p8u4Zo+2DYXsNrvSnFVV7KICbay846NYx6VTl8i/ecUkNr
        y052ZdIaxwRNgA19ooYSV+M=
X-Google-Smtp-Source: AA6agR6hQrmuvCiEu5/BNDodrrIftjxQLHxObdA2P7Rf8jFssdZej+OLUk7VjJEqu+dI4T6/ZmiX/A==
X-Received: by 2002:a63:5209:0:b0:434:9e1a:bdba with SMTP id g9-20020a635209000000b004349e1abdbamr11316901pgb.297.1662708937563;
        Fri, 09 Sep 2022 00:35:37 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b00174e5fe9ce1sm720938plb.159.2022.09.09.00.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:35:37 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V7 0/2] Add ums512 clocks and relative bindings file
Date:   Fri,  9 Sep 2022 15:34:54 +0800
Message-Id: <20220909073456.239668-1-gengcixi@gmail.com>
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
  use thr absolute path for the mfd refs of patternProperties

Chunyan Zhang (1):
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Cixi Geng (1):
  clk: sprd: Add clocks support for UMS512

 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2202 +++++++++++++++++
 4 files changed, 2277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c

-- 
2.34.1


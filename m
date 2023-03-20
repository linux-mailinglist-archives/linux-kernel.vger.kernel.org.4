Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29F66C22FF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCTUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCTUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:41:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D66EAE;
        Mon, 20 Mar 2023 13:40:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bc12so13244085plb.0;
        Mon, 20 Mar 2023 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oP/lmvQkJKOB+NiwdwqhS7TJ3nK9Wr8UjnRiV84v7Ec=;
        b=dTO1VImJdRiJkRGhegkOaL3B+5MUB2K7KE43b5gCftBgc+p2PNRgHMFnJuBCGpSDh7
         aT1MxFEknjb7nYTE7zcrcrGsCepsNJYETH2B+YqJn1qA1opjp0pq+iTlomaTv+4yo1ay
         U8j5KczVvPGzdhE8GCr5vWZU6wculTjvyYkpwCbVEVviMJizucsOtC1nFeek8G6XNbNN
         OF0fKsVNE6GkOK1jIB8DBt8UvGZZT2tfvXpyS7PLqQnlXV+aUVdXgspOGO9jtmVccrsc
         mlGcwdiP7r3kKL/DJvM+l5lSOQPNxnx9qRkDIbY3zM4KDW9q2OTKuITffWrUKj6uWeMw
         o3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP/lmvQkJKOB+NiwdwqhS7TJ3nK9Wr8UjnRiV84v7Ec=;
        b=VZz2BVb7M22UT3WGfypFCWzkIRbApLlhCV4qrIQVJ8PSI/W64eEPgmt3lwWdsbHJMI
         bqlyA9jysNrfULFv3ff5kUTQuuFOSqca/mm20bjVxVc8ZIs+5d+ehc0NcJbabU+mQVUh
         t6iEm74GhKu2aapdXh5BYVnS9UDMAooCbcH08OXbZJ7IQkMEoRqXx1tCJKmjlKt8x4F6
         uRdlxDtwdTctgnCvYC0SbEpgCP1GHz0kXqnKzyzKbd/tsrz6qa/XnLl4j1YQ2Q8Jm1jO
         1yneXzXH+WU9Y6aTRLios6qkQENUEdFAKkibJmEGFm0Dlu7GIVwUSzM2XnadqMcpfBAM
         P+Ew==
X-Gm-Message-State: AO0yUKXUn7TRBEiEs25W01FRD/gFFMMgdrpmD1Ebg08NQOs84mohGGS5
        ZCpBvjGDewTfktCESERlEuMKGoyFlXgpcfc9
X-Google-Smtp-Source: AK7set9CSd1MpC/y59ddHgavhDboSBzOwMzuF1fFx9AD17b+1pdMkVZ1k91joG9Z3gBS2oVAwlQW6A==
X-Received: by 2002:a17:90b:4d8b:b0:23f:3ee2:8ec6 with SMTP id oj11-20020a17090b4d8b00b0023f3ee28ec6mr496577pjb.11.1679344857541;
        Mon, 20 Mar 2023 13:40:57 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090aa60300b0023b29b464f9sm6580943pjq.27.2023.03.20.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:40:57 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Add CRG driver for Hi3798MV100 SoC
Date:   Tue, 21 Mar 2023 04:40:33 +0800
Message-Id: <20230320204042.980708-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CRG driver for Hi3798MV100 SoC.

v2: move bindings to a separate patch
v3: fix bindings commit message, reorganize patches
v4: add ethernet and gpu clocks
v5: add complex clock

David Yang (5):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  clk: hisilicon: Add complex clock for Hi3798
  dt-bindings: clock: Add Hi3798MV100 CRG
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/crg-hi3798.c            | 742 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 ----------
 include/dt-bindings/clock/histb-clock.h       |  13 +
 6 files changed, 761 insertions(+), 405 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c

-- 
2.39.2


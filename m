Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8062C6AD5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCGDY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCGDY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:24:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9CD40D9;
        Mon,  6 Mar 2023 19:24:55 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so10693873pjp.2;
        Mon, 06 Mar 2023 19:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678159495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTc4B3MdrvJL+//ogx+A/OVOi7fKk3cnu/IQgSSgXI=;
        b=KiE5V0euhm478iJxKklx3HghgzUC/vcW6bUISgyVPy3rMYvY2hxagsr7dauVn3QjNx
         2ji2NtqAc6//EujUXgL6XyvT3CLVTM58K3cpscZHGoSRkOIG8izGKXU8hID/Te6Yz3gd
         sMu/g2yhLnDl9N6PC53rBbNlk9LTU9HTMyHwAmrdq/ny4pNRi1tUurwYc8jC3xKR/IbN
         u7BG15WROlV+tuZhM1jOTaftVjbtSnPzMwI5VdNdCnr2CoBdyrg7/bz9/W3FKqkWRIAr
         LRuHiYbOGDtqJVpGj7+Empc5EmbkbiXuGsVT5eKJ6uFZFapOkcO7vsxu8BOe7WzHQBdI
         A+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678159495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhTc4B3MdrvJL+//ogx+A/OVOi7fKk3cnu/IQgSSgXI=;
        b=p1YXXUdiJuBc1Swy/iuCOduSM0pqLspXbFDohcvClwTePqZgwiiTseSd0DffQVSNSA
         4TxvoXq0a4aqz06aNnKeyjuRjVFcWtwecYIzFVXfbhyNOdnPbC2dnpHDTrBItgutYWup
         a4AsgiiyMqC+CECHAYXoIsXNBcSVmlkKlp+hLp+p611C7U+BPtTUhRS7kwBTcAOOvkAo
         UrIUZMfh37480pZuaJqgGHOW5hP4Twj4mlM+TiDuVhrlEM5p1CXDFaVk5FBqtAfzzzZU
         D7ecFn9zppNDzh2ePhJDnUPKkPffeB6j8euH5AB3ZAACE/Rm7BeGngmL98IeFhK+PysL
         rAUA==
X-Gm-Message-State: AO0yUKVTU77mSIbiboxd9kzZTPEWBKmWyPONZX0dpyHw/p5cDIPUzcDY
        RASvo8skg+msFKGfeKEhwM5HKovc/wUMHNhY
X-Google-Smtp-Source: AK7set/+B+WizNZo6RSY76PWRMEsrXzKgB8hJRZvlvi2A22wnLhtccaKXRM00a0I1jQz0o0E52htwg==
X-Received: by 2002:a17:903:246:b0:19c:fd73:5586 with SMTP id j6-20020a170903024600b0019cfd735586mr15844155plh.38.1678159495239;
        Mon, 06 Mar 2023 19:24:55 -0800 (PST)
Received: from y.ha.lan ([2a09:bac5:21b4:1246::1d2:a])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b0019a997bca5csm7380022plh.121.2023.03.06.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 19:24:54 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add CRG driver for Hi3798MV100 SoC
Date:   Tue,  7 Mar 2023 11:22:34 +0800
Message-Id: <20230307032243.14988-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series adds CRG driver for Hi3798MV100 SoC.

v2: move bindings to a separate patch
v3: fix bindings commit message, reorganize patches

David Yang (4):
  clk: hisilicon: Rename Hi3798CV200 to Hi3798
  clk: hisilicon: Extract common functions
  dt-bindings: clock: Add Hi3798MV100 CRG
  clk: hisilicon: Add CRG driver for Hi3798MV100 SoC

 .../devicetree/bindings/clock/hisi-crg.txt    |   2 +
 drivers/clk/hisilicon/Kconfig                 |   6 +-
 drivers/clk/hisilicon/Makefile                |   2 +-
 drivers/clk/hisilicon/crg-hi3798.c            | 611 ++++++++++++++++++
 drivers/clk/hisilicon/crg-hi3798cv200.c       | 401 ------------
 include/dt-bindings/clock/histb-clock.h       |  10 +
 6 files changed, 627 insertions(+), 405 deletions(-)
 create mode 100644 drivers/clk/hisilicon/crg-hi3798.c
 delete mode 100644 drivers/clk/hisilicon/crg-hi3798cv200.c

-- 
2.39.2


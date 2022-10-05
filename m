Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46F5F51D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJEJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJEJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:36:48 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30FB2936C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664962606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gov+ZrJ+QjAKAnae9bKBInhsSBvgjpflgUkl005cf6c=;
        b=iP0SkmwYL88IZWcrzEg/jryHIo2FKc8lU/k2nq0WCpgJYICo7vHBGHqPxUs0MWMyIXM//Z
        7YLP8EsqObm5jsGl3JKz+aOJ5nK+QR0xKRykSLG9Rh+6zNVozuBeC0Xa/EamBbsWewjCXr
        COHUfuaCcdiZwTgUplZgIcnUjVe+s1SFRDXKCPtyG79am4sQVfob8mhXAGqlHizqT63hZj
        4NWwHfocMnrqaYOQHsNYx999Au6bYHwivc2OzIbWuEIF+/djw+PL2TRpUGdY7KRoeuh6z0
        aufsCWbMFng7LYu03QoUNhM6LCW7vDGTIwW9pl1+jatO1LtEA12RYdkrkt9V+A==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-269-l00reBIlPr-MaJEgim18GA-1; Wed, 05 Oct 2022 05:36:45 -0400
X-MC-Unique: l00reBIlPr-MaJEgim18GA-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 5 Oct 2022 02:36:41 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v3 0/4] Modify MxL's CGU clk driver to make it secure boot compatible
Date:   Wed, 5 Oct 2022 17:36:34 +0800
Message-ID: <cover.1664958833.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MxL's CGU driver was found to be lacking below required features. Add these
required lacking features:

1. Since it is a core driver, it has to conform to secure boot & secure
   access architecture. In order for the register accesses to be secure
   access compliant, it needs regmap support as per our security architectu=
re.
   Hence, replace direct read/writel with regmap based IO. Also remove
   redundant spinlocks from the driver as they are no longer necessary
   because regmap uses its own lock.

2. In MxL's LGM SoC, gate clocks can be controlled either from CGU clk driv=
er
   i.e. this driver or directly from power management driver/daemon. It is
   dependent on the power policy/profile requirements of the end product.

   To support such use cases, provide option to override gate clks enable/d=
isable
   by adding a flag GATE_CLK_HW which controls if these gate clks are contr=
olled
   by HW i.e. this driver or overridden in order to allow it to be controll=
ed
   by power profiles instead.

3. Fix a bug related to missing flags in one 'dcl' clk entry.

This patch series is based on below git tree (linux-v6.0-rc1):
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git


Rahul Tanwar (4):
  clk: mxl: Switch from direct readl/writel based IO to regmap based IO
  clk: mxl: Remove redundant spinlocks
  clk: mxl: Add option to override gate clks enable/disable
  clk: mxl: Fix a clk entry by adding relevant flags

 drivers/clk/x86/Kconfig       |   5 +-
 drivers/clk/x86/clk-cgu-pll.c |  23 ++-----
 drivers/clk/x86/clk-cgu.c     | 122 +++++++++++-----------------------
 drivers/clk/x86/clk-cgu.h     |  46 ++++++-------
 drivers/clk/x86/clk-lgm.c     |  18 +++--
 5 files changed, 82 insertions(+), 132 deletions(-)

--=20
2.17.1


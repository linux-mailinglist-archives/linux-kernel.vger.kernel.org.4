Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1B5FD52F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJMGtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJMGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:48:51 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F7142C85
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 23:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1665643721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1w/vr3tpAIYE91n/PxWCt8JgkoaISpPedoc6geZvc6o=;
        b=hnqKsE9XfHEVJ5Sk2zZmhfQUKwTQet0CoOb6iondq/rd6ZAJdOgwGxwUn/MMXGLQEMGHna
        bXm1eIygGBdLkDn8QEmjz4b+iqI9UrkFqa/1qWRHqOSU+Fg3iVBOWgY/1kqF87Ayk3YVkG
        l9MsKQ6+tl4JU0Yx/COcweU5ldjg8NhGzfBymFGk/KNkVedhWsXPb6bTAOTNSyo0eAqxgr
        wWz1Q/+EtvKe/OT8jcAwTMHtEKbQMu6433WSP7Ar10OmXiiHScH//15YMDYnoeLUvugEs6
        fVddAdI7bFWRhsJleNtKaKZIIFWta9iA+5oCp1+GZhHoTO4C04mXa9/UgswTVw==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-328-8jWJ2PiLP7iAzNjbD_vaVg-1; Thu, 13 Oct 2022 02:48:40 -0400
X-MC-Unique: 8jWJ2PiLP7iAzNjbD_vaVg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 12 Oct 2022 23:48:36 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>, <yzhu@maxlinear.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v4 0/4] Modify MxL's CGU clk driver to make it secure boot compatible
Date:   Thu, 13 Oct 2022 14:48:29 +0800
Message-ID: <cover.1665642720.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v4:
- Address review concern (Stephen Boyd)
- Change the design of how GATE_CLKs are overridden.
  Make the clk provider return NULL when that clk needs
  to be overridden.

v3:
- Address review concern (Stephen Boyd)
- Change the method of fixing invalid width for reg read/write.

v2:
- Add option to override gate clks
- Fix a clk entry by adding relevant flags

v1:
- Initial version

Rahul Tanwar (4):
  clk: mxl: Switch from direct readl/writel based IO to regmap based IO
  clk: mxl: Remove redundant spinlocks
  clk: mxl: Add option to override gate clks
  clk: mxl: Fix a clk entry by adding relevant flags

 drivers/clk/x86/Kconfig       |   5 +-
 drivers/clk/x86/clk-cgu-pll.c |  23 ++------
 drivers/clk/x86/clk-cgu.c     | 105 ++++++++++------------------------
 drivers/clk/x86/clk-cgu.h     |  46 +++++++--------
 drivers/clk/x86/clk-lgm.c     |  18 +++---
 5 files changed, 72 insertions(+), 125 deletions(-)

--=20
2.17.1


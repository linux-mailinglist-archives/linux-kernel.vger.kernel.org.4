Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D915E5B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIVGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIVGYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:24:46 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FE676975
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1663827881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mD96AnXUKxYpT4Ph/26bbpXc79T1z2l442gHWiW5cxs=;
        b=BjH0RAf9/2DDAhfe/pudX1UUk+/j2Yyop1KzVNbMCZPI2cRPoH6EhqBU6RxcimfoEcodLW
        E08mOm9Muy2kitE2oGvOIMB6QdNwqzh+CNlwvyBTnllRG1JBtznHBeYkZDi+aiVHn0CD1f
        EYRWYLM2B6WGZFqrKElqFkEPQZnJL1qEnP7qRA59zpszZen6zocEdaMPxZT+BtaXx2JCgu
        9fmd0VW0VWYG4h18P1RBOuvKVw0TPtEg1i8vlMMLoG7VvykZpbkzJUjerq4O+QIYMY8Mm2
        +FVMdgxrCdOWB7VyajQIMlUGts64FmlN+GQXPyX5DpXvjcCZEdMMtIUs03NvrA==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-114-gh-cS0hiM1amzwT5hCndqg-1; Thu, 22 Sep 2022 02:24:40 -0400
X-MC-Unique: gh-cS0hiM1amzwT5hCndqg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 21 Sep 2022 23:24:36 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH RESEND v2 0/5] Modify MxL's CGU clk driver to make it secure boot compatible
Date:   Thu, 22 Sep 2022 14:24:23 +0800
Message-ID: <cover.1663827071.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rebase on latest 6.0 clk linux tree and resend patch series because of
  no response from anyone so far. Please let me know if anyone has any
  concerns about these changes. Thanks.

MxL's CGU driver was found to be lacking below required features. Add these
required lacking features:

1. Since it is a core driver, it has to conform to secure boot & secure
   access architecture. In order for the register accesses to be secure
   access compliant, it needs regmap support as per our security architectu=
re.
   Hence, replace direct read/writel with regmap based IO. Also remove spin=
locks
   because they are no longer necessary because regmap uses its own lock.

2. There are some gate clocks which are used by the power mgmt IP to gate w=
hen
   a certain power saving mode is activated. These gate clocks can also be=
=20
   gated from CGU clk driver. This creates a conflict. To avoid the conflic=
t,
   by default disable gating such gate registers from CGU clk driver. But k=
eep
   a flag to do so for other older IP's which uses same CGU clk IP but does=
 not
   use same power mgmt IP.

3. Fix two functional bugs found during testing.

This patch series is based on below git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git


Rahul Tanwar (5):
  clk: mxl: Switch from direct readl/writel based IO to regmap based IO
  clk: mxl: Remove unnecessary spinlocks
  clk: mxl: Avoid disabling gate clocks from clk driver
  clk: mxl: Add validation for register reads/writes
  clk: mxl: Add a missing flag to allow parent clock rate change

 drivers/clk/x86/Kconfig       |   5 +-
 drivers/clk/x86/clk-cgu-pll.c |  23 ++-----
 drivers/clk/x86/clk-cgu.c     | 117 +++++++++++-----------------------
 drivers/clk/x86/clk-cgu.h     |  71 +++++++++++++--------
 drivers/clk/x86/clk-lgm.c     |  16 +++--
 5 files changed, 101 insertions(+), 131 deletions(-)

--=20
2.17.1


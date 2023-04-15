Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A16E32CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDOROK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDOROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2710E7;
        Sat, 15 Apr 2023 10:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2D960B00;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25E28C4339B;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681578846;
        bh=/jSsoNxOvU8LSy+l6NwzbNJ7bw9nm6AcIP7OOw8z6pQ=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=Lat7VnNXQ6AoNm2PHANEyrOZERv7dzW5MJn3a+tKFjsDFx9iQgxyy3ZTscQGK2xaQ
         OyUrhpqLPWwaMg18/n8RsqiCnoqomSShiJ0dk4lvISqoj3vBCKToedpAs2JtYHL7Ii
         7+INKhM6HhZx4ixo8majrNGBgiITShvept6RdDIfzEafvmnvQWtDmAYodi3tXDFa/Z
         x4oxvCRLWyaUe9K9vJIFDunXTYvVQzKRHR7LapxTv7Q1HnbT12nl5nFz+BBF42P8My
         TNjb3PO5uAIF8UIKfLW60Z2h1CIYzHiaSVwdnTvZwWtx8aMO88M1dIJpGkw0aE09xv
         EA24JZOqEJUIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 08CFAC77B77;
        Sat, 15 Apr 2023 17:14:06 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC v2 0/3] mmc: add support for the dw-mmc controller on
 Hi3798MV200
Date:   Sun, 16 Apr 2023 01:13:15 +0800
Message-Id: <20230415-mmc-hi3798mv200-v2-0-1d274f9b71da@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvbOmQC/3WNyw7CIBQFf8XctRigD4srExM/wK3pgsdViFIMV
 KJp+u/S7l3OOZnMBAmjwwSHzQQRs0suDAX4dgPayuGOxJnCwCmvaM0a4r0m1lV70fnMKSUaWYN
 CibZrWyiWkgmJinLQdvG8TCPG5XhFvLnPmrrC5XyCvozWpTHE75rPbL3+ljIjlBjVKMGMqISpj
 +E9PkN47HTw0M/z/AN2fUw/zgAAAA==
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681578841; l=1327;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=/jSsoNxOvU8LSy+l6NwzbNJ7bw9nm6AcIP7OOw8z6pQ=;
 b=l4JXNZc79E2xwFXSVxovtxTQvUrpZAmERG0HzQvNBiv1O1kOh4Np5tlJxusfjwJbQDhwaU3lw
 48Dst+MG4HkC/nYlTtZygyY4WmHuE7CeSnQ4gSXvc4Yz3t6HzgOvWS9
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dw-mmc controller found on Hi3798MV200 is like the one found on
Hi3798CV200, but has some tweaks.
Also refreshed the dt binding and converted it to YAML.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- add DDR52 support
- edit dt-binding, substitude all hi3798cv200 with histb
- send email to more people
- Link to v1: https://lore.kernel.org/r/20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com

---
Yang Xiwen (3):
      mmc: dw_mmc-hi3798cv200: rename to dw_mmc-histb
      mmc: dw_mmc-histb: add support for hi3798mv200
      binding: mmc: hi3798cv200-dw-mshc: convert to YAML and rename to histb-dw-mshc, add compatible of hi3798mv200

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ---
 .../devicetree/bindings/mmc/histb-dw-mshc.yaml     |  90 ++++++
 drivers/mmc/host/Kconfig                           |   8 +-
 drivers/mmc/host/Makefile                          |   2 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              | 206 -------------
 drivers/mmc/host/dw_mmc-histb.c                    | 339 +++++++++++++++++++++
 6 files changed, 434 insertions(+), 251 deletions(-)
---
base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
change-id: 20230415-mmc-hi3798mv200-ce15e9b96866

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


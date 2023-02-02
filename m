Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D8687721
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjBBITP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:19:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1840BFC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:19:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m13so1065243plx.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSLvoWKFIHzwbiFrmh/N7Zqs+NmVx/mQp/jfLVij8Fo=;
        b=yR0zznsS7cpKWzf5jRRu1SGs5mdFv/ROA4gWJHdcf2U0ApQBKMCTIx7XJTvfyIhYx7
         z4ZU+Wb8T/vM5vYb4/8lzB8hrv0hA4AyIZLJLJKteoRUwHCREgIqN9434HXAXY0iCRVB
         ew05JPjLH1iedjt1pKPYk1qWZeaU1ybOS0C5znbVTEoDJiHSnoPmpsUE1YvA6FQgsJyz
         vxj+xfCfPD0x3avfnnqNxuPXaPwST/M1hCpiPAJtLU0daE3NUFKGsngr+c7Uwm5Nd0Xf
         GVAEwM9ozQ5XrzKfjU7heQNNdZR+iYLwPv7gH4vy2hRjXEwfTV0dqh0RksQSr4vqmvNd
         mfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSLvoWKFIHzwbiFrmh/N7Zqs+NmVx/mQp/jfLVij8Fo=;
        b=K5WadOvs8rx3dNgFLBzkAM8TUxr5OjXmz7QLtu4hWttoxUPzUBQfwaB54a7hJbmsPS
         jCVD7aL46IrUhq64AHFIFArmXJTr4iZk63oEUPfDGPeb6dKJpUCpaKQZaAJDDFuYU9D0
         QxjcRlTr+Qm+u9MjMdcxI6EIntIIuVWiAVYGrtEFEFE5tLphJfN3kS9qPbNRn4qwCzli
         OYfoOZ2VONyG/IGOorh+J8/q1aMbSMzZDFdSU3LuSKFu+vtbbinVEH+qAQk+DqKCknt2
         yN8+zJm1NqsUQXve1GetymCWVkQN2xcOFrv3irJGk3qqvZXcq4MPAQItJYAgn1umWU3E
         qZcg==
X-Gm-Message-State: AO0yUKVs5GD6cmf17L9AjWazajyFfDb8dTH0ND4qQS6TFV7abddurC/x
        mqQgys1gFMHbDGsfVePtHCM3uw==
X-Google-Smtp-Source: AK7set9hjfIzs5B04/10d95IHbHrAEAa7w/n9b2kPsEqjrWUVEguQhrMFdHHr8eu1oqizGH77mcqXw==
X-Received: by 2002:a17:903:24f:b0:196:3db5:c08b with SMTP id j15-20020a170903024f00b001963db5c08bmr6596565plh.69.1675325950749;
        Thu, 02 Feb 2023 00:19:10 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709029b8900b0019324fbec59sm13187552plp.41.2023.02.02.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 00:19:10 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v2 0/3] Add Ufispace NCPLite platform device tree
Date:   Thu,  2 Feb 2023 16:18:40 +0800
Message-Id: <20230202081843.2358-1-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ufispace NCPLite platform device tree, and add the compatible
string in dt-bindings files.

Changes for v2:
- modify node name to generic one and check with dtbs_check
- send-email without confidential mode

Jordan Chang (3):
  dt-bindings: vendor-prefixes: Add prefix for Ufi Space
  dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
  ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
 4 files changed, 363 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

-- 
2.39.0


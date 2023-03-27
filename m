Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12E6CAD64
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjC0Snh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjC0Sn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:26 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBDC40E7;
        Mon, 27 Mar 2023 11:43:21 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id f4-20020a9d0384000000b0069fab3f4cafso5063079otf.9;
        Mon, 27 Mar 2023 11:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiiBLEZPlQzu45k0Hu3yD+klHY/8gppuEuWQh0rwN1Y=;
        b=H8hObbVepyle4+RgAaKHAnDLGmbukYFuNwfACd6E25G6brwtvRDzFCCmUrLXTGk5Gn
         e6/6AofMBYfFTD0rxto5ST+X+0/DGRnuuF65DV5N2ZHib1RhkrWg33V9eJ4q8GrfMW0h
         6J376rv+fP52atobRc44CGKsSTc8G7SGTQFDhVvCGnXnzpCIbxSY2TJxqR3Dul6za1i9
         C0AO6YrQ2IawxUb5zqmeIqvyvvEpAxYh0AyeMZah5z1lwwuqCidux1pA4OVwDTUxqPS3
         qTxTx9uRdJJU8yu/IngJ1Qem3XVzmbuWEtCp8xhabypPUC8l73nY0gro6HiPFsj12Tcp
         YIvA==
X-Gm-Message-State: AO0yUKXhzl5pxfg/mxshvuCrryigmEPXuYnJYFpAvtWp2W9ZaohhuNRH
        /MtBOe7Ot7kECGDKKiYt5Ajrn/9JOg==
X-Google-Smtp-Source: AKy350a1+WSE/k5JT2iVmvW1QIunpD4icUcr0gou91cdXiN32HGnRrOZgGc1/o/6cRP8MH24qsjj5A==
X-Received: by 2002:a9d:7c94:0:b0:69b:c852:4ab8 with SMTP id q20-20020a9d7c94000000b0069bc8524ab8mr5919552otn.7.1679942600225;
        Mon, 27 Mar 2023 11:43:20 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d6442000000b0069f0a85fa36sm10526407otl.57.2023.03.27.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:43:19 -0700 (PDT)
Received: (nullmailer pid 250774 invoked by uid 1000);
        Mon, 27 Mar 2023 18:43:19 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH 0/3] clk: Fix/cleanup mvebu CPU DT node accesses
Date:   Mon, 27 Mar 2023 13:43:17 -0500
Message-Id: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXjIWQC/x2L0QrCMAwAf2Xk2UDX6gb+iviQ1nQL66o0bAhj/
 27w8Y67A5SbsMK9O6DxLirvatBfOkgz1YlRXsbgnQ8u+BHXneOGqSyY5cuK+Up9GG6ZXBzBrkj
 KGBvVNNtXt1JMfhr/azOP53n+AJQ6IFN2AAAA
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
Rob Herring (3):
      MAINTAINERS: Add Marvell mvebu clock drivers
      clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
      clk: mvebu: Iterate over possible CPUs instead of DT CPU nodes

 MAINTAINERS                    |  1 +
 drivers/clk/mvebu/ap-cpu-clk.c | 16 ++++++++--------
 drivers/clk/mvebu/clk-cpu.c    | 14 +++-----------
 3 files changed, 12 insertions(+), 19 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230327-mvebu-clk-fixes-f4a1365fa0b7

Best regards,
-- 
Rob Herring <robh@kernel.org>


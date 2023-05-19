Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130F1709F90
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjESTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESTF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:05:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE97125;
        Fri, 19 May 2023 12:05:27 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-050.ewe-ip-backbone.de [91.248.213.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C83B06605960;
        Fri, 19 May 2023 20:05:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684523125;
        bh=+cr9Yl8jFHNUcCdRbkgGRIZTigZRASzNJ69ZJfpPdhE=;
        h=From:To:Cc:Subject:Date:From;
        b=n9xLMdqiWjrJA0EjguyAg/+VK6xQrA9Y3ZQTzaYSzDzBF8k5qFfsS1qyfdiRVyNCA
         pONIvkX2hGgmkHrvCxNoKO4vyFkO3mMhtfiNa9QIAGwzfsSzuo15Gtc1Ojm57hZfcI
         QwYQkRfgstm3e9Hxhwj3XGPO7WYyZpx1/QiO+xeZqhGQ+jOf5qhA7QT8iQOOxtCUFr
         N4CiUqSFlAxesFW4vWKDNzI7vrVZ7mDan6wTUfW4gv1y7qRuHpARFTH/nMwxFM2Np4
         y+UVBJlHctaGOuCFH9HAR+4sGhM/iGUHw6lQ4PkO73hNVmUayf2HxLRKNTyc9D6q8s
         DDpEppSdp7Fqg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8758A4805CC; Fri, 19 May 2023 21:05:23 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 0/2] Fix 64 bit issues in common clock framework
Date:   Fri, 19 May 2023 21:05:20 +0200
Message-Id: <20230519190522.194729-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found two independent issues related to handling of big rates
in the common clock framework.

Thanks,

-- Sebastian

Sebastian Reichel (2):
  clk: composite: Fix handling of high clock rates
  clk: divider: Properly handle rates exceeding UINT_MAX

 drivers/clk/clk-composite.c | 5 ++++-
 drivers/clk/clk-divider.c   | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.39.2


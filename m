Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3BF712B75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbjEZRLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjEZRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:11:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8AF2;
        Fri, 26 May 2023 10:11:00 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-132-021.ewe-ip-backbone.de [91.248.132.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 746796606E90;
        Fri, 26 May 2023 18:10:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685121059;
        bh=8eB9AnYSCt+Yx89BjWAzjTBX54X+yIdd1MahV6KNCEA=;
        h=From:To:Cc:Subject:Date:From;
        b=Ocfqrq1NBZKtoJBhWc9oqb3vqtHHPAh7/6rZmj0hTfUrnYN/J6zH3kLods+tN++Xx
         ef6Duww05ebBxEK+QOAX94u/GIgiITIBLtOaOdpDCqEWsw0IAFHwaCG8zO5QUd4aQ0
         eTgatWH0VcKfG45aSadyBApHC7RwYUg5Usya1wES3MW1MJXuh43EXMeAajo8fexbnE
         M1+hJUrlHtMH6n/zorpbtM2jRsiaAx3uhJsWrX8yeaoTha946MY5i5nNTYHFyfNXKJ
         LeLTuSKYli4IGBEfLDWEXBncE+Mb/rSNVmmX9exejaGrKBLNWn9xRRX7wqbxPzpRLl
         PjS3f82tiB9qg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id D00C34807E1; Fri, 26 May 2023 19:10:57 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/2] Fix 64 bit issues in common clock framework
Date:   Fri, 26 May 2023 19:10:55 +0200
Message-Id: <20230526171057.66876-1-sebastian.reichel@collabora.com>
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

Changes since PATCHv1:
 * https://lore.kernel.org/linux-clk/20230519190522.194729-1-sebastian.reichel@collabora.com/
 * Add Christopher Obbard's Reviewed-by to the first patch
 * Update the second patch to use DIV_ROUND_UP instead of DIV64_U64_ROUND_UP

Thanks,

-- Sebastian

Sebastian Reichel (2):
  clk: composite: Fix handling of high clock rates
  clk: divider: Fix divisions

 drivers/clk/clk-composite.c | 5 ++++-
 drivers/clk/clk-divider.c   | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.39.2


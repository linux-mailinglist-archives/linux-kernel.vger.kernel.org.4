Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA63D722F4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjFETIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjFETIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:08:34 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D994;
        Mon,  5 Jun 2023 12:08:25 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QZjn01gZDz9sTy;
        Mon,  5 Jun 2023 21:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685992100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A6+BxjI7OK+Zyu+DiOoC1GzWLKWtwv1JdA+R6MwHfl4=;
        b=KoDdPpgrPHnijD0a50D5hOz8zC93mnwA+hyD+GX8pKtCIG2Anlw1UhOWmATQNnEwcO1pax
        IxCXo7IQ+GBWO06LxE1JRn3Mb/viG0A+3IaRQWeeCCmtLp+kvNSEK2VdprTG+gYGuijZi4
        dLP/Ir8mP4/mtcFWDLlAePfRYbreDniKfi7ljscyDUeb6rZJbLkp5BxqlSCz/PgypHKi1+
        yfVy9UVqYxfMRIF2XeaP0jkM1h73IPx13CVYGVgqZW02Dy+rr8tzKKbY629zU3iKFqGFZz
        VvgEJoA1W5vHcWn6E0/qmvV3yIgB7nskmGXNDdU8dAqaIuaNCl1LG8SIGKsWQw==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/2] clk: sunxi-ng: Consider alternative parent rates when determining NKM clock rate
Date:   Mon,  5 Jun 2023 21:07:43 +0200
Message-Id: <20230605190745.366882-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to share a patchset that enables the NKM clock in pll-video0 to
consider alternative parent rates. I have found this feature particularly useful
to adjust the pll-video0's clock on Allwinner A64, as it allows me to achieve an
optimal rate for driving the board's panel (in my case, the Pinephone).

To provide some context, the clock structure involved in this process is as follows:
    clock                       clock type
    --------------------------------------
    pll-video0                  ccu_nm
       pll-mipi                 ccu_nkm
          tcon0                 ccu_mux
             tcon-data-clock    sun4i_dclk

The divider between tcon0 and tcon-data-clock is fixed at 4. Therefore, in order
to achieve a rate that closely matches the desired rate of the panel, I need
pll-mipi to operate at a specific rate.

However, I must emphasize that setting the parent's rate for NKM clocks results
in a significant increase in the time required to find the optimal rate. For
instance, setting DCLK on the pinephone has seen a 60-fold increase in the time
taken, from approximately 0.5 ms to around 30 ms. These figures were obtained
through informal measurements on my pinephone, involving kernel logging and a
few reboots. The worst-case scenario observed was approximately 37 ms, while the
majority of cases were just under 30 ms.

The reason for this considerable increase in time is that the code now iterates
over all combinations of NKM for pll-mipi. For each combination, it subsequently
iterates over all combinations of NM for pll-video0.

I greatly appreciate your feedback and suggestions for further improving this
patchset.

Thanks,
  Frank

Frank Oltmanns (2):
  clk: sunxi-ng: nkm: consider alternative parent rates when finding
    rate
  clk: sunxi-ng: a64: allow pll-mipi to set parent's rate

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c |  3 +-
 drivers/clk/sunxi-ng/ccu_nkm.c        | 40 +++++++++++++++++++++------
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.40.1


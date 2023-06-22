Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC01173A166
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFVNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFVNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:05:25 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778219AB;
        Thu, 22 Jun 2023 06:05:25 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qCJzn-00D3Em-Qs; Thu, 22 Jun 2023 14:05:08 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qCJzo-002Xr9-0l;
        Thu, 22 Jun 2023 14:05:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: net: macb: sparse warning fixes
Date:   Thu, 22 Jun 2023 14:05:04 +0100
Message-Id: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are 3 hopefully easy patches for fixing sparse errors due to
endian-ness warnings. There are still some left, but there are not
as easy as they mix host and network fields together.

For example, gem_prog_cmp_regs() has two u32 variables that it does
bitfield manipulation on for the tcp ports and these are __be16 into
u32, so not sure how these are meant to be changed. I've also no hardware
to test on, so even if these did get changed then I can't check if it is
working pre/post change.

Also gem_writel and gem_writel_n, it is not clear if both of these are
meant to be host order or not.

Ben Dooks (3):
  net: macb: check constant to define and fix __be32 warnings
  net: macb: add port constant to fix __be16 warnings
  net: macb: fix __be32 warnings in debug code

 drivers/net/ethernet/cadence/macb_main.c | 25 +++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.40.1


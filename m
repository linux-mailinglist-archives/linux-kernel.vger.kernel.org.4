Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5D7384CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjFUNUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjFUNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:20:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA81BD3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2710614E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6428C433C0;
        Wed, 21 Jun 2023 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687353629;
        bh=EvfQzddAVDTvwMs5fXz8sldsDD178CwSmoCdl+xtBe0=;
        h=From:To:Cc:Subject:Date:From;
        b=GJ4B2Z+Wwal82mixJjmq17dIOv9ARWXvQ/6TCjk360D/VtbQhYvDrcMwP0pgbos8l
         iL7nW6MOak06TIDzPUblH3wb+bg/1qa4iQbk3FCDs6dom/arlI3tHbmUKG1RnRsSzN
         wDczDKndNz9qkTHp6LFFnB5D3PerGVuDfsmMLjd3LIPeoLLKVHAhKJRKZ5jG/hOo0u
         vZ7UaN2oMn7Vsf/2l4tTdVoBe+oGMC17iFmW09ZoGWnqptn52iN9L/sEPbMF3Q3z4V
         5UNi/ADl981hdirk6IagpqQ6Kk+y2y7yFXjrY0uOXNQMVq6dq4fgceuY1kHUAGFjqf
         ZBJASSxalrtHg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.4-rc7
Date:   Wed, 21 Jun 2023 14:20:16 +0100
Message-Id: <20230621132028.E6428C433C0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44e46572f0bae431a6092e3cfd2f47bff8b8d18c:

  regmap: regcache: Don't sync read-only registers (2023-06-13 13:15:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc7

for you to fetch changes up to c8e796895e2310b6130e7577248da1d771431a77:

  regmap: spi-avmm: Fix regmap_bus max_raw_write (2023-06-20 21:31:08 +0100)

----------------------------------------------------------------
regmap: One more fix for v6.4

The earlier fix to take account of the register data size when limiting
raw register writes exposed the fact that the Intel AVMM bus was
incorrectly specifying too low a limit on the maximum data transfer, it
is only capable of transmitting one register so had set a transfer size
limit that couldn't fit both the value and the the register address into
a single message.

----------------------------------------------------------------
Russ Weight (1):
      regmap: spi-avmm: Fix regmap_bus max_raw_write

 drivers/base/regmap/regmap-spi-avmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

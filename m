Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE17D6B0E15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjCHQEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjCHQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:03:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9716ACF;
        Wed,  8 Mar 2023 08:01:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18519B81D50;
        Wed,  8 Mar 2023 16:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D9C433EF;
        Wed,  8 Mar 2023 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678291302;
        bh=k/NR/Mngb8VfJOYI8XBPJ62M7b3AcBWHBox3rcvy9gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGvk7yJwPpliK7ycm9ReoXSp2YZNu1H6IZhoAI18KNFEaHMi9u2tLO+cbdIsh6tfC
         cz7uAebUkNI7Nnd/a7FB4YiTA4hzTLxL5WhlRXTXub2EydKuxt4G8jSPdQBm9L50pM
         bdH9KkrbTllg8sVS3Ug+pFpXbzcxcSk+yw6OdaRMGjdipe92Z/JxYP2sB/bVsuJhjj
         /LRI7PutTRfjNAZUcOTBxGl3Tg+IG9iCmEdBo89dcYpsHAeENaRPzmA1UtUA/iwo9u
         76MbquRMZTcFi009dUBa6Fcq/L/sNtCp7beXt706wrfijIyRa9tOJXx3BTHYDVX08K
         zIszuRY6Ad/jw==
Date:   Wed, 8 Mar 2023 09:01:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE() macro
Message-ID: <20230308160140.GA2347814@dev-arch.thelio-3990X>
References: <20230302014639.297514-1-saravanak@google.com>
 <CACRpkdacG4yxtZqwG5hKRY_8nY9qWeNPb-ZttMCnFH7ojZ3kCA@mail.gmail.com>
 <CAGETcx-W3o=rQoVLnKkvk=oTAMiwEcqAZ_trcMPBuune-7Hoiw@mail.gmail.com>
 <32edd2dd9557b7e3debbd8f1bccccd8d.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32edd2dd9557b7e3debbd8f1bccccd8d.sboyd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 11:15:54AM -0800, Stephen Boyd wrote:
> Quoting Saravana Kannan (2023-03-03 13:24:00)
> > On Thu, Mar 2, 2023 at 5:14 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > Works like a charm on U8500!
> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Stephen, Does this look good? Can we have Greg pull this in?
> > 
> 
> I picked it up for fixes. Will send it off later this week.

This change causes a build regression:

  drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
  CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
  ^
  include/linux/clk-provider.h:1367:21: note: expanded from macro 'CLK_OF_DECLARE'
          static void __init name##_of_clk_init_declare(struct device_node *np) \
                             ^
  <scratch space>:124:1: note: expanded from here
  98dx1135_clk_of_clk_init_declare
  ^
  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                          ^
  <scratch space>:125:3: note: expanded from here
  98dx1135_clk_of_clk_init_declare
    ^
  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                          ^
  <scratch space>:125:3: note: expanded from here
  98dx1135_clk_of_clk_init_declare
    ^
  drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
  include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
          OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                          ^
  <scratch space>:125:3: note: expanded from here
  98dx1135_clk_of_clk_init_declare
    ^
  4 errors generated.

The clock's name starts with a number, resulting in an invalid C
function name. Are clock names ABI? Should this be fixed by adjusting
the name like so or adjusting where the name appears in the function
defined by CLK_OF_DECLARE()?

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 8bc893df4736..5d0a7e3bfde5 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -355,5 +355,5 @@ CLK_OF_DECLARE(kirkwood_clk, "marvell,kirkwood-core-clock",
 	       kirkwood_clk_init);
 CLK_OF_DECLARE(mv88f6180_clk, "marvell,mv88f6180-core-clock",
 	       kirkwood_clk_init);
-CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
+CLK_OF_DECLARE(mv98dx1135_clk, "marvell,mv98dx1135-core-clock",
 	       kirkwood_clk_init);

Cheers,
Nathan

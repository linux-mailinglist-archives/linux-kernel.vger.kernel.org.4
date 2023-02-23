Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA946A00B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjBWBhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjBWBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:37:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852932E0D8;
        Wed, 22 Feb 2023 17:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ioIf77uX6u51Hpem+s6k528TPjHbR7wZpcQo8CQSX2c=; b=BfwQVPrt+VHU88/TvunqKA0eNJ
        +Vsz0I+aBA6H4TotTtaskQoudUbCgO61nOI+WWZm8imy/sXi0H5VPXlJ/nRolnvWFytRc5ReuRBZN
        G76plXXMQHPKwAmCfA0AamWJslU8otqhdGXKx+MwjvoW33X6LIsySMXzCcRlwp8FUNHa2IieoX1Sg
        MiBw0DlJl8WatgeNhzFztEo1OHZXgJ34xmBgGHAW0a5lE2WRcEwvm+lYegr2ju+e+vJa6/TpxXlPA
        +MEvUuHYX94xBGn2M/oUg2YB8K2Wh1OiGNGvrhl+n6NPqPqUB5Lk5M8GKuAlpmyyYRhQWFPP/pNcR
        FpiuggNQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV0XZ-00EfLI-DV; Thu, 23 Feb 2023 01:36:57 +0000
Date:   Wed, 22 Feb 2023 17:36:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/27] kbuild, clk: bcm2835: remove MODULE_LICENSE in
 non-modules
Message-ID: <Y/bDOeY+O6KsJFNw@bombadil.infradead.org>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-12-nick.alcock@oracle.com>
 <bdac18adf87f3b03104c16b7c0caaf8a.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdac18adf87f3b03104c16b7c0caaf8a.sboyd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 03:43:40PM -0800, Stephen Boyd wrote:
> Quoting Nick Alcock (2023-02-22 04:14:37)
> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > are used to identify modules. As a consequence, uses of the macro
> > in non-modules will cause modprobe to misidentify their containing
> > object file as a module when it is not (false positives), and modprobe
> > might succeed rather than failing with a suitable error message.
> > 
> > So remove it in the files in this commit, none of which can be built as
> > modules.
> > 
> > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: linux-modules@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Ray Jui <rjui@broadcom.com>
> > Cc: Scott Branden <sbranden@broadcom.com>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-rpi-kernel@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> Unless you want me to pick this up?

Up to you, you can pick it up, and by rc3 of the next kernel I pick up
the last stragglers that no one picks up as reflected on linux-next.

  Luis

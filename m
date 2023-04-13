Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663C6E164F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDMVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDMVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:04:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A1093C0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lWHvvlZBi8wuHY5YcSEWxlnVkh/RZd3Sjjp43kSWVsI=; b=tTt8w1Hfa/1lY2LeASbReZddgw
        byAxRIaM7SeY9pUI/gmTNckPYuRh9SnLHqrKrsh0iGZfykTQ4xNnuDx8xtAi28zBpAGFYd2XEIjdL
        wx2zJ0gjdNfbNO7hPhl6h6YN+wSQvEzRBejmipxiq2uUoDJY0oz9yHhF0x2zAZiSlVlHpAAuCMR93
        PSnAMy60ihcOR052VJmT3YOT2oWoTwTOrLQHEqrzjdLe/abwHU9b6nYlo3X36ujWSfkOoaLyAJmnh
        wqP2pICuY+3kmx853TOB3EESO0DDzJ6z2VRGx3+EQRrHrpvZbg1hLYbPWsMTEHXDoEFvtrYAf1l0Q
        3/xrjFaA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn47d-0079VV-0n;
        Thu, 13 Apr 2023 21:04:49 +0000
Date:   Thu, 13 Apr 2023 14:04:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, jan.kiszka@siemens.com,
        kbingham@kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, song@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2] scripts/gdb: use mem instead of core_layout to get
 the module address
Message-ID: <ZDhucb/0lOTlaI0Y@bombadil.infradead.org>
References: <CGME20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b@eucas1p2.samsung.com>
 <20230412202516.1027149-1-p.raghav@samsung.com>
 <ZDdSd8iB2n6r/ccB@bombadil.infradead.org>
 <aed50785-3eaf-3e5c-d208-5e5ccbc51096@samsung.com>
 <168139365042.2373830.5173244303178460397@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168139365042.2373830.5173244303178460397@Monstersaurus>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:47:30PM +0100, Kieran Bingham wrote:
> Quoting Pankaj Raghav (2023-04-13 08:44:38)
> > On 2023-04-13 02:53, Luis Chamberlain wrote:
> > > On Wed, Apr 12, 2023 at 10:25:18PM +0200, Pankaj Raghav wrote:
> > >> commit ac3b43283923 ("module: replace module_layout with module_memory")
> > >> changed the struct module data structure from module_layout to
> > >> module_memory. The core_layout member which is used while loading
> > >> modules are not available anymore leading to the following error while
> > >> running gdb:
> > >>
> > >> (gdb) lx-symbols
> > >> loading vmlinux
> > >> Python Exception <class 'gdb.error'>: There is no member named core_layout.
> > >> Error occurred in Python: There is no member named core_layout.
> > >>
> > >> Replace core_layout with its new counterpart mem[MOD_TEXT].
> > >>
> > >> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> > >> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > >> ---
> > >>  scripts/gdb/linux/constants.py.in | 3 +++
> > >>  scripts/gdb/linux/modules.py      | 4 ++--
> > >>  scripts/gdb/linux/symbols.py      | 4 ++--
> > >>  3 files changed, 7 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
> > >> index 36fd2b145853..471300ba176c 100644
> > >> --- a/scripts/gdb/linux/constants.py.in
> > >> +++ b/scripts/gdb/linux/constants.py.in
> > >> @@ -62,6 +62,9 @@ LX_GDBPARSED(hrtimer_resolution)
> > >>  LX_GDBPARSED(IRQD_LEVEL)
> > >>  LX_GDBPARSED(IRQ_HIDDEN)
> > >>  
> > >> +/* linux/module.h */
> > >> +LX_GDBPARSED(MOD_TEXT)
> > > 
> > > Should we just fill in the rest of the other sections too while at it?
> > > 
> > 
> > I don't see them used in the scripts. Maybe we can add them when needed?
> 
> I think there's a runtime-cost to getting these constants, as we
> interogate GDB to get the values.
> 
> Because of that, I think values should only be added when required,
> unless the python code is only lazy-evaluating these.

OK thanks, applied and pushed to modules-next.

  Luis

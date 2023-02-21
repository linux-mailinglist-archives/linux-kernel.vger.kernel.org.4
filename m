Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0614669E99E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjBUVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBUVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:39:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC7E2ED74;
        Tue, 21 Feb 2023 13:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=vnOi2tTevcVuma+X66aTaM2tOTxJYqgSiboye8N/D7U=; b=ytB88ZaZcuQ3qU4ecK1s8Vu4HR
        raGQarPUiz+7V780U3VUGVaQ+yq/Mtqr9JjKujgpE+vXUCkCncxY8y58AZ4+4NE1Q6Q41SRRjb2Yo
        0uu4bxR69XnurTljfIDs8f20v4D3opxN74D9vNMNjVh5Tl9WlQBSfWTr5yQV6y/h0kC+OqiyoMiZR
        1Y7WpUJbjlbTJug9GdZcf+OPkzeF1zx6iRa8bnd2y36w5iTrQLhp8s/U57ckJ/QL6Ff72o5Mi4X4x
        XBpaNLqwfpL/dZuEhF1p/tou9MDEMBwCQyOigGCSn9Py6XwTzh+iy5jTQuCkduMLSVPJYnV7zpPgb
        uMkXgeGw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUaMc-009r1R-Rk; Tue, 21 Feb 2023 21:39:54 +0000
Date:   Tue, 21 Feb 2023 13:39:54 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] module: fix MIPS module_layout -> module_memory
Message-ID: <Y/U6KrB6eR4aCmif@bombadil.infradead.org>
References: <20230214005400.17137-1-rdunlap@infradead.org>
 <59c0ba61-c5d6-b74f-0fbd-844b08d13e5d@linaro.org>
 <2e17b8f6-0c2d-e705-63b9-47077b442d68@infradead.org>
 <20230217115812.GB7701@alpha.franken.de>
 <1dac9eee-f0b9-a6f0-9fed-359242ccb02e@linaro.org>
 <e68c3825-fc8a-d607-1afe-543a4537a81c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e68c3825-fc8a-d607-1afe-543a4537a81c@infradead.org>
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

On Fri, Feb 17, 2023 at 07:53:17AM -0800, Randy Dunlap wrote:
> 
> 
> On 2/17/23 04:35, Philippe Mathieu-Daudé wrote:
> > On 17/2/23 12:58, Thomas Bogendoerfer wrote:
> >> On Tue, Feb 14, 2023 at 08:52:04AM -0800, Randy Dunlap wrote:
> >>>
> >>>
> >>> On 2/13/23 23:22, Philippe Mathieu-Daudé wrote:
> >>>> Hi Randy,
> >>>>
> >>>> On 14/2/23 01:54, Randy Dunlap wrote:
> >>>>> Correct the struct's field/member name from mod_mem to mem.
> >>>>>
> >>>>> Fixes this build error:
> >>>>> ../arch/mips/kernel/vpe.c: In function 'vpe_elfload':
> >>>>> ../arch/mips/kernel/vpe.c:643:41: error: 'struct module' has no member named 'mod_mem'
> >>>>>     643 |         v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
> >>>>>
> >>>>> Fixes: 2ece476a2346 ("module: replace module_layout with module_memory")
> >>>>
> >>>> On which tree is your patch based?
> >>>
> >>> linux-next-20230213.
> >>
> >> so I can't apply, because this is not in mips-next tree. It should be
> >> applied to the tree, where this commit is coming from.
> > 
> > Or squashed...
> > 
> 
> Sure, either one of those. I copied Song and Luis on the patch
> and it begins with "module:".
> 
> @Song !??
> @Luis !??

Thanks!

I've queued this up onto modules-next. That patch which changes the
layout won't go in on this merge window so it will all sit and bake
for a good long while before it gets upstream.

  Luis

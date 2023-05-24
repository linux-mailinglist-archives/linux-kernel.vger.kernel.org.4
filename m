Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39D70F12B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjEXIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbjEXIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B410E3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874C863A9B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0280EC4339B;
        Wed, 24 May 2023 08:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684917353;
        bh=kbD8GySk4t92OZQxFzt3j7NVUVYR3jwkepDeRGqlkns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KA2hy76eYBOkYRdNyfrfTOndEMZe3ddoylPYtsr0tbNn/AiA6HDYy6/lOq1oSP+AX
         mqR57czakHxfgUm21fcNL/P4aGsa1F2JpIfT7N/9P0m4odL0eiUVP94C1TrDyEvZHv
         x5/Qb1lhahgoE9fecW2zfNB8RZLNFstxJ9ec4Kh9U+7E8TR7D4IEfskosS6UqHfDDN
         8BX3YYpmSugoKTioX/2aKnZKZFG0gk7wyatiusCFaCUrcueI/Vjpv2AGAtgfmnIns7
         33SUtxZtnbPAz6ck8OWg7wW7e4pU1uBpqc8iADWg+A+lAg7hrJzA8FwqX1FyQ6h9/e
         39X8WHC0UwoIg==
Date:   Wed, 24 May 2023 11:35:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yuwei Guan <ssawgyw@gmail.com>, akpm@linux-foundation.org,
        tsahu@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memblock: Add flags and nid info in memblock debugfs
Message-ID: <20230524083534.GK4967@kernel.org>
References: <20230519105321.333-1-ssawgyw@gmail.com>
 <20230523160539.GH4967@kernel.org>
 <323ae5c0-8cb1-6ca8-a16f-541c1765a2e3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <323ae5c0-8cb1-6ca8-a16f-541c1765a2e3@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:42:40AM +0530, Anshuman Khandual wrote:
> On 5/23/23 21:35, Mike Rapoport wrote:
> > Hi,
> > 
> > On Fri, May 19, 2023 at 06:53:21PM +0800, Yuwei Guan wrote:
> >> Currently, the memblock debugfs can display the count of memblock_type and
> >> the base and end of the reg. However, when memblock_mark_*() or
> >> memblock_set_node() is executed on some range, the information in the
> >> existing debugfs cannot make it clear why the address is not consecutive.
> >>
> >> For example,
> >> cat /sys/kernel/debug/memblock/memory
> >>    0: 0x0000000080000000..0x00000000901fffff
> >>    1: 0x0000000090200000..0x00000000905fffff
> >>    2: 0x0000000090600000..0x0000000092ffffff
> >>    3: 0x0000000093000000..0x00000000973fffff
> >>    4: 0x0000000097400000..0x00000000b71fffff
> >>    5: 0x00000000c0000000..0x00000000dfffffff
> >>    6: 0x00000000e2500000..0x00000000f87fffff
> >>    7: 0x00000000f8800000..0x00000000fa7fffff
> >>    8: 0x00000000fa800000..0x00000000fd3effff
> >>    9: 0x00000000fd3f0000..0x00000000fd3fefff
> >>   10: 0x00000000fd3ff000..0x00000000fd7fffff
> >>   11: 0x00000000fd800000..0x00000000fd901fff
> >>   12: 0x00000000fd902000..0x00000000fd909fff
> >>   13: 0x00000000fd90a000..0x00000000fd90bfff
> >>   14: 0x00000000fd90c000..0x00000000ffffffff
> >>   15: 0x0000000880000000..0x0000000affffffff
> >>
> >> So we can add flags and nid to this debugfs.
> >>
> >> For example,
> >> cat /sys/kernel/debug/memblock/memory
> >>    0: 0x0000000080000000..0x00000000901fffff    0 NONE
> >>    1: 0x0000000090200000..0x00000000905fffff    0 NOMAP
> >>    2: 0x0000000090600000..0x0000000092ffffff    0 NONE
> >>    3: 0x0000000093000000..0x00000000973fffff    0 NOMAP
> >>    4: 0x0000000097400000..0x00000000b71fffff    0 NONE
> >>    5: 0x00000000c0000000..0x00000000dfffffff    0 NONE
> >>    6: 0x00000000e2500000..0x00000000f87fffff    0 NONE
> >>    7: 0x00000000f8800000..0x00000000fa7fffff    0 NOMAP
> >>    8: 0x00000000fa800000..0x00000000fd3effff    0 NONE
> >>    9: 0x00000000fd3f0000..0x00000000fd3fefff    0 NOMAP
> >>   10: 0x00000000fd3ff000..0x00000000fd7fffff    0 NONE
> >>   11: 0x00000000fd800000..0x00000000fd901fff    0 NOMAP
> >>   12: 0x00000000fd902000..0x00000000fd909fff    0 NONE
> >>   13: 0x00000000fd90a000..0x00000000fd90bfff    0 NOMAP
> >>   14: 0x00000000fd90c000..0x00000000ffffffff    0 NONE
> >>   15: 0x0000000880000000..0x0000000affffffff    0 NONE
> >>
> >> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> >> ---
> >> v4:
> >> - show string value for each memblock flag
> >> ---
> >>  mm/memblock.c | 24 ++++++++++++++++++++++--
> >>  1 file changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index 511d4783dcf1..10d0ddbeebc1 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -2136,12 +2136,19 @@ void __init memblock_free_all(void)
> >>  }
> >>  
> >>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> >> +static const char * const flagname[] = {
> >> +	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> >> +	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
> >> +	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> >> +	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> >> +};
> >>  
> >>  static int memblock_debug_show(struct seq_file *m, void *private)
> >>  {
> >>  	struct memblock_type *type = m->private;
> >>  	struct memblock_region *reg;
> >> -	int i;
> >> +	int i, j;
> >> +	unsigned int count = ARRAY_SIZE(flagname);
> >>  	phys_addr_t end;
> >>  
> >>  	for (i = 0; i < type->cnt; i++) {
> >> @@ -2149,7 +2156,20 @@ static int memblock_debug_show(struct seq_file *m, void *private)
> >>  		end = reg->base + reg->size - 1;
> >>  
> >>  		seq_printf(m, "%4d: ", i);
> >> -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> >> +		seq_printf(m, "%pa..%pa ", &reg->base, &end);
> >> +		seq_printf(m, "%4d ", memblock_get_region_node(reg));
> >> +		if (reg->flags) {
> >> +			for (j = 0; j < count; j++) {
> >> +				if (reg->flags & (1U << j)) {
> >> +					seq_printf(m, "%s\n", flagname[j]);
> >> +					break;
> > 
> > The flags are mostly mutually exclusive because it's unlikely they are used
> > together, but not because there are some restrictions on possible flags
> > combinations. So generally it's possible to have multiple flags set on the
> > same region.
> 
> But do we really need to account for that as of now, when no memblock region
> carries more than a single flag ?

Right now we don't care indeed, I'm a bit concerned of what will happen if
we'd have regions with multiple flags set.

> But in that case all flags here need to be printed with "|" in between ?
 
We could use space rather than "|" for simplicity, but thinking more about
it, I'm inclined to just take this version and we'll deal with multiple
flags if/when required.

> > Sorry, I missed that in v3.
> > 
> >> +				}
> >> +			}
> >> +			if (j == count)
> >> +				seq_printf(m, "%s\n", "UNKNOWN");
> >> +		} else {
> >> +			seq_printf(m, "%s\n", "NONE");
> >> +		}
> >>  	}
> >>  	return 0;
> >>  }
> >> -- 
> >> 2.34.1
> >>
> > 

-- 
Sincerely yours,
Mike.

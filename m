Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F3706A18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEQNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEQNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F159C9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122AF61077
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A48C4339B;
        Wed, 17 May 2023 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684330947;
        bh=Vl7/xGCMjGm7dBBBvSimFFnqjAVwiGrWBbtqILvy0z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1tQQ12gARaIbGtqJKLM1xh/nNHWY3En2nO5yUCtYrRpbIN479qk10Ze8qHBGqKLr
         1oxkP+BzE8FloEccxCeDfIi3idbMJrqklh7LGOHV5EgKTlzWoEho0+77MliY5KxJkv
         p20oHaSS2mWO0F+jH8tCO7jwWZRirOE40/5rJVc23AcMdEQTj8H7iHXeHLDYThKEvi
         fO6SBSjFqut0TbmO6sF63UwioF8NrlMQspHtIdjgIncH/1ruypUsQM/Nwx7R1hgPAg
         p+tFeaWKerVJumdssw13WXYyMUtFJ61zianwjYEfIAJDOh1vwgKs+thhIYxtkgltCH
         E4kUq+AKDdNtw==
Date:   Wed, 17 May 2023 16:42:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yuwei Guan <ssawgyw@gmail.com>, akpm@linux-foundation.org,
        tsahu@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock: Add flags and nid info in memblock debugfs
Message-ID: <ZGTZvbpweJMPAwu3@kernel.org>
References: <20230517025747.230-1-ssawgyw@gmail.com>
 <52fa3a4f-5467-7b68-334c-4280d3925b39@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52fa3a4f-5467-7b68-334c-4280d3925b39@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:37:25AM +0530, Anshuman Khandual wrote:
> 
> On 5/17/23 08:27, Yuwei Guan wrote:
> > Currently, the memblock debugfs can display the count of memblock_type and
> > the base and end of the reg. However, when the following scenario occurs,
> 
> scenarios where the memblock flags or nid varies inside a single PA range ?
> I guess the commit message description here can be improved to accommodate
> such details.
> 
> > the information in the existing debugfs cannot make it clear why the
> > address is not consecutive.
> > 
> > For example,
> > cat /sys/kernel/debug/memblock/memory
> >    0: 0x0000000080000000..0x00000000901fffff
> >    1: 0x0000000090200000..0x00000000905fffff
> >    2: 0x0000000090600000..0x0000000092ffffff
> >    3: 0x0000000093000000..0x00000000973fffff
> >    4: 0x0000000097400000..0x00000000b71fffff
> >    5: 0x00000000c0000000..0x00000000dfffffff
> >    6: 0x00000000e2500000..0x00000000f87fffff
> >    7: 0x00000000f8800000..0x00000000fa7fffff
> >    8: 0x00000000fa800000..0x00000000fd3effff
> >    9: 0x00000000fd3f0000..0x00000000fd3fefff
> >   10: 0x00000000fd3ff000..0x00000000fd7fffff
> >   11: 0x00000000fd800000..0x00000000fd901fff
> >   12: 0x00000000fd902000..0x00000000fd909fff
> >   13: 0x00000000fd90a000..0x00000000fd90bfff
> >   14: 0x00000000fd90c000..0x00000000ffffffff
> >   15: 0x0000000880000000..0x0000000affffffff
> > 
> > So we can add flags and nid to this debugfs.
> > 
> > For example,
> > cat /sys/kernel/debug/memblock/memory
> > cnt     base..end       flags   nid
> 
> These markers ^^^ are not aligned properly, and also might not be
> required as well.
> 
> > 0:      0x0000000080000000..0x00000000901fffff  0x0     0x0
> > 1:      0x0000000090200000..0x00000000905fffff  0x4     0x0
> > 2:      0x0000000090600000..0x0000000092ffffff  0x0     0x0
> > 3:      0x0000000093000000..0x00000000973fffff  0x4     0x0
> > 4:      0x0000000097400000..0x00000000b71fffff  0x0     0x0
> > 5:      0x00000000c0000000..0x00000000dfffffff  0x0     0x0
> > 6:      0x00000000e2500000..0x00000000f87fffff  0x0     0x0
> > 7:      0x00000000f8800000..0x00000000fa7fffff  0x4     0x0
> > 8:      0x00000000fa800000..0x00000000fd3effff  0x0     0x0
> > 9:      0x00000000fd3f0000..0x00000000fd3fefff  0x4     0x0
> > 10:     0x00000000fd3ff000..0x00000000fd7fffff  0x0     0x0
> > 11:     0x00000000fd800000..0x00000000fd901fff  0x4     0x0
> > 12:     0x00000000fd902000..0x00000000fd909fff  0x0     0x0
> > 13:     0x00000000fd90a000..0x00000000fd90bfff  0x4     0x0
> > 14:     0x00000000fd90c000..0x00000000ffffffff  0x0     0x0
> > 15:     0x0000000880000000..0x0000000affffffff  0x0     0x0
> > 
> > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> > Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>
> > ---
> >  mm/memblock.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 511d4783dcf1..b36fb6b31e0f 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2144,12 +2144,16 @@ static int memblock_debug_show(struct seq_file *m, void *private)
> >  	int i;
> >  	phys_addr_t end;
> >  
> > +	seq_puts(m, "cnt\tbase..end\tflags\tnid\n");
> 
> Please drop this.
> 
> > +
> >  	for (i = 0; i < type->cnt; i++) {
> >  		reg = &type->regions[i];
> >  		end = reg->base + reg->size - 1;
> >  
> > -		seq_printf(m, "%4d: ", i);
> > -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> > +		seq_printf(m, "%d:\t", i);
> 
> Why drop the existing %4d formatting qualifier ?
> 
> > +		seq_printf(m, "%pa..%pa\t", &reg->base, &end);
> > +		seq_printf(m, "0x%x\t", reg->flags);
> 
> Should there be ORed string values for each memblock flag ?
> 
> enum memblock_flags {
>         MEMBLOCK_NONE           = 0x0,  /* No special request */
>         MEMBLOCK_HOTPLUG        = 0x1,  /* hotpluggable region */
>         MEMBLOCK_MIRROR         = 0x2,  /* mirrored region */
>         MEMBLOCK_NOMAP          = 0x4,  /* don't add to kernel direct mapping */
>         MEMBLOCK_DRIVER_MANAGED = 0x8,  /* always detected via a driver */
> };
> 
> Something like NN | HT | MR | NM | DM ?

These are not less cryptic than numbers :)
Most of them are mutually exclusive, so maybe just spell them out fully,
just shorten DRIVER_MANAGED to DRV_MNG?
And make the flags dump the last to keep columns nicely aligned.
 
> > +		seq_printf(m, "0x%x\n", memblock_get_region_node(reg));
> >  	}
> >  	return 0;
> >  }

-- 
Sincerely yours,
Mike.

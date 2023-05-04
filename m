Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2266F6E98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjEDPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEDPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2D10E3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B19B3634EE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70763C4339B;
        Thu,  4 May 2023 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683212783;
        bh=DMsgKT7Hobbpb3BzXsLG/oHKtAFZ7Ra+fFw7O52RNaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qM7HY1iXLzguQbimslGp8ie6mm17bBCpAMNs7DebyuqV0StfXJi+VdYDhzpYm5Vfh
         3Ma4D5HvQAB2YoNd7bXQ3kgiR+kxCgOJAsYEwbWso+m3wYY04zlGjF73es/OhdEPBu
         /YNMSDfGxxSMilZcVRUUWBMLxQp7PRkgTmHVwKgbE5+/Tt8lgw0ZEb2iCtWSlpjo3b
         a4wEnXTM9nDVaGRGqIS3923eAEwYk+Ib6dzbzJXJMafOZpn6ynadERdbDHhyy/eVUv
         Clvcl/tKs9X3mZs5bXQV4abkMQFtEATKH+u0S3tt30o6V5453muBBOeIN5MVc3B683
         bJVHgfmRqohKg==
Date:   Thu, 4 May 2023 09:06:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "jiweisun126@126.com" <jiweisun126@126.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "ahuang12@lenovo.com" <ahuang12@lenovo.com>,
        "sunjw10@lenovo.com" <sunjw10@lenovo.com>
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Message-ID: <ZFPJ7CYFEextnOqE@kbusch-mbp.dhcp.thefacebook.com>
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
 <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
 <ZFN9aWYCxJW/HdHi@x1-carbon>
 <ZFOFHv8Kh/7KLuBa@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFOFHv8Kh/7KLuBa@x1-carbon>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 10:12:46AM +0000, Niklas Cassel wrote:
> On Thu, May 04, 2023 at 11:39:53AM +0200, Niklas Cassel wrote:
> > 
> > Something is fishy here...
> > 
> > (Perhaps the maintainer did a git revert instead of applying the fix...
> > and accidentally squashed the revert with a proper commit...
> > But even that does not make sense, as there simply seems to be too many
> > lines changed in 2d55c16c0c54 ("dmapool: create/destroy cleanup") for that
> > to be the case...)
> 
> It seems like the additional lines in
> 2d55c16c0c54 ("dmapool: create/destroy cleanup") is explained by the
> maintainer (probably accidentally) reverting additional patches in that
> very same commit.
> 
> It seems like that commit reverted all changes to mm/dmapool.c since v6.3:

Spot on, thanks for confirming! Somehow a series revert was squahed into
the final patch. :(

We reached the same conclusion pretty late yesterday, so I'll wait for
Andrew to suggest how to proceed. I think we have to rebase whole series
with the correct final patch and resend the pull.
 
> $ git log --oneline 2d55c16c0c54325bf15286cfa6ba6c268036b9e4 --not v6.3 mm/dmapool.c 
> 2d55c16c0c54 dmapool: create/destroy cleanup
> a4de12a032fa dmapool: link blocks across pages
> 9d062a8a4c6d dmapool: don't memset on free twice
> 887aef615818 dmapool: simplify freeing
> 2591b516533b dmapool: consolidate page initialization
> 36d1a28921a4 dmapool: rearrange page alloc failure handling
> 52e7d5653979 dmapool: move debug code to own functions
> 19f504584038 dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
> 347e4e44c0a9 dmapool: cleanup integer types
> 65216545436b dmapool: use sysfs_emit() instead of scnprintf()
> 7f796d141c07 dmapool: remove checks for dev == NULL
> 
> 
> $ git diff v6.3 2d55c16c0c54325bf15286cfa6ba6c268036b9e4 mm/dmapool.c
> <nothing>
> 
> 
> Should probably tell Andrew so that he has time to send out a new PR
> before the merge window closes. (I added him in To: .)
> 
> He should probably pick up this fix too:
> https://patchwork.kernel.org/project/linux-mm/patch/20230221165400.1595247-1-kbusch@meta.com/

Andrew actually squashed that fix into the original patch.

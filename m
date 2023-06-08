Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA12727C83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjFHKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjFHKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127CB2D54
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8987064BBE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5BC433EF;
        Thu,  8 Jun 2023 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686219246;
        bh=A/yf/LULqe7cvpY9FNQQv9+HJYr9a5XLS/1CEJh4cUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCr1Wl0YP84wvIO2VnanRSDJFX8gKazY0fIbIaQQpeY8GwiC4hJKVKNwtW0q4LCzf
         t93zJ1seq5bE9yZRw83p/S4eY8irVRPlLZHE4zT70ZBfYBB8OH/X3eb29hyfK3F353
         XbqPetAS+vr27HRFX6ytssh7f8WeSAZBa142EB+1TSWnufkB3VYtvjcFHm/6n9j9GZ
         jczUfeXFIjQA7EBXdX7DCGVMTVFYZ+tnHcgOjGY6svebxlSssNpgVxMIwRUPbwu7Dc
         NLTXt4JHsFOjeQllk02r4Aoh9kBaJnSVJN2MLSjmPTVdPELaClUG4Na86StyoAV/Jw
         Vnae3p4wKE9HA==
Date:   Thu, 8 Jun 2023 13:13:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Haifeng Xu <haifeng.xu@shopee.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
Message-ID: <20230608101340.GI52412@kernel.org>
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
 <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
 <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
 <34f32148-24c3-09a3-8bec-9515139e15b1@shopee.com>
 <ZIGcyku+DN5IHtwp@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIGcyku+DN5IHtwp@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 11:18:02AM +0200, Michal Hocko wrote:
> On Thu 08-06-23 15:38:48, Haifeng Xu wrote:
> > 
> > 
> > On 2023/6/7 18:22, David Hildenbrand wrote:
> > > On 07.06.23 12:16, Michal Hocko wrote:
> > >> On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
> > >>> If freesize is less than dma_reserve, print warning message to report
> > >>> this case.
> > >>
> > >> Why?
> > > 
> > > I'd like to second that question, and add
> > > 
> > > a) Did you run into that scenario?
> > > b) What can an admin do in that case with that error messages?
> > 
> > In theory，dma_reserve shouldn't exceed freesize, so the error messages can remind us
> > to verify whether the configuration of reserved memory is correct.
> 
> I am not really convinced this is worth touching the code TBH.

The only architecture that sets the dma_reserve is x86_64 and it sets it to
the number of reserved pages in DMA zone. There is no way freesize will be
less than dma_reserve.

I'm not sure that in general dma_reserve has some value now, but that's a
completely different story.

> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.

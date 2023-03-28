Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8D6CC9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjC1RxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjC1Rwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C9D10ABE;
        Tue, 28 Mar 2023 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wb/aIRtlfC2C3jG+RF0MsyFF/Fo2UynqeVSoO8JS/Z0=; b=BDH7Jj9zHHGqSkhzkUwbaaJTaW
        zZy0Vq0AElAfWug2nRqiMnGVybq1k70DD/aaH6okrYWFkTIv58te1zfU4gbF8VBfWiWOxlQXLEQM8
        tX8GW/0V0/YTCadI4GWiZ3y3NH59ZkeHPwCIEp5wYvVpI84TYiueVZZcCclEJ+Qevtd5/PZBxwNmN
        MKI68BLlJBNkZxDJiWdTMuy/+QSHYMnHJm8vnEe3gQFrrwkhrxAjmrrLIBvicGUDRJk3uYNor1zJT
        /jscjKxMdGcJzWdEOi68Vi+mwxb9uli63bpK9iF2Ygt/i08hqTWhLnn8LqDyU1MbfhdqFztuKM3yP
        HQBq/oSQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phDUO-00FNLk-0Q;
        Tue, 28 Mar 2023 17:52:08 +0000
Date:   Tue, 28 Mar 2023 10:52:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-modules@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Message-ID: <ZCMpSJzXg/+JSHNY@bombadil.infradead.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
 <ZCMDmHSqOeCj1EIo@kernel.org>
 <CAB=NE6UTC4VkNM57GGJ3XkG_PWLkMfXv2e2=yQJhtM6Fc-uMsQ@mail.gmail.com>
 <ZCMlyUewrAjTBb5i@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMlyUewrAjTBb5i@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:37:13PM +0100, Matthew Wilcox wrote:
> On Tue, Mar 28, 2023 at 10:18:50AM -0700, Luis Chamberlain wrote:
> > differences with eBPF programs is that modules *can* be rather large
> > in size. What is the average size of modules? Well let's take a look:
> > 
> > mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
> > -name \*.ko| wc -l
> > 9173
> 
> ummm ... wc -c, surely?

That's the number of allmodconfig modules found.

mcgrof@fulton ~/linux (git::sysctl-next)$ find ./ -name \*.ko| head -2
./arch/x86/crypto/twofish-x86_64.ko
./arch/x86/crypto/serpent-avx2.ko
mcgrof@fulton ~/linux (git::sysctl-next)$ find ./ -name \*.ko| head -2 |
wc -l
2
mcgrof@fulton ~/linux (git::sysctl-next)$ find ./ -name \*.ko| head -2 |
wc -c
70

wc -c would give a lot more. wc -l gives me the module count.

> > mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
> > -name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
> > -$((9173-5)) | awk 'BEGIN {sum=0} {sum+=$1} END {print sum/NR/1024}'
> > 160.54
> 
> ... which invalidates all of these.

Not sure ? But regardless the *.text* lookup is what we care for though
which was later.

  Luis

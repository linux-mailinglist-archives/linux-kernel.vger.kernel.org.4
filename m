Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F536CC972
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC1RiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjC1Rhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:37:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B0D50B;
        Tue, 28 Mar 2023 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c7ay3PzfLUlKczzYKFS0hIWxG5cR/FUCy4TCuFGv3qg=; b=PeenjWv1jMr3I+rMLnHAOXi8Ov
        LpHwi74bFLig9FY8+yCpUh5rs4nDlcpMFFb/PK6vIz7iga4gtSTxpW+2RAZXIIML3GWHgZ0cE0Glv
        2BjSFL7OS7hk0QmHUjjRT+u62r95HSe3G31uOvz6fv0UgkQ+EJcPtrY+TvqRS0J52ciZl8nC7eR8V
        iXYAsHhqjmj6IH4hVi6V1WIs4zyrbh2weILUMkDfuUU0/yb0K6ySz7HzDlyYCmvK8LHuLbsW3GRyw
        0RPJvWB8LsA1xKCLyzMLB621XHfks0lbQa69mKbudJShGX860rTEOWYlgtAGoe3QD4EcCxpz58HHC
        6SXRMklQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phDFx-008d3L-CI; Tue, 28 Mar 2023 17:37:13 +0000
Date:   Tue, 28 Mar 2023 18:37:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <ZCMlyUewrAjTBb5i@casper.infradead.org>
References: <20230308094106.227365-1-rppt@kernel.org>
 <20230308094106.227365-2-rppt@kernel.org>
 <ZB1hS9lBabp1K7XN@dhcp22.suse.cz>
 <ZB6W1C88TU6CcjJH@kernel.org>
 <ZCGdf95RvXB1RivU@dhcp22.suse.cz>
 <ZCKIX3de5AZfGggK@kernel.org>
 <ZCKZuXxq38obmYpn@dhcp22.suse.cz>
 <ZCMDmHSqOeCj1EIo@kernel.org>
 <CAB=NE6UTC4VkNM57GGJ3XkG_PWLkMfXv2e2=yQJhtM6Fc-uMsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=NE6UTC4VkNM57GGJ3XkG_PWLkMfXv2e2=yQJhtM6Fc-uMsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:18:50AM -0700, Luis Chamberlain wrote:
> differences with eBPF programs is that modules *can* be rather large
> in size. What is the average size of modules? Well let's take a look:
> 
> mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
> -name \*.ko| wc -l
> 9173

ummm ... wc -c, surely?

> mcgrof@bigtwin /mirror/code/mcgrof/linux-next (git::master)$ find ./
> -name \*.ko|  xargs stat -c "%s - %n" | sort -n -k 1 -r | tail
> -$((9173-5)) | awk 'BEGIN {sum=0} {sum+=$1} END {print sum/NR/1024}'
> 160.54

... which invalidates all of these.

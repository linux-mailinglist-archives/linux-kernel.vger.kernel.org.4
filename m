Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480967754F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjAWG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:57:51 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8513528;
        Sun, 22 Jan 2023 22:57:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C7E668BEB; Mon, 23 Jan 2023 07:57:47 +0100 (CET)
Date:   Mon, 23 Jan 2023 07:57:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        songliubraving@fb.com, Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
Message-ID: <20230123065746.GB30529@lst.de>
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com> <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com> <20230118074047.GA27385@lst.de> <CAPhsuW7zqYgLcWoG1Wr_tBBLt-yiNYq3FLVWYMpMj=6TJawQEg@mail.gmail.com> <20230119053545.GA16775@lst.de> <CAPhsuW5WFEHfGrSW5nYRRohmLMAfWoZiOCBgCdgzOCmn+Q_vVA@mail.gmail.com> <CAPhsuW4snf6cBYSDRbALSNM4OE36-dusir8HQQ90Li7u067ZWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4snf6cBYSDRbALSNM4OE36-dusir8HQQ90Li7u067ZWA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:42:26AM -0800, Song Liu wrote:
> So here are the two versions, both with secondary addr_[min|max] for
> CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC.
> 
> v2. Just use mod_mem array:
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=remotes/song-md/new_module_alloc_build_test_v2
> 
> v3. mod_mem array and the defines:
> #define mod_core_text mod_mem[MOD_MEM_TYPE_TEXT]
> #define mod_core_data mod_mem[MOD_MEM_TYPE_DATA]
> etc.
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=remotes/song-md/new_module_alloc_build_test_v3

I find v2 much preferably.  Having magic layouts with different
access methods is horribly confusing.  It might be a way changes
things if modifying every caller would be intrusive, but starting
out that way does not seem like a very good idea.

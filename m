Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6A675BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjATRms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjATRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:42:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164454F849;
        Fri, 20 Jan 2023 09:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C69962013;
        Fri, 20 Jan 2023 17:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C3C433A1;
        Fri, 20 Jan 2023 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674236560;
        bh=WMahhW6oUd2zW6eBCstPrXu22SWG93RzbfOHBsyIEW8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=guFUxnOCFuHNzVn+ojSHmkOO6vd50slt/V26hSoreOwzXTTcrXI9Ba69r7cXs4eg7
         qI/wt/u9gI0+o3i5/eBONpoa0TtTsENloBmouzjnH9raWWt6wxgKBJ+rqbd1pW4l33
         2oKDcq61uIYNcBCccKZVYUILvcknqp4KXIMIg7aWNa3c3W43+cm+6Z4GQTMvpmnA16
         EynmVv7buelQO3zfpXHrQDWhWhJm+Xm+dHdjRIKXDZchSTPISoToBdc96R40LKnYro
         IjDfkblDblozrSMHnwTnJLpuGlxF43gWG7u8Y7C0pyDKBtaEZjuUb/8sFPhTzfBURg
         Z2NPCOasa/fOg==
Received: by mail-lj1-f175.google.com with SMTP id e16so6297722ljn.3;
        Fri, 20 Jan 2023 09:42:40 -0800 (PST)
X-Gm-Message-State: AFqh2kr3lNF1X/vDmjd21iv+TyhbNw26LgNR/2XaWkj7dpCk5PpI2hYA
        g0a2X+WuHtBLYQts+BLSfXbDziN7kI3QppQUpKg=
X-Google-Smtp-Source: AMrXdXt6Tvta5YOpbskhbejsHqM1dM6W6pAAEg9w/RUcutSgRTCoAvGHEmbj0qZW4G/b0Q3iTkPqWtLG32IMzZe4sRg=
X-Received: by 2002:a2e:a5c4:0:b0:289:1305:680d with SMTP id
 n4-20020a2ea5c4000000b002891305680dmr843375ljp.421.1674236558924; Fri, 20 Jan
 2023 09:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
 <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com>
 <20230118074047.GA27385@lst.de> <CAPhsuW7zqYgLcWoG1Wr_tBBLt-yiNYq3FLVWYMpMj=6TJawQEg@mail.gmail.com>
 <20230119053545.GA16775@lst.de> <CAPhsuW5WFEHfGrSW5nYRRohmLMAfWoZiOCBgCdgzOCmn+Q_vVA@mail.gmail.com>
In-Reply-To: <CAPhsuW5WFEHfGrSW5nYRRohmLMAfWoZiOCBgCdgzOCmn+Q_vVA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 20 Jan 2023 09:42:26 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4snf6cBYSDRbALSNM4OE36-dusir8HQQ90Li7u067ZWA@mail.gmail.com>
Message-ID: <CAPhsuW4snf6cBYSDRbALSNM4OE36-dusir8HQQ90Li7u067ZWA@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        songliubraving@fb.com, Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:29 AM Song Liu <song@kernel.org> wrote:
>
> On Wed, Jan 18, 2023 at 9:35 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jan 18, 2023 at 01:52:51PM -0800, Song Liu wrote:
> > > In this way we can use the array in the for loops, and use mod->core_text,
> > > etc. when we only need to access one of them.
> >
> > Just use the array please instead of making it too ugly.  If that
> > is the only sensible way to iterate we have a good argument for the
> > array and can live with it.
>
> Hmm.. I think it won't be ugly outside of the struct definition...
> Alternatively, how about use something like
>
> #define core_text mod_mem[MOD_MEM_TYPE_TEXT]
> ...
>
> which is similar to
>
> struct sock {
>         /*
>          * Now struct inet_timewait_sock also uses sock_common, so please just
>          * don't add nothing before this first member (__sk_common) --acme
>          */
>         struct sock_common      __sk_common;
> #define sk_node                 __sk_common.skc_node
> #define sk_nulls_node           __sk_common.skc_nulls_node
> ...
> };

So here are the two versions, both with secondary addr_[min|max] for
CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC.

v2. Just use mod_mem array:
https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=remotes/song-md/new_module_alloc_build_test_v2

v3. mod_mem array and the defines:
#define mod_core_text mod_mem[MOD_MEM_TYPE_TEXT]
#define mod_core_data mod_mem[MOD_MEM_TYPE_DATA]
etc.
https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=remotes/song-md/new_module_alloc_build_test_v3

I personally like the v3 better. Please share you
comments on this.

Thanks,
Song

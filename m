Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6607672AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjARVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjARVxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB385EF8C;
        Wed, 18 Jan 2023 13:53:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC8CD619E3;
        Wed, 18 Jan 2023 21:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBDFC433F2;
        Wed, 18 Jan 2023 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674078786;
        bh=odow2u7c9P22z89GlE8wddINSjSouNXYUoKkWII7NXs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h7S4iKaMBVhXD6Mid/6Pu30NLvr5uMEY79CRxCk71ReJWT1+IcfTxD73tCd0r1ErB
         Fgvs4h2CjbLLCZY+w8FTSGYrgg/IVq2CMWwk3udpa6WNaidpuTOMuVKkyZ8QpkcC7U
         Jc8jE86jy3R6c/i0K39ITC/ZVSqDcME5qpQcvRQ+iktW+ekT48JhUD/jkjIuJOxBZC
         jIbxzqV0Zr0wD/nDWOnmHNnlPWjkI2gpHZBwMmcJE+tvC8I5pzCErBHEDKIC6nnNeo
         YbWO9RWctpvm4UZHjuLd9h6SZcl5UL9JL24gitS1atcmFhCNj3qZM9w8totlDZylrv
         Qe1GNOoHEQVug==
Received: by mail-lf1-f43.google.com with SMTP id a11so480505lfg.0;
        Wed, 18 Jan 2023 13:53:06 -0800 (PST)
X-Gm-Message-State: AFqh2kqSyVQcasDJ9X7gdur83yf+VgEIBighmcAvShvtoHzx+08ZDwah
        XoWxorI+szHJq6Nm3yXx5eUR9qu0vwIASWLJRug=
X-Google-Smtp-Source: AMrXdXsIYoPqzlt5WFxkF4QqJmZ9bQ2Owu4F2RyxtPss5r3kOuLu3tPTpBvuDvsbnywwBMCF2DGauDICsmP/lTXxaZY=
X-Received: by 2002:a05:6512:2115:b0:4cb:1d3e:685b with SMTP id
 q21-20020a056512211500b004cb1d3e685bmr476566lfr.126.1674078784233; Wed, 18
 Jan 2023 13:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org> <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
 <CAPhsuW44n8wzx6Ois4hNRWR9S=kB=LL+DqMTtMjAyGY2FVNoUA@mail.gmail.com> <20230118074047.GA27385@lst.de>
In-Reply-To: <20230118074047.GA27385@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Jan 2023 13:52:51 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7zqYgLcWoG1Wr_tBBLt-yiNYq3FLVWYMpMj=6TJawQEg@mail.gmail.com>
Message-ID: <CAPhsuW7zqYgLcWoG1Wr_tBBLt-yiNYq3FLVWYMpMj=6TJawQEg@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 11:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jan 17, 2023 at 10:50:55AM -0800, Song Liu wrote:
> > Hi Thomas and Luis,
> >
> > Could you please share your comments on this? Specifically, is this on
> > the right direction? And, what's your preference with Christophe's
> > suggestions?
> >
> > "I dislike how it looks with enums, things like
> > mod->mod_mem[MOD_MEM_TYPE_INIT
> > _TEXT] are odd and don't read nicely.
> > Could we have something nicer like mod->mod_mem_init_text ?
> > I know it will complicate your for_each_mod_mem_type() but it would look
> > nicer."
>
> FYI, I don't particularly like the array either.  But if it makes
> the code much simpler I can live with it.

How about we do something like this

struct module {
...
        /* rbtree is accessed frequently, so keep together. */
        union {
                struct module_memory mod_mem[MOD_MEM_NUM_TYPES]
__module_memory_align;
                struct {
                        /* keep the same order as enum mod_mem_type */
                        struct module_memory core_text;
                        struct module_memory core_data;
                        struct module_memory core_rodata;
                        struct module_memory core_ro_after_init;
                        struct module_memory init_text;
                        struct module_memory init_data;
                        struct module_memory init_rodata;
                };
        };
...
};

In this way we can use the array in the for loops, and use mod->core_text,
etc. when we only need to access one of them.

Thanks,
Song

PS: Do we need __no_randomize_layout somewhere?

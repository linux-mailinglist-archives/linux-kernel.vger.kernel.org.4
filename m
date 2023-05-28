Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3F713B69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjE1RyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1RyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 13:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882FA2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 10:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55DEC60EDC
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 17:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F86C433D2;
        Sun, 28 May 2023 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685296457;
        bh=y1CuNarFZv5dQKVpLVgD0nZGqP2nsjhVEFaOMwLaaR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4rYogy8UyUcFaY+DQJbqKwZyYhvKqwAzpQ6F5ULjjjIapy36KwE21po57JodnAv7
         nc2mXQR8mKgz5Uca5BcNV16sWEmNfH62S3w4LMX3fDphIywfa3etmi8wqogxDU8WVt
         nKWRdFXZZKMn8Cmi+amyIsEUA6XgQ+lQTMucgdMiu0zApXfB/XC8yjVXp7FxhZngvW
         RLKwGoVCwU+NcWO8GXeN51wfL7odNZ3gfDKQL6l4y6hjKPfK9EoSH8QfM+Jkl73bbj
         YEOc9pUzHzUdEjTJ2Jjs/fPzqTN6sIydmxDtbX/y9oed8TUSuoDCRLQdpJhz+RepOL
         h/hLORysaXU8w==
Date:   Sun, 28 May 2023 20:53:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4] memblock: Add flags and nid info in memblock debugfs
Message-ID: <20230528175354.GJ4967@kernel.org>
References: <20230519105321.333-1-ssawgyw@gmail.com>
 <20230527103722.GG4967@kernel.org>
 <CALJQGLmn3JkYBZgkJXOc2mMy_2u4HZRUzdfaLm+uF8MQQCWsgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALJQGLmn3JkYBZgkJXOc2mMy_2u4HZRUzdfaLm+uF8MQQCWsgg@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 10:38:03PM +0800, Yuwei Guan wrote:
> Mike Rapoport <rppt@kernel.org> 于2023年5月27日周六 18:37写道：
> >
> > Hi Yuwei,
> >
> > On Fri, May 19, 2023 at 06:53:21PM +0800, Yuwei Guan wrote:
> >
> > > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> > > ---
> > > v4:
> > > - show string value for each memblock flag
> > > ---
> > >  mm/memblock.c | 24 ++++++++++++++++++++++--
> > >  1 file changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 511d4783dcf1..10d0ddbeebc1 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -2136,12 +2136,19 @@ void __init memblock_free_all(void)
> > >  }
> > >
> > >  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> > > +static const char * const flagname[] = {
> > > +     [ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> > > +     [ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
> > > +     [ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> > > +     [ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> > > +};
> > >
> > >  static int memblock_debug_show(struct seq_file *m, void *private)
> > >  {
> > >       struct memblock_type *type = m->private;
> > >       struct memblock_region *reg;
> > > -     int i;
> > > +     int i, j;
> > > +     unsigned int count = ARRAY_SIZE(flagname);
> > >       phys_addr_t end;
> > >
> > >       for (i = 0; i < type->cnt; i++) {
> > > @@ -2149,7 +2156,20 @@ static int memblock_debug_show(struct seq_file *m, void *private)
> > >               end = reg->base + reg->size - 1;
> > >
> > >               seq_printf(m, "%4d: ", i);
> > > -             seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> > > +             seq_printf(m, "%pa..%pa ", &reg->base, &end);
> > > +             seq_printf(m, "%4d ", memblock_get_region_node(reg));
> >
> > As Kefeng mentioned, the node id for reserved regions will be wrong, so
> > this needs to be updated so that when reg->nid == MAX_NUMNODES we'll print
> > e.g. 'x'.
> Hi Mike,
> 
> How about print 'x' when reg->nid == MAX_NUMNODES, base on this patch,
> https://lore.kernel.org/linux-mm/44ce007d-8049-1cc9-7e2e-4ccb51a2867d@huawei.com/T/#m6d214d4ea8912b64f5efc9c3f51ae71aa057d1f1

This is fine, can you please send a formal patch?
 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c5c80d9bcea3..3d449aaba052 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2169,17 +2169,21 @@ static int memblock_debug_show(struct seq_file
> *m, void *private)
>  {
>   struct memblock_type *type = m->private;
>   struct memblock_region *reg;
> - int i, j;
> + int i, j, nid;
>   unsigned int count = ARRAY_SIZE(flagname);
>   phys_addr_t end;
> 
>   for (i = 0; i < type->cnt; i++) {
>   reg = &type->regions[i];
>   end = reg->base + reg->size - 1;
> + nid = memblock_get_region_node(reg);
> 
>   seq_printf(m, "%4d: ", i);
>   seq_printf(m, "%pa..%pa ", &reg->base, &end);
> - seq_printf(m, "%4d ", memblock_get_region_node(reg));
> + if (nid != MAX_NUMNODES)
> + seq_printf(m, "%4d ", nid);
> + else
> + seq_printf(m, "%4c ", 'x');
>   if (reg->flags) {
>   for (j = 0; j < count; j++) {
>   if (reg->flags & (1U << j)) {
> 
> >
> > > +             if (reg->flags) {
> > > +                     for (j = 0; j < count; j++) {
> > > +                             if (reg->flags & (1U << j)) {
> > > +                                     seq_printf(m, "%s\n", flagname[j]);
> > > +                                     break;
> > > +                             }
> > > +                     }
> > > +                     if (j == count)
> > > +                             seq_printf(m, "%s\n", "UNKNOWN");
> > > +             } else {
> > > +                     seq_printf(m, "%s\n", "NONE");
> > > +             }
> > >       }
> > >       return 0;
> > >  }
> > > --
> > > 2.34.1
> > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.

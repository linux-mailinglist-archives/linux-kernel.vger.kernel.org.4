Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C73734538
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjFRHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFRHRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 03:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4BB2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 00:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E7760B23
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 07:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A3C433C8;
        Sun, 18 Jun 2023 07:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687072628;
        bh=RUSkoYlZfJnev8VRU+EmUs/ebvB9btIgUAlONEIMtM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etEo+Rb8zFXyDvlBxHmWa0x8QGgougagp0LL87PgoPX7k4q9TP7JOWNKjk6flVhRA
         uSRL/mb6CPoMUEISUDYk3DZ5QJFjfFSaJ1NJc2J+pWl2yxJX7f1YoNnp5nVXVXIGds
         Zmrvuan0ojIo48H0TzVVIpN0yxRDQ1oPXqrOQ/HAmx6ehNzv2WxkveVoNlRW4XxXCA
         YbyIVsRlOtx1DRNEruqxugMWgxwuNrHH1/+JB/2JptLgTCSJqZCIsRzhILRYgFFlQ4
         LyPBuEumLbCzedGUDTnP+nN/484PhXhcjLPbq1rYI55bJYCdB15RgcFxjfMpVDOIPL
         tPGhmLToT+CyA==
Date:   Sun, 18 Jun 2023 10:16:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Ni <zhiguangni01@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/sparse:avoid null pointer access in memory_present()
Message-ID: <20230618071627.GZ52412@kernel.org>
References: <20230617044036.3985524-1-zhiguangni01@gmail.com>
 <20230616224407.863c74a3dc9d4f1427802f91@linux-foundation.org>
 <CACZJ9cXM9VkJ5=euHphwM5TtX3aZqZ_QynOq10FtrqCxZfZsQA@mail.gmail.com>
 <20230617070051.GU52412@kernel.org>
 <CACZJ9cWFyr7MyGWWaGiNYHDb39ZYAmijH90gAH5N8-z4jc2KNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACZJ9cWFyr7MyGWWaGiNYHDb39ZYAmijH90gAH5N8-z4jc2KNw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 04:59:46PM +0800, Liam Ni wrote:
> On Sat, 17 Jun 2023 at 15:01, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Sat, Jun 17, 2023 at 02:17:58PM +0800, Liam Ni wrote:
> > > On Sat, 17 Jun 2023 at 13:44, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Sat, 17 Jun 2023 14:40:36 +1000 Liam Ni <zhiguangni01@gmail.com> wrote:
> > > >
> > > > > __nr_to_section() may return a null pointer,
> > > > > before accessing the member variable section_mem_map,
> > > > > we should first determine whether it is a null pointer.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/mm/sparse.c
> > > > > +++ b/mm/sparse.c
> > > > > @@ -258,7 +258,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
> > > > >               set_section_nid(section, nid);
> > > > >
> > > > >               ms = __nr_to_section(section);
> > > > > -             if (!ms->section_mem_map) {
> > > > > +             if (ms && !ms->section_mem_map) {
> > > > >                       ms->section_mem_map = sparse_encode_early_nid(nid) |
> > > > >                                                       SECTION_IS_ONLINE;
> > > > >                       __section_mark_present(ms, section);
> > > >
> > > > I'm suspecting that if __nr_to_section() returns NULL here, we should
> > > > just panic.  But a null-deref gives the same information, so why change
> > > > things?
> > >
> > > Do you mean if ms is a null pointer，ms->section_mem_map will cause
> > > system panic,so we needn't change?
> >
> > Yes, if __nr_to_section ever returns NULL the system will crash anyway.
> 
> I got it,do we need to print some information by panic()?

Accessing a NULL pointer will cause panic and there will be lots of
information spilled into the log anyway.

-- 
Sincerely yours,
Mike.

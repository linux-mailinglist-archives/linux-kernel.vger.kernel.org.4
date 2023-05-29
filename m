Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36682714828
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjE2KqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjE2Kp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CDEC4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD796123D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C9C433D2;
        Mon, 29 May 2023 10:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685357155;
        bh=YyZhd7+u4rnN68BcvCm78mN9H7X5EQow465eMlMwb4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAGhpNbneXKu5Fu+MvG/WOrAYFJa/OhdGymyw5GN6sYkdBGsPBX1UbwYq+xtmcXiS
         GSc+hMQ6MFpNsY/QCqnjbpL3JYYbKuBmhGnnK90BnWJ/iAeKv8t0h0YWHQBJxbGRix
         D9+ULVYtggHIYgYaJVL+vNY2pQ/zg/RSfKPoc496Obts+VgzMbbu0zTBkxOg5mLiBE
         ustXpn3uJ8ZNVVgx0FEQrvLk0lK9smLr3YNL84eyEuIYQYVUlrD5Z/0k3p4m8NZ9h8
         vdCA4pucvoTL+6/eumOu/74mhwYt6AT9O/ZrxY/R9l16QWvX67qjTfueFzHgiQZaxq
         eCrLxfGUvno7A==
Date:   Mon, 29 May 2023 13:45:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <20230529104530.GL4967@kernel.org>
References: <20230526051529.3387103-1-song@kernel.org>
 <ZHGrjJ8PqAGN9OZK@moria.home.lan>
 <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4DAwx=7Nta5HGiPTJ1LQJCGJGY3FrsdKi62f_zJbsRFQ@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 10:58:37PM -0700, Song Liu wrote:
> On Sat, May 27, 2023 at 12:04 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > I think this needs to back to the drawing board and we need something
> > simpler just targeted at executable memory; architecture specific
> > options should definitely _not_ be part of the exposed interface.
> 
> I don't think we are exposing architecture specific options to users.
> Some layer need to handle arch specifics. If the new allocator is
> built on top of module_alloc, module_alloc is handling that. If the new
> allocator is to replace module_alloc, it needs to handle arch specifics.
 
I'm for creating a new allocator that will replace module_alloc(). This
will give us a clean abstraction that modules and all the rest will use and
it will make easier to plug binpack or another allocator instead of
vmalloc.
Another point is with a new allocator we won't have weird dependencies on
CONFIG_MODULE in e.g. bpf and kprobes.

I'll have something ready to post as an RFC in a few days.

> Thanks,
> Song

-- 
Sincerely yours,
Mike.

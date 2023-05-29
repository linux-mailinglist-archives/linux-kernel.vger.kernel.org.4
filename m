Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3571465A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjE2Ihc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjE2Ihb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D44A7;
        Mon, 29 May 2023 01:37:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8209F611E4;
        Mon, 29 May 2023 08:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70462C433EF;
        Mon, 29 May 2023 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685349448;
        bh=CCUPziSkCzOqPqywzNs2qZ9qhrttdWy8eSJClG82XbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NH/TNk+FaUKdryMnaUVwo560jZ2kmTBlw4OUah1VnPKtBqjxmavJqh7kjdIAkHuU5
         dA2fN0+JEwl1NvmDMjm87muL9Ya/wsgdzCT1oV6+nwCzz5Os5pezyf1tRDi7uTpzP3
         A/+DX+3mYdjq91TkjDPKjk7Z+6Umu/808sLJZkoo=
Date:   Mon, 29 May 2023 09:37:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     stable@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Mah=E9?= Tardy <mahe.tardy@isovalent.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH stable 5.4 0/8] bpf: Fix
 bpf_probe_read/bpf_probe_read_str helpers
Message-ID: <2023052947-jubilance-driven-31d8@gregkh>
References: <20230522203352.738576-1-jolsa@kernel.org>
 <2023052646-magnetize-equate-2b24@gregkh>
 <ZHOzaStC0WmTvwL9@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHOzaStC0WmTvwL9@krava>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 10:02:49PM +0200, Jiri Olsa wrote:
> On Fri, May 26, 2023 at 07:54:17PM +0100, Greg KH wrote:
> > On Mon, May 22, 2023 at 10:33:44PM +0200, Jiri Olsa wrote:
> > > hi,
> > > we see broken access to user space with bpf_probe_read/bpf_probe_read_str
> > > helpers on arm64 with 5.4 kernel. The problem is that both helpers try to
> > > read user memory by calling probe_kernel_read, which seems to work on x86
> > > but fails on arm64.
> > 
> > Has this ever worked on arm64 for the 5.4 kernel tree?  If not, it's not
> > really a regression, and so, why not use a newer kernel that has this
> > new feature added to it there?
> > 
> > In other words, what requires you to use the 5.4.y tree and requires
> > feature parity across architectures?
> 
> we have a customer running ok on x86 v5.4, but arm64 is broken with
> the same bpf/user space code

Again why can they not use a newer kernel version?  What forces this
customer to be stuck with a specific kernel version that spans different
processor types?

> upgrade is an option of course, but it's not a big change and we can
> have 5.4 working on arm64 as well

For loads of other reasons, I'd recommend 5.15 or newer for arm64, so
why not use that?

> I can send out the change that will be closer to upstream changes,
> if that's a concern.. with adding the new probe helpers, which I
> guess is not a problem, because it does not change current API

You are trying to add features to a stable kernel that are not
regression fixes, which is something that we generally do not accept
into stable kernels.

thnaks,

greg k-h

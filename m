Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF5663576
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjAIXkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjAIXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:40:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14EBFDD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56814B8107B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C919DC433EF;
        Mon,  9 Jan 2023 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673307613;
        bh=j/AOslE7dKs/eS8qJHSl2YKv7BJ6/SuxxXaZzozGox4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGqyk22L5AqLSy354Z822K3uY78NagVhRgkd+YooqoNCQqR7xpB68KPXkpnRA9gek
         AvesqkPuF7B/id0uZDtlfZxY+S/bojwz7tr+vm6899TWNXq4iWz6nLhbpDjyY/MP4x
         LUri2Cxfy9gd+ttb2P8C+hy1sWWVxRZOUaaaMpPU=
Date:   Mon, 9 Jan 2023 15:40:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Message-Id: <20230109154012.3342cbb91defbc485db641c1@linux-foundation.org>
In-Reply-To: <20230109192248.55694-1-sj@kernel.org>
References: <20230109165455.647400-1-Liam.Howlett@oracle.com>
        <20230109192248.55694-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jan 2023 19:22:48 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 9 Jan 2023 16:55:42 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> 
> > If an invalidated maple state is encountered during write, reset the
> > maple state to MAS_START.  This will result in a re-walk of the tree to
> > the correct location for the write.

Can we think of a Fixes: for this?

> > Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.org/
> > Reported-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Tested-by: SeongJae Park <sj@kernel.org>
> 
> I confirmed this patch fixes the boot failure issue.  Nevertheless, the 'make
> install' issue on my system is still not fixed.

Is this a mainline issue or an mm-unstable issue?

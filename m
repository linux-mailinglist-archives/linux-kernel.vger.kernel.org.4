Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D65B4051
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiIIUG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIIUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:06:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A0C6FDE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=m1FQBJi+9cTNBW64KCAuDcrszWntI0Tejqb5xg2lU9o=; b=T0r+NEU5sUM7CiYLhXDU7Bn+Ya
        iMYFMcJXgAH+87uMSpQ1tC9T4Anrnzsp1SFX0oERFOaZ6tS54kfoAykYzC3ZQFcuDF4HtCuXwoa9H
        v7Z/oJxkEE8LC6faGm9ZKAEirhzAPOVYsW6t/4MeUfe1SPLClg4aKl8sX5eebqHbGE9bkeOceI9mP
        QicdY2mlQIjTxwFi5p62xNuCQzhbHifZeQggwDk1xzoNCxnTXp4Zpj/FcWYmXIv9F/hvWIxSX+suk
        58w6ujvEDI1YwRYD2REXsUvJKwwfaTRsZhvDw7fbD39C5kge5HSPT1W2MZcrZDw06NKPrAYInWoHN
        rqfIvV3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWkGR-00DX6F-LU; Fri, 09 Sep 2022 20:06:11 +0000
Date:   Fri, 9 Sep 2022 21:06:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc:     Muchun Song <muchun.song@linux.dev>, Chao Yu <chao@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com,
        David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Message-ID: <Yxucs30FNkbWQHVh@casper.infradead.org>
References: <20220830141009.150075-1-chao@kernel.org>
 <BAC9CE6A-5873-429F-ACE2-E0A9E507D807@linux.dev>
 <dbef29b2-ab0a-c3df-638c-381916a0d15a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbef29b2-ab0a-c3df-638c-381916a0d15a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 11:25:08PM +0200, Vlastimil Babka (SUSE) wrote:
> > I tend to agree with you. A mount operation shouldn’t panic the
> > kernel.
> 
> Hmm kmalloc(64) shouldn't normally due that due to the the underlying page
> allocation falling into the "too small to fail" category, wonder if
> syzkaller was doing anything special here?

Here's the repro:

https://syzkaller.appspot.com/x/repro.c?x=17cd7fa3080000

you can see it does:

  fd = open("/proc/thread-self/fail-nth", O_RDWR);
  if (fd == -1)
    exit(1);
  char buf[16];
  sprintf(buf, "%d", nth);
  if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))

so this is the kind of stupid nitpicky bug that we shouldn't be
reporting, let alone fixing, IMO.

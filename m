Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3636FA185
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjEHHvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjEHHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:51:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2D1AED1;
        Mon,  8 May 2023 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LefI14uzybxKQyNSLakt+X2OjjVEG+ovmxbHqRlX8zg=; b=YkxCYdQtSBIxc8X95awBBkGzJR
        hjAEsP2lFevrFz43FVIJeiFvcNrwXOVoYw+fKbUToGW275kozsh+E/y0okukvvvlG0CzYQmFov9JU
        zC9niGRmCNpT+K5n1DVwnKRRkY5bTx0dNIlNEfhdRQLJIQpvvcDhG9qBsn5KnK3HDSCQxQFvbWONX
        SdK5I3XQviqU3GCbv1kdgJHs1BEDXKYG6ci5YHeyQPpmXMpfn7LXeV7TyXzD7/YRq9YtrA3P7ew1v
        lyHreVA3Sau3uia3UTiXU5FVkjnQrbh8REdIXkUAgSh0aIdKanL2LMT/SFw2FE4f+wYw4ri9Govj2
        U8rMwi3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pvve5-00DwqU-B3; Mon, 08 May 2023 07:50:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08941302188; Mon,  8 May 2023 09:50:56 +0200 (CEST)
Date:   Mon, 8 May 2023 09:50:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of Linus' tree
Message-ID: <20230508075055.GA12756@noisy.programming.kicks-ass.net>
References: <20230508144947.3ac1dfe9@canb.auug.org.au>
 <cccc2dc5-b4d5-3b2b-bd23-b63c20b1023a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cccc2dc5-b4d5-3b2b-bd23-b63c20b1023a@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 09:52:22PM -0700, Randy Dunlap wrote:
>=20
>=20
> On 5/7/23 21:49, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > While building Linus' tree, today's linux-next build (htmldocs)
> > produced these warnings:
> >=20
> > kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Gua=
rantee forward-progress of cid allocation.
> >  on line 11496 - I thought it was a doc line
> > kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock:=
 Select cid allocation behavior: lock-free vs spinlock.
> >  on line 11505 - I thought it was a doc line
> >=20
> > Introduced by commit
> >=20
> >   223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid=
")
> >=20
>=20
> I have sent a patch:
>   https://lore.kernel.org/lkml/20230428031111.322-1-rdunlap@infradead.org
> but haven't seen any replies to it (possibly due to the merge window or t=
ravel).

I have it, and now that -rc1 is out the door, I'll queue it for -urgent.

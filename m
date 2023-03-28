Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3E66CB6B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjC1GQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC1GQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:16:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4930F0;
        Mon, 27 Mar 2023 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jWHxcHGl2RwP2n+s+NBN1zECkQwgjOLaxOC18f4eWog=; b=UyqocMwwogZUsIzbdm8m7Lbf+D
        sCq20hgJ2jdtRJ9jRy7Z0ZVKQbXQnB9pvkdLe+6CiEemTmNenKXIAQLOLgbSiSYPcbylHAzdDOA7z
        WKRmsJrRZlRueJT00mB2YqAvcwnZszcPnm551TU2nnK8Z5Vgx3H70A6ceIFO9MTTGmukyf3fQXcpm
        Scvb2cBjqaJm8MlRld4eYSWGo5d1kn5hzjQDrVYTbVcGq8bHlJqBYJxZemEDi7xUimAShNynlfDoK
        pfb0bs6cB/d9tWo8lXmqQywRvqbvf9LqoNfZKgw44ycUu+zpSEhcvhTEAenhxEn4fc3HXwA05UBKX
        ZEI0TNAA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ph2cl-00DH7i-0a;
        Tue, 28 Mar 2023 06:16:03 +0000
Date:   Mon, 27 Mar 2023 23:16:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZCKGI1LxktS7pKS9@bombadil.infradead.org>
References: <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
 <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com>
 <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
 <e5c2183a-f62a-6ca9-eec6-a7fab7ce4c91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c2183a-f62a-6ca9-eec6-a7fab7ce4c91@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 05:44:40AM +0200, David Hildenbrand wrote:
> ... do you have an updated patch/branch that includes the feedback from
> Linus so I can give it a churn tomorrow?

Yeah sure:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230327-module-alloc-opts

The commit log needs updateing to reflect the results I just collected:

With the alloc patch ("module: avoid allocation if module is already
present and ready") I see 145 MiB in memory difference in comparison
to its last patch, "module: extract patient module check into helper".
So I think that's a clear keeper and should help large CPU count boots.

The patch "module: add concurrency limiter" which puts the concurency
delimiter on the kread only saves about 2 MiB with 100 stress-ng ops,
which seems to be what I needed to reproduce your 400 CPU count original
issue.

The program used to reproduce is stress-ng with the new module option:

echo 0 > /proc/sys/vm/oom_dump_tasks
./stress-ng --module 100 --module-name xfs

To see how much max memory I use, I just use:

free -k -s 1 -c 40 | grep Mem | awk '{print $3}' > foo.log

Run the test in another window, CTRL-C the test when above
finishes after 40 seconds and then:

sort -n -r foo.log  | head -1

If you have xfs loaded already you probably wanna pick module just as big
that you don't have loaded. You must have dependencies loaded already as
it doesn't call modprobe, it just finit_module's the module.

The last patch "modules/kmod: replace implementation with a sempahore"
just takes Linus' simplification suggestion to replace kmod's solution.
I tested it with:

tools/testing/selftests/kmod/kmod.sh -t 0008

This stress tests the kmod autoloading. Using time, the timing is
similar, perhaps mildly slower, but I like the simplification. I'm still
not happy with the "module: add concurrency limiter", specially it
doesn't seem to really buy us much, 2 MiB seems like within noise. 
But stress-ng clearly shows it is a possible source of issue as we
grow the ops. So it may make sense to just use the idea to replace the
delimiter for kmod for now, unless you see different results.

The stress-ng module test can at least be used now to replicate insane setups
at bootup.

Let me know if you get other useful results.

  Luis

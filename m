Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3A45F1818
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiJABOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiJABOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:14:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA721B9C4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:14:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FB1AB82AA6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 01:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC3AC433C1;
        Sat,  1 Oct 2022 01:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664586857;
        bh=T6idAHXFh9n2+pRJNc6hWHfwxSGKHbWDBaMjbK/JeJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7GBC70DwGcTrKRy3+wZrhNzEhzQFDvJzxDwhO9phpL81Mgusz/yxpkc6YixzJazB
         819FcfOHkM2L/83Nm1zh3J5CACwhdlKJaLPthgbJRqlCb5CJQfxkFML/KFdcpKfnHi
         Q4uC9d0S70ToxxulU0st1kaYfDef7erbTujUVH9w=
Date:   Fri, 30 Sep 2022 18:14:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Edward Liaw <edliaw@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [syzbot] WARNING in change_protection
Message-Id: <20220930181415.31c2ee66166d4e1c6c0eac64@linux-foundation.org>
In-Reply-To: <YzeR+R6b4bwBlBHh@x1n>
References: <00000000000046580505e9dea8e4@google.com>
        <20220930164211.b8215770d44e1a3803f1e660@linux-foundation.org>
        <YzeR+R6b4bwBlBHh@x1n>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 21:03:53 -0400 Peter Xu <peterx@redhat.com> wrote:

> When PTE_MARKER_UFFD_WP not configured, it's still possible to reach pte
> marker code and trigger an warning. Add a few CONFIG_PTE_MARKER_UFFD_WP
> ifdefs to make sure the code won't be reached when not compiled in.

Thanks.

Is 679d10331910180 ("mm: introduce PTE_MARKER swap entry") the
appropriate Fixes: target?

Should we backport to -stable?

The inlined ifdefs are unpleasing.  Let's go with this for now, but
some future cleanup would be nice.


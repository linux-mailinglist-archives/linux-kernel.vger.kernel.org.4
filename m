Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF57672714
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjARSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjARSfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:35:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D84C0FE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CgwL9aOyve1nqfyWkDkD2t4/0kuxtXLNYuXC76FgNaU=; b=gEuV25fSj9KSACmgkYfGRhkCf3
        0gpsvyhZz+MWlTPZON5f06NnQp0OVA4AciEzOWmBDoUE6s3YnpQnzTrnmZVrwvJUUTPuUIYO4v4E4
        DQy3M1OAqhzn1lcG8eUr71jljleW/xwYfJy86qxMxJ2NEKr7zI1j+hU41K7b1pUvh3qoLnXemWfsf
        GO0pGebZxSESq7QT3bYOeKxBEfwsjktMjvUC/IXTW2p60vAtxB3rwYSDysNMxoBg70Gu2HsOyjziX
        okNPeC/2rySpEW4IbMwpsb4572FYCOAWVu8/WF/ET/E8rlg1OiTZ+NwGpkPZiA727cF9o/VDEwbai
        ciPi47FA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIDHF-000EF3-3y; Wed, 18 Jan 2023 18:35:13 +0000
Date:   Wed, 18 Jan 2023 18:35:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        peterz@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Y8g74YJVonMHpWw/@casper.infradead.org>
References: <20230109205336.3665937-42-surenb@google.com>
 <20230116140649.2012-1-hdanton@sina.com>
 <CAJuCfpHoHcZxQZgt4Ki1kiBu9O+sANZQambOa+1gSQu2brPoyA@mail.gmail.com>
 <20230117031632.2321-1-hdanton@sina.com>
 <CAJuCfpFq23m-KYKaDoCS2K2aM8rO7j8aPa0nVPs-_xP2Sf6GGg@mail.gmail.com>
 <20230117083355.2374-1-hdanton@sina.com>
 <CAJuCfpGU3c102mLZBY6UzkbW-DtfpYF77wLgzFpRWagBw8XfMQ@mail.gmail.com>
 <Y8bodcnhyMox+QjG@casper.infradead.org>
 <20230118062639.2839-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118062639.2839-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:26:39PM +0800, Hillf Danton wrote:
> On Tue, Jan 17, 2023 at 10:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > The cpu_relax() is exactly the wrong thing to do here.  See this thread:
> > https://lore.kernel.org/linux-fsdevel/20230113184447.1707316-1-mjguzik@gmail.com/
> 
> If you are right, feel free to go and remove every cpu_relax() under the
> kernel/locking directory.

I see you didn't read the whole thread where Linus points out that a
cmpxchg() loop is fundamentally different from a spinlock.

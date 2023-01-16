Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F330466C3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjAPPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjAPPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:23:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7392A86B2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=exGsL8noNQoZg92JSR3cmEJBbPzlcRdapH/BV8PgOLY=; b=Gi32vGR1v3HMHKVuZ/8Vsm52db
        u5ZGCNmR+/gY61U5R+iQgIVnwWeU0AeqLWEhRX7gxH399ps+kAA1NJb6v89/yeDGcSsSWjG/21DHk
        Rh0GcFuuCCMv3Re3DtwmHb+ioA2Tvi/yZrvupH0YNbIDLqifnO/EUYHxPfykHf4fVFEuSFfuMriMu
        IRbSxkO18HiA1mNrYWYUE17CIuA7u0/FoaQYxAdNx+Px8hfGK6U2/Dgka+M+dVOgD3GYojhstgx67
        7htBvc9FMXx5JDlBIDww/MEjHCLk0W7sMHeLgTYSEMLQBjUvp29koYFnwNRvFahlyCIvGh+9gxf/u
        NFfCMctg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHRIq-008qSL-UP; Mon, 16 Jan 2023 15:21:40 +0000
Date:   Mon, 16 Jan 2023 15:21:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     =?utf-8?B?0JXQutCw0YLQtdGA0LjQvdCwINCV0YHQuNC90LA=?= 
        <eesina@astralinux.ru>, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH mm] mm: hugetlb: Add checks for NULL for vma returned
 from find_vma. find_vma may return NULL, that's why its return value is
 usually checked for NULL.
Message-ID: <Y8VrhNe/g6OGMEUg@casper.infradead.org>
References: <20230116100520.71277-1-eesina@astralinux.ru>
 <6f5ac7ee-0af3-a466-cf7f-b17270bc1391@redhat.com>
 <182575210.374192581.1673881818398.JavaMail.zimbra@astralinux.ru>
 <a402b90d-372e-2774-d2c4-ceae64c6eed2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a402b90d-372e-2774-d2c4-ceae64c6eed2@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:12:48PM +0100, David Hildenbrand wrote:
> On 16.01.23 16:10, Екатерина Есина wrote:
> > Sorry, I've noticed that I'd sent the patch without description and sent
> > version 2.
> > Function find_vma may return NULL, that's why its return value is
> > usually checked for NULL. In this case vma and its fields also should be
> > checked before dereferencing to avoid NULL pointer dereference
> 
> Thanks, but again
> 
> What are the symptoms? How exactly does this BUG manifest?
> 
> For example, does the kernel crash, and if so, how can it be triggered?

SVACE is a static analyser.  It's not very good, but the people who run
it are extremely persistent about submitting patches based solely on the
output of the tool and doing no human checks of their own.  Probably best
to just ignore them, or NACK them.

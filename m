Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA26C624B22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKJUEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiKJUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:04:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67FA2B25B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIhmN7AMTXSMlZmsQxBGWR4nbHWdLbYXDTp8/wDHABE=; b=CjlDFRP+oum7hqf01JepEnZMUD
        EDu/qJ8KnBhJR/3Fef9SzsiyzpYkdiij7vFh1uJgELcd9UeQTT4DtqIM8sImGhyb5MrarFdxQY2i5
        UfEUQGNWCMjv+voU9pdB7qeBK8LaSO+YjI3KVuxMABr3ewTbJjvcHShMLQ668qUR/BgpQkPnCtCh2
        +2gQyNsckD2/q5etq54nojntwzgYyNCs52TnVBL6IMxThdhp9ng1orb5IvXJIEgnLjKtvEqgXvMQ3
        VAPcxW46SyhaFhakqKtFeUeqpU7wQ4b56x31ooqtX5HylFpW1fm9iipu+GlPKnI3Mrk/fnTmVkNlo
        AFeRuIQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otDmI-00CMkc-QA; Thu, 10 Nov 2022 20:03:58 +0000
Date:   Thu, 10 Nov 2022 20:03:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Make some folio and page function arguments const
 and use bool
Message-ID: <Y21ZLhbRDv1TKMR6@casper.infradead.org>
References: <166810136860.3462948.16794726061248137027.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166810136860.3462948.16794726061248137027.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:29:28PM +0000, David Howells wrote:
> Mark the folio* argument to some of the folio accessor functions as a const
> pointer and similarly make some page* arguments to some page functions
> const.

I think the build bots are going to whinge.

#ifdef CONFIG_DEBUG_VM_PGFLAGS
#define VM_BUG_ON_PGFLAGS(cond, page) VM_BUG_ON_PAGE(cond, page)

#define VM_BUG_ON_PAGE(cond, page)                                      \
        do {                                                            \
                if (unlikely(cond)) {                                   \
                        dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");

void dump_page(struct page *page, const char *reason);

I've looked at making dump_page() take a const struct page * in the past,
but it's a lot of work.

Do you really need this or is this a Friday afternoon project?

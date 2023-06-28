Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33389741857
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjF1Sxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjF1Sxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083791FE8;
        Wed, 28 Jun 2023 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pbgmqzfx61gqa8ZE0U7704hyAi4M3AzWTUQaBmz/ojs=; b=nXV5/7tO9JYgJrNPdu3ARxvZ9H
        Te9clGGefdDvfjj4XBxBjUuPv/dgT2yF+X+BDpH559nid58AiJt08y0IKsv9DrnIpEAidQr7Qg6sa
        yge3leQVZxs+SIdx4hu8g09RdCM16ewSWcUoAALXpFt1+ANS7HgcRTwaaLN+AysJePruyIQnzOHZU
        zZQQyM7N5oTobC7OMGBEZpxNJf7HcO+lNNYZ3kKfV0j+Zz8OIoHGkdBE6VPBTaW0K4NjhopPqP/Wv
        +x3w8xazZ/YX/cUlvHRafLSmrEmnMkz6zC+XqB0EQ+ESoSu5xvuV0dJsjHPHWpT39WNsz3cVYVhdt
        m9cyefUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEaHe-00GRev-0n;
        Wed, 28 Jun 2023 18:52:54 +0000
Date:   Wed, 28 Jun 2023 11:52:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, song@kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZJyBhv6yrAfYvMh5@bombadil.infradead.org>
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org>
 <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org>
 <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org>
 <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:28:41AM -0700, Luis Chamberlain wrote:
> On Mon, Jun 05, 2023 at 08:17:42AM -0700, Luis Chamberlain wrote:
> > We've gone down from ~6 GiB to ~6 MiB.
> 
> And just to also highlight, that was just for for the KASAN enabled case, and
> for !KASAN we went from ~18 GiB to 0.

Linus, were you thinking of including these patches in for v6.5-rc1?

  Luis

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B90689F49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBCQbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjBCQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:31:13 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90EDA7ED8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:31:11 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E3CE067373; Fri,  3 Feb 2023 17:31:07 +0100 (CET)
Date:   Fri, 3 Feb 2023 17:31:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        syzbot <syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: How does ftruncate() interact with DIO read?
Message-ID: <20230203163107.GA4082@lst.de>
References: <2112099.1675441439@warthog.procyon.org.uk> <2076817.1675434996@warthog.procyon.org.uk> <72029a93-1150-1994-916f-b15ef0befd49@nvidia.com> <e8065d6a-d2f9-60aa-8541-8dfc8e9b608f@redhat.com> <000000000000b0b3c005f3a09383@google.com> <822863.1675327935@warthog.procyon.org.uk> <1265629.1675350909@warthog.procyon.org.uk> <2116614.1675441630@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2116614.1675441630@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 04:27:10PM +0000, David Howells wrote:
> Hi Christoph,
> 
> What does ftruncate() do if there's a conflicting DIO read happening on the
> same file?  Does it cancel the bio?

There is no way to cancel a bio.  ->setattr is supposed to call
inode_dio_wait to wait for pending I/O, although some file systems
like btrfs have their own hand crafted and more complicated version
of that.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214726C74B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCXAqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:46:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBA1193E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3F0EB82279
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40100C433EF;
        Fri, 24 Mar 2023 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679618799;
        bh=o+500o1W/tmKTD52ErdN6cCtWOuSwEJCYhyr4GzTzrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFSW9108Gr1OWZPUXrn2wD9LQpzPpmz9gSHNU6I66cwJr88MRANJE6syVlImnX7d6
         VrEJvSp3cnivvWHlDfm7455R31V6xaHpNIY47XArDhjeBc1u4HrIVBYgtJd3EZf3rT
         NdPv1H9W7y+jD89e4rsETC5uQDXI29/517EQYaFE1gvqF0sd4QpLSXwMyjw03QEzFG
         8CQ8WAOfnNJc3Ngz8cBhgjwC0isOHrbTB1FfjdqNisY6FRcHPMbybQOVcAjhDutVXI
         9O62i9dVPaLawnGzU2bcAhrZqRuOUBA9QsXCx/RXWawAPvm7ARoa7MUrDPWk8kq9UB
         ewH9SYQWKzDQg==
Date:   Thu, 23 Mar 2023 17:46:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZBzy7RHlCqmApxUe@google.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org>
 <ZBzPYwcoLXkFngz8@google.com>
 <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
 <ZBzkzg+lr+TOXZcW@google.com>
 <8207efb81cd1e9322ad608d313eb4b4bd5740e80.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8207efb81cd1e9322ad608d313eb4b4bd5740e80.camel@wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Damien Le Moal wrote:
> On Thu, 2023-03-23 at 16:46 -0700, Jaegeuk Kim wrote:
> > On 03/23, Damien Le Moal wrote:
> > > On Thu, 2023-03-23 at 15:14 -0700, Jaegeuk Kim wrote:
> > > > On 03/20, Christoph Hellwig wrote:
> > > > > On Mon, Feb 20, 2023 at 01:20:04PM +0100, Hans Holmberg wrote:
> > > > > > A) Supporting proper direct writes for zoned block devices
> > > > > > would
> > > > > > be the best, but it is currently not supported (probably for
> > > > > > a good but non-obvious reason). Would it be feasible to
> > > > > > implement proper direct IO?
> > > > > 
> > > > > I don't think why not.  In many ways direct writes to zoned
> > > > > devices
> > > > > should be easier than non-direct writes.
> > > > > 
> > > > > Any comments from the maintainers why the direct I/O writes to
> > > > > zoned
> > > > > devices are disabled?  I could not find anything helpful in the
> > > > > comments
> > > > > or commit logs.
> > > > 
> > > > The direct IO wants to overwrite the data on the same block
> > > > address,
> > > > while
> > > > zoned device does not support it?
> > > 
> > > Surely that is not the case with LFS mode, doesn't it ? Otherwise,
> > > even
> > > buffered overwrites would have an issue.
> > 
> > Zoned device only supports LFS mode.
> 
> Yes, and that was exactly my point: with LFS mode, O_DIRECT write
> should never overwrite anything. So I do not see why direct writes
> should be handled as buffered writes with zoned devices. Am I missing
> something here ?

That's an easiest way to serialize block allocation and submit_bio when users
are calling buffered writes and direct writes in parallel. :)
I just felt that if we can manage both of them in direct write path along with
buffered write path, we may be able to avoid memcpy.

> 
> > 
> 

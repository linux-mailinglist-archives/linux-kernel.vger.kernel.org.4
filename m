Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA80A6C743F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjCWXq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWXq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0532201C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6393262906
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A21C433D2;
        Thu, 23 Mar 2023 23:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679615184;
        bh=c6QPeB80q9C6lJ8ZYENe4qJTNGL5v9atXIzxW8tPIuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oX3mRy9yzTNA7RomAvUE/dxLlsp/pfSAr1P+feV4iffih+/Gq7gge8hY/55UuQcHK
         Btan7uoTrlOJLud1+8Pd5tXWfvloYVSHPY0yTT4prkyDiPm3U06TaraTwrBOe2eKs5
         +W85JbXD1O6D+LiLRHxW9ggzWWPybTqV2oQ+hc30MYli6RLygOIeP/OE3GU1W6yln8
         S7WFE5+lDInvQDLx60JMhSKbZS1Vx3AwQgeYoY165ZTPO768/hwW5xWBGr4EvwWDDz
         b+yyzHibz1qjNNGec3QPTrxj6VhGVaUsjRqDu+JZuY7LrrPHASb9zNTtnPw+LSP+xF
         SwzreOjjydOXw==
Date:   Thu, 23 Mar 2023 16:46:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "chao@kernel.org" <chao@kernel.org>
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Message-ID: <ZBzkzg+lr+TOXZcW@google.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
 <ZBhisCo7gTitmKeO@infradead.org>
 <ZBzPYwcoLXkFngz8@google.com>
 <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Damien Le Moal wrote:
> On Thu, 2023-03-23 at 15:14 -0700, Jaegeuk Kim wrote:
> > On 03/20, Christoph Hellwig wrote:
> > > On Mon, Feb 20, 2023 at 01:20:04PM +0100, Hans Holmberg wrote:
> > > > A) Supporting proper direct writes for zoned block devices would
> > > > be the best, but it is currently not supported (probably for
> > > > a good but non-obvious reason). Would it be feasible to
> > > > implement proper direct IO?
> > > 
> > > I don't think why not.  In many ways direct writes to zoned devices
> > > should be easier than non-direct writes.
> > > 
> > > Any comments from the maintainers why the direct I/O writes to
> > > zoned
> > > devices are disabled?  I could not find anything helpful in the
> > > comments
> > > or commit logs.
> > 
> > The direct IO wants to overwrite the data on the same block address,
> > while
> > zoned device does not support it?
> 
> Surely that is not the case with LFS mode, doesn't it ? Otherwise, even
> buffered overwrites would have an issue.

Zoned device only supports LFS mode.

> 

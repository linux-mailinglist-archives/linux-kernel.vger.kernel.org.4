Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E78E6B14D6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCHWQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCHWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:16:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9685B01
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dGp9vIk2lHmCEzh30vPS3w1b6P+mkS45Ij2om+aNJ0M=; b=JJ9D9SIdtY1y/UzJkqPz2s2H7c
        fIhU4OFC9CdY6gnk2qHgk9uVC0pbeWp1Ce9A+gsFMAb6s3DM4+XDclHyGkeyMgzdL8z2NGkEH2sV2
        V5zKkZSvaHwh2itkctgjLiyL+/F0+6DdVYY6fESwiW4mv/4QwNzKLvZa2g9/lLYxySxAE03jgaMjY
        aBHD3FDRQVArTD4CZ2BViM2QO+DmVsV7d3O1SwY+U2H4otRe3O1zkO6TcwO4Zxw7jOCUmxWkSKlUx
        KLaXNaSuT5ZnrMwletNpV5kuyWu+LDzKj9+7UY3KBUL+CDeESyGLW+Kf33BNHs5P9F7dYA9LDb4e+
        L0UFsYGQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa24o-006wOM-Nx; Wed, 08 Mar 2023 22:16:02 +0000
Date:   Wed, 8 Mar 2023 14:16:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] shmem: update documentation
Message-ID: <ZAkJInU6iufkI0j5@bombadil.infradead.org>
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-6-mcgrof@kernel.org>
 <efae0531-7f72-a78c-07c9-82879adf5666@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efae0531-7f72-a78c-07c9-82879adf5666@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:04:57PM +0100, David Hildenbrand wrote:
> On 03.03.23 00:27, Luis Chamberlain wrote:
> > Update the docs to reflect a bit better why some folks prefer tmpfs
> > over ramfs and clarify a bit more about the difference between brd
> > ramdisks.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >   Documentation/filesystems/tmpfs.rst | 27 +++++++++++++++++++--------
> >   1 file changed, 19 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > index 0408c245785e..e77ebdacadd0 100644
> > --- a/Documentation/filesystems/tmpfs.rst
> > +++ b/Documentation/filesystems/tmpfs.rst
> > @@ -13,14 +13,25 @@ everything stored therein is lost.
> >   tmpfs puts everything into the kernel internal caches and grows and
> >   shrinks to accommodate the files it contains and is able to swap
> > -unneeded pages out to swap space. It has maximum size limits which can
> > -be adjusted on the fly via 'mount -o remount ...'
> > -
> > -If you compare it to ramfs (which was the template to create tmpfs)
> > -you gain swapping and limit checking. Another similar thing is the RAM
> > -disk (/dev/ram*), which simulates a fixed size hard disk in physical
> > -RAM, where you have to create an ordinary filesystem on top. Ramdisks
> > -cannot swap and you do not have the possibility to resize them.
> > +unneeded pages out to swap space.
> 
> I suppose, in contrast to ramfs, tmpfs also supports THP. Maybe worth adding
> as well.

Good call, both the mount and the sysfs file (which is registered by
THP) lacks any documentation so I'll just add docs for both.

  Luis

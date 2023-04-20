Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598AC6E8E22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjDTJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDTJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD526EC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 489EC63ED0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAD6C433EF;
        Thu, 20 Apr 2023 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681983258;
        bh=oBd1jiFHxIfJOSd/MLajoRXe8BBSyCbVPO9SoZQLpHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0CwMjy1/D/gpKk1NALCWP7VOPf5oYDzx2eZJQZIQXtV8uw8hhemG+mbt/MmLfpA+
         J4rnI8vUhEM3pF4lJUvsz2BghNd2/OkIBCI8feNxliX7cIOq992BIS2GE6oP/dHd9/
         yTV1vLJq/XYh5gdr7yFXoaUo+kdAXOvqaEIyrliyKo9Y3uLOGpQ5VD/b40CHJE4vBp
         i6V94PrPsKoP7/1vm8BFcNZws13u6n2fqMQV7bpQ6kOXlnEko+UQZYTRIuVw6UT6uF
         XCQYhYHkD7GtC/H5stjxqsB+KGyRD7UlJ7wcd8Pm7IVSlyVmbwekw/2Q1MbEr3WRbk
         Gue7bJ8c5pVBg==
Date:   Thu, 20 Apr 2023 11:34:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-ID: <20230420-wetten-aneignen-8324959e629d@brauner>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
 <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
 <d1e719ea-95bf-bb96-62db-e550cefe0a80@linux.alibaba.com>
 <20230419142159.fd5ca2e91658fe304e317a72@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419142159.fd5ca2e91658fe304e317a72@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 02:21:59PM -0700, Andrew Morton wrote:
> On Wed, 19 Apr 2023 10:00:15 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> 
> > 
> > 
> > On 4/18/23 8:56 PM, Christian Brauner wrote:
> > > On Tue, Apr 18, 2023 at 05:37:06PM +0800, Joseph Qi wrote:
> > >> Andrew picked ocfs2 patches into -mm tree before.
> > > Yup and that's fine obviously, but this belongs to fs/ and we're aiming
> > > to take fs/ stuff through the dedicated fs trees going forward.
> > 
> > Either is fine for me.
> > Hi Andrew, what's your opinion?
> 
> I've been wrangling ocfs2 for over a decade and this is the first I've
> heard of this proposal.
> 
> Who is "we", above?  What was their reasoning?
> 
> Who will be responsible for ocfs2 patches?  What will be their workflow
> and review and test processes?
> 
> Overall, what benefit does this proposal offer the ocfs2 project?

I think I might not have communicated as clearly as I should have.
Simply because I naively assumed that this is unproblematic.

By "we" I mean people responsible for "fs/" which now happens to also
include me. So the goal of this is for patches falling under fs/ to get
picked up more quickly and broadly and share the maintenance burden.

Since ocfs2 falls under fs/ it felt pretty straightforward that it
should go via one of the fs/ trees and thus I picked it up and didn't
bat an eye that it might somehow bother you.

For us as in "fs/" it's nicer because it means if we do fs wide changes
we'll reduce chances of merge conflicts.

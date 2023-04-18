Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5026E996F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjDTQWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjDTQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:22:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A71BD3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:22:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLndo022424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007713; bh=P55Ye25BDJCTcXLNroTjSNzxxGD0p5Uoc9h9dHTaUKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gf0I9gLVKvEwyJg8K5OK1SL6nKdfR+wRkceYLvWkMK9kqAeUP9PTV26fXq6nw0x+y
         DqKX7NFuYE+d5u0UPimEfsoy+kBDxDBjzJgZu0ofv8YgTdyuW+N4e6iIAl9vCd9Sry
         pcHHK5EPD7qba03M1Si/N5hmet6jtSwXfvjwBhD24jYT0vZKQhH1iw77Jm3vJoBLkI
         SmPxfhRFTIQ/AR/q0yl8uDeuj3EL2MtZoCsNw4nRR6acViwDGk3atIe3k/84Xb26QE
         SNXHjGnN2Z1DYcF5SLdfAGmq4m+PXJiUut7pfiKdqQuEu4DaKM31foyoD7FvFf5nFK
         5NdH/n0aOY0IA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1A41B15C3AC2; Tue, 18 Apr 2023 14:02:02 -0400 (EDT)
Date:   Tue, 18 Apr 2023 14:02:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>,
        akpm <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-ID: <20230418180202.GA602488@mit.edu>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
 <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:56:38PM +0200, Christian Brauner wrote:
> On Tue, Apr 18, 2023 at 05:37:06PM +0800, Joseph Qi wrote:
> > Andrew picked ocfs2 patches into -mm tree before.
> 
> Yup and that's fine obviously, but this belongs to fs/ and we're aiming
> to take fs/ stuff through the dedicated fs trees going forward.

The challenge here is that there isn't an active ocfs2 tree at the
moment (git/jlbec/ocfs2.git was last updated 11 years ago), and it's
not clear ocfs2 has an active maintainer, although as discussed at a
recent ext4 telechat, there still are some enterprise users of it
hanging on.

We're starting considering changes to fs/jbd2 so we can get off of
using the struct bh for jbd2 (still very early days; it's more in the
early concept brain-storming stage.)  And since ocfs2 also uses
fs/jbd2, the fact that ocfs2 isn't under active maintenance is going
to be more of a challenge moving forward.

Something we should discuss in the hallway track of LSF/MM, perhaps...

							- Ted

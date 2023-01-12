Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E56669BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjALDn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjALDnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:43:53 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B644352
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9LInSOvBpIctyPHKBxYQ9qJKJNt5sNFXChqsuGuIhNU=; b=FXTK6o5kdhGJkVozW+5He0DFfB
        JRVOa5vdpFiB3n4pGNqNgwBgBEnZsy85RqlBPvOZ9tBJ7yLSTQ3ahSGZjCEuZtduNuQSzK84NmqYG
        6bCS4ABlYt4vEoQhc2a+Euf86HPvbU91iZxTrlvTqo7il7yLMhdhq8x8dp9Jqd8F6+B4zMnjYSbMX
        EQN9bx6AvG0wdv7Cd6pvLXvcEWpLGyUweEoQYoufTNof0IsN4zaRJjWL7Gr7lXb2DG9sTZJgJ+N9y
        iRC9CqGSfDpGSjjBJRM4jkqbfIMmL2Jy5+Y12vx+rzm/3Uu3kXr5B8Fa9xc9YavJ29JMfV2z06j0X
        PuX6s/RQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pFoV1-001Pgm-25;
        Thu, 12 Jan 2023 03:43:31 +0000
Date:   Thu, 12 Jan 2023 03:43:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        kari.argillander@gmail.com, akpm@linux-foundation.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH -next] fs/ntfs3: Fix potential NULL/IS_ERR bug in
 ntfs_lookup()
Message-ID: <Y7+B40Mnnm7/rY+O@ZenIV>
References: <20230112013248.2464556-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112013248.2464556-1-zhangpeng362@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:32:48AM +0000, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Dan Carpenter reported a Smatch static checker warning:
> 
> fs/ntfs3/namei.c:96 ntfs_lookup()
> error: potential NULL/IS_ERR bug 'inode'
> It will cause null-ptr-deref when dir_search_u() returns NULL if the
> file is not found.
> Fix this by replacing IS_ERR() with IS_ERR_OR_NULL() to add a check for
> NULL.

That's a bad approach - you are papering over bad calling conventions instead of
fixing them.

IS_ERR_OR_NULL is almost never the right tool.  Occasionally there are valid
cases for function possibly returning pointer/NULL/ERR_PTR(...); this is
almost certainly not one of those.

Incidentally, inodes with NULL ->i_op should never exist.  _Any_ place that
sets ->i_op to NULL is broken, plain and simple.  A new instance of struct
inode has ->i_op pointing to empty method table; it *is* initialized.

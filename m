Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1DC6A0D91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 17:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjBWQJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 11:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjBWQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 11:09:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6CD19695
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 08:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E486175A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB953C433EF;
        Thu, 23 Feb 2023 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677168561;
        bh=OqY4RBwRYEHh7NTF1I0c5uw+aMVgR9annOWD4n3e8cI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbxZYXiCUB2afvudMISaDZ5Op9OdhJjJlCvzGDV4fGxpW8+UIFYW8dAJDnbvY2X6D
         v/3xq97Eg5++ACX7ab79Wd0oXH1eT/uLkxwPrmR3c8TmyWMTf8mcZ20I9gPosDs94D
         m9gMj/BFwYMlcku8iPRFQHouCiSpNj2Wrg2/qFum/LI2g5SOJ7o/yAHjGPd136gXRC
         F8swkJS94i67TiqFXlAEW5ne6jo17iggXt3zi8BXeNZ3rCpyCZaWD2eE4gq1IWS10N
         Si5ZNeflBoxg4bV60YMb+dJooW6m6+YcSNM8qDtZTQYdQewZXhu1AYu3j51998bsoo
         HVMmucQroh9sA==
Date:   Thu, 23 Feb 2023 17:09:14 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        yosryahmed@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 5/5] shmem: add support to ignore swap
Message-ID: <20230223160914.cwvt53drn2bckpdc@wittgenstein>
References: <20230223024412.3522465-1-mcgrof@kernel.org>
 <20230223024412.3522465-6-mcgrof@kernel.org>
 <20230223122631.hwvhbqxadvbm23nb@wittgenstein>
 <Y/eDOXC4+vpCCBic@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/eDOXC4+vpCCBic@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 07:16:09AM -0800, Christoph Hellwig wrote:
> On Thu, Feb 23, 2023 at 01:26:31PM +0100, Christian Brauner wrote:
> > We would have use-cases for this in systemd. We currently use ramfs for
> > systemd's credential logic since ramfs is unswappable. It'd be very neat
> > if we could use tmpfs instead,
> 
> What is the advantage of using a swapless tmpfs over ramf?

There are a few reasons we usually prefer tmpfs over ramfs. Iirc, ramfs
doesn't have limits and grows dynamically. So we currently only use it
from the most privileged process where we do our own accounting and
immediately remount the superblock read-only. Tmpfs on the other hand
offers various ways to restrict memory consumption.

Other reasons are that ramfs doesn't support selinux labels, xattrs, and
acls in general which come in quite handy. Starting with kernel v6.3
tmpfs does also support idmapped mounts. So we usually always prefer
ramfs over tmpfs unless we have a very specific need such as the memory
not being swapped out.

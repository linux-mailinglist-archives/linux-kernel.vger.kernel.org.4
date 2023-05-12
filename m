Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423F66FFF67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbjELDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbjELDpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0DF559F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF5C64EA6
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDC8C433D2;
        Fri, 12 May 2023 03:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683863119;
        bh=LwXFBCIUn0qm0zeQk1M2Kj8pN5JJyhizS0k2YqjjrOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xKEZx2tzEI51buUGGzKH5QJ7PBGdG992TJmfpaxnYgMAMzaZ3FpNcs3PZkXbqm4M/
         /HR/cZNsnu3ldz5pcncGMlOV6OuZK72I3TEDHWbROxv+jS+IOJjGjpZewksm/bxplS
         uIwzeTnp9fq09Q5OQzXCY0N+Q+TPmqnc9Ank+EaE=
Date:   Thu, 11 May 2023 20:45:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/2] statfs: Enforce statfs[64] structure intialization
Message-Id: <20230511204518.eba10b4cbf9568a24d1d428b@linux-foundation.org>
In-Reply-To: <ZFz9I5bhRh2wH14i@osiris>
References: <20230504144021.808932-1-iii@linux.ibm.com>
        <ZFz9I5bhRh2wH14i@osiris>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 16:35:15 +0200 Heiko Carstens <hca@linux.ibm.com> wrote:

> On Thu, May 04, 2023 at 04:40:19PM +0200, Ilya Leoshkevich wrote:
> > This series fixes copying of uninitialized memory to userspace by
> > do_statfs_native() and do_statfs64() on s390.
> > 
> > Patch 1 fixes the problem by making the code similar to
> > put_compat_statfs() and put_compat_statfs64().
> > 
> > Patch 2 gets rid of the padding which caused the issue; even though it
> > may be considered redundant, it documents that s390 de-facto has an
> > extra f_spare array element.
> > 
> > Ilya Leoshkevich (2):
> >   statfs: Enforce statfs[64] structure intialization
> >   s390/uapi: Cover statfs padding by growing f_spare
> > 
> >  arch/s390/include/asm/compat.h      | 2 +-
> >  arch/s390/include/uapi/asm/statfs.h | 4 ++--
> >  fs/statfs.c                         | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> Al, Andrew, should this go via the s390 tree?

I'd say so.

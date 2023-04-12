Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEF6DE87D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLA0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDLA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC8D3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D3960F05
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B07C433EF;
        Wed, 12 Apr 2023 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681259178;
        bh=mpIpA+1gb4NUMq4biGISkWZOSJ4nEB3zKh/uw92n970=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I6btUPV5HS9K5fv290/6tGSVD4ZMsyWvRAb4GRYu2FSoTL82LXKNKwswdW0MlRqUN
         zdo+lE/zEw27/cwykcb1w7FZdRWt6P3ItVbVIoyLJkaCV33lVXpDEE878M3KiIukiB
         lu4r9a1zFPCcZSHEh31QKFi1xfC+JiWNq47UBeAA=
Date:   Tue, 11 Apr 2023 17:26:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Message-Id: <20230411172617.13bc444955f51653b170f744@linux-foundation.org>
In-Reply-To: <20230411092741.780679-1-liushixin2@huawei.com>
References: <20230411092741.780679-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 17:27:41 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Patch a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")
> introduced a new copy_user_highpage_mc() function, and fix the kernel crash
> when the kernel is copying a normal page as the result of a copy-on-write
> fault and runs into an uncorrectable error. But it doesn't work for HugeTLB.

What does "doesn't work" mean?  Please fully describe the user-visible
effects of the issue which this patch is addressing.

> This is to support HugeTLB by using copy_mc_user_highpage() in copy_subpage()
> and copy_user_gigantic_page() too.
> 
> Moreover, this is also used by userfaultfd, it will return -EHWPOISON if
> running into an uncorrectable error.

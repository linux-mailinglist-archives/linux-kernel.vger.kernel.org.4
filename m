Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E206E0141
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDLV5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLV5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:57:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B912D44
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F006397A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B1DC433EF;
        Wed, 12 Apr 2023 21:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681336639;
        bh=6pRvLGc87JTXtP4muzgwevPzgBKLZDkUknq8v/ar9Ik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NcieaChHyrNGnCn7GnJNkduQweAwfHG4D+WlMj0KByLMYkb+Yw5eawpuWpyDke/vp
         Jsf7xKCznL2j0yKer+6MO1ryeP1EfxxFG3yJT2IxKN0riQOmQtyzBSbL70eve4O771
         taqdi4LjEi0Jks86rFGfNpz/4hB6flnEUQzCwjGY=
Date:   Wed, 12 Apr 2023 14:57:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
Message-Id: <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
In-Reply-To: <20230412181350.GA22818@monkey>
References: <20230411092741.780679-1-liushixin2@huawei.com>
        <20230412181350.GA22818@monkey>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 11:13:50 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 04/11/23 17:27, Liu Shixin wrote:
> > Patch a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")
> > introduced a new copy_user_highpage_mc() function, and fix the kernel crash
> > when the kernel is copying a normal page as the result of a copy-on-write
> > fault and runs into an uncorrectable error. But it doesn't work for HugeTLB.
> 
> Andrew asked about user-visible effects.  Perhaps, a better way of
> stating this in the commit message might be:
> 
> Commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on write
> faults") introduced the routine copy_user_highpage_mc() to gracefully
> handle copying of user pages with uncorrectable errors.  Previously,
> such copies would result in a kernel crash.  hugetlb has separate code
> paths for copy-on-write and does not benefit from the changes made in
> commit a873dfe1032a.
> 
> Modify hugetlb copy-on-write code paths to use copy_mc_user_highpage()
> so that they can also gracefully handle uncorrectable errors in user
> pages.  This involves changing the hugetlb specific routine
> ?copy_user_folio()? from type void to int so that it can return an error.
> Modify the hugetlb userfaultfd code in the same way so that it can return
> -EHWPOISON if it encounters an uncorrectable error.

Thanks, but...  what are the runtime effects?  What does hugetlb
presently do when encountering these uncorrectable error?



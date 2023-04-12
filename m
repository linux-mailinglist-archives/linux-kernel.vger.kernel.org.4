Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6133E6E0234
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjDLW4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLW4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:56:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54027109
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE84F612D2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19444C433EF;
        Wed, 12 Apr 2023 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681340179;
        bh=1O/8VJdwC6exTtvaS31U9tPVXqQob2pb5H8yDpg2h4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vABntK2I8QKsI+0yaF7DesF+cF4ljqLZYifsghCGmVHxBmiQ95zGZS3qYrH39NxwM
         sGO15KX24Zh35lv60lXUqlttfQxZ2leJN8butFLzzH3CaOSxXkolNPeDqAyiC8WFv+
         aT2CKd7AoFCPsw4o8yZEfDTm0EZZy7e1rWRcdq+w=
Date:   Wed, 12 Apr 2023 15:56:18 -0700
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
Message-Id: <20230412155618.720e6b3aa5be6444f7889ea6@linux-foundation.org>
In-Reply-To: <20230412222138.GB4759@monkey>
References: <20230411092741.780679-1-liushixin2@huawei.com>
        <20230412181350.GA22818@monkey>
        <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
        <20230412222138.GB4759@monkey>
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

On Wed, 12 Apr 2023 15:21:38 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > > Commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on write
> > > faults") introduced the routine copy_user_highpage_mc() to gracefully
> > > handle copying of user pages with uncorrectable errors.  Previously,
> > > such copies would result in a kernel crash.  hugetlb has separate code
> > > paths for copy-on-write and does not benefit from the changes made in
> > > commit a873dfe1032a.
> 
> I was just going to suggest adding the line,
> 
> Hence, copy-on-write of hugetlb user pages with uncorrectable errors            
> will result in a kernel crash as was the case with 'normal' pages before        
> commit a873dfe1032a.
> 
> However, I'm guessing it might be more clear if we start with the
> runtime effects.  Something like:
> 
> copy-on-write of hugetlb user pages with uncorrectable errors will result
> in a kernel crash.  This is because the copy is performed in kernel mode
> and in general we can not handle accessing memory with such errors while
> in kernel mode.  Commit a873dfe1032a ("mm, hwpoison: try to recover from
> copy-on write faults") introduced the routine copy_user_highpage_mc() to
> gracefully handle copying of user pages with uncorrectable errors.  However,
> the separate hugetlb copy-on-write code paths were not modified as part
> of commit a873dfe1032a.

Sounds good.  So I assume cc:stable is desirable.

I can't actually get the patch to apply to anything.  Can we please
have a redo against current -linus?


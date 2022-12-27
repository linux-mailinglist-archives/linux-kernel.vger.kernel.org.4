Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FCA656E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiL0T5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiL0T5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:57:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12662B6;
        Tue, 27 Dec 2022 11:57:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B8B6B810A9;
        Tue, 27 Dec 2022 19:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92810C433EF;
        Tue, 27 Dec 2022 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672171022;
        bh=ROrHr4rQEbBVSusuDkPZQbj47+FTbTSpcuR7ZWvb2vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tg4+zMABiHi8H6Q/nzPqPNkkol1qGThUhsrluFNxfLCFfR5Q9EvR8bmNktoqY8wF6
         xsbM1hVhvV0VbwzXriICD6BAA6dKggq4SmM3JqwDDhgei8Q6reYk8I/OUbkZIh9XJH
         S+RWr/y/TOipoc19PIAfzkhmNZPvjsBsWcUI/3Bs2cpuWU76lIsnU7eG53sIehYv8X
         WWhMn7gb7Ugxrg/QtPsKDS+ZOXSfWlF46zLRBx8eR2CO4ClGFnHU9GgM6IgO7En7on
         hEDdJxEs9YjUc1KGjYaA4EdbtMymEq/Y4pv+ERyzRRgUsfY6cJeUFtAbby56pZvgnh
         A8A7VRvup4NWA==
From:   SeongJae Park <sj@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com, paulmck@kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_reporting: replace rcu_access_pointer() with rcu_dereference_protected()
Date:   Tue, 27 Dec 2022 19:56:59 +0000
Message-Id: <20221227195659.2876-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y6tNnQvGGV+JVgC7@casper.infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 19:55:09 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Dec 27, 2022 at 07:21:58PM +0000, SeongJae Park wrote:
> > +++ b/mm/page_reporting.c
> > @@ -356,7 +356,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
> >  	mutex_lock(&page_reporting_mutex);
> >  
> >  	/* nothing to do if already in use */
> > -	if (rcu_access_pointer(pr_dev_info)) {
> > +	if (rcu_dereference_protected(pr_dev_info, true)) {
> 
> Pretty sure that passing a bare 'true' is an antipattern.
> Instead, document _what_ lock protects us, ie:
> 
> 	if (rcu_dereference_protected(pr_dev_info,
> 				      lockdep_is_held(&page_reporting_mutex))) {
> 
> Obviously, we took it just one line up, but if code moves around, it
> may save us.

Good point, agreed.  Will do so in the next version.


Thanks,
SJ

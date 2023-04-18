Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EFE6E6CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjDRTdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDRTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BCC7A94
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CC3660F77
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 19:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F298C433EF;
        Tue, 18 Apr 2023 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681846419;
        bh=X+5emsm5/XcM0QeOriAGVbzKqML6KnpuYnqauTGrAr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PVCaji7MVpWuFJdo47N9kdRSDsKscdneyyrEGnaFAcoEtPlG/TQvDttw4zVBPcm1H
         AtENa8f86w1D1W26qU9Tqd7UXzDCbL1Sn6PJ5AjLx8ahCE6+FG6NyJSjq2Cwu8EknG
         u5JOA/Az/AO8ixvecHnhIObLUgthorFGPFqpgYmg=
Date:   Tue, 18 Apr 2023 12:33:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: fix printk format within cma
Message-Id: <20230418123338.3b85a013cf6ce1fcb3677ae2@linux-foundation.org>
In-Reply-To: <ZD4QsGd0DwHa83K1@casper.infradead.org>
References: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com>
        <ZD4QsGd0DwHa83K1@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 04:38:24 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 18, 2023 at 11:33:09AM +0800, zhaoyang.huang wrote:
> > cma and page pointer printed via %p are hash value which make debug to be hard.
> > change them to %px.
> 
> Why does printing the page pointer make any sense at all?  Surely the
> PFN makes much more sense.

I suppose one could correlate a particular hashed pointer with other
debug output, see "ah, that's the same page".  In which case one
doesn't really care whether or not the address is hashed - it's just a
cookie.  This sounds thin.

I doubt if a lot of thought went into the printk.  If the page pointer
isn't useful then how about we simply remove it from the message?

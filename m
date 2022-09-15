Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFF5BA298
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 00:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIOWGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 18:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIOWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:06:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4335360530
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 15:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DD9AB8228F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F90BC43141;
        Thu, 15 Sep 2022 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663279558;
        bh=5AuXMPrrxHCjeEpEVmlQa1X18Cra5xVFNPnTzTbCTfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sQ9O3jns4bXmhBcs2Fk/RcP3O1IzTzfeKPfl9WehIy+4lnywJNrHea57Yag0I+f0j
         PDmmtVYeALVO399Dg+TiuLMrgu0JP2fdnO9z3LaJYUNWR6oYnfWg0dkxozledb3LWa
         VsUL+C9LtLWox6Iidn8lFaZj5NP6J0hA/zEyxCmE=
Date:   Thu, 15 Sep 2022 15:05:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: Re: [PATCHv2] mm: No need to check pcp page when free it to buddy
Message-Id: <20220915150557.90323a44dd1f9d33e5100350@linux-foundation.org>
In-Reply-To: <1663209654-14727-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1663209654-14727-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 10:40:54 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The pages on pcp list have been checked the validity via bellowing call chain.
> It is no need to check it again when free them back to buddy by free_pcppages_bulk.
> 
> free_unref_page\free_unref_page_list
> {
> ...
> 	//page's validity is checked here
> 	if (!free_unref_page_prepare(page, pfn, order))
> 		return;
> ...
> 	//page added to pcp->lists and status is ready for moving to buddy
> 	list_add(&page->lru, &pcp->lists[pindex]);
> 

The comment over free_pcp_prepare():

/*
 * With DEBUG_VM enabled, order-0 pages are checked immediately when being freed
 * to pcp lists. With debug_pagealloc also enabled, they are also rechecked when
 * moved from pcp lists to free lists.
 */

Which seems sensible - a page's state may have been messed up while
it's in the pcp lists.


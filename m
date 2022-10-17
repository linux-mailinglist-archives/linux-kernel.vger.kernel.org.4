Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20AA601DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJQXzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJQXzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:55:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D77DF68
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4985B81B81
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EC9C433D7;
        Mon, 17 Oct 2022 23:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666050942;
        bh=FWVxs/EBT34NoYhpfHxvCyPhbWyihGkkEtNt4KcjUGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BywyYc1jquVaPwVyqQDEEuYsdBmfW72u4WzGLeCOxS7QcZE4dln6r3MbT4AIxGBAP
         lzh3ki/P2n9olzPQJLCgPZISguSCRMJ0z768huSis/0RYlUCfgLVLWETgQB8DoxOsB
         Of2STBMdJbssr6yojL8+bf70uBWieaqAQJcxAOX4=
Date:   Mon, 17 Oct 2022 16:55:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     xu.xin.sc@gmail.com
Cc:     ran.xiaokai@zte.com.cn, yang.yang29@zte.com.cn,
        jiang.xuexin@zte.com.cn, imbrenda@linux.ibm.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v3 0/5] ksm: support tracking KSM-placed zero-pages
Message-Id: <20221017165541.6e2d3cebdc1ba13861ea4b2b@linux-foundation.org>
In-Reply-To: <20221011022006.322158-1-xu.xin16@zte.com.cn>
References: <20221011022006.322158-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 02:20:06 +0000 xu.xin.sc@gmail.com wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> use_zero_pages is good, not just because of cache colouring as described
> in doc, but also because use_zero_pages can accelerate merging empty pages
> when there are plenty of empty pages (full of zeros) as the time of
> page-by-page comparisons (unstable_tree_search_insert) is saved.
> 
> But there is something to improve, that is, when enabling use_zero_pages,
> all empty pages will be merged with kernel zero pages instead of with each
> other as use_zero_pages is disabled, and then these zero-pages are no longer
> managed and monitor by KSM, which leads to two issues at least:

Sorry, but I'm struggling to understand what real value this patchset
offers.

> 1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
>    unshare the shared zeropage as placed by KSM (which is against the 
>    MADV_UNMERGEABLE documentation at least); see the link:
>    https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/

Is that causing users any real-world problem?  If not, just change the
documentation?

> 2) we cannot know how many pages are zero pages placed by KSM when
>    enabling use_zero_pages, which leads to KSM not being transparent
>    with all actual merged pages by KSM.

Why is this a problem?

A full description of the real-world end-user operational benefits of
these changes would help, please.



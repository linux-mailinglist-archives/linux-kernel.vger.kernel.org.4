Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD896E2EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDOCwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOCwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5011126B8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 19:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XGuO69WtYg3FOioC8caWzcFVIlRUk5ATc1N/1b6YxYU=; b=RLqQE4ZlfFYK1ZP1Fd8ITikILx
        GAa3bUkiIz/xpcoRUmdIXUjYgblz+ZROCXu48Jb6oiltVbX8a5GI6qMKXTzY+NgsIF8b85a051cHU
        qx8lPAjPro8yjYn2D51WNT/Lg5nma8Jke1U7YRWuycKpya2F1fUtJ9q8hv2E2wgGxvCRMjDL4T55y
        ZiWsf0FHcqVyTgRxOpZQYViPk5/gkn2+Zh88wDEVClwRYG+S1lbTPpqza5PIsa4Iw2Adzv9Ay7f27
        lxk7Bh/gzNB/Peux8F1qztydZyOzm7SzQQw8on4K68WMWg9/OjmVoiOr0eFSnD/CBgp+0BQQpWpkw
        E8nI6/Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnW14-009Iav-RJ; Sat, 15 Apr 2023 02:51:54 +0000
Date:   Sat, 15 Apr 2023 03:51:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <ZDoRSlHiyIvAz+pR@casper.infradead.org>
References: <20230415003754.1852-1-sj@kernel.org>
 <20230415003754.1852-3-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415003754.1852-3-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 12:37:53AM +0000, SeongJae Park wrote:
>   *
> + * begin:
>   *  rcu_read_lock();
> - * again:
>   *  obj = lockless_lookup(key);
>   *  if (obj) {
>   *    if (!try_get_ref(obj)) // might fail for free objects
> - *      goto again;
> + *      goto begin;
>   *
>   *    if (obj->key != key) { // not the object we expected
>   *      put_ref(obj);
> + *      rcu_read_unlock();
>   *      goto again;

- *      goto again;
+ *      goto begin;


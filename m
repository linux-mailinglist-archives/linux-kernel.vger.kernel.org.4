Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54480670FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjARBSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjARBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:17:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E603CE2C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7268F615BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C26C433EF;
        Wed, 18 Jan 2023 01:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674004393;
        bh=fk4xm4Y+i17NbExuukutS9RENCIwEMlB9MvB7cPidDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=udnOuwa2DgChr43Fas+3JsfXU8FXPXmZZItIeMR1KQsKzFO3WKQnmx+Tn9YvGSK4M
         TC5XO+gDXnyi7PMjefEbaicTZy3MkIJuOS83b1yuQ734sk/0rwKYw6/PA3CPsGyS6u
         NZNH9QA02Rav+slBL3DsMdXkNS40OfeRqe5FPZXQ=
Date:   Tue, 17 Jan 2023 17:13:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     rppt@kernel.org, mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_ext: init page_ext early if there are no
 deferred struct pages
Message-Id: <20230117171312.13bdb3b2673bdac3c93c2ab7@linux-foundation.org>
In-Reply-To: <20230117204617.1553748-1-pasha.tatashin@soleen.com>
References: <20230117204617.1553748-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 20:46:17 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> page_ext must be initialized after all struct pages are initialized.
> Therefore, page_ext is initialized after page_alloc_init_late(), and
> can optionally be initialized earlier via early_page_ext kernel
> parameter which as a side effect also disables deferred struct pages.
> 
> Allow to automatically init page_ext early when there are no deferred
> struct pages in order to be able to use page_ext during kernel boot
> and track for example page allocations early.

Compilation blows up with CONFIG_PAGE_EXTENSION=n.  I did

--- a/include/linux/page_ext.h~mm-page_ext-init-page_ext-early-if-there-are-no-deferred-struct-pages-fix
+++ a/include/linux/page_ext.h
@@ -92,6 +92,7 @@ static inline struct page_ext *page_ext_
 
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;
+#define deferred_struct_pages (0)
 
 static inline bool early_page_ext_enabled(void)
 {

but it then blew up differently.

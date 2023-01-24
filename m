Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E49A67A42A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjAXUpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjAXUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:45:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EAE4FAD3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCAD7B816B7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2931EC4339B;
        Tue, 24 Jan 2023 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674593105;
        bh=x9mSUklrAV+WI1SjDDeOL740XIVyg2KNk0EDeh71PmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ktoPCjIar8FYAQBbdT94SfsFIp3xI7s/Hl+QX+pc1n52yYONEeoI2Jq4lkKx3luT4
         9PS1aOACTPW0IUjkI6z33CJfiO0N7XZr5iI1BkZin8Fl07RHhzF//9nXas48qsrRUU
         TywccEiI2ial3G0J3ypgUZi7Jcb82M9SeOasF3Gw=
Date:   Tue, 24 Jan 2023 12:45:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH mm] kasan: reset page tags properly with sampling
Message-Id: <20230124124504.2b21f0fde58af208a4f4e290@linux-foundation.org>
In-Reply-To: <24ea20c1b19c2b4b56cf9f5b354915f8dbccfc77.1674592496.git.andreyknvl@google.com>
References: <24ea20c1b19c2b4b56cf9f5b354915f8dbccfc77.1674592496.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 21:35:26 +0100 andrey.konovalov@linux.dev wrote:

> The implementation of page_alloc poisoning sampling assumed that
> tag_clear_highpage resets page tags for __GFP_ZEROTAGS allocations.
> However, this is no longer the case since commit 70c248aca9e7
> ("mm: kasan: Skip unpoisoning of user pages").
> 
> This leads to kernel crashes when MTE-enabled userspace mappings are
> used with Hardware Tag-Based KASAN enabled.
> 
> Reset page tags for __GFP_ZEROTAGS allocations in post_alloc_hook().
> 
> Also clarify and fix related comments.

I assume this is a fix against 44383cef54c0 ("kasan: allow sampling
page_alloc allocations for HW_TAGS") which is presently in mm-stable,
yes?



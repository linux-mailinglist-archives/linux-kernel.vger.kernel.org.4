Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00896C72E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCWWSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCWWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:18:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8DC1B2F2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19124627BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F79C433EF;
        Thu, 23 Mar 2023 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679609931;
        bh=O4Ru8fyq2qUax/RXRkWJCuIYSsBuJuIiR89K5Axpcu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kOBgCgRc8rQm1vntzgi5hLvvhvdE6Eqzr9aQp8n229iEe56JnICdaFMX08mh4vHBX
         LdBLr1tzqUYsqyoo65DUNxPLjx7I2JQ3ngE6bqPug9LmE6aWxgNSniozxkBYOczzui
         V+63CvojAZFdSoolrBOpiv3lVQGcUfGxvPtBCbC0=
Date:   Thu, 23 Mar 2023 15:18:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        jannh@google.com, sjpark@amazon.de, muchun.song@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kfence: fix handling discontiguous page
Message-Id: <20230323151850.e2785b1cff37fba078f26f2b@linux-foundation.org>
In-Reply-To: <20230323025003.94447-1-songmuchun@bytedance.com>
References: <20230323025003.94447-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 10:50:03 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The struct pages could be discontiguous when the kfence pool is allocated
> via alloc_contig_pages() with CONFIG_SPARSEMEM and !CONFIG_SPARSEMEM_VMEMMAP.
> So, the iteration should use nth_page().

What are the user-visible runtime effects of this flaw?

Thanks.

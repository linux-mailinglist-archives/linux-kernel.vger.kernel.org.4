Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA174B13D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGGMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGGMqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:46:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8511B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=epRwf36yVmCI0wCfpPMQq9jRILgggfDPrqVrqjBCaHU=; b=aRcME96TksAYGGy3xhnReI37vC
        5vl2uIBCN9A8Tje4vTHDc0G5gPxthtBsNPG/mabnhgWkLg1hh7FNtFbJ3LRVn1mr6aHBOXgCp1GKG
        6+EAsjOhy6AyH9NwB76t7ISQALA6g3SgxnG5fo998wq79otfqefffisrYYgPQMaNTW1LnPnF9gdyW
        uTTfX+xTnghYYA8ZnX7MwIJEH1fiRGelBGIe1F30FOTDbUYocTRS67jwjZRdkVhy04QhYMLWL9V2L
        EoWg6Y0BRKwSZYvkGogB3bYF+Hn4OU3LxHMuWa/IzLxEU1ekKD8vnAcuBXeDH51qUEpFrqlcMTs36
        4LZpzHpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHkqw-00C1ck-Ly; Fri, 07 Jul 2023 12:46:26 +0000
Date:   Fri, 7 Jul 2023 13:46:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, pintu.ping@gmail.com
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
Message-ID: <ZKgJIlqZk8cw4MBa@casper.infradead.org>
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:57:42PM +0530, Anshuman Khandual wrote:
> LGTM, cma->name is an identifying attribute for the region for which the allocation
> request was made. But how about using cma_get_name() helper instead ? Very few call
> sites have been using the helper.

It's not really a "helper", is it?  The function name is longer than
its implementation.

cma_get_name(cma)
vs
cma->name

Plus there's the usual question about whether a "got" name needs to be
"put" (does it grab a refcount?)

I think it's useful that this function exists since it lets us not expose
struct cma outside of mm/, but it really should be called cma_name()
and I don't think we should be encouraging its use within cma.c.

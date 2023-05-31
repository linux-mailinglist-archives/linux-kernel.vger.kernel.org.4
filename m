Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5048B717679
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjEaGBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaGBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:01:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238D11C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zXFbghN5Oa6JE4b5vk2VR/hhTLQNTSqD9OkNgOn3LKA=; b=TuRIxgkOysvpuskkTTblNke1x2
        8kQW9AYsK0NPuQbEbOOlw6j28RDvPbSLKVv6fgtoIhZqiYkI2Sp7+Y8ftXPOgADBxvXRhKzk80M/n
        VLtY7uzaFNz4w+PVyQWNb21eB2qoKbU5/cWNoGRJeIaJDyNz2OpV1e3GD8pvAvWcvaoBQ1kMS/y6P
        pnasDNYMf4NBE9pgIeHwNMz0kLd5hnRbG0x5EY8Jcaj1kZbCZPHiMNZL1dGstf8juU42KYY6ptoew
        qM1JwRApgGprj1omrt876fMzRLZ9zEzOoVdY5W7mIOrSNAyn2PSDC7wZ3EEUb9GTKaKnJQcW05UfL
        WVjPlK1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4EtA-00GEeU-2m;
        Wed, 31 May 2023 06:00:52 +0000
Date:   Tue, 30 May 2023 23:00:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: support exclusive loads
Message-ID: <ZHbilD8TbMF3+bWz@infradead.org>
References: <20230530210251.493194-1-yosryahmed@google.com>
 <20230530235447.GB102494@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530235447.GB102494@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:54:47PM -0400, Johannes Weiner wrote:
> Somewhat tangential, but is there still a point to the frontswap
> layer? It seems usecases other than zswap have never materialized, at
> least not in tree. Life would be a lot easier if we were to just
> hardcode the zswap callbacks in the swap functions.

I've been wanting to remove it for a while, as it really is rather
pointless.


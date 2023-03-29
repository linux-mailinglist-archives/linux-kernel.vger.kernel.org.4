Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80C6CD532
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjC2IvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjC2IvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:51:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B94495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e5tA8e6Rq5IwjYRoES39AKzgJsaOL1PNlGaNEuxuSls=; b=sWSd8GK8NgS3mwvhKkk5UU60DL
        6VYlzhrKeVpDukC3hI+hgNmvegOJXMWNu5TEn4Y1bJcdkeJ9/2Ut9HuA8o613+biAgpnBhJJIIf+Q
        lJOuoQtyvtNqE9lw/ScdNMnsNbMb0k0U9xjK2GoTaVapuWDpQ6phU6HTsZeRQYy+DNJcC9Wgnel9M
        F36iUDnN1NxYsmUUgVuLJCDxcRUb0FNRS8EJarc8scJCpectqbSfXYPFpxP82NuTsgPAZ8zJON/PL
        e11vkI/VLdfW6MjpK8dc0HQG0yjrrx1s7xoAzuvbB2F26R0tF6B7+YEgPHoghboChnIOrrndTXb4S
        VwPkVqYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phRVf-00HBUN-0H;
        Wed, 29 Mar 2023 08:50:23 +0000
Date:   Wed, 29 Mar 2023 01:50:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        NARIBAYASHI Akira <a.naribayashi@fujitsu.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: compaction: remove incorrect #ifdef checks
Message-ID: <ZCP7z7azbdzG254c@bombadil.infradead.org>
References: <20230329080248.2543492-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329080248.2543492-1-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:02:41AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_SYSCTL, the compiler warns about a few unused functions:
> 
> mm/compaction.c:3076:12: error: 'proc_dointvec_minmax_warn_RT_change' defined but not used [-Werror=unused-function]
> mm/compaction.c:2780:12: error: 'sysctl_compaction_handler' defined but not used [-Werror=unused-function]
> mm/compaction.c:2750:12: error: 'compaction_proactiveness_sysctl_handler' defined but not used [-Werror=unused-function]
> 
> The #ifdef is actually not necessary here, as the alternative
> register_sysctl_init() stub function does not use its argument, which
> lets the compiler drop the rest implicitly, while avoiding the warning.
> 
> Fixes: c521126610c3 ("mm: compaction: move compaction sysctl to its own file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks! Queued up.

  Luis

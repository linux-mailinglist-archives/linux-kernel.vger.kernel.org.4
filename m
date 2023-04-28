Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD36F163A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjD1K65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjD1K6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:58:53 -0400
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6E2706
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:58:52 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id AA120BEE95
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:58:50 +0100 (IST)
Received: (qmail 12660 invoked from network); 28 Apr 2023 10:58:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Apr 2023 10:58:50 -0000
Date:   Fri, 28 Apr 2023 11:58:48 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     wenyang.linux@foxmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Pintu Kumar <pintu@codeaurora.org>, Fu Wei <wefu@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: compaction: optimize compact_memory to comply
 with the admin-guide
Message-ID: <20230428105848.ghtz5v3q6mug4hiw@techsingularity.net>
References: <tencent_DFF54DB2A60F3333F97D3F6B5441519B050A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <tencent_DFF54DB2A60F3333F97D3F6B5441519B050A@qq.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 11:52:35PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> For the /proc/sys/vm/compact_memory file, the admin-guide states:
> When 1 is written to the file, all zones are compacted such that free
> memory is available in contiguous blocks where possible. This can be
> important for example in the allocation of huge pages although processes
> will also directly compact memory as required
> 
> But it was not strictly followed, writing any value would cause all
> zones to be compacted.
> It has been slightly optimized to comply with the admin-guide.
> Enforce the 1 on the unlikely chance that the sysctl handler is ever
> extended to do something different.
> 
> Commit ef4984384172 ("mm/compaction: remove unused variable sysctl_compact_memory")
> has also been optimized a bit here, as the declaration in the external header
> file has been eliminated, and sysctl_compact_memory also needs to be verified.
> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: William Lam <william.lam@bytedance.com>
> Cc: Pintu Kumar <pintu@codeaurora.org>
> Cc: Fu Wei <wefu@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/compaction.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c8bcdea15f5f..ba57d4178866 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1736,6 +1736,7 @@ static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNE
>   */
>  static unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
>  static int sysctl_extfrag_threshold = 500;
> +static int sysctl_compact_memory;
>  

__read_mostly but that aside, it's only used in
sysctl_compaction_handler so could also be declared as static within
that function. That way if CONFIG_SYSCTL is not set, it should be
guaranteed that the compiler does not save storage for it.

It's minor enough that With or without another version;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

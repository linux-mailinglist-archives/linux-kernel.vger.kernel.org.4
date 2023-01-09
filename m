Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF93663036
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjAITW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjAITWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:22:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A16C7CB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:22:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 314B7B80DAA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2AFC433EF;
        Mon,  9 Jan 2023 19:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673292170;
        bh=1nN5+8vpW7IEZWlJ5SAxUljzv4o1B741QRXt26soY7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eo/wJqgqrCF9C+wRp8CP4a9/NTfNfcMNw8C9PYuDJIrA4CBH+FD6MEXmbE0+67ifY
         FzsJOhpsDklYmeRTVQw5S0rFZP/E7R9Nvljj29dg305NaNcgZeXDXBO2DWJ2Tcq7Jl
         bdb5Fm0PtOuf4r+dwBCH7f5Rs00GlGId75Z66JbdxHLy74WkjeL+1teLIKAaqeC8Uk
         aV6U+N8PNPEH0eKoaMsDWpF9mYwwIuwxqYE2fdApA8oW50k3YJC9jMJRbOS3l8AahX
         WiHoGiFkkPn/XSdDSf0PbkLx4lfcFGCfljJ3/9CClzlf5jl5c8amuN0EYAcV+Y2oA3
         irnGHYGgrbjsg==
From:   SeongJae Park <sj@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] maple_tree: Fix handle of invalidated state in mas_wr_store_setup()
Date:   Mon,  9 Jan 2023 19:22:48 +0000
Message-Id: <20230109192248.55694-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109165455.647400-1-Liam.Howlett@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2023 16:55:42 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> If an invalidated maple state is encountered during write, reset the
> maple state to MAS_START.  This will result in a re-walk of the tree to
> the correct location for the write.
> 
> Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.org/
> Reported-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Tested-by: SeongJae Park <sj@kernel.org>

I confirmed this patch fixes the boot failure issue.  Nevertheless, the 'make
install' issue on my system is still not fixed.


Thanks,
SJ

> ---
>  lib/maple_tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 14cff87cf058..59c4879ac714 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5620,6 +5620,9 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
>  
>  static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
>  {
> +	if (unlikely(mas_is_paused(wr_mas->mas)))
> +		mas_reset(wr_mas->mas);
> +
>  	if (!mas_is_start(wr_mas->mas)) {
>  		if (mas_is_none(wr_mas->mas)) {
>  			mas_reset(wr_mas->mas);
> -- 
> 2.35.1
> 

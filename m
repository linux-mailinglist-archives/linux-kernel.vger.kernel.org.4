Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FB70EADC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbjEXBgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjEXBga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C714135
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:36:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2611E6359D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0FCC433D2;
        Wed, 24 May 2023 01:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684892187;
        bh=I2ozqFvCTggoEgIg06Ztdcvnq1LV8wq5Ff07A01+XXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgKFPbZOWSAEz+494/nPXUSZu8CWsD1wHOF+o2vQqQae6t+T6eSxLqJ9iF9KtWIXu
         DY1fHY0JMKQp9Jh8SQysGCpacoQZucwVjJ6RwSNDz/yUf4iyJzO6/5RoZ3iW4DjD1B
         XpsLKZu9LKoUqI4FoQvEn+Avs/JeA5hLfSrA1O2Ui/v+Gi4JH9b6BeCFJlHARxX8ru
         /iBV2FdlrdPp71PZQ79e2gimzwctJ9+q+BfCKsR07739oYLe7HkMgrFKeuwV+ZEFow
         VTqjmpwipNocDjLRqbCcnfrfUNqTlsoDXRp3Qjvubfv8SU8bO0ENoyBh9MeOwbOt49
         x2tnlnV/R7n3w==
Date:   Tue, 23 May 2023 18:36:25 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to use le32_to_cpu() in RAW_IS_INODE()
Message-ID: <ZG1qGd6smyKAmpdd@google.com>
References: <20230518092931.2280835-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518092931.2280835-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18, Chao Yu wrote:
> __le32 type variable should be converted w/ le32_to_cpu() before access.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7f6c51a6b930..a4bff3b5b887 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2840,7 +2840,11 @@ static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
>  		cond_resched();
>  }
>  
> -#define RAW_IS_INODE(p)	((p)->footer.nid == (p)->footer.ino)

Does this compare the same __le32 types?

> +static inline bool RAW_IS_INODE(struct f2fs_node *node)
> +{
> +	return le32_to_cpu(node->footer.ino) ==
> +			le32_to_cpu(node->footer.nid);
> +}
>  
>  static inline bool IS_INODE(struct page *page)
>  {
> -- 
> 2.40.1

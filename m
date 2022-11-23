Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA56368F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiKWSde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiKWScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:32:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB2C771
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:32:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D676D61E50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0D6C433C1;
        Wed, 23 Nov 2022 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669228354;
        bh=AYGlvKt7YQZqa65l3Od2pD7Mak2sH6QY21MH6d1v69g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4/2ZFeVg8PW9hGT8u5EsP81jLTaArTBB5I3qjZ50OZDoicQcEpQvvgMDEzc35TjK
         Gk/4Yr22sxtpwie2fDWGbmo4AjpODfXvgCxUSZWSNPlp6SY6iTPeRs0uOmARm0o8c+
         ZJLC6n5mr328mQ9MeF9z4KSs4OBwugFFOL+f2dcGvUL0SKcrsAEEsNVCZAb0DxyREy
         ZI3rEHJb6Cb0C4jZIw5TKvSR+DymO+rZhgXVcLdylssIKqa81dQqPBcNnCcHhVdlIU
         bMw+Oek5pqBHhNmpxcyQ4ovwoaNtonWecfUdNWHl1TSBtvHbrERp6nInwquQtwD+Mm
         mG+2cvbTj8pSw==
Date:   Wed, 23 Nov 2022 18:32:32 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce f2fs_is_readonly() for
 readability
Message-ID: <Y35nQMuFRqiln0En@gmail.com>
References: <20221123170153.15888-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123170153.15888-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 01:01:53AM +0800, Yangtao Li via Linux-f2fs-devel wrote:
> Introduce f2fs_is_readonly() and use it to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/f2fs.h  | 5 +++++
>  fs/f2fs/super.c | 5 ++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f0833638f59e..efc9d6d7b506 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4576,6 +4576,11 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
>  	}
>  }
>  
> +static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
> +{
> +	return !!f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
> +}

There is no need for the !! here.

- Eric

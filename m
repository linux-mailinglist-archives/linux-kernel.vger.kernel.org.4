Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307006EA198
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjDUCZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDUCZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F822D4C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025EB64D18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3561AC433D2;
        Fri, 21 Apr 2023 02:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682043948;
        bh=gv2fcUr9k+SVhnNR60lQ152rJtcbuooIqSiLervPK+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jxHs3XH9pzIAJ2mAwpNj6y4McYEsggAhz+PNhiDSJ2cvcSm2eKO8HPryRqJbF7xp0
         dR11YyKS1MwkKHT3iuYzLJ00l5sIm9hjR1lHjRx8XiPOjRzfeHf05aqX+QDrl+G9jK
         8KPzzyIsXxxjkbYrRpIEL1ekEPbyUl4RhG/+KuO02o23i4yZEGp9Uv/J/CpOgMpcYr
         VrHKEEs8bz9Har1Bspj6Z5AW6tgHqfSZYocp1yxv+7iwC248yEb0swbfkdA8HQaDWb
         rD2n2eFqloFZFicWmHP8ve92ocHV7sCKhaZUYQgBtvZbvnhHKU2xUR/7qQqSmwriom
         tv5hsCQv0/0dg==
Message-ID: <7735439b-7f9d-3344-8c7a-6d5ad2a6712b@kernel.org>
Date:   Fri, 21 Apr 2023 10:25:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate node blocks for atomic write
 block replacement
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230418174201.3274634-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230418174201.3274634-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/19 1:42, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When a node block is missing for atomic write block replacement, we need
> to allocate it in advance of the replacement.

Miss a fixes line?

Otherwise it looks good to me.

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/segment.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c35476b3c075..0e1e29800934 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -217,7 +217,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
>   
>   retry:
>   	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE_RA);
> +	err = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
>   	if (err) {
>   		if (err == -ENOMEM) {
>   			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);

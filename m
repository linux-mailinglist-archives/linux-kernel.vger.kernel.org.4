Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF376600F26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJQMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJQMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:24:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243141EC47
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A33036111E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D76C433C1;
        Mon, 17 Oct 2022 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666009436;
        bh=8V48uvPxGKFSi7OzFbIVPe2DEkGqM7SFVUeaOyfbN3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uvLmd6eyRhVc1yDiqwXpr/XUYCNldnt2B9A/92GqZe7Ze0R+KgWEw6dnNMi4NiIaF
         BxW4xq9n3USmmHZ+AZxOsTokKjpYMIapljvutoiuCIuufSmnHZrh2rkQTrj3MMjJH4
         oj3byZtSHBgheCOviq7KUqfL4NRFba4k29i2g0l93wvoyFlkAGFsKVqeDvf0Kti0hb
         ClNHb1s/0D6ax+gJTWpzaylm/ncqIfWi7GlIkzaIm3NkQNmHSsj+UYl+qoeCtkJtRk
         oW6CVlc0qmxI48gArUfgrfqFTi2YBcnwfpNsJWrvK3uadAERerZzYo25htTehhMS3U
         5SuFDJuO1OPzQ==
Message-ID: <39c430b1-f4f1-e0a7-1089-9db85d1163d9@kernel.org>
Date:   Mon, 17 Oct 2022 20:23:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] fs: f2fs: fix kernel discard_thread NULL dereference
Content-Language: en-US
To:     Hoi Pok Wu <wuhoipok@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <20221017100437.618363-1-wuhoipok@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221017100437.618363-1-wuhoipok@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 18:04, Hoi Pok Wu wrote:
> Pointer discard_thread is pointing to nowhere, using IS_ERR prevents the
> situation. IS_ERR also seen being used throughout the file.

I guess below patch can fix this issue from root cause?

https://lore.kernel.org/linux-f2fs-devel/20221013155628.434671-1-chao@kernel.org/T/#u

Thanks,

> 
> Link: https://syzkaller.appspot.com/bug?id=9499bc6574cea5940e48199c2fd0732d9b11e5e1
> Reported-by: syzbot+035a381ea1afb63f098d@syzkaller.appspotmail.com
> Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
> ---
>   fs/f2fs/segment.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..79978b7206b5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1634,7 +1634,8 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
>   		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
>   
>   		dcc->f2fs_issue_discard = NULL;
> -		kthread_stop(discard_thread);
> +		if (!IS_ERR(discard_thread))
> +			kthread_stop(discard_thread);
>   	}
>   }
>   

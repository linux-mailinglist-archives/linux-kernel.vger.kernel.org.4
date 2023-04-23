Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4E56EC0F3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDWQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 12:03:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B110EC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 09:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D65860F5D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 16:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E3FC433EF;
        Sun, 23 Apr 2023 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682265806;
        bh=/hdz+i+nYRUKEXgv7GQajTKcP8oCUU7AN+8fnhfL/Lw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=SdFpj43ZoMG9P2j5lQj3TR7F78PzqFBIA1ayhOux4OkMZ032BpxQpbvZaOwsVBuZW
         J38BShYDkcZiIOXN1+BvNXvXVtFlNgZu/aovvoSnvfP+Ay3Jg4Ifs0Y8xF3tnEnhwI
         KShPRLY+CAAmshhFeFRWBrI6XEzcSJoQoy8iaQyUVGmV4s+pilbdmJMwmA0UU18GQf
         hjVuq8kH7sOMZwa5knJINvFuwCoRQnpKCCteKCAn+QfhuQ9VIjECwUIfQZZHN4FhDQ
         8c9fdIF8e47SSzCURY5HnJ3zh9JxGK6SPsWQe7bBXpmC4AFn24+WXxXIT8pDvVqd2/
         GsEmfCZbyV+Fw==
Message-ID: <99c955da-6551-dd63-6587-7f515dd5be32@kernel.org>
Date:   Mon, 24 Apr 2023 00:03:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230406193716.70796-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add sanity check for proc_mkdir
In-Reply-To: <20230406193716.70796-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 3:37, Yangtao Li wrote:
> Return -ENOMEM when proc_mkdir failed.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/sysfs.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 3aad3500a701..dcd497e0920a 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1385,12 +1385,19 @@ int __init f2fs_init_sysfs(void)
>   
>   	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
>   				   NULL, "features");
> -	if (ret) {
> -		kobject_put(&f2fs_feat);
> -		kset_unregister(&f2fs_kset);
> -	} else {
> -		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
> +	if (ret)
> +		goto put_kobject;
> +
> +	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
> +	if (!f2fs_proc_root) {

How about removing below check for f2fs_proc_root in f2fs_register_sysfs()?

	if (f2fs_proc_root)
		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);

Thanks,

> +		ret = -ENOMEM;
> +		goto put_kobject;
>   	}
> +
> +	return 0;
> +put_kobject:
> +	kobject_put(&f2fs_feat);
> +	kset_unregister(&f2fs_kset);
>   	return ret;
>   }
>   

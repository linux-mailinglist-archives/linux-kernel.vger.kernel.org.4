Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CBE72C822
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbjFLOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbjFLOWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719281996
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 296EE629FB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B960FC4339B;
        Mon, 12 Jun 2023 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579500;
        bh=ilN1/jTNe0GA6pB/SlZ9PiNSr53z2qsAMGgSkLjTC2w=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=sDMPNCtc0puIdJWz86xkxsdXNL19AE4EeVwLS/TyXZOr2t4P2/4Im0P2qECC30mDP
         tm4DDNx3P33+vPFwlWlJLludG8YoYq+00Yyj4s87yhihKig8YEA/HtXbG9oH0VsoJb
         x6qV1O1I4eblUs1+Qes/NOqAysPeciTTpYs7kXxryqySCwqITm22QDxY48FQshiOGS
         22PpbsfSiQGZotypAGtQgNuSbVKMFohjb4UY+veEVG7/bqkNuEaP90dBbqyjKhVxZ6
         UGzm2a+zLdaVNRPxloxjtB2aaADN3DKtoXD1rM/VkIBHJoZIIlBKuMmGIUzbxr+bWI
         i/HmVoQEQWMXg==
Message-ID: <7af0f599-2314-56af-2813-5e63754134e1@kernel.org>
Date:   Mon, 12 Jun 2023 22:18:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress tmp files given extension
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230606203645.3926651-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/7 4:36, Jaegeuk Kim wrote:
> Let's compress tmp files for the given extension list.

Could you please check below commit? IIRC, it was introduce to avoid compressing
file which has unpredictable tmp file, e.g. foo.sox.

Could you please describe the case you encounter?

commit 4a67d9b07ac8dce7f1034e0d887f2f4ee00fe118
Author: Chao Yu <chao@kernel.org>
Date:   Tue May 18 17:54:58 2021 +0800

     f2fs: compress: fix to disallow temp extension

     This patch restricts to configure compress extension as format of:

      [filename + '.' + extension]

     rather than:

      [filename + '.' + extension + (optional: '.' + temp extension)]

     in order to avoid to enable compression incorrectly:

     1. compress_extension=so
     2. touch file.soa
     3. touch file.so.tmp

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 3e35eb7dbb8f..cdc94c8e60f7 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -161,7 +161,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
>   
>   	/* Compress wanting extension. */
>   	for (i = 0; i < ext_cnt; i++) {
> -		if (is_extension_exist(name, ext[i], false)) {
> +		if (is_extension_exist(name, ext[i], true)) {
>   			set_compress_context(inode);
>   			return;
>   		}

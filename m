Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A660C49B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiJYHB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJYHBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA07539E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 412016178A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A9AC433B5;
        Tue, 25 Oct 2022 07:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666681278;
        bh=4PYxQh+Qd9S4hsYLOGM4p4PEH3DXxAlrzkcdULK3UMw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nMBzcXK5kpUmQ++BIkuyPzhy7M0Y6Fm1bzkMfrg5/vyXtGaO3R4nFAAotqXbjb/B4
         nHySbdd/PlFrOMcWL9CGFKxYNWxVLLKr1Pwvg1eGzmn+aOfkMZGFJcj4Pkf03NxD4x
         DBIKnbSy/8z0o0Ld1NogDKfDveYK078HCALP9ptKYeXWzLbxW1Tz4Y4zLrAy46tAKi
         l0H3+jUqqf/nwA8ITqc4GYgdjYBuqAxlpqA8EvAU7NrDBEY/EnF3q4YZGqIH1BWqfV
         SDYI2xfF3W63SRcT3grIK9J6LF6ylokCAtdNp70p8H02C2PjuFex7qFQ+9iQKycGcS
         UL3RX03iBjuHA==
Message-ID: <bfae3198-7557-f984-200c-2c677881f462@kernel.org>
Date:   Tue, 25 Oct 2022 15:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: remove redundant return in
 f2fs_create_flush_cmd_control()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221024135943.76120-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221024135943.76120-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/24 21:59, Yangtao Li wrote:
> Replace
> 	if (A) {
> 		......
> 		return err;
> 	}
> 	return err;
> with
> 	if (A) {
> 		......
> 	}
> 	return err;
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..f6f16d691226 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -647,7 +647,6 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   		err = PTR_ERR(fcc->f2fs_issue_flush);
>   		kfree(fcc);
>   		SM_I(sbi)->fcc_info = NULL;
> -		return err;
>   	}
>   
>   	return err;

It may looks more clean if it return 0 here?

Thanks,


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8576260F90E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiJ0NbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiJ0NbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4140EC508
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F9062311
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68757C433C1;
        Thu, 27 Oct 2022 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666877468;
        bh=nYDbxu1bhOneACR7AmCTTyuASVG29Q2OMg11MLfO52o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WPkFQFaXci1RVAACJDfVHY3yKsUP+t6tRQnDQRNaNw76u/C8uX5gwAlHUM4cTAaXk
         D2glN7dj1PEv3xnMbMQTiKrOEvAZz/L1AFEUmFpapoFSdchpYuRYBN8zADwmpHII+3
         pOgTehG+K/EVkejcznDUvS6o89A19dDwCpAAOMImIhvOhpzMXoqldjxCMSTuE0Z4cg
         m8lRaIhc3/GlDvNTZ/mHJsRg2OR1wCobzVBEHeuEFgsIEqYr23dzEslgRb8jhDYs6t
         s/nI6GzWkRFzUopiFH9bnxjEDQcb45y2mpW1p+ELP2DRcCZAVZb+qyS9NvL4xdXpKh
         Iw1bfWqdIPUwg==
Message-ID: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
Date:   Thu, 27 Oct 2022 21:31:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error when
 errors=remount-ro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221027120807.6337-1-frank.li@vivo.com>
 <20221027120807.6337-3-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221027120807.6337-3-frank.li@vivo.com>
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

On 2022/10/27 20:08, Yangtao Li wrote:
> When a fatal error occurs in the file system and it is
> remounted to ro mode, the flush thread needs to be stopped.
> 
> Fixes: d81ab30e85a5 ("f2fs: support errors=remount-ro|continue|panic mountoption")

Do you mind letting me merge these two patches into original patch?
since original patch is still in dev branch, rather than mainline.

I guess it needs to stop ckpt thread as well...

Thanks,

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc220b5c5599..3a1238a82dc9 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4017,6 +4017,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>   
>   	f2fs_stop_gc_thread(sbi);
>   	f2fs_stop_discard_thread(sbi);
> +	f2fs_stop_flush_thread(sbi);
>   }
>   
>   static void f2fs_record_error_work(struct work_struct *work)

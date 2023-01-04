Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F1665DCA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbjADTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjADTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:20:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ADDCC5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98315617EB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAA6C433EF;
        Wed,  4 Jan 2023 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672860021;
        bh=LpiVGTpm8ApY3OR3JbRwYHLopeoTKEw6B1JHMX4gXiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbdkcoCwzuuXfX7vSc31lbbGKZU9AZsXOaw4pd8z4VulQmx1Ys3VVEZcSDx4xM+At
         iyxONlbK25qxA85djRVAecg2l84tbSlsAac+btL+SspzzEIEmmoHW5/VgX4Fa9ojK2
         MOP6ErLXZlI1Mlc/DCJmKItahxo22TgGV3g2Hf3g3CKev1kICa5XoT9+QPZWPwUOl3
         962x9qRBNw3ypwK3axNQPsezeeXDmXiKrQzwbhYxz+EVsk0smyLka98YVnMPaK4gBZ
         zpxesLin9HIKqxYwu7CPIThTuLrNre3H+3isgyvs/MVBcdDgiBx/req2+8PWrs/Nd3
         wA+W4FpFVE7EQ==
Date:   Wed, 4 Jan 2023 11:20:19 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: reset iostat_count in f2fs_reset_iostat()
Message-ID: <Y7XRc+UiLBF/m3KW@google.com>
References: <20230104112158.15844-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104112158.15844-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

These are all in dev-test branch, which means you don't need to stack up more
patches on top of it. I just integrated most of them into two original patches.
Could you please take a look at this?

c1706cc0cd72 f2fs: add iostat support for flush
acd6f525e01c f2fs: support accounting iostat count and avg_bytes

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

Thanks,

On 01/04, Yangtao Li wrote:
> Commit 8754b465c249 ("f2fs: support accounting iostat count and avg_bytes")
> forgot to reset iostat count in f2fs_reset_iostat(), let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/iostat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index c53b62a7ca71..8460989e9bab 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -220,6 +220,7 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
>  
>  	spin_lock_irq(&sbi->iostat_lock);
>  	for (i = 0; i < NR_IO_TYPE; i++) {
> +		sbi->iostat_count[i] = 0;
>  		sbi->rw_iostat[i] = 0;
>  		sbi->prev_rw_iostat[i] = 0;
>  	}
> -- 
> 2.25.1

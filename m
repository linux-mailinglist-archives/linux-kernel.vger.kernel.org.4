Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892266F09C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbjD0QV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0QV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:21:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4273C0B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD71F63C3E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBCFC433D2;
        Thu, 27 Apr 2023 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682612516;
        bh=AlPlL2WN8U77bcV2QwI4i9S22AkfDR+RGnDs6yrBa5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ra9FPE4X/HSWMCcHnQye/Er4ASReRPGoU+Jsk8zWPZ1rUfCa3fo6f9CjYFWmj6U+/
         M+EiC6K5K5kFKvDXpv2+fBz7QsJxaIDJNkmBVBmyEtIxpf51ZiYX4szyo6xQpAAots
         S3g0zyq7LGEhtt28wpmT/mEfAE3S1mZo+RNLWThM1G8lGzfGg+qx1ubmJmjSNk/7lZ
         sNiApWh+gyXSoSfU+qmwhZ52YZGDq/pOK/X2whd1okKkrqJrqdCLKwEfVWP0uCx29i
         mtJ8Kxl4iQAXZkDeUn4jtbO4iN9nnlnW13bVSPsRqGIQqV9aHNArjVwV6vdjDYHZ/e
         LKh+UlIaBr/gQ==
Date:   Thu, 27 Apr 2023 09:21:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Daeho Jeong <daehojeong@google.com>, Qi Han <hanqi@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: do not allow to defragment files have
 FI_COMPRESS_RELEASED
Message-ID: <ZEqhImQzKJJSNLNZ@google.com>
References: <20230425164711.19826-1-frank.li@vivo.com>
 <1a602371-d9b0-7148-c916-a02c40649d53@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a602371-d9b0-7148-c916-a02c40649d53@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Chao Yu wrote:
> On 2023/4/26 0:47, Yangtao Li wrote:
> > If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> > allowed.
> > 
> > Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> > Signed-off-by: Qi Han <hanqi@vivo.com>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> Oh, I just see v2.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Applied with using goto for code consistency.

+       if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+               err = -EINVAL;
+               goto unlock_out;
+       }
+
        /* if in-place-update policy is enabled, don't waste time here */
        set_inode_flag(inode, FI_OPU_WRITE);
        if (f2fs_should_update_inplace(inode, NULL)) {
@@ -2712,6 +2717,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
        clear_inode_flag(inode, FI_SKIP_WRITES);
 out:
        clear_inode_flag(inode, FI_OPU_WRITE);
+unlock_out:
        inode_unlock(inode);
        if (!err)
                range->len = (u64)total << PAGE_SHIFT;

> 
> Thanks,

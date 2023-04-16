Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372386E392E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjDPOYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDPOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90687210B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D115611A1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8173C433D2;
        Sun, 16 Apr 2023 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655055;
        bh=s6j+cFhC+fFisG2k+MvYEAPar5ATW7KdlOagLT/oLHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X6q1KM1wnWWVtUYy5Y6dH7XHBb2fpJSWWvAi48hJZQfdCeymHBRiMPwiH+ftQeub6
         IyIR4D/xgkQMZ2FRCmjFtEIBc0ty9zCNU8dOa6LET5PLhxM80LdmBruMZNVAMJ9NhZ
         radlqllVmdEMnVMA80qxJPFWtObsyGRs+HVKuBL7YM0rCWqHFqrMEjwTWh67r3sV6v
         n9MNBF0KTtclamfuqGjfj3PM3hhnQdH8FPlrFVQ6bAA3er+NxxQq6mih9UXqtXOuj7
         QEY4Ipfgy+5I8jE4NxqhYajRwAk9wbKUeOr7BwAdwsND7ITNVD3T+3JSR1/fbtWk+L
         e1kdwwqVb2VIg==
Message-ID: <815ed5d3-efae-9d18-b2b5-e56bb196ffda@kernel.org>
Date:   Sun, 16 Apr 2023 22:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/7] erofs: introduce long xattr name prefixes feature
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 22:17, Jingbo Xu wrote:
> Background
> =========
> overlayfs uses xattrs to keep its own metadata.  If such xattrs are
> heavily used, such as Composefs model [1], large amount of xattrs
> with diverse xattr values exist but only a few common xattr names
> are valid (trusted.overlay.redirect, trusted.overlay.digest, and
> maybe more in the future) . For example:
> 
> # file 1
> trusted.overlay.redirect="xxx"
> 
> # file 2
> trusted.overlay.redirect="yyy"
> 
> That makes the existing predefined prefixes ineffective in both image
> size and runtime performance.
> 
> Solution Proposed
> ====================
> Let's introduce long xattr name prefixes now to fix this.  They work
> similarly as the predefined name prefixes, except that long xattr name
> prefixes are user specified.
> 
> When a long xattr name prefix is used, the shared long xattr prefixes
> are stored in the packed or meta inode, while the remained trailing part
> of the xattr name apart from the long xattr name prefix will be stored
> in erofs_xattr_entry.e_name.  e_name is empty if the xattr name matches
> exactly as the long xattr name prefix.
> 
> Erofs image sizes will be smaller in the above described scenario where
> all files have diverse xattr values with the same set of xattr names[2],
> such as having following xattrs like:
> 
> trusted.overlay.metacopy=""
> trusted.overlay.redirect="xxx"
> 
> Here are the image sizes for comparison (32-byte inodes are used):
> 
> ```
> 7.4M  large.erofs.T0.xattr
> 6.4M  large.erofs.T0.xattr.share
> ```
> 
> - share: "--xattr-prefix=trusted.overlay.redirect" option of mkfs.erofs.
> w/ this option, the long xattr name prefixes feature is enabled.
> 
> It can be seen ~14% disk space is saved with this feature in this
> typical workload, therefore metadata I/Os could also be more effective
> then.
> 
> Test
> ====
> It passes erofs/019 of erofs-utils.
> 
> 
> [1] https://lore.kernel.org/all/CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com/
> [2] https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i
> 
> 
> 
> Gao Xiang (1):
>    erofs: keep meta inode into erofs_buf
> 
> Jingbo Xu (6):
>    erofs: initialize packed inode after root inode is assigned
>    erofs: move packed inode out of the compression part
>    erofs: introduce on-disk format for long xattr name prefixes
>    erofs: add helpers to load long xattr name prefixes
>    erofs: handle long xattr name prefixes properly
>    erofs: enable long extended attribute name prefixes

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

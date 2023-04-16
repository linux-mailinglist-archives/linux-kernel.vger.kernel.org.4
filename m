Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5961F6E3910
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjDPOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB11BF8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD7760EA8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66491C433D2;
        Sun, 16 Apr 2023 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681654099;
        bh=ayfPSItOfFk4TQ7c63fW3LnrbPB2BuMo6DU7rxoTrCA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VMkhug+kVu/kyJxgTkqUl6yJ0sghB4L3Tk7zEkwGWH979coou288mUcnRivlBsp6i
         mMkoPTbYGiO0Kz36IgkhCa5am9cPc40gChl3ohBN4UlW2A2eAtxteoU9tC/AggI0aK
         Whr4upxppwsRicmZYe5W7Q9yzUZO7g7fnfsRR5MIpRNtgyM2crIpIKzYJnr3WGVVDI
         eDZFVhFgMwyrxxe9yn5nzPabOfhHHDT6xUm4lz0IhBajHr9RmE0jvaqVb6kR2qfKkg
         fWXyzj8utxdUgSrlVeoQ++oLEK1N/Ka2B/XYen16fxfUrzJVkVn2ayfgebxVsjcvDp
         wAZavjkt0zQeQ==
Message-ID: <75010857-7766-8196-77d4-24bb688ccb5c@kernel.org>
Date:   Sun, 16 Apr 2023 22:08:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 1/2] erofs: avoid hardcoded blocksize for subpage block
 support
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230313135309.75269-1-jefflexu@linux.alibaba.com>
 <20230313135309.75269-2-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230313135309.75269-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/13 21:53, Jingbo Xu wrote:
> As the first step of converting hardcoded blocksize to that specified in
> on-disk superblock, convert all call sites of hardcoded blocksize to
> sb->s_blocksize except for:
> 
> 1) use sbi->blkszbits instead of sb->s_blocksize in
> erofs_superblock_csum_verify() since sb->s_blocksize has not been
> updated with the on-disk blocksize yet when the function is called.
> 
> 2) use inode->i_blkbits instead of sb->s_blocksize in erofs_bread(),
> since the inode operated on may be an anonymous inode in fscache mode.
> Currently the anonymous inode is allocated from an anonymous mount
> maintained in erofs, while in the near future we may allocate anonymous
> inodes from a generic API directly and thus have no access to the
> anonymous inode's i_sb.  Thus we keep the block size in i_blkbits for
> anonymous inodes in fscache mode.
> 
> Be noted that this patch only gets rid of the hardcoded blocksize, in
> preparation for actually setting the on-disk block size in the following
> patch.  The hard limit of constraining the block size to PAGE_SIZE still
> exists until the next patch.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

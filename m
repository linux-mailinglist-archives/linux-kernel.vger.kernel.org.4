Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81736E3912
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjDPOJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A71BEE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5AF60DFF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 14:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3882C433EF;
        Sun, 16 Apr 2023 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681654174;
        bh=CZbs+Oo/9VcJDCyqKQM4i7CGLF3MOsS+63CPee2VFD8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=r9iK4iHqrEYnmRxTCYzjvjWyfqf6/YJCn23OAmmGUaC8wiP/KTVcspU91N+5/KbxI
         QkRzM6kHMzvoklvhIGeQVtlXxWgVm4QqIwkpCyLqxJprFvzLtbMKpQdaOWYLuNXQxO
         oUM2Do+YAlWdBFTsxocbz2Lta89uFZ34bK4Wb5FyHtMBnwvPICHKsSCP+JfN/fEZM1
         h58cE/lATTODdp9qKr2xIqKqXPjTTrett1DmQxxrrrlfvqEBypLrSidmOT3FPBFzxd
         +qskagLD13RxU1KizAl6WGK12X/HpFhlJ/dbQnKiPeWCv6IuszNTz7lTmerh5Hgm/I
         6D/45z6NV+fMQ==
Message-ID: <87dc51ef-35d2-6ae9-6e56-667bbc04526c@kernel.org>
Date:   Sun, 16 Apr 2023 22:09:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 2/2] erofs: set block size to the on-disk block size
Content-Language: en-US
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230313135309.75269-1-jefflexu@linux.alibaba.com>
 <20230313135309.75269-3-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230313135309.75269-3-jefflexu@linux.alibaba.com>
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
> Set the block size to that specified in on-disk superblock.
> 
> Also remove the hard constraint of PAGE_SIZE block size for the
> uncompressed device backend.  This constraint is temporarily remained
> for compressed device and fscache backend, as there is more work needed
> to handle the condition where the block size is not equal to PAGE_SIZE.
> 
> It is worth noting that the on-disk block size is read prior to
> erofs_superblock_csum_verify(), as the read block size is needed in the
> latter.
> 
> Besides, later we are going to make erofs refer to tar data blobs (which
> is 512-byte aligned) for OCI containers, where the block size is 512
> bytes.  In this case, the 512-byte block size may not be adequate for a
> directory to contain enough dirents.  To fix this, we are also going to
> introduce directory block size independent on the block size.
> 
> Due to we have already supported block size smaller than PAGE_SIZE now,
> disable all these images with such separated directory block size until
> we supported this feature later.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

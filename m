Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669BC6FB0A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjEHMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjEHMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:52:11 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01693919D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:52:09 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 2AE0021BF;
        Mon,  8 May 2023 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1683550041;
        bh=MTkVDPtwpPHlQ+nRozozPPCCu4cYcS5QQQYLuEJra4Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HNNqqO7lEwFAAqEsFFyqau6gVxSMMP3KJlVeNpK7rkGg8Y4tAJfLUqtwLfJXmyW6O
         ZtQNm9wE77NvjjQmrH9iMvGFYg6l7jpR1BEZ7c/iech1k655AYP+rdJwg1zP+Ep/wK
         5jihaIznu7ongtH+xQGNrn8G4eD3wE55n1CoT+pg=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 8 May 2023 15:52:07 +0300
Message-ID: <2afb5a8f-470d-3a4a-6ec0-de0325ebd7c8@paragon-software.com>
Date:   Mon, 8 May 2023 16:52:06 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] fs/ntfs3: use wrapper i_blocksize() in
 ntfs_zero_range()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, <jack@suse.com>,
        <dushistov@mail.ru>, <brauner@kernel.org>, <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>
References: <20230310030821.66090-1-frank.li@vivo.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20230310030821.66090-1-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.03.2023 07:08, Yangtao Li wrote:
> Convert to use i_blocksize() for readability.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/ntfs3/file.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index e9bdc1ff08c9..9d6ff29de441 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -178,7 +178,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
>   {
>   	int err = 0;
>   	struct address_space *mapping = inode->i_mapping;
> -	u32 blocksize = 1 << inode->i_blkbits;
> +	u32 blocksize = i_blocksize(inode);
>   	pgoff_t idx = vbo >> PAGE_SHIFT;
>   	u32 from = vbo & (PAGE_SIZE - 1);
>   	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -192,7 +192,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
>   		page_off = (loff_t)idx << PAGE_SHIFT;
>   		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
>   						     : PAGE_SIZE;
> -		iblock = page_off >> inode->i_blkbits;
> +		iblock = page_off / i_blocksize(inode);
>   
>   		page = find_or_create_page(mapping, idx,
>   					   mapping_gfp_constraint(mapping,
Thank you for the patch. We have partially accepted it due to 
performance concerns.

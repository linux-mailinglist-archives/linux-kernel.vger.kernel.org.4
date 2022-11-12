Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE2626AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiKLSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:09:43 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C63EB7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 10:09:42 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id ED8BD1FE4;
        Sat, 12 Nov 2022 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276409;
        bh=vIDSTmGfDYRWrkxZRsf26qzCp40g24+lWhiwN4Bq6vo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AQM6LM1f8Xx55H5wDnVculPAjZ1dgIJAzJKgjhE78B1vrFZX9ptjmSBHPS1oXL5UV
         mzSwmK/7BRWopf7h8Bhm0LRplOw6y+0URL/fSdqgQPStl22PGcagQ/J0NM9PB0nEF5
         OBJJhCxhF9I80OZrkC2QgiVQDkP2sUkxQtRQ6JJM=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 12 Nov 2022 21:09:40 +0300
Message-ID: <1ddcbb4a-ce49-a4a1-f8c2-a2896f3b2451@paragon-software.com>
Date:   Sat, 12 Nov 2022 21:09:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ntfs3: Validate attribute data and valid sizes
Content-Language: en-US
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <skhan@linuxfoundation.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com>
References: <000000000000c2333105e9cc7b1c@google.com>
 <20221004031502.20007-1-abdun.nihaal@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221004031502.20007-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/22 06:15, Abdun Nihaal wrote:
> The data_size and valid_size fields of non resident attributes should be
> less than the its alloc_size field, but this is not checked in
> ntfs_read_mft function.
> 
> Syzbot reports a allocation order warning due to a large unchecked value
> of data_size getting assigned to inode->i_size which is then passed to
> kcalloc.
> 
> Add sanity check for ensuring that the data_size and valid_size fields
> are not larger than alloc_size field.
> 
> Link: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
> Reported-and-tested-by: syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
> Fixes: (82cae269cfa95) fs/ntfs3: Add initialization of super block
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>   fs/ntfs3/inode.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index e9cf00d14733..9c244029be75 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -132,6 +132,13 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>   	if (le16_to_cpu(attr->name_off) + attr->name_len > asize)
>   		goto out;
>   
> +	if (attr->non_res) {
> +		t64 = le64_to_cpu(attr->nres.alloc_size);
> +		if (le64_to_cpu(attr->nres.data_size) > t64 ||
> +		    le64_to_cpu(attr->nres.valid_size) > t64)
> +			goto out;
> +	}
> +
>   	switch (attr->type) {
>   	case ATTR_STD:
>   		if (attr->non_res ||

Applied, thanks again for patch!

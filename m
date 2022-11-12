Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4F626AF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 19:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiKLSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiKLSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:06:57 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2914018
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 10:06:56 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9D47E1FA3;
        Sat, 12 Nov 2022 18:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276242;
        bh=ubvpp8eY3ZBpWpSMkiVtfbkHoNBryibhA74KcSTpYps=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=H56jZdHrbD8ibwYp5dzWsKmSe/TTfgKgpgKf9dpq8An4UUPPwva9kDSTRX8smFTOc
         JqXzsVEAQOWlwXIWRD+RwRUa6jBSYh4oC/M1g891QHRU1MhDgBJzJtXpnbIdajL9Jh
         KFyyRav3+9v7h9xC2tHTot4ji4Ftxf0vDc4wspE8=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5E42A26;
        Sat, 12 Nov 2022 18:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276414;
        bh=ubvpp8eY3ZBpWpSMkiVtfbkHoNBryibhA74KcSTpYps=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lwgMmLobXM4Vf1JDdqOHo/52PEHasLu9HhOhpTJR+oMYFkX6Z0CS+BjB/DkQHrsjB
         aatqHbYirco7EV3BbiuP27JiAoZr8CfTcegl3VSz//vAGH+SzZ957MzSLOzDmOtJM3
         83yVIHiqPyOb6Ie0kbkMqEVNtU/aJsuKkIki2Ano=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 12 Nov 2022 21:06:54 +0300
Message-ID: <3399a999-4503-d4f9-d7dd-82a2c18a1a40@paragon-software.com>
Date:   Sat, 12 Nov 2022 21:06:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ntfs3: Fix slab-out-of-bounds read in ntfs_trim_fs
Content-Language: en-US
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <skhan@linuxfoundation.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <syzbot+b892240eac461e488d51@syzkaller.appspotmail.com>
References: <20221001070024.1366018-1-abdun.nihaal@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221001070024.1366018-1-abdun.nihaal@gmail.com>
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



On 10/1/22 10:00, Abdun Nihaal wrote:
> Syzbot reports an out of bound access in ntfs_trim_fs.
> The cause of this is using a loop termination condition that compares
> window index (iw) with wnd->nbits instead of wnd->nwnd, due to which the
> index used for wnd->free_bits exceeds the size of the array allocated.
> 
> Fix the loop condition.
> 
> Fixes: 3f3b442b5ad2 ("fs/ntfs3: Add bitmap")
> Link: https://syzkaller.appspot.com/bug?extid=b892240eac461e488d51
> Reported-by: syzbot+b892240eac461e488d51@syzkaller.appspotmail.com
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>   fs/ntfs3/bitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
> index 1675c9a69788..629c1ee97268 100644
> --- a/fs/ntfs3/bitmap.c
> +++ b/fs/ntfs3/bitmap.c
> @@ -1424,7 +1424,7 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
>   
>   	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
>   
> -	for (; iw < wnd->nbits; iw++, wbit = 0) {
> +	for (; iw < wnd->nwnd; iw++, wbit = 0) {
>   		CLST lcn_wnd = iw * wbits;
>   		struct buffer_head *bh;
>   

Thanks for patch, applied!

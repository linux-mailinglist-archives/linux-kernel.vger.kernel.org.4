Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0106563AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiLZPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 10:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLZPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 10:04:40 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B1D2AFC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 07:04:38 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 850B72112;
        Mon, 26 Dec 2022 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672066867;
        bh=Mwj50PbPOzH4V7RtccJj3Vb5q71wQ/ygotgnXgchirk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=THALBGxwnCkLMqfXjL5pgoi7/PsqtdAcBJRfA0uNMdclhluNVDFQE5IwLzCsPEqs9
         HEpmcwWWzuTljjy7hSWdvk3sEN59B/ZV/dz08guykvfjq6b0AkMmqtqQoK7SxGirGO
         g855OXnLV9Qm2vnI0a6hZdRHrCIGDa+A68jXxVgw=
Received: from [192.168.211.153] (192.168.211.153) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 26 Dec 2022 18:04:36 +0300
Message-ID: <0bf7a140-1405-2b07-4d29-d593d9507c33@paragon-software.com>
Date:   Mon, 26 Dec 2022 19:04:35 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Add check for kmemdup
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <trix@redhat.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
References: <20221123084846.2703-1-jiasheng@iscas.ac.cn>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221123084846.2703-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.153]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.2022 12:48, Jiasheng Jiang wrote:
> Since the kmemdup may return NULL pointer,
> it should be better to add check for the return value
> in order to avoid NULL pointer dereference.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   fs/ntfs3/fslog.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 0d611a6c5511..eb7cf8a69607 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -4277,6 +4277,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>   	rec_len -= t32;
>   
>   	attr_names = kmemdup(Add2Ptr(lrh, t32), rec_len, GFP_NOFS);
> +	if (!attr_names) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>   
>   	lcb_put(lcb);
>   	lcb = NULL;
Thank you for your work, applied!

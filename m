Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745045F0F29
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiI3Poh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiI3Poe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:44:34 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C01E2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:44:32 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 774B721F9;
        Fri, 30 Sep 2022 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664552535;
        bh=fJostlUzc8wpnt0ITxFOMpPuwFxLHZwjaffSJfS8Ld8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nwRRjgniLyOXLa3oIo1Ynbk7V9sBJXg+PTfkl/9FgGx9D1U78uzNRmmkSnI/rT/ma
         PxvEYNIcjn4Z1GRq8iHc3xT8CiMnH71I03gqYA1iHhH2i6EAjGXZBe4JQdcOjlK6P7
         v9PfnqNh3dsjdNOcME0c0RX4iyuRPkcsqk93cIME=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 18:44:30 +0300
Message-ID: <784f82c4-de71-b8c3-afd6-468869a369af@paragon-software.com>
Date:   Fri, 30 Sep 2022 18:44:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ntfs3: Fix attr_punch_hole() null pointer derenference
Content-Language: en-US
To:     Alon Zahavi <zahavi.alon@gmail.com>, <ntfs3@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
CC:     Tal Lossos <tallossos@gmail.com>
References: <20220815110712.36982-1-zahavi.alon@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220815110712.36982-1-zahavi.alon@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/22 14:07, Alon Zahavi wrote:
> From: Alon Zahavi <zahavi.alon@gmail.com>
> 
> The bug occours due to a misuse of `attr` variable instead of `attr_b`.
> `attr` is being initialized as NULL, then being derenfernced
> as `attr->res.data_size`.
> 
> This bug causes a crash of the ntfs3 driver itself,
> If compiled directly to the kernel, it crashes the whole system.
> 
> Signed-off-by: Alon Zahavi <zahavi.alon@gmail.com>
> Co-developed-by: Tal Lossos <tallossos@gmail.com>
> Signed-off-by: Tal Lossos <tallossos@gmail.com>
> ---
>   fs/ntfs3/attrib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index e8c00dda42ad..4e74bc8f01ed 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -1949,7 +1949,7 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
>   		return -ENOENT;
>   
>   	if (!attr_b->non_res) {
> -		u32 data_size = le32_to_cpu(attr->res.data_size);
> +		u32 data_size = le32_to_cpu(attr_b->res.data_size);
>   		u32 from, to;
>   
>   		if (vbo > data_size)

Applied, thanks!

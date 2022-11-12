Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E0626AF8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 19:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiKLSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 13:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 13:11:13 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE502EB7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 10:11:12 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 401AD1FE6;
        Sat, 12 Nov 2022 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276499;
        bh=WKw6oiLpuQLfeOWVraEU9DSKkxzz8QF9fxnqbchto+8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=n5/O+59IXyqVt3DW9Pz9b3pGvXAgUcYH7sNaOKxWqTGquD6VvmYU2K613xXBrtBAi
         31a6JQvE0wdJdvttQ98mm1ewm1e6TwQcyHSXGhppCD5GyxJwBDcDkFAlfqBUW/ltP1
         C8IdAYtkidfUVNIkJ/jxVxtQlSxXWT+v7lgMblpQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 05C7B26;
        Sat, 12 Nov 2022 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1668276671;
        bh=WKw6oiLpuQLfeOWVraEU9DSKkxzz8QF9fxnqbchto+8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fAuIQhwD7B0rPF/XzLU2Tta9W8xaRvI7IkwpIKr8MxlDHfxE3CXIuKUXcLpoJ2VIM
         yM5IWlxQdy32hrV0wV3RwupXvRXr8nEJrQn+oCKgI44luoAB719VnNImIcAbluwXai
         fvgoKIAKgTTHb8Pekf93zQmyczGENXGkrPWxkYUc=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sat, 12 Nov 2022 21:11:10 +0300
Message-ID: <b9ef96f3-724e-1696-3f22-d5e89cbd927d@paragon-software.com>
Date:   Sat, 12 Nov 2022 21:11:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next v2 2/2] fs/ntfs3: Eliminate unnecessary ternary
 operator in ntfs_d_compare()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <ntfs3@lists.linux.dev>,
        <llvm@lists.linux.dev>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20221004232359.285685-1-nathan@kernel.org>
 <20221004232359.285685-2-nathan@kernel.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221004232359.285685-2-nathan@kernel.org>
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



On 10/5/22 02:23, Nathan Chancellor wrote:
> 'a == b ? 0 : 1' is logically equivalent to 'a != b'.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v2: New patch.
> 
>   fs/ntfs3/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index 5d3a6ce3f05f..6b0d2c01d6ff 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -432,7 +432,7 @@ static int ntfs_d_compare(const struct dentry *dentry, unsigned int len1,
>   	/* First try fast implementation. */
>   	for (;;) {
>   		if (!lm--)
> -			return len1 == len2 ? 0 : 1;
> +			return len1 != len2;
>   
>   		if ((c1 = *n1++) == (c2 = *n2++))
>   			continue;

Thank you for your work, applied!
First patch was already applied.

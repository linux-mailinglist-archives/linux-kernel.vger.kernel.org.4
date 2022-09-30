Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D525F0F22
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiI3PmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiI3Pl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:41:58 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14598205FE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:41:57 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D8C2F1D0C;
        Fri, 30 Sep 2022 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1664552379;
        bh=nmkTwmXqesIfJ/1aB2wEXqGWGGTPZopYvCvssO9Ukfs=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=S7gnv7wfXaJFNEyt69daODhWpnwW68UheFTmx9ma12s3VLI3GV/dcoQRkGZa4aFh3
         V2pCf7js1NxFbQb4TU0inKAaV2tcfP3+iz3Ut1GcTtsPX/dOp6lomK6VKJoGRXWY0t
         OAoXsLER+0DygScmmo2K7vliLGa+bx5rDYXXY+vg=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 18:41:54 +0300
Message-ID: <b3d04e78-c6d0-17ec-620f-5125e645dd00@paragon-software.com>
Date:   Fri, 30 Sep 2022 18:41:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH} ntfs3: fix [df]mask display in /proc/mounts
Content-Language: en-US
To:     =?UTF-8?Q?Marc_Aur=c3=a8le_La_France?= <tsi@tuyoix.net>,
        <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <d3337d95-201c-43bd-3b37-4fd9e654d821@tuyoix.net>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <d3337d95-201c-43bd-3b37-4fd9e654d821@tuyoix.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 8/10/22 23:28, Marc Aurèle La France wrote:
> ntfs3's dmask and fmask mount options are 16-bit quantities but are displayed
> as 1-extended 32-bit values in /proc/mounts.  Fix this by circumventing
> integer promotion.
> 
> This change is not eligible for stable@.
> 
> Please Reply-To-All.
> 
> Thanks and have a great day.
> 
> Marc.
> 
> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> 
> diff -aNpRruz -X /etc/diff.excludes linux-5.17.1/fs/ntfs3/super.c devel-5.17.1/fs/ntfs3/super.c
> --- linux-5.17.1/fs/ntfs3/super.c	2022-03-28 02:03:22.000000000 -0600
> +++ devel-5.17.1/fs/ntfs3/super.c	2022-03-28 07:14:10.799008309 -0600
> @@ -518,9 +518,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>   	seq_printf(m, ",gid=%u",
>   		  from_kgid_munged(user_ns, opts->fs_gid));
>   	if (opts->fmask)
> -		seq_printf(m, ",fmask=%04o", ~opts->fs_fmask_inv);
> +		seq_printf(m, ",fmask=%04o", opts->fs_fmask_inv ^ 0xffff);
>   	if (opts->dmask)
> -		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
> +		seq_printf(m, ",dmask=%04o", opts->fs_dmask_inv ^ 0xffff);
>   	if (opts->nls)
>   		seq_printf(m, ",iocharset=%s", opts->nls->charset);
>   	else

Thanks for patch, applied!

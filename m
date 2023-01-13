Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834266934D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbjAMJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjAMJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:51:42 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1821A051
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:44:50 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 957BA1D37;
        Fri, 13 Jan 2023 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1673602864;
        bh=hkS2VR9GGBUmCFjS1zTFPOZAx3NuHCndXgPxoK8gzuM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=A0o1lj4FHUKimBODbEWE63pnGGlfogAKtMclPQ361LC3NrVG56WEScgt/umNwpwQ/
         m21pn3bCGtCNcewJCyhSTLAei2dnV8oQS3X6EreAA1fQa5Goilnv4foHBXdjzLalf5
         XehEiv7tEbl9IVMoF2FPuFxjebIYismfIyw/QT3I=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 239C52181;
        Fri, 13 Jan 2023 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1673603089;
        bh=hkS2VR9GGBUmCFjS1zTFPOZAx3NuHCndXgPxoK8gzuM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=n8+8xItrHdhUuoWTPLkgT1eonBcBf6Ms+zilmhFcJRjOLRFfNLu68ZZzWkiRj42lE
         5KhE2aSByu6WiWb8TdTYn7gceB7xhE4qQs+oe0t5BRZjOmCKoZaO1FuukS/qGeMKsJ
         pO2Lesc9lHTeLbjJaPbHObvfgpTjhATFdWJj17TY=
Received: from [192.168.211.54] (192.168.211.54) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 13 Jan 2023 12:44:48 +0300
Message-ID: <2f653f1c-161c-57d2-b3c7-f21ded261938@paragon-software.com>
Date:   Fri, 13 Jan 2023 13:44:48 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Fix error handling in ntfs_new_inode()
Content-Language: en-US
To:     Shigeru Yoshida <syoshida@redhat.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230104123902.978084-1-syoshida@redhat.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20230104123902.978084-1-syoshida@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.54]
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

On 04.01.2023 16:39, Shigeru Yoshida wrote:
> When memory allocation for mi->mrec fails, ntfs_new_inode() calls
> iput().  iput() calls ni_write_inode() indirectly, it references
> uninitialized mi->mrec, and this causes the kernel crash.  This patch
> fixes the issue by making the inode bad before calling iput().
>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>   fs/ntfs3/fsntfs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 567563771bf8..7b93f2aeb6f6 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1683,6 +1683,7 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)
>   
>   out:
>   	if (err) {
> +		_ntfs_bad_inode(inode);
>   		iput(inode);
>   		ni = ERR_PTR(err);
>   	}

Hello.

This bug have been already fixed by Ye Bin 
(https://lore.kernel.org/lkml/20221117091912.3436127-1-yebin@huaweicloud.com/).

  * Thanks for your work.


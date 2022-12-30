Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB96595B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiL3HWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiL3HWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:22:11 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6618B1B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:22:10 -0800 (PST)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 9B971439;
        Fri, 30 Dec 2022 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672384716;
        bh=X8hh3t/cwLmbZlbKpsEr+gB7KcWiS5MNa7LWLYYwmek=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=a2wTt0UXa8yX8nv4T5ga/gkfckIA5deayPnQJir0DfLscJgYMDa6lzR4H9cwsAmD3
         OFNI0jKmZNbyhSTgXXOyRD/Pu9iuG1zsNMqUq0gZR4DC06mnUL54c5JGcQ7wY0UsQ+
         alJeJ9zCkjR3huhse0NQTjVMdU43KZ9zC503SVR4=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 10:22:08 +0300
Message-ID: <10b42aa8-4eda-c761-be12-9fe54e9f15d8@paragon-software.com>
Date:   Fri, 30 Dec 2022 11:22:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fs/ntfs3: Fix NULL dereference in ni_write_inode
Content-Language: en-US
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <skhan@linuxfoundation.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com>
References: <20221030070251.614970-1-abdun.nihaal@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20221030070251.614970-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2022 11:02, Abdun Nihaal wrote:
> Syzbot reports a NULL dereference in ni_write_inode.
> When creating a new inode, if allocation fails in mi_init function
> (called in mi_format_new function), mi->mrec is set to NULL.
> In the error path of this inode creation, mi->mrec is later
> dereferenced in ni_write_inode.
>
> Add a NULL check to prevent NULL dereference.
>
> Link: https://syzkaller.appspot.com/bug?extid=f45957555ed4a808cc7a
> Reported-and-tested-by: syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>   fs/ntfs3/frecord.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 70a80f9412f7..e55bbd209ef8 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -3243,6 +3243,9 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
>   		return 0;
>   	}
>   
> +	if (!ni->mi.mrec)
> +		goto out;
> +
>   	if (is_rec_inuse(ni->mi.mrec) &&
>   	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
>   		bool modified = false;
Thank you for your work, applied!

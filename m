Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E552631097
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbiKSUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKSUEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:04:16 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F6193FC;
        Sat, 19 Nov 2022 12:04:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id g12so13372026lfh.3;
        Sat, 19 Nov 2022 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccp2wBYFO08vbXEm/oc3l6HKT+S2pZFfZ4H2UKRPVcM=;
        b=oJIdZboD3LegFim07gTIpp2yjxJgy6JTs/1S+LgCUkXEHlNZp1otIlsxSu8jimHZoz
         KNcCV4OHsBzp0dtTE0spPqgKXa8M54B2NUtIkt8ViDhh3r5qrmBaBhztY6a5kBnM8y3q
         Rdzj4rFrqxJ5fmPSXV6qJ7rxwN8cfgmW6X+fRotJhCzxEkXK/4AJxqXDEYhNc4Ms0FBe
         M3LP6x0HDK/PESNm4LFXHNpN/kSOhwXT5PdQOIECMHiwDSiwRTR4Ij/U9xGGHVdu7rOh
         HSfHh/7aOKspgZmAG1a0SgpbeaOPmyGSMyQ8ydbpjSl+RqLYuhU7H0PZAiGvBfq8vCMl
         /sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccp2wBYFO08vbXEm/oc3l6HKT+S2pZFfZ4H2UKRPVcM=;
        b=H5vUi6dwpQk40/Utw8chXMkD/4YcmYOmzB+E7XUwTsZQrOvuxGYNtT8zpUpgsR4ipe
         k92wlOJMF6MVuK+DBfOn7kPuEbBHDOll3ZHz6gK8opkm7t5SDS05XbLAmYf+K5/uoJJX
         RxzXK2RKxMRSL9SjY5bgGkNXeQdoykHrWVxwXrOCssImc3hRHO2O3pMr5ARwioff0ZOO
         /idAsDv8tEA2Rf/AvqQ7/i6Wx4/c8hd+5dFnsYFyXhu2i554kBZxaXEEmu2ssHnadUZe
         xH7s53/IF80wdStELjV2nDkkUv20l7w+JXUPk6SlZzB3z+lUy0Qk4XI0EkLdP8GmB/oO
         VXEg==
X-Gm-Message-State: ANoB5pl0hDqCC1u1dDDkF/gCdpJfSxUqTGkb01GPeTa3Ms3dtEDPG3Y2
        4apBQp4WAHoiBPob1SDFVd4uaWjZkyjQn+qgQIU=
X-Google-Smtp-Source: AA0mqf6Ox0HWsFKikihBgL/tqHbJffquiFQYL/D/NGLcRMUKabfuF1EhgDX6YA33mt/gp/ydXospydzbprKOFR6YxGs=
X-Received: by 2002:a05:6512:20cb:b0:4a2:23f5:c1f6 with SMTP id
 u11-20020a05651220cb00b004a223f5c1f6mr4164415lfr.472.1668888253418; Sat, 19
 Nov 2022 12:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20221119045159.1400244-1-chenxiaosong2@huawei.com>
In-Reply-To: <20221119045159.1400244-1-chenxiaosong2@huawei.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 19 Nov 2022 14:04:01 -0600
Message-ID: <CAH2r5mttt0zhzaz4XwPqz0x2m-P98oD45JJuMVfqu7EP2nbq_g@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix missing unlock in cifs_file_copychunk_range()
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     sfrench@samba.org, pc@cjr.nz, dhowells@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com, yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

good catch.

merged into cifs-2.6.git for-next

On Fri, Nov 18, 2022 at 10:09 PM ChenXiaoSong <chenxiaosong2@huawei.com> wrote:
>
> xfstests generic/013 and generic/476 reported WARNING as follows:
>
>   WARNING: lock held when returning to user space!
>   6.1.0-rc5+ #4 Not tainted
>   ------------------------------------------------
>   fsstress/504233 is leaving the kernel with locks still held!
>   2 locks held by fsstress/504233:
>    #0: ffff888054c38850 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at:
>                         lock_two_nondirectories+0xcf/0xf0
>    #1: ffff8880b8fec750 (&sb->s_type->i_mutex_key#21/4){+.+.}-{3:3}, at:
>                         lock_two_nondirectories+0xb7/0xf0
>
> This will lead to deadlock and hungtask.
>
> Fix this by releasing locks when failed to write out on a file range in
> cifs_file_copychunk_range().
>
> Fixes: 3e3761f1ec7d ("smb3: use filemap_write_and_wait_range instead of filemap_write_and_wait")
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  fs/cifs/cifsfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index fe220686bba4..712a43161448 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1281,7 +1281,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>         rc = filemap_write_and_wait_range(src_inode->i_mapping, off,
>                                           off + len - 1);
>         if (rc)
> -               goto out;
> +               goto unlock;
>
>         /* should we flush first and last page first */
>         truncate_inode_pages(&target_inode->i_data, 0);
> @@ -1297,6 +1297,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>          * that target is updated on the server
>          */
>         CIFS_I(target_inode)->time = 0;
> +
> +unlock:
>         /* although unlocking in the reverse order from locking is not
>          * strictly necessary here it is a little cleaner to be consistent
>          */
> --
> 2.31.1
>


-- 
Thanks,

Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6663274E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiKUPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKUPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:05:50 -0500
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DCD9B8E;
        Mon, 21 Nov 2022 06:54:34 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 45B8B7FD25;
        Mon, 21 Nov 2022 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1669041637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bEARu0JbQorKPvi4zAUJ1f0tT4f5K3ZqomAc0zTv4IU=;
        b=bUeIfrhiI1iRGk6aylBQTqyrT9PYNIYcVY0djJjxf6ssRl1nqqNJltP6/NdbjN6LDiPdOo
        bOYBdhhQLZtO27XSd7Oal3iLJIyDYc5KT68mYjzRw1JO4BKli3GTh+z8DNChXSjRI+Pn5D
        NOU0Un9UlJcI9rSRJUHPG80FG9dMY/CN4ou1YtcjVh202tI1/ATCRaN1AGXUI/QJF0D0Tk
        wbvyHuebllBcWXFOzFt5RadidQq+bVdMeGF3EPnmFFBYqn5f3sWGHD9MFUdIXE5Jla3Uz7
        hfGrtR6LX5FCIBTF1tjoadg2/L2d5oCyNpVxWnM6MX8yB7kCoZFk6jT/+v4iUA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, sfrench@samba.org,
        dhowells@redhat.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, chenxiaosong2@huawei.com,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com, yanaijie@huawei.com
Subject: Re: [PATCH] cifs: fix missing unlock in cifs_file_copychunk_range()
In-Reply-To: <20221119045159.1400244-1-chenxiaosong2@huawei.com>
References: <20221119045159.1400244-1-chenxiaosong2@huawei.com>
Date:   Mon, 21 Nov 2022 11:42:01 -0300
Message-ID: <871qpw1i9y.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChenXiaoSong <chenxiaosong2@huawei.com> writes:

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

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>

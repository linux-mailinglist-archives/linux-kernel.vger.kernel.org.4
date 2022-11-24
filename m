Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FF63792D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKXMpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKXMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:45:27 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE18E0A5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:45:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fy37so3878022ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lo5YGwJkzuu1DEKl7Pt4UwcOc8q2fhNpZoctJ4DDbFQ=;
        b=CE0hpBY9PPZg/9DZFi7e0blAo9T+sKsmWIaI2kynQFy6/a8vcFaZy6nAOiD8blxjwU
         H9UFJ5LikJT3C8bWpqnIoOV4j1p+5GYsL0IdBQFwM6ge/2xjifrgexL0vNeICEF7ZUF+
         bM8XWxv2A/HlUbiyNrZqvW+J+fkvZ68R+/oHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lo5YGwJkzuu1DEKl7Pt4UwcOc8q2fhNpZoctJ4DDbFQ=;
        b=acghPL3Nr8XyOIUKIkeDWsu03tstDr3wV4erF/LWBFlvwg6qW+4K/Hb/w6ePoAJyF+
         jOBLBBRjgx6VW7/hX6j6dnx3/Fm3j7/sGh38u4xMMIxY0S22hbwmqk87XfYHvXz2rQYb
         Ns2NQ+2JDeFBsKUivja29sAFL6ARkwt8lCjglsGxn2Lfi35LTbDTmHP1OJ7XMPuZLUiI
         E3d5ohe3CLGkKAjjAB1VDv3Et/QJeLy1GZ5JNjczLGbvIWHESOG7TKjpBI8x2zjzrgbS
         oykzYy29ZBWv3tDxc14Kx5MTAPW7PWsjG5WeYrNu/wFMPVNwFx77cxgRb6vPxu1W0VHH
         9E6w==
X-Gm-Message-State: ANoB5pmEv3AXhznWFXgP9vFTGqgnVzts+yHBfkcJqk/18apgLhCCEP5e
        F41IzS/oczMUMcw3/XlvFT3lCw==
X-Google-Smtp-Source: AA0mqf4zlD6qqpgO7cyll4fS+0kcJ5qlj6KG20AmB1eiVliCrkSawgJvLEELOgUyDKqv1cq/mXRJBA==
X-Received: by 2002:a17:906:392:b0:7b5:a9df:d83e with SMTP id b18-20020a170906039200b007b5a9dfd83emr17542962eja.358.1669293924497;
        Thu, 24 Nov 2022 04:45:24 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-82-180-126.pool.digikabel.hu. [91.82.180.126])
        by smtp.gmail.com with ESMTPSA id f4-20020a05640214c400b00458947539desm468243edx.78.2022.11.24.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:45:24 -0800 (PST)
Date:   Thu, 24 Nov 2022 13:45:18 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovl: Fix use inode directly in rcu-walk mode
Message-ID: <Y39nXuhwVi39nZPa@miu.piliscsaba.redhat.com>
References: <20221124092602.259809-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124092602.259809-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:26:02PM +0800, Chen Zhongjin wrote:
> syzkaller reported a null-ptr-deref error:
> https://syzkaller.appspot.com/bug?id=bb281e89381b9ed55728c274447a575e69a96c35
> 
> ovl_dentry_revalidate_common() can be called in rcu-walk mode.
> As document said, "in rcu-walk mode, d_parent and d_inode should not be
> used without care". Check inode here to protect access under rcu-walk
> mode.
> 
> Fixes: bccece1ead36 ("ovl: allow remote upper")
> Reported-by: syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>

Hi,

Thanks for the quick analysis and patch.

I simplified the patch a bit without changing the attribution.

Thanks,
Miklos

----
From: Chen Zhongjin <chenzhongjin@huawei.com>
Subject: ovl: fix use inode directly in rcu-walk mode

ovl_dentry_revalidate_common() can be called in rcu-walk mode.  As document
said, "in rcu-walk mode, d_parent and d_inode should not be used without
care".

Check inode here to protect access under rcu-walk mode.

Fixes: bccece1ead36 ("ovl: allow remote upper")
Reported-by: syzbot+a4055c78774bbf3498bb@syzkaller.appspotmail.com
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Cc: <stable@vger.kernel.org> # v5.7
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -139,11 +139,16 @@ static int ovl_dentry_revalidate_common(
 					unsigned int flags, bool weak)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
+	struct inode *inode = d_inode_rcu(dentry);
 	struct dentry *upper;
 	unsigned int i;
 	int ret = 1;
 
-	upper = ovl_dentry_upper(dentry);
+	/* Careful in RCU mode */
+	if (!inode)
+		return -ECHILD;
+
+	upper = ovl_i_dentry_upper(inode);
 	if (upper)
 		ret = ovl_revalidate_real(upper, flags, weak);
 

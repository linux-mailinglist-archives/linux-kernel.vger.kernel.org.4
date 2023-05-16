Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC86D70428B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbjEPA6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbjEPA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:58:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A5AA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:58:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aad5245571so92898645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684198730; x=1686790730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVkJA3lTgCORmQkh7N6TzUrBQFxDZlWdNA3lW0Mj46Y=;
        b=J4s70hg4/JjW2UMnl2JT8bfnV8Ukk7qLfBS4DfHMVP/JOgNwokgC8Dkyy2iBK3s/cp
         gYZ6QgETEMQEuQcaiI/OJ5jo/jb+rywH6Mkwi5VKIqdUn+z7pLG0mH8/Xdu1ClrSnI0F
         D3LvdA8xlycb8GyP3a6rCitQflEC7moRpyYaf5up3ILf0Xx0cSBVaMnvbFy8NVBts9GE
         5hECGlXekzHP+n599yioqGSTNeSbVPLdCnkcSBxJYGSOBFyrtH/4tmSwwxn2ZeMeC+1n
         AMsNcnG9GUeKoQDRdWRnVSFVTXhZtCpL5/fALCQksNQ+CACQun2/IQWigbCmHWXY7tc/
         DK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684198730; x=1686790730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVkJA3lTgCORmQkh7N6TzUrBQFxDZlWdNA3lW0Mj46Y=;
        b=T3cC+hu14JJp3hcVbfHupKTJ4L/Bptjz0wB4GSa8Zo+hLi5M6UuwakeNKUH7JiJ5Xd
         hCLncoQw9g7sY20eacwRFczzJqaTbGpbOvXNtVE8S3+Y4Y0RPojYpCV2bCpZkQOC/HdJ
         JEsYqt+9biAsfsFDJ4tbB6EjGcgs6FKAB9P48JGerDhQJ7fKVKuME0+ymgk8VlCBOUC6
         LtTNNI9hRV4aaunaMvflc5G9+S2ix2hV7ZiS1oDO/jhBTwrvIxzkP88ZBOWrBfYHM73e
         8Od0wcKxfYHHDHeplQZN4JKm/f/K1T02pYJwbXUrxuXhEdjsNG/h1msj4ONko/lD2dFc
         LL0g==
X-Gm-Message-State: AC+VfDy7mP8gGB8UPFvpZLxcV85+w3uKMW0eHIC6AK9TRVgUTfVXZTAw
        mg6trskhQQ4YkGqsjbNRyoAxiYuHGNg=
X-Google-Smtp-Source: ACHHUZ59kkW3M/Lto4bJ5/I3FVMybYj2cauPWRT3XU4pPllt57pKl1czKu4W3Q3W8oduUHqHXWZ1MQ==
X-Received: by 2002:a17:902:e543:b0:1ac:8062:4f31 with SMTP id n3-20020a170902e54300b001ac80624f31mr39420635plf.37.1684198730328;
        Mon, 15 May 2023 17:58:50 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090ad59400b0024e1236f599sm232716pju.8.2023.05.15.17.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 May 2023 17:58:50 -0700 (PDT)
Date:   Tue, 16 May 2023 09:06:40 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH v2] erofs: fix null-ptr-deref caused by
 erofs_xattr_prefixes_init
Message-ID: <20230516090640.00001a85.zbestahu@gmail.com>
In-Reply-To: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
References: <20230515103941.129784-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 18:39:41 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Fragments and dedupe share one feature bit, and thus packed inode may not
> exist when fragment feature bit (dedupe feature bit exactly) is set, e.g.
> when deduplication feature is in use while fragments feature is not.  In
> this case, sbi->packed_inode could be NULL while fragments feature bit
> is set.
> 
> Fix this by accessing packed inode only when it exists.
> 
> Reported-by: syzbot+902d5a9373ae8f748a94@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=902d5a9373ae8f748a94
> Fixes: 9e382914617c ("erofs: add helpers to load long xattr name prefixes")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

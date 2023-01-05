Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1774665F646
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjAEVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjAEVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:54:20 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB04676DD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:54:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a16so31190080qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AiDogmSekfQ136iq07144KY/Kq2S6U3J1wMNG/6kVak=;
        b=fMVHXBR9f8COfqWuTLGIOdUfjxsWONJHOpmAedSE6QNMQXzIKWtSIeEaIowL951f6a
         v2/YTCyesQk0a+DcPRVmUX9F+EVNzVbxhY0/Wqa9dKGl36gIUUMd60gbkZsuFHkclYV3
         Tw1uzLULJMgrKgxKfeXDnbaa5pFPV+dBFzP0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiDogmSekfQ136iq07144KY/Kq2S6U3J1wMNG/6kVak=;
        b=YL1ezs0KnPtkyMfSsONI9OpfWAIA+OJU2zawGFMdDnljY8RDmLaopZQFAmnAM/x30y
         7X+QXBO32WfluC6PxLIl/9KL7PkDdGD207EPDdH6+E1ZthrIW4QPuFS4yjr3qr6p6KIB
         53avaVs6WVyr/i0m3RoHmFU2iVJo4klW/chrYwycIO7k5ibYdJQWgUs8diliX23YPQPj
         /VpUyRNoOp6ZQK29m8oZslkBOS4OJ+PO/Nb6BQTiuayGi6qHBR4LD4/JVz+C1mF8ZuJl
         jdzqSeZKQZXgZ0avp/jpNNgvMFQcf88LX8+hkmDFMwLfxDO4GezHXCnyFM4aIIOyt2f5
         QLPA==
X-Gm-Message-State: AFqh2kqUIpSFyd+j/HzajGnT6ddFQtxmM67X83nzasLyPxoUQ7qK4lbW
        nwuD4H+8FkZ7BYemBMrZPWYB0HTCaSIM2xsa
X-Google-Smtp-Source: AMrXdXvnyWbSpJSkBgOHfe0gjCix8KFgLOy7jpkvpF/0iQfS+hVZ4JECLXHsWIwmMMt9qsG7VPKe/w==
X-Received: by 2002:ac8:4f53:0:b0:3a7:e02e:7cc4 with SMTP id i19-20020ac84f53000000b003a7e02e7cc4mr68170986qtw.32.1672955657432;
        Thu, 05 Jan 2023 13:54:17 -0800 (PST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006fae7e6204bsm25775391qkg.108.2023.01.05.13.54.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:54:15 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id k3so18548961qki.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:54:15 -0800 (PST)
X-Received: by 2002:a37:a93:0:b0:6ff:812e:a82f with SMTP id
 141-20020a370a93000000b006ff812ea82fmr2294231qkk.336.1672955655473; Thu, 05
 Jan 2023 13:54:15 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dbce4e05f170f289@google.com> <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com> <1bd49fc0-d64f-4eb8-841a-4b09e178b5fd@gmail.com>
In-Reply-To: <1bd49fc0-d64f-4eb8-841a-4b09e178b5fd@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 13:53:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3U3Y6eaura=xQzTsktpEOMETYYnue+_KSbQmpg7vZ0Q@mail.gmail.com>
Message-ID: <CAHk-=wg3U3Y6eaura=xQzTsktpEOMETYYnue+_KSbQmpg7vZ0Q@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        linux-m68k@lists.linux-m68k.org, flar@allandria.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 1:35 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Looking at Linus' patch, I wonder whether the missing fd.entrylength
> size test in the HFS_IS_RSRC(inode) case was due to the fact that a
> file's resource fork may be empty?

But if that is the case, then the subsequent hfs_bnode_read would
return garbage, no? And then writing it back after the update would be
even worse.

So adding that

+               if (fd.entrylength < sizeof(struct hfs_cat_file))
+                       goto out;

would seem to be the right thing anyway. No?

But I really don't know the code, so this is all from just looking at
it and going "that makes no sense". Maybe it _does_ make sense to
people who have more background on it.

             Linus

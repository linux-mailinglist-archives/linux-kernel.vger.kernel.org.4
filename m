Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57DA65F15C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjAEQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjAEQph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:45:37 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4359334
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:45:35 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id x11so30336758qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6arApO6IYFcLwiEx1xQQun777cX20MCWlNjtRHJ5Clg=;
        b=uepsKThOle1iENJ7DV2TsYHwy/gOQiuTQF0fNpBMQRR8+VabvCU10BPMzbZh1ORZXg
         3MkOl+1WmB/YOuAUHwDScjl7S9g8SKYkBR9BtOnrgK+DaApmIuxT+midA2oFCc1pshKL
         /LBLrpF4wfUe3LCYZ7865wvKxInxFvIKQ/5OPQHJQMMcUP8NglSZDL1il/jyHarz2MTy
         XUdQQGjOApmZcO4QeaaRW+nU0FJEWSCPAfKDCbDjx0aXkWjegpdTqb6mEVNEZ52MqR0u
         IgC6ByABNBVj0lsR0KV++Fraa0FUxauGp1jP7KbvQz/h6DzdeffDZgyw2iGNH2NkrW6k
         SfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6arApO6IYFcLwiEx1xQQun777cX20MCWlNjtRHJ5Clg=;
        b=uQoSl9cmpArcSHcF5bu5KMmSlAijnDWOAH0n1BmMe45TriatDg4Knv+Qu6oYK92uMA
         95iGzUb/GpLsMwDsXnxc/Vz2erXNqy+kMmpusQ33K1eUduMjwHSw7jz16ilmhFTusuDG
         qKKixt18EJFv5H9GPPPtJ3Fn8ij13Cd9RA9+xiUmRuK66y6lgDyTjKRh1qfQLtD+51UU
         XT15W4ZXEzjbWE7Vy6DJy++OS6mGyK7w0NdopSuAaL2pf2uzql/DjRdb8/8++yg/sk2y
         fDYu5Yk3+bzsREwvzZCFmav/mz0ljggWtxp2mCp9dB0wqmyq5p8tczQ27j12pX0sYwCL
         +p6Q==
X-Gm-Message-State: AFqh2kojoiHnZa+BALwRvStjrgvsIVsnGKvAh+prmm2CG/nrQ/F31Ffo
        tF1v7OKt+mN6y/Sjf9Fy9/iNKw==
X-Google-Smtp-Source: AMrXdXsbTE4sJrzTmujne/EY/Ou99CTR4ifsI+W8HXA5+B6VmowpRpm7dSy8aUe89IRj2jXJHMV1KA==
X-Received: by 2002:ac8:44b2:0:b0:3a9:89f1:82a with SMTP id a18-20020ac844b2000000b003a989f1082amr69143771qto.61.1672937134671;
        Thu, 05 Jan 2023 08:45:34 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id c9-20020ac85189000000b003a54a19c550sm21840745qtn.57.2023.01.05.08.45.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jan 2023 08:45:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
Date:   Thu, 5 Jan 2023 08:45:31 -0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 5, 2023, at 7:46 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
>> Also, as far as I can see, available volume in report (mount_0.gz) =
somehow corrupted already:
>=20
> Syzbot generates deliberately-corrupted (aka fuzzed) filesystem =
images.
> So basically, you can't trust anything you read from the disc.
>=20

If the volume has been deliberately corrupted, then no guarantee that =
file system
driver will behave nicely. Technically speaking, inode write operation =
should never
happened for corrupted volume because the corruption should be detected =
during
b-tree node initialization time. If we would like to achieve such nice =
state of HFS/HFS+
drivers, then it requires a lot of refactoring/implementation efforts. I =
am not sure that
it is worth to do because not so many guys really use HFS/HFS+ as the =
main file
system under Linux.

Thanks,
Slava.


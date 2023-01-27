Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C867DE65
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjA0HTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjA0HS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:18:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC14113F8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:18:55 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o12so4564371ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gckA+z8bi0knDr7CiudDJxl25fqVm0Q7pXZDmnoc9BE=;
        b=r4C4D/Vi3TeQ9Yz8Rk7XAQJdh/ve3+6lpszoreHOJuC+AcbBAPvaXQ3F+xqJHq0YBL
         jQwuIwFJFttmEvbu/RcaZEITUVYtzOGzurzeopbCPTDky0fdsoCyO7/OeIP378f6FQFD
         fn0UNCIWrhY+tokqpEIxMTnCmjxr68kf9ET0s9gDWHHsr7pD0CY48n/x9UYeSbqH/mVX
         wF67yTRKx4/sqckRKMmIVTI8SyEHNRwrg/UV7XlfXS4FfkpvaovR5q7xsh31r8L8GSe6
         SQVx0pF05KVju8rBeMwEiCMmnHP2a3KhrCPJtjuyypPz3HoDX3NdSuPk6aFtdaqBrdK0
         3ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gckA+z8bi0knDr7CiudDJxl25fqVm0Q7pXZDmnoc9BE=;
        b=qmyLEUmwFPZAkHgKNqlp+CWRMvJ8qaYEvqs6ONCxDWXBCYSWX5Q2vp2UKZYPEEAWsT
         AVFlZzWhiTZ8fs6Eb2eyEvBmB2tuLTgJPvtLpNeawNwSfInzxHT66Ye0xIcWfeUX7mXf
         UmTCs+go5OKixTRhDfDXIv6v22jotCgtQP34egmxvVM3nuiu0M0mkDC/aakK7CmzMpjt
         IDRn4KFOBRVrmWjgP+14KgL+BZiBj0u/u2ArIQjlZ9x8T0QFSdEwIUiyU5hLC1pllYr5
         7g2/3q+U6IuOSvSChH9TyebCcnePK6YTDGMNgQKk0N5NX5WDxZCLDJXE/kxrMoeUGPRq
         pPmw==
X-Gm-Message-State: AFqh2koxbx+tBohIo3H8F7cWNU6JfXhcqm+3QnXLxC5ea944w6C2iCxy
        k/3vTNhy4fjQUR5xvOK5Ts51HFG7kdcxLpePpuCcjA==
X-Google-Smtp-Source: AMrXdXvn/qgdr6jgDpr6LENXIlhjrHMR+ZrYlvt8sYn9NJsEEwX9ZlmPUBtW9TiVDYyOJeurpBbVS1LsR7oNwajtq84=
X-Received: by 2002:a2e:9c93:0:b0:283:e61a:487c with SMTP id
 x19-20020a2e9c93000000b00283e61a487cmr2082796lji.109.1674803933651; Thu, 26
 Jan 2023 23:18:53 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002f9ede05eb40cfbd@google.com> <000000000000690e9405f338aa34@google.com>
In-Reply-To: <000000000000690e9405f338aa34@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:18:41 +0100
Message-ID: <CACT4Y+ab0VvBWA-pvmSbu9gpxWG0JOvv-dbp3_2ej5+qg32L7Q@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in end_page_writeback
To:     syzbot <syzbot+c9db9ae0bd780a3094e1@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, chenzhongjin@huawei.com,
        konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 07:06, syzbot
<syzbot+c9db9ae0bd780a3094e1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 512c5ca01a3610ab14ff6309db363de51f1c13a6
> Author: Chen Zhongjin <chenzhongjin@huawei.com>
> Date:   Fri Nov 18 06:33:04 2022 +0000
>
>     nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138e4485480000
> start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
> dashboard link: https://syzkaller.appspot.com/bug?extid=c9db9ae0bd780a3094e1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ad8cc2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106b5906880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable. Let's close the bug report:

#syz fix: nilfs2: fix nilfs_sufile_mark_dirty() not set segment usage as dirty

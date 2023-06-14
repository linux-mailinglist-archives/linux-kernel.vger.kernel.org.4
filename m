Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2531872F847
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbjFNIuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbjFNIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:50:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422881BD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:50:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f58444a410so2348e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686732615; x=1689324615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QvqI8Mn5442slnN4bMkfgcgs+D0vQtmOk1Tmf4jn+oQ=;
        b=5Oh5dMC+ehz0CR/xX31cyOHUjR3/6XTEG3m8qsbtdKKtqeQGwrVI5jQUD6k/YPfO0l
         GIyZjSDXRmsUMDCY47os1zDIQ31BLDzzUXhQ/66RYCSN6wylQj3b11GA9WjxEPo9R8hn
         xGK0701TSSftCJf6ueUwWHVwqqGvADCU6vDd2JljH0P6OLavKKfbX0xQN89zOK3j8r5X
         JZs/L1BCxopbRfLtkRWFGVJpVyfeNdnx4KrEumQPlTOuqBWwnDwybLdZrZejtIFXf8kE
         6waFma4vgbHBgR4hyvU7/f4pqpQKJvmUSucvX3eSdIXlbq+APMZKfOKPI6DR/uSSXkeH
         vJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732615; x=1689324615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvqI8Mn5442slnN4bMkfgcgs+D0vQtmOk1Tmf4jn+oQ=;
        b=EWuRLr57RYPYRt1rgQFWmCXCr82VBzsqKLwJVpEHhLMuHCo/MtQeOwwlaq5f+wjo7x
         HUM9PTj5iLO2exTlA9jEvJFrDonCVGt5Xx7BDKjGHCTqXKUyRWeaqkLTyG4GEvvtcFN1
         99QLGCnpN0GZ9/gi0rOX8YgJYpOGl0/hXgM5E41wYssv83XVGie1srGe3MHP5XC7crTy
         pMJzBQq6ii4DYWLT5r5Irp9DL0d0MSXylek/tBpbyB0dXPRt+8EkN7HM62Yfk5XehgY1
         QQuTvufbytkJfLbiadCzOTq9OXcaIkm/LggZCS8sgcdxkT79D94ZTA9bp7iS7LWQ//Qz
         /L3w==
X-Gm-Message-State: AC+VfDxvDKDbj55PyFz2+ZS6u6DLEbYlYm2ykbC7XzHVHx+vClls6EVK
        vxLMQAxFAHAz5yjWnATAUSyxrBEUFTYGvdhxMZ83KA==
X-Google-Smtp-Source: ACHHUZ4Y+C4+ZVih15pjCljP83z9agQjBLGlBmyYJPFm12grpcH5LQ/ivV9kqQ6JOfANpnxixSLHu9LWkBkFoMOHsFY=
X-Received: by 2002:a05:6512:3902:b0:4f6:132d:a9c2 with SMTP id
 a2-20020a056512390200b004f6132da9c2mr37539lfu.3.1686732615291; Wed, 14 Jun
 2023 01:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ab092305e268a016@google.com> <000000000000d88b1e05fdf513c3@google.com>
In-Reply-To: <000000000000d88b1e05fdf513c3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 14 Jun 2023 10:50:03 +0200
Message-ID: <CACT4Y+ZGEucU4yhooRGDia5jxjEb7BhSVh9y9s8UfRzrZapusA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_evict_inode (2)
To:     syzbot <syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 at 23:05, syzbot
<syzbot+8a5fc6416c175cecea34@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 504a10d9e46bc37b23d0a1ae2f28973c8516e636
> Author: Bob Peterson <rpeterso@redhat.com>
> Date:   Fri Apr 28 16:07:46 2023 +0000
>
>     gfs2: Don't deref jdesc in evict
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1544372d280000
> start commit:   7df047b3f0aa Merge tag 'vfio-v6.4-rc1' of https://github.c..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=474780ac1e194316
> dashboard link: https://syzkaller.appspot.com/bug?extid=8a5fc6416c175cecea34
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1294d2d2280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104a7508280000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: gfs2: Don't deref jdesc in evict

Looks reasonable:

#syz fix: gfs2: Don't deref jdesc in evict

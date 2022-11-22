Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539E66344D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKVTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiKVTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:48:19 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F2057B78
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:48:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ha10so1827017ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lVbDlvvtZ6kOnIDHKIHd3lgjSqvnp2Onmrr/hjcCiKI=;
        b=ZpmZGbA0yEeAQcmw1YRD+tH2k3dpJ2h+GQqA2nTW/+AmrJijfthJJ1JBDQ4b17naWX
         Gc/gxxKP+B5FUvV3VGk2W0G9ETX/IIVaM8yBzDUKEelLWQEv8b4KysweuE9QpJ6XQVSd
         wJVG2oDQ+oPdHYZz0NjKMihQlfjjhbkia8/Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVbDlvvtZ6kOnIDHKIHd3lgjSqvnp2Onmrr/hjcCiKI=;
        b=RG3xuAbqbcg2iF/Cx5sJt5SybhrbEWSLDeY6sx5K5Oj2ROvfQHLklULEOC57+1iks4
         2mKqXHTJoM8pR8fIchst2D3Do8n1hPq/IhJh8GEIg1bep7ebMjwV4wmmaqTnApHApVE7
         ClYetoXrHgIKyOSjuEJkHaSkWikgwsjOt9eyQm6hF6fKXLuaPUVij4r7L/xgP23HFoep
         BFOVcbZCNAQiAcEm50/y3rK4DLlZjXt4wLAyDFaH5VDu8qVhA9Lu8r4+u5F6QSLj17B7
         5shD3CsBAelFBQ+a1xGb5mUTNzP6vF2I/h56MCKfmUyZrnDaJ/oJaS+LiJuwff70wC0m
         SckQ==
X-Gm-Message-State: ANoB5plJiYNWdsvl8oRPSj1/qDeVctZ30QhDdmUAwe/uDbdqxg7234PU
        s8JN49cIg7e95PhbUcqaZekYJY8xv9OYP1t6BUCGyQ==
X-Google-Smtp-Source: AA0mqf7G2K2KCHsUYtNjGbSQRIe5kptdRvJjIPo2u6XacsktiIWjTo1Gtdxekg6+ahn0rSaoqbcgPDkabc4jvu8znZE=
X-Received: by 2002:a17:906:d7b8:b0:79f:9ff6:6576 with SMTP id
 pk24-20020a170906d7b800b0079f9ff66576mr20147812ejb.414.1669146496324; Tue, 22
 Nov 2022 11:48:16 -0800 (PST)
MIME-Version: 1.0
References: <00000000000021719805d692e035@google.com> <000000000000cbce8405eded1951@google.com>
In-Reply-To: <000000000000cbce8405eded1951@google.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 22 Nov 2022 20:48:05 +0100
Message-ID: <CAKMK7uFj2oouRmLyTZH5YLsk_V8FE=XUR-o0QkoMk1macyPDOg@mail.gmail.com>
Subject: Re: [syzbot] inconsistent lock state in sync_info_debugfs_show
To:     syzbot <syzbot+007bfe0f3330f6e1e7d1@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, gustavo@padovan.org,
        hdanton@sina.com, hpa@zytor.com, jmattson@google.com,
        joro@8bytes.org, kvm@vger.kernel.org,
        linaro-mm-sig-bounces@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        seanjc@google.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, will@kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022 at 21:51, syzbot
<syzbot+007bfe0f3330f6e1e7d1@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 997acaf6b4b59c6a9c259740312a69ea549cc684
> Author: Mark Rutland <mark.rutland@arm.com>
> Date:   Mon Jan 11 15:37:07 2021 +0000
>
>     lockdep: report broken irq restoration

Ok this looks funny. I'm pretty sure the code in
drivers/dma-buf/sw_sync.c around sync_timeline_fence_lock is correct.
And we don't do anything that this patch claims to catch, it's all
just plain spin_lock_irq and spin_lock_irqsave usage. Only thing that
crossed my mind here is that maybe lockdep somehow ends up with two
different keys for the same spinlock? I'm really confused ...
-Daniel

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115b350d880000
> start commit:   84368d882b96 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=135b350d880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=155b350d880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4e5e9899396248
> dashboard link: https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164376f9880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cf0965880000
>
> Reported-by: syzbot+007bfe0f3330f6e1e7d1@syzkaller.appspotmail.com
> Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

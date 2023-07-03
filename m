Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815487456C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGCIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGCICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:02:49 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D3B19BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:02:29 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-65026629c1eso4205702b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688371318; x=1690963318;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiZNLBYfEYXTt1L0qzwGmdJw59vGiJNUhJxkls68qUc=;
        b=bS86ZqweMapxvOj8cbmf4wS9ox8eUsuqbMhO1Rd9vQij/79fUucmPuIzXAQUiXg0um
         jLK1SyZ7rSkyWnK6UbM9puZcaOGMLqLGYU6VyM/kwtFxof2e8YaV/CfCYZVAU2aPbaWm
         ifaUk9kPEtV93X+4mMTvUodjkc3sZ32FFclpQlU578q24SmPYlAc+ECt45biE8OYaRis
         MSnOccgSrwknGab1DFy2WWE/ZT9hdXzo/SerR6QNpHbFY5xQyeDyQULzLPWS2cHOVh0m
         fDlD+XROXuMidqYLM1IoQdJlqx/vYDnqx2ltcGa/Vw4jOcbCTmUdNUoSxi4obN2gPbbL
         fW+g==
X-Gm-Message-State: ABy/qLaBAbbpvxWYF6epTlOJksvRf44zNP6/11YHkoUZLb+iO+lslVOK
        /VH6l6iv4R0cFhBN08htaXsoCM5/iEYeKvHCKBtUFHDniDN4
X-Google-Smtp-Source: APBJJlGeWl020xWQOz6lUxai5rIohD4968Dp1WHHAtStpCZSioUFTABcQvcbzs3SRpfQDw4mLu6EVZo2m+RqTB1AyAV0e9Ri0Jp4
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:238e:b0:675:b734:d30f with SMTP id
 f14-20020a056a00238e00b00675b734d30fmr11228712pfc.4.1688371318706; Mon, 03
 Jul 2023 01:01:58 -0700 (PDT)
Date:   Mon, 03 Jul 2023 01:01:58 -0700
In-Reply-To: <20230703-richten-ehren-5a4c9b042a23@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b359eb05ff9094f0@google.com>
Subject: Re: [syzbot] [kernel?] bpf-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
From:   syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
To:     brauner@kernel.org
Cc:     ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jul 03, 2023 at 12:14:17AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link atta..
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=127adbfb280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=319a9b09e5de1ecae1e1
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/disk-c20f9cef.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vmlinux-c20f9cef.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/5d80f8634183/bzImage-c20f9cef.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com
>
> #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-out-of-bounds in alloc_pid

can't find the dup bug


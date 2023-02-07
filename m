Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BE68CD8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBGDl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:41:25 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410823DAA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:41:24 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so9635980ilj.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 19:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmm3qSdcQWW/LIh05Brsvwj+H2UPgRRUps3dr9U70BM=;
        b=jzdOPw/KJcEHuyfVfwcj99pHrtFxYDpHtZ+GlKs25S6wX/dxtqnVlE+ZgMCJu9H3sn
         et/Oo1+RtsNma14u4FYimX92Tda48nD1Tng4IjYqZImGAPrtsdVX4IjmzG2gR9z57II5
         b0LhBXUC27lxOrz82IK9BKSR5nYJICAlY1XMfPpKvy7vlQM1Zqz7ZCwVGnuu2vHqZlTb
         auQ2kazdBAJYWcB3nG95WOSN5u2D+LeXWZNDej6xLECvgjNROyefi6P5gD8Cdgyi1TVE
         qUeEeB+UKMC2RquAgDXBNsJB+1hYbUMuzjtcSQyf+iFGC4DlcUjsRfnhU1wiCSkJCzwP
         s4jg==
X-Gm-Message-State: AO0yUKVrZsWX3RWvg9zbz4oOSKHMFf3sMnPJuKPG8UPFaxehwX/Xr2Oz
        ZXaA6eSOCRyGkXeT2UB/Uvt0eV+yg62+NC7sQrqFkGvU4+2C
X-Google-Smtp-Source: AK7set853vjFq45uDu9RYWu1S4L7s9wwtelHPIM38YVOFaH6COuImG8wiCNELZpehoc0TgHKFiPuIIHUlsNvlghL9iqUVaeedTKK
MIME-Version: 1.0
X-Received: by 2002:a5d:938a:0:b0:734:152b:6e39 with SMTP id
 c10-20020a5d938a000000b00734152b6e39mr556974iol.0.1675741283835; Mon, 06 Feb
 2023 19:41:23 -0800 (PST)
Date:   Mon, 06 Feb 2023 19:41:23 -0800
In-Reply-To: <20230207032427.1028-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f56a6905f413eb23@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad rss-counter state

BUG: Bad rss-counter state mm:ffff88807dca8900 type:MM_ANONPAGES val:1
BUG: non-zero pgtables_bytes on freeing mm: 8192


Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1242a20f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1754166b480000


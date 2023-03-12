Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A146B6BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCLW13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:27:27 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E52B9E9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:27:23 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i14-20020a056e0212ce00b0031d17f33e9aso5504520ilm.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678660043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5fqhJIjpirLrsA3xG4o21nLBL/g/rnnNghPQIsHEss=;
        b=dYsDVw+E/Z+fsT3CBInSstB0PdpViKpphWOxgaQzo/6yPWeCMkpxZ8eaK1oLoXxbdA
         ZwN0kjQ6xlZSYvxjTWRlulTEXRHRHD061hcx2FjfjkhR7ygv2C/1niUQr3uEZDl2xmN0
         7HCwj/EKPjh3MEbQq0RKz1hbPO2qrIkfZc7oyC3utwi+UhyqR5CCNGZuU9sSmNyVD9vb
         A/DACy0ZLt+zSjpZrVSX48EUQIqzTLro2BuN9/Hs8ZYlnA12tCr7ZcmLP8Y/qDp4mwDm
         4iuNYDHnpuvt2/NHJBpnhzMnj38/hbN+C5MItI+ZNMV05Zca7oBPUomOlp6XJudFlrOj
         JKWQ==
X-Gm-Message-State: AO0yUKUKFA84IduDepQwQpL7g0EFMUpXoIH3WEIXpQ2DtdaswdyGpa5W
        b5JNNbjglNEgdkEhHJXPp/W8Vcl/r2hRvseSVo01Ke4YLD1M
X-Google-Smtp-Source: AK7set8RxLuX+r2WrfitVnbkOx83kJ8KZ5ejK4b9706CYKAUI3x7/QchSBcyPABxjAwH8lZan3Cy80i9r6cBgLW5xqLjJhOXbqqH
MIME-Version: 1.0
X-Received: by 2002:a5e:8e49:0:b0:745:a851:1619 with SMTP id
 r9-20020a5e8e49000000b00745a8511619mr14614913ioo.3.1678660042917; Sun, 12 Mar
 2023 15:27:22 -0700 (PDT)
Date:   Sun, 12 Mar 2023 15:27:22 -0700
In-Reply-To: <000000000000a798f305ef2aeed9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e918105f6bb7ff2@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Write in
 l2tp_tunnel_del_work (2)
From:   syzbot <syzbot+57d48d64daabde805330@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jakub@cloudflare.com, jiri@nvidia.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e69652c80000
start commit:   355479c70a48 Merge tag 'efi-fixes-for-v6.1-4' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=57d48d64daabde805330
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1731caf3880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

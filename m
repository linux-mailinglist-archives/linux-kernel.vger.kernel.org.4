Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02474C076
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 04:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGICtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 22:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGICtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 22:49:20 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC8E48
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 19:49:19 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b8ad356f6fso36876465ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 19:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688870959; x=1691462959;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t48dt0gbHoYlD6zQ7nPtF/7kcwYP/QK/Spyg3zZplME=;
        b=MbbGv8xvNtuYjwjcfbrZfrgq3Tvj1WuWQmNtrjhB7iNA3ODL3gib2sDhr6zRhQHfIf
         zPdZzsSNRnA6SlomOO5iOE6zZB4MfkxZoza2UO3sVjVmaTb0KdeRx0wKe71eziv9teNf
         1CowWRhxXpZIx25BFLM/mWUshQfkNtc/GWQM0wVTM/JGDuSZmGBLnYif1n24D7zmx2ZZ
         Q9DyAxmYofeAi0bq6/RAk9qJoFR4hTkSzU3Pj0XEJyIGi+B6xsC5p/XXCldoOY2wMcFJ
         lWP5kEy4nguSCxOJcYY4YVcGd7HU8sKMIHTZF+PbHn1Ut2fv1IG+MYsVo/OBBpVcTKRy
         9a+g==
X-Gm-Message-State: ABy/qLZun0Zk5a6QfrOhapR+rpwTTLDmtMwk3Xn8UEktWxupsE1Ed7Pv
        CMhfgMZE1h6Igg6XRJn0yhIuaeMxcgPm8V9eJjvU26XiE9Nm
X-Google-Smtp-Source: APBJJlFJkrHvXVTRO6Vtonj5SuXcoJVj5y3+IwOSzRZo5PV3XTSrQZsZ+7qCQoXA6bVHCCkEvjM7TQxWW6qiRIEFhaIbbBR0ziYD
MIME-Version: 1.0
X-Received: by 2002:a17:903:2607:b0:1b8:a92f:2618 with SMTP id
 jd7-20020a170903260700b001b8a92f2618mr8197792plb.10.1688870959528; Sat, 08
 Jul 2023 19:49:19 -0700 (PDT)
Date:   Sat, 08 Jul 2023 19:49:19 -0700
In-Reply-To: <0000000000006d817e05f85cd6a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d4169060004e98c@google.com>
Subject: Re: [syzbot] [nfc?] UBSAN: shift-out-of-bounds in nci_activate_target
From:   syzbot <syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com>
To:     anupnewsmail@gmail.com, bongsu.jeon@samsung.com,
        davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e624e6c3e777fb3dfed036b9da4d433aee3608a5
Author: Bongsu Jeon <bongsu.jeon@samsung.com>
Date:   Wed Jan 27 13:08:28 2021 +0000

    nfc: Add a virtual nci device driver

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b7b56ca80000
start commit:   a452483508d7 Merge tag 's390-6.5-2' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b7b56ca80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b7b56ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7df0cabaf5becfdc
dashboard link: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123fc664a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12003f4aa80000

Reported-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

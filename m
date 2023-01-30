Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC31680641
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjA3Gul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjA3Guh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:50:37 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FEC9ED2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 22:50:19 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id k5-20020a6bf705000000b0070483a64c60so6272393iog.18
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 22:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa5ai5GL3vgKUKle+VKAr5dROC4CldLbzyie3VnJ+yQ=;
        b=e2L7DpdT8D+BoQirrd0j130Qbh3hZ/35n3i5dBrmvV1eX4cxpTc4gLfDJxpAPFc79t
         u1ieO8KCq5x1//PM1m/adJxPJZyw+yD9+0MCa5BIvR8tQsRFkm0+mp70eWU6PAuFZTP2
         hpA6WJhTpA5Foijg/P5sBnPVVYeQtAu5t3TYEehlmbyapAiTfxfrUMOPP18/q4y6dMiR
         UW/HDntZJXfv4MBfqmIdzXRaHGbuC3iQOM1TTYQtRz9ummukiEMNgFw3gJz9kM2qzTd0
         qH/QrHQLVpKPjjgfg9qfqBIhWAqD5u905+/CZMFDqixT7e74fpAMOYmG5I39cc9hEOKg
         VtnA==
X-Gm-Message-State: AFqh2koJErlvbbg//mw8L6Z8T2ZRqUlwEU1y2o8/07Aa0d5N0ezIeYKm
        fh7o4AxiIcSDQHSIFRtmz9HCfUS0CY5+FxivhgWCtv73ZuPC
X-Google-Smtp-Source: AMrXdXvdC+QErAlVG7uJMgNQ9lTgBFDx8bCpdbG8lK11Lf/u7Qj+dQBdFWzASs8r7KUmd/iYPqFVKZPMme/w94wlhO5NXaRYEgiw
MIME-Version: 1.0
X-Received: by 2002:a92:3601:0:b0:30b:dae5:c56 with SMTP id
 d1-20020a923601000000b0030bdae50c56mr5711752ila.99.1675061418554; Sun, 29 Jan
 2023 22:50:18 -0800 (PST)
Date:   Sun, 29 Jan 2023 22:50:18 -0800
In-Reply-To: <000000000000021e6b05b0ea60bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d47cbe05f375a0f1@google.com>
Subject: Re: [syzbot] WARNING in hif_usb_send/usb_submit_urb
From:   syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ath9k-devel@qca.qualcomm.com,
        ca@plazainn.com.qa, davem@davemloft.net, edumazet@google.com,
        eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        khoroshilov@ispras.ru, kuba@kernel.org, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, pabeni@redhat.com, pchelkin@ispras.ru,
        quic_kvalo@quicinc.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de, toke@toke.dk
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

commit 16ef02bad239f11f322df8425d302be62f0443ce
Author: Fedor Pchelkin <pchelkin@ispras.ru>
Date:   Sat Oct 8 21:15:32 2022 +0000

    wifi: ath9k: verify the expected usb_endpoints are present

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1162ac2d480000
start commit:   274a2eebf80c Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f267ed4fb258122a
dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1343a8eb080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17dc40eb080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: ath9k: verify the expected usb_endpoints are present

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

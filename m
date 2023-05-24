Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A366170ED3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbjEXFnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjEXFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:43:39 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1341A8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:43:27 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-76c3e89c73aso41123039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684907006; x=1687499006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVMaGANBT4FO+M+4WaVWfwLxfnECFcgkDsXKsvAj/u4=;
        b=idvXWYe0o1foBeqornYZb3/Plh3PdZlASWby9UvUkO1W+zjomb75Gd7z2LRe36Mqwr
         eTkT/AnhvHQt9sSk+Ab66uaM4j6kmT1/7GVQxxD9pULc+gVghGJQZ6r04yMBeweW/6eX
         YZ+zJluKPQNXzIPhrybYqKma64/mi3K6KSZTMKmhP/gw9GU1DVGEZLroLEUxG0OG6Fxc
         JraklWXTMkrGUbODkLlweji+nPIw3RYFqDEX7FlZK3W5xsRT1q2MocN7hWaQUvS2hF5E
         CU6yTrEgjZQnoDC8wjseeeUbBq+fkuPBY9o7zINBYqTYa3rgzR4UKbnng9K5C4XfR+zZ
         3U1A==
X-Gm-Message-State: AC+VfDyIuGUcXqp6Id9EdVJ0Yx70/sujRj3LC8mtN7F49IQkYg5vfQUa
        +gJzXB1UvjbnUz7WqpfvL7kXKeUKqgeMcvocA+kK6JNbcRzx
X-Google-Smtp-Source: ACHHUZ6E+B0ThBWOffyc/2kjmrvqKXkx5dohzqDxl4C5/YcAggY515Y7n0augbCIg4gJcLhcroaufm/VAh/xlIcI7ey6+zMbI6As
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2585:b0:774:7cc5:6682 with SMTP id
 p5-20020a056602258500b007747cc56682mr2664467ioo.3.1684907006403; Tue, 23 May
 2023 22:43:26 -0700 (PDT)
Date:   Tue, 23 May 2023 22:43:26 -0700
In-Reply-To: <000000000000959f6b05ed853d12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098aa2305fc69fb67@google.com>
Subject: Re: [syzbot] [nfc?] INFO: task hung in nfc_rfkill_set_block
From:   syzbot <syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com>
To:     brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        davem@davemloft.net, edumazet@google.com, faenkhauser@gmail.com,
        hdanton@sina.com, krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfc@lists.01.org, luiz.von.dentz@intel.com,
        madvenka@linux.microsoft.com, netdev@vger.kernel.org,
        pabeni@redhat.com, scott@os.amperecomputing.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 7ac7267fad5908476b357e7e9813d23516c2b0a1
Author: Fae <faenkhauser@gmail.com>
Date:   Sun Jul 24 18:25:02 2022 +0000

    Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1523596a280000
start commit:   ae8373a5add4 Merge tag 'x86_urgent_for_6.4-rc4' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1723596a280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1323596a280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927d4df6d674370e
dashboard link: https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1099e2c5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113f66b1280000

Reported-by: syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com
Fixes: 7ac7267fad59 ("Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

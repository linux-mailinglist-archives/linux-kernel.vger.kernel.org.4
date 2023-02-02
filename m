Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13776874BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBBEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBBEzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:55:32 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B865627BE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:55:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so571751ild.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 20:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCXSBKHFGkOitij945KHNCtiG7h7wsgd2ox/b52l/XU=;
        b=lllDJ3zR8WUDZPKeNKz12jFj+kHy48RKqY25PVmPYEU2jH9HFBprpVmhphABwW71nI
         kwq3qv0PM50KRZswL16lZ82iHk7sytwd+tTUrUJQ9aVgp1fAnTrHt5hDH3O+t3MM+eQI
         eL2EoU2K94vC1m2K4WnSGXX8gfu9garnTwfeWHby+KRX9TjBxSBMtLKiUHfnS3QpA3x/
         Tjy5cuLIjXAw5HBugGr5YyFCaFnZHvvyYP53XY/RggEt32zq21NHcZGYT7ohzFTOyKHG
         /4vFUdFoWvy0rNY3KJGeN4d2ovywPlT9MXprOUe47HVLQGugUat5k0Jp9F37q9GLc4am
         Kthw==
X-Gm-Message-State: AO0yUKVkFmVJaoBFU82v+AdJnxgSByUV0cu3p+JggcfMeCVgnXJtbhgP
        IwA81mt0OQPuXjbAjcGx2dsozOGKirhLp2qCoPQ1UeQLyYeK
X-Google-Smtp-Source: AK7set+N2Jjm/A0Fcquix/C4kGyTpSc3SJa3KNEpZGWx5tPfcEn1CG5T8fQ71o0Ao+DdWsZSutWOpYedoho79O8kyl9cOTdEQUKN
MIME-Version: 1.0
X-Received: by 2002:a92:b302:0:b0:310:c8e5:a1a6 with SMTP id
 p2-20020a92b302000000b00310c8e5a1a6mr1184080ilh.129.1675313728754; Wed, 01
 Feb 2023 20:55:28 -0800 (PST)
Date:   Wed, 01 Feb 2023 20:55:28 -0800
In-Reply-To: <0000000000005e857005db658b71@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b09dc705f3b05f9b@google.com>
Subject: Re: [syzbot] INFO: task hung in rfcomm_process_sessions (2)
From:   syzbot <syzbot+d761775dff24be3ad4be@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
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

commit 1d80d57ffcb55488f0ec0b77928d4f82d16b6a90
Author: Ying Hsu <yinghsu@chromium.org>
Date:   Wed Jan 11 03:16:14 2023 +0000

    Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154b77b5480000
start commit:   d888c83fcec7 fs: fix fd table size alignment properly
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=69c8957f4ac2dea6
dashboard link: https://syzkaller.appspot.com/bug?extid=d761775dff24be3ad4be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162ca1fd700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1036182d700000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix possible deadlock in rfcomm_sk_state_change

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

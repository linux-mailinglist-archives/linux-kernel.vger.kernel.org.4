Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D06F623A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjECXv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECXvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:51:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C99001
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 16:51:21 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-760eead6a4aso370859339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 16:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683157881; x=1685749881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcZ85UohRTnIlpcVoJh324dST1aeKdAB/UA/Qi32hS0=;
        b=dflLvWWnvNiviZfXaHWqIWT1kuHlL9C68G6rA+UMUkHaElpvH7MHJa3Q+j3jjTVyI+
         hMPhqbZioDbzpX9iahJyK39xQXeBxkCpOFptjT8AroqsVIdSoxCssqIL/OIDMcI1jgv+
         3YZgtZj662QQ5Lx0rzeoPQMk6uPAoG2Q2mZetQ75B+67TjYeM0tVnozZECrQJ791iJiU
         jN1SajxXIvewm3mMEYNGzN0r9OyP7wDUZ4xkFcjQPejwcRXKoM1kkkAt4m/22Vs1a94O
         EIauaPgsnW/kstbWBor5JbR30V6SdQOUMKMe/pTyDZcJx2FgvUIPSX8o3uNJNDC/JUWb
         adow==
X-Gm-Message-State: AC+VfDxI2ETsSwVtrAk65vvmG5erESWZE/qyvefpGqsWQ5pdN3E5bxmQ
        FVeYoHTlkLFn2MN+8Ey34Dyl0Df6bLMhhcnI7ZlNfpe6mZDR
X-Google-Smtp-Source: ACHHUZ7Bf2UNPAy6HXsUp7lRc0mXPoN88gh/boNNoZyrLkLf7rtC9mZT8aNT0c9J8Qez6j0MPSy/gM8e2N9XAxh1nMIZgRQwIOzs
MIME-Version: 1.0
X-Received: by 2002:a02:3306:0:b0:40f:8b6d:c549 with SMTP id
 c6-20020a023306000000b0040f8b6dc549mr11170398jae.2.1683157880999; Wed, 03 May
 2023 16:51:20 -0700 (PDT)
Date:   Wed, 03 May 2023 16:51:20 -0700
In-Reply-To: <00000000000065fe6705cad8850e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000991adc05fad2bb84@google.com>
Subject: Re: [syzbot] [can?] WARNING in j1939_session_deactivate
From:   syzbot <syzbot+535e5aae63c0d0433473@syzkaller.appspotmail.com>
To:     davem@davemloft.net, idosch@nvidia.com, jacob.e.keller@intel.com,
        jiri@nvidia.com, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b20b8aec6ffc07bb547966b356780cd344f20f5b
Author: Ido Schimmel <idosch@nvidia.com>
Date:   Wed Feb 15 07:31:39 2023 +0000

    devlink: Fix netdev notifier chain corruption

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120779c4280000
start commit:   7cd8b1542a7b ptp_pch: Load module automatically if ID matc..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=535e5aae63c0d0433473
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1488b8e0b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eabe3f300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: Fix netdev notifier chain corruption

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B12626997
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 14:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKLN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 08:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiKLN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 08:29:22 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F091A3A6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 05:29:21 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id x6-20020a056e021bc600b0030243ea79dfso2676654ilv.21
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 05:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsnUsvhIwzsS7cZXIKYdGycWSuXBo6YozUvSoQomrm8=;
        b=dDUYjKlCpBAtifRi74FSANzufxKL0LKWZk27yOKDsm/6izBk76R2bjHpah+mfxxNx0
         Iw0JtoqSdkRAu0LaiTmI8BAYA1WT/w4pS+l/ou+i8KrwLXkUu2gq58S6JWLGtD3bpDdR
         5HHZ2HHnAQRzv7vfMZ2goeSDpO7ODb4WYtBhNW6vP+UqMLCkqegGqag6ArkWT+0yeqFD
         0XCcd57MJlyRuNoKAgNDahR0EAoDQLxnJA3lHgvIE8+3rtzopfilCCJ95PBnNGyxRFC0
         T+AQt2UKnTirEkRdiOf2pZDqxJsWFyH3vQFSeHKwM66HnyozwHvTXyixEFdFnOqUwmH/
         ZUrQ==
X-Gm-Message-State: ANoB5pmL/CHAsI8zU8VzDqKOkXgNFKaPCOwHwr55QLnnyBxUv9Kg6PZs
        RLoiM/dwImdTpGY1ZrROC6TCc8/d+U7GMWdy2NhjgN15V7Bb
X-Google-Smtp-Source: AA0mqf6o/tGm0kyVXnxBAdO+ObJQdIvlTOuDuDp+X1w83mjSA0977oriViOeYIj1TU1YddlnHPU5j/Zf9LHYYHz313/xDqbZSGyv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1303:b0:302:4f58:bcab with SMTP id
 g3-20020a056e02130300b003024f58bcabmr580521ilr.313.1668259761064; Sat, 12 Nov
 2022 05:29:21 -0800 (PST)
Date:   Sat, 12 Nov 2022 05:29:21 -0800
In-Reply-To: <000000000000734a7305ed3608ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073937205ed45fe5c@google.com>
Subject: Re: [syzbot] WARNING in snd_usbmidi_output_open
From:   syzbot <syzbot+9abda841d636d86c41da@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, clemens@ladisch.de, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peda@axentia.se,
        perex@perex.cz, rafael@kernel.org, syzkaller-bugs@googlegroups.com,
        tiwai@suse.com
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

syzbot has bisected this issue to:

commit 4f8ed19593872b710f27bbc3b7a9ce03310efc57
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Jun 2 13:10:58 2022 +0000

    ASoC: tfa9879: Use modern ASoC DAI format terminology

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17433e69880000
start commit:   f8f60f322f06 Add linux-next specific files for 20221111
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c33e69880000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c33e69880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=9abda841d636d86c41da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e91fa880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161d3e69880000

Reported-by: syzbot+9abda841d636d86c41da@syzkaller.appspotmail.com
Fixes: 4f8ed1959387 ("ASoC: tfa9879: Use modern ASoC DAI format terminology")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

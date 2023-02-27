Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D56A387B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjB0C0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjB0CZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:25:49 -0500
Received: from mail-ot1-x346.google.com (mail-ot1-x346.google.com [IPv6:2607:f8b0:4864:20::346])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502E1C33C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:22:45 -0800 (PST)
Received: by mail-ot1-x346.google.com with SMTP id x10-20020a056830408a00b0068db8db7c5aso3001859ott.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 18:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JYCCskFnp7QyaLNJ6Djjzn0I9pptPSNc5U+/Y/HrfY=;
        b=d7CCr0heQPB1Ae8vKOy4VkoBw2WA1tNM2O7Bx0A4BJ07K6Nxh3o6FQFcIqpMtSgJln
         MYcpIWqP+0ezpXt9uiJUQitX88K9X67C0IeZtQ/LBDbIXjnGRZA2qm+nXQrYQF2nlsUh
         jGVvq96mizDJI2Nx1cK3ih5Ty/R7wTDaccjsdKsD1FCjnmt1VTrOzJwzdP/R7HbciL6d
         ayQL1krJ8LAu/TZN+6tB3wcZQArAKVmVGIrmgjMdojAtcRokDGC8DzHFRoTtApe1G3EK
         JMZohMd8yQ7n2+3bpxGo0s+UsL/BQqmaGsK/w72Ze5XNokXT8Gjh22/d1uw0Kn/g+jzA
         y49g==
X-Gm-Message-State: AO0yUKVFjz92+OkHCVy8wIFfm+XZ4LGo99wAgi+2ptDDMqjQLD96eVbb
        2T/z+P/kKTokbUHZyz7fTKhtIIDFx/HTTxYVy+qAmn/zaZFi
X-Google-Smtp-Source: AK7set8TubHHC8kq376JMKk9Dw/Kj2SbNLReIaLtnw9aCa5Lg4QAdSuM7ghwq2ss7FWKssfzGshuD7m68KYp2OPOLUevvtJuVGYZ
MIME-Version: 1.0
X-Received: by 2002:a02:a15e:0:b0:3c5:19e6:b532 with SMTP id
 m30-20020a02a15e000000b003c519e6b532mr9133099jah.6.1677463640054; Sun, 26 Feb
 2023 18:07:20 -0800 (PST)
Date:   Sun, 26 Feb 2023 18:07:20 -0800
In-Reply-To: <0000000000001c7bf005f549b59d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063a01505f5a4f0a6@google.com>
Subject: Re: [syzbot] [media?] WARNING in smsusb_term_device
From:   syzbot <syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com>
To:     duoming@zju.edu.cn, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit ebad8e731c1c06adf04621d6fd327b860c0861b5
Author: Duoming Zhou <duoming@zju.edu.cn>
Date:   Mon Jan 23 02:04:38 2023 +0000

    media: usb: siano: Fix use after free bugs caused by do_submit_urb

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1687af1cc80000
start commit:   8232539f864c Add linux-next specific files for 20230225
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1587af1cc80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1187af1cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fe68735401a6111
dashboard link: https://syzkaller.appspot.com/bug?extid=40ac6e73326e79ee8ecb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ba7cb0c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16734964c80000

Reported-by: syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com
Fixes: ebad8e731c1c ("media: usb: siano: Fix use after free bugs caused by do_submit_urb")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

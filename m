Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0050667DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbjALSPR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Jan 2023 13:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbjALSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:13:59 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E925597
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:35 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k1-20020a6b3c01000000b006f744aee560so11569727iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6euKgqaz5CvSSFLuJHiJJPEhh3V6W0U8Nog8Z76wv4=;
        b=XekGbmfTvBtRrq9jqrsVs8AwlZnd01ie3wYZrNhPuOZDoA5uyaxDUExELsNem7rDBX
         aKdO2kO6kJBr51AQXgmti23Hm15wa6+XdEZ2Si46tKG5R0/fZiW/gd5FWbW1psm4ErqL
         q3VX0JelvDUBgwBkZzwvPb0UVIll8i/IFYjnuLfksN7crE7nLFu/bXEnPXnLsGL6fC1o
         OM9+EpvBBhnJp+/amhQrW9PxGu2P1Rkg+alJjkmn6zKH6ExZ6ox7AApEYm+r3SFEM2Hp
         fA8qypz1UtalS5ydiS+SOnaGg79rSAmX1v/sRrVgx+R/UUfrPYLCJzkJwY/DMlizCZPV
         gf1g==
X-Gm-Message-State: AFqh2kovD6x94XSjZUg0yM+icS5putMvTTSLxfSptz2as5l3wikAC8wf
        gzXnsm/wxQbcjEc1rpxCRIrRFW3ozYATm5EIhwjDuSh2oqSD
X-Google-Smtp-Source: AMrXdXt6RzWE0Rl0t6eyTbbNXTZXuwLItT296DHWjPJukooX4Stc7BSVoGxsFFhp3pGnXT+5J2Cx/373k8qd81Qu76FPg84d3ac8
MIME-Version: 1.0
X-Received: by 2002:a02:bb08:0:b0:39e:829f:b60b with SMTP id
 y8-20020a02bb08000000b0039e829fb60bmr2523546jan.83.1673545414457; Thu, 12 Jan
 2023 09:43:34 -0800 (PST)
Date:   Thu, 12 Jan 2023 09:43:34 -0800
In-Reply-To: <3c64a290-5134-2030-a2da-9ec2b1efc0c5@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1c14e05f214a763@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_req_caches_free
From:   syzbot <syzbot+131f71f381afff1eaa35@syzkaller.appspotmail.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 1/12/23 3:26 AM, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1605ee86480000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=131f71f381afff1eaa35
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> 
>> Unfortunately, I don't have any reproducer for this issue yet.
>
> #syz test: git://git.kernel.dk/linux.git for-next

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Jens Axboe
>
>

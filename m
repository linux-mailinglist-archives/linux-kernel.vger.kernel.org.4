Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6176617B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKCLV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKCLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:21:23 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B5610FCC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:21:22 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i6-20020a5d88c6000000b006d088a0e518so829443iol.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHnXEf0M9YsxOsLvkyf2QDTjUwvP7IxH0p7vNmDb/q0=;
        b=eV3iZwzf7L81QJSoe2HySjsEM9JQ23QnYLhSdGywuhN/oxGmjO36M/VxhIZ8g2M477
         Tg22QNTKNRiHI+jY4DwcgGOg0b5v4gl5pkfonqkdPl4aaVQlwgHBdJfMnZ65p4Pc0zJt
         9syySDpD9C2fdDU1X9Yt/YmxQ8EWk4un4NxSbE+8nn7GoBKLxFkSZ7kYqFf9sV9Xsoak
         sHpeJF+uaPNLaEdDcXWBK0yoEmBAUpsLx1L0WABeKVL2ZaJVOSDnCeSL8gF6lYeySjxz
         aD2Lb1nIULVSnCJTu5OpiiZbXWmSNyXpX6DfHTOSQ95Id808qpoTgSDe9tGyiCvZH47J
         zTgw==
X-Gm-Message-State: ACrzQf0cFhibbYa/BjkyZALh1rJIYHV6b4NfGrxjfwGiTlL7DbNUiBfT
        lDC/VouSuzkVhTakOdJaBjWFQsBpQrha+n5rnHiRm2CRBJdS
X-Google-Smtp-Source: AMsMyM4NgnZoi5ORikvhzVJB/yNelYixw83omSUCIaLsic73GYFHOVcw1J1rtrHVc3Jcsp/leA9a4PGLokFVwq6F8NwaCbamX4I2
MIME-Version: 1.0
X-Received: by 2002:a92:b07:0:b0:300:e141:40cc with SMTP id
 b7-20020a920b07000000b00300e14140ccmr828785ilf.309.1667474482198; Thu, 03 Nov
 2022 04:21:22 -0700 (PDT)
Date:   Thu, 03 Nov 2022 04:21:22 -0700
In-Reply-To: <20221103001520.4011-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f013b05ec8f28bd@google.com>
Subject: Re: [syzbot] possible deadlock in static_key_slow_inc (2)
From:   syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

kernel/cgroup/legacy_freezer.c:355:35: error: passing argument 1 of 'static_key_slow_inc_cpuslocked' from incompatible pointer type [-Werror=incompatible-pointer-types]
kernel/cgroup/legacy_freezer.c:366:36: error: passing argument 1 of 'static_key_slow_dec_cpuslocked' from incompatible pointer type [-Werror=incompatible-pointer-types]


Tested on:

commit:         a2c65a9d net: dsa: fall back to default tagger if we c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140c7046880000


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431664BE22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiLMUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiLMUv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:51:28 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFE1EAE8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:51:26 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so2670326iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDc7/rZ+mBKdUtjFutRJIRW7wkURndgGrP5AD0QPxqo=;
        b=bPoViTSNFZGnjUXMP6SEcTk+CLV4bNxESnfT+irXCsjINvhx0+GBxTrJN9oNHLHMDe
         NFLqtBx7nNkZ/gxkDbO03/IX3yfs7tLDqlD0KKNxPg08AL3aMQS8K7Nxq/X2OLUiivLv
         z7RIu0SnyRHR3/A6KcdcW3QivWbQVtt4NehRIcoje1yawbX6J7uRk2Ai33OkAkxfF0jH
         hcezu/5GtT/YYmiUJzGFQ086RSvcz3EYSPfpFZhUvvQiuKXJrTLvMolqApLgjW9KVJUg
         QFRcRjPhUbK8cG5Gc1ejRggWa1PuDLPGZqL5SOEG6eDQsJ7273KWmyGgyDDpmcLilENI
         8D3w==
X-Gm-Message-State: ANoB5pmWADigXG6j4HdEc24g81HFxvaDgiU6JjV7WPiyMARjd15vaMOb
        mvVl5cMTgMSUmh33pjn3U/OgBnDK6GrYhKbXp/rUooUo/odu
X-Google-Smtp-Source: AA0mqf7WGfoEes8mrOe2kmB344G6gzyTMwyTinYcSPJxngDTfvSN/CCeov4ouvk1a9R90eMM9qiSFR87hJkMlYyN/QJ4BzF/UD6+
MIME-Version: 1.0
X-Received: by 2002:a92:ca8b:0:b0:304:a621:5c56 with SMTP id
 t11-20020a92ca8b000000b00304a6215c56mr1099437ilo.148.1670964686133; Tue, 13
 Dec 2022 12:51:26 -0800 (PST)
Date:   Tue, 13 Dec 2022 12:51:26 -0800
In-Reply-To: <Y5iiwlZm8hgj8S0W@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ca17805efbbc87f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in gadgetfs_kill_sb
From:   syzbot <syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4116 } 2668 jiffies s: 2777 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         830b3c68 Linux 6.1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=12066e8b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ad66d65044b93f16
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16793e8f880000


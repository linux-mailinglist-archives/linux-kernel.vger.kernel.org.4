Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219346532D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiLUPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLUPC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:02:28 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290BD222B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:02:28 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id w18-20020a5d9cd2000000b006e32359d7fcso6863261iow.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNMeliN+pyRVpWJexHL4yQy7Tek1lPMzRf9naRRra70=;
        b=sORPcTAPSNwrmY7XeOQTPR/3gFZOb8OVAehUOZHbItJEU96soZGpyAKyCOJLLYaxtf
         VarznMGEicCDz6hdWFE9DIOLIgYCUFloH0RIjhv1LQQaoL3Xo0f0lGNCE4bqT6IG+QdW
         ywH+weR3ZtQCvNuxBoMEcC4cpwHKVLR5BBLIgLYYpGGRn49liyrasae38Zdd9S/vr+fx
         HS5jQ+UIOTezPtOAe2HXUP+FMJDyki/D+mjdS46LET8gIOyys8MOkt6ExsILtYyevCxu
         XzgYvkThJq70a1crjiewWT66jYGJIQFuDd3D76Qd1Lw26WYKnQSxB7XDM6NT5gEXA9l7
         BI/g==
X-Gm-Message-State: AFqh2kooLTaxQ9YmhEQ3/lpz7Q2FQu3S5mkKmq3gsnSQ+AXkueyDu+W9
        VzEQanHbpmtuPOQquKsHagKECyTdtn8BS2EJn6cyRmV671tx
X-Google-Smtp-Source: AMrXdXuXWs1cinMM8nu7CT3pSpT6UCWVc8rFfcDMJR5+DigSg1rCIFHA0ayWdT0tEZzNl5WWEnNdbamk6Rpn16LoYEL9D8m57AQG
MIME-Version: 1.0
X-Received: by 2002:a92:d20b:0:b0:302:a011:ae1 with SMTP id
 y11-20020a92d20b000000b00302a0110ae1mr225729ily.170.1671634947354; Wed, 21
 Dec 2022 07:02:27 -0800 (PST)
Date:   Wed, 21 Dec 2022 07:02:27 -0800
In-Reply-To: <20221221122958.1792-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b38bc05f057d748@google.com>
Subject: Re: [syzbot] BUG: corrupted list in nfc_llcp_register_device
From:   syzbot <syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5555 } 2640 jiffies s: 2765 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         b6bb9676 Merge tag 'm68knommu-for-v6.2' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=136b095f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3fb546de56fbf8d
dashboard link: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12bab1c8480000


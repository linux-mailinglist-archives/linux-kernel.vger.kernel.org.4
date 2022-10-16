Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B825FFCAC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJPANY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 20:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJPANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 20:13:21 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307E42D53
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 17:13:21 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so6439908ilu.17
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 17:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OT+jfCOL0Hy4Tnhgo/qN2uQhA3DtHNKYnUCMSoIMXs0=;
        b=GadkhopiGdcNgeQp/haVCZB3cWTUstPAGMGhDxgJjson/0Nlaq4INKAKJgvpp8wUo5
         V9SolkE/2hFr9c7UpvXMmYNMTSDj/5+NzdDaHmvY9AQEoPmoLhaHQjghd1X4//GFh+us
         NJByAivHG4awF0KgFCPTewZPHpe8eDRLbJPuUvdOFGZL3AB2zo6STXUZjUeD9Aj1GuLV
         to4bCt3hGx6atDH08MzFS+fqMJuFq4zIjAOaiEkSO/U2SOroppQXRTLzetyOuqoyhA3d
         utRN859lwSAnbUdI3fq/AjFiFY+qXVcT0jmIUYImFhS+ZpYACecByLJXq8p6S9VBRECg
         aGBw==
X-Gm-Message-State: ACrzQf2uh8GABUqcLTMEWI4R6UvTUljlCnvRzU2Sb29RAOhehF86OBOv
        5Em43JHDf5fu5gmVmAxrdV6+tWrlAA4Gj2/s4Z+npcEZYq6u
X-Google-Smtp-Source: AMsMyM7vvzNDTLJROIMmQNp2imff1LH298JeC+d8hXLa34m4I4Db+2qTxnf7Mkdas1UnFpH2j5fi8PRhIBRU6VTylyFr8zi+4f6e
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:2fa:7113:8506 with SMTP id
 g11-20020a92cdab000000b002fa71138506mr1883182ild.93.1665879200296; Sat, 15
 Oct 2022 17:13:20 -0700 (PDT)
Date:   Sat, 15 Oct 2022 17:13:20 -0700
In-Reply-To: <20221015234821.438-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8f71b05eb1bb924@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in batadv_nc_worker (3)
From:   syzbot <syzbot+69904c3b4a09e8fa2e1b@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4077 } 2636 jiffies s: 2521 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         55be6084 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab7aaa880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14854b8a880000


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B5646E90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLHLaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLHLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:30:20 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8842F4A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:30:19 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id z10-20020a921a4a000000b0030349fa9653so875728ill.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 03:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75neS/lkdeISVpKqYuaazhE+JF5LWGgiKKJqm1yyxZI=;
        b=4Fc7sBupufoQ1zosNVKjh1CX3tyBDwZqqHyRRxqUNPMdBnvC9QchMan3bnJikMB+kV
         TWwdIHgFeHqdmu3JCv0rpRjyi1jv6GOhUeXrG7zSe9NpBzmLhmNoa90H2gZZFd4nWEpB
         Ega8Ri8rWgqUS2lLJtZsB8Wj436p1oLBJcxWEBrEr802ymgu1fLRyt8axWGXJHZsSi0K
         rf44DhNtu+6xub30f20Sir936Bw9r6Z5pFlmD5/I5nzndeJO1KQpiDVh8/1ATy7z2+gL
         AoVnJnH3+5vb/LFUm3ozCL4WjLB3b+Mt+UGMpYaB0f1tg6sKmGoZ0cBd4EvhyledJ1Z5
         IqeQ==
X-Gm-Message-State: ANoB5pmLrl26B41HEIJgLTF5lDXD2S2aceUnOhfEs2ffvBIpxPlXE4iF
        H/qFi5EzgLBq6khT79QOWCI5FqLrvP+GFVbZG9wvcrjkcs76
X-Google-Smtp-Source: AA0mqf6nXjc62ab3UiSC++utB0tioyvDLX4yatRTfGMNbgMDyzP+axwKSj3xpoM2I+8xbWCLrLbvP0XyXQ3BtzNNVnusDVHOhBoJ
MIME-Version: 1.0
X-Received: by 2002:a5d:8618:0:b0:6df:9c1f:51b1 with SMTP id
 f24-20020a5d8618000000b006df9c1f51b1mr20400997iol.166.1670499019305; Thu, 08
 Dec 2022 03:30:19 -0800 (PST)
Date:   Thu, 08 Dec 2022 03:30:19 -0800
In-Reply-To: <20221208045304.8105-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4b91005ef4f5c07@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_destroy_all_locals
From:   syzbot <syzbot+1eb4232fca28c0a6d1c2@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5546 } 2655 jiffies s: 2813 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         591cd615 Add linux-next specific files for 20221207
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=177df597880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=1eb4232fca28c0a6d1c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1348317b880000


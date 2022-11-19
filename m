Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E8A630E24
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiKSKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:50:18 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E578B11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:50:17 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id w9-20020a056e021c8900b0030247910269so4870941ill.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 02:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzB/fWeSs8vqh90QDvUL1B2Fa5XtRgr5XG49IFMwCAA=;
        b=h6QGlZgccZ4ZYJHBUIYcO0uMOErq4sJJ4eewc7QG2oFAWvUHExQtKjUycX/FHJ9hkB
         wezWEQ0jmE0ucKjxZ0kWBt/NXpIx8fC0EG+MFqrz4yA17eqjxSnX4TfalzqfkFxNQrkm
         AIecxlJsPibFBJ0hF+8mrVGCR2v1rzJgAZqxX3vLFtSwOKtklF5lMRegL+OIMX20Lzko
         by7EJDJEZb/9nkpLl6uYxKS7e4oXdfDid9yK0Bw8jY8iE002pbOzMW+fm8igC1XCx7T8
         pDs7oKnUGFNpsEtQS45jhpxaJIdp+nLkqujXdIrlYqESRZV3UKxbzrqWwHLWSr7OICEl
         DSPQ==
X-Gm-Message-State: ANoB5plMN3j8VM6o1YaqheRC0k1+Z/T08nwJer0PjcosDcmtGSfgHfcK
        8/zi7wxHPxVaIsZVOSGrjM/9nN/5hZMTYmizYYzsu5UMZg3+
X-Google-Smtp-Source: AA0mqf7PKruePwrlERr9cDsT/phLUA028nUgZoOTU2DOjbOZjXFevSWr0qSdQ24MZzngRM6kskFYEswUAD9MMlmgphVpItEUC+1T
MIME-Version: 1.0
X-Received: by 2002:a05:6638:26b:b0:375:af9e:ca61 with SMTP id
 x11-20020a056638026b00b00375af9eca61mr4901032jaq.203.1668855017057; Sat, 19
 Nov 2022 02:50:17 -0800 (PST)
Date:   Sat, 19 Nov 2022 02:50:17 -0800
In-Reply-To: <20221119095108.4564-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000793ce105edd0969e@google.com>
Subject: Re: [syzbot] inconsistent lock state in sync_info_debugfs_show
From:   syzbot <syzbot+007bfe0f3330f6e1e7d1@syzkaller.appspotmail.com>
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

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4107 } 2631 jiffies s: 2805 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         84368d88 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=146d20fd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4e5e9899396248
dashboard link: https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120fe909880000


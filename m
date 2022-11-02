Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14CF616BCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKBSOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKBSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:14:32 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4023BC1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:14:31 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so8987163ile.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrPtUGwKy/PHlitjy/whP0A7GNzhbWYSIBUmh5L+PS0=;
        b=F7OPQOhWJok3zkRtmQXwt8EK8UPgEkNqw5Z/QneE9sf5Qk2G9pHUcI9eXwrVWLy85j
         hCKLCnIehe4Zpd2SvUnTBE2ftPzumPxPjINZufI6Q3Vg8/hw4P5lN5zJkqAIJg0ilzHc
         9jWN+H6v79rAYXYChLOFWriBAN2f6CY2rlzfsv7ZAQ/E5U+FS2DqK0T/kkXMnM2PDjhn
         p+E866EG+twWCF1fzKxZdKpkUPaZegD1etkIKUYktHaY+H+F1cp+rD1JU+ebTAHC2tnR
         h9dP6W8Bd1hbG5yxIfJkjGE8uAknK4bXfaFeWllC9K3vvEuSwh/BGsrsjpAx1sXnKep6
         yREw==
X-Gm-Message-State: ACrzQf2nJuOqsn1WZybebSwrIfPAZfSn1u7MHnmwlgkyHWlh7fqUMKqz
        7H0nN4EjT0VtHgRq4LYrIDbU9EsPHr/js8mbllbCQqBTcIgQ
X-Google-Smtp-Source: AMsMyM6Ts05xrBZy3OHeDywLh4tO+KHxpOy0FToNdS9vo4StWp3uNo8ICvNqaBRzRQo4tf3E+WrsV/ZI9YyNn+10g+idAJrfW5Wg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13c4:b0:300:ac44:b69c with SMTP id
 v4-20020a056e0213c400b00300ac44b69cmr12482117ilj.300.1667412865355; Wed, 02
 Nov 2022 11:14:25 -0700 (PDT)
Date:   Wed, 02 Nov 2022 11:14:25 -0700
In-Reply-To: <20221102135324.3935-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088962f05ec80cf2b@google.com>
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

kernel/cgroup/legacy_freezer.c:353:35: error: passing argument 1 of 'static_key_slow_inc_cpuslocked' from incompatible pointer type [-Werror=incompatible-pointer-types]
kernel/cgroup/legacy_freezer.c:364:36: error: passing argument 1 of 'static_key_slow_dec_cpuslocked' from incompatible pointer type [-Werror=incompatible-pointer-types]
kernel/cgroup/legacy_freezer.c:382:2: error: implicit declaration of function 'cpus_read_lock'; did you mean 'rcu_read_lock'? [-Werror=implicit-function-declaration]
kernel/cgroup/legacy_freezer.c:411:2: error: implicit declaration of function 'cpus_read_unlock'; did you mean 'rcu_read_unlock'? [-Werror=implicit-function-declaration]


Tested on:

commit:         a2c65a9d net: dsa: fall back to default tagger if we c..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
dashboard link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127fa2ca880000


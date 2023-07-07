Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5574ACB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjGGIUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGGIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:20:30 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3021D1FDA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:20:29 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262d69faef9so2236893a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718028; x=1691310028;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN1UEoiyjNN/U7zWTps4glZc/qi7ZNLVVS2aoUJ2q4A=;
        b=e/galWEtcom+9MzH07YqPhoxZFdpEGpQq6SjF+ANHg3sHfMaus40DpGDyHiD+aEHhk
         uxNSS5xuCO+LxQXsmMcnzLcY38/7uSCVByY9wuu/lutOl60ftprptM2Hnh9V7wwCROmg
         RSPm28kcOvAm7Aq5RWcDKPp6LC8UoMblZx6JBXpBbFOZlgPPXqDFAMg94xRk6k1pZ53P
         ZvRlbCcjSh96Ial4+JuxuTsXMskSrwEzTMK0JJSZUAdfHz3IjsD1LqWEjAg1foa6YGBc
         KWM8aoJmcV/SLSJ/8eeaAsu1O+NEEOfktkAgaqLr/QVx/tWDfUxsW4aDp4JGzgVnst0k
         D1ew==
X-Gm-Message-State: ABy/qLbBROcfVaAjuvHJcSs89sYgp3ONzEOdnmJ8DzqG6cm3Ertm4NiO
        x1LJ4WYapMh6vZyOnpiGKo8mcMHRTNnhuE5AskrRBD8702/R
X-Google-Smtp-Source: APBJJlE53elBOc0PVBkPt5sMuDbxYXfNijnU6gTgY9iSg9CUfuKQG7NUjF7iYEWUsnBRxcEyGfvev30rDbJTXm2Ub6F9tIUO/Zk8
MIME-Version: 1.0
X-Received: by 2002:a17:90a:ce8f:b0:262:e5e2:e5af with SMTP id
 g15-20020a17090ace8f00b00262e5e2e5afmr3633167pju.5.1688718028524; Fri, 07 Jul
 2023 01:20:28 -0700 (PDT)
Date:   Fri, 07 Jul 2023 01:20:28 -0700
In-Reply-To: <2224784.1688717214@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037530605ffe14e41@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in ext4_finish_bio
From:   syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, boqun.feng@gmail.com,
        dhowells@redhat.com, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/main: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "main"]: exit status 128
fatal: couldn't find remote ref main



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git main
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136ff1b4a80000


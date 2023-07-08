Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94974BBA1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGHD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHD6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:58:31 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387241BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:58:30 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b88decb2a9so51724425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 20:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688788709; x=1691380709;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O32DTWdsFRvWxFXpaVi9TOBMpJKx59j1yv15pFQGRc=;
        b=atu3qdzsNS+zq07jcSofJH6PuUU1O8Ws6v5Itc3H12wi6EyYskynyV/sp27T1O1irj
         ETuYuFPM2uCyaXfqrYTarTJNJUIMTfPvztIttILMp3aBsov8HmB8Kixyjf06HuqDTZyo
         sNKAIfjeaxXXqRLiSu6Aoa9E6AIfEcdbakxEuFMTCUiBDFn/E5tQ8xQx4v+GtIz4AjHe
         it+Wgr7dYiEb8dbiLKVbv/yUxgMHGNMhsZVW0Io8NIbXSyDjWPipM2ML2WY2v7cD3TON
         R5jUskRZrWDJsG8i/f7SRBJazgU/fG5Fctwy+X60Cx9QNj7NP0PJEPR1McLumW1/mL+E
         tOLQ==
X-Gm-Message-State: ABy/qLZGONpEC3m2zkW90dkqU6YkJF8kV25aB1M68kQJArL6uqw+Obef
        Ygq49/7KmGUgnOhTgXVIMD9TsITUJBe0teV44qDzTdxvzSle
X-Google-Smtp-Source: APBJJlER+d/iqd1eSF7H5OQIYkrOCRq6GerJoVqJL2sqCXcOcT3z/hFwfc7JkXSfLu9oaRCZm/nT+2bsmYUbzIHmhmVAby8Qx3vM
MIME-Version: 1.0
X-Received: by 2002:a17:902:b418:b0:1b7:f55e:4ab0 with SMTP id
 x24-20020a170902b41800b001b7f55e4ab0mr6255827plr.0.1688788709723; Fri, 07 Jul
 2023 20:58:29 -0700 (PDT)
Date:   Fri, 07 Jul 2023 20:58:29 -0700
In-Reply-To: <20230708034748.1431-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024d45005fff1c3bf@google.com>
Subject: Re: [syzbot] [f2fs?] possible deadlock in f2fs_add_inline_entry
From:   syzbot <syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/lockdep.h:291:52: error: 'struct f2fs_rwsem' has no member named 'dep_map'


Tested on:

commit:         296d53d8 Add linux-next specific files for 20230703
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
dashboard link: https://syzkaller.appspot.com/bug?extid=a4976ce949df66b1ddf1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13354628a80000


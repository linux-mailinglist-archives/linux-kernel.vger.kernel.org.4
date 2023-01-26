Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECE67C590
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjAZINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAZINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:13:18 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27819302B7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:13:17 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso810046ilv.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEfpfP62XIqchPRHLndjuTCyLWg79Hv36f/NXAdlpAs=;
        b=FdfCT0D+hcNgfEu6h6M/psMxKfOmxsaYGZ64GqpsO6Lth9ZB2S07Cg7GCynNWdUEEz
         51AS1XrLdrHoi9pO92GZAIhRuqwx2FxQSs0INYaqVnCSKiM+ilHTCSx1wJ7gxZOIHIMi
         kdMhU46oxpZ3gRl0/FDwdF7wckCw8+9Pr2yGhnK7+kOsGYmH85b2tO12ZUH/lG2nhZTY
         jRfRGty6DEZQjnjX4m7VJAziWPX/iIEK2XH3O+hiC16A2zyMO3oAsm20SZjd0/AQFJxs
         dh7ywLEkQ0XWs0vP0gTRQ+nyYaRIZexeum26I6E4SOsGAjt9281A259gvcOxtc2CjxOE
         VhIQ==
X-Gm-Message-State: AFqh2kqt/wOdHQRr9OBM0KSdJuGLe1Dj2/4L1sTg+sy8KRvt47Lu3AYB
        2Xem2Rna78szCm0f+3anwREl2VahFkdchymQGl49XqDImykj
X-Google-Smtp-Source: AMrXdXsQG5JQdoaLSZYANWYd/5p96G8xroKqzn7EOH/B///qz3B0WtGEa/YaV/oAUEqZ9dapP40iNAIaLjwH/eN2pWh/x7CIJWVN
MIME-Version: 1.0
X-Received: by 2002:a6b:e019:0:b0:6df:5aa3:393c with SMTP id
 z25-20020a6be019000000b006df5aa3393cmr3225578iog.81.1674720796499; Thu, 26
 Jan 2023 00:13:16 -0800 (PST)
Date:   Thu, 26 Jan 2023 00:13:16 -0800
In-Reply-To: <0000000000005af92105e80510f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c692505f3265254@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_get_ea
From:   syzbot <syzbot+c4d950787fd5553287b7@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, dan.carpenter@oracle.com,
        eadaivs@sina.com, eadavis@sina.com, eadvis@sina.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, ntfs3@lists.linux.dev,
        pjwatson999@gmail.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

syzbot suspects this issue was fixed by commit:

commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Oct 10 10:15:33 2022 +0000

    fs/ntfs3: Check fields while reading

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cc6199480000
start commit:   fef7fd48922d Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7341d0f941b3356
dashboard link: https://syzkaller.appspot.com/bug?extid=c4d950787fd5553287b7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133d4479880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f05e71880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Check fields while reading

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

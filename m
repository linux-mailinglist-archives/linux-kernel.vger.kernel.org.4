Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F201627448
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiKNBtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiKNBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:49:39 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303BE4F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:49:39 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id c14-20020a5ea80e000000b006d6e9b05e58so5274235ioa.23
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NIciGEMFs3GR0VxmcRj2FqKZjUa05yht5hU+xLHqL8=;
        b=XDVRikc8HBzITxMYGAA8nfZbO4PD8pwqcRl18HG/OM5mCx+4OABwRXotnq0yccxtjX
         6YlXaMryIY2iOENuB5qYLi6xbe+f88+Pxeo1QBVExEVasP6FXm3trCLkYkgpSOmSw7yP
         yDKsXQnTnf1K0astSnOVoM9UXiykvAjIexo2Tz56MPwyQz6YLlIWblKjh2K8GrSaC8iK
         2SlL6WAGgDwnE4IGVzxoSL04LyStoWYv6Qss6+2jCYAGPk9p/V0OOGsI5bNmGs26xLdc
         yetAgosEqi6P0RDpzmBLBqUxde2Ee7TgMfjqTOzPs+YnrZ45INFPXKTbHeeaX1/9YwAa
         GrQg==
X-Gm-Message-State: ANoB5pncLY1Zqz7gdONYPFI5onEvWSnCpmP+tXk9YEEhdV/EQ0Wn1sPh
        K3auU2HJxY0aAsLa86KmrPllTJTppfMzgM23h9zYBjLmB07e
X-Google-Smtp-Source: AA0mqf4oSH+2L1giJjDUKiHTVQUltrz0Z1AwBwcVEqq+IVE588oskcYMuAffWmdXohdOr+bP5nkTCRoWMV6ijRU4lY/7rTO8ke0c
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1061:b0:300:d3e0:2492 with SMTP id
 q1-20020a056e02106100b00300d3e02492mr5288163ilj.148.1668390578548; Sun, 13
 Nov 2022 17:49:38 -0800 (PST)
Date:   Sun, 13 Nov 2022 17:49:38 -0800
In-Reply-To: <00000000000041665a05ed5c17db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7f9c605ed6473c8@google.com>
Subject: Re: [syzbot] possible deadlock in vfs_fileattr_set
From:   syzbot <syzbot+abe01a74653f00aabe3e@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, sroland@vmware.com,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de,
        zackr@vmware.com
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

syzbot has bisected this issue to:

commit 6dd6b7643e723b4779e59c8ad97bd5db6ff3bb12
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Mon Jan 18 13:14:19 2021 +0000

    drm/vmwgfx: Remove reference to struct drm_device.pdev

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1418e6a5880000
start commit:   f8f60f322f06 Add linux-next specific files for 20221111
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1618e6a5880000
console output: https://syzkaller.appspot.com/x/log.txt?x=1218e6a5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=abe01a74653f00aabe3e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138b76ae880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ab1bfe880000

Reported-by: syzbot+abe01a74653f00aabe3e@syzkaller.appspotmail.com
Fixes: 6dd6b7643e72 ("drm/vmwgfx: Remove reference to struct drm_device.pdev")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

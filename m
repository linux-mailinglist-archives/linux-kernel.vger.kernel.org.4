Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57196A6C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCAMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCAMql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:46:41 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8B16880
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:46:40 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id b26-20020a5d805a000000b0074cfe3a44aeso5565598ior.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 04:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5gRBWvCrC4ivORDLYanYAKruxMNDrxF3nhXlCgZ6d4=;
        b=o3Zcvm6rcWORaHzWHYZFyeUDHHTCbky9gKjGkvWZ3KFaaTtDEsz1puMTvyuDknr0Pd
         GLukxbD4YSykgJL4/LTxRMNkrCc14O5BIUtBKikx+nITumgCXwkjpi0VCJLK7rdny+Xq
         hVw5VB9n8XFbaFDqWxwBcLfteD6MFXxWN0ZIGOH8hg8WAghIhOwxfgsY4BO2oWXgynfX
         L1MwqBVY8V09/xIa4Tl4M57QNji3yvSOwRLDhPW41Fa2de4MWDBIF7igwFlwMbxqvyd0
         TIYSaqfec1rbkHjdEDfrQsEh+XiEd+7uBCiWQqRlWRNhxT18BE/MsDy+qVeG04K2XJkZ
         hZ7Q==
X-Gm-Message-State: AO0yUKUz74ifowFXSPmc/Y0BnIHdYy51eWpEr3x2K31qDWhFGBC4Uej0
        iwS5xScEGD/qU9fKTYNfoZBmbAOILrCCpg04wEIhFU/Ilt//
X-Google-Smtp-Source: AK7set+jinAjUAWYrdG6kv0VrfxDnBTCXLpXXJuHSxiCG5jjotaU+gO2m6Gn4BjUeDtSSYYxYS1qjF7hYGwhrzXiIgt3sUFd+X2Y
MIME-Version: 1.0
X-Received: by 2002:a92:ae12:0:b0:310:d348:e59b with SMTP id
 s18-20020a92ae12000000b00310d348e59bmr2898095ilh.4.1677674799832; Wed, 01 Mar
 2023 04:46:39 -0800 (PST)
Date:   Wed, 01 Mar 2023 04:46:39 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e24fb05f5d61afb@google.com>
Subject: Re: [Android 5.10] kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        joneslee@google.com, lczerner@redhat.com, lee@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, sashal@kernel.org, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tudor.ambarus@linaro.org, tytso@mit.edu
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

This bug is marked as fixed by commit:
ext4: block range must be validated before use in ext4_mb_clear_bb()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Android 5.10
Dashboard link: https://syzkaller.appspot.com/bug?extid=15cd994e273307bf5cfa

---
[1] I expect the commit to be present in:

1. android12-5.10-lts branch of
https://android.googlesource.com/kernel/common

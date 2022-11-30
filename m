Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38EE63CE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiK3D6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3D6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:58:21 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F569DD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:19 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mq10-20020a17090b380a00b00219671da986so401570pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j9kMceXn1cnLuprRWCueDZRsr0h4k/o4EX2l7BfaAKs=;
        b=k/zN1PHrTUFfyK81LThsVo5tS1UFtZXYRD210Jx4GwppNsuO7htbTh33UYvFpacKnk
         JRQYUfmDYSKausBt13t7CYZKaBCcL9BYZd1/fMcjR1V6h2usf/AtbsnxvS9VNeBl9xy8
         Z5Gv5siaUq/gcIfnjdY/eQl/1N5sLbNnx3B1uoZlQtyYZEoSn827RSCrScFYUJIe6ihS
         BubA0AOzCCsYVqCR+9qUoKxBJXTXjOyvogZgLxMJhBJ9C0Itsb0WzB5Ivmemtps5NEnU
         c0oAYz469ATVB+f+hBxdT7ZrYbxUo6sbMLNXxvQXINclRCeTqa+B1m1y94+ZXMNYnCmS
         U6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9kMceXn1cnLuprRWCueDZRsr0h4k/o4EX2l7BfaAKs=;
        b=gjubQiXOIQ5UIy+dqYMA2fCwH3m1VvNG7nypyKOT2Dh+DQr+r5pMrsO26lmIl4GAl9
         gGq3oBbnLSRDElH1cXMEns2saOpzcfDYnFSUQfY6MKFA/i8lSxW/+PFVpfMgEJKP6eME
         /39uD3hAggndmGqsDLi70BbycdK2Z9sDLDYnhbz8g2Unp6fq+NOVG+/c9Ro+efw4T33x
         lV2iL5s1g8Lnw/RZyrr8Zo0GdXr63NMVxXV0DjkH7gTNKYrE1x/BVV6ArcGe1x5V872X
         +B9lS4+L/PBwCOypKiZbZDwJ7qwvwCQTQj/YzbKqxWCPZadgsZf1Rv60lPneSLmjNVap
         vccQ==
X-Gm-Message-State: ANoB5pnnHk1DGlwt8ZkzSgwuJbVEcWlzRgAgkrP28YEKNfztwTBgTG4f
        ilmRbXYQL0BrFFTvRyo2MLiVwBHwbMtBLg==
X-Google-Smtp-Source: AA0mqf4gHVyd5z+Q6moTnxBWltBebY2+b/TMfIYflWFNmt9wOs9AgKTg0hi47KdUqQJ1v6ZgK/kG0eOQdlF6bg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:1303:b0:561:7dc7:510b with SMTP
 id j3-20020a056a00130300b005617dc7510bmr61676656pfu.3.1669780699429; Tue, 29
 Nov 2022 19:58:19 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:57:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130035805.1823970-1-cmllamas@google.com>
Subject: [PATCH 5.10 0/6] binder: backports for data leak and UAF
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Carlos Llamas <cmllamas@google.com>,
        Zi Fan Tan <zifantan@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of backports consists of 3 main patches from Todd submitted
upstream in [1]. The intention is to avoid untranslated data from the
senders to be visible to the target processes. More details of this
issue can be found in the same thread.

Furthermore, Todd's patches also fix a use-after-free issue introduced
by commit 32e9f56a96d8 ("binder: don't detect sender/target during
buffer cleanup"). In which invalid userspace input causes unprocessed
objects to be incorrectly released. Any subsequent references to these
objects will trigger a UAF as noted by the following KASAN trace:

 [  244.748468] ==================================================================
 [  244.750486] BUG: KASAN: use-after-free in binder_ioctl+0xb88/0x32e0
 [  244.751276] Read of size 8 at addr ffff67b1865bea58 by task poc/593
 [  244.752074] 
 [  244.752725] CPU: 0 PID: 593 Comm: poc Not tainted 5.10.156 #1
 [  244.753683] Hardware name: linux,dummy-virt (DT)
 [  244.754717] Call trace:
 [  244.755216]  dump_backtrace+0x0/0x2a0
 [  244.755836]  show_stack+0x18/0x2c
 [  244.756306]  dump_stack+0xf8/0x164
 [  244.756807]  print_address_description.constprop.0+0x9c/0x538
 [  244.757590]  kasan_report+0x120/0x200
 [  244.758236]  __asan_load8+0xa0/0xc4
 [  244.758756]  binder_ioctl+0xb88/0x32e0
 [  244.759283]  __arm64_sys_ioctl+0xd4/0x120
 [  244.759677]  el0_svc_common.constprop.0+0xac/0x270
 [  244.760184]  do_el0_svc+0x38/0xa0
 [  244.760540]  el0_svc+0x1c/0x2c
 [  244.760898]  el0_sync_handler+0xe8/0x114
 [  244.761419]  el0_sync+0x180/0x1c0

This second issue along with the reference to the commit fixing it was
first reported by Zi Fan.

The other 3 commits included in this series are simply upstream fixes
for the main patches.

I've tested this series applied to 5.10 and 5.4 which fixes the issues
above as expected. So please pick these up for 5.10 and 5.4 stable.

[1] https://lore.kernel.org/all/20211130185152.437403-1-tkjos@google.com/

Thanks,
Carlos Llamas

Cc: Zi Fan Tan <zifantan@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 

Alessandro Astone (2):
  binder: Address corner cases in deferred copy and fixup
  binder: Gracefully handle BINDER_TYPE_FDA objects with num_fds=0

Arnd Bergmann (1):
  binder: fix pointer cast warning

Todd Kjos (3):
  binder: avoid potential data leakage when copying txn
  binder: read pre-translated fds from sender buffer
  binder: defer copies of pre-patched txn data

 drivers/android/binder.c | 437 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 383 insertions(+), 54 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog


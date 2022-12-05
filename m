Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB3642884
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiLEMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiLEM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:29:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4933712AEF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:29:50 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e141so14254056ybh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=giRvEYAwiRPITUh13CLaa4Mc5f/fBZ7Qkfvhp0h/LvM=;
        b=z6kUjH9H2MrH3vuLbkBvK4flQRWSCXHyJbeXxRu/4vvPEYpJl3vyudP+XrJLLM9veK
         xSlcf9juF6rzzwH+fzwird9EmQT6WPFnFM6jhaPeSSyAj7+D1m5XvEDhwJ+quV46QLqJ
         l708SmW6oYOOya2yMFMp+msReKhG0X60JLR6UhQBI2iCUS/UWr+fQUYECWZUM3Z8zAAA
         dI+S1EJmX235DuH4xqi5OvocTT4uvpUjtUrCjWdUiFaeu8+ZV1WbWfpj1aGBeDsxgWzy
         x0pw8eWhypOzL7fMexWYTyYCjVHc7byKJbVEGxxUdD87k123/93sWlTsmHepKl77SKEv
         /2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giRvEYAwiRPITUh13CLaa4Mc5f/fBZ7Qkfvhp0h/LvM=;
        b=2HdDABuBYtCWqs13V+9DmCuYi8xh2jsmPnclU5kCQHZl5Bnrqb7RDjo54hXuIiyD86
         MktJEri1Fpj1IVr0zfJTC+SOh58CS8seUA6cVNOui8d3bMoKVavMRkQazpSH+0i7kSKB
         8Fp+slTa+QumhLHNxF0FGwJFzYYYfpSp3mzZZ+HWxx/xN0i4vFpJFVC1Uzl7EbMGZu64
         BrxF76lNddMfP5DwiK6hj7rjK7vkrpuS0taTa+3NFMhk6QBeEIcT9OTh2AVQho80jRWw
         Xoxbx6CK3YCOOaLMAcM9ac/XVH/qDrJ48Vamu5AfBzPbqE15m9asm+W8qqr86nxHUndH
         xVAw==
X-Gm-Message-State: ANoB5pmGIgsSJ5rj9/GiMkd1IzUkS+vkOvJ76pVwCQmh84VfPZQgpgW/
        ps542vf0xXJ/UdcXvVFCmB2rwFf9UQf4NO2sHufHxA==
X-Google-Smtp-Source: AA0mqf6BFKZrCho5Mrlj0Lf0pw6Ez4QBffxKSGiujFeQTm5K6Y/CZfbTwMQPrHSkmXlsPcZm7Krm1w18AMc763D4IGA=
X-Received: by 2002:a25:ed05:0:b0:6c4:8a9:e4d2 with SMTP id
 k5-20020a25ed05000000b006c408a9e4d2mr79378135ybh.164.1670243389244; Mon, 05
 Dec 2022 04:29:49 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 5 Dec 2022 17:59:37 +0530
Message-ID: <CA+G9fYsM2k7mrF7W4V_TrZ-qDauWM394=8yEJ=-t1oUg8_40YA@mail.gmail.com>
Subject: selftests: net: cmsg_so_mark.sh test hangs
To:     Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The selftest net cmsg_so_mark.sh test hangs on all devices.
Test case run with "set -x" to identify which steps are causing the hang.
Am I missing any pre-requirements / setup ?

+ cd /opt/kselftests/default-in-kernel/net
+ sed -i '1i set -x' cmsg_so_mark.sh
+ ./cmsg_so_mark.sh
++ NS=ns
++ IP4=172.16.0.1/24
++ TGT4=172.16.0.2
++ IP6=2001:db8:1::1/64
++ TGT6=2001:db8:1::2
++ MARK=1000
++ trap cleanup EXIT
++ ip netns add ns
++ ip netns exec ns sysctl -w 'net.ipv4.ping_group_range=0 2147483647'
++ ip -netns ns link add type dummy
++ ip -netns ns link set dev dummy0 up
++ ip -netns ns addr add 172.16.0.1/24 dev dummy0
++ ip -netns ns addr add 2001:db8:1::1/64 dev dummy0
++ ip -netns ns rule add fwmark 1000 lookup 300
++ ip -6 -netns ns rule add fwmark 1000 lookup 300
++ ip -netns ns route add prohibit any table 300
++ ip -6 -netns ns route add prohibit any table 300
++ BAD=0
++ TOTAL=0
++ for ovr in setsock cmsg both
++ for i in 4 6
++ '[' 4 == 4 ']'
++ TGT=172.16.0.2
++ for p in u i r
++ '[' u == u ']'
++ prot=UDP
++ '[' u == i ']'
++ '[' u == r ']'
++ '[' setsock == setsock ']'
++ m=-M
++ '[' setsock == cmsg ']'
++ '[' setsock == both ']'
++ ip netns exec ns ./cmsg_sender -4 -p u -M 1001 172.16.0.2 1234


Test log:
  - https://lkft.validation.linaro.org/scheduler/job/5915863#L1646

metadata:
  git_ref: linux-6.0.y
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
  git_sha: 7a60d1d7c4cda7564a42dca46c0a1e358ae4b887
  git_describe: v6.0.9-595-g7a60d1d7c4cd
  kernel_version: 6.0.11-rc2
  kernel-config: https://builds.tuxbuild.com/2IJaCkGKmSrmmsbPT5mEA6ObUqp/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/pipelines/710632137
  artifact-location: https://builds.tuxbuild.com/2IJaCkGKmSrmmsbPT5mEA6ObUqp
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org

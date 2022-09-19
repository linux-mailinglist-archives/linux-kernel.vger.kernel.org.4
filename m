Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FE35BD55F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiISTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiISTvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:51:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4163F31A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:51:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f23so208700plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=VA//horOBd3PrAc8DnRR/mI0g3v4NDEkI6a52rxQ2ys=;
        b=WZjjS5p+Vur1TXy3TOJDaFWba5FbE7eKC+M41Bb911DCtMkihvXAy79z1jucYOeWOY
         Ou2sMD9wxfs25a/wPMTKR3O1NJsDdv6ws/ts9IMfd9fe96qqVYVu85qDkqjmHta61Vc4
         H4ptzfIA34nursQDuv4gWYumXreVB32LeosG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VA//horOBd3PrAc8DnRR/mI0g3v4NDEkI6a52rxQ2ys=;
        b=O01KW0AOLjcm5Oc8BIkDfTz9Wk/TA5R9OQc1btmzynOi01WxnbGCzqxB72E6/HSOH2
         fBHLAxm5KqRMPrvbBVAWnqSPs/L3hf1z8FloRT6DOeATMuRpSQ77gjXEJ0lUAAGClKPH
         tqbCqJ2MSTa/CeBLAJc1lq86r5zNiqgvBizqmmslaac6DhmQkYIyhZEyXNq7HJ/TcNZU
         2NW7ZvILWZvoco8HXDj7EQF7Mnadwla8QFG3FCavFYh9eAG2/CzMhrPVO2MvFuyTXvJU
         3Gm7jdNuEwdTJLmboQ+/Ajjm1MtT2z61YR2MlxnpkyHElxM6y+Yyhp5ghh4GyUp/nNzr
         h7Ug==
X-Gm-Message-State: ACrzQf2262boBxm21s/XrYF0D/ku2Y/QThCG62Q3nWQ5MMQBepBxW1M+
        nP+3e0IrvJulmJgExJQhkELyUw==
X-Google-Smtp-Source: AMsMyM5ZCPkPLh44jdpnf3+8XQ9Xj5OdtJY6BdJwY5WsG+7PC9Zg9coiilSfSpJ45dGPW0dQGItPig==
X-Received: by 2002:a17:902:cccc:b0:178:a9b3:43e6 with SMTP id z12-20020a170902cccc00b00178a9b343e6mr1304869ple.92.1663617108563;
        Mon, 19 Sep 2022 12:51:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b00202df748e91sm7126104pjo.16.2022.09.19.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:51:47 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:51:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Alexey Izbyshev <izbyshev@ispras.ru>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] execve reverts for v6.0-rc7
Message-ID: <202209191245.B40A17BA51@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these execve reverts for v6.0-rc7. The recent work to
support time namespace unsharing turns out to have some undesirable
corner cases, so rather than allowing the API to stay exposed for
another release, it'd be best to remove it ASAP, with the replacement
getting another cycle of testing. Nothing is known to use this yet,
so no userspace breakage is expected. For more details, see:
https://lore.kernel.org/lkml/ed418e43ad28b8688cfea2b7c90fce1c@ispras.ru/

Also note that this is expected to introduce a small merge conflict for
the coming v6.1 merge window, as seen in linux-next:
https://lore.kernel.org/linux-next/20220914155533.70c10493@canb.auug.org.au/

Thanks!

-Kees


The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.0-rc7

for you to fetch changes up to 33a2d6bc3480f9f8ac8c8def29854f98cc8bfee2:

  Revert "fs/exec: allow to unshare a time namespace on vfork+exec" (2022-09-13 10:38:43 -0700)

----------------------------------------------------------------
execve reverts for v6.0-rc7

- Remove the recent "unshare time namespace on vfork+exec" feature (Andrei Vagin)

----------------------------------------------------------------
Andrei Vagin (2):
      Revert "selftests/timens: add a test for vfork+exit"
      Revert "fs/exec: allow to unshare a time namespace on vfork+exec"

 fs/exec.c                                   |  7 ---
 kernel/fork.c                               |  5 +-
 kernel/nsproxy.c                            |  3 +-
 tools/testing/selftests/timens/Makefile     |  2 +-
 tools/testing/selftests/timens/vfork_exec.c | 90 -----------------------------
 5 files changed, 3 insertions(+), 104 deletions(-)
 delete mode 100644 tools/testing/selftests/timens/vfork_exec.c

-- 
Kees Cook

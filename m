Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4C3608EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJVSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJVS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:29:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0023F32E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:29:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id io19so151989plb.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ke5eIvvI5eCtYNiwclKDnikzCwvckbCDiYPF6Tj1imc=;
        b=QfWGXv74zHYsCEKCzs3pzxyb+u6ZpsB0kuEN3EiocCOVBZ5RpHvOthGsvzoJbhiDXQ
         2XMHJYJu9Ww8+t0b5jg8cRXaJp40iqUSwQ4xnY4FKIwoKitZnWES01K4AcZacx5WNnxg
         bQTy+Ulra75+KaiIu0XQNYaUOVZs6/tuHBi1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke5eIvvI5eCtYNiwclKDnikzCwvckbCDiYPF6Tj1imc=;
        b=tpqZpsKu08Qveby7dq49kRd0TdeY6CTG73mWvgLNM11DZVx5KTrWzPWo7eqGA5I74S
         1mEvd1CKMw+JnbvOJ3FVkrJELXOwc3Bbxhyi8HSwGOalYhS2wquFpwSTpSGjXg3K48lg
         487zttbvtMzfSGyvHxKAxlifjKEHZCUsOext398gOSfsCnYF8IHu94/2GJgxsdnOm3R4
         GpSHndxdTG0un9DGgSkUZ4dqqbZJX6vsSb/Inl/f19hcQk4eyfAZEUfBavxtrU17nwXT
         k8WyLwiEES1o8+g2eqOX9hJrChFj4MYZUT7NQLNdUHAqyj3gYRz4Txnff7oPy29T/4xF
         60cg==
X-Gm-Message-State: ACrzQf1PU+bc3cI3chHfY/PHy/h9UC4Hvi+TFxDS7Bx2LCBRrMvdVC+w
        yLGn7z24gYy/C5cc0CSPuX0FRQ==
X-Google-Smtp-Source: AMsMyM75WuszreNn1hsHB7Pxuapw+PwlrCbIloKlGUfcGQMN628JRLLilodjU+kZh72YpXF7fQVdTw==
X-Received: by 2002:a17:902:d3cc:b0:186:9720:b19b with SMTP id w12-20020a170902d3cc00b001869720b19bmr1498965plb.3.1666463391490;
        Sat, 22 Oct 2022 11:29:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b001755ac7dd0asm17211091plf.290.2022.10.22.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:29:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/2] tty: Allow TIOCSTI to be disabled
Date:   Sat, 22 Oct 2022 11:29:47 -0700
Message-Id: <20221022182828.give.717-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; h=from:subject:message-id; bh=iR9JEWgQAWvHWSX99nEJpgLePgBlLNOFiur1YPdjibQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVDac31LObe+GNfv3yrM/Q03eDe7/+zs//PYJn4/G MUdzvBSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1Q2nAAKCRCJcvTf3G3AJrNuEA CMljYUKxXfT5CJr4I06XcaaWVGW3cyeVLcKSJrY5HisrklFSz2k5LB2CHUV6s6q4BTB3XYjDj80Qcx 71CmuKS4+GI5OPslOgWYtse9jcUY5K8ThaayhCb3aWyTAENxXcaS5Grc8RT+dimb6Pw7R0Q7W/KbX2 YJIXKNnBPzj8OMRjEixt38CCWTZQg5+J1JTuaKhu9HNNRE+IOiQyANAKz5WoTtvZDhbJGY8Ilk52/p cfUEgLssA0ekTy4vuaHecxpDj7/Z9OJqRiD4l48ivKXgS1BXkW4BmdZRPfreeZ+4S9h019nFED7i2K HMrTW97+ZoE9hA+agq0UDYhYk+YgTC0pk2wjL4TjMEezNMSperQB96f/s38F3JDSetS3ImorQpWOFl 3O0jJK+07hbKogfytaa0YMDEMU4mxA4071amKllxrcpCpEZq4lSNOA1zQB6F6nc56o4W1IBcigs8di lVMHO+totAbiVv89nAZ39nvzv9lUvND9G0afK4LivTadK8R4VXafY8+dKIOH/L88ppAyGrhkh1hSea la92nxd+VY9HxvDWwBgp7nGQcOdH5Sjgqq4hbPxKkAUUS5h3vxiGgbCJrWTTa8hgRJ4riE52dvBAbn G16yfHMmdcaDfkK++mgUGR/injEMhDT59adWLdZXNuZ9XT04up3OmPvBFChA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v3: make sysctl a bool (Jiri)
v2: https://lore.kernel.org/lkml/20221015064222.gonna.435-kees@kernel.org
v1: https://lore.kernel.org/lkml/20221015041352.never.966-kees@kernel.org/

This is so very long over-due. We just need to do this and put an end
to this legacy operation.

Repeating the commit log from patch 2:

    TIOCSTI continues its long history of being used in privilege escalation
    attacks[1]. Prior attempts to provide a mechanism to disable this have
    devolved into discussions around creating full-blown LSMs to provide
    arbitrary ioctl filtering, which is hugely over-engineered -- only
    TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
    TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
    had historically used TIOCSTI either do not need it, are not commonly
    built with it, or have had its use removed.

    Provide a simple CONFIG and global sysctl to disable this for the system
    builders who have wanted this functionality for literally decades now,
    much like the ldisc_autoload CONFIG and sysctl.

    [1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
    [2] https://undeadly.org/cgi?action=article;sid=20170701132619
    [3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/

Thanks,

-Kees


Kees Cook (2):
  tty: Move sysctl setup into "core" tty logic
  tty: Allow TIOCSTI to be disabled

 drivers/tty/Kconfig     | 19 +++++++++++++++++
 drivers/tty/tty.h       |  2 +-
 drivers/tty/tty_io.c    | 45 +++++++++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ldisc.c | 38 +---------------------------------
 4 files changed, 64 insertions(+), 40 deletions(-)

-- 
2.34.1


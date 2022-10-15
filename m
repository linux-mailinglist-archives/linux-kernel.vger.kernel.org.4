Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE65FF8DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJOGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJOGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 02:45:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385D31EFC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 23:45:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so6631059pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pbgBol5WLtIjo0mauMLFNdpMQOgJnyWv3/HUmzzNak=;
        b=PtnpoIjUqB9UGb77uz+5/3Qiuv2SRAS6qy2kQKEpkXDMs0n0wgD7DKTNygle+IMNTT
         7IYWrCgmD7b5Nol9xrOHi6BopUp/KHMHMD6y+6KNDlogtWliZG7JX6baAYRHMoyjbZ0w
         G0remnE33HZvIuWZFqLRvH5NTzQO9kepUqOGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pbgBol5WLtIjo0mauMLFNdpMQOgJnyWv3/HUmzzNak=;
        b=CdIt3jlgghCO0Oj9SNHCNrIVsbUSgbOIzVcW1xe5xZQLKCi17T/HWQzcB4/2nSY5gc
         be3NZpr/047mnU+hTo9H1mhJdvL+iWaLHFD6sNUBA/CVNA71eQX0+qK55iR9kvrQIMGI
         tTqEenhxdchm3LWlWu/rk2fpnohJMu0tgpfH41xA04CO/Tm+HcU7KziuwK5/chREuVYi
         8Pc87mUiCDfIjVP1YoMwAIYs+GPnS/gh3rEgBlRW/B5qR4TCVQG6ruSXAEiumEGKWvs3
         HqoGHeGN006Y2XGzSEx7nns5CuizXCqp3LOG+IRM9xJOyLtB9m23lCEytur5J+rSlvPB
         FN8g==
X-Gm-Message-State: ACrzQf2Hpk+MEDCTYT+3WWjKt9lO8PEdWM+kDdQjs9IEyrmZeY4TZE2g
        3KbYdGfWC3+4QOXQBkwytVbkE4747NegRg==
X-Google-Smtp-Source: AMsMyM4fuUQdjM6KT0EYpamRnAK6l1KC5kyZex/hf5CN0iUy8Q5Dcb8/qMSaSf86LhfRzZ/maxEr6A==
X-Received: by 2002:a17:90b:3141:b0:20d:49d6:30b with SMTP id ip1-20020a17090b314100b0020d49d6030bmr20498848pjb.223.1665816319889;
        Fri, 14 Oct 2022 23:45:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1-20020a620601000000b005626a1c77c8sm2774166pfg.80.2022.10.14.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 23:45:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] tty: Allow TIOCSTI to be disabled
Date:   Fri, 14 Oct 2022 23:45:13 -0700
Message-Id: <20221015064222.gonna.435-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; h=from:subject:message-id; bh=1YttJrr6aO9lIQE0JuwvoV1MXmKmA96/hUMi9+UVKN8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSlb6FaD0SO1Ro/0pPpEFmopLMiZ2GJkxmxNEy9lM xByakxCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0pW+gAKCRCJcvTf3G3AJk2dD/ 90I3bh80CwgHn3KM141BKsen5klAGRiM9K6k8rbh7VUWk/P9ASMRB0jQE4cMLbK5nqORdYMC0ejbOU F3Y6I3XgVDfkCZuIrBW9PTwwpX9G5whMAvXiOBlSCgJP1w439zjpJE/KkLKRFkd68FVcdmAIoU1bKG Lt1wDPLZ0ldA3X2pI5R67rtqvIHOccCIQuWtUfRIHtDafGVABD/Ilp8AErDeDiqRYrS2UAfslN7a1y q3+8zgalHo6paYvpZFPmKeZyP7xMUhknn6McbEKCs0tQeci+zWMagTHUiJSJtttPzij6m2CdCy1EPs i2uu7fh+9F/GJ4afKIH9hCGvEgRvwDg+59l/4XyFREjJzRyI3i+xyJqQnyjsboShH/xhzEUN0svSjf 9yKFM2OS09kJnxD8120AhMJvmZMzgB793NTBAMKfqXBJWvJgNici1uTwvsBDeprkpC4Q3ptnlR7Lzo Q0QiimjYUIJlYms1InFRFN3aQd3C/yGqUrIUnQ58fQYlOYvo5LyfZ8tL1PVhZPPAEdB2T/9RM6yyhx PS5x/+8GMt0kZjfn/Zrl/ZzVzQ6Y8zA+AgxR33X9E0Eaci5qgdORHmBjbXugH/QytL5KLmf6iFkq0q 9bhy/PNW3TTUBiuH/mMVPp4+2OA6ntVsZjKlcQu8BoClvm+21YsAhQvBp5ig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v2: add missed "static" to new sysctl var; add missed "extern" to old var. :)
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
 drivers/tty/tty_io.c    | 47 +++++++++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ldisc.c | 38 +--------------------------------
 4 files changed, 66 insertions(+), 40 deletions(-)

-- 
2.34.1


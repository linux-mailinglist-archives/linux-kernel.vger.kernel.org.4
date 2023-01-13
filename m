Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A166A709
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjAMX1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjAMX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:27:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E18A213
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:27:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so24913073plw.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeiJHvrswqLFEJEjzaUv7SNJ90rY7sOx4dR9LZd7H2E=;
        b=DuqQQVG5xVrKMgjEw0hjJ9MguBiRIpWq1NyyBjNbv2+ESrZQPti6WbySPmR4WRj/cg
         pR/DACzXpZET9vv+RCNgTa02tSyRReJqJl2vDrNc5GhJjcaQYdH6BhKrDinJm53Iuk7P
         MKB14bcVCKcNYXjForPiwJ1N8J3HioI9efTEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeiJHvrswqLFEJEjzaUv7SNJ90rY7sOx4dR9LZd7H2E=;
        b=YcdOcnO6Fy7gMurmrpEeWraV9G2OhjhAaG+MV9KakRurP55uOVgJKflQcN3rTIGYKB
         ldzLoxck0nX0frgX3ITifIKuavoi0iM6fx5aUtEJzjf2cP90Qk7t7mpwmvMpwVVZ6aoE
         RPXaezpGywPhV03HTjbntoAnDN5w6yvJI4bwLI5AdYir+O+8QGBV8QI1vLwdwe9syhiX
         VS3t1wG9yc1YdYRlO/LXkZfJCkSE/9gLHR5XMbrsoqnjgSoF4XwLeTw2l7WVmQdtjDNB
         hrRTaewIa3bo3c3tK9FXB9j//P2Fo8xk1NzH21JQqlg5L8nNsSHOijQt371qD7z6jdz4
         3Dow==
X-Gm-Message-State: AFqh2kqynjWQ0s9w3HAis1UAJBXrXt3gy/LZhWgXLS7Arpo3OyT/4FVo
        1M30vRxrhfKETWn6ySODecYPlQ==
X-Google-Smtp-Source: AMrXdXsDMheL/IO0a+uJkPxWNIoWsClmDoGmLb3/qltk/bmQk14iAy/bo+Gr8FI23b07uGkLj8h8Sg==
X-Received: by 2002:a17:902:b085:b0:192:d5dc:c84b with SMTP id p5-20020a170902b08500b00192d5dcc84bmr38212483plr.50.1673652426625;
        Fri, 13 Jan 2023 15:27:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b0018997f6fc88sm14682715pla.34.2023.01.13.15.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:27:06 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:27:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [GIT PULL] kernel hardening fixes for v6.2-rc4
Message-ID: <202301131526.28719A40@keescook>
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

Please pull these two kernel hardening fixes for v6.2-rc4.

Thanks!

-Kees

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc4

for you to fetch changes up to 42633ed852deadc14d44660ad71e2f6640239120:

  kbuild: Fix CFI hash randomization with KASAN (2023-01-13 15:22:03 -0800)

----------------------------------------------------------------
kernel hardening fixes for v6.2-rc4

- Fix CFI hash randomization with KASAN (Sami Tolvanen)

- Check size of coreboot table entry and use flex-array

----------------------------------------------------------------
Kees Cook (1):
      firmware: coreboot: Check size of table entry and use flex-array

Sami Tolvanen (1):
      kbuild: Fix CFI hash randomization with KASAN

 drivers/firmware/google/coreboot_table.c | 9 +++++++--
 drivers/firmware/google/coreboot_table.h | 1 +
 init/Makefile                            | 1 +
 scripts/Makefile.vmlinux                 | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A687293F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbjFII4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbjFIIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:55:54 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BD46A3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:54:47 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9e6ec482b3so1564232276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686300874; x=1688892874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=isGRI57abFTSmMxuS25eHokD96Z3GdYwa9dpc4Kssx4=;
        b=Iu1GCCLOrif/BHp9FDKqfy9yiMqyfzHGVY+jsx9g8ssylaQyUT8og48R7HciG34z7r
         PaYLhyDBGSAD6oF5C6fWSOi4e1QWO+XqObftQy5+o+D1tJ1buQtL7LkjD7WM5s72VQUc
         lwcZJgKVghfOWNQlGbHjDkKmjsyGkUTyNlupTwh+DpYm8rBdFKkaHs02bwB3j/PNMEEx
         zOzUaQzshFup6aqoj1SuOxsvWP46GSWVy0ezaqNy1eHBKSBy5yZcjEocuvg7DM2NAfV9
         7o86rQ6zx7rFyo2y8rL2HuHIJsZtFV/sVGfCYYtAg58/11KkJkENmhlWpVgSHtRQMBtM
         XcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300874; x=1688892874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isGRI57abFTSmMxuS25eHokD96Z3GdYwa9dpc4Kssx4=;
        b=Yf9+XIYx5BE1pmuBDmlnYN56xcOapfOz1dyy8e1j+VERy9vOBBTt8dAjMC9BLfHQG9
         xpA0hh54IRlnNBuhQYdWt+RknclYxfjjaJnvbupjLHksplgjLur2GDJ7rIqM6Eshgz6x
         lGF4SUaTxaS9jFaflCTTAYOM/lmJdk6UV7y6Hbmg5BFNsP4BQb/e+g9ktVfxJo7joIan
         NeBuImxjM/wlOm8X4uPtmInokpQk7PmszN7iER5+QQ/dm59GDo+X/LE8Fbxb0jgSH7Jz
         30ezPij6OdifxIL2K0qyj8YCOrw7oCYy1n9nzrYlNpgc3WALYt3jgy1DmDx5h+o8K3F7
         phJQ==
X-Gm-Message-State: AC+VfDwV8p3pzhJHOKXNI51+G4Z8fNrmwWM+urr3IsfVwWizNcmLy7kE
        S7WoCWclv86lyDY3RzwvMEJ84Q3lZCB+9DwdXXybKQ==
X-Google-Smtp-Source: ACHHUZ5zDWfO6N1U5NQqvAMibPOX2lX0OgH4TMaLHfMbiizukKMFPoR9Dqb9TNr7WchihMaBZlXa98pcYB02NUrAMiU=
X-Received: by 2002:a25:20d4:0:b0:bb3:912d:60bc with SMTP id
 g203-20020a2520d4000000b00bb3912d60bcmr478687ybg.64.1686300874447; Fri, 09
 Jun 2023 01:54:34 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 10:54:23 +0200
Message-ID: <CACRpkdbUZ=V+C+kyu40hCtgtzDRVfKwdwaZ4uJhDPSuhwRrgEA@mail.gmail.com>
Subject: [GIT PULL] pin control fix for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

just a single patch for a driver so far this cycle.
Not much to say about it.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b=
:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.4-2

for you to fetch changes up to 5b10ff013e8a57f8845615ac2cc37edf7f6eef05:

  pinctrl: meson-axg: add missing GPIOA_18 gpio group (2023-05-16
15:02:01 +0200)

----------------------------------------------------------------
A single fix for the Meson driver, nothing else has surfaced
so far this cycle.

----------------------------------------------------------------
Martin Hundeb=C3=B8ll (1):
      pinctrl: meson-axg: add missing GPIOA_18 gpio group

 drivers/pinctrl/meson/pinctrl-meson-axg.c | 1 +
 1 file changed, 1 insertion(+)

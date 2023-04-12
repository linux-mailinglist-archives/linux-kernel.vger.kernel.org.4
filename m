Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CEB6E00BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDLVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDLVWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:22:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96965BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1681334509; i=j.neuschaefer@gmx.net;
        bh=n1k64mXjIm6Bb6yrRLPzFJ9UN7psdplPSMfpPAU7vVs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=pF5aYGk2FmuuFWcsXp4WPd+tfUgOVQ3AzccOuY80f3iiwSKhA0a1EG+xo7fiUeo/Z
         yA2scWfdRklOrvH5AeJWcTasa0AjjgPsZioY+dw36yzq1UUa+apwL5SX90hzUBUFHf
         f6QJslrXOPg69e+PefmDdvzwwF+lgx2wcpaXHB47kjj2SdZM+sQ9e2t0oIrobr16sD
         agUqR/dpJYPdaQxyovj5k9AqoQC5gp3KCxcCka5TLm2kHq0Gt784nKFD+723EZmYSt
         sqpoI/naprIhbnVDCao3XD/zOaSSrQyuSnz0cWDmjNX1IiFeZiEhUi/VHNkBFdAd2b
         ka6+iiyX/VGow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([185.66.193.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1pjACu0M3B-0080Cf; Wed, 12
 Apr 2023 23:21:49 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM ZSTD boot compression
Date:   Wed, 12 Apr 2023 23:21:23 +0200
Message-Id: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0BpC4tU9DiS2KiZbIwSstRQbwo4nJqCU/g1hdQwYi8UZAHtLCcj
 0fdMFvaeTE1yLtEYkqq8KRBQdCJQq8ScLZ629MwHCVehY+FM0F2C29Y3DEMBVH9auEmW4bO
 IfTVUBaXncOvgy15N8irV/lKw+ezIrqM2Feoy1HH2bqhhDjwgSvmK0FqDh0Abyt1wv6/G5y
 3zAw3wqt9WenUbmp1YrQQ==
UI-OutboundReport: notjunk:1;M01:P0:UwrKKqhLQGA=;euOqLfHvy4QvTsfZ5FCaxrDzOB1
 It83uznIjC2xTQ4eW0Y28lfM+yTzxUgxmD5rNV0N3bz0JeskMJLnu6jKJM/JeYopxJJG6JiXV
 13IV2+xg3N2nysxq8hqtCsLD5ESVs1Ydt3q3DiYHzYRMCJwCJm0oeMB244EFcH+7VsMLisafo
 KoulktUQCgt6L91ZYUSqYH4TMtUie3ib+twA8I1qwgnPusMm5LMG8XiinV/W0ucgM8ZfR9dXS
 GZnUl7KSo2bdGfGD64VdqxLd44XUvlxtyL6XnyWpKRwpaUEoyuNKv+nAvOdG51vtbfNRwXsKE
 XL1/r3EtJeYwHjaWkG9aMN5DX8NRCw93NMRF9g0eyefiOsXuQrMgiaBeAJ1dg3skV9C3WYRv7
 ZI13yOclARm8xcS7PK1AFBUDzNNuGh08AzCrYdiyB28OtcpKxoHAwXeP94k6PAaSfuvSmbBfd
 6s/+O+HrGvwDN0v2SxSk1m1RNC48WJ/uENhDrZrHkbyFXy43aaWfSc7IdQ8WdorqM4E4SgFmd
 kr2sDrfm/kiTKc9QjFV/N5eGeZfIo/gfe7t7hNzJSEDo3lBquv5/1xXzplW/k/MPvIE+y5a+c
 ybzJ7jQHVJHVRn0YB/1ZJ0KGtQCJ6bdopZLKxzC1yGP8/Un5OO0VJrFRa7VphnwMl0HmrJ9cP
 xqxyLR91KNVJf5SabkIlRR4bUn1hMBjmSscwRObbiM+0VljR9qHdumQGSPs8Y+e3M3UPCYA45
 Q+JbJGR4JxfIqa9bkcetJd5J2Vt0gGi/C2hQPyyj1a5I+k0tcFqouQa9csDFv2xr2yx7dtsWl
 XIF5APXYzdXOjcFCjCmAFSi6KiAzuVQQrxlYupr7jOeE3o2oX2j5jmqjxSYLuqKYIJ7bdFU3U
 l1jSkCQW/TWi2Qyat4anpM3EF5qnqhY/lPS2perfkIHoIy+Vt7eiOZv1jOupA/HPV0xKKQOGL
 saDXVLIAa5QhxYQ3pCFYNii0zgc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables ZSTD kernel (de)compression on 32-bit ARM.
Unfortunately, it is much slower than I hoped (tested on ARM926EJ-S):

 - LZO:  7.2 MiB,  6 seconds
 - ZSTD: 5.6 MiB, 60 seconds

Jonathan Neusch=C3=A4fer (3):
  ARM: compressed: Pass the actual output length to the decompressor
  ARM: compressed: Bump MALLOC_SIZE to 128 KiB
  ARM: compressed: Enable ZSTD compression

 arch/arm/Kconfig                      |  1 +
 arch/arm/boot/compressed/Makefile     |  5 +++--
 arch/arm/boot/compressed/decompress.c |  8 ++++++--
 arch/arm/boot/compressed/head.S       |  4 ++--
 arch/arm/boot/compressed/misc.c       | 12 ++++++++++--
 5 files changed, 22 insertions(+), 8 deletions(-)

=2D-
2.39.2


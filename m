Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18AD6A27CF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBYIFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:05:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CF1ABC6;
        Sat, 25 Feb 2023 00:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677312340; i=w_armin@gmx.de;
        bh=bm2fa0tt9qyMUaRQTF7KSIVtPPB8KCnphI14dT6GRRA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Gy883kf56GpzmrTeHbqc2IcVwtvlkdncfWBOr2XcjmHG91xAFYWH2CX4bQEqeB6mG
         lJS39idQfgAE6x6Lccu98lqxT1+olvxxz8yP5+Iz7yYdKwdEY6An/uh3MqHSkuRAKD
         tVlEFrj+HJ+tKuTucGb2RkpaM9Kcf/JJg4w2LHWtg7WQDTU3QffT2JGmGQpF/SqOVr
         845U45M7z4Y+FSI4msHBY0IVspnsWluuLAjM/nA941goP4ps1eJoVEAUV+0Lm6Sc8w
         lQyqcZjyCqGjLJgJNIwdy0i+3mUrJgm4L1V/lUyAHqbBKmN0XW2vGnBio9egPhog2Y
         m98sVPLd+i7WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIMbO-1pJmsK17jw-00EIzq; Sat, 25 Feb 2023 09:05:40 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ACPI: SBS: Fix various issues
Date:   Sat, 25 Feb 2023 09:04:54 +0100
Message-Id: <20230225080458.1342359-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EE9+SqiyvCZxz+X9STR8mEs0tW1Ns2DidhA/BGs2d2TNIxwrWEl
 BsvZGHJN65vu72uba+u9ovsu3SpvXHvNPnAKdtcsQSC7y2tE8BnHPlLIh6v7OoeinEh6Dbv
 5s+yI72498RC1Ms3fSz8FpikIktJR4eOvaUV6+VvAsp05ZHpkYiMCoesp71WEyf5pMY2J/6
 LJOkSTODCqnKaaD4vGd9w==
UI-OutboundReport: notjunk:1;M01:P0:dSVCL8zROyo=;NJEm1JrBIRHjsuLxO3CDvJfpPMV
 oE15vJHUS6IOpFyjNdZ5zKgfpyRKiGU66lSmm/XEJ8gHCoMQZoTyoao/3ZV47pMCByowjvcpy
 Onz7Akvq4aQ8eh4xj7Dx3mmn5P+IO4/S0kTAnM4yliqDIH99uhKTVyZgB6b7N9QFFT4wUvTk4
 S2UUPJf7JICTw1PwSJYqJg5yqr0IJC9M+L6XA8j7o4Z9hcH7HQRQSX842YZ6t3IPYTmfqGZNW
 +BXX+PPC8HpwTprd5rhiL+cyyXyTur2/ubihIJzoY4Thv36glYDJeJ7wAkHpfbit9mqc6Y/09
 2shu8l8agpvRotvBlf8Hcj8Elqw7Lb0GeKaNOX5aX6sadV3DVvKZTZqDABMSRBUAt3PQdXnae
 fSIzA2+RIDDmK/7LW4yuYtUxocQ2vp3UQzwTnNP3zdtH0pbsoGUrDCBQxv8iZfanULKpcWL7I
 /B/viTuBmujLfgJLWYjE9tdtqgDcY5HkuEYlSC9QZZBN2oBN/0J6Z+4nBeakMN4z8U5qbmzgf
 ULFZ0PH+UkxY3eJvgwyLJUKb6r6L4KhtwwCjaabOdWExodGGTqEo8wDIA9MCb4aKqP9T1yrr8
 CzfOgjgLp5eqkeYRKNxaiMSkxFuUQF8ksM7ex2NFtkQViJ+IdT57vmIHpHSPc5kpy2I972Dor
 LNHfxquznfcbQ3t3oIoGsLvhNj+euJDlIYug+atIUYeE5ahCn5HtsyzDX/DR4/hefcSEETh+Y
 nG1uL5SD0CTm7jyseYABW8Shbtx3r/LQfVKAFki9btRtSTMwfA23qjjRRV7xOfRwPE6veEVHm
 rk+gd5m5S+HlDzSmsqTQKqfv6Vzt1nLnn8UfOpGk15tOzKb6ds4lETNJ5QFxExkf6SZxgkaIB
 7Y0x4M4+1vD03eeF8ToHo+5ce5RVz8ZQdkmXIwqElFZT79UgWvXA3l85GRtruOI6z+t0ZVtku
 TnCnvO5gCVx0MucaJycVGaI9S8w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my Acer Travelmate 4002WLMi, the system locks up upon
suspend/shutdown. After a lot of research, it turned out
that the sbs module was the culprit. The driver would not
correctly mask out the value used to select a battery using
the "Smart Battery Selector" (subset of the "Smart Battery Manager").
This accidentally caused a invalid power source to be selected,
which was automatically corrected by the selector. Upon
notifing the host about the corrected power source, some batteries
would be selected for re-reading, causing a endless loop.
This would lead to some workqueues filling up, which caused the
lockup upon suspend/shutdown.

The first three patches fix a stacktrace on module removal caused
by some locking issues. The last patch finally fixes the
suspend/shutdown issues.

As a side note: This was the first machine on which i installed Linux,
to finally fixing this took ~5 years of tinkering.

Armin Wolf (4):
  ACPI: EC: Add query notifier support
  ACPI: sbshc: Use ec query notifier call chain
  ACPI: EC: Make query handlers private
  ACPI: SBS: Fix handling of Smart Battery Selectors

 drivers/acpi/ec.c       | 44 ++++++++++++++++++++--------------------
 drivers/acpi/internal.h | 10 ++++-----
 drivers/acpi/sbs.c      | 27 ++++++++++++++++---------
 drivers/acpi/sbshc.c    | 45 ++++++++++++++++++++++++++---------------
 4 files changed, 74 insertions(+), 52 deletions(-)

=2D-
2.30.2


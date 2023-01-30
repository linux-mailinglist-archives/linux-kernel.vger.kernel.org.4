Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A99681E07
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjA3W1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3W1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:27:30 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770C1ADCE;
        Mon, 30 Jan 2023 14:27:30 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id u8so5774519ilq.13;
        Mon, 30 Jan 2023 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91APSBQRASxyaUot6kel5HH01cdUZFzcVWQ89+jE+NE=;
        b=f4B72CIJYqfo0g21cgdQmSuwU5oOqTM8jlthi0qxLzM3Fk/kk9HkIhzJDCUyu6skOq
         BaQaPz0ZcBSW+GmBCCz6rcujJz4i+b1XJvMQLUGBEg6UW5IEWDIwlNHf49nUm+L75aHj
         1r+ki1l0TApiKasfibpSpgM6SgIMATUKu/ebFHWFcNCdtJaPfeUu5qJvI4gXhRxEZ28m
         Sirzm44ry4gL3GhcD/9fUtbBebaFCMd3mkFpztU9RvU4WRzE+UygPPMdcvq/40OPetqt
         KWkBdWujvyHYoXPITiTBecar0+jX7Z+49pO9uLLJSPSBmmq9ApAzPztSuzn+MPRH0ewX
         34Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91APSBQRASxyaUot6kel5HH01cdUZFzcVWQ89+jE+NE=;
        b=jkcCfCSeJ2ScLNqwvnFqE6lux0PtuttHLHxMlf1wNSbUqSsFEJ25u93Ns7VSnL/0qM
         01tPiyGbYiH4UGfG4WbSbnLFLWhwK4mldgY4IYV3DKvmczzqWTxiCCYtBKN5X95aXg9X
         tzKgXN7MDtqgtuH/qOL8b1CiYh20VoEtp4e0+Oj1iP0YznGeLThplnVZ5Fxp072FurEV
         vYylQ44DKEuUdBuuOEWwITuo1GPtVIZF3SAO/lUTfjIXv14bYA7A6UqM1B/mxvto+Q7n
         vQ/Fkl13kyk8kscShz5TA9VVYd8H8t/ju8iH+JosImeKFKDqPu5kJ6M3pIi+VxWXM7bq
         3GSw==
X-Gm-Message-State: AO0yUKXwUBoHf4jW3PEqTgsJ+/3EQBkIOND1e7SNjHgDlSyUALdDGgsr
        dW5l886YlRzrPFV1l4UEQfU=
X-Google-Smtp-Source: AK7set+2wJM21/vUhqZKljfebmcjKs1hj2P8FB6BSF+IR4mJCpcim0cnQkXDA3k3kvhEr/KeiyT6Zw==
X-Received: by 2002:a05:6e02:1c45:b0:310:fb90:b61b with SMTP id d5-20020a056e021c4500b00310fb90b61bmr3315825ilg.10.1675117649557;
        Mon, 30 Jan 2023 14:27:29 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::11ab])
        by smtp.gmail.com with ESMTPSA id p4-20020a056e0206c400b002fc323a2902sm4370778ils.62.2023.01.30.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:27:28 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 0/2] misc: fastrpc: Fixes for issues in userspace
Date:   Mon, 30 Jan 2023 17:27:14 -0500
Message-Id: <20230130222716.7016-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I've been playing around a bit with the FastRPC ioctl interface on the
Pixel 3a with some device tree patches. Since the ADSP crashes every 10
seconds, the inconvenience caused by related bugs encouraged me to write
a few fixes. A demonstration is provided in patch 2.

Please enjoy and review these patches for better userspace while remote
processors crash.

Richard Acayan (2):
  misc: fastrpc: return -EPIPE to invocations on device removal
  misc: fastrpc: reject new invocations during device removal

 drivers/misc/fastrpc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.39.1


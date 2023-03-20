Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B6B6C1EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCTSCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCTSCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:02:03 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044C2BF2B;
        Mon, 20 Mar 2023 10:56:27 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679334907; x=1679594107;
        bh=YpXUHqN2Bflx7amgdjF7iQaRJLpF7PEzy98FHyuD0aY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=VrdyxyrTwRIEZRFp9QwPilHeKxV6/JjzQWzvIs3DEBp2q648vKCWJY01kD4TYKakz
         7a//Vx2jgfdCzSE5TyCh4bcRJFkk4bkGS9MBptePOIafA9V3aZ6pnqvEsv+D8rK+6o
         zxkSl04b/OHsOHd03uTLIAFadqluHuhuiBYb64EROZQUqjJXnXIoSKMT81xtZRR9Ro
         1YfabfyIi/hdMx9Ua059ZdIUEb3P6PIl0AcOfOoOmKYQJcSFqtww8VqWzW7IjAUtlq
         GTonx01y22Vu6GOoOceufrl1eER9igxfedbAORtqppTFoxDsVOGMdSAFVX/n4Wqvb7
         mj24XM5EONGZg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/2] leds: aw2013: Add vddio regulator
Message-ID: <20230320174949.174600-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Rename vdd to vddio and reword

Some LEDs controllers are used with external pull-up for the interrupt
line and the I2C lines, so we might need to enable a regulator to bring
the lines into usable state. Otherwise, this might cause spurious
interrupts and reading from I2C will fail.

Implement support for "vddio-supply" that is enabled by the aw2013 driver
so that the regulator gets enabled when needed.


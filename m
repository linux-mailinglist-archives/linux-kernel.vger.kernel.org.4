Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CA62E4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiKQTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiKQTFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:05:30 -0500
X-Greylist: delayed 9023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 11:05:29 PST
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028E70A36;
        Thu, 17 Nov 2022 11:05:29 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668711926; x=1668971126;
        bh=yPJuCb1OqNQw6Eu8hBP1cJKuQdzd/t0ti673JW0Nunk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=stmdFS/YayGbVNsPFy2y17n38oNaOmh02vIHxJaQRG9gMYfCbA8UJlpfCh0LpHe6I
         Awiy1kqL9L6ru+/bhKUVjwldodD1OJi3265FMrA50i22MuNB0nIV8yuhxslRiV1A37
         LYoCUF6SQiqtoEU5e2vLyxWypIZVhGbZJt61njoUmT8zbYkmzBKG1rTXG3EzhPW268
         nn9neFCGoHzGuHExTekP3tj604LnGrTPhK9R69HKq9gAepie4geS/kp5Nt72s79aO+
         mw1DC91CPXJ1xcPipGE4EiB15A5GkU7YRqIYEyQdlBjv4P9Tg6At3UM1TfgJWpT6e1
         YYzHsc6xY6iqA==
To:     linux-input@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: cyttsp5 - add vddio regulator
Message-ID: <20221117190507.87535-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung touchscreen controllers are often used with external pull-up
for the interrupt line and the I2C lines, so we might need to enable
a regulator to bring the lines into usable state. Otherwise, this might
cause spurious interrupts and reading from I2C will fail.

Implement support for a "vddio-supply" that is enabled by the cyttsp5
driver so that the regulator gets enabled when needed.


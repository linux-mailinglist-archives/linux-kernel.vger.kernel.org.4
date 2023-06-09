Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758DE72A225
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFIS1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFIS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:27:18 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3C35A3;
        Fri,  9 Jun 2023 11:27:17 -0700 (PDT)
Date:   Fri, 09 Jun 2023 18:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686335232; x=1686594432;
        bh=ZWzcN/Tm7VxGdb18LHyy/4I9RAaaMI8KoDWSNbJZYMw=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=EjjRfdrTEJRXwRqzh0tudvMQ2Tm7muCk6nBtud2Il6HJPAUSaYsPMzLyqfXQyioRr
         sZ7TUTl6fw/WvfZOg6um4ZLvf8LLonlThUbAU2Fv3dvZbzH6VX1/N1yDxgsBir8FIK
         qFsfDFcmZy9+P0/DSNiKWprGyMuVfj6eudrTHZH1eejzZ8lLPaXB9xEdKpvbes6Z5G
         C7UGRwUwHKPMBJ1IbGLX9kkjfnW8f8OdtZR72TWA5Ug5i/cA+Rj4Yo3TOR5bzIad6x
         B56Xicuzj+VwMbs/ozILsb1jNo8LN75H9F/PZobH1gwbG1FIzklEbIr1HC2Xy9w5cz
         Q9bcVZF52/NjA==
To:     linux-kernel@vger.kernel.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <20230609182639.85034-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Fix weird wrapping and drop another unnecessary nxp_nci_i2c_poweroff()
v2: Use dev_err_probe() and drop unnecessary nxp_nci_i2c_poweroff()

PN547/553, QN310/330 chips on some devices require a pad supply voltage
(PVDD). Otherwise, the NFC won't power up.

Implement support for pad supply voltage pvdd-supply that is enabled by
the nxp-nci driver so that the regulator gets enabled when needed.


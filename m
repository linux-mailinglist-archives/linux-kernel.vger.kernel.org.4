Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDA636C25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiKWVN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiKWVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:13:46 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D22C128
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:13:45 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id l15so24093qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCAdz79Q9Nl+OKyzqzGeecpOB8hVla9Ab63J2ksR6Vs=;
        b=hn8hQ/eozXMiB5C6TMwm0AOG6mw/bHwooPBiXgxeZ90DttPFa3/u7OAtBOMpBX+nSj
         hsJx7G1859fRsXUMsxRPKoTHTPdAW/YiS2AGfKDandRFwGbAh1ILJn3G6uG1UFD2CUWv
         Iy3hSGc+19ek5rUa6ltWn7D79B3Rj8yNCZ6nW3jASD3QrYMB7nGIgCv7R2EMHq8g5a3n
         +4GtO5FUBv1wM2mUpgOPf/zxXtslzi9qZcfew69CKjEC+FEbRud+/JWxmYr1VNvBAJ59
         DbI7ivMeVBd8QyWhVgyD5LTb2ZC4CF1SO5ljh2SfGMJbCAQHNhOSoQZv57k4suUi/qcq
         h42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCAdz79Q9Nl+OKyzqzGeecpOB8hVla9Ab63J2ksR6Vs=;
        b=R3K5AAk2SFi0q+UUUwq6/2a7ZE2sSjtPX0cQWPtm+w+0rwScoH9ViqSXdYjeMV2b9I
         mdZgBZWoUhv8LpKM4p2Bz/057NMTBothIUIZni8Pf6Epm2tHIsLX9PjJG/zfwQDb4eyJ
         YQmXBjDgSmObv/2Tr1+IIFwZrY1IkRBt8t2UJCN2Mgb9DBc2ptG/V0eo/RERQFD0xWr2
         E+gh8gX/72QZDbJyrY70qzE27a9gsnEQbv0ZrLFmThCqzgwTZ3qoTuyCYI6Q0K4PyB3O
         WnigTr4NMs5QcEQ7FiboK7WWgZgqkNjxi7Z+0A9RH6BOzGQ9/nKqKzzY6Fp5TKc5cNVh
         HWdQ==
X-Gm-Message-State: ANoB5plPBQO56W6IA2Gt7J1QSH0tNSO9anoab2qs182KMMbH8hJGrkFp
        w5KU9WUhsJAo7dPZOhnS8Vd8vw==
X-Google-Smtp-Source: AA0mqf6kDoFMZu4ePWxxwUg/J72OEu2pRDPGmxPTlFZFDAGC9mbXV5IpvRV0TQn56/juaryPJFIhYg==
X-Received: by 2002:a05:622a:2484:b0:3a5:2fdc:9dc8 with SMTP id cn4-20020a05622a248400b003a52fdc9dc8mr28904444qtb.69.1669238024169;
        Wed, 23 Nov 2022 13:13:44 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id cf11-20020a05622a400b00b0039ee562799csm10222928qtb.59.2022.11.23.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:13:43 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] These are the required patches I found while adding
Date:   Wed, 23 Nov 2022 16:13:33 -0500
Message-Id: <20221123211335.126417-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) The core framework needs some additional logic for 8S-8S-8S to pass through
succesfully.

2) The IS25LX256 chip needs added to the SPI part table along with various fixups

Nathan Barrett-Morrison (2):
  mtd: spi-nore: core: Add in framework for 8S-8S-8S Octal STR mode
  mtd: spi-nor: issi: Add in support for IS25LX256 chip, operating in
    Octal STR mode

 drivers/mtd/spi-nor/core.c |  57 ++++++++++++++++++++-
 drivers/mtd/spi-nor/core.h |   5 +-
 drivers/mtd/spi-nor/issi.c | 101 +++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 3 deletions(-)

-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA35636C58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiKWVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiKWVYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:24:08 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2BDAE61
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:24:07 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fz10so41933qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZQDrrY3Jh/JGf3hkC3luDZW4ufEkyiRrePoBcKr4iA=;
        b=Dv0Av04vLcO/pCddOPbVJgUmAD0kD2zXLrwqKqYa0NIQ0Hspv0NMm2jMXepOpLrF2Y
         wj5slOSCW05nlAMlZH4ScQ5mfb0Ws8JhpQrn4Jvl4N6kOy37HNSl6LvmDSewAhvDpqRh
         ngTvoATS1zvvwDt9M8YYmIw5qtimRzFkrrP1diAYeApI3uuhPGCxdMnqHkO4ovF0hXYT
         C9usUttclxaKSgv/KiFPp8o8kU4M+UcnOpv2bIBUYOmY27wubAvd5/bnMbAjC0fZ0meg
         Ort6+iZ4AihkbpbnT6cfpHni/25rZaXx9RdO9kdbIEjNp4QiqsK/5rhZQCdDwIAHEkrI
         +Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZQDrrY3Jh/JGf3hkC3luDZW4ufEkyiRrePoBcKr4iA=;
        b=5OYGvnAExNmqrityopLY12KAwnPLbL0pAppxr+oYRcmb9wXgJMm4V42RscHdHRlvMe
         CoQTsbveGIc6wAifedSyPUbfx1xtIxTLJWPmpioiIXE96C7t4V+TN7Bke4vA05KcUHhV
         nvJzVuomumi0MsuhwuIJ9puM+/enOMzZ/DxtInSUgtrRg5blxqDOiolXgGAiHZxYJ3UX
         aSKwtHma2kG4xKvKSELX9KxJs7K5syZ4ORylNPO8Tvq0Gk3HfpOrct5bSTI4mLkLD+//
         Iq6sxo54as1uDDLbhRGJC+MtdzdhVhXIgLIEXJwedwocZHIdzwBrb9caVa4PDNBuPV8B
         qQqw==
X-Gm-Message-State: ANoB5pkfO42YRiKUka8erDQrYQ0mJvSLVM0MuNwwdQ3G20xG4daJDS4n
        RCXYFOTXncTgw6gkid8gQ2E/Aw==
X-Google-Smtp-Source: AA0mqf6TyjGy5VAIjuc9VbLwCS17xAYpTzweE2Mo4q5nwZg+MJn7BgySkh5GbT9ZN6kp4vSgIg5AWg==
X-Received: by 2002:a05:622a:5d88:b0:3a6:6181:f4ed with SMTP id fu8-20020a05622a5d8800b003a66181f4edmr1130097qtb.347.1669238646821;
        Wed, 23 Nov 2022 13:24:06 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id i5-20020a05622a08c500b003431446588fsm10587030qte.5.2022.11.23.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:24:06 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
To:     nathan.morrison@timesys.com
Cc:     greg.malysa@timesys.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, michael@walle.cc,
        miquel.raynal@bootlin.com, pratyush@kernel.org, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: RE: [PATCH 0/2] These are the required patches I found while adding
Date:   Wed, 23 Nov 2022 16:24:05 -0500
Message-Id: <20221123212405.128123-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123211335.126417-3-nathan.morrison@timesys.com>
References: <20221123211335.126417-3-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the header of this patchset was accidentally clipped.

It should read:

[PATCH 0/2] spi: mtd: Octal Support for 8S-8S-8S and IS25LX256 chip

These are the required patches I found while adding in support for
an ISSI IS25LX256 Octal SPI chip to our boards.

1) The core framework needs some additional logic for 8S-8S-8S to pass through
succesfully.

2) The IS25LX256 chip needs added to the SPI part table along with various fixups

...

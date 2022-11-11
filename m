Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83568625D49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiKKOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiKKOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:39:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A60B5B58C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n12so12941758eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGuzNehUrzRR7f872iG1ND625YtqZMgOeatzucv3Q3o=;
        b=K+ngqIb0vvXToTosr6PdIcmrLthH5hf9frXCQZ/IXr25UYImDKQv/Sms/AAnZkigFf
         yyQ2HWFd5KwIturPmOw05vbOj7dHGiXWoVECwqe/6As9p6n0iMhTGKVfRY09b2URbJYD
         K29UZvJY9spGFoiqBCH6JRJPwmIkZ5NWH+98g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGuzNehUrzRR7f872iG1ND625YtqZMgOeatzucv3Q3o=;
        b=DFMrsEpFonwlQ5Zn1slRD70AJUsbNC2PY0zCE62aQ0XeC9XbTJ2Dml2BOXw6fia5qZ
         xqi7HnC19Gs4Dgk4w1XYauJC6hNbRJKv61v3CrMTEBulnQ6b9LfFEYFOXN203YHG2VoS
         Xp45vmC5ojEtM1C6EagT5+fZrWkxl+whTVXpVOrMh3TGfCOduwtKy8W+D8qUT1d1oqUu
         7K2+wOl5rnmydN3PlrnAsIjXOedmk/DoH081WwiTQDdJt67h0GB4Yqj4fnPNRimyjvFL
         0kmnfj6rRM0VGN9lsZ+4xgThvlMH7tKY+9KF9vsFAc+LVuJXNb501kFfEIr4C23vFIty
         qGMA==
X-Gm-Message-State: ANoB5pmaLa8n717cGzMN6IGCrBIUtcwvRyUcghyo/KclwFZiz95Ny6AM
        DmrNyfv+Qq3BvleWMpR8Ooq0Bw==
X-Google-Smtp-Source: AA0mqf55ikxQ1bfeV8MXIcH/zCmhNet+C888Jvr5UgLkHiTToLLH74Rdx+RJyQsghpH/jgF2gh6h4w==
X-Received: by 2002:a17:906:1458:b0:7ae:d8f:893c with SMTP id q24-20020a170906145800b007ae0d8f893cmr1989770ejc.359.1668177564949;
        Fri, 11 Nov 2022 06:39:24 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:24 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/5] iio: addac: ad74413r: various fixups
Date:   Fri, 11 Nov 2022 15:39:16 +0100
Message-Id: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches

- fix a run-time warning
- make the refin-supply optional in the binding
- add a reset-gpios binding

and update the driver to support the latter two.

Rasmus Villemoes (5):
  iio: addac: ad74413r: add spi_device_id table
  dt-bindings: iio: ad74413r: make refin-supply optional
  iio: addac: ad74413r: implement support for optional refin-supply
  dt-bindings: iio: ad74413r: add optional reset-gpios
  iio: addac: ad74413r: add support for reset-gpio

 .../bindings/iio/addac/adi,ad74413r.yaml      |  4 +-
 drivers/iio/addac/ad74413r.c                  | 51 +++++++++++++++----
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.37.2


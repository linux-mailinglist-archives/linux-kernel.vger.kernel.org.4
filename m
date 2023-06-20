Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71F737593
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFTUDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFTUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2C10F0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9786fc23505so623447166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291413; x=1689883413;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHUIx+vaRNcVvwWyiGDGMuucQ15EjOva/eBx4ejRVkQ=;
        b=eDKl0w0AM166qrNGpWPNGiYnU2jqsFMiMce/t7sI4Qbdqwf4tmaiAuViWs0KKyHm0j
         +YKGMEZFb8eNIzUZZvfRx5ThiLDAYHcrOWwOUA6iHkHxdkch+7WhBrebHkcbhRMMkv1d
         g/FBZxYnS+N2UoamO7gia7qdjmUaw0blYCkVjMGi8ISsRH2kmGCQBMbSI4KrCv76Xjlq
         3GG71Gqv1ITa4dRnQKCDrNkZhykNt4MdTor4jZ5/7xgGVZRRnrZwWVpXyjaLIMBbVAZc
         ZSM7B2l4aKjFb8YOvsPwE+OhQkzFafIF2RXP0UES6iB0Hl5kyBJFpuNw1lheNjwy1BaG
         LgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291413; x=1689883413;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHUIx+vaRNcVvwWyiGDGMuucQ15EjOva/eBx4ejRVkQ=;
        b=e65MXAfXVVTsIpN7VQlFg8wqu5Zyz5kLQc2B9Q/YIEhnG+pX3jmSrNzmQnYUOj+anM
         Mi8AiRbaewPJFEYcxHFuGMovD7KEz5MDqws4/zH3XBxx5uPE8jhYanXsrweR1uPypGMb
         /1c6jI6Z9aD+AxTVY4bO6jcDLlcUEI07/Hy+Ug1hmocqbkGfy5bSH/ZHyvj1lUc/0EY0
         9OwTLo6UM8ZMz9rK6yAUabVfJ7LaksihLSVxN2jDQmKl1TAjysY8tHh/vbTKAaBZPWJW
         Yv5eTtpqN3fMtTirRGLgAyxx6IWGlQGyGBB/OEEOJccSL7gQL4pbnfm6rKAI9CKGWVSx
         5c5A==
X-Gm-Message-State: AC+VfDy1x7DRow2vq5Q/hIX2x57HWUmK9hdMLDTN7C6fllMfKAQtWwHT
        dinf74y/oRa2Z0EP0A9ODgmD0u8v7rM/gQ==
X-Google-Smtp-Source: ACHHUZ6kvPvAH4p1lEqeMIeDw1zHJHWy2ckFm6zryX8xx0UlzKWZkrBlJifj3MtfdSDYY438Ju61Ow==
X-Received: by 2002:a17:906:6a25:b0:989:40a9:505d with SMTP id qw37-20020a1709066a2500b0098940a9505dmr2399526ejc.0.1687291413158;
        Tue, 20 Jun 2023 13:03:33 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:32 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH RFC v4 00/13] regulator: dynamic voltage monitoring support
Date:   Tue, 20 Jun 2023 22:02:53 +0200
Message-Id: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0FkmQC/33NQQrCMBAF0KtI1kaSJtrUlSB4ALfiYjIZbZCmk
 pRgkd7d2KWKyz+fN//JEkVPiW0XTxYp++T7UIJeLhi2EK7EvSuZVaJSQsuGuzFA55Hnrg+chHE
 AArAGxwqxkIjbCAHbN+ogDRTfxT3SxT/mnRM7HvbsXI6tT0Mfx3k7y7n6PZMlF/yija21MmQau
 Us372CAFfbd/CpX/3hVOCqhLGK9JovfXP3jqnAt68auzcYZ+FifpukFkW6J30YBAAA=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series targets the "automatic" state handling of monitors when the
state of the monitored regulator is changed. This is e.g. necessary for
the da9063, which reaches an invalid state (!PWR_OK) if the voltage
monitor is not disabled before the regulator is disabled. The problem
could also be tackled inside of the driver's "state change ops"
(.enable(), .disable(), ...) but I thought it might be a good idea to
have a "common framework" independent of the driver's implementation.

After feedback from Matti, the new approach doesn't disable the monitors
of disabled regulators anymore (except the respective workaround
property is set). Additionally, the core differs between initialization
and "workaround handling" when it comes to -EOPNOTSUPP.

1/13 is temporary implemented by me now and fixes a bug found by Martin
     Fuzzey [1] which can be removed once a follow-up is received.
2/13 introduces a new op to read out the active monitors.
3/13 implements the new op for the da9063.
4/13 implements the new op for the bd718x7 (untested).
5/13 introduces the new "workaround properties".
6/13 ensure that the required regulator ops are implemented.
7/13 find all active regulator monitors the DT is not aware of.
8/13 factors out the existing monitor handling into an own function.
{9,10,11}/13 implements the workaround properties in the core.
12/13 implements mon_disable_reg_disabled for da9063.
13/13 implements mon_disable_reg_set_higher for bd718x7 (untested).

As far as I could tell from the implementations, the other two PMICs
with voltage protection support (max597x, bd9576) don't require
workarounds.

Thanks & best regards,
Benjamin

[1] https://lore.kernel.org/all/20230616143736.2946173-1-martin.fuzzey@flowbird.group/

---
Changes in v4:
- introduce helper to handle the monitor state according to the workarounds
- split up commits per workaround implementation
- don't disable monitors of disabled regulators anymore
- implement monitor getter for the da9063
- workarounds are now per-monitor instead of "global"
- require defined ops for workarounds
- ensure that active monitoring is known on regulators with workarounds
- re-enable monitors only if they were disabled
- Link to v3: https://lore.kernel.org/r/20230419-dynamic-vmon-v3-0-4179b586d8a1@skidata.com

---
Benjamin Bara (13):
      regulator: da9063: fix null pointer deref with partial DT config
      regulator: add getter for active monitors
      regulator: da9063: implement get_active_protections()
      regulator: bd718x7: implement get_active_protections()
      regulator: introduce properties for monitoring workarounds
      regulator: set required ops for monitoring workarounds
      regulator: find active protections during initialization
      regulator: move monitor handling into own function
      regulator: implement mon_disable_reg_disabled
      regulator: implement mon_disable_reg_set_{higher,lower}
      regulator: implement mon_unsupported_reg_modes
      regulator: da9063: let the core handle the monitors
      regulator: bd718x7: let the core handle the monitors

 drivers/regulator/bd718x7-regulator.c | 210 +++++++------------
 drivers/regulator/core.c              | 370 ++++++++++++++++++++++++++++------
 drivers/regulator/da9063-regulator.c  |  33 ++-
 include/linux/regulator/driver.h      |  28 +++
 4 files changed, 439 insertions(+), 202 deletions(-)
---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
change-id: 20230419-dynamic-vmon-e08daa0ac7ad

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>


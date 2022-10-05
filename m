Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B295F512E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJEIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJEIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:53:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A005B05F;
        Wed,  5 Oct 2022 01:53:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so19535622wrr.3;
        Wed, 05 Oct 2022 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8BqRTIfWSS9jf0LKTH+g0B1dFdrxfzLef727HSnDg5E=;
        b=PKxmtwuMywF2lVOXQI8Ca6UEoonhS751LjVm3KrBx8VHrRfyLKiUqcZciFCSo/CtOy
         s1lIs1HIDzL6ahr/ODtsZQSTe+KZvRQJtG3iXKzUHJIdn6PwYNR8v6Z33xDrn/8YishX
         TX0mMe2pE8EgFciVv7M9tdz+ZN83q38kRceEZcbX5dVbg60M2urHf5NVqcm2bDwUMdP/
         s/2qMvdyhGYNeVlwB5N04sZrMFNp4wBPKRlhRh1eL6nVDsbE8T/HEnmQ7OY4cJNSbf+0
         ei/mtpIpIFufC+npusVvxmGIwvqmmVIkglsH+fofPMj7B3YwAUgAn8S6blJxbp1hirh8
         TR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8BqRTIfWSS9jf0LKTH+g0B1dFdrxfzLef727HSnDg5E=;
        b=tO/kSUKU1GkDRNwX4toMg/t98qUS9prQZNoZ9E+XXXP0PL+wEafTkSnfIRbivUtjKf
         x2G+Kw6KNYOVaGXHPzuNKgb5DRo8e7Sgdn3JVpy4zP5q2276+fcUEHs+2MX/Hio5py3j
         6CSkBgoyx77e6JXNfAaSUFOFLhfnnTR7yIULVqL2ZzcjIaLuRUM09bd9Cl7RPHPTtcgY
         36PuyZ/Em7YscSyukTwRBqTDOAq1vmJd4hwmBqqEb7tWbxMwp35tIzBjiHg5YgbHuTdZ
         HuWulb9b4TBFx7lj97oxgj2BYgxbKymdQitY8GQg7lIhy6KyZQR/gupPDmSKOtNsr66L
         Lypg==
X-Gm-Message-State: ACrzQf0OWM+ofXMc6V00RGarMWPQanbf6cga0i9cSMQkoFDOaNkcA27d
        EnCEduoDthRVV0lP67Q1niQXmPN6/Tg=
X-Google-Smtp-Source: AMsMyM4bBNLaqXf7/qpCF+O7XFAWN6Rt2ddxzdLH3ac1+JugGkSavY+KGJhd2skUyERYhn7PowfJcA==
X-Received: by 2002:a05:6000:1881:b0:22c:bee7:96e with SMTP id a1-20020a056000188100b0022cbee7096emr18495846wri.418.1664959988511;
        Wed, 05 Oct 2022 01:53:08 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b003b4cba4ef71sm1333769wmq.41.2022.10.05.01.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:53:07 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 0/1] ARM: mstar: cpupll
Date:   Wed,  5 Oct 2022 10:53:04 +0200
Message-Id: <20221005085305.42075-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This is a resend of the remaining patches of this series. I have kept
the cover letter in order to do not loose context of the previous series.

This series adds a basic driver for the PLL that generates
the cpu clock on MStar/SigmaStar ARMv7 SoCs.

Unfortunately there isn't much documentation for this thing
so there are few magic values and guesses.

This needs to come after the MPLL DT changes.

Changes since v5:
- Fixed tags for Willy
- Add missing kernel.h and device.h
- Use devm_of_clk_add_hw_provider
- Move "cpupll_parent" on the stack as it is only used by
  devm_clk_hw_register (it seems safe).

Changes since v4:
- Removed merged patches (dt-bindings documentation and dt-bindings)
- Rebased onto 5.19

Changes since v3:
- Added Reviewed-by on Daniel's patches
- Removed "[PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5"

Changes since v2:
- Re-ordered Kconfig by name
- Re-ordered includes alphabetically and removed useless ones
- Used timeout for cpu_relax
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_frequencyforreg()
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_regforfrequecy()
- Reduced the number of lines for msc313_cpupll_of_match
- Removed CLK_IS_CRITICAL

Changes since v1:
- Re-worked the series and ensure that 'make dt_binding_check' passes.
  The required commit is merged now, so it is okay.
- Fixed coding style issues in the driver and makes check_patch.pl happy
- Added one more commit for extending the opp_table for infinity2m.

Daniel Palmer (1):
  clk: mstar: msc313 cpupll clk driver

 drivers/clk/mstar/Kconfig             |   7 +
 drivers/clk/mstar/Makefile            |   1 +
 drivers/clk/mstar/clk-msc313-cpupll.c | 220 ++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

-- 
2.35.1


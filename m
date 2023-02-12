Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B133F6937B6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBLOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 09:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBLOMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 09:12:02 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B01F777;
        Sun, 12 Feb 2023 06:12:01 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 949C1CB387;
        Sun, 12 Feb 2023 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1676211089; bh=GtVlAJJGWKH1DMq2uvY3B25xRTilkMFb5G+MaWHNQ00=;
        h=From:Subject:Date:To:Cc;
        b=BVwrjgMhKVGXhXktn5kXGXS8vJ49qG3I/QTKJSFUwHAtwLSEBjXdJKdRtnpz/R6DE
         m7da1ZzkStgWwxLMYlm2cmxiBkY86AVg0qIlD68LnTB9U6SF0AomYT6ye2ftSjG+Tp
         zbbL4z3gI2LyEVzcbTeAq7PdwUa9EP1KO2a5wBx0=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Switch hfpll & krait clock drivers to .determine_rate
Date:   Sun, 12 Feb 2023 15:11:07 +0100
Message-Id: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHvz6GMC/x3OWwqDMBCF4a1InjslxlJrtyKlJONYhzYxTuwFx
 L03+vjD+eAsKpEwJXUtFiX04cRjyFEeCoWDDQ8C7nIro02lTWkAX0+YcPTQ0UziOdBd7EyAjcb
 GdtpVVa2ydjYROLEBh83vxCd/aeoTnI8GvhwB47sXmrZ5FOr5tx9pb+v6B/tUR1SYAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=GtVlAJJGWKH1DMq2uvY3B25xRTilkMFb5G+MaWHNQ00=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj6POL0FcBRnJRg5OOLiZVechUBSHFx2CiinKGu
 1UgPJxIcQaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+jziwAKCRBy2EO4nU3X
 VhR5EACESDkC6WWZ4QmLaNEeVzf2uD2Osg9trtmoEK2pOxi67tK20lz7A9HOtrKfNezpVBleH2R
 5nyax5rEQmVIpjXVG1dt2sf0q+KAPmUGsNCeFy5oKaqkjDilXr2zQCLI6q7/U2QaSivYeft2ku9
 0xI3sRn4TgywtcfIwCGqGBLb8rhpJggLchR0SmMNwCKydCZOHnz7Fb41GMmD/WfBQXVVMifUJNu
 Phc9+u4nANrMQHe274dOYUvf6/m9vrDtzJpKYTbbg2HjD+VTeyOZzheLdSKwxtti+YXmanda8Ii
 TxyVMhoanMNeALbMCU+NcSHxRQhEDJcp3g2HRXydMnQxAT92K9Jg2HNkvfU7miV5m3XmNLoy6dX
 mSryfgGwRX4JORJxf/w8KtgkBOsPWEPG0/2HTfxDgopgmhd1dzf81hVG6zzFoPOM9sY5LGvTcbr
 dHF9pYDZr8tQ+lybTgFzJntPIkKHpAzpfUPuxSrY82FOMEk+ayv8zLOeCoAun2ueYG4Rb09y3Zb
 7AFufKdgUnKONRx1eaeNQJJHWZUpXtempOar2cbPHy4npbPvTUCJss17SuVJ6HznSCSHCGKf9nh
 f/aCPBEtiIR9Qsj/sOJY+2oKI4Bh+p/+APLNseiPVvL5rTmILrUv5Aa3q26uRUMt+fgi9+xCqfr
 VZ+YKWvUoGZGUtw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to get cpufreq working on msm8974 I've found an issue with
clock rates above 2.11GHz (e.g. 2.15GHz). When a rate above this
threshold gets requested the lowest possible frequency will be selected.

This is caused by an overflow of the "long" return type of .round_rate
which has a maximum value of 2147483647 (2.14GHz) on 32-bit systems,
which msm8974 is.

We can switch the drivers to determine_rate so we can use the full
"unsigned long" type which lets us go up to 4294967295 (4.29GHz) before
an overflow happens which is significantly below the maximum frequency
of any msm8974 which is around 2.45GHz.

Note, that while setting the main hfpll now works correctly, the code
setting the div2 is still sort of broken, since it's requesting
"req->rate * 2" which will still overflow the unsigned long maximum
value, but it seems this doesn't actually break anything since the div2
doesn't use the calculated value. That's my understanding at least.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (2):
      clk: qcom: clk-krait: switch to .determine_rate
      clk: qcom: clk-hfpll: switch to .determine_rate

 drivers/clk/qcom/clk-hfpll.c | 14 +++++++-------
 drivers/clk/qcom/clk-krait.c | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)
---
base-commit: 6ba8a227fd19d19779005fb66ad7562608e1df83
change-id: 20230212-clk-qcom-determine_rate-c90c9ad0b337

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


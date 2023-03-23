Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB836C71C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCWUpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjCWUpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6465199E0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77BD1B821F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A69C433D2;
        Thu, 23 Mar 2023 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679604332;
        bh=C2TqXPrTCQIXt/q+F7TLNiZksg5FjIamJ1O1ngcMKFw=;
        h=From:Subject:Date:To:Cc:From;
        b=g4Iuv/eC/tLY0OOo6VXifQtKed7+ZOiC3SF8Fzf8DBRtGQPf0DZZvVg/pAAF+zHp3
         T93Lu/zbz57vDwCI8H6OoQeQ3hr4HbYC5mZMZoFmRvnlSL8Nm41DJ4jaqCNbpij26C
         5qGZBQj5dBdlMLLEaP5sCCAmTYcHysTja0r8b22Jd9oVXswju44g0mvBWt+lBoFIyg
         tz+PRfk20SwnbtjHPxPk5fFxhyBfksTfWrALtQlpy/I6NHugtXGPPAvoIG4h7WN5D5
         7uWs65EVIq0/1bufLlu4a+AvSbTQ8i5gni4HKpVlASi2H7FCX9r61idDyEV7JztaN+
         QZ5+93Y6sMVCg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/2] arm64/sysregs: Generate definitions fine grained
 traps control registers
Date:   Thu, 23 Mar 2023 20:44:52 +0000
Message-Id: <20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEW6HGQC/4WNwQ6CMBAFf4X07JrSQgme/A/joS3b0iiFbAnRE
 P7dws2LHuclb2ZlCSlgYpdiZYRLSGGMGeSpYLbX0SOELjMTXEguuQJNg6rA+RkIPXiMYJxoZI1
 OV51j+Wd0QjCko+335zxM+zoRuvA6Srd75j6keaT3EV7Kff3VWEoooa2N5bZtrMPu+kCK+DyP5
 NmuW8RfhciKBkulbG2kqcSXYtu2D3EAhY4MAQAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=broonie@kernel.org;
 h=from:subject:message-id; bh=C2TqXPrTCQIXt/q+F7TLNiZksg5FjIamJ1O1ngcMKFw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHLpn2C0H4Kv6fP9Jkb7mGJghweOh4fsJTEaf9xg7
 529ogP6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZBy6ZwAKCRAk1otyXVSH0GjnB/
 sEJYeBslnXvvOwIuNs/5/YQKQAA2QAqudmldbDvx0kiXkzhWmDAlZL+b5umDY5ExOuTQfhwtA/7CZc
 FIV0l9xuyEkWPNMgeFa6E9yAAt6AD8NiJ8cRLqzEjxAlYNxYHxQjpfj3Oib3Mjh+hpdGcrFomAhubg
 VrS/KyZPJ2kZjf/y6U6th0nbVL8L5Kk5XiRpWD0cxt02JZkHeinBrJCGzwtavZ6uQxKlJZd7ENY1Zm
 /hs9ZRYZulm4U5tU6D9dX5g4VukQAKADGgakgBS/U14gs2QUh6nY+O5ZIp7qr6V3qG+qJBNKosSypj
 B2rn09jpCaDKhNRPLRX+LdD5LCo5yC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series converts the fine grained traps control registers to
automatic generation as per DDI0601 2022-12.

I previously sent this with just the read/write trap registers, there
have been no changes in that patch since v2.

Changes in v3:
- Add HFGITR_EL2.
Changes in v2:
- Correct naming of nPIRE0_EL1.
- Link to v1: https://lore.kernel.org/r/20230306-arm64-fgt-reg-gen-v1-1-95bc0c97cfed@kernel.org

---
Mark Brown (2):
      arm64/sysreg: Convert HFG[RW]TR_EL2 to automatic generation
      arm64/sysreg: Convert HFGITR_EL2 to automatic generation

 arch/arm64/include/asm/sysreg.h |   9 ---
 arch/arm64/tools/sysreg         | 140 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 9 deletions(-)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230306-arm64-fgt-reg-gen-bf2735efa4df

Best regards,
-- 
Mark Brown <broonie@kernel.org>


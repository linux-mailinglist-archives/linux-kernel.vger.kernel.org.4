Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497176DFC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDLROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjDLROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C9658C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0873B637AE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C8FC433EF;
        Wed, 12 Apr 2023 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681319642;
        bh=12KprelI2/Vt7xRzp4F0cSteVB2Zn4nZCFdYvgfDKhw=;
        h=From:Subject:Date:To:Cc:From;
        b=DZW73upSKWVAOAVvAStc4AmNtkc9r0VMypxtQGB+dZV6LrWnnn0Z5M398esgBiHDs
         AD9TVC9bA7Qysh0db+Xi4wBZNe7qVjzt/q77jkagR5zDREmmgZGWoJ5mWJiUO5j7j3
         3ZgxUCiKDvVjsJJSq0tAYbgTvQtMbrwBDgaZgmwHTMYZwRK/tYbAMc6ELPa5V3BCmT
         sVFQW1/nfN/XmagNBct+j9w3IHA5aPYUGe2ahUURciPHi68BHrIiHuRrcnpjHrnJy1
         oF3x2bKKTIWONt31LzR9r1Xvs28eOdXhCXINmPt+AMaqfIc4BLgfxIdbdrKPuR1nzV
         u/2EsTCxlUWpg==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] arm64/cpufeature: Use macros for ID based matches
Date:   Wed, 12 Apr 2023 18:13:28 +0100
Message-Id: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjmNmQC/42NQQqDMBBFr1Jm3SlJFIWueo/iYkxHE6oxTFRax
 Ls3eoLyV+/D/2+DxOI5wf2ygfDqk59CBnO9gHUUekb/ygxGmULlIMlYlWjj0jHNizA6HiJLQqq
 V0QWZsuQa8rylxNgKBeuOg3mMRxuFO/85hc8ms/NpnuR7+ld9tH+oVo0KW13ZrqjIEtPjzRJ4u
 E3SQ7Pv+w/nTk1m1wAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=broonie@kernel.org;
 h=from:subject:message-id; bh=12KprelI2/Vt7xRzp4F0cSteVB2Zn4nZCFdYvgfDKhw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkNubV47aHgtbyATuJF0KGHKr3eF723EvZVSi19Ma1
 wFPDq+OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZDbm1QAKCRAk1otyXVSH0CcdB/
 sEN/VmHc0+BouttCfQpR+GjH7nEBfOCV3MxmpgXiS7YDaEUJJlm9SSqiQ4xvC5QEACdNJiQDW6DKYg
 XDCNdtoy631vwVZI0w1023OS6TKz95TgNeCIDg4DsSs6PZV5EXRck2m6i/Prxv+8sfhVeFm30/i/oN
 UMOLBKFEkz9dvubb6TPQALrV6C+dFghRIgpLQcg7cN1MALcrxgQhb8yZ78WxvSNAlP/8pz2IFYiPVV
 CL5hJ+cQynsVeolYb4DLMM/vdpXsQG2fxe2VEys7ed87AWdo46eUIdf1J3G035AMvDXIcvByTMTPd1
 n5ogmYl9Qn6fz72y3njF8FJmm0FrHU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As was recently done for hwcaps convert all the cpufeatures that match
on ID registers to use helper macros to initialise all the data fields
that the matching code uses.  The feature table is much less of an eye
chart than the hwcap tables were so the benefits are less substantial
but the result is still less verbose and error prone so still seems like
a win.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Re-add missed .matches in WFxT.
- Rebase onto v6.3-rc3.
- Link to v1: https://lore.kernel.org/r/20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org

---
Mark Brown (3):
      arm64/cpufeature: Pull out helper for CPUID register definitions
      arm64/cpufeature: Consistently use symbolic constants for min_field_value
      arm64/cpufeature: Use helper macro to specify ID register for capabilites

 arch/arm64/kernel/cpufeature.c | 271 +++++++++--------------------------------
 1 file changed, 59 insertions(+), 212 deletions(-)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230303-arm64-cpufeature-helpers-a70213a244e7

Best regards,
-- 
Mark Brown <broonie@kernel.org>


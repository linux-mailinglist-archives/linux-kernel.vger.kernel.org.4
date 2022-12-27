Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36193656B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiL0NAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiL0NAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:00:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E0F283
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23B54B8100B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC73C433EF;
        Tue, 27 Dec 2022 13:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146048;
        bh=HsCZybw8yewjHFqbVqY95jOBPrzRVgzWiLkTYyn/7Vg=;
        h=From:Date:Subject:To:Cc:From;
        b=muz6rFAHnewTM7ONltr1yYMiH+y1zoBRZxtRHwp4jJNt/K3PLzM4Dsk6RrAKb6vEl
         uoB0pT3hVotEYMamzYhJzNAZtTjjGfNAv35cQsHQjOLANKl580bzf41LtHD5+o/O+f
         WR/Bd6mTiR3KiFWcLfRityj6gJYyTqianrfo8eTRkHBqYNBiWZUGLqt49sclXlhi4s
         ejiBkvn9KYYThLL4TNPFOCsghkfyrszkl6/3k1J2JZOgI1TgpNbqYpJ14/tpI7Ekcb
         0wwD7+3+4HVOUuJVBZaKy+TXJBCHFnWTqdBdwsYrM+sVO3TsA3+baawi9eJbqGwjgi
         cgFczzgExDpfw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:00:39 +0000
Subject: [PATCH] arm64/cpufeature: Remove 4 bit assumption in ARM64_FEATURE_MASK()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-arm64-arm64-feature-mask-v1-1-c34c1e177f90@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHfsqmMC/y2NwQrCQAxEf6XkbMCGpQd/RTxk12wbSreSqBVK/
 91d8TLDG5iZHVxMxeHS7WDyVte1VOhPHaSJyyio98pAZ6KeiJBtGcJfs/DzZYIL+4wcYuKQmwnU
 emQXjMYlTW1gW21u8cMk6+f3eL0dxxcSCCclgQAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HsCZybw8yewjHFqbVqY95jOBPrzRVgzWiLkTYyn/7Vg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqux+lKrYFA3RDEFpH/hirTI4W3LXgpnZqltsgdKT
 pDiBnHeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6rsfgAKCRAk1otyXVSH0Bq7B/
 9Pv+V1qjVDmW2euGzjSlkUF8PaCSrFpxcAYRjdlW0xDuxlORCfOZmdXsMZvxJhfCTD52nWg9uAYQze
 GH8ocomihCPqpStR1jhC+k0T8WB3lRutidUvqoHVs8pUgSfEidlOfKVCieDph8VJ90jfN4k9l8xCct
 Ni4Ny3sLy3X77LO710nOZRDvKrDPP8+ymGxWvoS5bx8ofRw8sD6IKb2Pa7wckIb7a4xSgHGjo0MGU3
 Ucu2ZBYgV1P7u+imYSQsY1NHn2IvOGqGc5w1vf5rkrbGA+9zFPopNA8UunOFTCue7hk0OWOV90kduX
 Kx6Dkpn+URdj3IUWySfotDtyTKdf2J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM64_FEATURE_MASK(), used extensively by KVM, assumes that all ID
register fields are 4 bits wide but this is not the case any more, for
example there are several 1 bit fields in ID_AA64SMFR0_EL1. Fortunately
we now have generated constants for all the ID mask registers which can
be used instead. Rather than create churn from updating existing users
update the macro to reference the generated constants and replace the
comment with a note advising against adding new users.

There are also users of ARM64_FEATURE_FIELD_BITS in the pKVM code which
will need to be fixed separately, since no relevant feature is planned to
be exposed to protected guests in the immediate future there is no
immediate issue with them assuming fields are 4 bits wide.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1312fb48f18b..1c2bd78f03d3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -809,8 +809,8 @@
 
 #define ARM64_FEATURE_FIELD_BITS	4
 
-/* Create a mask for the feature bits of the specified feature. */
-#define ARM64_FEATURE_MASK(x)	(GENMASK_ULL(x##_SHIFT + ARM64_FEATURE_FIELD_BITS - 1, x##_SHIFT))
+/* Defined for compatibility only, do not add new users. */
+#define ARM64_FEATURE_MASK(x)	(x##_MASK)
 
 #ifdef __ASSEMBLY__
 

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221222-arm64-arm64-feature-mask-a4bca4fa4bce

Best regards,
-- 
Mark Brown <broonie@kernel.org>

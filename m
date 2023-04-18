Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198646E66AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDROIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDROIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849FB83FE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FDE5628A1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A31C433D2;
        Tue, 18 Apr 2023 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681826919;
        bh=bArM84IQ1n5ydc35nH+8offxbgpsF7AUR/t9YMKuID0=;
        h=From:Subject:Date:To:Cc:From;
        b=X4waKfj+5lgn4oHmgoGTFM8/w48Wv6f1zrSu6aRejWeV1xRClI21cz2WlZyBIrfbB
         0JUSIhiGBXBQKPZVnRlykMg1yBB3z8KFPwlaTeT0fePRrowloDXxbc/oviNQLW2ynh
         bg5Em0S5cpIZ/IXpNcIOeBynAODYtbF0kzqN1aSAcCAnFBFJhgt2MXO+JlitMIgh3+
         rQN6AAFeGikaaHxvYB2/V1BGCP0ekdioquMPm1HE7OdWu7iQMOAeij58mShPBxC8jK
         e4dFNV34TLLUFIzrw6dqN/BLd9XFoFSAAUwYx3XXxcVC9YaMdt1F1knJmg+Xr3wo4l
         y320aks27cVXw==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64: Add decode of ISS2 to data abort reports
Date:   Tue, 18 Apr 2023 14:57:30 +0100
Message-Id: <20230417-arm64-iss2-dabt-decode-v1-0-2138b5668777@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMqhPmQC/x2N0QrCMAwAf2Xk2cBay7T+iviQttEFsZVEVBj7d
 zsf7+C4BYxV2OA0LKD8FpNWO7jdAHmmemOU0hn86PdjcAckfUwBxcxjofTCwrkVRs4xhSnHI0U
 HPU5kjEmp5nnLP03vm34qX+X7/50v6/oDzRoCan8AAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bArM84IQ1n5ydc35nH+8offxbgpsF7AUR/t9YMKuID0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkPqRjLdFd3zHIJg7GJ1jriP1c4IpRIyhjASSUV1MU
 WjHWWU6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZD6kYwAKCRAk1otyXVSH0E5JB/
 4qWPEsiImI7Le++xJzTxFuikQxhb+m3IoH2heclLGy/rvtkImLwCfmkT+LaVVAdWpD2mzW3szfyLBz
 2YZPgxPxsuaJPuZ4gR77s119KPCN+6Gwf48H7wqsx+m5+9Hg1TLX/6PRk2YYq0eUjPZUmNOG3Y+HPy
 zcbWtH6RPaseXlL+uRbynT08L0pgX82c0C5QyYzff7ADtEo0VfiQlz/j988drq00IzcQ+NKDIGD0/7
 L6wTi7GXkak+SRXFHDVOkK9/kJA7cl9A/IaMjpUttG6CftUykSUf72LPDxSrX1Lj9PZ/tJym/+K6pO
 R1e1/m1vpq+YwCl5Zs4asOg+O08eSS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We provide fairly detailed decode of ESR for data aborts but do not
currently cover the information reported in ISS2 which has had quite a
bit of additional information added to it by recent architecture
extensions.  Add decode for this information to aid in debugging, for
completeness including features we don't actually use yet.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/esr: Use GENMASK() for the ISS mask
      arm64/esr: Add decode of ISS2 to data abort reporting

 arch/arm64/include/asm/esr.h | 19 ++++++++++++++++++-
 arch/arm64/mm/fault.c        | 14 ++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)
---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230417-arm64-iss2-dabt-decode-ec9b46c98a91

Best regards,
-- 
Mark Brown <broonie@kernel.org>


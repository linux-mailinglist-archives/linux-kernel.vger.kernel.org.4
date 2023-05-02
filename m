Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0906F49B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjEBSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjEBSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126919AC;
        Tue,  2 May 2023 11:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A9A627CA;
        Tue,  2 May 2023 18:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1A95C433D2;
        Tue,  2 May 2023 18:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683052280;
        bh=roX7J2C0cryIH4aFs82eea9tajAAQbquDLz9EWJ4Moo=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=OUOgWCiTr3qm3yoKkf+0dTdaeN1e0aW64AGHh5bhzZi8wrNmFmIHXIBKrNEOXPC7G
         N1y8IxqSWnn+2eLrKQwjUBLtGuTnLY3RMloepvWBgqpmbx2GWdne2zF4Wr+1M0cFHS
         uaffoc/z/okLGmZUaUl2zP+14qQJkRmLxtxwlQzDfiqJKnfdilGtiUY3hT2kInOzkH
         UjA60H+nKjFFthiM02UEnElogeKnUsAmUpeUE9D4VN9N0hFDlUngyDyuwtxhRdPTiP
         mhlluV0blQmVV4bQA23iXkWEWyyH3xT7iroJQSxnEXeUSN6Fo3txe9pHVfsW2SYpl4
         RSFnEg7oNZ+zg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id AE069C77B78;
        Tue,  2 May 2023 18:31:20 +0000 (UTC)
From:   Gabriel Tremblay via B4 Relay 
        <devnull+tremblay.gabriel.gmail.com@kernel.org>
Date:   Tue, 02 May 2023 14:31:14 -0400
Subject: [PATCH] Change the interrupt from level_low to edge_falling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230502-gtremblay-x13s-keyboard-v1-1-6bc3e59b0d39@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPFWUWQC/zXNQQqDMBCF4avIrDs0ThSaXqV0MdExhraxTEpRx
 Ls3Cl3+PD7eClk0SoZrtYLKN+Y4pRL1qYJu5BQEY18ayJA1rSEMH5WXf/KCc20zPmTxE2uPdHH
 OtoMjEoKiPWdBr5y6cfe+OQf5031/qwxxPp5v9237AVB2ldOJAAAA
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Tremblay <tremblay.gabriel@gmail.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683052280; l=1193;
 i=tremblay.gabriel@gmail.com; s=20230502; h=from:subject:message-id;
 bh=nbP1Xx1KAt958LpS5KvFFCWaYnFLYSX2Yz32vSKwDHU=;
 b=faBX9jx+sw9zzbs1OOJBCsG/3856f4GkZfvQqQ38ycrkKmFhL/mIyyzW1Lp+daHZlpOK7/PJZ
 hxMDIG9RBBdCfD19KjPfkiBjUBQg0fEv9Dh0H/kTAUS83Kol88Ly/sL
X-Developer-Key: i=tremblay.gabriel@gmail.com; a=ed25519;
 pk=QBcAw+03yiRPOAXsWfAlyaNIhBRPIH3l8tURId7/7Nw=
X-Endpoint-Received: by B4 Relay for tremblay.gabriel@gmail.com/20230502 with auth_id=45
X-Original-From: Gabriel Tremblay <tremblay.gabriel@gmail.com>
Reply-To: <tremblay.gabriel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Tremblay <tremblay.gabriel@gmail.com>



---
Lenovo's x13s internal keyboard shows responsivity issues when fast
typing occurs. The problem is not replicated with external HID keyboard.

This fix tries to alleviate the problem but requires further testing
and commenting.

Signed-off-by: Gabriel Tremblay <tremblay.gabriel@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index bdcba719fc38..e8d7f02c9bf3 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -639,7 +639,7 @@ keyboard@68 {
 		reg = <0x68>;
 
 		hid-descr-addr = <0x1>;
-		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&tlmm 104 IRQ_TYPE_EDGE_FALLING>;
 		vdd-supply = <&vreg_misc_3p3>;
 		vddl-supply = <&vreg_s10b>;
 

---
base-commit: 84e2893b4573da3bc0c9f24e2005442e420e3831
change-id: 20230502-gtremblay-x13s-keyboard-289935f922e2

Best regards,
-- 
Gabriel Tremblay <tremblay.gabriel@gmail.com>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9CE63275F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiKUPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiKUPJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:09:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DC1D2994;
        Mon, 21 Nov 2022 06:59:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4CEC21F48;
        Mon, 21 Nov 2022 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669042788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XbU6pJlnqsaZ2ECXXpl266vRcoUTK5bfjkYQl7JTGT0=;
        b=w5wNzDKc5o5a66YDFf0df334D2mmIQbjszdUQeTr9hiGgzOAsP4qyGiqEtXhNZAPz4YUtv
        PcurCRZYYCz+agP8TBX0QRvDkRcOS1Zq6qCGrfSqxo9uIIaZNRKRKGSFHlcMOo5cKcYJMA
        MK4LGlpQqeKSkPU7nc3LMvoEGRMs9ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669042788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XbU6pJlnqsaZ2ECXXpl266vRcoUTK5bfjkYQl7JTGT0=;
        b=EO7VZCQUzdvWwVf3irvBD+SDUznOjSXilBhyPSaGVrZA4hyxrP20upv7CuZRMoqoTj972+
        yYNmJdMRTpT9qFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D4491376E;
        Mon, 21 Nov 2022 14:59:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K/esFGSSe2NkLwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 21 Nov 2022 14:59:48 +0000
Date:   Mon, 21 Nov 2022 15:59:46 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: qcom: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20221121155946.3c985500@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>
Subject: interconnect: qcom: Drop obsolete dependency on COMPILE_TEST

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Georgi Djakov <djakov@kernel.org>
---
 drivers/interconnect/qcom/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.0.orig/drivers/interconnect/qcom/Kconfig
+++ linux-6.0/drivers/interconnect/qcom/Kconfig
@@ -74,7 +74,7 @@ config INTERCONNECT_QCOM_RPMH_POSSIBLE
 	default INTERCONNECT_QCOM
 	depends on QCOM_RPMH || (COMPILE_TEST && !QCOM_RPMH)
 	depends on QCOM_COMMAND_DB || (COMPILE_TEST && !QCOM_COMMAND_DB)
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  Compile-testing RPMH drivers is possible on other platforms,
 	  but in order to avoid link failures, drivers must not be built-in


-- 
Jean Delvare
SUSE L3 Support

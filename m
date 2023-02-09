Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA7E6902FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBIJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBIJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:13:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E46526B;
        Thu,  9 Feb 2023 01:13:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 526DC5C57E;
        Thu,  9 Feb 2023 09:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675934011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/mb4V4AKxUcpCqvygYFU+EbBIkXTjeRr8MrZfnACX74=;
        b=fyQc2pIiM+B4yHJGOwP8OZD8sN2r0CXFM9T0l/Mq3CbYFt5jfVjyuM1eFu3DMSdlyEhIHJ
        eMFm0e4hi1TjCM62Vz67ijctSxBHimu6XjzF5rixU9cVMio5GOpat9Cwz8QsH/hD1YItnm
        7jM6hNCtKl6wu9H0VSDEmb9qZOGcNKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675934011;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/mb4V4AKxUcpCqvygYFU+EbBIkXTjeRr8MrZfnACX74=;
        b=wgtaxmUHC8zYK8sIgcCcpTUz+nbj4Xzu+A48a+sWnSIxjyyk/rhYH0tc/4mMAI0UbXSA9U
        ovR2XxaPwpPa1FDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A37871339E;
        Thu,  9 Feb 2023 09:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jvc+Jii55GM7JQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 09 Feb 2023 09:13:12 +0000
Date:   Thu, 9 Feb 2023 10:13:10 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] interconnect: qcom: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230209101310.11942cd0@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
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

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

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

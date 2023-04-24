Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601536ECA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDXKaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDXK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:29:47 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 03:28:39 PDT
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0314692
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=thOQNaGa1KezcTHfkgm9AKof4vJNBxcHo6T+Yz6kT6w=; b=Jz
        1+6AstA+9oZw5qGNOVs/J/0+27uHKAVocWmKzlmddOF7fgVKkGyPzcOaZOijVVdjhGc3Mt0QKodJa
        /NVbTHvtl6/GxTxclPoeDgFXVDAdmSaAJ9DVgj25aRW1eCwQZRI2bROSKPP3XxDz8KD8sVmcL021i
        zKePEBh79hmOtdNV6AtIl3IA7WggaHQpoOtc0oi+7VEMyZgfXP5Xje7NcpllcB9C4osM/LR4GA6gA
        bIHc6PrnMahyvbaQwY6sGdwPDnOWFgSuLMT5AUtjyqS9K8QTZ7twYX7b4SgflFst9QFH3ZuhYdqDk
        BI0GgDmNxAmepLvJG9dbioDQrLEoA7sQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
        (envelope-from <ukleinek@master.debian.org>)
        id 1pqtQw-008OHt-Gy; Mon, 24 Apr 2023 10:28:34 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] tools lib symbol: Use -D_FORTIFY_SOURCE=2 for non-debug builds
Date:   Mon, 24 Apr 2023 12:28:27 +0200
Message-Id: <20230424102827.58707-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=ukleinek@debian.org; h=from:subject; bh=jrt5Cw7SjJFatnTn8819yq1WoBGWxX1SXz352b0VDDA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkRlnKLutnVNpXzOtP7TRRQg1soefAWGX30yPIH 1oDSMkYOVCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZEZZygAKCRCPgPtYfRL+ ThiUB/9XRDpdrB86B/5rcyoJADDJ8HsQKim1O/ZOdsJJVtUlKP5LfuXFgu0ij9UdiQiLSthhLNj fEV5MQhi4OG/kntVWc7NAdxqJR1UYgimDymR1CcZMqPFwyG75455XSnBTofz2Kf1qRNpVfLcbTP qbhMG/s2peM8yErw36j12bulfhy/IYgaWVqcAVcojMeKDgutj78Fz41JJwaHMkkfhHPAGdDUkaU RpqhGm5fdkW4MQr/QFi2ac2d13es+tDY5RMf3k8v/Swd+hTndCm+y+NrXnSg9VEqTSwSHHsfHsE m8OG1K1QFNRS5u7RpzbX8qqI+8roJnN/KTsoEHiSaDvS2ZPB
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 160be157eaba ("tool lib symbol: Add Makefile/Build") failed to
define _FORTIFY_SOURCE to 2, probabaly this was cut&pasted from other
Makefiles with the same problem.

Fixes: 160be157eaba ("tool lib symbol: Add Makefile/Build")
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 tools/lib/symbol/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 13d43c6f92b4..4a08cc4e19f2 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -39,7 +39,7 @@ endif
 endif
 
 ifeq ($(DEBUG),0)
-  CFLAGS += -D_FORTIFY_SOURCE
+  CFLAGS += -D_FORTIFY_SOURCE=2
 endif
 
 # Treat warnings as errors unless directed not to
-- 
2.39.2


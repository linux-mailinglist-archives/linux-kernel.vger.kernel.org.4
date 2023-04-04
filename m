Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D386D5593
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDDAec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDDAeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D51BCB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680568422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HCMKpUEBBb41wumrKRtFt3l4UFUDKQm0e5vMvIDSbHw=;
        b=Q8+H+NVhXIRxK9CO2cDcmGeEa253HYS1uqwIuB1yDa2Yxk4os9RO5UrNaL+uBATHUAuH+U
        35uG7SjVEdxMgvbv8KStt4rHAjOxqTtkI96A+s4cfkcs0dIZcjc469fxIEYVA1+5mnT0/R
        4gQS7zpWKtnMlnupjSyO86GQcgSxPfY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-RuX1xYw8PQWTlzhjOC9Z4g-1; Mon, 03 Apr 2023 20:33:40 -0400
X-MC-Unique: RuX1xYw8PQWTlzhjOC9Z4g-1
Received: by mail-qv1-f70.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso13907842qvw.15
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCMKpUEBBb41wumrKRtFt3l4UFUDKQm0e5vMvIDSbHw=;
        b=wF4Jf7jP9CjwAwSAkVsWcKCeREIHSyGK9nIaXdjd6uTPSX5R4N/Tm3NrC23ByXUe+9
         CXFRz3iTncHJn/q9mYW8kRh+Z1Wm4vBP8bDLLu4zI+2+eadADi93E8TJ0b2p/DAkmLR3
         DTxEYVeDAhXHTfoKh1j1SZMF5mGWmRbguhxSA86oLPouSbQ4nuBCb9y+x2G3Yl2VHMef
         7GfAG3uTZLaWQkCGdeFxtPtMwl9QeoM4cxxspKUwKzpD4T4TlHjII7APtg+iYW2iGGl3
         R/BttkR8OC6Jz6wv0HtLSoM57gVQLa1YXoIuPf6L7nRoSTkGTIjTUpouaZF82yy5jhPi
         I0+g==
X-Gm-Message-State: AAQBX9cgXCersMHdz1gYTceFHH+S3i+lKbCmsNq2PVo9uOqiWBcoDec6
        MlQeKgOaojZj/QYI+ml2GLKIE2rM1ngg9KIudzoImwMmNWj3Y57VrgEHrOE33fyt5G3PMxLOIvq
        GSL+c99TohUDvIgUdCVaPtT2c59+FdJS6
X-Received: by 2002:a05:6214:c4d:b0:5ad:c532:67e6 with SMTP id r13-20020a0562140c4d00b005adc53267e6mr1092101qvj.42.1680568419885;
        Mon, 03 Apr 2023 17:33:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlsnwoS/IsQsObFTXFkOS6WrQ4JfYBiqEJugHfljD3oCZexxoqhGjadhA+cFVWghQwgzJIzQ==
X-Received: by 2002:a05:6214:c4d:b0:5ad:c532:67e6 with SMTP id r13-20020a0562140c4d00b005adc53267e6mr1092076qvj.42.1680568419614;
        Mon, 03 Apr 2023 17:33:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q10-20020a0ce9ca000000b005dd8b93457csm3006035qvo.20.2023.04.03.17.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:33:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cpufreq: amd-pstate: set varaiable mode_state_machine storage-class-specifier to static
Date:   Mon,  3 Apr 2023 20:33:37 -0400
Message-Id: <20230404003337.1912901-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/cpufreq/amd-pstate.c:907:25: warning: symbol
  'mode_state_machine' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6f4b8040d46c..5a3d4aa0f45a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -904,7 +904,7 @@ static int amd_pstate_change_driver_mode(int mode)
 	return 0;
 }
 
-cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
+static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
 	[AMD_PSTATE_DISABLE]         = {
 		[AMD_PSTATE_DISABLE]     = NULL,
 		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
-- 
2.27.0


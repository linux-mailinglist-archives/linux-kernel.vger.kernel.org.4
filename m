Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307A6F2F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjEAIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjEAIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E0DF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682929263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FT26bsZTksy9w0Z5ZkQBGS3kpOjEM/lIdHfF+ktDpPI=;
        b=X6E3kYC0JxZztsypqXX0y5JongHs2b5hlUsjjsB6tiKiJWQk+sm9/unk7MxRO0arQV+zWk
        MEf6jdHgYUT2Q5jVhTOkVYXgRu6DD9gUqs8foxb9H7xJbVEuSJIP3WkVMn7rBLoWm+TMOX
        eBfGhi1ulPd3MyZkqJnXj0iNlGSwi+I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Sb_X7t6tM1C057X3hUHbkw-1; Mon, 01 May 2023 04:21:02 -0400
X-MC-Unique: Sb_X7t6tM1C057X3hUHbkw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1aad9af33c1so17905445ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 01:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682929261; x=1685521261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT26bsZTksy9w0Z5ZkQBGS3kpOjEM/lIdHfF+ktDpPI=;
        b=QV7OiVPPCvfC/hKFd2MV/OvwQVqU4WdlidkUPVatPsBURUOGupBXPkPq29FIrHa6T2
         nukd9ddLPe+hJwK7OO4B4wrulNUDxYf8rgE9TbcxCw7FooYpfn/D6tkZOChRSqOIokqG
         OL9UGdc3/KekunjwV92EP3GJKECdlLRQrWkWjhAP1U55LaIZt+ABG09soXDG+UtYk5zi
         FEPwMmyq4JzXkx+b2giOH4IahkfEocbgP11lphf7s7e55Sys94Dh+wwhWb7DxmEdpZYN
         /8ggxhoYwO3tLCKxAJ+x41ZGpOKgmcHEiX3zmBjmnSQf4QaPDtFrY39vgIi3Hz+sa2f+
         jclg==
X-Gm-Message-State: AC+VfDzYVtVtDct67E/X+SVGYNk+mes38aQcYxohWKhTJp1krbBZ++8y
        MWEpFkX/BwmD1ggZS9KSnvCbHIY+mxtiZ33On02/Q6/c6nywGjgX48h8npmHLvD6xhstKjtQ0i2
        G5gO/3ciO3CSWlDRvVtJpjfBl
X-Received: by 2002:a17:902:9a48:b0:19a:b754:4053 with SMTP id x8-20020a1709029a4800b0019ab7544053mr14265281plv.26.1682929261460;
        Mon, 01 May 2023 01:21:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HfJhry47T9KbwOD+9oM8pm5mDg19vNl2hJAA8LhH1GM6W6FydZaTthxFQQf7IjvvgqsJGVQ==
X-Received: by 2002:a17:902:9a48:b0:19a:b754:4053 with SMTP id x8-20020a1709029a4800b0019ab7544053mr14265271plv.26.1682929261227;
        Mon, 01 May 2023 01:21:01 -0700 (PDT)
Received: from nsharma-mac.redhat.com ([49.37.74.43])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090276c100b001a80ae1196fsm17375015plt.39.2023.05.01.01.20.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 May 2023 01:21:00 -0700 (PDT)
From:   Natesh Sharma <nsharma@redhat.com>
To:     corbet@lwn.net, chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        geert@linux-m68k.org, axboe@kernel.dk, linux@zary.sk
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Natesh Sharma <nsharma@redhat.com>
Subject: [PATCH] docs: admin-guide: Add information about intel_pstate active mode
Date:   Mon,  1 May 2023 13:50:50 +0530
Message-Id: <20230501082050.74131-1-nsharma@redhat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information about intel_pstate active mode is added in the doc.
This operation mode could be used to set on the hardware when it's
not activated. Status of the mode could be checked from sysfs file
i.e., /sys/devices/system/cpu/intel_pstate/status.
The information is already available in cpu-freq/intel-pstate.txt
documentation.

Link: https://www.kernel.org/doc/Documentation/cpu-freq/intel-pstate.txt

Signed-off-by: Natesh Sharma <nsharma@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bbecbd5797a3..10f3c8d1bb46 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2104,6 +2104,14 @@
 			disable
 			  Do not enable intel_pstate as the default
 			  scaling driver for the supported processors
+                        active
+                          Use intel_pstate driver to bypass the scaling governors
+                          layer of cpufreq and provides it own algorithms for p-state
+                          selection. There are two P-state selection algorithms provided
+                          by intel_pstate in the active mode: powersave and performance.
+                          The way they both operate depends on whether or not the hardware
+                          managed P-states (HWP) feature has been enabled in the processor
+                          and possibly on the processor model.
 			passive
 			  Use intel_pstate as a scaling driver, but configure it
 			  to work with generic cpufreq governors (instead of
-- 
2.39.2 (Apple Git-143)


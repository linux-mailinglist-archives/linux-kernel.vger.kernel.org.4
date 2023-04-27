Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348E6F02AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbjD0Iij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbjD0Iig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F584C33
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682584668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FT26bsZTksy9w0Z5ZkQBGS3kpOjEM/lIdHfF+ktDpPI=;
        b=BcKGl1KoXj0TKaqryAjfZYX+zc/IlwU9MqKw8ce58arZ+ciZU/7GVmYjl+nWvuKeIKEumc
        HQGmocSGhL/Z2VQlrvrmEAiIqvmxiJLprZwtxfYa4aSVxkAsgdUXlgK3GAU0tE66f0DZfA
        GYtKM9SRweJXjyT+EC0xfTItALZLaTE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-XFWTRM5cPmeowdix9C_PAg-1; Thu, 27 Apr 2023 04:37:47 -0400
X-MC-Unique: XFWTRM5cPmeowdix9C_PAg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-63b60018e71so5554248b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682584666; x=1685176666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FT26bsZTksy9w0Z5ZkQBGS3kpOjEM/lIdHfF+ktDpPI=;
        b=VB3r7sbyyKE6CQDfS4z6XrASEoq2UwekxF1YgAMZV0lLfSX3Wl/CzewhnyujBT07FF
         0m/PCcDIQLUm+xJsY//TxTDM5O0Dmu2qTH5us68RnvcE4i8NAeUoncTA2jeOR+DzsqYV
         JIWn6DyDGXAVMbgYl6vsN8vlngMU8BL/G9PsBaiQsgoNtpsrTBRzmdGTqhYNJDmm8lAL
         4DAHPD9Fk23kOkfEoCVEUgGFZhw0q8f40h8Shd88hU1wtwIi+Ff/DxmCGiPrItsDAZYi
         VtBtkJt3V/VnrUgl0NoYCxBGkiKhsnXyvZ3I9JCL/grIooM5uV1RZLQiSPE4SGKDYrz9
         SvWA==
X-Gm-Message-State: AC+VfDzpaFfQYTZCdtF8NLj3aAXLuZtX8K+v5zIprg+jP78tkj62Cwyc
        l456fsn8vOTukFZ3EKfAcNarjfimbQ814v17GUu8GOmruSsksD/9pcT671IlLeuwqSghdmx5net
        3U4m6blSMw5h9ppQTjsqkiJNrVKwXACbKKJ4=
X-Received: by 2002:a05:6a00:18a6:b0:63b:854e:8459 with SMTP id x38-20020a056a0018a600b0063b854e8459mr1320900pfh.31.1682584665848;
        Thu, 27 Apr 2023 01:37:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40DrCNhHatZ2coz2Ut05aumESlJ+c2+DlbJvx0NkNxsZ6d1inQLpc7uIfqPl1ShuB2Djet7g==
X-Received: by 2002:a05:6a00:18a6:b0:63b:854e:8459 with SMTP id x38-20020a056a0018a600b0063b854e8459mr1320882pfh.31.1682584665497;
        Thu, 27 Apr 2023 01:37:45 -0700 (PDT)
Received: from nsharma-mac.redhat.com ([2405:201:a400:c036:a55b:cfa9:5cf:adad])
        by smtp.gmail.com with ESMTPSA id t2-20020a628102000000b0063b1e7ffc5fsm12591223pfd.39.2023.04.27.01.37.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Apr 2023 01:37:44 -0700 (PDT)
From:   Natesh Sharma <nsharma@redhat.com>
To:     corbet@lwn.net, chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        geert@linux-m68k.org, axboe@kernel.dk, linux@zary.sk
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Natesh Sharma <nsharma@redhat.com>
Subject: [PATCH] docs: admin-guide: Add information about intel_pstate active mode
Date:   Thu, 27 Apr 2023 14:07:06 +0530
Message-Id: <20230427083706.49882-1-nsharma@redhat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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


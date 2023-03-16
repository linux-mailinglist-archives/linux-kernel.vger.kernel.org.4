Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043626BCE97
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCPLmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCPLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:42:07 -0400
X-Greylist: delayed 1749 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 04:41:51 PDT
Received: from egress-ip4a.ess.de.barracuda.com (egress-ip4a.ess.de.barracuda.com [18.184.203.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6A168AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:51 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200]) by mx-outbound40-126.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Mar 2023 11:41:49 +0000
Received: by mail-qt1-f200.google.com with SMTP id i2-20020ac84882000000b003d6fee1d438so721186qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1678966908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAO3s9WIPu6FGtr1O/SymD5IC2bA74jcQnX8JFNXRUo=;
        b=C8+BneIotC1t/8SGsAwDtZfbOSQUpCldbfArpFUgOLYaoAXAJlYImxKZcS8jKjzRVl
         6zhy9GCGrL+4BYygI7AV2or+E+1zGMTfiklsKTBpnVlghyVnbS/G44mpRSN51MVttwMp
         t3LDD2aWhfYvfD3pqkpP4Tv1I+zP7bO9k7StM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAO3s9WIPu6FGtr1O/SymD5IC2bA74jcQnX8JFNXRUo=;
        b=sBUmXdH4+Li7pyR4ZCd1GpDpBC37DhP5o/KVwMwCXNPxFzf0qte2CPeaTKIIrLC3to
         WP26oiqk2mvfsRyyR+C8bAMirpFYwyqzYD6loRS59W9IEtOU/tCSQPAUv9LVna4XJNTN
         nRCqKHvSWCgR7cTkvczrXLbtCoOf17/qK90hUT1RVn4hDlFvMsY8Ejdz1upu1i3kfmHv
         Gn+37t1kakxHPw9JO4iszlckDhVadAZ452mp1vg47taCa1SRq5KL5GFEdaDx1WkKBpOy
         JyuSAOVFGqgkV/2LySKfMRIlm7t7nZhlAbg0aOiquRi5DuyXR51lf6gHq7ww0bkU90gx
         Ptsg==
X-Gm-Message-State: AO0yUKVM6dwU4ciQkCmmwur+mzfLgVgvz0OCJimSYeEfWLtfunFqEiEh
        j2zIbxMUZSNuM/Xy5mhTVKRuaiQZb+ON4UHTvASepygoKb+BQDV0Vd6J9rd2ADYj/VLV2RhhPv+
        EAdYIV7F2mIugzDguPu2sqn5CBZh1fqFbJK9i5m8b6uMsNxYAxzyzuBzZh5gq
X-Received: by 2002:aa7:9d12:0:b0:625:a102:9a34 with SMTP id k18-20020aa79d12000000b00625a1029a34mr2467805pfp.24.1678963675646;
        Thu, 16 Mar 2023 03:47:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ZIHqpxTj5SShM5wZfbAekKBVo4SSDbXQqCraFeWsiUcsOMKa5qAMss1F1qq9ZExPt1dhZLA==
X-Received: by 2002:aa7:9d12:0:b0:625:a102:9a34 with SMTP id k18-20020aa79d12000000b00625a1029a34mr2467791pfp.24.1678963675351;
        Thu, 16 Mar 2023 03:47:55 -0700 (PDT)
Received: from localhost.localdomain ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b005a8c92f7c27sm5108744pfd.212.2023.03.16.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:47:55 -0700 (PDT)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabiya.d@mistralsolutions.com,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 0/2] Fix WKUP domain IO PADCONFIG size issue and RPi header support
Date:   Thu, 16 Mar 2023 16:17:41 +0530
Message-Id: <20230316104743.482972-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1678966909-310366-5551-16212-1
X-BESS-VER: 2019.1_20230310.1716
X-BESS-Apparent-Source-IP: 209.85.160.200
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUirNy1bSUcovVrIyNbcEMjKAYikGKYZpyYYWlo
        bGieYmiWYWlgZmFmZGaYnmxqlmKSYGSrWxAPGtUx9AAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.246833 [from 
        cloudscan17-171.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, NO_REAL_NAME, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

Hi All,

This patch series include the below changes:
1. Fix the incorrect IO PADCONFIG offset size of the wakeup domain for J784S4 SoC
2. Add RPi expansion header support for AM69 SK.

Dasnavis Sabiya (2):
  arm64: dts: ti: k3-j784s4-mcu-wakeup: Fix IO PADCONFIG size for wakeup
    domain
  arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 72 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  2 +-
 2 files changed, 73 insertions(+), 1 deletion(-)

-- 
2.25.1


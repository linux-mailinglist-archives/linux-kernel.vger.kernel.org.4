Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32273BC35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjFWP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjFWP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD72123
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687535847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8yB7HqTroWEhP9efqg+b7pKLnUsqA1PuT3Ijl2qFi+4=;
        b=Yo93A4Fl0yVQ4Xo1VL5TfycDWMSqxYC8xhKJ2TVlYNpJySn1SNV8ZihzQSYmgerBOpELhy
        4zsFB/3J5IPelY+c/DnQt057Zn7JttplUGkd/9juN/YkmOxH5JslrBRpF2hB79No2J/Sxu
        tVH3braoXb75nmDoys8/D8P6UTdjeRo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-gSKXmlzwPwiy9XPoFZdRog-1; Fri, 23 Jun 2023 11:57:25 -0400
X-MC-Unique: gSKXmlzwPwiy9XPoFZdRog-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b71ea696f5so585248a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687535844; x=1690127844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yB7HqTroWEhP9efqg+b7pKLnUsqA1PuT3Ijl2qFi+4=;
        b=SQEdeAsWRvokJw9dmP16TNFXCVi2rjCe4aT6AGxNjmq9rFrAWPI72DT9r2nvkUbV62
         FWh68DfFpSveIzs3iwF5go9CYTpzfP9ncouKiRxePcUqxAZ7tnvDKh/pF2APsO1NgNj6
         pxs8FivX5MJAvK6k34u704wSXSACSf9je1PNSALkDswIjFBL40U1EPSgFoIyBuJH6k6Z
         QKyXR2kIDvejQwG2G/egNps95OkpeQdhQnP2m0USk7tyD15ZoHgPVoX0hnHROWraDLuw
         np7Au/MJhnsWugtkl+v9NzVuKnVKOGNpm87s19w25oozqm0hsa2bLegkLjSb+YcNafk3
         AvKQ==
X-Gm-Message-State: AC+VfDzlqDKu9wsZpE1wBhwjNPAW7DxaWtak97SmezB2qyNg1pv90fVC
        VqFAMLEKimkglTJJvnXKpHPY3zKqOT9dgn1wZDR6jF0Rizn2uMOdzJrEtUGBtAlexsgsb8/myjL
        GS5CKJDvA2YVzddgEFCclFkeUYN7y1mxLQVMLoGVjK3AkXXBsvZHdfpMMTehPRUu3+rh66JJGUv
        9/GIKIxPV7
X-Received: by 2002:a9d:7414:0:b0:6b7:296d:3d4e with SMTP id n20-20020a9d7414000000b006b7296d3d4emr980473otk.30.1687535844280;
        Fri, 23 Jun 2023 08:57:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nubFY5xAfbSlXYXWVWjad3VSMli+Q/HTHaXj169kXem2BAiF1sIv7sOY1ukVSIq+NyDYRnA==
X-Received: by 2002:a9d:7414:0:b0:6b7:296d:3d4e with SMTP id n20-20020a9d7414000000b006b7296d3d4emr980442otk.30.1687535843646;
        Fri, 23 Jun 2023 08:57:23 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d6391000000b006ac75cff491sm3883758otk.3.2023.06.23.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:57:23 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to get icc paths
Date:   Fri, 23 Jun 2023 10:57:07 -0500
Message-Id: <20230623155707.944272-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way, if there's an issue (in this case a -EPROBE_DEFER), you can
get useful output:

    [root@dhcp19-243-150 ~]# cat /sys/kernel/debug/devices_deferred
    18591000.cpufreq        qcom-cpufreq-hw: Failed to find icc paths

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a78d7a27b4b5..f2830371d25f 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -661,7 +661,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to find icc paths\n");
 
 	for (num_domains = 0; num_domains < MAX_FREQ_DOMAINS; num_domains++)
 		if (!platform_get_resource(pdev, IORESOURCE_MEM, num_domains))
-- 
2.40.1


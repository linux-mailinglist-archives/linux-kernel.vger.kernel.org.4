Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF96A229D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBXT63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBXT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:58:27 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4736A79D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:58:14 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaeceeaso5452567b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677268693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HItKTiGQPlQYCMjDtIoBxaJw1Pu4dDmMmJ8dk4P8cQE=;
        b=cFXgXNHH0TIBYGBXQK+NGFbDWGGG9gu153NQeVh/+J0c8SNKdNfW9Q60AuZrfAsX48
         vjEPsPHHbMFib+HOiDp9vjK/qwSKx+iN67T8D7ZEQRGrsREGiEf6JIeaqPpjTMEyQUW0
         hsTDPHU2y91qXxeXfzzrKDe0Kc8PVVGcr6IaejwzYWj2WnrYEwsai79jb4TqJGOBlecf
         EqE+L6RaLt4syuvJhi7XYIKkreiRdvv9+zNqfcyWAr643l8IG9xnrxi/Fsm3v0i4gRQY
         fGrzB+2ajlUMh2fMPxiGJOzHqNQkGMQrrJ/bQz2LblBj9kY4auTbcLMLdJsagYmi4XkQ
         DYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677268693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HItKTiGQPlQYCMjDtIoBxaJw1Pu4dDmMmJ8dk4P8cQE=;
        b=fyhbghqDSpZOIch4VII8oBIeuzZVpgICb0NO9vno2As1NpZkOpYGhpNQTNcZZtgV8h
         WeuKTYmp4mZYcwsobiWtTuBxIGaARBcV+AyLRIkzaA/2CaGATloZ0dLzEqZWUONFzI6i
         MSZddhutHcGeOGeLClwMZcZpXI8RdUJNfXqfCqAlwYCk+06UFjLT6CmTKtuxPkBDedmB
         ZwZ0eBiLWS9crmccFdM3dgfkk6/ZtT0cgmb5dwzu6QzneBohd3fygogAtUM+lJywf4cB
         uic4J7VO26SwcZIPtP27NTwoucM2EkVgmWHJsRMpX4P/VqGRgIuf8sJa0wrXb/pHOXB7
         jC0Q==
X-Gm-Message-State: AO0yUKU7Vjqj6dD8PboPHTC/Y44CFzBN7tHR+68iRkJd2UvzRFLIgVuf
        8GFMvWJaW9QAnw2xb0jkyhtvOPRluXo=
X-Google-Smtp-Source: AK7set+7KRAGVWv7u53lisKdJmZK7YsbzkRyOXJGQLoTktPLlGhyHTGqkcO/nEkhJUG7EkhdP4V77f40yrY=
X-Received: from sdalvi-android.chi.corp.google.com ([2620:15c:2:a:1808:5921:faf8:7a68])
 (user=sdalvi job=sendgmr) by 2002:a05:6902:4d4:b0:855:fa17:4f66 with SMTP id
 v20-20020a05690204d400b00855fa174f66mr4840916ybs.8.1677268693379; Fri, 24 Feb
 2023 11:58:13 -0800 (PST)
Date:   Fri, 24 Feb 2023 13:57:47 -0600
In-Reply-To: <20230224195749.818282-1-sdalvi@google.com>
Mime-Version: 1.0
References: <20230224195749.818282-1-sdalvi@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224195749.818282-3-sdalvi@google.com>
Subject: [PATCH v1 2/2] PCI: dwc: Skip waiting for link up on probe
From:   Sajid Dalvi <sdalvi@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sajid Dalvi <sdalvi@google.com>, kernel-team@android.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Root Complex is probed, the default behavior is to spin in a loop
waiting for the link to come up. In some systems the link is not brought up
during probe, but later in the context of an end-point turning on.

Call trace:
dw_pcie_wait_for_link << spins in a loop for 1 second
dw_pcie_host_init

Adding the snps,skip-wait-link-up property in the pcie device tree node
will skip this loop and save 1 second per interface on pcie probe for
systems that do not need to bring up the link this early in the boot
sequence.

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
Signed-off-by: Andrew Chant <achant@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3ab6ae3712c4..f5cba44ebf39 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -477,8 +477,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_free_msi;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	if (!of_property_read_bool(np, "snps,skip-wait-link-up"))
+		/* Ignore errors, the link may come up later */
+		dw_pcie_wait_for_link(pci);
 
 	bridge->sysdata = pp;
 
-- 
2.39.2.637.g21b0678d19-goog


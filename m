Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAE74DEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGJTxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGJTxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCAA1A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689018781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gy/vSNQrD1I/JzE/a01WIAugyPEbnbITAis3wuB31bs=;
        b=HvX1sBf5kEJGxH1Sa/AQ+hp9u/uXZLYBvCqSoKu8jeYbXTwUGW1UQOSg5+2w8EN00pz40n
        YOF4BIRqvvf6Vpn3GIhfaCJx8WbevXf2nW2R70puL206UUtUZ68zeDHRZCzkeAaaGhNIJF
        icjHNqwDqY2pC81FYm1LkpgK0M89REE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-agfIGAMAMTy55K1wS-4lrw-1; Mon, 10 Jul 2023 15:53:00 -0400
X-MC-Unique: agfIGAMAMTy55K1wS-4lrw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a3df1d46e5so3480162b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018779; x=1691610779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gy/vSNQrD1I/JzE/a01WIAugyPEbnbITAis3wuB31bs=;
        b=PdUlJypKU7lK3Mw2qLcRRs/GZa0dQW8OaGCs+RBdcX4sIf74cwN2mtzSdwU+/f0a7R
         ViKO1NQhbrSM6EIBobrB+Bez9cP5JeNIKO4Mzf5XR4LDZ9L9SrtaqqkwUhy3LqJZI4iF
         jXrn5aVMGrWlnewoUjdBEqWwW2ktSwaPfm2HAC0fVl/8WDT8zvsBNzgjqHff83tNCiGa
         TSsLDwJLhFll6iyQCZMBe0qawST7MZ+pL0AMWaG7OEVIqhfJCC1MGd+ZbGIRjcoDOb9Z
         y1mshMJR7ekrucm/7Qbgx+zF7ShMB/wigDIQLa4hoxScsP1rjiOB9TCmvSWjClW5PVzJ
         AC2Q==
X-Gm-Message-State: ABy/qLbjHjw8CDhEvKOLeypY46VXNmp+GZmIMsn9aZ1VCkea2hDzk21I
        8SDCXm01+sh2zKhOftTFPMObyKKKB6LNY4GdFm+HorTvPBhig+FVBEU5Jh/xqmbamHpy2noqGSG
        pd+1Nw5gO5ZOdmjl/nR9rV+O28pbaEtlrdDgfaRnPBu6d/UmAJi9+0K9IBCLuiGUD04ckbPS7zt
        sdWq/YWz0Z
X-Received: by 2002:a54:449a:0:b0:3a1:dd1e:a726 with SMTP id v26-20020a54449a000000b003a1dd1ea726mr9887213oiv.44.1689018779518;
        Mon, 10 Jul 2023 12:52:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfk5sAu+Gz4ewFF0ZgHQ4JXru7kUigoww2rD7ehqaN1ZIbUUPXVTG7Kygn3sRVlp5C3Ukyjg==
X-Received: by 2002:a54:449a:0:b0:3a1:dd1e:a726 with SMTP id v26-20020a54449a000000b003a1dd1ea726mr9887189oiv.44.1689018779163;
        Mon, 10 Jul 2023 12:52:59 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id r23-20020a544897000000b003a3d273aef8sm274972oic.6.2023.07.10.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:52:58 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next] MAINTAINERS: Add another mailing list for QUALCOMM ETHQOS ETHERNET DRIVER
Date:   Mon, 10 Jul 2023 14:50:57 -0500
Message-ID: <20230710195240.197047-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-arm-msm is the list most people subscribe to in order to receive
updates about Qualcomm related drivers. Make sure changes for the
Qualcomm ethernet driver make it there.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f115c355a41..e344af30e7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17541,6 +17541,7 @@ QUALCOMM ETHQOS ETHERNET DRIVER
 M:	Vinod Koul <vkoul@kernel.org>
 R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
 L:	netdev@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
-- 
2.41.0


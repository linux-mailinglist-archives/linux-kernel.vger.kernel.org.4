Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363FD6D2A47
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjCaVsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjCaVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A3923FEF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680299199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qACvXNoEnX2lVAx6UnLm5++0SRgSju5l/WpOwhVlX2M=;
        b=jT8f440HQf35EKUUohVzZIJcuCT7aw6iH4czxqguoMVwbjdl+6xikNDcVSi5f6J6AGg065
        D/VcAPuXtrWe6udnGcN0ZzKhjKjDvdRY8pG3O5WR4DJrMquViEUZvnoMNtnYiL2p2llpst
        UcYh5yuAO2CLRfnymVTM/GXUT69mXYg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-VJZsm2y3MhaIG4rU9JK3Hg-1; Fri, 31 Mar 2023 17:46:32 -0400
X-MC-Unique: VJZsm2y3MhaIG4rU9JK3Hg-1
Received: by mail-oi1-f198.google.com with SMTP id s63-20020acadb42000000b00388f0de0c51so5056138oig.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qACvXNoEnX2lVAx6UnLm5++0SRgSju5l/WpOwhVlX2M=;
        b=rs/mS25m6nFLI4nIyyVviEpwYq+74B09nwl3jjINRLGP8lgnEyuKdQGYSpfPpPxBjg
         pPIw34zMTFbstRMfIrFSasppmMg+0mCi9xFptfKCOvRlXE5rOnGA9QgSf9qAHWbiudgj
         GGDhGHxT/4MJv9dygHTi0aNXdlbwyYIphaRXCFO030JdH3lKiXmkER+WulY+CTLsvqFv
         CKF1ve+83LsZqjA8l9A+GklOrj0AP8S9uQqGeF2QDCifaEJsFwC+rFrPQGRiD8R2rcc9
         AYTqNuTnW2QclIsUsgi7OWxoj/5Mx8mbHqkBipB72ag5yRJzooXiaTZtqOPITef0VYnV
         DnrA==
X-Gm-Message-State: AO0yUKUwxemzvHAhRJxWc1rJTbd5GgK5tOVHIW1Gdra9ZA4hOf5Wfe5y
        ApmKJGYmSaEH6/N3GfsMs+e70lTnwAmuYqWy3J8Q132kvODXtHFXZbCcD6U5OsmU9hYQSgT4+nn
        jRrPhEQa7/ZEdVTVPrUDfDyKdOpriodjCiLZTQvxgh3kEYVKLeEymlSndeptzvAhtIZatW76tl9
        3/jao7EW/PA4o=
X-Received: by 2002:a4a:4185:0:b0:533:c6b7:27dc with SMTP id x127-20020a4a4185000000b00533c6b727dcmr12902183ooa.0.1680299191662;
        Fri, 31 Mar 2023 14:46:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set822UYJHwGM7owlnRUxqK6f0CJtFjIBd5BokBFZ7cUXSCSQ9eyAJDzp0jQbAnb0TfpNiU6TyQ==
X-Received: by 2002:a4a:4185:0:b0:533:c6b7:27dc with SMTP id x127-20020a4a4185000000b00533c6b727dcmr12902133ooa.0.1680299191225;
        Fri, 31 Mar 2023 14:46:31 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm1328531ooa.19.2023.03.31.14.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:46:30 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, mturquette@baylibre.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v3 06/12] net: stmmac: Fix DMA typo
Date:   Fri, 31 Mar 2023 16:45:43 -0500
Message-Id: <20230331214549.756660-7-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331214549.756660-1-ahalaney@redhat.com>
References: <20230331214549.756660-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

DAM is supposed to be DMA. Fix it to improve readability.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v2:
    * New patch, stumbled into this typo when refactoring

 drivers/net/ethernet/stmicro/stmmac/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 54bb072aeb2d..4ad692c4116c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -242,7 +242,7 @@ struct stmmac_safety_stats {
 
 #define SF_DMA_MODE 1		/* DMA STORE-AND-FORWARD Operation Mode */
 
-/* DAM HW feature register fields */
+/* DMA HW feature register fields */
 #define DMA_HW_FEAT_MIISEL	0x00000001	/* 10/100 Mbps Support */
 #define DMA_HW_FEAT_GMIISEL	0x00000002	/* 1000 Mbps Support */
 #define DMA_HW_FEAT_HDSEL	0x00000004	/* Half-Duplex Support */
-- 
2.39.2


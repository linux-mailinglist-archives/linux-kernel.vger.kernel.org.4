Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719BF6DE567
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjDKUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDKUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A592558B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681243503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWIvLHTbsZUrfZPZ+ixSWYku7exrmBkFXk3jbX419Vo=;
        b=IJgFgjs0IQ+hDKluqPisLKYLzbxO29r8wYgb0O64DUtifJv4iYZZl9rtivHvoVXi/Zf6++
        Whc6IGeEDTyuuYs8Nayzp5TA/DFLMULTHrxm4j3Paeu9N6Jhcwxve8/0YVX67szjrg7ykY
        XLrsgOmQC9zjdqshdzidnOVllPAUybc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-oKNT1hrWNA26yPgO8JD8_A-1; Tue, 11 Apr 2023 16:05:02 -0400
X-MC-Unique: oKNT1hrWNA26yPgO8JD8_A-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-184258b8a2eso5800096fac.21
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWIvLHTbsZUrfZPZ+ixSWYku7exrmBkFXk3jbX419Vo=;
        b=m7/mTzWdb+dGPR/c+XxZWw+rLjvWfor/VwUlTtll8WuX6meHF0WMG+c3m7VjS6mwEJ
         w1COFX1/YqrAenDXC9h9cQO6VwvUxXanthHikyEqyegXuhkkzwOLCh3pFFpGDqvm9HIT
         FHCreOJ7iLFaCdf77cVD3k1aLNqNGs5pjEKhQDVx7IGlh0dvbQmmPSODOuoDa+62mkf1
         6h0JnBHCmbwUUDbUOR8LrBtmREBAja2Pzdo5GJ0PwF03NdPM0/7oIFyKwo/amqUqk3/y
         3DQ6CirwvZiephtDTNnDgE/NWQ2xFNNd1IzlaT/6bUK+xa0K7WTF7qpsHzh1ZrnTdCYQ
         wjbg==
X-Gm-Message-State: AAQBX9cy/61ny3u6gqx0olXeBdyflhl1EGGgqDl6359TUChSWGrh539Y
        8hBpcV04QpodgJxmk+0icVc0/Qd0s7EzBNzx/V7jkrTeEOhmUNL33ipz5nF03U1ZL9BmUzB0TZy
        Sm/609PL6FYS1GBo9tiCpx9lZTYgn/pyryloVi2nvjinTT4WzrfYsvPDOn0D+xdR3k3cbquL2Tb
        zUlXt8hqYUxlw=
X-Received: by 2002:a05:6808:1823:b0:38b:973a:fe71 with SMTP id bh35-20020a056808182300b0038b973afe71mr6409952oib.40.1681243501289;
        Tue, 11 Apr 2023 13:05:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350b0cAvz42Qlls8WIYBkHt9iLwhpGWw1ZoYTxtNtior36S9BhWlnFImaPqwchjhbT2TqrxZ8rg==
X-Received: by 2002:a05:6808:1823:b0:38b:973a:fe71 with SMTP id bh35-20020a056808182300b0038b973afe71mr6409904oib.40.1681243500915;
        Tue, 11 Apr 2023 13:05:00 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id e20-20020a056808149400b00387764759a3sm5868545oiw.24.2023.04.11.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:05:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/12] net: stmmac: Fix DMA typo
Date:   Tue, 11 Apr 2023 15:04:03 -0500
Message-Id: <20230411200409.455355-7-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411200409.455355-1-ahalaney@redhat.com>
References: <20230411200409.455355-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Changes since v3:
    * None

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


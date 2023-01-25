Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE367BD49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjAYUqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjAYUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:45:57 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C45DC25
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:45:55 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h184so8999839iof.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwc/7+BF+Bdkf3+X8cSWATZteUuUtFlSqW/LGNAknug=;
        b=zmT4HI/OTixN9d27Nn8lmhh7KPUqTTBNaEdY6WgMJMogIG3+jETUBr3vYYc52FG5Pe
         zpa4B8JcHJjMe7FIHf62bOb8PAHQhCp6fOREdPaVfKuTOPlx0Hn+ATwGmrti6xh11t0g
         qHpboZBHWtC1YmgDU7mtWjVeACOB4RZ4WXlouYPwRFs1s3QJjeHciHMgZmBOtck38Gd9
         ukHaHy2tIvkhjIGkJ91rgXyPtmJZJ6S7O3wGhVe0aZ/rGwzAmz5xAXoDEI5tqhM71A/u
         q+Dgbxw/SUezTOGSWjdlC+6OwQTfIL9JvJ1u2tnBLGmxJkelchEU612+V68E7dJz5VwW
         fKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwc/7+BF+Bdkf3+X8cSWATZteUuUtFlSqW/LGNAknug=;
        b=mMwHPS1pOtjBCkBeyVlzbQNyUhaFnoGvOcT/ZtFmK8oILlSHOjucBHZXcWjPCGzDU3
         0U6uepHdhtXbDGO1RQkcCwrMJyYxWpQGb5emjNJGR5lRJIGWU+xvuwOgvdHGXRuZRgXS
         lAY6VCWYPKk2tDXdM0DM+Zj8gT6AgPakoT22nuWSLO6vZr9/wc4kpGOjzqv1PcQ5hm/w
         IYTGt7LS7tpXi5311nCXD4mH/LHHPQoOtASCQ1DvXDYa8J/j57CUZMsNn+xzqHjqtviq
         zlIZB1vqyh6eRXK3bsxWtdiU1Ik5K3iLff0iaYRSEgJ8pcXtJyU8h4SJL7mlMP+ACR1Y
         Jkbw==
X-Gm-Message-State: AFqh2krXNjDRolzctSbQ8UdxUHZ4n382ieT1oE9N2MJK1PjSTiHKxDHk
        3asb4aumijUPRs0BuIBDlkSEwQ==
X-Google-Smtp-Source: AMrXdXsuTb7h1Bqw8S2j7vgNCyDU2boq615Xwy0koE3VBkZlJulR7pKWVEplVw9TeSWTzqtI/UYGmQ==
X-Received: by 2002:a6b:6019:0:b0:704:cd00:ae4e with SMTP id r25-20020a6b6019000000b00704cd00ae4emr25777719iog.0.1674679554876;
        Wed, 25 Jan 2023 12:45:54 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id w14-20020a02968e000000b00389c2fe0f9dsm1960696jai.85.2023.01.25.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:45:54 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/8] net: ipa: define remaining IPA status field values
Date:   Wed, 25 Jan 2023 14:45:42 -0600
Message-Id: <20230125204545.3788155-6-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125204545.3788155-1-elder@linaro.org>
References: <20230125204545.3788155-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the remaining values for opcode and exception fields in the
IPA packet status structure.  Most of these values are powers-of-2,
suggesting they are meant to be used as bitmasks, but that is not
the case.  Add comments to be clear about this, and express the
values in decimal format.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 178934f131be5..ee3c29b1efea9 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -34,18 +34,31 @@
 
 #define IPA_ENDPOINT_RESET_AGGR_RETRY_MAX	3
 
-/** enum ipa_status_opcode - status element opcode hardware values */
-enum ipa_status_opcode {
-	IPA_STATUS_OPCODE_PACKET		= 0x01,
-	IPA_STATUS_OPCODE_DROPPED_PACKET	= 0x04,
-	IPA_STATUS_OPCODE_SUSPENDED_PACKET	= 0x08,
-	IPA_STATUS_OPCODE_PACKET_2ND_PASS	= 0x40,
+/** enum ipa_status_opcode - IPA status opcode field hardware values */
+enum ipa_status_opcode {				/* *Not* a bitmask */
+	IPA_STATUS_OPCODE_PACKET		= 1,
+	IPA_STATUS_OPCODE_NEW_RULE_PACKET	= 2,
+	IPA_STATUS_OPCODE_DROPPED_PACKET	= 4,
+	IPA_STATUS_OPCODE_SUSPENDED_PACKET	= 8,
+	IPA_STATUS_OPCODE_LOG			= 16,
+	IPA_STATUS_OPCODE_DCMP			= 32,
+	IPA_STATUS_OPCODE_PACKET_2ND_PASS	= 64,
 };
 
-/** enum ipa_status_exception - status element exception type */
-enum ipa_status_exception {
+/** enum ipa_status_exception - IPA status exception field hardware values */
+enum ipa_status_exception {				/* *Not* a bitmask */
 	/* 0 means no exception */
-	IPA_STATUS_EXCEPTION_DEAGGR		= 0x01,
+	IPA_STATUS_EXCEPTION_DEAGGR		= 1,
+	IPA_STATUS_EXCEPTION_IPTYPE		= 4,
+	IPA_STATUS_EXCEPTION_PACKET_LENGTH	= 8,
+	IPA_STATUS_EXCEPTION_FRAG_RULE_MISS	= 16,
+	IPA_STATUS_EXCEPTION_SW_FILTER		= 32,
+	IPA_STATUS_EXCEPTION_NAT		= 64,		/* IPv4 */
+	IPA_STATUS_EXCEPTION_IPV6_CONN_TRACK	= 64,		/* IPv6 */
+	IPA_STATUS_EXCEPTION_UC			= 128,
+	IPA_STATUS_EXCEPTION_INVALID_ENDPOINT	= 129,
+	IPA_STATUS_EXCEPTION_HEADER_INSERT	= 136,
+	IPA_STATUS_EXCEPTION_CHEKCSUM		= 229,
 };
 
 /** enum ipa_status_mask - IPA status mask field bitmask hardware values */
-- 
2.34.1


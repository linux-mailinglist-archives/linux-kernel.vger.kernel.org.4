Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F260F734
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiJ0M1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiJ0M0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:26:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C0144E18
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:26:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y143so461115iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh1EaQjT2Reomce8kVVBzGzrDBNIcwVObojZzaiEYwI=;
        b=Aoj+E+2QqQ3GfZknmX8bjYVVjTqTknVXBgtukTrN+IiQ4/sLUoSqr3DsM1gal3O6XR
         T6eGVNVcmHM0fV8NukcOgwGlPAyFjHwg3rKS7u+oR+8W5ouHPrWhVuzBeYc0iZrFrkH7
         +JYmZ27IfImAqHzt9l/Z1YdogztdX0IwCtYmf70OfcXy4DrvnC4ExQwaSDdr4XOqOdCc
         2uaUcxDg0OL7MSfaVGw7hOXCj/7KnPeVs0i16HOhpubwiJfSgGoF57+OZsmjKIuDZ+rU
         G+chfM0GPoN4ff1z1ufcy60NQNv2BGgNoKS3KQZMvyjwk7SUH3qKX3/qsrQLiM4NJYxS
         C+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh1EaQjT2Reomce8kVVBzGzrDBNIcwVObojZzaiEYwI=;
        b=i34CdbNvTEfUsEtlqtgQpAV6uRD+NDYEFzjsAiCYeKiNY5REoObgVlqIL+EItWZsDE
         y0G0s6C/2txUi2x/cyQ1ghSGAze18bkYb+fOatD466TAT1TzW4zIdhOd+/JbsjoukpmE
         8w96ylYQ8W8afEpp8OrRXqVjFJEA85VbAQp3LCp4cGl8SAj5Rnx5lKmVnI4Rf2muMTq7
         JhDugEhZqDyhKlqYBvuw4BAxiCuKjBm/uzuFruemrpsvLFI7lKhWfcgbybpgfU26TbC5
         z61KfO+uViaevnf/9Dl3qI5j5Kfd0FoAX/tag0kTjuwLr7nDUTPezYdTTpTN2M5h/Wz6
         NxVg==
X-Gm-Message-State: ACrzQf0HPmo5HM1fyGbJgFgJ9e7q6Om7tcFbAcwtuwWCrLrh2kqnDq0g
        hd7SuQ4ca2oRpTIpJMAbbEs+OQ==
X-Google-Smtp-Source: AMsMyM4fqCIVwfpp8JR3l3QjHc6SdWOigd6nFRNkyDpODhBKAwdNTUDyeG0MwO/3SIaj4r7JmL+ILw==
X-Received: by 2002:a05:6638:14cf:b0:365:c889:4285 with SMTP id l15-20020a05663814cf00b00365c8894285mr29372852jak.312.1666873604012;
        Thu, 27 Oct 2022 05:26:44 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id w24-20020a05663800d800b003566ff0eb13sm526528jao.34.2022.10.27.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:26:43 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, andersson@kernel.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: ipa: refactor endpoint loops
Date:   Thu, 27 Oct 2022 07:26:30 -0500
Message-Id: <20221027122632.488694-6-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027122632.488694-1-elder@linaro.org>
References: <20221027122632.488694-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change two functions that iterate over all endpoints to use while
loops, using "endpoint_id" as the index variables in both spots.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 6fc3cc6379fb0..740b2e4e0c50a 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -426,10 +426,10 @@ ipa_endpoint_program_suspend(struct ipa_endpoint *endpoint, bool enable)
  */
 void ipa_endpoint_modem_pause_all(struct ipa *ipa, bool enable)
 {
-	u32 endpoint_id;
+	u32 endpoint_id = 0;
 
-	for (endpoint_id = 0; endpoint_id < IPA_ENDPOINT_MAX; endpoint_id++) {
-		struct ipa_endpoint *endpoint = &ipa->endpoint[endpoint_id];
+	while (endpoint_id < IPA_ENDPOINT_MAX) {
+		struct ipa_endpoint *endpoint = &ipa->endpoint[endpoint_id++];
 
 		if (endpoint->ee_id != GSI_EE_MODEM)
 			continue;
@@ -1008,10 +1008,10 @@ static void ipa_endpoint_init_hol_block_disable(struct ipa_endpoint *endpoint)
 
 void ipa_endpoint_modem_hol_block_clear_all(struct ipa *ipa)
 {
-	u32 i;
+	u32 endpoint_id = 0;
 
-	for (i = 0; i < IPA_ENDPOINT_MAX; i++) {
-		struct ipa_endpoint *endpoint = &ipa->endpoint[i];
+	while (endpoint_id < IPA_ENDPOINT_MAX) {
+		struct ipa_endpoint *endpoint = &ipa->endpoint[endpoint_id++];
 
 		if (endpoint->toward_ipa || endpoint->ee_id != GSI_EE_MODEM)
 			continue;
-- 
2.34.1


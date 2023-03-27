Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5132F6CADD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjC0Ssj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC0Sse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:48:34 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397C310D3;
        Mon, 27 Mar 2023 11:48:31 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PlhfN3MCLz9t4q;
        Mon, 27 Mar 2023 20:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679942908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtgaKa7tkPxqeT7Z9b4tRUceRb1UfrPjsq/gzZvZwCQ=;
        b=M+p7+L5z+T0keWbGp512aYTvpEm0hcE9Rp36lqAVGX4SKpH+fzAOFWmehZkNwfoWzuUhbh
        exn8B4PIvV+HpaUnpD9FrGqI7lrLSEfWOwGJUU+jGru39mYRjgfvMwudICXPFdRk2ACIvF
        t1DcKzUptVM5kT7Sl7i4WrYadEB6QBZKEJQ4H2qejBua9+dhXIpytnVNMJGTd6kWRX64r3
        5exFBfMcRNlKJ0I5sGIcyKZogQcbWb+H5wkTWR4yFy/HwiM6FlpdjrGtcJ1ECVNDHFtfTI
        wh891gmJqtJDPylwtwFce8FLKVeyS76Jv1BhWVVnbmU44/Zw+EMvlNaBV+stdw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 2/5] dt-bindings: misc: qcom,fastrpc: allow FastRPC node without reg entry
Date:   Mon, 27 Mar 2023 20:48:08 +0200
Message-Id: <20230327184811.499553-3-me@dylanvanassche.be>
In-Reply-To: <20230327184811.499553-1-me@dylanvanassche.be>
References: <20230327184811.499553-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FastRPC nodes may exist without a registry property and actual
Compute Banks  in some cases such as the SLPI on the Qualcomm SDM845 SoC.
Relax the regex to allow such FastRPC nodes and remove 'reg' as a
required property.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 1ab9588cdd89..0ccd3296d4f2 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -64,7 +64,7 @@ properties:
     const: 0
 
 patternProperties:
-  "(compute-)?cb@[0-9]*$":
+  "(compute-)?cb(@[0-9]*)?$":
     type: object
 
     description: >
@@ -89,7 +89,6 @@ patternProperties:
 
     required:
       - compatible
-      - reg
 
     additionalProperties: false
 
-- 
2.39.2


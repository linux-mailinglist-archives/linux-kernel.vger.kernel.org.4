Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E867355D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjASKVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjASKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:21:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC43659A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:21:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 207so1111255pfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YwY5vS3vg7xhsUsIQ1VvphbeU2zwbR546RMoiQfbHEY=;
        b=Tc+2yp1WrmoViXm4dPlfBNSICNv0JpAie0IwZQUXdsjVquejy+neZNgWJx+GqAaxaI
         +6zK+ywgK3dz31I3tecgf0b6Pgt93e0PRQKpyAdGYOUVAa0yn7B0HTT5uY3vOjCZMpsJ
         4IMjOuTM7KZDPDl3E9V18jn5hMnfh8YLJqwraVN9mi8NaEc3EiH4c9S/kGdYgT4q221v
         EWm3mxV0BdqvROaNixmbT2uQnOLXoJYHKJm1e69JhQ0qvwNZrRb46iFRK0mq4r1ZBDzw
         nW2bUiouOaO10T1dTMv31pP2j1zMaY8ATrR4J7vJKoc1t8kofQqWagNuxHya/AbIm0pg
         vAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YwY5vS3vg7xhsUsIQ1VvphbeU2zwbR546RMoiQfbHEY=;
        b=K05YSAwngfFQ7uzJaZv7o/vUI3mOa+MOiSjW+ehpxV/jBHrgc7SdwT4GU7MSeoNq3R
         Dgl11aS/RW8PbyevCMqALmgFm1YSuk8zFMHVws8nMVKx1gx6jpsNxouwGS8gBf9kBJTk
         e9fgPrNsldeG3Pf4mDCQj8SH8inGWFAbDwjkD8vVZ7y5aT+EdGwoNHLAZ8tLRnFsfHiW
         GDdFdEjgnxv5agR7eqsRDMI6l3xGK/sOLMVir8qbHKhjYB9+KRx/iT5zlfo2Jbm2yLf2
         lTjTvxmeGy8+p3JLxOoawsy+sIEi2XpG2SxBaaDTITVBcEn8XE4ecPDJPBudBBYXZ5dd
         T22A==
X-Gm-Message-State: AFqh2koI6JA3o3fHFNS8ntaQKLb1A6egapX76PPj3WPZrn+1PMr3lghn
        JRcHbiFFfeLFFKHs1s8szZfeQzPVB3hDR4bvFUY9tF4O30HESk9DF/PwB+7CN1l13/0Vn1WJz2I
        4xr9ybOWC66adR+GzMw==
X-Google-Smtp-Source: AMrXdXsyIVr3tw3q7AVX+IjP5WhJgBo5ZUYUE2UtmdhLVrNJOfSaH0vYrz7OwqoeSFOtS2ucaxBPuw==
X-Received: by 2002:a05:6a00:1d9c:b0:58d:90d2:8b12 with SMTP id z28-20020a056a001d9c00b0058d90d28b12mr11019916pfw.3.1674123669937;
        Thu, 19 Jan 2023 02:21:09 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b00580d25a2bb2sm19152964pfb.108.2023.01.19.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:21:09 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH 0/3] Add Ufispace NCPLite platform device tree
Date:   Thu, 19 Jan 2023 18:20:59 +0800
Message-Id: <20230119102102.73414-1-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ufispace NCPLite platform device tree, and add the compatible
string in dt-bindings files.

Jordan Chang (3):
  dt-bindings: vendor-prefixes: Add prefix for Ufi Space
  dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
  ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 360 ++++++++++++++++++
 4 files changed, 364 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

-- 
2.39.0


-- 
******************************
This e-mail is confidential. If you are not 
the intended recipient, you must not disclose, distribute or use the 
information in it as this could be a breach of confidentiality.If you have 
received this message in error, please advise us immediately by return 
e-mail and delete the document. The address from which this message has 
been sent is strictly for business mail only and the company reserves the 
right to monitor the contents of communications and take action where and 
when it is deemed necessary.
Thank you for your co-operation.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43674623E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKJJLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKJJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:11:02 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0067CFD32
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:11:00 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t10so734030ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K05Ia4tp78SlX7BxYQJ/FemIfvNEVytxmmG9tyvodHU=;
        b=ymlFC8TgZ7JYvVyJFGfznJj1TTfPsvTMoF0Te79bDg8Ade7SMhYWlz5eTJlxqNVTms
         A3INStiLkJkjRQrmbbotWOIEEVYSFgnF+/ntuMd2RiI4Ug3MLXZE/smGtdxq9p5qSLmi
         zRwvqIZ8jjjk5SrRN7ZtssMNGWq+qnC+XRC9U/kz6p+JovGWzgncUmiv5rikQM9+yXwp
         /B7wOACSpTAvVc6sO3YurqHjP2DTwv33M8k/BYL1RVe2mfHMnbmu6doAxJ8ApFyC1ELz
         PQxHEdsbgXalxmt2KVnPnPK+zMaF+o4fq0IDRE1zB1sq+U758SaqOI3LaEMDAjr8R/Ef
         yKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K05Ia4tp78SlX7BxYQJ/FemIfvNEVytxmmG9tyvodHU=;
        b=eA2SyNciEtuRilrtUUdU3BuwH7Rw7GKIrfMNRgLYPVhZhuV+sVg1VuhPNXxBUWY+iu
         AgJhIn/vKxt0CmoLVbAxS2E+rnx6CS1a1jT5DP/TOvQ+4Qx6POfWeo9g2DsQH8QduuHF
         3Z/08Rdx9nDRd4+Htef3GXh3TaNjfX2/XCfdKW/yfs1g6ZlcWSTELstOIG8v2OAiqehG
         bs/as/+sw6h/26vzxhJIEuWXbyzl44I+ws85Kw3UAdacsMBIhIwr1wxh2Esi2rWbXPUu
         6P1fUAavsvm5k9nW+5RdrTJq5PfK8FCGlUhldVMgC+hwOUMVUEOYY4gu6kfzTeRTQLNX
         byJA==
X-Gm-Message-State: ACrzQf0axlAqdB6cXPTAYv07rI+SI8RGZCb4JH6vEGB60kyw54b2RGlq
        TsLLyxPjwTVZgCnyogYhOxxdMg==
X-Google-Smtp-Source: AMsMyM7oGN4asYaOfnSRe0f4BvYXsNs5BQWOc0jQJnH3HO4Od9H7BEVJqIwmBdvqrknuEVmhEGdCqQ==
X-Received: by 2002:a2e:956:0:b0:277:35ca:5f01 with SMTP id 83-20020a2e0956000000b0027735ca5f01mr8763802ljj.214.1668071459221;
        Thu, 10 Nov 2022 01:10:59 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512324a00b004afc1607130sm2658713lfr.8.2022.11.10.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:10:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Robert Richter <rric@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        James Morse <james.morse@arm.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        devicetree@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v6 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
Date:   Thu, 10 Nov 2022 10:10:55 +0100
Message-Id: <166807145377.16822.1334581217853971870.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com> <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 2 Nov 2022 12:36:54 +0530, Sai Krishna Potthuri wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add bindings for Xilinx ZynqMP OCM controller.
> 
> 

Applied, thanks!

[1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM
      https://git.kernel.org/krzk/linux-mem-ctrl/c/efd1547170c3b153f161c293fc11b9fe2f1ece01

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

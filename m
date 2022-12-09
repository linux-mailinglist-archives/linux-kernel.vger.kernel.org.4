Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABDE648A49
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLIVr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:47:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3F3D381
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:47:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w15so6510483wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pj6fEio9GMBTTHsUKN327d/y8NUqAks43uKCHfaSmLs=;
        b=mb7tWCrLDmGYT7t7An9lV/NQSe5kR86hqGck0z3DNpPW2s5TFbhTfFXPMl0Py1AhyX
         AMo/QqJ96mnXlc6/NBvNArZCm4E7CMwaPH69HBD3Ny9kjJmXXDeJAQP+K2W25ByJ2IU8
         wkosx5IA2cacD6ljCsoGU+fUHUqLyUVkd2AFQJv8ap4BSxGsLrMMxm3UjI3kUxqf++uo
         AzLN83n1YIqtDDC/B8wzFKMianEZcMcYbLxP7N+mLfTBDOkYKy7hGXiJHzVHXZOcEQFL
         jXYFLdfuWRcfsdjhzVrsXZOGZbDlMVrxx4CJkjpZPt1d7wq9VGKLpDLfAvXaZvROurMp
         bjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pj6fEio9GMBTTHsUKN327d/y8NUqAks43uKCHfaSmLs=;
        b=0NmpWWryJON4uPHm2jl+D4HJko+l8XIoTLVwBIDxihJq4aCUigYi2huoAB5NCr6EPP
         gHGG9bHudUUjF2v8ZJJP7JR3fuZut+h2u8V3IMKEIE5v8OFP3CIz+HZCxZ8VrC/hqwS8
         n6/odyUc40OAtGY6XHAl28XpFgj77zlsywLP6zK8Fwp6mOwu2UdS/ERD/z1Xe+c0tw3t
         Oz90JAWPqOPyeGki+cqfitKQp0nvfG1be2rY+EIxPaubjKT1V7kUbIB/VtKQrpvBAhFK
         0+rUoKgZ+pQPGjq+p3sUV7oaSbocRo9XhLC1dOSmF1kDpPVbLS8nla8mSUAtiAHFIi8n
         gIkg==
X-Gm-Message-State: ANoB5pnc/gT1d76jtrzVccddOS13jZNWGNSFK6JQBqeXG55rwGAqewN+
        23YB3o89mJo1Z9hlNAAjttphL4DuOx4sRniAve5gGdbDew5GlA==
X-Google-Smtp-Source: AA0mqf50J+hdEGZmzaZ153eaZiupzCfzw+lwtn2Qm4b+RxM9vYWB6RlKrtHhNZn1USVCgSoyEMyfwgd1oHHcf5usDrI=
X-Received: by 2002:adf:fd03:0:b0:242:5361:54ee with SMTP id
 e3-20020adffd03000000b00242536154eemr12633940wrr.667.1670622440325; Fri, 09
 Dec 2022 13:47:20 -0800 (PST)
MIME-Version: 1.0
From:   davide rossetti <davide.rossetti@gmail.com>
Date:   Fri, 9 Dec 2022 13:47:08 -0800
Message-ID: <CAPSaadwWXXF3N4BaUYS_Aqas27eqNX+mcx3a7MnohqPy7+--ug@mail.gmail.com>
Subject: dma_to_phys on Intel CC platforms
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

looking at https://elixir.bootlin.com/linux/v6.1-rc8/source/include/linux/dma-direct.h#L86,
it looks like it assume the AMD CC convention, i.e. CC bit set means
encrypted:

static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
{
phys_addr_t paddr;

if (dev->dma_range_map)
paddr = translate_dma_to_phys(dev, dma_addr);
else
paddr = dma_addr;

return __sme_clr(paddr);
}

What guarantees that this works on Intel too?

-- 
sincerely,
d.

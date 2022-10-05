Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2445F53E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJELqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJELp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:45:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3EE7A52F;
        Wed,  5 Oct 2022 04:44:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so1906618wmb.0;
        Wed, 05 Oct 2022 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6JO1askOXv3fIRom3nLLKljILvMiIWCZXOL0gCR+zI=;
        b=Wc8WRlG+WpW8mbJvGsJThiHj1HY0CcYuGKBnatg6+VXXQi3avdhmYgTfOe3XPQAcY7
         I/JLrMiFquIOHeVyojQCB7iwK71vi1HkS7r2JM46K/HiaK0rYukCIhxzlO4R5sb0j/NB
         cAQ1owdKdxK3SaU4jfpOkhuphZUT1GwKDK+j7jou0ujCPuSoxkr6wKBAak22bMFVHydB
         asvpTNDz5gNPWcXeELDQV2bhdW3+FfJzQqOS+lLyu5Tp6+w0ne0v5XK0iipYT9cLSutr
         xtAN7myNx3rNfc3gEK9iOWxyQjAoT2zw2XL661qkxCw8sFgab0k0FrBsgtbBQOTi4oh9
         iC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6JO1askOXv3fIRom3nLLKljILvMiIWCZXOL0gCR+zI=;
        b=D5pTYbgsqx+wwJJXuVwGBA70Jj7ubuLlEckqxuhMPHZVCvmHusPhzyl/Nn0AzqBfKZ
         sxDsVFHcEkJvi4nio5MMDNQod+8bOVT2XFX58aM9ElycP/FLT/qWQEWkIUnA7YwSI8pH
         UQhtGJI/LrJ4HEtNJ8CqWZv8uTqmB5BVp4/PCKmdXL7WNoJEOGSGK7l6Zo2pcCoL8m72
         7JweTQ0+LjWqe2U2JsWpmPZNwte3s8oxJC+oFyEDB9ASYGq2lohj6vCGtsWVr6SWfTga
         3UAW0wPHIBMrNxTNeKHgkWEIkJRUZssOpLAhJFCqBOQb7aefKv8yFXV51XgDOu/z4uzT
         D/MA==
X-Gm-Message-State: ACrzQf0GGT6HuYJNORWw8Ig/9qijVEtXGNbiog3g9yuXy0wwqNVcYkaP
        rVCerVR05vX/BjtbR0y4+p+iaRu/fys=
X-Google-Smtp-Source: AMsMyM6kySg7JhOnbqTNzF3k0OyNUxybSz4HxCID9n6Z9GWv0v0/EuIV6zyBPaOH+zhl/XtyQ8wAPQ==
X-Received: by 2002:a05:600c:1c84:b0:3b3:ef37:afd3 with SMTP id k4-20020a05600c1c8400b003b3ef37afd3mr2874007wms.155.1664970220260;
        Wed, 05 Oct 2022 04:43:40 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id z12-20020a05600c220c00b003a63a3b55c3sm1631689wml.14.2022.10.05.04.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:43:39 -0700 (PDT)
Date:   Wed, 5 Oct 2022 12:43:38 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: build failure of next-20221005 due to 4078ec1ef5ed ("LoongArch: Use
 TLB for ioremap()")
Message-ID: <Yz1t6rPLOzKT8Id+@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The builds of loongarch allmodconfig have failed to build next-20221005
with errors

sound/soc/mediatek/common/mtk-btcvsd.c: In function 'mtk_btcvsd_snd_remove':
sound/soc/mediatek/common/mtk-btcvsd.c:1394:32: error: unused variable 'btcvsd' [-Werror=unused-variable]
 1394 |         struct mtk_btcvsd_snd *btcvsd = dev_get_drvdata(&pdev->dev);
      |                                ^~~~~~


sound/soc/sof/intel/hda.c: In function 'hda_dsp_remove':
sound/soc/sof/intel/hda.c:1185:26: error: unused variable 'bus' [-Werror=unused-variable]
 1185 |         struct hdac_bus *bus = sof_to_bus(sdev);
      |                          ^~~


drivers/mfd/asic3.c: In function 'asic3_mfd_remove':
drivers/mfd/asic3.c:940:23: error: unused variable 'asic' [-Werror=unused-variable]
  940 |         struct asic3 *asic = platform_get_drvdata(pdev);
      |                       ^~~~


drivers/gpu/drm/exynos/exynos7_drm_decon.c: In function 'decon_remove':
drivers/gpu/drm/exynos/exynos7_drm_decon.c:771:31: error: unused variable 'ctx' [-Werror=unused-variable]
  771 |         struct decon_context *ctx = dev_get_drvdata(&pdev->dev);
      |               


git bisect pointed to 4078ec1ef5ed ("LoongArch: Use TLB for ioremap()")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip

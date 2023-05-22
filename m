Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE7670B560
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjEVGv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjEVGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:51:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F97C2728
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:48:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso9349855e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738064; x=1687330064;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpcVzZiQHuJlgNB+1GZ1+0T8mFu8yvELdw33UYkkLl8=;
        b=MhTrOuJMVD/4Pr15dj2MrRWhZPx0is3SfH6Ud6YRvaJxvKiUbbEC7CTqI/Q5+iMV1b
         XxxxSMSIWXe8jdGA2HUktG9hQAPY6LJBIklBVlzrf3IahiQyJxZPIB1XvjrBLr6w8pbu
         jC+xl8sGfRJ+KzUC9kj/iPDhdBXIuMIOwR2dAacfsEGCMIDwc3clIxy3UeCWM5DptFTs
         NBbh0hnEQdkA0Iqa8fBYEvvSiwDTBL601lXW4etNKf3nXesfrtuUBnhhNwaT3l1tLP7c
         5xbiOibZ9X0v8dxTtb9dE9Kx/ViuFGrSX0er5Qug2HQumyMaVpTEHNF6jl/14dUUB1T4
         9KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738064; x=1687330064;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpcVzZiQHuJlgNB+1GZ1+0T8mFu8yvELdw33UYkkLl8=;
        b=K69doaV3rDJd7gEZ5txI+GSd+HB7f7hw64Qb8mCfJNqK8Z7ZG+Z4m0mfskMWG+LEUs
         B93WIEGC4e67qIID1OyJdOEehqv2Bbs9UVTr5U9BiU2td/zyypQPN3tokM94KoOeKm91
         SWW7rL18HS0AUZHfJXRdX1nqS9J0IeTh76TZiqdNTnIZFDRi73molW/o41hnZgrZ0vBL
         QEav6mbM+Zx8XFMKD0AKbR8w1hkgvP3QdlTkxm+e+n7Gxq8k4LgbnCYzpZo2ypjZZ+yF
         M7BiSIB64mhyBd7bN2Ejr96LCRKhIbsLH4CYlL6mdqfGuL9MLDjpwcNTTVweERObrH2B
         85XQ==
X-Gm-Message-State: AC+VfDw0eF+vP6vzTXyTZ6y4ZTnsFwtgyOdy+g81gmlxU/4mTufCcBrX
        U7pZbTlz4jqjbaTVplrk5yRgCKLUgUwC4fxa9v0=
X-Google-Smtp-Source: ACHHUZ61taaEnFgdPu7bLIwWViZ4oSt5EKj2mxSI/JiWU2FHciOor4L9SkuxyH8S00xOAaiKFcGkXw==
X-Received: by 2002:a05:600c:281:b0:3f6:41d:24d2 with SMTP id 1-20020a05600c028100b003f6041d24d2mr1546520wmk.39.1684738063644;
        Sun, 21 May 2023 23:47:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c22c400b003f4e47c6504sm10440588wmg.21.2023.05.21.23.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:47:42 -0700 (PDT)
Date:   Mon, 22 May 2023 09:47:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Wenjing Liu <wenjing.liu@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:384
 construct_phy() warn: variable dereferenced before check 'link->link_enc'
 (see line 381)
Message-ID: <aa1f09b5-4e29-48af-8b97-831115a7b682@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d635f6cc934bcd467c5d67148ece74632fd96abf
commit: 76f5dc40ebb188b081e03783541856c03e97f8e0 drm/amd/display: move dc_link functions in link root folder to dc_link_exports
config: ia64-randconfig-m041-20230514
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305201930.FVPVEaPp-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:384 construct_phy() warn: variable dereferenced before check 'link->link_enc' (see line 381)

vim +384 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c

54618888d1ea7a Wenjing Liu    2023-01-18  367  	enc_init_data.ctx = dc_ctx;
54618888d1ea7a Wenjing Liu    2023-01-18  368  	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
54618888d1ea7a Wenjing Liu    2023-01-18  369  			      &enc_init_data.encoder);
54618888d1ea7a Wenjing Liu    2023-01-18  370  	enc_init_data.connector = link->link_id;
54618888d1ea7a Wenjing Liu    2023-01-18  371  	enc_init_data.channel = get_ddc_line(link);
54618888d1ea7a Wenjing Liu    2023-01-18  372  	enc_init_data.hpd_source = get_hpd_line(link);
54618888d1ea7a Wenjing Liu    2023-01-18  373  
54618888d1ea7a Wenjing Liu    2023-01-18  374  	link->hpd_src = enc_init_data.hpd_source;
54618888d1ea7a Wenjing Liu    2023-01-18  375  
54618888d1ea7a Wenjing Liu    2023-01-18  376  	enc_init_data.transmitter =
54618888d1ea7a Wenjing Liu    2023-01-18  377  		translate_encoder_to_transmitter(enc_init_data.encoder);
54618888d1ea7a Wenjing Liu    2023-01-18  378  	link->link_enc =
54618888d1ea7a Wenjing Liu    2023-01-18  379  		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
54618888d1ea7a Wenjing Liu    2023-01-18  380  
54618888d1ea7a Wenjing Liu    2023-01-18 @381  	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
                                                                                                 ^^^^^^^^^^^^^^^^
Dereference

54618888d1ea7a Wenjing Liu    2023-01-18  382  	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
                                                                                                    ^^^^^^^^^^^^^^^^
Here too.

54618888d1ea7a Wenjing Liu    2023-01-18  383  
54618888d1ea7a Wenjing Liu    2023-01-18 @384  	if (!link->link_enc) {
                                                     ^^^^^^^^^^^^^^
NULL checked too late.


54618888d1ea7a Wenjing Liu    2023-01-18  385  		DC_ERROR("Failed to create link encoder!\n");
54618888d1ea7a Wenjing Liu    2023-01-18  386  		goto link_enc_create_fail;
54618888d1ea7a Wenjing Liu    2023-01-18  387  	}
54618888d1ea7a Wenjing Liu    2023-01-18  388  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


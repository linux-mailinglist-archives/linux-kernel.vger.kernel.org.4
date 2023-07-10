Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA8674CCA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjGJGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGJGIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:08:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7CFA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:08:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so45625805e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688969313; x=1691561313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SVhLr95VKg7glfqsuHxNHjzeVCLSq/G/5K7c2rnENU=;
        b=v25DDkqIvucSEnkVDBb88JM62u6UhxMQmhQEFtBnnepd5N01xMl0aZZVn6408Mc+Lw
         EFk7fZY6ZcEQk23n4bad7oobs3z43ET/5TOUpQYiKV3TExv0Sl2RvoRjLmyDn3uJAEMR
         iJ1Y8GLCpUMkEmnzpAzlxQfEL4/5GRMZ61m03oOd0P9sIYjwxLnfmhV3kgMagrlCMVxe
         BWmdvCcBx5yeF2EjT5bhkQcLc+t2EMDaULwR9sUI5uajclE+BbbyNM5ASzl/OW8UA0fY
         LlYmv7/OZg1goHL8cROLX+UMOCCmx3Rt7Iq2Vi5Vqjh+nM6oel3ayJ1lV8cVlz/oHDjy
         E+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688969313; x=1691561313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SVhLr95VKg7glfqsuHxNHjzeVCLSq/G/5K7c2rnENU=;
        b=fKVtkhwU4AwzAkKld46HWrOGSBNjtp79MY8O9U9EzzYI4fTSqiDklzYC/BU2EZr/lj
         z1JPpSRbWjtJf8viVdX/9qtnEMnvjGbfAkMA8PmBLMw1SI89VC8swcg1QrVq8soBApUC
         GqmkK2CNU8uj/0Vn5KLx1tvcJaKitUYil7oj6vrN+xr15bh6I9+9sph+taaTorIP0pLm
         fzXfCBFCDH7EN2Lw951WgpnxFCR3JsKoa16WxW3B46TIs+W4wusIdp5JNlUPAqVnCcQ/
         U5cVmWHstuz+PIHzgmt8mBX0najMYbQX16O6U0otFK9Dex3b8ZLlwFAPnNyp4BGOUqs1
         mdJw==
X-Gm-Message-State: ABy/qLYRK/AeoabwZj/HCGLI1nUQvKiQ3LMprkpBUeXo0xEw+owFxSzI
        2uIgg8UtPVRy+YRSsoOX8LQcuhzzLZdYQppehLM=
X-Google-Smtp-Source: APBJJlGNV916/RhwLEjTgvYReVMDbcpN8czCnegfqCUHKHwq3DJsXoz6Rt5Ff9q1Mo7Gh3MrEVA4Sw==
X-Received: by 2002:a1c:4b0a:0:b0:3fb:d1db:545b with SMTP id y10-20020a1c4b0a000000b003fbd1db545bmr10833003wma.20.1688969312699;
        Sun, 09 Jul 2023 23:08:32 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z19-20020a1c4c13000000b003fbcdba1a63sm9235567wmf.12.2023.07.09.23.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:08:30 -0700 (PDT)
Date:   Mon, 10 Jul 2023 09:08:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     gregkh@linuxfoundation.org, error27@gmail.com, xu.panda@zte.com.cn,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: potential buffer overflow in
 ks_wlan_set_encode_ext()
Message-ID: <fb7fac70-1d81-4dee-97ed-66c6a58720ca@kadam.mountain>
References: <tencent_5153B668C0283CAA15AA518325346E026A09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5153B668C0283CAA15AA518325346E026A09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 01:50:07PM +0800, Zhang Shurong wrote:
> The "exc->key_len" is a u16 that comes from the user.  If it's over
> IW_ENCODING_TOKEN_MAX (64) that could lead to memory corruption.
> 
> Fixes: b121d84882b9 ("staging: ks7010: simplify calls to memcpy()")
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29664847C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLIPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLIPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:00:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C082FBF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:00:36 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t17so12159554eju.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XM+NqmxrxOKrO4r+GSXeVhiB6LxMM8JdlBchVd7ou2E=;
        b=Z4bJJ5D07ymwN7yZwDI+yQY6muJ26z5kaTTsBIA9nIpmv9YHxKP5my1w+vR3CqL2Yl
         3mhQtjaEKr1osJK0OJ13vs6zgdwbF95byFuVJ1eHisdwKxPuBWaY5k5CvIo/ApsyTPtZ
         JqsuhYS/w8QedHvQPe3le38qF808M2PXx3Zc5U3QJzDCWlwZeUYf8t2NGKK60lUz0jy/
         c8gU4C+u/FIHkeuFyesZRk0ma+UU7Ism3zwNZLAHz6VwWuWL7qbCBtCs9mcpxGXR6vva
         x5H0ip2xjymAkayzdxxGlElhslnuVwKEfbEJmZ4vBUqiJq3y1EQZnSqpz5ln8lDGyAeJ
         yPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM+NqmxrxOKrO4r+GSXeVhiB6LxMM8JdlBchVd7ou2E=;
        b=qA56603P/rCukXBP+eCBdShepYbUm78zawKit1dx3L9dIQaBd5C1q9TpxiSeLUH8mz
         dxojJXRijuUeGrvmY7NRpCSZjcLD5ods1/bFpt8r1FZ7FvX4QpP95C2DsKqAFAd5mGPx
         3RBl2SxXDum8kYCeGYjpaAobpqzIaavYIvVMYbhYRtVX1YpGiEQprWBHIW57Rwq62lxW
         OFvZKeZJgxpdAoTFTiQFqpB8fJZ6/+RwxCWHVpCfbVhX487WBstFAOoUZJL4PZ4m6fNV
         tbGlPOFlWW6qdEmjbS2CYrg/us8Xgso5fEYOr1iQnPHcQErpg9J86BxXFVpwyhL/QXjg
         lCsw==
X-Gm-Message-State: ANoB5pnghEuoywyPItzW9W8PV+XzwlJBke+zHpZ/ybMG2bweMA7UUF+q
        4jtKy15JtdVa8jzTM+5D+Sz7UTDagg==
X-Google-Smtp-Source: AA0mqf4gzYNe84jvdh3Gqbqlu4tIC/P0Bazvy6ZGU3s/Pif3jvrceMWn70eycIPkxzTiCx9hMNLuXg==
X-Received: by 2002:a17:906:a1d2:b0:78d:f459:7181 with SMTP id bx18-20020a170906a1d200b0078df4597181mr7780568ejb.44.1670598034920;
        Fri, 09 Dec 2022 07:00:34 -0800 (PST)
Received: from p183 ([46.53.254.142])
        by smtp.gmail.com with ESMTPSA id ss2-20020a170907c00200b007c100eba66asm8508ejc.77.2022.12.09.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 07:00:34 -0800 (PST)
Date:   Fri, 9 Dec 2022 18:00:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     security@kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>, adobriyan@gmail.com
Subject: No CVE-2022-39842 aka int/size_t confusion in pxa3xx_gcu_write()
Message-ID: <Y5NNkAoZRY+UlWaf@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

> From a09d2d00af53b43c6f11e6ab3cb58443c2cac8a7 Mon Sep 17 00:00:00 2001
> From: Hyunwoo Kim <imv4bel@gmail.com>
> Date: Mon, 20 Jun 2022 07:17:46 -0700
> Subject: [PATCH 1/1] video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
> 
> In pxa3xx_gcu_write, a count parameter of type size_t is passed to words of
> type int.  Then, copy_from_user() may cause a heap overflow because it is used
> as the third argument of copy_from_user().
> 
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
>  	struct pxa3xx_gcu_batch	*buffer;
>  	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
>  
> -	int words = count / 4;
> +	size_t words = count / 4;
>  
>  	/* Does not need to be atomic. There's a lock in user space,
>  	 * but anyhow, this is just for statistics. */

This patch is predicated on the fact that struct file_operations::write
may accept arbitrary "size_t count" values" which is not true:

	ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
	{
		...
		if (count > MAX_RW_COUNT)
	                count =  MAX_RW_COUNT;

This check clamps everything at "INT_MAX & ~PAGE_MASK" which is within int
value range so it can be divided and multiplied back just fine.

Another thing, on x86_64 copy_from_user/copy_to_user() _real_ signature is

	unsigned long copy_user_generic(void *, const void *, unsigned !!!)

Note how "unsigned long len" becomes just "unsigned int len" right when you
are tired to follow the callchain. Assembly does "movl %edx, %ecx" and other
32-bit things.

So... No CVE?

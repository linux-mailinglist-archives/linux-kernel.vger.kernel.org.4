Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A525714795
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjE2KAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjE2J7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:59:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC2AB5
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:59:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so1003703f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685354387; x=1687946387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0RbtsRS6lbAOQy47hVSuc0QHPvxMe8cs0M24teto58A=;
        b=Ar8P7xtKnNKUt0knv8le9zAvdKRj27Cvtv7ZwbskI179t5uZMfOQhHuk592athm+ri
         ZdTuvunZryKu+Qpew7V2uBzZ1FpW+DpOJEVFHoc1hvyVz5uraOqDf4EtY0pciNcEWx8u
         8wF20n7Ea78TOuKaYZMa/v3q4/sc/0wofWPzeBqIe5kULcrKSy7OnWbyLw9MA514QeIB
         rjrNsUlNbnDOu92a7M5CxVt/z+k6uZDWcjPErmwFK+riwoOhk7O23NW4CT6abtK6SKSX
         IcusyAGkO/jI1UIidgzZbHYwLU53fjoDaSQk4VFtpuRjNW00fiFWLujq8yA9Ex+tBnF/
         eevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685354387; x=1687946387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbtsRS6lbAOQy47hVSuc0QHPvxMe8cs0M24teto58A=;
        b=Eo5n7gHhr45pCOhPTI42ZNUZkpT2QX9Qd1RmRAj+51i6kWMi3mXqbsMbj/kqvgwT9t
         fgTblMaPh72BmKPfsHYHa3nbEN9QXyWIvWbyB4ooWTkwwjY8uILacVDcFzDP0kjwwxTD
         0COgF28jr3zh+ZOEc/wWliQNW+54NxCRYZcLy/3b8KNELJ4Ruay6FS3T7IdE7DiA5NLP
         h7P4FMrXR882TSj9u+HCnYhh64AsVvzIAPeTi0h5pkao5chJrGw7sZ+NZyF6f81d/s5s
         tt1TImNZxmjlO2tXAE5mDGcWnSy+j8o+uXm+Tsqj3wJQgt/Z6A5RseScnpvIfBfqgwf+
         3erw==
X-Gm-Message-State: AC+VfDx2ZafuP+hMxOTAvj32IHZN8t4exyK/elcenyZZs7WLIpoN47BZ
        kjVtUJQ9vSZRGGJ1uHtuPRNanA==
X-Google-Smtp-Source: ACHHUZ6Fxfkt4PsVueAZ/VALeISHrqvtKqFYDfSWj7GtiFgGIcrwnSSR9flweNKYso6Ajst40PL9Qg==
X-Received: by 2002:a05:6000:1a43:b0:30a:dcba:2d81 with SMTP id t3-20020a0560001a4300b0030adcba2d81mr7785541wry.38.1685354387450;
        Mon, 29 May 2023 02:59:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6781000000b002fae7408544sm13150275wru.108.2023.05.29.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 02:59:45 -0700 (PDT)
Date:   Mon, 29 May 2023 12:59:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: xilinx: Fix a memory leak in zynqmp_pm_remove()
Message-ID: <8355a10b-e365-485f-810f-0c3001a0406a@kili.mountain>
References: <93ef923496b6c45a0baa59458099aed3a20b771a.1685346792.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93ef923496b6c45a0baa59458099aed3a20b771a.1685346792.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 09:53:24AM +0200, Christophe JAILLET wrote:
> 'rx_chan' is known to be NULL here.
> Reverse the logic to free the mbox if it has been allocated.
> 
> Fixes: ffdbae28d9d1 ("drivers: soc: xilinx: Use mailbox IPI callback")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> 'rx_chan' may be NULL, but mbox_free_channel() handles it.
> Maybe it is more informative to keep a (useless) "if (rx_chan)" to tell
> that it may not be allocated.
> 
> 
> On my machine, compilation fails with gcc (Ubuntu 12.1.0-2ubuntu1~22.04):
> 
>   CC      drivers/soc/xilinx/zynqmp_power.o
> drivers/soc/xilinx/zynqmp_power.c: In function ‘zynqmp_pm_probe’:
> drivers/soc/xilinx/zynqmp_power.c:193:12: error: ‘pm_api_version’ is used uninitialized [-Werror=uninitialized]
>   193 |         if (pm_api_version < ZYNQMP_PM_VERSION)
>       |            ^
> drivers/soc/xilinx/zynqmp_power.c:187:13: note: ‘pm_api_version’ was declared here
>   187 |         u32 pm_api_version;
>       |             ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> I think that this warning is bogus and gcc is wrong.
> 
> But I don't know what to do with it :/
> Anyway, it is un-realated to this patch.

I bet GCC is correct.

Do you have CONFIG_ZYNQMP_FIRMWARE enabled in your .config?  This driver
can only be compiled with that enabled, but I've seen some of your
other patches depend on CONFIG_BROKEN so I think you're going outside of
the Kconfig rules.

regards,
dan carpenter


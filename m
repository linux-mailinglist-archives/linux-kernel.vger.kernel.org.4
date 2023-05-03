Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1B6F51CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjECHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjECHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:36:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E940FD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:36:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so29188935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1683099362; x=1685691362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJV74MDW5y+ACVn3WrwP3elljkzjXGgh8VAriWHOGeU=;
        b=oRTVtBH8IYjN1lZYq9pa8LDdL/WzfkKlBG88g6SiHg2KoWXgvSrP85lRErVAZH5GED
         XBZwfbCNrlYtuQ6walbqhauG/y8NSiv29JvivN2qWePFu572bX6inRsHgCZsgYnEQqxG
         z1dx3MjfbfvOojAP8Vpz3UlA9XgU47SN91XBy9hrAD104hkXCwvGxYf3kkDzLgnQteKe
         7BDak7Id5tYHZlPVhFOBtallmAAmpOgRHCVlb5mZUO0gUA5tm4CxoYcEZDISjbjYzKxZ
         YxlfCq/mmJKYKe1C5l5daDd7v/uzbqSb/kLr/LcXhAlzpirXh0XfvMs4nPSHJz08emWI
         L4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099362; x=1685691362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJV74MDW5y+ACVn3WrwP3elljkzjXGgh8VAriWHOGeU=;
        b=j+A9iC476wAJf5OpHayfpWZgLCv6+zkJvlBZ2xUGZPxcGtTGi7ivB1JbkfVuZCEzNN
         zOEUwAkWcvO7BJRvpbKGnaI2KgdK33HiFBRnQJ1RXwc1wKNYpktQk+dgu5ckVHPtF+FN
         rY8/Y22Amzm1iJL2EoT95p1EBS3Rukmj26Fbt0onvChCp//32f6MCqaVKFwxUxfNo7Ws
         tlqSWbEIwdDadW65daaOtmtcHOdL0J4UqbLTi5aKlNdaTWRUpchzWn+CJFjXtZAiS3UL
         SMPqWWWxttPEhK926kNKKzTEPcR0DwPjFMi4T8Fq5Lyitbk+5L1yJXqtLQOYuONExvN3
         64qQ==
X-Gm-Message-State: AC+VfDxcULVqBoQdOwvCz6DyUaDlHwDGVstWXvPd0pDEPUvOvfKespMr
        UzKcS2XtgKLGZxAQrkCFMizkfg==
X-Google-Smtp-Source: ACHHUZ4SxHM5uSlnUxlhPS/Pf8T50OkNmttNSY0qaLO2oouXjCtFEL1Y1EPh3R4rXWle2zeXRmPlOA==
X-Received: by 2002:a05:600c:22d2:b0:3f1:6fef:9862 with SMTP id 18-20020a05600c22d200b003f16fef9862mr14051393wmg.13.1683099362288;
        Wed, 03 May 2023 00:36:02 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o19-20020a1c7513000000b003f31cb7a203sm1010153wmc.14.2023.05.03.00.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:36:01 -0700 (PDT)
Date:   Wed, 3 May 2023 09:36:00 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Tom Rix <trix@redhat.com>
Cc:     shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pds_core: add stub macros for pdsc_debufs_* when !
 CONFIG_DEBUG_FS
Message-ID: <ZFIO4FixTx1HC1RJ@nanopsycho>
References: <20230502145220.2927464-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502145220.2927464-1-trix@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 02, 2023 at 04:52:20PM CEST, trix@redhat.com wrote:
>When CONFIG_DEBUG_FS is not defined there is this representative link error
>ld: drivers/net/ethernet/amd/pds_core/main.o: in function `pdsc_remove':
>main.c:(.text+0x35c): undefined reference to `pdsc_debugfs_del_dev
>
>Avoid these link errors when CONFIG_DEBUG_FS is not defined by
>providing some empty macros.
>
>Signed-off-by: Tom Rix <trix@redhat.com>
>---
> drivers/net/ethernet/amd/pds_core/core.h | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
>index e545fafc4819..0b39a6dc65c8 100644
>--- a/drivers/net/ethernet/amd/pds_core/core.h
>+++ b/drivers/net/ethernet/amd/pds_core/core.h
>@@ -261,6 +261,7 @@ int pdsc_dl_enable_validate(struct devlink *dl, u32 id,
> 
> void __iomem *pdsc_map_dbpage(struct pdsc *pdsc, int page_num);
> 
>+#ifdef CONFIG_DEBUG_FS
> void pdsc_debugfs_create(void);
> void pdsc_debugfs_destroy(void);
> void pdsc_debugfs_add_dev(struct pdsc *pdsc);
>@@ -270,6 +271,17 @@ void pdsc_debugfs_add_viftype(struct pdsc *pdsc);
> void pdsc_debugfs_add_irqs(struct pdsc *pdsc);
> void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq);
> void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq);
>+#else
>+#define pdsc_debugfs_create()
>+#define pdsc_debugfs_destroy()
>+#define pdsc_debugfs_add_dev(pdsc)
>+#define pdsc_debugfs_del_dev(pdsc)
>+#define pdsc_debugfs_add_ident(pdsc)
>+#define pdsc_debugfs_add_viftype(pdsc)
>+#define pdsc_debugfs_add_irqs(pdsc)
>+#define pdsc_debugfs_add_qcq(pdsc, qcq)
>+#define pdsc_debugfs_del_qcq(qcq)

Usually this is done using static inline stub functions. Any reason to
not to do it in the same way?


>+#endif
> 
> int pdsc_err_to_errno(enum pds_core_status_code code);
> bool pdsc_is_fw_running(struct pdsc *pdsc);
>-- 
>2.27.0
>

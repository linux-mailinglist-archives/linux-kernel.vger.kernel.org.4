Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697296E4580
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDQKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDQKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:45:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34626A78;
        Mon, 17 Apr 2023 03:44:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso3962175e9.1;
        Mon, 17 Apr 2023 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681728206; x=1684320206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+oplVmOeEOPgIqDyW1qIYFp0lFRq10T5/lljQHKoh4=;
        b=fHyGwkwDAtNj0DlHlyzUivs6EQ96RzQOhVuP6N5dkutmEDOwUGklY/lxNlehpflUy7
         RCd62MWviAhxTYZS52hjrQ71xno4y9jqfbhxt3Hs4Mdcu9pON3/1mtG8vpmZqmE93rSc
         Tb9ck/xOVFxFKiM0Wz1Z70UmNgrft9ErZieucpP2Mcdgn78ksMQlzO/LezrV2Woffiz0
         kJl7S2KtfS+COsO3Kvw8GdleE1ATC3ii2tbsoi7Ycu7uWpB0wjKLZ2xVilaYMJZ3bvWt
         zV+Wa2SY60vwSeapI6zXZ1/XB62iNG9tEkmvGcjh59AGw4AgSKF4VPgTwio0IlpzZPAh
         K3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681728206; x=1684320206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+oplVmOeEOPgIqDyW1qIYFp0lFRq10T5/lljQHKoh4=;
        b=gkLn/SB3PCUQV3V+/QTtclXCvfhtGS+zIZs8Sxa2iDt3qQq7ct1KSu5lb1dXgBsNMb
         O7OoWZAadX105pu8JNnPedP/2/gC7r/OKWeNsy5zh0wtLli3oGGAhKi6DiMAWRWoKtgb
         oOEP473M+2kzDREqVq4PuFqMWWMkKuhEB6wJS3WHNJmgDp+ffaarxDu/oKYSQyDTXnxi
         pBtk6tGoWrwqfb7LrQmiMljYfVkB/iWXepiTg+MI7WA0rxlv5NZrVfDmX8DFouBt12Qb
         UMookRNxAVlskO8CrslhJgDhsGJkgkRyFY81ZI+ybjO+gdXat2QZ/Lmox3O4ZV+fDXPA
         Ox7g==
X-Gm-Message-State: AAQBX9fLUhCRnFzchtpTqKGCZVthiqUL7vDYKahl5iWo/edbAuOp8R7z
        7JRxGeDF9F83jS3o0hIlw2U=
X-Google-Smtp-Source: AKy350bd9dvxSELvJHpzUxOJ/agocGbgxies6qUeTX6tG3PuWYiJlTByTcqlSV22b766L4A0As52Hw==
X-Received: by 2002:adf:de89:0:b0:2f5:8116:6458 with SMTP id w9-20020adfde89000000b002f581166458mr4935358wrl.66.1681728206141;
        Mon, 17 Apr 2023 03:43:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d58c5000000b002f47ae62fe0sm10246043wrf.115.2023.04.17.03.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:43:25 -0700 (PDT)
Date:   Mon, 17 Apr 2023 13:43:15 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kang Chen <void0red@hust.edu.cn>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        daniel@makrotopia.org, dzm91@hust.edu.cn, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com
Subject: Re: [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to
 devm_clk_get_enabled in mtk_thermal_probe
Message-ID: <48ae0e2e-257d-4ad2-afbc-2eb4b48e516b@kili.mountain>
References: <b2e5ef14-9a12-15d5-8016-d0994c1177c3@linaro.org>
 <20230411063531.3976354-1-void0red@hust.edu.cn>
 <20230411063531.3976354-2-void0red@hust.edu.cn>
 <4fed91ef.3c256.18783c407e3.Coremail.void0red@hust.edu.cn>
 <cfb7743b-03b0-96c4-fcc3-7095694f6fbb@linaro.org>
 <6108982E-A3DC-4B7E-829E-20BBAC9C503F@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6108982E-A3DC-4B7E-829E-20BBAC9C503F@hust.edu.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:15:02PM +0800, Kang Chen wrote:
> 
> 
> > 2023年4月17日 17:52，Daniel Lezcano <daniel.lezcano@linaro.org> 写道：
> > 
> > 
> > Hi,
> > 
> > this patch does not apply:
> > 
> > Analyzing 9 messages in the thread
> > Will use the latest revision: v3
> > You can pick other revisions using the -vN flag
> > Checking attestation on all messages, may take a moment...
> > ---
> >  [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
> >    + Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >    + Link: https://lore.kernel.org/r/20230411063531.3976354-2-void0red@hust.edu.cn
> > ---
> > Total patches: 1 (cherrypicked: 2)
> > ---
> > Link: https://lore.kernel.org/r/20230411063531.3976354-1-void0red@hust.edu.cn
> > Base: not specified
> > Applying: thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
> > error: patch failed: drivers/thermal/mediatek/auxadc_thermal.c:1182
> > error: drivers/thermal/mediatek/auxadc_thermal.c: patch does not apply
> > Patch failed at 0001 thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
> Could you show me your work tree? I can apply it on mainline-6.3-rc7...

Please write it against linux-next instead.

regards,
dan carpenter


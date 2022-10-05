Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596DC5F56BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiJEOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJEOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:51:54 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CED39BA3;
        Wed,  5 Oct 2022 07:51:40 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id h10so8896789qvq.7;
        Wed, 05 Oct 2022 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QmwHGbQvoaY/TFnVnQHLYh+/HcbN2RGXwWhx0V1Vk9k=;
        b=gjopUXWEZ2d4VoVGBtuZoCBUSvJH7WREhR7WR11jhtntHE3SQQYlg/x+6wrvTAsJk3
         93Dt9/jOsZvODxZQWIAtUjtuxTMNcyRXOIPqh3i55auTjpzoenFBT10IO2RsBbcZg4uf
         TGegROqwPPIW+Y0Tr2AvjculHSsduUoLV0KrXTZ5spN2ysXOoBkvCiMq+SG8vZubKacr
         Ef1Vm7XastiLJF64He8wgSpm+vCXqZoRYbJSXZjmBulauTHPSOVhQs9HakuQxkIxNLgH
         buZzpSBeNthrzb+PE/CuX7ioHIcgh5H1ztahj01c55VwIKbGozfWztmYNff5UFEkrj3u
         iTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmwHGbQvoaY/TFnVnQHLYh+/HcbN2RGXwWhx0V1Vk9k=;
        b=CVyhxTNtLiJdrmo+6iLrHIcB/NOQJhXsx+9RIdZT69qzizGqa8s3H1EmxCOxOfydwM
         8Ob+QxxYcPSkBUTrOzaMuqXoJTdyKMdxyIB/XruXPgpQrI4WM0xFsaj5mXnSuZnMcw+4
         U5NXai3kqnHge3Wt9GzPW5TApeMrABfKfxi4EowFpCm65aNAbm7ZtxmSzVKrCGDTbexb
         nVYJK9BcQPfg1mW2A5zZe4+rvfu9S4admPO6MneYA4Qg5T/J4rbPwkPdOpJFVB/+6YlD
         uiswqucWzgkmLSzDNc5tWvbPLFUD8cdvTlqFvxA6vmooMab2P7+SZuZR2m+5mJ+wfVdt
         Jmww==
X-Gm-Message-State: ACrzQf3+phlCmRAoUtZlS+roVWJKN8aiOhm+g885vGuh2wTrKDiqxVRV
        M1gpcE87+5ib8DwHTDNYq6Y2UgA+Ymq62gqoGzPIaNs026I=
X-Google-Smtp-Source: AMsMyM6jPYkeTeR2NY0nznahmo00ZU8+Sz3HtZuQGhqi/KV6Ys61YV9lrpQewAzLs9fbvppOY7Z7IWcq3tpVk+eMeBs=
X-Received: by 2002:a05:6214:19cf:b0:4a9:4241:2399 with SMTP id
 j15-20020a05621419cf00b004a942412399mr121185qvc.64.1664981499641; Wed, 05 Oct
 2022 07:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221005133120.50483-1-olivier.moysan@foss.st.com> <20221005133120.50483-2-olivier.moysan@foss.st.com>
In-Reply-To: <20221005133120.50483-2-olivier.moysan@foss.st.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Oct 2022 17:51:03 +0300
Message-ID: <CAHp75VdVfs-e-HGSRejm4c07A_4KuUGSFNvYTtjLC+3JtuhkEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] iio: adc: stm32-adc: fix channel sampling time init
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        nuno.sa@analog.com, Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
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

On Wed, Oct 5, 2022 at 4:36 PM Olivier Moysan
<olivier.moysan@foss.st.com> wrote:
>
> Fix channel init for ADC generic channel bindings.
> In generic channel initialization, stm32_adc_smpr_init() is called
> to initialize channel sampling time. The "st,min-sample-time-ns"
> property is an optional property. If it is not defined,
> stm32_adc_smpr_init() is currently skipped.
> However stm32_adc_smpr_init() must always be called,
> to force a minimum sampling time for the internal channels,
> as the minimum sampling time is known.
> Make stm32_adc_smpr_init() call unconditional.

The lines are quite different by their lengths. Are you sure you sent
the updated version (see also below)?

> Fixes: 796e5d0b1e9b ("iio: adc: stm32-adc: use generic binding for sample-time")
>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

I have told you already that the tag block doesn't tolerate blank lines.

-- 
With Best Regards,
Andy Shevchenko

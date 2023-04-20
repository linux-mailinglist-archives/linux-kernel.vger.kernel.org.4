Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E046E963F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjDTNtv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDTNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:49:49 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5F35BB;
        Thu, 20 Apr 2023 06:49:49 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54ee0b73e08so43542737b3.0;
        Thu, 20 Apr 2023 06:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681998588; x=1684590588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFwAnymNU/xzoPTSiU/gkgBU1rweVN8hCuHcak3NWrQ=;
        b=U7DnDH3GlysvNS9UpGVZfBW0kST+LFbB9+Ey1y/BE3BT0ZnSRG/YXWaOpXRw3SXvYf
         nzFbwE9XqSuW71u+Xw5FUoXqsOtU++AqBV7dDq5eZENqkbRbj+RNQsgXZqyRLi0SFVuP
         uvWFPD2f+bH4jg+f3WkG6ED7HhyOkueD9rs+lG+k0zweB6dObV/snaTI1I+YB9O5A7S2
         wNRhx1aZ8gy3DRzwYNXyEepvGQ62bdiFkM76RocLVSRCdyv/TsZjvq1HR4MU0om93K7F
         iZ8LXYfk198V7uI/GKX/lBklXfFYVvpRecDOP/YDSp4l7Eis1qr+Of2Bn63f9M9N3oWe
         dEaQ==
X-Gm-Message-State: AAQBX9eM2IQvwH31MWIKIeysi6MPjn+mq5UbWJZQ8Dpwmnr7aIgv+yPU
        C5hzGAmXwiBoc9RsLZfkD+7I7L8HVKE06x8+
X-Google-Smtp-Source: AKy350aHYAo4bOcjErXQ0AhMjkPP6hJu1QQSrbHoSqlkk/CEjLwiQEy3zHyoC/dWVr2MDHfXlICqMw==
X-Received: by 2002:a0d:f5c2:0:b0:54f:ba86:9fb with SMTP id e185-20020a0df5c2000000b0054fba8609fbmr849775ywf.24.1681998588028;
        Thu, 20 Apr 2023 06:49:48 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x69-20020a81a048000000b0054c0f3fd3ddsm359780ywg.30.2023.04.20.06.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:49:47 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54c12009c30so41648647b3.9;
        Thu, 20 Apr 2023 06:49:47 -0700 (PDT)
X-Received: by 2002:a0d:f5c2:0:b0:54f:ba86:9fb with SMTP id
 e185-20020a0df5c2000000b0054fba8609fbmr849753ywf.24.1681998587380; Thu, 20
 Apr 2023 06:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230413114016.16068-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Apr 2023 15:49:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUNfcu=opFMSTP2E_VkgWXHazHFL2_Z4B0gFvQ7k8z7ZA@mail.gmail.com>
Message-ID: <CAMuHMdUNfcu=opFMSTP2E_VkgWXHazHFL2_Z4B0gFvQ7k8z7ZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rg2lc-smarc: Enable CRU, CSI support
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 1:40 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable CRU, CSI on RZ/G2LC SMARC EVK and tie the CSI to the OV5645 sensor
> using Device Tree overlay.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

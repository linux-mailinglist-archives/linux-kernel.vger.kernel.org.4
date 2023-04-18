Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD936E691D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjDRQO1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 12:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDRQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:14:26 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E38A4F;
        Tue, 18 Apr 2023 09:14:21 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2a8bbea12d7so20087491fa.3;
        Tue, 18 Apr 2023 09:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834459; x=1684426459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edzK7u79JqM+7LhPBFR+z+4eZJTEqnBnyOWxqayzfUI=;
        b=EReeCXHKx1aTsXZqjFcWudONc0P0bjLFKUIeAqY1Tfm97KjVFV5fG0WRlzrOU9XV17
         5HDzAhNDq7Mb0Yf9lzy0SPZNF+otGl1mWBVoVBHk9FmCcc9pGg42Qxw/yU3jiH9f4hNM
         9hpU8ETn9mIPtO/Yf1gdfF7OQFI8WAdQ/nfBmRmj68Q5eUGBX3OsvV43Lhxmve/zqCOO
         xocvJb7i5WD3VeHmX+Xje09BWAecVR4xcRWtVIs20dyCAGzKKFCMHlBRYE7TDl4GqWyI
         Eg8WKLMSHtEIgxIvyM6+KIyTMRE698UR2Wm4jYpH1vmaWY8g+YxcJtKxZRoi0yOvbtCt
         ipgQ==
X-Gm-Message-State: AAQBX9e6UZ9pcw/vbrS7hza0tMYQpjCi0nIX1iH9hjH9DTgVsWD2XS/P
        91wfYtjwMVX2Li21TNvG3EHVg+TpHQ3pKKkR
X-Google-Smtp-Source: AKy350Z/zwZVo7ajnKsgaHXgBS3gBKqd2fLfcrymV0zfU0Yp+TE3UdLaOGQiwNlBOTztY54Dnq1GbQ==
X-Received: by 2002:ac2:5ec6:0:b0:4eb:4002:a5ca with SMTP id d6-20020ac25ec6000000b004eb4002a5camr2931215lfq.66.1681834459478;
        Tue, 18 Apr 2023 09:14:19 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c17-20020ac24151000000b004eb554a1711sm2409704lfi.51.2023.04.18.09.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:14:18 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4ec8133c698so10733929e87.0;
        Tue, 18 Apr 2023 09:14:18 -0700 (PDT)
X-Received: by 2002:ac2:51a2:0:b0:4ed:d542:6f65 with SMTP id
 f2-20020ac251a2000000b004edd5426f65mr397608lfk.5.1681834458048; Tue, 18 Apr
 2023 09:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230418155153.222214-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230418155153.222214-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Apr 2023 18:14:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpTu3NXt-Y-Xh9SS=mQsL9Wm4=XNe6pKGd+WB2Ef5Fow@mail.gmail.com>
Message-ID: <CAMuHMdWpTu3NXt-Y-Xh9SS=mQsL9Wm4=XNe6pKGd+WB2Ef5Fow@mail.gmail.com>
Subject: Re: [PATCH] sh: pci: Remove unused variable in SH-7786 PCI Express code
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Adrian,

Thanks for your patch!

On Tue, Apr 18, 2023 at 5:59 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Addresses the following warning when building sdk7786_defconfig:
>
> arch/sh/drivers/pci/pcie-sh7786.c:34:22: warning: 'dma_pfn_offset' defined but not used [-Wunused-variable]
>    34 | static unsigned long dma_pfn_offset;
>       |                      ^~~~~~~~~~~~~~
>
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
>

Please no blank line between tags and SoB.

> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

For the actual patch contents:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

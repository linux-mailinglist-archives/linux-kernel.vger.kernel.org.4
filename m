Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11646E792A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjDSL7g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjDSL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:59:28 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C001314F50;
        Wed, 19 Apr 2023 04:59:04 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-54c12009c30so604003877b3.9;
        Wed, 19 Apr 2023 04:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905536; x=1684497536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62BHt3Ar78t7oUJVs8PCy5IPU8m/wKdKtDVaKr7HP6k=;
        b=f/LB+o6IaCbtEKHObxRVEiP8lM01O3l4YUQDn1bnPVTk15qu1qsTCzwO/3Onn44Azi
         c7VtIrT9qxZ8/IJYiXuS5Vn2MbSkXrNk6D9HA9vYd5ltW75ZeAQy51wmjOUBsjgsUNnR
         mIYqzh7ICxKVi5J4jQx3VJH8ZD/baNPxM39De02J7XPutmNSJtnn3qscsUp3fc+nmgRU
         t6p2buwi90L/ydiRdBm9pbzVo3oM7gw9JJPnOqHNJjyBVu/4fRGWfyK7nXguMz9+BffC
         0RzEcWCvFWRTeBkqMYAjCJWUlYYPqSCb9LcO2KhZRUn+U2EfdMcNvd+zAYYlWkSI16HI
         YiSA==
X-Gm-Message-State: AAQBX9fyCSDopKIXoWR+Syci+k/wh1BgJ/D5ka3z1OjvOg6g0qXFL32Y
        B1Hsdsj1BadfzPSnJcFR0kjFIpjRM9nr7kta
X-Google-Smtp-Source: AKy350bLGfqenHWWG9NNG43U3ZWxicWwpIpcK86DJVOkruXsC1+3NAIoC7Ws/HPeSR89NKNLU4ku7Q==
X-Received: by 2002:a81:7b89:0:b0:54f:c68f:dc40 with SMTP id w131-20020a817b89000000b0054fc68fdc40mr3079677ywc.39.1681905535865;
        Wed, 19 Apr 2023 04:58:55 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 17-20020a810d11000000b00545a0818479sm4408762ywn.9.2023.04.19.04.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:58:55 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-54ee0b73e08so499570957b3.0;
        Wed, 19 Apr 2023 04:58:55 -0700 (PDT)
X-Received: by 2002:a81:834f:0:b0:54e:f59f:5153 with SMTP id
 t76-20020a81834f000000b0054ef59f5153mr3045895ywf.17.1681905534986; Wed, 19
 Apr 2023 04:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230419114854.528677-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230419114854.528677-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Apr 2023 13:58:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9PynJKN9=UX3+t1orWJiPusbsELPybLN_UVnykDH9Mw@mail.gmail.com>
Message-ID: <CAMuHMdV9PynJKN9=UX3+t1orWJiPusbsELPybLN_UVnykDH9Mw@mail.gmail.com>
Subject: Re: [PATCH] sh: sq: Fix incorrect element size for allocating bitmap buffer
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 1:55 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> The Store Queue code allocates a bitmap buffer with the size of
> multiple of sizeof(long) in sq_api_init(). While the buffer size
> is calculated correctly, the code uses the wrong element size to
> allocate the buffer which results in the allocated bitmap buffer
> being too small.
>
> Fix this by allocating the buffer with kcalloc() with element size
> sizeof(long) instead of kzalloc() whose elements size defaults to
> sizeof(char).
>
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29B666094
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjAKQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjAKQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:33:27 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D042BC4;
        Wed, 11 Jan 2023 08:33:26 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id l139so15538259ybl.12;
        Wed, 11 Jan 2023 08:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CXTrtqRp8xq1t4uI/gJlWDHaCDKcZXC3jcPMK78AGM=;
        b=IsP6VG378zIvOIIc5PfbfEIKrdIRWjw8Xm2GzVn/3myTWgPK5Kt1vXlvXzoWBH5zyW
         703zygsBxdMGwJu2B49919UgxqiPdxoS0RzvjC6BP82BuEtqK8nX39Wm0QXU8a4bUq26
         8RR3U4VLFTq5O9OBzEfxWkgYT//tou97Iafy447nekO6+H0LMo570nJZuQLTbmVdeDQ0
         OwxloSpT0ruwfRORQCKRk8olbGpSmK3H/18KReo0ZYdIksvnOXoLjVPVSfiui+7Qmg3j
         Mrn1SN34cuJJYSJ/c4iw49SVUeK9Fo2UT020WWUb/un1bL2u/1zV/7M9PaQVnX5wLKsB
         iFyA==
X-Gm-Message-State: AFqh2kqqkxK+xBdqzR78W6oiDd5y36JyBvbdyhcJUlTjBZLpTORSTjhB
        iXbVddVhv3IzpwjZX+AbLYOUqWGJMnydNw==
X-Google-Smtp-Source: AMrXdXsOikQcjU4JcH5EteqpjGS60PI+TD23Yh9GlSzMdKj0my9bKxPWRyZfaJOe+67kE8d50x4aaQ==
X-Received: by 2002:a25:8547:0:b0:7b2:991:9b7c with SMTP id f7-20020a258547000000b007b209919b7cmr23651699ybn.1.1673454805218;
        Wed, 11 Jan 2023 08:33:25 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm9290157qkb.116.2023.01.11.08.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:33:24 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 194so13314107ybf.8;
        Wed, 11 Jan 2023 08:33:24 -0800 (PST)
X-Received: by 2002:a25:d84e:0:b0:7b4:6a33:d89f with SMTP id
 p75-20020a25d84e000000b007b46a33d89fmr1645500ybg.543.1673454804653; Wed, 11
 Jan 2023 08:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20230104141245.8407-1-aford173@gmail.com> <20230104141245.8407-4-aford173@gmail.com>
In-Reply-To: <20230104141245.8407-4-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 17:33:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9cL=oGxKK0+2z49b=0is4kqG69mKz9PkDu96e6n2qAQ@mail.gmail.com>
Message-ID: <CAMuHMdW9cL=oGxKK0+2z49b=0is4kqG69mKz9PkDu96e6n2qAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: boot: dts: r8a774[a/b/e]1-beacon: Consolidate
 sound clocks
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 3:18 PM Adam Ford <aford173@gmail.com> wrote:
> Each kit-level file represents a SOM + baseboard for a specific
> SoC type and uses specific clocks unique to each SoC.  With the
> exception of one clock, the rest of the clock info was duplicated.
>
> There is a generic clock called CPG_AUDIO_CLK_I defined in each of
> the SoC DTSI files which points to this unique clock. By using that,
> the clock information for the rcar_sound can be consolidated into
> the baseboard file and have it reference this generic clock thus
> removing the duplication from the three variants.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

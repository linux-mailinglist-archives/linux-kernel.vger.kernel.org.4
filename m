Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27106337F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiKVJIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiKVJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:07:56 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5213E3C;
        Tue, 22 Nov 2022 01:07:55 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id fz10so8885740qtb.3;
        Tue, 22 Nov 2022 01:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+me+gK92AeljrWBvAVG/MPMCTgxhzzYX45cfGkqB9FI=;
        b=P8uJvE6M453q/yaKyiUoqkYAq38q7RROsYrI8WSGSahQ+P9lP8q+8LttjtzI0DXy4B
         DWZ/5q30+0mfwEbfOPYxYDx6b9xEFjxQSM0fWaPijhuVVw4xL4C6nys1/M1CnUZdROV+
         JfgT0pLoFZXtqNDbRQrHUZu8eidDnAHEJF7sIheQQKIbmtdktzr2lmEB6P7xrjNB7Z6m
         3vMQC5H5ZOM9MKhoYAVYE11WKywZu/gAHEJaQeCCnYZaHClW7+s0UrEqLV25v5IcRQQK
         Su5cTB7MCwIlRv+ZKJkNLaBB540cRI/WE6u1pp6LeOyar2xFebZ5HEFDbZkYMgG8fQfb
         Sa3Q==
X-Gm-Message-State: ANoB5pm0XkHEdsnH0lHSV2H+QxWy4LGyGGiRRCeTvqMa7RJ77MHSz8Pn
        KcSW/RwB1N5zJpZe7o+ezsy/aAEKw61b2Q==
X-Google-Smtp-Source: AA0mqf6AL1ZlFa3kiRXsCQnyXAu3JFQ2OdTNRM52D6hFwZUWTf3EfEQo5NWRT2xotyBNK/iQMZmUTw==
X-Received: by 2002:a05:622a:5a15:b0:3a5:3388:4089 with SMTP id fy21-20020a05622a5a1500b003a533884089mr20598633qtb.601.1669108073884;
        Tue, 22 Nov 2022 01:07:53 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id de13-20020a05620a370d00b006e99290e83fsm9936515qkb.107.2022.11.22.01.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 01:07:53 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3691e040abaso137949847b3.9;
        Tue, 22 Nov 2022 01:07:52 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr5473386ywb.47.1669108072643; Tue, 22
 Nov 2022 01:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20221122030555.26612-1-yuehaibing@huawei.com>
In-Reply-To: <20221122030555.26612-1-yuehaibing@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 10:07:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjzL5PSBYKfE05xcCVMX+LTwCDNq0iWk-z2WAFyDZ4mw@mail.gmail.com>
Message-ID: <CAMuHMdVjzL5PSBYKfE05xcCVMX+LTwCDNq0iWk-z2WAFyDZ4mw@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: ccree - Fix section mismatch due to cc_debugfs_global_fini()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gilad@benyossef.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, cuigaosheng1@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 4:12 AM YueHaibing <yuehaibing@huawei.com> wrote:
> cc_debugfs_global_fini() is marked with __exit now, however it is used
> in __init ccree_init() for cleanup. Remove the __exit annotation to fix
> build warning:
>
> WARNING: modpost: drivers/crypto/ccree/ccree.o: section mismatch in reference: init_module (section: .init.text) -> cc_debugfs_global_fini (section: .exit.text)
>
> Fixes: 4f1c596df706 ("crypto: ccree - Remove debugfs when platform_driver_register failed")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

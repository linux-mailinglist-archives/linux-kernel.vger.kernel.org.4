Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517AD643566
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiLEUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiLEUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:14:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32FD26567;
        Mon,  5 Dec 2022 12:14:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so1253867ejc.2;
        Mon, 05 Dec 2022 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7iqaD9NQm0VyRYiAKdqd9SMWPMi9ylBYy253DQgNSw=;
        b=oCD0W0IaSoHbayzt9V8/oDsDC53nzKKZ2Mo+oqka/f8QqAYYtwy3EBqNbZfu1mX51c
         UfN/tURajh7slXey/xU2cZvzi/n4R+WZboo+Zcce0F27jnC84wt8lWG300qk8Au3OVID
         Tb7NoZcxH1cKX0sXJqdKs9wLf6FMTFzkBe8zOEC4zjViKEn2zJZ6v+goOWAdeJUW+Zr/
         LSQR1H6vL9vKdw+sEb306UPCf4/kf3zgrjytWukowI6XV5Bdbu10EDZbSQ775W3eLDV4
         WIq4CNhOCK5a3RAGjgGcf9J3ImVs7WXCUV7yhxZ5od7N48wsBr8C6kaHEYtgSA2aJ2DU
         QzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7iqaD9NQm0VyRYiAKdqd9SMWPMi9ylBYy253DQgNSw=;
        b=mno3rUBgoHauoKv3ARXSL3iCxfWlKFUqEtgCe7vQBvvEL3jRuRCsH+ShbY1JDeNXh2
         lmsOUo7ljj5MSrRT8DSTsyCoLrUosCFRySxqS5bGGSthgRLQtOUTLkDHYL170fN2AljR
         yvsrFBK5VFFUgP0LgtC2tnCbGS1XSw6BDAmfUmmeovrklSY/sZ8K/CckCkWV4TcuvzNr
         QErE9n8RC/yl3aEK+TWCbC0vCWFU7UYLSXnI2xCS2cGY7rTazXAsFfkNQgR5B69ghu6g
         qoI723fOdOoODvjzVtv3cly53bCSvKjJ156lf/bG4mWYoFlD30EavxosFoc3fyF6HljZ
         y9Kg==
X-Gm-Message-State: ANoB5pm4Hh6+5Q4vA5gNigM7DYXgxOQ9CKvTmOkGOEzpB9IVBh0KDi/l
        p5Msar97FxOjM6GZQFHAAf0=
X-Google-Smtp-Source: AA0mqf5q1oILM2xX1UEbTreI2l/RpJd/mjGJV0cxlhtwsxgQ5R9AS3T4LmZh6w6dtXyv9cjBfn1InQ==
X-Received: by 2002:a17:906:1310:b0:7c0:c5e9:634d with SMTP id w16-20020a170906131000b007c0c5e9634dmr13260599ejb.220.1670271258235;
        Mon, 05 Dec 2022 12:14:18 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b007c0d41736c0sm3426117ejb.39.2022.12.05.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:14:17 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/5] clk: sunxi-ng: d1: Allow building for R528/T113
Date:   Mon, 05 Dec 2022 21:14:16 +0100
Message-ID: <2261489.ElGaqSPkdT@kista>
In-Reply-To: <20221126191319.6404-4-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org> <20221126191319.6404-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 26. november 2022 ob 20:13:17 CET je Samuel Holland napisal(a):
> Allwinner released some 32-bit ARM (sun8i) SoCs which use the same CCU
> as D1. Allow them to reuse the driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



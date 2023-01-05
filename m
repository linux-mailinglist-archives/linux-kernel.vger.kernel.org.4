Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB86A65F2CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjAERep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjAERej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:34:39 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B26E45;
        Thu,  5 Jan 2023 09:34:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z16so20354658wrw.1;
        Thu, 05 Jan 2023 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yFsobRjIEmQm/DKnD82AMLE2egCJRjpMOIJdP27XLs=;
        b=Ok61nY5Kao4ppgyPXSS8swkii7i2kd66zOt2jX9qQ+Tfv5GgacxnCkiGMezhCzNj9X
         n+Yp+EgcV4yBHYcDQx7PMoYmmKI2phxaAubd5No7nP248rq4vsV6kw0nvlkHwVAMvtDk
         6IIdWux63nEEUuW4QIsp203EoX2UDzCjXzuPXTTOT2zQtSzD1m3COLJgM2JC1PzOIPUT
         B22Ny80hRW+8y/M27B7QEY07eZZWQAo4KZaKClg/HO2xbFWiDhheFZ0doa4eTMagK0jG
         AK4zRba8lh7A+Nj0p4GNzIVy20smjUdFKLrFvIdY+YTLtrXQcR5dKlO05uml5C5sdmLn
         0/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yFsobRjIEmQm/DKnD82AMLE2egCJRjpMOIJdP27XLs=;
        b=ZlWGBMebHiEMwlvDycxuD8WJ+s+d6wGKqEPx1SbWKQKA+bRx3LxOU4bcLBQY3arc2i
         YUUgDwa5oOk+TdpobuKlLXGhu6poce5NbgKTMEm6HUjCG1Dgr5hlQgYLAjj1oHUYp+Ca
         AoW1jZbkPaTZdADV8rp6i0Ia7Qe/3jHFbyXiGob4cwI3CcZiqLf9np9KZAfqo6V9MVX1
         xqm9LnTFQqskh1cFzFrRvKU7bpO0YhdSOEVOk0w7AZQhFxqla8tJrrH0P+tVCoMXg+jV
         xYsyISYY+rsfgBKhIzgjAALpVWCqJvEii60k3RUNKATYVUc7mXiBJCi0SS0/HFEwJqvG
         tXWg==
X-Gm-Message-State: AFqh2kqE0G5rQ1l5WF8edhib88l8ey4QrFvKUIVsc+AT4GXUXBDuruhX
        NANA2ky4dl2BxJJW08v5ockPoZKvsykNKzH3
X-Google-Smtp-Source: AMrXdXuRNLB0HJ7TJiRxUb5UM81lg4k8r0EpzD0Wo6njhgCYm6MxIzN0BDQ7pYFS6fb59zvHXKaEYQ==
X-Received: by 2002:a5d:6dc1:0:b0:242:3353:26ed with SMTP id d1-20020a5d6dc1000000b00242335326edmr28981391wrz.62.1672940077645;
        Thu, 05 Jan 2023 09:34:37 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a18-20020adfed12000000b0027cfd9463d7sm30165469wro.110.2023.01.05.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:34:36 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 6/6] clk: sunxi-ng: d1: Add CAN bus gates and resets
Date:   Thu, 05 Jan 2023 18:34:35 +0100
Message-ID: <22918155.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20221231231429.18357-7-samuel@sholland.org>
References: <20221231231429.18357-1-samuel@sholland.org>
 <20221231231429.18357-7-samuel@sholland.org>
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

Dne nedelja, 01. januar 2023 ob 00:14:29 CET je Samuel Holland napisal(a):
> From: Fabien Poussin <fabien.poussin@gmail.com>
> 
> The D1 CCU contains gates and resets for two CAN buses. While the CAN
> bus controllers are only documented for the T113 SoC, the CCU is the
> same across all SoC variants.
> 
> Signed-off-by: Fabien Poussin <fabien.poussin@gmail.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



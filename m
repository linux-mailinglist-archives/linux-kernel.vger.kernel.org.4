Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B6B65F110
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjAEQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAEQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:25:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E358304;
        Thu,  5 Jan 2023 08:25:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u19so91187475ejm.8;
        Thu, 05 Jan 2023 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGcjNWkYyFV7KGtDmAPcnHFpakjpf87o3mWY6B3jNYE=;
        b=kkvPJ+0gP56qm8Gm9tFVNHPLid+GH4Znb+lcoJ5awmOUBN26bnPtyYc4yVt36VwAHh
         lU4Rs3J9dvunQghJMYZCjdo57bRhKlksSOfqGM5GMI8Zkv0PUx+5Dj3un9lXQpGx9yEk
         8udoJGOAwp02/sHn4NXWtnHHwRWArLEdwGpTT61nY3aAEFtG/WrFQPbjWsH4DzeYq1tC
         oniICgQxBL/X3KszV7NLR7HvuqJZnuEjMlk6GrsuYzxT5NVB6d2OPfIhYv/i+TOXQg1w
         mWIKs0O858viOkrDkhik5wt1iiEkCxc0vSj+cY8OFpMKWaSOBEewncXLf+mwBpughF8n
         cTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGcjNWkYyFV7KGtDmAPcnHFpakjpf87o3mWY6B3jNYE=;
        b=m+gtFb4X/Ry6YHy22cR68JOAuEfAPGdj0tKt435/+S0mr5+Mq4YgBbC2Ir6SDjzelS
         6x0i5lLTM1gJcEPUvA6UUQU5TLpiSMhMANJUva3qpfU7Kf1ytqHQIlrsRRTdsyzACzt8
         qXG4Ah2tbVwp7nNQakODBTkR8Pfq9EsB0dIw5GJc2wYqnzZ1AzRk4jduteqLFjJKFejj
         9VK2cPwD6hM+XndvKYQtQ2coiUmQbe/zO7oRV2cWtfAXV2d/8Qe4TQR7cR4TDbj4zNmM
         8G1cL/Vr1A32zhKCmt+3qS8p+BgR7C/Noe8SI0WHmB4IQ7qOkBmJUvJs9XXVQzFB11Xa
         kB+Q==
X-Gm-Message-State: AFqh2koBwmyMtr9c3KKt7qMGXmZxnCyz60uAkokgz3hd9p9UUcyLwN7S
        fHZpsva6dn2uU5f6UA2IlVI=
X-Google-Smtp-Source: AMrXdXud+NA0Suedx7vVT0q3+kaXBXllkZ9GjEa6ydtq6LSRAxonQbvR+e2OR6Avz1mD7lO5OS0w8Q==
X-Received: by 2002:a17:906:910:b0:7ad:aed7:a5da with SMTP id i16-20020a170906091000b007adaed7a5damr57431170ejd.28.1672935916846;
        Thu, 05 Jan 2023 08:25:16 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906211100b0084cb4d37b8csm6504278ejt.141.2023.01.05.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:25:16 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] clk: sunxi-ng: Avoid computing the rate twice
Date:   Thu, 05 Jan 2023 17:25:15 +0100
Message-ID: <2860887.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20221231173055.42384-1-samuel@sholland.org>
References: <20221231173055.42384-1-samuel@sholland.org>
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

Dne sobota, 31. december 2022 ob 18:30:55 CET je Samuel Holland napisal(a):
> The ccu_*_find_best() functions already compute a best_rate at the same
> time as the other factors. Return this value so the caller does not need
> to duplicate the computation.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



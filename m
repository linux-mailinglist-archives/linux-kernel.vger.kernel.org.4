Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2464638BED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKYOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiKYOPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:15:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8720F7F;
        Fri, 25 Nov 2022 06:15:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z26so4292458pff.1;
        Fri, 25 Nov 2022 06:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5KzGXVYN4vmEuI7SNB+5orsczk7XvMecFi6EmJ09e0Y=;
        b=b15yVOSIToO/Qd/EqL6wKJ/T3apIQzi6Sm6FvD1VDA7l+Mn6egT167LmmF+g7fdQMg
         ZwuMsARTdI6kYZuvVEKt71fZnCokd9EBsRssooubPOy7/P9lEU8mBvQl14wp2SsPQHLN
         +aputDjR31fUtG96TuB0gy9JyRe5LAxcNm5NJwJV9dz0bWimH0CoK+Jd+zfuImmh2YHD
         jIHVoTNfTBiBlZjeZChiueto0EGvxuX4UmOLP6s49/mnSKGrPAEUdkP6OVqF3tQUasgZ
         EZ+oomXoGhVxp7qi/Z+2MwcJQQFT96g7Nnv5Bi2DsOMHsR3Cq3qgr54RbSmW/h63GQTo
         SmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KzGXVYN4vmEuI7SNB+5orsczk7XvMecFi6EmJ09e0Y=;
        b=aV9Qfaf000jfsT259QAJotDoynR3dCL30ka+MbUz1vhVhN80+mUV8+S+3fOga3MXUq
         4ffsYqxCDikFvbv6iLHmHLQhdL6YBLFv2qqtEKJdhs616KaQQWVjJ0/PP6qRdZMOc7uR
         WUT/T7Si5hNDsoQXvNLKvTypUZMO05Q3Pq88h1K+TxOOh6UyqXwz2vz+w14tqaIpvmmm
         9p33kvB0fGF/OPJXHNXT5Ze4bYTDdMt2iWlgYTWDxz8dviMrcmPlneVYnTiXsiHxp+kV
         d6Y2yVpsCEeCpqKofpwCma7tCkJNFmIjjej/9qi7qN4DLOppsW9r1CXgGyJyp3+gFXt/
         fZbw==
X-Gm-Message-State: ANoB5pkvX6aynAoJ/txix6VdtdEv/eHwejpZO72u0vSmavSZIQigLr5J
        LWpxtiKS3JITQQsmxMmrSvF9ZPPAtdicWMQBk9Y=
X-Google-Smtp-Source: AA0mqf4cc1knI5Pqqcgkt0vNUXenfxo1PzcEuuURfi1pfus1dcl0kkFJiXeCFA60BwsGhQX1CHgVMphyhxGISQ/l1JE=
X-Received: by 2002:a63:4d09:0:b0:477:7dc8:57a8 with SMTP id
 a9-20020a634d09000000b004777dc857a8mr16055958pgb.506.1669385701910; Fri, 25
 Nov 2022 06:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20221125092601.3703-1-abelova@astralinux.ru>
In-Reply-To: <20221125092601.3703-1-abelova@astralinux.ru>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 25 Nov 2022 15:14:50 +0100
Message-ID: <CAOiHx=nc46Hj4wDGC0ci8+SrAkJZ9i_7-yZU1D8cWkpS6prGoQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM63xx: Add check for NULL for clk in clk_enable
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

On Fri, 25 Nov 2022 at 10:28, Anastasia Belova <abelova@astralinux.ru> wrote:
>
> Check clk for NULL before calling clk_enable_unlocked where clk
> is dereferenced. There is such check in other implementations
> of clk_enable.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  arch/mips/bcm63xx/clk.c | 3 +++
>  1 file changed, 3 insertions(+)

Makes sense, especially since clk_disable() already has a NULL check
(in case anybody else wonders).

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A262872BF09
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjFLKaq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 06:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjFLKaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:30:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A20C42B97;
        Mon, 12 Jun 2023 03:11:16 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56d0d574964so13525047b3.0;
        Mon, 12 Jun 2023 03:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564542; x=1689156542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0KNjzjUscMpY94OwsETv2nblTfy9at4y8uMIjfaCTE=;
        b=FWZYDSffohLAD8uTXbV9nFIdjjCiuDHPt2KwWJt7MKhftu51wgIjgOVSgqgFDCSzOs
         QEA33N7AgwQcVYKxZiaok0YeYh8t1QNuDXBuL1A3PNF1Rs99eDxghU25O6MExKBfqSpC
         VpE0/UtV689T7rbQhLOM8GqsLMJGI5o83Nb/xsI90q1cIzzd1DVsxEMYf3quzNSCRtG8
         Mjb08q71u2q/pL0dG+eGvtWgNavF0D9N1FdCMFX8f8K6EHK9KQQKfKdmuO7pKaMSOwCE
         DIfj6ejVSNBZE/W1Mq4u6vJ7WXZy99AH7dhESA7mNDdOSDrAsCNK4pjLa1KCtRB+rJuH
         yDbA==
X-Gm-Message-State: AC+VfDzMnCDanEjKmYZ5Yx2bT+VzXrKvXRmE6bB0lTHqxEEETJc9m5on
        30HKW+R14Bz3O9YGrjQNBQV9bL4PhxVNog==
X-Google-Smtp-Source: ACHHUZ4uneBckly0b57PIbbUG+jCqf3Rm7P9wu5uJiQURJY0OWPtoX7+64yEX3pTxkH16XLqqS9m4g==
X-Received: by 2002:a25:19d4:0:b0:ba8:63e8:e583 with SMTP id 203-20020a2519d4000000b00ba863e8e583mr9007721ybz.61.1686564542552;
        Mon, 12 Jun 2023 03:09:02 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a8-20020a258708000000b00bcce8d2c5f8sm253306ybl.44.2023.06.12.03.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:09:02 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bc50b217bc0so2129186276.1;
        Mon, 12 Jun 2023 03:09:01 -0700 (PDT)
X-Received: by 2002:a25:4b41:0:b0:ba8:2e05:3e9c with SMTP id
 y62-20020a254b41000000b00ba82e053e9cmr8962689yba.24.1686564541590; Mon, 12
 Jun 2023 03:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com>
 <20230612090911.1579029-1-geert@linux-m68k.org> <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
 <ea22bff7-ecd2-018e-77a1-1d2edaa21355@linaro.org>
In-Reply-To: <ea22bff7-ecd2-018e-77a1-1d2edaa21355@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Jun 2023 12:08:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUz5KatvuDxPZN5YEP-8SrqonbGCO-411CxWuKQn1PXA@mail.gmail.com>
Message-ID: <CAMuHMdXUz5KatvuDxPZN5YEP-8SrqonbGCO-411CxWuKQn1PXA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.4-rc6
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Mon, Jun 12, 2023 at 11:48 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> On 6/12/23 10:28, Geert Uytterhoeven wrote:
> >> JFYI, when comparing v6.4-rc6[1] to v6.4-rc5[3], the summaries are:
> >>  - build errors: +5/-6
> >
> >   + /kisskb/src/drivers/spi/spi-stm32-qspi.c: error: ‘op’ is used
> > uninitialized [-Werror=uninitialized]:  => 523:27, 564:27
>
> Seems that the report is not correct for this particular case as op is
> filled either by memcpy or memset before use.

I can reproduce the issue with gcc 12.1.0-2ubuntu1~22.04.
No idea what's wrong. Disabling CONFIG_FORTIFY_SOURCE doesn't
help. Perhaps an issue with the memcpy() used by UML?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

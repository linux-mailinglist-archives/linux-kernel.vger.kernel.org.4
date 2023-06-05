Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865A722207
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFEJWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjFEJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:21:51 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B66E44;
        Mon,  5 Jun 2023 02:21:32 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75ca95c4272so410197885a.0;
        Mon, 05 Jun 2023 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685956892; x=1688548892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+IJZ8YoQCXr6cLHC0VkJnXD5EBJfWNAYm1Nc1zlsBI=;
        b=BTAYJMXUpakeg2wqR2PbJdrM4ec6OtJ5U/1HJr19o0pEUWQEIP4Tv9L7fzJ5J2Sudb
         9bwDPc3+2BUEiGIPhTG9l4ryfz25gJzpN6I2JMcki+0bbIlCk0S7oKheXY4islm/qE+O
         QBAOWXiLmNGgnSj+I65n1hkHspWeIm45BF4jnuud6bV5lnELybaYnAKFEc8NdPxy6p+c
         nofG8DkpV4DD1k6nt1VEkrDO1qARjqFGkelf+K+rcoQlUn54rqnVhaeoYXJdLy/hcxL+
         3izKcS1Ze8rlZs4xiVDKhvXCwLhS2bsGc6Sco54x1HD6qlrHlzkSTXXhanJbk7zAPhsW
         x+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685956892; x=1688548892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+IJZ8YoQCXr6cLHC0VkJnXD5EBJfWNAYm1Nc1zlsBI=;
        b=XAoKEljqSW/G46SCdNXXW4NH99EcBTuowi64KVGL2XVt9vcOhSRPqRGRseaUFHK2Zb
         W9ju/IXAfnwYNvomaqjuoxfjkG3f2fOLtV1nQA9H5pk1CMSzTzqlrdgP3lQj6boUZmyI
         lA6yTg6Jks00LMT9Fl2t6Vm1JSE/A6SdaJ+uBCYbgbsqZI+BmfqleDKwgtn8mhcCSfHD
         jxq3boEWFQu5cfTd2booLHGrLQW+1sotIndbBFLes5DZuT/G+5Yu9cH0EBkHZiMAou+X
         Mcd1xa0KB4quqjDUMWb8C0GBLuXbsyQPuQMOVugchh/5S2rz73CRHA5DVAlNjGnxoYEz
         qHlQ==
X-Gm-Message-State: AC+VfDxtgwYMxf5EluwtTKadi24DOcKItQFFmQVxSGCJ8pX0X+8rHiyF
        wznDT4GoXa/hDsQvSxfWPX4UtM9/RYBBkJ8NG08=
X-Google-Smtp-Source: ACHHUZ5XhYNabc7t/Kamr9I4cIi8AJZ+CaRkBphgjejYHYhW/hMp4t/5rc+FdwjyETN6kk9ZiCkTConA+aceidP6icY=
X-Received: by 2002:a05:620a:46ac:b0:75b:23a1:8e64 with SMTP id
 bq44-20020a05620a46ac00b0075b23a18e64mr22218316qkb.53.1685956891974; Mon, 05
 Jun 2023 02:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230605015345.12801-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230605015345.12801-1-jiasheng@iscas.ac.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jun 2023 12:20:56 +0300
Message-ID: <CAHp75VcCMf9B6Cf6PTKSxbhv7_eYVNrG7CFNXi2nN-tJ2AjdNQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: ath79: Add missing check for platform_get_irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 4:53=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.cn=
> wrote:
>
> Add the missing check for platform_get_irq() and return error
> if it fails.

Here it seems better, but still needs an explanation why returning an
error is not a problem (assuming DT might have a wrong number). I.o.w.
you need to prove that with current code this fails in that case
further. Otherwise you will need to prove that there may not be DT
with a wrong number.

--=20
With Best Regards,
Andy Shevchenko

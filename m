Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9657331CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbjFPNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFPNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:03:01 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0612D79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:03:00 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56ce61769b7so7772767b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686920579; x=1689512579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqh0ctcZSSNyRLU8FT9+ClAUkk1xdpX2MQLPP/RnayY=;
        b=MG+hTnXbncvoRz+RslD756hmGsI9/fqykFQTy5fbp1tlF1qi+rqV4AmAIqlg1ObZnf
         E3+Lr0rsmac4Ia424Mzgn3mZjwsZj+GCBgWkoAbVN/vl56kuQPJF6C6W/sfMqnM3XPRk
         byvVqHqtcM8kylTJPORWCFe88lkV8GsTPnUCaZiM14ur5BIlNuyt2qiVo13Sf1mlmdWp
         gpR/6b7kYn8UkPcZyq8s0UEgkrRgCutNUWxVo3kAkc/gRefTZZjcQjevSlqi08lYDAZX
         bP9UaFyfjz/CdKJG13M2tPs02KHVeaFG0sPmhzOzDqGDgAvb+hAPAXuNRy+ux5tAC7ub
         XBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920579; x=1689512579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqh0ctcZSSNyRLU8FT9+ClAUkk1xdpX2MQLPP/RnayY=;
        b=JoUFMdIBMLFSBuE+orCVMnFkziXywwqnYCScQ1t21EpYI1cy4yCi1SGaJaeH+jFdsG
         hhQLGYYcB050an5OkklOwd5PIXyqJJZfD+tCuklcwfV6EKMTJEIg8pZ7X3VMbiXRNjYa
         tO2XA8n0lsY9KnPmowvjrUuOl00Mu2YjOLGbUYGJXF6l7of9FO9hSIzgltsXF/rkTIlw
         RDopHWqhDfhbr1e9iU7DS/rNmpKIzG1PIWp3uHageTidkEvfS7sH0hMqzM1yzxrs0oXT
         lojnWsOLS/airHigINzrJJ9dRmYZe8fH8yy3CxzBNV78gaPQTQHJEWqnYp1kv6yoEyd5
         asCg==
X-Gm-Message-State: AC+VfDy6d9+dJRdKaBauze2/2P0jZac58eC4O7fxsO6hi5H+aJlPb88I
        DArnrLm8eU01nnVSg4v4JM3FxmoB/nv8Yjt0ZDmu/w==
X-Google-Smtp-Source: ACHHUZ59gNYfqxe5wJoZ5aeX4/NRY0zwtgWn80m7CZIDDHhc+6i/AOmOKSKeO/cec1lNrwDw7sPggb4LRnOvt1mVU2E=
X-Received: by 2002:a25:26d0:0:b0:ba7:86c2:d95c with SMTP id
 m199-20020a2526d0000000b00ba786c2d95cmr1656110ybm.64.1686920579272; Fri, 16
 Jun 2023 06:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230615105333.585304-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230615105333.585304-1-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 15:02:48 +0200
Message-ID: <CACRpkdat1MLPfsosci2anWSsr80PLCJXN1=jTfKUi4QYnwBbSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: check memory returned by devm_kasprintf()
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        UNGLinuxDriver@microchip.com, andriy.shevchenko@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

thanks for your patches!

On Thu, Jun 15, 2023 at 12:53=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> While browsing some code I noticed that there are places where pointer
> returned by devm_kasprintf() or kasprintf() is not checked. Thus I've
> tooked the chance and fixed this (by updating kmerr.cocci script,
> changes published at [1]).

I applied patch 2/3 and 3/3 you only need to resent the first patch
after looking into the comments from Andy.

Yours,
Linus Walleij

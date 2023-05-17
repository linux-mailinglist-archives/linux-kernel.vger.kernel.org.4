Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C455770644B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEQJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEQJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:40:00 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FB54C3C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:39:57 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so205998241.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684316396; x=1686908396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx2TwACJ0P6x76R79l1peGmeBxK0nDxRRdKEiAVASmg=;
        b=FghLVlakB/I4LTcp5y1lhq3dENdKEJsA/+tLp+LY39xxkD/kGXRAfB1XJ4U+W1HKrf
         Hl0Y39s8G9LRi0Ps1tNMjTxRV+f5Ac5Zp1YZGi24Bdgxx8vPO38JcM4hE5t+xZDOQp4x
         xVeuO7e/wPUbEN44d3VPl8tu3+/mu/PdRnfrLaCCvcD6spXHcuIrNQsnNZu3qAfWU9Xq
         VT/+rKc/kqG1HJ/tz7Z+D4b/a4J1p//YwB0aaIt+2sZ4qaoUKcb094Y6dndOQeV0bz8q
         iJxwL/oc/GmcuoyCqE/3zkHlgDnwmo6M24yqHrLpIHcd/eHr6F83YK3w5U478BHQFZ0e
         erjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316396; x=1686908396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dx2TwACJ0P6x76R79l1peGmeBxK0nDxRRdKEiAVASmg=;
        b=ByN5hKC+gpHgYrr59aukiBE2FqHBhtg//kCULyEp2xrQO0xSe3YTrlS4KRuhKms6z9
         y9i7kvgnD1CJ6dZ/3iIjkrM4+cCuKgDM06NEBTaYWD4jh5G290UDQnB/P1EYEPeCsyym
         iwGZ368L0gJJKBuyo6k/8oh2hHUSP/bHmzKaOI5DLTO8I43KClMDYcfpOT10e82zJyqQ
         QJfgUqk/oBjqxWfF0Z+NjREM5R14H0FPv+g3PAAO5uKIVbqSliOW9BsYBGAm5TJVHJQQ
         zO84p91hKBDoIjaZUZUHO1toE7tTNlAJtyBdjEEtvuMlk+XSQ2BfrkYsQPcwLW0kyss9
         YxRQ==
X-Gm-Message-State: AC+VfDxKOEnimwloY8OwpJxhEVnyT3FsqF8qcAwa5uUn1R6/NMvy004z
        IqEheSjKeKcdZohShc83pRP+scFytJQ6SJdrbc90CA==
X-Google-Smtp-Source: ACHHUZ5D9xUVZ6cVMIFmmwfE3Tk6vop/nmFY9mgejxQxIJDBU15GmWANEReYIQ+w3TDvHkcRWp6hPKKkGtkzkgR08Q8=
X-Received: by 2002:a1f:dd42:0:b0:43f:cc0e:b634 with SMTP id
 u63-20020a1fdd42000000b0043fcc0eb634mr14104342vkg.5.1684316396471; Wed, 17
 May 2023 02:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174408.494811-1-afd@ti.com>
In-Reply-To: <20230515174408.494811-1-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:39:45 +0200
Message-ID: <CAMRc=MfC-0yNbqWU-=LiQ_xhJZCPOjN04ZGw7KMkz96gmf4Txw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: tpic2810: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 7:44=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>

Applied, thanks!

Bart

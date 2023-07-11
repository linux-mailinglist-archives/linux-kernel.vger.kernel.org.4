Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC2474E99F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGKI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGKI73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:59:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53700E7E;
        Tue, 11 Jul 2023 01:59:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so2841700a12.0;
        Tue, 11 Jul 2023 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689065963; x=1691657963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCy1RMIN6aIK9mn7wKePuH00105doEaXlrGCs4x+WdQ=;
        b=dxlshHpmcU+/RD60BTec1K9KqP7h2H1qRUUgssAiUE3ZGj+mnndoP/7sSwX+9u73um
         72PK2ODb+RMT9frUR4J5eG1WNCGu+t/TXnF51yfM+4lPgLAba85EMwvioAmveSlytJhV
         swDXDm6eI78/RimikzoVgP+uj2gOf5XqkS6WFIxXrx+lmjPpPAD/7aHiGXac/58e1dVb
         ORNd6oIKm7Lgobf85gCJ7lpwGHQon5iKAE7mTIdfkxOcX5ua0dOUQYIhscreQsIcK6ey
         cUX38n5Wuife9T+Wz62hvOTnOhFb/TtDjJEaUPNI+SjNnrpleHx4xK+uC0hbQ5JNyLe8
         wVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689065963; x=1691657963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCy1RMIN6aIK9mn7wKePuH00105doEaXlrGCs4x+WdQ=;
        b=YhyGj2J3DO/Y4+FUgYjXFzy3h8WjVDNU6cVG1vbuRAarNH6SEk+xGXkZPFNQxncfkY
         NE6QHPq2g+yyVzqW3OIpqVmzE9N3L998yO9kR5SiEJQe3o8oEGkY7THaqHJF1kW3Qthi
         brr6YsIM52mfP3T1IUhcxN/Eab/4EtnyanA5HtlvrxH/BFAk7tNCRHUdUCReE3UoW9hj
         hBdjCnz+wo/5rRzweP4MEX7KCZa3yiJvjjVcwAnTnLw/aVT+mMkj+QIqwofA3uUG8A8X
         iEIf8nEE8VVyOPkNM1Ojm7NG6/7gu6TZjOAlkxlAi25Nfwv2EqDPwwbNV0MXnOiAgaH1
         mAXw==
X-Gm-Message-State: ABy/qLaDC3IIv3QcQmnBfXp0QuCsg+g/z1b/06dYcH30khZTRrqRiWrX
        79ZYCtRSaR5LemSYQcb64CWKMJ6OC6gieDTBeO61qV/uP7o=
X-Google-Smtp-Source: APBJJlEKr1ge3dczVpJsYSOqUXnzyXzHURhlljTZFokROyPrWeINhJ9rT77mJOwEG7Urp65ym6bQFTN0BBU9o/b1gFM=
X-Received: by 2002:a17:906:2b51:b0:982:cfe2:32fe with SMTP id
 b17-20020a1709062b5100b00982cfe232femr15950094ejg.63.1689065963301; Tue, 11
 Jul 2023 01:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230710215023.679-1-asmaa@nvidia.com>
In-Reply-To: <20230710215023.679-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 11:58:46 +0300
Message-ID: <CAHp75Ve87oHP4P-=xHZgHuWyJJnpuARH+qzXO_vJRhUeovXMWQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mmio: fix calculation of bgpio_bits
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        davthompson@nvidia.com
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

On Tue, Jul 11, 2023 at 12:50=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> If the "ngpios" property is specified, bgpio_bits is calculated
> as the round up value of ngpio. At the moment, the only requirement
> specified is that the round up value must be a multiple of 8 but
> it should also be a power of 2 because we provide accessors based
> on the bank size in bgpio_setup_accessors().

Is this a fixup for the other patch? If so, then why did you split them aga=
in?

--=20
With Best Regards,
Andy Shevchenko

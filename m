Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449A729239
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjFIIGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbjFIHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:49:43 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A523AA1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:49:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-568ba7abc11so13492327b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296960; x=1688888960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3c2ntYAOnDdSkrfl6TadBZmpYpoDIkLc1TtVzVrRJ8=;
        b=IKrGMIFZ/EjMmj9mSBuFlJHyclCyZWfGsF9i5dacTEK78et2kPUekz7nYsXJRvbKVu
         AAlWv6lnPv4lVG3NxH/xCOskpaEXs+dwdY0EIGAiyA16DQVL9Tefc2AiqbVpPyfFiE08
         QrzR0llTMHM2kimq7fy7i6XtLWK2at8OpZYgQ3YGV8WXP0sqnDxCsP1Fei6uUeV2a8mj
         P9TM/TEh+u3CjCtabvhK/46qAB4NJOoLQUNwOnhuV/2dwCFJNvTXZD+zJz3aqKODPSAo
         /NqsIuD9Fen1gD303bC7MOIdDxxkt6Lewdtj4IKv9w/22g+yUWtAwUjjZ+8MGd78ROOo
         ZtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296960; x=1688888960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3c2ntYAOnDdSkrfl6TadBZmpYpoDIkLc1TtVzVrRJ8=;
        b=QYi2siGRXy4UP9+BV8CnDZ3yrnm+4rw7QYuFCwJUmLlUwwBQVSt6eB+vothxTjOMvV
         USdC/mvGNV7rn0IuDbFTThP63JYoWEd1SHbwpeORA7JjiUReLPuom23yNpN7PeikqC4d
         Eg/rJ26QgtXgPjV4DpU/R50zhhcCGJzhyTq834tooyJPKWubbvJTV7PyaF6llvOlKw9L
         C/zgyeSKdYYhnB+Dnv6Qfhne6DF8ahY5cXJC7l5Tje0cnlfUWaqihIBkSFMwuF8bbmT+
         2yx/1c8Dp5jZM3ZQ2SA1hm+V8R93pNXiCXHaGEuC/GDXtoXG8DJClWIPLbIWTSQydo6f
         8GHA==
X-Gm-Message-State: AC+VfDzICVAQSYSU4e/SOULHzr7wNbrjm/1F16U33waKkwZYpKCjKhWl
        kOlw13wS0u8RwME96jvpK0gA8Ou6cgxX3pCIRPrxAA==
X-Google-Smtp-Source: ACHHUZ5bsNQpTQNAQO7r1mc69mmCaFHlXIZd6vtnZ7v0XG3sWHlGWJIsko8TTb833lC9heTEu1Kke0gt//Jr7u8OZAQ=
X-Received: by 2002:a25:a349:0:b0:b9e:b9b4:bb12 with SMTP id
 d67-20020a25a349000000b00b9eb9b4bb12mr370346ybi.48.1686296960015; Fri, 09 Jun
 2023 00:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <1686249772-26231-1-git-send-email-manikanta.guntupalli@amd.com>
In-Reply-To: <1686249772-26231-1-git-send-email-manikanta.guntupalli@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:49:08 +0200
Message-ID: <CACRpkda7TrNckpS5rLadv=eYRCDDN1qTBUp=jr+KfgoaQy8z7g@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: zynq: fix zynqmp_gpio not an immutable chip warning
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     michal.simek@xilinx.com, michal.simek@amd.com, git@amd.com,
        shubhrajyoti.datta@xilinx.com, srinivas.neeli@xilinx.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        srinivas.goud@amd.com, manion05gk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 8:43=E2=80=AFPM Manikanta Guntupalli
<manikanta.guntupalli@amd.com> wrote:

> Make the struct irq_chip const and flag it as IRQCHIP_IMMUTABLE,
> call gpiochip_disable_irq() in the .irq_mask() callback and
> gpiochip_enable_irq() in the .irq_unmask() callback to fix
> "gpio gpiochip1: (zynqmp_gpio): not an immutable chip" warning.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

This v2 looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

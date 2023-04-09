Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF66DC170
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjDIU7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDIU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:59:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA072D4C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 13:59:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ef6ca60ceso58098777b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681073972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYjszfZdIcFlvw/gOOPz9XiTbVxYxk5w+BqzIhUy+bE=;
        b=d/mrOeoKL0OlBPafapAnDGixxdLfdyADkQLv+Ua2kG7yhbZVHtFc9ETB8RGLrd27Ap
         Dyk8PNsg7tIuWbzhMdAmpDHBx8lZjfMXygqPy0J1qlyUnvHYoD2t/TcnZI/EtcSMFONa
         vGeKS6QFi70+ryohE6/BJ59MI8i8CYYkYeiSZ4m/c/aux1wjejdvxlTHHBjj/O6x8KHu
         2kFlCQ6nAHFhSd9GOcKOoAz514uKbtCkPBNEdlNupO4hlEoB4+1syUYqu3IdAztVgozt
         qAAKmUGignwNN60l7MeqMBeo/DUuPKKMBH9vsOuj5J4byGrKXw/4Dx0M4/Z1J4g7r5Nb
         PdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681073972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYjszfZdIcFlvw/gOOPz9XiTbVxYxk5w+BqzIhUy+bE=;
        b=N2FF0Lbp9WerOd3D2LXGmYOc7FhktRKeySmRNnUk51lqQUrIaP2efd74qR1j0bzwOQ
         Pbb7kfQNt+Pxue3ma9HYhRwXozYACa/aFaF0WrA1CqC2HONa3vg1a8dOMFH9jERqBFlk
         HouhqzDC0AaZSCIQO/LCUEQcrTaq9slzpCxYjsUyaD6navhBMnkPzbNHrLfDYCO0Jul1
         S/CB3NKcgKtTViXrkiBkZTKBNU7OFkmmRamO09q4s6DsfcAakLVAmVylEdJF1CZh16hp
         pOObbdt4Xy1mnKoRgfLFvNO8KIIxSeDNEtwKc8wFA5rYBu4tUNB39xdI9Zy6VGHhMdu3
         YgCw==
X-Gm-Message-State: AAQBX9cJLvz+K3tFohe0+9J6nrvvVqL3OJ+a1g0PvWwFM+WpLiz4yQap
        FLkOFHG+LeeFV4Z3BHcWgsLN5PXbmGyfrPJdHYOuDg==
X-Google-Smtp-Source: AKy350Yp9XrZeUCJSC7aO9fq7bq9epWNdSClf2RJnSRNIezt0Tnn6jJWKu8JAkFkLUUcBraIR06fSn1OY0JqdgWJfwc=
X-Received: by 2002:a05:690c:1:b0:544:bbd2:74be with SMTP id
 bc1-20020a05690c000100b00544bbd274bemr5923049ywb.4.1681073972033; Sun, 09 Apr
 2023 13:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230102094733.3966825-1-linmq006@gmail.com>
In-Reply-To: <20230102094733.3966825-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 Apr 2023 22:59:20 +0200
Message-ID: <CACRpkdaxPt5eVM3D17qx24XH0-3gceDYCODNudv0PFYrCsB-2A@mail.gmail.com>
Subject: Re: [PATCH] ARM: ux500: Fix refcount leak in ux500_pm_domains_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 10:47=E2=80=AFAM Miaoqian Lin <linmq006@gmail.com> w=
rote:

> of_irq_find_parent() returns a node pointer with refcount incremented,
> We should use of_node_put() on it when not needed anymore.
> Add missing of_node_put() in the error path to avoid refcount leak.
>
> Fixes: cd931dcfda5e ("ARM: ux500: Initial support for PM domains")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied. Sorry for forgetting about this patch!

Yours,
Linus Walleij

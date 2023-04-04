Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB746D6497
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjDDOCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjDDOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:02:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5F4EC4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:02:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536af432ee5so616033027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680616917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhHi1rvDP10jyqp6elYeOU798evHTjpyzcCbCEvb8Kc=;
        b=LGGP+RsXJ62qou0+C1xjBzSyj+8IzaLTZ6O/t/gVnmwtvFnC8CePoPk8ZSiKmtZ09t
         6ZgPlk78Ov+L/lKuSWrK7/vcNqb+EqUk9ChBn3+Fm4XANMzbqL++UxnSlFEODa425ByS
         5utDLusg1dlDtgj9zNNKadRhGRDgu21cjvn5qcyZugFQNGAfWbVDrbwgoCyjWVqN/avT
         Qsr6WQ0m8uRFtpoUgAA805PfrP+Ewzw/0pQJ0AI7ecxOK51thHJMATbvv2X69/r6WEBp
         YI8pd/8vgMCFEUSGNGt5VodRwGnzA7rFEaPI+dHmEPvkYKwGaEOf0r9AS9ZzDDL0oXv2
         8Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhHi1rvDP10jyqp6elYeOU798evHTjpyzcCbCEvb8Kc=;
        b=CFXVW4auWq5OChzcP+GKsP16MC/K1rZk6y/QjXYZT+D9klpg0Ec/zBt/UYlfQ0/6IV
         7ImzHoAW3KIuAYtcN6TFOKXoY7XZlOdd1eEjCmrwYGjWeXnvpw6Ch1e+MRGt45pKJB/9
         01T7sVUKwDJ4Q7rrHRzUTmd+W21bxH/r0DkyJBarYn76PDgDjICtZOCQrAGBNPaWsX0L
         nuKrFnd2wXD38mtpPKgjalHOiwsz7aNyst1JRBeapCtpUX4kEo4/yxkd2udly4M5x4v1
         buTD7BwrRIMiP62CdMFpNr6L45wfu9wtQBTH0HgaUT5F5gro8vfUKDwcpwEe40I+gWKH
         yObA==
X-Gm-Message-State: AAQBX9flfD/1GbtZrxekudkB6OEc/KEJvImyYkbcnQcdkzUSN8CZKW64
        dxn/K3MBdxUnbdnjAgP4wCviJAuaWij521W6MWjVLl9B5/ygm73v
X-Google-Smtp-Source: AKy350bxbwzpZz18ICNta7OUeGE74gnB4fQ2IiKbCVd5qVGch1T/mzQirta1Ay6x7i930ZuDKOP4WhZqpAGZjoTzt6A=
X-Received: by 2002:a81:ce07:0:b0:53d:2772:65d with SMTP id
 t7-20020a81ce07000000b0053d2772065dmr1561312ywi.9.1680616916859; Tue, 04 Apr
 2023 07:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680543810.git.william.gray@linaro.org>
In-Reply-To: <cover.1680543810.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Apr 2023 16:01:45 +0200
Message-ID: <CACRpkdbp0o2UDqcz17sha9WCchhwhGuFHBdWfyLSerioxiJ1qQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix possible deadlocks for i8255 GPIO drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 7:53=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:

> The 104-dio-48e and 104-idi-48 drivers leverage regmap-irq to handle
> IRQ. The default regmap locking utilizes spinlocks but this can result
> in deadlocks for IRQ chips when running -rt kernels [0]. Enable
> use_raw_spinlock for the regmap_config of these drivers to prevent such.
>
> [0] https://lore.kernel.org/all/1466065537-82027-1-git-send-email-mika.we=
sterberg@linux.intel.com/

This looks reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

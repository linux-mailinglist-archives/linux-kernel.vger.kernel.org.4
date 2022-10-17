Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E0600C22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJQKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJQKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:16:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F9F4B0C3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:16:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y14so23722869ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jxk2s2ANmZp2WKA9YJugV44UvSaSYVmLt/4gqo1RPrQ=;
        b=oRgOe04VturqaPQ5sDuGc6PwP/W6m2unf1BiwREtowfWriAyr/tM8BdpGur5T/Tn+l
         LCpm3jhUgKaM0MayF1eKAcNyOtZ4QOB5ogQFO6RSOw25pAI67b4SWo1tSHyYBF/YQ/d+
         dAsCqCTsNnwWa9BLA02mNE+GAYL8opQtM1QIOLIlltTVPSDxPeVeO0KmGCTkcBcRcoDu
         xtnXtkuuv76dxwjB7llqBeAc+BTosvOd7nDGIDN7UzmMDfZbj9xSeRcC2mbxoiVaZJl2
         X4P9Mdo0TRUTBUzY/PCs8+0Lxqqmc5yIWX2F4W4CBTIhXlgurOfPGUhCse1uLVaTUsbY
         iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxk2s2ANmZp2WKA9YJugV44UvSaSYVmLt/4gqo1RPrQ=;
        b=q/L92NpTxJKR5G4kFSTILP47W4hOtWYCSn0OaQeqnUizJI1eR6Yec8AAtVokV0Vaqj
         gGCgYcbGbDwrLHcgjXXK17aX18Eq8075SaALcYdz1y7lPbqH9WMcOVNnEAeKiFOjzOht
         +WkceNZvgqq3BhagSQxp1qYaoGWU/TkRN7Z5tw+MMQMEu6m8Zy9MvTbLEMpFL1dHdsHa
         AB9qfYA/tqDtoQ2y7rvVnIP/njSBH5nhU1W1YgkxnZBY6kPqTRb/rEj0eatFQCA7E8Zn
         kYWXldEOlMI21axBwOdgY7YI0NFhh8dOst+QyUtCoPnsaEmcfgawrfcWSg6W1puMIiPH
         Uymw==
X-Gm-Message-State: ACrzQf0MD+xqJ+zx327y2RSajWPn26FZvRv/6DYxPfTQuWdHBlrvBKF1
        gQ0bgOnKjdmuJlLCbQtERHShI+bDprzHFacxyFuPLw==
X-Google-Smtp-Source: AMsMyM6WdhHd+FbdZ9YUr/vApG/7uuVhXLcczqk65Dc+MgIVSXr5iMfAcTj+FxRTgy5ZrMgkQjCJeg6f3wRiPT0eY04=
X-Received: by 2002:a17:907:1624:b0:78d:d61c:2b4a with SMTP id
 hb36-20020a170907162400b0078dd61c2b4amr7894907ejc.208.1666001760814; Mon, 17
 Oct 2022 03:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221013134729.5592-1-mario.limonciello@amd.com> <20221013134729.5592-2-mario.limonciello@amd.com>
In-Reply-To: <20221013134729.5592-2-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 12:15:49 +0200
Message-ID: <CACRpkdamdnBDrieoxxEcxRjPUqKXgOj4=P8Z1044NrMHd8DB2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: amd: Add dynamic debugging for active GPIOs
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 3:47 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> Some laptops have been reported to wake up from s2idle when plugging
> in the AC adapter or by closing the lid.  This is a surprising
> behavior that is further clarified by commit cb3e7d624c3ff ("PM:
> wakeup: Add extra debugging statement for multiple active IRQs").
>
> With that commit in place the following interaction can be seen
> when the lid is closed:
>
> [   28.946038] PM: suspend-to-idle
> [   28.946083] ACPI: EC: ACPI EC GPE status set
> [   28.946101] ACPI: PM: Rearming ACPI SCI for wakeup
> [   28.950152] Timekeeping suspended for 3.320 seconds
> [   28.950152] PM: Triggering wakeup from IRQ 9
> [   28.950152] ACPI: EC: ACPI EC GPE status set
> [   28.950152] ACPI: EC: ACPI EC GPE dispatched
> [   28.995057] ACPI: EC: ACPI EC work flushed
> [   28.995075] ACPI: PM: Rearming ACPI SCI for wakeup
> [   28.995131] PM: Triggering wakeup from IRQ 9
> [   28.995271] ACPI: EC: ACPI EC GPE status set
> [   28.995291] ACPI: EC: ACPI EC GPE dispatched
> [   29.098556] ACPI: EC: ACPI EC work flushed
> [   29.207020] ACPI: EC: ACPI EC work flushed
> [   29.207037] ACPI: PM: Rearming ACPI SCI for wakeup
> [   29.211095] Timekeeping suspended for 0.739 seconds
> [   29.211095] PM: Triggering wakeup from IRQ 9
> [   29.211079] PM: Triggering wakeup from IRQ 7
> [   29.211095] ACPI: PM: ACPI non-EC GPE wakeup
> [   29.211095] PM: resume from suspend-to-idle
>
> * IRQ9 on this laptop is used for the ACPI SCI.
> * IRQ7 on this laptop is used for the GPIO controller.
>
> What has occurred is when the lid was closed the EC woke up the
> SoC from it's deepest sleep state and the kernel's s2idle loop
> processed all EC events.  When it was finished processing EC events,
> it checked for any other reasons to wake (break the s2idle loop).
>
> The IRQ for the GPIO controller was active so the loop broke, and
> then this IRQ was processed.  This is not a kernel bug but it is
> certainly a surprising behavior, and to better debug it we should
> have a dynamic debugging message that we can enact to catch it.
>
> Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Use PIN_IRQ_PENDING instead
>  * Add Acks

Patch applied!

Yours,
Linus Walleij

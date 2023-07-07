Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B9174B22D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGGNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjGGNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:50:18 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468EAF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:50:17 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-579ef51428eso24710677b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688737816; x=1691329816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM7C61X6juuUCk/Ywr8w7y2XGaloi1pllSZVLBWH7jg=;
        b=qQ7IZOns6i5qXWdyFkLl2wKz+JIRsRx6nFQYq6Z/Y9MCdeqfZT/mEw0Tc/Je57xJRN
         px0LBiHIbsQI7UpsVBvDN7Vu0SwnzB33StXjro0B27sboHojIPHoDoWVRq0ymCxHipfK
         HMIiblkzCwbWdndM9eMieoBdKvS8AijUexdvjX/ebEDIT1G3WqPdiMHd1wvLuCyWnfGd
         CfAvpxoejRdiBpI8NxbXPm9DJ+YEaGapzfy6OIDNkILFaKnwXjRa5fb5ZjWuP8Vxl85T
         chDp4qRizPcvKa1zfkNF2NiXxKW8PGxy5Khsr+076Hx6dwmQt/UGOS50JGcJEiUNgu/3
         qkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737816; x=1691329816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM7C61X6juuUCk/Ywr8w7y2XGaloi1pllSZVLBWH7jg=;
        b=i/393SQ/Wov8rhEwgqYIQB8sfeYpOBPp0fjL6De+L+V98yP8zMiBcfbQ5KEojVHBql
         8z74p2J3Js6saTcghBOjaC5ni3lKW4mt/dtXAcn33SfcYZIVlIOMAXzEOVO7Z+7fny/j
         se7r6iEZxKInKe4VvkU/3g2J1UnouxoSzysqD/fa3CaNJ0HSBxEo95AXFrhqvQ4PccUz
         R1u0TNwdInLWz42EuWf89UFaXEymU4sEuQo8rd3QhfCEQBtJOa+83jWBzb4ajx0QVPj4
         EB8EwB+xhEBcjsaKs1o6k0RKW/chj5wTMGjeWfDb/0wDRztatkRgXi6z9FlEykOYGjV0
         XeXw==
X-Gm-Message-State: ABy/qLbmbaRdgrRMGiX6tcSTAHuYOHHPVTYpsgZ1NYmjnasyfnTJGOTZ
        L/GW8zsSWK/ryxwwDaY7jUffE93FVoAz7sDqGwb8Bg==
X-Google-Smtp-Source: APBJJlEh/n00m/fh5x+CN9n/27U/1jzzr4sdjLM69E2qxwVgOdI3TXV6Ntuhi4zkktqlgedf/YoV7JphNFNdbVwtGFI=
X-Received: by 2002:a25:b7d3:0:b0:c4d:c258:7ad with SMTP id
 u19-20020a25b7d3000000b00c4dc25807admr5619084ybj.64.1688737816531; Fri, 07
 Jul 2023 06:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230705133005.577-1-mario.limonciello@amd.com>
In-Reply-To: <20230705133005.577-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jul 2023 15:50:05 +0200
Message-ID: <CACRpkdbrwg6wRbFKCfr0H766Z5bX5rANZ-YGAfM6P2q3Khk=bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix for interrupt storm on ASUS TUF A16
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        andriy.shevchenko@linux.intel.com, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        Hans de Goede <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        open list <linux-gpio@vger.kernel.org>
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

On Wed, Jul 5, 2023 at 3:30=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> An interrupt storm is reported for the GPIO controller on ASUS TUF A16
> but only on Linux.  In comparing the GPIO registers from Windows and
> Linux the configuration for several bits specified in _AEI() was never
> actually loaded into the hardware on Linux.

I queued this up for fixes as it looks pretty urgent, perhaps I will
even send it to Torvalds before -rc1 if there is positive feedback.

Yours,
Linus Walleij

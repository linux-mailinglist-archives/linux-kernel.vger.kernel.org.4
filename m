Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439474122B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjF1NU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjF1NUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:20:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B291705
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:20:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c13280dfb09so4682289276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolution.nl; s=google; t=1687958450; x=1690550450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGA6jxqN8vTcDS3wt2muKgODh4eayNigHAkX1s+Utm4=;
        b=DM28bS3zVl7LqD1wB6+f6W2ce5jfWKpWcC+hGhPHAWdzeVR7DtutGaZ9gVnwn/EiB6
         Pz9mDD8KpmHY3yQbzFDienNENZxX4JMLFK9nRIixXu5trv/etNgTNNM4fTsBx+IOBTgK
         sLShII9vBlLLI77k5XUCncIuUvNnQiQwFQy2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958450; x=1690550450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGA6jxqN8vTcDS3wt2muKgODh4eayNigHAkX1s+Utm4=;
        b=NztCv8398IdXpJXOAxUSFPKZNwb+0YMyOtXYChJHebKjkYg+uAQyRGfUXBZkbXxxDR
         Cz6jxJ2UPF5iSuWhbSitPdg4m5t4ry+LmhNWAhD+NkLGZkmCeO4dylxyvyQN2+JGXyrB
         LhIwiee0P4LdMcuLCS1ibZOUVz/b0DKVA0+ixF2U31M5r4jedKsBCo/RzOQjmltEBgY9
         O7KQnEFLMHGafZvlsTOl6FtMo0StHD1L6m95e5kKBPw0v76HBTkMDdui6IYAM2HGqmcp
         NamjO37iauF/VAjXT98Y5S1aUoAvkTX4HFb+QuZqtM4i80sgXToYyxGBf9D5PygMpZfs
         0Q1Q==
X-Gm-Message-State: AC+VfDx8Zw7rBvQ5CxNDE469HjgCveiYk/SPUmrGbtZM8tVj3ril/dhn
        tpEkUM/g+wRoAkAAmnDoxhQv7Hi8ANqp2SkmlCIwXT1leL2vssn+BLUzNDQV0gjFCTriod00uM/
        EIqq9bLFxdNX3JnkzYWYp1/QMZ3fZLw2KZg==
X-Google-Smtp-Source: ACHHUZ5vzh7jOCYjBp4RJ8IsPQl5raQ9wLO+ZE90Xiiggta+9PXzCzTN5UiOvpvxAJewg7KjMc+a5s0IC797yUYUJpo=
X-Received: by 2002:a25:ef07:0:b0:c19:3d97:b924 with SMTP id
 g7-20020a25ef07000000b00c193d97b924mr10615611ybd.32.1687958450389; Wed, 28
 Jun 2023 06:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230628125406.237949-1-stefan.moring@technolution.nl> <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
From:   Stefan Moring <stefan.moring@technolution.nl>
Date:   Wed, 28 Jun 2023 15:20:39 +0200
Message-ID: <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer length
To:     Fabio Estevam <festevam@gmail.com>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-techno-validated: techno-validated
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

In our application we send ~80kB at 10MHz. The total transfer time
went from ~80ms to 67ms, so that would be a reduction of 15%.
I tested it on an IMX8MM platform.

Kind regards,

Stefan Moring

Op wo 28 jun 2023 om 15:16 schreef Fabio Estevam <festevam@gmail.com>:
>
> Hi Stefan,
>
> On Wed, Jun 28, 2023 at 9:54=E2=80=AFAM Stefan Moring
> <stefan.moring@technolution.nl> wrote:
> >
> > IMX51 supports 4096 bit burst lengths. Using the spi transfer length
> > instead of bits_per_word increases performance significantly.
>
> Could you please share the performance increase after this change?
>
> Thanks

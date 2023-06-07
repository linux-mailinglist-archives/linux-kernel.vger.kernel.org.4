Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028D725BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjFGKnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjFGKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:43:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011B1BDC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:43:45 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56974f42224so67583587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686134624; x=1688726624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIVOmSfiAxNQnZtiT/RJR0F2pGN7zpHL20gWDVh0IKQ=;
        b=DXNE6u2n3h/qryUePfFmk5H6iT9uzIO5BuDZ6XBSfsXRkGfZhwRvUYmCTikhu99JXG
         bgnevo2SdKk6aIj+lZ8+GGEEMv3qBPJuBZqwLbe8UMIdbk9KRJcsDvInzJmAY8Igqop5
         yafAhDgPwVSTJ/FV/+uNX0mWkVvWKh8m3G+azKfeac7gMukLEUS3JN3kxHBUP3uAlQUG
         lBEwBp1ztxnk5Lirknev0kHP5UF1gXKp9meVHGLFWOxIwW6RKX7VMVpn0uwxOVDMXg5R
         9SkoOFXmoRV4/mFHpiB1pQp4Dw2QXcfTWIspBomNl5k890iWPRzV90sNJUPmFtfpPM7i
         L30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134624; x=1688726624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIVOmSfiAxNQnZtiT/RJR0F2pGN7zpHL20gWDVh0IKQ=;
        b=EGM5LzfqeUzClb0RbxX39ut9KCULyG/5iYWkq04PVsKMmWcKcSDeJ8pEgXXONHTw6T
         U7bsJM19/dDS7/LApbObsSY9U0hu8Fwl6EakCPPUqCDFTvRYAWjkAmwM5t/FZwhE5MZN
         f2vRwGbqa2U5eeoFf6RIaZ2h7Mib6oLQLBd7hM6XmY3ZiJb8ZCX6O/a+oyN5u7hPG9La
         fkfFhigtPJW/z1XCjE/NMyb17Gj4E53LPIiIHqdaUslPP1z1NOvNCzbpNbf3uGQrOl4k
         +GKGIxYdiwH//B4eCsVlzecQd8uc/PrMa2bVBhrpFn/Tru96sI4QFdBJ0VNA/T+iDzXB
         UQXg==
X-Gm-Message-State: AC+VfDxpYA4vB3YMHC/otkRJEAHCljzerZpZDwyJHjaQc+8GRCZHVC1X
        ZvFxE5HvzCoolqTfavfnGMVAXZjWQHtVWFwRGNPm+w==
X-Google-Smtp-Source: ACHHUZ7iN6kCCfb7xer6RdaL3uoj+q1ymoQ6OuwykcqF1vL4PKge6pwtwhXnPW2ijjINKJRtZGMeuvXTPhwsJ5gC3Tc=
X-Received: by 2002:a25:4e43:0:b0:bab:cd90:87be with SMTP id
 c64-20020a254e43000000b00babcd9087bemr5366896ybb.51.1686134624597; Wed, 07
 Jun 2023 03:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230605133031.1827626-1-suzuki.poulose@arm.com>
In-Reply-To: <20230605133031.1827626-1-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 7 Jun 2023 11:43:33 +0100
Message-ID: <CAJ9a7VjypLQr3qUA5=BMvvdzS=-eCEjeO7azxK5AKJ4TTM1YSA@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: Match all ETM4 instances based on
 DEVARCH and DEVTYPE
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        linux@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 at 14:30, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Instead of adding the PIDs forever to the list for the new CPUs, let us detect
> a component to be ETMv4 based on the CoreSight CID, DEVTYPE=PE_TRACE and
> DEVARCH=ETMv4. This is already done for some of the ETMs. We can extend the PID
> matching to match the PIDR2:JEDEC, BIT[3], which must be 1 (RA0) always.
>
> Link: https://lkml.kernel.org/r/20230317030501.1811905-1-anshuman.khandual@arm.com
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: frowand.list@gmail.com
> Cc: linux@armlinux.org.uk
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  5 +++++
>  drivers/hwtracing/coresight/coresight-priv.h  | 19 +++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4c15fae534f3..8a2e24d5686a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2260,6 +2260,11 @@ static const struct amba_id etm4_ids[] = {
>         CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
>         CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
>         CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */
> +       /*
> +        * Match all PIDs with ETM4 DEVARCH. No need for adding any of the new
> +        * CPUs to the list here.
> +        */
> +       CS_AMBA_MATCH_ALL_UCI(uci_id_etm4),
>         {},
>  };
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 595ce5862056..72ec36c9232c 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -193,12 +193,27 @@ extern void coresight_remove_cti_ops(void);
>         }
>
>  /* coresight AMBA ID, full UCI structure: id table entry. */
> -#define CS_AMBA_UCI_ID(pid, uci_ptr)           \
> +#define __CS_AMBA_UCI_ID(pid, m, uci_ptr)      \
>         {                                       \
>                 .id     = pid,                  \
> -               .mask   = 0x000fffff,           \
> +               .mask   = m,                    \
>                 .data   = (void *)uci_ptr       \
>         }
> +#define CS_AMBA_UCI_ID(pid, uci)       __CS_AMBA_UCI_ID(pid, 0x000fffff, uci)
> +/*
> + * PIDR2[JEDEC], BIT(3) must be 1 (Read As One) to indicate that rest of the
> + * PIDR1, PIDR2 DES_* fields follow JEDEC encoding for the designer. Use that
> + * as a match value for blanket matching all devices in the given CoreSight
> + * device type and architecture.
> + */
> +#define PIDR2_JEDEC                    BIT(3)
> +#define PID_PIDR2_JEDEC                        (PIDR2_JEDEC << 16)
> +/*
> + * Match all PIDs in a given CoreSight device type and architecture, defined
> + * by the uci.
> + */
> +#define CS_AMBA_MATCH_ALL_UCI(uci)                                     \
> +       __CS_AMBA_UCI_ID(PID_PIDR2_JEDEC, PID_PIDR2_JEDEC, uci)
>
>  /* extract the data value from a UCI structure given amba_id pointer. */
>  static inline void *coresight_get_uci_data(const struct amba_id *id)
> --
> 2.34.1
>
Reviewed by:- Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

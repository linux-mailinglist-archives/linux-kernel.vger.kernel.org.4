Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB0729161
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbjFIHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjFIHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:40:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE49D1BD6;
        Fri,  9 Jun 2023 00:40:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-561b7729a12so38188677b3.1;
        Fri, 09 Jun 2023 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686296455; x=1688888455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS9HfMRZUkDStDN5JY5KxLgcjCDDdIlBwC3TmRA3bJw=;
        b=r34X8x8BLSknL6F3UY74ewf40Zm/zXjzVgt21bAHsKY8ei3MI7dY01oiqZIgOeBVze
         DPFB4ATjnyeL2sCGBM7oYkUt5vT9VHA4NR1daGaYlEoE43CokfHwqfMFKWPEPecfLgBC
         nM31pnyZV+N9n1mwmaWQmlM+D7aV7MzvpEhnJ5YKADYq4nmn/xVbG/6zzRUbGdiy2Zh8
         CVxQFa86JWersfJBMs7zwxOSgw+yVj4/oy50Cu8gfu+0e/sYLI7TRzGqhtPG7467HRPu
         dDxzOYRhFrorDqtB09Rv+OELKQ5P/uA/TFgix0MubRKiV+Ko8AivwGMFE8kioWz05cCS
         1TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296455; x=1688888455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS9HfMRZUkDStDN5JY5KxLgcjCDDdIlBwC3TmRA3bJw=;
        b=j6orl2VphcicKCzDsru0u8crvF6PPpNZ9MOWA91bq58Db6p4KkzBfd3yl9LJNyjR5C
         nv4KjxROad4RKv0E04cORNBJvg9cuPF835gLsh5/J3sO+QhyGWUco/31KTj89JfgGNQb
         rmSsuqo6Kk4LqCWYm3KBJsyQUVUGOBoL9q3eQ6PHmjwaaU6o23IRZ/sn0ON/wYY8itEp
         yMYnHVSmJ4ZH8Uu2lmYDG0PyDg1YW+2XH2H/Iz1iXRyR7H9dCX9tZgsJNaq3makeqeCw
         OzbtzKcvgKssKXIEXi/qst5TH+tl9W6rC39/HnoaePgd19sUaRVEEJEDpThNt7V2Rq5H
         Ta+A==
X-Gm-Message-State: AC+VfDzZnMwD6K0fPuIRUUDr5vihQBiNARdmi36X5Y1tRTWG2ctxkKEk
        6qXsNU1axk7X6jE7vOmZMT/8NLOgpUy5AQlyx01acX8j
X-Google-Smtp-Source: ACHHUZ430BiBoaZyvqE/c2j+l6kshdfRFgKwhYGArqu4S5PsTpawZJCBiIJAy9/jnBc8ZufqFatpYnGE01XOYMIJTBk=
X-Received: by 2002:a5b:a44:0:b0:bac:fc30:3913 with SMTP id
 z4-20020a5b0a44000000b00bacfc303913mr956135ybq.21.1686296454969; Fri, 09 Jun
 2023 00:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230609071441.451464-1-victorshihgli@gmail.com> <20230609071441.451464-4-victorshihgli@gmail.com>
In-Reply-To: <20230609071441.451464-4-victorshihgli@gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 9 Jun 2023 15:40:43 +0800
Message-ID: <CAK00qKDkZ1wbxO+iyryrWv2KeXoZ6DMMrip215A2rds494hkGQ@mail.gmail.com>
Subject: Re: [PATCH V6 3/4] mmc: sdhci: Add VDD2 definition for power control register
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

Hi, Ulf

      This patch has been acked by Adrian in patch v5, but I forgot to
add in this patch version, sorry.

Thanks, Victor Shih

On Fri, Jun 9, 2023 at 3:14=E2=80=AFPM Victor Shih <victorshihgli@gmail.com=
> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Add new definition for VDD2 - UHS2 or PCIe/NVMe.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f4f2085c274c..f219bdea8f28 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -99,6 +99,13 @@
>  #define  SDHCI_POWER_180       0x0A
>  #define  SDHCI_POWER_300       0x0C
>  #define  SDHCI_POWER_330       0x0E
> +/*
> + * VDD2 - UHS2 or PCIe/NVMe
> + * VDD2 power on/off and voltage select
> + */
> +#define  SDHCI_VDD2_POWER_ON   0x10
> +#define  SDHCI_VDD2_POWER_120  0x80
> +#define  SDHCI_VDD2_POWER_180  0xA0
>
>  #define SDHCI_BLOCK_GAP_CONTROL        0x2A
>
> --
> 2.25.1
>

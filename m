Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509E774C6F4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGISPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGISPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 14:15:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9DCE1;
        Sun,  9 Jul 2023 11:15:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so610571a12.1;
        Sun, 09 Jul 2023 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688926504; x=1691518504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57/DKKkczSnhAi5y9UitWkgGZTdh91iHF+xGOadtOFM=;
        b=JqgAROm8i61wufU7LuF28KU0aXCGQddOImOAfyTB426/c17WRmkd2T9T6Anm2TvHIV
         g6D48+umt9NmkM5YgI3n8k7yu12SNcLBLgf10KbhKVX1ebjYDKY0GALjwfBvMUNejs9J
         uZpmNDdGumcoT+hcqy63eizDWDcV4eavXaoP+kxhX50PKCqTiYyNbymKkCxvYrXQ91XB
         N27asGrmywii8+cJsmzgvYhgkAe4xYHXQxDwW2GMS3dXawPWzKLPt4PkaSTjPV++Ae2Y
         Q+WLZ20K4jX4058RQlVd8ouF00vPE3TKtkGXmCsIoV2WJMhGhr31UDUk9Bdq94hc4WMj
         HLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688926504; x=1691518504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57/DKKkczSnhAi5y9UitWkgGZTdh91iHF+xGOadtOFM=;
        b=e4UjPhOA0DJ4iyNrjiL+o28vondd4TLGhQCn3SQHLzFS+wWUTi2v8ABKcm2ZDJMbmi
         EqSLgQ6+EEqEYzgorxoN/j3ff/J2TGFT9DlY/4ku5WDcyJShshz59+j62X0XqODlKxpM
         /mehWU02SqiIt2rJjXD/n1oS5UvOwo0bqmgjlIXmIe8ZHkG/GnWw170ZSPaS/MvqCEIw
         d99Lr6u/Q3TygjDBMG/0hwY814IaU1hTcTAjZY8ORYWNgr4Yw20nsFqem0jRkUxVJIdh
         P3V0I3kTd8IyR3bmF0DT18CNIO0ijBsgSzVlFD1/Uf29vSON6J9ytBR2YlGBeo+Ov7xz
         7r/Q==
X-Gm-Message-State: ABy/qLZi2aX1Nn9k4I0EeLX/RzZYkyFJ4tc1M9totUQlKvW6LYJzfwXB
        422PIYBbM6aeC+ZcAJv9WRycV/znb9JVQDE2Te0=
X-Google-Smtp-Source: APBJJlFIP798NTJcxwR8lUhj9TiP8qI9WcDYYSMIaZ7DeB5aDYU8XrCnz/MEGfHSgG8l7bba+Zi7W6//YHVXuUPnOnk=
X-Received: by 2002:aa7:d1d9:0:b0:51e:ed6:df38 with SMTP id
 g25-20020aa7d1d9000000b0051e0ed6df38mr9224006edp.13.1688926503676; Sun, 09
 Jul 2023 11:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_513E2ED35A17B9569C91CF75664724C7620A@qq.com> <d60c850cbfa5a25fcf97eef724f5b701@208suo.com>
In-Reply-To: <d60c850cbfa5a25fcf97eef724f5b701@208suo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jul 2023 21:14:27 +0300
Message-ID: <CAHp75VcbUOuQ9_2VL9mcs3e1x=ZOV5yd+c1U_iE24G5k-Uk7AA@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: prefer 'unsigned int' to bare use of 'unsigned'
To:     xuanzhenggang001@208suo.com
Cc:     ardb@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org
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

On Sun, Jul 9, 2023 at 5:20=E2=80=AFAM <xuanzhenggang001@208suo.com> wrote:
>
> This patch fixes the following checkpatch warning:
> arch/x86/platform/efi/efi_64.c:109: WARNING: Prefer 'unsigned int' to
> bare use of 'unsigned'
> arch/x86/platform/efi/efi_64.c:177: WARNING: Prefer 'unsigned int' to
> bare use of 'unsigned'
> arch/x86/platform/efi/efi_64.c:182: WARNING: Prefer 'unsigned int' to
> bare use of 'unsigned'

> -int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned
> num_pages)
> +int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned int
> num_pages)

Nice, but you shouldn't just blindly do some mechanic "fixes". Now
your patch makes differences between the function prototype and its
implementation.

--=20
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C01722D71
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjFERQz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjFERQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:16:54 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862CDF2;
        Mon,  5 Jun 2023 10:16:52 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94ea38c90ccso99621366b.1;
        Mon, 05 Jun 2023 10:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985411; x=1688577411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIbP3FT06Bqfrrnf4uXT+R2nnTjQ/h9BisXJxhTGbb4=;
        b=T2RemKIhb957Cf+M930edgAZ8DOcKpSOFXIh00hvVWjIHbRrnMBJ8RMJNA4jrx7uKr
         GLFGHySolIn5lOBJjVsLCJEdjRts+LLYIvBZx/TNIHnQYKEspGeE4yoxLytsQN8sE4EZ
         0b5V/pIaKdgqdhz2Bzj24RLX+4i3Sf5jppdEz0c6oOrsoSywai6nQTny+kf4NoeXX6Pr
         j0cBGjPYRjm3bIzWCG986cQpmOoCasGdsNt+UWbVH0IQgHTBvkY18r2VavLWY6IOAWPv
         mUYhz/Id7mKD+qQ68XTUbxVLDOPLPRkLY5Al5zT3/+MysYY96TtvszAVfVCmy1L25WsQ
         c/cg==
X-Gm-Message-State: AC+VfDzvt2+xwPzoe7SGd1rFsxjr5g3DomljFH8S86cKplBMiDuJ2ENi
        nYEqtpGAEhbJXiDpbn8qEsH9fQDhHuhFg44gmeQ=
X-Google-Smtp-Source: ACHHUZ5ATJMAgTFQRLZaSki3/or39XJvk7wjX5ejaDkoA8irtuJEsa6KEt3JSSP/xpbRH8puvn/A7k+6d8IMesvJDYg=
X-Received: by 2002:a17:906:1d9:b0:974:ae1d:ad0b with SMTP id
 25-20020a17090601d900b00974ae1dad0bmr8058822ejj.3.1685985410685; Mon, 05 Jun
 2023 10:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213319.3304080-1-arnd@kernel.org>
In-Reply-To: <20230601213319.3304080-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Jun 2023 19:16:39 +0200
Message-ID: <CAJZ5v0gvs=3GVE_1GpP1mKsQAkc0+gC6AQYoWP7r+60kUtjfAw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: s2idle: fix section mismatch warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        Manyi Li <limanyi@uniontech.com>,
        Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 11:33 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The acpi_sleep_suspend_setup() function is missing an __init annotation,
> which causes a warning in rare configurations that end up not inlining
> it into its caller:
>
> WARNING: modpost: vmlinux.o: section mismatch in reference: acpi_sleep_suspend_setup (section: .text) -> acpi_s2idle_setup (section: .init.text)
>
> It's only called from an __init function, so adding the annotation is
> correct here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/sleep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 72470b9f16c45..552adc04743b5 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -840,7 +840,7 @@ void __weak acpi_s2idle_setup(void)
>         s2idle_set_ops(&acpi_s2idle_ops);
>  }
>
> -static void acpi_sleep_suspend_setup(void)
> +static void __init acpi_sleep_suspend_setup(void)
>  {
>         bool suspend_ops_needed = false;
>         int i;
> --

Applied as 6.5 material, thanks!

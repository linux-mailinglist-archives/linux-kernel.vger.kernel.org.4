Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6A6CC645
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjC1P2n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjC1P2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:28:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54ABDE0;
        Tue, 28 Mar 2023 08:27:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so51127740edb.13;
        Tue, 28 Mar 2023 08:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALVybUnAV54ozvibHmKaFENlN7wm2q95bQqB2mKer5Q=;
        b=rD1ojgT2pNLbxr8IEnuaS3NLqOu57SUE6CSxB/rG/Sf9VxMYI4AXlpHODoyv/17CEz
         R6fQqTAK16xbuA5AK5PP7sYCD1v2pyQ66wXlDCDCcJOS1CDR3c3Tk2m82bzY33R+M6k9
         NMya29YoK+cDJjTnBjhz8VhpG9lBkndYobf94WEujufU5aNbxLrcNqrYDQ4IDNC7ez48
         rFsV6/toZCyXfPlsuz4BJfczCp7aoPAvHWP5rBMaXNb/wUHdU1oBx38M0/tx5+AcE/QT
         NQoxhLWXZbXE4F97vcRQAB+GgINbzgOA/sDhpaKrDH55zCDG0YlJgkLTsRQpettHsIhA
         +ADw==
X-Gm-Message-State: AAQBX9ciFysp26SGQvrCyi5LL0wL6jK3tqpfuFVwbOJuYVlKoO8UcnqW
        n36QOIpJYNKEkEwsChv/AnmipWxYMMB6q4jjTCg=
X-Google-Smtp-Source: AKy350a5DWG8ejDtuGwU0IUxCtgKGBKbB6HM7fJqI2byfWZHnQyiIrytaI7S62mVYzC0O1Mhxg2hGaIuXjdXamF6wYY=
X-Received: by 2002:a17:906:fe49:b0:8b1:3298:c587 with SMTP id
 wz9-20020a170906fe4900b008b13298c587mr8592629ejb.2.1680016926814; Tue, 28 Mar
 2023 08:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230328015120.111168-1-yijiangshan@kylinos.cn>
In-Reply-To: <20230328015120.111168-1-yijiangshan@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Mar 2023 17:21:55 +0200
Message-ID: <CAJZ5v0i3Ew=LPPzVw5Vtttpq+H=YuCrU_LN1b7W9Kj0v5JQ5gA@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi/acpica/exserial.c: replace ternary operator
 with min()
To:     Jiangshan Yi <yijiangshan@kylinos.cn>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, 13667453960@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 3:52 AM Jiangshan Yi <yijiangshan@kylinos.cn> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/acpi/acpica/exserial.c:346: WARNING opportunity for min().
>
> min() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

ACPICA changes need to be submitted as pull requests to the upstream
project on GitHub.  When that happens, a Linux patch based on an
upstream ACPICA PR can be submitted with a Link: tag pointing to that
PR.

Thanks!

> ---
>  drivers/acpi/acpica/exserial.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
> index fd63f2042514..dfe507e0a09a 100644
> --- a/drivers/acpi/acpica/exserial.c
> +++ b/drivers/acpi/acpica/exserial.c
> @@ -343,8 +343,7 @@ acpi_ex_write_serial_bus(union acpi_operand_object *source_desc,
>         /* Copy the input buffer data to the transfer buffer */
>
>         buffer = buffer_desc->buffer.pointer;
> -       data_length = (buffer_length < source_desc->buffer.length ?
> -                      buffer_length : source_desc->buffer.length);
> +       data_length = min(buffer_length, source_desc->buffer.length);
>         memcpy(buffer, source_desc->buffer.pointer, data_length);
>
>         /* Lock entire transaction if requested */
> --
> 2.27.0
>

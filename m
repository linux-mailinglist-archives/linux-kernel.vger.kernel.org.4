Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECC73053D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjFNQms convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 12:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjFNQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:40:53 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3D1A3;
        Wed, 14 Jun 2023 09:40:51 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9827714a479so20576866b.1;
        Wed, 14 Jun 2023 09:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686760850; x=1689352850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwP8ISPxM7coZuH76hmCT9/ShjhIdsbTHWg6APCgEzg=;
        b=XhSuRpoVqxlUxGhCr4t+J1QosQdsk1ILeKx6ouA9HpLsOV1SSEirgKee+S2lgJ+/RQ
         mA0sDEHyz60hCdNQQZSjRvJ9ZicfkcOjH5BX7VYwfqER35BE9ePPBtHM0l7GgatLS/qC
         YP6lUOCl6N8x3EGKzXz30K/dDIv/12a2P6XLVOQmgb3DkFtUMygMgeyypElRA4zHVNnj
         QzXEPO+2zWQ2Tu+NTBF5LURwRVYA23Dy0BVAlxf3Z0RmNP4MsfjUeautPQtXkdjo9BX9
         kZXVOMTq8M7ue78Cio9yqw84LLBbtzcDqT5P2zsyTsRgK0diuwgPtHswoEXxAdJeo+Sr
         LgBA==
X-Gm-Message-State: AC+VfDzDZSw0b/JzQmo7XMq7wx+i9uFDz3PcCya0tnoGHyAmiiGitDRJ
        Y0QvGvjVbW31tHPtUGQBdHdyXZOLf5StFDjF0lbBk1RgFt0=
X-Google-Smtp-Source: ACHHUZ5Fp2mU2+vCa5yHZKoCqycOljtbSUiIkTkPxOpmUPeD6y92hCOBYMiS/gN063oFxAL76FjPWL4fal9DiE4E9DE=
X-Received: by 2002:a17:906:7791:b0:975:942b:ee43 with SMTP id
 s17-20020a170906779100b00975942bee43mr2233469ejm.5.1686760850265; Wed, 14 Jun
 2023 09:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230614162112.122816-1-cymi20@fudan.edu.cn>
In-Reply-To: <20230614162112.122816-1-cymi20@fudan.edu.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jun 2023 18:40:39 +0200
Message-ID: <CAJZ5v0iZMHmgGE7ZTmOghHtWPXECx5HFt2a1NBNwABBX0CQBeg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix missing check for return value of acpi_ns_get_attached_object()
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jun 14, 2023 at 6:21 PM Chenyuan Mi <cymi20@fudan.edu.cn> wrote:
>
> The acpi_ns_get_attached_object() function may return
> NULL, which may cause null pointer deference, and most
> other callsites of acpi_ns_get_attached_object() do
> Null check. Add Null check for return value of
> acpi_ns_get_attached_object().

But may acpi_ex_prep_field_value() be called in a code path where
acpi_ns_get_attached_object(i) can return NULL?

I mean, if the given attached object is guaranteed to exist when this
function is called, NULL will not be returned, so the new check will
be redundant then.

> Found by our static analysis tool.
>
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> ---
>  drivers/acpi/acpica/exprep.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
> index 08196fa17080..d9c006ec1ac8 100644
> --- a/drivers/acpi/acpica/exprep.c
> +++ b/drivers/acpi/acpica/exprep.c
> @@ -431,6 +431,13 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
>                 obj_desc->field.region_obj =
>                     acpi_ns_get_attached_object(info->region_node);
>
> +               if (!obj_desc->field.region_obj) {
> +                       ACPI_ERROR((AE_INFO,
> +                                   "Null Region Object during field prep"));
> +                       acpi_ut_delete_object_desc(obj_desc);
> +                       return_ACPI_STATUS(AE_AML_INTERNAL);
> +               }
> +
>                 /* Fields specific to generic_serial_bus fields */
>
>                 obj_desc->field.access_length = info->access_length;
> --
> 2.17.1
>

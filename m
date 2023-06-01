Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB0771F1C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjFASWB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjFASV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:21:59 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D51B0;
        Thu,  1 Jun 2023 11:21:49 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9740c1c4a24so1039466b.1;
        Thu, 01 Jun 2023 11:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685643708; x=1688235708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqCUqDYksVNvqeVQHZgCHSSKZ/7/hLGB68zLmIOsRUs=;
        b=BbrVD/BHeKpIWSRmifzDN25cNF/57QQeIRJ+QSYeuuuVodg+3spB721fiOcvj+8AqR
         Hgeyz+kholFZqqfmZ05RpsGDegKa41ApomZ0538zWnKKkZHvbc+GxBujNQ+KZbQ11tfk
         JTitKu0X95G44Pm2ThTa9NUbmFunr9vYMY6qQtQ/U9iN++inVKD1xRwHnoq65WAMFtGB
         QVD2ZCwZQoNQV9WeRFaGxfBCCOSvNuXJq34byusY6M/hZowuLzfjoesdqRhbmT/pAPDO
         qptBCaaJxkGvhTfEZyCaRj51mzY0rXCQDVmVaDqKfsY/dcd+Zlps/5sNzVTBULIDFsPs
         NiGQ==
X-Gm-Message-State: AC+VfDzusF2KKFCNjdbpz/7Gtd1jO/eyvg0zYtFCmvlVe4P3tgwICyRU
        bjUnlcMHwDf0YeUnmDQcRnbzaXjEKHCVQgw5JjU=
X-Google-Smtp-Source: ACHHUZ4vxX+rKzsnlhWpc+E25cJv5aDvF3bra5I+gLszk30gfyuQi9JZeUSRLiKI+wtuKlhDdh7we6SPxQ03g4Q4E5s=
X-Received: by 2002:a17:906:7791:b0:96f:6590:cbdb with SMTP id
 s17-20020a170906779100b0096f6590cbdbmr5026678ejm.6.1685643707928; Thu, 01 Jun
 2023 11:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230523161815.3083-1-wyes.karny@amd.com> <168563860014.2889935.9236369807138013890.b4-ty@chromium.org>
In-Reply-To: <168563860014.2889935.9236369807138013890.b4-ty@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Jun 2023 20:21:36 +0200
Message-ID: <CAJZ5v0jpZQ-kMikEPUvuESxX+OMVyx97zDxavs9WhTiyu7ZA1g@mail.gmail.com>
Subject: Re: [PATCH] acpi: Replace struct acpi_table_slit 1-element array with flex-array
To:     Kees Cook <keescook@chromium.org>
Cc:     lenb@kernel.org, rafael@kernel.org, wyes.karny@amd.com,
        robert.moore@intel.com, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 6:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, 23 May 2023 16:18:15 +0000, Wyes Karny wrote:
> > struct acpi_table_slit is used for copying System Locality Information
> > Table data from ACPI tables. Here `entry` is a flex array but it was
> > using ancient 1-element fake flexible array, which has been deprecated.
> > Replace it with a C99 flexible array.
> >
> >
>
> Since this is a fix for -fstrict-flex-arrays=3, I can carry this in the
> hardening tree until it shows up in upstream ACPICA.
>
> Applied to for-next/hardening, thanks!
>
> [1/1] acpi: Replace struct acpi_table_slit 1-element array with flex-array
>       https://git.kernel.org/kees/c/0233ca593eba

Works for me, thanks!

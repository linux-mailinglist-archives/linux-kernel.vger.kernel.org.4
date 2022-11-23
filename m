Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70B46368DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiKWSbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbiKWSao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:30:44 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620958BD1;
        Wed, 23 Nov 2022 10:30:37 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id s4so11790073qtx.6;
        Wed, 23 Nov 2022 10:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aEILFREgMjioCoopFHYCy4vYqbtsoJQrV29gVAwV1c=;
        b=5/dV6aKaJtmylSxqr2+Yj0UTbIMsGSyQs3t9FjO8XiDV97cDABPM4mYVOgaXSfcHnx
         DntkgtI2cIa+u1nbo29rlFaWejQZO6D8Zni8N+zJ0vF+QsTxiZi0Iiao5l1fKUh5SLhh
         nHgf3a2oudV8y1HjUCSZqcIevKhdtBODPLC2TUhF9xyS2RPB9m9adK02AzaDVyn4KPzn
         Hu3YnBG0jXvV9sKsldiQHohEL+pyTqg03AyfEPFB5Z4mnnzLU3mzDIEh9jyioUkAbTY3
         tVoub20plgTYfDSoEhmic072JcC2RqjM0gSPJ/PVEU9i56O0sH6hhbAgCTSQtsfUcc1k
         iZGA==
X-Gm-Message-State: ANoB5pka6cJg2VEjPcMNw8IWpyPQEbXS+DqUkdfns0Rs6xi9MgXU8iIm
        IoQgVoNZXq2yYk5cBO9DmvKEPaCESeFzGgISucQ=
X-Google-Smtp-Source: AA0mqf4wgdf0Gr6B06OaRDRN8iPr9JHzG4fp4lvkkzLJ8c8VBEZI7N+B+f0IKubWNPgXecmN1RI2ugRhZB2K/D+Brls=
X-Received: by 2002:ac8:60d3:0:b0:3a5:4678:5b24 with SMTP id
 i19-20020ac860d3000000b003a546785b24mr27445699qtm.411.1669228236813; Wed, 23
 Nov 2022 10:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20221118063219.2612473-1-bobo.shaobowang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 19:30:25 +0100
Message-ID: <CAJZ5v0i34XTWzV-PnrC1JZ7sTWcRDF9rDsoZ0N+GEHOH9zeWfw@mail.gmail.com>
Subject: Re: [PATCH 0/2] change to use ACPI_FREE() to free the ACPI memory
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org, lenb@kernel.org,
        yu.c.chen@intel.com, linux-acpi@vger.kernel.org,
        guohanjun@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 7:33 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>
> acpi_evaluate_dsm_typed()/acpi_evaluate_dsm() should be coupled with
> ACPI_FREE() to free the ACPI memory, because we need to track the
> allocation of acpi_object when ACPI_DBG_TRACK_ALLOCATIONS enabled,
> so use ACPI_FREE() instead of kfree().
>
> Wang ShaoBo (2):
>   ACPI: pfr_telemetry: use ACPI_FREE() to free acpi_object
>   ACPI: pfr_update: use ACPI_FREE() to free acpi_object
>
>  drivers/acpi/pfr_telemetry.c | 6 +++---
>  drivers/acpi/pfr_update.c    | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> --

Both applied as 6.2 material, thanks!

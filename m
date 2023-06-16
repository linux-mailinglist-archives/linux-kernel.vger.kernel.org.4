Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0BA7337B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjFPRzc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 13:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344957AbjFPRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:55:25 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF65C3A89;
        Fri, 16 Jun 2023 10:55:19 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-94ea38c90ccso28993966b.1;
        Fri, 16 Jun 2023 10:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686938118; x=1689530118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmdUcFmDIHlF7HNhb9E+Wkb+wdo7Gt9DP5LMS8GUDQ8=;
        b=cUfQu6dyYyQBOLVYERgd2yelS3heFp8ekktfScc4ItP/JXuaD1ELkWnPu+Ati3lefl
         mb2GxwlWXowaihCn9No1R9QhnGol8ryxhRbTimLeBwXI1iUedvQPWAOSCmq0MO/8nVxi
         DHZC2Hu1TJLy+7jGDgb7AtyKdSGI/O+EEwBccwBluV47oiA00V5l++9f6+tZk/T30kNo
         bTbc0RnYriHqCPrjlkQpXNkfigjnd8NSFrZiAWVXv1Enr6eQn/zQvajfsiar1euKeau1
         JQDmXG4U4Ittajc+hzSpSadz/PGAl+3+Cy4jgRsOtJyOCgmQm9fZKUeqRJYxGuF4Ep4y
         rR8w==
X-Gm-Message-State: AC+VfDwuY8BXPNkbUc68KQdK5/fCbywrkjcPASkjmCff8a22oZgw4WPf
        IjJVpDZuSwIqBoRSL33PNygFpaq6oGmfk+3sf9AS3VM+
X-Google-Smtp-Source: ACHHUZ6mZRWVEeHl7/kUKp1yAMVlNmsMXikDXdemoqUgcPXO7I1uW8lktQz9b924tyX9E9JBp8X7v17xDGxTuIOhyNQ=
X-Received: by 2002:a17:906:7292:b0:982:a4ac:f79a with SMTP id
 b18-20020a170906729200b00982a4acf79amr1964777ejl.7.1686938118240; Fri, 16 Jun
 2023 10:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 19:55:07 +0200
Message-ID: <CAJZ5v0hgNMWNtkAF7YY24cFvsnGYYYHMW1c4NekaNmyqYf=0tA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] device property: Introduce device_is_compatible()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
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

On Mon, Jun 12, 2023 at 6:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Introduce a new helper to tell if device (node) is compatible to the
> given string value. This will help some drivers to get rid of unneeded
> OF APIs/etc and in may help others to be agnostic to OF/ACPI.
>
> While doing it, I have noticed that ACPI_DEVICE_CLASS() macro seems
> defined in unsuitable location. Move it to the better one.
>
> Last patch is an example of what the first two are doing.
>
> The entire series can go, I believe, via ACPI (linux-pm) tree in case
> the last patch gets tag from the respective maintainer.
>
> In v3:
> - added tag to patch 1 (Rafael), patches 2&3 (Sakari)
> - made commit message text wider in patch 3 (Sakari)
>
> In v2:
> - updated commit message and added kernel doc for a new API (Greg)
> - also replaced acpi_device_get_match_data() with the agnostic API
> - tried to keep header inclusions ordered (to some extent)
>
> Andy Shevchenko (3):
>   ACPI: Move ACPI_DEVICE_CLASS() to mod_devicetable.h
>   device property: Implement device_is_compatible()
>   ata: ahci_platform: Make code agnostic to OF/ACPI
>
>  drivers/ata/ahci_platform.c     |  8 ++++----
>  include/linux/acpi.h            | 14 --------------
>  include/linux/mod_devicetable.h | 13 +++++++++++++
>  include/linux/property.h        | 12 ++++++++++++
>  4 files changed, 29 insertions(+), 18 deletions(-)
>
> --

All applied as 6.5 material, thanks!

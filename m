Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB06C70FD79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjEXSG2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjEXSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:06:26 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C37E7;
        Wed, 24 May 2023 11:06:23 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9739440b60bso10041766b.0;
        Wed, 24 May 2023 11:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951581; x=1687543581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCb55Zgn6mVQwYnYnhdrcQMfFu1FfHYcI82tnxgFFXY=;
        b=TB8LWL7r9QMoFuxPJYnPwdKXpm7lla4zdSzM9yN/KwAUtvdcJJiR2jsKXUazIbGS7H
         Yw+7ibdssgQVJT3nyJR2w1PqPfV5Ld55iLrh9SSZxf84O6M80ZjuoY/R1/vzeRHNHajI
         j/nSkiEJaSMm96Kb7kob2DalbOsNI3UglLIPPlorxYWFJLMtD+NfUCpeTa2DGe9+2fAW
         QyGN1hpkhmSxMgJAn9rOQx2sBidhkh2zT4vWrklgYXX+rYX9WeV8Sysm47M97EhzQ7aR
         cOLEEDlpoWpNIxrdZ1Zw3466vHL83yHv0/0ZTG47B02bP978mEObVJgB3MjhFrmdnfB+
         aQgg==
X-Gm-Message-State: AC+VfDztXK5D7mEw+UGlWFDnx8gEcW1+/qBhF24WE9/S9pL7S22Nc0I8
        mD33V57iJ5gipp98Qecty6dmwTA2CLjb1P23LNiAzqXH
X-Google-Smtp-Source: ACHHUZ4Zau31Zkqmffi9M8T99R9vE1X8UU2tRT/1M11kJ81h2dfM+6yB1chLKny5LEPIzuZcNbHgeerTLPjpRJfoU0w=
X-Received: by 2002:a17:906:739d:b0:965:9db5:3821 with SMTP id
 f29-20020a170906739d00b009659db53821mr17548734ejl.7.1684951580645; Wed, 24
 May 2023 11:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <13276375.uLZWGnKmhe@kreacher>
In-Reply-To: <13276375.uLZWGnKmhe@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 20:06:09 +0200
Message-ID: <CAJZ5v0gKaheHVfRcgFx_3JdBp9bw5nUQXYp9vZP4RVVXzdb7uw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] ACPI: scan: MIPI DiSco for Imaging support
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

On Wed, May 24, 2023 at 1:48 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Folks,
>
> This basically is a re-write of a recent patch series from Sakari:
>
> https://lore.kernel.org/linux-acpi/20230329100951.1522322-1-sakari.ailus@linux.intel.com
>
> The general idea is the same - CSI-2 resource descriptors, introduced in
> ACPI 6.4 and defined by
>
> https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-interface-csi-2-connection-resource-descriptor
>
> are found and used for creating a set of software nodes that represent the CSI-2
> connection graph.
>
> These software nodes need to be available before any scan handlers or ACPI drivers
> are bound to any struct acpi_device objects, so all of that is done at the early
> stage of ACPI device enumeration, but unnecessary ACPI namespace walks are avoided.
>
> The CSI-2 software nodes are populated with data extracted from the CSI-2 resource
> descriptors themselves and from device properties defined by the MIPI DiSco for
> Imaging specification (see https://www.mipi.org/specifications/mipi-disco-imaging).
>
> Patches [4,6/6] come from the original series directly, but the other patches have
> been changes substantially, so I've decided to re-start patch series versioning from
> scratch.
>
> This series is based on the patch at
>
> https://patchwork.kernel.org/project/linux-acpi/patch/12223415.O9o76ZdvQC@kreacher/
>
> applied on top of 6.4-rc3.
>
> Later on, I'll put all of this material into a special git branch for easier
> access.

The patches are now available from the acpi-mipi-disco-imaging branch
in the linux-pm.git tree at kernel.org.

Thanks!

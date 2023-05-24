Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5275370F5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjEXL43 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEXL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:56:27 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F37B184;
        Wed, 24 May 2023 04:56:23 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510f866ce78so250345a12.1;
        Wed, 24 May 2023 04:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684929381; x=1687521381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts8juLbk9tH3TciBEO7YqwijEpAwtpNwIl+U8f3UTMQ=;
        b=kpBoJh4DkxP+iwsgPqfDjse7EMYHRBOuefhjwRClfwJFuoHkFg6fWME7fU1Ir2HyKc
         OLxvWXZ9QIplw77e6XduYrEZx6i0wQ65ixmeV/cSMP7K9knh/M3e9k6FpgWIFG/H0POk
         caIS6TvonWmo1wq3kgCjos+DUFbRIyZO3+5lXERnG58twLwvGxhKTVkv85ALHUUq/Tp/
         QTq6ZZBoZPIInlZnhCCM6G5NyWhzyUxBRba5qtHdkxVkNC721u2Zk9J9nAPrrWYRZry1
         bAkSlcxw73dWqXQZt2yfvYYXnMnPI2faaFDD4bUdTHqgmXUWs5IqDyRqK0RKC4Kx4q2L
         QpfQ==
X-Gm-Message-State: AC+VfDy2/6owOawSENdBtQROq+4t39IvklLvzZGC90YOOoiWqAL4xacS
        71YasAWWc8JZEY6AtOUBfTuZ5/AHWA0/NdX1fEf/PS7PDlM=
X-Google-Smtp-Source: ACHHUZ7MT06b3lSwEViVMQBGKwn1Lr58MTA/6lavX4RbfWS9M+/gFm0HhFbW7cCnvW8F4QI1XvBsJe8rw+24fvc/UMk=
X-Received: by 2002:a17:906:2097:b0:965:86ed:ca6d with SMTP id
 23-20020a170906209700b0096586edca6dmr15549853ejq.0.1684929381339; Wed, 24 May
 2023 04:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <13276375.uLZWGnKmhe@kreacher>
In-Reply-To: <13276375.uLZWGnKmhe@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 13:56:09 +0200
Message-ID: <CAJZ5v0g+jD3WUQgvaLrFZ3etEcF486UpCemhrfUQKuOV1hjt_Q@mail.gmail.com>
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

I should have mentioned that the following two patches are not included:

https://patchwork.kernel.org/project/linux-acpi/patch/20230329100951.1522322-9-sakari.ailus@linux.intel.com/
https://patchwork.kernel.org/project/linux-acpi/patch/20230329100951.1522322-10-sakari.ailus@linux.intel.com/

because I don't agree with the idea of renaming device properties in place.

Also not included is the documentation patch, because comments are
added by the individual patches making changes in the code.

Thanks!

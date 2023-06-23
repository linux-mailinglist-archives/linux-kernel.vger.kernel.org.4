Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9473BACD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjFWOxr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjFWOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:53:36 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B4269A;
        Fri, 23 Jun 2023 07:53:14 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98273ae42d0so17806266b.0;
        Fri, 23 Jun 2023 07:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531988; x=1690123988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1qSDE3rPwykp1shfj1zuf+dGomt2YGKeLvj9O4itJ0=;
        b=NjpNjwuMY2ILaBcnCrcpK4gypMotclWRTuOTmi553v0REcZ62LUaIUHa4jIgqx+Ln0
         os1dbsdy00W6QY25hwxhPe20iYbc3ZUbruqJHGCMk5GqlpMa/iZq97usT38eN4jrA3ft
         fBacGqeB1h/tfifG8iU/gb9o557XgidiwtdfaYfoi0Gv1iaWX6iv951f3bbmxy39VuHq
         4hiVYUDjkhHvU4ahP1yvChV0ajaeWXPrlPqp1F7hmHVvKRLH19b/DUyK0NQgxiPzBBxA
         uH/5SxXKfNQJqmVW2+7Q2RQoXMCLCNoyTGgyH9nTg8z8LMdd4qkyqBZTQslw/MTfjFC7
         A0AA==
X-Gm-Message-State: AC+VfDxsA7wL0dVOghcMdrxRG833D2sL8mnphEvpfMtijX0f/lL3weTW
        Oag3LT1/v/AjFdWdF7JUviwOkJOb88fyK8sTtGhQGWNc
X-Google-Smtp-Source: ACHHUZ5lKngbPAW+7VngRAiWWJe0ho7IRCDTsQ/Y4uI+dieZpeESY0wwLG08AmNxxZUVhw6DGESa4zSWiOgClczXE2E=
X-Received: by 2002:a17:906:64cc:b0:987:115d:ba05 with SMTP id
 p12-20020a17090664cc00b00987115dba05mr17611355ejn.3.1687531988417; Fri, 23
 Jun 2023 07:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230621054603.1262299-1-evan.quan@amd.com> <20230621054603.1262299-2-evan.quan@amd.com>
In-Reply-To: <20230621054603.1262299-2-evan.quan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jun 2023 16:52:55 +0200
Message-ID: <CAJZ5v0iqy0yMJP5H7ub67R8R6i42=TcS_6+VF-+fWrM-9tYFQA@mail.gmail.com>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF mitigations
To:     Evan Quan <evan.quan@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mario.limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
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

On Wed, Jun 21, 2023 at 7:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
>
> To mitigate this, AMD has introduced an ACPI based mechanism that
> devices can use to notify active use of particular frequencies so
> that devices can make relative internal adjustments as necessary
> to avoid this resonance.
>
> In order for a device to support this, the expected flow for device
> driver or subsystems:
>
> Drivers/subsystems contributing frequencies:
>
> 1) During probe, check `wbrf_supported_producer` to see if WBRF supported

The prefix should be acpi_wbrf_ or acpi_amd_wbrf_ even, so it is clear
that this uses ACPI and is AMD-specific.

Whether or not there needs to be an intermediate library wrapped
around this is a different matter.

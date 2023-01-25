Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661EA67B5BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjAYPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjAYPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:20:48 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEE26583;
        Wed, 25 Jan 2023 07:20:47 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a37so20732372ljq.0;
        Wed, 25 Jan 2023 07:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA2k8GKSkaJ8JiRx7vynIxEnjRyi/3LR49biO0Zb0Dc=;
        b=ixTEenOPk/P28/WU27Zufkdc1V3U+/6IBKwUhocsiuw+38itv78CKYJIJm3IOPxZZh
         i+I5OzNOaSm1ilJLMkp+jKPUY0F6AY8m8Y2Cwsj+Y8qI8jKMhoBPei3zxJ9oehMAyShU
         PhwwAmOmols9U59QKZl6AMsxBjG3El/paycXsVjsVKrlrhBw6aj8slLejN1b+R0s9QaD
         TmH9wrXTjrJ5FrPvIvW2bYBhGb7flpPu8GQEPpgqXs0Xz2an4o9ImNOL50s50RwqvzXy
         QyVI4FIV3ss7L7nUtFffLVk1rXQRrFqUcYgMbf6L90I8kUVdqe9xsyl2fGvb6KskfYrf
         BUYA==
X-Gm-Message-State: AO0yUKXmbTAydZAGwzOumhfq49MvzXh/EWMms6YopzkVR3ek3mVBsXyK
        wxEznsPlAqbF9SnhPAHSQ8bmhs+kJYNlfIDTq3yttu65
X-Google-Smtp-Source: AMrXdXvLgZvoJvJqVmraThNQIStOeL24DaFIwzCkVTm8WaEP+sS95TlKL6RuNKiTDyWh6InzZ3GrXySUxCjLUSwLpiY=
X-Received: by 2002:a17:906:4e9a:b0:84d:4dc6:1c08 with SMTP id
 v26-20020a1709064e9a00b0084d4dc61c08mr5520786eju.421.1674660035333; Wed, 25
 Jan 2023 07:20:35 -0800 (PST)
MIME-Version: 1.0
References: <5665899.DvuYhMxLoT@kreacher>
In-Reply-To: <5665899.DvuYhMxLoT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Jan 2023 16:20:23 +0100
Message-ID: <CAJZ5v0iVqGoVq1TVvYoQLxRWnP1nTPe7seeQvbVPancxH_6J1g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: intel: int340x: Use generic trip points table
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Wed, Jan 25, 2023 at 3:55 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series replaces the following patch:
>
> https://patchwork.kernel.org/project/linux-pm/patch/2147918.irdbgypaU6@kreacher/
>
> but it has been almost completely rewritten, so I've dropped all tags from it.
>
> The most significant difference is that firmware-induced trip point updates are
> now handled in a less controversial manner (no renumbering, just temperature
> updates if applicable).
>
> Please refer to the individual patch changelogs for details.
>
> The series is on top of this patch:
>
> https://patchwork.kernel.org/project/linux-pm/patch/2688799.mvXUDI8C0e@kreacher/
>
> which applies on top of the linux-next branch in linux-pm.git from today.

There are two additional branches in linux-pm.git:

thermal-intel-fixes
thermal-intel-testing

The former is just fixes to go on top of 6.2-rc5 and the latter - this
series on top of those and the current thermal-intel branch I have
locally with the Intel thermal drivers changes for 6.3.

I would appreciate giving each of them a go in your test setup.

Cheers!

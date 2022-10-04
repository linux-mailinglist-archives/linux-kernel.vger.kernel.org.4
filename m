Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3875F47DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJDQqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJDQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:46:46 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA145BF76;
        Tue,  4 Oct 2022 09:46:44 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id i9so626637qvo.0;
        Tue, 04 Oct 2022 09:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWbK3HWU1NqOiGngwjnLkebxvT+CcA87eNz0phP+Y8I=;
        b=J9L5FmiY4O/gnFceyPw8fY5YfG/E8b+g/hNpGzPJdZ6CqeEiXuBnF07+vhdpsOQ75T
         zCbPFtz1gr6nsdfq1DvDT39KSZA90noCQYAPKL3X2YUrFr83AKtNCdMNBneb6mKm2E2H
         lgjGJju4NMC4ecglJxPFw4748kbjMivwlQ0b8WyFtzAUxndIXsX2pi+IVwTpjONkNegB
         Vx5194hVw0XO/8TxF6IzEMT2QIf8S+1hSGdaYNUKEHGM+HH8xEmHIlYUIFkWr5b7BmeG
         XtNMpYaBYJKOMWiBleW5zn4uZZO5MMgIiQBp8A6Dq0wZrLILmyBGFwknfy+BTXg52Tbo
         8QCA==
X-Gm-Message-State: ACrzQf23ur/V/S3k5kulFVIm9XuUTD3rJzzwAqU02xPHutklk5vWi6VR
        w9Oe4TWujYjkcCC30ZG5ALXPtT1JlznRJ39mLLE=
X-Google-Smtp-Source: AMsMyM44GIOPUIsIfeR8UwPLqzO+zVSWaPBk9dbX3swR7djvArKm9NicLJY5qd1mxdGmExX7HHGR/rcHBn8Cv688p+k=
X-Received: by 2002:a0c:9d91:0:b0:4b1:7809:4825 with SMTP id
 s17-20020a0c9d91000000b004b178094825mr14231399qvd.130.1664902003920; Tue, 04
 Oct 2022 09:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <12068304.O9o76ZdvQC@kreacher> <97e3971b-cb6a-634c-6c58-d4348c52767a@linaro.org>
In-Reply-To: <97e3971b-cb6a-634c-6c58-d4348c52767a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 18:46:32 +0200
Message-ID: <CAJZ5v0iPzamhD9yi=8fW6+5gRCFVyXnXtF+UA18B02b_WcwXiQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ACPI: thermal: Clean up simple things
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 6:45 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2022 18:28, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > I've just noticed that the ACPI thermal driver is in a need of extensive
> > cleanup, so here are just a few simple changes in that direction I would
> > like to get out of the table quickly before doing more intrusive stuff.
>
> I've done some cleanups in the ACPI driver. In order to not have
> duplicate effort, shall I send in response to this cover letter a RFC
> series, so we can join our efforts?

Well, I guess it won't hurt.

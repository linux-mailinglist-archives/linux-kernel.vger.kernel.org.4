Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22C6696585
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBNN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjBNN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:57:54 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13ABBB7;
        Tue, 14 Feb 2023 05:57:32 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id sa10so40233600ejc.9;
        Tue, 14 Feb 2023 05:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nmznzbw1bOIjwDiJ10Y1TrCJXhhnPxVRmXhihKNuSew=;
        b=JYKP8322sUNLaE9mx2v1oz44Q+ZPldJ+xG/rzylUOR4zjK43BSc9w3ecOViYdzCMpQ
         tR6kKj4o+F+Aa9QMBXorEqvcKcTxg9qVcqsDHLgY3cz/bBY92W46JWwMWbcVA0Hm7GYP
         WqGtdcNxq3LbyOShrvK54G9OEGjwD4jYcj3ReUW8F8ZVvnzZWc1JiPgAq3b+p/qeqmQO
         vrH5swaFugCTTXCNZMIPbal0nLgPGRR5G95BkpmdtN6MjKLf7jqBMvBzL5IkErHqcAJU
         S6P/wQeF04RdnwmkGGpQ4RKb2P9YVUE3mWkQfdImmVEfQuj9RLAy1P/jtbF/Ht3LGj6+
         VIFQ==
X-Gm-Message-State: AO0yUKVozrWqNlrwjSzC1JADsZiAN0c31FgOtC71xxbsxu5Ea6EvGDed
        FAR4BOQ4Uq618h4mc7Ye+mQk0hAkKJ3kg+5Gapk=
X-Google-Smtp-Source: AK7set+uH6pcyxWm+CEeJiXxPUp7JSWQ/TgSg6q3J/PDPXX1EWcHvLVs/oUrQCd74L4gVYpt65P1stogFSdSmylmYaM=
X-Received: by 2002:a17:906:e28a:b0:8b1:3298:c587 with SMTP id
 gg10-20020a170906e28a00b008b13298c587mr770691ejb.2.1676383033916; Tue, 14 Feb
 2023 05:57:13 -0800 (PST)
MIME-Version: 1.0
References: <12138067.O9o76ZdvQC@kreacher> <12124970.O9o76ZdvQC@kreacher>
 <mafs0sfgybc3q.fsf_-_@amazon.de> <CAJZ5v0hAjKvinPqX2VuCv1jVu50jrnDpECaO=sA2CQZFHZpJdA@mail.gmail.com>
 <mafs0zga0ds30.fsf_-_@amazon.de> <CAJZ5v0j1CBe7Hjhg7Tzm3HkuinA9zgtPffMtd96ZaOds=US+xQ@mail.gmail.com>
 <0f74e16d2a1c5005c342d800445c046b8fe248cb.camel@linux.intel.com>
In-Reply-To: <0f74e16d2a1c5005c342d800445c046b8fe248cb.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 14:57:02 +0100
Message-ID: <CAJZ5v0g1PiMDFUeVKy3YL4pni6oDDaEVTw-LLYnYMMsF+5uuMQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: processor: perflib: Use the "no limit"
 frequency QoS
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 2:40 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2023-01-30 at 15:58 +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 30, 2023 at 3:18 PM Pratyush Yadav <ptyadav@amazon.de>
> > wrote:
> > >
> > >
>
> [...]
>
> > > [0]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
> >
> > It's already in the mainline:
> >
> > e8a0e30b742f cpufreq: intel_pstate: Drop ACPI _PSS states table
> > patching
> > 99387b016022 ACPI: processor: perflib: Avoid updating frequency QoS
> > unnecessarily
> > c02d5feb6e2f ACPI: processor: perflib: Use the "no limit" frequency
> > QoS
>
> I am checking 6.2-rc8.
> I don't see these commits.

You are right, they are in linux-next only, sorry for the confusion.

I'm going to push them for 6.3-rc1 this week, though.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178B1656CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiL0QP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiL0QPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:15:24 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962ECFD;
        Tue, 27 Dec 2022 08:15:23 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id z12so10737459qtv.5;
        Tue, 27 Dec 2022 08:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4/jvC6LoaYDJ2i8XVmPXWzut9eNTEwxTOlFn2Vt940=;
        b=Cw7jkicRBv7smswkKIoL/N4qsUYHYTKAMB9IgmPEdAPWnSSb/V6b2hFLdWdycvdNo0
         ulmOnYtqO2TsU/eLA369GW1LoU/BR8D+ajIYyUp6QfBYMdVtPwlZcpN8LM3YJuypHawj
         QKpHS34GUmbf0ZWM45A2GQPyLJWbNgdQuxAGXWhXPDlTHULFI28mYDosZ0u+yk7bbSuZ
         dRpHXryZfJdMsbAp56QOeS4C5/rD/6oxDORRG4Yr41MGExC049qcamMV2do7C4wlgCc/
         oXsj9IB2nWM9ASRa9wzORZKRClN6PC25kCEIZbkpmW/iHgJ3rUNJczu6dsVS9OtB+uGV
         qpag==
X-Gm-Message-State: AFqh2kpEu846pMFTtjN2QPIJ7nTrwbJ2hLlHtKZPbZJBremNrwqpx0kL
        dKDcqkQ/CQyC9yoMfIjh08eB9nqwNcSU8j3Itlk=
X-Google-Smtp-Source: AMrXdXvRDw3yOr3HtrbwIr8ZhcWwC4vGUgYDiilUUSb0o6WeawkXxFnn+dmx0hrzDSK9PI1LIshF9D1SRNyjac9PaMc=
X-Received: by 2002:ac8:749a:0:b0:3a6:8dd0:4712 with SMTP id
 v26-20020ac8749a000000b003a68dd04712mr933793qtq.411.1672157723029; Tue, 27
 Dec 2022 08:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20221221155203.11347-1-ptyadav@amazon.de>
In-Reply-To: <20221221155203.11347-1-ptyadav@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Dec 2022 17:15:04 +0100
Message-ID: <CAJZ5v0jNB1UnwW8mW6Cu9qi4vdvH9twMRkGcSOcndv_SEDeoOA@mail.gmail.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
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

On Wed, Dec 21, 2022 at 4:52 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>
> When a processor is brought offline and online again, it is unable to
> use Turbo mode because the _PSS table does not contain the whole turbo
> frequency range, but only +1 MHz above the max non-turbo frequency.

That's because of the way P-state limits in the turbo range are
handled by the given processor.

Some of them restrict the P-state even if the limit is located within
the turbo range and some of them don't (that is, requesting any
P-state in the turbo range gives the processor a license to use the
whole of it).

> This causes problems when ACPI processor driver tries to set frequency
> constraints.

The problem is that acpi_processor_get_platform_limit() sets the limit
to the frequency for all of the _PSS states including the last special
one and it should update the QoS to "no limit" in that case.

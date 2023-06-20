Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA673679A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjFTJXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 05:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFTJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:23:40 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0220FD1;
        Tue, 20 Jun 2023 02:23:40 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-988a4a7be58so61679366b.0;
        Tue, 20 Jun 2023 02:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687253018; x=1689845018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn06othrxyUbjjcGIg6BI9HKgyVRJBi0nYrYtjCy59c=;
        b=NX+DItotG3JDe8jfuORZbDCJHMJLCkJgBojoP5E/b/8MrlSf+jSQRN16XU9UGVRSpc
         IQsewfTepgfc2IzyT0F5TIblswo7Sjdbg2evNmO43rtHMFEpIrF902SBrJDhRknLJ7Lh
         cWhkA93cSKGpxeU2xCZHy7USqVokz9Wivbrv9+nqZEfhLIn4gZYUagu6aD5N8wSKwgS1
         rYf4q1Zbr8ub51O3qkLvLgUCqKEW2QWUl/Er2IxNzUX6UoVHod3OJhyEqJOAJNR6dkMs
         lFXbXiEsKXLrDn8xraYYPgw1aPq+e+GTHgGjQtOsa5TApJIv8iF1lwR5COJqGCepA2WX
         BZ2Q==
X-Gm-Message-State: AC+VfDx8FNdZGVcT0CGCNRiGy3svaNscIwNYF//+25ifJPN0cMtQnX9m
        kGSks/3t/PLz2dIKNGxV4SAJSgFWE7AjUg7/OOo=
X-Google-Smtp-Source: ACHHUZ5DpoEOSGfriQ0VGQySempiEBTP+uJPizlOBgqmx3cVtWzLdqTfib10VpahFy8o/f+vf2hTbngsKSUKtUP5H0Q=
X-Received: by 2002:a17:906:74da:b0:974:5480:6270 with SMTP id
 z26-20020a17090674da00b0097454806270mr8285432ejl.0.1687253018265; Tue, 20 Jun
 2023 02:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230615063333.4030395-1-perry.yuan@amd.com> <CAJZ5v0hMEuiv71RoEfyBJ_Z83AvMWXfEvt9kBU2SmZyXvKSx4w@mail.gmail.com>
 <6973890d-3366-0fdb-6306-77a763a979d5@amd.com>
In-Reply-To: <6973890d-3366-0fdb-6306-77a763a979d5@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 11:23:21 +0200
Message-ID: <CAJZ5v0hw7eCAE+5NVyc_D=qriK21kZ8aJFOD0G4MBr0qjMLfUA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] cpufreq: intel_pstate: Use the acpi_pm_profile_server()
 symbol
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        viresh.kumar@linaro.org, Ray.Huang@amd.com, Deepak.Sharma@amd.com,
        Wyes.Karny@amd.com, gautham.shenoy@amd.com, Sunpeng.Li@amd.com,
        Xinmei.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 19, 2023 at 4:53 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 6/15/23 10:57, Rafael J. Wysocki wrote:
> > On Thu, Jun 15, 2023 at 8:35 AM Perry Yuan <perry.yuan@amd.com> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> Avoid duplication of functionality by using the generic symbol.
> >> This does have a functional change that intel-pstate will now
> >> match "SOHO server" as well.
> >
> > And why do you think that it is a good idea to change this behavior?
>
> The idea was to cover all possible server types. It seemed that it could
> be an oversight that it wasn't included initially.
>
> Is that not the case and it is "intentionally" not including "SOHO server"?

Yes, it is.

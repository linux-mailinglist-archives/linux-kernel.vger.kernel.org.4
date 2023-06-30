Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20125743A47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjF3LFl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjF3LFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:05:04 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9610E3C24;
        Fri, 30 Jun 2023 04:04:30 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b6993fd7d5so4504231fa.1;
        Fri, 30 Jun 2023 04:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688123069; x=1690715069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A07KMdYL5lwtSiNQs9uf0BCUOmidGfNE7gu5dbduzz4=;
        b=DNrVCKS5Kc3xxH5m/ynAJlGrLXEuy2+JKhVclkWMh+GMM7x2ORRxYjjRd8Xqf2j9Ig
         ZvoP2LrSr5hbgiVtR7SlS8shzVy1ntWBiriNXNsE+h+qgFhmMXDE1mPtwAZfEoABgwFR
         KxxhMUJbuf6kG88F9aQIH1/72jEOwQZbWkQjpoAygeWXkYNAoFTW3JVPO+yZb+SL74Gj
         WcDASAYgKh4jx83eEdQe6GzvhIUE4mRrHKsXdiyd10T9JXgEKEGy+Oc93mkCDuFd45Lk
         IvxUvJppAi55+Dw1BOZdm4vmW1Ai2JhO78/VWlbeUT22rrFScnDQOtt8LWAvXnHNbutL
         ApNg==
X-Gm-Message-State: ABy/qLZEZGZiAr8jkllOug9yzereleBKMV/fUkLkn3XT+jFZ8qdWlsXx
        tZ7djXStNUMSQQJ19euNSKb93a3wiML/W0sr7H8=
X-Google-Smtp-Source: APBJJlF84Z7MEMYLZcp2VfasQuRS8ZyWLfVEDomr86EbZXXaJb4YKeVw/k4pFkw68brAtYWA4X5t2UoM06gQM64Ar1U=
X-Received: by 2002:a2e:a41a:0:b0:2b6:9ebc:d8c4 with SMTP id
 p26-20020a2ea41a000000b002b69ebcd8c4mr1748262ljn.0.1688123068602; Fri, 30 Jun
 2023 04:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-9-michal.wilczynski@intel.com> <CAJZ5v0hPY=nermvRKiyqGg4R+jLW13B-MUr0exEuEnw33VUj7g@mail.gmail.com>
 <699b327d-acea-c51d-874a-85133b74a73c@intel.com>
In-Reply-To: <699b327d-acea-c51d-874a-85133b74a73c@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 13:04:17 +0200
Message-ID: <CAJZ5v0jpcas1TLGVR5Cic-bz4YkkAVypShj0sfEKUmy+930vVA@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] acpi/nfit: Improve terminator line in acpi_nfit_ids
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
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

On Fri, Jun 30, 2023 at 11:52 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 6/29/2023 6:14 PM, Rafael J. Wysocki wrote:
> > On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
> > <michal.wilczynski@intel.com> wrote:
> >> Currently terminator line contains redunant characters.
> > Well, they are terminating the list properly AFAICS, so they aren't
> > redundant and the size of it before and after the change is actually
> > the same, isn't it?
>
> This syntax is correct of course, but we have an internal guidelines specifically
> saying that terminator line should NOT contain a comma at the end. Justification:
>
> "Terminator line is established for the data structure arrays which may have unknown,
> to the caller, sizes. The purpose of it is to stop iteration over an array and avoid
> out-of-boundary access. Nevertheless, we may apply a bit more stricter rule to avoid
> potential, but unlike, event of adding the entry after terminator, already at compile time.
> This will be achieved by not putting comma at the end of terminator line"

This certainly applies to any new code.

The existing code, however, is what it is and the question is how much
of an improvement the given change makes.

So yes, it may not follow the current rules for new code, but then it
may not be worth changing to follow these rules anyway.

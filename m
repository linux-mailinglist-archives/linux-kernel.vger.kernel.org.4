Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27B76D9FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjDFScb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDFSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:32:29 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5367AAC;
        Thu,  6 Apr 2023 11:32:28 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id cw23so3588087ejb.12;
        Thu, 06 Apr 2023 11:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OazaTs0rIDqMjSa8VI/xlda7Ld7jBm3HLpm8D8X9bAM=;
        b=1hurltdCxekI5BEboqopVhRHI5xVrQbIE3eE1aRywGJVZFNuH9afnZTYcOzA9UYrmd
         BIQWf42L51WHhTnevlJJC2g1OniNCHk0K3/Spw6wgm9Mb07zv6o0PGyC9nwKyhMNn9ny
         2Kghg4dpkfDoCH9bwF8Ae715SYPLpG4DdtFy7T6qpVllI7/wu0gPe41kBkGBWA3VzoHz
         WqNzmnb1bGCpPBcX9mjKauVpLfvtjTIOJfmynUVSe9N67swCYHf/3mP4anvM/7LgcSQz
         rF7dawwwHl4vPsYHgExTBo9wQrmv/w+wpkDCd3PKyEzpyJnDRgEjO95dOt41Qn5b0LOg
         4OIw==
X-Gm-Message-State: AAQBX9ebnNGbwKzZlVRjLU3pJu9SlyEss+qpV3nmdEZNdnAWnrsZFq3v
        kOijnC/k4b1Wn9i1dA+CmGn5yreFtYOEx5SMzPrbYW7Q
X-Google-Smtp-Source: AKy350YP440Tr915HSRK6JOEqPvvBuQzfaXfxoFRlArWsa44dxesKE6jjFQDhp+fG3VA36axYt0Ql8sGEfTgzLnC8Tc=
X-Received: by 2002:a17:907:6d0e:b0:8b1:38d6:9853 with SMTP id
 sa14-20020a1709076d0e00b008b138d69853mr3752173ejc.2.1680805946548; Thu, 06
 Apr 2023 11:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <4845957.31r3eYUQgx@kreacher> <14903668.tv2OnDr8pf@kreacher> <642e13f27c63e_21a829429@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <642e13f27c63e_21a829429@dwillia2-xfh.jf.intel.com.notmuch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Apr 2023 20:32:15 +0200
Message-ID: <CAJZ5v0gRWtVH9NUnY4k4tnR_qLhKfhGMYFkae5b-89z2TrO2xA@mail.gmail.com>
Subject: Re: [PATCH 22/32] ACPICA: actbl2: Replace 1-element arrays with
 flexible arrays
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>,
        Kees Cook <kees@outflux.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 2:36 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Rafael J. Wysocki wrote:
> > From: Kees Cook <kees@outflux.net>
> >
> > ACPICA commit 44f1af0664599e87bebc3a1260692baa27b2f264
> >
> > Similar to "Replace one-element array with flexible-array", replace the
> > 1-element array with a proper flexible array member as defined by C99.
> >
> > This allows the code to operate without tripping compile-time and run-
> > time bounds checkers (e.g. via __builtin_object_size(), -fsanitize=bounds,
> > and/or -fstrict-flex-arrays=3).
> >
> > The sizeof() uses with struct acpi_nfit_flush_address and struct
> > acpi_nfit_smbios have been adjusted to drop the open-coded subtraction
> > of the trailing single element. The result is no binary differences in
> > .text nor .data sections.
> >
> > Link: https://github.com/acpica/acpica/commit/44f1af06
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This one needs the following folded in to pass my tests.
>
> Feel free to fold and add:

Done, thank you!

> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> -- >8 --
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 981f8b0f595d..85d9d67e38a4 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -894,7 +894,7 @@ static size_t sizeof_flush(struct acpi_nfit_flush_address *flush)
>  {
>         if (flush->header.length < sizeof(*flush))
>                 return 0;
> -       return sizeof(*flush) + sizeof(u64) * (flush->hint_count - 1);
> +       return struct_size(flush, hint_address, flush->hint_count);
>  }
>
>  static bool add_flush(struct acpi_nfit_desc *acpi_desc,
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index c75abb497a1a..745c4a27bc35 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1878,14 +1878,14 @@ static size_t sizeof_spa(struct acpi_nfit_system_address *spa)
>  static int nfit_test0_alloc(struct nfit_test *t)
>  {
>         struct acpi_nfit_system_address *spa = NULL;
> +       struct acpi_nfit_flush_address *flush;
>         size_t nfit_size = sizeof_spa(spa) * NUM_SPA
>                         + sizeof(struct acpi_nfit_memory_map) * NUM_MEM
>                         + sizeof(struct acpi_nfit_control_region) * NUM_DCR
>                         + offsetof(struct acpi_nfit_control_region,
>                                         window_size) * NUM_DCR
>                         + sizeof(struct acpi_nfit_data_region) * NUM_BDW
> -                       + (sizeof(struct acpi_nfit_flush_address)
> -                                       + sizeof(u64) * NUM_HINTS) * NUM_DCR
> +                       + struct_size(flush, hint_address, NUM_HINTS) * NUM_DCR
>                         + sizeof(struct acpi_nfit_capabilities);
>         int i;
>

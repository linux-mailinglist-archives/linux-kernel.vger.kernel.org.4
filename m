Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AE654547
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLVQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLVQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:41:53 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B332B25C;
        Thu, 22 Dec 2022 08:41:49 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id pe2so1179021qkn.1;
        Thu, 22 Dec 2022 08:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eN3Zs99qkrCh4vkx4vSKF4x3Qe9Q9larwUBX8sPwUM=;
        b=XGctkDcn2f9s6X4+fLdo8d3twJV8rzzHxPP7c6yYnVGH/jMe/Vc04f3hqigKGAF6kI
         YXexD4ej9Vvw/mv1hcV6UpYo5guXQJxMywF+/kNB1OPraCJvxPbXapoUzVvpmHRKRvND
         XgMuxqzVQqwgXscl69n6eC4CXRds2HrlgYYZC7KO/eFD9XAPi5uKkQuZDQV2oGlDYbCz
         36ePD8oZ5rrwqxlIAMpZToR3xNm8ld4CA/RVsPtuC4pVaI+N0ITOSTMHvu2nhROjsUJX
         ai1UyI3duY4c6WhL1R20Qr6rUnT9mOyqsmve7MZckncr5tGJMSLrwh5/yOiuBuMHuKfO
         Dm9w==
X-Gm-Message-State: AFqh2kr9US7t8TpNiSC15EsdQYj+SsumOtCWc3WDXkLGjEevDyWOCtvN
        yH5r4GfV07V99rvoCMOdjNCsUQh9RM7OIY1fg3Y=
X-Google-Smtp-Source: AMrXdXuGeP8i2XteUZGrOD8Yf4XIswmc+Dr9cfwlfF6+dKSmd7/zk8pOmco+3JIEJPQc2KqK2223pobIEAV/75j0kDg=
X-Received: by 2002:a05:620a:5235:b0:6ff:8f5a:1d37 with SMTP id
 dc53-20020a05620a523500b006ff8f5a1d37mr316258qkb.501.1671727309007; Thu, 22
 Dec 2022 08:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20221215191617.1438-1-mario.limonciello@amd.com>
In-Reply-To: <20221215191617.1438-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:41:38 +0100
Message-ID: <CAJZ5v0jNYs-X1tmhtJfbkKPga1AS9h-311LnxbEWHNrAT01utA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Stop using AMD GUID/_REV 2 by default
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, Philipp Zabel <philipp.zabel@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        anson.tsao@amd.com, ben@bcheng.me, paul@zogpog.com,
        bilkow@tutanota.com, Shyam-sundar.S-k@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Dec 15, 2022 at 8:16 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> A number of laptops have been showing up where lots of EC controlled
> features weren't working after resume.  They've varied from KBD
> backlight, to fans, brightness control and lots more.
> In kernel 6.1 we introduced a module parameter through
> commit a0bc002393d4 ("ACPI: x86: s2idle: Add module parameter to
> prefer Microsoft GUID") and a series of quirks in follow up commits
> for systems that people reported the problems.
>
> 3 more systems recently reported issues; and so rather than increasing
> the list /again/ to add these new systems we took a hard look at the
> "why".
>
> The AMD GUID/_REV 2 path was introduced for vendors to be able to
> differentiate from the Microsoft path.  Vendors could populate this
> with unique code for their designs.  Conceptually this was supposed
> to help the ecosystem, however in practice we've found that there
> are more machines that don't populate it than do.
>
> The only models that have populated this with unique code for avoiding
> a bug specific to their design is the HP Elitebook 835, 845, and 865 G9
> systems.
>
> To avoid growing the list further this series rips out the module
> parameter support, all the quirks and sets the default policy to follow
> the Microsoft GUID path for AMD Rembrandt or later.  We validated this
> on OEM systems and we found this fixes them.
>
> To avoid regressing the HP systems that use the AMD GUID/_REV 2
> path, let them keep taking it. The reason they take it is believed to
> be a bug with WLAN firmware.  If this is fixed in the future, we may
> consider dropping the HP systems as well and having no quirks.
>
> Mario Limonciello (2):
>   ACPI: x86: s2idle: Force AMD GUID/_REV 2 on HP Elitebook 865
>   ACPI: x86: s2idle: Stop using AMD specific codepath for Rembrandt+
>
>  drivers/acpi/x86/s2idle.c | 87 ++++++---------------------------------
>  1 file changed, 13 insertions(+), 74 deletions(-)
>
> --

Both patches applied as 6.2-rc material, thanks!

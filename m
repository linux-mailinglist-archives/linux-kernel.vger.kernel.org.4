Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0A5E8EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiIXRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiIXRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:08:01 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791E25E91;
        Sat, 24 Sep 2022 10:08:00 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id c6so1901722qvn.6;
        Sat, 24 Sep 2022 10:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V/3GhR988gPDS6E2QDOzA/8y9R+/aGZbwIz06arVHDw=;
        b=yTOdkapCj3V5WNvIkZf5U7aYUlGUyqzS0zJ+ZziLkVaVqnduqAeY6Tfq4uDOcpkYQs
         UE+GSEtY4Ijrb5KBtx+7V67Tx/Gaf+ejpSId6nHAcXXKlLTHlj8AR6sHCGWeUaJGAZcS
         bSJc30owyo/NEFV81vV6tufb/OdrJPZG2e4N/oh88knntuVOiSb5Dj3vJxCZ/Pt/MvXY
         7raOfmCkNcOjAsxDd70fMpzzox/3Q2sbmNx1LrVLvtHOi41mgYgPo7ZKChFbdeqpE6sC
         UAY8p/U8R71Jn3E0DKnGbBMhFpj5v9n0VCsFEHA/OHhaaIaF78/bODLpVIMuCh3ffhMN
         YTfw==
X-Gm-Message-State: ACrzQf1HM7hWudXcrWyRY9iE9r9CgifuVSsJhqenUWX7oxr+alRPNaWJ
        laOohoGxFCDjvEzwKaTcVK6T+NDjw7k8Pt05cF0=
X-Google-Smtp-Source: AMsMyM4uLhgwFaeBlTpnO7Ux4sRZ+3+Xo3VmMtiR+I3wbVBzxzR2JNCThNcNnwzXWrLVBQNaaB3BTVMUN/26CfLw39c=
X-Received: by 2002:a0c:da14:0:b0:4aa:aad9:e450 with SMTP id
 x20-20020a0cda14000000b004aaaad9e450mr11681294qvj.130.1664039279863; Sat, 24
 Sep 2022 10:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220921204055.22889-1-mario.limonciello@amd.com>
In-Reply-To: <20220921204055.22889-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:07:49 +0200
Message-ID: <CAJZ5v0jAOWbqdPRDfUeheD2EVZVeUxUwShqMr125Qn4zbMwdAg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Fixups for s2idle on various Rembrandt laptops
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, travisghansen@yahoo.com,
        catalin@antebit.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>, davidedp91@gmail.com,
        marko.cekrlic.26@gmail.com, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Sep 21, 2022 at 10:40 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> It was reported that an ASUS Rembrandt laptop has problems with seemingly
> unrelated ACPI events after resuming from s2idle. Debugging the issue
> proved it's because ASUS has ASL that is only called when using the
> Microsoft GUID, not the AMD GUID.
>
> This is a bug from ASUS firmware but this series reworks the s2idle
> handling for AMD to allow accounting for this in a quirk.
>
> Additionally as this is a problem that may pop up again on other models
> add a module parameter that can be used to try the Microsoft GUID on a
> given system.
>
> This module parameter intentionally applies to both Intel and AMD systems
> as the same problem could potentially exist on Intel systems that support
> both the Intel GUID or the Microsoft GUID.
>
> v3->v4:
>  * Absorb tags
>  * minor URL correction
>  * Rename module parameter per Rafael's request
> v2->v3:
>  * Add more systems
> v1->v2:
>  * Add two more systems that are reported to be helped by this series.
>
> Mario Limonciello (7):
>   acpi/x86: s2idle: Move _HID handling for AMD systems into structures
>   acpi/x86: s2idle: If a new AMD _HID is missing assume Rembrandt
>   acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
>   acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
>   acpi/x86: s2idle: Add a quirk for ASUS ROG Zephyrus G14
>   acpi/x86: s2idle: Add a quirk for Lenovo Slim 7 Pro 14ARH7
>   acpi/x86: s2idle: Add a quirk for ASUSTeK COMPUTER INC. ROG Flow X13

All applied as 6.1 material, thanks!

>  drivers/acpi/x86/s2idle.c | 136 +++++++++++++++++++++++++++++++-------
>  1 file changed, 112 insertions(+), 24 deletions(-)
>
> --

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C75EE5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiI1ThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiI1ThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:37:12 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78435F115;
        Wed, 28 Sep 2022 12:37:08 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id p3so3250076qvz.6;
        Wed, 28 Sep 2022 12:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OnNyNviAMrTN7Xzf5rjzt1Cctz22dmk9+rbhre1TNPM=;
        b=edBpeVchMfYJ8nZ5wvDb68/2NHUzlq+Qp6/RhJ9R0szerHTxYq1UjN7Zm73arhgLNn
         h/xx2VnK3CttGz/vcx1cwNc91oemLJIp28N/pYuFE3lQN4mV76iNTpAr5rbWncc2KWJq
         ld4epTeCX4OqaJ4yhZVZLwNh3wfzzMhht0U+neNu9ifepIaATKKjFKq1kry11cxh3F+p
         RBbo1DR7k16RniWxBawKhroaCabchCJ6/YqGPTN1c5guhsL0adH9SrLtpLPqIVDcGmOD
         MauL+lcZmQFahz8KaJByQebeUjikACSV2rfJtEifUECSLLkcB1guPvu5Rh9PGvP/u7qP
         LcQg==
X-Gm-Message-State: ACrzQf01L9TqbVDtxbZ7FBnuyFNE3B/Ajpa5A8B0myOom0rtnaKGTz5Z
        Tpik6Sa/EC1vhw222edRYaYUjhbFUNjoJusBtykpU2vV
X-Google-Smtp-Source: AMsMyM6hnDwyC5sax1NuHQQfb3aCyw02PG5jPXTvbhNAdOcp+pnjAZtht+l6KJYLbyUX0pRDrxcm8mrvrltZ/YciL2s=
X-Received: by 2002:a0c:f3cb:0:b0:4af:a435:2c1b with SMTP id
 f11-20020a0cf3cb000000b004afa4352c1bmr496757qvm.130.1664393827995; Wed, 28
 Sep 2022 12:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220928161935.31913-1-mario.limonciello@amd.com>
In-Reply-To: <20220928161935.31913-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Sep 2022 21:36:56 +0200
Message-ID: <CAJZ5v0jHe5fDfGaL42XmrHDc25NRSRe3dR9CDtBEd_asmjYJcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: x86: s2idle: Fix a NULL pointer dereference
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Philipp Zabel <philipp.zabel@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Richard Gong <Richard.Gong@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
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

On Wed, Sep 28, 2022 at 6:19 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Ryzen 7000 (Raphael) introduced AMDI0008 for _HID.  This ID was added
> in commit ed470febf837 ("ACPI: PM: s2idle: Add support for upcoming AMD
> uPEP HID AMDI008"), but then removed in favor of aligning all new IDs
> to Rembrandt support in commit fd894f05cf30 ("ACPI: x86: s2idle: If a
> new AMD _HID is missing assume Rembrandt").
>
> Unfortunately there was a mistake in commit 100a57379380 ("ACPI: x86:
> s2idle: Move _HID handling for AMD systems into structures") that can
> lead to a NULL pointer dereference accessing `dev_id->driver_data` in
> the sentinel of `amd_hid_ids`.  Fix this dereference.
>
> Reported-by: Richard Gong <Richard.Gong@amd.com>
> Fixes: 100a57379380 ("ACPI: x86: s2idle: Move _HID handling for AMD systems into structures")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index eedd21d8a284..3ae2ba74de92 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -470,7 +470,7 @@ static int lps0_device_attach(struct acpi_device *adev,
>                 for (dev_id = &amd_hid_ids[0]; dev_id->id[0]; dev_id++)
>                         if (acpi_dev_hid_uid_match(adev, dev_id->id, NULL))
>                                 break;
> -               if (dev_id)
> +               if (dev_id->id[0])
>                         data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
>                 else
>                         data = &amd_rembrandt;
> --

Applied along with the [2/2], thanks!

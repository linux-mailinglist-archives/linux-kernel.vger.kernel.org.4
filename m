Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A35E8E62
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiIXQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIXQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:12:08 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF313FB6;
        Sat, 24 Sep 2022 09:12:04 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id c19so1838270qkm.7;
        Sat, 24 Sep 2022 09:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F15BgTFn4WudNgvloadL1dN3rK2rHdLhpPBgO8Ot8K0=;
        b=ABM5+zZcaMe+0aUX3njUG7KQOyhWPEu2kRj+gkJgd0SQXilV06AZuUZSiZ5KTUvGmq
         dQg6Igx1wjkF1NBC1HqsXruqViYfmBCbQPVAV/NORjl7mq+4Knjh1a5QhxvrQ1MCRCyI
         DCCTLZvUWayGaGpnWcfl/RWYmqO0xzJTRAsvl9rR+LN68V+lB+HJQoWIqk3Sf+iEPqq4
         RXfMOJB8HzaaxOKHP/TpYStKZ5bj/HYxzkqlmGE7+fO2z9KJS431+JUKaSZI5eDAqcXO
         CxZw57iBqyBTDaMVvg5PN2pGyiXr0dNv2AKnOz8TFau5Hv1Cjfq5a1zXMJiaNc7NMJ3e
         umLg==
X-Gm-Message-State: ACrzQf0sw1JLlEt2XUnAbidkiohkjJtTn400tR3cQF9TgG46P+UP545j
        YWjj+MBWhfn4IQswux8DX0EWBAlYB/FoWoXxUTw=
X-Google-Smtp-Source: AMsMyM5GS5nhMHgOvE1Fg0q/eefTo0ji37PuMsUrxRuFjBLaMDqjARvSO2nqBoUfPKgFBcKum5NWOaknsBlfVnoWvZ4=
X-Received: by 2002:a05:620a:46ac:b0:6ce:3e55:fc21 with SMTP id
 bq44-20020a05620a46ac00b006ce3e55fc21mr9034311qkb.285.1664035923964; Sat, 24
 Sep 2022 09:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220915182315.276-1-mario.limonciello@amd.com> <42663baa-2d8c-a45a-a33e-571119ec12aa@redhat.com>
In-Reply-To: <42663baa-2d8c-a45a-a33e-571119ec12aa@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:11:53 +0200
Message-ID: <CAJZ5v0g_AFSa010yZ5NrLaQcY7wNy0p_2eJS9pyiEum8LZ7O_g@mail.gmail.com>
Subject: Re: [PATCH] ACPI / x86: Add a quirk for Dell Inspiron 14 2-in-1 for StorageD3Enable
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luya Tshimbalanga <luya@fedoraproject.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Fri, Sep 16, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/15/22 20:23, Mario Limonciello wrote:
> > Dell Inspiron 14 2-in-1 has two ACPI nodes under GPP1 both with _ADR of
> > 0, both without _HID.  It's ambiguous which the kernel should take, but
> > it seems to take "DEV0".  Unfortunately "DEV0" is missing the device
> > property `StorageD3Enable` which is present on "NVME".
> >
> > To avoid this causing problems for suspend, add a quirk for this system
> > to behave like `StorageD3Enable` property was found.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
> > Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.1 material, thanks!

> > ---
> > I had attempted to modify the heuristics for when two ACPI devices
> > have the same _ADR to prefer the one with a _DSD, but this wasn't enough
> > of a help. As the ACPI node doesn't contain anything valuable besides
> > the _DSD, it seems that a quirk for the system is a fine enough solution.
> >
> >  drivers/acpi/x86/utils.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> > index 664070fc8349..d7cdd8406c84 100644
> > --- a/drivers/acpi/x86/utils.c
> > +++ b/drivers/acpi/x86/utils.c
> > @@ -207,9 +207,26 @@ static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> >       {}
> >  };
> >
> > +static const struct dmi_system_id force_storage_d3_dmi[] = {
> > +     {
> > +             /*
> > +              * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
> > +              * but .NVME is needed to get StorageD3Enable node
> > +              * https://bugzilla.kernel.org/show_bug.cgi?id=216440
> > +              */
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
> > +             }
> > +     },
> > +     {}
> > +};
> > +
> >  bool force_storage_d3(void)
> >  {
> > -     return x86_match_cpu(storage_d3_cpu_ids);
> > +     const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
> > +
> > +     return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
> >  }
> >
> >  /*
>

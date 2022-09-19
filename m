Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D2F5BD232
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiISQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiISQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:27:37 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F33B955;
        Mon, 19 Sep 2022 09:27:36 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id d17so20075054qko.13;
        Mon, 19 Sep 2022 09:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dEokQm5n7CvZvcm2/TuaTTXN7aMhR9oWpeaOPSUYU4I=;
        b=2VB1+Tr3QCxgJH8CMgvGesRM8iys/5TAkWesrqMfkx2TTD+lFfC81RWae/u3/sgiqi
         u5IM7ISnTFLG6Pc3hTlDpEqf51p5QgoJ8yNm/1RaKrOwnVBw+BDIddCHeYS7DiTnNT+K
         0ILoxd1n/2jMvghPUuXCkQ5MTbksVxl9cJVMLIuD6l5GKsXQZGRFQa5/ZlWqRm++h3Y7
         vV4dti/OmiUT8LRIImLwY0O1LIARe7cCIYJs+txCUnQyhNcGK+S3NyOMhPSAj3PaMZcg
         /2h5Ws3tnxssuwkj6hrlWw4uvG0WPg0vjimRST7fLdd9mvsSryo8SjUbMHPx+blPTEFE
         PSvQ==
X-Gm-Message-State: ACrzQf0rj2RXm/fckP1O+OoVg5RVUgF8eiAkxSYYNC3Ugi4E4iQlEcGB
        DDkbT3mKLHfHRY3WFPWAJQVUixF1+R7GEGGKEAPGZzQaBV8=
X-Google-Smtp-Source: AMsMyM4XZU0z1J3kzFB53bs7jo2hBp6BEvaMD6zIiq/E5pFGeXvdD251SJwkmfPDO2xF+FINSxCgav8IXCY7rRiYzZ0=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr10917915qkp.9.1663604855357; Mon, 19 Sep
 2022 09:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220912125342.7395-1-W_Armin@gmx.de> <20220912125342.7395-2-W_Armin@gmx.de>
 <f8fa6d10-6eb1-7fa7-80eb-ea190d29ba4a@redhat.com>
In-Reply-To: <f8fa6d10-6eb1-7fa7-80eb-ea190d29ba4a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Sep 2022 18:27:24 +0200
Message-ID: <CAJZ5v0jWVMMTjc+KtBRS86f8kYpbPcDCH9JV2ZgeN4f-MSO8rQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single error
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, Mark Gross <markgross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Matan Ziv-Av <matan@svgalib.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Jeremy Soller <jeremy@system76.com>, productdev@system76.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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

On Mon, Sep 19, 2022 at 12:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/12/22 13:53, Armin Wolf wrote:
> > Currently, battery hooks are being unloaded if they return
> > an error when adding a single battery.
> > This however also causes the removal of successfully added
> > hooks if they return -ENODEV for a single unsupported
> > battery.
> >
> > Do not unload battery hooks in such cases since the hook
> > handles any cleanup actions.
> >
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>
> Maybe instead of removing all error checking, allow -ENODEV
> and behave as before when the error is not -ENODEV ?
>
> Otherwise we should probably make the add / remove callbacks
> void to indicate that any errors are ignored.
>
> Rafael, do you have any opinion on this?

IMV this is not a completely safe change, because things may simply
not work in the cases in which an error is returned.

It would be somewhat better to use a special error code to indicate
"no support" (eg. -ENOTSUPP) and ignore that one only.

> > ---
> >  drivers/acpi/battery.c | 24 +++---------------------
> >  1 file changed, 3 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 306513fec1e1..e59c261c7c59 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -724,20 +724,10 @@ void battery_hook_register(struct acpi_battery_hook *hook)
> >        * its attributes.
> >        */
> >       list_for_each_entry(battery, &acpi_battery_list, list) {
> > -             if (hook->add_battery(battery->bat)) {
> > -                     /*
> > -                      * If a add-battery returns non-zero,
> > -                      * the registration of the extension has failed,
> > -                      * and we will not add it to the list of loaded
> > -                      * hooks.
> > -                      */
> > -                     pr_err("extension failed to load: %s", hook->name);
> > -                     __battery_hook_unregister(hook, 0);
> > -                     goto end;
> > -             }
> > +             hook->add_battery(battery->bat);
> >       }
> >       pr_info("new extension: %s\n", hook->name);
> > -end:
> > +
> >       mutex_unlock(&hook_mutex);
> >  }
> >  EXPORT_SYMBOL_GPL(battery_hook_register);
> > @@ -762,15 +752,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
> >        * during the battery module initialization.
> >        */
> >       list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
> > -             if (hook_node->add_battery(battery->bat)) {
> > -                     /*
> > -                      * The notification of the extensions has failed, to
> > -                      * prevent further errors we will unload the extension.
> > -                      */
> > -                     pr_err("error in extension, unloading: %s",
> > -                                     hook_node->name);
> > -                     __battery_hook_unregister(hook_node, 0);
> > -             }
> > +             hook_node->add_battery(battery->bat);
> >       }
> >       mutex_unlock(&hook_mutex);
> >  }
> > --
> > 2.30.2
> >
>

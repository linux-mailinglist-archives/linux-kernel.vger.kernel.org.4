Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857E6377CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKXLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKXLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:40:57 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63076B9F0;
        Thu, 24 Nov 2022 03:40:56 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id jr19so882093qtb.7;
        Thu, 24 Nov 2022 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YW65nmzWJiseN5RQVR2kexQ255Synbbi/eoozzZAKxc=;
        b=Ra/oS7fF6qlZuXNzVzunYzTLirz+kr69JHws8QXEJsPwZwbyD5bvSK7ieoB941wU0z
         Qj974L4ZCsJBzJl1h+VGmvXhQILXEuV/X/E0MTxvOx36e/39eWTRIjMgeej6aRCT1gNK
         3ftjZvw11jicQ1m+7IkwKPd17Tv00SgOljtJbbRefIVcE8Vj3wsOVdDnaxCojx74I1m9
         HkpgUNrO06C1O9htZlWlwIpuswNmcyAa+RcxE8bkiJ2t/jsQ72Y3VaErkalzIkbywFQQ
         rExSEkaUMdIE1ZPPKM/9vW68xo/d1Y2L11yNrAr5p9w5FVgfBBfS/dbILXob/Ia9cF0P
         A30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YW65nmzWJiseN5RQVR2kexQ255Synbbi/eoozzZAKxc=;
        b=1pr48MDTxOk15JG2HlZQTsfWEeWetwA4RwEagZFWhr2JGnWsvEhCbaezs7VFoRMDNr
         v5VDkRINddHIYkKDmvngahARaMCPVM2nYKzO4zh5JJugXQ8Ho2N7MgUsiuYiarT2dEHO
         hoJp48fqVeLcpigkT8ReY7wpv1frI0NTTPbjlObdfoLagjX+zFYvT1FwlXZYPln5wQsn
         S0hd91aJ9ICY6/msBed7unih+cY6N+pGIHbn8K6r20tFU1o2QfGa/tXHvBxPWn6Z95+k
         Oh8dSbCMJcz1/5ebrdQK+5jYyPmX4qbI7rIeh0gEzihdV8tJyfwMnRvt+9svOuDQwej4
         l3vg==
X-Gm-Message-State: ANoB5pnzdRZZZpd3kFDeA5ixFcpY0rGJA/Mu9sOeE9UV7eUOA6yUPXd0
        Dr0DaJ0c+J3g1S6PcnEPAGePyd3ZI3i+s+OhirBqXv0liE/NJRQz
X-Google-Smtp-Source: AA0mqf6EVMaKyGsT8Yf0GvAO/D+kqDDFYaS6AiQ46hc9hnelIYsTl23j70SLgM9m6BIWF9jcltR9rJgMp7U0DwE5tkE=
X-Received: by 2002:ac8:7eeb:0:b0:3a5:2615:5694 with SMTP id
 r11-20020ac87eeb000000b003a526155694mr15003828qtc.429.1669290055940; Thu, 24
 Nov 2022 03:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20221124110718.3925934-1-sbinding@opensource.cirrus.com> <20221124110718.3925934-3-sbinding@opensource.cirrus.com>
In-Reply-To: <20221124110718.3925934-3-sbinding@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Nov 2022 13:40:19 +0200
Message-ID: <CAHp75VcCfCxfEJKcKpu18tJZHjVBPMScrE8ADmaMYvmjkUZokQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ALSA: hda: cs35l41: Use ACPI_COMPANION to read
 acpi properties
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 1:07 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> Currently the driver finds the acpi_device used to read certain
> properties using the HID, however, this is not necessary, as the
> acpi_device can be obtained from the device itself.
>
> With the ACPI_COMPANION correctly set, we can also simplify how

ACPI companion device

> we obtain the reset gpio.

GPIO

...

The idea seems to be an improvement to me. Thanks.

But I have side question, are you going to address the
https://bugzilla.kernel.org/show_bug.cgi?id=215993

P.S. It would be nice if you have an account there, so I can reassign
that to you.

-- 
With Best Regards,
Andy Shevchenko

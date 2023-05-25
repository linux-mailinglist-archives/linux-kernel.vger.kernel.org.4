Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D071139D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjEYSWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEYSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:22:47 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C58E2;
        Thu, 25 May 2023 11:22:46 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6238b15d298so608836d6.0;
        Thu, 25 May 2023 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685038965; x=1687630965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCYamoQ/cXfRxWQHGyTpAloY70tX3p/WOFuPH93ZdDs=;
        b=XlNv5bmBO2/P2UMavmyGO/KB0uJyMnUJVb3bQRFl0h5XQjwYkdvlKy2pdjBhYxFubn
         TAn9OranLZ0ZLYYP3fzBuU2gc2K36TiK8fUW/x/XbevnIFxdpGXNjrO4PqKBVbNiJPaB
         LyFzGKg9kYFTq3t/FYxJHm2AE8/kwn5DKWP0fUErSMRWsgLjAaYKseWUvc2gAb6Zt86P
         0LVZbkO3/W/VB6E/ig5rpop9QCbTnie0OIgY0tB4mUCO+HlpkSru/1GJ7CAR54qnN9SI
         C2SKAnM+Z1WJtCPlJnKXVTu/eJDwNPuebq54wh5SAj6VipGTT8iUkboeydLfPIiDncO4
         owVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038965; x=1687630965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCYamoQ/cXfRxWQHGyTpAloY70tX3p/WOFuPH93ZdDs=;
        b=mE3yYcBSC0kXbBUbT4jfVqB4eHC9msHaDBtvx7cr4sBW3CAe10cCPOaplVfIQZ1VO/
         5yU5YZmAyZwJUaC3dx0FkLig3oSwHje885zSJ2dimufiN0eLqkdxSDtG7Lkad5eMSTWk
         cyXxrEu5HLRJ19hDZ8uEz97w8vMksqYFBE2dIcY2ILdHhyNVQKKO/Qnp8EbqdYc8+XCK
         YMrXQZtlWy2Pdf7lYWZ+ZpRympNEL5Uifwscp+EINF5NBX5IFUaUDcsYbBiGiB8j8yRq
         /SlYEiHWeTyapCNGPbWsGsLO7wErZ791GF85WMQ0HocGJP8jgqUMd8uBg0tTJx5fkZ2y
         iiVw==
X-Gm-Message-State: AC+VfDxsPrxZBA3XuZImTn+rYbEPfZfKPeE0rIM20D20gc20igntG403
        GbvIF6NQ4LtTWzneL8bhsk2KoNY9tINCwk7wl0qR2mIkQwA=
X-Google-Smtp-Source: ACHHUZ6EJqO8TVHnz2hJCncpsFXCQc+8nMEQG9UNvnORiP4h3NLCPKj2bidP8fho0TkzAcKX96mzg0Kl8gVOeQhsJng=
X-Received: by 2002:ad4:5cce:0:b0:625:aa49:ceb0 with SMTP id
 iu14-20020ad45cce000000b00625aa49ceb0mr2750957qvb.57.1685038964984; Thu, 25
 May 2023 11:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230525160827.15285-1-osmtendev@gmail.com> <5b8700fb-d455-469e-a34d-62cb6f68d324@roeck-us.net>
In-Reply-To: <5b8700fb-d455-469e-a34d-62cb6f68d324@roeck-us.net>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Thu, 25 May 2023 23:22:33 +0500
Message-ID: <CAK6rUANVnXctUoxPdqefRjEe1BQ_AkDrksJN9bpuE6KkOXBTjA@mail.gmail.com>
Subject: Re: [PATCH] adm1266.c: Drop error checking for debugfs_create_dir
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the new patch not v3. The patch I sent as v2 was a mistake.
Please discard the patch I sent earlier as v2 .
Apologies for the confusion.Hope it clarifies.

Regards,
Osmten



On Thu, 25 May 2023 at 23:17, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, May 25, 2023 at 09:08:27PM +0500, Osama Muhammad wrote:
> > This patch fixes the error checking in adm1266.c.
> > The DebugFS kernel API is developed in
> > a way that the caller can safely ignore the errors that
> > occur during the creation of DebugFS nodes.
> >
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
>
> Confusing. Is this v3 of the patch ?
>
> Guenter
>
> > ---
> >  drivers/hwmon/pmbus/adm1266.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> > index 1ac2b2f4c570..184d75269d2b 100644
> > --- a/drivers/hwmon/pmbus/adm1266.c
> > +++ b/drivers/hwmon/pmbus/adm1266.c
> > @@ -340,8 +340,6 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
> >               return;
> >
> >       data->debugfs_dir = debugfs_create_dir(data->client->name, root);
> > -     if (!data->debugfs_dir)
> > -             return;
> >
> >       debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state", data->debugfs_dir,
> >                                   adm1266_state_read);
> > --
> > 2.34.1
> >

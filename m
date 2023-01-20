Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B308675C83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjATSPk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Jan 2023 13:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:15:39 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30DDBE4;
        Fri, 20 Jan 2023 10:15:35 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id mg12so16046954ejc.5;
        Fri, 20 Jan 2023 10:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqP17bCoNp80WwoAZTjADKbunc1QO+WYV+s3nQtpawA=;
        b=43cTmRBsjOC6hSZW8wCzc5K/Ota7t6j0LPoAC7hjrSAVIYUE0LHEuEfRvLQyzRZExm
         KudCe99UE3B2kr0IGFR8HfH5Yh3gskW8Ho+dLdZfV36Y/1BPVUo/yySQ3Z1Xr2OGFFEz
         nrynEDcMqy1oPajq6KtxGejNFESk4TqzEhh3J1GUNFoBjPiIvB538/7D/H851gL7PERh
         Trhja1FikGUUZvl4xC3ZCBv4A+JT7sv01jA1hEEpA1NnOU84DKKyCR0PG9U/rVhDWEyi
         kZY3ArvBP5WICAxtzbwGGkVtygl1hKBimjKEJI4U27DhHLktxOkChMPQfKB+G4xbJ2Em
         zfiQ==
X-Gm-Message-State: AFqh2krVF9YJ5SqrC89sDh32B10XlpOIQhIO2rxEGG3+SnJAwX2QsBel
        Fu0LNElHv5v1tAFecPxzVHfWhSH5ZFKiiy8xR64uUrmX
X-Google-Smtp-Source: AMrXdXu5El6FR00TLRDD4xJXFPd1YsK3IG0zI4SInsKlGRR1rort+cbJ665y693HIOQ/Pf3MKjXmbIPvf+v+qVcaX3w=
X-Received: by 2002:a17:906:2c4b:b0:870:3557:160e with SMTP id
 f11-20020a1709062c4b00b008703557160emr1242549ejh.78.1674238534348; Fri, 20
 Jan 2023 10:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <20230113180235.1604526-2-daniel.lezcano@linaro.org> <CAJZ5v0jDF9qrQAQM1AhT-Q4A3Nzyht9XxZoZyS1afoAPt1h_=A@mail.gmail.com>
 <e4468710-1336-847e-89e4-51c745a0a79b@linaro.org>
In-Reply-To: <e4468710-1336-847e-89e4-51c745a0a79b@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 19:15:22 +0100
Message-ID: <CAJZ5v0gdXJuNr9jUm6rPdPCuBjc8jwgcZQwtyxurd-jr50btLw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] thermal/acpi: Add ACPI trip point routines
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 7:08 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
>
> On 19/01/2023 14:15, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> +static int thermal_acpi_get_temperature_object(struct acpi_device *adev,
> >> +                                              char *object, int *temperature)
> >
> > So this would become thermal_acpi_get_temp_object(). or even
> > thermal_acpi_get_temp() because it really returns the temperature
> > value.
> >
> > I also don't particularly like returning values via pointers, which is
> > entirely avoidable here, because the temperature value obtained from
> > the ACPI control methods must be a positive number.
> >
> > So I would make it
> >
> > static int thermal_acpi_get_temp(struct acpi_device *adev, char *object_name)
> > {
>
> We are converting decikelvin -> millicelsius. Even it is very unlikely,
> the result could be less than zero (eg. -1°C). We won't be able to
> differentiate -ENODATA with a negative value, no ?
>
> In the future, it is possible we will have to deal with cold trip points
> in order to warm a board. May be we should don't care for now ?

My point is that the ACPI specification mandates that the return
values be in deciK and so always non-negative.

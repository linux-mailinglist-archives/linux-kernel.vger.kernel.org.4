Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C15675D03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjATSsV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Jan 2023 13:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjATSsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:48:17 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BE5FDF;
        Fri, 20 Jan 2023 10:48:02 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id u19so16200959ejm.8;
        Fri, 20 Jan 2023 10:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGnyRzY1q6uGKHCPbfZjapTbd1fVyDwIxw6QkOwGmkU=;
        b=kjpSjUoIyi1nX7BOQ6b9j1oM2jEk/t1Wmji8Qe6jOpyneoFPEI3krCAY2aoT5wUHEc
         pppxTcYC0dCz/1GAO0phQ5jPpgTnmtJzSGwtSyVcmVupz8OX+Bx7VhF1ndPA6diftjC3
         e//8MPMHzD6OvdiAiD/S7rmnd9NegEF5TqVz4Zd4CTdoBAyjA2t0Uv3doEqfxnOCTfF2
         vfp/hV/XNoWUVOcn74U0KuDz6WSZZiJB4Ttz0nTOIwUKt0bWycfLsVUCwExIGC7HfdzG
         Ft49yb7w+V45hYKH4SjcMgfH9e4RqN7wLOtd8+tQlnnzfz+TF7skH1MheJbBwrKVcSxD
         auuQ==
X-Gm-Message-State: AFqh2kp5ivyjAUJ/vH5wSJcJuZODgP65lm+J7gEMkEmnvWm2XB7uTLTn
        GG0MUEK7gFEqyvsoa4S9bfOYVCWRypU4+xPWIMPeisCE
X-Google-Smtp-Source: AMrXdXuhUvkqhYk6ZW7X0dfejp6ANt7B4z2byqer5sbFY1X5djVrrqhZRFPv8+n3VS3t4QElV7Qs5Ov9F2qmO/lCElE=
X-Received: by 2002:a17:907:7855:b0:855:63bb:d3cb with SMTP id
 lb21-20020a170907785500b0085563bbd3cbmr1637584ejc.532.1674240480941; Fri, 20
 Jan 2023 10:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <20230113180235.1604526-2-daniel.lezcano@linaro.org> <CAJZ5v0jDF9qrQAQM1AhT-Q4A3Nzyht9XxZoZyS1afoAPt1h_=A@mail.gmail.com>
 <e4468710-1336-847e-89e4-51c745a0a79b@linaro.org> <CAJZ5v0gdXJuNr9jUm6rPdPCuBjc8jwgcZQwtyxurd-jr50btLw@mail.gmail.com>
 <b007d54e-737f-b0cc-2fb3-45a06d5fa044@linaro.org>
In-Reply-To: <b007d54e-737f-b0cc-2fb3-45a06d5fa044@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 19:47:49 +0100
Message-ID: <CAJZ5v0j=4u6eKBiEEBsLJySidSi+VPcGc5Qw0_qK4RVvX4=pzw@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 7:27 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 20/01/2023 19:15, Rafael J. Wysocki wrote:
> > On Fri, Jan 20, 2023 at 7:08 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >>
> >> On 19/01/2023 14:15, Rafael J. Wysocki wrote:
> >>
> >> [ ... ]
> >>
> >>>> +static int thermal_acpi_get_temperature_object(struct acpi_device *adev,
> >>>> +                                              char *object, int *temperature)
> >>>
> >>> So this would become thermal_acpi_get_temp_object(). or even
> >>> thermal_acpi_get_temp() because it really returns the temperature
> >>> value.
> >>>
> >>> I also don't particularly like returning values via pointers, which is
> >>> entirely avoidable here, because the temperature value obtained from
> >>> the ACPI control methods must be a positive number.
> >>>
> >>> So I would make it
> >>>
> >>> static int thermal_acpi_get_temp(struct acpi_device *adev, char *object_name)
> >>> {
> >>
> >> We are converting decikelvin -> millicelsius. Even it is very unlikely,
> >> the result could be less than zero (eg. -1°C). We won't be able to
> >> differentiate -ENODATA with a negative value, no ?
> >>
> >> In the future, it is possible we will have to deal with cold trip points
> >> in order to warm a board. May be we should don't care for now ?
> >
> > My point is that the ACPI specification mandates that the return
> > values be in deciK and so always non-negative.
>
> I understand that but the code does:
>
> static int thermal_acpi_get_temp(struct acpi_device *adev, char
> *object_name)
> {
>         ...
>
>         return deci_kelvin_to_millicelsius(temp);
> }
>
> All the callers do:
>
> ...
>
>          ret = thermal_acpi_get_temp(adev, name);
>          if (ret < 0)
>                 return ret;
>         /* This could be an error
>          * or negative millicelsius temperature
>          */
>
>         /* here we already have millicelsius */
>          trip->temperature = ret;
> ...
>
> So I guess we want to do:
>
> ...
>
>          ret = thermal_acpi_get_temp(adev, name);
>          if (ret < 0)
>                 return ret;
>
>         /* we convert here instead in thermal_acpi_get_temp() */
>          trip->temperature = deci_kelvin_to_millicelsius(ret);
> ...
>
> Sounds good ?

Yes, it does.  Convert when it is known to be valid.

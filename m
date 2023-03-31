Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13B6D2786
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjCaSGE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjCaSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:06:02 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E014C1D2D5;
        Fri, 31 Mar 2023 11:05:54 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id t10so92754653edd.12;
        Fri, 31 Mar 2023 11:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/reCKtYhi3HG+0JUopGdSMZyzF44Qp/rswO5vBUAHPA=;
        b=3FBObQSu/1DcSMT6oWK1+iOf/VHMNvkKZXn76CjqfKE7GYf4mdv9nQfjRdU1CEP2ZM
         /iSmSdf/WeDX/XOkv4BaXx9AlDLbM/qKP6+zBJ2jHGbEXAXbq0Ewtfia7AvDXwbzkt9m
         ekub+3j0yHK1KkWvL64/2qf6MzCmSxkArQCS7HrFWjmF4NwXHM0ZU9x0s5MFjIo7a/K/
         P4k9ZS+vKWUFjsSpDlSSRtX2eNzcuU103WXarmlR9TciMSPTJ/T/lJSSclwYbzcLARsL
         6LhglL3vGRJZlqGIsTpBnIbJxzD60Yjg9nOE8b+/wae93/T8I28gqy9mF1Jvq0CYHOKz
         oJPg==
X-Gm-Message-State: AAQBX9eOXwXX2J0+TE/pcr96Lze7f4IUpJyrlmxzW24v7Oz1cnbZDd2Z
        2OTuzrVxLTbjosTdQTUfJpwtaRn9OQeJNmZ0XNk=
X-Google-Smtp-Source: AKy350aRu1rC5LHQTl5XlwzkbXuwNMcWF1StwcS3fIRDb/ZqG7tJPnQq2X51SHdvF0hXEbVt4l+Wy9EFKcBK9RAgh4g=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr13809961edi.3.1680285953431; Fri, 31
 Mar 2023 11:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230330194439.14361-1-mario.limonciello@amd.com> <20230330194439.14361-5-mario.limonciello@amd.com>
In-Reply-To: <20230330194439.14361-5-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 20:05:42 +0200
Message-ID: <CAJZ5v0jabz27wk-g=iZRSnpUCmWimfjSUZO+iuNeRbuzPxW=DA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Raul Rangel <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> intel_pmc_core displays a warning when the module parameter
> `warn_on_s0ix_failures` is set and a suspend didn't get to a HW sleep
> state.
>
> Report this to the standard kernel reporting infrastructure so that
> userspace software can query after the suspend cycle is done.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Reword commit message
> ---
>  drivers/platform/x86/intel/pmc/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index e2f171fac094..980af32dd48a 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1203,6 +1203,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
>         if (pmc_core_dev_state_get(pmcdev, &s0ix_counter))
>                 return false;
>
> +       pm_set_hw_sleep_time(s0ix_counter - pmcdev->s0ix_counter);
> +

Maybe check if this is really accumulating?  In case of a counter
overflow, for instance?

>         if (s0ix_counter == pmcdev->s0ix_counter)
>                 return true;
>
> --

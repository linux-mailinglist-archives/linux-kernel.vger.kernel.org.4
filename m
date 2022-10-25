Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8060D20C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiJYQ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiJYQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:55:43 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA361109;
        Tue, 25 Oct 2022 09:55:31 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id bb5so7922503qtb.11;
        Tue, 25 Oct 2022 09:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZqUr/OzcoHnOZKPLsDNCtHXwikXL6EbBtCzKiFk/Cc=;
        b=cUJ4OIRi8qRMjq8EKpdADJXwff7OeNUG33dkV98yubIeJL8cOI0ITRx5gfa4n6dEj2
         1Ep+f+soKlrTD1vy6a7rDWnXv4/Di2MLayZLv9L6p1x5Q7wAgJpay+WIQa5xZPv8c0bL
         8giVGK/RI8oLgGqTo3GAgmb8L3SkSyUrHQqRTN9SfCHaHZzKP4m0D6/XrfxLNir5qOjQ
         DgXLL302Q/0cegNG3OUc7M7LnUJ0bfaHslDZUgBnivB/jXIo9jqF02Ln+eRqMv25zdR1
         rgv8detdt2X+nT+alAcf7dVZB3/iocWRiIVa9knoc7fnoDyfA7govZlARlSQcATa1+CQ
         e7lA==
X-Gm-Message-State: ACrzQf040j1ZaCc32utXESofO38JwvwevAB3s0uRGgmS4N7WkML/5Ljo
        I4iqKveZu6rW87IOIPTOS9/+khIFae+wbiy1rh0=
X-Google-Smtp-Source: AMsMyM4kGQLDWyB8QPdQB0gSaZY0jopUbg0ROIJcNDy1dd1EtYpGLn6tVdf/4JP3TlQ1to3Fyjmj5FD4yThSZM6WIUU=
X-Received: by 2002:a05:622a:13c6:b0:39c:c34f:29ec with SMTP id
 p6-20020a05622a13c600b0039cc34f29ecmr32890078qtk.153.1666716930758; Tue, 25
 Oct 2022 09:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221013174612.393830-1-cristian.marussi@arm.com>
 <20221013174612.393830-2-cristian.marussi@arm.com> <20221014105143.4yxldx2idqgvmzgu@bogus>
In-Reply-To: <20221014105143.4yxldx2idqgvmzgu@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 18:55:19 +0200
Message-ID: <CAJZ5v0gNzZmwf1sXB4SkjmpLOKgv==uWDw7HYJjSzBHinuiEBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] powercap: arm_scmi: Add SCMI Powercap based driver
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com, wzmuda@marvell.com,
        dan.carpenter@oracle.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 12:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 13, 2022 at 06:46:12PM +0100, Cristian Marussi wrote:
> > Add a powercap driver that, using the ARM SCMI Protocol to query the SCMI
> > platform firmware for the list of existing Powercap domains, registers all
> > of such discovered domains under the new 'arm-scmi' powercap control type.
> >
> > A new simple powercap zone and constraint is registered for all the SCMI
> > powercap zones that are found.
> >
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: linux-pm@vger.kernel.org
>
> From the core SCMI perspctive, this looks good. I don't have much in-depth
> knowledge of powercap framework itself.
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as 6.2 material, thanks!

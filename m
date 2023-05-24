Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CC70F9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjEXPMb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEXPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:12:28 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235BA9;
        Wed, 24 May 2023 08:12:27 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9739440b60bso5467366b.0;
        Wed, 24 May 2023 08:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941146; x=1687533146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UXDN2PyeR99Kl2XuFYefQFHJngwboujdM25i9JFaEM=;
        b=MXLH3fZFEHydEHhm5WNWzI5DA6x0Q6R0rFB4YFLpmVdOMaghy4HCrDTYUmyLL8+NDV
         3EFIMxUmqic25s6tole3rEUBtcUMdqlN3AiF9aBrN/MKGjhR5dNUnaGjO6iDHtl4U52W
         tAP/ABET0BrzS0BW23GObPA5G0H+A+I9iHXIpH5SpSBKnoYOa+4qgQME8yQcqex3bIcX
         1VSU529KwS4ncOlMurRGFqAVAHn4cMs9LNjRHbFuJ7bvcEf5VrOfDJS9FplzWk+bu+Ps
         R7TA6FLi1buFTzu+rzihzUqOkD9+WqtGjJ75uWPtuHwtFf/pNHxofy5DE+fEAY5dwCY1
         V7Rg==
X-Gm-Message-State: AC+VfDyxCl9Awk4rZqG+rcMufUw57H5NhoPvIsqtE+aWXpm3ASrfp8zJ
        5l+/XWShKeVJCw4r+hWWWRSevxMvT/4iih91oUQ=
X-Google-Smtp-Source: ACHHUZ4OYPdWaQjx9yqyUgMixe1QqOmL2Nc5U20VrJQS3gNrmvMqNIY3XX7TiAPbxBd8sseRLVtrDiaz0cYTFW9ioVg=
X-Received: by 2002:a17:906:6495:b0:8d2:78c5:1d4e with SMTP id
 e21-20020a170906649500b008d278c51d4emr17846553ejm.5.1684941145779; Wed, 24
 May 2023 08:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230309140724.2152712-1-cristian.marussi@arm.com>
 <20230309140724.2152712-2-cristian.marussi@arm.com> <CAJZ5v0ixFvJ6akSMZmcUsg1n_kufq_WonWhS+ef=ps1FXKqUGQ@mail.gmail.com>
 <20230329120432.ao36v536sdwqi6e5@bogus>
In-Reply-To: <20230329120432.ao36v536sdwqi6e5@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 17:12:14 +0200
Message-ID: <CAJZ5v0jyuCoDKeZ-1YcAss_a-RFR2U+bXk7f8bNVJYrMg9OEZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] firmware: arm_scmi: Refactor powercap get/set helpers
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 2:05 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Mar 27, 2023 at 07:06:36PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Mar 9, 2023 at 3:09 PM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> > >
> > > Refactor SCMI powercap internal get/set helpers.
> > >
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >
> > I can apply this series if I get an ACK or preferably Reviewed-by:
> > from an SCMI person.
> >
>
> Sorry, I had looked at this and just delayed asking you about your preference.
> I am fine to take it

Yes, please!

> or else
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for SCMI parts)
>
> Please ack 3/3 if you prefer me to take it once you are happy with it.

Done, thanks!

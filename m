Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19CF6A95C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCCLEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCCLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:03:59 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28001715B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:03:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a9so2256517plh.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyqRiQrjRd/DgKhnwDjD3VNPSs/VOxygJCdNlbvjnIQ=;
        b=MTjWfUGO+7ykPOHEHtUdUjVgNfC2Wh8lenSwuk4fUAIoNx3/ktfeZK9Z2CZ/OWGVyT
         V4tsskVxDRyzjTqtFEhiwf715Q9PyRkLQWTpfIO7dvOCKMgr/kLOyY4g7pWb8fZd96+e
         275b4uk2BRWxqZwCMAqXCDSCPsgSdlH6OZHkZlEbwNRMYgdX1BkYhwIe5dQpFB8S4cE8
         AMcKjjY8NiFnHeQPFptLt81zppCMc0XCNpFva5wlX1ddc9/psw/arCRD49p6KZyCuyz9
         D9dUPUIBaO3YdflGuksqSX65sK/vTuHTcvQkYDWNB/hh7MK3haxe4un+uc/KNxBj49nq
         heow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyqRiQrjRd/DgKhnwDjD3VNPSs/VOxygJCdNlbvjnIQ=;
        b=d08d2p/MJt18IRmfEUFhl9y/mrycI3BSXKSyMJITNe/h393mu5WAHBuW76DKvTrwYg
         3Bn/HPNZLzSl6nEKE/j7DZViC4YmZ+i572B8fJtyspKo+hHpsZnGDnKGUdLwtY6wis/C
         327gtDatlwgnxMnnwBn/9ux1rfapUszOV0A99O+Byv+BD2Ac0rolBVSjaqa9sVEoke/b
         fcA7HTxqSmFN9QL3enUYGRV2rpdeB0f2MY8/7oPrl16nOYBnUktnx4p2UMzocDZ41OeQ
         rDckw4oW0rraAFlIa7oZGEDGV1L0aN5DZklb9esAFh3mpaTKFUDJ6Tnph9RnC11pdyWn
         mH5A==
X-Gm-Message-State: AO0yUKW+lofWT34RawYpgsGQRWzMR9tXpU+bnrP3oAHe9O6gR1WJYo1C
        xBq6QWROlZfTrngydn20TRrqqwHkQSD/mC6Y8WhngQ==
X-Google-Smtp-Source: AK7set8phWiie3Nf4hACV/MQGfEnXNww+J1KCgqC7NMtdqylWMY0nYuw9qGmwMYEN4ozV+WJlaB6y5J3YvDp90b3470=
X-Received: by 2002:a17:90b:1283:b0:234:925b:7d61 with SMTP id
 fw3-20020a17090b128300b00234925b7d61mr433000pjb.9.1677841437114; Fri, 03 Mar
 2023 03:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <58bb34de-e333-00bd-ae3f-4ddf0e56aa5d@gmail.com> <DM6PR04MB657530D5D51EF32A442C1409FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657530D5D51EF32A442C1409FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Mar 2023 12:03:20 +0100
Message-ID: <CAPDyKFo4_qgHycq+MSqMDKMJdqwyf8w=dLm3f_sFQWz30S9EJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Bean Huo <huobean@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 at 10:39, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > On 02.03.23 3:43 PM, Ulf Hansson wrote:
> > > REQ_FUA is in general supported for eMMC cards, which translates into
> > > so called "reliable writes". To support these write operations, the
> > > CMD23 (MMC_CAP_CMD23), needs to be supported by the mmc host too,
> > > which is common but not always the case.
> > >
> > > For some eMMC devices, it has been reported that reliable writes are
> > > quite costly, leading to performance degradations.
> > >
> > > In a way to improve the situation, let's avoid announcing REQ_FUA
> > > support if the eMMC supports an internal cache, as that allows us to
> > > rely solely on flush-requests (REQ_OP_FLUSH) instead, which seems to be a
> > lot cheaper.
> > > Note that, those mmc hosts that lacks CMD23 support are already using
> > > this type of configuration, whatever that could mean.
> > >
> > > Reported-by: Wenchao Chen<wenchao.chen666@gmail.com>
> > > Signed-off-by: Ulf Hansson<ulf.hansson@linaro.org>
> > Acked-by: Bean Huo <beanhuo@micron.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>

Thanks!

>
> Another option might be, allowing to report "broken_fua",
> should the platform owner chooses to, much like scsi does per sdev.

Are you suggesting a static or dynamic configuration option?

For mmc, we also have the card quirks that may be used to configure
the support for FUA, based upon what would work best for the card. Is
that what you were thinking of?

>
> Thanks,
> Avri

Kind regards
Uffe

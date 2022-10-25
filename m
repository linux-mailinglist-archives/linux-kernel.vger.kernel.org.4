Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B1F60D22B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiJYRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJYRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:00:11 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC146D97;
        Tue, 25 Oct 2022 10:00:10 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id 8so8530579qka.1;
        Tue, 25 Oct 2022 10:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTZQtE2w2U1K5L9bDC3388PiqB5iO4ZihXZEoNcy5mw=;
        b=PrOEAI8moSlUimbJ5mw0gxXPu1ABE0bw5C5mcA/a1HKk7vmTe/4Kv2zs1Te3p+jbXq
         BQFXNaxUUNQ3QGDNKDGTVxX3fq5tfp2bG+DDdLtTQZn+aQsZq/Htfk8EBPqHMn0ifPoJ
         dniMgi6jNRkH/nTB3towdtNdZVbeE9sKMsuSbrQVeDsNAgQTAUN5PRkrSpOyrCtw7vjz
         fcTLqBixMB6w6xYca/G8Lq19CtiyttTNPa6PZSOWM813SIFp8/QTu7hpNJPbenI3XGjn
         FlEs+YKC7mrhl9z3sTKO40bCsnruUs9tMdlpvCA3RcNaORnyNl/E39L/IyMZDNWCKQ6w
         B30g==
X-Gm-Message-State: ACrzQf1CaBmoSHT6VCPrycq3Ryjh4TERCNNgIZetUgoXi4tXvze0Ru3d
        iSB147T1V7vM0abjdPhQDfY5sZXGOdRYVPkM/OM=
X-Google-Smtp-Source: AMsMyM6NBZmStH15Smsny67sCBEAgrek7DrE2XPASyaiZdjzk7F3C8+Y4aId+7RT+W8+xX/aPCIZnpYfoXtN+lWPgV8=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr27251959qkl.443.1666717208955; Tue, 25
 Oct 2022 10:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666000867.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1666000867.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 18:59:58 +0200
Message-ID: <CAJZ5v0g9v6nsw1UftD7zGVYXKKTUN1y_sLgFG7Z+h9hVXoxU8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] thermal: Validate new state in cur_state_store()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 12:03 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> In cur_state_store(), the new state of the cooling device is received
> from user-space and is not validated by the thermal core but the same is
> left for the individual drivers to take care of. Apart from duplicating
> the code it leaves possibility for introducing bugs where a driver may
> not do it right.
>
> Lets make the thermal core check the new state itself and store the max
> value in the cooling device structure.
>
> Once this is merged, I will update the thermal drivers to stop checking
> for the same.
>
> Based of v6.1-rc1.
>
> Viresh Kumar (2):
>   thermal: Validate new state in cur_state_store()
>   thermal: sysfs: Reuse cdev->max_state
>
>  drivers/thermal/gov_fair_share.c |  6 +-----
>  drivers/thermal/thermal_core.c   | 15 ++++++-------
>  drivers/thermal/thermal_sysfs.c  | 37 +++++++++++++-------------------
>  include/linux/thermal.h          |  1 +
>  4 files changed, 24 insertions(+), 35 deletions(-)
>
> --

Both patches in the series applied as 6.2 material, thanks!

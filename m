Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F06322D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKUMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUMuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:50:51 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE3AB54D4;
        Mon, 21 Nov 2022 04:50:50 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id l2so7115827qtq.11;
        Mon, 21 Nov 2022 04:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZWlcs87et1TSZPqyxUAi9M3uvjB0Gjg8BMY4gTTc9Q=;
        b=j1ap7rezEsS4V87xPK1mnP2bWvXWnxP8M7CkaC3/382B3AAT8gQ6ZsKbrUDswmWUBO
         vFLgddo9+OXp1GYcoSrOPPXgHe4G2XVJvAcGeO4kmjHTE52xdoMWOFovMw8wdRQIsEL3
         anJmRjxcp75agi02aP1nqq1OZBcq5XKOcruknub0xSZVd98RdJL2Lbs1sE2vbyxYraIf
         nZDpPxFkyTfI9qiqtWkiaInn6nLxLV9IhZKhC2xDQ4f4EfKebBCExrSRyP1XVzHCsiFp
         NNRn2VAnqVds21SLL2vzdDlWo5nxTyIzzUamSED3ff/4S4UwSLRexWzhu1bfvfeeRiPC
         5jXA==
X-Gm-Message-State: ANoB5pmLlxZ9lm0gGNMpMnd51XLdWwyoWzU2JmRp68N548GLELhEsWmp
        KVljaERWLhWymYlHvdxRoJEw6CJJZ3hL3py3gyU=
X-Google-Smtp-Source: AA0mqf7L7Nf2BFFBq5yvUh3FbBGduEJVCaI7f3nNwUpzYil/EXTLQWN2i51odCO611N3LVmXgCcElrWWs8p8jdrdWl0=
X-Received: by 2002:ac8:73c4:0:b0:3a5:a53d:a102 with SMTP id
 v4-20020ac873c4000000b003a5a53da102mr17306577qtp.153.1669035049621; Mon, 21
 Nov 2022 04:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com> <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
In-Reply-To: <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Nov 2022 13:50:34 +0100
Message-ID: <CAJZ5v0hi0Shr4ae7_Fj=eZ6GUsALJnhwxWJic0ASr=FR5C++Ug@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 1:23 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi Rafael,
>
> On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski wrote:
>
> [...]
>
> > v3 -> v4:
> > - remove the chunk of code skipping metrics updates when the CPU was utilized
> > - include new test results and more benchmarks in the cover letter
>
> [...]
>
> It's been some time so I just wanted to bump this, what do you think
> about this v4? Doug has already tested it, resuls for his machine are
> attached to the v3 thread.

I have some comments, but it's being pushed down by more urgent things, sorry.

First off, I think that the information from your cover letter should
go into the patch changelog (at least the majority of it), as it's
relevant for the motivation part.

Also I think that this optimization is really trading energy for
performance and that should be emphasized.  IOW, it is not about
improving the prediction accuracy (which is what the cover letter and
changelog seem to be claiming), but about reducing the expected CPU
wakeup latency in some cases.

I'll send more comments later today if I have the time or later this
week otherwise.

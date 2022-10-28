Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C006119EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJ1SKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJ1SKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:10:38 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4748D22D;
        Fri, 28 Oct 2022 11:10:35 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id k4so1064259qkj.8;
        Fri, 28 Oct 2022 11:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcLuxRQs5tABHxAs+Y7/Lan+bBcM/F9sLFO2LCCg8pI=;
        b=fFRnJD+ZWuW4TVrnQD3vavTqjwCWgCugY3lLjK6PBU5t72rZM4bv9yno4wSkk/aTej
         GLTlxeI6F3NONCV/e9xsiSwvJsHgHi06X8F0iyO9RXwMbC56wcm/rEOc6W68q0/wOTrE
         cyS+JMDZ5p661J/LVsdprqs2SM7eY0hDQBjx49GNZKQVN3yRDtzCGz8BxplBVjm0YVeC
         rkcwNZLLtUcOvc1ZsL8amoGbY0LkfzIgqert4p15Q80yQlVtiuKf6JOIZUZMroo9r5t9
         rNEH1K9zMkQtqWSSxJIdMD55fEytZXaKiPHIfXUYG5xUfb4DhpjTToC6HK20DnFdYRK4
         nGtw==
X-Gm-Message-State: ACrzQf37rJm6sPrw9Qf9mAgxeZyUN6S/KPB9RYHbqF/cJdF7SlhvaCTC
        g3XiALyFQJL9/6LkMxCJATBm74NswaUnvjWzNqg=
X-Google-Smtp-Source: AMsMyM54EVSBeljNE55w6SiZvJVeDXIdVmQr3Abl3AV8IYuAQ+bIargizIY/e8fCVgrBAre4T1vZ4n1HAXQwNX4+KBg=
X-Received: by 2002:a37:b1c2:0:b0:6fa:1185:4dbf with SMTP id
 a185-20020a37b1c2000000b006fa11854dbfmr389886qkf.764.1666980634716; Fri, 28
 Oct 2022 11:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221021151013.148457-1-ulf.hansson@linaro.org> <20221025114308.4kevtiz5heoekgz3@bogus>
In-Reply-To: <20221025114308.4kevtiz5heoekgz3@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 20:10:23 +0200
Message-ID: <CAJZ5v0hQj2OgpCj-6REuCYwMn+qoHc1TXQ+HjtqL8JcL8XPQRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpuidle: dt: Return the correct numbers of parsed
 idle states
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 25, 2022 at 1:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Oct 21, 2022 at 05:10:12PM +0200, Ulf Hansson wrote:
> > While we correctly skips to initialize an idle state from a disabled idle
> > state node in DT, the returned value from dt_init_idle_driver() don't get
> > adjusted accordingly. Instead the number of found idle state nodes are
> > returned, while the callers are expecting the number of successfully
> > initialized idle states from DT.
> >
> > This leads to cpuidle drivers unnecessarily continues to initialize their
> > idle state specific data. Moreover, in the case when all idle states have
> > been disabled in DT, we would end up registering a cpuidle driver, rather
> > than relying on the default arch specific idle call.
> >
>
> Makes sense.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied along with the [2/2] as 6.2 material, thanks!

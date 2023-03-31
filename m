Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB406D1B47
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjCaJFb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 05:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjCaJFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:05:03 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6A71E728;
        Fri, 31 Mar 2023 02:04:58 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id t10so86796500edd.12;
        Fri, 31 Mar 2023 02:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg7UvCKf4FflsOaE7m6CKblqSYNUNLu+zsGJqL+kAIo=;
        b=CyWjmHBNCMZOZgEzkZ/LUgXPVLWsoZPxzn+HK2G6vFfmkJ53uscRRZQBbGJgBzdWp0
         T/WG0XS1weZSm+KfPeR+so2Pcx7eQAHhiYrqvsC/ZMoYrxk8Y9RJD+7W+X6oOrOhpKcw
         0iKfuboEwX7hrfOWKEID0y9WiZpl5QnCuTLqAr7DvxQG967Ht8IvosJAMru+mk+vFwR+
         tbxHOnMdMjR10skuQN8HReLsjv1wSIDic77khVeA9ZL/kx6v6yznFSfAGiW77yRxM8WS
         QWz1uoohWSTR1k/BGoDmerUZH8JcthN6zEHBjdxkSxxAHJ7FvXVVY602zt+vMYx3Gkfk
         YwJg==
X-Gm-Message-State: AAQBX9e09aaou8ff1PTTBf0XU8H2jZuq7hQvcbtTtOC8wjsvYEFgQ0Z0
        WBBCKka7wYfbmiW7CKftXeldEjliwu8NhXq/fSE=
X-Google-Smtp-Source: AKy350ZubaYRqIEgMdcx/bX/uJcrS6NTNG8xSB+YnlIP65Jv2fmonLvwL9ZmfCS2Wbvtq4XF3yqqER+2aj6WGc1q+qU=
X-Received: by 2002:a50:cc94:0:b0:4fb:c8e3:1ae2 with SMTP id
 q20-20020a50cc94000000b004fbc8e31ae2mr13352964edi.3.1680253496669; Fri, 31
 Mar 2023 02:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144726.1545543-1-robh@kernel.org> <CAJZ5v0hAeRa9xsp6-_um9j-9F6nf=PYuOC2mgMAmmUHP+9=RZg@mail.gmail.com>
 <CAJZ5v0i-Vum+js8c7fZJiQWwTBYByy2O=UtObR6GciLMLt41Nw@mail.gmail.com> <f4592c81-af30-8289-d02d-a44e25e0fe26@linaro.org>
In-Reply-To: <f4592c81-af30-8289-d02d-a44e25e0fe26@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 11:04:44 +0200
Message-ID: <CAJZ5v0ioHh2E1krvVhXTdzKN+Bh64ML+t5v-Tnt+bORpAqHUyw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Use of_property_present() for testing DT
 property presence
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
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

On Fri, Mar 31, 2023 at 10:44 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 30/03/2023 19:28, Rafael J. Wysocki wrote:
> > On Mon, Mar 27, 2023 at 7:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Fri, Mar 10, 2023 at 3:48 PM Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> It is preferred to use typed property access functions (i.e.
> >>> of_property_read_<type> functions) rather than low-level
> >>> of_get_property/of_find_property functions for reading properties. As
> >>> part of this, convert of_get_property/of_find_property calls to the
> >>> recently added of_property_present() helper when we just want to test
> >>> for presence of a property and nothing more.
> >>>
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>
> >> Daniel, are you going to apply this, or should I take it directly?
> >
> > Applied as 6.4 material, thanks
>
> Sorry, I forgot to answer. I already applied it.
>
> Shall I drop it from my branch ?

If you can do that, then yes, please.

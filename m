Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7C77439D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjF3Kqm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jun 2023 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3Kqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:46:38 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96DEF0;
        Fri, 30 Jun 2023 03:46:37 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98502b12fd4so45256766b.1;
        Fri, 30 Jun 2023 03:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688121996; x=1690713996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/UBV7P1ulz8YvA35BhCt72l7KfIOxYTNUGMNlMCewg=;
        b=CfdwF6kGwnTz+N01bo4RiU6731eJOd4t7eumO2s9F9czzzs0hGTrdLddF0nSE9EHEm
         b/Eo5ZuLVI5hWttQgwALUii+30EHC97JHqnJJB3oIUX5EtjFtHk95MISnXHi9jc2XNa4
         syE61espwdTE0OA3WOW0OCZdPsF4ZxruTYLxePVmUOcWwqsBuJpofit97cVpxuuFRpxm
         JB/CXTssmXrDxbOnOTDpbx8YwmRoMq01QObcp9bzdH+NN7/s/BWpcatUIV8tgEKq0jPe
         gNWV7AR/db5vAiD8J65q8y/mHgn7gmsKY13hlfiv/698grDge/6Vvi3/kTDytw2Jo18g
         DMsQ==
X-Gm-Message-State: ABy/qLYFa0CvbtbNFMaB1EJ7NQ7vxb63i+nJW2isTp5h8ESOQr3OpIm2
        3HBoAfz7yK9u/UZmnvVTFJWQ9XUpHIAvoxXdx08=
X-Google-Smtp-Source: APBJJlHAbw3cv+huvJUtlKwW2ExWGqSGStRGZZzCW/2PIO1UUthMw3rlS5DOVBCNSj+a75AK0FsQfC5rqzpn02VyAvk=
X-Received: by 2002:a17:906:1109:b0:988:f9ba:e18d with SMTP id
 h9-20020a170906110900b00988f9bae18dmr1539376eja.6.1688121996174; Fri, 30 Jun
 2023 03:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230607003721.834038-1-evalenti@kernel.org> <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com> <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com> <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com> <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com> <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com> <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
In-Reply-To: <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jun 2023 12:46:24 +0200
Message-ID: <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Jun 30, 2023 at 12:11 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 30/06/2023 10:16, Rafael J. Wysocki wrote:
> > On Wed, Jun 28, 2023 at 11:10 PM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> [ ... ]
>
> > So what about adding a new zone attribute that can be used to specify
> > the preferred caching time for the temperature?
> >
> > That is, if the time interval between two consecutive updates of the
> > cached temperature value is less than the value of the new attribute,
> > the cached temperature value will be returned by "temp".  Otherwise,
> > it will cause the sensor to be read and the value obtained from it
> > will be returned to user space and cached.
> >
> > If the value of the new attribute is 0, everything will work as it
> > does now (which will also need to be the default behavior).
>
> I'm still not convinced about the feature.
>
> Eduardo provided some numbers but they seem based on the characteristics
> of the I2C, not to a real use case. Eduardo?
>
> Before adding more complexity in the thermal framework and yet another
> sysfs entry, it would be interesting to have an experiment and show the
> impact of both configurations, not from a timing point of view but with
> a temperature mitigation accuracy.
>
> Without a real use case, this feature does make really sense IMO.

I'm kind of unsure why you think that it is not a good idea in general
to have a way to limit the rate of accessing a temperature sensor, for
energy-efficiency reasons if nothing more.

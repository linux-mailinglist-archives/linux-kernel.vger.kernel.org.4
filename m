Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4D6B2DFC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCITyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCITyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:54:07 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882986B32B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:54:06 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a3so2717469vsi.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678391645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqpcGDTF9TvNcH8vUk4y3HxaqWz3ChIQXFNytcqy8nU=;
        b=OJbln4sdUL4EAT7TMgmdVYhV87K5DCcUK1N6+s4b6mo9FsSNTACJr8B67kxGsBmgAo
         GcY7w0Mdqf0D+1c4yh6n1ULBJUXd1SI97oywSezgjCGdhd8deH6bTizYEtqVtlJ21zkO
         2kycYb+om4iP4IdH/xivp18F5koYqU0fjFJaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678391645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqpcGDTF9TvNcH8vUk4y3HxaqWz3ChIQXFNytcqy8nU=;
        b=jGMT74FNRF+kUIGMOCI0ixywfy9rxq9UidnCjhDrEGu3yi3RDjyOyh/qYwocI3dDpx
         HOMBKSZPIsIJVkTgK9iKaMXvMOIaYgINZ32EGm728cUK6XzoyGSOTAeVMK+Q1B8nBlcS
         ob0st91OUWSCaQtCe8zWRnrdN0maRPaXhB02dmhjyLK2ut8vCjcq2vWvoTN361pyfhTh
         sFwGHxODJhoqkdF/ufUCuLTroDwhW7w+FP9tJh1HMwbCVwtjjkAvyG1CyJpNgJjluqiR
         5BB89/ntvP2Tu5GoJjt3angzZ2EcvvgTi9aHEHxJAdePtAdXFW1HBMQwxGMX/NRUbZ6e
         39yQ==
X-Gm-Message-State: AO0yUKVU4Hzr4OfargDJ8tluaetzLduRV6213qRbnrVxoNxI7L9al95A
        TSqe2UNLYdOTNitR2sCaHQpSr8aVhZwhdpHCO/UO2g==
X-Google-Smtp-Source: AK7set8IhMjIfSIqc5tWtr8EnGWBjwWQ1Qw4o1RTQNtpBk0PXRu13Gppe1EWsTNPEF2TEFMhKolo/tokyByyIxtxAxo=
X-Received: by 2002:a05:6102:3167:b0:421:a2e2:cf30 with SMTP id
 l7-20020a056102316700b00421a2e2cf30mr15502192vsm.5.1678391645507; Thu, 09 Mar
 2023 11:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20230308202159.2419227-1-grundler@chromium.org>
 <20230308202159.2419227-2-grundler@chromium.org> <ZAnBCQsv7tTBIUP1@nanopsycho>
 <CANEJEGuK-=tTBXG6FpC4aBb7KbsNZng2-Rmi0k6BJJ7An=Pyxw@mail.gmail.com> <07dd1c76-68a1-4c2f-98fe-7c25118eaff9@lunn.ch>
In-Reply-To: <07dd1c76-68a1-4c2f-98fe-7c25118eaff9@lunn.ch>
From:   Grant Grundler <grundler@chromium.org>
Date:   Thu, 9 Mar 2023 11:53:54 -0800
Message-ID: <CANEJEGurX3Kr30Dv5_LzxN+shYuWXxxbEJG1MOgOOhpAq1WzLA@mail.gmail.com>
Subject: Re: [PATCHv3 net 2/2] net: asix: init mdiobus from one function
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Grant Grundler <grundler@chromium.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Eizan Miyamoto <eizan@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:30=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I hope the maintainers can apply both to net-next and only apply the
> > first to net branch.
>
> Hi Grant
>
> Please take a look at
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> Please submit the first patch to net. Then wait a week for net to be
> merged into net-next, and submit the second patch to net-next.

Thanks Andrew!
I read maintainer-netdev.html when Jakub pointed me at it a few days
ago. He also instructed me to use "net" but didn't specify for the
second patch - so I assumed both patches.

I'll follow your instructions and repost to net-next once the first
patch has been merged.

cheers,
grant

>
>        Andrew

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA886FC055
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjEIHU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:20:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6C52688;
        Tue,  9 May 2023 00:20:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QFqM52DdNz4x3g;
        Tue,  9 May 2023 17:20:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683616851;
        bh=2wjmKTbt/z5/1Lgzb67uZ1KsoxbcTNd7BEGnUaPkJ+A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gywRbWdSmUgbLXjnspObVrUv7pOsxsVhSbXU+zEQv1KxI3iQgbMLGV1sgY9TK3HlP
         mxau4GAW14GS7xLkEVVGt6TSUjDdnI5gQ/yqzOjt4UCnnZWSLHcIgVNj68ChxG08lD
         vRtFnnM842n16stuYmzmQHCXsKAqPyWp2WWJvsx+jRTLU9LsG8XgXgmPcL/RXmpXPi
         oQLUh6oCZ+H+Syx+bRcmjd7Wh6fDNKVW4OIOcI6c8JL50e0arVtLxUfpndCjg58KQP
         Nb4QsloFLe6SCwbo8J9T15yZrdQuazh7lwYNglnE2FlJrSPA1dTdzlh4JYwTc8ZYnb
         FZOpgLXwBHWlg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Li Yang <leoyang.li@nxp.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "Y.B. Lu" <yangbo.lu@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/6] bus: fsl-mc: Make remove function return void
In-Reply-To: <CADRPPNQ0QiLzzKhHon62haPJCanDoN=B4QsWCxunJTc4wXwMaA@mail.gmail.com>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
 <20230412171056.xcluewbuyytm77yp@pengutronix.de>
 <AM0PR04MB6289BB9BA4BC0B398F2989108F9B9@AM0PR04MB6289.eurprd04.prod.outlook.com>
 <20230413060004.t55sqmfxqtnejvkc@pengutronix.de>
 <20230508134300.s36d6k4e25f6ubg4@pengutronix.de>
 <CADRPPNQ0QiLzzKhHon62haPJCanDoN=B4QsWCxunJTc4wXwMaA@mail.gmail.com>
Date:   Tue, 09 May 2023 17:20:48 +1000
Message-ID: <87ednqx967.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Yang <leoyang.li@nxp.com> writes:
> On Mon, May 8, 2023 at 8:44=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> Hello Leo,
>>
>> On Thu, Apr 13, 2023 at 08:00:04AM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> > On Wed, Apr 12, 2023 at 09:30:05PM +0000, Leo Li wrote:
>> > > > On Fri, Mar 10, 2023 at 11:41:22PM +0100, Uwe Kleine-K=C3=B6nig wr=
ote:
>> > > > > Hello,
>> > > > >
>> > > > > many bus remove functions return an integer which is a historic
>> > > > > misdesign that makes driver authors assume that there is some ki=
nd of
>> > > > > error handling in the upper layers. This is wrong however and
>> > > > > returning and error code only yields an error message.
>> > > > >
>> > > > > This series improves the fsl-mc bus by changing the remove callb=
ack to
>> > > > > return no value instead. As a preparation all drivers are change=
d to
>> > > > > return zero before so that they don't trigger the error message.
>> > > >
>> > > > Who is supposed to pick up this patch series (or point out a good =
reason for
>> > > > not taking it)?
>> > >
>> > > Previously Greg KH picked up MC bus patches.
>> > >
>> > > If no one is picking up them this time, I probably can take it throu=
gh
>> > > the fsl soc tree.
>> >
>> > I guess Greg won't pick up this series as he didn't get a copy of it :=
-)
>> >
>> > Browsing through the history of drivers/bus/fsl-mc there is no
>> > consistent maintainer to see. So if you can take it, that's very
>> > appreciated.
>>
>> My mail was meant encouraging, maybe it was too subtile? I'll try again:
>>
>> Yes, please apply, that would be wonderful!
>
> Sorry for missing your previous email.  I will do that.  Thanks.

Does MAINTAINERS need updating?

It says:

QORIQ DPAA2 FSL-MC BUS DRIVER
M:	Stuart Yoder <stuyoder@gmail.com>
M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
L:	linux-kernel@vger.kernel.org
S:	Maintained
...
F:	drivers/bus/fsl-mc/


cheers

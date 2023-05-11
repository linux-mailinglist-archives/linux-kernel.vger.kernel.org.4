Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC06FF01E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjEKKtJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbjEKKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:49:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894F5BA5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:48:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-iCHHTVxWNbqcZ3-yAECREg-1; Thu, 11 May 2023 11:48:39 +0100
X-MC-Unique: iCHHTVxWNbqcZ3-yAECREg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 11 May
 2023 11:48:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 11 May 2023 11:48:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tony Lindgren' <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
Thread-Topic: [PATCH v2 1/2] iopoll: Call cpu_relax() in busy loops
Thread-Index: AQHZg9SqgvUK/klkyEy9n2eMPFqMgK9U5DUg
Date:   Thu, 11 May 2023 10:48:37 +0000
Message-ID: <494a000774b546e4aae00ae0a7dfeae4@AcuMS.aculab.com>
References: <cover.1683722688.git.geert+renesas@glider.be>
 <fe235a1f65bb6c86d2afcdf52d85f80ae728dcc5.1683722688.git.geert+renesas@glider.be>
 <20230511064839.GG14287@atomide.com>
In-Reply-To: <20230511064839.GG14287@atomide.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren
> Sent: 11 May 2023 07:49
> 
> * Geert Uytterhoeven <geert+renesas@glider.be> [230510 13:23]:
> > It is considered good practice to call cpu_relax() in busy loops, see
> > Documentation/process/volatile-considered-harmful.rst.  This can not
> > only lower CPU power consumption or yield to a hyperthreaded twin
> > processor, but also allows an architecture to mitigate hardware issues
> > (e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
> > architecture-specific cpu_relax() implementation.

Don't you also need to call cond_resched() (at least some times).
Otherwise the process can't be pre-empted and a RT process
that last ran on that cpu will never be scheduled.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB0770BA41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjEVKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjEVKlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:41:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30464DB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684752082; i=efault@gmx.de;
        bh=162mx++aiaIC4AFXOHEHGhjNzTocOAtT1cfLol+uyh8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=W5TGHberS3V51Ns2UfZ26zN/AHhaiZIs0ENtUo0GrlildhPWU2OEdnnTiODUQAeDS
         6sYYNlxA5lLapR2mZWKjwxhSJ18fVyj8wxwKpJblTHdWeX2NLPmAl6cJqkNaFUkCEn
         Zko7nzfo5SHA58w72mw5AHw44tUt/Hx/ftPnzllPYIUh8YKIK9A8Q/zkYuWITgT8z5
         u9AL5JJ6Iid8BMjeUsNsXwaPh1rYWx8XUaeyTJNBtdhoF3hs9Jvk12QYqDRlE1JlUp
         poIxdsvU0hAu2YrestOA1WUGcXcWhBEjtdrSHYeB4PihKnbvjArMfVp3EZkCaqrxQX
         ut0E1r0S0cqPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.219.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1qNx710RtN-00wnMZ; Mon, 22
 May 2023 12:41:22 +0200
Message-ID: <d7fa9ffe0e6cd546b8ff3826379c2cf78e5342b6.camel@gmx.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 22 May 2023 12:41:21 +0200
In-Reply-To: <20230522080604.MgUGcyeU@linutronix.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
         <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
         <20230522080604.MgUGcyeU@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TAylgSoyLoI+cbCltsiawQH000B+vqlIkB+MtmwXqagH3DJA9BG
 MElSg8P2j8qSQTqo9CBXAIsCwGIIsFZWBce1BZBEDv+h/lCxKQyEUjWf8HL91Z7f2qSr/X5
 dICWbr1vElr0+bxaYXbc1LR3lMxvFZmgcxoDFNjksEZ+q5bedSzhC0CShZgWDOXI/X/rEKW
 42pD/JV7Kjj7W8bwHZuYw==
UI-OutboundReport: notjunk:1;M01:P0:8NjwXDj9Ajw=;6hXmc9tYXbQV5is+P+p15s8OZds
 osuXCGr16efZNffEq4Wor+FLJvabhAB2Nqcf5iYCZeCK2LnRcqseVmvoDOnkVkut2S/u8Xdph
 65BtUVs9veBLlgGAG2XFRQJUezxwUY8at+sNeFxJICwr0cCTgltjl2G5Frj5xOSAyRYcq5n/T
 5NM6b7uxd+w74uJnL6v0ivO8Y5/EDGNVnys5rXTvKNsiP1JsUmoS7cYHuI/zeLRGvss3uBuus
 GsUC49s4hCcBf32Z1RvbBiK8dTlWHdNdDx4KuDZ3ZMt/HND5WlRK0U0AQOgmSpa8cl+osBkTP
 8xXgmePm4QcZUu+UN/yBTOLTsJ4UxbTq7/t3E2bdeLefhjmt5ISnSLmlXCCxnRr5Wuu8NPVUb
 KR3KRDX/6JFXNr9zU+rGr3FBb2eYXc7MiM9zppAq5mN8qD03VEuD1MlsTUWGXr3zTh2ZTUFFZ
 nTDrlY6S0mzE75og0s8PUhr5Nj9XUnJrgkDQ/SIW3LWi60MIo4yiKIftIehi6heqsSfdAphuP
 CTu0gj4y34VsFSIMgOsWTK1Je4ZCNZBhGDV+yFghzLFVIzrN67WiGY2L+SsrKBkVkrOWSVwqq
 HEKtksod5CS0lMgD3z6hIA+EgQUu3/17cAvZydhco1cpBRQ2q59sCCbx7NmoAHw7/5ujFyssl
 4yMaFcdbBx9ptKpMrA+oPpyVTG5MKfBzP32Hdw37Q2q+QdK+OziT2C+qY1e7fawS6MREZ/nf3
 bMOclQBPDKtrKqQSbzSZTlW6baFqfKR/yQI3NV9odr7DyP3e8lOTLgS/yMnLaOd7loH8tk9ye
 EJafH/seAyNK+GoHg2Vxbak+DIxIIqgCOqo7Y6goLAcUDUb83079ovOseEN5/9bILVHoJelM+
 bddv9XrIeKg5bThm1FthxxrHRM62T7l4zX5zW/dctjwQuf4eEKZky1S6SRnRRi057D52kEPzH
 9wfRT7Un3gpb41CAGoMSg65+7ME=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-22 at 10:06 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-05-21 16:27:10 [+0200], Mike Galbraith wrote:
> > On Sun, 2023-05-21 at 08:03 +0200, Mike Galbraith wrote:
> > > Greetings,
> > >
> > > The locks added to prep for $subject induce invalid context moaning =
due
> > > to not being raw locks, but if I do that, the hold time does very ba=
d
> > > things to RT.
> >
> > The locks aren't really 160us horrible. The GPU was enabled (oops),
> > nouveau then makes box horrible for RT (and graphics:).=C2=A0 With GPU
> > turned back off, the largest trace I saw was 77us, which jibes pretty
> > well with new max of low to mid 50s without ftrace running, or up a ta=
d
> > over 20us for this now pretty old commodity i7 desktop box.
>
> So you are saying it is all good?

I wouldn't say good, but not the sky is falling 160us bad.

> I've been looking at the r8169 the other day and it seemed all good
> since it was only scheduling workqueues and NAPI. But now I see this
> mac_ocp_lock + config25_lock which are acquire in hardirq context but
> can't. This needs to be taken care.

I did a patch converting the locks, but didn't post it hoping maybe
those locks weren't really really needed.  It doesn't matter for my
box, as it doesn't do anything but give RT chances to trip over bugs.

	-Mike

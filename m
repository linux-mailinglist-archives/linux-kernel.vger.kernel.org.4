Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482FA72FC74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbjFNLaZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFNLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:30:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7053E55
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:30:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-f8v9-c73Obe53UlMQEGF2A-1; Wed, 14 Jun 2023 12:30:18 +0100
X-MC-Unique: f8v9-c73Obe53UlMQEGF2A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 14 Jun
 2023 12:30:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 14 Jun 2023 12:30:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sven Schnelle' <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tracing: fix memcpy size when copying stack entries
Thread-Topic: [PATCH] tracing: fix memcpy size when copying stack entries
Thread-Index: AQHZnqzKx3JbU4cZlkeCRQJzbO4XQa+KKVfQ
Date:   Wed, 14 Jun 2023 11:30:15 +0000
Message-ID: <a64f80ed957d430bbbf73cdc4ad5c8e2@AcuMS.aculab.com>
References: <20230612160748.4082850-1-svens@linux.ibm.com>
        <20230612123407.5ebcabdf@gandalf.local.home>
        <yt9dy1koey7h.fsf@linux.ibm.com>
        <20230613113737.1e07c892@gandalf.local.home>
 <yt9dttva8gxt.fsf@linux.ibm.com>
In-Reply-To: <yt9dttva8gxt.fsf@linux.ibm.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle
> Sent: 14 June 2023 11:41
> 
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > On Tue, 13 Jun 2023 07:19:14 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> >
> >> > Yes the above may be special, but your patch breaks it.
> >>
> >> Indeed, i'm feeling a bit stupid for sending that patch, should have
> >> used my brain during reading the source. Thanks for the explanation.
> >
> > Does this quiet the fortifier?
> > [..]
> 
> No, still getting the same warning:
> 
> [    2.302776] memcpy: detected field-spanning write (size 104) of single field "stack" at
> kernel/trace/trace.c:3178 (size 64)

What about:
	(memcpy)(......)

Or maybe:
	(__builtin_memcpy)(....)


	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


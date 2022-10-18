Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162066034E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJRV11 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Oct 2022 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJRV1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:27:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD27FFAC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:27:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-qOH_xBdJOBaF_O3VLLyPvA-1; Tue, 18 Oct 2022 22:27:17 +0100
X-MC-Unique: qOH_xBdJOBaF_O3VLLyPvA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Oct
 2022 22:27:16 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 18 Oct 2022 22:27:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joao Moreira' <joao@overdrivepizza.com>
CC:     'Peter Zijlstra' <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>
Subject: RE: [PATCH] x86/ibt: Implement FineIBT
Thread-Topic: [PATCH] x86/ibt: Implement FineIBT
Thread-Index: AQHY4vaTWxnEUTsnZEq6+EVM+oAeM64UOHoQgAAFvACAAGqpYA==
Date:   Tue, 18 Oct 2022 21:27:15 +0000
Message-ID: <b16965fba2d245a9ae49c1edd20832e0@AcuMS.aculab.com>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <9bb036e48580454b81e6de7224c5f006@AcuMS.aculab.com>
 <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
In-Reply-To: <3edb387ea335085dcb6dd49f1d9c9ce6@overdrivepizza.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira
> Sent: 18 October 2022 16:58
> 
> > Does the hash value for kCFI only depend on the function type?
> > Or is there something like a attribute that can also be included?
> 
> Hi David -- does this sound like what you are asking about?
> 
> https://github.com/ClangBuiltLinux/linux/issues/1736
> 
> If yes, then it is something in our todo list :) I think Sami is
> handling it.

That sort of thing.
As well as helping restrict what can be called from where,
with reasonable unique CFI hashes something like objtool can
work out which functions are callable from which call sites.
This should give the raw data than can be used for static
stack-depth analysis.

Possibly even the compiler could output the 'called
function xxx at stack offset nnn' data.

From some experience doing static stack depth analysis
many years ago (on a code base that had no recursion and
very few indirect calls) the result will be unexpected.
I suspect the kernel stack is nothing like big enough
for the worst case error path!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


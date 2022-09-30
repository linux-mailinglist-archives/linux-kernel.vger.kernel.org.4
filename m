Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B585F14F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiI3Ver convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Sep 2022 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiI3Ve1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:34:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339B1D1A7A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:34:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92-6L0_Y9URMfO4eHTHzlMxwg-1; Fri, 30 Sep 2022 22:34:24 +0100
X-MC-Unique: 6L0_Y9URMfO4eHTHzlMxwg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 30 Sep
 2022 22:34:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 30 Sep 2022 22:34:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hugh Dickins' <hughd@google.com>,
        Kees Cook <keescook@chromium.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Thread-Topic: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Thread-Index: AQHY1LmyNvo5HN+EEECxPXiP8YKQXa33zoaAgABIuACAAGaCkA==
Date:   Fri, 30 Sep 2022 21:34:23 +0000
Message-ID: <aa1785a02b7e4472a89c87f3b664731f@AcuMS.aculab.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <c432330b-33f0-82d0-65f1-a548ce0658b1@suse.cz>
 <16fe443a-dabe-aa46-6bc7-dad03f29e0dc@google.com>
 <c1c8920a56014a179dbb82d483f2ad28@AcuMS.aculab.com>
 <06329f-e498-ccc-6223-32f87716436d@google.com>
In-Reply-To: <06329f-e498-ccc-6223-32f87716436d@google.com>
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

From: Hugh Dickins
> Sent: 30 September 2022 17:22
> 
> On Fri, 30 Sep 2022, David Laight wrote:
> > > > > Regarding "conflicting" alignment requests: yes, I agree with you,
> > > > > it would have to be a toolchain bug if when asked to align 2 and to
> > > > > align 4, it chose not to align 4.
> >
> > See https://godbolt.org/z/3nGsTaf5e
> > the align() directive takes precedence.
> >
> > Here you only want to ensure the alignment is at least 4.
> 
> Sorry, I don't understand the point you are making,
> nor how to deduce it from the link which you give:
> I'll leave it to those who understand better.

(I've copied Kees Cook - I think it is his patches that are
increasing the function alignment.
He'll need to find the thread history...)

IIRC -malign_functions is being used to put functions onto
16 byte boundaries to get aligned pad space before the function.
Adding __align(4) overrides this and (I think) will remove
the pad space.

I could only see the alignment directives in gcc ouput.
clang didn't seem to generate them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFC05F09DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiI3LSL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Sep 2022 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiI3LRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:17:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384317884
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:02:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-1kEuWYt-Pb-bGG9NzbX_dA-1; Fri, 30 Sep 2022 12:02:41 +0100
X-MC-Unique: 1kEuWYt-Pb-bGG9NzbX_dA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 30 Sep
 2022 12:02:38 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 30 Sep 2022 12:02:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Hugh Dickins' <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Thread-Topic: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Thread-Index: AQHY1LmyNvo5HN+EEECxPXiP8YKQXa33zoaA
Date:   Fri, 30 Sep 2022 11:02:38 +0000
Message-ID: <c1c8920a56014a179dbb82d483f2ad28@AcuMS.aculab.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <c432330b-33f0-82d0-65f1-a548ce0658b1@suse.cz>
 <16fe443a-dabe-aa46-6bc7-dad03f29e0dc@google.com>
In-Reply-To: <16fe443a-dabe-aa46-6bc7-dad03f29e0dc@google.com>
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

> > > Regarding "conflicting" alignment requests: yes, I agree with you,
> > > it would have to be a toolchain bug if when asked to align 2 and to
> > > align 4, it chose not to align 4.

See https://godbolt.org/z/3nGsTaf5e
the align() directive takes precedence.

Here you only want to ensure the alignment is at least 4.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


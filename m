Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422D5EF4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiI2Lx2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Sep 2022 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiI2LxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:53:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A7151B10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:53:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-FG1UcietOBqlK6YUwDSrzw-1; Thu, 29 Sep 2022 12:53:20 +0100
X-MC-Unique: FG1UcietOBqlK6YUwDSrzw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 29 Sep
 2022 12:53:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Thu, 29 Sep 2022 12:53:17 +0100
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
Thread-Index: AQHY02LHNvo5HN+EEECxPXiP8YKQXa32TN+Q
Date:   Thu, 29 Sep 2022 11:53:17 +0000
Message-ID: <9368c760191448bba0e062709cc7c799@AcuMS.aculab.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
In-Reply-To: <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
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

> -static void rcu_free_slab(struct rcu_head *h)
> +/*
> + * rcu_free_slab() must be __aligned(4) because its address is saved
> + * in the rcu_head field, which coincides with page->mapping, which
> + * causes trouble if compaction mistakes it for PAGE_MAPPING_MOVABLE.
> + */
> +__aligned(4) static void rcu_free_slab(struct rcu_head *h)
>  {
>  	struct slab *slab = container_of(h, struct slab, rcu_head);
> 

Isn't that going to cause grief with options that align
functions on 16/32byte boundaries when adding space for
'other stuff'?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


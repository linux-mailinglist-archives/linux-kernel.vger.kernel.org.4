Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0317122CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbjEZI5m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjEZI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:57:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD712A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:57:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-273-LeFxhf7FOqaUSuK7fsXyyQ-1; Fri, 26 May 2023 09:57:34 +0100
X-MC-Unique: LeFxhf7FOqaUSuK7fsXyyQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 26 May
 2023 09:57:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 26 May 2023 09:57:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Lobakin' <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        "Larysa Zaremba" <larysa.zaremba@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 05/12] iavf: always use a full order-0 page
Thread-Topic: [PATCH net-next v2 05/12] iavf: always use a full order-0 page
Thread-Index: AQHZjwj6Ca95rmUXrk6PtFqkdUejnq9sPxhQ
Date:   Fri, 26 May 2023 08:57:31 +0000
Message-ID: <9acb1863f53542b6bd247ad641b8c0fa@AcuMS.aculab.com>
References: <20230525125746.553874-1-aleksander.lobakin@intel.com>
 <20230525125746.553874-6-aleksander.lobakin@intel.com>
In-Reply-To: <20230525125746.553874-6-aleksander.lobakin@intel.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin
> Sent: 25 May 2023 13:58
> 
> The current scheme with trying to pick the smallest buffer possible for
> the current MTU in order to flip/split pages is not very optimal.
> For example, on default MTU of 1500 it gives only 192 bytes of headroom,
> while XDP may require up to 258. But this also involves unnecessary code
> complication, which sometimes is even hard to follow.
> As page split is no more, always allocate order-0 pages. This optimizes
> performance a bit and drops some bytes off the object code. Next, always
> pick the maximum buffer length available for this %PAGE_SIZE to set it
> up in the hardware. This means it now becomes a constant value, which
> also has its positive impact.
> On x64 this means (without XDP):
> 
> 4096 page
> 64 head, 320 tail
> 3712 HW buffer size
> 3686 max MTU w/o frags

I'd have thought it was important to pack multiple buffers for
MTU 1500 into a single page.
512 bytes split between head and tail room really ought to
be enough for most cases.

Is much tailroom ever used for received packets?
It is used to append data to packets being sent - but that isn't
really relevant here.

While the unused memory is moderate for 4k pages, it is horrid
for anything with large pages - think 64k and above.
IIRC large pages are common on big PPC and maybe some arm cpus.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B634566924E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbjAMJIG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Jan 2023 04:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbjAMJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:07:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981E74594
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:05:35 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-213-8NbXl33pMYu5sfuK1Wbrsw-1; Fri, 13 Jan 2023 09:04:52 +0000
X-MC-Unique: 8NbXl33pMYu5sfuK1Wbrsw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 13 Jan
 2023 09:04:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 13 Jan 2023 09:04:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mel Gorman' <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Thread-Topic: [PATCH 2/7] mm/page_alloc: Treat RT tasks similar to __GFP_HIGH
Thread-Index: AQHZJmoXf1CytyX+t0K5Vu0irpkuJa6cCxcQ
Date:   Fri, 13 Jan 2023 09:04:50 +0000
Message-ID: <4c169ca43a7b49f1bf61c01181ed585e@AcuMS.aculab.com>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-3-mgorman@techsingularity.net>
 <Y77VYdboKBUsILhD@dhcp22.suse.cz>
 <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
In-Reply-To: <20230112093623.sl4jpqf6f2ng43w2@techsingularity.net>
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

From: Mel Gorman
> Sent: 12 January 2023 09:36
...
> Hard realtime tasks should be locking down resources in advance. Even a
> soft-realtime task like audio or video live decoding which cannot jitter
> should be allocating both memory and any disk space required up-front
> before the recording starts instead of relying on reserves. At best,
> reserve access will only delay the problem by a very short interval.

Or, at least, ensuring the system isn't memory limited.

The biggest effect on RT task latency/jitter (on a normal kernel)
is hardware interrupt and softint code 'stealing' the cpu.
The main 'culprit' being ethernet receive.
 
Unfortunately if you are doing RTP audio (UDP data) you absolutely
need the ethernet receive to run. When the softint code decides
to drop back to a normal priority kernel worker thread packets
get lost.

(I've been running 10000 RTP streams - with 10k receive UDP sockets.)

So I doubt avoiding sleeps in kmalloc() is going to make a
significant difference.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


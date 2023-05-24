Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154CE70F00F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbjEXIA7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjEXIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:00:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3B91
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:00:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92-BouyzOU9OF2fo-YtRUPpEw-1; Wed, 24 May 2023 09:00:37 +0100
X-MC-Unique: BouyzOU9OF2fo-YtRUPpEw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 May
 2023 09:00:36 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 May 2023 09:00:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Preble, Adam C'" <adam.c.preble@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: How do I force an IBT trap in a demo kernel module?
Thread-Topic: How do I force an IBT trap in a demo kernel module?
Thread-Index: AdmNrJN/HBQNXQy0RfSVuasMlQAruQAaPVaQ
Date:   Wed, 24 May 2023 08:00:36 +0000
Message-ID: <82034ea784e44c5b929f519ceac6c4e0@AcuMS.aculab.com>
References: <PH7PR11MB65237A81D8258BB1E10969A9A9409@PH7PR11MB6523.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB65237A81D8258BB1E10969A9A9409@PH7PR11MB6523.namprd11.prod.outlook.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Preble, Adam C
> Sent: 23 May 2023 20:29
> 
> I am debugging why a kernel module of ours triggers the IBT (Indirect Branch Tracking) trap, and while
> doing that, I was trying to write a standalone demo that would forcefully trigger it on purpose. This
> has turned out to be much more difficult than I thought! What can I do to get a module to generate an
> indirect branch without an endbr64? Creating the indirect branch itself doesn't appear to be hard:
> 
> 1. Set up a function call
> 2. Assign it to a function pointer
> 3. Call the function pointer
> 4. ...maybe add a compiler flag so it doesn't optimize the call to a direct branch.
> 
> I am primarily building in a Debian environment with gcc (Debian 10.2.1-6) 10.2.1 20210110. By
> default, the branch does get optimized away. I had to set the -mforce-indirect-call flag. The endbr64
> instruction would still emit so I added a function attribute to suppress it:
...
> So what do I have to do to tell objtool to allow to me deliberately shoot myself in the foot here?

You could try adjusting the function pointer by the size of the endbr64 instrauction.

Oh, put the function pointer variable into static data.
That should stop it all being optimised away.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


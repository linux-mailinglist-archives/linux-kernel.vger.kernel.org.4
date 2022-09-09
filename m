Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A985B415F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiIIVWT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Sep 2022 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiIIVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:22:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1BEE98E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:22:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-75-4x4mabv-MMeVWZPOeCQ1kQ-1; Fri, 09 Sep 2022 22:22:13 +0100
X-MC-Unique: 4x4mabv-MMeVWZPOeCQ1kQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 9 Sep
 2022 22:22:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 9 Sep 2022 22:22:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Manikandan Jagatheesan' <mjagatheesan@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@suse.de" <bp@suse.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        "Kodeswaran Kumarasamy" <kkumarasamy@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: RE: Performance Regression in Linux Kernel 5.19
Thread-Topic: Performance Regression in Linux Kernel 5.19
Thread-Index: AQHYxD76FSnznGGLrEKJhYfY7fdHzK3Xmvxw
Date:   Fri, 9 Sep 2022 21:22:12 +0000
Message-ID: <3758868033fe49d5ba54e500e16df35f@AcuMS.aculab.com>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
In-Reply-To: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikandan Jagatheesan
> Sent: 09 September 2022 12:46
> 
> As part of VMware's performance regression testing for Linux
> Kernel upstream releases, we have evaluated the performance
> of Linux kernel 5.19 against the 5.18 release and we have
> noticed performance regressions in Linux VMs on ESXi as shown
> below.
> - Compute(up to -70%)
> - Networking(up to -30%)
> - Storage(up to -13%)
> 
> After performing the bisect between kernel 5.18 and 5.19, we
> identified the root cause to be the enablement of IBRS mitigation
> for spectre_v2 vulnerability by commit 6ad0ad2bf8a6 ("x86/bugs:
> Report Intel retbleed vulnerability").

As a matter of interest how much faster does it go if you
boot with all mitigations disabled and compile without
retpolines and without page table separation?

There are plenty of semi-embedded systems (even running on x86)
where there are a limited set of binaries, it is difficult to
add new binaries, and everything basically runs as root.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


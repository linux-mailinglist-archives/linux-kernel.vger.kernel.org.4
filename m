Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8568021F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjA2WF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjA2WF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:05:56 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2B13D4C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:05:53 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 276342C04C6;
        Mon, 30 Jan 2023 11:05:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1675029948;
        bh=2AZL63pfAWUKEF4IHdZOZ5Vad7bOLhjr1WKbUqAuAW8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=P0dXpHi/5znpUykxRil2Si/6qxBtFjTVxPBlsi2IxMyBtjB79Tms00WTKqcIOkCsf
         Rl91e2btnbEYOvYg8lCnK/huyA9vZQQlCAu7FvZ51Vz6jzfPLv9ITUvuhcylJnbxpM
         nq1R5sw98lBD+8Z5boiR2iD97BPuU7Lywcp4Wpy8tRGguJgt+iKkcpcOFF9gyBzGXB
         SccoFAV2s0aLEsQ5gPWOEHYnuNKlsBKRVxudWEZZHONRDJbrtZEtOiBPRKTg5dcXlK
         dfR9zpk1EQUBxQhFsUA8NsQgHzBMTz1C1nZ4WfbSRdxoFrQkijRQJhUmGDdy+w5EvH
         OosZQoOLbYHLQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63d6edbc0001>; Mon, 30 Jan 2023 11:05:48 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.45; Mon, 30 Jan 2023 11:05:47 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.045; Mon, 30 Jan 2023 11:05:47 +1300
From:   Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] USB: MAX3421: Handle USB NAK correctly
Thread-Topic: [PATCH] USB: MAX3421: Handle USB NAK correctly
Thread-Index: AQHZMfm2aO24Wzk0JEq5z3qToIgLia6w8bAAgAQsGwA=
Date:   Sun, 29 Jan 2023 22:05:46 +0000
Message-ID: <c42ca86c191f425297090e45a125e370323f87e6.camel@alliedtelesis.co.nz>
References: <20230127024734.8777-1-mark.tomlinson@alliedtelesis.co.nz>
         <Y9NtvKbY1nfoVtw9@kroah.com>
In-Reply-To: <Y9NtvKbY1nfoVtw9@kroah.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:23:249b:4bf3:3b6:8672]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <BF05EB9A99FFCC4E874CAD0A2F046EE6@atlnz.lc>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=a6lOCnaF c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=Q9fys5e9bTEA:10 a=RvmDmJFTN0MA:10 a=4GEGL-l4OV8QxAh4I78A:9 a=PUjeQqilurYA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-01-27 at 07:22 +0100, Greg KH wrote:
>=20
> What commit id does this fix?  And should it be backported to older
> kernel trees?
>=20
> thanks,
>=20
> greg k-h

The code in question has been unchanged since the original commit
2d53139f3. I'm sure that the behaviour is the same in all kernels since
this driver existed, but also wonder how many people would be affected by
it. I would be happy if this only went into the current tree.

 - Mark


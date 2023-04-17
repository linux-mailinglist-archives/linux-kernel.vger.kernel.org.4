Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE416E4B62
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDQOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDQOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:22:45 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2101.outbound.protection.outlook.com [40.92.58.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28451E45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5rIVsESXRUZ6+hBbC8nye7YrFqf1C4oj6ZylTrF5awtQquW8ByrPwLYaMJgAQXQOUb2Jdvl7MJr4pUI2jooFxrJ3DawNf/271CE8z78luWg3U0v4g4hGe8A2AKz6yVuHnM+nt0R1m22jSJoqPlA3BBkJYKOlQnpLEbODcup20Rlwj1nIrOKGAkhKJywh9+VbSrHjOJMDRvy3N3rGRBzUPYxnbuBlGxPJQFO7BJse2EANUfKuNvBev5Qx3QZ0J+dep5X8lYOGV88tEEG2kegpeVMJyg93rdBWEeGBwgM0OV+p7GxGs3Zh9yuyCCRF/gAwsf53SZbj8NoEKLTQzGSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcxTT6UF9js318S99sa+KWysi/C4jiZaemKNiEHU6Gc=;
 b=dbFgk5vZfj0M53L/wkhsq0PPad/edDu41XQjB5hPx9MZUP07GJ8qSixKCkYo/HsoyYaeYSRwXGGl0Au+PEWJvS08T8gl6fgJcLyVrPdSr8qcUuacfWtV2iOohY8tw5tME7HH8sgG4Tz/CCMQboQ2C5kklTr9zlmYGdsZoDqEDlEzB0f2K4hV58zwlF5ChdZfDb/rYyoXvcezOA09Bk7hY40qKFQSMJlMUOgT0IMiEd3LIk8QqAOwlcuisyHzgyrX5IESn4Tq8JnUNxsAnPUBNjA9IZBtcsruGOJkcjSB8Tkm2blDpEQINyD2iHX3OOX4nO4lGRAG1tH2bRvUx2B1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcxTT6UF9js318S99sa+KWysi/C4jiZaemKNiEHU6Gc=;
 b=jV84X0FtpTQgYNJX4J5C7T952WAiKVoUVXdYNFiv+ssZtKC8BmOdqciD+zjYRIz6Nick+RnX/du7mjdKzJUPxO8MEsftruvjCZ9h958hpvTQn6iO8pYs3otJfWxhAZLMUTlCXPrOySye3aH12htp0kmVkGkGkcABfwRHGkowQHxww+99k1oqhevY4dM7jQTPIjZtCGp1QKuzkF1B0oGCKbKMgtOPtCZx+sFX/5UsUbXgi34O4aMaHMKDQgYJqvatn4l1sc4s840wMP4++VR5m0FUnyPR0BjpVLH7qpByHPOIJps3NdnWHdwA2xOnn43BFnPV6bwoAAjNz7e/eHB4cw==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 PAVP189MB2410.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:30c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Mon, 17 Apr 2023 14:22:36 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::5849:317a:3d56:7846]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::5849:317a:3d56:7846%6]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 14:22:36 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
CC:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: linux-6.3-rc6/lib/maple_tree.c: Two style issues
Thread-Topic: linux-6.3-rc6/lib/maple_tree.c: Two style issues
Thread-Index: AQHZa3oGkjmGjA5gLkua9Txw7MMTQa8kNJAAgAAIsiQ=
Date:   Mon, 17 Apr 2023 14:22:36 +0000
Message-ID: <DB6P189MB0568A487A016FBA45DF108A89C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
References: <DB6P189MB0568CB290411B23A176511239C959@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
 <cd5b6ce1-3c2f-97f5-64c5-4c4c90c40627@bytedance.com>
In-Reply-To: <cd5b6ce1-3c2f-97f5-64c5-4c4c90c40627@bytedance.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [F6uosOT4urZ2bMpbyNb9rC6oLKTKk5XM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|PAVP189MB2410:EE_
x-ms-office365-filtering-correlation-id: 47e2f971-a146-4862-6135-08db3f4f3175
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/JCHBSEWQxa1wVvDIhwUbzK7Uw7p39Dl7GettxbEXTNfiCW8S772GInowPqA6+dSrTaFL36J6Q3H3KjQxN9BtOKR7ykttunm2Fpq0jcOiOdN06r2DM+0HU+rjKEqxWzGglb6NPW4W3spFrwwY35yBnCcmB87y6yEq5ZjxRJOrw5HHr9R0oa2IdxfOy6P+zCoXbfWRK7FHt6vRijmv/pIt9v3rffdpxckeaRsBUeTd0+gCP9wwBSTs3za4MSSh+jTqhe6tEN/1tU8sfztZvyi9QHhAlJcs1aqAzp4UIAJ5coB2heLvScoJcN9FZurTNb/C9UbD+HRyRT/vYqfRfIof2Jfv13F/I1dLDZcXq8SkY2jnU9Hj+I7tRB83J1TkdZolnrVDYlPcQZGappzMuwfxAIhXnQxLPoBRRGMX5d42uLGkNWpLOE4J6VovEtfcBN8rYNAQRocAfSxyVrprJsDqWvUXZkr5GhU5jf+3TP7LRqtJ8NY2C7sF4F6VB/rRN8gcjRnFAdWqZ8VoZO3i5Y1/5zyOZ2m8VR+ThMemwUllDdONqxHA1FO0RcUj2d2HCLhCDzahF4zNbU8KkqL0dPi1HiqhJQAhLi+uoQWrsn+xr4FCjjuH5i2YXaESuudYyg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uKNZibjFH0FyoK9qDWPJoTZ1W5M1qmwmE7JaBEZgPgzC1Bgy3VS78z8v0U?=
 =?iso-8859-1?Q?obcqWXsSPmmg8C7IgmutX2baWGSsHBID61bk7zPwQAkt3F28kewwZmIY3V?=
 =?iso-8859-1?Q?2m00l6ylWz9k42QecGsxiCc9MOo0z0/dr0L499bVUK+OtDqqpX2iVWKib4?=
 =?iso-8859-1?Q?5w46xm5svE/mrc3/vybXgMCWanXDnC0FvABJmL1ULwvwfHhmiuPZB077z/?=
 =?iso-8859-1?Q?BmCW9RTvwTpy964zMjq5jAnP6CBbOxDPfW6+DrA9F42gxQgdcePXxd+rNc?=
 =?iso-8859-1?Q?lhL6U5nygFhEUA/90r18xsD+Ssv5Fj/Fjd34+/nMd54v2/7TbgefkaPCcW?=
 =?iso-8859-1?Q?NwbJTdNSElzooXAbmCy4Em2zh2o3I5nzeqJ4znlwGC+W3Ua4TGXxLvnQQd?=
 =?iso-8859-1?Q?oXhAwB2PpBKNCHkNHPZYOXC7TihvsW9mMHQanxo1263SOy30SJ2oK+o0y2?=
 =?iso-8859-1?Q?ykI/p6jicbK5rab+IRwOc3dNh2AiMFGY1sOwyjDHdqYYFmlGg7mzybDFtt?=
 =?iso-8859-1?Q?sbbCazNUfvDH2LZr7TLrPLrkxJ4VTNXsYysmd9ECIn9m5vwZAOcn6ONDFw?=
 =?iso-8859-1?Q?HqhW7Xi6/ssa9hyJl+Xbfh7FC8nurXq9Yqtgyq+yPsL3ZsP+nZ0ZboM5wu?=
 =?iso-8859-1?Q?Wq0Uv8LR4irPOCyCsD6iycdDBxnTbH55LJDX4VS9WzCsOIITmOXVf7okze?=
 =?iso-8859-1?Q?Nyoe2c3qJ9XzhnP1zpN2e586fHB8JySbHJv01FZ4dhMnAbxfgwc2Urn7aB?=
 =?iso-8859-1?Q?kfyd+0RrBmrjAckIU5jT6irjdIUsqJPUmwVV+2EnoxAcGpFQEhFBCKzRJM?=
 =?iso-8859-1?Q?lpe6rFRGAHdSJewAEgVFVznpdlbP1NqDyDitHVsRk0meGyEXbAzCf/ckv4?=
 =?iso-8859-1?Q?d3ZEFhgcu36bv0OGA0MiQx8HdXQETDOWOk9Z+DRgbyUWjE3zMUrSyJ+fDJ?=
 =?iso-8859-1?Q?X1gQXxFiTbMpV6WTl8UsM9e90NYpB8k+n8VBVpnZ7kLAnNlCPgFkd53SyH?=
 =?iso-8859-1?Q?D/GEmdN8WMsB6zbGaEUugDNOgTZBqdRAiL0aZTEg7FsDVtSgvxbBBfv/3i?=
 =?iso-8859-1?Q?e9oVfbrFCrFuTwjmFmHNhzYtTAf60ON3pKQFmP1cT4II+IJSz8aD3Xm5tj?=
 =?iso-8859-1?Q?PWzY34fjxLsJX5G7r1XGHFV6xc9U/lmuI/PvapYKvLI6gQKXg8pL6rHOHl?=
 =?iso-8859-1?Q?0aUDplpqIgLz+SnQ6lAzqKf3Hm+nzE0JXc0aOWVSImEUpWmwkspJQYiz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e2f971-a146-4862-6135-08db3f4f3175
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 14:22:36.7353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP189MB2410
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,=0A=
=0A=
>It should be fine here. =0A=
=0A=
Perhaps I have been slightly less than clear. The discussion is about the *=
style*=0A=
of the code, *not* whether it works or not. My apologies for the lack of cl=
arity. =0A=
=0A=
Expression is=0A=
=0A=
    while (A &&=0A=
        B && C)=0A=
=0A=
The static analyser notices it is poor style to have B do a limit check, bu=
t have A use it.=0A=
Sure its working code, but suggest new code=0A=
=0A=
    while (B && A && C)=0A=
=0A=
It won't make much difference to the code, it will merely be better style.=
=0A=
=0A=
2.=0A=
=0A=
>> Source code is=0A=
>>=0A=
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0memset(pivs + tmp, 0,=0A=
>>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(unsigned long *) * (max=
_p - tmp));=0A=
=0A=
>It's not good here, I can fix it.=0A=
=0A=
sizeof( pivs[ 0]) is a better thing to say than sizeof( unsigned long). =0A=
There is reduced future maintenance burden, when the type of *pivs changes.=
=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

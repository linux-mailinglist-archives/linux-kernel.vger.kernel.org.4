Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA674248C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjF2K55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF2K5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:57:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089B210E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688036261;
  x=1719572261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yj4lhBa1ssuk2i/gaNL1aQTijHQfPwzvCBIBv4aaScc=;
  b=f1wJVOph85Ctg0u72O8ZmwUltrAHislzvN8sYsf1/36xiO1Hg7SAZlwK
   xfnhTLmxZzvoUJHmHG3OmDuvXJp5v6uT2E7T4lq1YVCEpMsKqNsbIQFZC
   xnIDYgXqlhkCirmk0/7ZsxdKIL/oM+Ya7+JKf/4sHvm6BAnYuACzFBljm
   MWcirNu+ZYZGWYalnejl8CbRS6T8BqiHgrb0QoeJH74Iea58EixJ1jVGb
   g64NGIHXp/J0kECEKYaE8YZ6gAwEfGqNVUF717InqcWSne7z6fzI1ys8v
   ZJvwApyUoJmQsSp7Y6z7cf/6NaCIcAwOeM+4DwniZxzn8EpNnU0lCcn8Q
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVDLUPKNatZf9YD508O6IZRIpOWStfqNMTkIoURVCGdzFQR8IL5SeBNqOTezFOQ2+zSd0RZSP7hhuZe688hLqCceu2ZJjgX6GzGnOA8i0ivoolsPAkHl2vhfOwoRLzjcmMEEl4twzxMPO6nNJyk3Avybi/Uz2da+agsT/jG+jOpe2MzZQWOirvDas1Y9VFJrpwUdzsStgon/ud05yu1Z1ETiKdZjJd9TuQWk2eGcBacZpebqR6J1XqoQ9Seg0uFvnBWR5jPdCbttufkzr24TZ9x9vRzypR/xJzPDV1I9We29K3uiVV0+2VHENfqv61sP5AuNQhEMJITjtonllQF/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj4lhBa1ssuk2i/gaNL1aQTijHQfPwzvCBIBv4aaScc=;
 b=ad8gHeyOcL/mAwGIIlUiqFIYQ6WeLuolInc6+5+3QF96PUQlem3WGMwODCsOekwN5Zohw83qgMmkxL18BsF4CTRL1JMPxScdZ/Gka7Y73TzugxQbDfADrW2nQhuHX8tlg29GDEpnvuGa/oTdDKINco4LwP0y+Nk3bJ4pSkAb075ZQuBJj+M0cXk/7Fumgmx5Nkly+Rdcw90XMFy+nrzykXR8Se3fXkU2iB2/DydNjsz+emwz5quegYgsXBl0AyxFVjmextuOZytXO1TOTqXy6g+BtfaW8bQdUNH4Civ+Q2behjhXMt/fRkZkGfD9ILOUlxVUYKK49duOHr+EStCHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj4lhBa1ssuk2i/gaNL1aQTijHQfPwzvCBIBv4aaScc=;
 b=fU3zLGBKdGCrgUdkdiu48KaLgFdZ0PHEaQy1TqGIIGcmpTZn2DTueFl7+BNYuJVrr53DQ7Bg2HCfUUNzQKLMv0CCn9i4k0YwuU9PFjyPhASNOjJsC8ObNjcuYhznfqBWVsVz7bsOYL2T+VItgQTV1VjyQODeT5lLPTXWe+zZrxQ=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "phillip@squashfs.org.uk" <phillip@squashfs.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH mm-nonmm-unstable v2 1/2] squashfs: fix page update race
Thread-Topic: [PATCH mm-nonmm-unstable v2 1/2] squashfs: fix page update race
Thread-Index: AQHZj9oHXRmSx1lCV0CPTsZ7ZuoAoK+h0VIA
Date:   Thu, 29 Jun 2023 10:57:37 +0000
Message-ID: <d7e032358b10a1f472f452e5170aa5cc8cbb9a81.camel@axis.com>
References: <20230526-squashfs-cache-fixup-v2-0-6fb7723c3647@axis.com>
         <20230526-squashfs-cache-fixup-v2-1-6fb7723c3647@axis.com>
In-Reply-To: <20230526-squashfs-cache-fixup-v2-1-6fb7723c3647@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AS2PR02MB9344:EE_
x-ms-office365-filtering-correlation-id: 21543183-b8c3-4679-3656-08db788fa6a3
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D96AWT0y4rCYgIyLAO6vA+NzSMUb915GuytpL5BiX5ZPAgm59aM8khuOFrI2zAWRpPkfbK0xyguQZVPj8Mj2j8kTTPP2tdYbIErkuVCjLK+HVrjto0vpaUdsuiWW5Nx6r5hp5cp+Eo2y50/ij9qug0yfyiDw3iLf9XdCtpF+MJ3h4M94VthKGJSwoR0cNcnpoNPysi0v/YYjeklevmMpK0+mWPWpZg6L3znkvY5QTirdrmZe3LEBh7pVRy4ojzShFHEaFkDrUPe2fbK/J0kMrcFMXuPq5Bpcxjbq9G4XAK2y44IV8dE3WOaDi3sqLSydZLlMnbtgRi2j+aWewccsJZibpnICPGd+2U3sKvN9TCoLl9euRhSX1pyDjqtrg4+TQJ8qMy1jB9HVPnHry+pIuqhp9gdK/u5UOz3kM719zLUFbfWRzSkbYka1UE0FiX5CRCTz5qyygvvY5uEq5txpyNSABfqCMEF0ssZ5qkvUXLKWDzUhPnhtvfSUMTOjZRBsnSkHX8MO9h4yLHU1aGVUEuaFjvtgYDYjAe5pDqgX4cGiKEdvBkwV7lNUIsfHlEwYtzEEMEmZVB4bhzQhEKKeYeN1suJVivniNWorpvmr3gt7eoyJEXFOdusAY1SKXr94
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(6512007)(2906002)(186003)(6486002)(71200400001)(122000001)(107886003)(83380400001)(38100700002)(2616005)(6506007)(26005)(86362001)(4744005)(110136005)(41300700001)(54906003)(38070700005)(478600001)(316002)(36756003)(76116006)(66556008)(66446008)(4326008)(66946007)(91956017)(64756008)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDdqNGZzT2ZWdDU4eHNVcTFnMGc5a3oyb2N0OFJYSDM0WTBVcnh6REdTeVN2?=
 =?utf-8?B?UEhOQ01vUlNnRlNoVmV2bmhOQmJuY3BSYXoyQytpNWhEOGM3RHlpd3ZrNnJP?=
 =?utf-8?B?MUpLRUE5enFjRzhZUVlpajZCQjRPeGhVU29XeEUzdlEzVjFVZWJlQjlLRElt?=
 =?utf-8?B?UmRac0swTWxqcFdvbFl3ditKTzYzTU54ZVB4b2djK3BLWnFpcEErQUdtckds?=
 =?utf-8?B?bXFOK1JrRytYWlVGSHlRWDF5eGRXZzBUY2Jld3NtS1duQmtjQWtieEcrQkRl?=
 =?utf-8?B?YldsOUd6ZWp1a1lPVDlnaU44K21OQmU1ZEt3NnZxMWVQY3NlWXcxczJzYVcr?=
 =?utf-8?B?MHA0bTB3TW0rWlBLY2VxdDNRQXJ2djlSN2RKNUFYSTgyV1VsTVQ0UTdpd25a?=
 =?utf-8?B?a2xYL2l5VHo0clg2a2RQZlJUejhhd1A4bUhmZTAyVzJKOUlhbXZlQWp0enc2?=
 =?utf-8?B?OGs5SzFnekVHWmgxUHZYemdjYjFyZmtKTDBoY1lEUDZMVjhlVVR1TkhoUlBC?=
 =?utf-8?B?RnlvV0dhVU9EZzUrRDErbVFSWGxDS0duci9ISVNjTHkxYXlaZmRFVUhJbGQ2?=
 =?utf-8?B?MHdFL2tZaDRRSHgvaWZZNlB0T0VSY0ZNUWNBemN3YWZMWDdLMnE5TEZWb1Vz?=
 =?utf-8?B?Lzh6dkNOK0grNFVsSXhOeHE3N0xUSE5uY3U5MC82YW9BTDZFaVpzejFTeERl?=
 =?utf-8?B?VW9rNTcwRkJ3NjV5Vms1aFRIeUx5cmpvOVQ4SGx5NUFvVGoyR1J5cVZPUVh3?=
 =?utf-8?B?c2Q5bFR6NXduQjljaW1JR1FoQXI2aGZKcWp6V1U2NWFhQTNrUnhKQTlLNy9N?=
 =?utf-8?B?cmNESStnS2MxRFpZWTd6RVBvK0NtQVVOQk9wR3gyU2NQa1MvZEpGbVh6c3Z6?=
 =?utf-8?B?Y2dhdllhd2hDcWtIVHk1b3lWQXozSGNzRzJqbEwyUUpVZnhqeGN0MVZBekts?=
 =?utf-8?B?dnB4WGMzbHZERURXaVhjU0EySWRGVkNtSjNSYXdFQ05hMWZFOXU5d0MzeS9k?=
 =?utf-8?B?Q01na09wN05KZFFDYjRKMmFWV3l1bmNuQmljRnhRZnB1NmdrUjJKRTFOa0Fv?=
 =?utf-8?B?c3lqWEYvQ3FBMXlaaUY0WldkUDN4U0xWbkUrSWhUalpxSVREQ2VwUDdMc2Vp?=
 =?utf-8?B?T1krU2NaUHhYL2JMeThZTmwwRFVXYmJydDJOT2FndGhZR1dwdlBsQ2ZCaWJ2?=
 =?utf-8?B?SUNxZmxLQm1mN3lqTjJuYllhVjVqTHdBUWNiWUwrSmJwUC9tUW4wZG5tTWM3?=
 =?utf-8?B?MS82ZkR5OGRuSmNiMGgrQklwNG0rM1kyNmY0S1RpeDNzeFVLelFIQ01GdVl2?=
 =?utf-8?B?T3VEcU00akh0dm82WHdXVzhtTk9HbTFOaXo5UE1kVWlzM3gxTkphRGxHOWF3?=
 =?utf-8?B?YWtoVi8xTW96Z1BKalVJaFlQUDkxcDJwZ04yNXZGK1FPYWwzdEt6RHdoVjJU?=
 =?utf-8?B?SzBYNUJ6L29jNE44MkVwWHR3V3Z5bUdpTnZoZDF6SXU4d1o1UW14dWQvdGg5?=
 =?utf-8?B?eloxSkFTTVM4cjhwWStBWjA0VjhQRTY2S01ISGx2eVVJV0tTZ1FiRktvT2s1?=
 =?utf-8?B?bEhxbk05RU4wS3l4dDRuNzNRZFJ1bjNSQWdxa2RiL3lldzV5cUErWDI0TCtu?=
 =?utf-8?B?ajhXdDhtL1hsR3ZXc1VFZU5vV01kVHRvL2gzODFJN3h0R3pVeit6Q1dxRXBo?=
 =?utf-8?B?MlFodXRKZXVSbFlST200ZENuSXBiWUxBbi9OampJTjZnbTVIbW9BVnBRdnpI?=
 =?utf-8?B?ZWtJRktrMDRWeWY3N1RzUEF1QjY5cTdQcS9WUWYrTmcvay8zWFZnK2ZqcmRD?=
 =?utf-8?B?aytxSlo1ZTdGeTEyRGVXYjBOZlArOWJlSld2ZS9rTjRnTVVDeENSNy9MSThS?=
 =?utf-8?B?ampuRFpaY3JaWlc2V09nN2VzdGJMaDF2SHd4VExQZ3Bpd3dQQ04va2x1OUdN?=
 =?utf-8?B?NFpRWUVUcjcxVDArZlVNOVJKdHdsME5xS0RHU09sdVFuTmtsbWU3SkJlV2V6?=
 =?utf-8?B?d0k2d2p5MFh3MTAwNHdHeitUYndMS3BJQ2FBeFh2NnEwK2wrR0ZuZkFLamdj?=
 =?utf-8?B?aXFHR1dvTnViN01YOTk1T0FQNzY0cjlNWHJRYTk3d1VtM3dvbklxVkFYNVRo?=
 =?utf-8?Q?ZmjmQlK6aOpQviqD8g9FQKgPI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5729584C7ACD4E44872748E201E47406@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21543183-b8c3-4679-3656-08db788fa6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 10:57:37.4154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bn43JLg+9vjqct4Fyqmjg4wM6cRNsf8SvZneoSQ333umO7qYB500kdHEOFaKeuM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9344
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDE1OjU3ICswMjAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6DQo+IFdlIG9ubHkgcHV0IHRoZSBwYWdlIGludG8gdGhlIGNhY2hlIGFmdGVyIHdlJ3ZlIHJl
YWQgaXQsIHNvIHRoZQ0KPiBQYWdlVXB0b2RhdGUoKSBjaGVjayBzaG91bGQgbm90IGJlIG5lY2Vz
c2FyeS4gIEluIGZhY3QsIGl0J3MgYWN0aXZlbHkNCj4gaGFybWZ1bCBzaW5jZSB0aGUgY2hlY2sg
Y291bGQgZmFpbCAoc2luY2Ugd2UgdXNlZCBmaW5kX2dldF9wYWdlKCkgYW5kDQo+IG5vdCBmaW5k
X2xvY2tfcGFnZSgpKSBhbmQgd2UgY291bGQgZW5kIHVwIHN1Ym1pdHRpbmcgYSBwYWdlIGZvciBJ
L08NCj4gYWZ0ZXIgaXQgaGFzIGJlZW4gcmVhZCBhbmQgd2hpbGUgaXQncyBhY3RpdmVseSBiZWlu
ZyB1c2VkLCB3aGljaCBjb3VsZA0KPiBsZWFkIHRvIGNvcnJ1cHRpb24gZGVwZW5kaW5nIG9uIHdo
YXQgdGhlIGJsb2NrIGRyaXZlciBkb2VzIHdpdGggaXQuDQoNCkl0IHR1cm5zIG91dCB0aGF0IHJl
bW92aW5nIHRoZSBQYWdlVXB0b2RhdGUoKSBjaGVjayBlbnRpcmVseSB3YXNuJ3QNCmNvcnJlY3Qu
DQoNCldoaWxlIGl0J3MgdHJ1ZSB0aGF0IHRoZSBzcXVhc2hmcyBjb2RlIG9ubHkgcHV0cyB0aGUg
cGFnZSBpbnRvIHRoZSBjYWNoZQ0KYWZ0ZXIgaXQncyBiZWVuIHJlYWQgYXMgSSB3cm90ZSBhYm92
ZSwgbWlncmF0aW9uIG9uIHRoZSBvdGhlciBoYW5kDQpyZXBsYWNlcyB0aGUgcGFnZSBpbiB0aGUg
bWFwcGluZyBfYmVmb3JlXyBjb3B5aW5nIHRoZSBjb250ZW50cyBvdmVyLCBzbw0KYSBQYWdlVXB0
b2RhdGUoKSBjaGVjayBpcyBzdGlsbCBuZWVkZWQuDQoNClRoZSBvcmlnaW5hbCBwcm9ibGVtIGNh
biBiZSBmaXhlZCBieSBtb3ZpbmcgdGhlIFBhZ2VVcHRvZGF0ZSgpIGNoZWNrIHRvDQpzcXVhc2hm
c19iaW9fcmVhZCgpIGFuZCBpZ25vcmluZyB0aGUgY2FjaGVkIHBhZ2UgZW50aXJlbHkgaWYgaXQn
cyBub3QgdXANCnRvIGRhdGUuDQoNCkknbGwgcG9zdCBhIGZpeCBzaG9ydGx5Lg0K

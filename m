Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978E66990A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjBPKBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:01:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56614DBCA;
        Thu, 16 Feb 2023 02:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676541704; x=1708077704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xbgd7nRupZuxEClc70MTNc+6/KdtUgrsjJ94eh7q1Q8=;
  b=uQFC8pv8Q9zTzzUYt+2ERXNkE6X9AlC9jgt2CP23Da/nXsQLo6KoogZK
   Y8ofONDsSEIbLVZM/g/8/XbvjFktsxEIJfzOq9trQMr+R1uP3DQDF2pEe
   29luT+0WG1kmmdkZys4jEliLAH5uS/TNa//H/VY3DS0rlWSkhNR5aV82W
   W6ZivfSUSqLECjXqshIhes/dZSLDqOJnH7+/OSpxYNGMT3CI+VPowJ2VQ
   jZJBGd8Z2aez2sUdt8Hg9oQlrZwy/p2GiZqCteeg7Umk9QT9stu7FY9Pa
   St4efmf2wLeuULVWZbNC1Wb5mFq9UC/3/tQtwmvwWFTFbJv0G3cE85fGl
   w==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="scan'208";a="200955050"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:01:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:01:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 03:01:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esm1qKir7nZ3+yDFujpxY1y4NpePltFI+jaPDzm92FPqkRUMX6cSjqS5Z94OQ6t6u5jwec7qqut7EYTtZ/9qjQmacqtnNFAlIfq2/REedqb8J7wNGF2Az6j5cfjkmA1pQP13TTW/Irt/ZhX/HJA1dqZDwa7nAF+Kqi7AeDkongMb3bWuk66eGEStPNzmkW86fnfBUllO1bIp0nIws2uZ/lzLhsJNWH4ZU8jgAyf9EXZ0shw7QSpN9mde4FecDgnLqz4PzHPKEbBIWl3kBcPdc6ZhB9CWe8VAe76eutYXbzyUVqKor9GIo5RzfF/N1p0VMGVsmPUko/kmYbFSRjdIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbgd7nRupZuxEClc70MTNc+6/KdtUgrsjJ94eh7q1Q8=;
 b=ll2xz1V3Hu3ADFPqRTpbJBcavxMdPz/FTkqABHHuf/3YqsnPFkYjbX9f6D9ImcRX5HF8J4MNX2vdBwX6bkZP7952taEniurRHhuPleyTZHG4X/pPrcwMFro4lQFocKCo+TPSyDlyJokAxtxXPVobsy+E1webTJzEiduk3yi/G8CFKJEydvh2bE16Od1D8xDN3EPol7QDantrSkV0e2J0+Z5VWEnMjxr2pcRiVUC5nlGROX0Ry2NeHEZFWQ3RhO43Wq3FkxidlwRk9AtbCdJLL/lXnIbXi75abwYLJgu02jGnZuelYdm9Jf3dbxQ7VVZudZWVIgd+GSDruHAjlOWgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbgd7nRupZuxEClc70MTNc+6/KdtUgrsjJ94eh7q1Q8=;
 b=BiBTpUTn7M6aW011CKdScpwws/EYgIQRWkXxA7hzBXW/J7qfkk6pOkvnVlXW9Tgcud42HX2LgBK8ABC1dof7rYa+0nJZcLZrJ3FsckUhixrXAOgPtf0YUxmnx/NYqg0+rnTQ2fvyRTPyd2M5WbisqLcQ+IzWjbta3f4ypqgpkfQ=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5349.namprd11.prod.outlook.com (2603:10b6:208:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.27; Thu, 16 Feb
 2023 10:01:41 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.027; Thu, 16 Feb 2023
 10:01:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <ye.xingchen@zte.com.cn>, <sre@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gcG93ZXI6IHJlc2V0OiBhdDkxLXNhbWE1ZDJfc2hkd2M6?=
 =?utf-8?B?IFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2Uo?=
 =?utf-8?Q?)?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBwb3dlcjogcmVzZXQ6IGF0OTEtc2FtYTVkMl9zaGR3YzogVXNl?=
 =?utf-8?B?wqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Thread-Index: AQHZQe2q1zd1e8b5xE6CaKr0Be2j3A==
Date:   Thu, 16 Feb 2023 10:01:41 +0000
Message-ID: <7ba1360a-74f4-46dc-ad1e-f81c833840ac@microchip.com>
References: <202302151450594333186@zte.com.cn>
In-Reply-To: <202302151450594333186@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BL1PR11MB5349:EE_
x-ms-office365-filtering-correlation-id: 90c585f9-37ec-413c-cb03-08db1004cd7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jESnad1sIyBxuqti/ckJe1f2h+DnIt2LLguqIHHjVLpz7KSz4pRCqQKv/rKOWoWbVR5TxTH72pYbuDOzge3xM/AMgqLUeDUrT9yG7HMzZdothPvoMrOsUWgrK9JaaH3pgpUHEMTFMMG6jyhAvMTnmNvh4SQACrvMhI2jFuC2jjV86auRSERWn4EgW7MkPXRSutY6VfaM08IunHRsnKs+FRLQlNgNplbaKXs9phwvyaV9nYvY1PEpULTtZrwCTa6kTZl+zndvLe1qpYyD4WkWSARiDG9nn9TC7ZrndZ9G7JGJjcytERCVFfjbHu/dPv/SU2Ea5CYlTJRlGdKtyO9RAKT4BR2jCJpQbY64Jmbn8JbtuVAfLWO5gQOntjSt9RUrEpeGONLdOvph1931A0U5fe7DZYdQKg2bIqmf9tEElvYgytj0BHsLYMSbZNln5soQ721PMihOS7KpqIz7rAVbrMiJ2HThLkl6/jHbfhTVR+wvdY5vtzRmJPVkVdChnd4bTAKk0JzSgvNpVk2OZ/5agg+/aFPrjo7DDRGy72b1udPCdkorh1niLuU+1xl2m+OpVozdcmPgUmrDHW6QHwAsdB+Wx+2VnECDIsWZRtvP6m0T8hohNcPnPDEPJdeF6kwq709N6RH8wn7++SCRppnwuJRDnYNG+dBlIdn/RkbS1gJ00rSB/DIf3jKqOfo/84hmFguNOmk+Pac6atj9YXb/xHhfQI1VIoJzR/PkvMbvCK2iTxXWzPywZwJG7FUyfHnrZBI5h3rwO4aR/R0Tg0gGvCvGqD3jliQK4JqoHDP2FD375kx6IbJXbpZGwHcmJ4ZY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199018)(4326008)(66476007)(91956017)(76116006)(66446008)(54906003)(8936002)(110136005)(316002)(2906002)(478600001)(6486002)(41300700001)(66946007)(66556008)(31686004)(53546011)(26005)(186003)(6512007)(2616005)(6506007)(83380400001)(38100700002)(122000001)(31696002)(86362001)(5660300002)(71200400001)(36756003)(38070700005)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0hER0ppa005WjlMYWFxZm8yRklnQnVnMjZGWnIvUjZ3VFozVGVaU2R1VGd3?=
 =?utf-8?B?Vyt2NnVMWW1HQTRzVTZZU0JQK2k2ODBKcU5SR3RuTW53MjhkLzRiUWl1dkla?=
 =?utf-8?B?bGxIblVBZC9jR0F3b1d1RDVHTkJhbjJZdk95V2JkcTgxN2RLL1RkWUtXRkdp?=
 =?utf-8?B?RXpjVEFwNStIclRNemU3TUtUZThzVzhzWmRVcmlNUWVtUGdtODlsb1krU1Vn?=
 =?utf-8?B?YUtaSDBrRGJDQXV6aE5kK3hmVFRvZUFvQ3k5T2hSb0Jpekk0eXZMTUxKdXBx?=
 =?utf-8?B?TWx2bEZNakFtaldLL0EzbEdhM00wMkI4SVV5dk1OZEVaamoxRmNMcXE2VDhC?=
 =?utf-8?B?OVR0bGVNZHVjMEFFVU5PQVV2djFZcmhkWXg0U0t6eWVCL2tqYnNMeDVybnZm?=
 =?utf-8?B?S2xkclZCNmE2WmZmMmIyb2FDOHdXMEovODM3cFRjY09KdFBFVUFkOHVibUJj?=
 =?utf-8?B?Yk43OUNodlhQLzZldG5qNG5HdmZTVXdsUHZqZVA5WFpFWlFDTzlMRkh4WVRK?=
 =?utf-8?B?TW5kRDVlUlZkQ2xUQ29ucUlLbkNYV1ZvajdqNkIzNTI0SHNjNnFIclYzMWJt?=
 =?utf-8?B?YjdBK0NrWmhQZUlick9EZmdTSkg2RWlFVmhVb3cvMklHcWpObVR4b3pYWUNx?=
 =?utf-8?B?enkrcVhtcnRqb05GTzU2aTA1ZlY5K1A4M24yUmZoV0QvTWs0QVVWRTZISXN1?=
 =?utf-8?B?VEhZUk5GVDUydERxcU13YlZEcHhZdWxrZHZFbHJFREJpKzVHZGYyOG9MdFc4?=
 =?utf-8?B?Z3hSYlNGbFBpek9sWkgxSkoyczcwcDJOSVVSSkREbU1IK3dQeStLemRrTDZE?=
 =?utf-8?B?R1JaOWgyUnJDcDJUM2VWc3pBUGg4TTVRWnNTV0NFV1pjVnFkdUJteS8rTmhF?=
 =?utf-8?B?cGlFU1VjYkRNeFhwQ2U2UG9jVC9hUzB0VDBIcCs4RjFyaGdwVlJyVVE4RkZU?=
 =?utf-8?B?WUd0a1Q3aGpRN0NQdy95Snh1YTFVVFoyTHo2V0VRYkdVVFlTRFRYZWo2ODVI?=
 =?utf-8?B?M3oveFBpa0dWNWhkQVJHaXkzRWZCRFlNMlhVNFZoYUxJcnhHbmhWa2hhWHgv?=
 =?utf-8?B?N2UxZEVzUTdzVjFUSmRRM0V6LzRHM1JKVTRNTGZiVFYxdkhYZ2RaTUw5dm5m?=
 =?utf-8?B?aGxuV2hyRnhFd2M3a214Y0tzRzVwVUJwbzRmaUk2bG9lRGJ6N0M3aVZ3L1Zh?=
 =?utf-8?B?UURvclFpcXdndVpKMmdObVc2M1hEYldnRHM4bHRrYXJFQ2ZWM2JHMHJPV2kx?=
 =?utf-8?B?dzFoQnZEM0t0SXJpRlo4anFyTWNETk9zMVNoNUZBaHFXamZGT1JpL01jYi8r?=
 =?utf-8?B?SGgvUG5BajFQKzVPVnRKR2l2MVlwd1FmQ1dnR212VGNKWThtakJpZlhYV3Vx?=
 =?utf-8?B?M2hoSDkyTEFnRFlSNDkyVDRYOS9ENWdUUm1acDlicll1ME9nRkVrczk3U1Ev?=
 =?utf-8?B?TnF0ajY1emJ4Q3JiRXBERFlaamZCdjFpQ0tVa1E5M3BIei8xclFsckFaQnBK?=
 =?utf-8?B?aXh0Qjh5aEU3S1JZTnRHNDRmbVlrYTkwS1M3NktRT21DRkpxWVIzQVljQWEv?=
 =?utf-8?B?YWo3aklMcVBGVE9vbHNTWk1WdjRsbUdxODNTelE0Q2lJby9abXZRc0oyUk9t?=
 =?utf-8?B?cDFqV1lFTDBMY3AyNHJZNEN0RGR4eS81YlVtemN2amJ2V21mbGRNR0paWm5O?=
 =?utf-8?B?bUpHb0ZaZGJkbU02LzJDVmZCZ1BmYzFmNzR1RS9yZGpGZFF6RnhkelRuVTMz?=
 =?utf-8?B?ZFBRdnJScFQ3d2JFdnRaQUZCNkI5azRSTk52c2xnN2ZmQ0k4TGlSc1dsNGhH?=
 =?utf-8?B?OGorMm1ZVHBoYUJoN1lad1lsVkMydi90UUlqVkxlZVpjc0pCZjd0SXdDRTc0?=
 =?utf-8?B?TlRkaVV6WlFvOVZweFB6ZXhZTVJhV0FuUDFoczVUa3RoUGdJOFU4N0R0UVRJ?=
 =?utf-8?B?Ky9BWnRmQS94czNBSUhncXhGUWtBUzNwbmFVV1F1aUhZeUVYSFBKM29pWDNs?=
 =?utf-8?B?M1U2cDgxWUVnU2M3MnNOWHhXNG8wMU5Sd1dhbjNtNXh3N3N2MS9QUDVZNFFS?=
 =?utf-8?B?dkZVUG84K1hBOWVhNnlrVzJicFlXa3FteEdzRXA2c3JTTWFhdTJWU1EwRURE?=
 =?utf-8?B?Znh0OGR1SVd0bUVnU3JoZzJNOHhRcTRlSURXRnN4TXZtTVF1aFpEMUp5RTFZ?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B2254E0586A7743AFDAE85D63305DE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c585f9-37ec-413c-cb03-08db1004cd7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 10:01:41.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXgYoADrBPfDDFAwAe+15mqzFkc0/4XcvXxPJ5KZhQQqSYB7S1RnJhFmHsCrg4G8K5Kw+kxk64dg2TImk5Tsf/L3jIwt2KBVuBHYS6gjczA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5349
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDIuMjAyMyAwODo1MCwgeWUueGluZ2NoZW5AenRlLmNvbS5jbiB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBZZSBYaW5nY2hlbiA8
eWUueGluZ2NoZW5AenRlLmNvbS5jbj4NCj4gDQo+IENvbnZlcnQgcGxhdGZvcm1fZ2V0X3Jlc291
cmNlKCksIGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIHRvIGEgc2luZ2xlDQo+IGNhbGwgdG8gZGV2
bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKSwgYXMgdGhpcyBpcyBleGFjdGx5
DQo+IHdoYXQgdGhpcyBmdW5jdGlvbiBkb2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWUgWGlu
Z2NoZW4gPHllLnhpbmdjaGVuQHp0ZS5jb20uY24+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9wb3dlci9yZXNldC9hdDkxLXNhbWE1ZDJfc2hkd2MuYyB8IDQgKy0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMgYi9kcml2ZXJzL3Bvd2Vy
L3Jlc2V0L2F0OTEtc2FtYTVkMl9zaGR3Yy5jDQo+IGluZGV4IGQ4ZWNmZmU3MmYxNi4uMzE0MmFj
NTM3ODJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3Jlc2V0L2F0OTEtc2FtYTVkMl9z
aGR3Yy5jDQo+ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvYXQ5MS1zYW1hNWQyX3NoZHdjLmMN
Cj4gQEAgLTMzMSw3ICszMzEsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBh
dDkxX3BtY19pZHNbXSA9IHsNCj4gDQo+ICBzdGF0aWMgaW50IF9faW5pdCBhdDkxX3NoZHdjX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+IC0gICAgICAgc3RydWN0
IHJlc291cmNlICpyZXM7DQo+ICAgICAgICAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0
Y2g7DQo+ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4gICAgICAgICB1MzIgZGRy
X3R5cGU7DQo+IEBAIC0zNDksOCArMzQ4LDcgQEAgc3RhdGljIGludCBfX2luaXQgYXQ5MV9zaGR3
Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCj4gICAgICAgICBwbGF0
Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBhdDkxX3NoZHdjKTsNCj4gDQo+IC0gICAgICAgcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gLSAgICAg
ICBhdDkxX3NoZHdjLT5zaGR3Y19iYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5k
ZXYsIHJlcyk7DQo+ICsgICAgICAgYXQ5MV9zaGR3Yy0+c2hkd2NfYmFzZSA9IGRldm1fcGxhdGZv
cm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsIE5VTEwpOw0KPiAgICAgICAgIGlm
IChJU19FUlIoYXQ5MV9zaGR3Yy0+c2hkd2NfYmFzZSkpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gUFRSX0VSUihhdDkxX3NoZHdjLT5zaGR3Y19iYXNlKTsNCj4gDQo+IC0tDQo+IDIuMjUuMQ0K
DQo=

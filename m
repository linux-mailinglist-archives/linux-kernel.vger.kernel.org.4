Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538576639FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjAJHaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjAJHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:30:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1BB5FB5;
        Mon,  9 Jan 2023 23:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673335673; x=1704871673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5B8jYqcbhMFIGS6JZgbcSr8NqW8rdGj+B7aOzIoig7M=;
  b=abMmcpclnwRVSlCABCMHmnasjQKtVGN8zsENE7+zKQ3SBVG7t2e6Z/JA
   hwwTHf14CfzJTCs8OrNMqm/7wwYqMuejxvMmfFkduU14IgSNg1mPzSZdY
   wJHClRCs9FFdjFL0NdiZSKjbqZ6PZL1WdVfkxsqA0K88N1O+lPKCMr9Lr
   RmN05945SC4fnrm0mWfX7WH+OSKJeLofhhmlJCLA39wpiOxVJaO9FMejC
   f/dcC7/RfO67dGGOzD0leAcsaMocnHmCX23PO2NjaqGB2A6WftPlkjCZg
   97Lt0GYJCC6dDIElmk6oIhI6hCzbVSyUIB1dHcDowoy/sqXUpRrk7smwV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306596266"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="306596266"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 23:27:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="764631457"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="764631457"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2023 23:27:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 23:27:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 23:27:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 23:27:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 23:27:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwcwiklF17TC434KXkOvfHdff1UOVjRZhjZE3VX8rR7m6667JnHc2ul9G+pUlDkgLHmx4o7sGiUvXg5NVF2E25vtTq39fFVyJF0unDru8OuJ0gzS+fiZDRwdFQ2V/Qj8ceHpl/pNefxz0We4+yuhWkPJfFB4ACg9Di+vFsmNJcSpCPm+9FvKiU2RUqwXsidIPytC3DmKtd9uuQrOt9oGLT9lk74M3U6kTNs4q4bJPL5ijV5O82EpzJ6HhT9k+14JpBRPebx65Fhf65FdpBU4xzkpLerOUx1o/RH9Xg+oYCGoyahdUFvS10BSi/jV28qYrm3WaJGZq5ge7rz/xLhalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B8jYqcbhMFIGS6JZgbcSr8NqW8rdGj+B7aOzIoig7M=;
 b=CqT43DYAb2nXi0GcNLTnoDJWDFiQZr/xwFQaZvWWo9pVEYRZ+PgHtUjB+FBPeiyny4Wjfg/O47ZjSRBg+mxS5GWjQfX/+RGFfpVigIk6m8eCcio/LP6wj0Ywgy3+0n1S+frFjdWuocXfIRVPULhLV7VlHBvfZhbamc1hoMc9CcVwUAexfsqsha/rRBzYh1hQiv0qF2idGSim5b1UuTGpXwGJ9vlzYsDAiIpeqQAHshSaPxfpMafT9cBQMegD1lALBjX1LFwU/VuyCO49J2VeQfSOrmefrpxoHGAtUCKOmaMPWOB5OVGUKS45KHc+03W4Y9b3Gest6SMelzGQuDsrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 07:27:44 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4e05:a2f4:1f34:d790]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4e05:a2f4:1f34:d790%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 07:27:44 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Deepak R Varma <drv@mailo.com>, Jiri Slaby <jirislaby@kernel.org>
CC:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "ishkamiel@gmail.com" <ishkamiel@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dwindsor@gmail.com" <dwindsor@gmail.com>
Subject: RE: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Thread-Topic: [PATCH v4 1/2] tty: serial: dz: convert atomic_* to refcount_*
 APIs for map_guard
Thread-Index: AQHZH1HXybQvvXtL7U+v00xHH6NxAK6XOFQAgAAOa6A=
Date:   Tue, 10 Jan 2023 07:27:44 +0000
Message-ID: <DM8PR11MB575088A17680C124D6B9EB73E7FF9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <cover.1671898144.git.drv@mailo.com>
 <d85c7441b96ce387d9010142efc3469d53b6aedc.1671898144.git.drv@mailo.com>
 <e42d5d19-7ed5-468b-98cc-13d0187dc555@kernel.org>
 <Y70DbEvxDDGXDv4i@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y70DbEvxDDGXDv4i@ubun2204.myguest.virtualbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CO1PR11MB4867:EE_
x-ms-office365-filtering-correlation-id: f6d62744-fa69-4e72-8850-08daf2dc2a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GqoVw1PI+giY4BWj0y6fk6pBnEZkYS6/V5DDolQ8n8OkJZBCpOWIWOeVfXCExzM/BXcdIppaYwZkKrHyAAuLy5vYHFEWaIb9DubWlKcsEx4uvtpu/gjvm7zg/Zs2F+w+RBcQYZX05HanJ5HOXQEFqtPJ8zeoLEh5z/LHy29KvARTMBLhY76ZlnYV/7kx1XzFn6x3Wgq9K4+R5bi6kAqiAvvt4Z9ILQbYXyc9G0Tm8r6zb33kzcfLnQSZLQv+KTDOzMfL7yApRrm+Gqdi9gAcCfTnDL9xkeYwzt38GEcLxEw0krmAp/ZFg4RSwRdy2WTNLSshoqIlTBRqxpWKhjR+FG8A97pqDkkLcFBBXN86IKzStqcIWSgK8QJejjPg4ofDaOEjMjol/KWls9XOCHYk/8z0P6jSEYXBzw2uiXj4spamgrwLNRuHfjlB6dxlp0X8cGpXDk5Wy6cGwrIVrXBxXcmKV2rVUhPABzvnpDtGZnsdXPotDxt+zaEdQI7y25fcyGuOO36mRlxtwwkKh8UoSTrPL/0cofP94ybHOffcGCeOHof+tnN87gNJ1p1iAZkUzJ8wnSRU+adc5gm+x1ahmZ1HHplcT9a6c+5UqK/Qodc4iA3gVgo7AMLE4gWFhHH0wmdweZgFM1/y6Bi3r2YOmKz/jLqBr7+y6nyb8Rv3GQL25tsPYsDAGnUC3lL62f0L290O45YKn8yorWbPDbahQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(186003)(26005)(8936002)(122000001)(52536014)(6506007)(55016003)(54906003)(9686003)(7696005)(66946007)(5660300002)(33656002)(66476007)(64756008)(66446008)(7416002)(66556008)(4326008)(316002)(38070700005)(86362001)(71200400001)(38100700002)(76116006)(82960400001)(478600001)(110136005)(41300700001)(8676002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTFCbGlvbHY5NzNLL1d1SFh5N0FHZDd1Mng4REFMRDFNZXV2OVp2MHp5eHNt?=
 =?utf-8?B?dzVzNFpDdldiZ1BVa00xYkNIbTZnbTF1TWc1bFRPRGh5ai9qdENZdisrZHBX?=
 =?utf-8?B?M2ZkNVorNkJRL0tJMnNMaFV3VGlJTkhLVk95VllNODZUdXI4N0lWM0xScHN3?=
 =?utf-8?B?azZXczJzZzF5dDhwV1F1NjVEUWZ2QW4rZm4yNUMrNWxWdjVrV2RUWFBLVThz?=
 =?utf-8?B?OHNnZzRBdGxtK2tPWXRnblRUWHV4VUQ3YXBnbDl2TTRBZ3dSNFFiSGU0TGc3?=
 =?utf-8?B?aVM0Ni9kOFp1OE1jWWUyWngrTUpwWTJSMi9zNlIrR29QRjlIWmZHQmY4eWpQ?=
 =?utf-8?B?ZGNzT1pXRVh6RVFQaW1jSEY5c1R0QncyZHJ0MGo5aGRBUS9JbHhVaXUrRFJF?=
 =?utf-8?B?YTQxcXZDZ0o0RXdCbmdiYmZ0ZnJpa2VXMHlnZXZIdDBWeHdlTEJjdzZKUWxX?=
 =?utf-8?B?aWF6R3ZqVnN6bldOczJSSWxJZFlReEdRcVNDaG5FbWJBNkVuZFN0S2pudGFq?=
 =?utf-8?B?dlY5ZHdkRm53THBuYlE4Mms1SmRRRGVmdzNqelpGWHhxNzRWMmJzWXcraUsw?=
 =?utf-8?B?eGw2N3RwYnAvQk5zM1FXSnFVWTJKckFLSzBXTmZ0VHFOMTJHSUR4R1o5ZThz?=
 =?utf-8?B?YkVyUDRlQmV6TTYzaXNUamVnUzlzdkZFNk85ODRhRVljRms5V0Z1eTRJbGlh?=
 =?utf-8?B?aWZYQVY0V0pRbzlwazI3dml1SzJPT2EzZ2hrbWFuekxCT3hMTzc0Z0hmZi9C?=
 =?utf-8?B?ZFV5UEVOUEw5Ym0vdGdyUTkreEUzb3pCeUh6NXVNa1N1Ry90aHdZdDYxV3c1?=
 =?utf-8?B?bXY2VURXMjdkbjBtcUYybzNVbGoxc2lJVGlDT3BvNDNxTGtVVUFnb2lGZHJY?=
 =?utf-8?B?c2lwNXRIYXZWTUZsS0ZpZ21sZ3BFeUlCM3BTakJMYldpdzRlYjV3TXJ1OU9Z?=
 =?utf-8?B?Q0Y3K3FrV3U0SFVGZi9acWE3c1VCVlBBUnNuUDJVOGh6YmwxK3llbnRlS2dq?=
 =?utf-8?B?b29zOHhYcjYvb0J3V0RHemdHWEN6WVJtTnEwUUFKU2Mwa0JRZm5YczV5TSsv?=
 =?utf-8?B?Ty9NME15b1J1bUJMQjVyRm81M05GTXdsR3c3ZENCajJpbmNoVERncWJkaGcz?=
 =?utf-8?B?QVNYbUNOUHl5V2UzN2RxbHUyWlFtTE9TUFJuZUJhL3AzZHBxdGNid0p6NkQ2?=
 =?utf-8?B?R2J4eHdsb3FwcFIvZklSNzRwQlRtRUMrTkFMcER0VHExYlV2ZEpDMG1SeVQr?=
 =?utf-8?B?d285cXEvUERYU2Y2TlJ6aXZvZW9NUDBPN015UTBaV1RJU0VCa3ZQZ0NhdDhy?=
 =?utf-8?B?R2dvbGF0K2RWVllyOWJVQitnekQ0R3J5U3JsR0FDNmxWdnpGM1NFWkc0R3Rp?=
 =?utf-8?B?MFZjKzZ5K3VzNnNBZkRkRElab01rN2QrcU83SWVZWU9GNjZEcWRrWVF4VVYw?=
 =?utf-8?B?cS9xV2dyWDA3Kzk5VW1jYjZMZU9uMFU5OHVHMDUzN2Ntd3R5SDhHZG81TFVU?=
 =?utf-8?B?NU5UOExYVFRWNXJ3U29rTkVzclNRVTI5K3hrQ1ZjdGNuaEFQUmZSdUdNVG5z?=
 =?utf-8?B?YngxTThyaUxkOHVuL0RwVGM3RTUwVjRTUzFiY2ZvNTh5VlFLOUgvTkY4Ykhj?=
 =?utf-8?B?REJ5dmxDa3BHTEgzT3hubjB6aVlWMmJqbmY2b2NGcnV5SmZvTlBNZWFvSFFy?=
 =?utf-8?B?RWMxNXphUWwxbjJhNVpYOERCMEZMbDA2aFUzeW4zbXFzVkhoV3ZTQlpnM0FM?=
 =?utf-8?B?MUJ6VERka3B4eHR6aW1ZK3N1YWRHTWJCRUkydFdGMjBGY2pscnJGaExTWXBk?=
 =?utf-8?B?Nzk4eGtGSHU2WHRtZiswZzdlOXBQclhQQkJvVXAycDVFcjZrOGFoVXdjZUgx?=
 =?utf-8?B?ZWRsRWdCRms1K2tDUVBlc1lLNW1VZUliV1Q1cUFMSVhwRzdBaW5lZzh3UWQ5?=
 =?utf-8?B?SDBRSWJ2Rk03Q3ZzY1dDRzdJV1dlc1gzSFJ1YnpBazgzOExtMUdFK1NMdzJU?=
 =?utf-8?B?aXdnRFNkSVFGY2Q2TlVGVUxoM1ZnYXFwcEVtL3JRQjN6Zy9wZWVkZmhPQkUv?=
 =?utf-8?B?cUkzVmtzU1laRHk4eWFUQnN6R0wyQ3pVK1pCU1ZlRzlZdHIxVk5xMFdvaWtF?=
 =?utf-8?B?NW9jU25zcGNOYkViWnd1OHVlV25JNDJqM1dKOHRhUENyRG5tbXFpbCt4TnZy?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d62744-fa69-4e72-8850-08daf2dc2a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 07:27:44.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfohsWPo2iGs2K4X4ydAVxZZterb2S/Ih0Z3E5Cg3SmTVt2PNYso3bwqWfNJMW7GqDn9uggy7oJ3hKufKSB0Fjs6v2ij3esAeoxre6OE0E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiBUdWUsIEphbiAwMywgMjAyMyBhdCAwOTo1OTo1MkFNICswMTAwLCBKaXJpIFNsYWJ5
IHdyb3RlOg0KPiA+IE9uIDI2LiAxMi4gMjIsIDc6MjEsIERlZXBhayBSIFZhcm1hIHdyb3RlOg0K
PiA+ID4gVGhlIHJlZmNvdW50XyogQVBJcyBhcmUgZGVzaWduZWQgdG8gYWRkcmVzcyBrbm93biBp
c3N1ZXMgd2l0aCB0aGUNCj4gPiA+IGF0b21pY190IEFQSXMgZm9yIHJlZmVyZW5jZSBjb3VudGlu
Zy4gVGhleSBwcm92aWRlIGZvbGxvd2luZyBkaXN0aW5jdA0KPiA+ID4gYWR2YW50YWdlcw0KPiA+
ID4gICAgIC0gcHJvdGVjdCB0aGUgcmVmZXJlbmNlIGNvdW50ZXJzIGZyb20gb3ZlcmZsb3cvdW5k
ZXJmbG93DQo+ID4gPiAgICAgLSBhdm9pZCB1c2UtYWZ0ZXItZnJlZSBlcnJvcnMNCj4gPiA+ICAg
ICAtIHByb3ZpZGUgaW1wcm92ZWQgbWVtb3J5IG9yZGVyaW5nIGd1YXJhbnRlZSBzY2hlbWVzDQo+
ID4gPiAgICAgLSBuZWF0ZXIgYW5kIHNhZmVyLg0KPiA+DQo+ID4gUmVhbGx5PyAoc2VlIGJlbG93
KQ0KPiA+DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZHouYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2R6LmMNCj4gPiAuLi4NCj4gPiA+IEBAIC02ODcsMjMgKzY4Niwx
OSBAQCBzdGF0aWMgaW50IGR6X21hcF9wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnVwb3J0KQ0KPiA+
ID4gICBzdGF0aWMgaW50IGR6X3JlcXVlc3RfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICp1cG9ydCkN
Cj4gPiA+ICAgew0KPiA+ID4gICAJc3RydWN0IGR6X211eCAqbXV4ID0gdG9fZHBvcnQodXBvcnQp
LT5tdXg7DQo+ID4gPiAtCWludCBtYXBfZ3VhcmQ7DQo+ID4gPiAgIAlpbnQgcmV0Ow0KPiA+ID4N
Cj4gPiA+IC0JbWFwX2d1YXJkID0gYXRvbWljX2FkZF9yZXR1cm4oMSwgJm11eC0+bWFwX2d1YXJk
KTsNCj4gPiA+IC0JaWYgKG1hcF9ndWFyZCA9PSAxKSB7DQo+ID4gPiAtCQlpZiAoIXJlcXVlc3Rf
bWVtX3JlZ2lvbih1cG9ydC0+bWFwYmFzZSwgZGVjX2tuX3Nsb3Rfc2l6ZSwNCj4gPiA+IC0JCQkJ
CSJkeiIpKSB7DQo+ID4gPiAtCQkJYXRvbWljX2FkZCgtMSwgJm11eC0+bWFwX2d1YXJkKTsNCj4g
PiA+IC0JCQlwcmludGsoS0VSTl9FUlINCj4gPiA+IC0JCQkgICAgICAgImR6OiBVbmFibGUgdG8g
cmVzZXJ2ZSBNTUlPIHJlc291cmNlXG4iKTsNCj4gPiA+ICsJcmVmY291bnRfaW5jKCZtdXgtPm1h
cF9ndWFyZCk7DQo+ID4gPiArCWlmIChyZWZjb3VudF9yZWFkKCZtdXgtPm1hcF9ndWFyZCkgPT0g
MSkgew0KPiA+DQo+ID4gVGhpcyBpcyBub3cgcmFjeSwgcmlnaHQ/DQo+IA0KPiBIZWxsbyBKaXJp
LA0KPiBJIGZvdW5kIHRoaXMgWzFdIGNvbW1pdCB3aGljaCBpbnRyb2R1Y2VkIHNpbWlsYXIgdHJh
bnNmb3JtYXRpb24gaW4gYQ0KPiBuZWlnaGJvdXJpbmcgZHJpdmVyLiBDYW4geW91IHBsZWFzZSBj
b21tZW50IGhvdyBpcyB0aGlzIGRpZmZlcmVudCBmcm9tIHRoZQ0KPiBjdXJyZW50IHBhdGNoIHBy
b3Bvc2FsPw0KPiANCj4gWzFdIGNvbW1pdCBJRDogMjJhMzM2NTFhNTZmICgiY29udmVydCBzYmRf
ZHVhcnQubWFwX2d1YXJkIGZyb20gYXRvbWljX3QgdG8NCj4gcmVmY291bnRfdCIpDQo+IA0KPiBP
biBhIHNpZGUgbm90ZSwgSSBoYXZlIG5vdCBiZWVuIGFibGUgdG8gZmluZCBhbiBleGFjdCAxOjEg
bWFwIHRvIHRoZQ0KPiBhdG9taWNfYWRkX3Jlc3VsdCBBUEkuIEkgYW0gd29uZGVyaW5nIHNob3Vs
ZCB3ZSBoYXZlIG9uZT8NCg0KSW4gcGFzdCB3ZSBoYXZlIGRlY2lkZWQgbm90IHRvIHByb3ZpZGUg
dGhpcyBBUEkgZm9yIHJlZmNvdW50X3QNCmJlY2F1c2UgZm9yIHRydWx5IGNvcnJlY3RseSBiZWhh
dmluZyByZWZlcmVuY2UgY291bnRlcnMgaXQgc2hvdWxkIG5vdCBiZSBuZWVkZWQNCih2cyBhdG9t
aWNzIHRoYXQgY292ZXIgYSBicm9hZGVyIHJhbmdlIG9mIHVzZSBjYXNlcykuIA0KQ2FuIHlvdSB1
c2UgIXJlZmNvdW50X2luY19ub3RfemVybyBpbiB0aGUgYWJvdmUgY2FzZT8NCg0KQmVzdCBSZWdh
cmRzLA0KRWxlbmEuDQo=

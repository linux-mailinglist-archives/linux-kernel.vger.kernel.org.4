Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3269A584
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBQGKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBQGKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:10:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E546559710;
        Thu, 16 Feb 2023 22:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676614231; x=1708150231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=puv77NlfITFbFiWOqdeWzWkPcf10IlQkieK2fbt1ZcA=;
  b=NXQU5C8gBhjIYFDKu8DT6nlnEGGg0BqVLamrBNh+XTQK9wlxFQpJfI3y
   yuIkHz3tYBia0wcHc94s7nyXx5sSvep4OSQSX8u1a6+EWHEG8foioYiNM
   SzfFdByZgs1z/t3SP+eqcNhV+0P8wB/A+mMtrjMQKBPGsPFagzvVZ3u+n
   GDz1PB2Z3boesEl3LrpgP1O003AWx1JPdImjLRHM52U1rK9EmsyvLwtNC
   KqmAAPlPJ53wwV9EWyyu+lny2Uv7Jaa/XruPd9KQgTdWg2a+5DTBiScWy
   Oot2RcP5GKT4hYJHDH5im3alDe9LN5XjnOYTGPtwCUntp0Xsv4hWFvkIX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359366227"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="359366227"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 22:10:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647968894"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="647968894"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 22:10:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 22:10:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 22:10:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 22:10:30 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 22:10:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aewnVZG3PTmBOWDDbIQZIoHWcXHavCaVno3sJncttejirFaVQB0fU6Zkwj5h45csrjAlLBAtdOf8xEcaZtgW446vxpdUeHwmvs8pv9JwiAXDdPGg8Zy6RCy+57tSYM5RnsrenAiuE0aFkkjy8GpiVx9EepeyV/9HSXE8QmkntjgRmQ8cLqRTMbsWHO+JddIRx8jBXopjpgJaP1HUTZL96w4hTIT2B8HW2TwFWQCpwEGKwjCdurdkpIW1ZmxeD0nO38A6r47b343vTo4Z19CeV90g+jD5PwVTVl4EADyI9bpfUbYjD6srJVEPmN2uyUZg9SWk3YwBG4hndDGovZ5mhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puv77NlfITFbFiWOqdeWzWkPcf10IlQkieK2fbt1ZcA=;
 b=K4KibAgq05AsfDj536tHrbPPtyhpgKstkN3i8hA6/oe1Qn6isI9Pk/P1hDyfXH7fUsapoidCAnrEkQRExJHpd1CO6fo8xJWxkgu5McflzFH2q63+OFY1jcc470AHG8C9mh2MAV9KkpjI7BOewJHEYyXCQe6vHn+MUGGApuB/kkQ8NZ4a0T0V0QZTmaJlt0TIpMiyUzLv65Ff96VEANYMxs/lnInO2+wjOnUwHUEbgRcym5N2bWxnnrxrv/Y9H27E+HtKmafib/uC+eYN1fhzNngRz82LI8EF4186Zms+7zWVMnZMFPWkckAFQ7Dz8h8Uws9C0Ad0nrM0q6Vzvjfj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 06:10:22 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 06:10:22 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Topic: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Index: AQHZP1Hum/btr+ww/kiynrKipZgIc67OndeAgAEcQoCAAAvHAIAC4+Mg
Date:   Fri, 17 Feb 2023 06:10:22 +0000
Message-ID: <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
In-Reply-To: <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|CY5PR11MB6163:EE_
x-ms-office365-filtering-correlation-id: f772a74a-dc9e-4eb7-52f0-08db10ada702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4F6yDJU+E28olxBb1bVF3TCIdc5NdDh7H6fuzWuLuwqTtsd0vfNDcARLRiyR5KMNGTEKenM9MJlhOzj9GHHo0JPf80ArXb3G2haSzMVBVP6Chszjj8cy0X1mn0FwiqA58q7tSkmB/CsUZRBBzutQSXOYYHIOUEviB/CYQa/lN1Gp4Vx74cx/r7Qs+Wdc6PbucpYovAAd0pBbBJxbrgZmm2W3J9dATdkaLjvbubNH2htu81o+0HCekzUdh1mN5aKxvRs7YYlGvemrIyVd3eIS93LGJIThjX4mKRXrDfWjYBvuK2Ssp6uoLAvBmR3Bxo7HI8dv0mQ+gA+XQ3n+U/pcWP9Les8Etl+eV7NuTxLp/paxkdyB0kYqXQDbqnE2cMKwFRMXuVrC+qNj2lzkQDSQUGeELFvOsNnsqMY5qIZCKRVER5Xrnii5OXA8vwrOjzGPArPpt1d22XNY3/HKNf3Yfqf3XVFylCtzOYkHuW088A4BaoWJ3yIr0DfASoeJwtgTj/CNu9f8P9+LpCW9Kwwh6iohDG6xpsFGMosKdn1OiAphkx1iUffMiarT2tQK0CFc+HxhBCxpHxv5TiK1f5XtfK5ZPc5ORVQcG0Z32d4pCh1SMxWdufsO2SR58C4IFDRUEM3PwhbD4axF49kq5EKCMe4NP54ZhBORd+7cwZ2xy9dnVMvsZ2z+chfA/7pS1F3WswiQ3e76n9RRGBBv929qmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(52536014)(5660300002)(33656002)(66476007)(8936002)(54906003)(2906002)(110136005)(316002)(64756008)(41300700001)(71200400001)(55016003)(66446008)(66556008)(8676002)(4326008)(76116006)(66946007)(7696005)(478600001)(82960400001)(122000001)(38100700002)(66574015)(83380400001)(9686003)(186003)(38070700005)(53546011)(6506007)(86362001)(26005)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXN5WnM0VTg4ZkRxZ0JRNzY5a3FRVjhsNlNBVXlpTHdYNmFZdmhFcWZWTHBL?=
 =?utf-8?B?aGRsRnhhYjh4UHpxaU81TzIva05XekkwcWkyVENlWkhXOTE2enk4dkt3R1Uv?=
 =?utf-8?B?RDRHT00wSGhTdUlCM0VUdXc3N01Qd2s3T1IrRzkwKzJBanhHNENNWGloam94?=
 =?utf-8?B?YzNZN2hDWENINmphNVc0THZZUEFUUkRYZDBCWmR4YjlJR2FDUno3QnBlZHpL?=
 =?utf-8?B?NjZpcFNsRDVWSnJQVG16Zlg0WDhJU05veWZzUlUzNzVCKzJmUTJCL2JPRDJF?=
 =?utf-8?B?ZTZvVDVRQWovcEwwMTN0WFNjc1VERzFpQVRYbHFhSCtmWnVKdXNwYUZBYlhp?=
 =?utf-8?B?c0R0M2hIbm1QRGFwamJoRVh0ME1yWnJOUUNKV0ZLQjFJRXJTRmhoM0doeUNq?=
 =?utf-8?B?TWtHWEpOZWdYdGNObHoyVkpkYjkvTEd5MklOdmVSSjlkK1RQQkQ1NlVuS29G?=
 =?utf-8?B?ZW53NnlSYmFIVm9BaFo3cWtrMU56TkJvaDFUUnE3c3VsYkhFWWdUVDBKaFVr?=
 =?utf-8?B?YW93TlpwRjlFWVMwTnZlNEdEVVZmeEFGN1J6ZmVzZFI5emNyS0tmT2Qvdy9P?=
 =?utf-8?B?dS9jZllpd21jQmZ4MGt3NE90RzJsamZPSndlNEdsaVFYYVRtejVrU0JiYkFu?=
 =?utf-8?B?NlBWTEJmeGdVLytIUmErNmhRN2lFWTY2d0FZdGJVdk1CdHM1aFJaaHJiay9H?=
 =?utf-8?B?eHo2R2kzbUl3TGR6a2xYYVFkRzRzMGJjcVVtRUo4cThRQ3lFNmlFUmFXSDNp?=
 =?utf-8?B?azZSY3htWjFnYzZTNmEzZkt1YkFVUVd5aEZQYml4alhzZ0kvTEJuYTdzZUEz?=
 =?utf-8?B?S3E1YW5aV2tCb3RZOEdQYmVZTHlWakNkSXlma0U5UHlNU1NhVFdwdWtwa1My?=
 =?utf-8?B?QkpBb2RNRGpqK0d4MTd4Z3Bwcm5sQUl5blNiZ3VmUmN1R2dVeWE0d20rM3dK?=
 =?utf-8?B?dVduU0tMSVVVMlB6K1h2Q2o4VldrUmpOcy9DWVFqYkVYSDVoZDFGejIxcFlV?=
 =?utf-8?B?OXo2OXVWYnU4TUtVU043MmxJWEZ1MWx1V1NWb1pJSVQySnp1OHRnWXkxQkxG?=
 =?utf-8?B?M3IydWticGJCbzUvTDlDaFZWVnFiMDZRemZMN043SG9tZURKU2VoUzk2YlJq?=
 =?utf-8?B?OXYwN1ROWkVNbHpZNUVwd0ZTLzkrL244RUsvZXVjQlRDa1JQVndWelRRQUkw?=
 =?utf-8?B?NkUvdXF0N1pNd3M0WnpXQlY3ZHdHS29rS3MzckIxTlJMbm81cWNEZ1IzMk52?=
 =?utf-8?B?UjhMYnJpT01PNnBYa1gxVlJ6NkRZSXBiQjFHRGxIL292bk8zVnlhMkxhUWYw?=
 =?utf-8?B?Zzh1RzI1d3UwWDByNFR5bkxJYWx2UGVuOXRBcEpyK1Q0VVQ3MGRGejRPQXlj?=
 =?utf-8?B?TWNUOHRoeXgzbGNUTTRzOWdMSUpOMXA3cXlwWU0xbnh1N3lQQzd6OTZURnRJ?=
 =?utf-8?B?RVRsMjEvSnpMaGNuWk9JdjBjY1Ezemh4Ymo1aXZTQnpQZkNmOHNaOG1ONFdX?=
 =?utf-8?B?V3QrdUJDQUFtZ1JVUXF1aUNzVis2TSt1NlJacUx0L2pQVFkvTHNHdGV6c2pG?=
 =?utf-8?B?NWluWW44K0RPUjVqTGNyb2FNRFJZd0VWbGs1T0NuY056UlB4cW81NEJ4OWRL?=
 =?utf-8?B?cm9pRGJnQStRRXl1ZE9sZXlMOTQzT05xeFFZVFh4QnFQMTFwdmtlMVBSTE5M?=
 =?utf-8?B?bWszWjNHTFc5SGRWM0hUQzJNamhuZkZDUDAvSWlIbTgxOTRhckxaTTdkQnpG?=
 =?utf-8?B?UnFuR3pIVS9ra1p2Q3FxR2hjeFJPOFdoOXc5U2ptakZSYU82M2xDaGlFVU1u?=
 =?utf-8?B?SzRMNFQwdmhlTDE4Y0tNL1krbDNJNE9pdDRpdzhqQ01LSVdPeUp5c29SNlRJ?=
 =?utf-8?B?ODQ0eGFmUGg3NG1iN0xDZ05GNkhKV1ZsWloxUzV5L29XaEQwdVFtMzdvZW9K?=
 =?utf-8?B?dXg4Nit6QzJ2d2VGbjJHSUo1dEtudEQyYmRLK2xySG5UU1lqTWw1YXZyZmRk?=
 =?utf-8?B?NDRlSkxGNWM3MnRMN08yR1lrQWdyOXFpWmtNcmVTdVFUOWRtT3hZaGFkQUx1?=
 =?utf-8?B?QStWUHEydXNaaWd0UU9SekJXWE9nMm5GQ2YvSzFRYzg5cnoyZ3hSM3J4ZFdX?=
 =?utf-8?Q?hk7pGNkUTNoLBfrHbWqtObxFZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f772a74a-dc9e-4eb7-52f0-08db10ada702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 06:10:22.0234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARRGikbY0YRo5anS//YjwxOpfRw+l5ZnxwvuJqutny+rwcWBWsGHkq1jLqVTLUz7Fh8Df8QXTS0k7goCDNOGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDE1LCAyMDIzIDU6NDYgUE0N
Cj4gDQo+IE9uIFdlZCwgRmViIDE1LCAyMDIzIGF0IDEwOjAzOjI5QU0gKzAxMDAsIEhhbnMgZGUg
R29lZGUgd3JvdGU6DQo+ID4gSGkgU2FrYXJpLA0KPiA+DQo+ID4gT24gMi8xNC8yMyAxNzowNiwg
U2FrYXJpIEFpbHVzIHdyb3RlOg0KPiA+ID4gSGkgV2VudG9uZywNCj4gPiA+DQo+ID4gPiBUaGFu
a3MgZm9yIHRoZSBwYXRjaHNldC4NCj4gPiA+DQo+ID4gPiBPbiBNb24sIEZlYiAxMywgMjAyMyBh
dCAxMDoyMzo0N0FNICswODAwLCBXZW50b25nIFd1IHdyb3RlOg0KPiA+ID4+IElWU0MgZGlyZWN0
bHkgY29ubmVjdHMgdG8gY2FtZXJhIHNlbnNvciBvbiBzb3VyY2Ugc2lkZSwgYW5kIG9uDQo+ID4g
Pj4gb3V0cHV0IHNpZGUgaXQgbm90IG9ubHkgY29ubmVjdHMgSVNIIHZpYSBJMkMsIGJ1dCBhbHNv
IGV4cG9zZXMgTUlQSQ0KPiA+ID4+IENTSS0yIGludGVyZmFjZSB0byBvdXRwdXQgY2FtZXJhIHNl
bnNvciBkYXRhLiBJVlNDIGNhbiB1c2UgdGhlDQo+ID4gPj4gY2FtZXJhIHNlbnNvciBkYXRhIHRv
IGRvIEFJIGFsZ29yaXRobSwgYW5kIHNlbmQgdGhlIHJlc3VsdHMgdG8gSVNILg0KPiA+ID4+IE9u
IHRoZSBvdGhlciBlbmQsIElWU0MgY2FuIHNoYXJlIGNhbWVyYSBzZW5zb3IgdG8gaG9zdCBieSBy
b3V0aW5nDQo+ID4gPj4gdGhlIHJhdyBjYW1lcmEgc2Vuc29yIGRhdGEgdG8gdGhlIGV4cG9zZWQg
TUlQSSBDU0ktMiBpbnRlcmZhY2UuIEJ1dA0KPiA+ID4+IHRoZXkgY2FuIG5vdCB3b3JrIGF0IHRo
ZSBzYW1lIHRpbWUsIHNvIHNvZnR3YXJlIEFQSXMgYXJlIGRlZmluZWQgdG8NCj4gPiA+PiBzeW5j
IHRoZSBvd25lcnNoaXAuDQo+ID4gPj4NCj4gPiA+PiBUaGlzIGNvbW1pdCBkZWZpbmVzIHRoZSBp
bnRlcmZhY2VzIGJldHdlZW4gSVZTQyBhbmQgY2FtZXJhIHNlbnNvcg0KPiA+ID4+IGRyaXZlciBp
biBpbmNsdWRlL2xpbnV4L2l2c2MuaC4gVGhlIGNhbWVyYSBkcml2ZXIgY29udHJvbHMNCj4gPiA+
PiBvd25lcnNoaXAgb2YgdGhlIENTSS0yIGxpbmsgYW5kIHNlbnNvciB3aXRoIHRoZSBhY3F1aXJl
L3JlbGVhc2UNCj4gPiA+PiBBUElzLiBXaGVuIGFjcXVpcmluZyBjYW1lcmEsIGxhbmUgbnVtYmVy
IGFuZCBsaW5rIGZyZXEgYXJlIGFsc28NCj4gPiA+PiByZXF1aXJlZCBieSBJVlNDIGZyYW1lIHJv
dXRlci4NCj4gPiA+DQo+ID4gPiBUaGUgbW9yZSBJIGxlYXJuIGFib3V0IHRoaXMgc3lzdGVtLCB0
aGUgbW9yZSBJJ20gaW5jbGluZWQgdG8gdGhpbmsNCj4gPiA+IHRoaXMgZnVuY3Rpb25hbGl0eSBz
aG91bGQgYmUgZXhwb3NlZCBhcyBhIFY0TDIgc3ViLWRldmljZS4gSVZTQw0KPiA+ID4gZG9lc24n
dCByZWFsbHkgZG8gYW55dGhpbmcgdG8gdGhlIGRhdGEgKGFzIGxvbmcgYXMgaXQgZGlyZWN0cyBp
dA0KPiA+ID4gdG93YXJkcyB0aGUgQ1NJLTIgcmVjZWl2ZXIgaW4gdGhlIFNvQyksIGJ1dCBpdCBp
cyBkZWZpbml0ZWx5IHBhcnQgb2YgdGhlIGltYWdlDQo+IHBpcGVsaW5lLg0KPiA+DQo+ID4gWWVz
IEkgaGFwcGVuZWQgdG8gZGlzY3VzcyB0aGlzIGV4YWN0IHNhbWUgdGhpbmcgd2l0aCBMYXVyZW50
IGF0IEZPU0RFTQ0KPiA+IGFuZCB3ZSBhbHNvIGNhbWUgdG8gdGhlIGNvbmNsdXNpb24gdGhhdCB0
aGUgSVZTQyBjaGlwIHNob3VsZCBiZQ0KPiA+IG1vZGVsZWQgYXMgYSBWNEwyIHN1Yi1kZXZpY2Uu
DQo+IA0KPiBBZ3JlZWQuDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayByZXZpZXcgYW5kIGNvbmNs
dXNpb24sIEknbSBmcmVzaCB0byBtZWRpYSBzdWItc3lzdGVtLCBpcyB0aGVyZSBhbnkgY29udmVu
dGlvbiB0aGF0IEkgc2hvdWxkIGZvbGxvdyB0byB1cHN0cmVhbSB0aGlzIGtpbmQgb2YgdjRsMiBz
dWItZGV2aWNlIGRyaXZlciBzbyB0aGF0IG5vdCB0b28gbXVjaCBiYWNrIGFuZCBmb3J0aD8NCg0K
PiANCj4gPiA+IEkgc3VwcG9zZSB0aGUgaW50ZW5kZWQgdXNlIGNhc2VzIGFzc3VtZSBhIHNpbmds
ZSBpbnN0YW5jZSBvZiBJVlNDDQo+ID4gPiAoYXMgd2VsbCBhcyBNRUkpIGJ1dCB0aGVyZSBjYW4s
IGFuZCBvZnRlbiBhcmUsIGJlIG11bHRpcGxlIGNhbWVyYQ0KPiA+ID4gc2Vuc29ycyBpbiB0aGUg
c3lzdGVtLiBUaGUgZGVjaXNpb24gd2hldGhlciB0byByZXF1ZXN0IHBhc3MtdGhyb3VnaA0KPiA+
ID4gZnJvbSBJVkNTIGNhbid0IGJlIGRvbmUgaW4gdGhlIGNhbWVyYSBzZW5zb3IgZHJpdmVyLCBh
bmQgc2hvdWxkIG5vdA0KPiA+ID4gYmUgdmlzaWJsZSB0byB0aGUgY2FtZXJhIHNlbnNvciBkcml2
ZXIuIEV4cG9zaW5nIElWU0MgYXMgYSBWNEwyDQo+ID4gPiBzdWItZGV2aWNlIG1ha2VzIHRoaXMg
dHJpdmlhbCB0byBhZGRyZXNzLCBhcyB0aGUgSVZTQyBkcml2ZXIncyBWNEwyDQo+ID4gPiBzdWIt
ZGV2aWNlIHZpZGVvIHNfc3RyZWFtKCkgb3BlcmF0aW9uIGdldHMgY2FsbGVkIGJlZm9yZSBzdHJl
YW1pbmcgaXMgc3RhcnRlZC4NCj4gPiA+DQo+ID4gPiBUaGUgaW5mb3JtYXRpb24gd2hldGhlciBJ
VlNDIGlzIGZvdW5kIGJldHdlZW4gdGhlIGNhbWVyYSBzZW5zb3IgYW5kDQo+ID4gPiB0aGUgaG9z
dCdzIENTSS0yIHJlY2VpdmVyIChJUFUgaW4gdGhpcyBjYXNlKSBzaG91bGQgY29tZSBmcm9tIHN5
c3RlbQ0KPiA+ID4gZmlybXdhcmUgYW5kIGFjY2Vzc2VkIG1vc3QgcHJvYmFibHkgYnkgd2hhdCBp
cyBjYWxsZWQgY2lvMi1icmlkZ2UgYXQgdGhlDQo+IG1vbWVudC4NCj4gPiA+DQo+ID4gPiBUaGUg
cHJpdmFjeSBzdGF0dXMgY2FuIGJlIGEgVjRMMiBjb250cm9sLg0KPiA+ID4NCj4gPiA+IEFsc28g
Y2MgSGFucy4NCj4gPiA+DQo+ID4gPj4NCj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBXZW50b25nIFd1
IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gPiA+PiAtLS0NCj4gPiA+PiAgZHJpdmVycy9tZWRp
YS9wY2kvaW50ZWwvaXZzYy9NYWtlZmlsZSB8ICAxICsNCj4gPiA+PiAgZHJpdmVycy9tZWRpYS9w
Y2kvaW50ZWwvaXZzYy9pdnNjLmMgICB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ID4+ICBpbmNsdWRlL2xpbnV4L2l2c2MuaCAgICAgICAgICAgICAgICAgIHwgNTUgKysrKysr
KysrKysrKysrKysrDQo+ID4gPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTQwIGluc2VydGlvbnMoKykg
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4+IGRyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2Mv
aXZzYy5jDQo+ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wY2kvaW50
ZWwvaXZzYy9NYWtlZmlsZQ0KPiA+ID4+IGIvZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9N
YWtlZmlsZQ0KPiA+ID4+IGluZGV4IGRlMGE0MjVjMjJjMi4uYjhiNmZjMTA4M2JlIDEwMDY0NA0K
PiA+ID4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvTWFrZWZpbGUNCj4gPiA+
PiArKysgYi9kcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL01ha2VmaWxlDQo+ID4gPj4gQEAg
LTQsMyArNCw0IEBADQo+ID4gPj4NCj4gPiA+PiAgb2JqLSQoQ09ORklHX0lOVEVMX1ZTQykgKz0g
bWVpX2NzaS5vDQo+ID4gPj4gIG9iai0kKENPTkZJR19JTlRFTF9WU0MpICs9IG1laV9hY2Uubw0K
PiA+ID4+ICtvYmotJChDT05GSUdfSU5URUxfVlNDKSArPSBpdnNjLm8NCj4gPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tZWRpYS9wY2kvaW50ZWwvaXZzYy9pdnNjLmMNCj4gPiA+PiBiL2RyaXZl
cnMvbWVkaWEvcGNpL2ludGVsL2l2c2MvaXZzYy5jDQo+ID4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiA+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjEyOTk2YjU4NzYzOQ0KPiA+ID4+IC0tLSAv
ZGV2L251bGwNCj4gPiA+PiArKysgYi9kcml2ZXJzL21lZGlhL3BjaS9pbnRlbC9pdnNjL2l2c2Mu
Yw0KPiA+ID4+IEBAIC0wLDAgKzEsODQgQEANCj4gPiA+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ID4+ICsvKg0KPiA+ID4+ICsgKiBDb3B5cmlnaHQgKEMp
IDIwMjMgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ID4gPj4gKyAq
IEludGVsIFZpc3VhbCBTZW5zaW5nIENvbnRyb2xsZXIgaW50ZXJmYWNlICAqLw0KPiA+ID4+ICsN
Cj4gPiA+PiArI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gPj4gKyNpbmNsdWRlIDxsaW51
eC9pdnNjLmg+DQo+ID4gPj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiA+PiArI2lu
Y2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+ID4gPj4gKw0KPiA+ID4+ICsjaW5jbHVkZSAibWVpX2Fj
ZS5oIg0KPiA+ID4+ICsjaW5jbHVkZSAibWVpX2NzaS5oIg0KPiA+ID4+ICsNCj4gPiA+PiArLyog
bG9jayBmb3IgaXZzYyBBUElzICovDQo+ID4gPj4gK3N0YXRpYyBERUZJTkVfTVVURVgoaXZzY19t
dXRleCk7DQo+ID4gPj4gKw0KPiA+ID4+ICtpbnQgaXZzY19hY3F1aXJlX2NhbWVyYSh1MzIgbnJf
b2ZfbGFuZXMsIHU2NCBsaW5rX2ZyZXEsDQo+ID4gPj4gKwkJCXZvaWQgKCpjYWxsYmFjaykodm9p
ZCAqLCBlbnVtIGl2c2NfcHJpdmFjeV9zdGF0dXMpLA0KPiA+ID4+ICsJCQl2b2lkICpjb250ZXh0
KQ0KPiA+ID4+ICt7DQo+ID4gPj4gKwlpbnQgcmV0Ow0KPiA+ID4+ICsNCj4gPiA+PiArCW11dGV4
X2xvY2soJml2c2NfbXV0ZXgpOw0KPiA+ID4+ICsNCj4gPiA+PiArCS8qIHN3aXRjaCBjYW1lcmEg
c2Vuc29yIG93bmVyc2hpcCB0byBob3N0ICovDQo+ID4gPj4gKwlyZXQgPSBhY2Vfc2V0X2NhbWVy
YV9vd25lcihBQ0VfQ0FNRVJBX0hPU1QpOw0KPiA+ID4+ICsJaWYgKHJldCkNCj4gPiA+PiArCQln
b3RvIGVycm9yOw0KPiA+ID4+ICsNCj4gPiA+PiArCS8qIHN3aXRjaCBDU0ktMiBsaW5rIHRvIGhv
c3QgKi8NCj4gPiA+PiArCXJldCA9IGNzaV9zZXRfbGlua19vd25lcihDU0lfTElOS19IT1NULCBj
YWxsYmFjaywgY29udGV4dCk7DQo+ID4gPj4gKwlpZiAocmV0KQ0KPiA+ID4+ICsJCWdvdG8gcmVs
ZWFzZV9jYW1lcmE7DQo+ID4gPj4gKw0KPiA+ID4+ICsJLyogY29uZmlndXJlIENTSS0yIGxpbmsg
Ki8NCj4gPiA+PiArCXJldCA9IGNzaV9zZXRfbGlua19jZmcobnJfb2ZfbGFuZXMsIGxpbmtfZnJl
cSk7DQo+ID4gPj4gKwlpZiAocmV0KQ0KPiA+ID4+ICsJCWdvdG8gcmVsZWFzZV9jc2k7DQo+ID4g
Pj4gKw0KPiA+ID4+ICsJbXV0ZXhfdW5sb2NrKCZpdnNjX211dGV4KTsNCj4gPiA+PiArDQo+ID4g
Pj4gKwlyZXR1cm4gMDsNCj4gPiA+PiArDQo+ID4gPj4gK3JlbGVhc2VfY3NpOg0KPiA+ID4+ICsJ
Y3NpX3NldF9saW5rX293bmVyKENTSV9MSU5LX0lWU0MsIE5VTEwsIE5VTEwpOw0KPiA+ID4+ICsN
Cj4gPiA+PiArcmVsZWFzZV9jYW1lcmE6DQo+ID4gPj4gKwlhY2Vfc2V0X2NhbWVyYV9vd25lcihB
Q0VfQ0FNRVJBX0lWU0MpOw0KPiA+ID4+ICsNCj4gPiA+PiArZXJyb3I6DQo+ID4gPj4gKwltdXRl
eF91bmxvY2soJml2c2NfbXV0ZXgpOw0KPiA+ID4+ICsNCj4gPiA+PiArCXJldHVybiByZXQ7DQo+
ID4gPj4gK30NCj4gPiA+PiArRVhQT1JUX1NZTUJPTF9HUEwoaXZzY19hY3F1aXJlX2NhbWVyYSk7
DQo+ID4gPj4gKw0KPiA+ID4+ICtpbnQgaXZzY19yZWxlYXNlX2NhbWVyYSh2b2lkKQ0KPiA+ID4+
ICt7DQo+ID4gPj4gKwlpbnQgcmV0Ow0KPiA+ID4+ICsNCj4gPiA+PiArCW11dGV4X2xvY2soJml2
c2NfbXV0ZXgpOw0KPiA+ID4+ICsNCj4gPiA+PiArCS8qIHN3aXRjaCBDU0ktMiBsaW5rIHRvIElW
U0MgKi8NCj4gPiA+PiArCXJldCA9IGNzaV9zZXRfbGlua19vd25lcihDU0lfTElOS19JVlNDLCBO
VUxMLCBOVUxMKTsNCj4gPiA+PiArCWlmIChyZXQpDQo+ID4gPj4gKwkJZ290byBlcnJvcjsNCj4g
PiA+PiArDQo+ID4gPj4gKwkvKiBzd2l0Y2ggY2FtZXJhIHNlbnNvciBvd25lcnNoaXAgdG8gSVZT
QyAqLw0KPiA+ID4+ICsJcmV0ID0gYWNlX3NldF9jYW1lcmFfb3duZXIoQUNFX0NBTUVSQV9JVlND
KTsNCj4gPiA+PiArDQo+ID4gPj4gK2Vycm9yOg0KPiA+ID4+ICsJbXV0ZXhfdW5sb2NrKCZpdnNj
X211dGV4KTsNCj4gPiA+PiArDQo+ID4gPj4gKwlyZXR1cm4gcmV0Ow0KPiA+ID4+ICt9DQo+ID4g
Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKGl2c2NfcmVsZWFzZV9jYW1lcmEpOw0KPiA+ID4+ICsNCj4g
PiA+PiArTU9EVUxFX0FVVEhPUigiV2VudG9uZyBXdSA8d2VudG9uZy53dUBpbnRlbC5jb20+Iik7
DQo+ID4gPj4gK01PRFVMRV9BVVRIT1IoIlpoaWZlbmcgV2FuZyA8emhpZmVuZy53YW5nQGludGVs
LmNvbT4iKTsNCj4gPiA+PiArTU9EVUxFX1NPRlRERVAoInByZTogbWVpX2NzaSBtZWlfYWNlIik7
DQo+IE1PRFVMRV9ERVNDUklQVElPTigiSVZTQw0KPiA+ID4+ICtpbnRlcmZhY2UiKTsgTU9EVUxF
X0xJQ0VOU0UoIkdQTCIpOyBNT0RVTEVfSU1QT1JUX05TKElWU0MpOw0KPiA+ID4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2l2c2MuaCBiL2luY2x1ZGUvbGludXgvaXZzYy5oIGluZGV4DQo+
ID4gPj4gNjU3MmNhNGYzNDBjLi5iYzkwMDZjZDZlZmMgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvaW5j
bHVkZS9saW51eC9pdnNjLmgNCj4gPiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L2l2c2MuaA0KPiA+
ID4+IEBAIC0xNiw0ICsxNiw1OSBAQCBlbnVtIGl2c2NfcHJpdmFjeV9zdGF0dXMgew0KPiA+ID4+
ICAJSVZTQ19QUklWQUNZX01BWCwNCj4gPiA+PiAgfTsNCj4gPiA+Pg0KPiA+ID4+ICsjaWYgSVNf
RU5BQkxFRChDT05GSUdfSU5URUxfVlNDKQ0KPiA+ID4+ICsvKg0KPiA+ID4+ICsgKiBAYnJpZWYg
QWNxdWlyZSBjYW1lcmEgc2Vuc29yIG93bmVyc2hpcCB0byBob3N0IGFuZCBzZXR1cA0KPiA+ID4+
ICsgKiB0aGUgQ1NJLTIgbGluayBiZXR3ZWVuIGhvc3QgYW5kIElWU0MNCj4gPiA+PiArICoNCj4g
PiA+PiArICogSVZTQyBwcm92aWRlcyBhIHByaXZhY3kgbW9kZS4gV2hlbiB0aGUgcHJpdmFjeSBt
b2RlIGlzIHR1cm5lZA0KPiA+ID4+ICsgKiBvbiwgY2FtZXJhIHNlbnNvciBjYW4ndCBiZSB1c2Vk
LiBUaGlzIG1lYW5zIHRoYXQgYm90aCBJVlNDIGFuZA0KPiA+ID4+ICsgKiBob3N0IEltYWdlIFBy
b2Nlc3NpbmcgVW5pdChJUFUpIGNhbid0IGdldCBpbWFnZSBkYXRhLiBBbmQgd2hlbg0KPiA+ID4+
ICsgKiB0aGlzIG1vZGUgaXMgdHVybmVkIG9uLCBob3N0IEltYWdlIFByb2Nlc3NpbmcgVW5pdChJ
UFUpIGRyaXZlcg0KPiA+ID4+ICsgKiBpcyBpbmZvcm1lZCB2aWEgdGhlIHJlZ2lzdGVyZWQgY2Fs
bGJhY2ssIHNvIHRoYXQgdXNlciBjYW4gYmUNCj4gPiA+PiArICogbm90aWZpZWQuDQo+ID4gPj4g
KyAqDQo+ID4gPj4gKyAqIEBwYXJhbSBucl9vZl9sYW5lcyBOdW1iZXIgb2YgZGF0YSBsYW5lcyB1
c2VkIG9uIHRoZSBDU0ktMiBsaW5rDQo+ID4gPj4gKyAqIEBwYXJhbSBsaW5rX2ZyZXEgRnJlcXVl
bmN5IG9mIHRoZSBDU0ktMiBsaW5rDQo+ID4gPj4gKyAqIEBwYXJhbSBjYWxsYmFjayBUaGUgcG9p
bnRlciBvZiBwcml2YWN5IGNhbGxiYWNrIGZ1bmN0aW9uDQo+ID4gPj4gKyAqIEBwYXJhbSBjb250
ZXh0IFByaXZhY3kgY2FsbGJhY2sgZnVuY3Rpb24gcnVudGltZSBjb250ZXh0DQo+ID4gPj4gKyAq
DQo+ID4gPj4gKyAqIEByZXR2YWwgMCBJZiBzdWNjZXNzDQo+ID4gPj4gKyAqIEByZXR2YWwgLUVJ
TyBJTyBlcnJvcg0KPiA+ID4+ICsgKiBAcmV0dmFsIC1FSU5WQUwgSW52YWxpZCBhcmd1bWVudA0K
PiA+ID4+ICsgKiBAcmV0dmFsIC1FQUdBSU4gSVZTQyBkZXZpY2Ugbm90IHJlYWR5DQo+ID4gPj4g
KyAqIEByZXR2YWwgbmVnYXRpdmUgdmFsdWVzIGZvciBvdGhlciBlcnJvcnMgICovIGludA0KPiA+
ID4+ICtpdnNjX2FjcXVpcmVfY2FtZXJhKHUzMiBucl9vZl9sYW5lcywgdTY0IGxpbmtfZnJlcSwN
Cj4gPiA+PiArCQkJdm9pZCAoKmNhbGxiYWNrKSh2b2lkICosIGVudW0gaXZzY19wcml2YWN5X3N0
YXR1cyksDQo+ID4gPj4gKwkJCXZvaWQgKmNvbnRleHQpOw0KPiA+ID4+ICsNCj4gPiA+PiArLyoN
Cj4gPiA+PiArICogQGJyaWVmIFJlbGVhc2UgY2FtZXJhIHNlbnNvciBvd25lcnNoaXAgYW5kIHN0
b3AgdGhlIENTSS0yDQo+ID4gPj4gKyAqIGxpbmsgYmV0d2VlbiBob3N0IGFuZCBJVlNDDQo+ID4g
Pj4gKyAqDQo+ID4gPj4gKyAqIEByZXR2YWwgMCBJZiBzdWNjZXNzDQo+ID4gPj4gKyAqIEByZXR2
YWwgLUVJTyBJTyBlcnJvcg0KPiA+ID4+ICsgKiBAcmV0dmFsIC1FSU5WQUwgSW52YWxpZCBhcmd1
bWVudA0KPiA+ID4+ICsgKiBAcmV0dmFsIC1FQUdBSU4gSVZTQyBkZXZpY2Ugbm90IHJlYWR5DQo+
ID4gPj4gKyAqIEByZXR2YWwgbmVnYXRpdmUgdmFsdWVzIGZvciBvdGhlciBlcnJvcnMgICovIGlu
dA0KPiA+ID4+ICtpdnNjX3JlbGVhc2VfY2FtZXJhKHZvaWQpOw0KPiA+ID4+ICsNCj4gPiA+PiAr
I2Vsc2UNCj4gPiA+PiArc3RhdGljIGlubGluZQ0KPiA+ID4+ICtpbnQgaXZzY19hY3F1aXJlX2Nh
bWVyYSh1MzIgbnJfb2ZfbGFuZXMsIHU2NCBsaW5rX2ZyZXEsDQo+ID4gPj4gKwkJCXZvaWQgKCpj
YWxsYmFjaykodm9pZCAqLCBlbnVtIGl2c2NfcHJpdmFjeV9zdGF0dXMpLA0KPiA+ID4+ICsJCQl2
b2lkICpjb250ZXh0KQ0KPiA+ID4+ICt7DQo+ID4gPj4gKwlyZXR1cm4gMDsNCj4gPiA+PiArfQ0K
PiA+ID4+ICsNCj4gPiA+PiArc3RhdGljIGlubGluZSBpbnQgaXZzY19yZWxlYXNlX2NhbWVyYSh2
b2lkKSB7DQo+ID4gPj4gKwlyZXR1cm4gMDsNCj4gPiA+PiArfQ0KPiA+ID4+ICsNCj4gPiA+PiAr
I2VuZGlmDQo+ID4gPj4gKw0KPiA+ID4+ICAjZW5kaWYNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+
IA0KPiBMYXVyZW50IFBpbmNoYXJ0DQo=

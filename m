Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0931646FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiLHMsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLHMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:48:12 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E015A15;
        Thu,  8 Dec 2022 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670503691; x=1702039691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4DDxb9oxFIUnsmVAYM59X6fT3qpmcdheSHFZpJ7GggY=;
  b=Tzoc7IEMdkjCaphJxO5QqlZwmMK5VwMlNxhf/xAub2gI6uENgPR6ER2g
   qz4eyzS1so/dbIqOXyDV671S9SnfnGOAOM/lIaosGh54RQ2v8zqA4qVsl
   Y7Fos0GU6dV8LoBqsK0JTswrPY/KCGxNVBmBE6rstbJ+71OeA1Ul9Szoa
   ctWjs6QaO2KEF3klsfsuHD5+bGqxtGpdjLKuVgQ0A33+A4wIXBlzlQ5pZ
   tbHB1GZmwE/xUDiACgqRjyYooSv1TNjG3dausS5IMXUDcPSPhWFQty7/8
   2+X7J4Q6v+33Np8XkoyNzGj1HRU8bffxh+DLUjcYS38xyRP7EOxJ0UEux
   g==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665417600"; 
   d="scan'208";a="322548771"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 20:48:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSRctB8MEaTmUccXZy1TnTCRJfuBGnj/VF8T1Bd720uqj8QGvDdBgBJjc6LTaCcrlqfJ13dKzY1MU0Fq9ieBgpNY8SB92euJcS5V1JKVQ2Ve67srlaUR0RC9Luqz02LLeJ5W/zpJr+NDPZo1hVOCc5NKGa9l+EvFKl7v2qvMSrUe6RWmb9O6YF5PBN1UI7J4HUMX3cvud6LGYuwAoDm4ptLWeAmC7A07bqygevPZYbQ/cCv2o2hZG8FAbtjgKTKb3udIYqWymuzqm5BKYgd8BxPAvwB4ylIDsjmXLMNWxxQZnYwF3124J7Y8fV+jLR61AelQPZ0ESUxyC9qIEBdCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DDxb9oxFIUnsmVAYM59X6fT3qpmcdheSHFZpJ7GggY=;
 b=RMEcSYFATMx4geY0hatD7bXcWpc4K0k7p8ZkcN2Ob3sowlkMX9ZSIIkW8IHXXOzt8CYLXiiaPD09ZBVUXa3Vd5t7/0c2cr3rddR6hAl5h32nXMDWtsWRc6i7IaN+9DQfd8F/TA9THwlDDIvcVQTz4RPlvnEqdLlmA6aV/8BsIle3ArM1gnp8/6a/eT90kuozIbxbPypfMe8o5Y3dvsubWwjtVRbkEOXO9GRaSSeu5sL88c6q/3mjBmXKPvP3TWzj3S/OLs0XZ+4fBM9AJOl2NvMdeiVLrhIPhyJfD/vnZVLYMoYwTKg6vjmPJ8z68i+6sjvOe0R/3i9GOfTArbMq5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DDxb9oxFIUnsmVAYM59X6fT3qpmcdheSHFZpJ7GggY=;
 b=pSGrwj0ELsm7Qi++IB/aI4BeiCgZkWNr8ZGSvoYGt4YqX5IJ6HoPbdiPVKmixvr2+nsVGnMhr/K7nNDdNKqiTXyMYI+9EVXRPm8X/x32jmGxi2eJjVlItFB+PsTrxj44vL+VhTC9nHCrnZHKIob1goxvpMdx0pyEb9WMPXhHq6M=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SA2PR04MB7548.namprd04.prod.outlook.com (2603:10b6:806:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 12:48:06 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::a038:ff31:3aac:992e]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::a038:ff31:3aac:992e%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 12:48:06 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] ufs: core: Remove redundant desc_size variable
 from hba
Thread-Topic: [PATCH v4 2/4] ufs: core: Remove redundant desc_size variable
 from hba
Thread-Index: AQHZAlj+11R6Zl2YkEWjrwPUMVa0ma5jJMqAgADcquA=
Date:   Thu, 8 Dec 2022 12:48:06 +0000
Message-ID: <BY5PR04MB632742AD2ADF3C53EEA94F95ED1D9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-3-git-send-email-Arthur.Simchaev@wdc.com>
 <e99e929b-c26e-36eb-3254-d0ec58599e6a@acm.org>
In-Reply-To: <e99e929b-c26e-36eb-3254-d0ec58599e6a@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SA2PR04MB7548:EE_
x-ms-office365-filtering-correlation-id: ec6d0fdd-6db5-4ca2-a42c-08dad91a7402
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1c2k7zeivcYV7IxDc85KIVgP9BUMvOazfiUah35QIVi2IulTuE/YZoVUVN0RucDIiySGuMCDOjiVMbKoEj8OGD0kscudM73JrOyqrPAzFqXeq0f2Q0NPM4tuGXYVAkJ3HUK47PFLMj3r/WnBIcIUycez8NxsWkcv9p9nvo3CXrZ8mISy/KIt6VAaSeCzUoMy+u2sLTLDKzjmO1Y8MVEwNdJTJu5M1Asyj2vZ2F0UKEpJQw0A/dgJbkREfSt0+yFtkmHkilADtUKk9WqukWo6D3t5OhpQD7GSanDaj80GMT78B1z5GSes6gDAQ1bvkO9Ogvrnrb/umJL7A8OuL7aCAi/5rOv4nr6zjZdzbD2YeQC2JPbqG7Qv5KuVMrCAZ8IijZVtyV4HWBwhhHAmFqwjTKUHT07WEWHl3ZUG3jzYfUW/iUsxdkEJ6HkVfHSx7plgXcWCzev2cMaJwksXiK8w5kgModFkePvyZ1Si4UOzjUrffNwnIiEgotaLQaHxvWRNmL2KfIoiuHS5Fy5ycecPb/vRenpYRzflbxQ+Iq70Y90AvBENH4HUjwK2WVClnAxRwJlPAiTtfwL8ZPRjWKA6eo955fmf1BJa25IfH6r5l/RXV+EECA3q5gd3WRb8ejtPkOKJhBjLwiXE7IUFynLrY45Yw6iXDJaIaV0nnzAyldZWEx4stettUaVVtjuszXBy6l8x1fIdMxkEJ5H7MqIXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(8676002)(4326008)(66446008)(66476007)(64756008)(66946007)(66556008)(76116006)(54906003)(110136005)(316002)(5660300002)(2906002)(55016003)(38070700005)(4744005)(33656002)(86362001)(38100700002)(122000001)(41300700001)(82960400001)(52536014)(8936002)(71200400001)(478600001)(9686003)(186003)(26005)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmlFckthd0UwRkx5UnMyRGVNSG56NUNmek1jWHRmQXJNamNSbjBxSUJlKzNQ?=
 =?utf-8?B?ZUFxNWE4bW5rUHJJeCtoaGd1NkEyOUtKVVVTNXcwQk93eEZ4OWFhUFBDZWxr?=
 =?utf-8?B?NlFKQU8vSEJUZ0NMYU11dE1EWWlFVmExMlpzczN3NklSNlNwcVZRQUd0dXVN?=
 =?utf-8?B?ZWxDVjZ1SDQyOUl4ZFlPVGhiN2VZZjhJZlFSdUY0S3B1QytmYnZGMUYwMkND?=
 =?utf-8?B?TUxLRXpYenNTaGtxZ0tOTCsvb3E5R214dzJuQ3ZqRWZKaWQrOUFSUElYSVll?=
 =?utf-8?B?cVMrOCtIL0xGT3J1MDBqQjl3VXZoRlRKUkswQWNkNDIzTnlkKzhpWlBCQ3RZ?=
 =?utf-8?B?Q0VGMDJ2SnJrL1dDd1FkWm9OTzd5djlTa2RTQS9hU25NZjQ0T0ptUW1lUVBH?=
 =?utf-8?B?OGJIWGhLVEVMeWtiVndLVHZhSzFEZ09rMm5xSCtjMXJ3RTBBU1FFOHBka3NI?=
 =?utf-8?B?ZU9GVXZYbUZVSEgySlVyRG05ZkRVSzJqdE84T2ZHZ3Y4TnNyU0YwUGU5cmhI?=
 =?utf-8?B?Vy80d0pwNGRwKzBZTVJTM3ZoRkZoZVlCT29rd3NndVRYZVd1L05ZOFBZTDNK?=
 =?utf-8?B?eUpVenkyVVNpY0dvZjVURGswUjFTVlJ4aWVqYVk1MS9QdTZQaVF3dENwaTdX?=
 =?utf-8?B?WHMxRkJMY24zajBpaGdISTRqaHA5bng5Umg4UXFGTlN5UnIvZGgxVExjc0tj?=
 =?utf-8?B?MDJpSzF5QVNldmlaeis4bEtoalRhV050NlhoSmVjOUZEcUh6VWROd3BzUGRm?=
 =?utf-8?B?emNMamMzMEZXUTArd1I3c05ob1h6aFRHMkpjTmdRSHRlZDJyOVJvT01XRnI0?=
 =?utf-8?B?bTNKdEMzL0lMRTJreUdLL29CZ3BxTzdFTEpqSWtSY3I4aXZwK2xDWnJOUVlQ?=
 =?utf-8?B?a01wSnQrQ1R0OWdWN2VvaUZPSHRMTWwrRW9kSnIrbkJTZHFIN21pd0FqYnVY?=
 =?utf-8?B?ZnVkeXpKelVjNmMyelBBK0h6OFAwdEhHUWN0Wm8zbnRSbkt4MjluK1ZLWGZO?=
 =?utf-8?B?Q3Y3ZTl4bWVPT3FacEJGUHIzUHE4OUx5cWlzUjg5Zm1US2F6MVB0SmF4dVh3?=
 =?utf-8?B?TGx5aWxwbzNNcURSd0NMODgrTDNhT0ZMWEtMTjVjQU12UGdvbkY5cFNoL094?=
 =?utf-8?B?YXBqZ1BlR0lKcUdLYmI3SmNqSFZhUURGQkJ1ZVMwcjlkR2NPZUYvQmtkdXdI?=
 =?utf-8?B?U00rQ25VUFlwRlFZeHJDV2Q1VkF4K2NQdy9HaHRKbTRHVDBiVGtOUDNFVVli?=
 =?utf-8?B?V1RMSUtYZzJ0T1JIeXVCa0dkQ1FSTVhiQzJtZzBHNi9odklZS21uOHFTSzkw?=
 =?utf-8?B?MlBnbmo0dlBSd1EyaDRHOUpvNmFUcFEycTF2MUszMWh0MzZoY3lRRlliYlh4?=
 =?utf-8?B?SXFvc3BuQmdNWU82WFFJaHZ4TUY2VlEzUlplMEVTSzM0S1ZLaFBtbHlDcmdT?=
 =?utf-8?B?SDg3WlNhelVZbzlTSW44dHRGWFZQUWNFalRMeFNXNHF0M1JZNnpUMkp1OXl2?=
 =?utf-8?B?TXk3TVlsRDFXeUZuVGVyNnMwd29acnhjSEUrUFdJOTY4RW9nQmk4dzJ3L3Ax?=
 =?utf-8?B?RS8yQzY1b0FJVlhIaXpQOXJKYk41WXBncUNFZGViUEIwQ3haK2QrRmh4R0lO?=
 =?utf-8?B?Q0pJdWNwdmRUV2xyR3B5aHBraFNDWEt1Q1FmWTVZSlY1SlJwcVkwaUNObjBE?=
 =?utf-8?B?OVl5UzVibWRYcTB4akFUQVlDNThuaXoyVlJEU1V5bnBXZEFOS2RjanZhKzBi?=
 =?utf-8?B?N2NOZWcyVXBXQU12V1M3YjUybVl0eC80OG1KbnQ4cWo4RG5nQ3FzV1JSNlJ5?=
 =?utf-8?B?d01tVWg1ZHJSZlhHemwwRkNmMk9wblJKVjJ1UXVJVkJmbkNabTJkbGFQLzIr?=
 =?utf-8?B?aHhCSlRMY256OWk5KzhPLzY0a0YxM0MyL0xjQ0FZdkFoZ0NiUHpVU3FrMCtk?=
 =?utf-8?B?NlJDODhsTDczbXJtUll4SU00VDFWTERFTlJ6VHJqZHBEL3JQeEhiemk0c0tR?=
 =?utf-8?B?M3BSMmNHWTREc0doT0JEenJ2aGgvaERSejlhM2dNTVc5RXlwN1E3S0RGTW84?=
 =?utf-8?B?TTE1OUdIM2hUdmd0QW9pMi9Zb1dUbVorSjhSUmllZWF0MUZOaVVnYk92TDlR?=
 =?utf-8?Q?OO/Ssop/45hmTnkGmD//F660g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6d0fdd-6db5-4ca2-a42c-08dad91a7402
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 12:48:06.4585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFVWclcM6/r4TO7iHMROR2o/5VQBHpSooplXtlrWAQjx3wOeDyVcytoogdBRh+9CkWGEWJiB46QHlqk4HUqDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7548
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gQ29tbWVudHMgc2hvdWxkIGV4cGxhaW4gc29tZXRoaW5nIHRoYXQgaXMgbm9udHJpdmlh
bCBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nDQo+IHRoZQ0KPiBjb2RlLiBBZGRpdGlvbmFsbHksIHRo
aXMgY2hhbmdlIG1ha2VzIHVmc2hjZF9tYXBfZGVzY19pZF90b19sZW5ndGgoKSB0b28NCj4gc2hv
cnQNCj4gdG9vIGtlZXAgaXQgYXMgYSBmdW5jdGlvbi4gUGxlYXNlIHJlbW92ZSB0aGlzIGZ1bmN0
aW9uIGVudGlyZWx5IGFuZCBpbnNlcnQgdGhlDQo+IGZvbGxvd2luZyBjb2RlIGludG8gdGhlIGNh
bGxlcnMgb2YgdGhpcyBmdW5jdGlvbjoNCj4gDQo+IGRlc2NfbGVuID0gUVVFUllfREVTQ19NQVhf
U0laRQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFydC4NCg0KRG9uZQ0KDQpSZWdhcmRzDQpBcnRo
dXINCg==

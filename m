Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15258619465
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKDKYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKDKXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:23:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7012613C;
        Fri,  4 Nov 2022 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667557418; x=1699093418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOc8ZiGJcpjh9B4M/ppBgYAdScQj+ZU0SwKQyMkSwcg=;
  b=bCAY4P+i28SbfSWp70hKida+0WfEzNDw+TYE4Us/t1tyyrNwvgPdxwtx
   tvKligT96DWY75EZo5dncYSyHlCWPLmYA6Djjn/UQegv41ocg6ySTCSv8
   uHamG+mwl3KoXcBoNiwA0k8P/lgI9aBz/XW2JoGqZfRJD1K6rrR5HUAWa
   AeRZO5K9cx2MWfAhbQ+EDwJQWQkF0SMNewSjzwiNLcYDW/t6+jkK7JDgj
   gUxLpCy/Ym1BDbe39au/76oOgdwxzQn+MoTCNLdA8EzJa5NX/fBFSA8j2
   MIfkM0Av96wdsJn8elhiwyhfAQHVfEi/GlXlsAI8n6DrHL0iZArytXR1I
   w==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="121808302"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2022 03:23:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 4 Nov 2022 03:23:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 4 Nov 2022 03:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ck1aGBo10Mw63M379v8A/xegr4+3QCnTmufC0Hxbjga6cUIP/TUgOZ1WNWjycpQvdQ0v++RbTES+m9yUI9lOOHzMLj33uwu03VC9HcbuAdPED23hwXqZfQeoRbuCzrSX2cexsq887HGWzBM8XNg0/vQvT/QdROfMRn9hZ7o0dOYZwY+HShPZW8vZ8zohHhVK9nWPB2TOUM2f4hAoI7gLNObDquAC3KCYh1RaPva78mQTGIz0mv2m88tI1aQqBAC+Ikcc3egWyOE4soRnRiECqq8SnMgETQ6sz6T7viaM2amGC9iGANJjAF2LMyxV/EZvNFvC1bfTrkD/QVxc3afKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOc8ZiGJcpjh9B4M/ppBgYAdScQj+ZU0SwKQyMkSwcg=;
 b=Ie5QUKxtVIZTXxUsIZgRHSv4GwZjfbqe92eB/XG+n79D+Ap7untuyy9fF1O6SBRMLBcwUbFl0f+c9er4bdwnkW3oU6VGiIez6CfkGeDwhH8VvvV6sITRrKn3XiXLbDWZ4uz55+PeXDMP6AybTQ4ue2+GJx7/uenmZRbonOl0ZtqJD/Urd5hH0HvN5m8iTlnG2Y+nu7nHHN7a6hhtMAiXDFZ0gtuoTN/J2xmnDiiG2dMrlOK756yHJcpf28IyWwEcFuhJGITUssIcb7wZ5iQV2SEz+qVBjeg0S5y5ZfzUJW/NGXd8kJxDyPkQ1FWv+QubRlFvsZlaQpjW8Mx/1hm/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOc8ZiGJcpjh9B4M/ppBgYAdScQj+ZU0SwKQyMkSwcg=;
 b=S7jb7cNJTR5OoybFF9YzUGtkiN6MzNIhYucz5WXiaL8XxBFU1gSLQWtXeby8b3VNV0KUeRPhh1Tmkz1i2NdAoaXstBfYu0jOoWRieuTJWRnEWQVKvQ1wJ1V16iu45AxDNNrJAMjSXocGCgICHd/T/aPs6SYP2yW8Kr6KljfyxfE=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 10:23:30 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::ad91:1f74:6e64:3f00]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::ad91:1f74:6e64:3f00%6]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 10:23:30 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Kumaravel.Thiagarajan@microchip.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Topic: [PATCH v2 tty-next 3/3] 8250: microchip: pci1xxxx: Add power
 management functions to quad-uart driver.
Thread-Index: AQHY1V02yYultS77nEiXC6E78nq8Dq38ac+AgDJZefA=
Date:   Fri, 4 Nov 2022 10:23:30 +0000
Message-ID: <PH0PR11MB50964BC2301907D51B3DCF119B3B9@PH0PR11MB5096.namprd11.prod.outlook.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-4-kumaravel.thiagarajan@microchip.com>
 <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
In-Reply-To: <CAHp75VdEJvG=BQvS2KVNY8BnjfHyOCO6ww0S4_gxVZNuhXaURg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|DM4PR11MB5344:EE_
x-ms-office365-filtering-correlation-id: f6916cc7-9490-4a0b-f47d-08dabe4e9ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXL1w2qDNgby8UcX65KlEe5yaQ7dDKKijR6KXvByFOqwPUq7AjavSOlzh+vltkxde81oZvlFkdViYY7mPSiq2Qil94KlFiUo/8whiNXhQv1PJW0CGD/UoDbBDTmb4XFzwyecpXkmc9g0sgpa/t6yxzHf6n+pPD0gEjrVT20NJeXzqt8955HvTwh3ezWGpbEipfS16rojPr/lCMHoAD7VkC0aHjvbiORZyeVc9HFmWdEGeoqPATdsFIfvFqEEjMRf4rTje/HZW5zk4u81KRnskqgYtVXwK8XqRdohDJJCIuD0a6ek1H5GUqR5izm5J6+zYkNG3VSkpoyCOHTP5gsMkoeY9cQIIBYgceML3lE/ex6LAFM90dte8AEAufC35xyrnVEQDVFIdqVTlX+mj5+RruT8ENhJtb2himvoHkk/9I8cnugQDJSSJhlUbitbmCIeHsJRV+iHNdz+UVQJlygbHKUx5yjC6uWFXzuuwl7LcMPbGRVTA4gRmTUhzsaFUbT4xypPgmCVL8RGTOA7Uw/imwEDhwUJczgOYX38zX9rSVyrEd65IMa3DxgiB9+JuP5szj0iWZn0oiDy9XypAo9qV+yKjYzRVM1vR5L98bQ2rUOtZmpc1F7PJNT4W06HwBTLFGCruHeIjS6jo6R2ZC25b0GwOg43aMuI7HCS+mC1/X2xyzH4nOxSYlM2hYTbEGsIOVirZa6Zl0zhLrb7ErUhUC/1XpVP5W74tczudXfwQ4V+MLn+Y54/2RqE6Ubb6uAuWbD4xx1w3bELYvhddZtx5cm0bXXyunV5CfYubLoMSUofbcDdmZtpnX+KJZmSxdKuLgHnugMjL3sMiYQayaS/2IBQz6rqHtusYP6ORlmjKg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(478600001)(6636002)(110136005)(38100700002)(107886003)(54906003)(122000001)(316002)(83380400001)(8936002)(86362001)(26005)(9686003)(41300700001)(55016003)(8676002)(7696005)(71200400001)(4326008)(38070700005)(186003)(7416002)(5660300002)(4744005)(52536014)(33656002)(53546011)(66556008)(66446008)(76116006)(66946007)(64756008)(6506007)(66476007)(2906002)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW4wcVJSVW5nbzRGdzFJK2ZYREtpVlR2TWVUZDh2SjQ0Y2pTeWJpQzVnQjlP?=
 =?utf-8?B?QVlkQk13NnBIQzNRMi9yRmx2dSt2QmhNUlMvSTlvQ3p2YkFBTjZIci9NSktT?=
 =?utf-8?B?dE80MjVhUFJvSDBrL1NjSDRNRHBlK1RFaW5CYXFENnNzc3FDSjRzb2czc0N2?=
 =?utf-8?B?bk9RUmx0bUk1SnFYZ2VxYUk2eWZQUEx0MW0vbCs4V3ZNMU5nV3lTNFZabitp?=
 =?utf-8?B?TEhrbkhoVXNjVCtFQ2lUUU1LVCtpQ1Aydjk4bWwzTVBaV2ZnZUlnaThDc1Fn?=
 =?utf-8?B?YWVBNHR4UFV2Y1dKb1YyMHpkSCtsMFo4VklTSXBYWUNHWnZSNXQ4YzEwVTlu?=
 =?utf-8?B?VStNV2pzQis2MWd4M2phOCt2K21iRWVPbWpTNk9zM3VaWE9ZN3RZSUU3MjB1?=
 =?utf-8?B?Sk5tMG9PbUpQaWxJeGZGU2lDNTlVSG5qSVBTSWRub201eklCWFpZQmpaQy85?=
 =?utf-8?B?Rmd4bjNlSENEdnluUnE5SndZM2ExUEFhZCsrOE1sZU84Z1dVM04vWEUzWW92?=
 =?utf-8?B?eFRVTm16clBZeUR6YXZySVQzTHlXK25HT1FHa0N5azhFTFY3Vm5IOEZ6b2Rx?=
 =?utf-8?B?ajB3dmtIaTVNTXNiQW00cmpNMFdMWXN6U0RLeXpzeGljR1hkNmhtQ2xIZ29T?=
 =?utf-8?B?LzRueVdMaTJQczBGc1V5OVd6TEtSYVdRQjJLdk8wZVVrS2VLa3U5Y2ZwMDNr?=
 =?utf-8?B?WUNUSXNoaDJMTXFoV3RXZTFvZjBiVjRzRFV4K0h0K0J0dmtSbjYzM2hWTUtj?=
 =?utf-8?B?TUIyZW5IYmJYbzFoL01iUlZUTE1LTkNFU3ZsZXBqdjB5UE1YRGhQV0NZSG82?=
 =?utf-8?B?MjhuNkNCWlhjdmpxZnFIR0x0aEtxNmlFZlFITTQ5aXJKRzFQTjdEOERvVUh0?=
 =?utf-8?B?TlBvdVR2eGNOYjYwMEZwclJHUC8vQ213T2kwWXZkNU5aV2NYM1B0Z0xtUXNO?=
 =?utf-8?B?cUlwMVdzZ00wWjY1QXphbTVLWlFxaVpOQnZ4YmZjVjExcWxGU1p2dnBBOGdH?=
 =?utf-8?B?NGRUUFhVNFRtVm13UC8wT0pSYXFJZXdzcGtYNE5QVGMvVmhqSDBPbFgxY210?=
 =?utf-8?B?TU9TUC9BcnBiZkQ1U1V2ZVNJNjdva0xQOTVIOERkRVNOUlVqQmppRTV1Y0pJ?=
 =?utf-8?B?L0pNYjhnUU1MOUR3T0tkN29KU3lIVjFtVVdlbE1xV1k1eFdUNDRiYytXS0hM?=
 =?utf-8?B?SWtvaVVMVkd2RUFGSzQ0c21QUGtTNkVWU1dBVldlSWY5Z0FlZlBiV3hyTmpZ?=
 =?utf-8?B?WU10ZnJlS1VjenFZVllJMDlTV2R5bitSREQ0b1ByRUljRmxXREhMRVNxRm5C?=
 =?utf-8?B?S3Z0M3VkeUMxMU9IL251WVpjNWc2MDJDcjlqd2NGSXJhUTY2WW1nV2lhZzR5?=
 =?utf-8?B?OUVQQjZxS2ZzQmxnMG5kK0V2c3FRL3pMN2dDSDBWS3hLaTZLUDBaRWNFczVF?=
 =?utf-8?B?Qk9WcEF6SmZZemR2dmk5NllWbHlqaENPT25HbEZ0TnVLWERkaVVGVFd6bFUy?=
 =?utf-8?B?bTVOdFdON1ZCazIwWEFQSmVQa1hkc2U5MEdnb1JMbGVEOXB1eVVkek95VWRt?=
 =?utf-8?B?NG9sVkVrUlU0anlKUTRPdVVmdUlBZDJyYXBhbG1pVlByMDVvdm5oMmFXVk9S?=
 =?utf-8?B?ektsN2FEbGZHVlpwL2pUSlp6WEFGNytZMVhZNklmWVJ2L282TUFZL1Z1Slpu?=
 =?utf-8?B?eXVoTTlvdksrQVA5dkY0VXBKNTZ4aGsxdXpVRWVpTVdwcC9NUlByL3JiSzI3?=
 =?utf-8?B?RHlxNVJsbWZ2YTZOVm4yNUF4eXNXT0ducTVUeEF4cFJZV1g4ZGFXZm1mSnZS?=
 =?utf-8?B?Qm5kZ2tlMkRRTTRKM2FnRTJNNjRRSEpxaS9naDJVdm1GREpWdFlGTlN0c3FN?=
 =?utf-8?B?MnVKT2xJdWp1dHl5eE1qcHFJZjdIdy9wL1huMFh3emdua1NZMUJ6QkRGUFN3?=
 =?utf-8?B?M1phYk9xVDB5aitxMmFteW8zcDF4dkxNbFdOVTdEWUtsUHlwem1RcElsNkJ4?=
 =?utf-8?B?UUFlOTRId0ZjVHZ2OThOeVUzVkRFQWZKMU9nS0gwWFVZSEc1eUwzOGFNR2lD?=
 =?utf-8?B?dTZjWFVWb0w3YzlUTUQzVTB3eEdwRWRNbHB3UDRMS2JCUTREa0lJL3pmOG9t?=
 =?utf-8?B?bmNuRVZZSFBHVnNseXU5b0tYb1Q1aGdiV1EwaXRSRFZuMjV2VGxxOWVTcjB2?=
 =?utf-8?Q?bTj9NrxqzqLuIe5OLuNTLX4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6916cc7-9490-4a0b-f47d-08dabe4e9ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 10:23:30.6418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fgDV25m1IJrN9zQkbAKrzybbrj0BZbraY9DyhH2wt5PKPiHB9Gx29TtT6tvBIPqSDgz8Yv1Y2F28ea8EcpbJbII6mlJoEe/yKmtdxQvTz+WCmzSZJmrc6LFY8UMfrvpQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IE1vbmRheSwgT2N0b2JlciAzLCAyMDIyIDI6NTcgUE0NCj4gVG86IEt1bWFyYXZlbCBUaGlh
Z2FyYWphbiAtIEkyMTQxNw0KPiA8S3VtYXJhdmVsLlRoaWFnYXJhamFuQG1pY3JvY2hpcC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgdHR5LW5leHQgMy8zXSA4MjUwOiBtaWNyb2NoaXA6
IHBjaTF4eHh4OiBBZGQgcG93ZXINCj4gbWFuYWdlbWVudCBmdW5jdGlvbnMgdG8gcXVhZC11YXJ0
IGRyaXZlci4NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlDQo+IGNvbnRlbnQgaXMgc2FmZQ0KPiAg
DQo+IElmIHlvdSBoYXZlIHNpbWlsYXJpdGllcyB3aXRoIDgyNTBfcGNpLCBwcm9iYWJseSB5b3Ug
bmVlZCB0byBzcGxpdCBpdCB0bw0KPiA4MjUwX3BjaWxpYi5jIGFuZCBzaGFyZS4gKFNlZSBob3cg
ODI1MF9kdyAvODI1MF9scHNzIGFyZSBkb25lIGluIHRoYXQNCj4gc2Vuc2UuKQ0KDQpIaSBBbmR5
LA0KQWxsIHRoZSBmdW5jdGlvbnMgdXNlZCBpbiA4MjUwX3BjaTF4eHh4LmMgIHRoYXQgaGF2ZSBz
aW1pbGFyaXR5IHdpdGggODI1MF9wY2kgdXNlIHJlZ2lzdGVycw0KdGhhdCBhcmUgc3BlY2lmaWMg
dG8gb3VyIElQLiAgVGhlIG9ubHkgZnVuY3Rpb24gdGhhdCBjYW4gYmUgbW92ZWQgdG8gY29tbW9u
IGxpYnJhcnkgaXMgdGhlIA0Kc2V0dXBfcG9ydC4gQnV0LCBmb3IgdGhhdCB0aGUgZmlyc3QgYXJn
dW1lbnQgb2Ygc2V0dXBfcG9ydCBtdXN0IGJlIGNoYW5nZWQgdG8gDQonc3RydWN0IHBjaV9kZXYg
KmRldicgKHByaXYtPmRldikuICBEbyB5b3Ugc3VnZ2VzdCBkb2luZyB0aGlzPw0KDQpUaGFua3Ms
DQpUaGFydW4gS3VtYXIgUA0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E47410BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjF1MHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:07:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47787 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1MHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687954022; x=1719490022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VxTATcz/xDvtvd1M0IeLkWaax3o5uk8C4fsyBplLJPc=;
  b=VQJk25wPyXy8L/ChfqQGCsG0JbsxbDeDhgD2uAzINvtX8RmRiTgDN0AJ
   Bao7oh6F+yaBtuMr/DTBV079MqTS0/W4yesPNJuvWxGpwqnJ8N1jaAWjM
   lVWFVvCh7uNr8VPm1MnxeDwjkcOeb6uv3FwsiflJPB6lBSakHjS4Xr7y8
   kKEu2rsV/5zJuaE7lVXVy6uZl9ZJzs1rTJe51xY2iBohi5xRPZxDEtg/Z
   REmr5VpxCprRXwJKP9PUc+OPuVx8+DaQC68cEl+ujZY/mEF85L+3KnQMP
   s7/EJy9ZrkhptrK0TUbasbTiLL53VsVplUwF+CxnLtWtKmriX2/ZqbsdO
   w==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684771200"; 
   d="scan'208";a="237075038"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2023 20:07:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeyZa5bMekMnkV0AOxhn4YN+xmzS6CczSyRLYxJNwcH/PbNzxgfeR/qdciZDlLcvgoflT6xWGuCY2BsnH8D4qq7V5lj8operZFRhrwPjUJ4AsljRQdG1kQMiUa/g6yfDrZXQ1aLXVsey9LaFAzMPRGqQgzCdfBoYs82nVtAVWmEeK96LrFclfOALQR9xOFF1L+lXAa7+7JY1/D3YE1A9Ad/qMmsvuWEcvBVm3iWrCHB8IZZTYGVwtg5h4kUT9C+P7xi3UgwKZdakyj/+BZW/W8WEXMuyeKj/h1Ed7mWdFKNMycBoOcAB5lTqufG6HIyxsF4+aF3MAPSW0wNki2S2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxTATcz/xDvtvd1M0IeLkWaax3o5uk8C4fsyBplLJPc=;
 b=FAXQnEVs7y+/YfBPw6GwoTjllc8CtEfF1k8FScTqzHN6+UWO6zxzarmccEzQ0AtlZSpAtyvW+c9Nb1eAJbWPXnWLxBR4egcHTsT5UOqGPQjNtp2B8sbHw3lzdAJM4n53FyrSA2Wf4yJo7lFZKd0yOw/LYBvZYDddS5TbxWWSN6jIIml++syQKggukFXlrr/nHTOTBXKPaj6UC3Y0DHTB6uwi51sev0QN2Vmky/S4iEV3xCdPKY7Z2b8KovpXjS28Tsypmtfs6nYkNi2wefEWVXJMdHFElXjP3eH9aGPQ8CTtOp2jGQewfytxKDm4hICwlRTMogD3C9LhajovQK6dLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxTATcz/xDvtvd1M0IeLkWaax3o5uk8C4fsyBplLJPc=;
 b=ZUUajf4i7+kWl1Pfs8QbxQVBbKSOS4eS1sG42/2mR+xT5suM3oObVr+o1OHaTBMZOQQ1CC0byK4JOEgVV0LVXmKg5Pi+dRebZtSVrNopUCmchC7gRly3jbBMq94ep1c2sfmgi2fZUE9W6Mxk0WEF3MVxlDHiHKl5zbzWu5hawjU=
Received: from BN8PR04MB6417.namprd04.prod.outlook.com (2603:10b6:408:d9::23)
 by CYYPR04MB8790.namprd04.prod.outlook.com (2603:10b6:930:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 28 Jun
 2023 12:06:59 +0000
Received: from BN8PR04MB6417.namprd04.prod.outlook.com
 ([fe80::9b77:81ec:d24:5cb9]) by BN8PR04MB6417.namprd04.prod.outlook.com
 ([fe80::9b77:81ec:d24:5cb9%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 12:06:59 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] block: ublk: enable zoned storage support
Thread-Topic: [PATCH v3] block: ublk: enable zoned storage support
Thread-Index: AQHZWBd1sDAZTvUQO0y46n8WBFABra7+u2iAgKICQQCAAAEKMA==
Date:   Wed, 28 Jun 2023 12:06:59 +0000
Message-ID: <BN8PR04MB6417B762EA748C0117D6EACCF124A@BN8PR04MB6417.namprd04.prod.outlook.com>
References: <20230316145539.300523-1-nmi@metaspace.dk>
 <ZBQ3sgoN8oX5HXOJ@x1-carbon> <87edlvhkfe.fsf@metaspace.dk>
In-Reply-To: <87edlvhkfe.fsf@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR04MB6417:EE_|CYYPR04MB8790:EE_
x-ms-office365-filtering-correlation-id: 3eda8c9a-7178-4949-c4cf-08db77d02cfc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeIDldRAMxHtGg08allZwlx9CdqQjh+9p5yz2lnW5JH/ykHEeyFNu0cCzVoVb04T0Ep5IROIBhbCKsxHHaicfiKI1vkTJMxj2FhpKam7ZrfDjgZU/+FjJoRZgPB07gOSpYL2ctPbMafmBNN0nqPnP6rdLJkBMVpkv3R9QYJfuYLCflCAwlVrhpQn3IKUH3MWPbxwhzJmOl/8wwb7MXbkaFXoepvuNqZzYlcTWvmdQT2c6/3P54hybfu9fVALk/MYBTYl1nlarzQKu95r4uI6+xZ7Qv7I9W7XCuHQnyLtosdsIvgS6eXdlCBhg0BMsvRXiwZgvKDQXHgXzR40w19sM+kDFP1cdi1wawJ3TX+Vytkq/9W0Jmnr14FTi5Z8lmD/M/DWxOAluvrGIOFc9accNj58o5skpX0YDxgYwaUGGQpNKLqkOoT/hsby44Gqac29DXZqg9smOQltb6yzHk8BtHF8XBhuiSARxwEm5XG16oemwYHoEMO8Cg/FCbYDiOPRQmYqFzYvB1oAyzxC/L9RhsIx/SJh1DnDLnCPZaGq5Ypz49vG/6xvmmwOJC/b+iqFd/o/OF36x5dT5ztaZY6TJl+yoG2XI+Y56yjOsdT6sDeGtweUiisB3VEmFxHB6aMP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR04MB6417.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(66574015)(83380400001)(8936002)(52536014)(316002)(7696005)(71200400001)(110136005)(8676002)(54906003)(6636002)(4326008)(41300700001)(85182001)(33656002)(85202003)(55016003)(122000001)(86362001)(82960400001)(38100700002)(64756008)(9686003)(5660300002)(66946007)(66556008)(66446008)(66476007)(478600001)(2906002)(186003)(26005)(76116006)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBsS3Z3RFNlanZLVVhPNHNibE5UZlQ5Y082VUNLYXhCU25FWE1DdlZVTFA3?=
 =?utf-8?B?SUhyQ2lEMWRtU3I2cEhzcURYdTh3b3o0YzVjZGt0Y1l6Vmo2VFB6ZzNOUVpC?=
 =?utf-8?B?b05XcE0wMDZzVGN4SWxJVGJJY0xwMStOWE5XazhJVFBYZlZ3U1VFN1ZKSWha?=
 =?utf-8?B?VjhpSC8xaHM2aXBrY3puZlpLZXl3emUxSGM3cVczQnhyYXphcUhsWjUzKzVj?=
 =?utf-8?B?NmJQYVFQMVppOUlhWkdVV3I2b2RmdEprU3pwVHMzaENJR2dwSHNzdnJzclBI?=
 =?utf-8?B?QW5seGVBT1MvQkxIYVZTMVFrRW0zSG5qSjBDb3RsUzNBN3FXNnoxVHlMY2R4?=
 =?utf-8?B?N0htS3VCelhXLzdhb0E2VUxuYkR4QjVkZ1EyM1p1MnJYRWV2Ky9xQ1lYbHM0?=
 =?utf-8?B?Qm9BY3BFTlg4cVdNNmROWHRjZjZUVlBOOVNoYk9mYTlXaE9iUlNRbExsdGcv?=
 =?utf-8?B?ek9kbmg3cXVmQndCa1pCdU12UCtzSU4va3JHeTFySFExMUlhSHE0clZSNkRu?=
 =?utf-8?B?WFBiUkFEM3ZEbFBKMmFQUWsvcGk2Ym1IVDY4dENiWjN4ZHh3L2RDZ25XejRT?=
 =?utf-8?B?QjFlbXZhS012dU05QjE2ZEovajltRGdIWGR5RHR0ajVFYlZDVVZQNXJ3bDZW?=
 =?utf-8?B?VXdETFUxdzgwUWFDaXZyOEY2RGlkakVHWm1Bd20rNWF3WU1PMWE0S3A0dzA2?=
 =?utf-8?B?NjVPNGU2eVBxaGhBVVMrU29rSWIxTVR0RzAvTFBDY2hlYmt5N2haWlVoU25k?=
 =?utf-8?B?YXZDTzZCL3hFUllMKzRnNnpGVnJKWFo3N2FaQXYzVzNibnE5RXJGcTlHTHlF?=
 =?utf-8?B?NUF4b2VENnI3SXVJL3lIVjBudmRzZzFHRHJvRjJDNnQrMVVkYkpsdTRPaXI5?=
 =?utf-8?B?ZDlXQjRaZGcrOWl4ZHdYaWxEaTBvRjl6eTluTVczS2FiS1BVNlpaK3ZXOXA4?=
 =?utf-8?B?dEFEeXlXTERnSVhsSFpvMDFDUkhYZmg5b0labDF6aUltVy9mdUhBWnlSekpL?=
 =?utf-8?B?VjUyVXN1ekcrRUovU2hqdE9xU2hCTWtXdmQ2Ny9sajJIZlVuaWF2V0d2T2pW?=
 =?utf-8?B?ZGtLU01sbEVIWnZVZTNrcGkzL1ZzZzAvQVh1M2Z5WXM0WVAwMUtwNzJaUTlr?=
 =?utf-8?B?TFFYMXkwU1Rjbk5VQklwTE5IRWJFMDVoWXBYR0JFWkNpeHE0ampEUGhmaDhp?=
 =?utf-8?B?Ym1TMGl6THgxZmJCOUlDdkZlSEQ2cEZjY29KTXduMUI3cWhXNTBpc3pOMmIv?=
 =?utf-8?B?a0grb1JPYjhQU1hJVmIzcHJBeTAxa0NST3Nxc3pqdExzM3M0NXkrQTJRL2Zn?=
 =?utf-8?B?clBDdG1HWTM3MzY2RUEyd0FZWnZyQjB0Y2NyLzhzS0ZUQzQzdm1Gazhxc2xF?=
 =?utf-8?B?VkpZZ0FFLzh2NFRGaHZOQkF6Q3JxT0NQY1RVdkJyUVpMRXFGaFcxQU10cGMx?=
 =?utf-8?B?TVFzckxqRjArMGg2bzZHVlR6c3ZRZEF1ZGFGU3daQkZlNm9tSVYvVlNweE9U?=
 =?utf-8?B?SjJ1SmhZVzcrSHU1ZDFRVFJ5ZnlLYnZlL2dxQkl2N0JGSnFXZWY3ZE9ZWVFm?=
 =?utf-8?B?RDFhRDdISGsxTUpseEx2enlEdFhrZFFML3dVU0pLVzRQa0hudVJOazF5aEM1?=
 =?utf-8?B?NTgxa1RRZTJoT0RWdWJOWFdPVE1tZDZ5K3VJejRMUWNlQmdSWFBML2Zxc0Jj?=
 =?utf-8?B?Qm5Bd05tOVJnY3NoUjRJM3k3dDd1RHRtUk8wMVpVSjdranZkb0E5WWVvMkZ2?=
 =?utf-8?B?V3JURDFLYU8zb1ZaQ1NlejZ2Q0RWZ25RdkhZYmYwaFlxNkwvd2dxa2RxakFz?=
 =?utf-8?B?YVZxVmJuOW9IbWRIZk5ZQzBIS3A4TVFDU0NyQVVPcXIwRVBUUXlzOVIwOXBv?=
 =?utf-8?B?WWo2STZ6a3dWN0pNQXhNdk5WVXR6YnF6RFVrWnVnVnFaalFxdWtuY2VRTnBt?=
 =?utf-8?B?TEdZSVBXem1EejRDYm15Nm1wWVZMN3NLRUg3cXdYMlFpYlNQSUw0RTVJeWhs?=
 =?utf-8?B?WjVQeUk0N3ZtNkRGUlROVURCdjk5WnJONmpWc3hYVTJSVC9IY1RwenZOcnNN?=
 =?utf-8?B?NmtuMS9yTjNKUTRJNm1lbnpNK05qMXdYVGU3am5GMWE0WEJ4bVUxbzdsRnd3?=
 =?utf-8?Q?sM0TgJm2vsrIM61bg9j5KkvVj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ls4OnaItSm6AtMs0pyMuqWvuELNO1FSCw6NTeRdzAmAoolkL6lFL022hxvLw6/9+qURs+lyp9ZHCto1esywPmzdIgvioddiVGrTLo/oQCpwlLTYQYtife9KmyUDkdSPpxvCBgpgG8JWQGkxZAZw2Aj0IzYwoDKLM4fK/XXmyIgKPJsuakQxc+zZxN4mdt/xVfloCymxh2FGQ4nOFtyAHe/b6DmqSOevLwB9HK3QIJmSGsQfx7br9Mk5JMDp6LRsSzYs2yF5++lyKWraIySIBN9B3+W8SCyxHbuifx0FtbU/9gG9H7HYvuJwdkgYkfWBE84i9jc8X3DdacnHhUcoNb0TIitEX8pmo6xWJBnaXsVyNH07oUjCOJjAsZRdTzDfaQNTujVaGf86aOycCeGgrezLrrNlJUTZQnsmzESyzReGPbcVz67o9c5XK9/LArnDWoSjlF8Vr06mVVO4p6Nki6v9uY7gkzFFm8q9nHePhaBJDNHT7Xm4b+Zr4WV/bskQSeBzgxa65XunWqwA3FnR2GGNjWyxweizd98YW5rxdiSMgM/UZMS3kTb2jjKVCz6Kw6yUYcTHEjVK+ErerNO9+mke18RJt8AbGqkhkYL1VJnqnfMfQwSmbagSMezcF4zbY8RXdfcdlTUoeFNL7oNH9awXepPhuc7XVrm/kgYicuwtFeFUO6fbZ9U/6ItbfDu2WJzaCggn5In8/f/kvTBrBf+ANRAlskQjUPhtfKYs+oCc+oCqo7NlAQnzi292iAiVmducrAS2hzZ3MtQNNfSTuY5fUiPRcYxO6HwrkRvPGo0BNR4gmMdBk8vLdOtt4dhjlF5VzZYJRHQO/iUI61yOYDoh/y7+Mi7NdQNgaAeKNjcm3DWCBF3zHoEaWNCwXenrqDqT1S+Fq2Eop1YBq2zvh3A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR04MB6417.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eda8c9a-7178-4949-c4cf-08db77d02cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 12:06:59.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUbZBA1O3yymHPnLBG6S44F+pGll2dfh4I6P01HdUdlkDeAuabkETlcVpAhRVf5vVKDi0CeeMPdSe+Q5ovu2Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZWFzIEhpbmRib3JnIChT
YW1zdW5nKSA8bm1pQG1ldGFzcGFjZS5kaz4NCj4gU2VudDogV2VkbmVzZGF5LCAyOCBKdW5lIDIw
MjMgMTMuNTINCj4gVG86IE5pa2xhcyBDYXNzZWwgPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT4NCj4g
Q2M6IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgSGFucyBIb2xtYmVyZyA8SGFucy5Ib2xt
YmVyZ0B3ZGMuY29tPjsNCj4gTWF0aWFzIEJqw7hybGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5j
b20+OyBNaW53b28gSW0NCj4gPG1pbndvby5pbS5kZXZAZ21haWwuY29tPjsgRGFtaWVuIExlIE1v
YWwNCj4gPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPjsgSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPjsNCj4gTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+OyBvcGVuIGxp
c3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djNdIGJsb2NrOiB1YmxrOiBlbmFibGUgem9uZWQgc3RvcmFnZSBzdXBwb3J0DQo+IA0KPiANCj4g
TmlrbGFzIENhc3NlbCA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPiB3cml0ZXM6DQo+IA0KPiA+IE9u
IFRodSwgTWFyIDE2LCAyMDIzIGF0IDAzOjU1OjM4UE0gKzAxMDAsIEFuZHJlYXMgSGluZGJvcmcg
d3JvdGU6DQo+ID4+IEZyb206IEFuZHJlYXMgSGluZGJvcmcgPGEuaGluZGJvcmdAc2Ftc3VuZy5j
b20+DQo+ID4NCj4gPiBIZWxsbyBBbmRyZWFzLA0KPiA+DQo+ID4NCj4gPiBJIHRoaW5rIHRoYXQg
dGhpcyBwYXRjaCBpcyBzdGFydGluZyB0byBsb29rIHZlcnkgbmljZSENCj4gDQo+IFRoYW5rcyEN
Cj4gDQo+ID4NCj4gPg0KPiA8c25pcD4NCj4gPj4gKw0KPiA+PiAraW50IHVibGtfcmVwb3J0X3pv
bmVzKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzZWN0b3JfdCBzZWN0b3IsDQo+ID4+ICsJCSAgICAg
IHVuc2lnbmVkIGludCBucl96b25lcywgcmVwb3J0X3pvbmVzX2NiIGNiLCB2b2lkICpkYXRhKSB7
DQo+ID4+ICsJdW5zaWduZWQgaW50IGRvbmVfem9uZXMgPSAwOw0KPiA+PiArCXN0cnVjdCB1Ymxr
X2RldmljZSAqdWIgPSBkaXNrLT5wcml2YXRlX2RhdGE7DQo+ID4+ICsJdW5zaWduZWQgaW50IHpv
bmVfc2l6ZV9zZWN0b3JzID0gZGlzay0+cXVldWUtPmxpbWl0cy5jaHVua19zZWN0b3JzOw0KPiA+
PiArCXVuc2lnbmVkIGludCBmaXJzdF96b25lID0gc2VjdG9yID4+IGlsb2cyKHpvbmVfc2l6ZV9z
ZWN0b3JzKTsNCj4gPj4gKwlzdHJ1Y3QgYmxrX3pvbmUgKmJ1ZmZlcjsNCj4gPj4gKwlzaXplX3Qg
YnVmZmVyX2xlbmd0aDsNCj4gPj4gKwl1bnNpZ25lZCBpbnQgbWF4X3pvbmVzX3Blcl9yZXF1ZXN0
Ow0KPiA+DQo+ID4gTml0OiBJIHdvdWxkIHNvcnQgdGhlIHZhcmlhYmxlcyBkaWZmZXJlbnRseS4N
Cj4gPg0KPiA+IFBlcmhhcHM6DQo+ID4+ICsJc3RydWN0IHVibGtfZGV2aWNlICp1YiA9IGRpc2st
PnByaXZhdGVfZGF0YTsNCj4gPj4gKwl1bnNpZ25lZCBpbnQgem9uZV9zaXplX3NlY3RvcnMgPSBk
aXNrLT5xdWV1ZS0+bGltaXRzLmNodW5rX3NlY3RvcnM7DQo+ID4+ICsJdW5zaWduZWQgaW50IGZp
cnN0X3pvbmUgPSBzZWN0b3IgPj4gaWxvZzIoem9uZV9zaXplX3NlY3RvcnMpOw0KPiA+PiArCXVu
c2lnbmVkIGludCBkb25lX3pvbmVzID0gMDsNCj4gPj4gKwl1bnNpZ25lZCBpbnQgbWF4X3pvbmVz
X3Blcl9yZXF1ZXN0Ow0KPiA+PiArCXN0cnVjdCBibGtfem9uZSAqYnVmZmVyOw0KPiA+PiArCXNp
emVfdCBidWZmZXJfbGVuZ3RoOw0KPiA+DQo+IA0KPiBDYW4gSSBhc2sgd2hhdCBpcyB0aGUgcmVh
c29uaW5nIGJlaGluZCB0aGlzPyBJIHRoaW5rIHRoZXkgd2F5IHlvdSBwcm9wb3NlIGxvb2tzDQo+
IGJldHRlciwgYnV0IGFyZSB0aGVyZSBhbnkgcnVsZXMgb25lIGNhbiBmb2xsb3cgZm9yIHRoaXM/
DQoNClRoZXJlIGFyZW4ndCBtYW55IGhhcmQgcnVsZXMgdG8gbXkga25vd2xlZGdlLiBPbmUgcnVs
ZSBvZiB0aHVtYiwgd2hpY2ggSSB1c2UsIGlzIHRvIGdyb3VwIHZhcmlhYmxlcyBvZiB0aGUgc2Ft
ZSBkYXRhIHR5cGUuIEFub3RoZXIgb25lLCBJIHBlcnNvbmFsbHkgcHJlZmVyIGhhdmluZyB0aGUg
Y29tcGxleCBkYXRhIHN0cnVjdHVyZXMgZmlyc3QsIGZvbGxvd2VkIGJ5IHRoZSBzaW1wbGUgZGF0
YSB0eXBlcyBhdCB0aGUgZW5kLiBIb3dldmVyLCBpdCBpc24ndCB0aGF0IGVhc3ksIGFzIEkgdXN1
YWxseSBhbHNvIHRha2UgdGhlIGNvZGUgZmxvdyBvZiB0aGUgZnVuY3Rpb24gaW50byBhY2NvdW50
LCBzdWNoIHRoYXQgdGhlIGRhdGEgc3RydWN0dXJlcyB0aGF0IGFyZSB1c2VkIHRvZ2V0aGVyIGFy
ZSBhbHNvIGRlY2xhcmVkIHRvZ2V0aGVyIGFuZCBmb2xsb3dzIHRoZSBmbG93IG9mIHRoZSBjb2Rl
IChpZiBpdCBpcyBnZXR0aW5nIHRvbyBjb21wbGV4LCBpdHMgcHJvYmFibHkgYmVjYXVzZSB0aGUg
ZnVuY3Rpb24gbmVlZHMgdG8gYmUgc3BsaXQpLiBGaW5hbGx5LCBpdCBhbHdheXMgaGVscHMga2Vl
cGluZyB0aGluZ3MgYXMgc2ltcGxlIGFzIHBvc3NpYmxlLiANCg0KT3RoZXIgc3VnZ2VzdGlvbnMg
bWlnaHQgYmUgdG8gbG9vayBhdCBleGlzdGluZyBjb2RlIGFuZCBnZXQgYSBmZWVsIGZvciBob3cg
b3RoZXIgc3RydWN0dXJlcyBpdC4gSSd2ZSBmb3VuZCBDb2RlIENvbXBsZXRlIGJ5IFN0ZXZlIE1j
Q29ubmVsbCBhIGNsYXNzaWMgb24gbWFpbnRhaW5pbmcgZ29vZCBjb2RlIHN0eWxlLiBPYnZpb3Vz
bHksIGVhY2ggYWR2aWNlIGluIHRoZSBib29rIHNob3VsZCBiZSB3ZWlnaHRlZCB0b3dhcmRzIGhv
dyBpdHMgdHlwaWNhbGx5IGRvbmUgaW4gdGhlIGtlcm5lbC4NCg0KPiANCj4gQmVzdCByZWdhcmRz
DQo+IEFuZHJlYXMNCg==

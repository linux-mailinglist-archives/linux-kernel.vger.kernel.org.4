Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAEC611163
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJ1Mal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1Mah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:30:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB107434B;
        Fri, 28 Oct 2022 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666960235; x=1698496235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fA4D1ztO2JkfQFw2BoKCsxcSnU4Hq5Tn94aQlXkTBb0=;
  b=WTsFYipwCNFLJCDOsubSVigPdSgcrCxByAQ1aGilnu1QKvlwFYbYZUJd
   rBo+B6CZrOW9YM11wcPYb92rbAQGqC+exl8YPCJksN+LguuljRtr61S/2
   rZoFr4zW7j48OhsO84PemI9Uwu84JRQMirpfvV23+ly8vFIftN9Hj1OcQ
   H3xBaMBACEscO0K3rswoqMzmz3Ojbvn3xUGx9euTPkEig5nZMzMH2b0Tc
   ddU35O5lMSYNEbI0T39/DtRhnq0tIkP8P13n25QuOk1uU5fGl226tDUmR
   T4qa9hTUjDtwMWbyu/bqiTUmK2M2LssGBUnnAP4EXdfxxggzgLuRWJ5T5
   A==;
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="120791913"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2022 05:30:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 28 Oct 2022 05:30:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 28 Oct 2022 05:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4ZqofXDbbu/KIuB5ECgDa2xiAaQ/SWBDVs14jrqCn1UJ4PGQx6iVo7PI2qF0d2EhsRnZnbz2KnbDJ9Cfy3LFipdhQdfYWUQ41MTmCxOaO6C7gwIt5Ur0H/ED3fZQ/6fPUGzqYV+OwDZrHWCigcHi7VTLmWkmoKLYC1en3pdb4ZXmJemBJ6HSYqtPaitfFK4x7rL6DXstt4xOU5N2/4CigLOARhdzodhxJASbod5umTPTmW0sjx6n2qFZP/A1RkZ15W7PqmxQfP/0l5XnA9C+8aoLF8URLbmq1UmCCwF+AmtkQdSn2F+dEV1XM69J24GE37lMbRX7ovGXfur/zDCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA4D1ztO2JkfQFw2BoKCsxcSnU4Hq5Tn94aQlXkTBb0=;
 b=XpfyV+2Wnrb8vcK22xjTAvG4F49SEMymRfyKnVVMyUtnNiLX8jnlJJ3oCd25EQMeMyJeVNsK29arKywy7L8DD1QXe7Q146ekDpTRvun9eywlMIS2BWqa5j0gsW+caU5OwYeUirqZamGKFsEwU6/Pzk5Hlf/eT1jx1uE7gMpTCAUVpvOQmezxJuysFkQlfm6Ia4MAqHaCrf/Tj5Lb2jjz2yY/mipbcoK4dylIVDDxiisZ3wo4ft+XffO34NbYRcMDHo4DMnUA8HyvHVYkntpxh+hZxiu83f3/mHsX4kFclY/iXhtOpDHB2E28m/xH9CzKFLKmSBmRxgRaUd+5K3Rp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA4D1ztO2JkfQFw2BoKCsxcSnU4Hq5Tn94aQlXkTBb0=;
 b=q1et+Z9wmufRf2RqV/+EoDdDdNKzhoeyPi3RZJMr1mGvD/HEECHbu1X+SYrdm+XPr1dTOzBsAfwZlVi+nzTV7Wke0PjI/OL0sk1b/CEv8ATsOo1CreJO13goOs/Qq0mfJcphX3rRZdVBMekbYhSk0yBAVmZu0kvFECuGmgQW1sU=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 28 Oct
 2022 12:30:24 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::1b9f:d534:5b73:892f]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::1b9f:d534:5b73:892f%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 12:30:24 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: RE: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error
 information
Thread-Topic: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error
 information
Thread-Index: AQHY5X8sNi3OCqQh10eu9hrgsxOmFK4jw9Eg
Date:   Fri, 28 Oct 2022 12:30:24 +0000
Message-ID: <MN2PR11MB3645681EA68D746AD5455DBF88329@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
In-Reply-To: <20221021185615.605233-1-terry.bowman@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3645:EE_|SA1PR11MB5945:EE_
x-ms-office365-filtering-correlation-id: bcac2be4-dccf-4544-4c15-08dab8e0304c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6M+eiVXYKtrIh43fCZ73VKHeS5Uz73y0eTASInCadFveBfH9gYyAJoLZ9OUJhSS5olOhdyY8YpaxFHspH6hrfuDbEF8+7KfxUCqZyvcza1Bwd/5678OnhfRs54CmP218J7iiJSvV7sZea9gsStVrUVV+bqTwIjnTBYOvDLf0d7VZk+3ymzLjntW63pMAktWgae1ATAzdjXlWOfB+3YBuwDw0hTqa2DtlycP3OPtDNHJ7lcehCXTWxNHvwngGoEXjui5v2gFr5csj2mzpuJSudqw1Jy3NglBC1GxAfO/CeRLv8HK68tmmLPPph/ZLGAZuo5O9MNnkk1qKJbDEs6t6LZtS5hUOz0mzP37dCjWuZJMoDIYeziGpKSaF75Buhg93HTXNtAyH8O7MrzHRVPyP4eEOVEDg/tAbEOVicXw+uXxl0vn0RIdR2QdX3AaQUJu2W7vNrAY0KcRerimllAmqiYimH+a62a9LTAxjYrPy7d0dqQ6Fw/ibhh9y0YHliKpz/DLX+TZfRSTegzRB98xngIlsYASC0JgIAX8Zp9wZRYhOds7BfMn3RFQPe9DxyDCyN0ia5j0aqr3QXSZ89bwdO0h+O81uA2XYUxt6vQxXMIz7MJm21YM8dqet6C2CxAJm/7Px11Yv2KVj0naYkRshxXYaw1HCkUK8c6KiTPcQIH50hDeHQ/iOtCuGS5uJAQOensneUf+306xSXsK1dQaLH93GE1of+6ERsPddjdLBV0JU/XV7hzyOguOta9JvuHjG+ptPom25yg4TkOKEd/v+rsaNoQzzfGYhP+892Dlif+Kepnt3ht4fo0CSkWsyfjE8/4ywfRwHs7252HqSl9TwZnymT/GdckQpRHK7nr7ZYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(8936002)(71200400001)(7416002)(38070700005)(2906002)(966005)(186003)(478600001)(55016003)(316002)(110136005)(54906003)(83380400001)(66556008)(7696005)(8676002)(33656002)(66446008)(4326008)(6506007)(53546011)(66946007)(64756008)(76116006)(66476007)(86362001)(52536014)(5660300002)(9686003)(26005)(41300700001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThrUk9LTzlDZmZ4S0wyaHdFd2QxUmtRbjZ0dlk2ZmpISnpoWmhOOTM1ZVoz?=
 =?utf-8?B?aTVuSVorb0kzV2MxbUVlV0xtUDdrT0kwOVBBYURrUWdsa0lGVTdISnZWRmV5?=
 =?utf-8?B?VmNvSlhVRXJuVDRCajM0QXhEMzR2dExEV2dwUWtLakFTNDNIUkNmeU5iR1VD?=
 =?utf-8?B?ZFNRZFU0Tmpua3g5UitxMjBjTlFKYTd4YXJSbjZjSm9Gd21KcnNyMWpsa2Qx?=
 =?utf-8?B?VmtvWUhzWlgzWmc2WHJEWmZXOHR1WVVaRkhKY2ZTb25CcTlZelFaVms3ZmVm?=
 =?utf-8?B?VW1rMGQ2VWNwUkxoWjBnUUZlT0VwcG5hR29BZjJyeUREbHNCMjJzaDk5bTh4?=
 =?utf-8?B?d0U5ZFB0cXpUTndJK3JGY3RZcjVEaU84b2FrdXVkR2I3bmVNTFp0OWxnWHFM?=
 =?utf-8?B?eFlwZVAvWGJEU3Fkb3lwM3AyWUpFZWxidFNtL2FvS1hpMWxIWGpjVmlVL3Q4?=
 =?utf-8?B?WGVwTXJzRThvcTE3VUFpeDdTbWdXeGc2b3pXa0huTjc0d1VkTHlYYnc2MUJU?=
 =?utf-8?B?QU1jeG8wb2Uwd3I2M2Z1U2RmdHpyK2MxNmdJVjVsZmZaNXMxU3V3NDZpL2dI?=
 =?utf-8?B?bjBnQjdMZVZ1OGxzQmJPSm1hc2hTWk9DT0ZhRHNEUHk4aGlNczFmZnRGU1Bl?=
 =?utf-8?B?c0ZlZ1MwWnhuVVdqcmJWSm0zL2hJV3dFa1BlV0YvMG5LMnFPTUNwTW03U25x?=
 =?utf-8?B?cUIwanJIT01aUUZ2eEdoZjUyWDlHZ3dCSFdaVmcxclB1ZFBhTHlnRXFFL21U?=
 =?utf-8?B?ZHQzL0liQjlhU055S3FqbXU4a01HR3UrTEZmQWY3OWJnVnZKcTd1czR0UTRQ?=
 =?utf-8?B?bnAyS3VQRjdpWWVwb0pHdjNrYnBmM2RQZDV3QkRiMjRnZkhBVDhUL3pKYUFK?=
 =?utf-8?B?bW9SaHlEVHNVK09KaDNlc0d3MWR3Nk1WcCsrWDNReU9TRjZWOXBFWXhiMnM2?=
 =?utf-8?B?WlFkUHQrL05XTmh3OU1HbGl2SURyd2JGWkRkZXA3S0hXYzNNYzJuQnhEQXJ3?=
 =?utf-8?B?Sk5Fc1J6MEVOcTlmaGRGSU9GbWhkajZRSUh3LzJKYWZ0eGtqTEFJTk4zWTN4?=
 =?utf-8?B?UkpndG1xZ3EzbW5ocVo2eHh2SitFQ293TGhtNG5RRWdlcGt0Z2RManRrV0Jl?=
 =?utf-8?B?clBGSlV4R0FUdzV6S3lmZGROZlFqTjc2bW43SUhvTWtmNk4yWGorWTNJc2s4?=
 =?utf-8?B?bWtTdUpFeWVORWh2cFVBWDRWaU1IUGJzYWdUQ0lsVWcyQmladVpnQktBK0NW?=
 =?utf-8?B?QUtsWit2VWxST2ZoQVVDRVRYa1dGdjdhZnVxMityUnlQMmxIZVB5bG9rMldE?=
 =?utf-8?B?N1dzK0ZrNjJCbTdLVVN6bWpUenlBbHd3S0dpNUNCczBUOHZ5bFJ2ZnBRc3ls?=
 =?utf-8?B?Y2RFWTNiZldzUCt6ajhROUc2Nk5xeEY4L2QyeVdDZUxtUE5OeWtiU1FqRU1H?=
 =?utf-8?B?NndSWUNOS3JNcUxEbTFZWVBuNFBjYStpS2lPV0VKWDV6a1NFUU5MV2Yrell6?=
 =?utf-8?B?MGdmWXkwVENrTUl3RnlVd20wcW5BU3k4YmZzV1BJSnhZQ214R1pCa3ZaRUJT?=
 =?utf-8?B?ejZoWmVjQWUwYitYOEdqOFFGRzdrRDBsWkg2bTJIZGpNY0YwYjdLakRFZzNl?=
 =?utf-8?B?eEZJOG5lWUxWZEtJcEZ2Mk9jQzRpUEo3OTRtWWh6V21UUVhtei9XQ2VVYlFi?=
 =?utf-8?B?akxjQVVISnNjTnlQeENCR3VIczNjOW1sY2gwZU53bXlqN3IrRjVRSmpGWk1s?=
 =?utf-8?B?KzZPQzROcXdUUTRESmJlVGN2dGdZVmV2U2RsR1lQTXpXM0dzeEU4UEIvcGtR?=
 =?utf-8?B?d2RkYVExd2dPeEZiQVZFakdiRENZTnFvWVY1SEZsOFJkOHgydEpadlZMMXF0?=
 =?utf-8?B?bFRHOHNlOUR0anVadENqanQ5bVZBL2NvazlWMTV4a0N0OXNIejhqcEdLTVVr?=
 =?utf-8?B?ME1paWtGVGxqYngra3NuYXptTC9YL0xIeDZJZHplKzR1SlJGS2tOajY4cDhx?=
 =?utf-8?B?dE5uME1sVUU3NWI1cUE1MnVieFlDMkZlMSt6TnVZR0wvLy9SQ3lwK0ZLTGZK?=
 =?utf-8?B?aWNiUk9pQ3QwcEN5UjQxZkMrdm1YeGgrSFlrMllaWkxqVlRJN1dDbGovL1Z4?=
 =?utf-8?Q?5/zb0fG/9KiizDKBBPJN9CqyR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcac2be4-dccf-4544-4c15-08dab8e0304c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 12:30:24.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhrqZaFxjN/a+5kjeC4Cr2GWiFs2jKMMVy9kdqMzi03QKKnv2qT92mM3UHJtKjR/z9ZIVFETkvxTGJmntY1mIXUJAwpcykm5PR5pMgAHfUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUZXJyeSBCb3dtYW4gPHRlcnJ5
LmJvd21hbkBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjEsIDIwMjIgMzo1NiBQ
TQ0KPiBUbzogYWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hhbC5sLnZlcm1hQGludGVs
LmNvbTsgZGF2ZS5qaWFuZ0BpbnRlbC5jb207IGlyYS53ZWlueUBpbnRlbC5jb207DQo+IGJ3aWRh
d3NrQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbQ0KPiBDYzogdGVycnkuYm93
bWFuQGFtZC5jb207IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHJhZmFlbEBrZXJuZWwub3JnOyBs
ZW5iQGtlcm5lbC5vcmc7IEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbTsgZGF2ZUBzdGdvbGFi
cy5uZXQ7IHJyaWNodGVyQGFtZC5jb20NCj4gU3ViamVjdDogW1BBVENIIDAvNV0gY3hsOiBMb2cg
ZG93bnBvcnQgUENJZSBBRVIgYW5kIENYTCBSQVMgZXJyb3IgaW5mb3JtYXRpb24NCj4gDQo+IFRo
aXMgcGF0Y2hzZXQgYWRkcyBDWEwgZG93bnBvcnQgUENJIEFFUiBhbmQgQ1hMIFJBUyBsb2dnaW5n
IHRvIHRoZSBDWEwNCj4gZXJyb3IgaGFuZGxpbmcuIFRoaXMgaXMgbmVjZXNzYXJ5IGZvciBjb21t
dW5pY2F0aW5nIENYTCBIVyBpc3N1ZXMgdG8gdXNlcnMuDQo+IFRoZSBpbmNsdWRlZCBwYXRjaGVz
IGZpbmQgYW5kIGNhY2hlIHBvaW50ZXJzIHRvIHRoZSBBRVIgYW5kIENYTCBSQVMgUENJZQ0KPiBj
YXBhYmlsaXR5IHN0cnVjdHVyZXMuIFRoZSBjYWNoZWQgcG9pbnRlcnMgYXJlIHRoZW4gdXNlZCB0
byBkaXNwbGF5IHRoZQ0KPiBlcnJvciBpbmZvcm1hdGlvbiBpbiBhIGxhdGVyIHBhdGNoLiBUaGVz
ZSBjaGFuZ2VzIGZvbGxvdyB0aGUgQ1hMDQo+IHNwZWNpZmljYXRpb24sIENoYXB0ZXIgOCAnQ29u
dHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVycycuWzFdDQo+IA0KPiBUaGUgZmlyc3QgcGF0Y2ggZW5h
YmxlcyBDWEwxLjEgUkNEIHN1cHBvcnQgdGhyb3VnaCB0aGUgQUNQSSBfT1NDIHN1cHBvcnQNCj4g
bWV0aG9kLg0KPiANCj4gVGhlIDJuZCBhbmQgM3JkIHBhdGNoZXMgZmluZCBhbmQgbWFwIFBDSWUg
QUVSIGFuZCBDWEwgUkFTIGNhcGFiaWxpdGllcy4NCj4gDQo+IFRoZSA0dGggcGF0Y2ggZW5hYmxl
cyBBRVIgZXJyb3IgcmVwb3J0aW5nLg0KPiANCj4gVGhlIDV0aCBwYXRjaCBhZGRzIGZ1bmN0aW9u
YWxpdHkgdG8gbG9nIHRoZSBQQ0llIEFFUiBhbmQgUkFTIGNhcGFiaWxpdGllcy4NCj4gDQo+IFRP
RE8gd29yayByZW1haW5zIHRvIGNvbnNvbGlkYXRlIHRoZSBIRE0gYW5kIENYTCBSQVMgcmVnaXN0
ZXIgbWFwcGluZw0KPiAocGF0Y2gjMykuIFRoZSBjdXJyZW50IENYTCBSQVMgcmVnaXN0ZXIgbWFw
cGluZyB3aWxsIGJlIHJlcGxhY2VkIHRvIHJldXNlDQo+IGN4bF9wcm9iZV9jb21wb25lbnRfcmVn
cygpIGZ1bmN0aW9uIGFzIERhdmlkIEppYW5nIGFuZCBBbGlzb24gU2Nob2ZpZWxkDQo+IHVwc3Ry
ZWFtZWQuIFNob3VsZCB0aGUgc2FtZSBiZSBkb25lIGZvciB0aGUgQUVSIHJlZ2lzdGVycyAocGF0
Y2gjMik/IFRoZQ0KPiBBRVIgcmVnaXN0ZXJzIGFyZSBub3QgaW4gdGhlIGNvbXBvbmVudCByZWdp
c3RlciBibG9jayBidXQgYXJlIGluc3RlYWQgaW4NCj4gdGhlIGRvd25wb3J0IGFuZCB1cHBvcnQg
KFJDUkIpLg0KDQpUaGUgUkNEJ3MgQUVSIHJlZ2lzdGVycyBhcmUgbm90IGluIGVpdGhlciB0aGUg
Y29tcG9uZW50IHJlZ2lzdGVyIGJsb2NrIG9yDQpSQ1JCLiBUaGV5IGFyZSBpbiB0aGUgUkNpRVAg
Y29uZmlnIHNwYWNlLg0KDQpQZXIgQ1hMIDMuMCBTZWN0aW9uIDEyLjIuMS4yIFJDRCBVcHN0cmVh
bSBQb3J0LWRldGVjdGVkIEVycm9yczoNCiIyLiBVcHN0cmVhbSBQb3J0IFJDUkIgc2hhbGwgbm90
IGltcGxlbWVudCB0aGUgQUVSIEV4dGVuZGVkIENhcGFiaWxpdHkuIg0KLi4uDQoiNC4gQ1hMLmlv
IEZ1bmN0aW9ucyBsb2cgdGhlIHJlY2VpdmVkIG1lc3NhZ2UgaW4gdGhlaXIgcmVzcGVjdGl2ZSBB
RVIgRXh0ZW5kZWQNCkNhcGFiaWxpdHkuIg0KDQo+IA0KPiBUT0RPIHdvcmsgcmVtYWlucyB0byBh
ZGQgc3VwcG9ydCBmb3IgdXBwb3J0cyBpbiBzb21lIGNhc2VzIGhlcmUgd2hlcmUNCj4gZG93bnBv
cnQgaXMgYWRkcmVzc2VkLiBGb3IgaW5zdGFuY2UsIHdpbGwgbmVlZCBhbm90aGVyIGFlcl9tYXAg
dG8gc3VwcG9ydA0KPiB1cHBvcnQgQUVSID8NCj4gDQo+IFRPRE8gd29yayB0byBzdXBwb3J0IENY
TDIuMC4gU2hvdWxkIGJlIHRyaXZpYWwgc2luY2UgYWVyX2NhcCBhbmQgYWVyX3N0YXRzDQo+IGlz
IG1lbWJlciBvZiAnc3RydWN0IHBjaV9kZXYnLg0KPiANCj4gQmFzZSBpcyBmcm9tOiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvY3hsL2xpc3QvP3Nlcmllcz02ODYyNzINCj4g
DQo+IFsxXSAtIGh0dHBzOi8vd3d3LmNvbXB1dGVleHByZXNzbGluay5vcmcvc3BlYy1sYW5kaW5n
DQo+IA0KPiBUZXJyeSBCb3dtYW4gKDUpOg0KPiAgIGN4bC9hY3BpOiBTZXQgQUNQSSdzIENYTCBf
T1NDIHRvIGluZGljYXRlIENYTDEuMSBzdXBwb3J0DQo+ICAgY3hsL3BjaTogRGlzY292ZXIgYW5k
IGNhY2hlIHBvaW50ZXIgdG8gUkNEIGRwb3J0J3MgUENJZSBBRVIgY2FwYWJpbGl0eQ0KPiAgIGN4
bC9wY2k6IERpc2NvdmVyIGFuZCBjYWNoZSBwb2ludGVyIHRvIFJDRCBkcG9ydCdzIENYTCBSQVMg
cmVnaXN0ZXJzDQo+ICAgY3hsL3BjaTogRW5hYmxlIFJDRCBkcG9ydCBBRVIgcmVwb3J0aW5nDQo+
ICAgY3hsL3BjaTogTG9nIENYTCBkZXZpY2UncyBQQ0llIEFFUiBhbmQgQ1hMIFJBUyBlcnJvciBp
bmZvcm1hdGlvbg0KPiANCj4gIGRyaXZlcnMvYWNwaS9wY2lfcm9vdC5jIHwgICAxICsNCj4gIGRy
aXZlcnMvY3hsL2FjcGkuYyAgICAgIHwgIDU2ICsrKysrKysNCj4gIGRyaXZlcnMvY3hsL2NvcmUv
cmVncy5jIHwgICAxICsNCj4gIGRyaXZlcnMvY3hsL2N4bC5oICAgICAgIHwgIDEzICsrDQo+ICBk
cml2ZXJzL2N4bC9jeGxtZW0uaCAgICB8ICAgMyArDQo+ICBkcml2ZXJzL2N4bC9tZW0uYyAgICAg
ICB8ICAgMiArDQo+ICBkcml2ZXJzL2N4bC9wY2kuYyAgICAgICB8IDMxOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3BjaS9wY2llL2Flci5jICB8
ICA0NSArKysrKy0NCj4gIGluY2x1ZGUvbGludXgvcGNpLmggICAgIHwgICA0ICsNCj4gIDkgZmls
ZXMgY2hhbmdlZCwgNDQzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IC0tDQo+
IDIuMzQuMQ0KDQo=

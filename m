Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870D16E8CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjDTIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDTIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:35:09 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BC3C31;
        Thu, 20 Apr 2023 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1681979707; x=1713515707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=00uHBPwzR22uRuNQm8bjd5vaAI20mI9j2KZ6x2Usso8=;
  b=hc19vxUEto6bMAP5HeHMn9xdgqKESP/WTcZ8p0pyeIAuXiGiNoJCAWAv
   Mc2xcHvBibjOkdQZlV9ynARZMTT9R4YH9WxLstBAdrazA/UskG0Jnv4oH
   YevZ50jGdL02/l/+XfN5V1ZVukvJ6xCUu20iOjKzDE7dLRzRaENb591bn
   ZAYcQK8hQnuAqxNKtxRlh/Jg169rBsU4HjhjMYeVGvXk+XfwvGHxupVcn
   pXXUxSH/jwq80S/D5TNXsqri9rTS1/9JF6GOOirFXKVoUIMZPg/Mi6c/t
   DSL0ZTw4YG7B8Hq3/gLtHE+FVjCluXnpQoFIRVktJ3pZipZDoKVKvwG9l
   w==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677513600"; 
   d="scan'208";a="233917296"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2023 16:35:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4OCU1gvONeh8jyVWXbVdS/PcPrqRTGlMmq43iYXrQz3WvQetz1RiTEqEKTEp8F/5s/3LZ6t+qwsXDwepn3b1bLJq+nc5+OedSo+kJ+KSAQklGDvtTUzIwBVRJnjkUlrVW7AKI5x+z7afWNfBWNFq8Q9hONJY6E6GtJ5IcyjnSbEAryXB3hdHDIO1QiJXZNQ5qtgfD5K1QURLOx1e57ZxpuJzFiTUyC7h/QV3r9j3PQyzRaVOKKs1mLekzY8HcEOyCCd8VfUAhykxXbllybL5upGG8GNJNeXxJX7vaW09jTVGc4K92nTybv/clwkYCkFQ30l9o3Fsxkq2rHqoc1R2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00uHBPwzR22uRuNQm8bjd5vaAI20mI9j2KZ6x2Usso8=;
 b=IiGgqo9QpRwLzedQALhK6WKzVG171dy4d5URA1gkOw/si7skAdxMXE3Erv9XYKF5QCcU30B5iXNLZWfLTVnz8tRV1yZ5xcRBNq+nCWnLQaq6/Dfk1AOmkhTxLlHpP4XdnIUXMpLbo29IdwEvF7hDLPuIJvaKf6izfNxreDcV2z44gV8TRAp4d2BXgO+4me5azq11EY2bKqED7Hghtjei5dKh8JGIgbeXHFRu1gLxeDj6070EClOR0lazEuVehOfoFaN94hpzJi/b5GsFgPTydCdLSVDaME/FOod4YMo9qwlSrLnqSN4TxDFBhfOSE+4nMfDx9+gIyAgzWjl7Z29wiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00uHBPwzR22uRuNQm8bjd5vaAI20mI9j2KZ6x2Usso8=;
 b=mfBTxZJv8yq9hoWNtLEqdlpR7Boor6/Uso5hoKrxLTT92X79VM0if1p/ycTKkITQel18NasaD6jAzlFk4QqYnSB5ksTIwTvoSOQm5e80AT97kwlzooc49JUmw3Wn3fknjqMulVAq0jovSlTMcXDbyeVobO3yxhdGcaHdOo304/M=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8873.namprd04.prod.outlook.com (2603:10b6:610:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 08:35:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 08:35:03 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] scsi: ufs: mcq: 2 minor cleanups
Thread-Topic: [PATCH 0/2] scsi: ufs: mcq: 2 minor cleanups
Thread-Index: AQHZYicXuNgczMCcKkaWwp70y3yJ0K8SO0eAgCHGMRA=
Date:   Thu, 20 Apr 2023 08:35:03 +0000
Message-ID: <DM6PR04MB657517C1752964E5792DF0F0FC639@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230329101303.18377-1-avri.altman@wdc.com>
 <c3860fdc-9018-bb8b-e1e7-def3da77dc42@acm.org>
In-Reply-To: <c3860fdc-9018-bb8b-e1e7-def3da77dc42@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8873:EE_
x-ms-office365-filtering-correlation-id: 3fa940b3-38ca-4366-8e87-08db417a232f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OoQsED7kwDfIuBXSOzfHEPwbBoLvwQb1IY86x2kFmdr7AVvXx+guV0cjAGbsBawSc5RRcd0f7NkT8DfQ17305FMeie3wOyNhONxTmz5bwVmhQgEkhNP1YCkVpAXGgoKnTLRXbevqrlugjKthh4LhRq/vAIqIT7Yhl7/uhvEjBXIGf4kQpen5SZ2x8QAYtmtth+yggkXXVSnN32PH6XgW5eQ6lANl6MT44SdywWdFVjzSWI8e9nCCS9wBCCwmOUSn0i1vO7Zy+KStypM0PoZKlkLfpAJ+gzuLW76iTTjDBHs9H6uVkm3mKE4Idot/4o3d+NR3/0txnAYThCrOyujZ4C2GHoX20JHSlZCsqCkrxm+NtnN7afDK2HytD6c0/9k63ep4enfb419G9Z3fvIN6IhmAuH4rED5voyh1eLYCQ4vhv8mcw8YGLuXVOoP4AystIcZi2Ytneri0vHP7kINl8IEPZCwJbZ/K9jNQK94s86bxZjcMjrpp5LqoWv4tDaK3oxb7RTSoSLM4XWgX25wh/hJTHI5EWAIKW3IB++l8AfPXJ+o/fM5kfRrcIi82KHOeZ/ZUdwjoTaAnflNdtfM4kbeIIe0RIRUq/PxBawgdi2iXS141FtnMyLMZciJwvhHh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(110136005)(54906003)(478600001)(6506007)(7696005)(55016003)(9686003)(26005)(71200400001)(76116006)(66476007)(66556008)(82960400001)(64756008)(66446008)(41300700001)(122000001)(66946007)(4326008)(53546011)(316002)(186003)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(2906002)(8936002)(558084003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NoTUJReGpSLzdrMU1wZ1N0OXNHVEdtallXTFJ0MmovQVhSZUZsYTRUTDV5?=
 =?utf-8?B?N3B1K3hEMWppTUtTMFJXL0dnNEVieUNvNGNZVzc0dG1YVWhtRXp3bDFvZTdT?=
 =?utf-8?B?SHBFOGVuOWRhdjRGVmtlMXg5Ni9IbTFONkNJWDFCT1FzOWJhdkxIMDArY0U1?=
 =?utf-8?B?cVE0c0dEL3M3YUJHVlhQRytrU0wyaTNzRklFeE5QM3l6T2FSWkRUcFJZZFlL?=
 =?utf-8?B?cFJyanc2ME5HSnc5VjVtYmRDUGEwcXB3ZVhYcGxmNmFBT0Ztb2oyc3ZXU3Rs?=
 =?utf-8?B?cXFBUDZJTHlRR0pTY0tYU2MvM1dNUGFjTGd2VTA2YjJlWGR2eHMzb0pGbmpN?=
 =?utf-8?B?K01ocWJFN0l6d1hnR0xsVEdHVUs5OUlrRXRuc3NkSmxuR0lPQTNWVzNiTWdU?=
 =?utf-8?B?Y0FTdEhJNllObWhMdlBFRHUraEpQU25IdE4rTDNTRkRRREcyNHYyeUJkYnNh?=
 =?utf-8?B?am4rejF3N2dEVlNGeXozemhHOHkyQitKRURVVzZlRmtqeFB2ZEVzYXhoVEZp?=
 =?utf-8?B?Mmk3QU10QlNsVmVHaWdkbEJEUFkzRFNUekY3UmlpMXo1eW16SzNobkYyMUZZ?=
 =?utf-8?B?TW8rRUwwT3V3SFl2N2R5M3BVc1FsTG9YUExFOCtOVFdmVDN0R0tyWEFjWkVD?=
 =?utf-8?B?RTlORHBYSW0zWG5iclAyVzVEL1RtVHJMQVdjYXhuSlJxV1BwbHRkOHIxU3Bz?=
 =?utf-8?B?Yno1cHExWGJ1ZldGekQ4K09kNHZSa1AwUzFDbU1IL3JyM1VtaHo2YVRnK0Ru?=
 =?utf-8?B?eHNQVWU1anpuNEU2MjlNZ1NZaXRiL21sdWtEa2tiVUNReGpQNXhuLy8xempT?=
 =?utf-8?B?T2VINjdGMktveGhQSFpETHNqS1o0QzRSU0puNWp1QmRlMWdQdzUrNStJaDli?=
 =?utf-8?B?aVVGeHgxVWNZVSs1bit3VEFjQ0w2NzlPWDhRLzgybUlVWjdQMWx2ekNZSmRS?=
 =?utf-8?B?SCsveEMxMlg3RXZyNm1aTHhOd1FFZkphNERzMm5xR2NRenZsT0pvODBVcFMr?=
 =?utf-8?B?OG11c05MVm1zV2p1Uzl4SUNkb3V2NWlYNnZyclFzcTRBemZ2VEJNakd0NTVx?=
 =?utf-8?B?b2U0Rk9xWGk2bWFPQzd5NVo1TjRQcGREY1JqMGI4NjZxcHU2R3YvRHNLQnNE?=
 =?utf-8?B?RXB1alp5MnIvUy8vdERKQ0w3a2xDekVrN2xqaTFVdXVneTErZWovZnJlK1BC?=
 =?utf-8?B?K0RCVVFPTHJma3FkaTU1OVU1TzdrVE13Mmg5TDlxb2x1OG5VOFdNOG5UZG1Y?=
 =?utf-8?B?aXhDZnFuWTZEV3dsSC9qZk8xblhUOENXWWRnby9VYXpwWVU0b0tGZnBtck41?=
 =?utf-8?B?NW5aems0b0pZdUdZMWlabUFvZDVtQTBZZ0JDMlp5ZDkzUUFyaEYvTWhhYlcr?=
 =?utf-8?B?TVVheWw5Sjc3bXZpbkIvKzB5cVhQRm00TWFEZUVtd3lLL0x4cUYzclhZRmww?=
 =?utf-8?B?bDJGSlJ3eitqcDRsdGErUGFjYnBDV2c0WlYyUXNIUVZSUStYMWROdDZiQk5u?=
 =?utf-8?B?OW1Qak1idUNmM1dIbFQ4REVVb3dBTnRWVVg2MzdydFV6c2gyUkRZY3hLZWJZ?=
 =?utf-8?B?MEtaWndsTTNBeUtDMHl2YjRXaTRVWXcrb0ZhOG9ELzVSdUM5bG10eDY2K3ZU?=
 =?utf-8?B?TXF2dU92YkNrQ2NPS3VFVjFpdDAxVFBTZzJ3a1AvNEIxSlRYZnBtSHhLRHNV?=
 =?utf-8?B?TldaTDdwcUY1UkZ2bFEwRDdBZXpRMThTdFprZFR0UDh0NmJSUXRQM0kzTUVn?=
 =?utf-8?B?RDZlVDlsbmdySmZER29DMWFKMWtRNGRmZThpeFM5QWJaZkc4Mk9RWDNINDVC?=
 =?utf-8?B?VVVtYXNRZUM0NGdTZmoxZVB4TTUyT2UzT1BzWDllaGNGZEd1WU1PelhneFVD?=
 =?utf-8?B?dEYwMlRsL2xDWm51T3RPZ0ljZUd2aGhqdjlvTEhPNzloKzJGRVhjTG5sTmFm?=
 =?utf-8?B?akRzYUdsL0VleGxRL0N2ckhTd3c0TEhrWEtyWithZGlMa1h1SXR0cDNaMEtZ?=
 =?utf-8?B?UlNaUkVuRGRjUDg2aEdwY1NRaWNLMVl2UENkbExrT1I3c2cyRzBzSVZncjVT?=
 =?utf-8?B?OWFqU01SQVhSSjhwTGk3UlYrMDZtYnNYZkdPTjFOMFhsY3gzTEswZ0huQW11?=
 =?utf-8?Q?YX7sJXC0vK/Jye7M90CqoFYea?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gt6u6HzCC79nO6rJwkY+pXXNog0sNB+ir4SMD8oh4eF72Wdl8asCVZcMaLrasU7rRhbDh4i4tmdmNIJTIL6Btw2/c7ENRO4LF2GCFPOPznaeaTCxJHtraaupBNp0bdQjqn74DzLBmkEOyrqL7FwT0xsTUY9R9D243QGG7HX1oIkAsWZl8lVCHqWjp8mAkDkEWnA5EHGb9bXYrNJ5dCV/1INT9gRQcLehoGl8m1i/btJdHeW7BVVDy9QbZp0ayxvdFaRukHAsfrCLdR+Xsdsam4CjXcXXuw/qQATFI5uET9jjtp+313I8UxoK4gcVHPmqq7HkgDDwZqRGuofbAY7T7/IeCHhVF6dIpad4U0lwFMs7CtFTheSr1+mD9soKMRQG3vnk9kEX0RHrYfjJuTLON3Mxu0tA0SP4jnBVeftj3kEBnjBjQccP1NsIch0cDLFsw8da55SVKQrZ/6+6dIiRvUPuR2nsmqVsfqRJ1/ECH5xXanVzoqHRVCjnjyU9V/TzaPXML8QUNouoKSoGWLOWHfqv/0dRo8fnirIYe7ra5kLW8w2RRu7TeD6laTSMI7M/l+tPUh9eFH0CE0C2ihRFyyug0oCUUq4842czWMAsvdboZoESnWWMuWoMfguBgXIPM2bEGU8pSyfhycrp3TKomtUOYBRjyUXOde2lAEKWZCyxVceTWSIqmzH89IpKHwRHeJXf8KuE5QBt+VkP/uGSJ6sDrRdkC8trlq6yaj2mg3WLnRRdD+tfr2WmXY2K4cSlMGsfTM3mZRrS4OEQ4w1Qqpd4FX1qGRm+9ubMNhhrs+Yf9EpTbLVLi/QHU7rceJl4yCAnr75RngfRhZwBRyLX6yXCXLwdyNwF6O6OD+JERrEcbWuVaGNPBsAD2qxrlI0eoapA/3budJPBkFm0TeXX6HiZB9KcbDCCOk1d/Jj6J50=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa940b3-38ca-4366-8e87-08db417a232f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:35:03.4713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fg3BfdjWFkWwIxC3sjiYOr9uCmHlecky45g00HjgNMw48C52qnRoZaLJFAF1yuwEBjFOKOCYDtXS9VFc44oX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8873
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMy8yOS8yMyAwMzoxMywgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gMiAodW50ZXN0
ZWQpIG1pbm9yIG1jcSBjbGVhbnVwcy4NCj4gDQo+IEkgY2Fubm90IHRlc3QgdGhpcyBzZXJpZXMu
IEkgaG9wZSBzb21lb25lIGVsc2UgY2FuLg0KV291bGQgYXBwcmVjaWF0ZSBhbnkgaGVscCB3aXRo
IGEgdGVzdGVkLWJ5IHRhZy4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBCYXJ0Lg0KDQo=

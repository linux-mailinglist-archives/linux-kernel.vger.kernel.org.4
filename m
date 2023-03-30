Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9554C6CFAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjC3F2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC3F2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:28:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30ACB2;
        Wed, 29 Mar 2023 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680154126; x=1711690126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=StaU1LbU8sl92owZwq/ZgjxC/c3INExU5hx4vcFq12k=;
  b=kAZAHJJEET5BKQDA7vXbUn/Nx9eLMYoI5cCKzVOOooQwa8DTcZwrBrdp
   VUVpIs4+YM7D6iDAADJWjoHijKPoNMfBuPtX23dFO0Fmf/16NJf1lKQq9
   v/zd+pFol8Da+CiPWjfser7zOP6xAaV1cKslpT5Ono0gif7ipoozMfwma
   vmpxbFyRWDAVVa3m4Lny9pPwQz9jduZxD9e00D8Zz25nCzhS+m7qITwP5
   +8UpIdmX/Guw/yBJzHmbX9xf46TeW54TKnHYQAxBG91Ty2AUNqFyUwf12
   vodOQ01iEwlBtojhI7otsSQyc/hguHpyBppZWCATuSdzrQ997BJbFhPLd
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="207374341"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 22:28:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 22:28:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 22:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnwVhvGUyRjUpYRGi9/AsPcBOhV6JqU4hG3nUlLpb+2z2WR4+VjoSyqgGTZWXOLfzqFqrUajY/CdZluLiH1+K5q364OlExpxZpAPwROU6J0AiRd1QLYpATP5/sCVBMTXlnr7zxiyOJBgECwrkA31D+VonZpp3DkUvXMu7LnJlZHe623STFWLPX/KTKsubzl5MYtHs8LEPz5PsPhh6IfgY0V7ZqJkksjI+xe/pOgROIbtvO2rXj4Yn06XBwwuUEzj/hJ9k3Jy6kJEq991JJcx0qz5q0c8QFkf/fjZ1EeV5sOQRtmrJ5Rq7K9RUowuBBL7QlvyvrgubsQAzFAxrHXphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StaU1LbU8sl92owZwq/ZgjxC/c3INExU5hx4vcFq12k=;
 b=CNo9ousiK63b9bTrqJLVcpN5IERsTfzLi1ljAv8Kd96SmRbwy1aA+p5jAMQAwiH1kBB2LkkqBOcGyuLBxLiav5z1/YD/sTnka4TZh7VG6PU+Gl0dHZmlpdbZQiBsdu4fnF3l1DYE7yn6PvDtPD1QbMQZEtlDzPTl//1Np23hI3WuS0cKKdbuUAX0HX5FOqUcwZ2ogLqak6Ynwlv+l879K9jfZHXo0lmXGWBivNKGelgrk27Y+AbsIB2Xge8kFG/vu6XpjtaMq5X/a2irhyP9QvJIgPpwe9yn/zmYH8sglz7V3+/3eeIR9zLwEwkkPNWXCfqQIpvHxr+M7pqjiQw03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StaU1LbU8sl92owZwq/ZgjxC/c3INExU5hx4vcFq12k=;
 b=lepW48vY1woJX1t1JRkBMgsRN0ygJmSvLFtBEt1svCmHYid7AwRHEgVGYDqaz8+ZCVeCdqhW4NsZmuOmf2xqxoUIjnORVM02djaPuXjmaKKjRGZ4jBeAY3RqnqJwq6FWVyOptMmRaVSXmxiOtt/Yqo3DuGnBhPCFc2yBegOSBO8=
Received: from MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7)
 by DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 05:28:43 +0000
Received: from MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c]) by MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 05:28:43 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add
 EEPROM Functionality to read and write into EEPROM bin sysfs
Thread-Topic: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add
 EEPROM Functionality to read and write into EEPROM bin sysfs
Thread-Index: AQHZYYNgHjpt4wjh+ECr2Bh0bZsdZ68Rh+aAgAFGJIA=
Date:   Thu, 30 Mar 2023 05:28:43 +0000
Message-ID: <f999539280139b7085721803f12f836c201edf20.camel@microchip.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
         <20230328144008.4113-4-vaibhaavram.tl@microchip.com>
         <ZCQMh_TbPyLGhTD2@kroah.com>
In-Reply-To: <ZCQMh_TbPyLGhTD2@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6232:EE_|DM4PR11MB8160:EE_
x-ms-office365-filtering-correlation-id: 0ae939dc-c7eb-4b70-913b-08db30dfa0c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +uosyAsq91SP5NFbxdMmdFXDXI6zqtzL5S3eizYNMPQTL1aouPrgq1m7Bd2WPHQKvS/zvjk3/aNqGkHLIVNxthbvh2DtyXd/d8sMTYHkul1CItgiGVo2o+6/sHWPnn2tb6pIQegs2jZAIcB2tEIDoJrU6yiXdYFKfrEH5IzTmn09g+x5RlipqCW+XYc0n7E5D/Yo6frEEG5Kw1xZvJz2Y2ua5oBmh/2T1lQTqwK4wOgMETWKJJH3Wh+UaorESAGKkoXWf9Y/BalUG6cBZdwKD01LV4uALsxTNwOXtckhv767oV7GZWSc0ieLcxxrC1gR30wMsS8rSop/O+pdvCD7R+h9Xe5k869qVA3MHb6HT2Ui3uk9CsUU1tHVKyt4p3w2O1vAXnhgf+B/t1ipibXGqQ7uK7OrbEK96uqQLWH44FnW31nQzgyyUX1aCN/zsWeK7xTaNtcibid+oG9gcZ1tp99du9W05YIpbH5TNL7uDcpizERPte7wZuvcFdGDAsayIBIWz/uldH34q5sWabCwYhAMc1hN9+pD/JmYEWCjGiiQ3WJhGCAMCU6Pu2i8bn6MAiRITpmSOkabZMCt4Xe1oh1xnFCzRum4snS3s27c90QLM2rNyO7UTfOITs+jNLMQfh1vCHhZ3BEVILh31ACSlOlWAzjQlSfsNRQhMYQQ0tbxv/UQABslyI1lBEUciabd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6232.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(4744005)(2906002)(41300700001)(2616005)(83380400001)(316002)(66556008)(71200400001)(8936002)(6486002)(36756003)(66446008)(8676002)(54906003)(66476007)(4326008)(6916009)(64756008)(91956017)(66946007)(478600001)(966005)(76116006)(86362001)(107886003)(122000001)(6512007)(6506007)(5660300002)(26005)(186003)(38100700002)(38070700005)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9YVSt1eE9CUnJyRlRzTEtHSTdVNHFaeWg4MUtueTBUUGxXWDNDSHBXN1Vn?=
 =?utf-8?B?ZWttWFpMaTlLSllOaFhyOVBDQmlFQ3NuMDUxSk5rdGV1OWxUUnBYcEdrYzBJ?=
 =?utf-8?B?T2o3ZXZGSkllSXpXQzVXTEx6Z0ZFTHFxVUxvekl0d1hya0JuR1ZkWkJyNVhl?=
 =?utf-8?B?cFUyS2F0N29wYjJGRFJubmNSVlplNFk3R3dQSTJNaVF4cU5KUFcxRWlkV0VM?=
 =?utf-8?B?SHBwNGxDcmJianlqbkFYb08rQjVmak1CMk9TUnJoSE40cTZ0Y3pNaHIwbGVv?=
 =?utf-8?B?U1NrRnV1TXdKcU1zK2NnaFdHTkJHYmkxbmIyQ0VlVi8rWXg2MDZHY0FheCtB?=
 =?utf-8?B?VHd3d1Nta3NGb2FQUkEzOU52K3RMYlNvZ1dYRnB4L3VzTTI5aUtEVEZpdGov?=
 =?utf-8?B?b0pZM2p5SlZJeDBwK1Q3OTEzZjVqUXI4UnljVDViQUtHS210a3o0TWF3YWkz?=
 =?utf-8?B?UU9UTW8zaFdtUUdEZFcyUWtDaEllTk9GZzV6WDRXQUROOHFING5VSWcrWnox?=
 =?utf-8?B?VjhEZ1JmRGtQWDlzYWxVUmJHQWFiQ2EvWStpOUVJSTJnaFJUd3dFc25maWhO?=
 =?utf-8?B?ZHlyMDREcUg4dFZXbGxCb1REQ3dObXM3T3dqK1libXpLa0ZENDFkbzE4ZXZ6?=
 =?utf-8?B?b1h5UzJ5aU53M3J4Q0dDaUJxNi90ZlRhbC9QeU1DeElFN0ZHVmg3b1IzWFJN?=
 =?utf-8?B?WFVZdEczNFFnd0FES0YwKzBlZWpJaUJHRVFIbmhINVg0aWEwN1NlQmhSVXRu?=
 =?utf-8?B?YnMvVGR6U0R4VFZqZ2xmT0NmSForbFhYelJGcXdhZHNqaEozMWZ5eWUxZzdC?=
 =?utf-8?B?UG56STNhak1nbHZXWTI4QmFhNXVWdDBXcUsyNjBxc1EwNUczL29TK1JvTkJF?=
 =?utf-8?B?VTlQTFo4eWlEd3Z5MWZ4cUE2WXk0K2g3MHZqNGRNNmlyTVhER2M5VkJPMWhk?=
 =?utf-8?B?Nnp5ak5jaTM5VUFVdHd5NnFieEg2blFWUERqYVdlc0oyRHdSOG9sVE1FUldK?=
 =?utf-8?B?VTc3Y0ZpWVNTajBkSTBuWHZxeGZ6NHRWRmJDM1Q1Qk5PODVUeUtRT2lSekNv?=
 =?utf-8?B?VW9YYkdYL2gvdGdCcXRRNTdLVVd0RnNianlWQWk0V3Zyb2NUeVZIU1ZkS3NH?=
 =?utf-8?B?eDNqN0xDdHBadzBsS1NnR0lmT3FJRE5kMjc0a1VaTVdYQ3JjUVhCcFpxQ0tJ?=
 =?utf-8?B?ODZEeks5QXF3R2l5cnNKaWdROWUzWTNSOG1wN2lTODJoMXhUY3FtYUMwVzIx?=
 =?utf-8?B?YXoxU1RSYWI5YW83ZzVVb1ZCb1FNMHVZT2JzZHQyQXpub3FkQmx1VXJIY2NS?=
 =?utf-8?B?ZWxSMkdyUHp5Q0VMd0JTSzUvWndQcnlrQ25yMGlTMk93cTN2eW1uUXRlNTFB?=
 =?utf-8?B?R3BDRDNHWjlTWXZqcE1vSVNoZENEeW4xQU9LV1FaK080SVVYb3drWStXVnRF?=
 =?utf-8?B?U1hyUEo3UGh2ek05OCtDVFR6MzRxb3Z4U2VpMVFEVS9hejVEbFFsdnZ5N25O?=
 =?utf-8?B?KzcvVjAvOSt4UWNhaDFLNDMyNjFYWVJhTmpydkx3WlBZTUVjMG5GQzgrdzFM?=
 =?utf-8?B?ZGUyaG14S00vOUhsdUJwTlFUL2dUdHlTZjk4TXlZUENDUWFiamdOaHZtcmJ6?=
 =?utf-8?B?NkJTWFlBa3FScFNmclI5OCtaUTl6VUxTVGJvYkMzOFRQcUxFbFI2NkV6L2hu?=
 =?utf-8?B?VmIxWU9zTlh5bWZrNDM3QXNHcWpiREhkYmRSaWgraWNVTk5FZFk0dnMwd2s0?=
 =?utf-8?B?KzBqbytQN2I0UENyRFJRdDkwU3FQWVVzdmZQQWl2ZXM2TnJ0TWxmcnVGbWRC?=
 =?utf-8?B?ejB3ZFRjTlZ4eWEyYnJpOTJKUWRHd2Q3aE5hWFpEVTQ3Nys1cTRadGRJTHRu?=
 =?utf-8?B?YlBVdkNMQkJSRWdwb0NNTlZQSVNiQXg2ZFhIejBhSm1JQWxzLzhibGZnTHRB?=
 =?utf-8?B?amJRNGhaQ0MyWE1FditkWnBObU91bC9mVGZuOWZWNDhmQmRVd1hibDdnTEZN?=
 =?utf-8?B?YTBKakN3aE14eVVxOUJzd2tQUTJCVDBmdEZtZ1lEZDhiMEduZTcvTUZ1NEl0?=
 =?utf-8?B?UFcrSHN0UzZheEI4dkRUTE9hRTZmM0hRMlNVdTY0ZUZ2UGhINEJTSkgwOWw0?=
 =?utf-8?B?OXA5L1lleG11Y3RRdG9vL1ZHODBRZCtVVzh0S3V4aGY0RTJDcUMzT0IrWHJs?=
 =?utf-8?Q?9Eou+0q5W9hWEjq+xUSQ2Z4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E1E1659A4E0374A9D7F351E000CB80C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae939dc-c7eb-4b70-913b-08db30dfa0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 05:28:43.5836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9vg78nzG4hTzGRRaxZuTRJWhv2NvVI6JkviQ/FlIT9AY3kqEg6S4zrBS5MQOZF/iJTyaLROpeTQ5vKQGGpOU3UKYGiWo8OoQy+kd0sTlt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDEyOjAxICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgTWFyIDI4LCAy
MDIzIGF0IDA4OjEwOjA2UE0gKzA1MzAsIFZhaWJoYWF2IFJhbSBULkwgd3JvdGU6DQo+ID4gRnJv
bTogS3VtYXJhdmVsIFRoaWFnYXJhamFuIDxrdW1hcmF2ZWwudGhpYWdhcmFqYW5AbWljcm9jaGlw
LmNvbT4NCj4gPiANCj4gPiBNaWNyb2NoaXAncyBwY2kxeHh4eCBpcyBhbiB1bm1hbmFnZWQgUENJ
ZTMuMWEgc3dpdGNoIGZvciBjb25zdW1lciwNCj4gPiBpbmR1c3RyaWFsLCBhbmQgYXV0b21vdGl2
ZSBhcHBsaWNhdGlvbnMuIFRoaXMgc3dpdGNoIGludGVncmF0ZXMgT1RQDQo+ID4gYW5kIEVFUFJP
TSB0byBlbmFibGUgY3VzdG9taXphdGlvbiBvZiB0aGUgcGFydCBpbiB0aGUgZmllbGQuDQo+ID4g
VGhpcyBwYXRjaCBhZGRzIEVFUFJPTSBmdW5jdGlvbmFsaXR5IHRvIHN1cHBvcnQgdGhlIHNhbWUu
DQo+IA0KPiBBZ2Fpbiwgd2h5IG5vdCB1c2UgdGhlIGluLWtlcm5lbCBlZXByb20gYXBpIGluc3Rl
YWQ/DQpVbmxpa2Ugb3RoZXIgaW4tS2VybmVsIEVFUFJPTSBBUElzLCB0aGlzIEVFUFJPTSBpcyBu
b3QgYWNjZXNzaWJsZQ0KdGhyb3VnaCBhbnkgb2YgdGhlIGkyYy9zcGkgYnVzZXMgYXZhaWxhYmxl
IHRvIHRoZSBrZXJuZWwuDQoNCkl0IGlzIG9ubHkgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZSByZWdp
c3RlciBpbnRlcmZhY2UgYXZhaWxhYmxlIGluIHRoZQ0KRUVQUk9NIGNvbnRyb2xsZXIgb2YgdGhl
IFBDSTFYWFhYIGRldmljZS4NCg0KVGhlIGFyY2hpdGVjdHVyZSBvZiB0aGUgZGV2aWNlIHdhcyBl
eHBsYWluZWQgQA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1krOUhPZEhHcW1QUCUyRlVk
ZUBrcm9haC5jb20vDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=

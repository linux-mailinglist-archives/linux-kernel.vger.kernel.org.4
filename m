Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E55B4D79
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIKKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIKKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:35:08 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F48013DD5;
        Sun, 11 Sep 2022 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662892506; x=1694428506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ci675OhMAzBd02zoi9gGZZs9v/YAN5VW873tptlM9D4=;
  b=l44IvmbDiuFzjiIvJZyqoTp6MlWjB67fck+Z3yqX+MuJb9CrBYO8QWRR
   OGeCQ+rixE35CDI83ficzxDa53uXgbYUKzjEG/VjUbYpmUHyLp5yLqaMa
   ircpi3C1O5kXGG6Z5FulLviOKQNQx40YEH8ZH0AHFu/ckXYrdbgos8JJ9
   9Mswnogd4Dmgn+CWR6bCbRDX/QXWuABBA7X3/y8VswVrWEYIBwtWKMFY/
   0oOjYsXE6UxQhYw43BDKqMeUTxvatSXvzNbxDeD3eHeuj/Yv27xs75lH0
   5ByfVHnpt8C8986ddF8M0+5lYN8r/5JSB8bI603N8cNMSeZNHQ2Rapplp
   w==;
X-IronPort-AV: E=Sophos;i="5.93,307,1654531200"; 
   d="scan'208";a="216213570"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2022 18:35:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbmUJQdNYYkhx+z4zGzzIIrifK+SHn0dkFpId8nApRW7jo/PAgalkEUuFVIbf309l9DG+DSfqMYTdhvzDmyhmwG2oxIK9atd403t57yLN9AW525CsZ2j2LnGKsK/5xCk9cAzzQQNOtdLuVKfpVf25KGt+rSVfQ7zBYzMSKYS82+byhrQOTm9BWOWqZhnmvDn/sx3rf2nH3Tk7EPY4FTF6+98jL3xpzOH5GP7DW8K0lVrAXGw9WhBM4lkHxyzc8ll0nvsl5mWx+mKMj8mjG7KYkmH1M6ud9dou5mB5Q2zvA1N3Aed1ttvwu/bnbnGiPLRRFvqfisZ3BZBzyGiSexsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci675OhMAzBd02zoi9gGZZs9v/YAN5VW873tptlM9D4=;
 b=XbBEHRb3ncuGhJY/Q0opwgwnv0ih2W7ZBtDHGjpLdkGhS3YEM9oyo4ALT/ebTc1Pp15388cID6oksKkzVm2cV3VKUiI4yNqTBxggB56qWRzZbCCR+BsuT+gIBC3oCxHW3QgLgVkLxJheo2JEBEMWMAaVVlO0nw/WioAB8O3+WpLfa9z847BfizxmS1AoTuzrnDn8EJ3lonV2fUm4NRV51lUiNrpy6PR1OzNAxV8h9QTu3PvCucjCOMIJpdmKPX3V5CzJJV88ut+RhtbyBdM0vS9vcNYxUr7E8tuVlcQSCUq5P2sxrugJVMn+dKPUUDKODKR7vhOXiWZxlYRMjcb/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ci675OhMAzBd02zoi9gGZZs9v/YAN5VW873tptlM9D4=;
 b=nxh+ObOTimFlim6PElqtGUxsrwYU9UKtL4Tcxq0Dn33JEvVcNIqKutgbXjL6Ceakx4Wa1Zb5NhadAqPY0DH42o4E0Co+sZwSFhnKvF5y5rCZgJ2LKCPKpPf0mwiKXvGoAibX5csOCFXbGmiajEg6wtSeF6wIxot8ACtW4IXy0VQ=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SJ0PR04MB8343.namprd04.prod.outlook.com (2603:10b6:a03:3d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Sun, 11 Sep
 2022 10:35:04 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::785b:bd0f:8c6b:e06a]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::785b:bd0f:8c6b:e06a%5]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 10:35:04 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Daniil Lunev <dlunev@chromium.org>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq2kYf+AgA2Q4OCADD3GAIAcWViw
Date:   Sun, 11 Sep 2022 10:35:04 +0000
Message-ID: <BY5PR04MB6327C911666B7A5AE0E92A96ED459@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
 <YvBK/8yeohLhu2Za@google.com>
 <BY5PR04MB6327431615BFFFD735EB2502ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
 <CAONX=-cXDcekWznHf6h1WwtJfELyFxSPAZ4bnA5t3xOrmUQZ5Q@mail.gmail.com>
In-Reply-To: <CAONX=-cXDcekWznHf6h1WwtJfELyFxSPAZ4bnA5t3xOrmUQZ5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SJ0PR04MB8343:EE_
x-ms-office365-filtering-correlation-id: e4f9ca68-7e5f-4ecf-f5fd-08da93e149c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxuKM3ZTKMxkRnbx/56FLkYnA/dtVkoABv9htUsiKxBWnpfyH4Xws7y7MTq6F/fB3+LdWphJemsB/limVFizLFNfysfmm0G7pifIT8lUDcwsZtfb4eA9/2UmwUyOhV9TWmnFffd+Dc45exk7e/twcc+0jGWeDbrnNZrmOL0Cl3Mtm9ScQLYrPIJgRkuBmw85ceBGbC4v3KTy4NwQwpFhIF0j1XQCA3CKGvxSv/s4Pq0YM44rlCwEllaki9+AxDXc+7FW7nXnZOA5POjcQlgnaua39jn1clI0zFpJ+WU26nAxrcu08zSCW7RwyhWlnf6Iz2lCAnit5fXapeDUueNrCERuar0FtX9v77oqOZ/QGFlIwqAhG8mWh8vTQwANHvvrNQYkSnlw1DXtpXgOYEygavlg0BcSihn7Vw6zR00XPAF1CtQDm24VrvydoTXn58mSu8yW4gvlHE011QUzQ4d/u6tWiXf6bZfKGUGh2odRAntZvD9VVTy4CLmhv0VuqnBGagjV3nqULN1I+qYtpKN4M5VbQXxbrBnMEPvKvB7PNDuqaFMSsBO4wAHuN6rePcmigDvHR3W4vP5lPtK1oCoS6jPrGuykc0dPAZBy8Q/PISodJOa6Ypx2CJozZ9U2kQvdcG2ClLCRsYEgnr4hs24nA7yT3UpUOfu1wB6nCZ2m2FnrW1jYaJApm2kXBPszWZl90Kf2b7ilmXgqeoLJyZjIoNvUoiUlI2oZ6iRCwhgkuOSQv+jAlixNNzniDK5fm+E/es2Zuejfh9MV9/FAjFdnJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(53546011)(33656002)(316002)(5660300002)(82960400001)(4744005)(38070700005)(2906002)(55016003)(52536014)(26005)(41300700001)(186003)(6506007)(83380400001)(9686003)(7696005)(8936002)(54906003)(6916009)(86362001)(76116006)(8676002)(4326008)(64756008)(71200400001)(66946007)(66556008)(66446008)(66476007)(478600001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEd4MTE3TjdjVSs5WGRYYlc3VEZPR2pSVkwycFQ2MC82bW1GVmhkSkpYM0c5?=
 =?utf-8?B?Z1RMTWpGRnNXTXUvdWU4R3oreE5ja0RaUHRkcFdianE3bktGZ3BUaWlKbkU4?=
 =?utf-8?B?YzB2T05ocm5PSlUzcERVNkNPT0VoRmRFL2VoUTFMWWN6M1ZMRzFFNEtZZjVB?=
 =?utf-8?B?dFVmMG1TUC80anZqN1JKdGkrYXE0bWhDYWlsTWYvL0FNeEo0bkJUaU1xOWNV?=
 =?utf-8?B?NFl2RUhPZlhWMmZBcEtTWVEyZy9xUENreXhMeGZ1V01CTnZPL0NJb00xRmoz?=
 =?utf-8?B?VjBwT0tUK3V3OVJwRzl0SjJ5UnJWbDhVdUZoa21XUHZKWTVTKzlmbmJEOFIz?=
 =?utf-8?B?T1VlS3FrWU54QnRZOEFIdUZ6UjFHWXNYV2J2cDVDKzRNNjhUbkdUOTNFUHIz?=
 =?utf-8?B?LytMMEdrZzVjUWdJOWtwT3JuTVFYTi9IY3VKdXFnTEs0Q3VoVE1TQklCRjZ4?=
 =?utf-8?B?WldoOGl5VFBwMGgvKzdmbktNU2VsdC9WdThkeEZIejE1Z2NuUTFTaFNjeHp2?=
 =?utf-8?B?NmRGblZxNWVJS3A4VFFYMWRwYnZhVlo2eEQ3RkNvRlB0T3VOUkV0ZXF5UlZ3?=
 =?utf-8?B?dUZ2UFQxVlN4RWJSVVNVV1dLNDBINDhBdWhrU2RRMHdZRVJkeHF4RFJCem85?=
 =?utf-8?B?MFRLTWxTcTRPampWbG54TDc1U2lrS1JWWFBEVXFBWDd1R3pUM0s0NThYQ2dr?=
 =?utf-8?B?UDJ3ZzFmM0ZkZDU2RC96NTJMQzQxNlFNOTE4bW9CN2FzSEVwTkN4UnZKQVNG?=
 =?utf-8?B?OXBUK2w0YUJMWXhZNnRFUVdPUFpUVVJtNjl4VXJFMG5VWTVsWEpHb3lYSG5U?=
 =?utf-8?B?WW9uUWVtL0N3TEdwTHBoWFpkNXRSTXRnRzB0L3NBKzBDT2JESGZLU0s4VGJQ?=
 =?utf-8?B?dzZEdmtpQmpwY1BhOGxPYWpCQW9CTmd6SlBpTEdGNEw4REhGcGZsbU5pZGJD?=
 =?utf-8?B?ZGpYc1E5cHo1bGNlVVQ0cHl2SDlRbklXdjZNUEhoYnVXMU5pb0ZDd0N2NHBI?=
 =?utf-8?B?c091UVdWWUdOTEhSZGZIaUF0Sm9tbUxiS1BFd25kUXVBRFVvZEZxdURjUHRJ?=
 =?utf-8?B?RHpIOVV6eVBuVHZFQ0FLZ1kzZ2VuWE9RUWxMbHJTbzhhOVRIRGM3dmEwTkQr?=
 =?utf-8?B?QUVUUlV4ZlZ2NEhCVEgrNEJ3T0N3WFpmenNNbEIvQ3dmUXloV3Ird2FUekxL?=
 =?utf-8?B?K3VDOEI2RUV2UXFlNjdOM1J5blE3bmdZNEhRcUh3WjJmdEFXRm9RdkhYdU53?=
 =?utf-8?B?bmJIY0RKSDlrdjkwSmg0ZFV3OUlLT1pVaUVsU1NiOW9ZZTFSa3kxd2U5T2JF?=
 =?utf-8?B?azAzRER5QkUzVW9LTEZTZCtSZ3l3Q0FCVG9ZK1A1WjdJRlJUdnlzTUlkeWNS?=
 =?utf-8?B?eGF4a0hpTkdIMVRDN2FjZ3pFZDFNdmZYelBybnA0eThTeWh5c29XWVo4c2Fy?=
 =?utf-8?B?OVJJSW10eDdLSWYvOHJKNVpaVGpCclhrUzdMaWxmQUxDQXdmdnF0Y3IvS01J?=
 =?utf-8?B?VVNIbTB1TG9xQUxxUmgrSXUrWVBPQURVSnl6RTFRaWFieG1WRm9qbVdscjZO?=
 =?utf-8?B?QUdVejF3ZEF6aHIwVkU4MWRZSVUxNzFJT2x4cHoxL3dFNHhuTlEvR243N1RY?=
 =?utf-8?B?d0VucjMrWlJHQVhjVjNtMlRaVGtPc1QwSFdVVS9NK3FwaHltL1hjWG1ISThB?=
 =?utf-8?B?eitwcG5XZ3l5M0NWYTlya2dLd3BoQVFpN1hKelU5VlkwOUFZUEFub0pma1RJ?=
 =?utf-8?B?RzJiMDNxU0szOS9PM09YbU9rbFFKTjdRanJ5T2xHWFRsQ2RLK2hNMXhPMTE2?=
 =?utf-8?B?UnAzNkw2Q0NKeGZNV21Nb05WSk5FYmsxcmE4aG1VUGJpMFV5ZmtLa3dpcTcx?=
 =?utf-8?B?YlZCcS9NRW9RZmxaYStOcXk4cHdIdENnNGJzVGZ5OVpodmhEZ01mSzZRRmdm?=
 =?utf-8?B?TlhKaFlwbWN3THNsbC9nTUZDcVg2VDRIVlNDdFhMQzVWSDl6NDh5WXMrdlpY?=
 =?utf-8?B?SjUyMmZZSThIRlYxLzRZQVBDc3JhMnRZQUttVk1Gd2lZSmYzb2psUTdyWlFo?=
 =?utf-8?B?c0JRMTFQeEhPYXRNUEo3eEZoT2JVeTBLVHRmeGVjTEs3ak9haXFiWktPbU5a?=
 =?utf-8?Q?jR8m9y3rnlpLDob0slnuai72s?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f9ca68-7e5f-4ecf-f5fd-08da93e149c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2022 10:35:04.0422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnVT79KVJ6iCLaCU/2tm7NBUgPxko4/G3QISe5fPgqTgS5gxEi4C51CecMoJMusYpwiFiDjA6GXrH1/TDL6XGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8343
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFydGluDQoNClBsZWFzZSBjb25zaWRlciBhcHBseWluZyB0aGlzIHBhdGNoIHRvIHRoZSBr
ZXJuZWwuDQoNClJlZ2FyZHMNCkFydGh1cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IERhbmlpbCBMdW5ldiA8ZGx1bmV2QGNocm9taXVtLm9yZz4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBdWd1c3QgMjQsIDIwMjIgMTI6MzYgUE0NCj4gVG86IEFydGh1ciBTaW1jaGFldiA8
QXJ0aHVyLlNpbWNoYWV2QHdkYy5jb20+DQo+IENjOiBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNv
bTsgbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBiZWFuaHVvQG1pY3Jvbi5jb207IEF2aSBTaGNoaXNsb3dza2kNCj4gPEF2aS5TaGNo
aXNsb3dza2lAd2RjLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc2NzaTogdWZzLWJzZzog
UmVtb3ZlIHVmc19ic2dfZ2V0X3F1ZXJ5X2Rlc2Nfc2l6ZQ0KPiBmdW5jdGlvbg0KPiANCj4gQ0FV
VElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0ZXJuIERpZ2l0
YWwuIERvIG5vdCBjbGljaw0KPiBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhhdA0KPiB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiANCj4gDQo+IFJldmlld2VkLWJ5OiBEYW5paWwgTHVuZXYgPGRsdW5ldkBjaHJvbWl1
bS5vcmc+DQo=

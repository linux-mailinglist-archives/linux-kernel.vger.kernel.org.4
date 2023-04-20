Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4606E8F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjDTKIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjDTKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:07:03 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1130ED;
        Thu, 20 Apr 2023 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1681985177; x=1713521177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AKkabMpw2g1JI3xL1y/OYBKDaiW9x4DbO5zXhrTgimU=;
  b=qtY8VLL2p6Kh9yElh6GEuA69hecviibTZ8Q+Z7UB9o9XlfRXNmHGIdXh
   /ITrmGQ4cNBRHlz+2y9RnwBRnzOwSFHspYD7qgSxm5LwZ0inqusLMTYx9
   iioPYCutKMrEY8wKDgWXQQL5Aaue9hvv82tDjAq6VHTZAkw/N0GzpaF8K
   ycmlgHxlPFWoQdZvWzeiDGlfzi2WjVWWgrKa61BC6C1/XMt/I8ogKlrbp
   /Qihn5sySxt8ObOUUtItcw0v9ZzXv4fvHMwU+59959S+pvK3Oh6X3Uz5x
   daaTHk/OLokl9sXzNua4oFvwURDdmOq6YKJUMTjk8F86QEeyMyJeYybaT
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,212,1677513600"; 
   d="scan'208";a="228847671"
Received: from mail-bn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2023 18:06:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA/MEfta5W/j20LCnhWea44gL0HnhJj00WxEGITjllypQN7I2rEcxT1OE+pr62RWU7qa5bs7CBq8LVYtnjY+pZtKlrQs6Uha5/hWcl2XyARHSOpj+/F2aPTjR7rnuz3JSc/PmXQ4GGyszBWZdGnhkQoITyYV6WXqsae8EHmvUeLNi3TQaUPontd/eih5AqmaZufRFxiBglGwAhz92gFoIKOH8Vbhx+eBOvXINTDCB8YkYIwLwULhsitJNsHqd5plGAoyjPGzY3bak4v42K1OVK+doRRxvDasAyixiV8R2ttGxe2i+hSoS5QQOQClnuW/0sqfWkuVVAymHyGN9NVXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKkabMpw2g1JI3xL1y/OYBKDaiW9x4DbO5zXhrTgimU=;
 b=PE+ruvlAoqGaLKeMuhR3B/sZEcoBztpJsf7MAeo2UKk/W57DVSzy9GlMqXWAlcpZ6ZPNv4sarcATbJ4LOLqhmhK3lX9JpX04FPUXVDtYFbIwHBpEsBKPfiIZgPNBk0cd7oC+YdSzQT/Z8gTUBoBRp9ge56jkB1uR7I8RzW3dFTzwYJxSFi3TYR4t02AATY8AVtb/TRc8EOpm4VcBJXR/iekHL09jJWj16mubybHY248UpUpKTQsP79Vg1QH1XXOwNO9u9Uny2GoE3jJl1NNxpA8SP8lZBKMBVZ5koLvDmyFy4d5P2/HUqkOV2IOeUrLOwtn9zvUxOXAz7sM6dtWlKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKkabMpw2g1JI3xL1y/OYBKDaiW9x4DbO5zXhrTgimU=;
 b=HmFiwBLFjw4iLtoOnDsaCTUSLfO1yqJ2t4vxLqVM6nIgj3+Cp0TJC2fMuDtZ6yZtz9sf3q+S2t9NAxz5qdAAO3TfuKH25KAiq9Om74L5uSBwwQGQ61WhJ+cO1OugB1rkElhYuzwEmhek9q11bKzm4CPkHgplsOf8O79ZwwDAgwg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB8018.namprd04.prod.outlook.com (2603:10b6:610:f8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 10:06:13 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%7]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 10:06:13 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: RE: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Topic: [PATCH v2] scsi: ufs: mcq: Limit the amount of inflight requests
Thread-Index: AQHZY6T/4Blt3rJSVUiRYWFGAGGxLK8ZS/iAgBrLETA=
Date:   Thu, 20 Apr 2023 10:06:13 +0000
Message-ID: <DM6PR04MB657568B03233E8CA7DF4BC6AFC639@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230331074650.75-1-avri.altman@wdc.com>
 <989d6e48-c440-5bf3-6fef-c0c76fdfc3ca@oracle.com>
In-Reply-To: <989d6e48-c440-5bf3-6fef-c0c76fdfc3ca@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB8018:EE_
x-ms-office365-filtering-correlation-id: 4a53fad5-8e20-418b-ee7e-08db4186df6b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MqjmWuOVK2gx4jJRomLBPQwVTcpA0Hs5YLII5tIPlWxQawo63FXMs0vFntVO3XPN2itSK8lbwVvIGYsdn7sZMPtxJjsI4uKZX37a0Vf/ZyKtS7zAcjA6FvQFXLGeRtIiUYT6vHpKd9pGMlLScQBsBEhM8bX9aH8OAhH3FMm30AaqVXbf7at/fMfAbaJplXJV/o+4AEynd+66hDcfCIzILqFv7W/+YaDcnHX2LoV5HPBEl8UXkpLoIelVj9ytLL/ab/5MXTpfXYdK0sz1yE6NMLF2e7oO6MhvcNxOdNiJ9AnWXscEPVvOJKS+aDeNB5eJV8ET8fU3rqQx+C51b/3NQtwkCgHAZevCwrcr4WP/5si16tyLwEZHvxnRBKAcNNS6rGsG/CtDKsYrYLPsD8S/6yacmEKfG6DPrZveTmqREw0HUYNN9rT0snkCf3YqF6xJOw1j2bYol/2B8kuPSsumIkCezGgbo6rHz7AweNijGrWcLe6kED95E6y29YYH9dYS7y5rTIC8MFAt2Tz0jy4xvKjVty1BC6BK5bN0MnhUDfgFSdgKT/0lUAF+HXKTc6GSIed1gOCjaPutC+lhYiN8fq4d7Q31Mz0YHJD05+yeRMOJu4Rr43KACLT0/a4c6ARD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(122000001)(4326008)(316002)(64756008)(54906003)(110136005)(66476007)(76116006)(66946007)(66556008)(66446008)(186003)(6506007)(26005)(53546011)(9686003)(38100700002)(83380400001)(5660300002)(41300700001)(8676002)(8936002)(55016003)(478600001)(7696005)(71200400001)(82960400001)(38070700005)(33656002)(86362001)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmlBaWVqZS9Gai9CeVZXd0hlckEvQXJ4aUJxWUtsMFFDam5VejhKbXVmM3Y5?=
 =?utf-8?B?aDduQVF2bEEycldPZktLYzBpMWc0RkUzUHJQVU5kdU1LZlgyOTlkQXBuMjNX?=
 =?utf-8?B?R2NYZUlOZVR3bStmMkdZNHdJa285VFhnZ0pFemJoc1p1RnhJTVpPRjAyemQ4?=
 =?utf-8?B?SEppVk1Ha1JWUVBJaEF4MEROY1RFQ09QNFIwRVJ4ZzFVQWRyam9PcmFqZWpX?=
 =?utf-8?B?NlJMWTZJSklEdnd1Y3N2cDBIYmJaQjhjQnhUNEs2TTNFVVFrWEo1dmJnRUdm?=
 =?utf-8?B?Y2txUmNtVFIrc3FTS0g3ZDAxVUJBTDZSM2hoYk5xRWNLTTVNamFvTS9PeElR?=
 =?utf-8?B?VGp3Y241YmdtR1RoYmxRL3FFU2xQZEJUSXpqSUMwVkNveWJqM1JuTkp2TkJk?=
 =?utf-8?B?V3Q1RTF0MWNtZ1hYOUZadFQwcGdwdldtRlFmUG5JUHNmVTRESXkrQisrOTFC?=
 =?utf-8?B?NGlWbW9IbmlwSzZVTVkyTFdBaXZGajFSTzRSNWdtYTZvQ1dNb0FrQzEwUkJs?=
 =?utf-8?B?LzMveGxBTFk3dVFXWXJrTTE4ZXpOR3dlalV2aVI0amVqMnM0bEFPY1NNZ3Vh?=
 =?utf-8?B?WTBkTytvSXFzSWFtWkQwNG9rc0hVNkNVMTRrQ3hRQytYUjV0NkdhNldrUUk3?=
 =?utf-8?B?VDVHdjhta0ltRnY3OVorbU4wbGNaZXk4N0M5c3RIUExHTEtUVVhza0s3Zndq?=
 =?utf-8?B?YUxDT0p2a1FyR2hmN1VQL2htZllQWXhOc0lDVFUvM3dHTGlVYTRTT0R6dEpj?=
 =?utf-8?B?bm10alZZdnhqOFZFNmZFSXIreHRBNy9Pc09JOWdkZ0NGVStETnJjQ3hpK2dM?=
 =?utf-8?B?RkE2S211KyttVWJBcDNWa0NnR0d3Ym9yN3NNRDdTTXZnOXdjTmY2Q1RteHFl?=
 =?utf-8?B?QmY5ejFtVC96NFdNTkU5N0d0QllkUUZhNitiSDFXa1cwaXJXc3FybjFtU2Nn?=
 =?utf-8?B?NndYWHhORktGWGFSRGovY0RTaGVuUVFZMHBPVEZRV25rdXU4L3k2dk5MRUQy?=
 =?utf-8?B?ZHN2OElEZzhTOXJTU2RwTGpaYU5sanlwWWpuQ0dFaUQ0N1RPNFBGOVpYMVE1?=
 =?utf-8?B?QlVRekRIcVdmWUk3TU5DRmxpeVZHcDdLZk1zRG92N3V4YWR6VVhnSTBFbHE5?=
 =?utf-8?B?TDB0cHE2bG51S243TktMdFhuVVNtZ1ZOZ294RkZNbGFpSFA1eHh3dGpGSis4?=
 =?utf-8?B?VzVacEtGZW9McWZ5SzZoWmE2TnVzZk1IRlVScHZyMy9uSndXT0N4VGcxMUxK?=
 =?utf-8?B?UTNzdzdVMWRiQkVvTjFQLzlBVng0ZzlrVnh0MGZIUWZoQWpkd2ZoMmV4c0kw?=
 =?utf-8?B?d204bHVnMmV6NVhtTG9LYUtjdERxVHZ4eStTd0ZTdVVtMEtlRHpEeGUyeU5h?=
 =?utf-8?B?dWFXV1BnOGRtc0hOb3lnQnNRalFaUmRLdVFJNmlsY3NwWDZqZ0x2dk5wZ3Vt?=
 =?utf-8?B?amN5TE4vQlRCNjlueG02MzFzYTVGaHpSM0w1UHNtR2QzR3B6eGZiNmdiVENz?=
 =?utf-8?B?YncwYnZJZllsVS8zVkhxT1ZMT1REc2M2M1ltZnp3Mkt0N0hzOXpuVUNYL2Uy?=
 =?utf-8?B?WXIyTXkyN1doZ292cXdaTC9kTkJkejljK2h4RmtGaURaa21EMDNrejg0aEFT?=
 =?utf-8?B?Sm5zbk1BaTlDZU1QRHpPVDBGWjRnakxYbHN4eGQ2NXZRdk45U1VrZ1AyVCtX?=
 =?utf-8?B?bUVTVVJidW96dTNFRTI1UGRNeExDZ1hsdGpDQjNKc3ZoR2E0YjRxbTVhckJC?=
 =?utf-8?B?MG44TjdFbjlIb2lRdGtlczhIQmZMSEYxNml5R0FjVjdPcnJVWnJRRlFtblB3?=
 =?utf-8?B?UDVzc2hyM3lKSXhudzBzMkJJRlBxT3l1NkZpLzFUUWV0dGpCYmNZYzhGWng0?=
 =?utf-8?B?Rk04bnpNd0pwSnYwVjc4aHY1cXl0ZVhJa1FFWEZ1VjA3NUF5QnBncFcvOHdZ?=
 =?utf-8?B?VUVFdVdGZmk5bHMwUkI3UkVTUVFHZ3IyNnpmdHpScnYyTFhvcU5USmo1REFl?=
 =?utf-8?B?WHBVUlQwQ2VxcmVNY2ZRYUpncmRYcXkyNFJDR3plWG5lT2IwQTlWZHhwYm1R?=
 =?utf-8?B?NjdJOVYwR0x2Znp3ZTkwMnRxWkoxVzZld05vQW1oOHZNaWVNTUlkV2ZiY3BR?=
 =?utf-8?Q?waYIzQfnhSnCdiJe1GA05dmFY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VkUC+bErIliqYOvzQUp/pMJA7B7FP0wF5f0OxpqF4Rppt7uutAIOygzCUT5kolGAJl00KM9iwBjBmY4bg6UyL+7SwikDP70H6pBPLqLUUIY8qVmnOw1ehodpjb//d62BZtXGT9FYWubIwupMn7lvzv1oq15yHPtHCkv1KEzCHsJ6kveRItMLxHGy5e6jCYc8Br8Y39fvyXv0sd4mBkRAmdmNMt6nrlyaYs+e1ktGwlW3YEiuX5iowOF8I0DWgEzO0XQ5OzJTHDBuXrpV3pRG3Uw9CDdH0LzKuEXmwW2+xTASGIE6TF+DpkQug1vB8YAYDOuEMqqr4OIN7ZeB1JfVVssfTc+5w2Ic5EA6nfNd/eOKwiRbvc7yzdQIp1Kybjpds7UiBD2lpJGPwSlRuBDNobV9NQncY9bYJHBhnzmATx2ppQdPagJivRD2vrgycF8/MFNMz6v/3uJh3HROcQyPC0LCWZwXkNTb5/pue5Yup0t1A0RVB2IUTQ9ZlJqPIbMu6oZXF+yFbCfERATCzzD4znIJTSlpYw16ZeVW/ReDgRv0J18BqlUDK+XmHooMYkf6d63EB9Xnavb8FYD9zIk0VjymodcrXbiiDiloKqZ1vnulEUwTZ8g1vs+jqvLx4SApQTnSDMtN4pwaCGiwTVrMTu0PISSo1fJIMVXHRLDoSZ6uQZtR7m981fCFxBBFwvFQOIPUqjbj7PBx5qPT3CQHjKZMGDQLkKEXTAw5L9mLIBk6VM235yAM8md5/7GRuZWqsWtvk2+JSn61WeLtFKUyORj5AiISli6lvHvZfYuWYtXos9675SVSz6bMyovd6VJ147z4txtriS28N3KFyecRV9H11pa+InKoJ8MrzJRSJa7yaM+tlLW2Ok9AE9Ib/6veiCDETso9Nul3GcHZeBd50FMl8UwDaJR1GADHAotgIOA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a53fad5-8e20-418b-ee7e-08db4186df6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 10:06:13.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yy2Bsr8rQJ76UMPwRCWX0GGP4U2SdSSEyIR0+6cAUhnK37Eysx69GKsL1XAM9ZXdywdkewiYDbdI8FECDEtDMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8018
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiAzMS8wMy8yMDIzIDA4OjQ2LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBpbiBVRlMs
IGVhY2ggcmVxdWVzdCBpcyBkZXNpZ25hdGVkIHZpYSB0aGUgdHJpcGxldCA8aWlkLCBsdW4sIHRh
c2sgdGFnPi4NCj4gPg0KPiA+IEluIFVGUzQuMCB0aGUgSW5pdGlhdG9yIElEIGZpZWxkIGlzIDgg
Yml0cyB3aWRlLCBjb21wcmlzZWQgb2YgdGhlDQo+ID4gRVhUX0lJRCBhbmQgSUlEIGZpZWxkcy4g
VG9nZXRoZXIgd2l0aCB0aGUgdGFzayB0YWcgKHNpbmdsZSBieXRlKSwgdGhleQ0KPiA+IGxpbWl0
IHRoZSBkcml2ZXIncyBodyBxdWV1ZXMgY2FwYWNpdHkuDQo+ID4NCj4gPiAtLS0NCj4gPiB2MSAt
PiB2MjoNCj4gPiBBdHRlbmQgSm9oYW5uZXMncyBhbmQgQmFydCdzIGNvbW1lbnRzDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgfCA1ICsrKysrDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91ZnMvY29yZS91ZnNoY2QuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4gPiBpbmRl
eCAzNWEzYmQ5NWM1ZTQuLmNhYzdjOTkxOGM1YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Vm
cy9jb3JlL3Vmc2hjZC5jDQo+ID4gKysrIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiA+
IEBAIC04NDY4LDYgKzg0NjgsMTEgQEAgc3RhdGljIGludCB1ZnNoY2RfYWxsb2NfbWNxKHN0cnVj
dCB1ZnNfaGJhICpoYmEpDQo+ID4gICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgIGdv
dG8gZXJyOw0KPiA+DQo+ID4gKyAgICAgaWYgKGhiYS0+bnV0cnMgKiBoYmEtPm5yX2h3X3F1ZXVl
cyA+IFNaXzY0SyAtIDEpIHsNCj4gDQo+IElmIHNob3N0LT5ob3N0X3RhZ3NldCBpcyBzZXQgLSB3
aGljaCBpdCBzZWVtcyB0byBiZSBmb3IgdGhpcyBkcml2ZXIgLSB0aGVuIHRoZQ0KPiBudW1iZXIg
b2YgSFcgcXVldWVzIHdvdWxkIG5vdCBpbmZsdWVuY2UgaG93IG1hbnkgSU9zIHRoZSBob3N0IG1h
eSBiZQ0KPiBzZW50LiBSYXRoZXIgdGhpcyBpcyBqdXN0IGxpbWl0ZWQgYnkganVzdCB0aGUgSFcg
cXVldWUgZGVwdGguDQpUaGFua3MuDQpUaGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzIG1lcmVs
eSB0byBkb2N1bWVudCB0aGUgdWZzIHNwZWMgcmVzdHJpY3Rpb25zLg0KcHJhY3RpY2FsbHksIGl0
IGltcG9zZSBubyBmdW5jdGlvbmFsIGNoYW5nZS4NCkkgd2lsbCBlbGFib3JhdGUgdGhlIGNvbW1p
dCBsb2cgYWNjb3JkaW5nbHkuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gVGhhbmtzLA0KPiBK
b2huDQo+IA0KPiA+ICsgICAgICAgICAgICAgZGV2X2luZm8oaGJhLT5kZXYsICJ0aGVyZSBjYW4g
YmUgYXQgbW9zdCA2NEsgaW5mbGlnaHQgcmVxdWVzdHNcbiIpOw0KPiA+ICsgICAgICAgICAgICAg
Z290byBlcnI7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAvKg0KPiA+ICAgICAgICAq
IFByZXZpb3VzbHkgYWxsb2NhdGVkIG1lbW9yeSBmb3IgbnV0cnMgbWF5IG5vdCBiZSBlbm91Z2gg
aW4gTUNRDQo+IG1vZGUuDQo+ID4gICAgICAgICogTnVtYmVyIG9mIHN1cHBvcnRlZCB0YWdzIGlu
IE1DUSBtb2RlIG1heSBiZSBsYXJnZXIgdGhhbiBTREINCj4gbW9kZS4NCg0K

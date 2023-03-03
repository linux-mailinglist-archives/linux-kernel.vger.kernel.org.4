Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7596A9683
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCCLiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCCLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:37:59 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682115F23A;
        Fri,  3 Mar 2023 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677843458; x=1709379458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41XbnRnDJv9op1NHZiCJA2i2Yli9PX1X+sM+Hvz/Kx8=;
  b=nFoY9/tr7yjIdGEKRNKktjA2bGLgkWIjN+Fh5NelBGZzB0OttFETba5q
   +UGRwrRbGxZa/FQ42sDIJ1AzHCoSYLLk8mQJLc7KAWTf7qFdV3N/UyF5l
   phAm/+XY/Ch39EdpDB0qV5mDi64YFhf0UEq75M+FPYX4qOobrxQE2aoth
   wNoj4A/gOY3b4cn1vdudbCO01XrYVS6/mdY5CYm0qI2ygMHlSb86+zQ80
   PBnYOB8bSPnEB16FlN2vWFurdpIKo3T5ZCsvdIozjw8UA+Pp+lt0k5ZZe
   PMOHco+r62bDM6IQXxgk2s8sHw1DUCR2rOYRrhbix1pNp/m4VQtUi07h8
   A==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="329052555"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 19:37:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM/nIezdPC2Q1/EyxLsFtqdlYg76eDzfdlMM+2SHhPz9/BuHrEwn5jub3SDZqB0mIVCOIkTdDMsj3nwr0s4nc81P7kodaiuSJ6sCB6rdX/QYqZ+hyQwXl7jtVi26Mz+OJ6XHn4qBP7MlFWC5yc0TpTxVcn1zFTt0hfrtZR0xOf4PuoY0sQvCcIJNd23zIxr/Y8Y0jHKiYgdocUuFxsTVhWxdG5viivVe7CabW4Vp9jdlF03skk1IuUpUJW0/nnR9JVaw1DGAadXers0jSgIQMmP+/nEfucOlPe5KeV9XFkt0+bkymUkB9gc/fsy5mS5YfFYhfW8LUvaZevAAjlnD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41XbnRnDJv9op1NHZiCJA2i2Yli9PX1X+sM+Hvz/Kx8=;
 b=eOwG1+pv72XqWGXxmQOgt6knva0wHAnDLUUoMeEuK4beueFzst85Di7MlcSIot8vxkWDULoBiyvwAM+P9tGygeu0aw8pJeSJk2KLrJzpc+FxP9b7QYJ4xdMLx1jVOIQAyYWd1GjKgsCPpCD3grSvmf3O1unKI0vgY3xXdJtIwWwmqxCgqj5lMH+3zKO1vZIxtYIO9cByO/hHUMz7/EIx4C/we86sXgeJly1tNp9fdYB90Eqp49oSXxdINybOTohak76USOx4c85tw+XkoppE9W50oXS+vToi5wutgLC0yzB5QQ4oWUiEdgawIN6ahs4a8d+aejINRTtIMKd2SgE3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41XbnRnDJv9op1NHZiCJA2i2Yli9PX1X+sM+Hvz/Kx8=;
 b=zpfr8YHfEk9tJSId0QPBaHtyo4JZ9NpCL2+WeQX/2EdVBvQfxPuMXWTR1PtH3NxBwe4g6ou6I2SS4yxp6Gmxvrh20ERQ4E/zQbtvd4V5WD5jwJyPOge2gYm1vKCEjJEjQKHNpqa1yijOZB0cjNTuHasH9nB3ohvKQlZg707SPPw=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8494.namprd04.prod.outlook.com (2603:10b6:806:33e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 11:37:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%4]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 11:37:34 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bean Huo <huobean@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVlmdiu5jdy/kOzGvaaPem9+q7nldUAgAE27gCAABiZAIAABebw
Date:   Fri, 3 Mar 2023 11:37:33 +0000
Message-ID: <DM6PR04MB6575D261CD93F52C85974515FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <58bb34de-e333-00bd-ae3f-4ddf0e56aa5d@gmail.com>
 <DM6PR04MB657530D5D51EF32A442C1409FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFo4_qgHycq+MSqMDKMJdqwyf8w=dLm3f_sFQWz30S9EJQ@mail.gmail.com>
In-Reply-To: <CAPDyKFo4_qgHycq+MSqMDKMJdqwyf8w=dLm3f_sFQWz30S9EJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8494:EE_
x-ms-office365-filtering-correlation-id: 0e98a2a6-ae05-4698-553c-08db1bdbae4a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmnTXKFp/do4ffNtR5V2K7qUWzt9m7/AZZPl7HwvMpZv8cNsF1dy4O6uM/Sad+jGcPPCSRhdFRxTZLa9JdSgVsSm5FKENZwIwPjfSJf0d/UsQGPrC2asRjsX78Oap1UsmzjuqojnTrex30Byk55xW3eJ6HMRoIS3in9NGcHFM7FRIsD7Jq5zmSgTPsaq3Xhvn/P/8p+bQq909TaDt82LgTrgtMmiYlfCY0xfyn9NGUZZflR6jyZSXW+BUT8olARjUDp2j2NTiao6NxIl4j97b1pVaEvUD+sTx93P3cyZhD7oHPpxtbMFk1S3iyPD7/1FvoaxsMhjOby9atISNxmFLPSroY8UTWoIk2F1tf95jCpnGPSBu4l2m9cI35JLcwSZ7JQZ1VCFxxtpUcPuirK3k8HNtXJ47xPcF23GJWpVjemNxOQYFcEvrOvQoYiIQ8Kelb63q4UO8vH/t/HsewSMb+2Kzx3U+ClaT0F6QvrfRAaTN7uftJ4xmjFZoq+huuAgljvmBi7q3QPUaIZy0XQAbVc/KyDeAEpvxqCLCWZtBOi754TK4LQPDHXbfZmB2dfeP7il1Q4Z5/Ru/wZG7OMvq2Xk/RZpk2b61Fsjbj26TLvdp2SI2g28EcNuHfC43OhnyW8sy9GCMB4q/gh1/anfkVmRcC4M4l3rXdcQOHzVy8vcqXAwyESKm60aXWVwppqiFcx8n07aVYNzIw+cak3wY4R0ftVmUoKbGPlt+wqVqWU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(86362001)(64756008)(66556008)(9686003)(55016003)(41300700001)(6916009)(53546011)(66946007)(76116006)(186003)(66476007)(66446008)(8676002)(8936002)(33656002)(52536014)(54906003)(4326008)(122000001)(316002)(38070700005)(26005)(6506007)(5660300002)(478600001)(7696005)(71200400001)(38100700002)(82960400001)(2906002)(83380400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0Z5Q1hVc2hiWEJiMXk2SThPUnM4U25jUzJhNVluRVMvQXJiaks5a2Q2TEx1?=
 =?utf-8?B?SVhxSzR3ODRPcm04bkNCSSs1M3hXSUpDRmJjY0piQjlaVlpGa2JuOWZpbWZz?=
 =?utf-8?B?eUMrbUx2YXp0aGRFNzJwYWFRL0c1NE5BVExpVEtzbFROWGQvMHFTanBHWFZt?=
 =?utf-8?B?VlltckxUUWJXWnp3US9pTVpQTmRibk9kMS9lalczUmZmY1JEbTZ4WkVUSUs1?=
 =?utf-8?B?RlR5WDlQeE1qZVUwamZuZktyQXA2MitKai9uWDFZRTRnQ2dqSFFUM2lKMTYw?=
 =?utf-8?B?WU92T2JZZUEyVmZVMnpDQTlJVUZKK2RpSEUyNXdBaUNoVTN2cjN4UXhJVlgy?=
 =?utf-8?B?dWJzWUVzYk5TeDJCeERwMWZEbVdMWkZmMWc0MjRDdjN0bzVxU3hYcFJQNHBE?=
 =?utf-8?B?Yy9PV3k0VkRqeWxJNXBQQjhuemZpMDJINFMvZjdQVVhra2RkZ0xGazJkMFAx?=
 =?utf-8?B?M3p1N09ZdFBBRm9aRWFzK1pkY3VDampLODRNMUVBdk5yQk1NenBISm1YYVBx?=
 =?utf-8?B?Tm5BRk9majZBbi82bXVrN0Q2OHZNSlhsL1FHVGN0QWJEMlpkQkxRQmsra0Rx?=
 =?utf-8?B?aHJsRjNFN0JMeVF4a1FpUE1SRUhxSlBaVzVGdjFpN3MreFNYWFljR3RCdGR0?=
 =?utf-8?B?MTV4SWREUlVPVFpxQ0hHaHVFbWE1MGlsOXZKTWMrcTZEM3FyckRFbjZIUUdn?=
 =?utf-8?B?SkJFVkd3c2t4ZzhEKzlVV0QzdTExODR6cFAvNVBNczRjS2Z5SWZQMjFrdFpr?=
 =?utf-8?B?VFAwYm1BQVdjbXh2UVJXVXk2a3ppVHZXZVhETXBNLzhLa1AyTzg1RDdwbk5j?=
 =?utf-8?B?MkVzQkI0V1VHWXpIOUVKZlBSWG9LM1paRkZXeVVvcW5kSW54M0gyZnc4d1Fy?=
 =?utf-8?B?cmo1Z1NkbkVUZFFJWmVxOU5iTlUwTkNFaDkxc01lTC9wSGN3S2NmeWluY0Q4?=
 =?utf-8?B?R0VWQVMreng4V013cDl3L0tSV3BFd2lSNjY3d29rM3c0TTgyLzdzdjZxeG81?=
 =?utf-8?B?WUZwdEl5UlA5Q05SeG55QVlLWmdOTE4zeGl0Lzh6WjNWVUNyQXZteTIxT2hL?=
 =?utf-8?B?ODZxUnV2RTg5cW1nRWkzMENYeDZxQmVHNkg3L29acm5oVXYrbXNWOHduck9S?=
 =?utf-8?B?M0pmYU5KUXVxZFNGRkhVQjYwakJocDF1Nk9wU3RSU2QyZW1jMFNJZ0huVlVC?=
 =?utf-8?B?cGt0eEZ4UlM1NHFyVWhJL2xETXlad2tXWFVNUFlYVVFsNTdCUFpGOFFiSXNz?=
 =?utf-8?B?UjJhZ0RIODRacUF4SzBVZHowN1R2VjVnaXk3aTZxT1J5OGV6Nlp6UDRWWGpN?=
 =?utf-8?B?aWFhNVBMMzI0Q1kvTFFVMmsxQTUrMG9MSWgxYlVkMUZYWlFiZFI0L3YySy9D?=
 =?utf-8?B?S0ZMUkgyWnlHTmRlNDlTV3dUTCtmZDlWN0tlWGs3UkVPeVpPUFYwMnFGblB0?=
 =?utf-8?B?a0FxM3lieGxVbUNLdTgxcmphcmI3SVdmSWJLRDNWbjE2WWcrTERPMXRNbFNN?=
 =?utf-8?B?aXd4NUpPYkd2ZXl6dTVaaUQ4N09HTXFoZ0tOOFFuZ1Q3MHdZYmUyeVNIdXdG?=
 =?utf-8?B?M05Fc2x3YTFwVTRZZ3lTRTR2MHdOeHc0c3pMZFlnNW5MTUlWMEFZVWdRd3Ax?=
 =?utf-8?B?K0hGckRiUmJEYlNoT0hLY0ZWTXBjSDh0M1lvSlYyYnNKdmRkaUJ5U0F2MFRx?=
 =?utf-8?B?WkF5ODQySktqSlQvVUdZNmdLV2svUDNScTdPMTU0U0JoZlAzRzZGQ3ZLWVR0?=
 =?utf-8?B?dDVCbUVSaTdxNlJ0SXFhSlhTNUduMDhtb3pIazFsWE4rWWZiTGQwbDBHdm9E?=
 =?utf-8?B?d2h3aEMrYUFoU25udGw1UWUrdHJuK3FGckZKL2FoYXZpNlB1S0xUZi9yUlJz?=
 =?utf-8?B?NjVjaGFoVmlIU3czd3E0TkZlMEtVbDdRNE1YbnJ4OWo1KzhRMUZBY255aEtj?=
 =?utf-8?B?UG1VNFlOZWhFR05GSmcxTGVMWnJlTTcrQ1hWQU9qd2x0ajBsb0ZnQ3h2bTht?=
 =?utf-8?B?a3VZOWs5UElkbVFOL3lBN0hQNlcyV2xwWE04YlBzMFRLN20xbVgwdXBOdVEr?=
 =?utf-8?B?eEdUUXBKdDZ5aUFpNTQyZmFQNU1RRXJKZzF5dUkzM2ZuNkxWa2ZTWVlsd0dC?=
 =?utf-8?Q?u00ypXGCk1M7JG74mz2suV2em?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0liU+C87sA7HhuWh9lCCBp9savQ9ZnL+5rxgae3/tHdUvsMPwYilOXsvGkCqioLPcsjdeICrOVcf1CdKZW8JMSgfaQTa6hHx30Fb6xFhMyvarUlJF35BGHPHt58vbaHw1hV3+gx4TodW2wetlS8wANZ/+eetP1ys1oaoIBibBU+5zSY1xMSaxyFgN5fKHizsR0QDwjJybAXnyIjCsDeqx1+CCKYbP/x1hSSHNnQUJo7ZPXiMXCiLICbTTTc4oQz55MwTIb8xyeDJrpetWVNAJV7HmEdJuKqJ00DC8/hmu2qlw4S+T1O570lTttk7h7cYRE8AIKbJi44pa7fFxrJKOMw/bZ3d/LKFC8s2jqXzMNBiokkhjhF1gsZBZxdW+v0sK+9z8oTuuhu3Gyz61T7XguEvYU0ftMWai4mZqSl4l1SQlc95HOxo9QzkAyHMO+YTIW7JU17unHJO9RiluMbBA2Sv1EDp8vumrNKUlZIe4P5aSp2OmAsK3nKtt4a8P55RH2FAHbpQ7rifzfJfTh6EP02We5BHZh4LKCwm4FVY5fHPKlLzxYvVP6f/veQPq+yKC5wMZPkg4MiGhE3d7KUo3t/kmQZIyygsC69oFd/p7XSXCjlirA0MtjUn+0XKXJdR+IZDTiosdaRJo6YikVABLtG8JlLfuRPpa2/ZyLvRFvX8v4OwwORpF8p/lLmAPtVW/O7qRypITxsZra3dHOysGzT7oObfCWDLrFQ4yk9N4mArPQoDw5DaoT000vnvvDcjSN1A4/e8Er+F+2iZSx8HMdNGOh25Cw+jS07i/emQcsI+1Wpxidd7poNTvEz/AKI6noKLSDeAvhoNkUClLClfrqWB6hqCyRMYpwEi/QyMKblT4ZgHXqAnweTPXjS45dPA/bDSJ3LB64PFrz8GPBjnMRlMqwtlptRO3Ltf1GIRZAQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e98a2a6-ae05-4698-553c-08db1bdbae4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 11:37:33.8795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EKwq+cSlixizOvqmhGc3GIDoHva4jMo9W+FbGUyj1nNyhb6PNrGVxJF55TH6jPN0Z5hYsICB1IhuNN9z0AIJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8494
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIDMgTWFyIDIwMjMgYXQgMTA6MzksIEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3
ZGMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gT24gMDIuMDMuMjMgMzo0MyBQTSwgVWxmIEhhbnNz
b24gd3JvdGU6DQo+ID4gPiA+IFJFUV9GVUEgaXMgaW4gZ2VuZXJhbCBzdXBwb3J0ZWQgZm9yIGVN
TUMgY2FyZHMsIHdoaWNoIHRyYW5zbGF0ZXMNCj4gPiA+ID4gaW50byBzbyBjYWxsZWQgInJlbGlh
YmxlIHdyaXRlcyIuIFRvIHN1cHBvcnQgdGhlc2Ugd3JpdGUNCj4gPiA+ID4gb3BlcmF0aW9ucywg
dGhlDQo+ID4gPiA+IENNRDIzIChNTUNfQ0FQX0NNRDIzKSwgbmVlZHMgdG8gYmUgc3VwcG9ydGVk
IGJ5IHRoZSBtbWMgaG9zdA0KPiB0b28sDQo+ID4gPiA+IHdoaWNoIGlzIGNvbW1vbiBidXQgbm90
IGFsd2F5cyB0aGUgY2FzZS4NCj4gPiA+ID4NCj4gPiA+ID4gRm9yIHNvbWUgZU1NQyBkZXZpY2Vz
LCBpdCBoYXMgYmVlbiByZXBvcnRlZCB0aGF0IHJlbGlhYmxlIHdyaXRlcw0KPiA+ID4gPiBhcmUg
cXVpdGUgY29zdGx5LCBsZWFkaW5nIHRvIHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9ucy4NCj4gPiA+
ID4NCj4gPiA+ID4gSW4gYSB3YXkgdG8gaW1wcm92ZSB0aGUgc2l0dWF0aW9uLCBsZXQncyBhdm9p
ZCBhbm5vdW5jaW5nIFJFUV9GVUENCj4gPiA+ID4gc3VwcG9ydCBpZiB0aGUgZU1NQyBzdXBwb3J0
cyBhbiBpbnRlcm5hbCBjYWNoZSwgYXMgdGhhdCBhbGxvd3MgdXMNCj4gPiA+ID4gdG8gcmVseSBz
b2xlbHkgb24gZmx1c2gtcmVxdWVzdHMgKFJFUV9PUF9GTFVTSCkgaW5zdGVhZCwgd2hpY2gNCj4g
PiA+ID4gc2VlbXMgdG8gYmUgYQ0KPiA+ID4gbG90IGNoZWFwZXIuDQo+ID4gPiA+IE5vdGUgdGhh
dCwgdGhvc2UgbW1jIGhvc3RzIHRoYXQgbGFja3MgQ01EMjMgc3VwcG9ydCBhcmUgYWxyZWFkeQ0K
PiA+ID4gPiB1c2luZyB0aGlzIHR5cGUgb2YgY29uZmlndXJhdGlvbiwgd2hhdGV2ZXIgdGhhdCBj
b3VsZCBtZWFuLg0KPiA+ID4gPg0KPiA+ID4gPiBSZXBvcnRlZC1ieTogV2VuY2hhbyBDaGVuPHdl
bmNoYW8uY2hlbjY2NkBnbWFpbC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5z
c29uPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4gPiBBY2tlZC1ieTogQmVhbiBIdW8gPGJl
YW5odW9AbWljcm9uLmNvbT4NCj4gPiBBY2tlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFu
QHdkYy5jb20+DQo+IA0KPiBUaGFua3MhDQo+IA0KPiA+DQo+ID4gQW5vdGhlciBvcHRpb24gbWln
aHQgYmUsIGFsbG93aW5nIHRvIHJlcG9ydCAiYnJva2VuX2Z1YSIsIHNob3VsZCB0aGUNCj4gPiBw
bGF0Zm9ybSBvd25lciBjaG9vc2VzIHRvLCBtdWNoIGxpa2Ugc2NzaSBkb2VzIHBlciBzZGV2Lg0K
PiANCj4gQXJlIHlvdSBzdWdnZXN0aW5nIGEgc3RhdGljIG9yIGR5bmFtaWMgY29uZmlndXJhdGlv
biBvcHRpb24/DQpTdGF0aWMNCg0KPiANCj4gRm9yIG1tYywgd2UgYWxzbyBoYXZlIHRoZSBjYXJk
IHF1aXJrcyB0aGF0IG1heSBiZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUNCj4gc3VwcG9ydCBmb3Ig
RlVBLCBiYXNlZCB1cG9uIHdoYXQgd291bGQgd29yayBiZXN0IGZvciB0aGUgY2FyZC4gSXMgdGhh
dA0KPiB3aGF0IHlvdSB3ZXJlIHRoaW5raW5nIG9mPw0KSSB3YXMgdGhpbmtpbmcgdG8gYWxsb3cg
dGhlIHBsYXRmb3JtIG93bmVyIHRoZSBmbGV4aWJpbGl0eSB0byBkZWNpZGUgaWYgdG8gdXNlIGl0
IG9yIG5vdCwNCk1vcmUgbGlrZSBTREhDSV9RVUlSS194eHgNCg0KQnV0IEkgYW0gdG90YWxseSBm
aW5lIHdpdGggeW91ciBjdXJyZW50IHN1Z2dlc3Rpb25zLg0KDQpUaGFua3MsDQpBdnJpDQoNCj4g
DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZyaQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUN
Cg==

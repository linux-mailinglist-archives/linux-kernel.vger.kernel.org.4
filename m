Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E175633B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKVLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiKVLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:32:52 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2C211C31;
        Tue, 22 Nov 2022 03:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669116456; x=1700652456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tjsLEs2ksCMWUEC39qewg7AR/xeY4nBGGT3gVJzONpM=;
  b=SsBxLTK7pOM7usCZ5US3nBXmMkNUVzdNSkmoJ7+SHRhHdvBeP6XxJcZn
   2CfTybRcGrttHfsPbELZo9iwyloLewVQXWMV/a6v1RFx1A1EaJgkBjuoY
   ym3N1OWQ/A9SWYvtuTiHQ5iVeR5zS3ErlD3Ys3uCBxtidCCo7F4zkbPrO
   llEV2mPWecMJQwUOeZV8Y+PG9QxDk2dIMHzpAb5B4F51xAPURDnJGAX3I
   N9a842Zsep9cuHCrbHQrY8Ol82K1uq3k4iM4AotlrqIz/oRUR6v+NrmU5
   ew5stVqL/zrA3or1BbOb+ZbkNnbXpYWTIUXSs0Bm0oer/T1MZOsZwcZDH
   A==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="217191359"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 19:27:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Z7m5P64Ml0U64Zaeow4yafK2dEdH8/siwJ4UWlVT96riJYI4qXIKEtxg6OF9nfJHFgV8gO8NcM7qoBgo/9+PX+6D++20mRArdp2NRjxfpOqGlHNgNrxebEPSupx8tbHtfwIE4AyJ7rgfYcB+YX3SNYb+EuzRR9xsh8hoYe0Gg67MdKLKypjaakIE0OILcEtV2rysdLn/wCORDmQ8Isd6LSx22JIXU2pvNg55JwqfyX4A1jQOTP9ysXasc0DOm2HrHuuaoXcHbe9cOHQ8sZmfTTM4mpW4k6StaZmLiQ+aDiz9BQGAMSm1YwK8VGMJtb0rbgys3ElTgJ9Jj2CzN1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO39f4lxRCdV7PtYFtIj2XRZuceQTpHtk1V40Clbfrc=;
 b=nEFKVmQ9HbXaqGr9JUJPPrFrTrWKDmzcBOOGCUo4E8DQX+KNLaJ9VVhHyj8S4GXRfUSKcn8AOGHJtrYCKapLMD0V9cP31f77RCcc8TkGyHEQdubrYvXAiNR00JESZgQN0SAR4XkxuUwws2wtcNQYqnFSvmIgBT7O3+N454NatqHx2+sQiYy9/D47tNNFFqZuBdJx3/EnEVGUJ7BocjvJ7yEJnzn37QoBIYOfLawEQ1RyW7iczE9Q8C8v9Su095ZVQaIqrPXS8D2WeGJ71l9ydjX+DdBulfpd5ZvINhHTjTbJf9+tDmtkRok9nOGEO86MwAzmn9pvdoNBgmXo1Iaz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO39f4lxRCdV7PtYFtIj2XRZuceQTpHtk1V40Clbfrc=;
 b=qjlda6HUsTA3iSBfvLSWvCAC1d7o2aoKisQcFUC5WRF878A8tCKGc+fJGPdEsbvUkw4u9WHiaRVViXbib6R4wRhxxGfs0xgex8RJ/t+CGDH3N0/U3v3iPdZ3hssZFczlMFrOKfSNS6EIfPCeQcDvzVFcr41eAWOjrp1sf9dOoCY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN6PR04MB3808.namprd04.prod.outlook.com (2603:10b6:805:48::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 11:27:30 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:27:30 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Topic: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Index: AQHY/S6fGNUnGplQxEOfi3uFlr5Rnq5KyPtwgAAHT8A=
Date:   Tue, 22 Nov 2022 11:27:30 +0000
Message-ID: <DM6PR04MB6575811A8A988896E8738DF5FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-7-beanhuo@iokpp.de>
 <DM6PR04MB6575FE2AEA80828348604AF0FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575FE2AEA80828348604AF0FC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN6PR04MB3808:EE_
x-ms-office365-filtering-correlation-id: 802b1928-88d2-4f10-5211-08dacc7c8b24
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eIsNI8N1BlMqB2yw5r84YJUW7RuPEWhgHG4XSQwnc7q6SQ4U66eznMiuobj4d4VQUFC8hLchIc8a6OXCapKh5VwwPXPdKpawoh8U2s7qM70D7KzNFOmpYEL1q6hg5VVpazuYbtgcZeum2TN/tBfNPv7ZoZ+BUOjPTDklbcAsgVOIJN0vetWkn5pM2x+LN9bXeDdL/76ZlmJ4aCwJsoYl3HMtcbg8+m+/pdFr0Dvb31rRMoitgUWFp1VqO5iRw+CcypemBJ5g5H15knT1nzqzbgeP4avzYpjJ76p6bUicEivuO/xHDNIJo4avU766euhnL/m9MvQFGu5hqAvdkyMKeE7ujp0akzOv+AGfUQ/PjRNZ8DZHVyDbZwmY4ndowlauTPgfiFq79XvHoxuD+CmPZFjynzsbl0P+eIiwzTDz8Se0Pvdwf+cfgkQkm0zAfeyQva9dTG4WfpaSxy8jJ7iuIh1HjiPAyLnU1TkZK+/RTHVC3AlblZIexdLnrDJ3Y4Pe24poDeLPMIWPfjysk0VoaA6jQ/uscqFTYkVgrOaJUyH3lcQrXihETVchyR7fapZsUuMm/lo9dnf1YWxVmi/oOUK4P1ehFEzqUuTPHARqlken+birc81nAONtkn8sygX75PJ4HPC6kopxyMSODhiUCQfXqvIgnfZEX+X6uDV8YZTyCk69jCRLmdZoZxgsyJddRm71j4jui8KBG9I9Vjr8pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(2906002)(4744005)(8936002)(7416002)(52536014)(5660300002)(82960400001)(8676002)(64756008)(4326008)(110136005)(54906003)(66446008)(66556008)(41300700001)(66476007)(316002)(38100700002)(33656002)(66946007)(76116006)(921005)(478600001)(71200400001)(122000001)(2940100002)(86362001)(7696005)(9686003)(6506007)(186003)(38070700005)(26005)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9JkF1KCE4Ub9ubRjHyZPxrFRyI0MGeKaaq4Z+dV8zFvI1DA8SPheiEzrL9kS?=
 =?us-ascii?Q?+bHeFlLeptOedX17448hqD7Mjy6dFfPKoOkKsXSQR/VOfXEXqhu7yhy18hl+?=
 =?us-ascii?Q?8xTDebyRKTJilXx70la0Nq1hElPF/M//XGEG4hXI6YMk/r27cz64RWOYBUvW?=
 =?us-ascii?Q?7P1f4heVtRthGAGCq55iydofE9K45Ph9ZN41vfP8MgYU+f5S01XFAeri260l?=
 =?us-ascii?Q?mYn++G4TRRoHQbApgJ78UL/hfV8HqQ+z7AmEWftUEDX7j13ujifUWrbC+rTB?=
 =?us-ascii?Q?GuQTWs2AFirlkUrw9w+afT0MW6ezj51UD2oDTfnpLCSRXBl7fEK5uO8OUXok?=
 =?us-ascii?Q?/vhMKULQxcC9GhqVThIH+Euv+5Rvl0Z7HlK7VQy3PvM97pmAYLq2fHiyKDr/?=
 =?us-ascii?Q?W74FjELS9Xk/d0mbKUL5mPExuHCXKWk0dbJMVaBKRP0jh7IVJMRVhEQ58zJv?=
 =?us-ascii?Q?GOLk6tq6jY1P3AX/LKuYmpf5DKcNS/NCez8/j75qhsnTQO4aF8UJL6TnJqRx?=
 =?us-ascii?Q?+dGw9WIdEJIiIF0gbWvHPJmKymeozIvoV3dZEv7ai3RbZ/F6hqnfrNnYo216?=
 =?us-ascii?Q?xK/6qw2mMVdW//Iro7RWJe1qyw9W1U9AVCPXQluJv/AjB3skY/dszu110Eff?=
 =?us-ascii?Q?DqzT5Sr//6gsrEopG0Ps5y+uGbOt4AJ1Y3Mwj7oMMeCTiVAyYTrZGsLWndkB?=
 =?us-ascii?Q?zTXMKE2G+ZancAGQU7U/FE2M0h6E9OP6AeTQjupRUHbx0Kad3RBX3g7WyRo8?=
 =?us-ascii?Q?8bkbGO84TsOGk2xa/5hBMFzEREBVk9mYt1npOKViASHSeruFLnIdgBhpR5VJ?=
 =?us-ascii?Q?9IsyXPZp3Wrf87FccIJwwcg50BLuNkdqe3ejS7z6T73XJAJlCHWYRMUl1+gt?=
 =?us-ascii?Q?J85yFR0zojEVANRUxqddPYJst8tzxCjpHihl3li77OZLdk61V/EGy8muQA/V?=
 =?us-ascii?Q?pAdPEunxesn2sssb2AmvXGzT8/5EATHIHz7LzrTJWEYG4j+xMgff1aX1jPPH?=
 =?us-ascii?Q?Ybox37/SLgQyS/gItMs0wHc9BhD7xUpFo5rMAEvs8bDW8ZDYpK1uQy1B0Xeu?=
 =?us-ascii?Q?fkueBLqYrkIUN/Rkf/shr/t5JmToTzFv5flE6mJWtmiVWEXs74YqhCnxJAMp?=
 =?us-ascii?Q?j6bs5CAGLUIgJpcp6/IzmKG8BhSIm4OLWZ9bTyFUlYnDlokPRYRT7pGyxda8?=
 =?us-ascii?Q?ojaJRqJBM7qj55pFKgtB+luI9xbbErxfD1kefwfNDRkOMUUfksCQntJZ7UXy?=
 =?us-ascii?Q?G5z2oEgOr4vPV2WbtIz8Dk+GgeR9051/WjNxNMqGa80AAI4LEIcam7VbYCqM?=
 =?us-ascii?Q?yMt09LzxK4QhCjLZJphUWNB1M8LxWJS05r7ydbOIeyjj6D0bz52DEXUvfQul?=
 =?us-ascii?Q?NjU7i2RZsZwoqQnwWFYQHkEpfVyx1GKzn/96TPsAiwZdlnqIfQ0dV8DIsDpE?=
 =?us-ascii?Q?77qgLdM0nddCqvqigV5SiwWSnUReBfsHCXdzMw09y1iyqrre/dB5FylpDJJi?=
 =?us-ascii?Q?a6iG1I6433+P+Ul7SGwg7ZhEt1XWKYGHAhqwIO6Q3HgPHPHSr3Y/ckuCvyKj?=
 =?us-ascii?Q?JWr8iSxueVb+zcGNBSBGcO9+e8Kj3+94n3MKrWDb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lXu/KgcQJXnkzFJh/PVavqNeJ3zI+7FDE+oSO9jDE1pibYaT/Bn+I8JXBfhM?=
 =?us-ascii?Q?2cm7bIw6pw31ZiJN3oXrzIy5exW6BtOmBqMtUShzU3p6OxDexT8QXJKhoZ2F?=
 =?us-ascii?Q?yo9wKR7R8Iim0831hCXeYnFteSd2zchYq9zWkZVF8LduGjqakpxQdj/fDbmi?=
 =?us-ascii?Q?RnB2uCrQmfQbJIx5Q5OjmH+vvvVgwy6knL7HR2faeMliNElcSdCPNa7khfwf?=
 =?us-ascii?Q?xACvA4xUk/zH7wHyYKFlDifvTB3qoeGd5y73+dySiusjaNWYudS4oCJHEAQy?=
 =?us-ascii?Q?FuKlkZIgowtszAjWglaoijOr0nsIaqHb9Yn4veaIvLS1OBmHrtOGciYCzJcX?=
 =?us-ascii?Q?qSpf0q+eouUps9Dlm/efCwDzjZqcsK6o7ietfQc0bcU7hFI0meCHXx1VLE/B?=
 =?us-ascii?Q?bhA89bgMqCBLsWFpj19J4DxOEsN74R54a46TzRNKLn3IrQhPF84hICdZ9+LY?=
 =?us-ascii?Q?VuyYO2Kmz0FM6jB50RRL+206P8JlMLH/W55AUGF5IaFmRUInkyXMLXw2X2Qt?=
 =?us-ascii?Q?DOddM+QSsH+in615tZdzArp564iYS6rLy7LbEuTaqkHxY0P3jDRqZRuJfhid?=
 =?us-ascii?Q?FQmPV84MqzW43MixBKYcDtoLGb4vycAbbCPX/MEoc72/NKhC+vCUF3qqXTQs?=
 =?us-ascii?Q?btD4Y9sxmglth+85lve18q7Gxws78XlJ/iDJeYCDMy6CHMFEgv9gMH6MhYFh?=
 =?us-ascii?Q?iC5A7if2XQD35RqlptYv6T6EKbMKgyFCesCqL3GkmRdD4pF6K2Wdn8ewGQpO?=
 =?us-ascii?Q?tWI6YNnU9vj1+pjXUdNgAgBHDK4sAgVQRD+/tkoJXofIPPvb+TIvk6+9k4v2?=
 =?us-ascii?Q?VM84Eq+3HvTSw4J6IP35URMjnY8WdCso4e0SSkXgJLKKjQS6zGJNlmHE9Mjl?=
 =?us-ascii?Q?4PiQBVH1YblGxf5M7O+CToeJngvra0uM86I0EiZXDm46uYfSrhxmJXmuPua+?=
 =?us-ascii?Q?rkpqj+A9WyX+VwyozlfBE9/1SRJY1r9Dx7sgKl7zcF1EIS5hiapheSx991M5?=
 =?us-ascii?Q?ScGbj22axKFy0zZscbF8zeTioQwrD0Flai0H3vIfwW6MV3oH4jp0J96GGarH?=
 =?us-ascii?Q?mf6387UcC/QuqXmVUcUwIGPj9UzM5+ZNRQX3zQERofedwinkYdRHQj2PYxGc?=
 =?us-ascii?Q?uzSBZNUWFsgkql9buXI3pgGujwPcWIlwhORH1JLJcxUsmlv6xhrV/yCaD98P?=
 =?us-ascii?Q?V/BLNaEu7Ny87pLIL8PbU0VyrzlelEknXeDJIVg7ybdwEie6qZFcwFDSU3OI?=
 =?us-ascii?Q?9KJ8u2sKZh6h+PgbibTW3UhQ5qf35sq81Pn1pzmEFQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802b1928-88d2-4f10-5211-08dacc7c8b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 11:27:30.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JA34tpr1M7yeiKEXpO8ftGQh3I2yxUcJ+nEb9A1OHtDEZaYKBR5xAkqXtAW44GD6Hmf7YmELLqOut+4MmvnXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3808
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> > +               sg_cnt =3D dma_map_sg(hba->host->dma_dev, payload->sg_l=
ist,
> > payload->sg_cnt, dir);
> > +               if (unlikely(!sg_cnt))
> > +                       return -ENOMEM;
> > +               sg_list =3D payload->sg_list;
> > +               data_len =3D payload->payload_len;
> > +       }
> Isn't bsg_map_buffer does that for you already?
> For both request & reply?
Answering my own question - no it doesn't...

Thanks,
Avri

>=20
> Thanks,
> Avri

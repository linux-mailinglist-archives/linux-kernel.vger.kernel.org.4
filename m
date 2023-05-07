Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC39A6F9C94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 00:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjEGWve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 18:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 18:51:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF94687;
        Sun,  7 May 2023 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683499890; x=1715035890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FINfEmUhlCYIxSi9zFoAy4tPy2W6cexVrq2fDs5sogQ=;
  b=KnIWdGbs4j8mhEfYN1DJ5JpFzsNNynLURvgnYxjiYDhDLM7/qXXz4vhz
   FiYTKjmDMkFwztEUmN5Gt3E1rYy2zhB8JE2Zpzdh21H7qRNLOArzZ7x8h
   cS63zFdhD4stAHrwWB+kji3L7L6u8GN+2wIs7rvaoRns6hIDU1SEm1+5m
   uuKIBxxtKZiInm2dc4uI1Z6QHgAqDMdLE21ZtdfydpuUFikiqGky7fbGN
   rNeNddywgYkDlLy4vQ4GN0mF0Kh4qJ2z8rihISkD53bCBgNHdh8I/hLCR
   7ilnv/OSkLCecSWFEkWiJJUFteVG3DYkwf+if+C/EArRanaYf1n4YrD8D
   g==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="230130590"
Received: from mail-bn8nam04lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 06:51:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLz3XBw3LlGIFh8BfX5EnAZxSaP+lOE/PuMhDmiBYmh6Cea8uxPN1qOPyfPt3PR00dTqsX/ccJB8J7QEdDgqfbSUeDbDD/oL+UqGwBk0hvOJg6v3WmzXmu7DcQuJA+QYJGKWNQbFL10wgAJGENFh4iOQ2xtceA/VsxTNPIaeQxm8F0m3Su7ybkqR7ViaJwof/U8kXINSVu/X5pApjOP3MBpz3LbMho6asSc4MjDDXnDcEZ789vMUgqZheAdP+DGLqF5YmhOf5lY+WQBerP1YSPOy65IPYL2fA4YcK+FQb3PtT0yogLHvim5EIhBmYZnLYRo88R1UxFdqkhRXLkLLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FINfEmUhlCYIxSi9zFoAy4tPy2W6cexVrq2fDs5sogQ=;
 b=WafP7yZLMyLsfHpgJ83CI7GJc5gbKK8q1h7rm03L1HRze2F7++zI/7KAU23fXx86fXJZuxfTX4d+NRTaQnOBHkiN3z5rfD7NKtkXWeoVMnifscS5LIxsw0az+KpEWRGrVqmYhnFMpTbuiGi/afpamnEhQhOnRfongbuMBH2Mojc4ffPZ+GocAvYh+L6TBLrFszCATAABtRiV3+UkTc4opf4LGKqGw7Y9vPeHHF2Fsu9rjAXm46WB80BPFNpQgZ1XbAqgYmBQrEQRu8VlHjjTIhzttF7qhcofeMjcELSe6O+CepcpEINws02lp2jqRiPGPZto4yXi36eHL6FdqmfTXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FINfEmUhlCYIxSi9zFoAy4tPy2W6cexVrq2fDs5sogQ=;
 b=LCCQYj2kbkizHBE/mBdRz6M9zAN5wdpqVixQmMGzMi9mfHXLRXT1QMYkFWrzwfLgvaKtCS7h/KhTWITiKb7YW5/iNd2+ZDSdvbiFhYZmXjPdlyO24drQ5yZlJivc75BpZhRvIp0UOvZEMR3YBatnh0og2tGVAWCAadRYPCm0w9M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7561.namprd04.prod.outlook.com (2603:10b6:806:14e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Sun, 7 May 2023 22:51:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 22:51:27 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 02/12] nvme: Do not hard code device size for
 dd test
Thread-Topic: [PATCH blktests v3 02/12] nvme: Do not hard code device size for
 dd test
Thread-Index: AQHZgTZ05TaikmrPM0WiSILudyZ6vw==
Date:   Sun, 7 May 2023 22:51:27 +0000
Message-ID: <jwm426e5bs2devm5wyrq2htf7azw7cailoljvvs5eninwy4eib@m6hjvnyyhque>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-3-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7561:EE_
x-ms-office365-filtering-correlation-id: c2e57f97-fc7c-414f-66bb-08db4f4d9733
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sv48/XcSlUCtd0G5fzSV7P0ACKzEdGEJGHEAePlIkCbqpLmUEufkJQUqlRGOt6fG5WD/lYXeeOsUk++QnwrJbIHOmtNgAtkEbgnQAGwlfNwFo1kI4ugStnv0a4ZRpcj1ruEeMvODNU4agAMi1dUM/JdCXo8+d2XT7ZNPWQ6eZglmAn3EFFXj6sQPhWjDxzrUFSfOHsb3ORPqXKRBG+G+IoFQJofqr8ErxwDEMjx2CHiceFHsOhNzj59yX1fbxuJD+I0qa7egswAqtpkVX3PIKYEevsErREaiGoqM1BgtiPd4zFXAqCDYXZ1rDjIzp+uyV6Vq/vNeU6vjAc3kgrll9V48Kb6oQE0KLzKbMyKr2NPoVa++PEIYtq11zmzzuqHsSFhOoCBNpn5gBHRga2W2X9yOajEEW6/ltEvJGj630BmhyrdeD6pvp4QwlfQOl7KTdm/AXmRV+TtKEWjq42uXHsyZLXA0iANgd5OG4HH9n/dG9EAMq1LjsqBrOUmJCGEYLRMRbwuzrOdMl5+Szos2tGsoPmpNWXXuXrQA1qG0hEuYiZFWnaZM5iHABB/6nnVPMOy+u+qppBSC+Y40BYPMs3YW9YMdzy+ITFp5RZ4PLR5ZEgxLwaqwwKfzyBS/n5WG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(26005)(6506007)(6512007)(9686003)(6486002)(122000001)(38100700002)(86362001)(558084003)(38070700005)(33716001)(82960400001)(186003)(478600001)(2906002)(54906003)(5660300002)(64756008)(66446008)(66476007)(66556008)(6916009)(4326008)(316002)(8936002)(8676002)(41300700001)(91956017)(44832011)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kP/Uavy2RB7FsuMbKIySWZplSuMFvPeoF4ciY80l9UWmqgRjJtour+Mdtmhy?=
 =?us-ascii?Q?FmTgX4jc9+m9r7DJsHc8lq0XxPLTh9GfgZ9wKW6xQ+K2AA1duILU8kaiZ+85?=
 =?us-ascii?Q?rd+X0vewQc4GdeqZIaAAL0xLhC9nuHhFCeYQcZjm0lKT1zEeHrXYlg8F66uz?=
 =?us-ascii?Q?sJy3P2kwU6OM8IQIW+WK6X9MmssyEiMJALiGltyM9pgACcZPnZLMY45MVec8?=
 =?us-ascii?Q?nNCS6t5QlIa8HtzZiQuTCxbh9q+VZQSuA8Ir+4gkXwHgvmltcJt0KgHUbRji?=
 =?us-ascii?Q?fskXvgkfZ+LJGJhsylNzYFyBIPwcUKGheU8C7G06ibSozny6YPElS9WfH8Sw?=
 =?us-ascii?Q?YLJ3n8ZNKIgYG4l2KmMhTxa8AOjL54dvqOfv8t4Q7pR5pzJbEY3eJStSCnYP?=
 =?us-ascii?Q?LnZCp9xCeoEtMYrjA+FH2xpMxMOWWBNFpbJJ6NvyFqp8JaZ5xFFTXyfAicBW?=
 =?us-ascii?Q?HT4k6UVBVo9wOid5IHYc0m5de+bjulbOA2lDXTs3LGEzmgOJ5RJsy+CbNuuv?=
 =?us-ascii?Q?GParLla83OK91Ncv/fQoDp2W51FEvXq3mEry+EhPUFvAZjGyHz54EYVsBpI8?=
 =?us-ascii?Q?6APHRrLn0OCBrvXtC60GD14RtOk52LVLmCXmkF5N0bTsD9IMak4bjpsEn1Pm?=
 =?us-ascii?Q?BkEe/6vgSjotRWtAQhFC98WieEML9WpTFhXXNchBIuV6Oo2d9FxM+S7A8Cg7?=
 =?us-ascii?Q?FVtUM2ebIMl56apjM+H5RVAFpC8zQfwa8+fgryUuU+YH6kCAPScfmAPy06cR?=
 =?us-ascii?Q?LiWk1OjnYEhC2hE1mLpbbY86xmAr5Na5NqqxFcRq5/N0TZHR9j5Isp2oOEle?=
 =?us-ascii?Q?V4sJoAYNDy2ia58iFYbsZI8SQqcbkfh3LtbTdt3WnQ7ETdHuzYnvhrKjO0Wo?=
 =?us-ascii?Q?phoNssKFy+nI4I9rz8BrtJuh7HCYZ3d47Ymi9Q38zDwEoJjTk5+S9GJJ2h9x?=
 =?us-ascii?Q?I6qhu09qvx1MWQmdU2GA1NBJYjGm8NQgCNk1f9lQVh0H6K3D6LQ1I48pM51P?=
 =?us-ascii?Q?O2KAw86GSiiM52bqg1bCQo9wmNRxzwEGgJ/UUpzXqk9AHB8IYooor8YYg4/K?=
 =?us-ascii?Q?VsO2oM2qNQuBvubL8B5OzOgzU0J2Pk8tvRkvkRf7JCHe7dy7WkbnYEZq51Hr?=
 =?us-ascii?Q?/o+LlpxIcxbT2p1Q318Cc+ljG2O/Zkg0Fyk+OEN06aecUDq4rP/l2nRI9ujy?=
 =?us-ascii?Q?4BqxmrMMJWFLAqgcn5iesxKVJEybGz4LDvBGxwCwwGVVPk4o6uVmhOkS/zRQ?=
 =?us-ascii?Q?ceJZAVHo4vNlWY702ShnE0tkqjsDcHgYsGBFSZVZ58OsJ0LT2PygIN+66lzS?=
 =?us-ascii?Q?rBZLOPcPOVLPT9Jwn/EGydmM3NWiwqbVQMbimWlW6J9tDTvcLXTbYxvXNN8T?=
 =?us-ascii?Q?e0XFpEucm+wWaByBkLKsyVCOjf7hc20JRQf3hAEAW4d3XyoskQ1PgQXlD6sX?=
 =?us-ascii?Q?pINXXA5vY0yT5Qevfd+AAvNiEmC6/G0vEXw11PuM1CY1Q0NwQChGqawKkAuG?=
 =?us-ascii?Q?xPAXEhQ1y8/5HyiJjGfoSkUHyxiKm/bgiUNkhILDBPKUia4DERZtpcvWwQrX?=
 =?us-ascii?Q?FxRVVaDIJ0YiaFRYOR7ByiHJgAPJJw1RcrDys5FeR9zE+Yl7twm2Lxvgdnr5?=
 =?us-ascii?Q?K0YGlbZAlhHNJ2hfUVuBLj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BCE7F851273E9E4CB15989012DAA9175@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S0FyEbf/eMCphMF4pmbv6d6pdY28AJ0uh8ahsi33KpP8uktnGRq5YdAZaIY9ibv/wOI99qqwXf9FRSeIGT1StITzDjy1E8vsNowgBi8hmUyWifMnlWf+TVbSF8uTdW3dXMgL+goYdLwxvU8lyP3djtVLv72AC7MLll/5hgoS2KY0hRkG8aBz3y6mecggFluBwTn2FAzoTVAWX10mtHdcCIX884LiJLN93DzS9KkOHVCBm9U/r5rTIRtkA3vCxj6Z75F51vBOATGgqJmLnU3txoH9ecUTwb4OL6iSEo+HlapAUirJ/DyU/gXtS8Y+HrQwVDi5hwB+Mie4WcTCS2TuRt3itE4Cn6p31PrhnoIUuXwhKbowzhQJ0i4TTDeI01iQ1QXMFI9zzh6sKMZoK3j9VPnRuTb9HcCLxwtATpATaNI7L/moTbu3oqGAKsVpe7vqKkLq5VtwDqn56IPwHgD2n2nYEGUPiP+QuFR2VNZrqEuCNKlYVVTtr7NOI54f42llTqBzFTL7+DTYZtUkk40jRYJidjeM+8pQAuwKax1JryFR2uVV7KnFs8xHRXjVjOuI4ZEa428S5jdWr4O9eP2pnc6KYYLpJb2BypQNR9OuZyfXuWOxnEnKKl9CMzIDefufLvAR0HkBcVh22gesituX0hRcndDi2E/eI6mQnPF5dy5qFm1lMScxXUaVxScDNMEgdTn2gfO8VlyrEnlJ02w0fLc/Dw9CReR0P3lvzk2/3PykIfXVf3mgJPHznyIL8w0fzMvwRM3hjlIkZ6QiJcCcHXuSQ4k+EG625ZVPd4Q0cMY+uyqQr8ef6+8i8XGbMxsnGAVDwjNSQispr51+0LseyphNkb0GP1NzueJ4uaWEGLlgpcKUlKQYBAC+A/voxdkBdF3kDY2RXF0GZNIOJc6Uim2pieuP3+KmTq4Qchxj0Y8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e57f97-fc7c-414f-66bb-08db4f4d9733
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 22:51:27.0432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OB91bBvSQbR9sLbVyACQEhOSRhIBvco3RnHOdik2TOzWiaXaInr2D9FoX72JcG1XfwOl3xg6+FfmWuXNtVegP8Zzg6CKdScV0mXAcUGEZDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7561
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One nit: I suggest "nvme/{014,015}" as the commit title prefix. It will cla=
rify
which test cases the commit touches.=

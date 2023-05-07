Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDF6F9CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjEGXJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:09:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41D768A;
        Sun,  7 May 2023 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683500955; x=1715036955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8U1ujK4iC5k4GDjH5N85AlWjuWSOzVP0Kxoxs/oGk50=;
  b=nlwuRZ3Ju7JLO69XXapI7yndkHO2wuHkQn0T1QEbYRlSNN8INaj6Rxf9
   6HEL68FmFd7xhlX/Kfwm1SMhIeyuyiOITClwvhf5KN8sf5hgy5Pkv0XjO
   oRBWgFRez7ERqRXENKgavuGA9KUlfI/XPfsVDBSFA6XJm1s9Vbs7wTAAA
   0CTU1bKw28JhPNIAwG+skuVPFxh+aKgVNNPUc+7D5WHItC+QYiq3IOzkL
   m8wT5gkZmr8vJwUJmY9qFapz591JYKXlUddXJNe/bOZYCVelI+OKfDU9l
   yz0S/aeJ8tjJRe8WYCVt/c5WfA6pzjTzCstGAHZCjAcpu1Up09TsNA1zR
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="334551994"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 07:09:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQqb/uCXS/xiR5AIbdMkW7Q4zEFzESNrVoliTkD30rwtF8ygmraUkQx5TeFsEHFWajGsHg2F6xHUeTVrxMu1biq/8ORkcVSqPa7UWIIX8KNNdCDpMsl+lLaykjl+KM1xB1yoANXNQSHGBhykFFGKoPCYqTFP/rpjhy0C7cjavaPSwhSVJFZemi7qT9JxWnd4NfOR/1W3rWWBZezxcfPrIxtOkR5SoSdgxV5NvZzvvNoAriA/cvQvHKtmG576Z8A/iNYQGUcIP+dwL5IybZPf/f9PQGkW7YQ8nAMHrfElvvI9+c5zwmB7qazKhygJqeSIhD2SxaxvMAaszXfkMUUShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAJCKgyfepTk/AhJW3ZR54U8t56+Owisk1yFtHo6Kns=;
 b=Fp9e1XuERfQu7/iDTWYz8kXmItFX864uPCqrkv4RmYFgk1MPJGa+CU8HieuDUBuFcEaO4H4viDvK2NU1/N3Qq+F47jyJkbpe9k0AO0Z9jKusE04Wv2IojUH2lJb4idJzvx1n+5hz69tLqVpRwqqaPfoH2RgfTyh4cjktdO/v9Un+2q2Ci+G40Jz8hsnjta76S+fr1IkqyQoNRFEeEDEQG976uw1Z2mSymvUDArQdqpCtzz/A+nd96OKbpknGDUq7QtqUZ1SMcis1PFmFkT47k1c8XTGvT5StaOqFcHnrDWCnvQBsOw5suHhtqMtmeyWUlYmCQALIA4ycHUAuYEG/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAJCKgyfepTk/AhJW3ZR54U8t56+Owisk1yFtHo6Kns=;
 b=q3V3nGwt8/o/hzS+tu0gYhL2LT0dSgkjotMGuxzC7c+vKu60BuyWw+isSnSU2Iqg0pDX4+bLy8/+qaLB3kSvW6k8pFMyYgA48Webws/Iy3XUAdYMizCOYfTsS8p6ej4mVOPt44DnF48Bnidd7kUF8ERncY41g3UKjP2HYtFBwFY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB9049.namprd04.prod.outlook.com (2603:10b6:930:bf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Sun, 7 May 2023 23:09:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 23:09:11 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 07/12] nvme: Make test image size configurable
Thread-Topic: [PATCH blktests v3 07/12] nvme: Make test image size
 configurable
Thread-Index: AQHZgTjuHWPXdNE7UEGuDuT6Oka2IQ==
Date:   Sun, 7 May 2023 23:09:11 +0000
Message-ID: <ejcfr3bfckfb6qxas477yvpoug2z7pe2w72npu6wpsnaqjhnhi@bx4fdnw3y7h7>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-8-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-8-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB9049:EE_
x-ms-office365-filtering-correlation-id: 19cfc6ad-42ca-4cec-6a80-08db4f501161
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2c0ez5avHKCoayCJYdbYmLX3AZ+eDkhgOnX1sZs6sI1aEctnFnY/t1StaemzwCz8AMvlL9jSqdG6X9VEEYFy7J++PuoSk+b8CcaIMM9VFiIDXakPyriy7Ip5R9KJRfmDSVhe/fO7gE4ly8BosQuevuBbTBkkDI45bzp8VFpaOU0KfSC5ozLDAfPkRsTefO+tqANSPup14tfeynGqWrDWNu2XMPwl8GVQN1a6wnzWEkVlqAZ0gcZFSc9XOCd5ozZ33IaXhsEfVBBmADgdEHRS86HLthMX65puEOYZVuQQ4pOae3FnKV62THOX5l0e6EQGJ6NA1Ls8cxJ3PWKZTACAliLS3S1WIrPtSkWn6WRI+olXXL37MItyQJvBmHdKalxu20yMVhgKDRebTXBUHXBfDU9/Se2LZvd2LexQsOh3LvHIXNz4Tr36cNDGWkxXAC2sm3HZNj2JiWepr3OAyFc0XzG9bQ7fq6sqXAzyGcSqLYCn5xrhtU6FxQpvdUqoRjMJ03ORkT5Wj02Ky6Gjhqhyo6KXnDUE1XrdIwPjNZerw8F8hEF7FMPZBKOBoCWQB5fAqrjow7r1w3luXcdFZI5W6b6YZGkqXKoddTm2y9zs6qlcuG4byw3W36sRBOCXY01
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(83380400001)(91956017)(478600001)(6486002)(71200400001)(54906003)(9686003)(6512007)(6506007)(26005)(186003)(33716001)(44832011)(2906002)(30864003)(40140700001)(38100700002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(122000001)(82960400001)(4326008)(41300700001)(5660300002)(8676002)(8936002)(38070700005)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lt3U9XsqMx7XMvkqhrQAjlN1S7LCzClEe5OLlTUftgXtutGReK3ExcIVyFQg?=
 =?us-ascii?Q?baK+ttfRN6kz9MnnTeo5xCMXL/DrYKALJvmDLW2hlxGZY0iZBDjPpeSVOIwa?=
 =?us-ascii?Q?LM6B/lOMOMTUWaDAX+aEQ56syFNKujC5kxbSLeK0aJf3vbSLCHgKaMZ9M2LM?=
 =?us-ascii?Q?wsyLzPAxJGR0Dt56Qr7rrK2Pr8sfpii+BmA+iue0ufFwL/Zde4SMbb8x22+k?=
 =?us-ascii?Q?+1IW+5YLI8/mB33Ih94aA/a7GViTwqSFWUXghIL538Vtx9y5RS7WwAUkpf7I?=
 =?us-ascii?Q?9eGlp+NzOWZcOh3F5SqYtrE+6EbExTNq+GuixbNZU/F489GP7v1OnSBJv+lr?=
 =?us-ascii?Q?eOAMuIGsvPx86v5S2uNQohWnTEDoKyy4hUWydhQ8Umydbpe3cX/hDaQJzZS+?=
 =?us-ascii?Q?WOhep2SZBV+tWPljDMKrHXlqQNxzVePqylY7ilBHHSdSmDPd1Zowp4iy7lYK?=
 =?us-ascii?Q?LYDTeN0Mv9BCkEYShIq9I811g9+UDdSXYbPExrSIcXEa2mz9jBecS/R4cZvF?=
 =?us-ascii?Q?XMH1JRC/P9B1Wr6qGPW3tvEW1nHGERpDIlLq02IMyXq/yF0TmIM8YogqnliF?=
 =?us-ascii?Q?GsgOEvvmLTFjqq0uWZ8S/gnt+pY8fi6N6mSZ83N+5yVMnYZN1DLwp70QITkf?=
 =?us-ascii?Q?R1fIZr7Xrp61I9INH55gD/u+ZEsXq1Dye4F5cjPMwV6H7YwjoIeXzGGORNx4?=
 =?us-ascii?Q?B1EdWE4DWte2y0TASSXXbhMECw7VMoLBjDSKrz9IXqvx9s2aID1atKDW5Sg9?=
 =?us-ascii?Q?p+PlktWoTWmuBL27i26hAJz4xWQzv7r2UsxWzTZBDBEwh+2uzmegYKSUB+fj?=
 =?us-ascii?Q?0pAxIjfF5aknYZsvoUteWUw3AUFqlvLaZTfFytVi2D55YEbZiHvj8UFeOizr?=
 =?us-ascii?Q?bg0tFN4P03bRebwDvnER6/hvs8Wdjh/DdhNjLJXYwxUThoh3exB4K4Gnln4T?=
 =?us-ascii?Q?fUCqiPdOs7LgW8K/iH9Qvk+znVBfp5TW+6F4B27BBqwGKXTAif1G7QYLfXPW?=
 =?us-ascii?Q?RIu8nKw63IfcA1lqTytNT6fzLaMIQrlDKQ5/H9ggoOQwSPLjhIt3epi56KQY?=
 =?us-ascii?Q?7VvIGXraZrdmxpyD+wI68iEg6lRGI4eNtsPiqcwzwMl3+KaacGxyNIBnjlb+?=
 =?us-ascii?Q?qe/y155pxhIh3pSjCMhnjbIXChxWGKQvQvmIhWBS/qsaZdTGqZYS7dNQaHhW?=
 =?us-ascii?Q?VKdXSN2wzto4fipDSXbSmcsOiJCDnKukWUsjJ1W93SvnTjQ6yS3jsBBPsKko?=
 =?us-ascii?Q?XGBtvWuryhFtOGCmzyx+GunJ4R2/JxN0dmLlbjujb3vqNCS0uRI+qkamjy/i?=
 =?us-ascii?Q?HKvSOKYGxYbdY3SPvo3nM+GbxyIW52DuPjjESYi3ZQwX1qN0Gt952KsMaujw?=
 =?us-ascii?Q?61Shwaad3TCiOxxAzRkOAIefeqwJIM9ePTzmoWHnbFaK0ExnBfKWTNeKeuYb?=
 =?us-ascii?Q?jj1raZm37BPtDIMQivYSm9Y2GwoipXHtEkg83owmUR0iksEeh95+vZZsRfl9?=
 =?us-ascii?Q?+yu+pSOLbH8XVbzMBn5O2M5mutO20VocfUL+UN7/F/g78tVSNvjOhYd7SV3o?=
 =?us-ascii?Q?6pBVyWo5Fv5B2W9DR6+6tRbsR0DV3ayIhprcD6DilEO4tnJ+jYKHX+tef5OF?=
 =?us-ascii?Q?wtlC9dastMO85r98uMZ21qA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B68DB8C6DBCB6647A2C24728FBBAA9FE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cbCDM4jggG+/5Cuwx0Go6dwWxzyK97GHbPPAtqfrLiE0U7ADuX/avC9ggDgF8QiA/Jni6YB3NVrH5abj1Vrqfmu3ihLZhZtilE2kWAy/ZViHAAS5ed0OnOTVPPkHWEL/LoJtV1s+ZYRDSPc1/UXr2sJsFWHnT2A+XkgQOByjsZYzXAkfks0FL+Gq/TaWrMhmLLvo18byL51r2Bxjy/h6pTHcLTrzC8om7ojqaWTy7wZT7n8CDdFQqr9HNGJxLzwq9oTxurBV1fMVmmfcg2eGItDHM897buzXgT2c29wz8bFo/JQO4O9ubFScEGVsmsfroQCZ9qVQ9hAy6oRw0hv86FvKusubiwcB7P1tk6MEhaX3lkdFj6+HhHHE0IzYgmdsT45z6zGW7HVRtDKDTt/7Kfgxqeh96n0KFHF2AOQAX0OEScRgP/z4LoVnmpi3TZy7AVyY3Q6rdhcRoAb9xbUCerKmEXjtyah2Nz4pkw3rYXbTB13+eghB2/xGKFjWCY/oofqRROp3LXo10KAYlwqMSOrRGQNOFRuXT5kD/h+0G+fpOkN0Hc0KO/C64s5S5VupMKuINj7dPRG4hFZQXoWsscaZlvnTr1oNrlRd5r5OcuvcGjcEhcF5CiKT8WknX+srFegmoJUhi6GhFrPCX2P7mx9e+jA5UTji8KEBny60Fjk+z0Dy2Nhbhq7ZpxgiImUWYCh95XdJpm9rRrt8lfR7N8fYwviZgiL7fM6OEYvdVBcGle+X0esqmhVGJdZjHYgjOqZlpmXhnQOGAyF8Ios+TpN1NfjjIsUYmqhpN7te9Ych5khuLtK6cjxO7Km28B65FvB4fmdwtlJE+5QM/C1/scrA/6IrHz4mPyWOHGK/eFKSnG4g+mQf8jvM0T53zWyZqEFWIYxy/Wya039RwdfLkg0MOOlCNhGI4yQQKcuPqok=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cfc6ad-42ca-4cec-6a80-08db4f501161
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 23:09:11.0260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwlMt/WlbKPAhllH1y4dyUEmnPwrZ7q43DBjNVtETMrsYxY4UlHpW8y42zxR2FosSDz+/jP/iJmFdqJTlaKrU1+735jTAkli7o3UMx+XR3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9049
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find three nit comments in line.

On May 03, 2023 / 10:02, Daniel Wagner wrote:
> The reduce the overall runtime of the testsuite by making the default
> size of the test image small. For verification jobs, the default can be
> overwriten via the newly introduced nvme_img_size environment variable.
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Documentation/running-tests.md | 3 +++
>  tests/nvme/004                 | 2 +-
>  tests/nvme/005                 | 2 +-
>  tests/nvme/006                 | 2 +-
>  tests/nvme/007                 | 2 +-
>  tests/nvme/008                 | 2 +-
>  tests/nvme/009                 | 2 +-
>  tests/nvme/010                 | 5 +++--
>  tests/nvme/011                 | 5 +++--
>  tests/nvme/012                 | 2 +-
>  tests/nvme/013                 | 2 +-
>  tests/nvme/014                 | 2 +-
>  tests/nvme/015                 | 2 +-
>  tests/nvme/017                 | 2 +-
>  tests/nvme/018                 | 2 +-
>  tests/nvme/019                 | 2 +-
>  tests/nvme/020                 | 2 +-
>  tests/nvme/021                 | 2 +-
>  tests/nvme/022                 | 2 +-
>  tests/nvme/023                 | 2 +-
>  tests/nvme/024                 | 2 +-
>  tests/nvme/025                 | 2 +-
>  tests/nvme/026                 | 2 +-
>  tests/nvme/027                 | 2 +-
>  tests/nvme/028                 | 2 +-
>  tests/nvme/029                 | 3 ++-
>  tests/nvme/031                 | 2 +-
>  tests/nvme/032                 | 1 -
>  tests/nvme/034                 | 2 +-
>  tests/nvme/035                 | 4 ++--
>  tests/nvme/040                 | 2 +-
>  tests/nvme/041                 | 2 +-
>  tests/nvme/042                 | 2 +-
>  tests/nvme/043                 | 2 +-
>  tests/nvme/044                 | 2 +-
>  tests/nvme/045                 | 2 +-
>  tests/nvme/047                 | 2 +-
>  tests/nvme/048                 | 2 +-
>  tests/nvme/rc                  | 1 +
>  39 files changed, 46 insertions(+), 40 deletions(-)
>=20
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests=
.md
> index 7e827fba7ac0..6b34a253fd97 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -104,6 +104,9 @@ The NVMe tests can be additionally parameterized via =
environment variables.
> =20
>  - nvme_tr_type: 'loop' (default), 'tcp', 'rdma' and 'fc'
>    Run the tests with the given transport.
> +- nvme_img_size: '1G' (default)
> +  Run the tests with given image size in bytes. 'm' and 'g' postfix

It would be the better to list all of 'm', 'M', 'g' and 'G', since '1G' is =
the
default value.

> +	are supported.
> =20
>  ### Running nvme-rdma nvmeof-mp srp tests
> =20
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 9dda538b1ac0..cab98ff44326 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -25,7 +25,7 @@ test() {
>  	local port
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	local loop_dev
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> diff --git a/tests/nvme/005 b/tests/nvme/005
> index de567a74a891..8e15a13f3794 100755
> --- a/tests/nvme/005
> +++ b/tests/nvme/005
> @@ -24,7 +24,7 @@ test() {
>  	local port
>  	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	local loop_dev
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> diff --git a/tests/nvme/006 b/tests/nvme/006
> index d993861c06ba..ea0db93791a7 100755
> --- a/tests/nvme/006
> +++ b/tests/nvme/006
> @@ -24,7 +24,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> =20
> diff --git a/tests/nvme/007 b/tests/nvme/007
> index d53100f3ff7b..243a79f5a254 100755
> --- a/tests/nvme/007
> +++ b/tests/nvme/007
> @@ -25,7 +25,7 @@ test() {
> =20
>  	file_path=3D"${TMPDIR}/img"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/008 b/tests/nvme/008
> index 5568fe46e463..5abc4240ca46 100755
> --- a/tests/nvme/008
> +++ b/tests/nvme/008
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/009 b/tests/nvme/009
> index 2814c79164ee..491d3c809ab0 100755
> --- a/tests/nvme/009
> +++ b/tests/nvme/009
> @@ -24,7 +24,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/010 b/tests/nvme/010
> index b7b1d5188e9b..805f80d40620 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"${TMPDIR}/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> @@ -41,7 +41,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_run_fio_verify_io --size=3D950m --filename=3D"/dev/${nvmedev}n1"
> +	_run_fio_verify_io --size=3D${nvme_img_size} \

ShellCheck compains no double quotes in the line above.

> +		--filename=3D"/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/011 b/tests/nvme/011
> index 4bfe9af084e4..da8cbac11124 100755
> --- a/tests/nvme/011
> +++ b/tests/nvme/011
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"${TMPDIR}/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> @@ -39,7 +39,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
> -	_run_fio_verify_io --size=3D950m --filename=3D"/dev/${nvmedev}n1"
> +	_run_fio_verify_io --size=3D"${nvme_img_size}" \
> +		--filename=3D"/dev/${nvmedev}n1"
> =20
>  	_nvme_disconnect_subsys "${subsys_name}"
> =20
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index c9d24388306d..ecf44fcb5a51 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -29,7 +29,7 @@ test() {
>  	local file_path=3D"${TMPDIR}/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 265b6968fd34..e249add46295 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -28,7 +28,7 @@ test() {
> =20
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/014 b/tests/nvme/014
> index 875e99eea346..55d920f2660b 100755
> --- a/tests/nvme/014
> +++ b/tests/nvme/014
> @@ -29,7 +29,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/015 b/tests/nvme/015
> index 8cb343e1d31c..071141380e43 100755
> --- a/tests/nvme/015
> +++ b/tests/nvme/015
> @@ -28,7 +28,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/017 b/tests/nvme/017
> index f2a95cf276cb..0248aee9bc41 100755
> --- a/tests/nvme/017
> +++ b/tests/nvme/017
> @@ -25,7 +25,7 @@ test() {
> =20
>  	file_path=3D"${TMPDIR}/img"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 315e79534348..78e9b2bb94d8 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/019 b/tests/nvme/019
> index 4cb3509a12b2..9fff8ccaac9c 100755
> --- a/tests/nvme/019
> +++ b/tests/nvme/019
> @@ -28,7 +28,7 @@ test() {
>  	local nblk_range=3D"10,10,10,10,10,10,10,10,10,10"
>  	local sblk_range=3D"100,200,300,400,500,600,700,800,900,1000"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/020 b/tests/nvme/020
> index 16fdfcc94918..1966d5925213 100755
> --- a/tests/nvme/020
> +++ b/tests/nvme/020
> @@ -26,7 +26,7 @@ test() {
>  	local nblk_range=3D"10,10,10,10,10,10,10,10,10,10"
>  	local sblk_range=3D"100,200,300,400,500,600,700,800,900,1000"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/021 b/tests/nvme/021
> index 6ee0af1fe158..1fefc0fbca00 100755
> --- a/tests/nvme/021
> +++ b/tests/nvme/021
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/022 b/tests/nvme/022
> index 1d76ffa44178..1ff915786f86 100755
> --- a/tests/nvme/022
> +++ b/tests/nvme/022
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/023 b/tests/nvme/023
> index b65be07edc38..90316230a3d7 100755
> --- a/tests/nvme/023
> +++ b/tests/nvme/023
> @@ -26,7 +26,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/024 b/tests/nvme/024
> index f756797d6f29..384a8266e741 100755
> --- a/tests/nvme/024
> +++ b/tests/nvme/024
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/025 b/tests/nvme/025
> index 941bf36f67fb..815223d1c28d 100755
> --- a/tests/nvme/025
> +++ b/tests/nvme/025
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/026 b/tests/nvme/026
> index c3f06c2a377c..d2203f19f026 100755
> --- a/tests/nvme/026
> +++ b/tests/nvme/026
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/027 b/tests/nvme/027
> index 0ad663ace811..97fe70e78344 100755
> --- a/tests/nvme/027
> +++ b/tests/nvme/027
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/028 b/tests/nvme/028
> index 7de977a81213..c539620bee28 100755
> --- a/tests/nvme/028
> +++ b/tests/nvme/028
> @@ -25,7 +25,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>  		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> diff --git a/tests/nvme/029 b/tests/nvme/029
> index f8b4cbbb9156..1808b7b0edf1 100755
> --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -14,6 +14,7 @@ requires() {
>  	_nvme_requires
>  	_have_loop
>  	_require_nvme_trtype_is_fabrics
> +	_require_test_dev_size 1M

The line above is added here, and removed in the next patch. I suppose thes=
e
are left over from the working code.

>  }
> =20
>  test_user_io()
> @@ -59,7 +60,7 @@ test() {
>  	local file_path=3D"$TMPDIR/img"
>  	local subsys_name=3D"blktests-subsystem-1"
> =20
> -	truncate -s 1G "${file_path}"
> +	truncate -s "${nvme_img_size}" "${file_path}"
> =20
>  	loop_dev=3D"$(losetup -f --show "${file_path}")"
> =20
> diff --git a/tests/nvme/031 b/tests/nvme/031
> index 4e1798246db1..e70898819a86 100755
> --- a/tests/nvme/031
> +++ b/tests/nvme/031
> @@ -33,7 +33,7 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	truncate -s 1G "$TMPDIR/img"
> +	truncate -s "${nvme_img_size}" "$TMPDIR/img"
> =20
>  	loop_dev=3D"$(losetup -f --show "$TMPDIR/img")"
> =20
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 2e4b7f0760c7..46bbff25e70d 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -40,7 +40,6 @@ test_device() {
>  	# start fio job
>  	_run_fio_rand_io --filename=3D"$TEST_DEV" \
>  		--group_reporting --time_based --runtime=3D-1 &> /dev/null &
> -
>  	sleep 5
> =20
>  	if [[ ! -d "$sysfs" ]]; then

The hunk above does not look required.=

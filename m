Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41663D01D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiK3IHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiK3IHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:07:49 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C114D17;
        Wed, 30 Nov 2022 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669795668; x=1701331668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zP1SE6XhdZbKOxdPyI5AjaIHtxWAoCMkSbuFX/RRJGI=;
  b=KjwVqkA9FxES8+12dCeDBtROOg76wIhJC1IYJ0xBfz5BpDjjK2Me4sGO
   jOtszrhmz7ensMLzwyL8w3Dw+Ae/hFL3V6iQ/mLIO2Md2jyVQ7ecNAp/Y
   TSx3f8PnYGW77bfpYaMezEY5dYeLTTFuFHhOQ23T+ChV1Qw0K5xOdWVMU
   G8VGkaS5bkYxA0sZg4qDjIj2ukKMxs+oj8zredYF6P8LODRSOC6+B1DJJ
   cRyomFHdApEj9xIgoTgFpxik5uePbOoGulF5zkhBvAqJrdYclnMEcWq0y
   E4yVqQ3zwks2AGdD0TfwJPONpdHFWMmeQQc5QSHodo965kGFKUZ0upKvU
   A==;
X-IronPort-AV: E=Sophos;i="5.96,205,1665417600"; 
   d="scan'208";a="329632707"
Received: from mail-dm3nam02lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 16:07:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCb6xbkUr+KpuJuI7FiVvRHcBtu+QCNjc/LpWj/WcMlaygfng0nciDqelV+N22/RsmSVTtl+4ccQDHs1RjoxljZokmEwZ1iexyJf9LFWLoj+bWnSJbcgFokKhViqSjxUBC0q3A292lTRNt7CLW4hwe11uZUhNiLq8oEuCtMoQdd6NxtYaHqW1SIBJbK515iujDuiEpJwqm5ArFQZm860N30M2zDi9qUN7USDqTDmieyjLW2RnVfONI6QIvySxLF1yfCmtTw/memvEtc/BDhjaFhccGR1VUGASUNMVkQQWjzFaOBzzn9oweW6xCI3XKlvn1fJvnkWWH0n5Ceh2Hz/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP1SE6XhdZbKOxdPyI5AjaIHtxWAoCMkSbuFX/RRJGI=;
 b=HhjDYPM0iInzGT9vkCrWkjL4/n5qrjsdLnUVhFqmVcTuwZoFK+3RV2X967PB6LAJ/HDkNohXwLVGjxkNfYInqFFl0s7bD+ls2EdkIRzntlAd7DDToQyYZe9G9Pz286x3gq2p5RRM9+FurLXOXGrWhHJHnG/uP8YB6UZYXodItQGN/bkS7gBC5Uhdx68SGZT5o110PURnX7b69pH7bDxMgTNd5Pcn8nDDscAzxgIqmnQYtpdHe0PbU6Q9bd+kp74HNcfrkn6p7Lkg+dLJAx1R6xbCS7//2yi7X5Q/5T0py8/csTToezC5uic/SUHqvh5/ln3YWxqXjl88W4i4dup0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP1SE6XhdZbKOxdPyI5AjaIHtxWAoCMkSbuFX/RRJGI=;
 b=bUzpUiVme591xmJcCGh/IXBeomdZ8d/pSGXQLju02r+tHEuMFH2zn/slwxixdEE9s52seZcDYdX32XuU34DXDKSznL4kLZuO2TpzspTtqTOa7DhIifznxD9rbBQlKJ09dDY7IIpDWJ/XrHJwaTfj2sXfOHkE8SteR9DdURG+GGQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0851.namprd04.prod.outlook.com (2603:10b6:404:d6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 08:07:43 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 08:07:43 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 6/8] null_blk: add param to set max disacrd sectors
Thread-Topic: [PATCH V4 6/8] null_blk: add param to set max disacrd sectors
Thread-Index: AQHZBEp5/mHwxPrqAEuGAmftqO8sqK5XHQ8A
Date:   Wed, 30 Nov 2022 08:07:43 +0000
Message-ID: <20221130080742.tlr7nnxernioteps@shindev>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-7-kch@nvidia.com>
In-Reply-To: <20221129232813.37968-7-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN6PR04MB0851:EE_
x-ms-office365-filtering-correlation-id: 9c8c22f2-8488-4b2f-a588-08dad2a9f52e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EQ16fCMkMOoRgM6iOcxECwgw41xzHtoOLB7f05cIYErCj7ZdYXpHSKTECh3pdpl2Hwp1Qsj7c6E/I52hjrwaJ5KZYdyvuIW6IX7hh5s67dqyVpuRJgAXhD0Fx/CLsRZv2bW0zS2hK3tpJ41dIyMnIP8Y/V/klxIHPf6E81KypQzfAkaJELfrsVGat13aBaqG/yZex8fap9T0THljXzXaeaKn2HsSm19tDZ6LVdJ91o/GVknc8gnerxGxnWiNd0cZhCPEKGxh9KU3xQVNRTCGhonaZ2Ug/V7iE92/bomXC7GEbBaCK+bL1cgCDezz6TJHkVhQgkCJNZ/+i0Lxio8MaWEPOslZw0OIa8muNqF2LjJPRg45i4cx7OZtY39QrZeTBXMaz7FYmOS9VLywY0NhHbnMNM1M7P42TjoZhVWZxTcFN5JodC60zGN7bebqFBtB6kayWrLIfpa0C9DRMvS/lMTau8++RA7gZitf75B2fqS5tGHs7mCK2bYczHNKqEtoMmHQD5nQ1D5PpcFIKlDKIXjz3bPiDfMK7jan8XUa92prh3ZF9k0xt3F4yfLPFjdJwP/x5p7khFszdtMETRiV2cfPaUpiF6A+/vpCK+Ig7jzkBeqZ+LDPYd8Ar+XNvUmzDYznTDOEzL0IDrga4tQiuRzuKrrRw2ijh4zA+mDk1UIqKS8XgMFBzL+rc9HKUkVvTjINeTqENk0ZZUOp+fdNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(64756008)(8676002)(66476007)(76116006)(4326008)(86362001)(66946007)(91956017)(66446008)(66556008)(41300700001)(5660300002)(6512007)(82960400001)(478600001)(38100700002)(71200400001)(6486002)(6506007)(26005)(9686003)(122000001)(1076003)(186003)(44832011)(316002)(6916009)(2906002)(33716001)(54906003)(4744005)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J23EtUvvLze/3U4pMZmWvKUMp6pcghy7ZFiYMMCflIPalzK9/b5Ofj/qbuIg?=
 =?us-ascii?Q?KF83sR4mgWB18nWEw0hZpe1G2GM4Eq9GH/4+Yjtz+DJ7j4ckcvtBK49RaxZS?=
 =?us-ascii?Q?3AaqOiRfzftWsb6wjNPEJRKOJBEyhh33asYxoVKCdpmGEn4AoIzFkHZBDNOg?=
 =?us-ascii?Q?Thk8aNz1rMHhw7tTnhRKaqk4jpWtoH52GZ+Ng9LsJeZid66MUmXoL2bH7nwQ?=
 =?us-ascii?Q?2V5oI/ZZ+sgWA2VWMIgZMfI0cAyFhylLty0+a0rwjpxTTRyNZptOYIuNzeXu?=
 =?us-ascii?Q?ZWzoGSpHTVyS7FJ8ZeBRaNHk4kZwA38WQnjosv/nreQyviW+r1kL4c8plRLl?=
 =?us-ascii?Q?Lynrs4JjtFAINCK0OXwwynxcYEs9ayzI6A6hgj/AZsHxKUZoK08u79ecOcoo?=
 =?us-ascii?Q?XCuVIHQQhJwtTWCI9wR7RSo4a8z4NvGWuzGmEKEJhQ9D4+4g3F9qVR6IoDxg?=
 =?us-ascii?Q?ynZemedohHCuMM+4QMK/rS8Cbhmg2PQqaDBZ5FFdTg86RRUAzdcXiqWxZlAD?=
 =?us-ascii?Q?WmF+vBnXR3PZ95wiaEYa5xrkpRyrQkphFhCOBmDATCdUbROVbNJQ19MjaOxo?=
 =?us-ascii?Q?S+UbeygYpZ7oMAXVTp2nrQLYjjUFhfrkdn9nKfG9IXRjBAAvZoxkm6eNJgOx?=
 =?us-ascii?Q?dr93/qOQZ6sVWyrrSjaS2ADf87PraiZeKiMvTDyL8/4wLZq6qIRiuygjmdJ2?=
 =?us-ascii?Q?Wj1JCvXD9OOeGvVb0dWJX27RHeujUvesj/wwI3af6lLYS2jPM21Da3GS3+ey?=
 =?us-ascii?Q?A5xT53wMnQspl4p8wDx7zOGUzbktB1atuOkAz64wqXUwebUGC6oIMctjV+yM?=
 =?us-ascii?Q?XqvahqF+nTVEAZqupOM5bNzl8TroPDWahpubYHaSVsnXV4Mla09ZA9xP7O8F?=
 =?us-ascii?Q?UWRj2EEWDeAn3jubVLKYHoKFlZa7SOmpYZmqfpgDKA4lZIfvor8C7TjxfB0E?=
 =?us-ascii?Q?VnZDrkLHrkVqXl4RPfbrrPe0wQU033C3/dVwV9pKMNS0if+wPjHTVnR/j6xy?=
 =?us-ascii?Q?3wbhQQahAf2aFpr6chi3Keo084v2GcuMLjwXjimWf4Gr/482iDBUa1NJc2lo?=
 =?us-ascii?Q?Z6TIYaG3AltpJ55szTfvyqf05IfYPTMmB23JziePBqhjHVN+BQVYBtRDKpGD?=
 =?us-ascii?Q?grJsjztTW7E1OiJZWdCrd7n0IASgFntTG1pgJuyiZSBeIQXg4IeYzL8k3h3s?=
 =?us-ascii?Q?kx80jeR5hfwvRM9YyRdVx+hQBmOfu6n7gwfKEDI4F8bUJz/XLVipnmpD+nd5?=
 =?us-ascii?Q?liHfOWzqYLKl9VHunUahnqjT0mxs8z44u7+nY0xHfkf+b6uKEEv/Z9Ko7RmT?=
 =?us-ascii?Q?078irExkTWAabNiw49OdKIRel6BkWRcZp5TWyNrmKumsSCQMGVETD+50YfXP?=
 =?us-ascii?Q?amKKk7qzTY1k7wQj3ssG9nUdas9zlIHdjun81xrBu770HSDeBfI4twNwLSZ3?=
 =?us-ascii?Q?f48BAi+OP0dfa1iQI9U/6tjfA8WNCTYYEFk6hiMaEWAZnlCHLRDXHa6H6OlD?=
 =?us-ascii?Q?tzfJ1WGorgBhB574oxzTBeKAhfipd5QjUvLx0eUGs+wunsA/G4Jfuag9ywJh?=
 =?us-ascii?Q?NumOiNfo3QXH9O6hnHOnjIK1eRrZ071vceZy00FzeMGC8D0kxDzMkK2PBOFS?=
 =?us-ascii?Q?GA6jGsEzeT5IlBE+VSo0Xh0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <744BA5C0D802244F9588D9EE907554F6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4O7qv/rH/9iQalauDl5VHWgOqC7L+AR8Al9b8aZgFRJ4JEAU84gT2/XjI0pD?=
 =?us-ascii?Q?f0tQtIfsrAnJj//Zu3l8tjC36h6RmqQtek0vmkawx920p55xkDpr8E/aEdw6?=
 =?us-ascii?Q?dvsS1O7kB+5YiLnc1RND87OEVi/W2yL1meziMAq6MvzJ8pxubMm/Rdxt18XK?=
 =?us-ascii?Q?ofkVASE+ajXFoaE3lABbtH7RmVM225aETauOz+LvM9dgvRPtXiWKQga7DbQS?=
 =?us-ascii?Q?f66K8TVgk1CjETcQuAZ9vShruzhNxJAFYt3CxVm6eDjVsZykcGCyTCdP/1p9?=
 =?us-ascii?Q?g93DOE7KFfHOtcIryWsMdVNFuvkotB5wFzaugEERuk8av+Tv95eqwdyZtlzp?=
 =?us-ascii?Q?A84LR2ecNe88qgL/5SX4dumiBAvAGDvenMqq1EYB2A+tfqRfualYeCD8yREB?=
 =?us-ascii?Q?3dTjZa03FKdY+XPr2LvNGi2v1pidzugOWdNNLw30NnT1ivoUMuldU3d8paST?=
 =?us-ascii?Q?9fxceem9ciB2q/s/eBOlg1JTnuoFXxz71zlspHrGShnwZdnZayktUWXCG8x2?=
 =?us-ascii?Q?Shi6IHZtMToASkEDN7wZBlWDTPkEiKMtDYqAIREfYh+OiU+q6w7dmtCaFgXw?=
 =?us-ascii?Q?MMDOQdSyWvtqw3Qkkkqy4CZ3Za3JNNsWtA306oSwwDDu/dfy1IYn7YC4/F7r?=
 =?us-ascii?Q?MpFZ7JfVbe4KL2eSWI7Sq18TbNpOP130bnca47XTLyFKjPXcZxU6l2bjjx5D?=
 =?us-ascii?Q?ruMMPVMv5r+Dea/ePhNbKiqcp1IuoF5VBwu+7be9H0NiYLJjIMY2CsM6WoOk?=
 =?us-ascii?Q?TkE0iY124L8EUad+4316573F7W1KSQWBBZ4CvcMVZelYBMa+SpX5CoegYiNZ?=
 =?us-ascii?Q?4S4rXc7ducvEC2c2j8WrgfKcNGbwAWWyBRkWjC26KynJ/DN2urIOJ9FyurJu?=
 =?us-ascii?Q?nX95v4O77MuFmZY0IpsL76d1UdTPN3K9diHWkK5bjKQeFLpnweH6KbRQ+j6t?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8c22f2-8488-4b2f-a588-08dad2a9f52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 08:07:43.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mGCRQYETjxyT+QMmI1Ufyvzc+4mf1u7OMeKafeqO+boe1ZH8g39cRT1KudvtoJP0+Yw0ylgnmPwRpIbLQrwlEdaSW5Nd7VR9fzUyuHlouc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0851
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2022 / 15:28, Chaitanya Kulkarni wrote:
> Instead of hardcoding value for the maximum discard sector to
> UINT_MAX >> 9, allow user to set the value with newly added module
> parameter max_discard_sectors.
>=20
> To retain the backward compatibility make set default value to
> UINT_MAX >> 9.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=

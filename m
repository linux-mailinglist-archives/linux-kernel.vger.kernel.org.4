Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5D63D007
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiK3IBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiK3IBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:01:21 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3B3204E;
        Wed, 30 Nov 2022 00:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669795280; x=1701331280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FNOOoqrV6EsyLY4127+DshyEdDa5TddkQsuj7vpTex8=;
  b=RXHuuXjzRNR6YuTx4oVfB6/bappB3SJIwuAL/1P878jRd1f74FFVqngQ
   cJjgX+OTiis6zY0JEU8swuH4gweGrlMK0SOUp5oXHuC1kQExXttioONfo
   F0KkBZ+JGLH99z1CUGR5dj022aTqeVknXdaLns4P5m2xd+IY84u8tElLI
   n54veN+vj77y5qMAK/Ei4e5EfzIdmkvDHJOqaguloaV3tAZpw/Foj+C4w
   FfKUrECH9PTjVD/iTuE841BT3IT2oawtq5uSzeQWHUNViAvycghht7cxB
   ytaMlsqJfcI7CYpByQIAHZEDVho+pxu1yHPB02lLLZUStR7nleGWT4WtJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,205,1665417600"; 
   d="scan'208";a="321882066"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 16:01:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+VPqmXmQbwkAh4VVDuhLKTIHGDnvBy3up65QAz5G7QnYqGjljrW77t66ASHgXlmiddIMFlL399XMhOVLBP731KpOCo9pRvesb8jP5IT4Md5vO3tO/ztUzY2eoZyD7OHlnQKQuTEi9iwxLSjDpv131Snv2A0g8MEGqXBlBOiJu4YgZgov2DYvnAm3ZeOjeSdQed4SNxFGmwoJbZ0FcY7VrHnm/aV0dg+YTUTqeYGGbiuLirXT0WxadiSDveBZLHU+/q5ZasHGP5PYIOiJk8bief1RdafMRycPZRNRILzsD6/vMIGju8yyf6xkvv74TJ4wUKXmhiq9oDwIVH3mdf9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNOOoqrV6EsyLY4127+DshyEdDa5TddkQsuj7vpTex8=;
 b=IOuy9r4yq3c1C5WfT/gslOx8rCY3O2tc7b+WVWqU1zEpLq67rAWidzpXMeWHfuXFD/HMpoujoZxS1iEvL//xTshUyV3ErleKCHf/I/ACtu95O5MnpJ7/XrxXdAGxiKoKLEtPL+rU4Cv6NxqbBsbH66Zovt3ORFEBelx8fpes6PWJkbP7P7QxoAheZmChu7OKadu/vB2G18lcQ6V5DOc93IjYdwx28rt1Hbo5r8OQ2f3MxSNgv2PvlJx/LCzVw9cGgPKSdYRvfeY5sQ0g9swn0L287Dx/RcQ90GEdGG3KN9Rw70/NceCV0ekqqY6qgS+Q49rqfMUz4jz7kJEhYvdYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNOOoqrV6EsyLY4127+DshyEdDa5TddkQsuj7vpTex8=;
 b=wBZkWLH6dvAGlmBf+sTlJq7RzkVqd9zgU0+kA4sOZ0pGQB+owJVrurAMSJ1W95kZqQamt7sQPO1ZtNU3I4gGky4krJMxYxGiSsYp6gB0d4Pjs9RDNFpCr8K3rb0/Fi+meqcXLqcBuWFkarS6zrOzmS1ZO0+nIsvU9/uEKT89Kms=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7336.namprd04.prod.outlook.com (2603:10b6:510:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 08:01:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 08:01:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 2/8] null_blk: code cleaup
Thread-Topic: [PATCH V4 2/8] null_blk: code cleaup
Thread-Index: AQHZBEpe5dDfQCkPMkCSOkWljl0aN65XGy6A
Date:   Wed, 30 Nov 2022 08:00:59 +0000
Message-ID: <20221130080059.dwyscjvro6bcmfj3@shindev>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-3-kch@nvidia.com>
In-Reply-To: <20221129232813.37968-3-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7336:EE_
x-ms-office365-filtering-correlation-id: 5e494acb-4167-4266-3cc7-08dad2a904e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRFztdFTDWd25NJ1ERzA4Tkc9PGfcb+6R/0Y0R+HGSirXwaSitXrJKvSp0Jj+3WRMe/bGeMqFT3UMEv8dVmuX6Hzl3UmVQq2uPJLdxKajWKnTj+MelRPBWGM7StrHEbovW7n+H6KAzkpiJxTRGG1xHdpFPoUrKDy9esPSpJMnv8+Ag81I82Ype2FzDWgCVkKU7VEHx3yd2NKYnrvXVlBWQkUp+MaWYkfW8fd4cFBDzYodlgSxI00v+kLkyuUuMXienTEg7knieRvNnr+Y0uq2KO6ssmkzFzchE7h9J5NVs1YWpxIeQpy2TmJFz6+ON4M+qF6OWN/Uuggp82BP3qLkonGaPHj4dcFTTt5R/9npsS+U5Le6KHbHYjI0ooPyM9LTTzewAv4mMAFpGyKhvVkxETtwN4RGs8Q2/m3+9Xb/WlW6tErGFvjnPsnTg8/0gozDWPYoZppRsBcP+ek9RFmyjElGcnLjdgsM0SV0mA+bZMRxaijBheKAtYSEaENGK4dx5l/FookiRIgnzTzv+ToQqqlkAPbb0OmN5tmmKEF3fUY792xa+7VKaZITvDrHT3JjtKATm0RxVn3Jswtr39yhSSv2CnI/x8DdqAu7Niix5f5N18s/aSOkFgeqxY0X7ShxZnXPAGK5Va01wHlna1+a8UtFGo+drY+4arIaHEcSCK6s/Z/POrS+e5dLijdd2IuU40FxfkMn4W5BXKr2YFGHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(71200400001)(6916009)(186003)(66446008)(54906003)(33716001)(4326008)(8676002)(64756008)(8936002)(66556008)(66476007)(41300700001)(5660300002)(91956017)(66946007)(76116006)(82960400001)(38070700005)(38100700002)(122000001)(9686003)(478600001)(6486002)(6512007)(1076003)(86362001)(6506007)(26005)(2906002)(316002)(4744005)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxG1RcWfMZd4S/5o1Sb+p9UrqdsQTPsvxUXl0qQZJnRz1Os/VF67w907+uWA?=
 =?us-ascii?Q?s9wDGRFrFbnODZj+zs8DZpRCainTPr5hK9iCkZ4I6Lbb8eH13W1qMIuznN6+?=
 =?us-ascii?Q?qaHekZ/8JQ0dB/inYRJeHElpViuqbKuJSZkoC+DiGkOwDLFshNFUewr4znWn?=
 =?us-ascii?Q?jL3ZBw9u/LnrCslmZPFOV5tI8dpgI9EwfVOZunCK+HXZC+YkNj7W9TmZQXW6?=
 =?us-ascii?Q?n+96zf/YV4LeXkKMKxzsEzoZeoe/adrgZZife0onswPS0KsMHhcJLdbAqQUj?=
 =?us-ascii?Q?cfug823YAy/y1cPuTr/9EDB+5ijZqn4ao2hb5nckN+WFfKTJidIN72e6F/67?=
 =?us-ascii?Q?o0R5MF/pZHlPykCKC6vGuTl3eXdTISCNWv4zWdBI4vmKz2mHOoTlKYGT4W85?=
 =?us-ascii?Q?LHm5uwAaCwBDt+YYes8EQ6xSuE8s1i7c+8bsP0m7s2sCp3pTV/7ALvPNilQC?=
 =?us-ascii?Q?eA5pUTgBjBR1ddrwjBRR0ZkauBNCh0ANpnqVNM26n80gb4BMDQOjIWOUBpUl?=
 =?us-ascii?Q?RPsXdiRyEMhQdVNcH8g5F7TkpMTxCnJ28yqSTpX6EH/tiBofnMFerUr1zn7p?=
 =?us-ascii?Q?MStmshFyZp0QZbm1fPkbqzMIOcuDVFDsCpQnHktOvRp9dWicgnyuJasOb5NK?=
 =?us-ascii?Q?tCif/XKBVRdLL9PlUfYKlWtmIkq0Rd7uADhgukuVs9uhMRCbWqznbmCh5AcT?=
 =?us-ascii?Q?5waMfauhzbOzeQVngLdumbYvJh/pEqlKoiy+RcbbZg9SHMSzSRy1GKivdJJ/?=
 =?us-ascii?Q?RHNaDvz4f5v5zQa7bWTmUEb0iulrEFhfPk4uLkz5XHDJNfVv7wisVq5yWOiw?=
 =?us-ascii?Q?D0KGWQRAya07eZwz4ycOa+nXRawL7sI9thIG2z9lexpoRjToUHhTGYHaIJtO?=
 =?us-ascii?Q?zVFrQX/qJp8lBaAq6gaBXkCaomvg3ifjgxt3NuAIEOgqU07skxjmwpkLLzbV?=
 =?us-ascii?Q?k0lODeD+8Tzq81+Cytbon0xp5D186xxE88p2WmmAHvy4DecRgOmCPhHuT7hg?=
 =?us-ascii?Q?1zS4knAUK/5FUI9LXXSZ8t0S8suGbUEk1pP9T55gjSlxvMhRYliQ1JG7CKbI?=
 =?us-ascii?Q?zTRnZV3T11IbyRhfDVJ2bkBiI5uMB/JjijwuZMBrIJfRhaYJqd1A5I3cLu/3?=
 =?us-ascii?Q?Jxu99f9lUE0hFbaSt8ClI6rQqIFgdadGNMai/KGtdXS9QN7kVvKDXxVqFSJ0?=
 =?us-ascii?Q?0PIeUsBiMtP3fsyOZdWxzkDjVelQFuCAsCFyr2ws6WJcWTdGzJM19slIY3wy?=
 =?us-ascii?Q?VbAEcY27ULh22u7GfhGMOyf6eIVHvDKWMt7erPR8izqCs/TDZSsj/HY1oudh?=
 =?us-ascii?Q?2tocDIxHMbons2BFIVRrQ7+wJI6Cnn1wNfJGnYCoApD70JGJX+en3/E+3HTy?=
 =?us-ascii?Q?FFRwnigL+Gr6rELH1ZqOKdRA7QvXdZ9DynDUHUsui22+kp4WiLIRUiUMVP5K?=
 =?us-ascii?Q?3GpPyWgONsKSehKAUwPHWmyNfC1kzwBgziAddNDeF7M0xCZGTdhTYrtxDHqO?=
 =?us-ascii?Q?g9I53Y57+c1VhWLvcBmWmp8611Z/PB6nrFDbgc1OJpFKnLJl0FfD1DjpVdeH?=
 =?us-ascii?Q?3jW8bhlFndZKR/8dlCnuHSrnHTBjUaEN2kTKK/jwQ8z6gKWN8cjadcIm8vBq?=
 =?us-ascii?Q?LtgGxxxSo0do1XRb5KESDkA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA5211C469F99949BB5B3AB0C152EEB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+KAcX1gGONNio4qhHVF7PMTNtov8527o6O5oqPJ7CWwnkjtExlattI6cgGML?=
 =?us-ascii?Q?GS4Y2Rde16aeJAmJKpUiXfDCtFTBcUR2UHtymuzMNalvNTYPRFXfAazV/d9e?=
 =?us-ascii?Q?dJOg4dkdYRUyIvxuKusIpkx7ABEvRA6GbZeBUcnih1NAl7glhgFgGuXVvI8H?=
 =?us-ascii?Q?5UvPU/j+4zVkPy0GTnuqXO9kMaFEpT+BIpFVS6+e/00ZvU6Jza1BNF11MZ3O?=
 =?us-ascii?Q?b6dSODen7Jv3YmQ4UKUAP5GYbGNyv1GRBMwE8bDSUcTg0Mi8peSiMFbmmiOL?=
 =?us-ascii?Q?d8w5USTG+6rXQEEDOkXBfh9WFXiP5hkDM/i7vF7NKHH1OMdn+wvzs6kH4oXJ?=
 =?us-ascii?Q?/Q6aeE265PJi+TriiVLs/QtVzXBcwMVl+u+quRyJvUE2tbVggs4IPynZBs5N?=
 =?us-ascii?Q?2cKNBGJM4aHR66RSHxY4a0QYW2vNh3xar3OnQXT+K/AZjBhPat1+rCrmIi3w?=
 =?us-ascii?Q?9Ddq+lxYIC1MTvMq1SqHBKlOuX2IB9Rua7eso6QmSH5HcaxBZYSXFnSzn2fD?=
 =?us-ascii?Q?gr4xT2LpbvhH/bvYOfUEOYMVgEHprpKBzRoBWlluu/plY9R6NtWwRTm8rFE1?=
 =?us-ascii?Q?tjCTySyaA7hUhGduyfIz5RBovcVD6grBXQJL0yGoB43ZUhGaZGgG/1tXrg6C?=
 =?us-ascii?Q?sz4XkOKQJ7joM8ybkSp0VdQP/cjwxlIGmnqAocaC45Pmbx8NlQyvK7b+7VuF?=
 =?us-ascii?Q?g0AxFVI6zmvspe/nxBhLcZhneLUbOl12v6I2QV6j7UEFaplYG4ISq17AXXvB?=
 =?us-ascii?Q?3G4Y9hLf2Dw4luZlKS1/RMz881VtUuLPeswrb1Qa/kVwiUW5zXV3TrXzn7Z7?=
 =?us-ascii?Q?mXYrtKusCqFw2y4H8T6uB48IzQqP83xai7UfYqtPl+LUiA+9t06Rk+Znv3Cm?=
 =?us-ascii?Q?nF9gMluAGv50E4jIQytV8+045nnbG3SOZGXhDRiCfHvdk3TfCO+DvHDFRfcq?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e494acb-4167-4266-3cc7-08dad2a904e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 08:00:59.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNprsnetDAlDGsB265cpylAjYT/AXeQAgF2QRl3XeekK4OvSuh1Qn5YVDo0Q9f7tdo1ERy3KTEaIAlpBzMVohmotatzbrf5xTT2zHbbotCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7336
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2022 / 15:28, Chaitanya Kulkarni wrote:
> Introduce and use two new macros for calculating the page index from
> given sector and index (offset) of the sector in the page.
> The newly added macros makes code easy to read with meaningful name and
> explanation comments attached to it.
>=20
> While at it adjust the code in the null_free_sector() to return early
> to get rid of the extra identation.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=

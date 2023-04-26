Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF86EFC66
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbjDZVXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZVXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:23:02 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8C19B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDeM8nci9AgijV90dNcgFrYVFIAHmtYfGHbFVNyefjWxpzXEJZWz1HtKlejvd6+8NtpyrOdzsMyYG6WkWQSnrKmIwpDLK8b+zWDguQdA4I+tSai6CvuPket0NhIA1watDBzusK/lU9byJyNauDzIABFc869SaOcUDhiID06k9ghE5HZWuLUcot7dOpUGvWrYrVLR1uepR1reCHTSmHaLN7VOcLvNDqMaOZIKFRycIw3q84AxJJZ8ySmxlD/SEEsPT0CD8uGQP5YFegGyZxBV9UvSzbsfmT7OQA+XOaG3rvIYRpqjng5CC2EpWNSIKc8VFZaYOp1FjEP2ai2bdIXHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po76Rbq1I5mKafhEe9BitPa8Wldij0sAwG7yGqg3eXs=;
 b=n55NZ9/xXf3AoPod3yTRlXHkuqOD+jTxIKeYMuDtfoSkoxNhzi02M/0OZfVWFR0tUSzvy5P5QiZea8BWpu+Sjvi9j7UP69lzTiBALxUr0Pt9SVgYMPKA4bhiNXN9/1ajvEcfZRKAyopjXFHUFIHdYi0Iyrao5JWUxiCXwg24f2mFFDKZ7GcqdgdezcqW8XPZEONRfBO9bq1el9Ce4FzV0tyQlHVA20rm8eqpjKQW3CZpOcO0B3G8rp/zZxjKbRHsXeRULtAvltYnQCQhnNH9B76XTPXBCP2kKUNe5ajIU0vv6b5tS5H0SiG1hgjvF+DJJBxhxB+FNHQ0JiPwq1JIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po76Rbq1I5mKafhEe9BitPa8Wldij0sAwG7yGqg3eXs=;
 b=gWsDysONurCQGyexgK46WjZp557CmDXb73P5GuDgA+mETVN7LwN/VwUDGWw0YKfyp2xEO1zcZmZ4sXCi3ngscWcsvQlHt0ywoSCcDLKzEldsxfDkulZHZOCCVVpPV4un8I5Z7Eq5UBsSa/7hVd2vp89gurMLdLuoS2fPNZNhIeI=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL3PR05MB9186.namprd05.prod.outlook.com (2603:10b6:208:3bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 21:22:57 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 21:22:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jon Pan-Doh <pandoh@google.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Thread-Topic: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Thread-Index: AQHZeH5MzL7QCyjHEUuk1s9n/e4s+68+FGgAgAAFFgA=
Date:   Wed, 26 Apr 2023 21:22:56 +0000
Message-ID: <985C9735-6009-449B-BF9A-1293AFBCBDE7@vmware.com>
References: <20230426203256.237116-1-pandoh@google.com>
 <7F4D224A-A6A0-46BF-B008-A9E488257639@vmware.com>
In-Reply-To: <7F4D224A-A6A0-46BF-B008-A9E488257639@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BL3PR05MB9186:EE_
x-ms-office365-filtering-correlation-id: c5247137-f539-425b-3fcf-08db469c675f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2MYilILeBLbxIQOgz89YwIDvwhyu3PMFuzJdBUXvDjTgsUdbT+kO6kC4R5dtc8GRwesdo+edSeMm7jn+qA/YEwl3Ur3hN1yuyhTL06su1Ip6SDzV5DpTJMx4fRpqr+rIE8p5LHIMxLL/J5O3YDk0WtbRjtDV+7aUqdK3gqibXu28oVmnFUcTG7rswiYXzvyE6dU3JBu5gX9giQKavdWuAPIU11XrY5EJYwBG9qkM0m2LfKS2j+OwZ+Hhi/aNJ2yV5FbiDX+IoBE5SDQ+Nti9PvebVTADlpWeuENGPQVDdzwecP9ca4ZNKezWsFyEoZbXgCRo7JTfKHDlaZrtFyM6zEiJcNeHPgV4SwNLgkxw1iBhh2nkPKfJqBH2i9+LNfddN0bm3GZuH5y+oYRmKTLazmLUlY4edriijKt6ZZH4Yg515le7X+2zQJV7NoBXPNEp4yG5ymHP93QRJ+leqQB+Oon4GcbgVkj7sAI1B0nylGekMjUEBe5OMHZzKbGqnPSK+TIxiQhjExk6uJC3YS11pI65ZQTQy0tE6b5aNubf3/AinjWHSzMfNlnHsK0cp31oZJDWEHZcPtBCdSXsz4mgLF2r5dtqfdkgbMLHY5gK3AyzoU3K5abeR+NSO11/9D7JkkeDkR/f71hTW6uv7ZO3w6rETIfP7KhRJxDTFkHrYqXfO5V+J8LvBY+1JuuzEPv5zNXhNjj8WwAMnZiGb5DMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199021)(26005)(6506007)(6512007)(38100700002)(122000001)(71200400001)(6486002)(66556008)(64756008)(66446008)(41300700001)(4326008)(66946007)(478600001)(66476007)(6916009)(36756003)(86362001)(54906003)(76116006)(316002)(2616005)(83380400001)(186003)(53546011)(38070700005)(33656002)(8676002)(8936002)(4744005)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yWIKgRNjHvS5UhMMRz2z+rQXkD7iRJKtHdV2JpZx0dRip+/lMpdVIGFNvzLz?=
 =?us-ascii?Q?V5uUSjC69gPasGSof3xcBVaVc/r3WTCdctP5fZ/wXf6c39p1gqggFpxQ+3hL?=
 =?us-ascii?Q?67Rs1yPPM2A5IpGRiiiHCnhpsPQxRrzQ7RT4Lz19Q+qE/3fSxPYCXS4CucO0?=
 =?us-ascii?Q?TABGSp/OK4j4Ej9JtNSgKoZavItDmhA/q2MhqHsi0h1gXus/VKrodqLHy0om?=
 =?us-ascii?Q?F0jz/cr80INpdWvr1zsWITc/1EuDkcITCvmrQMeRuOb7QOOMI/kO2Am9t8mE?=
 =?us-ascii?Q?XHuBPEWQ+zXCMy2ZdAYoFQ2CFfVsvx0Hm4wozY4K38oMAlWK9xnj6l4Fsj+7?=
 =?us-ascii?Q?qcyF/+4g2coxvU9PALM9oiSp+rNWOYNL5yCo8UtmTB74P/fP6pzpvc18GHq8?=
 =?us-ascii?Q?E6aDRK+4om4ABsI6k1vqpUYuwH/Eu9LnbBACYhx3AKZ0K8jWqXvuFlVw+1jd?=
 =?us-ascii?Q?pk7HFD/myMjqEu4YVEfBv/LkkePWHfA/6zeOcDQZ7N10fIvLZOGzyvRTtLDd?=
 =?us-ascii?Q?oUAAPJEF6+m0dnLKTaZqh9K3Y6GlHCrmaM8FvRaF2EBqPODhzFXKsxCvHI+G?=
 =?us-ascii?Q?lonWyi7YzkQJSgWTsqyJceiir+ykVI+PCQdOarbQ1Zux+THXdUUnocrG5SWP?=
 =?us-ascii?Q?0uII5gO50K018ZPzqbEoAJKnIy1/LBpKH2H6727TmFmE6rJdTk2N+NNht/i5?=
 =?us-ascii?Q?BX9zA/Ep+7LUm5hc5JvqFUN1bE1doptFt2wjiHQaLhvhPJrF3733L3tH17sN?=
 =?us-ascii?Q?0Uim9ddSbckdMy5NhYSmgKuC6lKexgojWYL8o9EGGAkkqZVP69hrJjyUabsA?=
 =?us-ascii?Q?y661FXL5Xy9q0mDomaoXlNNj6aWs4+lyF7t528P/nMq2mTEzRHCInZZan1An?=
 =?us-ascii?Q?3IH8xYgF8TYbmOH88WBWX2Pn79P6mD8UIMDU42BMNPmC5fT9uPfEnxb9vhUw?=
 =?us-ascii?Q?pXyQDvQIWUI1gpAKqzaiHw+YgNNe0G1KlKcY1L42VSDefdq15ETfWgipSRe5?=
 =?us-ascii?Q?yu350JI6O/TZUrNSE59e1BHKea16tQGZaPZZsFcMG2CTTCtlOvkGfR55KQuk?=
 =?us-ascii?Q?sb9ChEpWmYf3xjs28feMrHca4w88581wyVOvhwQom+cxYY6PaCkHyB2KbevP?=
 =?us-ascii?Q?cCL6PvumPIHeaAuByh/OpcyXFLD4zwt0MH7G0VFp43Tzh2m3xlmmPzNb15Zl?=
 =?us-ascii?Q?SWlsEDyAnS3RaCoseeD/BcXRyPBRrmCR8b3vV7quipgVtufiUlQzZsD4bCRq?=
 =?us-ascii?Q?Qhn8Zws8XlC5EiFD6TgcfgMz+nD9brTTQl5+3AAZM7j0XKbkDmUxkd5j6thq?=
 =?us-ascii?Q?KgIJ37IIRkBD1jPvwFX01IGfyfXvb7YNtDEEV6s5lFnPR9jlwp51S2c1G3f1?=
 =?us-ascii?Q?0vHlSqqoFaXmrWni7y7WlziE8D0hh5WGU5iU/J43kVP3hiua0bHo1j8GRyLL?=
 =?us-ascii?Q?YHg4SFCJUrdOFRwM6ATDy5wAazYueaZCQYwHqsTFglW+nVw0zO1jUzE/stp+?=
 =?us-ascii?Q?dDFdy1EBKVDCxkAnAlkwWAJdPguCxooYgRFzR3QGMz/xR6tCLlXiAqPXIhov?=
 =?us-ascii?Q?PSC3JoCpmDO0wjpoREofaCwLppgGxpEyLFuNEeMu?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0F9808E4945DF4992F670F28F7FC4AF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5247137-f539-425b-3fcf-08db469c675f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 21:22:56.5776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyEMxqyzHEmY0lLX2T1HrH1+qKYdC4sNfe1rDCUWh7ZvP5pvjcdiWb8kZhwZMYYcn4RHCH1ZinjoV55idSc9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR05MB9186
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 26, 2023, at 2:04 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
>=20
>=20
>> On Apr 26, 2023, at 1:32 PM, Jon Pan-Doh <pandoh@google.com> wrote:
>>=20
>> When running on an AMD vIOMMU, we observed multiple invalidations (of
>> decreasing power of 2 aligned sizes) when unmapping a single page.
>>=20
>> Domain flush takes gather bounds (end-start) as size param. However,
>> gather->end is defined as the last inclusive address (start + size - 1).
>> This leads to an off by 1 error.
>>=20
>> With this patch, verified that 1 invalidation occurs when unmapping a
>> single page.
>>=20
>> Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a V=
M")
>> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
>> Tested-by: Sudheer Dantuluri <dantuluris@google.com>
>> Suggested-by: Gary Zibrat <gzibrat@google.com>
>>=20
>=20
> Sorry for that.
>=20
> Acked-by: Nadav Amit <namit@vmware.com>

P.S. I think it is stable-worthy.


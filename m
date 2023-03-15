Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7D6BA674
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCOFCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCOFCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:02:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659EC5FA44;
        Tue, 14 Mar 2023 22:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpEVQZ/t7OAxEGwFqWA0SrAWqPk1R1HSwi9zQ3v2Ukwaue6bsJflFf5bsOlanCRJIZH0CcF3pqRC93kux2NlxZ9SPXgZVC999OhG3Thc/fnPdzqcKXQLR/IcC9RT9bKLftAiB+Cw+QsFPW/ZBOI/WzrW+LyGakAU9qfNVeL2ctSzyphlmVRVkGRTTbWexgmiTAVTB20Qm954v3ulMdttLenBFLoxhazbuWIx/TmQh+PtQFj7zWhDYE0cwg+8kTNERFSk+eiwmIThYBLGD3OA0GVsfQMpm7x8nUWVwngFo+N9yaighW6mhlH2o5c/WotWzXB0s5EX5pINqC6a0fX6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0gY6UeirXaRTncJDqz2ieWv2ni7ffE4qdtudrsnb3k=;
 b=aRn46a1vmPapDjT4jr+vvI/Qx+TBwT4Kim4WsOy3L2NzZc9/gV9OnVkp8XrDeKZc7NKrC7uXdosgVk4nFXFHgRb7gwGreuyh70QWL6ZPhTKfw/La5T+CoJVfJ8CyC/C5z/uGyOeImo7DwHW3fnc3a5+tjnZdVf5MgL9LFuka3gThvPyinuX9dNRn+xlKMrCHrNNqd2iVoAgzxgHKNP+BwLshIYXzAKFL+AO8OgcPSWvRxvZUkWcJGHWWBgY8zjXNFROJ0lIXqSQioct0IHWpd9DHnFv8rZsOFh/dBz74TzCIClWeQC/2EfxntvgpUU+jhv//t+ziuJmia4mMRSZVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0gY6UeirXaRTncJDqz2ieWv2ni7ffE4qdtudrsnb3k=;
 b=IP003dsvs+VVi8+DiWOw6xfwv5NdEts+L20r7XBaN46w134DOCBLRUteIbyycy/8SmJY6iqi3sDaa1sUAdYhxeXebA1FRJfZIlfu4artYeELBZ1NOnhpAdJ4EVGRIJEGe8e2Ar0EFGcnD3LCbgvMuN4dhjGbRRzu15CpOBNLhvA=
Received: from MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 05:02:39 +0000
Received: from MN2PR12MB4607.namprd12.prod.outlook.com
 ([fe80::68bb:3dc7:2fc2:fc00]) by MN2PR12MB4607.namprd12.prod.outlook.com
 ([fe80::68bb:3dc7:2fc2:fc00%3]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 05:02:39 +0000
From:   "Harsha, Harsha" <harsha.harsha@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "saratcha@xilinx.com" <saratcha@xilinx.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Shah, Dhaval (CPG-PSAV)" <dhaval.r.shah@amd.com>
Subject: RE: [PATCH 3/4] crypto: xilinx: Add ZynqMP RSA driver
Thread-Topic: [PATCH 3/4] crypto: xilinx: Add ZynqMP RSA driver
Thread-Index: AQHZQ1tHDsof4pLv3EOE4blAOG7Zi67z8FwAgAd/PTA=
Date:   Wed, 15 Mar 2023 05:02:39 +0000
Message-ID: <MN2PR12MB460728BD61F5B2D7C06FFEF2F3BF9@MN2PR12MB4607.namprd12.prod.outlook.com>
References: <20230218053809.1780-1-harsha.harsha@amd.com>
 <20230218053809.1780-4-harsha.harsha@amd.com>
 <ZAsHHOOpEzXVY23I@gondor.apana.org.au>
In-Reply-To: <ZAsHHOOpEzXVY23I@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4607:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: 706c80ad-bf6c-443e-b481-08db25128024
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7daDWbA63NLnyRJZdCDEpSFSuGDqf07eiyWzSTq1ShtIn7QOyZtSKCCGjp2o/OVZ18vAsoWDQXdNv6GTu21TDDxtwCqdH47ncrE2bThmkxnJwbds8/0GicGgXrXqP9SU3F8YoE8t3llGqirAsV7N61qwrpO/VNaKWgZOk/tfDGBSAr/U+a0NQNppIzm727EtvptsbCxB3VHMHK4rXzz5YOMsh/sojN/TFnNSwU05lN2k8GinH/VDSTuWaa6IxpLvo0GA0NHFya3LCpFu7lahTZeSnE0s6QrTTdoG+XHZJ5zOqWlaGxQCiHdejKlzZOfT31Bnk9rZ2oBQYUFx92lkaz4WN7aN7grE8D73kUukkpkq5cJ8yDav3I8SLWgtvDq1Q50ZAW9CdUtQLYnJzs2iQBGHteFPMauqNy2iNhxqEFY1DBCIm2QWeaBDMdIqvkLDBqUSyZaPBAUUxXsPfvV/i1E3WSvZGiCYZdRAPoOrhe5zAxGv5xsmdcThg4Wb9fdOR/pI3K9oWM0MPZeFXiejxoQmY/2TAsCFK4RktwPw47stoYTcCnW0XFJpOVxj1B0c3RqURtnRQ2RdzWdavbnZw1gSoeO6WX9mFENbB4Y1x8z3lAG27OOJQd3Kw+B7K6F9D1kSzwvAomfPZmvw5IcYNgcZyoCmW5hnWLZSqA1GG7xjWrXAlXD5Tpn+SkMWE60w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(5660300002)(52536014)(8936002)(41300700001)(2906002)(38100700002)(38070700005)(33656002)(86362001)(7696005)(122000001)(478600001)(6916009)(66556008)(66946007)(966005)(76116006)(64756008)(66446008)(8676002)(71200400001)(66476007)(4326008)(55016003)(316002)(83380400001)(54906003)(6506007)(186003)(26005)(9686003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cn7hLedxoMjTh1txli87m6AvKyoicEZsMLsxYT16u3FAWXQUG8+1E/yVx5mB?=
 =?us-ascii?Q?RCLPhcpYUmu+4HkyzOcjRYVpnL9IfVGr+4m1E6GEZYTyiIo/CzIkH+Rg6S2K?=
 =?us-ascii?Q?UHoSK7RxpnI2Fwdu9bjgK9DM7KaxMEiqUxbUc0iufqgvIk8Q2yPH3i9zbVtd?=
 =?us-ascii?Q?AKPQz1nqgFy87PBYQHjk2iLubMRGxG28UqCd7Nu5oug6o5nNbKN0c4mZ07jW?=
 =?us-ascii?Q?SXKjNhsnWW6TPCB8BlNZr+6yAmmIxxFrjmjQkJUEtCUBJRT+r17uz9vFhums?=
 =?us-ascii?Q?h3b8dat4AnSQ3UVEHH1tEIe2bzkQf47/zLDUpLXx43GWPLOuxejCXvmSOsuR?=
 =?us-ascii?Q?ATYXRsL2dSj6jyPfdjteqesMECESS6fkmgZ3ADshg8p7i98a7lJV25Dpscp0?=
 =?us-ascii?Q?oW1DpLrt5E3gUq6GSZLP3L7NtdXNJeHMcNnqSFoqvIZ0gGUzuIrNQkEaFt5s?=
 =?us-ascii?Q?4lsa2vWYNbyHMkFUYO702divJRQj5JIPep1OTmVm003JgdH98jtLKhPH7Cx7?=
 =?us-ascii?Q?YPahPI2nZYTLb5TLZJKRXziZe2JdnIKk6e/cSmqelMgYYvGYrejMtnAYhVzf?=
 =?us-ascii?Q?jV6QAInDKvV9i+8ZuKOSni/2qx3/A20jTENyG/ABCBrmqOy2EmpY40D3JbWU?=
 =?us-ascii?Q?9IPFYR028wqCQgHvtRVM4OVh0TJ+pnP0EJlPdshFt5N2PvanKjcSqF94Tu9j?=
 =?us-ascii?Q?NvFyYmz7HpL64z44KmS1+jkxUpyr81ltB/xSwPTDmiECN3AO0u/1PZpySmcw?=
 =?us-ascii?Q?awqzp2l5CoI2k2icAwlMLCEO775YMl7Q+g4l++o9SYfCIXr+WX0F1Hvsn8mX?=
 =?us-ascii?Q?CzqeBAzUSXIw7D9LFaviwR9Xj0WAmxWUi8kX1OmvwrZQW8aEj+b85Hxo4crP?=
 =?us-ascii?Q?iyavEd6cdE5tzk39Jw1gsLfyv0aFGdVJDk+qyWoFiIHFspCDCSHvTPst3Blt?=
 =?us-ascii?Q?5exSi1U6vxx1wm5dmBBIBqBp45kD+VL/NQ3gT3NWWzb+btIRGglipCkje37m?=
 =?us-ascii?Q?PbYVSwS5bybef91EzHEzRu1hfq0KRy4L6q58EU7UKw3RiZv4RJQaTdfZMxSg?=
 =?us-ascii?Q?RdqkJvrvYHhMCUMtsTQ2768A7piW7diypI1Fv/8WRmDQJ0D7eFvi3ulqK9M9?=
 =?us-ascii?Q?cznSi7WlZgdQIdTIwafWOB6giKf6iezmIikj30BrQvwpNYhyVqwmbjJuKMSx?=
 =?us-ascii?Q?brGeeY2dcdeHiMoy6397U37NitVJ5zgFN37ce+OUTbuOYtgvVpMbkeuOU+cq?=
 =?us-ascii?Q?9BN1trSCaWbfjqeEJsglHvSg3qZnSrZ+DjlnKQmUwtXSaZLrVbb3Eysfi69u?=
 =?us-ascii?Q?qlVCPyCarSmocgS07fNehAz5cI+94NkiCpqzJqmSYQ2Gtpoooa88MsMP0XHK?=
 =?us-ascii?Q?Ro3GZe0EJTb0HJn8pyL+Udj25lg+DrZyPQehaGNjvSS6KuO9KByVyceuvLVw?=
 =?us-ascii?Q?6aeSqMzwSEK40EkegILyLU8AQeeU64Ax3NlXdXfnLUTv47luMfJXTRpLXs3D?=
 =?us-ascii?Q?FBSo6u+lmnyA9PLlBuueo16NWJPKkarAHw0TM09i3PWKLWDgSf4lOodEn+86?=
 =?us-ascii?Q?WgxJ6f5qicYf0t7monY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706c80ad-bf6c-443e-b481-08db25128024
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 05:02:39.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va+D5kFgwyLmDbVPmVpuMpvdkFNrVRObeceugbb1jauzcWtIfxiqT9wHFmnkYt36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, March 10, 2023 4:02 PM
> To: Harsha, Harsha <harsha.harsha@amd.com>
> Cc: davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> michals@xilinx.com; saratcha@xilinx.com; git (AMD-Xilinx) <git@amd.com>;
> Shah, Dhaval (CPG-PSAV) <dhaval.r.shah@amd.com>
> Subject: Re: [PATCH 3/4] crypto: xilinx: Add ZynqMP RSA driver
>=20
> On Sat, Feb 18, 2023 at 11:08:08AM +0530, Harsha Harsha wrote:
> >
> > +			.cra_flags =3D CRYPTO_ALG_TYPE_AKCIPHER |
> > +				     CRYPTO_ALG_KERN_DRIVER_ONLY |
> > +				     CRYPTO_ALG_ALLOCATES_MEMORY |
> > +				     CRYPTO_ALG_NEED_FALLBACK,
>=20
> The driver appears to be async so you should set the flag
> CRYPTO_ALG_ASYNC.

Thanks for the review.
For the RSA driver, below is the flow of operation:
RSA linux driver -> ATF -> Firmware -> RSA hardware engine.

To perform the operation, the request goes to the RSA HW engine. Once the o=
peration is done, the response is sent back
via firmware and ATF to the linux driver. Meanwhile the API in the linux dr=
iver waits until the operation is complete.
This is why the driver is synchronous and therefore the CRYPTO_ALG_ASYNC fl=
ag is not set.

Regards,
Harsha

>=20
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE896D411C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjDCJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjDCJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFD65BB;
        Mon,  3 Apr 2023 02:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlNqvBfFr8nVWDXnwXXaATG13iLKOW0daZ8uWaUOwwhjuOfgJBaUUs0XjYymK1JRbiycAnD6vhmamLShQIlVS6iW3mhU0YZLpuzYqTh6PimDxJXblw7EoFVCInVfmGnW6cI6UFp0Oo9FHg6lyOf5FjxwKLsoY52Puy7MH1Y0NHXXSCp2FS6xCtmbyio1EmHaX88Hg1PPBDu+xJFGOybaxdOdJinEkBmQdKg6EF65LmOT3+fqmEHg7KnXk8cfUIjVqyyry4V9n2TdpaVfScTthmXtqQMamgBdtvgKbGHnReDk2uC5NQaniEPU/+DJuWEk8XJv632FSfq+k/2rmADthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RYgv8N+j3k7nxIQgJvlAaBBYeRpdcVwG6bECK54+4w=;
 b=GNpeqAfw1o/OQIiwX096CaN4x7MArhNCgnVneW50qvhsjjeZAC/ygNLp1OExTslkXTGvzauxGxhsbYX2YAq68mTDpjDI0/FuyleO4m2SxNaQxjOgBZAJFyQPl3aELBUylm9LIQ2DeOPx9f01ZwQWcur64oZ/W6Z0QDO2nrbqy1zw/fwJia3fUuKaJc0IfPK4OkBBrjjst0g5LK8AbbxQe2WyNASuXwyktv8U94McyDDS5t6QL2NP/4HT/pNfmsprqKev1/tXC7g6DbBRQA5qHES3cNg6fxwkkmT3Kvg68135RoyKou0HZ2rVCZcoFyfCD9UOXf2dmpDScGNQqORDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RYgv8N+j3k7nxIQgJvlAaBBYeRpdcVwG6bECK54+4w=;
 b=tk5Hrcq9yr115iue6UtJQ/j4Qo46BXBSxaX49bib4ij4inCzeDd97j/NJfluzKJPhe6TasdlPQir+00StuGXj/eBqoIkwJvXFDVEDjfMLlEETPBBqpO8UFF1FmJ8EAb0CnaiExoUN22/BN2dfpPzq0LONjpbfVwVO0HOZ/RUjqI=
Received: from MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 09:47:59 +0000
Received: from MN2PR12MB4607.namprd12.prod.outlook.com
 ([fe80::68bb:3dc7:2fc2:fc00]) by MN2PR12MB4607.namprd12.prod.outlook.com
 ([fe80::68bb:3dc7:2fc2:fc00%3]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:47:58 +0000
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
Subject: RE: [PATCH V2 3/4] crypto: xilinx: Add ZynqMP RSA driver
Thread-Topic: [PATCH V2 3/4] crypto: xilinx: Add ZynqMP RSA driver
Thread-Index: AQHZW7b6DfKLwgB1B02PBPlygQUroK8Up9+AgATDHaA=
Date:   Mon, 3 Apr 2023 09:47:58 +0000
Message-ID: <MN2PR12MB46070886A98A29851B65133BF3929@MN2PR12MB4607.namprd12.prod.outlook.com>
References: <20230321053446.4303-1-harsha.harsha@amd.com>
 <20230321053446.4303-4-harsha.harsha@amd.com>
 <ZCah3f/Z8nzdHITy@gondor.apana.org.au>
In-Reply-To: <ZCah3f/Z8nzdHITy@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4607:EE_|PH8PR12MB7278:EE_
x-ms-office365-filtering-correlation-id: 5dca1c10-14c8-46a4-7744-08db342881e5
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cb2bePvBb+JH4PSNrFbwqg/P+7w9FeecbrU2xfWIuRDPCxlGASJHq7nU8GAbiw4fVo+su456zPGW+TKCj1YPJfiSCi0h5zJ5QsvhGe17vXWSllJhdyzATuUocJeFIXPBipWGiI5gaRa5f2XktC0osZHmPgiJ7bK7rm3qLq51tsVuujI1R3CLwJc2gh43Va1lM5hnCfICW48UhZ5ZorwbbjI6bgXHb1hDs7hRUQU2dHi/uiLCZqVYIMiiOhgPG5VAJFBaBd3ArU7WLE2V8k1mtRFQnbihgSt8mQA/Uwe8QItsfRPF83ZI2xbOaICqNxdNpkE0TpgSg90EYTM7LrjUKuGJczzw/4Q05fmzFsxsqfX9TMwEAhUEPzPBl49P1kWW8KByMnEY9ZMwgXB6YRKTXNQGeUJTbKUMj7EY4CoYGFx5jYkYg5kVQ7WaR3TnR+ce6i+Um9ULaGVU7YJIcjP7aaGcX4u7Uq14xtXUGM8wqOE4VN6TZtLH+VNu3LkX3EkB386coAoieDj9qWpZRciesD1l9CkJiDlcF6hmGXhAK7lzKtbgkjUGVTEqu0Y49bSmwoBC4afANANv2k1pQU8Wz3ey7fV+uQa6x2y9m+g8YbQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(55016003)(41300700001)(8676002)(4326008)(66556008)(478600001)(66946007)(64756008)(66476007)(6916009)(76116006)(66446008)(316002)(8936002)(54906003)(122000001)(52536014)(5660300002)(38100700002)(186003)(53546011)(83380400001)(7696005)(966005)(71200400001)(9686003)(6506007)(26005)(86362001)(2906002)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?22fVYKBKzFEZJ3hHvZeZx8m091LoUBMSkkDC7PA+YdvP0mpEc2SMuok6dTYk?=
 =?us-ascii?Q?fVq5I7zDcEymMRinrtUrT21Kn4YLltmkhB7HaYoVwDKe1y91ECr3SVuWJ7pt?=
 =?us-ascii?Q?xnyb31evLCFR+kcvHHzjEp9RdovEQZZv/tmVX7k04a4rama8QuQjp7d+A8pf?=
 =?us-ascii?Q?vtxxn2ApW8Y/BTmy/CjiVQr6toRuqxwryWjTepETPMkVK7DU06AllTZUNQZF?=
 =?us-ascii?Q?AjTho1gLQUj1S52ccBPTle4Nt4Ifbr3z1YVpzruGwk5LYnL/eDzXrQco+t7j?=
 =?us-ascii?Q?2imOvVq9PxU7LZD0QpnSJIWc01rUkUJxz1T4EPz/85LnYoAQ3sbuC+2yiLaV?=
 =?us-ascii?Q?WxDA61xmUkBozgirQw22dFAbXP3ompCfVrS5i6nxGwKVdtGVUiPHtCyqI0Et?=
 =?us-ascii?Q?qDiQqVlVt4kvMdV8a9x6eMN6ZTxy3DOJPbTDxAxQhM7Y+1vfGcvvcigIl0By?=
 =?us-ascii?Q?aIzKfmLNbqDS6Kfk7UODUdjkEf9oEPNlZ/2rGF8/f+2erU9ag61qu4rgW49a?=
 =?us-ascii?Q?dDVITfeWgPoVvdXuQrSrizJ/pJtcaURWNbZ5Elw0dye7In4GhSAgozPw7+6C?=
 =?us-ascii?Q?Wp4whFLJAUeomJFpeMvJbYkjejchkkXFqLZCTBYQgqEd0iHxDH85XDtfOydJ?=
 =?us-ascii?Q?NYuut8f9IO/qLtA3qUzt3eldvCfCjxcqfrWnrUgXdEwZmR0h1LS9/6+TYt1n?=
 =?us-ascii?Q?Q3jvOQKH+PblpyAQCV9qukfXo6HS3esN6YZ4OpkXWA+MOFqXQcq9XzLN2h3q?=
 =?us-ascii?Q?aEgd84S3x8SWJ933k9WAk6BNerEPTY11Py3UZ62yCz+2C7kJBXn0fWle1u8R?=
 =?us-ascii?Q?sD17uRxcQVSxns5QjMyksyUVVNUK4dNLOkOJG9JWCrnKrxetj0y5AcDGbo7u?=
 =?us-ascii?Q?f3ZEPuGipE4ZP6wzjXIKwqkkXLjClqmwmY+erg6M6lw6BJPuvaY2m6gO1TMM?=
 =?us-ascii?Q?UNqUxjFPOuOkNWPoOweVRCVrpsRjBq726CwL0U/v5dB6zD+mSA+ngjjBae4R?=
 =?us-ascii?Q?ZrNT3AuzfEbipu8+DhGLOnCmvsl/I5cU/32mpNMQ8lyScgXIZTAuMycGTtyb?=
 =?us-ascii?Q?HEvCvcstzFifpsxsA7BKZakgGQvgyu23mchYOKruYcXwbsbeo6E1eNfnmGe8?=
 =?us-ascii?Q?0s2J1wRib3P9o0MqMU5ykcYaYNfsKA97AdjHTw9kKYi3P/JAKAfr2a06JRk9?=
 =?us-ascii?Q?4L9WFbuOsIs44o30bAKF08VTwbT6b+hZGO60z7P3XWjKqjcLNSRaeXKh6ZQ8?=
 =?us-ascii?Q?Vy3ONf2tVgYlmDuM9KT7BGtj3HRio56penUxQgsKW97U93gkuyqkWAZvCqmF?=
 =?us-ascii?Q?n48bjVOnx0VR2H+/ADeFonfRmFA38D9zDmNXD5T9XyjiCirgYZfTSz6SkDW4?=
 =?us-ascii?Q?W793epuYkyIlKP3kAk/4odcaEFrUtSZSV6dMj21V2XQrjnX9ogBzjvi1Jxrf?=
 =?us-ascii?Q?XMZLq2QiaS74BRr5CXBRRO52mYsnh7Za+ZEL2WX6CfdYIAAfKpd7uKG2RSAH?=
 =?us-ascii?Q?qeV/jq4ViNWeoJG/6vQARvJN7oGoAAYeuXSurr60HIwBt47GXYBZpJvAIOpD?=
 =?us-ascii?Q?6jvxAPi4yffVbWH9mRk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dca1c10-14c8-46a4-7744-08db342881e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:47:58.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QatCGiyTlEW4lY/LQE8eOt0hTEWd5/q3oYk3V1wvzu574GTpAT8EBpc6vC7Zk1tL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,


> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, March 31, 2023 2:33 PM
> To: Harsha, Harsha <harsha.harsha@amd.com>
> Cc: davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> michals@xilinx.com; saratcha@xilinx.com; git (AMD-Xilinx) <git@amd.com>;
> Shah, Dhaval (CPG-PSAV) <dhaval.r.shah@amd.com>
> Subject: Re: [PATCH V2 3/4] crypto: xilinx: Add ZynqMP RSA driver
>=20
> On Tue, Mar 21, 2023 at 11:04:45AM +0530, Harsha Harsha wrote:
> >
> > +static inline int xilinx_copy_and_save_keypart(u8 **kpbuf, unsigned in=
t
> *kplen,
> > +					       const u8 *buf, size_t sz) {
> > +	int nskip;
> > +
> > +	for (nskip =3D 0; nskip < sz; nskip++)
> > +		if (buf[nskip])
> > +			break;
> > +
> > +	*kplen =3D sz - nskip;
> > +	*kpbuf =3D kmemdup(buf + nskip, *kplen, GFP_KERNEL);
> > +	if (!*kpbuf)
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static int xilinx_rsa_setkey(struct crypto_akcipher *tfm, const void *=
key,
> > +			     unsigned int keylen, bool private) {
> > +	struct xilinx_rsa_tfm_ctx *tctx =3D akcipher_tfm_ctx(tfm);
> > +	struct rsa_key raw_key;
> > +	int ret;
> > +
> > +	if (private)
> > +		ret =3D rsa_parse_priv_key(&raw_key, key, keylen);
> > +	else
> > +		ret =3D rsa_parse_pub_key(&raw_key, key, keylen);
> > +	if (ret)
> > +		goto n_key;
> > +
> > +	ret =3D xilinx_copy_and_save_keypart(&tctx->n_buf, &tctx->n_len,
> > +					   raw_key.n, raw_key.n_sz);
>=20
> What happens when you call setkey twice? Wouldn't this leak memory?

Thanks for the review. I will check the behavior and get back to you.

Regards,
Harsha

>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

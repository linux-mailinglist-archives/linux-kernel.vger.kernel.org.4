Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFA1639831
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 21:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKZUS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 15:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKZUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 15:18:23 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB6415FF7;
        Sat, 26 Nov 2022 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669493901; x=1701029901;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/+lzXLIDzVP9K+yUIFFoBpGyp+MEFrCz3Ee/rw2xmZg=;
  b=CiGEw4aQB6z6ZTrLc+9XMXUA+LYhqWdymDNgSbgoZpW8ihXdwNAk/Gz2
   6h3F0Wi0NO3WvqMa48pzZvVQWq3mJy+EiKiCtTRYlOgjhMeumKtjMCVFr
   r3etj1Fd8DlpSSan0eRS2g2wUMPLE20djplF48SCQ/XwK2Nq2nAjGyZHJ
   NxViMrOq2lBiM09Sils1g4U5Bro2CUU48iwMqOUuGd+wrC5cGVxM/vATo
   3GN2wDusp9utjolA+bq9o/AhMhwkRCtV02Y/HwF637a4zPuwgsBOFdyAS
   lw2QpZSQidPZfAXgcMlutq8N3/x4LUnXvYz5W0SSbqR5hpeYduc+Ebhvo
   A==;
X-IronPort-AV: E=Sophos;i="5.96,197,1665417600"; 
   d="scan'208";a="329345350"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2022 04:18:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2A/wN2GU9qWzSNop6w3sl30mLbD3GQaogzwpqHV449Aw5kSVwzFf6b4F6+gvNgGxxmbCgZZr39AAg6UA7Qqg+ZzFzDzW75dcCEjbKG8rqKUtkHnIBeuCg5rPRbbFil9u0A3ige17NOn5styRyqM+q5Cxok2HXvZBdVp87L29tQbnPWLATDi71iZGj6peawP2PMNgPHbE5bTqqctXKp2/au+Svjhji2ojJk4c/YMSNYh5nceb+rSbkGfKASxloDmPkytln3pbF59OSl/iNr5KkQOoalUgIyOR2ImEFcumTNHvz24T+7dqXr5LcE6QKqUsU+TQSR72igHCkSRO/HuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8iTTmZmdjwk2YN5KoxoLMxk3+oEGG+PNVWCufdojM0=;
 b=BS8Gq1rk0ZmrOpVByFBlIziBna7Kr8MwroVqv47OBvopApMHECpMLS4C/ZS+OJr/1UKbpPchLCkXxTkeS/9uPIgp6byh2rO2ntS2ZVcKfqiZefBy3nIjMrkfjRcNqRoGHEjBjmr4BwYZSos3d4qbE9sjdo58PTRoFNLS1LaVtIONcBE5rlH9EJmbS5Jmntcx3UWZhOdLL75ElPGlZMAZ6vmfeXzn78SzhXS7G7hOP4njnUE4qA13UlEyBvS4SgGxy1Y/ae0S4ebU1uC2affFqD1872ZHZRSYEPSFVTKDBk5IJoY3EX8KPrnDB63StQj7ro9zvY7qZRRrU1lDo4gIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8iTTmZmdjwk2YN5KoxoLMxk3+oEGG+PNVWCufdojM0=;
 b=sLpqYUR/JE5aE7b8bM4nZ/eqx95ZaLiyL0frYKhLikGr8IPD13g4zjXMK1vWAqlWb09OTLYRrarb6wKdwM+fWijwQJvEYav1UrYHGPIF6mIorPao/C7RIq65eROBf6S709YPgpqpS1hOYNVF4BdUJNrNoRqm0oHvsU9QnGPb0NU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.20; Sat, 26 Nov 2022 20:18:17 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5857.021; Sat, 26 Nov 2022
 20:18:17 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: remove non-data R1B ioctl workaround
Thread-Topic: [PATCH] mmc: block: remove non-data R1B ioctl workaround
Thread-Index: Adj/YjUrXkzlUmHATlmcTHF+6XwQXwCb623A
Date:   Sat, 26 Nov 2022 20:18:16 +0000
Message-ID: <DM6PR04MB6575FEC365167C7347D7FF2FFC119@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <dd632a86fb924b019d1a009b17eb3cbc@hyperstone.com>
In-Reply-To: <dd632a86fb924b019d1a009b17eb3cbc@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CY4PR04MB0760:EE_
x-ms-office365-filtering-correlation-id: 4dd8ddcf-efb0-4e1e-e860-08dacfeb5a91
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+DqQrV9tWUv32W5lnUJXlJ1fpMAYpW1HzlcOUAqd/Hov5D48lAYbmoyHwbtgv1YyyGr2A12JHA9Y2c3LPD6E7nvprX3uGH+yu2IDiqzZmYAJpgoW/u+e6ilBS/y97e62Ou62dxoIH25Kjz5TVCjXnjcgh2QFYhUL+r9vV7DIz3AtLTnNVD4tW3XMHT2HfBi2JwuQk5GcCzetCuk1or69yZfsrU3QABral5u5LkygeDeXrhH+Rj2qzSOKSa8D0MBeN/H0zWa9vNS6Ybdm+wATB4LyzR4WT/sZz6I8jj6NO84DSNLlTbUE7CPNKgWw9pk4/b5b7ceEJ4kvtwfRTlt7cdfnSGhCer4MbclPGUAYJCP62YctXc4kcby4j1QIsPZG1pkE/Xi5n0eqaD7EMSPFxWeLTgqiiNPzxXdmrY2InYklgtXIzitY5Tpxq3J9uahdsLbcXyyZe2w+gHrj7l49cCZTa3gS/Q27HJmJMVewrikFJ0Q9VHGPzUT6qYHTwzGGbVHlh+r8+qLA6AY49xskeKl9lLSJDOm6ay1zP2sMR1iUYep7PMFqd9OEeokJ9sMxB+0aESVHEcNBWh6g3gou0KlXB6KbN/3/c6jg4NraJZO3PlSAq9+A76/erVpmact/CkvUGg9hElQP+rJaH5NzW6tC/Fe2xfPhkkoFrgcw/asqvtL8dOPu47UU3MV+qNc9YAJKDUnudvMxEyb97aUsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(122000001)(82960400001)(83380400001)(2906002)(38070700005)(41300700001)(52536014)(8936002)(110136005)(316002)(86362001)(33656002)(6506007)(186003)(55016003)(9686003)(5660300002)(7696005)(26005)(38100700002)(76116006)(478600001)(8676002)(66446008)(66556008)(71200400001)(66476007)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bf31kEI00A6xeYRfp+VbxaMaVUrjhzrMWDrLLsWIh+/eE/yut3NEWP1TV3?=
 =?iso-8859-1?Q?o4VDcrltak3xLbttNZCnTVqvbX3VYNvZ2V/FJePY3jkNxPfzPVBLDiYZO6?=
 =?iso-8859-1?Q?swpx9gT9uCp+12+KjACVz9oONHB93QbmIwxRkhN7axiVbtf+r9Ns9/B7q2?=
 =?iso-8859-1?Q?yPt+mG7hzgmfteGvt9AwG69vFThfmHoDTzVPcpgLS/l7asHdm8lIsjxpCq?=
 =?iso-8859-1?Q?qbN4wJAJz6h/P3k20Zj6uvb/cQSVB099FfpBeQWK/yNTnhywMRl/pwMEWv?=
 =?iso-8859-1?Q?w4JZtAKAog0JuTThj1KWGpfsSb54NvLcBX0iVFskuDHctP0fEAyXXVjGIf?=
 =?iso-8859-1?Q?M4P1aGAnPoYdoqV1lewQdUXeMwhsw6siEkwgKjMMZx2E+K82pJBiXokRbz?=
 =?iso-8859-1?Q?+tY0htooT+A6bhfRrB28fHVxhRFREfSnqF+3CQLDFYfprSXfA1L6tzTT00?=
 =?iso-8859-1?Q?qnaCwRHv0W7WituFMNVmWN4kABr2r3E8t2x1Z9uum3DmWXy59szIz/OYpL?=
 =?iso-8859-1?Q?Gw6G9TmBr3ciEweaxDw57ncC14oS0inuNCnY+bvT5xy4q9Lf51yNmAeG80?=
 =?iso-8859-1?Q?GT54jrvGcL3jX4GD78JcGkLLfPVclQp7vMUjYDhGf4vzhGIzP85Y9a3Uf6?=
 =?iso-8859-1?Q?V+k2BEU9SoAaVmJUoS3OhS2GMUYoR1gBm0GSfAeZKydHbHSDTm/ZQzZVIS?=
 =?iso-8859-1?Q?uY4m1r3eMA891JGSHS7xvXAa8Ndssaeuu5ykf2UapytUtm/OSWWQZHngD9?=
 =?iso-8859-1?Q?HbtwvjAnvh+ePJziGZ7evS4acQHdhkJdgzy6J5+n1My2sNXx48niSg4vfK?=
 =?iso-8859-1?Q?pJH5Bycn1xYriHET2RfZL4Gr7Zpa2Y+sDPm0XBQrKW1UY3MOnd6lYHRy7g?=
 =?iso-8859-1?Q?E4kL/ZlM+nS6OOZXnJhz0noBYJiMxGcGIYIiht6rl3uGLtYXJXQCZv6H/F?=
 =?iso-8859-1?Q?5bOL92Tco4FaR3DsB5w57tJ5QknCV2x64mBIQDutE+u37Bd/BDHEuhzbgM?=
 =?iso-8859-1?Q?em3ISyZlslsyNUkrqieyPmmKIAg4GUb0NsMaKmIPhcfMfuV2cDxIkxixWP?=
 =?iso-8859-1?Q?YI48hD9kz4CPdM7vD085+F5eQxno/JoTZ8l0NZ9iaZs+G+GaG4r9Gt9Ncu?=
 =?iso-8859-1?Q?bcfPtCECCBj/AIZ/h5qyrBoyzsUSeBOgBFjLDSQYF6QmWc5lcboZyw4SxN?=
 =?iso-8859-1?Q?a9+6vBFXNHjjy6UVHIYnHZIgYKYtJUKUTgvzlY1Ims1dGuDgZdoVa3TISq?=
 =?iso-8859-1?Q?U5a2FkzRTZwtATIMeJc7ZyYUwRgz3ySaoovrOMQP6AyCrji1wUq/tAjxVm?=
 =?iso-8859-1?Q?33OTf/qpNPh/K/ps7eqpWnXpiaGwNEBVPJ+XB6wPjQh0ALTqf5e1srcurY?=
 =?iso-8859-1?Q?9hRVOo0d6b9kUkunJZTEI0SzJHzfA2sbLVti07uUwzDzLmWtEz/H5l3vj1?=
 =?iso-8859-1?Q?5ranS/0jDwGPZf1HG9dBew2yVMpJbvldHL73iGm2L0oN6xw/7JlBZ5gyyT?=
 =?iso-8859-1?Q?FfU9MEd4OWlyvQZEUC7/cYxcHc9vNAWq1ThMPRQhkYoSDF2tMRsyf/MSsu?=
 =?iso-8859-1?Q?118p2e0tjYOU8RCYAoe8znc9gxnwyEYBMFfeVRnrbcDVqJ2kUu71NHAlM1?=
 =?iso-8859-1?Q?6pZWk8pLP3QV6A0Q9sUwM6rX1+AY1Jn1+l?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fmx4pZ8+tjBDF2TMzEW06QXvfXqBtH1w8rqzpIdUlw/6qPt50mRbwq5GNY113iL3EzjnmxAxT4XGXMdthPn8GwMoJWJiV8hByMAVnNbKwUb3xRSFRRrqWRxS3J9vHbseLeHjLVTSelM5kmjN8GLhcvYwfzbKoZuzLeN4r99osfAUXRdHXWi/V7WSgTs4w2bcSOGMot6gmYOG0C7iLZ29UY86OVyKTeJXp0W2tBpGlEdROYwM8OMdG+SzcyVOPmnoVoLdWJ8YE0eisE3eyuRLFvI1xMXYTgl59CnZglaMKGP21gVV/WwNBDfsbAOpxp4QBtQVhvS7dUT4dxImo7KcNUcW3sK1M8mmPh5LWFoEDjcNUOQx2ivtBZhViUoLv2/GZQ8DAUEkOD4MuPKmxSySqi+wuBVMhskgUQ1Y74cqC0bRtV/Z+oD2tQruesuRToPUj4qpNQsikwneQX93mMBD6DjWCftJgO9myHoEJixwl3rty0bDtgIkvS69vY/xixs0Ms7Xm4+Ce9BDx5w+AmF3HzkpRUoq5XPAYgHhwIPEm8fozbxrtLHLYkQLN2zlca+mwDuYNxqph2vz6QWc0j+3gCgYrl24ryIfjIF1WwfbVlaW/VhoMvU8mUvs+I57BKnY8eHKY9a0oNOiAThki+0kcoKLXXpOLH+Hz39vbJ1gCaXRXWR2UH/VtAt4EPcsFFOAaCL6kwfTNmZM6gsjRwvDzDVT8pl0OBf2S3zDo798U8PlQUy7CQGzHBjvBSEt2E2zw3uuCuKWmqu0/YA0+i+Dz+ByLt8vW2QVR2cQWYIi//8Y4M3+4zSo1rQ5HLrtxhSXvRoA6dzfO00b+TiNsERoeexwyDoWU0I5kgiKu7b+B9L0SWP2Z8oW4EMIxPs7ZJiKzfEiAJ9wcWvGZswG+TX4D50CrC2WTQzx4zoDu6BdEQc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd8ddcf-efb0-4e1e-e860-08dacfeb5a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 20:18:16.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iv+CO9A71ESGsL0ZpcwtziZow86PZcJH8cjJaB/TOQjEJflgS/KzeDnDubSinffP6eY2GvUp/+pOK17VhbwynQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The workaround of pretending R1B non-data transfers are data transfers in
> order for the busy timeout to be respected by the host controller driver =
is
> removed. It wasn't useful in a long time.
>=20
> Initially the workaround ensured that R1B commands did not time out by
> setting the data timeout to be the command timeout in commit
> cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl").
> This was moved inside of an if clause with idata->buf_bytes being set in
> commit 4d6144de8ba2 ("mmc: core: check for zero length ioctl data").
> This patch intends to fix the issuing of R1B data command CMD24.
CMD24 response is R1?

> Its data timeout was being overwritten with 0 because cmd_timeout wasn't
> set at the point the workaround applied, but data_timeout was.
> But since the workaround was now inside of the idata->buf_bytes clause an=
d
> intended to fix R1B non-data transfers that do not have buf_bytes set we =
can
> also remove the workaround altogether.
I find the above explanation a bit confusing.
Maybe just explain in 1 or 2 sentences why this workaround is no longer nee=
ded?

Thanks,
Avri

>=20
> Fixes: cb87ea28ed9e ("mmc: core: Add mmc CMD+ACMD passthrough ioctl")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/block.c | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> db6d8a099910..20da7ed43e6d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -514,19 +514,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>                 if (idata->ic.data_timeout_ns)
>                         data.timeout_ns =3D idata->ic.data_timeout_ns;
>=20
> -               if ((cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B) {
> -                       /*
> -                        * Pretend this is a data transfer and rely on th=
e
> -                        * host driver to compute timeout.  When all host
> -                        * drivers support cmd.cmd_timeout for R1B, this
> -                        * can be changed to:
> -                        *
> -                        *     mrq.data =3D NULL;
> -                        *     cmd.cmd_timeout =3D idata->ic.cmd_timeout_=
ms;
> -                        */
> -                       data.timeout_ns =3D idata->ic.cmd_timeout_ms * 10=
00000;
> -               }
> -
>                 mrq.data =3D &data;
>         }
>=20
> --
> 2.37.3
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782


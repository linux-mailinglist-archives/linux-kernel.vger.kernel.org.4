Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB2621241
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiKHNYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiKHNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:24:22 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A226314D3C;
        Tue,  8 Nov 2022 05:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxlwtd8MmdZl9tdYN7HdEJ26gRmf4p5I6aRSIqhrtlqLAJquPXTZCi66S7wDiRoQZb6cFPr3qAdbJLzvFMKR6hYpfo/Vxgz/vd8LT1VRvPwXnGOS4fQBKg+a4xBSSLFx3xMuw6Vj//aVl8jciZdPlLnRIMfb9EQhDrake03wLc7xLREjOQ7ns+dcB2qNIbXUA4pb7wyP2H57p066l642A6RTDLvIvC6Qj207c/HLikXwhZJ/HUPG/KnN3MdYH/r0OEkYBDIiI0wYcph9A3A/bPFv5pxmK/rtL4cqcZEKP/xffy/m7puPKEMfhFA/RQE78LJps0/9bRmL2coArgUq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0AQPsjCbPtlMoyLANjCQmqY0lB+RfSDcfe5iyMmTkM=;
 b=MQCW6+Nse8naXXJDOf6M6xmt4YiiQh5G+Z0vhrzZGLty6WRiJ8LVsI9YSh04LTM2+GWMTL77b+Go1SuliwM1OwlcQk2R4RdZxNjFNItjsSFcZNivOoEqs0fBpLz5mL/CjgltzE0gIiWA5Z7IQ+D9+5a7+1o4pseyq2kkS3R7dAOHlcjWHNtbgEyjJPfuNTDazAgkvnAqGhXQXR1B6h+adY7ns+o2wxc4vPFmQPSmtTrIUykud0fmIjKSPTcHFrMikeaNAZJzn2uL1qeY95cP93Sm5hsHvGPiDJvl1iftDCdl4u8puHzKMA9qkX48CQH16+6CE+sDPfallMHdcJWhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0AQPsjCbPtlMoyLANjCQmqY0lB+RfSDcfe5iyMmTkM=;
 b=YP8ZLyzE16RUWeT2sMsrFyT+b2nSaoPWZHd/ry3SBZwOyMKQ3HyLT3UyTtLNK5VusJ8Oqf0MIk1t7a7c6UQmdEVVoTnravsYVd9PHQUwvmF+n3QaVVml5BUFv/l2JTzzWf9uTGVUhyr5/gIenopnuMOQdmplAQC3FylJhxobsNicxOu7pRsuY3vYxqQionedSHOxbYsITeLbiLjGfK3MsWsCBCxR98Aii3HMmXQf1hjfADlTYCt+PK5sLVAsIT6RZGVb0H0u0U/wglaOFjxva37HD4rXqmxnRG7N5CZ2/BsbhWUfC7A/6iafw+wZySqwE5a27fEL89E+Rw64mb0HeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 13:24:19 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 13:24:19 +0000
Date:   Tue, 8 Nov 2022 14:24:13 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     jonathanh@nvidia.com, linux@roeck-us.net, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] ina3221: correct the update_interval value
Message-ID: <Y2pYfauqMqQPEYrS@orome>
References: <20221108050029.24576-1-nmalwade@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvUjulLbm99zybaD"
Content-Disposition: inline
In-Reply-To: <20221108050029.24576-1-nmalwade@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: AM6P194CA0034.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::47) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: daab9921-ff82-4c78-2d0e-08dac18c8af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMg9RAUOcUhhOL8Nnajm/fb72zuVeLp1wBzJ9AywZl2w9Vp9pSc1qiDoDAE7HT8nmBhUKEnJPdQjITsLjqF4ZSxNofJE8h1wV/hLXrw4euSF7WucygALM7dTF/LcIJA2g/c3N6bg/bMvFf6BVnAn/+gdSbPmizEawwN7U+32fyBCOFJrcDF0ZVQGdMHVV/XCeHlpyGg2DU2ZEsA3mEvuSeb+++2aAqZjbT9vSpOzu37DZ3rsG7Ru2n3aDjPDGfAd69IGUoyvMbCm1iacXxVhIpv/mMV55yWkKX8DDO2l3vyXkbpLAjRJc9jCN7wgYvbbKaQ1zDRzSfycwKWjD+WnPJLu5wETDZYT2t26Qcf3rfYT38NhwaF0JuWW7Ikn1K5n/4ZPMAonbMBFbctvXPF4bqgXG4RoZx41etkySU0vRT26EUf/JDtS5aQ3Cbk+N6YaVamWq12w1gS2J3rcKCed02PMvGhTnBCiXndY3IJeKXaC7RlWhAKN9MMeLhsOfn6NKlFYCaaTriBhBck/5CH9oEGTTWKtH2Pj89YfcwyFY3pQoS4mRs38ZPxgeH+TJPah/ug3wetsCvhbJJnWXbnccdoujWn9EOryU3PCmFi5TnRi/wMe9JokInJDIg6Oeye6x7yVdKgq5fwHhAKscaENB3x8GZzaL2ZEi27tK8Fy5WHHouR4T4zUlYa2okACK7N6Myf9ueQrcN2inr6AhXqu1abuGE64N1k8svIoQkmDySStGWDcgxUeobVVDPmTFChOYRIhH3Y2HblrM2Cz6xMhgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(44144004)(6512007)(186003)(9686003)(6666004)(33964004)(2906002)(6486002)(478600001)(86362001)(38100700002)(15650500001)(33716001)(21480400003)(83380400001)(6506007)(316002)(66556008)(66476007)(8676002)(41300700001)(66946007)(4326008)(6636002)(5660300002)(8936002)(6862004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NhU0RlQ2dQZDVCa01IVktweG9MVVVZa2Fid0VtNTBGZW5GNGNXbHVsNEVC?=
 =?utf-8?B?azNlMGxLRGVqOHlIQkVaUURvWWVkWWtOWFkrOEh4aWlyeGRqZUtGUkErZkhz?=
 =?utf-8?B?YkVhaVAxS21CZXdEeEl2SHJEaWpOejhrTHZGWmpraHRZS3BvSHZYS01pWG0v?=
 =?utf-8?B?aGEyV0tUQVpBZ3ljN1pxcjgrdVZTRzdxQTE4cmgzYWpDZGVCVE9POUJ2dTVD?=
 =?utf-8?B?OUxTVXg2VTlPbzBnR1RMSTAxZEtzWEZyL2N0VHp2U1NuZEtFZ2hianBvZEZv?=
 =?utf-8?B?K3JvblREMFMxOHhsd0d6SEdkOG9lKzllemExc2FOOGcrWmRVN0t3T2pVSlhQ?=
 =?utf-8?B?cTQvaXoySU1XRk1RTGtGeFJTcDJIL2hXd1J0VW0yRUVjZ2NnajIxMFBjdng0?=
 =?utf-8?B?U0szcFlDUzdabUloWFdwOGVKbllFbVJlREgxamlPV3JhMk43SDFsWngxSFVV?=
 =?utf-8?B?VldhQWRDdTVFb3M2Y0FIbVJJVWEzUGNyQ1IxWkdibm10QUkxVGFKZUZHSkt6?=
 =?utf-8?B?aU5vVjU2eWY2eldsdWxsdlMwV0RsM0szSndaakRld0dnZHJoWjhVa0o5bzZn?=
 =?utf-8?B?Nnh1WFJGSkJia3FjTWpQMyt1MUhNQ1ZwWGFFWml5VVZacGxrVDVRc21IWk00?=
 =?utf-8?B?QnVFZlFZbGs0UlF2SW84TndOa2FQeDFtVWxsRnljZGFlR3o0Z0x3SmJWbTFj?=
 =?utf-8?B?ZmFwd2Y4S3A0ZHBYMy9UTlNBWTBIVGR5dkdwNkF6YVkrUVBhMkQrSnNFYlNo?=
 =?utf-8?B?c3c5ckFITUJzVmRQdDRWZk1VUXpBNU5reHd0bDhLaXhicDJHVW45TWNrMity?=
 =?utf-8?B?UmdmV3oycWNqRjc5c1orYjJuUlo1WlV5N0lGWDYxUWtDQnhJY0Y1K3FKZkZG?=
 =?utf-8?B?eUY2VTNBVUdQdUJ1OFozMDdsVjBXTVRtTXdQV2FPODd1dEFXSUJZVVhxR3Z2?=
 =?utf-8?B?eFJMVFdDTHhsMHQzNUxDYm9SZGJUSVpVYmVwR0tEcG0yYlRkMWp0bldNaFFL?=
 =?utf-8?B?OEluV1hieDZMZ1M3N2pKRTJWQWw5T2YrWGtBMmM4Qk1aaUY2djNlSDUxOVBw?=
 =?utf-8?B?TDQ3ZGR1VUpYTmhVdjZIRUVFa1pVZTRaL2ZTSWtwRlNZZ3ZCVFdqUmZZdXFh?=
 =?utf-8?B?VlMrMFdSMUgwVk1tb0RiRUJ5MGFCNUdGSDZNVmtTWU1UNE5NbFJpbEJtbUlL?=
 =?utf-8?B?S21DSGNRUUFhWThjUDY2VDNMdGFFYWNUbUNtZUJoV0QzUVNSUUpXNWI4b0s5?=
 =?utf-8?B?eklSVy9UTGR5b1dNbG8zMGdiTUwxei8zaENPOHRDR2doSUNSeVpTZlk4VXhh?=
 =?utf-8?B?Z2h2RVFxaU83cCtYeXVXSnpROWp5S2RmVzdUcGthM1lPQWZFTkE3T01xbDgw?=
 =?utf-8?B?NFZKL2xYQ01UVEVvcEQxbXJOVDQ3MTBXSGZSNnFBQ3RCTEpQa2tCVjl0bUw5?=
 =?utf-8?B?Tm9hajJJQk1abVVXSUxTcG5lSk1GVGYwa1h4K09KNlBETjYyQmwyM3NzdWZD?=
 =?utf-8?B?cDYrZXRkckZyL0lIdytPUVZDZlRycVhlSEZ5WVNyNVhtUE1uZ2RwV0MyZjgr?=
 =?utf-8?B?S0gxdHZ5WUxtbGJ5SVJvSlZiNjNTL0tWb1UrNHc0SVF4ZjJyb3R3OXd6eXcw?=
 =?utf-8?B?MmxTR0lJZmdtS2NlN2JWYU5hSDlyc0lITExVZVVEWHIxSVNqVkV3UDYyU2o4?=
 =?utf-8?B?ZlBBMS9FbkEzY1BwRmdNb082TmVpNWV0V3N6aGhMaEpkYU8vR2dtK0toOERI?=
 =?utf-8?B?RDl1L01Zb0FOcmpCVU9IMkhnZjh3M3BBVGhPL3FmdGgrUUprNE9yNFBDQkV4?=
 =?utf-8?B?NUNYUnhTYU1yKzEyck9oaGdWUXd5YS9TNS92TEwwM3lwa1dxOEUyalNwZUJD?=
 =?utf-8?B?L1Q1YXdRekZHbnpUVy8yRDM1bXAwMWlOdjY2aWNUN2NmZG9vTkt2YWkwaTRC?=
 =?utf-8?B?YnU1RWVFSUljOFVyMUprTHJ5bGFpT3dVYlNFcHlUeG8vTjZCVW01OFAyc0p3?=
 =?utf-8?B?ZDlzY3ZSKzVmczlZaHR5cm1yOXdCNVEzN3VBRkU3VU1KUlNwNnlxT1F6eG82?=
 =?utf-8?B?T1NEUm1pV2crQXJGbGdsem1CaDl2djVoVE1reGdXUkhLTWJwTVRBb1pnWTVp?=
 =?utf-8?B?dW1oWk1uSk16THpIeGNNc1ZueDVSVDNoU1pvbk9Ra2gyU3dUd3N6SVB0aXor?=
 =?utf-8?Q?5JGsZ4FeiIPn6AZoUlUIANTzfLEwLcSr4Rre1HU78aL3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daab9921-ff82-4c78-2d0e-08dac18c8af1
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:24:19.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTpEnU8HVU9dlbVCfTdP02cbrd4oOndcdFFAOPKfgr4N4t4NIjj0HbyGHuSeLiRpTGWHphhsxP6nLjGjlQP5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--XvUjulLbm99zybaD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 01:00:29PM +0800, Ninad Malwade wrote:
> As per the INA3221 datasheet the samples value should not be
> considered while calculating the update_interval value.
> Section 8.4.2.2 from datasheet says - "The conversion-time
> settings, along with the programmable-averaging mode, enable
> the INA3221 to optimize available timing requirements in a given
> application. For example, if a system requires data to be read
> every 2 ms with all three channels monitored, configure the INA3221
> with the conversion times for the shunt- and bus-voltage
> measurements set to 332 =CE=BCs"
>=20
> As per above only conversion time and number of channels are
> required to set the update_interval value. Correcting the same in
> the driver.
>=20
> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> ---
>  Documentation/hwmon/ina3221.rst | 3 +--
>  drivers/hwmon/ina3221.c         | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina322=
1.rst
> index 8c12c54d2c24..a4f107d1e489 100644
> --- a/Documentation/hwmon/ina3221.rst
> +++ b/Documentation/hwmon/ina3221.rst
> @@ -61,10 +61,9 @@ samples                 Number of samples using in the=
 averaging mode.
> =20
>  update_interval         Data conversion time in millisecond, following:
> =20
> -                          update_interval =3D C x S x (BC + SC)
> +                          update_interval =3D C x (BC + SC)
> =20
>                            * C:	number of enabled channels
> -                          * S:	number of samples
>                            * BC:	bus-voltage conversion time in milliseco=
nd
>                            * SC:	shunt-voltage conversion time in millise=
cond
> =20
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 2a57f4b60c29..e3aa57e3b039 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -183,11 +183,9 @@ static const int ina3221_avg_samples[] =3D {
>  static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int inter=
val)
>  {
>  	u32 channels =3D hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
> -	u32 samples_idx =3D INA3221_CONFIG_AVG(config);
> -	u32 samples =3D ina3221_avg_samples[samples_idx];
> =20
>  	/* Bisect the result to Bus and Shunt conversion times */
> -	return DIV_ROUND_CLOSEST(interval * 1000 / 2, channels * samples);
> +	return DIV_ROUND_CLOSEST(interval / 2, channels);

Why do you drop the * 1000 multiplication factor? That seems to be there
to account for the input "interval" being specified in ms whereas the
values in ina3221_conv_time[] are in us. Isn't this new code going to
give us values that are in the wrong unit?

Thierry

--XvUjulLbm99zybaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqWH0ACgkQ3SOs138+
s6HUKw//alVibJ7dYq1bR4ayOOvFopSDyf9l1BYMaO1pz97d7bmx8VpIrCZztpaE
dTgBSQgxtLxLXQRXTePdmLknOpgZ4dSDY8mygVRlLBCAUe2Ltv0GE0mgQFz3iMrD
YPrf5dfwlI/FXurCSF3PCOboqJHM7XKphNx6hL0RsXNAFgCSg/WynJVPNnEgbvsQ
87UvMC1jqSXSJBex6JA9IL0HTOzRoBETt/2a3xIUcfDrvcR9pUeoGousSzf6/kQR
cAucYJvFHIU/8XNCE0DelHaxEwuSW8980HYrIAd429z5mmAI8fu82HjeQ6Sbxhw8
KwyzMuQ5ZDGtTr034pUCw2eo70kxrEDIw0DjNxXbwu4DlWArq/r80yfv9OY1Xesz
MlV7pKCOLv7ueLgeJKukHHAgjJQnOIUK9xW33sYgueYyD1xb7n9T+W7BUiQwXtS6
/PflIj1XVStpFQ+M6HByNB8cjrfRa5TmzoMaWMzdJ4v1mi9oYWZhmQ56LAzkm003
qKjXMGxh/Nf3UyuBV+DpRjIEFpOMfGTnsP2PHBH3P8jQQx16DC3/dTX+NFYEwBb4
WpdWQA2LOTpRd5DLR+wXNcRsHZN/Ez672iZ8+7hdWBLwbtqMjwdr+Ho05AkmEjtC
jd5OupB1yEhV/Rb11cPcMoOefkAvUILJNFu5wL2TU0t32NQoRV8=
=CcCw
-----END PGP SIGNATURE-----

--XvUjulLbm99zybaD--

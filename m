Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD422621226
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiKHNRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiKHNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:17:12 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FDA218A;
        Tue,  8 Nov 2022 05:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Ts+b/B8cnYkBTrMoophhaNUmX7w5s597hDgN2GnpFVrZ0ScBh2YV+mdOEWRf6wUpoCaqC8IBYQO8Z8/qg7I8m590a9czELBOcNp/ka4vJDU/mD2LuhoHsAG+n9hZmwlIqKFyvVHsJcYeCAK4rrCK8WflgPX+xuV2jyWvAP4hZ+HeMdc88Ax6ejT/G2F4Fa8YuDC1/FQkXrcOp4lQamhYeC2/LBz+JyDUM1jvNwIYdMHO2royoWlMoB5m1cMRPCCHNpJHzD/QxCAcS+Q9L2UD2B6YF0IITxIhwEVl2iRolfAUIF+KOL8+ILA/a1ogyIBzozYxLl8J7cjOO3edF4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfHBwxqZoHRiijMHwCIFp13Gj29Ya8PYhiiv9VC7llQ=;
 b=H8fLGXvBsYiC6jOmTe3vpJ7h18a1nvQ6gciU/B75mYpNCuy31TjbQUq5b2iJownlJ4/PE3jY3qBimobZig/skz5ZiIxHz/3FRPQ7mPYbEm/9j17sWT1u3dcrkcsxxZ+DS2RJyh0+YD/jLK9GH2VVBNfOzwphrLsWTp3/TShG93M+cSmeG31kOM2ExRdDVKEoo4xf+0+rT6VBd8OXk7FDNMoiVM0pZ21b8yMbaV9uJ5+BKHss/vU1TONKP03O7++bZ9FnVCSGteIH/Oy6eQ9ZwIEoi5a0stbjlOvdBAnNTQEJVK/Ko8YoibbPMIZMVfFvtQTFHMQi1ZFZdeZ0CmCoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfHBwxqZoHRiijMHwCIFp13Gj29Ya8PYhiiv9VC7llQ=;
 b=d3/0qmZXqYf1xvd1J5x54wYE+hIWK61kpVRKgyTLCVgezvOHGEjt0h6+ayv3jhGlAHuB5TySlwU/a5AIZgOGPMhEe/bPPtuShjoXbVYgTxvmUQ4LRby+XlGAkh1Z3rpE+0SPx84f0A692Zq4WPvNldY8hOCa7bBaz911QwMQQJuQBPyBT1x+aIrO38eaA02t1zecBHH4JpaykXOuNxaLbY9f4eCIqAy2a8SZ8v+XHPT0Ax6rOLyyPJ4ZEUZXapt7biaAEuMeYucFJ0K2UZIgCDOdyD6sc7Y36j4cfqbj5zexgOjpF6FufXR741GLtrPJh+vGZd371Xrwj7oUB3JCNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) by
 SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 13:17:10 +0000
Received: from DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255]) by DM8PR12MB5413.namprd12.prod.outlook.com
 ([fe80::774:7ac5:2a7e:4255%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 13:17:10 +0000
Date:   Tue, 8 Nov 2022 14:17:03 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     jonathanh@nvidia.com, linux@roeck-us.net, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] ina3221: add support for summation channel control
Message-ID: <Y2pWzx13km4qJfHe@orome>
References: <20221108045243.24143-1-nmalwade@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kiqTF7bkm4/b9cRJ"
Content-Disposition: inline
In-Reply-To: <20221108045243.24143-1-nmalwade@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.2.7 (2022-08-07)
X-ClientProxiedBy: AS9PR06CA0771.eurprd06.prod.outlook.com
 (2603:10a6:20b:484::26) To DM8PR12MB5413.namprd12.prod.outlook.com
 (2603:10b6:8:3b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 23efc104-e51a-4caa-3769-08dac18b8ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uzR3sWdBWDJ+Iv2y3s5G6SMV10+DCQ065T1xxFUoRKMk+X2fksIN21+Nu7O8WeJ1I6iPbTdlimWYlUxaYVOEArreLHUX5ob5PdI1R8gYM3qRs3bB7ymKFiZrQxoR39ykxuy4ueLQUIE3aNOKFC30MEAqB+Z7IaB4KZ2JaSemxzMrnvjklxD6IvTkHZxFWGTi95LM8h2RLoR7H/5fJtICJE3CP5pQGbNEqUX/UCq1u89F6lHTR7uwwI3IlOZpXTriy/hcAvyzgplGRZvgebgoWDranG9TyFVMmf1+EMIhNgT/e+SYbAPKSlOEqSwhwI9tQnP+9I7rLtYaVuz2h3dd8yZ+ZSUWnvOxOJbLd+775AtI75zCX1MqBFta6m3StBw9BBDIFvV12ND33qqob0aq75eMYIjSzc4wjd+EZAyaEW1FgOzqZzGnEvgm1sV1Ij/0syrqfHoWjozzN/Mya492a8YXQpcaJcFkitS+BQremKukvjRDC0HNuPkRa2NwttCw+3LRmvpSGcFyLX7GF3gxDYJ2+3DuwTPDvYur9EsoqrvRezxLtwADuunFudk+NLFowfBe5dWur2+bTH1duNBiFxD1Wbq8FvoM76Gp/pv/4Axoq15gncgTpnTQvVyiOygsm69yeQiuBHulNdPnwPUkuJ/c7su+jN033dvdW4gUPXMu3E/iQCBz+MjZem2vbD6IFR0dGlAvFygXpLhzYrFQIz7HPF2MOkNil6A9O1B2uCJawqZ2ocLegSTiMWUs3oGp2AL7q4JwYnxX491wIasmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(86362001)(9686003)(2906002)(6512007)(186003)(83380400001)(44144004)(6666004)(6506007)(21480400003)(66476007)(8676002)(66946007)(66556008)(38100700002)(33716001)(478600001)(316002)(8936002)(4326008)(6862004)(6486002)(5660300002)(6636002)(41300700001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?unnw5bs6Nu79kxcwaXazA1YNLbMiUIc6jLRNP2r/DGg0HxXiCR5x32gHpQXy?=
 =?us-ascii?Q?sNZOJfK9B65MYD3zNjkxUbjKSeY4XAldnSBMBqCmr9/z4T/KWtOsIdi2Bsde?=
 =?us-ascii?Q?R17bbP7EIWTPzCc9C/xJGKQCF+Jmje77eAc2cSBx5/z1wsUJbc2/uj/GZ1KC?=
 =?us-ascii?Q?DkdAlUuqCv8VUkjHF0LZyRrhHB4S36cc8FaPaYwIhe3sV1iETPqjWQEKQoNX?=
 =?us-ascii?Q?xGprzkDX2QEo3BPUBIEp9Z2b5i5ASd731FFtzE6CD2qvDjOAb1EhSJs83m7v?=
 =?us-ascii?Q?CjMi0NaIra9qv/2g5vcraRf99ssfSwNkH+L59tYg4Ct/E1Ro4vzTT9p60dDC?=
 =?us-ascii?Q?2JRUtcpeU2o/MW8TomAO5ko4tbQKz7L/baE0MSIhyiQ+bDtys+oa7s0HUflC?=
 =?us-ascii?Q?/vT/kxWsVskqubY9WBBbzlcIiCbOViKHlJOmPxwRpa4NF1Gxnbn9eE0zMdIt?=
 =?us-ascii?Q?xHxZJjcffYrALQjdHkTm7DA0PUvuq+xHBp4CY29END1U4S6nBq/IGe63aylo?=
 =?us-ascii?Q?WnV2M0+U3P0+EeMO59iJ+y0krb6p1KtKWKJyXKGg31cRoLh2aKj8M6YBcHma?=
 =?us-ascii?Q?UTXCaL9uvBYSaAX9Yiqzvfm3Ae35i+KL1jhzhgjoR8307ux616ukmVk5MIcf?=
 =?us-ascii?Q?bWnHfD7je4RXmJU/fP36d4G+MJsQixUbHeTv2Nu0kgMB99emRyb7h7d0sADA?=
 =?us-ascii?Q?ugoJ3XZEqQjwt0J5ZSnkCoD6dlMqBRzWIht18Cm0fyutHSmAG9Lx4LVdHsZ9?=
 =?us-ascii?Q?WuM5OHk39HTdO9Vw3KulL7J1oS6bimatAMcsb51xYS64RI6iacUMk6PewggQ?=
 =?us-ascii?Q?1dd4xGnwV1ptD6Yu48E2cSOxO+hcdFtys5FCsHMdOV47PoeoAJKwx11sqZkd?=
 =?us-ascii?Q?+M02FcKFSGzUX5MnZVNGFHo0/0KUZ7dzZ1y3B5Ns2sGyZTnPerM/PiLFVFni?=
 =?us-ascii?Q?bmfxXRdlDYslynqTR+S2o8rsyQk9KBYNr47W9sctmyyQFwgX9h8vbIlepmo1?=
 =?us-ascii?Q?ydRqsSPpeJlskrZ73rA+jnxGA0POFlfTjzQVpnzJIUWuPJiFVYGkuB7g9x0+?=
 =?us-ascii?Q?1+a4LHwVFBHp9t5EAQHFFjOCmnxhpX+CdUIKT6uKE7yPoCxY1cQsd43Rtyzd?=
 =?us-ascii?Q?Q+ufx7dqbCh9Mr4raX7409TC2RNr/Q0YROjDSdklP3VfM9hpyjA2GcMGp1Zb?=
 =?us-ascii?Q?wPyxkJCPXzhgPPFAzf0mtSfHxS+MZFSlqyz50DUKPMYO+6lCKP0WEgyHDnJV?=
 =?us-ascii?Q?bzMFoAcxknm+gFRbDetFAam1YxleSePgSv696UCEo0RrHHNrX55GY+d4uRax?=
 =?us-ascii?Q?qs02MKyD42O+okp6qWVVg4QPC6yGjZuV8pzS7pZRVt6HJ4KeK5UII9cf91PI?=
 =?us-ascii?Q?nM7oDmRexa4q2hN65X3vT7kX4qCD+xoOLbzcRQU3Wmcr1hOCo1ugHKYbJdKa?=
 =?us-ascii?Q?VsGh/eRhzjQbx55ikRER509nqj0ufp4gl24/v5nsunfpmkEipvCzDYHfsWog?=
 =?us-ascii?Q?1xfyF2oQdO98cJ8oU16NAn+Kj+4cE/rl68eGsMaPSORR5gKeELtZtSn/F8ir?=
 =?us-ascii?Q?d+F9rHLxZclt0My6Kd8n+MOQCyh193f9fiNLeGirqT7Eboytje9rxslnLIG0?=
 =?us-ascii?Q?iwRAayDDaiKuFihLrk4Y86OHsnPOIA3256/2+QBYX2uu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23efc104-e51a-4caa-3769-08dac18b8ad6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:17:10.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMUhfVLTeaVPAZXwF63f7CivJfNLEuZGV4lf5QVKQKQ0lYGbGB5h3aXfuehhHGfya9B1R9Oms5FWO3Ns8hkRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--kiqTF7bkm4/b9cRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 12:52:43PM +0800, Ninad Malwade wrote:
> Add support to initialize summation channel control via kernel device
> tree property "summation-bypass". The channel which has this property
> is excluded from channel summation.
>=20
> Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
> ---
>  .../devicetree/bindings/hwmon/ina3221.txt          |  2 ++
>  drivers/hwmon/ina3221.c                            | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Docume=
ntation/devicetree/bindings/hwmon/ina3221.txt
> index fa63b6171407..c6e8e6aafcce 100644
> --- a/Documentation/devicetree/bindings/hwmon/ina3221.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
> @@ -29,6 +29,7 @@ Texas Instruments INA3221 Device Tree Bindings
>    Optional properties:
>    - label: Name of the input source
>    - shunt-resistor-micro-ohms: Shunt resistor value in micro-Ohm
> +  - summation-bypass: exclude from channel summation.
> =20
>  Example:
> =20
> @@ -41,6 +42,7 @@ ina3221@40 {
>  	input@0 {
>  		reg =3D <0x0>;
>  		status =3D "disabled";
> +		summation-bypass;
>  	};
>  	input@1 {
>  		reg =3D <0x1>;
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 2a57f4b60c29..ba0d6da06947 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -104,6 +104,7 @@ struct ina3221_input {
>  	const char *label;
>  	int shunt_resistor;
>  	bool disconnected;
> +	bool summation_bypass;
>  };
> =20
>  /**
> @@ -125,6 +126,7 @@ struct ina3221_data {
>  	struct mutex lock;
>  	u32 reg_config;
>  	int summation_shunt_resistor;
> +	u32 summation_channel_control;
> =20
>  	bool single_shot;
>  };
> @@ -154,7 +156,8 @@ static inline int ina3221_summation_shunt_resistor(st=
ruct ina3221_data *ina)
>  	int i, shunt_resistor =3D 0;
> =20
>  	for (i =3D 0; i < INA3221_NUM_CHANNELS; i++) {
> -		if (input[i].disconnected || !input[i].shunt_resistor)
> +		if (input[i].disconnected || !input[i].shunt_resistor ||
> +		    input[i].summation_bypass)
>  			continue;
>  		if (!shunt_resistor) {
>  			/* Found the reference shunt resistor value */
> @@ -786,6 +789,9 @@ static int ina3221_probe_child_from_dt(struct device =
*dev,
>  	/* Save the connected input label if available */
>  	of_property_read_string(child, "label", &input->label);
> =20
> +	/* summation channel control */
> +	input->summation_bypass =3D of_property_read_bool(child, "summation-byp=
ass");
> +
>  	/* Overwrite default shunt resistor value optionally */
>  	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val)) {
>  		if (val < 1 || val > INT_MAX) {
> @@ -873,6 +879,10 @@ static int ina3221_probe(struct i2c_client *client)
> =20
>  	/* Initialize summation_shunt_resistor for summation channel control */
>  	ina->summation_shunt_resistor =3D ina3221_summation_shunt_resistor(ina);
> +	for (i =3D 0; i < INA3221_NUM_CHANNELS; i++) {
> +		if (!ina->inputs[i].summation_bypass)
> +			ina->summation_channel_control |=3D (BIT(14 - i));

No need for the outer parentheses. Otherwise looks good, so with those
parentheses dropped, this is:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--kiqTF7bkm4/b9cRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNqVs8ACgkQ3SOs138+
s6F4+g//ZemXwIwPbxIesp3zJzQOOyx12y3JHFNa5sCNri/y9XcMdl3U2jDJmZ1J
aJrjVRmEWWSE9fJpvIU2DKQLWTWSyV3XqfDCbBAqaZ5+5qj1q/gqmzFoowgVkVyH
qg/6QnJzxFvqq0XFAbwJURkD8SktVoRWkPW3sCpbLNDdpQL4/STHq8FeamGiNw0B
vscXStNQfkX9Ukb4pZaLr240qpOjxRE720j5UYsXt7t8OkZVbcVfwMFWCOATGFhk
CyU/S30wNkKQmmlLdAR7CTustFKRXr45S4is41aW/fNjvn6YiR6b4QnPc1v9yX2L
xJqm0zzaJC0JwocdRRxIgtQxhCjfacdWDAUBuzzveCuMTflNRqWSZWKjDoHYWiUY
h//AgrlRXm+tcDTxkVun5b34K5AaQwJXLz5SJwCyibQuijW81J4gj+dC+536sZcK
z6VW9KgaARVCcdjsZcCuaddyMBethc1VbBzKOm/k2BzWwshl7Sksbii8T2j08jDi
vSLtIFhXH3Iwd7E8i2HkewsmD+9Dt2sB9SiMCL8Q+uGyIhIBYjZsPCWDmvdyR0te
HooIOOR+ysh5W6kj0DOM4TPBpgHGP/gSDjPJRrJt6DATDjZo5wrzegddMetvKVr4
jTJWJuqdedeqMwKHARkgPTIcSMBiUqSeeWM85041FFbKQvl+G5w=
=baxH
-----END PGP SIGNATURE-----

--kiqTF7bkm4/b9cRJ--

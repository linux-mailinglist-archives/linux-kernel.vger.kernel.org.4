Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C05E672E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIVPdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIVPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:33:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404DFB315;
        Thu, 22 Sep 2022 08:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V18DscCrT/JatryQv2q9kPTmnSFd+v9yt7uf0qpu9jQi1svHQi4RbU4UKd1ybb7OkuShahBhYZWPQcHGMEB/ojJHu9QHCIGnq3/qRyaf/J6KdiXr3UWydaGqDsZOvuNTahF6ni+SQ9hdAps5SRBPxLMtZkkTO0eL/5AIQfpGGlupukRiHpKvTrgLKSHWVyS8V89AA4DhFtwyy2D9O9i1sa8P5aLUz91k3uDYbyfyWJH1eBt23WC2q/SrT3vr0qI2xx1jNOx7GCAyX7baudNy1sm8GnY2ymt96Hwzb8DP5tRlgZTbTobaUerKHY86rqZDP7FErQKk6p3+9dvmvPx5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQWI6ybBb8yeyhvrk0ULTv1hPY/Kf4PeYLdyZ0IGieQ=;
 b=hxQmyNJL+qytbkdn7pXPkOaRD/ppDfdRDcXXbau0y1FIOFvc2kj+5TwFawnN7mqxp2sV/uIZpnr/qWlkeYskS1KMki5HClzWVJHzFSum6zeEJZYOYvgl6GHi1onQb7Jvc2nO3iFqkEYeM7LfKk2E8r3ZlV67tlZjSlnnbXgE7WBo7Kb4lvHFDoos7+5TYemhwWPNOKQfrMVkyTP9KbTVOzGItr417b6LVL8fOLSEvDo4/Fw6pifxo/nBejm9KdgCuFSXnwgXaRjWY8+fGD2s6URPIKVPR3hRCQvPok3MLhFrbU9gb0po1NthBcG68jg7JX2W2HpKKaZv/grWDtxi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQWI6ybBb8yeyhvrk0ULTv1hPY/Kf4PeYLdyZ0IGieQ=;
 b=JAhUmvfG+oFyQXpEXSbKRW+sl4vrQRLOpbF4Li17DYrySadgtYu7bmVO+RSJUNtRKJ2Kg5YdvvwESNxaobAOof7Yoxtedaxo9sJWzb4YAiLatjtzD5eRx8h0yElg4XiULu9lvah38MIpZoXst1XH6G1LwST5bmjVBhcCgH07Lm8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 15:33:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 15:33:04 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] platform/x86/amd: pmc: Fix build without debugfs
Thread-Topic: [PATCH] platform/x86/amd: pmc: Fix build without debugfs
Thread-Index: AQHYzphfEfwKPjfUrESXp/fkH4dzPa3rk8dw
Date:   Thu, 22 Sep 2022 15:33:04 +0000
Message-ID: <MN0PR12MB610185262BDDE5DF99EC242AE24E9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220922153100.324922-1-nathan@kernel.org>
In-Reply-To: <20220922153100.324922-1-nathan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-22T15:32:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a019b00b-3c12-437d-8818-2b39daff1f60;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-22T15:33:03Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e0af4c94-5fdd-4c96-a382-a7c6698c3d7c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY8PR12MB7220:EE_
x-ms-office365-filtering-correlation-id: ac698abf-36fb-4d93-4e00-08da9cafbe1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAUhrwHYh3U3Uasp1azNF3qsNmDp/qFn3AeqFxayMeNIZLovsIQrGTF8dDaB6WDUaX2Er68J8Xek0p7UKmd+9B1LpC4y1oS2X01Sh46ZXAmDKwUlh1WhvRsON8cWLtOSq9k75cC2idPWpjC1mE4yWhOm/PZ/+uT+SdREOtRak2669Ai2E8Xri9/JrZhlR5YALc60fOAPDnTCyV2L1xph9FfT9NALr8FUo1mwPIsoND+ATcLDMsE08Z2T9xxKZ5Ro+e8jHplGicmD73LyFZNZG5rd0JPvIfFpCW/ufMVzAaL2Tro9Ign/JKZyUqRqi0O+7KL8DS9ACeYmSCyPjut3yYReZotT/lKLs9koaHuqIB82nkK2cpvg7uVvkedonNty9bDW4VnYbu2zXSfo9ghBTg2zfdtbCCtMU9Z3vyg731qUz1xyqlr46zRnEXhV1xV7Mk1BbJ3KYRjDqhglzWcxdY/NmYyrTbW3cdiwoC9B6o/dC8vWrp767wEzY0Ude6xt9m+QuRj9OFdMehXekUAejJl7Uf4uquD6PvnEixoYElu6bUm8GL25a3ekMr+zMKluoXUBqgbXIYhqL2MN5j2ug/fyqgdsHM55h63kOUNJqlpLHsafjzH0s3zA/dFDolPqrTfNuRUaq2OINPXzjPi7SiStZy8ce8698iNHMWxh+Mochia3iO7NRKLofdvCX0GfjZNRtgTj3PMcPRfCcGX0mfmUrCh6tjpXVW4IvopsOxx38/UfkOZ8o1NAcMNxeSY4GtBQySqSZRlHypXgkpEwcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(26005)(7696005)(6506007)(9686003)(53546011)(8676002)(38070700005)(2906002)(5660300002)(66946007)(71200400001)(38100700002)(478600001)(122000001)(66476007)(33656002)(55016003)(186003)(41300700001)(86362001)(83380400001)(66446008)(66556008)(64756008)(4326008)(76116006)(54906003)(52536014)(8936002)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K2mdNMJ90SLx+dIUtLouRPgroq72PIP6a895OAhRpQedsbb+JxvwKB/EjZj+?=
 =?us-ascii?Q?HvlugbfNm+bJGhe+yzmVCQS7EGvmJ7+7zpJRedWKOkL9l4M/EySOgVzqIkfQ?=
 =?us-ascii?Q?4jx9ZGqAWussvwq5Y9Dq4ia+uLTZPg0rkBORKtKK2MQvk5iy0TpBGgPepJHZ?=
 =?us-ascii?Q?3Ma8p1OK8nCIOZ39zbeoB5Ds8iHDNAK3+DBQS85iZcb97HctHlXCXP+9I0wr?=
 =?us-ascii?Q?VD3BAa8e2Rx56W8GmycE1KTCJa7B86UltucGhgJVTSyEI+KLNquPCiJOBFJo?=
 =?us-ascii?Q?Vz30v6itWKksbK+twruGifFXlSUHSnSUsr4Uua0q6FFpYsoJqtxpKBlGOsyC?=
 =?us-ascii?Q?ytHuKHglGFc6OfaZi+e2LQcW5Ksde+wTDWAf2a8OCL7COxml2k/+9DEelfvA?=
 =?us-ascii?Q?VgYCEZBjfaPKnbKdCGN2Y0BVgdlb6IliLCOPxB1WET8zCifTF31RKiamTkui?=
 =?us-ascii?Q?LxncTuthbWYsD646xNj2/2B2BWf5Wu9tl3tG3pbV+rSG+O2T/EoFpr/0KBYj?=
 =?us-ascii?Q?AxBlB+Uxlayc1C5BmClyiHvE8FZ97cEHqovbkTo+HQH6hK5HoLr5o7isghy+?=
 =?us-ascii?Q?i8vzSPZlxrQRilRc6Zif7lRCQfB+2GgbB2gEpb8b0VWVxF1wdD6JaaJ/ogQ1?=
 =?us-ascii?Q?Ajb18RpW4x3n2A5XGOypn+bHKyPA3J2SHEepzQAG66QgpDe//a3GB57W2w3Q?=
 =?us-ascii?Q?AtbvfC52SwlheMUSokEvvMX2JBobot2eBUV5oJwiuqy3gh4ETMP/xF6dlL14?=
 =?us-ascii?Q?2hJEYqOYRHjRl5BC9aNFHYMrlVQ/5tvsrW9NjIMdUIP3o6dMaUvlwsbBTnDF?=
 =?us-ascii?Q?T7DnVZCv7FdlGeofvwScAWljh21bJf3BNTMX4nV9bFQrS9DsQL0wGX875mC0?=
 =?us-ascii?Q?6zkNZeQAVhLJr2ikoIU2rWJ/T3Mzaw7AeY5fhfj06uxriOz/pdGAsQWGc2YE?=
 =?us-ascii?Q?5MPzMO8MeHOFYvuqJ99EMRnyL8IgxYPPTnsQ/6Tb+xtImZTw2LX3uROHf+2q?=
 =?us-ascii?Q?GMnKJble0Z/5U/I77PnQENAs+n2croTRV5PGWskzi4TXfHGbyMXkvr7LwE0b?=
 =?us-ascii?Q?c6+Zi6ZHdN3+zYMrrjuJfw3Yl8Ne1Vr6FNErXyBy7c4eJNpYHbrfpxA2aJ1g?=
 =?us-ascii?Q?8C+njmJtPmAp0pG2QQ5/EFSdPuX0C3e1xtq9FwSRkySXphaQ9U8TXHZ2lcpo?=
 =?us-ascii?Q?9Nl+VDKVAlxiBVaQ3sgbhRGJpjmDrRgyX7DNrVvQ6qTZoaoPLOvXLKm4nRvM?=
 =?us-ascii?Q?Am7aqtxLYwT6jiLj5iRvvhqb7wDw7eIuAmS5SQguj8QNCebJqXf3FQ/ttzCx?=
 =?us-ascii?Q?lk48dZizkGlGV6LvLsaJY+vyBff0/F39FA9XhW5wvczm+ibBp+l08klOWGD2?=
 =?us-ascii?Q?HLneQoqw91yRZeqpgBYOao4sy8UQnxbvK6ozSRBUoWtmuaBV9skxHA0siWYm?=
 =?us-ascii?Q?jU8lXbkBJI1HiNBRthx17PkEj06SGvLNfdaXyfFnDC/7z6KZ3z6RY3U53RhK?=
 =?us-ascii?Q?a6I96dTaZT+1D8WNDyu50TSLXG9PL8FOhY9QSsBgbpFJJzjTEqO/zsoAgf0X?=
 =?us-ascii?Q?bvXJk7ApVaghl3VloIc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac698abf-36fb-4d93-4e00-08da9cafbe1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 15:33:04.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHjWqEM3wLmww0thQxZWwtfPTFRMT5++jpXNfF9d531PId8qMNNLqD7W1R806IwrCPaQ95ByNn3Ikjl2oApYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Thursday, September 22, 2022 10:31
> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Hans de Goede <hdegoede@redhat.com>;
> Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;
> patches@lists.linux.dev; Nathan Chancellor <nathan@kernel.org>
> Subject: [PATCH] platform/x86/amd: pmc: Fix build without debugfs
>=20
> Without CONFIG_DEBUG_FS, the following build error occurs:
>=20
>   drivers/platform/x86/amd/pmc.c:984:17: error: use of undeclared identif=
ier
> 'pmc_groups'; did you mean 'set_groups'?
>                   .dev_groups =3D pmc_groups,
>                                 ^~~~~~~~~~
>                                 set_groups
>   ./include/linux/cred.h:65:13: note: 'set_groups' declared here
>   extern void set_groups(struct cred *, struct group_info *);
>               ^
>   drivers/platform/x86/amd/pmc.c:984:17: error: incompatible pointer type=
s
> initializing 'const struct attribute_group **' with an expression of type=
 'void
> (struct cred *, struct group_info *)' [-Werror,-Wincompatible-pointer-typ=
es]
>                   .dev_groups =3D pmc_groups,
>                                 ^~~~~~~~~~
>   2 errors generated.
>=20
> pmc_groups was only defined inside a CONFIG_DEBUG_FS block but
> commit 7f1ea75d499a ("platform/x86/amd: pmc: Add sysfs files for SMU")
> intended for these sysfs files to be available outside of debugfs.
> Shuffle the necessary functions out of the CONFIG_DEBUG_FS block so that
> the file always builds.
>=20
> Fixes: 7f1ea75d499a ("platform/x86/amd: pmc: Add sysfs files for SMU")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks a lot for the fix!

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/platform/x86/amd/pmc.c | 116 ++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmc.c
> b/drivers/platform/x86/amd/pmc.c
> index 0616ef8ce64c..e47e54b095af 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -371,6 +371,64 @@ static void amd_pmc_validate_deepest(struct
> amd_pmc_dev *pdev)
>  }
>  #endif
>=20
> +static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> +{
> +	int rc;
> +	u32 val;
> +
> +	rc =3D amd_pmc_send_cmd(dev, 0, &val,
> SMU_MSG_GETSMUVERSION, 1);
> +	if (rc)
> +		return rc;
> +
> +	dev->smu_program =3D (val >> 24) & GENMASK(7, 0);
> +	dev->major =3D (val >> 16) & GENMASK(7, 0);
> +	dev->minor =3D (val >> 8) & GENMASK(7, 0);
> +	dev->rev =3D (val >> 0) & GENMASK(7, 0);
> +
> +	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
> +		dev->smu_program, dev->major, dev->minor, dev->rev);
> +
> +	return 0;
> +}
> +
> +static ssize_t smu_fw_version_show(struct device *d, struct
> device_attribute *attr,
> +				   char *buf)
> +{
> +	struct amd_pmc_dev *dev =3D dev_get_drvdata(d);
> +
> +	if (!dev->major) {
> +		int rc =3D amd_pmc_get_smu_version(dev);
> +
> +		if (rc)
> +			return rc;
> +	}
> +	return sysfs_emit(buf, "%u.%u.%u\n", dev->major, dev->minor,
> dev->rev);
> +}
> +
> +static ssize_t smu_program_show(struct device *d, struct device_attribut=
e
> *attr,
> +				   char *buf)
> +{
> +	struct amd_pmc_dev *dev =3D dev_get_drvdata(d);
> +
> +	if (!dev->major) {
> +		int rc =3D amd_pmc_get_smu_version(dev);
> +
> +		if (rc)
> +			return rc;
> +	}
> +	return sysfs_emit(buf, "%u\n", dev->smu_program);
> +}
> +
> +static DEVICE_ATTR_RO(smu_fw_version);
> +static DEVICE_ATTR_RO(smu_program);
> +
> +static struct attribute *pmc_attrs[] =3D {
> +	&dev_attr_smu_fw_version.attr,
> +	&dev_attr_smu_program.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(pmc);
> +
>  #ifdef CONFIG_DEBUG_FS
>  static int smu_fw_info_show(struct seq_file *s, void *unused)
>  {
> @@ -437,64 +495,6 @@ static int s0ix_stats_show(struct seq_file *s, void
> *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
>=20
> -static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
> -{
> -	int rc;
> -	u32 val;
> -
> -	rc =3D amd_pmc_send_cmd(dev, 0, &val,
> SMU_MSG_GETSMUVERSION, 1);
> -	if (rc)
> -		return rc;
> -
> -	dev->smu_program =3D (val >> 24) & GENMASK(7, 0);
> -	dev->major =3D (val >> 16) & GENMASK(7, 0);
> -	dev->minor =3D (val >> 8) & GENMASK(7, 0);
> -	dev->rev =3D (val >> 0) & GENMASK(7, 0);
> -
> -	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
> -		dev->smu_program, dev->major, dev->minor, dev->rev);
> -
> -	return 0;
> -}
> -
> -static ssize_t smu_fw_version_show(struct device *d, struct
> device_attribute *attr,
> -				   char *buf)
> -{
> -	struct amd_pmc_dev *dev =3D dev_get_drvdata(d);
> -
> -	if (!dev->major) {
> -		int rc =3D amd_pmc_get_smu_version(dev);
> -
> -		if (rc)
> -			return rc;
> -	}
> -	return sysfs_emit(buf, "%u.%u.%u\n", dev->major, dev->minor,
> dev->rev);
> -}
> -
> -static ssize_t smu_program_show(struct device *d, struct device_attribut=
e
> *attr,
> -				   char *buf)
> -{
> -	struct amd_pmc_dev *dev =3D dev_get_drvdata(d);
> -
> -	if (!dev->major) {
> -		int rc =3D amd_pmc_get_smu_version(dev);
> -
> -		if (rc)
> -			return rc;
> -	}
> -	return sysfs_emit(buf, "%u\n", dev->smu_program);
> -}
> -
> -static DEVICE_ATTR_RO(smu_fw_version);
> -static DEVICE_ATTR_RO(smu_program);
> -
> -static struct attribute *pmc_attrs[] =3D {
> -	&dev_attr_smu_fw_version.attr,
> -	&dev_attr_smu_program.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(pmc);
> -
>  static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
>  {
>  	struct amd_pmc_dev *dev =3D s->private;
>=20
> base-commit: 401199ffa9b69baf3fd1f9ad082aa65c10910585
> --
> 2.37.3

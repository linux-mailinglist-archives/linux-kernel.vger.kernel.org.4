Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A46FE7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjEJXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjEJXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:02:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BA65AA;
        Wed, 10 May 2023 16:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEq0MnSOoXNFsSwXVM+KDAwMlF27YILvRttubHbYAdSyp1ldx5p+GyZXN9PiKPqbQ62XdQMMazb/ydLpNp5LtPJJTl0bc/StoISEu/V9zh5Mf9Ld0GaN4Ih7LQTzakwWllkBlDdqyHdjzNG72v8BUuc5imHedfcblLGyLGdjiKwqr99UjoQgWLXzq9WC6JVTsuhw6N4SYsb95R3wGob+EcO0GBymqcJDNTpe1E6gL6fR2rVg3Nbqu5wn/QMcAKaPdk6wUsG/lNP9/TH9e7djWsOA6iOBXO24qZYhsz2HcJ5f5ZnH/Q2IpL0ulyWdjDG6g0gnUg3b5uVM9ag2KiLedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mff1qYk2vHwANb+z5MAyOys4fpzBakWsJRJHpF57UwU=;
 b=O/RhPNhmdpQQsCRaSCkDAZ6RyM23tCp5ZXYnkgLJdQrxJwtCNRlaDXkDdwEI1RFYyI7EL7ZcpPMn8QsRsQpqDdr//htUOoJsnbFE5lbeWSu/FhEZoAOwBdUbhIEIXHG60PlM30Tk/37qb64GRXtJEGISI3d2v66YbN/q26kUWJAEEBRIbdADoxlQgUKlTsSBd4vcvSn4xuBKTHo7f9qEh1DgII3svL045LHEQfnBqRWuNHsiC1Z9XoamEX0z82NPW8mLM6V7JQqzvZbNWooBM6VlqF6SrZIqezoFNujqBmWfUUbhY6ugmOS4S2pyATXPlFEeKCv5mD4HNKJyQcKsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mff1qYk2vHwANb+z5MAyOys4fpzBakWsJRJHpF57UwU=;
 b=jGGXiXWYo+qXqSFQyOfQEw67MGEN7czSFZSzjopAwPz01DJAGt9otBOeRsDyYqCjRgx6kowZRZOBmOaYTEmdHAHqjfXStiEfVp5KHt539E4PxTllrxmIsqPAC6SauckOxWBSvoeJzDee6/OXWK8g1i6PGIfd60mOB094tVc3l83db5Jn3ZTi7MyxabXdP5l0CRzFs+5kW8gso8JBABfNJuWIaM9K8JpG9Wz0EwA5JLp03fNFIpVlHYfS0JCYm8kNEwVSr4QO3R3Ggzhwjymwj5WHahCLgO/4GNAaJlJ5JeFXO3oWY7QkPMtPP0FMavTSt336S+n4UOlLu7LSAxE+Cg==
Received: from BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 23:02:35 +0000
Received: from BL0PR12MB5521.namprd12.prod.outlook.com
 ([fe80::45c7:723:54c7:9148]) by BL0PR12MB5521.namprd12.prod.outlook.com
 ([fe80::45c7:723:54c7:9148%6]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 23:02:35 +0000
From:   David Thompson <davthompson@nvidia.com>
To:     Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Thread-Topic: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Thread-Index: AQHZgzY+h/vbiPqEuk2dOyVolWTn769UHl5Q
Date:   Wed, 10 May 2023 23:02:35 +0000
Message-ID: <BL0PR12MB55214CBEAAE8CB4241BCBBDCC7779@BL0PR12MB5521.namprd12.prod.outlook.com>
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
 <20230510115434.50166-1-limings@nvidia.com>
In-Reply-To: <20230510115434.50166-1-limings@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB5521:EE_|DM6PR12MB4217:EE_
x-ms-office365-filtering-correlation-id: e4cd5eac-1723-4b88-317c-08db51aaa4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pbxa+R9eRuXYRLNtVBZiOBagNn033hZZ/OdQkaTke6YdRPnqFozdDewhKdxq2qtAMdfqZ2diZuhA3uZ7LpCcsx5btLEZ6gs0sCOStu7Oax59WP62J0VjSGQ/3VLamYxQhYldnuKEy7I810lkvlKBwlkCd89p7a+A145+v9otnEqou/Bi8DiRWF+s9v4LmGNPrUKB+S6PiMUcIc72U2Gxw64HkBnhqW1BU0+XCNTRLU2dG7WBDcGpUi2YCVyKzKe8krym+8J0n+W7M4TCsKmNmuubhJuwMTFDrJwtEZnnQmSPdsgFp8imip/d+orkDLhZSeoy0A00B8Jf7QxMv5V1vBHf9akh9p7MyuMBZrU2vmmefb3o/ezQoPLRchxMpx3UkrNoTy+JKZOCT5aG4ZWDMMcLiOj051PODssTThKIMUEZmKrEFawGAk8Bjdqi84VV5BrNCV72twC1MO7OWdKEKaJscmB8/e3m0lO7QdRaBPaMJsEMMnOzJkaZEqYCPxVHPg4r63K3IKC4uimBNC9FKDBE+4xkjfn98xQpfsRfw+NoIzM89M5Ao/n4G0Mh2nbFEbkfHqcXgRNKk5uhGAA7egIPJ7hZWrnhfAeb98K3w4piq3G/xLrrvbGzy/m7CY6o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5521.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(54906003)(83380400001)(86362001)(55016003)(71200400001)(6506007)(26005)(7696005)(66946007)(4326008)(66556008)(122000001)(110136005)(64756008)(66476007)(66446008)(76116006)(53546011)(9686003)(186003)(316002)(38100700002)(41300700001)(8676002)(5660300002)(52536014)(8936002)(2906002)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ag5B1sNNluuutlP58YQ+6GH/Pq/NR+khFidHkCgyDeGsZx12hxeD9ulpM3Vd?=
 =?us-ascii?Q?6jCUAPHgyoh13ddL1VgTTza8bqbMSVI1xiO2QgXqgbLvOTCqK8W6klXuOZiv?=
 =?us-ascii?Q?a2Btxr359YfjVdoSBXLAshnlRXnwehUiG80mJGmjKRK6JQcaOZ26eJ6J+c7Z?=
 =?us-ascii?Q?BGE+hB17TR1UOvPF5FsuWAg/IAPi46Ek7uo5AA61f2xn6ApCjX+9AHCnmBaT?=
 =?us-ascii?Q?49RRa5uu+eOlyRxcrHZD0eTpcYXOV++dfMd1HfdPQSE/HJkIeSIN5YOACa/w?=
 =?us-ascii?Q?jhW9hftiUxCwIoiQzSK8LPf6rsSI6+62zYk1ZA03dCzf2ZldoA14DCaX3N2B?=
 =?us-ascii?Q?UK+q1xhy2r/OA9eR1SzHvuWJsaoI0FWq/iXQqdw64uG2w+4HNNQTt1CbsOmC?=
 =?us-ascii?Q?5V+Eo5XHN3C2XlIF3+wLBiiSwW4Lf3mSsDN1L012xPiYHh97Qm5irPOMmgO/?=
 =?us-ascii?Q?AcJQF3jYNP04Py4YWpD4zWYaXxBAFucukOWDRlbY1EKqUuBywGDvITQCwC2K?=
 =?us-ascii?Q?c5F8Depr327Yj11RA2h3riwAZdoFq1ixTMbQwFdpl+PIeSLEgGjcx3YUqxNs?=
 =?us-ascii?Q?2MTOIe6ff2GMUUNE+XOVPvoMi1XsTmWwwf+bo5xoGOldqyMLLtQr56J8Peug?=
 =?us-ascii?Q?FYcR1aIkikX4vccnDXzjckiyx4g5/0XaLAbD2RiCFs5JqKVeaC509L2lwdcM?=
 =?us-ascii?Q?FXxRl5LDRTesiWi0VQLqLgq/UHhqU5Lm8quLoYpoAS/ymvmqK32WdJaRGL8G?=
 =?us-ascii?Q?riFuOBOAgFtGJlvRZ41ro7dx2cklp/fdWqgiloLeROohzORpSwMebJu9zVUm?=
 =?us-ascii?Q?USjN1l8d7zwyFqMI3gm+386qUEb7Otk8FUIYA7cM7dMSzwZ6bnC0G5FY6lwm?=
 =?us-ascii?Q?w3JgFDbmCzndUTM4nHia+Wd7Vg8dxllrMPkQBiRMNecgKoyJ3tVgqnor3ddF?=
 =?us-ascii?Q?hrR9xtGQIXXO38no2SBcGJGQ4PVLbaIBxZXb/tPFeqnia/zmYcZpTa9JvQFv?=
 =?us-ascii?Q?wwiEi8+RGcRjWpvBMOVZjJp6594sAp+Y3JOu6rBiYPvVGoiHHNBQgS3Wox4F?=
 =?us-ascii?Q?pm/my0Mc3d/n3RWYU5B9M0irKXS8nk/mD6XYajkAd6db2DVaRt7NiArmGD3g?=
 =?us-ascii?Q?xkALgs53kFdXWsbH6KtUGhyDlUI/SMAGx39aGQqpx2W9E7uqSijKp3ADUvQa?=
 =?us-ascii?Q?rYM1oHeCUWlG2c8U7UuufWBPcnUbnSP+PNRjXJ2Oez44pZwdYncASNmpo06e?=
 =?us-ascii?Q?ScNowts0WuUSWhCPHg0YoaZ+3V52pFmiK0OYhWOr/udt7SHQkOZLHDQySeWH?=
 =?us-ascii?Q?4Zo8ZXcU+DTG/Az4bk8J2dBKOJsfit2t+MsmpD3jIasABiFTJF0VKv2hPl+k?=
 =?us-ascii?Q?sl0lxGV0yKhja8mylWxUE+G0RoVOEYwVNh3O6KYNcUyj2rOD4kei3BSA3ZHs?=
 =?us-ascii?Q?KKENVRF9K3+6jaFj+xlOs75vZvpIBrQxQUxCnCRkth0wgN6LCYT5zQ4Y5/CJ?=
 =?us-ascii?Q?7+2AY1ctNAmXc1OM69fkMYEPGyxCkaHk7x6BuqDEXjLGZ9Pi7fM9chr1mfSK?=
 =?us-ascii?Q?17/x+rkD+v6zivfeOpZWFX169cAO9b+DAbVA3dgD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5521.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd5eac-1723-4b88-317c-08db51aaa4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 23:02:35.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54pTzAItCfJvgfUF+P7dw88oodhvC8elTTLJ9DjWX3yI650avgWntpEfMPFLBSdQ+zF3pipKiXis8JRxxhEetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Liming Sun <limings@nvidia.com>
> Sent: Wednesday, May 10, 2023 7:55 AM
> To: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
> <davthompson@nvidia.com>; Hans de Goede <hdegoede@redhat.com>; Mark
> Gross <markgross@kernel.org>
> Cc: Liming Sun <limings@nvidia.com>; platform-driver-x86@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
>=20
> This commit adds sysfs interface to be used to write into the boot log wh=
ich is 1KB
> HW buffer on BlueField SoC. The same log buffer is also used by firmware =
code
> like ATF/UEFI, and can be displayed by userspace tools or from external h=
ost via
> USB/PCIe.
>=20
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> ---
> v1->v2:
>     Fixes for comments from Hans:
>     - Add more details in Documentation about the log levels;
>     - Replace 0x0a with '\n';
>     - Solve comment 'Why len + 1, this seems intended to assume some
>       separator between prefix'. The change is to remove the '+ 1'
>       here to avoid confusion. Yes, it's trying to remove the space
>       separator. Since the next block 'Ignore leading spaces' already
>       has similar logic, no need for the '+ 1" here.
> v1: Initial version.
> ---
>  .../testing/sysfs-platform-mellanox-bootctl   |   9 ++
>  drivers/platform/mellanox/mlxbf-bootctl.c     | 141 ++++++++++++++++++
>  2 files changed, 150 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> index 9b99a81babb1..4c5c02d8f870 100644
> --- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> @@ -75,3 +75,12 @@ KernelVersion:	6.4
>  Contact:	"Liming Sun <limings@nvidia.com>"
>  Description:
>  		The file used to access the BlueField boot fifo.
> +
> +What:		/sys/bus/platform/devices/MLNXBF04:00/rsh_log
> +Date:		May 2023
> +KernelVersion:	6.4
> +Contact:	"Liming Sun <limings@nvidia.com>"
> +Description:
> +		The file used to write BlueField boot log with the format
> +                "[INFO|WARN|ERR|ASSERT ]<msg>". Log level 'INFO' is used=
 by
> +                default if not specified.
> diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c
> b/drivers/platform/mellanox/mlxbf-bootctl.c
> index 1bad1d278672..e88ce68acb89 100644
> --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> @@ -45,10 +45,38 @@ static const char * const mlxbf_bootctl_lifecycle_sta=
tes[]
> =3D {
>  	[3] =3D "RMA",
>  };
>=20
> +/* Log header format. */
> +#define MLXBF_RSH_LOG_TYPE_SHIFT	56
> +#define MLXBF_RSH_LOG_LEN_SHIFT		48
> +#define MLXBF_RSH_LOG_LEVEL_SHIFT	0
> +
> +/* Log module ID and type (only MSG type in Linux driver for now). */
> +#define MLXBF_RSH_LOG_TYPE_MSG		0x04ULL
> +
> +/* Log ctl/data register offset. */
> +#define MLXBF_RSH_SCRATCH_BUF_CTL_OFF	0
> +#define MLXBF_RSH_SCRATCH_BUF_DATA_OFF	0x10
> +
> +/* Log message levels. */
> +enum {
> +	MLXBF_RSH_LOG_INFO,
> +	MLXBF_RSH_LOG_WARN,
> +	MLXBF_RSH_LOG_ERR
> +};
> +

Should add "MLXBF_RSH_LOG_ASSERT" to enum for completeness

>  /* Mapped pointer for RSH_BOOT_FIFO_DATA and RSH_BOOT_FIFO_COUNT
> register. */  static void __iomem *mlxbf_rsh_boot_data;  static void __io=
mem
> *mlxbf_rsh_boot_cnt;
>=20
> +/* Mapped pointer for rsh log semaphore/ctrl/data register. */ static
> +void __iomem *mlxbf_rsh_semaphore; static void __iomem
> +*mlxbf_rsh_scratch_buf_ctl; static void __iomem
> +*mlxbf_rsh_scratch_buf_data;
> +
> +/* Rsh log levels. */
> +static const char * const mlxbf_rsh_log_level[] =3D {
> +	"INFO", "WARN", "ERR", "ASSERT"};
> +
>  /* ARM SMC call which is atomic and no need for lock. */  static int
> mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)  { @@ -266,12 +294,11=
1
> @@ static ssize_t fw_reset_store(struct device *dev,
>  	return count;
>  }
>=20
> +/* Size(8-byte words) of the log buffer. */
> +#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
> +
> +static int mlxbf_rsh_log_sem_lock(void) {
> +	unsigned long timeout;
> +
> +	/* Take the semaphore. */
> +	timeout =3D jiffies + msecs_to_jiffies(100);
> +	while (readq(mlxbf_rsh_semaphore)) {
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mlxbf_rsh_log_sem_unlock(void) {
> +	writeq(0, mlxbf_rsh_semaphore);
> +}
> +
> +static ssize_t rsh_log_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	int rc, idx, num, len, size =3D (int)count, level =3D MLXBF_RSH_LOG_INF=
O;
> +	u64 data;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	if (!mlxbf_rsh_semaphore || !mlxbf_rsh_scratch_buf_ctl)
> +		return -EOPNOTSUPP;
> +
> +	/* Ignore line break at the end. */
> +	if (buf[size - 1] =3D=3D '\n')
> +		size--;
> +
> +	/* Check the message prefix. */
> +	for (idx =3D 0; idx < ARRAY_SIZE(mlxbf_rsh_log_level); idx++) {
> +		len =3D strlen(mlxbf_rsh_log_level[idx]);
> +		if (len + 1 < size &&
> +		    !strncmp(buf, mlxbf_rsh_log_level[idx], len)) {
> +			buf +=3D len;
> +			size -=3D len;
> +			level =3D idx;
> +			break;
> +		}
> +	}
> +
> +	/* Ignore leading spaces. */
> +	while (size > 0 && buf[0] =3D=3D ' ') {
> +		size--;
> +		buf++;
> +	}
> +
> +	/* Take the semaphore. */
> +	rc =3D mlxbf_rsh_log_sem_lock();
> +	if (rc)
> +		return rc;
> +
> +	/* Calculate how many words are available. */
> +	num =3D (size + sizeof(u64) - 1) / sizeof(u64);
> +	idx =3D readq(mlxbf_rsh_scratch_buf_ctl);
> +	if (idx + num + 1 >=3D RSH_SCRATCH_BUF_CTL_IDX_MASK)
> +		num =3D RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1;
> +	if (num <=3D 0)
> +		goto done;
> +
> +	/* Write Header. */
> +	data =3D (MLXBF_RSH_LOG_TYPE_MSG << MLXBF_RSH_LOG_TYPE_SHIFT)
> |
> +		((u64)num << MLXBF_RSH_LOG_LEN_SHIFT) |
> +		((u64)level << MLXBF_RSH_LOG_LEVEL_SHIFT);

Should use FIELD_PREP() macro to generate value in "data"

> +	writeq(data, mlxbf_rsh_scratch_buf_data);
> +
> +	/* Write message. */
> +	for (idx =3D 0, len =3D size; idx < num && len > 0; idx++) {
> +		if (len <=3D sizeof(u64)) {
> +			data =3D 0;
> +			memcpy(&data, buf, len);
> +			len =3D 0;
> +		} else {
> +			memcpy(&data, buf, sizeof(u64));
> +			len -=3D sizeof(u64);
> +			buf +=3D sizeof(u64);
> +		}
> +		writeq(data, mlxbf_rsh_scratch_buf_data);
> +	}
> +
> +done:
> +	/* Release the semaphore. */
> +	mlxbf_rsh_log_sem_unlock();
> +
> +	/* Ignore the rest if no more space. */
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RW(post_reset_wdog);  static
> DEVICE_ATTR_RW(reset_action);  static
> DEVICE_ATTR_RW(second_reset_action);
>  static DEVICE_ATTR_RO(lifecycle_state);  static
> DEVICE_ATTR_RO(secure_boot_fuse_state);
>  static DEVICE_ATTR_WO(fw_reset);
> +static DEVICE_ATTR_WO(rsh_log);
>=20
>  static struct attribute *mlxbf_bootctl_attrs[] =3D {
>  	&dev_attr_post_reset_wdog.attr,
> @@ -280,6 +407,7 @@ static struct attribute *mlxbf_bootctl_attrs[] =3D {
>  	&dev_attr_lifecycle_state.attr,
>  	&dev_attr_secure_boot_fuse_state.attr,
>  	&dev_attr_fw_reset.attr,
> +	&dev_attr_rsh_log.attr,
>  	NULL
>  };
>=20
> @@ -345,6 +473,7 @@ static bool mlxbf_bootctl_guid_match(const guid_t *gu=
id,
> static int mlxbf_bootctl_probe(struct platform_device *pdev)  {
>  	struct arm_smccc_res res =3D { 0 };
> +	void __iomem *reg;
>  	guid_t guid;
>  	int ret;
>=20
> @@ -358,6 +487,18 @@ static int mlxbf_bootctl_probe(struct platform_devic=
e
> *pdev)
>  	if (IS_ERR(mlxbf_rsh_boot_cnt))
>  		return PTR_ERR(mlxbf_rsh_boot_cnt);
>=20
> +	/* Get the resource of the bootfifo counter register. */

Wrong comment, seems like cut-and-paste error

> +	mlxbf_rsh_semaphore =3D devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(mlxbf_rsh_semaphore))
> +		return PTR_ERR(mlxbf_rsh_semaphore);
> +
> +	/* Get the resource of the bootfifo counter register. */

Wrong comment, seems like cut-and-paste error

> +	reg =3D devm_platform_ioremap_resource(pdev, 3);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +	mlxbf_rsh_scratch_buf_ctl =3D reg + MLXBF_RSH_SCRATCH_BUF_CTL_OFF;
> +	mlxbf_rsh_scratch_buf_data =3D reg +
> MLXBF_RSH_SCRATCH_BUF_DATA_OFF;
> +
>  	/* Ensure we have the UUID we expect for this service. */
>  	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0,
> &res);
>  	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> --
> 2.30.1


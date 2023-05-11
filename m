Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59716FF563
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjEKPCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEKPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:02:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9FB9;
        Thu, 11 May 2023 08:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4BDwZtUfnLWUljGlkzmhNRYyU5loi+AXpR2KWQT5YqSsxXdmvjW9P1s1Q/8dTiq9bLHe7KUJYmvRJTyC0eunavr/EHLZdwMM2MvoPkCjT7yPS93CW5EUkkVw3Fawah7GMzD2PycchsL4nkPiZdhxjNE/gmNIFoZujb1w4eE7IOUVytWT/J3u0isGXg9EQE1iW2DuSX96sttdnOnEDXE7zitdERXFd2/HcWQwcYTz7OP7rmtE4REaclOo7czPHGA9t2uYXau2IV5jxIMH8InITUVLGp06OQy+F0sss+3rs2bOlOomVdreum47XVWrcb4Sl/erlqfru7IJTS69PhPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge6wXuRkbDSImCSxLrkRrdk2+/Mijax0kaAmGlGJm9Y=;
 b=RcyK+E5vYN8aRXLzwwd3WIUkCEok+YdFvXye9jjlxPlBMqHctrU7MD5gfawODvEdyr7cnWWyituIhPDgCdaBks4eouj1HbW2N0imj33+ktRkzXfzZBkCOn1YyLz6LzISHXLdowLPSvauipwFUUhxQOTclAwYHIngAeN1TPxeqLtbh2g7F3WaJ4eBhz00Nc+YdbjwZ7HILiX1KoOF2kf+f179h0krxmiPv+t1FVncnAx8Q5Ztcf++BRXUOGbDrkP2R5Emae78w7AQx7mjdN3veKZzAlHUsua3OLQ5Rl1VVpr3Qa4YQh+/0ryvzGPwcIOvD80kysFRs/p/8wSaOhVWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge6wXuRkbDSImCSxLrkRrdk2+/Mijax0kaAmGlGJm9Y=;
 b=RcOwc4wabrwX2c1xQ4IbVaFCQUAVz1EbGF96vCYin9Q2nGOUM6pcen76rRvHstjzhpl+kIoZwpu7DZX5Sp/qnuSDQlqH4zRD0LFAkPosI16SiCu3iHmrBNyg2+OtjoyAZbY7lB90LdSg42CZrkRzfwtRz3q/fkDQtNqkrkRnzZ7Zyj3JpwNcrqi13NdcZp4leN13cuOhOQMoD7h/gmFQTkx9FtK5Dkvn5c2rxQcKdb9RM3/+AQfWvuzeuTX4/aaWMFMOh8IOwcqQc8TFtuzL2RZ4OvgWxoUPIiW9LwrytPrPCDAq6uHWE3Q/m/uQnRuzX7xv8tBV0+vsuZWCKxs8PA==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 14:57:03 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::22d5:5aa:8672:e36f]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::22d5:5aa:8672:e36f%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 14:57:03 +0000
From:   Liming Sun <limings@nvidia.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Thread-Topic: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Thread-Index: AQHZgzY+EafiDZip0ES0e8zqC86qmq9TioMAgAGfPyA=
Date:   Thu, 11 May 2023 14:57:03 +0000
Message-ID: <BN9PR12MB5068CA6B504A1C9EEEB92DA8D3749@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
 <20230510115434.50166-1-limings@nvidia.com>
 <0a9ce95-e861-ad24-7147-59dde7727a37@linux.intel.com>
In-Reply-To: <0a9ce95-e861-ad24-7147-59dde7727a37@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|MW6PR12MB7085:EE_
x-ms-office365-filtering-correlation-id: 7349ce38-8960-4d89-9c6d-08db522ffb20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GX+LYgMySqHF1OLpyf8qO+3nHDHYwL+qhVY4Bhon1U8z+TgSmW9AijzGxCew9MBaeu+NzW2raZZrTAtayG7xaDbz/ayOo52PfiJRuA+d9tcb6+arKhXjhchQqMu6TjC++m8cOUciWxElPObDTBIpsZpi3qb8quJ9IUCjOY6nCgCDbm2BWAhG+DH/qQRBdxFz3EKHUfXyyCQwr9NHC3/sls1oxsyHwtcsWodIMVyD28qXJojAYep3x6NiB1JDbglcw1y1uKy3LljALCjaGfYqyNlGG5hTiEJtTXp57jkzUzjvV4Le0EFfRXfx1yqo/FD/NR7vi1gHX0GOfuWtMMIP+naADFPKp3PojJ6u83m2cBjwd2L/Wr7NGPJnSZlB/gKnORiLNVm/eHZS8VbLFs5eGxT1G8gbxQhcdhV2JCy6t8zFcg2XfYjazEOUp8vY53r5u8jqwgLECwHMRAetj//UyUrCdbVOZWcqkEADxws4uWy1chZ5D8fFBBKmdS1r+HEMhtT9mpGhWLxKeNsDxCVHLK+8x5xr2B+p1ZWDqeuFrjsuC36uS0Dg6buH5FK8W91rDuB6gOJJabg9BV+7DBlGpa9nQ1B54piuGSip2QDSpWDgxAQyvPs6Q/YfF9yuw9lq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(2906002)(38100700002)(122000001)(52536014)(5660300002)(41300700001)(8676002)(8936002)(38070700005)(33656002)(83380400001)(86362001)(66574015)(7696005)(53546011)(76116006)(478600001)(54906003)(66946007)(4326008)(316002)(6916009)(66556008)(66446008)(66476007)(64756008)(55016003)(9686003)(71200400001)(6506007)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HYOMMb6b20L1xoi/uMp5l6rCOwmqn+/NgRkCI0of2qLx6r+Kaus7JbIz0u?=
 =?iso-8859-1?Q?wFSQ/epysROhiVO4QX+JjMlcABdodgLoDaO900gtYu/4Egxw5GvkBzvcHP?=
 =?iso-8859-1?Q?WYaqUcvA2YHGLJjCMGipw4yfruvdXUMPWT6mWJaOpUvDMo+Su4nfnjb+yG?=
 =?iso-8859-1?Q?H4Le8ta9/2g+b/dhCXrLI1bmGoQJfSEmtBnhUB+5cCp6dYlJav/v5TNGmy?=
 =?iso-8859-1?Q?016QjbGX44B0vKe71wSO4oZ2jglUcvqyI6xPYJaOQSoMZpG5qFiDRx/S8k?=
 =?iso-8859-1?Q?vfRqDPQeioNkWl/wmBrJIQKq4Rz/4atMxZp3NWaN81n+62aeBU0N/jBef8?=
 =?iso-8859-1?Q?rtudHaavOK6nGkkLnSJREUviSjjZMlEv7pOglB5MmGnyCZgkA4Pyom3XCD?=
 =?iso-8859-1?Q?XiErtg5YTea0KSxJxLS/7mp2UrFO8P0se7Vwlq6ovatX7/4cK463Tqzd6H?=
 =?iso-8859-1?Q?DBApeAM/AekRoFPw4gT6bRuKFMiKaUmzDeo0gSSca1W17rgfJRejVPKDqy?=
 =?iso-8859-1?Q?MeHFG15nWNRnXfw2aRSLELLCs4NYrGHW+HeQ3OllwWBw8bJC7li5HysT2v?=
 =?iso-8859-1?Q?TEFRK5iwXCnfPoHNz8pC+efFfUoEYJ2rKT+bnpN9n07tduUdgVBQg+4ww6?=
 =?iso-8859-1?Q?RVEfXllG36LZkTlsyq76nDqtUNGAb22Y3krpETnrO+IV5FOjacrIFE9OHH?=
 =?iso-8859-1?Q?iNkntVtGdCO5VLgx7PEQh7YAwi6VId7dofW/P3gaQdgcaStyNC5OYSx6gb?=
 =?iso-8859-1?Q?BUc/Lgjk+adPse5gD3zCjMCLMF6Ze8LnR607HgQXjTSU4hEaPtGqXmgaJT?=
 =?iso-8859-1?Q?7nwYN2wD6pKYbtlCaFDjPd0ILavrSJL9GjL8uOeP3OKXyj/28ZEuoK+vjc?=
 =?iso-8859-1?Q?8sU26qGi1CrAYY8HKIIDB1m8K6qLCWQ9Uj4UKcslBwQJ5jVHBfSJjNTiN5?=
 =?iso-8859-1?Q?1M7x7ykZNMr8I9xrTQID8z3EXpJ4n03klLTVHDq4D7V/fsk8kRMfKQXQE0?=
 =?iso-8859-1?Q?FjxZDcdCqHur5fX0RPypB6wlaUE4ZsIS/1HdELogQGbV6C8axtKov3iiJz?=
 =?iso-8859-1?Q?7wRc7yXBLTPfqDQElHZfye4X+sXPzzpLbyW2DMdr5q0WXFB2/CwZXEpvFz?=
 =?iso-8859-1?Q?WRsxCv9Ch319RFIGlRzbTCnvCBfbdze0U81bLSrwsI4C7H/uLHmaacxQ1q?=
 =?iso-8859-1?Q?4LrMUVZBZ/qYEqZIicoaK/NR/WX6gTsghUz+vgZJ9H2/4+WEay/Z3dvHgJ?=
 =?iso-8859-1?Q?ahMM0aBQBt+h/p1qew6TGuNsnHMq52giKSnN2J5u7kQCOrj62pjnZetnlp?=
 =?iso-8859-1?Q?Kv2hjgTFoc3J09gRfd1ZDalJ+3RJ8TT6IIlnn+KMCaM4NSn06PPrPXPhIU?=
 =?iso-8859-1?Q?anZ4DE5IONkAQ8dYJL3jN+KYqqzMaULZ8PXAZ1/C23G65ALI7Dj8aDHCRJ?=
 =?iso-8859-1?Q?6kPosbn+F4i60YMlWTJha8dVnrHzSdC1n+AWb93O2hDgqk+3XXhEdxn80V?=
 =?iso-8859-1?Q?xJHzKGvr0+WZiuF+lZ5QdUiFsayZ4ddoKUz1bLCmvVs++h4xlTc/AmCqY3?=
 =?iso-8859-1?Q?4vgVlQXFtnneEr2sZl+wbvyNWMam5sq7cjGNc0f/cixgVuBAvWm3aG1k5h?=
 =?iso-8859-1?Q?Q3rFq8MOuTP6I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7349ce38-8960-4d89-9c6d-08db522ffb20
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 14:57:03.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfG2Jt+NetaOQ4cEqK12q4InaNUkTnSeFy5fEUgNqhvwrGHzglQkTlhegXb9nAKAUoHIvlEhy6xlfGrDfVk53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.

> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Wednesday, May 10, 2023 10:05 AM
> To: Liming Sun <limings@nvidia.com>
> Cc: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
> <davthompson@nvidia.com>; Hans de Goede <hdegoede@redhat.com>; Mark
> Gross <markgross@kernel.org>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot =
log
>=20
> On Wed, 10 May 2023, Liming Sun wrote:
>=20
> > This commit adds sysfs interface to be used to write into the
> > boot log which is 1KB HW buffer on BlueField SoC. The same log
> > buffer is also used by firmware code like ATF/UEFI, and can be
> > displayed by userspace tools or from external host via USB/PCIe.
> >
> > Signed-off-by: Liming Sun <limings@nvidia.com>
> > Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> > ---
> > v1->v2:
> >     Fixes for comments from Hans:
> >     - Add more details in Documentation about the log levels;
> >     - Replace 0x0a with '\n';
> >     - Solve comment 'Why len + 1, this seems intended to assume some
> >       separator between prefix'. The change is to remove the '+ 1'
> >       here to avoid confusion. Yes, it's trying to remove the space
> >       separator. Since the next block 'Ignore leading spaces' already
> >       has similar logic, no need for the '+ 1" here.
> > v1: Initial version.
> > ---
> >  .../testing/sysfs-platform-mellanox-bootctl   |   9 ++
> >  drivers/platform/mellanox/mlxbf-bootctl.c     | 141 ++++++++++++++++++
> >  2 files changed, 150 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > index 9b99a81babb1..4c5c02d8f870 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > @@ -75,3 +75,12 @@ KernelVersion:	6.4
> >  Contact:	"Liming Sun <limings@nvidia.com>"
> >  Description:
> >  		The file used to access the BlueField boot fifo.
> > +
> > +What:		/sys/bus/platform/devices/MLNXBF04:00/rsh_log
> > +Date:		May 2023
> > +KernelVersion:	6.4
> > +Contact:	"Liming Sun <limings@nvidia.com>"
> > +Description:
> > +		The file used to write BlueField boot log with the format
> > +                "[INFO|WARN|ERR|ASSERT ]<msg>". Log level 'INFO' is us=
ed by
> > +                default if not specified.
> > diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c
> b/drivers/platform/mellanox/mlxbf-bootctl.c
> > index 1bad1d278672..e88ce68acb89 100644
> > --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> > +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> > @@ -45,10 +45,38 @@ static const char * const
> mlxbf_bootctl_lifecycle_states[] =3D {
> >  	[3] =3D "RMA",
> >  };
> >
> > +/* Log header format. */
> > +#define MLXBF_RSH_LOG_TYPE_SHIFT	56
> > +#define MLXBF_RSH_LOG_LEN_SHIFT		48
> > +#define MLXBF_RSH_LOG_LEVEL_SHIFT	0
>=20
> Use GENMASK_ULL() instead here and FIELD_PREP() below.

Updated in v3.

>=20
> > +
> > +/* Log module ID and type (only MSG type in Linux driver for now). */
> > +#define MLXBF_RSH_LOG_TYPE_MSG		0x04ULL
> > +
> > +/* Log ctl/data register offset. */
> > +#define MLXBF_RSH_SCRATCH_BUF_CTL_OFF	0
> > +#define MLXBF_RSH_SCRATCH_BUF_DATA_OFF	0x10
> > +
> > +/* Log message levels. */
> > +enum {
> > +	MLXBF_RSH_LOG_INFO,
> > +	MLXBF_RSH_LOG_WARN,
> > +	MLXBF_RSH_LOG_ERR
> > +};
> > +
> >  /* Mapped pointer for RSH_BOOT_FIFO_DATA and RSH_BOOT_FIFO_COUNT
> register. */
> >  static void __iomem *mlxbf_rsh_boot_data;
> >  static void __iomem *mlxbf_rsh_boot_cnt;
> >
> > +/* Mapped pointer for rsh log semaphore/ctrl/data register. */
> > +static void __iomem *mlxbf_rsh_semaphore;
> > +static void __iomem *mlxbf_rsh_scratch_buf_ctl;
> > +static void __iomem *mlxbf_rsh_scratch_buf_data;
> > +
> > +/* Rsh log levels. */
> > +static const char * const mlxbf_rsh_log_level[] =3D {
> > +	"INFO", "WARN", "ERR", "ASSERT"};
> > +
> >  /* ARM SMC call which is atomic and no need for lock. */
> >  static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
> >  {
> > @@ -266,12 +294,111 @@ static ssize_t fw_reset_store(struct device *dev=
,
> >  	return count;
> >  }
> >
> > +/* Size(8-byte words) of the log buffer. */
> > +#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
> > +
> > +static int mlxbf_rsh_log_sem_lock(void)
> > +{
> > +	unsigned long timeout;
> > +
> > +	/* Take the semaphore. */
> > +	timeout =3D jiffies + msecs_to_jiffies(100);
> > +	while (readq(mlxbf_rsh_semaphore)) {
> > +		if (time_after(jiffies, timeout))
> > +			return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
>=20
> readq_poll_timeout()

Updated in v3.

>=20
> > +}
> > +
> > +static void mlxbf_rsh_log_sem_unlock(void)
> > +{
> > +	writeq(0, mlxbf_rsh_semaphore);
> > +}
> > +
> > +static ssize_t rsh_log_store(struct device *dev,
> > +			     struct device_attribute *attr,
> > +			     const char *buf, size_t count)
> > +{
> > +	int rc, idx, num, len, size =3D (int)count, level =3D MLXBF_RSH_LOG_I=
NFO;
>=20
> Why casting to int, why not keep sizes as size_t??

Updated in v3 to keep type 'size_t'.

>=20
> > +	u64 data;
> > +
> > +	if (!size)
> > +		return -EINVAL;
> > +
> > +	if (!mlxbf_rsh_semaphore || !mlxbf_rsh_scratch_buf_ctl)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Ignore line break at the end. */
> > +	if (buf[size - 1] =3D=3D '\n')
> > +		size--;
> > +
> > +	/* Check the message prefix. */
> > +	for (idx =3D 0; idx < ARRAY_SIZE(mlxbf_rsh_log_level); idx++) {
> > +		len =3D strlen(mlxbf_rsh_log_level[idx]);
> > +		if (len + 1 < size &&
> > +		    !strncmp(buf, mlxbf_rsh_log_level[idx], len)) {
> > +			buf +=3D len;
> > +			size -=3D len;
> > +			level =3D idx;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* Ignore leading spaces. */
> > +	while (size > 0 && buf[0] =3D=3D ' ') {
> > +		size--;
> > +		buf++;
> > +	}
> > +
> > +	/* Take the semaphore. */
> > +	rc =3D mlxbf_rsh_log_sem_lock();
> > +	if (rc)
> > +		return rc;
> > +
> > +	/* Calculate how many words are available. */
> > +	num =3D (size + sizeof(u64) - 1) / sizeof(u64);
>=20
> DIV_ROUND_UP()

Updated in v3 to use DIV_ROUND_UP().

>=20
> > +	idx =3D readq(mlxbf_rsh_scratch_buf_ctl);
> > +	if (idx + num + 1 >=3D RSH_SCRATCH_BUF_CTL_IDX_MASK)
> > +		num =3D RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1;
>=20
> min() ?

Updated in v3 to use min().

>=20
> > +	if (num <=3D 0)
> > +		goto done;
> > +
> > +	/* Write Header. */
> > +	data =3D (MLXBF_RSH_LOG_TYPE_MSG <<
> MLXBF_RSH_LOG_TYPE_SHIFT) |
> > +		((u64)num << MLXBF_RSH_LOG_LEN_SHIFT) |
> > +		((u64)level << MLXBF_RSH_LOG_LEVEL_SHIFT);
> > +	writeq(data, mlxbf_rsh_scratch_buf_data);
> > +
> > +	/* Write message. */
> > +	for (idx =3D 0, len =3D size; idx < num && len > 0; idx++) {
>=20
> size_t -> int conversion, why? Why you need another variable besides size
> anyway?
>=20
> How can len <=3D 0 occur when idx < num is true?

Updated in v3. Simplified the code to remove the 'len' from this loop.

>=20
> > +		if (len <=3D sizeof(u64)) {
>=20
> Why =3D ?

Updated in v3. '<' or '<=3D' will have the same effect in this block.=20
But changed it to '<' to avoid confusion.

>=20
> > +			data =3D 0;
> > +			memcpy(&data, buf, len);
> > +			len =3D 0;
> > +		} else {
> > +			memcpy(&data, buf, sizeof(u64));
> > +			len -=3D sizeof(u64);
> > +			buf +=3D sizeof(u64);
> > +		}
> > +		writeq(data, mlxbf_rsh_scratch_buf_data);
> > +	}
> > +
> > +done:
> > +	/* Release the semaphore. */
> > +	mlxbf_rsh_log_sem_unlock();
> > +
> > +	/* Ignore the rest if no more space. */
> > +	return count;
> > +}
> > +
> >  static DEVICE_ATTR_RW(post_reset_wdog);
> >  static DEVICE_ATTR_RW(reset_action);
> >  static DEVICE_ATTR_RW(second_reset_action);
> >  static DEVICE_ATTR_RO(lifecycle_state);
> >  static DEVICE_ATTR_RO(secure_boot_fuse_state);
> >  static DEVICE_ATTR_WO(fw_reset);
> > +static DEVICE_ATTR_WO(rsh_log);
> >
> >  static struct attribute *mlxbf_bootctl_attrs[] =3D {
> >  	&dev_attr_post_reset_wdog.attr,
> > @@ -280,6 +407,7 @@ static struct attribute *mlxbf_bootctl_attrs[] =3D =
{
> >  	&dev_attr_lifecycle_state.attr,
> >  	&dev_attr_secure_boot_fuse_state.attr,
> >  	&dev_attr_fw_reset.attr,
> > +	&dev_attr_rsh_log.attr,
> >  	NULL
> >  };
> >
> > @@ -345,6 +473,7 @@ static bool mlxbf_bootctl_guid_match(const guid_t
> *guid,
> >  static int mlxbf_bootctl_probe(struct platform_device *pdev)
> >  {
> >  	struct arm_smccc_res res =3D { 0 };
> > +	void __iomem *reg;
> >  	guid_t guid;
> >  	int ret;
> >
> > @@ -358,6 +487,18 @@ static int mlxbf_bootctl_probe(struct
> platform_device *pdev)
> >  	if (IS_ERR(mlxbf_rsh_boot_cnt))
> >  		return PTR_ERR(mlxbf_rsh_boot_cnt);
> >
> > +	/* Get the resource of the bootfifo counter register. */
> > +	mlxbf_rsh_semaphore =3D devm_platform_ioremap_resource(pdev, 2);
> > +	if (IS_ERR(mlxbf_rsh_semaphore))
> > +		return PTR_ERR(mlxbf_rsh_semaphore);
> > +
> > +	/* Get the resource of the bootfifo counter register. */
> > +	reg =3D devm_platform_ioremap_resource(pdev, 3);
> > +	if (IS_ERR(reg))
> > +		return PTR_ERR(reg);
> > +	mlxbf_rsh_scratch_buf_ctl =3D reg +
> MLXBF_RSH_SCRATCH_BUF_CTL_OFF;
> > +	mlxbf_rsh_scratch_buf_data =3D reg +
> MLXBF_RSH_SCRATCH_BUF_DATA_OFF;
> > +
> >  	/* Ensure we have the UUID we expect for this service. */
> >  	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0,
> &res);
> >  	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> >
>=20
> --
>  i.


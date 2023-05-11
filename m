Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE96FF514
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjEKOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbjEKOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:52:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFF3593;
        Thu, 11 May 2023 07:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+xwUtf78BRJxGFyXBOlcETuVXV2CyuIaD5hQ0r39sL1GdtBXxTk3K24PRj3s8SgZcxq7vV1QY+BO6SNQulSqunrfuKHmUmQM4RwqPqByjoy+Tli0Og0OJE0utaYN4Za+RbBaMevWD4IeqJJwnj/ktHqG/CfHPcO8WG2305c/aKjaK/rVWAnqynpbSmmpGN/yA20YOQF8YCwIF4P4D1ZmDb5+KXKgfAHEGSoHlo2xCDbpg88+++LjsZFYAHm6t1MwCe7BgRSrAiM0vyo5W9QIAnzf2XOwWOELyPbfJPZ1TjGVS0fLPuuBQ8N+r8TGxShyRoIsPxWaOCdEWYdFPPSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WK0yQ/LIWIkZ4CVuRcHSNV+MD99FRSbHJCb+H3h/Sk=;
 b=hntW28lATM5cGzYKfjh4Q6hWNi2XZx1Yp/avK3hQaUT2Cd2IvWDH1lkaB3MRnvfiE06eyV7mXB4/b5ZOkUqUXMaeLj7Z/ZGSBMnLhe8yVLIW/auiEkncZfd0voYQgv8gDv+TC8mwTjoY6O3PA4htb92BS5huf1SzZ8AMlu4QBqbhKkJAPbJzpDPTMxeTRz9K7oGxWNEMsI2k368b5hq6VxY4bjMQ+BGT6pnHgXQMQnoXj4kioz9J/eQtMEP3uApA3sHvaQkILvBV2El4EEDsMKSJu12HTRsnEM6S9xSsqEA8zqAhCx+XrepKauwa1bwbkMwTte4LK1kA3GzQdIFBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WK0yQ/LIWIkZ4CVuRcHSNV+MD99FRSbHJCb+H3h/Sk=;
 b=HDiHjmelou3P7o1CtBU7Y/8YWaHqNKolek5Hez6uLreHTisjtPXepE3wWxOu9SD372Cu7fecAjyeQMTb8r1aWBwXxJJhhROeFmaTE7yo155EZxrOBLNYyFuY4KEaFHWQ+z3v0tth99JnxqFhJvjkQX+Ej2Fy/hp0zNNUU4OJLS/5FOcVO92cxbMbLolQGpODpzCA8DyCFMlFxVaDEHjTIQ7wvCbIHSwfrah3/hbrQYhaLKyPHhDWGJd3HsdiLxe3iTegMibWTp/Dhz10gFKHg5gETCwafwWCsOe+41VfhvmFdKk/PIvybdXJI6B4lHFAkGwlmZk8cKBj5Sz9OLz3AA==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 14:51:37 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::22d5:5aa:8672:e36f]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::22d5:5aa:8672:e36f%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 14:51:36 +0000
From:   Liming Sun <limings@nvidia.com>
To:     David Thompson <davthompson@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Thread-Topic: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot log
Thread-Index: AQHZgzY+EafiDZip0ES0e8zqC86qmq9UIJeAgAEI2xA=
Date:   Thu, 11 May 2023 14:51:36 +0000
Message-ID: <BN9PR12MB5068ACD7CD09B63130077FD1D3749@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <1f778872d177146336318cf856a2c0b06870b1b7.1683568762.git.limings@nvidia.com>
 <20230510115434.50166-1-limings@nvidia.com>
 <BL0PR12MB55214CBEAAE8CB4241BCBBDCC7779@BL0PR12MB5521.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB55214CBEAAE8CB4241BCBBDCC7779@BL0PR12MB5521.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|PH7PR12MB6785:EE_
x-ms-office365-filtering-correlation-id: e30c69dd-79e7-4771-29cd-08db522f3836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ynBsqNiUX+QZsK0bG9vwUtWTypBeZWbyKgnxZw9+c2BdnVLN9+DdNWW7MABBIOa+meoFkzF4kDS0R0xDKd9qjlQ1qEHMbgmpjUsbWbWmXMU0Lu8Hn9N/uKKonwCVCX2eBU2I4Km1xc9Rug8eT9fmcxVmXAbUkSLbo3VLu5DCIi+WO9DG2tQ9mnHTwRiNHxdhGWI+98WD/GboTJ2RdjxmZ16sWtC/H+lkp3X0/qcetIxiYfs7Xe4QYce2G0G3x7Q1t/q1h93Z6eT2NO3uYI2AMSClUwMevvgAhdGbnACGERo3jLx7QoXoWH+IFm5K+z/7p214cYPW6Q4UqnKVt3f4BJGgSckiekgdm8OxahOSO5oqHJk0N3gBq9vFGHD4CzxiZKnkd4xCUVmldkMLWn+A5ufTfa3ot1A27/rcJyfn2KzlgRwdOHgc36ibY0+res1F6FdvaEXCrPTnvgQ2oHi9c8mrlik4BAantNYIqsljDVUj5P3lPGnfRjonNgnMN+x8W2Wwa7zFj9z7pKsiy7HPLwh6f0PrCCrwYxUABIUo5X+7lPGbdcr1ClHBtxVJf49Ne4dkbapDYzZ/7qf6gtIRRmpKZ0xfza0csC2mmq8McXWhpMYQQi6H0Nnawm6QO83
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(66946007)(66476007)(4326008)(71200400001)(66556008)(66446008)(64756008)(76116006)(5660300002)(8936002)(8676002)(52536014)(110136005)(26005)(9686003)(54906003)(316002)(6506007)(478600001)(41300700001)(7696005)(53546011)(2906002)(186003)(83380400001)(55016003)(122000001)(86362001)(38070700005)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I2M0l6jUGviJ0JLGM+Df9CVSR6hTWEY3o7u3/CKq08tBcnpSOngRekDThaov?=
 =?us-ascii?Q?7g6lAJrwV3sVLZbmnZVVnEcwXQibxvlOtx66hJQSZtSXdp8cBdl51mnoFMb2?=
 =?us-ascii?Q?IltKXVcYHdndB0tG0zjWeO5o6+4OdzKO7LHpNNdVtw9WEbLQeKqKkOyTk4v1?=
 =?us-ascii?Q?YDCZM3ypPACSziZZYvQib4JvK2TFbPIBTfSD8G5AVCcvLSsMtBLcrjlaOqZD?=
 =?us-ascii?Q?eaTyIg4u5o+XOH/suQukNseGsWgNWN8t5E0TlSMa6Lqdcs6ThsmFJCcpTuZw?=
 =?us-ascii?Q?GzRXzS7woSCskCnBX9upnqA4dioNIPNWbYiwPOXv9uWQ9REphEg+ZdCrHi4I?=
 =?us-ascii?Q?GbrgsjibekP+U1PjT+DUSBNg9MmRWcJoC6S1w4AIIXCk7BJZgjdDK2dojInP?=
 =?us-ascii?Q?EFw6ypZjoCha36zxiTmViQTmXOrIy8xM+CBxvNDY7egYxxIQT8g0f/cxqITV?=
 =?us-ascii?Q?dHuBok9iX1kQpUIj3CIXOI385V55WvWswRwEuv1M4U6GauLsGzUJwqG/Ee1L?=
 =?us-ascii?Q?OIdgOm2SWpC/j7Z684C9sKFmast0+W9cFJDRVlbEZpcZjHeOacMYNOHFY8VO?=
 =?us-ascii?Q?F+Xel+wNepcYn57PisFckmY86y9HofwV/CWqZygFIww0isHUUZe3X1Rf6aae?=
 =?us-ascii?Q?DCN9jGt+BdG9AVjPf8ZhZ22QjzvZbLvTgWaY8XGvEq/RfzUsZrEExl4augY6?=
 =?us-ascii?Q?Q9AfFZiJM/3ahjVUpF2aiMK63ju/N6EifL2mmL0uJuM+proFGukTk3FGKHjk?=
 =?us-ascii?Q?3EemXlUwQwzrX2OUKT7YPJcnsCZhYUH6bxQM4fXTtHYH4WtrSO/TAzeuOkA0?=
 =?us-ascii?Q?m72r48dYcU/EIs4B3xeZ820WamDhep3Ut5dOUFOHIAtDw/02DXsn0oB2NWDo?=
 =?us-ascii?Q?R/UtwcGO2i4t61cwruWOIOU1xwK526ZhcQOfjeuZQWw0KhoVEO/xpawweGig?=
 =?us-ascii?Q?vhfWMPOKkdFR0XaG7VzyqIxyoCHDJNiey8FZsqIJ3e3NZta9G3vwPLe8746N?=
 =?us-ascii?Q?Iub7+JH/+VMu7vgVblqe0BAwhGw35UA1m2SAyTNYYh0S7kQjyGPwDZmX06zS?=
 =?us-ascii?Q?0dipAvBoTkg31ENbfg4F/n2VNnbbQ926A3/jpW521kWcA3E3IBL6HcJ1JiK8?=
 =?us-ascii?Q?aQEtXUDfMpBSGDOzjK10uekqE6aQ5IbUwNRLvxIsF5FeD93PPjEd4alL4BW1?=
 =?us-ascii?Q?nrBeupZhKY/xjIHphEWVhAlj1X/PpPPlCx0Pz3ApNHp/agO/U4YgFdHBmkMK?=
 =?us-ascii?Q?r4reLPaJlZ09FgHErN7gzsDX5245Ia/Tiz3lPsNn8JeSitqB/2Jga/+8LWzL?=
 =?us-ascii?Q?5bI3EBYRvreb96mczQ4qef4nWhqxFf29lJZMK9QVPg8Dc4ZXiMwfhadiqPDs?=
 =?us-ascii?Q?JGLLHV6QIszybuj5h/Y/cQ58ceKknwY9R1a1ZJrPBpUlF2TNsIXKrIsmgbyM?=
 =?us-ascii?Q?fvT/GjvRzZW6g+3LoD9QESsiJ7f6xlIA/3AqlTI1yttrYf+gQ744tcJKVe0e?=
 =?us-ascii?Q?33aj1RaQllQLOTK4OK42877gkXsboIKzPwoDmHCle2iJ6/jlP2dzfzcsHVur?=
 =?us-ascii?Q?Fd9lboh8OSdhv+L1Slg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30c69dd-79e7-4771-29cd-08db522f3836
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 14:51:36.2996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUNe8fakhI7VjnfbjlFrEt3N7VnfkPuROLUzem0WgDoECkCtGKqo1oVVAIsKODFnWvxx2bgEqv/YC3Sa+IKFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Wednesday, May 10, 2023 7:03 PM
> To: Liming Sun <limings@nvidia.com>; Vadim Pasternak
> <vadimp@nvidia.com>; Hans de Goede <hdegoede@redhat.com>; Mark Gross
> <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot =
log
>=20
>=20
>=20
> > -----Original Message-----
> > From: Liming Sun <limings@nvidia.com>
> > Sent: Wednesday, May 10, 2023 7:55 AM
> > To: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
> > <davthompson@nvidia.com>; Hans de Goede <hdegoede@redhat.com>;
> Mark
> > Gross <markgross@kernel.org>
> > Cc: Liming Sun <limings@nvidia.com>; platform-driver-x86@vger.kernel.or=
g;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v2] mlxbf-bootctl: Add sysfs file for BlueField boot lo=
g
> >
> > This commit adds sysfs interface to be used to write into the boot log =
which
> is 1KB
> > HW buffer on BlueField SoC. The same log buffer is also used by firmwar=
e
> code
> > like ATF/UEFI, and can be displayed by userspace tools or from external=
 host
> via
> > USB/PCIe.
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
> > b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
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
> > b/drivers/platform/mellanox/mlxbf-bootctl.c
> > index 1bad1d278672..e88ce68acb89 100644
> > --- a/drivers/platform/mellanox/mlxbf-bootctl.c
> > +++ b/drivers/platform/mellanox/mlxbf-bootctl.c
> > @@ -45,10 +45,38 @@ static const char * const
> mlxbf_bootctl_lifecycle_states[]
> > =3D {
> >  	[3] =3D "RMA",
> >  };
> >
> > +/* Log header format. */
> > +#define MLXBF_RSH_LOG_TYPE_SHIFT	56
> > +#define MLXBF_RSH_LOG_LEN_SHIFT		48
> > +#define MLXBF_RSH_LOG_LEVEL_SHIFT	0
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
>=20
> Should add "MLXBF_RSH_LOG_ASSERT" to enum for completeness

Updated in v3.

>=20
> >  /* Mapped pointer for RSH_BOOT_FIFO_DATA and RSH_BOOT_FIFO_COUNT
> > register. */  static void __iomem *mlxbf_rsh_boot_data;  static void
> __iomem
> > *mlxbf_rsh_boot_cnt;
> >
> > +/* Mapped pointer for rsh log semaphore/ctrl/data register. */ static
> > +void __iomem *mlxbf_rsh_semaphore; static void __iomem
> > +*mlxbf_rsh_scratch_buf_ctl; static void __iomem
> > +*mlxbf_rsh_scratch_buf_data;
> > +
> > +/* Rsh log levels. */
> > +static const char * const mlxbf_rsh_log_level[] =3D {
> > +	"INFO", "WARN", "ERR", "ASSERT"};
> > +
> >  /* ARM SMC call which is atomic and no need for lock. */  static int
> > mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)  { @@ -266,12
> +294,111
> > @@ static ssize_t fw_reset_store(struct device *dev,
> >  	return count;
> >  }
> >
> > +/* Size(8-byte words) of the log buffer. */
> > +#define RSH_SCRATCH_BUF_CTL_IDX_MASK	0x7f
> > +
> > +static int mlxbf_rsh_log_sem_lock(void) {
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
> > +}
> > +
> > +static void mlxbf_rsh_log_sem_unlock(void) {
> > +	writeq(0, mlxbf_rsh_semaphore);
> > +}
> > +
> > +static ssize_t rsh_log_store(struct device *dev,
> > +			     struct device_attribute *attr,
> > +			     const char *buf, size_t count)
> > +{
> > +	int rc, idx, num, len, size =3D (int)count, level =3D MLXBF_RSH_LOG_I=
NFO;
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
> > +	idx =3D readq(mlxbf_rsh_scratch_buf_ctl);
> > +	if (idx + num + 1 >=3D RSH_SCRATCH_BUF_CTL_IDX_MASK)
> > +		num =3D RSH_SCRATCH_BUF_CTL_IDX_MASK - idx - 1;
> > +	if (num <=3D 0)
> > +		goto done;
> > +
> > +	/* Write Header. */
> > +	data =3D (MLXBF_RSH_LOG_TYPE_MSG <<
> MLXBF_RSH_LOG_TYPE_SHIFT)
> > |
> > +		((u64)num << MLXBF_RSH_LOG_LEN_SHIFT) |
> > +		((u64)level << MLXBF_RSH_LOG_LEVEL_SHIFT);
>=20
> Should use FIELD_PREP() macro to generate value in "data"

Updated in v3.

>=20
> > +	writeq(data, mlxbf_rsh_scratch_buf_data);
> > +
> > +	/* Write message. */
> > +	for (idx =3D 0, len =3D size; idx < num && len > 0; idx++) {
> > +		if (len <=3D sizeof(u64)) {
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
> >  static DEVICE_ATTR_RW(post_reset_wdog);  static
> > DEVICE_ATTR_RW(reset_action);  static
> > DEVICE_ATTR_RW(second_reset_action);
> >  static DEVICE_ATTR_RO(lifecycle_state);  static
> > DEVICE_ATTR_RO(secure_boot_fuse_state);
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
> > static int mlxbf_bootctl_probe(struct platform_device *pdev)  {
> >  	struct arm_smccc_res res =3D { 0 };
> > +	void __iomem *reg;
> >  	guid_t guid;
> >  	int ret;
> >
> > @@ -358,6 +487,18 @@ static int mlxbf_bootctl_probe(struct
> platform_device
> > *pdev)
> >  	if (IS_ERR(mlxbf_rsh_boot_cnt))
> >  		return PTR_ERR(mlxbf_rsh_boot_cnt);
> >
> > +	/* Get the resource of the bootfifo counter register. */
>=20
> Wrong comment, seems like cut-and-paste error

Updated in v3.

>=20
> > +	mlxbf_rsh_semaphore =3D devm_platform_ioremap_resource(pdev, 2);
> > +	if (IS_ERR(mlxbf_rsh_semaphore))
> > +		return PTR_ERR(mlxbf_rsh_semaphore);
> > +
> > +	/* Get the resource of the bootfifo counter register. */
>=20
> Wrong comment, seems like cut-and-paste error

Updated in v3.

>=20
> > +	reg =3D devm_platform_ioremap_resource(pdev, 3);
> > +	if (IS_ERR(reg))
> > +		return PTR_ERR(reg);
> > +	mlxbf_rsh_scratch_buf_ctl =3D reg +
> MLXBF_RSH_SCRATCH_BUF_CTL_OFF;
> > +	mlxbf_rsh_scratch_buf_data =3D reg +
> > MLXBF_RSH_SCRATCH_BUF_DATA_OFF;
> > +
> >  	/* Ensure we have the UUID we expect for this service. */
> >  	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0,
> > &res);
> >  	guid_parse(mlxbf_bootctl_svc_uuid_str, &guid);
> > --
> > 2.30.1


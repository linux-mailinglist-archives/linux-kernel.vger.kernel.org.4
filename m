Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483BC6969C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBNQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjBNQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:36:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172722CC71;
        Tue, 14 Feb 2023 08:36:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2mbheKAxBkMfwkIZFgiQcUQOxCXHqg4iYQzLorTS4DoS3G5d8y2YqctrBvP8eYs5zosjBgPJyDoE9/PYwpDv9YftAAZ6i8kPhIYjRLR6+NNRaL7rjcmPivsA1mASCkA2l/QMdWtVv95tWGxAfsA37ArhvtVwRULc2yHJop06B/6+LQpUXuSEjP4fMU8sKdt1giW+bv+C/Z46LY0V80M9bjVre9JUFP/kSsVBpwI51OAlEJKWhKef9KLjcmxWCj1fgoSeZOw36ybwj771j4xyS8p41Q2p7m0+sGP8fqDyrPzxocyosShz8e47oX3yyBc41oj06UXaMQU5EYLRfFjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSJDJozLDEIU9xqrUt8vIb6iJPKo3tTHkvwrWye4pWQ=;
 b=J9BYjaSS8H7f2+0dL0ld3XGLdRhFJ/K1Y1SPMYW/6wIxsPkJf0FN7XFiHkpplxcvJwL1nwB8wIGfIUV0c7Bv1h93icztih+wKLFACmird2qG3woiYplUkst99PockSwz3Kw/aP0WnnjVc6Rg5eiP6fK0FK+HRZgf7n2UCdhsdRQNKWNYeOvev6bEBB1ZjErHCwqz7ztRFmbAFblGsf+z5LfmJG9Z7oYq8WnefPy6TLbLQnfxqWI9zL+r9W2Acea6RtIYKF7k3jrtPKAncuw4RP/2/EGH6qI+YWvOoKqFZ4ZrZ959+BSPPuygsptt+ZNJWaPgQu8AMWxagjiX41SMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSJDJozLDEIU9xqrUt8vIb6iJPKo3tTHkvwrWye4pWQ=;
 b=IvEdh6EEcT2aMh/oGto7HWysmX6OK2oxG9GYmdrZalqgn3+Oct8DKOVtObn/bZMdLf4cHg1dBeFZz0KSOchXsD6cZ0GPzMsCMoaS7RAON3dE0ZHcXRZHfCGdZiQM5Dx7b0vJ4+4gJ4G78jC5FqC2qVKn2jezxMyQunC5E+ybwXE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 16:36:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 16:36:27 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
Thread-Topic: [PATCH] platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
Thread-Index: AQHZQIiOUdOGwPV3f0+ptZfVua8KHa7Oo8dg
Date:   Tue, 14 Feb 2023 16:36:27 +0000
Message-ID: <MN0PR12MB610112C0A677F1526AB14F2DE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230214152512.806188-1-arnd@kernel.org>
In-Reply-To: <20230214152512.806188-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-14T16:36:26Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=86e7f91e-1729-4736-83bc-4655ceeed350;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-14T16:36:26Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: cb4e4ee3-dfda-4e06-b4ba-460d4b974b2e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BL1PR12MB5852:EE_
x-ms-office365-filtering-correlation-id: 563172de-b6cd-49c6-19f6-08db0ea99ec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7PUM7IPPliRw8GG1PLwUhg1uuz+7uUgdEm2kAjKmU2ZJQlkbVBLZ/bxFkDInvCzRLatB9gE6w8Drl+/D3VRk13tNQ2Nro2TLOmBQpNZFPKx6EnbqLfMoacg2Bq8HPG4YV2Hs+VasH+ZnehSKECCHwVF7t2u/NJWQbP+vu6gNLUv2QXrUVpbszphV0I/8BlhxxRE8nW5BE3kpcjRU9En41x6ynb0MemVjYGN160FB5PaxG8zjYIhtKf+1V0Cl0r9quanyyOgXQ4TjDQBw5munkWfWveRAhx9HC0CB4w1FZtafumtZ5LW3jCbgeW5yH0hz1HESuFA5AY1YuSYKG9NBK2wZjtGJpL+k31kY+8OscgYGT7ht93cUdo4Z6ZiNXlm1w9Ozixv7iNwYbg25j2C8IbJV2DeRWlOlWqbW9qJj6CJBEZay+KPpEz9kEVmDsu1njWRgPgWFjzrpA7j/jmjIn+PFMHSDQQjQwIpkDmqLqLbgUJGV/PjmIvDlD9j16qwB+upKZx33fLEKwY5N/2ZZaSzi4STCf6trMiueFHmfoIhB5DXvTMmjYovOGjoJYM0c8VdHp/7IX75TW8YgdfByXEGC7q4XAvRLxLzwXlmsvPpQeTEv7P1fdh+8XksNEqSQDFCZfgyDfUTpxpWQDXyYGRNty8wZxxfICAR0Auxtfdl2qovT2b8Ke8mPa0k9ensXJucKIG1FDlRxixgC15OhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(4326008)(6506007)(52536014)(5660300002)(41300700001)(33656002)(38100700002)(8936002)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(8676002)(86362001)(55016003)(71200400001)(38070700005)(478600001)(53546011)(2906002)(316002)(122000001)(110136005)(54906003)(7696005)(9686003)(26005)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P3NmWd9/JWve0PqM15Pu39pynNvxDFIk5FEHwFDS6Yo2B3Gwoc546Uqbvfk8?=
 =?us-ascii?Q?JLWA4lKpFqrex9ABvuCKgZV9ySdUrlwwpS8L4214Yt2u0kBaY4cNgBLUNsDE?=
 =?us-ascii?Q?OKSFye/c3ZWlH2BNniwjxJm3qqgOutL/BE3eOMsz8oGk9Yaa9JuQL2dP9RU0?=
 =?us-ascii?Q?b7ed80Kb7YndQaS+WxGXPfGOEH/D8sQzpXRA3jJuP2Uxoj7N7TkBby5g31Gn?=
 =?us-ascii?Q?b67b+qR2cczoyO77jlAFOMBbOEZ4XhUytvYjR1kJfzRyyAWmCfIB8u3GKhIY?=
 =?us-ascii?Q?W1n5xRW5iejcTe+8YAB/9GX+5wUd6vh92BU3PnTZxxQz3T6l7NI7QHY7/zo8?=
 =?us-ascii?Q?1/1Cs2zw+cz/4cmXgAn7xmDWQbOH58jjtTDXREcBJSTAFMWNPv7g+1G95q0f?=
 =?us-ascii?Q?gtVq+HroDLw7GAnj+LGTmAjVSAWcRodKYavfLKFMSm4LoR8SI8+BHs6oIXOe?=
 =?us-ascii?Q?bAtNJiXHMvub3Am6r+/r796oii/HWuSELnzrkXCdZm5x+jID3uCySR7OUFV5?=
 =?us-ascii?Q?TNenm/IWld5KJ0X8gepccZc8D/gxcQLK0TMOws6293ol9DyEk0BS23saiJq+?=
 =?us-ascii?Q?grXWqHIwVFyHYhVpZWo+vpEI7y7uwH9ry6lnh/jZb+45LGInfgwrCPWYgdWf?=
 =?us-ascii?Q?fFvCbHtMtDHC+hMwb3HspGyFBJ8EewLrhuDpn7sE6FYBjMO1GXka+d8YirMz?=
 =?us-ascii?Q?PN+zvtHuHvrTkeTuWL3/LRzsXjTZ2lqYakd44zlb5Io+CHbMnWovTX2Y734+?=
 =?us-ascii?Q?F5C7getXqt5pDLxpEAk9HB0UohGQZXL/J6Mm3Mr5u+4jfvkA55aDqik/zQ9m?=
 =?us-ascii?Q?jANIk323R9yU5R7iNvz2eBeun9+IvHupOgtkBX96tNPvO3Gh1Rw3PrWwF7EZ?=
 =?us-ascii?Q?oumtkN5Xy5dAbpKpTdZeDz35T5VOCKrtJS3iTeYSVriHYoS/maUwudSAdM/8?=
 =?us-ascii?Q?FvDmsmZMGIZhYv+eZEOYlamhn6FsPsPwbUBopZy1MZ7PWj2M1z9Kvzw2axXX?=
 =?us-ascii?Q?65qevFA2jJPDuvWDtAnonBnrgLHWNqS+LvBlh+SEiX95icwlSmEgS9WgOqzr?=
 =?us-ascii?Q?pp06PC/VYmmrvg8Wdm7pXG4xtymRVhmAP9GDS/1BaMMkoJSzE3orRBJqR0hr?=
 =?us-ascii?Q?tW8JY/8tXk9EohrAk6A2MKn2kLITlgCBubppPr9c4qlEvRYYrCjoebTmzqF4?=
 =?us-ascii?Q?AkB8Kfyd42/kTV7iLOCWUCNXbrMijMg4fmcXz/gvH3ycqlNJ80fJ0opYXoKJ?=
 =?us-ascii?Q?6WSKPsuJt4KLBKyBvfmsYdv+dSwl8OeK7xkxszMQeZE57MY47y+9GM9rzbrJ?=
 =?us-ascii?Q?cVJkPO7zeBfiLQMf0AzUzrTS/35vcmCkj/EsSK5yZ+P0kcZogV4oTMwS2ODq?=
 =?us-ascii?Q?gYhskr4h/IEL2nzTb4noSQv3sjOOpajaZ0k/tiHqbRjAYG0tbh4zJKfd4bdV?=
 =?us-ascii?Q?TCQBnZHFizTeIdKxBoaFkgSh0EPYHVfJs1odyJts25nKF8/2GzcWth+Ei1Xp?=
 =?us-ascii?Q?h5e3hR1vLtC+gEIZM/m8PbTbcbhFHZ8q0Gwpx8YlBXclLqsY6aHZ1E+lZicG?=
 =?us-ascii?Q?HvGtIYYW3KbOhlMnsOI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563172de-b6cd-49c6-19f6-08db0ea99ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 16:36:27.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JNnuGqRIYyv8NS4ulsc6tD+5lcuTygJWvMMBZdfEddFmH3xcP+r3+JZmQPE1RXWTgq7IDGS/kMNPi5ws1CW2+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, February 14, 2023 09:25
> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Nathan Chancellor <nathan@kernel.org>;
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The amd_pmc_write_stb() function was previously hidden in an
> ifdef to avoid a warning when CONFIG_SUSPEND is disabled, but
> now there is an additional caller:
>=20
> drivers/platform/x86/amd/pmc.c: In function
> 'amd_pmc_stb_debugfs_open_v2':
> drivers/platform/x86/amd/pmc.c:256:8: error: implicit declaration of func=
tion
> 'amd_pmc_write_stb'; did you mean 'amd_pmc_read_stb'? [-
> Werror=3Dimplicit-function-declaration]
>   256 |  ret =3D amd_pmc_write_stb(dev, AMD_PMC_STB_DUMMY_PC);
>       |        ^~~~~~~~~~~~~~~~~
>       |        amd_pmc_read_stb
>=20
> There is now an easier way to handle this by using
> DEFINE_SIMPLE_DEV_PM_OPS()
> to replace all the #ifdefs, letting gcc drop any of the unused functions
> silently.
>=20
> Fixes: b0d4bb973539 ("platform/x86/amd: pmc: Write dummy postcode into
> the STB DRAM")

I suspect this is not an appropriate fixes tag.  SIMPLE_DEV_PM_OPS only cam=
e in
8e60615e89321 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN")

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/amd/pmc.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmc.c
> b/drivers/platform/x86/amd/pmc.c
> index ab05b9ee6655..641085906baf 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -171,9 +171,7 @@ MODULE_PARM_DESC(disable_workarounds,
> "Disable workarounds for platform bugs");
>  static struct amd_pmc_dev pmc;
>  static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32
> *data, u8 msg, bool ret);
>  static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
> -#ifdef CONFIG_SUSPEND
>  static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
> -#endif
>=20
>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int
> reg_offset)
>  {
> @@ -386,7 +384,6 @@ static int get_metrics_table(struct amd_pmc_dev
> *pdev, struct smu_metrics *table
>  	return 0;
>  }
>=20
> -#ifdef CONFIG_SUSPEND
>  static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
>  {
>  	struct smu_metrics table;
> @@ -400,7 +397,6 @@ static void amd_pmc_validate_deepest(struct
> amd_pmc_dev *pdev)
>  		dev_dbg(pdev->dev, "Last suspend in deepest state for
> %lluus\n",
>  			 table.timein_s0i3_lastcapture);
>  }
> -#endif
>=20
>  static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>  {
> @@ -673,7 +669,6 @@ static int amd_pmc_send_cmd(struct amd_pmc_dev
> *dev, u32 arg, u32 *data, u8 msg,
>  	return rc;
>  }
>=20
> -#ifdef CONFIG_SUSPEND
>  static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
>  {
>  	switch (dev->cpu_id) {
> @@ -861,9 +856,7 @@ static int __maybe_unused
> amd_pmc_suspend_handler(struct device *dev)
>  	return 0;
>  }
>=20
> -static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler,
> NULL);
> -
> -#endif
> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmc_pm,
> amd_pmc_suspend_handler, NULL);
>=20
>  static const struct pci_device_id pmc_pci_ids[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_PS) },
> @@ -905,7 +898,6 @@ static int amd_pmc_s2d_init(struct amd_pmc_dev
> *dev)
>  	return 0;
>  }
>=20
> -#ifdef CONFIG_SUSPEND
>  static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
>  {
>  	int err;
> @@ -926,7 +918,6 @@ static int amd_pmc_write_stb(struct amd_pmc_dev
> *dev, u32 data)
>=20
>  	return 0;
>  }
> -#endif
>=20
>  static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
>  {
> @@ -1017,11 +1008,10 @@ static int amd_pmc_probe(struct
> platform_device *pdev)
>  	}
>=20
>  	platform_set_drvdata(pdev, dev);
> -#ifdef CONFIG_SUSPEND
> -	err =3D acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
> +	if (IS_ENABLED(CONFIG_SUSPEND))
> +		err =3D acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
>  	if (err)
>  		dev_warn(dev->dev, "failed to register LPS0 sleep handler,
> expect increased power consumption\n");
> -#endif
>=20
>  	amd_pmc_dbgfs_register(dev);
>  	return 0;
> @@ -1035,9 +1025,8 @@ static int amd_pmc_remove(struct platform_device
> *pdev)
>  {
>  	struct amd_pmc_dev *dev =3D platform_get_drvdata(pdev);
>=20
> -#ifdef CONFIG_SUSPEND
> -	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
> -#endif
> +	if (IS_ENABLED(CONFIG_SUSPEND))
> +		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
>  	amd_pmc_dbgfs_unregister(dev);
>  	pci_dev_put(dev->rdev);
>  	mutex_destroy(&dev->lock);
> @@ -1061,9 +1050,7 @@ static struct platform_driver amd_pmc_driver =3D {
>  		.name =3D "amd_pmc",
>  		.acpi_match_table =3D amd_pmc_acpi_ids,
>  		.dev_groups =3D pmc_groups,
> -#ifdef CONFIG_SUSPEND
> -		.pm =3D &amd_pmc_pm,
> -#endif
> +		.pm =3D pm_sleep_ptr(&amd_pmc_pm),
>  	},
>  	.probe =3D amd_pmc_probe,
>  	.remove =3D amd_pmc_remove,
> --
> 2.39.1

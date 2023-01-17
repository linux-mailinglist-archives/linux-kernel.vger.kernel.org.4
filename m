Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E8D66D4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjAQCz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjAQCyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:54:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E424107;
        Mon, 16 Jan 2023 18:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcm/JlQzmP29ZiTjiXleqkp5NtU1ad3aqkLxoEFZI1vOWAtaJuGiWiP9KAN8w0Zf9+yW40Thhec8tP5ZewWEtTQ+P67ynrz14o1K4X8jwb8wz9QOgyqd1zHidHR/haQTuxPba8DqkIABW7QJcD6AlZlCVMl/KE7rVHh77fJFOrD5nEV+DyHSqgiIdDNUorrvdxj+U39BAST4VqB1BDo5Xdh+x/kFHojQuEDmOjsEMwtkSa8dD6G6B9oslRWGXa/+DKI0jjEn/wxLWo5XYqJNhh0/8rbYZVpYZVtyI5xiN+Bh2ZQ2W5sg/7HdlxifHJFOMx8TgiztIXxdJTdEqMa4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7u6r9m8AAHZLsUooacoJiuRdNbmbS7k6rpiLMO3roY=;
 b=gfpmWFSf3RxqpAF/trYN+l5GjI6tj/fFV0NsySZYxFRuFmoRAmBKhOGbOeXjNChZqEF7dWBXwMjJlGH/Jceaa3rVEHwY7YLG2OWX7tA0Ll3Qxf2wFWvJgJ3wOnBDgYJGlahn8DrvasIgw3fRB5c1ZKMDSAJpMKysa7YFq/4Ls+DQIPLsZag3Iun9g6nMHQ3PeaVyOZgJm88RPg/NTbUAqSpglN+bj7G/c+rdkPQj84pA6FVvn7H5ySHXb4mLIjQZtE7t5D/wL5sCWcwMJYh2qRx+n+NQrWAxxQI7dbnDLd2u6ybNop0YKfv3BPRAZGuvmFnbXAk+YCKHOa9w1/kyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7u6r9m8AAHZLsUooacoJiuRdNbmbS7k6rpiLMO3roY=;
 b=D7KT+EmJ7UunG/5zD/29GxWAPeW4w1v6dWbzVH8Ca0C88qtg8aMQovZ+7VTp7DF61H2/gf2FS/e/nb+j5NXQIKC4svA4BEir5Dd/JSSy64Ud2N2qlwkvDVrWvneQQ+hZn6ybi7BA6689pawHkJJ+uKPxWyfwlFmofP0a3uYvAM0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 02:51:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 02:51:24 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xaver Hugl <xaver.hugl@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH] Input: i8042: Disable wake from keyboard by default on
 several AMD systems
Thread-Topic: [PATCH] Input: i8042: Disable wake from keyboard by default on
 several AMD systems
Thread-Index: AQHZKdslTv6nDFMDvU+XXnpXMKEm6q6h6Msg
Date:   Tue, 17 Jan 2023 02:51:23 +0000
Message-ID: <MN0PR12MB6101C67B957236CD0560E372E2C69@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230116184830.30573-1-mario.limonciello@amd.com>
In-Reply-To: <20230116184830.30573-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-17T02:51:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=06d3821b-4f32-4b0a-bcc3-73406bdc4856;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-17T02:51:21Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 23cdf74e-b651-4a7b-86a2-1891f1f3dcc4
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DS7PR12MB6333:EE_
x-ms-office365-filtering-correlation-id: 41032146-8173-4213-a599-08daf835b8ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsnuSfxW+r2tYyzh+xpgRCIXLEfZc8RxhBP1khULjGeDQjNl0L6pMR90yvXB4isPEh0yFEPFL2OUgIoghWc0+er/VO9ziTL8TjMBubvgbKaqPlaC5GQ+V5///k+RQW/lmLaY7YDz/eINJ7WBSpjgpf7hgpK3hectc/k9QOXt5TEaYmdqCHe3x2riFtnGfHMrnorHqtLpzuVPJaC2K/T2VNmNJt7c4aUGXxWWIIRgA8JBn9Qpp8HjzjSzJGkXDLpfTBL1S8H+aTmhZ/jijhF+WKEYmkjXfao9FD/yXOhsxinmYyetF2onqc3PHghwqKh/TOsjJ8mftiIdYfT25QqRwlmiaXccaMVCKquJnMBP2wTU4a0b0nAH9Fy2/Hre4gQOhFCNrgAMfY/75j9hjCLIojxSbZz3y67mt5WwlnvobsDOoDtSeyTWxNooAicxN9P63kMzn5FD2Mf7RAUp2t6b3FAiLItsIFJn1PaUYZ1bQimdfZdhYn8TWG/V3EJN3QOKpXjTdT59TVMLiZRWxnrOhHzNVLkx1GrDVikTKQQYx/0yTh9yWVPvd+qgIt4kFWoGlvaDAdcTVJ18sPg20g5rv4HmEQn9+zyA+UNXn5Ca6FOIemEyQG/5R9DmnIpC9gHTmfRWfkLlzF6FLk49VQ+ItA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(86362001)(8676002)(33656002)(4326008)(64756008)(41300700001)(53546011)(66556008)(66946007)(76116006)(66476007)(66446008)(186003)(9686003)(316002)(7696005)(38100700002)(71200400001)(54906003)(110136005)(478600001)(6506007)(122000001)(2906002)(38070700005)(966005)(52536014)(5660300002)(83380400001)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QthMQqzdJJMiityh0B4fNnT5u+acW3G3BwksW6sRr4Ek0V3Ts3MDS6epaifh?=
 =?us-ascii?Q?9X65JvX3FEBoAS5M9WTo4M+5OKt0MQlYbHKSy7F5vIqstJRsY/GtYw44fQh/?=
 =?us-ascii?Q?8Z4swQjmleB9FM2dJQlZBBfSfe5gb8NCkei4rWGl27u93kT0IwKU2EPJrhf4?=
 =?us-ascii?Q?ohuVqkz8d0IjkEqObytOiLIO6kaQUYuMtMPwq/nynfo9DfKmz94Yi2crBob9?=
 =?us-ascii?Q?1znsruxBTGIhv0l8vn/smORT+n6OD74cW7ptTZC3joo68dHR6bG6m5U4lrBm?=
 =?us-ascii?Q?VJKMR1KvsHyzk+ZppiLdmM56F5GDY/jOlsF25KLLdVx7wjf1G9zEUKxWUpHp?=
 =?us-ascii?Q?OMl+ytThCtm3DJEawmpjSWblrdIp+yoG5G+2LIPRYhq5oOxgNUy6dF6oRX/w?=
 =?us-ascii?Q?8htxXj+CajWWRldrf0mQFmwj6oOuhuZLXtmvqlI3HJTzA0b9DhQ6aCmnM2YG?=
 =?us-ascii?Q?hp7koe8fibl8xiNN59LodynKNVg/uKvVU+cBZ6PWafHDVeryDVYGN3idyzUR?=
 =?us-ascii?Q?hTkLXFYDNpOD8V08ulMNTKFc84Q3UkiAQ0TNiXhhRNhSX7bIVS9ycT7y+eRa?=
 =?us-ascii?Q?uHjsddAG29Q/Bt+tBkPnfk/rlX8LkrMB+9xcSImC6mU45QocUUQFF0AYCcmP?=
 =?us-ascii?Q?EoK6vhAJcOuTMDySiQqcZyKBVCsmcAefMBSFG9uzTjnrOOe+tQ+IwAtMzE69?=
 =?us-ascii?Q?CC5WWNVK9FQmEcPg89BPn8Q/ifb7s8UOO+czpaca6NnBqG55bvnfqk/82FHG?=
 =?us-ascii?Q?J+mKCw9f43k4GFYHuBo1XiCYdQDRjj+/ItHlRi7tc6/Damnw+PPctPGWZh0G?=
 =?us-ascii?Q?vPmyt7LmEi2cmbo3A3aHPoRpXCD766s/IwM65ejAYk5m7dCZMTHt2N1u6RrH?=
 =?us-ascii?Q?QQ5DeevQiHXx3b7bCWsPlMiZuAf1yIm6uw6XmWreZ6jG6aoSC1aV4OGFHq3q?=
 =?us-ascii?Q?mPz25lkP6SCZ2oZqV3sqE5nqH2K8ObnNzpAWhzICHVIAmkdZccm3EttFUuHb?=
 =?us-ascii?Q?j+pzQXgVdYIU5oPNgOP+9Vzwtq09NPBVCrGgn/SMbOp1EtUQlsoRGIkNZ15d?=
 =?us-ascii?Q?DK/7zIa5rxIiMJFYRKFuPh4k29U23rOpZ1/2eOEijOH5atiXROsvQWAg8gEu?=
 =?us-ascii?Q?vZvkgRZjhESwZF/f79ew5ius5cA/l1F52TRaM4x9595SCp3Us9t9oX6qr1Y4?=
 =?us-ascii?Q?npf83TkfUhrMfZ5UaTEKbQl8hSK+o3HFwz22OYk+MeNE4I6xnWLIWWfJbC0y?=
 =?us-ascii?Q?4yCoX5OKJNHiLe/M7tXtWFzPUK3E12bzPntFaQrx1rZP1PI/MzRN8F9Oc0RS?=
 =?us-ascii?Q?mdnUqOYu8CLutfUWvPKy1prdBBoe7dEGRAsp8eSfWR5kdzJuAFzWEJ9BNm/C?=
 =?us-ascii?Q?xpdMJPgvZeD2kT5aKM6Qacdbi2tr9jv817vf5aHrIGyM7qRXNl5kVcsz17tK?=
 =?us-ascii?Q?OB4QghgsruZTeqK7xBT5GTE5j30zJIrSnBReSyjScg5sTEqC8WUrFFmq9nQ8?=
 =?us-ascii?Q?4mcH/E43onsMsi4Z6sLJ+ASDd1crWImESh+/P7MG1PA40T4mdrWiu9GVAzGh?=
 =?us-ascii?Q?dHMjd8QynIEO3yXahW54znL72Ne3NLBtMJ+WEmS/393AOAOegRt799wxu3IQ?=
 =?us-ascii?Q?3YZQ51Yx65hIi9SjPbh7sZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41032146-8173-4213-a599-08daf835b8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:51:24.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SL8KYzX2RwdrduhNZ4Qr/Y90ZEc+C+ROpTR1zWQS8LbXTbrlvsXm/vz2gl1paufGQuj7pFf881p3rruG6V7Nvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, January 16, 2023 12:49
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-
> kernel@vger.kernel.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Xaver Hugl
> <xaver.hugl@gmail.com>; linux-input@vger.kernel.org
> Subject: [PATCH] Input: i8042: Disable wake from keyboard by default on s=
everal
> AMD systems
>=20
> By default when the system is configured for suspend to idle by default
> the keyboard is set up as a wake source.  This matches the behavior that
> Windows uses for Modern Standby as well.
>=20
> It has been reported that a variety of AMD based designs there are
> spurious wakeups are happening where two IRQ sources are active.
>=20
> ```
> PM: Triggering wakeup from IRQ 9
> PM: Triggering wakeup from IRQ 1
> ```
>=20
> In these designs IRQ 9 is the ACPI SCI and IRQ 1 is the PS/2 keyboard.
> An example way to trigger this is to suspend the system and then unplug
> the AC adapter.  The SOC will be in a hardware sleep state and plugging
> in the AC adapter returns control to the kernel's s2idle loop.
>=20
> Normally if just IRQ 9 was active the s2idle loop would advance any EC
> transactions and no other IRQ being active would cause the s2idle loop
> to put the SOC back into hardware sleep state.
>=20
> When this bug occurred IRQ 1 is also active even if no keyboard activity
> occurred. This causes the s2idle loop to break and the system to wake.
>=20
> This is a platform firmware bug triggering IRQ1 without keyboard activity=
.
> This occurs in Windows as well, but Windows will enter "SW DRIPS" and
> then with no activity enters back into "HW DRIPS" (hardware sleep state).
>=20
> This issue affects Renoir, Lucienne, Cezanne, and Barcelo based platforms
> that use LPC EC. It does not happen on newer systems such as Mendocino or
> Rembrandt.
>=20
> It's been fixed in newer platform firmware, but determining whether the
> system vendor uses an LPC EC and has deployed the fix is not possible.
>=20
> To avoid triggering the bug check the CPU model and adjust the policy for
> s2idle wakeup from keyboard on these systems to be disabled by default.
>=20
> Users who know that their firmware is fixed and want to use wakeup from
> keyboard can manually enable wakeup from sysfs by modifying
> `/sys/bus/serio/devices/serio0/power/wakeup`.
>=20
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Tested-by: Xaver Hugl <xaver.hugl@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115#note_1724008
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Hi,

Please disregard this patch.  In thinking about it more, I don't want to pu=
t the
workaround directly in i8042.  I am working with Xaver to test deploying th=
e
workaround in platform/x86/amd/pmc.c instead so that we can ensure it only
runs on the firmware versions known to have the flaw and will post a new
patch when we have it working.

Thanks,

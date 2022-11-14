Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A76288E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiKNTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:06:47 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219E60F9;
        Mon, 14 Nov 2022 11:06:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZadDSnrnZcYIJvk/eNk8YPB29JE2Nq4wodC4meU4FYVNydvMzS1fXo5OmwjB223W10SOAcPP4ECV8HLZJmqnhyE1Ye/R0pbE2kT7onqNOyfueYW3E4qEoZYOtkh9a4uT1VKAOFOkGjy1ls39VbdHoPpzQsGn5+eFLjewZCjs04OydzmoCCxvup2mLD+8xziO1kKu7TjGWNJIaQIf0UCA+9WcTv+gI3U3XJ7lpYa/3ySzl1eDR8bqJZtBr1WRdtVLgPQZ3XeGJ7Bx6SRHG6oUigvNnUKYuKTJrc5ZhkSvpSuf0re3kCVUkEw9C+5y/DqCA2kR1dFHfH3Ttjr5vfDIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WOtBWIm3pQK/tP/1jjvSAjflR9M09ldfyqPpJIjlFE=;
 b=a6u0kRES7CJRh+puqqmrT1rB5LFqkoGiorQ0uBhbqxPRgeNshwc4F+4Jef9f/Lk5wVx/j0mq8+6fl97H+vwlfZ16KPK4aPwe6Xq+WP8pq9Rx+gQUM0kxnMzPnNiNPjFvysbCKucS7khKo9SY1G89M4Zm3AF9z2q/zPqS9x+J+WtOZh/W2BqSw/zYN7/lnm8VkvW1kcsQN5u99pXWG1CPRpzTnI7900nmnhCZnkvRuhZfOmL797rRLIi4Y0K5CZodranENe8XZtcd5VozKkwa8ft7553yL+7J9ass/XrIMlF+Gi0h2r2uCBEVyJ87p4swmjqVzEru3H51zGeeNNnHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WOtBWIm3pQK/tP/1jjvSAjflR9M09ldfyqPpJIjlFE=;
 b=lSCtZdBmouFT/HKSovt/tk6/KH//McLZFRnrJuV+rc6ffD13fCgp84ixZkNsotVaUex79eXY+UsXhI2X2z6vrGOyCqlL0Cr+aYrGakKyZ8ZTi/vMY+pNwmMIAY/uu7YdTi1RjhRHQILU8VCuKMkttPYF5cZJtMHvfjfqdC5Mb6s=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:06:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 19:06:42 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sven van Ashbrook <svenva@chromium.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
Subject: RE: [RFC v2 3/3] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Topic: [RFC v2 3/3] platform/x86/intel/pmc: core: Report duration of
 time in HW sleep state
Thread-Index: AQHY9NCbic/3i/An1U+4vQ36413J9q49ja2AgAFAqTA=
Date:   Mon, 14 Nov 2022 19:06:42 +0000
Message-ID: <MN0PR12MB6101B9889A1C2ED2CEBBF380E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-4-mario.limonciello@amd.com> <87y1ses90k.ffs@tglx>
In-Reply-To: <87y1ses90k.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-14T19:04:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c654afcd-4efb-4e1c-9dbb-1fe6cbe2cc34;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-14T19:06:41Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2fc85273-f2ce-4a96-8eb6-8c0d3b212204
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4105:EE_
x-ms-office365-filtering-correlation-id: afaa4492-d252-4467-957b-08dac6735ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MA1TgUl+sBAh76dxtHi35DUBa4amiEJ6cWCsDuFMtLUUzzGq3/pK0hbAkroWpvHw3u/3WVAuooBkffu/tWhWQSWs5MsQ2QxXSu2BAdIaCvbmwNh1OK4HiQ0ontqGsNBDBKZqPCs1O5LaZbwUAYhYDchpZI+YGC1IHyPzCjdCiR1un607Ie7b4fhihoOJG3MCP9yoZH3oVWiDXyW2kjfiKL5B++NIE1dbYF0tjo/16VJMShFhqFHGP06H0SHgSp2/ZlmpbwzWzA1gooNBxoArDzIFhkEcZkxPWkk3qewCemjPnEKSKpYWRaFBsLLNTylwIi5bp/pjfz+9ia6CaoDsHXDjloDlkY63C7rkhOIike96k4oOfIRyvL5JvzACN+2i2q2DLcgQGFIU1qm6W60W6lIIlQ4w7o3N2LqFbpUtYsqNxwphEquBi6jHK3q+Tci1UdOsVQSSnqOnLhkWp8RdHQMX77c2+RwopJnMhWtMqzwZ0Po12G1NwBtozguikFsp8rCfyn7mhuMA2RAPgGArQulwDOToxYy8ahdAAp5CpnRhxZShV7NXY4nqAIJot4PircHFNyfvJP9z0cjGmLhRJnfHzoTjcLtk4enE/N9+P9EKQpxrHAKKFAdEX3R9DgOeql3kLVcWfhyiWZhDHR353a8xMDyQpMcFOd67RDxO8YedbnyHUueX4EN8DqWa6rdtQOyNS4s+esJa2VDHk/tWCKqXKrV9U49eCXgLU59xqxm536JT+fRp+E4hbxjwcu48GYtU7/1IzLbJOlHN+SFW8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(26005)(122000001)(110136005)(9686003)(71200400001)(54906003)(66446008)(33656002)(316002)(64756008)(66476007)(76116006)(66556008)(66946007)(2906002)(55016003)(4326008)(186003)(8676002)(86362001)(52536014)(5660300002)(83380400001)(7416002)(6506007)(478600001)(38070700005)(53546011)(41300700001)(7696005)(4744005)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V+9sW8ialJZW8/4vwaw2AnbZpeY5alunJ15n+8psh8XS1HaUWIs0sNL95mnA?=
 =?us-ascii?Q?cigYWlIprv5i9yjEWln7/VLP3XhdWNVCI9tqdqvCfGPwCG4t/hXN+22wz97s?=
 =?us-ascii?Q?jWslDFGXDrcaMr4rIEBFCUeopp/9I8m1UzXAQ16I/nV8PJiMZoEfXU+LgkOc?=
 =?us-ascii?Q?vTD2WTKPbR2wrae0ugG8pHbp7uiyo/dCT0niDzdZXUQEw9ylygSIHLxcXiQW?=
 =?us-ascii?Q?kv/hoTLOeU8g7EV1lvfckc/GFp3JMu/llr+3CcuvGYISZDj6dEulEKLfJC3/?=
 =?us-ascii?Q?vNfy0n0FC56W4WuRotgXzj1VPxnSxVnn2LuFZjHUxZtpOx8A2lqTk+aUIGvv?=
 =?us-ascii?Q?mvu7EJkq+e3Lk7V9XESpdNVThjf6KBbKHzQy4kHG5Jkn+UwrSMTueE8dUu3t?=
 =?us-ascii?Q?dO73gv7qcEFwPsX3fPDryMAjmYGK0MBJzv/pALBOyTKiTdCeeNs8QisU0xfs?=
 =?us-ascii?Q?kCuoD+0T6rF/cgKU5+jCkwKDgCBFyNE/NG5Hcz1rLCAFjSXSZzzAPhgLsR+z?=
 =?us-ascii?Q?ynLyM8kwpwp8Pzz5l6vXPucrQPFvh7W/MNVCJQBxwd+8pexIlYwZOEsK84/r?=
 =?us-ascii?Q?BGZsj9GRo8TYwwud6sZQ8a3tyJHp4/xK8BuKtaypVTh+4BSUeKMvt+CwaDb6?=
 =?us-ascii?Q?7xX+oukASxAsZDqhZ2CVebFShbJ0qRiGi0rTJAngs8KXCI9cFkInFlaloMu6?=
 =?us-ascii?Q?vk8UQLsY1mzE5Gwk78E7NcFnpPDHM2TyBQm3c1ZKmDaF5yJVFOFKDVqygbU2?=
 =?us-ascii?Q?FTBKwOevIaLovt2x62FzzQ4Cz63lpUkZADGhiU2Iv9s8eV/vLdbPIIpyOw9P?=
 =?us-ascii?Q?08QMn2F9LTTuaQy1vvEKgpIWv8X7P5eFbKgpV+TosJ9hkS7ihsw7fIafUw5X?=
 =?us-ascii?Q?ejDPsFfxrV9Xs8zK3iQOhERUXgxrbqQEl1pBCYug4CfPljlM3HxpXPeaIfzr?=
 =?us-ascii?Q?I61hVOIJylzshP5zj/Q+5q9DiPOhuT8DCJ0EgqDftIGIx/bnzWq0aP0FXTWr?=
 =?us-ascii?Q?ls8nYM0dcbkyHde4yzGpqeQlXZYck+zK2RPRRS0/sB4zgeCsUuE2jkGjLvvr?=
 =?us-ascii?Q?TVr1R9DmqsEvdF0q8vYmW0wm6iAaV92Rk6nYoGycqmIxO6hHSqYZiIt9ZtsU?=
 =?us-ascii?Q?dU3JjicL1PyJkdSHKsTTOUD+t6TkurVBra1ATQIC4tnFb8C0nt+BfNXpupZ4?=
 =?us-ascii?Q?cj/XqgLWpayq5FU2u6fY1vQc9hd2lBEI4wGYewdVKEA0AlVSPwnIEt35pPUN?=
 =?us-ascii?Q?PmQUAPHqnW9IuG4cCCwUTac4mZIXdR9OmufuaFJwFq+Cvah44dlNOVC807M3?=
 =?us-ascii?Q?5WFOjMRtjoPeXHLkg0ha8sIZAR6zF1Tt99HBijyxsgg3iKshmpzMrzW1I9TZ?=
 =?us-ascii?Q?xP2n8MUNxg1ZA6nbG75uC3SqzZ1xkOxc19dSzVZAkkIw//HQk6OlkfGqEGFP?=
 =?us-ascii?Q?wzBug64B7J9GXGPYsg6aSBBXj67StOCHlIvLLnLyNqTv7vveORys/N+W5oFy?=
 =?us-ascii?Q?oTYyFMpsqGtfauBKOxmcFfaGGrWFO9NRj4SH0FRQN3EAxsDb+EBwcZwhgdEm?=
 =?us-ascii?Q?6yKrL4MBGONj3aDhM+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa4492-d252-4467-957b-08dac6735ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:06:42.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDTLEMVFukl3pZUqVfCUDh074lDr8BUIZEhln4vr/eQSktpNsfHZM4wBjatKwHwXa1KVP7yjgUJVjQiOAClHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Sunday, November 13, 2022 17:57
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Sven van Ashbrook
> <svenva@chromium.org>; Rafael J Wysocki <rafael@kernel.org>; linux-
> pm@vger.kernel.org; platform-driver-x86@vger.kernel.org; Rajneesh
> Bhardwaj <irenic.rajneesh@gmail.com>; David E Box
> <david.e.box@intel.com>
> Cc: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>;
> rrangel@chromium.org; Rajat Jain <rajatja@google.com>; Hans de Goede
> <hdegoede@redhat.com>; linux-kernel@vger.kernel.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Mark Gross <markgross@kernel.org>
> Subject: Re: [RFC v2 3/3] platform/x86/intel/pmc: core: Report duration o=
f
> time in HW sleep state
>=20
> On Thu, Nov 10 2022 at 00:47, Mario Limonciello wrote:
> > intel_pmc_core displays a warning when a suspend didn't get to a HW
> > sleep state.
>=20
> Where? Copy and paste is wonderful...

In current mainline, drivers/platform/x86/intel/pmc/core.c line 2130 will
show such a warning.

"CPU did not enter SLP_S0!!! (S0ix cnt=3D%llu)"

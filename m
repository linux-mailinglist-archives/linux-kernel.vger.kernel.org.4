Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04856722C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjFEQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjFEQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:07:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610A3B7;
        Mon,  5 Jun 2023 09:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2zb+n1L5WFwlQ8T6pnmxn21FUAV6XjFWwIN2JMatQsLEqVIqdTxvLpLJQ9WjaXdB8UABPKPnwTQi6HFzi7vZ09/dEZqSSCidfKc52APayTnWz8kPKW/PFmZNgLIveR9Lo0FnzS3TCRfbJm5BbGiodFkeJ3uApNqnz/D/zuX1IntsX+z+D+BUabbEvvKMb4Q0+78QYyBbGN3XU2gOoBHkpxQv7Mh0ArmzhL0Z6rJuc9zNU4fbdW0EXIXkNhEGEIMjQkNaouXTWS1gx7tvPmfWho+D8A325JP0L5dtBmpDQrOUKXBnc1A81VpF4QvuhOHw96HAvge649j+o2rV5CXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGCYkFJX9TGWlcMPZEBgP67u4k53RLi7tr9V/TuNiqQ=;
 b=Oj8/Z6ZQBC/DnZi8jAGlT9HPzkb2R108qO/SNIvJaPWf/19JuN6kIUiyxchEp37EQ5wnUgaAbtcaDiQ29JmSeJAblB/iewNdM1li9ibe1bFuh54e0eXPExwhop9h5dKnWizMAHDCRGjDSq+6YuvcjqfX0rgjY8jaqOQRc26oD0PX4T/rcwcNX5GmjF9j4pecEYjtySR1eDi1o07q5PIP4ZbmGy++l6tZYMGnuJc1fzv7ianQ1Ph2RnrffezWcP8RpZDbBsEhXAhtq0wn2T6CvoA1519x8NXd7D4WgXc5IEIv2oge0S6KGXe4Qg5gYe7LTOYWlOb7jh0546IFs8od/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGCYkFJX9TGWlcMPZEBgP67u4k53RLi7tr9V/TuNiqQ=;
 b=jsDpaDDGOYbd2AZoRU5Psf/Pss00jHcBHsxcUi4n1stHIdWEjYmkhFof3ICtnCnzdt1TxhUCzn4f3he7xMYO1AASsQduQ8Pty+RNNePavUp4lff4IhJpfQsKMBREZSju1NnnRbF/GA8vb+tSxOsCRo51g3b/dAxakVt/uaQ1tKY=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 16:07:27 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::6239:f594:96fd:2af3]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::6239:f594:96fd:2af3%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 16:07:27 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH 0/4] Enable amd-pstate active mode by default
Thread-Topic: [PATCH 0/4] Enable amd-pstate active mode by default
Thread-Index: AQHZl8AYgGk+ncCZWUSMrNFXSaXP9K98XhLw
Date:   Mon, 5 Jun 2023 16:07:27 +0000
Message-ID: <CYYPR12MB8655C41A0DE7938EBF44DFCF9C4DA@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230605151133.2615-1-mario.limonciello@amd.com>
In-Reply-To: <20230605151133.2615-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=51047bad-fa66-471a-832f-e0183515fd3d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-05T16:00:02Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW5PR12MB5649:EE_
x-ms-office365-filtering-correlation-id: 55935776-486d-4687-fe11-08db65def52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDWbFE9vOtpHefz2EOzvm0ll5g8jamStv6RaFJLYOnZjl/A2YDVLlgsweX512GYC5C2dAcw2sUFojSZly2OJ+vD1Ury58roOBf9sXb68qg21R5czMHIIBUj5y6m13ghUoiCgmQAwOZGCnIVzE7jcxHz7Ob78f2YbedKxuAZ3JM+4+uT/jevHu1RTqioVEAfSQ5ZVpDxCAnqmu6JZ+kiY0fJBU2bWeJE68Nz32LAqaLjU5lAFZOxYlCOcMtQrD53FDUlur0fq8I95wTQ1QmWpnfhC6djkcZ0szKBNeglsgmNaix8fr8BJ9hgjzun0jnkO+zFvSQeIEEoGJQDqusR67c2ewzDgHsElNDUMArA7j5iOJbIoS5kSvbQ54zSIpHW0l11qirF0ExDsR7SCdc2v0cAmEevTPZBdofV/3OpmP6Bmfw04nOYDMB4rMzEC28lehLpRLxi6LCgeWc28EJyvAxlczgsEV4B+E/sC09DGdYs1TW4xqqva6fxjFRVnachTtVEM2SwPe7Ms65+D/LqMGHKtQL9rGkvUQ9uDv5pVwT7xFdyg2DDGDJRPjh/vBM3wJ22VcmswWrO4V6UgBLIqXtIDWzu72irRIqBGz1C1OuSN5xJhQPMyU5734f9Om4wo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(54906003)(110136005)(71200400001)(478600001)(52536014)(5660300002)(8936002)(8676002)(38070700005)(2906002)(33656002)(86362001)(4326008)(122000001)(64756008)(66446008)(66476007)(66556008)(76116006)(316002)(66946007)(55016003)(38100700002)(41300700001)(53546011)(9686003)(6506007)(26005)(186003)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e0fe2IJyDRiGr8bK+ntBQDvg2UnB/RVz+BmFmKF/kJsvedhLFHz5CR9LaSze?=
 =?us-ascii?Q?AB4DSUJ+8kxrlKJHh3vlebGfBmwzREhc+KzMlN/2GfV5LPuNuetk2fOAH7fA?=
 =?us-ascii?Q?/N5fb9J63fjCa2uAYwir2i6KeRQRPBXMgrBYbmHY29MZV+mscPi8cTqve/9Y?=
 =?us-ascii?Q?MiaWX3yemo6LqiZZ7dnhV/OSbL588fBSb67p7nIOL2XsKumJnovysLPUoLig?=
 =?us-ascii?Q?5BJ/bnWN6TbijroOY+J0ntoqmA+TuyXqwCmNTXvH//BL35DxunmUQkyapxXJ?=
 =?us-ascii?Q?C5c/anieN5FxkmEWNEBagzIBzWyqn37g62atdocDoKDcPWei0wR1vzGkfInQ?=
 =?us-ascii?Q?PKeGPRKRvTsTHmCUXHbNRe0V4wM8FddbIL7ywHXa6dsvTL5gEqpLv9T8AYam?=
 =?us-ascii?Q?ljVajdQAFKLA1lH5I3F7hecOdthBo3V11MqBJlXKPoafIWt1sMJhieB07yrx?=
 =?us-ascii?Q?Wuqh7qpIVubDu6l1S8uRpwBM+6h5+IjX/xwTuJxsFc+rsNSVheZA+ZRfOA+U?=
 =?us-ascii?Q?L5MWLjkjls4oUjE+E2xftYsqdmLMcWFs6uq+Duns9IW9hyoZ+atzcaTUPTm2?=
 =?us-ascii?Q?F492fOvztY+e7uDDee34e4BEblwvQA3B4kWWNAbf77p0XLSOELD2t2jMQHcr?=
 =?us-ascii?Q?ysMBg1iFNd+LXz8/CY0bqwhGuMwae5URiFh662Ympx755WoXxZyNPh8aihfF?=
 =?us-ascii?Q?iR3UAjA98nwDFEHNyGab3vLc3yjAfSqWTxq7HJRgc733AHLgYmt3H+APbNln?=
 =?us-ascii?Q?/s95y38dkVNh6CF/RqqsIwvdq2krEH4Gc6niWlUvg/sQY/lvVVfFNDcxelNq?=
 =?us-ascii?Q?8WQ+11KQ2t85cUECmqKsfL4aj0shza7krPYILDQkQZkJNOcpA5ai1FfaaC6e?=
 =?us-ascii?Q?r+tnpH8VrdUM2P6nRuHEpWrwCrrJN1qsgmQ+eTnh6TYUVio0zPVdS+DrsbBq?=
 =?us-ascii?Q?y0AVI6Wp9GyiVhUkSWHX51GyiwdhvGMItQ390fZgHc59QY75JLSBkCEWdeCS?=
 =?us-ascii?Q?o3mLuBXaegvQnpwGxyhpLvxtQj0uOF891JoQ3NincBhtENTYtTMk8tGnHtva?=
 =?us-ascii?Q?H/Ei7bxlWKTfM19UJ2WaH3sOfLypU9PMZSkJBjNkOVLsK0XsczXowxtwYZ4s?=
 =?us-ascii?Q?2vk3CvWXnuax4qt1TbWD2t1EOLvmQ27DmfrNz8nSpsLZqQ6yABbjf4VSzBNj?=
 =?us-ascii?Q?Wzk6An2axcOq8rLvoJrEaSn3P8ac8Vxt8/KY6wy190KmTvfn9zC7hPP8lt8r?=
 =?us-ascii?Q?/5ynSVNlN/MZqJzOD5uFCS6akCQfW5dDHZEtkuGDUUpZoi0MoR9M9sAdEJ4X?=
 =?us-ascii?Q?/fzwXno2odwRIM/94zUAndtWfYwvnOTnJw4yxTDsmqUu46tYo7luGUSY3zmg?=
 =?us-ascii?Q?TDZgEBwC7vv2rDMbrN3IrPpjStPy2H0lIqls7yn08TUnsyoqQkuoJ1lWRxxA?=
 =?us-ascii?Q?DZA8OzzIgK/XXdfJdUkpqz0u6Fn22hIYTTjr2bpMqlmXK+UpipfEIQuMJNFQ?=
 =?us-ascii?Q?Zlmtxfrh9NzPfpU/CGjkvQBjdPTZ00BG41CAeuK+izIX7fIRD9lHethlfohS?=
 =?us-ascii?Q?/qzrWOzTBob39avm2BU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55935776-486d-4687-fe11-08db65def52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 16:07:27.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbncZ8sMdJ0ysB6dr+epkuzhsNvd5tOJyRIIcOfzZDxYE3Tu6QLEK1hodqTjz4CBnJaEO+qG6LW7MFa51me9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Mario, Raphael,

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, June 5, 2023 11:11 PM
> To: Huang, Ray <Ray.Huang@amd.com>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J . Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> Viresh Kumar <viresh.kumar@linaro.org>; Robert Moore
> <robert.moore@intel.com>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pm@vger.kernel.org; devel@acpica.org; Sheno=
y,
> Gautham Ranjal <gautham.shenoy@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 0/4] Enable amd-pstate active mode by default
>
> Active mode for amd-pstate has shown enough success now that it makes
> sense to enable it by default on client systems.
>
> This series introduces a new kernel configuration option to set the defau=
lt
> policy for amd-pstate modes for a kernel.
>
> Server systems will by identified by the PM preferred profile and still b=
e set as
> disabled by default for now.
>
> Mario Limonciello (4):
>   ACPI: CPPC: Add a symbol to check if the preferred profile is a server
>   cpufreq: amd-pstate: Set a fallback policy based on preferred_profile
>   cpufreq: amd-pstate: Add a kernel config option to set default mode
>   cpufreq: intel_pstate: Use the acpi_pm_profile_server() symbol
>
>  drivers/acpi/cppc_acpi.c       | 34 +++++++++++++++
>  drivers/cpufreq/Kconfig.x86    | 17 ++++++++
>  drivers/cpufreq/amd-pstate.c   | 80 ++++++++++++++++++++++------------
>  drivers/cpufreq/intel_pstate.c | 17 +-------
>  include/acpi/actbl.h           |  3 +-
>  include/acpi/processor.h       | 10 +++++
>  include/linux/amd-pstate.h     |  4 +-
>  7 files changed, 121 insertions(+), 44 deletions(-)
>
> --
> 2.34.1

The series is tested with commit 7736c431466abb54a2679dc257f739fddfa84295 (=
linux-pm/bleeding-edge)

Default option will enable EPP mode without any parameters added to kernel =
command line,
If user adds "amd_pstate=3Dpassive" to kernel command line, they still can =
choose other modes to use.

Based the testing result.
Tested-by: Yuan Perry <Perry.Yuan@amd.com>

Perry.


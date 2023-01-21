Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4C6763F5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAUFOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAUFOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:14:36 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB82D78;
        Fri, 20 Jan 2023 21:13:58 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L4k6RY016811;
        Fri, 20 Jan 2023 21:13:38 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3n89abr37c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 21:13:38 -0800
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30L50BpL011462;
        Fri, 20 Jan 2023 21:13:37 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3n89abr379-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 21:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD2rlq1HbgAI88EfrFHFGf5MBQqDqidyDP6jGJF+ILq878yYQ5ZhdKBlaPm/2leoaeXUYntxEmefYNG7mk1XMkAb7ApWHPJquUTGMfEPdxwkx/OJ3Or9MGDCVdikLdDrT/7QecFYyN7b3LLReMBlT6VvVV5PJMrSeUIHdnT5OZXw0uKMfuDXCZxCiLOj1/rfj3rW63XyMh3jZjTOH4Q+Le6o6+k5267RjoGAes/5Ik8BZogltLhFDPZghCDez0Zl/IczEimX4oOW/EfCI91lwiMI1PQguyB0Wali3QF7EiJ0Deg6lqjvCao+3zexVuOEwwTtdabzHExmTWpfMIllVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vnMQY0I3QaFLVDgLdi6SoQ3kSeJAgReL3tZlBED87E=;
 b=II2Xd8FSImDdbG2KNfNGvSqUanX1mi9y52xG0zyrl+NAfCsc+amvX1Y8LtYAebQLbm1ehf2KOuw7Xvn5EoJyX9ESR8TiHlzLS59iWIqkZkl9wW0l/Lmw9jGhVwK8DGY202CY7m6AGchVCiUV28VW4mlQ23ixDTNbD2dJ7zZsx+FbQ/iixpkZww+IBawI8SOkXAarogl0mNCwfMBLIRGUHlZ5Obr9P0U4+3juyhQTjmJuEWeorB7vUNiqOiNUlElSWQplV+n/1I+6+zghcXK5EPlr7kFByDa16l2M730Nwn0ZHuh0XLADEwFw/iFOC8jRhRcpa6CssWFX8UAcAWlNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vnMQY0I3QaFLVDgLdi6SoQ3kSeJAgReL3tZlBED87E=;
 b=aJaQOJmWUDVKR8j8BCZtkYEYEHpWQ2OApzhQAkSAuedd73aR1ZQN67wd+mujIP7JJdukv0SWf3GBd67ZSGWe8hosI8X4iSshg02jCJcAOwPSQ6DxUpY9X39H65pSBNfM/lt4Z2El37EzdPIYbC63QrnWEBd7IlWUijWOk79inqg=
Received: from PH0PR18MB5017.namprd18.prod.outlook.com (2603:10b6:510:11c::22)
 by PH0PR18MB5018.namprd18.prod.outlook.com (2603:10b6:510:11d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Sat, 21 Jan
 2023 05:13:34 +0000
Received: from PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::bb12:b4df:353b:3d3]) by PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::bb12:b4df:353b:3d3%8]) with mapi id 15.20.6002.025; Sat, 21 Jan 2023
 05:13:34 +0000
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     James Clark <james.clark@arm.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
Subject: Re: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel
 timestamps
Thread-Topic: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel
 timestamps
Thread-Index: AQHZLVccXiBzheVo+0WQseonZLFXyw==
Date:   Sat, 21 Jan 2023 05:13:34 +0000
Message-ID: <PH0PR18MB501742C2DE3261742CA19501D6CA9@PH0PR18MB5017.namprd18.prod.outlook.com>
References: <20230103162042.423694-1-james.clark@arm.com>
 <PH0PR18MB5017223066D8744D12C1F1BAD6FF9@PH0PR18MB5017.namprd18.prod.outlook.com>
 <5acce414-eabb-3d22-4907-da6b64b85a9c@arm.com>
 <b61039b1-1f64-ff1e-8e6a-7d8ada28656c@arm.com>
 <PH0PR18MB50178B52ED081276D2404493D6FD9@PH0PR18MB5017.namprd18.prod.outlook.com>
 <70a94ad3-fe5d-b013-7f6b-dd83d2332e0e@arm.com>
 <5fc1e764-bafc-34e5-5ff9-8b62af99ac10@arm.com>
 <PH0PR18MB501732D8907DC909B2ADECDFD6C59@PH0PR18MB5017.namprd18.prod.outlook.com>
 <Y8rTyzfQaO8S8S/v@kernel.org>
In-Reply-To: <Y8rTyzfQaO8S8S/v@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGFubWF5XGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNTc3Yzc1YjItOTk0YS0xMWVkLTljNWUtM2NlMWEx?=
 =?us-ascii?Q?NGU5MDQ1XGFtZS10ZXN0XDU3N2M3NWI0LTk5NGEtMTFlZC05YzVlLTNjZTFh?=
 =?us-ascii?Q?MTRlOTA0NWJvZHkudHh0IiBzej0iMTA2MSIgdD0iMTMzMTg3NTE2MTAzMjk5?=
 =?us-ascii?Q?NjI0IiBoPSJ1c09VdHZhZWJuNlJSK0lVakVnM0R3RkxPd1U9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFOZ0hBQUFv?=
 =?us-ascii?Q?a3RvWlZ5M1pBWGkzQ0ErNGhjR29lTGNJRDdpRndhZ01BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCb0J3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQTNUekZBQUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVBY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5017:EE_|PH0PR18MB5018:EE_
x-ms-office365-filtering-correlation-id: 848aa5bd-53f3-478b-14ee-08dafb6e3ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlif+DXC4EVhCpAlA3PgJ1/GJJaeKY3qZyUfOK41maxD8mqcidDV3QA9D3j4DA6SADN5DOLL7VybNBgQysVlstWISQUqrU3wFJfu+b+D31VgbruNWRgqZlgPSIGKuHzX0/m+d4XiwrYCJEQo0hi9TNkZK8CYKDN/w/LozBCgjZaQ3T4r7YheGCyU+FSYSPiAg0hKtUr9SeZukj3QSzBDJqce9c54e77Ycj1i141RhSmAr/izC/X1l5b7+AgMIWFmZswd1q2HDtF1/ZR7lF+kfBhBiMXl3S6wfZpk3cbD0CbT3ElyAhTT5D7+joNC4LBSrpRybdFXR82v9ATqhF3Hq8ZYBstNOM4muYbmfdtxWaY80K8KdOWs5/aLFAjL/gwWLLUrLW9nkhB0sg9pIMbfX8of1d4zmB7Mj1EukU7ZnEsQ1qcjyDmTvco5LnwPmUH3fHtZG9tMGK3rUsEx4ma5mAsEVmiw9H2KIhmBCKIcULJIHsXVzV5FTADsKQa10ta7oWzr7c1nw1MtXNcNwuBM4qEzKv6q4/ewyZ0MA9LDsKXuC+jI6skRH9fAxrBY1+0qcOAluYqVwNCWpzHYja6xyKJGqrFicY8L9cg0w57oVZMYeEBwbfJUn2ZBSVFzhtBtbdMrKw9Ny2clCF5F3gfwWUzr6OmBf1LYpIhJeTc32eD/eoqnzuXTzrl2UNBta/QxwTBklagk3/Qn9ADrui3PwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5017.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(33656002)(52536014)(5660300002)(122000001)(8936002)(316002)(478600001)(86362001)(7696005)(6506007)(53546011)(64756008)(2906002)(38070700005)(54906003)(9686003)(83380400001)(66556008)(186003)(26005)(55016003)(76116006)(71200400001)(6916009)(66446008)(4326008)(7416002)(38100700002)(66476007)(4744005)(8676002)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3vyR301OlbOgeMgwVRlbsios+UIaurvhHWxh+Xcq0u4yBLsIoSAsX2OfSZhq?=
 =?us-ascii?Q?8iPNB730x/ZD63/4ze6rilZQpg9a0oI5yp1lGX+lSwKzfNBN5XRd9DjKtbKu?=
 =?us-ascii?Q?5D5cu8EGVCl+g4z1hgU0GeRMpIdgx5u0gPj6uhkCRDRUcNm2P0GqFIMV02Lx?=
 =?us-ascii?Q?BiN/+BbA5nMZJY0V6kvD+NZW36qPBL4Ebt0SBOSk9azb6dIlAzoP3jB1CpL0?=
 =?us-ascii?Q?yQEsqMcLph5G/ieZ7xtkLyItsF8FZov/vgKpjOLC6Jgxk1GdEk03urqBVb9P?=
 =?us-ascii?Q?fQYLM4rGmrjgNwxlkvw8c/NUOZ2imSoatCdA0hevX0jk7Blva5O85J6FVjqz?=
 =?us-ascii?Q?2QmkY8SP7OFHHkDjTx6guuN4iCXnEyznuABgv5mtj4b+k/AaYlH1EvISMdfI?=
 =?us-ascii?Q?/7LaQ2dHnnCJQ7OyQB/ZIJPhy0knDeJpL/3ZroT+daTFAbTZ/mMyuGsJMVF7?=
 =?us-ascii?Q?GalWICtyEgn+oQHQJiXbESU88WeZhlyR+colb/bBe4cobGwgJ9dRFk5t9xoK?=
 =?us-ascii?Q?RTw07pgvFJAyl8aqzkGsWLasV5ytHbMCO8J5LRPRCT6t0UVjLXpbBFREczgT?=
 =?us-ascii?Q?wUTdKMR6BcJpruzUrdJcjLdsofxzdL5k9iqe49GedG+SYGPrFt6TCrdXECPc?=
 =?us-ascii?Q?ZTy7p3IA9+5DUdab8dZM9An8iV9HW7lhNgD407DXHJKprbvdZkPdMRXv+LKt?=
 =?us-ascii?Q?PbpuWbO4qa515zn9h2onQzSKRpb+4ERjsuCOiMYjo5kHc9Qw4DMACqJfMA3X?=
 =?us-ascii?Q?3mbbobxCIbYnzD6rRRSnZHq3xLoQk0FwI35wR2ZId7wIIc0zXYM56S5zdMMj?=
 =?us-ascii?Q?T5t2pgN65yuPtNylMIHq6k/GPizpBeSwmLwYoaOay8b/ib7pH+WjwadqTq1d?=
 =?us-ascii?Q?zGNE4vVrSi5Y+a3ZyvQ62l4DKShXJjJKyzMd/G1Y5pxxMcCLoy3PwnKoNghu?=
 =?us-ascii?Q?6tDIvgNDpPXK8j0XS1ykranlKNC+9PMuigR5eCXBupuS8jG3Vsi6N+Eki3OR?=
 =?us-ascii?Q?x+tn/fP8QmTajt4WpMRY+UcSfo/6veOSRHo24qbPqv0gWRnF2/GgRzvHqEcr?=
 =?us-ascii?Q?0VHyvXn5eL4uLs/mI3xufx0kQQbuUHAgk2YC7o6A5KUGPOiuZx8OugVs2xI6?=
 =?us-ascii?Q?ZqqMzR+Xg6WPX7mZTXTsAcvR1Lpq1CbPOshvK5F3i9CPbPQpJmJ0goo+ZyLx?=
 =?us-ascii?Q?ZTJqq4APxv1kyhyS2bdEJIhHJ+1YeZ6K7jDXN2KhdPW7UMC+gGpPAi3x5kBG?=
 =?us-ascii?Q?1IVtbiA9Elqcxj+MqxoV+5kC0fdqA8d8sUHehu7LE3o9S7jpfCfG8Y/njqPv?=
 =?us-ascii?Q?JIV/ZMtvXW9/ylk5l6Zv3NhsHxAD3F6nKLCB8ea2BazYCa5i704V9dwtojAM?=
 =?us-ascii?Q?OEQdT8ArqhLcx/cgLLIxARProSKQfh7BHOKpTqswEPbjhCDShSbhIiBDbkbl?=
 =?us-ascii?Q?P3L0Vif2Cc6RfDCvefAk4DTFdPWxwx6Nb5R+RmWOZwHN1WsTtVUk7C5LdBmj?=
 =?us-ascii?Q?c6Nz3FB9xjFcH0WE3dC7R03/gWs7VEhvc0AUbsNq2JGMkQmhj5zZVZ1uD7Hi?=
 =?us-ascii?Q?p801NMHtAtUr0GH9EK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5017.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848aa5bd-53f3-478b-14ee-08dafb6e3ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 05:13:34.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6NeQ8OV1hbj8dpE/9869AjYf4fBJt5d5XBjDzVhPZNmIpNZRVv4fHn51Rv7hlFXYmvGnGiHBvXzcFV+RMLXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5018
X-Proofpoint-ORIG-GUID: ik_VANiiHMe9zfFXV2JN5-7jEqr9M5VD
X-Proofpoint-GUID: w6ueDUpXqkyjp7X2_v5NbdAGp1I1OulR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-21_01,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnaldo,

> Em Fri, Jan 20, 2023 at 05:30:30PM +0000, Tanmay Jagdale escreveu:
> > > On 13/01/2023 11:12, James Clark wrote:
> > > > On 12/01/2023 15:33, Tanmay Jagdale wrote:
> > > I've sent v4 and I don't see any issues now with the files that you
> > > sent. There were a couple of different edge cases that I listed in th=
e
> > > last commit message. Let me know if you find any more, otherwise if y=
ou
> > > leave your review or tested-by tag that would be great.
> > I have tested the latest v5 version on our platform with test
> > cases that run with and without filters for kernel/user space.
> > The timestamps look good on all of them.
> >
> > Thanks for the effort !
>=20
> Can I take that as an:
>=20
> Tested-by: Tanmay Jagdale <tanmay@marvell.com>
>=20
> For all the patches in this v5 series?
Yes sure. I tested the patch series on our platform
and able to see the correct timestamps.

Thanks,
Tanmay
>=20
> - Arnaldo

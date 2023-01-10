Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42966465F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjAJQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbjAJQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:42:39 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BD451330;
        Tue, 10 Jan 2023 08:42:38 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AECUPw003867;
        Tue, 10 Jan 2023 08:42:13 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3my94tv6g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 08:42:12 -0800
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AGeUuF025079;
        Tue, 10 Jan 2023 08:42:12 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3my94tv6g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 08:42:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1xyUEfT8o2rTqdfUlM45ryLUrlEmQK4vSRUb5CQAAN21lPhRtom+FvuTswXh5XQRYrjuf+U8dfiEQa60CuuFobsit6sNBSC+mYhNQlqgE1nUjzTMWDcGVWv3VJ443Hu0pl09taUo0qaA2d9SOb4kfCs91kSoQg6AfFGM1YOu012pe/vfvrAr3i8XzwvfaMH21b/3rOnDeY2bfD3bNq0flvWDtiIfqiNMSOrrC4rCCllKlVLJ3gAOPa2IdMPbBE6XmaVxi+x/y7F5czO6Ve13VmP9Jn9JuZ+U1V+8I57EAyj2Er/v0tt0yX5pzmH+gY6jrbhScCcf/dnFV39Kpeywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=updwEM0n9PRpMN+RzsJUXuumwZBcwUCifMnOXtCbzIA=;
 b=mMETtHr+k94FQCqMbQk59tOjxIsSNqJRR+rLWWjNyhf8F4QzbuEYexLcAGSUJ96V0EJ8l9046KrLByE/8vyYV58wZv0oMBLsCWekuUytFGI4YMDLMRj8eMXyMKSMVcqU427q9cuGZ8TEL3LfTf/xAaO9K8g6kWFgp3ha98WupN01zXvtas0nlGfpbkbjpY2/Pqc9ThGMQMP5QgJ5LeGNMF/YX2dnHqNGfuAklOOPPaPrWuwYDOPYsD7AysjlvPIBZz6Sz7LinIXpFgdcdYpakbMl/bYHL8Do5dVr95Pp7blCq83cYAJqmuDTrMkqBbi1VlhZNZzd5OV8YnSil04zeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=updwEM0n9PRpMN+RzsJUXuumwZBcwUCifMnOXtCbzIA=;
 b=TdKv995JXfeGgIJV8BNaFewFF4InKqtfgP/rL0oREof6i2M1xxlNUnyaahSO/xSFDyYiu2ASCVwhS3yHAQRdkIvvS+LQ0J/c0a5lANNAQgNfjakgIMeB+Zk4K4e+vh9VGU8CiI90iPYi1Ui8UfNjtqT43hnmeCEC2eqMkIe3mp4=
Received: from PH0PR18MB5017.namprd18.prod.outlook.com (2603:10b6:510:11c::22)
 by DM6PR18MB3767.namprd18.prod.outlook.com (2603:10b6:5:264::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:42:10 +0000
Received: from PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::bb12:b4df:353b:3d3]) by PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::bb12:b4df:353b:3d3%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:42:09 +0000
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     James Clark <james.clark@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel
 timestamps
Thread-Topic: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel
 timestamps
Thread-Index: AQHZJRJ7K3sYQ5kcXkCnHW1ZV0EOew==
Date:   Tue, 10 Jan 2023 16:42:09 +0000
Message-ID: <PH0PR18MB5017223066D8744D12C1F1BAD6FF9@PH0PR18MB5017.namprd18.prod.outlook.com>
References: <20230103162042.423694-1-james.clark@arm.com>
In-Reply-To: <20230103162042.423694-1-james.clark@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGFubWF5XGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYjcxNGU1ZWEtOTEwNS0xMWVkLTljNTgtNDgyYWUz?=
 =?us-ascii?Q?NWUxOGMyXGFtZS10ZXN0XGI3MTRlNWViLTkxMDUtMTFlZC05YzU4LTQ4MmFl?=
 =?us-ascii?Q?MzVlMThjMmJvZHkudHh0IiBzej0iNTUyMCIgdD0iMTMzMTc4NDI1MjYzMzQ3?=
 =?us-ascii?Q?NTEwIiBoPSJ5OXBuMHJCdDJmSW8veCtrNi9oZ3dlZzBxdG89IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFOZ0hBQUEy?=
 =?us-ascii?Q?VjVGNUVpWFpBYm5kOGF3dUd1QVJ1ZDN4ckM0YTRCRU1BQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQU1BQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: PH0PR18MB5017:EE_|DM6PR18MB3767:EE_
x-ms-office365-filtering-correlation-id: 356afe6a-a3b4-45ac-512f-08daf3299e17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T8cVOjJavIlYogoypg0YOLSvm7YSVpjw3IvToRdfu64Cm5i10ghSCq0SjXflABJeuVceU96hpJ5gOomRtiV008DOW2B2Kz2/mttH1asD8tyNqyuDoRcURjGU5U/UDrS3qqOCPEPg7P3DY8dnz19KI144fObqL8ivOteyy9W5gY3U5F2L7JX8aQsBI1nWrjW6gvy6VSFhOftRZGpB00Kb7CVFJm3aE/ZH8F6DJ3lIQQTYy5Gfn1WgnefhlT+eHwDtFAW2h3PxtR0wsEhW2fXXham/ZGbNx/0znOCLt9rhUKezfcL/T8+hBjrvJyLMzmbkbPCMwV02RwbMonlJCYJtxVXSz4OSGoqNjASBAnn2uyn60W2vv1XvAXVhCd3Bx++yow7von5oVqS3Vqy5gWxrpRA+qAg8kD/+JIKTjxQwVXX5SOtpJ7XL/6SwrlXiqZLjPU4t6JFhFg/HQCfsemC93lU2HpI1kwu4zTl2yB7CFh31/tH+SMxS8708Y+/mYvJ6yNu1YTOhscwTSCsp+yfrreff+jvlFRMoWuMaVTfM8v05ChWJNR7pbwyJwzlmP2tuoa0u2ZeLvud46t7c/LojOKWehCuk+zhvjVFGbxdsDkDW6BnjgmIDyV95d47bNqavyblj+a1u69Sfs14aYokNUkxB5LXOMvXydNL2lyv5BgKjSokvS38U9cItNMq6c4ibPUAVbsojJ/KB+oQaiBYh6s70zk/jaY3H0Qllq8EdcMisXA++WoJMbLk2zLStLi2RCcJLk2wzuVelN2fvvnd9CLXjO+GgiLvM2ydFWhmjXaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5017.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(33656002)(7416002)(316002)(40140700001)(71200400001)(5660300002)(26005)(7696005)(186003)(9686003)(478600001)(966005)(41300700001)(76116006)(66946007)(54906003)(4326008)(66446008)(66556008)(66476007)(110136005)(64756008)(8676002)(52536014)(38070700005)(8936002)(83380400001)(86362001)(55016003)(6506007)(122000001)(38100700002)(2906002)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zNyURLQlpG+Ggeb2i1d64nfwhHP6bLa9neswoIEbMN36qazAkmSp+fXKGw9t?=
 =?us-ascii?Q?9+tTE94L/oIhhl8lyFjVhyYcLYdieHYxfQxgZRgNOt+LclzLZp/R1Fq9l3CG?=
 =?us-ascii?Q?VXy9WXHEpEQIm5WFPB+7YhAj9ShflY9CpkVhuhkSJnwYf5x9b8yWt6h4e0Bt?=
 =?us-ascii?Q?J5vwS5lQEe8kdO+ETxYEuQbXkbTXxzKvac+42iPDZC3ojMXkXwDwKqqcynEU?=
 =?us-ascii?Q?6ZCTJ2PdTtR3ehZ9NxUxLrp/oDGLL5jihUyxnJdcQ7ufEVMlBQjtcCErHOCS?=
 =?us-ascii?Q?cMn2Au4T34CTRMfbsz8UiFJN6zzdRNn3RV4BrDS78UXi+wCBVPAugPCSwjWz?=
 =?us-ascii?Q?2/7IhY7Wk9ChgFgq9bF+70gjbT4VvQdeuRQyaPMvBxjOQ9z37MdLUwpLl2p2?=
 =?us-ascii?Q?K115saIvrW+YoilEwhX9ft6/D8IyoeRSgx103xC9IRGiSOBGi2C6x/mQkiZ6?=
 =?us-ascii?Q?JnlP5qf61OZLlMrHt0OFRCoxHPUuokITk2c++hXSKlHRvmIPT/hX6rQ/gbR2?=
 =?us-ascii?Q?G0sxhPctMNDGHHJ4rS3jSrvMhK6v1anMx1Nt29Bwar2Bq72GjIoqK+QBV4CY?=
 =?us-ascii?Q?eD4AHtyfF5fim95Rtr0mwMkN2PO2qtRXsN/sh8xV8a49pCO23pT1I0MtH5bf?=
 =?us-ascii?Q?Cac8DkwgvZ0wdLrVQvW2pgzzkjyD4GPQAg8pEjRO9W55G25V5g5fGnqzRO3j?=
 =?us-ascii?Q?VM73QibL/Bcn2grBDAlqA9psz6ys3tNdUYW+qYIeERwgWkkVJTF0ViZnb+ln?=
 =?us-ascii?Q?QcZqAkm2YCe6dpMFqjZPtfeN9HLp7P0YvvVc1HJf1In8SPqpJjbsM37zXj4C?=
 =?us-ascii?Q?GhWsqVBRBaJT8AA8S/uDoe5LzTZNphtnFgIuMgKCUOQx01F8SyfvxszqhCMc?=
 =?us-ascii?Q?b1UAF6d71DeTNgEab/pSUEURQ1S4NGoW1hgpq/BRkBwi8Cw63792/YGa1zZG?=
 =?us-ascii?Q?GTAXp5IbZXCIdpZgIoprekrjcNgyrFqOuHKQNw6D4TEC4YAW6GW9UTMYni29?=
 =?us-ascii?Q?KXO0sbiQfPLFkcHN16OWi0mXoUwItPFRA/3ctZ+IvHtzem5KNNfvmn/qpuCV?=
 =?us-ascii?Q?bEfchmOAV87em8cNKM83AY3ctbTJhKSBq1XUZExeBupccOYX+MJMG/wIMWuM?=
 =?us-ascii?Q?XSREXpo9qCcEUGwPCVbdbz7X0QdhOmA7KIyngkM2mJnvtGH1BOEiJJM3vXJd?=
 =?us-ascii?Q?ly/0TcX78juka+dD0X3tlKFdIGt3YWme2Qldz5WOji2qTGoD4axwD3Vry5cr?=
 =?us-ascii?Q?p9y8ZIzk1ULWt9R/aRiwbsYvVl2CUXQ7PzhI0VOeS0u9Mk4KatzgWDfRJK7c?=
 =?us-ascii?Q?Lc3Xf56Yoha3FjCD5MM44VmMW877VNuC1ehYLJ3Rr2OCTsXB4hKWqnCL9Ali?=
 =?us-ascii?Q?MkIYdWTR7uqKuUBfbc/BskkdlSiyd6A1sU8+KC/4jqK7//16Kc3sb5/iERYW?=
 =?us-ascii?Q?mURvgQZnO4yFzEjhvjdFm+S/i0Sfk0sdyBLr4aZzbN1lFakUMZoSnpFzJD+c?=
 =?us-ascii?Q?oi6nxms78NQ02Y5F0gaXYEbeWH+BlxUkJhsRHFhoj6p7Rpj3kowhINNle5bn?=
 =?us-ascii?Q?xJcmsr5fK29TSZTqU4cDADSB/TBzlWf/0pWDuhar?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5017.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356afe6a-a3b4-45ac-512f-08daf3299e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 16:42:09.7414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0km9YssQCEedxIzNSOKlfIesefVcW2GKXYDQlj6bayNHGwrNocbYRlKLfjElf2+OcVWGqExj2DgZmkNLbC36g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3767
X-Proofpoint-ORIG-GUID: MDmLi7B7j52vHvDgLsAFo9pLXEYEAB0o
X-Proofpoint-GUID: r6ZhRFggfIHjY8dOKD--B9HLOtxi5iY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> Changes since v2:
>=20
>   * Remove const to non-const change and copy strings where needed
>     instead.
>   * Use sizeof() instead of PATH_MAX
>   * Append "will not be set accurately." to new error message
>   * Remove unneeded stat() call
>   * Rebase on perf/core
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> Changes since v1:
>=20
>   * Add 3 refactor commits for sysfs reading around pmu.c as suggested
>     by Arnaldo here [1]
>   * The dependency on [2] has now reached mainline so is no longer
>     blocking
>   * Rebase on perf/core
>=20
> [1]: https://lore.kernel.org/all/YnqVqq5QW%2Fb14oPZ@kernel.org/
> [2]: https://lore.kernel.org/all/20220503123537.1003035-1-german.gomez@ar=
m.com/
>=20
> German Gomez (4):
>   perf pmu: Add function to check if a pmu file exists
>   perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
>   perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
>   perf cs_etm: Set the time field in the synthetic samples
>=20
> James Clark (3):
>   perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
>   perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
>   perf: Remove remaining duplication of bus/event_source/devices/...
>=20
>  tools/perf/arch/arm/util/auxtrace.c |   5 +-
>  tools/perf/arch/arm/util/cs-etm.c   |  91 ++++++++++++--
>  tools/perf/arch/x86/util/pmu.c      |  12 +-
>  tools/perf/util/cputopo.c           |   9 +-
>  tools/perf/util/cs-etm-base.c       |  34 ++++--
>  tools/perf/util/cs-etm.c            |  86 ++++++++++++--
>  tools/perf/util/cs-etm.h            |  13 +-
>  tools/perf/util/pmu-hybrid.c        |  27 +----
>  tools/perf/util/pmu.c               | 177 +++++++++++-----------------
>  tools/perf/util/pmu.h               |  10 +-
>  10 files changed, 284 insertions(+), 180 deletions(-)
>=20
>=20
> base-commit: 09e6f9f98370be9a9f8978139e0eb1be87d1125f
I have tested this patch set on our platform and able to see updated
timestamp values in perf script's output.

$ perf record -e cs_etm/cycacc,@tmc_etr0/k -C 9 taskset -c 9 sleep 2
$ perf script --itrace=3Di1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,add=
r,symoff,flags,callindent

At certain points noticed that hardware emits same timestamp packets
but with updated cycle count (CC) values. A small snippet of the log:

Idx:100; ID:12; I_ADDR_S_IS0 : Address, Short, IS0.; Addr=3D0xFFFF8000086A7=
61C ~[0x761C]
Idx:103; ID:12; I_TIMESTAMP : Timestamp.; Updated val =3D 0x2f373e37e02; CC=
=3D0x3d
Idx:107; ID:12; I_ATOM_F2 : Atom format 2.; EN
Idx:108; ID:12; I_TIMESTAMP : Timestamp.; Updated val =3D 0x2f373e37e02; CC=
=3D0x3f
Idx:112; ID:12; I_ATOM_F1 : Atom format 1.; N
Idx:113; ID:12; I_TIMESTAMP : Timestamp.; Updated val =3D 0x2f373e37e02; CC=
=3D0x45
Idx:116; ID:12; I_ATOM_F1 : Atom format 1.; E
Idx:117; ID:12; I_ADDR_S_IS0 : Address, Short, IS0.; Addr=3D0xFFFF8000086B5=
2D4 ~[0x152D4]

Since the source of timestamp is the Generic Timer block and the CPUs
run at higher frequencies, this behaviour could be possible on high
performance ARM cores.

Having consecutive timestamps with same value is resulting in a
slightly jumbled order (in nanosecs) in perf script's time column.
A snippet corresponding to the Coresight trace data mentioned above:
...
perf   965/965   [001]  3182.286629044:            instructions:k:   return=
                               0 ffff8000086a761c coresight_timeout+0xc8
perf   965/965   [001]  3182.286629044:            instructions:k:   return=
                               0 ffff8000086a7620 coresight_timeout+0xcc
perf   965/965   [001]  3182.286629046:            instructions:k:   jmp   =
                               0 ffff8000086a75c8 coresight_timeout+0x74
perf   965/965   [001]  3182.286629046:            instructions:k:   jmp   =
                               0 ffff8000086a75cc coresight_timeout+0x78
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75d0 coresight_timeout+0x7c
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75d4 coresight_timeout+0x80
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75d8 coresight_timeout+0x84
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75dc coresight_timeout+0x88
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75e0 coresight_timeout+0x8c
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75e4 coresight_timeout+0x90
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75e8 coresight_timeout+0x94
perf   965/965   [001]  3182.286629044:            instructions:k:   jcc   =
                               0 ffff8000086a75ec coresight_timeout+0x98

Perf's do_soft_timestamp() logic in cs_etm_decoder.c file is incrementing
the HW timestamp based on instruction count. Since the next timestamp
also has the same value, it could be leading to this jumbled order.

We would like to know if this has been observed on other platforms ?
And what could be a solution in SW for this ?

With Regards,
Tanmay

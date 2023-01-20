Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B84675BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjATRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjATRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:44:57 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AF518D1;
        Fri, 20 Jan 2023 09:44:54 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGIEdh007917;
        Fri, 20 Jan 2023 09:44:28 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3n7s99s9pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 09:44:28 -0800
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30KHWwpK021619;
        Fri, 20 Jan 2023 09:44:28 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3n7s99s9pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 09:44:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1j9kHfIf5+IaZb68KpKJsL6zXfUImpOPfz//Q50vSLALNG/tk0JKAFTHl2H+FGSK0W0AQ8AMVQYzNdi79L9HfAOiroDJZ6ZjR7PD6JtvsjAchLJ1QmoTDvFq3EMw8t6U7+/XVH7n7xCEqVKGbuSRSTrTh7eFGxO/v1eLjpSakBBfWHcWX1WiGxp+XTvmxBQ/8632yVF4p2RrhEkVUId7PqcQnxS64/QBWTx/9lmI54l0OIp7lyO8FO1uYoprDbiB7M0p+319brtVvGmtZP9/a9D1aVLkN3UMVFlUzYUG+VasxcvcxoOl9vzC7D2wAnhdIqui4WRvu+TYcNen9C4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWDIWCPMT5dwdupLOMuVfTM8sBc1YNzA7o3daULYdxM=;
 b=XLpqG5DlTpRL61RLV38gCFPH3cTF3vpZT70BFRo+IQtLSbtFxukPGwBYclxqwknIdpS5cKozBFRu8FERkKX1aFvFvMTsXkWl+f6pVhp9mk/VoizZurd+J5D8xwE3LQwm393880nBNF20kHOf91d6qCH3uV0FMwAkAeH20IwbN61GUiwrFrG/pqiDPGSXEDM3Gk5toysABQs0ZNYGKe54t9wLDkrahFnlYl+l/M55zMAToUcZEdP6pwAVXBdPvIcUIrqpOh4zY8xmxYO97dWQBYqpn78j2zTjOfjXxOjwpTKcv8l1/g4DMWA1rmC3M7g0yeim2xEGXBxq+whO5tpMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWDIWCPMT5dwdupLOMuVfTM8sBc1YNzA7o3daULYdxM=;
 b=IbNQ6FgpgD0RVIa5LlEXh4/AQgPXas52R6iAct9I2b+PQieWJmgM80cer4HRbTbTwUWAn0cRVW7m4FjtX9wRH59Sop7HYIZZP35ofUB2mX5nwjspeUee9UvcfAySyOAwxe9ZwYGQg9fIbHyJdEYblCSmyVNJefGsUmVkD9WZtLo=
Received: from PH0PR18MB5017.namprd18.prod.outlook.com (2603:10b6:510:11c::22)
 by CO1PR18MB4761.namprd18.prod.outlook.com (2603:10b6:303:e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 17:44:25 +0000
Received: from PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::bb12:b4df:353b:3d3]) by PH0PR18MB5017.namprd18.prod.outlook.com
 ([fe80::bb12:b4df:353b:3d3%8]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 17:44:24 +0000
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
Subject: Re: [PATCH v5 0/8] perf cs_etm: Basic support for virtual/kernel
 timestamps
Thread-Topic: [PATCH v5 0/8] perf cs_etm: Basic support for virtual/kernel
 timestamps
Thread-Index: AQHZLPbWmCAToFxcOEGnB59qOKa3yg==
Date:   Fri, 20 Jan 2023 17:44:24 +0000
Message-ID: <PH0PR18MB50177B0B9AA2578C7F95243ED6C59@PH0PR18MB5017.namprd18.prod.outlook.com>
References: <20230120143702.4035046-1-james.clark@arm.com>
In-Reply-To: <20230120143702.4035046-1-james.clark@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcdGFubWF5XGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMTI1MDg0M2QtOThlYS0xMWVkLTljNWUtM2NlMWEx?=
 =?us-ascii?Q?NGU5MDQ1XGFtZS10ZXN0XDEyNTA4NDNmLTk4ZWEtMTFlZC05YzVlLTNjZTFh?=
 =?us-ascii?Q?MTRlOTA0NWJvZHkudHh0IiBzej0iMzM1OCIgdD0iMTMzMTg3MTAyNjI1NzE5?=
 =?us-ascii?Q?MjQwIiBoPSJuUlNHRnRmYkFQd1h1RWVlcjFjSlROaEZLdlU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFOZ0hBQURJ?=
 =?us-ascii?Q?WTZ2VTlpelpBZERoS2RjelVvcjgwT0VwMXpOU2l2d01BQUFBQUFBQUFBQUFB?=
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
x-dg-reftwo: QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVBY3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg==
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5017:EE_|CO1PR18MB4761:EE_
x-ms-office365-filtering-correlation-id: b27a17e1-858a-4060-a5d8-08dafb0df882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H55/aTc+iZY2lXu85nAFvfCx0bLZgBTHPtIDPjJlFhjiLUFOfXNJ4bS8Tiliybskm5+lN141H+rq4ChFfpiAvAwuJkyMlhtNOPT/pIxLYATfvBMETOKzoJpF60ppDU6gwf++2sG9Aj7pcs1ZRDjNykDwYAEfMXBgLr6GAOOBmCr1EpI42WnMP0aLxVyKyjGxLXT/3e7zzxxiUeKVbd+jE5gihegGBP3f4ixznLotSz4exzj/DtPHzGQpPLnP1alRb/Y6XFMB0NIiFmvX23FVOoVDBE5RGwpaNz5fsFtBYNZzXPRX0bOT/GSp4AOIwqWX4sQ3t2pNtPnG53lQoRnyjZ1X3xipkakSllA2Qt0DuOACQXCEdbe+wujNAacYH3DpICJY7+U3q6XogVvJRzgc6M+5yMJmKsGUh11vAXbBaKZLphP6UbWkh++9OXN3kbxNZsx092TGXUdIL0Vn9kdBAsISSQ+VPsNRayJ7laxh3zH6YqtbGQkeMeKd0Zlp871EVLWZm7BMGG9PuR8y1GI5R7iH5zz1BIdnl0RRTADgG4V8Sybnt0+O6qDWa6huf7IY54kZvh9ZrMaTDDjwRtobGga9jowHf2IJUPnk5+Eb9L1bVXOY9E/sMlfvI/cB5jVlKYdOFVNeRqdl/5Z/qwrbbGeP1jyvrvZmYBsvXPGVLh+NGyxG0wc4hM7/nzM5s4zqRWwcDln37NMDN+ZmWH+ICqI7/FhH5xJmjycJh9TahhvH6oJ83wP5nw6f/tJBrgcmlE0d5wfEmke6X0ePnJIheg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5017.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(86362001)(966005)(6506007)(7696005)(478600001)(33656002)(52536014)(122000001)(316002)(5660300002)(8936002)(64756008)(9686003)(66446008)(4326008)(66556008)(8676002)(66476007)(71200400001)(38100700002)(76116006)(7416002)(66946007)(41300700001)(186003)(26005)(38070700005)(83380400001)(55016003)(54906003)(110136005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WQJ1zezNVOcKng1Pjeuq4ELw4jBwOXYR8IClvHv1guIuTTAMOR525rgXCEu4?=
 =?us-ascii?Q?D8vC8DoLESsX1jo0EfvyCZMxwrnW8BJ+68qXC1hIDDrzPd2gvm3cBYeMqsRN?=
 =?us-ascii?Q?IIQaYV/ZWXVCVXEH038jr60eJV0SiVE6x6CWtncVTHrfzZ/pflphqHSqew0W?=
 =?us-ascii?Q?2X7alb6eX2xIz12xoqTR5ygUsswiV4rv0N5BqPb9S/lRUE5/7I3l74WkVmUo?=
 =?us-ascii?Q?cUOFrwu40myqDWLV7Bzo0HeXqZ2Q5rtuVBwRp2G3ikHzBi7H87QSXtVQDU5D?=
 =?us-ascii?Q?Py8H22khrjbySTTaadjBbfGGnb9NHu6OhQtaV245ljKny6xaAWyvF9fZoPwc?=
 =?us-ascii?Q?g4jPji1PwjWsI6R34Ble1SAYLLfH6aIxeuvAPiaNL+iFZ63TWgyhesyYktgy?=
 =?us-ascii?Q?cWzhTQWdTU/RGqNH6X1vPBtl7IzwQndHcCLL0kQeZC6DDveZCrTitWXgbQPy?=
 =?us-ascii?Q?NR2qPS+zEyX4o03evfhUZ6fZoAAla5/DYFuPGf954J8BcidhVhUz9CAkA7/s?=
 =?us-ascii?Q?F0nPo1FLWXEvLbtLp3Sx9s7/aJR9Rxj6rzDppUj1TXM0bamztX26c26j8+aA?=
 =?us-ascii?Q?e7GEPUnpJ5Rulx4tVLKvzUuLUrmg9i/0xrC4JB9NbMTZjME98mN1Stq6c05Q?=
 =?us-ascii?Q?+FahZFPvvUAytL04lco9m8bGvEqYUuRL5V9WQIThOZUvZCQRPTo286unE+3y?=
 =?us-ascii?Q?tySFS+EyJgXiZIkHKqLM2JJfpH1Sh5W1pqz/syblQVAAy51U6ir/452NSUBl?=
 =?us-ascii?Q?BZSYsEzfobi8KUvFTWcyPE/dfRJ3glmemfTaa9xuc3pq9vRbayZJYW3BwCLZ?=
 =?us-ascii?Q?UVqhbZYewybI5FwXvf5GacNH7wg/mUtOeYWs0qCf/p5zG5Mc2Fr9Iuwifneg?=
 =?us-ascii?Q?ZnY5gcEdCuVkarMOVTDPRtaT/VTSJCzvRsopXkwNz3aX2bJpsP+gLSnAQbq9?=
 =?us-ascii?Q?AYl3tFYnY6uSoOD4jmudq1GsUgE44wYjCXoDOMRopxXdSIm1mVvmTSYflvBE?=
 =?us-ascii?Q?5OcPCRwxYtuK2t8CKnKa2NqJL6CUbvJXY8h25/EDAON2vqC3lMxd11sb7SmE?=
 =?us-ascii?Q?5TRVqE9hZrkEWmvwUlcolyfXSGpTOR0nqrk3KT42TXFWn2Oi/aU1LuubuJKW?=
 =?us-ascii?Q?ENjyPXv6H+U57cqR6vj15ZgM+fGtrZYEDYaEwAskC70ZFgn9NueBUTtNAM2+?=
 =?us-ascii?Q?omdCLwD5DhfOi5OdYVPL+WUMoyzJOLbqrJtZQzWBvdstIG7axfDRkb0OG2uO?=
 =?us-ascii?Q?TnC/IxgQwDdrRXnFtrFzrF6/ie6M2X0Udyo+CB6DtepSmKuM/HPedpnkWJmN?=
 =?us-ascii?Q?M/6RKcXOxL9EvFZamiU6r4NI0ZhQm0Azja3Al2ub2zN5W4+cx7PIKVN9AvlE?=
 =?us-ascii?Q?U1diVqiCrCYfMPDE/mvimG6qrzutBmNfVqSskODRUcFWvOmQS+80RlS/Qj2Z?=
 =?us-ascii?Q?UiOTofglFE/l8iOhQEvcVSA5ARNVAbX+hXSGXZDyruP2R7Kuxn+HR+kk6PMH?=
 =?us-ascii?Q?aVUP7W9m8fWRjw2nitLxefqy3p3aZKb9GX80pJzx7Ii5hGBKFT5+1zrjoXSW?=
 =?us-ascii?Q?D6YBccAYazmjp7Ee7kLp+VPSa/cp3kKNBztqrSr9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5017.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27a17e1-858a-4060-a5d8-08dafb0df882
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 17:44:24.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDC+8NEiIgTzoHED90x4rlTYyT3SXAACJMN2Zt4NL70e2as4xLohfRC1emD1vxTKzusvdtFGlrVp6u344SykLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4761
X-Proofpoint-GUID: -Pk4JGEFp4RWbQaYsAClCRoia3VAR5fV
X-Proofpoint-ORIG-GUID: mEit1PhXCH4drx79jRDK3aFzputC_XSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> Changes since v4:
>=20
>   * Rebase onto perf/core
>   * Convert new perf_pmu__cpu_slots_per_cycle() function to use
>     new helper functions
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> Changes since v3:
>=20
>   * Scale time estimates by INSTR_PER_NS, rather than assuming 1
>     instruction =3D 1ns
>   * Add a new commit that fixes some issues around timestamps going
>     backwards
>   * Use nanoseconds inside cs-etm-decoder.c, rather than storing the
>     raw time values and converting when a sample is synthesized. This
>     simplifies some of the code like estimating the first timestamp.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
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
> James Clark (4):
>   perf: Remove duplication around EVENT_SOURCE_DEVICE_PATH
>   perf: Use perf_pmu__open_file() and perf_pmu__scan_file()
>   perf: Remove remaining duplication of bus/event_source/devices/...
>   perf: cs-etm: Ensure that Coresight timestamps don't go backwards
>=20
>  tools/perf/arch/arm/util/auxtrace.c           |   5 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  91 ++++++++-
>  tools/perf/arch/arm64/util/pmu.c              |   4 +-
>  tools/perf/arch/x86/util/pmu.c                |  12 +-
>  tools/perf/util/cputopo.c                     |   9 +-
>  tools/perf/util/cs-etm-base.c                 |  34 +++-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  68 +++++--
>  tools/perf/util/cs-etm.c                      |  95 +++++++++-
>  tools/perf/util/cs-etm.h                      |  16 +-
>  tools/perf/util/pmu-hybrid.c                  |  27 +--
>  tools/perf/util/pmu.c                         | 177 +++++++-----------
>  tools/perf/util/pmu.h                         |  10 +-
>  12 files changed, 351 insertions(+), 197 deletions(-)
>=20
>=20
> base-commit: 1962ab6f6e0b39e4216206205bda14aff87705f3
> prerequisite-patch-id: 9722bf86e3e6d16d177ff9a1411992a795a7dcbd
> prerequisite-patch-id: b05dbef439c2ea8465f3321532257b0ca29f21f9
> prerequisite-patch-id: 92680a4781cbcf010fcb007e6ea030f59e9eaefc
> prerequisite-patch-id: 8e3a73a04e4b89b503377b5fac1d89d551159393
> prerequisite-patch-id: 09980d8fedcdaa70b220a7802428109f48448a58
For the series,

Tested-by: Tanmay Jagdale <tanmay@marvell.com>

Thanks,
Tanmay
> --
> 2.25.1


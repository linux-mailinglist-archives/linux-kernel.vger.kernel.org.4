Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F14713539
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjE0Ox5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjE0Oxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 10:53:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837CE1;
        Sat, 27 May 2023 07:53:53 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34REeQXV001066;
        Sat, 27 May 2023 07:53:30 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3quf7p8n56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 07:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzS6DFKUhn6i+WLW8o1Rz0+hast1guz9X5pFg4BUi/ehQlIC1Z5pozMYS4nHRPx0PfMYqGn48SiUDA43tAU5C+UAMed2sQKD6pWOhO/iC5bYQR6LYrwcenIuJAntDBctOiVqgvPnWGx/nCTCUNgC663i0wBqR77y/kmAr31/1avYMJKcPS3ldQ0TVylo8ClXXl7onp06vB8mOoENy93v+x0zrt1LEg3M42dVT7gR46BEfXcsXl510ML61GYvHNDf5nBA8+S8YKhwAZuBjtHy487v2L6btD8BE7/FaL9VTYiBA5Ar8W81y26UXGn5IgbaOTE4rIG7q6TIyxHxUCDhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZtsWJp+WY9Pii1ASI3WGlejtCoVdUeYGlKsBsB3znM=;
 b=cPXtFWEc5CuKJdGcP0PaugMBPVNudN9RPVa76efEoiDwf4vKSSJuzeysi7kvVbwZqjrNWjSNKWr0zQ3r2bYTXiAaNb03WsU2A6B3pRh1D3JnM+8pRZrVF5NVXn4Ca5ceUQkH02YKGAfYPBzjW+ZQsAYn/YpFyJJrvrAgcd23OqlnAJmpaDrNnWlHr2S6kjXYNP6Hr4d89kldL2h4u5nVMZCMe9XjcbzKqZre9qTiGJFTzoiQmvvvGgW5CwEzzS46pVZFy9ktXE+B1fYmHp13kV4+HUyYg5pAjtTK2YHzokFdq+Dosdp8mzegvytHUMEZhb1106TCDVDBS3SOBgfP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZtsWJp+WY9Pii1ASI3WGlejtCoVdUeYGlKsBsB3znM=;
 b=k9MfkH3t4xvqEVNIHhQjAZDjurzkIlZLw9/C+X3AhlspzRrE8VvcUwIvx1T9Y6+LHKCQzAFsB6oF/Y0mJQOezBEXMYXFDOWpXjkawSJ+p+lsv/Fooh3ejFKR8zSDvXSCgl4zGMzb6m/anTWcxSzSFbWO2DUxG4wCQZXSKt/hiqE=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by BL1PR18MB4247.namprd18.prod.outlook.com (2603:10b6:208:318::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 14:53:26 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c%5]) with mapi id 15.20.6411.021; Sat, 27 May 2023
 14:53:26 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Thread-Topic: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Thread-Index: AQHZj5sOTdsKm/MUPEiPdp8HUff0C69s87YAgAE8q+A=
Date:   Sat, 27 May 2023 14:53:25 +0000
Message-ID: <DM5PR1801MB188350DD9CFDBB3E240AC838E3449@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230526062626.1180-1-bbhushan2@marvell.com>
 <20230526-bondless-slather-5de0a5659353@spud>
In-Reply-To: <20230526-bondless-slather-5de0a5659353@spud>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctMzkyN2IzNjEtZmM5ZS0xMWVkLWFlN2YtMDRi?=
 =?us-ascii?Q?OWUzMzM4ZjZlXGFtZS10ZXN0XDM5MjdiMzYyLWZjOWUtMTFlZC1hZTdmLTA0?=
 =?us-ascii?Q?YjllMzMzOGY2ZWJvZHkudHh0IiBzej0iNDUxOCIgdD0iMTMzMjk2NzI4MDI2?=
 =?us-ascii?Q?NjQ0NDA5IiBoPSJXZW9WUUQ0N3lFVjJvenp0SkVNWS9GSHFxdnM9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFHSVdB?=
 =?us-ascii?Q?QUM1LzcvN3FwRFpBYmc4OXMyMnJMSEh1RHoyemJhc3NjY1pBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQUlRR0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?WkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFj?=
 =?us-ascii?Q?QUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJn?=
 =?us-ascii?Q?QjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFI?=
 =?us-ascii?Q?VUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFB?=
 =?us-ascii?Q?eUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNn?=
 =?us-ascii?Q?QmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFH?=
 =?us-ascii?Q?MEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dC?=
 =?us-ascii?Q?ZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4?=
 =?us-ascii?Q?QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBB?=
 =?us-ascii?Q?WlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6?=
 =?us-ascii?Q?QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0Fa?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FC?=
 =?us-ascii?Q?ZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lB?=
 =?us-ascii?Q?YVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJr?=
 =?us-ascii?Q?QUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQURBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFR?=
 =?us-ascii?Q?QmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFE?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFI?=
 =?us-ascii?Q?TUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdC?=
 =?us-ascii?Q?bEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhR?=
 =?us-ascii?Q?QWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdC?=
 =?us-ascii?Q?dkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0Jr?=
 =?us-ascii?Q?QUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFi?=
 =?us-ascii?Q?Z0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFH?=
 =?us-ascii?Q?d0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFB?=
 =?us-ascii?Q?WHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBB?=
 =?us-ascii?Q?R0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3?=
 =?us-ascii?Q?Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFj?=
 =?us-ascii?Q?d0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndB?=
 =?us-ascii?Q?SElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRB?=
 =?us-ascii?Q?QnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJ?=
 =?us-ascii?Q?QVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFI?=
 =?us-ascii?Q?VUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUNFQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBaEFZQUFBQUFBQUFjQUFBQUFRQUFBQUFBQUFE?=
 =?us-ascii?Q?OFhOeUFuUlFtUW9MNnlDenJYRVlJSEFBQUFB?=
x-dg-reffive: =?us-ascii?Q?RUFBQUFBQUFBQTEwZ2ZjYjFMc2tlUE9yNUh2UEUxcXlvQUFBQUJBQUFBSWdB?=
 =?us-ascii?Q?QUFBQUFBQUJqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdFQWJBQUFBQm9H?=
 =?us-ascii?Q?QUFBWkFBQUFHQUFBQUFBQUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUpBQUFB?=
 =?us-ascii?Q?QUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBWlFCeUFITUFid0J1QUFBQUxn?=
 =?us-ascii?Q?QUFBQUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBYUFCdkFHNEFaUUJ1QUhV?=
 =?us-ascii?Q?QWJRQmlBR1VBY2dBQUFEQUFBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J6?=
 =?us-ascii?Q?QUhNQWJnQmZBR1FBWVFCekFHZ0FYd0IyQURBQU1nQUFBREFBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUdzQVpRQjVBSGNBYndCeUFH?=
 =?us-ascii?Q?UUFjd0FBQUQ0QUFBQUFBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdC?=
 =?us-ascii?Q?ZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0JmQUhZQU1BQXlBQUFB?=
 =?us-ascii?Q?TWdBQUFBQUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3QndB?=
 =?us-ascii?Q?R0VBWXdCbEFGOEFkZ0F3QURJQUFBQStBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3?=
 =?us-ascii?Q?QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdV?=
 =?us-ascii?Q?QVh3QjJBREFBTWdBQUFEWUFBQUFBQUFBQVpBQnNBSEFBWHdCekFHd0FZUUJq?=
 =?us-ascii?Q?QUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFBQUFEZ0FB?=
 =?us-ascii?Q?QUFBQUFBQVpBQnNBSEFBWHdCMEFHVUFZUUJ0QUhNQVh3QnZBRzRBWlFCa0FI?=
 =?us-ascii?Q?SUFhUUIyQUdVQVh3Qm1BR2tBYkFCbEFBQUFKQUFBQUF3QUFBQmxBRzBBWVFC?=
 =?us-ascii?Q?cEFHd0FYd0JoQUdRQVpBQnlBR1VBY3dCekFBQUFXQUFBQUFNQUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxB?=
 =?us-ascii?Q?SE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUJmQUdFQWJB?=
 =?us-ascii?Q?QnZBRzRBWlFBQUFGUUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHRUFiQUJ2QUc0QVpRQUFBRm9BQUFBQUFBQUFi?=
 =?us-ascii?Q?UUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFH?=
 =?us-ascii?Q?MEFaUUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBR2dBWlFC?=
 =?us-ascii?Q?NEFHTUFid0JrQUdVQWN3QUFBQ0FBQUFBQUFB?=
x-dg-refsix: =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUpnQUFBQUFBQUFC?=
 =?us-ascii?Q?dEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0JzQUdVQUFBQTBBQUFB?=
 =?us-ascii?Q?QUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBWXdCdkFHUUFaUUJ6QUFBQVBnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJB?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FHVUFjd0JmQUdR?=
 =?us-ascii?Q?QWFRQmpBSFFBQUFCZUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3?=
 =?us-ascii?Q?QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFa?=
 =?us-ascii?Q?Z0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FB?=
 =?us-ascii?Q?QUFiQUFBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZB?=
 =?us-ascii?Q?R0VBY2dCdEFBQUFjZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZ?=
 =?us-ascii?Q?QWFRQmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJm?=
 =?us-ascii?Q?QUc4QWNnQmZBR2NBYndCdkFHY0FiQUJsQUFBQVdnQUFBQUFBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFH?=
 =?us-ascii?Q?VUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUFBQWFBQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3?=
 =?us-ascii?Q?QnlBRjhBWVFCeUFHMEFBQUFxQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFHa0FiZ0IxQUhNQUFBQWlBQUFBSVFBQUFHMEFZUUJ5?=
 =?us-ascii?Q?QUhZQVpRQnNBR3dBWHdCM0FHOEFjZ0JrQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|BL1PR18MB4247:EE_
x-ms-office365-filtering-correlation-id: b2cef74c-7739-4ab7-b0e5-08db5ec22039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvOfT6lspYbXW6G6k+l61vi/IXETf3b6VOq02PTv4bjfhwDjxtoHEM0pZu6k21qluE0DKh5eHxmsWkRXpSBSPwTNV6WrvD1YMKyznRH0BshI6I9R4OfztLK9XB6Ruozwr5cV1U+4oQFFz9T3DoWMqW3SCprHRjZ3SdSLT1KF33m+RDHUtECgNeGyzlASogWbn5o4Jr/oVjz3zyRvIRdoq+HTcERMWr5lHXZjXhoepNWmq/Y8YIlSBeqbcYF+dRcEVvizKinL1aluFf5zGs+OSJ17pv6MB99OhkKntBRA3aCF50PQLCPOH6+M7YX6S45xg5lQmlJyV5NBagRyEtNTr/EYmGPk1BdmuQbJA0T6/GLO0qi4GgOgWLKqKh8rQXzgalryXFTWJzx4l2GG+dz7nW14DEb7P//J2Vrwy455Va3ZVo1ORUUMjdVbVhufq9NjTqkAaAwz6lCo62/nKcFf8/QJlIp29t2nOhxar8haW6fwbWzdohLUp1TwxxyEuBDxzp3Oo9u+BqPOxJSE9nac1d79jgYdrZqd4/UfM3LrLYB6lJPSFNXZq6203rBvh55D7+tznZKSm7xD9d91n0DcX5kbHcBKrnlKgCeH8+uiS8HJmidXaXILshAWm2Cw8GBIcCtXXjVhP6ue9MO5skE5qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39850400004)(451199021)(38100700002)(52536014)(107886003)(8936002)(33656002)(8676002)(966005)(5660300002)(478600001)(54906003)(55016003)(7696005)(122000001)(71200400001)(316002)(41300700001)(66446008)(64756008)(4326008)(186003)(66946007)(76116006)(66556008)(66476007)(6916009)(86362001)(38070700005)(2906002)(83380400001)(53546011)(9686003)(6506007)(55236004)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nKdCchO+eSab48VOfX4CqkZ/5nMPp4ETLpMxbYSO6Qxqi2iuRpMk2jZHY+2M?=
 =?us-ascii?Q?IGBJRM9lJl/zg5wtCkZq79fnEBXu69WhA0JTkJa+Mu2DUWNjwzhw73Ajz+0/?=
 =?us-ascii?Q?5P9ZFwn/exHkh6Nt3BKnmYHrhQLjn28VEZjxxsa6IQqFtVw9QkXv6K+BEY8D?=
 =?us-ascii?Q?Uk5i56gfa4gq2pFz7klWuGLL9NoupZ92gtXDAADJW+luq6clwI2vETI9H7if?=
 =?us-ascii?Q?5h7OJNifmbpGoxtnQXZhJyMROrxSi5TvHNT6/HnJN4HtNX8hwaNodzkUk8TA?=
 =?us-ascii?Q?x8skoJfp7EtuGovau+3OXtFN5XutvWKrWJoc1WNtYwTogHK/dqmIFB25VZAy?=
 =?us-ascii?Q?SdGOWSlFCtNUVom/vlZiJ1CdPnecPlKyBy3xjTjDR0XkSCpUGvG1arDs6038?=
 =?us-ascii?Q?eVeSWqXBkXIZW04CHcnuzpjbBFM08KGKYWZIfzHf9sFWpUuyjDuts+j6Wcqc?=
 =?us-ascii?Q?OX91ElGCi0TRlgknzQzjzkBnf60ZmJxPmUOU+yOE11nfrD/mxgC+azKROxF2?=
 =?us-ascii?Q?sz7rvgl1bltMxxaF4ZGGEQ+UsemWifV+mhENeJJEIi1BK+iOPuzogPz3Dwd2?=
 =?us-ascii?Q?AFaOtkT9Aic1zyfKDFRuO1kgNkjRhg5PjpQ3571KjrlEhhrJPvXySs1/xZft?=
 =?us-ascii?Q?tKtkv1WJ55TYU1BjAi7NpB/i0JypIfamfHu/pS4IJRuAlARBTK4yGn93xIp8?=
 =?us-ascii?Q?FBLM0UFq3YLrt2BQORJwZ72nfzJQj21x65fTnoyEtX07+dJr8be0aPAwiQVW?=
 =?us-ascii?Q?nYMKJ5FIbjOtOeJQv135Wg8XapxKynT14HOF/qVHM9387L+omjfC8Yp7Lx/D?=
 =?us-ascii?Q?u8Mdt5pYQ8v/vckNNNplKEfrinUzIbaB2BXZsBIu2sUp3qjV7cmibjxahfL9?=
 =?us-ascii?Q?6ZLGBY+Q3r72Qi0hOTyluHbrao3nOt//jyx8MRfox1ft6yp2YbCc6qQ9ETCb?=
 =?us-ascii?Q?mabKM8DAwgtIhnkF5vrwCyZ+rYlfJrPmos00zh0CzJ2c/b1ITBtWhTDX10k0?=
 =?us-ascii?Q?9B55PUnxZnfH/g7b3rHCKnoKUgs19kvTG/2GS0zGfY9rAScosiyqErgS/1OZ?=
 =?us-ascii?Q?aw5qDVY5N9eUWP/VgeTvMT1ji7sWg0TI9n4XYdFnc+hvxTGwGQeVU8b4wfqi?=
 =?us-ascii?Q?eQdbsl5u9d9dMQqOSnIchc3oC16eZz5cRYrgvzvRadqA5vrjmA5tGC2zUwHM?=
 =?us-ascii?Q?Alq+wQj6UY6tLXLYmVJfpNBBtYjioutrq8oG1n+X9rF8oUryv8RGyEEszxTA?=
 =?us-ascii?Q?RPW4LzBwUSyA9vKqOAwx1on5K6grlYRr/jal1TWMDD8uXoumzY9Ug/P3XlWU?=
 =?us-ascii?Q?5sgo8TyaPWU/8hIg9IWQ/eO6iqSCnN3CJLChHJG2g41OgT++SNEB+hCF70W1?=
 =?us-ascii?Q?GFVzValpkBDxshH1p569qXY0tECFotQvWPiqzLBtIBwHBBJcCPFPW+ub4tON?=
 =?us-ascii?Q?Kpz9yyRNOOZrHuwR76SzO46gthQLJulpNIEKDLNjiyKl6ZrZH8PxR+SCHQm0?=
 =?us-ascii?Q?w0Q331AmsE13noGgD3ySKh72YybXkeVlTE+RsiSJZk0t4gsA9F5GpL7lzQfZ?=
 =?us-ascii?Q?Qt4sP7jeIxRwEWP828elr76IjejecfvnnoD2Sc6b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cef74c-7739-4ab7-b0e5-08db5ec22039
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2023 14:53:25.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hR7RYxggBHt0C31DvJzWyoID5CODR7NLvVl+mq1m40/uBeHdrArR9NTSVoQ5gou4USIUyqCxqpuQvOW8PGIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4247
X-Proofpoint-GUID: B2hYBAXsTARIYQ45YNfZk9UFJINNmGA2
X-Proofpoint-ORIG-GUID: B2hYBAXsTARIYQ45YNfZk9UFJINNmGA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_10,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Please see inline=20

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Saturday, May 27, 2023 1:07 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: wim@linux-watchdog.org; linux@roeck-us.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>
> Subject: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI syst=
em
> watchdog driver
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Yo Bharat,
>=20
> On Fri, May 26, 2023 at 11:56:25AM +0530, Bharat Bhushan wrote:
> > Add binding documentation for the Marvell GTI system watchdog driver.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> > v8:
> >   - Compatible name as per soc name
>=20
> I am sorry, but I do not understand this.

I mean to say replaced soc family name from compatible with actual soc name=
s

>=20
> >
> >  .../watchdog/marvell,octeontx2-wdt.yaml       | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yam
> > l
> > b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt.yam
> > l
> > new file mode 100644
> > index 000000000000..3c642359d960
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/marvell,octeontx2-wdt
> > +++ .yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +http://devicetree.org/schemas/watchdog/marvell,octeontx2-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell Global Timer (GTI) system watchdog
> > +
> > +allOf:
> > +  - $ref: watchdog.yaml#
>=20
> From v7:
> Put allOf after maintainers:.

Thanks for pointing, I am sorry, missed almost all comments on v7. Will res=
olve this and below as well in next version

>=20
> > +
> > +maintainers:
> > +  - Bharat Bhushan <bbhushan2@marvell.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - marvell,cn9670-wdt
> > +      - marvell,cn9880-wdt
> > +      - marvell,cnf9535-wdt
> > +      - marvell,cn10624-wdt
> > +      - marvell,cn10308-wdt
> > +      - marvell,cnf10518-wdt
>=20
> static const struct of_device_id gti_wdt_of_match[] =3D {
>        { .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octe=
ontx2},
>        { .compatible =3D "marvell,cn9880-wdt", .data =3D &match_data_octe=
ontx2},
>        { .compatible =3D "marvell,cnf9535-wdt", .data =3D &match_data_oct=
eontx2},
>        { .compatible =3D "marvell,cn10624-wdt", .data =3D &match_data_cn1=
0k},
>        { .compatible =3D "marvell,cn10308-wdt", .data =3D &match_data_cn1=
0k},
>        { .compatible =3D "marvell,cnf10518-wdt", .data =3D &match_data_cn=
10k},
>=20
> This is a fat hint that you should be using fallback compatibles here.
> You even had a fallback setup in your last revision, but you seem to have
> removed it alongside the removal of the wildcards. Why did you do that?

Not sure I understand this comment, Compatible in last version was as below=
:

+ properties:
+ compatible:
+    oneOf:
+      - const: marvell,octeontx2-wdt
+      - items:
+          - enum:
+              - marvell,octeontx2-95xx-wdt
+              - marvell,octeontx2-96xx-wdt
+              - marvell,octeontx2-98xx-wdt
+          - const: marvell,octeontx2-wdt
+      - const: marvell,cn10k-wdt
+      - items:
+          - enum:
+              - marvell,cn10kx-wdt
+              - marvell,cnf10kx-wdt
+          - const: marvell,cn10k-wdt

By fallback do you mean " const: marvell,cn10k-wdt" and " const: marvell,oc=
teontx2-wdt" ? If yes I removed because "octeontx2" and "cn10k" are soc fam=
ily name and no a specific soc.

Thanks
-Bharat

>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
>=20
> From v7:
> maxItems instead. You see it is different than above properties?
>=20
> > +
> > +  clock-names:
> > +    minItems: 1
>=20
> From v7:
> Need to define names.
>=20
> Cheers,
> Conor.

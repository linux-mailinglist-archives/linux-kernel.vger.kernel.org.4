Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8648D74A326
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjGFRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGFRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:35:03 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD081B2;
        Thu,  6 Jul 2023 10:35:02 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366GrRMg030710;
        Thu, 6 Jul 2023 10:34:40 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rn3v96q7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 10:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J423vFBvB65YDy6GrKzJm4THdVx0Sj9TzPdv24q1vQMoFhMTmx7kmSSJOipmF/sajJ3p5wp0eyIEgZklrEbhb2sg2cmxUgOWecCxO1I2APwZkUaMEL0SSM3XhFbBF7xTUN2k+YvURyfLKo+8Yr8WAL9UjE/8glTlJU5DwhOhhDga2L48zmmlNfORzkSRprtmbeoyoj6K5S3V/TWjO7VZtVQzb6P6QJncKrHfOPEPGiLt+rLdnlBdHkGDn8vP8BOLGsR5r+nZDiPQOo5o4Uo4qJ1zcpIa+manYRUIKcqqu62oRZCLo+VhtIlj6WLlKszcuRca045DtFJMqJl+lucFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX5augub9mf8T6dmgZzGUuv+IGOun6k9wDdXIbKDwcA=;
 b=MZO41xrxxVhqARvX7u3WKS/GcHdASDXVBSU+PN5Z5VxHuv2WQmGXxoTiImr8XdULcd5ZYzBdKfVtp3EzWEtXQDRUtKPdTLVfX4zbSanWE+OF/bxk9gzyrlg0uidq2De4OPUsatboZuwYmRriL5Q5sFiIMQ8g1++cUhcyYhAzveO6a6P+PbHXEc0STpmHGac9I9ikhNqFggb/nvlZxu2FmL0waoVhX1iJOfjLHMPo/wMAUZqwLDlaN7cC7Yu4FFWQPltJ7Sy8Z9L5tAGmmedkyXgkhZ0WwQFg403UasPaQWw1KB9VBcof3mexs5AjG6bv+fLOaoi7ZZYzm8RtMcP5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX5augub9mf8T6dmgZzGUuv+IGOun6k9wDdXIbKDwcA=;
 b=fv8TPifnCh0r1jpqqY9TVfDhuFjU4DXylftq/IiCfZkb/H6ujHLbwTWnPkY/+xgrFpaqYEV2ybkIe/wYvqSFWzTeOP2s/rYBLymTQp9OO9mEiDvhpTLWuNT7f1/6byTm/jZgkDCe/FcdLnFBDbCrB7IZ1jA+umMrCrtO/GKvr1I=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by BY1PR18MB5398.namprd18.prod.outlook.com (2603:10b6:a03:52c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 6 Jul
 2023 17:34:36 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::ec1d:671b:dbbf:706a]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::ec1d:671b:dbbf:706a%6]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 17:34:36 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Simon Horman <simon.horman@corigine.com>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V3] octeontx2-pf: Add additional check for MCAM
 rules
Thread-Topic: [EXT] Re: [PATCH V3] octeontx2-pf: Add additional check for MCAM
 rules
Thread-Index: AQHZrc/2c/6JCbOKkUKIfAttreR5nq+poGgAgANjXMA=
Date:   Thu, 6 Jul 2023 17:34:35 +0000
Message-ID: <SJ0PR18MB52164BC38B5D8899B74610E1DB2CA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230703170054.2152662-1-sumang@marvell.com>
 <ZKQi2HiT/yu/vSr8@corigine.com>
In-Reply-To: <ZKQi2HiT/yu/vSr8@corigine.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNWQ3ZDJmZjQtMWMyMy0xMWVlLWI2ZGMtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDVkN2QyZmY2LTFjMjMtMTFlZS1iNmRjLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iMjYxOSIgdD0iMTMzMzMxMzg0NzIzMTM3?=
 =?us-ascii?Q?MzQ1IiBoPSJqbW1VNy9xRnVlekVmMTlRSTF2TkgwU0pyNEU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUJC?=
 =?us-ascii?Q?WTlVZk1MRFpBWW10UkYzcXl1clppYTFFWGVySzZ0a1pBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
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
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQURRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFZQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|BY1PR18MB5398:EE_
x-ms-office365-filtering-correlation-id: fe337268-22c0-4193-b16a-08db7e474482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ql1wjU6bL4EnPaLszZKfxhexJkGk3T1b7gXQAdnLYKbWrvovtkMP21V5sCuhngX31JaDThUMIZtyBeomn4PYw8Bv+IkygkPcqj1STp8w8OfjZuCrLdSIHt9X/rdMLU50RyZL87eD9Jg5MYfJRuKEQR3rpD0KpI8dra7LDVb8M8xrjerw16PROLVzajh6qUVKbgDvYqmcfu/MYjSxSZ8dtl7zJsmwyNBZADtNZ5p7/guS5FqZrale/NfraxHj3EEJrwJYyKoOiqOQHETU5MS/BY11SuUrDmQlP216RnFQJEOrK06dUUbIg5iena4YrVI7xIaKEnPPA+KrFm7SZh7br14o33tyS0dM2ACpo+Y+gkSGKZ+DKdWLRG98LVfYqqK+fWfSE7gzeSY527sfyWMPO1s8zfBzfTRWChF0hfoX8b8cXacE242ipZGOcA5fk53N4vbbzD2UmsozYCEhbXnyPpwdmCyhoxgu6Lb0ocUhZ/IHxPiu7gsoFb7bQfsSuKC2jDt2+IXADer4l/m0sPcePfScbMEEk/Fg5ceMT5fteSGMJkEX7HAYVG6ZRWetDwPKlsYiFMxkWhGEIHC/V2F9crQYrC4boo1Oz60Qe9W/ZOtF4x41H5q0NYp4oyye/MQ0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(136003)(366004)(451199021)(9686003)(186003)(6506007)(26005)(38070700005)(122000001)(86362001)(33656002)(38100700002)(83380400001)(55016003)(71200400001)(52536014)(7696005)(5660300002)(6916009)(66476007)(66946007)(64756008)(66556008)(316002)(54906003)(8936002)(8676002)(66446008)(4326008)(41300700001)(478600001)(76116006)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r0SNvYXhD/RG3vgSrFd1m/iMqATYk6TPRi8Zd2xI7/P+llnLq5gouC2Q0RNo?=
 =?us-ascii?Q?AT6QG/fuibUhDypgwmAo6pgmLEZb9EEFV0FQBPvrGuTMIT0iXZraLWvAIUaW?=
 =?us-ascii?Q?wZfPyYnXc90NMk3C28G7/5NabEDse7bMign230xJr4VWioJzBnuWIUn51P7w?=
 =?us-ascii?Q?VSDRTa7WXTvx15q4nFXQGWaT9KjZzSm8S/ii2kSwb8h6ievIRo5Bf500PjRH?=
 =?us-ascii?Q?4P9F30oGxcz8/PC+xmXYtAKaWZoNdHVEgc8zfE4JmTvzoi9A0eQ8iIjn9hhK?=
 =?us-ascii?Q?HvjQfE5Tm4Hr+noYmtTNv7fyKP1rcYVsDN5pixPPz+C/tggr310ZUwEi/gW+?=
 =?us-ascii?Q?mBen+fZTkVY2yM84sxTyR6poAFsJU9WFKLHRhQZKpOUyJHpcbRlpc/OvqkBs?=
 =?us-ascii?Q?RrEis8TWOduDeMCOTr76ndHZVjLX/UwhMiYT4tzDOSz3WIscdd8N+rMqbdZ5?=
 =?us-ascii?Q?Pl6aqdr5imBaPkXD/xL0cphaRxgZVwp42Lfb2s0oPaEPBRzAT79srl7luQyG?=
 =?us-ascii?Q?ebbUYbW2ovVMQKwlC9/PbLnLLwGnUZ7MKeSh9ysDsfyv1ekGoHA794qUfc/9?=
 =?us-ascii?Q?np5XeIB9ZChIwTeCOQu+15NkTTkx6FAfZGinpglQaRRHjaL22qXlxpqCKGf3?=
 =?us-ascii?Q?8MGM5M7UwKtDlvZm1VdWuFu1IQ4NaYavJJ3o/5OUMAz4PiFtM2jV2CkHEJcj?=
 =?us-ascii?Q?acapxIb7naKCVZ2CDCNUxtFVCfZl2nQxXwaYq1AZ54cTesBFJctQpCUU+QhS?=
 =?us-ascii?Q?ooYcmRwVh8LQ3vQsVKMnxHnpF/uLUUH/qXU/5Ikc9LpLogqAE9uzzoyM/G7v?=
 =?us-ascii?Q?KaA1DM0YjVRt6funBSp/DAATA1YgtiEzKlvfC/XaeeWsrpriBz/a/UzyUZkY?=
 =?us-ascii?Q?JxFYaSV4WtC+tl91IovMCpuTlhxMoZ02AtefxsOTejfsQopVrrnT4hX3fqTZ?=
 =?us-ascii?Q?QG1Jra0wM+lmekkN9sxUIomBZ46LD4B5JyN1wZCbMJ6gDyyDliRCiEV28F0g?=
 =?us-ascii?Q?ase18rcUGPcP22WIiAAWFziujOT7DmLJsg6+19yn6h+6UjASf0+t+1xV6tns?=
 =?us-ascii?Q?nO16kph8JIsIGRfAzMzpcUbCFE2uU7WYeGI4kj2OvewQX+D30muoSd46b1oK?=
 =?us-ascii?Q?neN3UFs/7EsmK4zF18S2sutcB+Dw6iq7Uepexr8+GQBUbm+U771SVsJm5NWH?=
 =?us-ascii?Q?wl22IJchiKcr4A9DfOuEMrXVuYo/s7TmJmWyMiQvV9edLh2ZuixfGoYp+7iA?=
 =?us-ascii?Q?5Ul1qJs37O2fV7Y12SPssScvazzS/N4DKJOfAtZtxtKN53cVKrnqnTAYnZX7?=
 =?us-ascii?Q?wfiKAgmY+RXqiWtwT+/efkbvroqDYouVQrEjK7fFjeaxpWuXWgnFn2J6GhN9?=
 =?us-ascii?Q?8pXiF6Vtro7MPmXc9BQi2kH4LZ9X5ArXtq8a4ukrRGJ+UftfmJiPu7MbNtbB?=
 =?us-ascii?Q?TOB8BQxW+h8bJ6s+YZ894w5KhEhcxOeSc9ffsR8u6IO2aEDEStAxLCDwRGNM?=
 =?us-ascii?Q?2jErFbO8HAqocWB/6p5Syc3sPSSCA4N23eagrRdqIEqfyCmssWWh+k5EO69o?=
 =?us-ascii?Q?/TDGHgNnmaeUFc3FsEM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe337268-22c0-4193-b16a-08db7e474482
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 17:34:35.9903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnUPZohCNVzWQ9HcvcFzDzMrha8Fmiai0hs7c9/TFfdiMP6ru2cV77yILr5R+SmuE7/vf3XgWnOvRFRTsgIy+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5398
X-Proofpoint-GUID: 0DOep6iPHo6LVEI1qA6U4D-KGTQ8BPA4
X-Proofpoint-ORIG-GUID: 0DOep6iPHo6LVEI1qA6U4D-KGTQ8BPA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_12,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Simon Horman <simon.horman@corigine.com>
>Sent: Tuesday, July 4, 2023 7:17 PM
>To: Suman Ghosh <sumang@marvell.com>
>Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [EXT] Re: [PATCH V3] octeontx2-pf: Add additional check for
>MCAM rules
>
>External Email
>
>----------------------------------------------------------------------
>On Mon, Jul 03, 2023 at 10:30:54PM +0530, Suman Ghosh wrote:
>> Due to hardware limitation, MCAM drop rule with ether_type =3D=3D 802.1Q
>> and vlan_id =3D=3D 0 is not supported. Hence rejecting such rules.
>>
>> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
>> Signed-off-by: Suman Ghosh <sumang@marvell.com>
>> ---
>> Changes since v2:
>> - Added "fixes" tag
>>
>>  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c |  7 +++++++
>>  .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13
>+++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> index 10e11262d48a..49ba27875111 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
>> @@ -871,6 +871,13 @@ static int otx2_prepare_flow_request(struct
>ethtool_rx_flow_spec *fsp,
>>  			if (be16_to_cpu(fsp->m_ext.vlan_etype) !=3D 0xFFFF)
>>  				return -EINVAL;
>>
>> +			/* Drop rule with vlan_etype =3D=3D 802.1Q
>> +			 * and vlan_id =3D=3D 0 is not supported
>> +			 */
>> +			if (vlan_etype =3D=3D ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
>> +			    fsp->ring_cookie =3D=3D RX_CLS_FLOW_DISC)
>> +				return -EINVAL;
>> +
>
>Hi Suman,
>
>vlan_etype appears to be uninitialised here.
[Suman] yes. Moved the assignment of vlan_etype before the checkin v4. Henc=
e no need for initialization now.
>
>>  			vlan_etype =3D be16_to_cpu(fsp->h_ext.vlan_etype);
>
>Perhaps the new check should go here.
[Suman] Ack.
>
>>  			/* Only ETH_P_8021Q and ETH_P_802AD types supported */
>>  			if (vlan_etype !=3D ETH_P_8021Q &&
>
>As noted by Jakub elsewhere, please allow 24h from the posting of v3
>before posting v4.
>
>--
>pw-bot: changes-requested

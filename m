Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFAF73B620
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFWL2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWL2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:28:34 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A4213C;
        Fri, 23 Jun 2023 04:28:33 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NAUb0O025529;
        Fri, 23 Jun 2023 04:28:22 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rcur5jnxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 04:28:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5a+AOfCMgGtdD/K7R6Es0E311yO52Ylgi0MkFwDQfZUj/GzmJAkOpLo2F2d4mGI/dzC8RXXR9RBk3j3V7TuyBQhhvym20rM1zg/ULJc5Yj3A/ni29U5QGmiwYTYQJjdj3x57I7gYxApW33Sw9VXu+AdpDQ2WfHthnF5K3Un9Bf1aVu+P1xLVKJgVOqN3sJ7PJrA614OHUgtwFESQe3RCF4liKSECA7eVsuAnuU2F1LH+7RpvZmeBX0PGzL6iJvECWByiLtT7kVN089363lX3ocp5F4GetB4EaK2OJRT8pYupstcR/OA6umChOVR3CEXCs6y9C3wAE1YJZoHpguyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4zUwbx05/3l3bfkFDazexzcNt6Y5Vq8FqYv39OsqpE=;
 b=NTfOKYw9M9R8pBGPH9l4/oyXyKDA13YkUDUF0aSagwTtambkM9bxhST+iADnKYeVnO+iMcmiSFHqzEdxYkih+WM+gvPMSDOmMrXX/+le6hXb7QIMvlDiv0H3dvyWA7Ukqil/RqL3h3aIuw18HOlmmU4AGKQ3kpPcoMCYxywnqUPOHnHxoWE0TKyubx/DqUBfAyBh4uId13+eHjBaVFOxhjl9kTex3AEFUDxijE/u2U5ySLjjn/xNcrR8jzOgbKTBzfgQYYtrK2RU7MDFm6IUzEHfN3MHG/Dd0JQCDHAKZnA/DIyFZ2WPLtCiUvXKFl/ozyGjObMCLs2XCIWlQShOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4zUwbx05/3l3bfkFDazexzcNt6Y5Vq8FqYv39OsqpE=;
 b=k8xpiKCxTwu2DuX9wZOrZdEB6MqzO+AdiNDBNEk42MN/yMN8Pk3Iyrd+OEf5xN+xgXWUlmsIWgrVx/OWqYG74id89L5zFjFXnK62zVlIYim86DrkOQYwwTuDWmqipAXhQaW4V6EGU6p+6xN/bCxSrLR6VTEGK/IHInmzm1SC7Sk=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SN7PR18MB4000.namprd18.prod.outlook.com (2603:10b6:806:f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 11:28:19 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::c8bc:9028:e12d:c138]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::c8bc:9028:e12d:c138%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 11:28:19 +0000
From:   Sai Krishna Gajula <saikrishnag@marvell.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
Thread-Topic: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
Thread-Index: AQHZpcXPjEIdzNE8GUWRy5B3kUqU5A==
Date:   Fri, 23 Jun 2023 11:28:19 +0000
Message-ID: <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
 <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
In-Reply-To: <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0wYjk2MTkyZi0xMWI5LTExZWUtYWQxZS1h?=
 =?us-ascii?Q?MGQwNWIwNGJhMDNcYW1lLXRlc3RcMGI5NjE5MzAtMTFiOS0xMWVlLWFkMWUt?=
 =?us-ascii?Q?YTBkMDViMDRiYTAzYm9keS50eHQiIHN6PSIzMzM5IiB0PSIxMzMzMTk5MzI5?=
 =?us-ascii?Q?Njc5Mzc1NjkiIGg9InA4bitOWXZRMVNSYjNvenNyYnlHZUdjY05zQT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40?=
 =?us-ascii?Q?UEFBQWhaZ2pPeGFYWkFmRUdseTJBYlQ0LzhRYVhMWUJ0UGo4WkFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRRUJBQUFBeloxamFRQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFaQUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4?=
 =?us-ascii?Q?QWNBQmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VB?=
 =?us-ascii?Q?YmdCMUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFN?=
 =?us-ascii?Q?QUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhB?=
 =?us-ascii?Q?Y2dCa0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2?=
 =?us-ascii?Q?QUcwQVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFj?=
 =?us-ascii?Q?Z0JmQUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFB?=
 =?us-ascii?Q?QUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVB?=
 =?us-ascii?Q?RjhBY3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFH?=
 =?us-ascii?Q?MEFaUUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3?=
 =?us-ascii?Q?QnpBR3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdj?=
 =?us-ascii?Q?QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0Fj?=
 =?us-ascii?Q?QUJmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?us-ascii?Q?WUFhUUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpB?=
 =?us-ascii?Q?QmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQ3dBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?us-ascii?Q?MEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFB?=
 =?us-ascii?Q?YVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdF?=
 =?us-ascii?Q?QWNnQjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJs?=
 =?us-ascii?Q?QUhNQVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFi?=
 =?us-ascii?Q?Z0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhB?=
 =?us-ascii?Q?WndCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZ?=
 =?us-ascii?Q?d0J2QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxB?=
 =?us-ascii?Q?R3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3?=
 =?us-ascii?Q?QmtBR2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFH?=
 =?us-ascii?Q?OEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFC?=
 =?us-ascii?Q?a0FHVUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFC?=
 =?us-ascii?Q?cEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhB?=
 =?us-ascii?Q?YndCbkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdV?=
 =?us-ascii?Q?QWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdC?=
 =?us-ascii?Q?d0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1B?=
 =?us-ascii?Q?ZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZB?=
 =?us-ascii?Q?SElBWHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1?=
 =?us-ascii?Q?QUhVQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUlBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SN7PR18MB4000:EE_
x-ms-office365-filtering-correlation-id: c703c611-96d9-41f7-86cb-08db73dcf219
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: atvWFpFncqJeqO+sBhsbinRYBD2Ht3ehYukvZce5iXU82F8J3TDd5c8uDKMYHuejZJkw84dmB+whczGyTb5lS5Q8g3kVg9EQIKc4z4Qa29myZFeC5drnVjIlk/N3R4f6nE/B6xJFg89e5ie40iZ+Y2gz7hOJ3UuSag0AxOLemxds9M4YZQ8K27ScqyV+n6qG28vc+oOAeWe67+a5x9ZkH8/Ivw56GHzsByU8znT0GPoF96PjcYmFqfPgRzKgCQWPprKJGighlg7i6PIOcHBHZ7ZD0eLesDwF0dK6GrBrCbWxsybUURxsgqAWrzr8TsQAvE+RbmK8wlrugEUTSu867z69Cn+3uPirTtq6Gd3jMX6ovp+a4lzFQQYliDwdCWy157af4KeYuIodQf3OpV8KOb9+0Ji3Q8MM80XNq5s2T4uhSaxNwn1s9hhZlxBAennEKJl4Knq6OhuhwiK1zGtpeO6SsdxlE/7xblFUqSp31niYQPy0AxKH/l4fJCY48QgZsgUAv9lvpgQyOXjJFpkQLJBKrz4wGHbVNxKVwLaeUpQs23j/VkWYySmMRi3Xaxq6VXDM6Oi6V3HqxqQHAuLJ+1a4NpjsyonqyLHWoRjo/rlUoId7xH0Nv/qGGFIjwoeN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(2906002)(7696005)(38100700002)(122000001)(71200400001)(83380400001)(107886003)(9686003)(53546011)(6506007)(186003)(26005)(41300700001)(55016003)(86362001)(54906003)(38070700005)(478600001)(66446008)(316002)(76116006)(66946007)(66556008)(66476007)(4326008)(33656002)(64756008)(6916009)(52536014)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pEZoF/bWhDx2BAn9q9aJR0sXuohPkr93UJ/OfhAUagKQRgCDAjwt6RMXd3Zv?=
 =?us-ascii?Q?y5nDEgdIqCXKqbBBh3ov6nlskgoTgMQX2xSduISSrEsnikko9xSZwK6IZMsA?=
 =?us-ascii?Q?Wckyb9NTGrixDeT8VXRB+I6EzqWlPWZ7i8ftzA+iviiXX5VQboAMeYfymxY5?=
 =?us-ascii?Q?LDSCgWhUEa9w5SIAal7hZpqt/S0CLDjsx9Y0sXoqEpQptNLzDQGEDBiUUADG?=
 =?us-ascii?Q?TduMHoon4bL85N9qX+x7tdwqPpYgHLt+zAf/JVe3x+Xl3pefmVssw1695XO/?=
 =?us-ascii?Q?VPLL0ZHUnqEGk7tH9VIPVJcJip3L1f2ugAQOTxSzlyOkbp5kFuE3BQ4Q2UTA?=
 =?us-ascii?Q?tvHR/goAPnusjbIsfIRwB99milsPwvvXVNSXk6IGjNVP+jnoBOqnpxrOKPtX?=
 =?us-ascii?Q?8S0AglFeakKWQVjOCmyTJ3g7+lUgSQVmremGSc5PeppzSmZjb0S8YmAOOAD7?=
 =?us-ascii?Q?b0m/76mPq6Id7aHO/ow9GgOM5i+Bf7VFt6gprp9e+7086sSlgZCr5Bxsi70d?=
 =?us-ascii?Q?d1AiJ+hnb3iCUAxozMiDkEOJhv+1G9uOe+qOBA7pnYOnyEqHVVvRrUuWg17O?=
 =?us-ascii?Q?hd5PwVVahWROgkapUT02Rk2Z4JKdzwrNyQBUHl0ckafrwNkm4JKefg2RSMkz?=
 =?us-ascii?Q?AznmzsqOYLBYcdlLey7o+cMiuOsgbTO5h9K4JwByDyJ9U7cpR0zLi7lL8iXT?=
 =?us-ascii?Q?co43pDdK8D63Jjl8upZ+PICyMXQpE5+82yAjruERyTS4IxKV5K3V+j/5A9iL?=
 =?us-ascii?Q?zxQSBouXRIh7DjB2laLNeVvJfiAFOQH7oMJauJEsI4D/e+i11tbkNjJAclpP?=
 =?us-ascii?Q?HJAKpLSjrrLlsTnpAmWQwvx/6knUu7CNyaC3tzSmBVzbg+zqaHU0ksyouACU?=
 =?us-ascii?Q?4mZW9pZZSN4K6R0y0Ln93RnpNmsCOXriqh2l9VX0SV5f3Z8IjzGBbGQBkjk+?=
 =?us-ascii?Q?Olv8FId/IWPrZwxAsuMW2Z55A3t4oWUO4lY9CjgB+lJ1YO80Sv8+EcjP2pvW?=
 =?us-ascii?Q?Tjb+h9NhfR1iliKDr50MDJcP25zG54xMii6fr3zNLtDYp4BzDe75ooa04XG9?=
 =?us-ascii?Q?Fbo26kfv1k10QXsqrJoexxWSN4Q4uHm80k5RMe2J3YAx3+MROOQCM1nAlJjc?=
 =?us-ascii?Q?ursYOAkDmEw5TO1PzGklB40pBz6zY0NqZ3my7BtqNXl1A69151r/+58/3f/r?=
 =?us-ascii?Q?7MyB8rL0v1EKtNlP446pdAzB/bMnXPXbR127NhuCrw/LpdDvmlZGVQecQqFr?=
 =?us-ascii?Q?4Tcs5HUzzotVMm3jWfJd47DVTEZoQvIwTpNEr3oqhYeVi5TZcCZDHjTibWYL?=
 =?us-ascii?Q?In5DrBXMhgFefgftQNVcJnF+enrf5uEQh/xBazewSx0xTjSRVixS5a8zVqCA?=
 =?us-ascii?Q?USNBNeG6jAICj1bVGGKI1KsVsOoRuS0WeU0k3b7kDcMP1rJAunPH3EtWfDS8?=
 =?us-ascii?Q?YXIMOiMjIiBt1E31+fYBoycYddfdJbRl8UXgUpdjCNRe8SQwCExIahzSShPW?=
 =?us-ascii?Q?t1yJxbIXHj7bH9WkPuvR842L0vLMdHNLOflxWA5HgmgHsML1BRTi6/Ml7e7e?=
 =?us-ascii?Q?nQye5eBQRhnr8hK/ThH3Z3vAPyV3HyrOY8AYguRy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c703c611-96d9-41f7-86cb-08db73dcf219
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 11:28:19.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hrxdydy2y6NymVKFLISFSo+jNrue9ltktqNAn8PdtBK7A2TTCMev5MpdHg0Tt2k6IndNAe9MzVJLNQnkJMd26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4000
X-Proofpoint-ORIG-GUID: tf4bVxt_HHfx5nChSbNLPU0rE7MAJmf1
X-Proofpoint-GUID: tf4bVxt_HHfx5nChSbNLPU0rE7MAJmf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_05,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Friday, June 9, 2023 6:48 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> maciej.fijalkowski@intel.com; Naveen Mamindlapalli
> <naveenm@marvell.com>
> Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp
> pointer before its usage
>=20
> On Fri, Jun 09, 2023 at 05:28:06PM +0530, Sai Krishna wrote:
> > @@ -428,7 +427,7 @@ static int ptp_probe(struct pci_dev *pdev,
> >  	return 0;
> >
> >  error_free:
> > -	devm_kfree(dev, ptp);
> > +	kfree(ptp);
>=20
> Yeah.  It's strange any time we call devm_kfree()...  So there is somethi=
ng
> here which I have not understood.
We moved from devm_kzalloc/devm_kfree  to kzalloc/kfree as per review comme=
nts from Maciej.
>=20
> >
> >  error:
> >  	/* For `ptp_get()` we need to differentiate between the case
>=20
> This probe function is super weird how it returns success on the failure =
path.
> One concern, I had initially was that if anything returns -EPROBE_DEFER t=
hen
> we cannot recover.  That's not possible in the current code, but it makes=
 me
> itch...  But here is a different crash.
>=20

In few circumstances, the PTP device is probed before the AF device in the =
driver. In such instance, -EPROBE_DEFER is used.
-- EDEFER_PROBE is useful when probe order changes. Ex: AF driver probes be=
fore PTP.

> drivers/net/ethernet/marvell/octeontx2/af/ptp.c
>    432  error:
>    433          /* For `ptp_get()` we need to differentiate between the c=
ase
>    434           * when the core has not tried to probe this device and t=
he case
> when
>    435           * the probe failed.  In the later case we pretend that t=
he
>    436           * initialization was successful and keep the error in
>    437           * `dev->driver_data`.
>    438           */
>    439          pci_set_drvdata(pdev, ERR_PTR(err));
>    440          if (!first_ptp_block)
>    441                  first_ptp_block =3D ERR_PTR(err);
>=20
> first_ptp_block is NULL for unprobed, an error pointer for probe failure,=
 or
> valid pointer.

This is correct.
>=20
>    442
>    443          return 0;
>    444  }
>=20
> drivers/net/ethernet/marvell/octeontx2/af/ptp.c
>    201  struct ptp *ptp_get(void)
>    202  {
>    203          struct ptp *ptp =3D first_ptp_block;
>                             ^^^^^^^^^^^^^^^^^^^^^^
>=20
>    204
>    205          /* Check PTP block is present in hardware */
>    206          if (!pci_dev_present(ptp_id_table))
>    207                  return ERR_PTR(-ENODEV);
>    208          /* Check driver is bound to PTP block */
>    209          if (!ptp)
>    210                  ptp =3D ERR_PTR(-EPROBE_DEFER);
>    211          else
>    212                  pci_dev_get(ptp->pdev);
>                                     ^^^^^^^^^ if first_ptp_block is an er=
ror pointer this will
> Oops.

Will fix this in v3 patch.

Thanks,
Sai
>=20
>    213
>    214          return ptp;
>    215  }
>=20
> regards,
> dan carpenter

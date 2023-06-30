Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D7743400
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF3FTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3FTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:19:47 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E472D69;
        Thu, 29 Jun 2023 22:19:46 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2qDSN004601;
        Thu, 29 Jun 2023 22:19:30 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rgvpc53cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 22:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWSdt35q3Wc4suSyZtJOMBtsNWSh+SkKMhJaMqEorXXVz9Y/YnmKb5yaX7+OdKxBgTdDHGbCbyrOm4FU2o80NLJ5SXKCkFYcfNdyhBpMNUXHyiJeX423dIdcCZvQCY9bwmRxBZ/R1n0CWBkCd/YzHtoFHQuI5EGHDFTmWQeYu+R5QiOtkIsPOUoT9tggZDNo7IC2OxAySnMIFioQQzOxKQajeb4BHjUXvSiX4cX5Un8Gc0Fwzr1/c4WX1HUrKF/6jnq4gNcOsZlLprpUGL+O8JXPW5Sas+gxxbWqyS8ko6R7ZwDNRGvC06GSktuGg+4kX2YHhyycPw6fkEExIdOvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqTfj/IVRO+9XujDnEKSjuIl0p8v98Uib13Z1cPwa2k=;
 b=D0iJWZL3zkjW0P+YuE7vNAUhWSRKpTNkm4K8KwhHivRzxPM1VFdENgEOW/6nSgNlkDWG8Ymg5b8AVA/OddgRA+zJ0uxRQLeab4654aTrKoQNaYIbjdGmZODDhJJcTKte57t0L91NnDwoxV2+ZzKZWHAouhjx9hVcQkdG1AjL36Glwg020cb3DJtjd7G+SuX0YeUzgx7GRBtc3W8FroAYlD5+il30m7X1grQipMF8U2UafIfgHjYA5dEz9RIt9oI/9DkGSa2TrA3x8FY0EHjQGTl49FV/TtvJO+VNc3faDQZRPjHeXzbXLixnnmaiVpjLaWqd/z+MnmtZwfV4Z6RrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqTfj/IVRO+9XujDnEKSjuIl0p8v98Uib13Z1cPwa2k=;
 b=Zp1W9WRBF/rrjU5EE7Mfl7HTQx7j1Rf0yGXG4unuDzI8tIsifUQHv9lKRU3YrVb5iDkDxsA6s1+rgh3FeVLgvac5uBs3qsov3DQsor1vKLCJjl+hC01dqCjcQi24sjbpQ1daK530OfiPfp9ZxK8HomIBMP8gSSn7E1cFRNBDqsE=
Received: from SA1PR18MB4709.namprd18.prod.outlook.com (2603:10b6:806:1d8::10)
 by MN2PR18MB3672.namprd18.prod.outlook.com (2603:10b6:208:268::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 05:19:27 +0000
Received: from SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::b2e5:e05:a794:59ed]) by SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::b2e5:e05:a794:59ed%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 05:19:27 +0000
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
Thread-Index: AQHZqxJweVNRvtU2DkO6MScNy+K7wA==
Date:   Fri, 30 Jun 2023 05:19:27 +0000
Message-ID: <SA1PR18MB4709E390AC13A1EF5F652165A02AA@SA1PR18MB4709.namprd18.prod.outlook.com>
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
 <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
 <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
 <3894dd38-377b-4691-907b-ec3d47fddffd@kadam.mountain>
In-Reply-To: <3894dd38-377b-4691-907b-ec3d47fddffd@kadam.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2Fpa3Jpc2hu?=
 =?us-ascii?Q?YWdcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?us-ascii?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1hYzMzZTJlOS0xNzA1LTExZWUtYWQxZi0x?=
 =?us-ascii?Q?Y2MxMGM0MGQ5ZTRcYW1lLXRlc3RcYWMzM2UyZWItMTcwNS0xMWVlLWFkMWYt?=
 =?us-ascii?Q?MWNjMTBjNDBkOWU0Ym9keS50eHQiIHN6PSIyMjk1IiB0PSIxMzMzMjU3NTk2?=
 =?us-ascii?Q?MzY2OTA1ODMiIGg9InhFbnlOZDJjZWhiUGZXZUlha29VV3duRlVTVT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40?=
 =?us-ascii?Q?UEFBQ1gxbzF1RXF2WkFhL2d1ZVhlUFhvd3IrQzU1ZDQ5ZWpBWkFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4709:EE_|MN2PR18MB3672:EE_
x-ms-office365-filtering-correlation-id: 3a93131e-bfd9-4d56-cb7a-08db7929936d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PBwXcBchWEJcO0Gqr+BVr+TfP2AkDJc+BPwQRya9VVrVwUm2bFKY3CAwWjliiU0hXtln+qJDy5JHLx16ktQ6ciT5lXqEiOiLgTs70JJeQOMppkKtpnRgs/wNA0Ie4B+lrisnh/wnUGvz/Zr4+ponnaBZ2usLAycQhpngSgllJendIemqkNbhlpgAob+19/QfLjDS6IP5Q0NuSW7hf8foa5SECzYBlWFdRj845USOPjTG74bgkSdbplhv3jo6pgZ75+9JkVdzLqCcqEJrNAhaG/y858eJTtF+uGiXruEXQIl/PWL32FnIrhYv86Vi1PWL7ust8PqPdl4tZ/DcjoKM6Q2VoY8gM+j/yD0xV2hGpVOw2lgKjNCBUWCHFyIw4wDobmK/tNgrWsHNurMYGzj2tk/YIqVVL2fb9aYokWQLDjVJWcIcfbiTPTYlNdXNQ8r0CmBBUqq5c9NXb15aaZoq+2bmk1+165IqVzWm9EipgvFoX+4M+8nh5TvFN67ojkIH3xA3RM9ht3j9mdbAC322UCHMSUCeGnw/K4lXhzvh9rI4T0vlZILgmdl8YIJKbG4m36E3jumiHS8oKBpCWZHrutkRicm3fho8NANC+fEqkPxeE5AtkWDlNe8yor4FyZH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4709.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(55016003)(83380400001)(38070700005)(2906002)(122000001)(38100700002)(8936002)(8676002)(5660300002)(52536014)(86362001)(107886003)(71200400001)(54906003)(41300700001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(316002)(7696005)(33656002)(478600001)(186003)(53546011)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yc3oSeoPCH+LA+QMDPb/bNI75Po8oaaFvt17uW+p5lXIfnro6Y7O1f8fh1oI?=
 =?us-ascii?Q?V+S2BttE7FSZwDJ0QmCErUU7G6hVxa2N91RDr6C2kGdeiq4v5AWtCBDA78sr?=
 =?us-ascii?Q?IvUwBNnXH6EZlh3hFMnK+mtZvwXz2TtbJjPDx/xob/BWLGq1dXjpEE+66IrB?=
 =?us-ascii?Q?ic8VpjP9JqB0XPBgc45O4FgbV0KNOUpr3NJ5Pin38vKLn3ODkk46nqzJf//9?=
 =?us-ascii?Q?n4hbtVQcD9T2VJ93MgWYF5v94/WDnJzgI6XRoFZY/Idc3aQt6WSPEdYmGXIJ?=
 =?us-ascii?Q?XgCn3DYIcA1s4XKBP7uaCy0XnKE4ucX1DM5QQaC9entHWArs/j4Cgq4uY067?=
 =?us-ascii?Q?/SjEabhb1LLrPpzW5lTlqw26RW/k9tY617WDgRV1ZiCgKbcDFh14qEkwnbUp?=
 =?us-ascii?Q?BXCJkT6hph41bK07yjbkb+HAuRPzn6BfREapm4dtW9LMIBLbvZLa+noWeIs+?=
 =?us-ascii?Q?fpsuCx4P9zVgztad19o9J7jXCwVGpPWHtFUj6D6gfi82CmmfuaT952axziaw?=
 =?us-ascii?Q?mYm8AL2vbEXjPMFvf2kqqmUNDBXwewGDJjHXctsDTqq4dd4cN17/iZ/CtBgq?=
 =?us-ascii?Q?rX1llo1+56LqyizCUZrcOLybr5HPYixIWGS88aL0bAXN52rXJwlgXPpPaCXO?=
 =?us-ascii?Q?AwCMNJhjbpBJLtZiV4gcqVrkxItOKkoeAZAeTlAKSVEAvkMLRHiraVet0MtE?=
 =?us-ascii?Q?0tbt5+aWGq9S/fmW2BYYi9CfqABRH7IBiHt8XtAjbSRSv2X+GtTs4BfX6Pmc?=
 =?us-ascii?Q?Tp1rUVOZybst3gKmV+DaGDtobD05Wb1lbiG5Lb2hJr13AjbJaNJwWA7BT3Je?=
 =?us-ascii?Q?roh1nptncqNDtgqs5V5l+hAhu4gAahekYjYruqT83IeChsIN+QMmJjDqWJl9?=
 =?us-ascii?Q?/ZjG9c2O5CzC3DtnazSwhQG2k7djmGp1AooHx08WgLkY0lL26UjNx30lZS50?=
 =?us-ascii?Q?7CaxfgJ8cFjYsqDEwALsxf+38qwPNXfHCT4bGgbKejyhVIpkho7290bS4zxF?=
 =?us-ascii?Q?d7BpW7dOIJtwV+AOZm5/g24pZD3R+y/Bk/zXO949t8+5QQsySR1x+YMQF7ls?=
 =?us-ascii?Q?JExpug83EQy5nGSSMg26Ik5CTWaLHqmwUZMldOtmFHtH+CY8tRciwQHiPcIz?=
 =?us-ascii?Q?ibunVf2rt4O1waK5XWptw85zIT0V7ySJrckNwRPWqHHFija5CwKtBK9KroV7?=
 =?us-ascii?Q?pNVX9RAWzTCQ0dbGi+hTdpADbmG78QdBV6aFGPnJSRlZ49ypmGgzAQX9TD6k?=
 =?us-ascii?Q?IQNyczYDq3GCNRbGRAgU+RWE/iS+j16IUdJU0PDMM4TtdRALI6agYS68E0QP?=
 =?us-ascii?Q?UWd6oa9yW7PD1ri1WWm9CQlAwOcomnUaWsB5f+sxHwvvGXwH6MaACi4bCoNq?=
 =?us-ascii?Q?Br+bSq/UTr0jpw0zw7Q7k2ziDEQpASu3eTG4inAH3wzH5npveil+sZtovQKM?=
 =?us-ascii?Q?q/gPL7OTtrIX+vyPIk3Ah7xQf6eqtmQvw7dQYuFnoJo8EtZvMuknBXOUiW7B?=
 =?us-ascii?Q?L5xtQKmcdnHdkpZzp1HOGEQxIU1FEwuvuVZuoImh4baLPzb/+FcNfy38efDi?=
 =?us-ascii?Q?i5cDDD4ldN53jGWQPxiZEwNxhx921HarrP8DwMHm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4709.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a93131e-bfd9-4d56-cb7a-08db7929936d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 05:19:27.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Q34MEyi/EJYTt/5pvMycZdJ/ZS2Rgry9E5VVGaga/lhJeNUiQq9TT7xWoCitRfQDk1kD0ATwKCyy/er5gwIxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3672
X-Proofpoint-GUID: 1e3fO5G0Gcw6_T_2Vr0FxuoYCpTYK-vv
X-Proofpoint-ORIG-GUID: 1e3fO5G0Gcw6_T_2Vr0FxuoYCpTYK-vv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
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
> Sent: Friday, June 23, 2023 5:14 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> maciej.fijalkowski@intel.com; Naveen Mamindlapalli
> <naveenm@marvell.com>
> Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp
> pointer before its usage
>=20
> On Fri, Jun 23, 2023 at 11:28:19AM +0000, Sai Krishna Gajula wrote:
> > > This probe function is super weird how it returns success on the fail=
ure
> path.
> > > One concern, I had initially was that if anything returns
> > > -EPROBE_DEFER then we cannot recover.  That's not possible in the
> > > current code, but it makes me itch...  But here is a different crash.
> > >
> >
> > In few circumstances, the PTP device is probed before the AF device in
> > the driver. In such instance, -EPROBE_DEFER is used.
> > -- EDEFER_PROBE is useful when probe order changes. Ex: AF driver probe=
s
> before PTP.
> >
>=20
> You're describing how -EPROBE_DEFER is *supposed* to work.  But that's no=
t
> what this driver does.
>=20
> If the AF driver is probed before the PTP driver then ptp_probe() should
> return -EPROBE_DEFER and that would allow the kernel to automatically ret=
ry
> ptp_probe() later.  But instead of that, ptp_probe() returns success.  So=
 I
> guess the user would have to manually rmmod it and insmod it again?  So,
> what I'm saying I don't understand why we can't do this in the normal way=
.
>=20
> The other thing I'm saying is that the weird return success on error stuf=
f
> hasn't been tested or we would have discovered the crash through testing.
>=20
> regards,
> dan carpenter

As suggested, we will return error in ptp_probe in case of any failure cond=
itions. In this case AF driver continues without PTP support.
When the AF driver is probed before PTP driver , we will defer the AF probe=
. Hope these changes are inline with your view.
I will send a v3 patch with these changes.=20

Regards,
Sai



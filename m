Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4322970ECAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjEXEsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjEXEsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:48:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C836513E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:48:43 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O2133a027623;
        Tue, 23 May 2023 21:48:26 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qpwqk4exu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 21:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D55iONGWXRB+5dUgPkj88JpoDjlGWtq0yYTkLzTwMnvPJjDpPlC/rX2FTDUVgaTbRZXegojJaxV52CJ0cufHFbXp9nXNvn8Kk/wStVKg0qx6DNQ05oC2ZH2ugH9YFy6D86zbdwglIF6oepnSwuvO15dm51lv0QrcYR25p4R7iuFTrUnGZR5duqb8pPJz4mZxj1HRNEwHp1A/mVWnrUKouzajIw1TVzBMG+DC3XG6DBemdOFs7G1BCz+rIhs6Zrb3i8wOzuIOAqIZFx5klhvc1Iby43tDbtCNqtAkDmmsPec7PzqbB21xEIYxdBPbWwVdsslfXiez/0KH4j3Bmb9JLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSwmABSFM1OcJexacK5Ag+N8uBAdw+wOjppcS1rVrRE=;
 b=Jy+BZsVF/cI/50pgVbCuiTt2Xx0rG4yGHXDp7ntlEsC7uR43p6RHZO3ONgnxGHkozzTs1QplI6mvFiauaonMuYRjLkK5FoT+KP3oAlwPnu5k0Fik+ulkzIoJBkzBJIHMOmBPO9LNNXBDWAasxeW4gt68LUmeYowN5mA0udc7nE4DYQnuYACPXJXzSchMouDq4y+M95PZKHHir4a7rBR0PrGZFjoWAcAG42QArNLRBkO0NFt3wcdfGOCUciHE7cyAJddZtBImKZCTX0cdkgsqe7SbHStPXXBONEWhO2O0npiO8OkqFw6F46qQ5SGP2F3x/E5y40GVemCapnsgURJk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSwmABSFM1OcJexacK5Ag+N8uBAdw+wOjppcS1rVrRE=;
 b=kvJQuITefI868qFQwkyoosut1Atg3FWleLoRKtY1ZrckgOgwU2QAWNAoyuhQIwaWAIEKPRtSvsKd6ESufbK8lN9CD4CguzgpxlAGKmz85JbFGUY7HJuWTfGYYSD1igrKFr8hKcgxQEpk2BR3ZKN4CJVoXYYbeGqRgepHzmEFn6Q=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by PH0PR18MB3894.namprd18.prod.outlook.com (2603:10b6:510:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 04:48:20 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::f25c:a4ee:6866:c84d]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::f25c:a4ee:6866:c84d%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 04:48:20 +0000
From:   Linu Cherian <lcherian@marvell.com>
To:     Mike Leach <mike.leach@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "acme@kernel.org" <acme@kernel.org>
Subject: RE: [EXT] [PATCH v6 0/6]  coresight: syscfg: Add config table load
 via configfs
Thread-Topic: [EXT] [PATCH v6 0/6]  coresight: syscfg: Add config table load
 via configfs
Thread-Index: AQHZg9VVfzPoIytoGUiHzRJrqLjF269o6frQ
Date:   Wed, 24 May 2023 04:48:19 +0000
Message-ID: <PH0PR18MB5002D43DD267B8E778EC634DCE419@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20230511065330.26392-1-mike.leach@linaro.org>
In-Reply-To: <20230511065330.26392-1-mike.leach@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbGNoZXJpYW5c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0zMWM1NDVhOC1mOWVlLTExZWQtYjZlMi0wMDkx?=
 =?us-ascii?Q?OWUzMWI0MmRcYW1lLXRlc3RcMzFjNTQ1YWEtZjllZS0xMWVkLWI2ZTItMDA5?=
 =?us-ascii?Q?MTllMzFiNDJkYm9keS50eHQiIHN6PSI2NjQ0IiB0PSIxMzMyOTM3NzI5NjEw?=
 =?us-ascii?Q?NTg5NTYiIGg9Imp0QUJnSTAxQmxXeTQ0RExMWlFPcVRnUEVFND0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU40UEFB?=
 =?us-ascii?Q?Q01rQjMwK28zWkFXczhSOUh6RFljMWF6eEgwZk1OaHpVWkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRRUJBQUFBSTdxVHBBQ0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdC?=
 =?us-ascii?Q?MUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJqQUhV?=
 =?us-ascii?Q?QWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFNQUF5?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?TUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhBY2dC?=
 =?us-ascii?Q?a0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcw?=
 =?us-ascii?Q?QVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0Jm?=
 =?us-ascii?Q?QUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhB?=
 =?us-ascii?Q?Y3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFHMEFa?=
 =?us-ascii?Q?UUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3QnpB?=
 =?us-ascii?Q?R3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdjQVpR?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0FjQUJm?=
 =?us-ascii?Q?QUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFHWUFh?=
 =?us-ascii?Q?UUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpBQmtB?=
 =?us-ascii?Q?SElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQ2dBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFG?=
 =?us-ascii?Q?OEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFC?=
 =?us-ascii?Q?aEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhN?=
 =?us-ascii?Q?QVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFiZ0Js?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FC?=
 =?us-ascii?Q?eUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFB?=
 =?us-ascii?Q?Y2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhBWndC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZd0J2?=
 =?us-ascii?Q?QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?YkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtB?=
 =?us-ascii?Q?R2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFh?=
 =?us-ascii?Q?Z0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FH?=
 =?us-ascii?Q?VUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?RzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJn?=
 =?us-ascii?Q?QmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3?=
 =?us-ascii?Q?QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFY?=
 =?us-ascii?Q?d0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFH?=
 =?us-ascii?Q?RUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhBYndC?=
 =?us-ascii?Q?bkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3?=
 =?us-ascii?Q?QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FI?=
 =?us-ascii?Q?SUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFC?=
 =?us-ascii?Q?eUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElB?=
 =?us-ascii?Q?WHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1QUhV?=
 =?us-ascii?Q?QWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|PH0PR18MB3894:EE_
x-ms-office365-filtering-correlation-id: 97776fd5-67db-401d-1e41-08db5c1218eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKtNf4qJLer90uBeubrsTFIyqpWOE4B4JyCI6iIhdNRQBVC8TfiCvvdADALMPsh5+G5wdDGFg+g++IRHoaDAFUvQ63YOSo8yrKD0tA5Ks38xUMOrDby5KA4+GFMp6Xbv2FEivXZ1Nn6yigw6z/K3GQqGdO//ArxYI2K9dyCOO8EJDB6mEpLE64XT2iW+eOIYrQ6T8/X2dpMroMIWmJJ0ZS7lubl6dXeOZtNibiOjzETSaoPGdlorDp/7TyxhojKT1q1PjzDyA3X8W4ie0ThuPsQ6xpM441dMxR9qVo2ZtDKF4ESk/8usBjK3Ovi58IHME9RKUUS69npq9yU3kyzTe8yZg4DGri8YHZrifQIh4loYkZJ2ucVA0FktK22Ias0v8PUXaxdxzr/pVmDkb79ir8UAA/wzgmQgrXj7OO8P3+LuMH8ihEBPsEMYOiNfRcC/pfMnE0pGtqgIF+RNmvH8CCukb8P5wd0mOukvTJIg/HZ9FgrqDUbc4XXWbulpPYoeX4ArQLh7xXFxIat65LOJO+RR0wdpXaOJj7AF8GvYT6IPOEXh4vv/Igh6b6gSK3fzoWBup/tTnoYuLS3SxlQHlRSwbohc0g/z68FAvU6KQ9u+wjRHBqYAefvNKtYpSNPE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199021)(33656002)(6506007)(9686003)(122000001)(53546011)(38100700002)(186003)(83380400001)(2906002)(55016003)(316002)(66556008)(71200400001)(66446008)(76116006)(66946007)(4326008)(66476007)(64756008)(41300700001)(7696005)(86362001)(110136005)(478600001)(38070700005)(8936002)(8676002)(5660300002)(66899021)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d6BN3GTOPONF+w3E4Se6nvaIFtIuS7YDCiQnsIzuujdqENko8XxphG3FuOIK?=
 =?us-ascii?Q?2vHAZ61Ok+ZV9/6AkK+BIqTSAaeQBpJDuf4xGuTw9sl+S7XDDhZoXuCppPxf?=
 =?us-ascii?Q?8M5At2WtOTQ51k/AoonwYwZzGUSwtUxqt1zyZnfzwlY+rtmWW+/Mk3AQQapN?=
 =?us-ascii?Q?gXSyCwVjl7Y5Z0FS48Wvu+B59qbr8HiPHUQp4PrICMTigA3CMO4rZD/pLpyk?=
 =?us-ascii?Q?wMXko/ZD9FQIygk8RmVpqFLYqgfg47gLZCjS2pYrNQkosHL2FsLtezb2nfJD?=
 =?us-ascii?Q?FeJDTy4UQPETSxhpNmU38ydgbK1hrobrMGQH7kEldiTfoKSUlwMA20v9cCf+?=
 =?us-ascii?Q?fOlkfsn09WKj6WTb1/mkx5OJ0AJjr9LXCSPuDAFFR4+0f7dYaz2xPhPxsf8A?=
 =?us-ascii?Q?ZyoxrB4oSo/X1SAHsHJQbbUL2gXddkHEEgjuvzmu11I9CvT6jLz3b2vLT7KB?=
 =?us-ascii?Q?EUbG3IhL5eV6IlcBsM3XHp86rbxlxwG3WrD533+fCWUIUHgf11Hp1PFfmD2J?=
 =?us-ascii?Q?9mNEWA6N4tUaDzFEr06PNSlUgD+HOyE3Erq0rpSRLi2aWaoFUA/KCqSIFZbM?=
 =?us-ascii?Q?YGOV1nDkRr2PLpYZQpVJSxnR8pJVEmub0vjwwC7VjZatR3TsVURdHr0+ditL?=
 =?us-ascii?Q?3RR1Z0zwHlcyu3i9Lb1hAtD51uWfcEpGKZEjLQWgfdD9IUZgYlt6jJyCThjN?=
 =?us-ascii?Q?vlX7uU134BGiy9rJATZFP80hV9KXbHOYuKhF38Alwtqu9RHzFSxe//wsAb1K?=
 =?us-ascii?Q?mY0w0C42moaJLeW970gDD6z6EPaOScftFpDZU4n/UalX8Fd/efdAZTI1lGvF?=
 =?us-ascii?Q?aEwyJiWJuXlnghAYXo1ajmOxAedGqiFpcASmRUh5nuHTL7i0D7MvXz7NGA+g?=
 =?us-ascii?Q?r5wDMrK5FNZvAuMeKjVamDmuCIIFdofV7dPql6OExZ6F6drh1QyGq2KitqN4?=
 =?us-ascii?Q?ItTAHjr1BBwZZXMQgLHlR56Bk8wmE1Xet2xysgERZG/oMPUvPHnYKeypryiV?=
 =?us-ascii?Q?on7bqn1O85XqCvXX9uMwD+/6zH6ipJ50QWvaj0quzAhXWhcEpWpMw26WlzSw?=
 =?us-ascii?Q?m1qKIolBnqyFouUH9S0tcfu8hBLz8xeQKpvQbli9tKc23zYFxv15nJ2X1Rrx?=
 =?us-ascii?Q?+Bk3GBR+TV3YF2pd2482+9M67Of2/rqI3aH8ll1VNO38Y2+SwKXKSZePofz4?=
 =?us-ascii?Q?/tFh7K0H5qYEbOfclATDmf5K6NmrFvV48thL9f0aCx32rmQABV6kF06dj+If?=
 =?us-ascii?Q?cIxL2mc9ASmhYpZ3uusj1kTFMhtBpssWSMMY6jCTEou5nIGkgRlMbsB9z1YB?=
 =?us-ascii?Q?Q6EMVtdSrsz+IxonwySl9Zszz7wR6TiTg2nQOYNX2o4nyDwDijdb5fSUbEkm?=
 =?us-ascii?Q?OT4IMlqC1Ulwgs7w6ECxyfr3LO48T9JMIB09PwfDhHrCVuE6vIl35x4XLCxB?=
 =?us-ascii?Q?WN12GqpIWCcKydeZwy9iaBovffkMb8j5Wi07PlYR4aUUC53YX8FclWOSH6CC?=
 =?us-ascii?Q?AWv0ldfo5EWvT2jX4NKBaYAPBGynO+XftGpWuzYaeEc6VC+uoTAe3FXy4A?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97776fd5-67db-401d-1e41-08db5c1218eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 04:48:19.9968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVj88fAMjqtbouGK1E/upv2HFnSgs50Lw0Tm9bB6igKtMRuVLvnUxAfcADot/1kUADUFHgC/hU11OUVfiD0M2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3894
X-Proofpoint-ORIG-GUID: MPJvcO8Dug77e8zeDdDHaDqHIL_2Q2j3
X-Proofpoint-GUID: MPJvcO8Dug77e8zeDdDHaDqHIL_2Q2j3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_01,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

> -----Original Message-----
> From: Mike Leach <mike.leach@linaro.org>
> Sent: Thursday, May 11, 2023 12:23 PM
> To: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; lin=
ux-
> kernel@vger.kernel.org
> Cc: acme@kernel.org; Mike Leach <mike.leach@linaro.org>
> Subject: [EXT] [PATCH v6 0/6] coresight: syscfg: Add config table load vi=
a
> configfs
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> This set extends the configuration management support to allow loading an=
d
> unloading of configurations as structured tables.
>=20
> The existing coresight configuration configfs API is additionally extende=
d to
> use this table functionality to load and unload configuration tables as b=
inary
> files.
>=20
> This allows coresight configurations to be loaded at runtime, and
> independently of kernel version, without the requirement to re-compile as
> built in kernel modules.
>=20
> Additional attributes - load and unload are provided to in the /config/cs=
-
> syscfg subsytem base group to implement the load functionality.
>=20
> The load attribute is a configfs binary attribute, loading the configurat=
ion
> table in a similar way as the ACPI table binary attribute for that sub-sy=
stem.
>=20
> The configfs binary attribute mechanism supplies a strictly size limited =
kernel
> buffer, providing better safety than other mechnisms, and also has the
> advantage of being accessible directly from the command line, and being p=
art
> of the existing upstream coresight configuration mechanism in configfs
>=20
> Configurations loaded in this way are validated and loaded across the ent=
ire
> system of components atomically. If any part fails to load then the whole
> configuration load will be cancelled.

Currently configuration load is restricted to ETMs alone, CMIIW. Do you hav=
e plans to
extend the generic configuration load support to CTI component as well ?=20

>=20
> Routines to generate binary configuration table files are supplied in
> ./tools/coresight.
>=20
> Example generator and reader applications are provided.
>=20
> Tools may be cross compiled or built for use on host system.
>=20
> Documentation is updated to describe feature usage.
>=20
> Changes since v5:
> 1) Possible memory leak removed.
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> 2) Reuse mechanism for reader code revised. (Christoph)
> 3) Unload mechnism now by name in standard attribute, rather than entire
> file
> 4) Mechanism to check last loaded configuration can be unloaded.
> 5) Documentation updates.
>=20
> Changes since v4:
> 1) Update coresight/next - 6.1-rc3
> 2) Update to lockdep fixes to avoid read lock race in configfs.
>=20
> Changes since v3:
> 1) Rebase & tested on coresight/next - 5.19-rc3 - which includes the fix =
patch
> for earlier configfs works.
> 2) Lockdep investigations resulted in re-design of some of the code acces=
sing
> configfs.
> 3) moved load and unload attributes to root of cs-syscfg. (Mathieu)
> 4) Additional minor fixes suggested by Mathieu.
> 5) Memory for configfs loaded and unloaded configurations is now explicit=
ly
> freed.
> 6) LOCKDEP nesting fix for configfs base code (fs/configfs/dir.c)
>=20
> Changes since v2:
> 1) Rebased & tested on coresight/next - 5.18-rc2
> 2) Moved coresight config generator and reader programs from samples to
> tools/coresight. Docs updated to match. (suggested by Mathieu)
> 3) userspace builds now use userspace headers from tools/...
> 4) Other minor fixes from Mathieu's review.
>=20
> Changes since v1:
> 1) Rebased to coresight/next - 5.16-rc1 with previous coresight config se=
t
> applied.
> 2) Makefile.host fixed to default to all target.
>=20
> Mike Leach (6):
>   coresight: config: add config table runtime load functionality
>   coresight: configfs: Update memory allocation / free for configfs
>     elements
>   coresight: configfs: Add attributes to load config tables at runtime
>   coresight: config: extract shared structures to common header file
>   coresight: tools: Add config table file write and reader tools
>   Documentation: coresight: docs for config load via configfs
>=20
>  .../trace/coresight/coresight-config.rst      | 265 ++++++++-
>  MAINTAINERS                                   |   1 +
>  drivers/hwtracing/coresight/Makefile          |   3 +-
>  .../coresight/coresight-config-desc.h         | 105 ++++
>  .../coresight/coresight-config-table.c        | 431 +++++++++++++++
>  .../coresight/coresight-config-table.h        | 151 ++++++
>  .../hwtracing/coresight/coresight-config.h    |  98 +---
>  .../coresight/coresight-syscfg-configfs.c     | 513 ++++++++++++++++--
>  .../coresight/coresight-syscfg-configfs.h     |   5 +
>  .../hwtracing/coresight/coresight-syscfg.c    | 101 +++-
>  .../hwtracing/coresight/coresight-syscfg.h    |   6 +-
>  tools/coresight/Makefile                      |  56 ++
>  tools/coresight/coresight-cfg-bufw.c          | 309 +++++++++++
>  tools/coresight/coresight-cfg-bufw.h          |  26 +
>  tools/coresight/coresight-cfg-example1.c      |  62 +++
>  tools/coresight/coresight-cfg-example2.c      |  95 ++++
>  tools/coresight/coresight-cfg-examples.h      |  25 +
>  tools/coresight/coresight-cfg-file-gen.c      |  61 +++
>  tools/coresight/coresight-cfg-file-read.c     | 227 ++++++++
>  tools/coresight/coresight-config-uapi.h       | 105 ++++
>  20 files changed, 2503 insertions(+), 142 deletions(-)  create mode 1006=
44
> drivers/hwtracing/coresight/coresight-config-desc.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-config-table.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-config-table.h
>  create mode 100644 tools/coresight/Makefile  create mode 100644
> tools/coresight/coresight-cfg-bufw.c
>  create mode 100644 tools/coresight/coresight-cfg-bufw.h
>  create mode 100644 tools/coresight/coresight-cfg-example1.c
>  create mode 100644 tools/coresight/coresight-cfg-example2.c
>  create mode 100644 tools/coresight/coresight-cfg-examples.h
>  create mode 100644 tools/coresight/coresight-cfg-file-gen.c
>  create mode 100644 tools/coresight/coresight-cfg-file-read.c
>  create mode 100644 tools/coresight/coresight-config-uapi.h
>=20
> --
> 2.17.1
>=20
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org To unsubscribe send =
an
> email to coresight-leave@lists.linaro.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611CF68FCF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBICKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjBICJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:09:32 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A60279BC;
        Wed,  8 Feb 2023 18:09:31 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3191uYPu024969;
        Wed, 8 Feb 2023 18:09:09 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nm65kydjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 18:09:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX3XyARapfdi/8S6kZ8wESL1ugCTPFOIg0pEmutBupDh5XLPsWChi8I0TdpKKaqCOkqZlQ1ymcmtUJRA3vSmQYIGEDVFre3v/FAeqLgwSeGnyuqzdQQO4aFlv5F+y7dXDy90+KhWBrwRduEPGyYcg58j5/DVxUOVsSqT0UCb8QVM2S6hqxTfNLPzQ9MM7wj06blmgqsszsGUdAXL9i1t/std3/I+BQaJ0+SQNfKLqMInHzZiYSV5kp3y+FjjbwycBQeL//bm10vTYALabLYhyxoAogs1uYxxC6ob4V1j3OnGNVDvbhdu79q5mtLDHlplN4fnhiKBGgy0zyb8ScPLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZKm7TGZ/pX2OLnaLSiQdioQBFrrh2zqp50e2JDMxl4=;
 b=KO/tBuOLNRUxqSArqUdboF60GqMYe4IIYREXCYnCbsK18K13bTt2kl6QWJ5AYHKEzo3gsbyd5VtI9J3OpllQgFcok7oC7uzrDldAkBwdb5FlBt4JNHSQT0nP4n0OFtOAiF+b/LolIxP06sDdjeBW8UYAnlM1j1+pW/Tic2TOPkeUdR/u2fzksIReB0odVvhKV7ES+zwad94+U3S1ptDccv4nPpYJYncB6K8evmTS+cvoKyx7pCv3YKZDcar/nMRoIJ+jvkuHk0kw8uJUJa85hZLhagcnJi9kRlENLSEdOtYXRVpgodXuFV7flSiCs34FEIxX5e0BaPZ9Puk3PuwqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZKm7TGZ/pX2OLnaLSiQdioQBFrrh2zqp50e2JDMxl4=;
 b=vLwFhI30mQfwpUFOrD1QOWgeEQo1q24LAkf2UV5QGCbuoEcOpUvmO97FpIjiLzsOZUQtgD9QDhmnM41fDKnLDddXTs1fkiK94Zn378Ng3n5TF1OLk9PmHsYVunM62COt3CR0YKRU45eyFyCpQfDgcgxjTwRPCe4mHwkf3yPsRGw=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by SJ0PR18MB4058.namprd18.prod.outlook.com (2603:10b6:a03:2eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:09:07 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::9c90:8670:2720:af4a]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::9c90:8670:2720:af4a%4]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 02:09:07 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout programming
 is within the limits
Thread-Topic: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout
 programming is within the limits
Thread-Index: AQHZPCt93Xej8F93+EuTg7ZQ9cdYSA==
Date:   Thu, 9 Feb 2023 02:09:07 +0000
Message-ID: <BYAPR18MB26792B48DF03593B3CFAF608C5D99@BYAPR18MB2679.namprd18.prod.outlook.com>
References: <20230208083736.1237256-1-george.cherian@marvell.com>
 <2f2dcb7c-e5bc-7e97-71e0-eebdc72fbd03@roeck-us.net>
 <BYAPR18MB267995FB55301778894B3334C5D89@BYAPR18MB2679.namprd18.prod.outlook.com>
 <20230208175547.GA3065515@roeck-us.net>
In-Reply-To: <20230208175547.GA3065515@roeck-us.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ2NoZXJpYW5c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1iOGQ2Yjg0Ni1hODFlLTExZWQtOWUyYi1jODU4?=
 =?us-ascii?Q?YzBlOTZmNWFcYW1lLXRlc3RcYjhkNmI4NDgtYTgxZS0xMWVkLTllMmItYzg1?=
 =?us-ascii?Q?OGMwZTk2ZjVhYm9keS50eHQiIHN6PSIyODc5IiB0PSIxMzMyMDM4MjE0MzIy?=
 =?us-ascii?Q?Mzk3NjUiIGg9InBSMHZWd3MzUGVwZ1ljWDVnbktjRkVKZnBSYz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhZSUFB?=
 =?us-ascii?Q?Q1ZkakY3S3p6WkFRTUR6OGhsVWFmQUF3UFB5R1ZScDhBTkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFHQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBMUZIM2FBQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQlFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBRFFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0JqQUc4QVpBQmxBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFkQUJsQUhJQWJRQnBBRzRBZFFCekFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB2679:EE_|SJ0PR18MB4058:EE_
x-ms-office365-filtering-correlation-id: da3bdb44-1d15-4d19-24ba-08db0a42a017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2M8dGKyfJH9fbmGq41yuRyyoOTSwTU+Mjg194G10EExu+HlHQt9wGnF80b5T/Kv4hzhfCdF1zZ1jr+Cx4t2jmbC1HMTe7Vnl3KQUpcDWM4b0yRv0sP3BQMAO4R8WIgeXx2P/bSSL/25AhDKR/5ZDGVfIfy/dfMVrygQW7G8wv+iTc7fNHLF0nJ7udp+UVbClB/6cxWWR0JKeQB2/RQyJo/tR3jQXFxLyZfaOCPZvJTvnux1XuV3dPvb2RsREBGv62je6MIXVjcAkCVGOpOFKPLe+vk6cnc0Ax6SscOeo6e4BIEFDedApfCWVK0blkLFHQOypjeGcGpiBCrpBrfAMhfJWzjhY0KE8jJJhduYCT5M8Dnw9vZUvLCXc3vXCAAVShVqj9a4C02kDjgpn7RGroPJDEneuBiOoYvcAotDesrhTL5zRUiNcMpzqZyd9K7AMBxqXsUg1ZOzeaAW3KUg71s5Pc5N8S4NGRO2wWA+uYQ5lFaISvocApz1pEguhJSgVs2IYZ1vc3IPukMhCgLAWM0Q+rHq1bbsBYUaV++coP5CYjoWYHtZaxul31caxtY6ZhDIBCcpIgQubzE5srgOIYyrBG+Z1BYdxpPudBMJK/Bl7xHvsTvezVBDzaBcbdTigrLeGNhwl4fiA+8Q4m//PVK3AdKeWoGPRZwrzZFaa6kUmesZvBLwW1VA1C8k9FETqQPxbYZEjwef+OfR7Gqxug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199018)(55016003)(76116006)(38070700005)(54906003)(316002)(2906002)(478600001)(5660300002)(8936002)(86362001)(52536014)(8676002)(66556008)(66946007)(4326008)(41300700001)(6916009)(6506007)(64756008)(53546011)(66476007)(9686003)(186003)(33656002)(66446008)(7696005)(26005)(38100700002)(71200400001)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tTe07zI8bKPmPzxemi/WCi9BwwRus2tGtUuZO3Cw7F/Ta+dxk4qvsBQhL23L?=
 =?us-ascii?Q?yhGWJfr3YwQ/NIDDdXHPccYFTmBbKOQW04sdMuJ24cUpyYJh4D+JVySx9S6k?=
 =?us-ascii?Q?sXJAjS1io1pPydNeUMxzBaH1XPFoGOplxfrjfP8BlcVODtB7i3frIaMRBwnu?=
 =?us-ascii?Q?kOkdx1Spt/dHZUboqVdpi/vhA8aLMVjzyCJm0vJ8Lmf3+iiNw9v7JLXNLAWY?=
 =?us-ascii?Q?ycBFfO9fdrZpFnFGbWU6ECRbFpKMOYvGRsw2ybII7v2jU4n2zGe92T8k62Bo?=
 =?us-ascii?Q?34hHhEbf70914IdNTiZPCakBQHZhYeT40nblmM77p7q92WjDRzr1a+BP9p/6?=
 =?us-ascii?Q?NTLJIJIR86HCfuorxylIH7NBqLsTdNjz/ZEmkpfpbY8cNOTvyBF1o6Ss6A7R?=
 =?us-ascii?Q?TOsJcIxMjfq3DYPS4Vk+lJGZg51CWLlD9D1MH+vXsWYutZTb8xBZqGeh7dXG?=
 =?us-ascii?Q?D8tjibb2qLtG3EHZEd77MpfPlbLPCIyxDJyBvwxx4gbvbo1L1SvNcUK3AmhM?=
 =?us-ascii?Q?QHIXafxeLmddu3QYbWtLm9K0je8DHUB3eO11NsLPEbgRg3mFQc9Yyraxdd7h?=
 =?us-ascii?Q?jmy2zd2KJwiAkLKf/zwKC/KUVnWb89S5idddESDsG1wvhMAZ0U2oLgvq+d0l?=
 =?us-ascii?Q?JhHIt0yzchd0gL9tF9SuCQW5EMPBnmiG+W6/j8hilbaJDMGOkO/5/Xp59pdF?=
 =?us-ascii?Q?pHR5z39o1/jDHWzpLmrWubivQ8jaMIgPXkB1N8w7wKSdI0MR6A3OBhgE1YUi?=
 =?us-ascii?Q?eOU+LObDYhm6lzOV3WwttdP9EFqzTZgWwZAZ7rffheEPzISUa7+0Plw1ftxb?=
 =?us-ascii?Q?SotyozDIzsxgqKbS23PCKMLgtsOg2zTY3E2OM8GlnSdFAxKqtHPq2yaK0eY5?=
 =?us-ascii?Q?yVu3uhHZdG261keT4DhIYb57MDxNjRYUwgA/ple9eNRK5uypuSSYwTR8sk/q?=
 =?us-ascii?Q?4UicAddDwROj/Pb821/6yIbjmJNDvPQEQhM8jOJzi4t07sb3JYD4G/pKxU/r?=
 =?us-ascii?Q?/mpoV+lRBeGmIFEus0PNVl6QapXZ3IXQ8T7D6g/iqvfpAql1qL4OQyWQGood?=
 =?us-ascii?Q?loBERhPH9gmVX9S6n+4mUucrlO6DSSVAY1VqxRMZ4CmbbdN254fkDTtlSJ7r?=
 =?us-ascii?Q?+MFxvb71/mkVhVI7txc3HTQRdchyLNn0nAdHmBue5lj32R/5OzbA1yD860Sc?=
 =?us-ascii?Q?98AfCP24hX+xvlGgFC0WZ3EbiXIEopTkNbA+zHKyKHhZfR70D4voXtSjzHBG?=
 =?us-ascii?Q?apsx/V9QaWAT5nEvz3h7YoQG/2WACYcJx3Ny+/x7WeKZQZqqcm5YSKNSxLm4?=
 =?us-ascii?Q?bNDenPJBj4SD9iChHsBPAVgdBa8CIRPK1W8YUFj0UJVwlQoipa5dOcPQwug3?=
 =?us-ascii?Q?hoefj91p3pXa2/6IIBz2RVM1fRPLRiSZ3GVHQxmCOp90k/f+JIHGbwDbTNy8?=
 =?us-ascii?Q?ToWkVWGa9JGTPeBiNB+m6w9Am65klWjPyqtGue03gleopYLtHrWSXV0Iw0nm?=
 =?us-ascii?Q?D5u+HCHKaj1/DWEaKz8MFNaTiXZo0WHpaG0PRso47a006BPyEAzVJUU2O3Kv?=
 =?us-ascii?Q?VvPpKzU31W+ANyPas+eGfoEI/WfYQKeFigv8D+99?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3bdb44-1d15-4d19-24ba-08db0a42a017
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:09:07.2422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPQvZ3/ORC7kxJ5rl3PwVb3PQnaJh1L007VH971MHifcB1XQkFshzJElKqRKCdVgaDwGtRQIY/JQ0SJoV8DH+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4058
X-Proofpoint-GUID: WonbXGvU_WFMhtO-2fTFrhd6nx_BSXfF
X-Proofpoint-ORIG-GUID: WonbXGvU_WFMhtO-2fTFrhd6nx_BSXfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Wednesday, February 8, 2023 11:26 PM
> To: George Cherian <gcherian@marvell.com>
> Cc: wim@linux-watchdog.org; zhangshaokun@hisilicon.com; linux-
> watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout
> programming is within the limits
>=20
> ----------------------------------------------------------------------
> On Wed, Feb 08, 2023 at 05:20:34PM +0000, George Cherian wrote:
> >
> >
> > > -----Original Message-----
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter
> Roeck
> > > Sent: Wednesday, February 8, 2023 8:41 PM
> > > To: George Cherian <gcherian@marvell.com>; wim@linux-watchdog.org;
> > > zhangshaokun@hisilicon.com
> > > Cc: linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2] watchdog: sbsa_wdog: Make sure the timeout
> > > programming is within the limits
> > >
> > >
> > > --------------------------------------------------------------------
> > > -- On 2/8/23 00:37, George Cherian wrote:
> > > > Make sure to honour the max_hw_heartbeat_ms while programming
> the
> > > > timeout value to WOR. Clamp the timeout passed to
> > > > sbsa_gwdt_set_timeout() to make sure the programmed value is
> > > > within
> > > the permissible range.
> > > >
> > > > Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version
> > > > 1")
> > > >
> > > > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > > > ---
> > > >   drivers/watchdog/sbsa_gwdt.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/watchdog/sbsa_gwdt.c
> > > > b/drivers/watchdog/sbsa_gwdt.c index 9791c74aebd4..ee1039a652f1
> > > 100644
> > > > --- a/drivers/watchdog/sbsa_gwdt.c
> > > > +++ b/drivers/watchdog/sbsa_gwdt.c
> > > > @@ -149,6 +149,7 @@ static int sbsa_gwdt_set_timeout(struct
> > > watchdog_device *wdd,
> > > >   {
> > > >   	struct sbsa_gwdt *gwdt =3D watchdog_get_drvdata(wdd);
> > > >
> > > > +	timeout =3D clamp_t(unsigned int, timeout, 1, wdd-
> > > >max_hw_heartbeat_ms
> > > > +/ 1000);
> > > >   	wdd->timeout =3D timeout;
> > > >
> > >
> > > Wrong order. wdd->timeout should still contain the requested timeout.
> > But then the requested timeout is not being set in HW.
> > Isn't that a disconnect?
>=20
> No. The driver is supposed to set a timeout no larger than
> max_hw_heartbeat_ms. The watchdog core then takes care of differences
> between ->timeout (as seen by the user) and max_hw_heartbeat_ms and
> pings the watchdog as needed.
Thanks for the explanation. Will post v3.

-George
>=20
> Guenter

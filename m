Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781B36EFAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjDZTQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjDZTQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:16:02 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18848EC;
        Wed, 26 Apr 2023 12:16:01 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QHhQhK008288;
        Wed, 26 Apr 2023 12:15:38 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3q781hretq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 12:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2vt5DAXq7OsmE5Bf4pZivsrBUj1SYF41Lt1ndpXKTtrb4yUI0Eh+26lOYqyMevvoLlkWcYlZYqDwh5WbqOG3qMh8hXyhxDVFu9iVL8RFQCrBKijDWCm2SNBrCL8MI4L17VbAoGzJrPKWacegHnPfX1US1VZMTXo98++qJAf23MCcKjcJCoGA0kj8KaiGSHOpsF46d2agzp6Pbu17fhmkXSprl9dK80LRyvY1sdfx8MP4cAKS6gTo/+HbZd0bLGsia6P9d5NdXIDjmaPkARRMtekj97/ptd50ytZrnNsx4LKoC3UWwETVN470n5mOjjyl9HVECjDSjO9YEMi0siOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQe3yQ4eNDRIafPm2juS9XIl38S7zNnAga068743m0Y=;
 b=OV4WxcWHExtPIKyi7tRWSDba7O9s/GODRNDxDxrROkwgJoqU0BI3VE3TAkUwXkmTxcU/8asuJz4TqWmYQXx44Bh6XeH8rELvzSjV01A6ueinf5B385ZoF84uHU/Qo3Gxw9DwvQT+WUUVUo1f3OjUxj81rhjT3GHLsNihrs5FhRUSD9xzXkUL/1EbVDcdI45c5AhjRNN3GqtItkkZe4yqhzCjU4uJ4+3FqfcDav2c75ZgTTwjKWbujAMCXAdDw8UF43v+mGIHTZujn8/0yr/pWXMgksPzMELBk1OsXpeWNoUcdDgTqySy6qssZfmhR9lm/YXgqkDAgFuyeOUy6uaRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQe3yQ4eNDRIafPm2juS9XIl38S7zNnAga068743m0Y=;
 b=i65kwEewp4BK8XousyYscrTFGxMudOGOq+ICIKqhicZFQs4rogCaCcAxNDa4LBHuBDbD76yQZ77/+Z1YudekQRIiNNJg9AdoGILUK3ZoAnub3fa+GrKp2hPpGJKIqA/P0sHSggwjUEMBP/e66srJi0UrL9reVXkjBnjOrI4CLAc=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH0PR18MB3830.namprd18.prod.outlook.com (2603:10b6:510:2a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 19:15:35 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::aeac:c6a9:1987:57ea]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::aeac:c6a9:1987:57ea%3]) with mapi id 15.20.6340.020; Wed, 26 Apr 2023
 19:15:35 +0000
From:   Sunil Kovvuri Goutham <sgoutham@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: RE: [PATCH 2/2 v3] Watchdog: Add marvell octeontx2 watchdog driver
Thread-Topic: [PATCH 2/2 v3] Watchdog: Add marvell octeontx2 watchdog driver
Thread-Index: AQHZd06wDxIA2GK0akO5TgOnuvWk1K899qLg
Date:   Wed, 26 Apr 2023 19:15:35 +0000
Message-ID: <BY3PR18MB4737A9FDBEAF7D2C31EDC8E6C6659@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20230425081926.9234-1-bbhushan2@marvell.com>
 <20230425081926.9234-2-bbhushan2@marvell.com>
In-Reply-To: <20230425081926.9234-2-bbhushan2@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2dvdXRoYW1c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1iNTIyNmU1NS1lNDY2LTExZWQtYmVlZC1jYzE1?=
 =?us-ascii?Q?MzExYThlYjBcYW1lLXRlc3RcYjUyMjZlNTctZTQ2Ni0xMWVkLWJlZWQtY2Mx?=
 =?us-ascii?Q?NTMxMWE4ZWIwYm9keS50eHQiIHN6PSIxNzMwIiB0PSIxMzMyNzAxMDEzMDUy?=
 =?us-ascii?Q?OTQwNTQiIGg9ImtObWFWTFJjOXk2YnJ5dzRBRlVzWTNaYmdWOD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?RG1mSHQzYzNqWkFYQTZIZHo5WWY1dGNEb2QzUDFoL20wT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBYWk1eElBQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQ3dBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0JqQUc4QVpBQmxBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHTUFid0JrQUdV?=
 =?us-ascii?Q?QWN3QmZBR1FBYVFCakFIUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdC?=
 =?us-ascii?Q?MEFHVUFjZ0J0QUdrQWJnQjFBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH0PR18MB3830:EE_
x-ms-office365-filtering-correlation-id: 928d0a98-ced4-4009-43b7-08db468a9cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: royzLfWlcswmpDfMjpLL0TFZ4OiPtekqLJDyCkTBQlGAYDjxzre5M7+Dol35qT6rY90FgdDodQh0oTolcGLbZ4rFDjpxKUsShcv7l/bdv3/j2CllZA9A1SeBzM6v5uPZbtRMcsqYI+pHzFLy7FvFHfnxP3bZ78DC7OdXw60GA2Ub8PntoTsUyM12kd4qdeJJu3xlfXlWRQc6Y5tXh25T7oDRmIG4+B9lEnujvtlEiUwodf2knZYEc8AA9AXfSRK4c0pefwvgkXit+mItFHI+Np3Pfl6Je6sgfWXKnogp2aOldH1JLAHV69yNEC4A0fGy3/r8QdKQ3gQI7iFW/RMPMkZ4/IsgwLbHN61tByWDjx5U3koX34a4ekDrvB64HYYlBphLEkRBQWt1gn5kCn8DmCNv0LvqNs0bhgS6PKiz26+zuXcbOYkkyhuVwPOf2Aw3voXU51axJctEmyXN99hq+eOtWBFQTJ/St+eosEiFhHjCU4QKOl2Z4ht2vk7ahilRwQOVgFTx3kSHxSb4PtuAm9za2s8yPjDI88ccA6miBX420avZ6Qp3bEvsJG1EUbcopH4v1Q+C9bwXR/qejzd3DeEbqePUqgBMVPGpfsCtN2Mzasx1tn5tK/MEIFnizvl6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(316002)(64756008)(66446008)(4326008)(38100700002)(41300700001)(122000001)(5660300002)(52536014)(8676002)(8936002)(33656002)(86362001)(2906002)(38070700005)(66476007)(55016003)(66556008)(71200400001)(7696005)(26005)(9686003)(6506007)(53546011)(478600001)(83380400001)(107886003)(186003)(76116006)(110136005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AqcBfHNBXHNOT7OJ1NclciToCuwYgiXWzGtyNfPe9/5uB/LhaE92l9IrdPD0?=
 =?us-ascii?Q?Vz3S50P421HSXKUtDbFIDxQ6/KrLiO3833Dz+T30NOsDPRuPWOBFevvfSxlh?=
 =?us-ascii?Q?h1IejDZn26hwfUX99iqSXqJEV9oxWJN74OXBe53/RsrGcOXCLaDUFIC6b/C1?=
 =?us-ascii?Q?0PMbvI7uz0tQw56MuZYsNQJFs1wc33qeILA8Elj0mo2/gzUQOHaKjHchQxa8?=
 =?us-ascii?Q?xU+4j1ixLVORynzmg8rBn47AwYF2lpiadfHevTd2Oxx7tsfn6OfCV9wRcId8?=
 =?us-ascii?Q?8gwZoYoihATtcgi+GLYdq9gtMb3u3E0x+o0Cg1Y+bvkR5Ph1j3Z2QGHGyLP3?=
 =?us-ascii?Q?7pNgL+FPaHRJrbJEBTA18O1ZdJrpJFhTrILDhgQK3yGPUuengbihbmBcy4DN?=
 =?us-ascii?Q?/Apz3qHHAiTOKl/ytbLkybfCrr8fyT/JV7MkaT/KQseYZHvKtLeynUprqmv2?=
 =?us-ascii?Q?TAOICMycZ2lpXtxBZIgnTruPRYWKrA3Gwof+FOtCfsrBxyXWKOq2BYBDXcE5?=
 =?us-ascii?Q?K+OE/FC0zajZZrVUxu5RfbTv95Rzrso2jk4ZyWnxZssovw4tfqRF0jie/XtG?=
 =?us-ascii?Q?K8KKPPMFEAK+ZTDE8te+fhMkZokbDZ6Dh/qcEVKgy2sicTHCH7lg4+VZ4KYq?=
 =?us-ascii?Q?gdREc+CZiVfB21ZXsqEnXxnh3Aby7I8jEPZxoILZv3V/Eclqi5ExVMOsa/0H?=
 =?us-ascii?Q?XFvmE45xn6ZZAHLhyp0Vq+wNAZLMeK3hOZIf/6Hp9i4HA8V7UeX0H2bcZ0ll?=
 =?us-ascii?Q?S/38Nh5vtubzShTrBk2CRzJVC+J++ijfADdoJ0gNpw9DU6mrjNFnIsCp1Jvn?=
 =?us-ascii?Q?Oeze3U5Ob5v3UCxBW/o4Dzy1X0nh+9JUMHr4/tYNi65H/6PygGC0Zfbf3pCy?=
 =?us-ascii?Q?z7bc8EvoJnVcPw++Sdc+Ar4QQn2o6/wwNBW3/ey9fQguiWEMuA+0V5spKs4H?=
 =?us-ascii?Q?zEfoiCI9Sl00i0gufjt+R3dq06lmuOp5Ym0CCyZ353wz4qdic6bcfrPvHpMm?=
 =?us-ascii?Q?9+vo+11YglnPrWbl2VzDV1bhQ6kzz8qHRroZ9ODOKuNutuwgWmQGzxktb973?=
 =?us-ascii?Q?hCx1vM+qRSU22Ft2XgLkiLt/f8wndbESzWpeIMimCRpch4+WW9huCJsT3Uwo?=
 =?us-ascii?Q?jbDBYkbUWXyBpMpjPRrU+sT9+rVFaujOGbCbB3kumJHVD1+VNJwUTXqKFa11?=
 =?us-ascii?Q?5hQoPkPnlKtDbGhCJbVQAFknZ3DhOPvKG3ISJdkz5NFIwkXPh5JBr67UAw1Q?=
 =?us-ascii?Q?8osFQ2/WMvySojauX3+jlKp5UYWae1Q2LA8gynbySgHJiSYYtbHfyh+GRPx5?=
 =?us-ascii?Q?kHl5p7LbbIkxvWZrToPj46HuJGEyQOHCcAp+k5SkfCwbQDYykalCZTCcOmca?=
 =?us-ascii?Q?MGQtVepI9194xEg+fooHShac9Lu97CAnT6r99oblXx1VOLrywPuCwQLesTSZ?=
 =?us-ascii?Q?bIsEunVRb03DKT6wpiBtv1Br7eEg+OXhXB/YnZDKYZs9mpVzYvDzGcAr9F7A?=
 =?us-ascii?Q?sqX7xzzqFt3VMTQqd441HaZVeQk8uqLDb1dKmhmAMm7gSc6NoesTU+aSlMQF?=
 =?us-ascii?Q?vRZY8PAUAj7Fa1QgfTefJASBgS1NJNKqmipqsWxA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928d0a98-ced4-4009-43b7-08db468a9cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 19:15:35.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1tQT93JVnYhYHuXLYBWRQrCkvuIOK/Mw8cMOxuL0+uPF3mPGXzdpAZPWpCRrVlvJv4V6Ww6WpO5JYVM8a0FKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3830
X-Proofpoint-GUID: vTmDJfhJRAnbAE40pIgk7rGhJ4AUJw_B
X-Proofpoint-ORIG-GUID: vTmDJfhJRAnbAE40pIgk7rGhJ4AUJw_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Tuesday, April 25, 2023 1:49 PM
> To: wim@linux-watchdog.org; linux@roeck-us.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>
> Cc: Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [PATCH 2/2 v3] Watchdog: Add marvell octeontx2 watchdog driver

Shouldn't this be just Marvell GTI watchdog.

>=20
> This patch add support for Marvell OcteonTX2 watchdog. OcteonTX2 Global
> timer unit (GTI) support hardware watchdog timer. Software programs
> watchdog timer to generate interrupt on first timeout, second timeout is
> configured to be ignored and system reboots on third timeout.
>=20
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v3:
>  - No changes
>=20
>  drivers/watchdog/Kconfig         |  11 ++
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/octeontx2_wdt.c | 271

drivers/watchdog/mrvl_gti_wdt.c

>=20
>  # X86 (i386 + ia64 + x86_64) Architecture
>  obj-$(CONFIG_ACQUIRE_WDT) +=3D acquirewdt.o diff --git
> a/drivers/watchdog/octeontx2_wdt.c b/drivers/watchdog/octeontx2_wdt.c
> new file mode 100644
> index 000000000000..564a1ba2bf21
> --- /dev/null
> +++ b/drivers/watchdog/octeontx2_wdt.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell Octeontx2 Watchdog driver
> + *
> + * Copyright (C) 2023 Marvell International Ltd.


This should be just "Copyright (C) 2023 Marvell"

Thanks,
Sunil.

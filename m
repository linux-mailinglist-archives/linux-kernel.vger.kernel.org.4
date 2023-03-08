Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F76B0708
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCHM0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCHMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:25:50 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF25F53D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:25:30 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328BTdcv029079;
        Wed, 8 Mar 2023 04:25:18 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3p6n7qgq35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 04:25:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqhXy4dEUPMaWSzUBGwVH3sL+A+BYQcHAjPQcPEqOxVXwpRQjqBsS1li+QeC2mpWng07CbLPoR14iBYIPGR5WbfHG2ymJxvtzdXzKPJhHYhVlSgiu4eztF8+8UgOOFQlIRXbBjM8qUnzkaoG7Ua/eZ3zMsRD7VLwA0o8GnAXdI8x8dlQ0E+XAq3BlaYfRnk0bi3a+3sdxlIgQWkInS1ntpTX/cEb44ugcEqF/0J/EtfpaKhtdCGXksOUANv7zqzJH2E7PtZJikQMYfH1qZ1SC/7pGCTb8mizmV7mzc6BtGgq3RVtPpXVGZCGYM1fn+5WfrgUT8AYvvkxlnM6B0i7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc/O800/u+DM4y0pFKknTbPiXPJnTmuTzLSI9pDjDeo=;
 b=CYplitjnSuogWFyWdecJumyd5Vi1Nw3tfTHR7PJyeQzFPH/Pcx0/6hZLTOWhSjEESZCDp28p9ifRkTHVl9STPN8thmsXQDdWgwcPpOFziL4/Xelcnf4BE5o/tBs1rHYQGd+VXecTbxrEOLFpPtbml/aUn16VVIMmIgShz88M6IyEc5gOYreWlQHfekektWGvyqZ0doZSOIuR9m1vnEY5o2Wy14fA8fhhZ4dwxFMtKQvlChl2ls+pivgE/1LwNw39YLIdbL8cP7DqWFxKPaZltj+wvzcqRBxZiwTuv0Hwh0twRWi1tRE1F1xl8gMBW7BGtCqP8iWpLpVYahBTWnCuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc/O800/u+DM4y0pFKknTbPiXPJnTmuTzLSI9pDjDeo=;
 b=ojFZHwmArNeGoiCv1lzZ23yAw8IsosgG/i3xmJakGmCZvTOdEMouEf1fuZVnDP+ei1Io4wg/JopOwjAH93DnORMPcEU2Afx1d2xqSDu97yNcY4uoBqgbksaxVrvy6gYOpGwciUVCPNEUkZXQmIXhrm4zDkapKZbmtRnTYglPack=
Received: from CY4PR1801MB1880.namprd18.prod.outlook.com
 (2603:10b6:910:7a::19) by IA1PR18MB5513.namprd18.prod.outlook.com
 (2603:10b6:208:453::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 12:25:15 +0000
Received: from CY4PR1801MB1880.namprd18.prod.outlook.com
 ([fe80::5613:d461:fe85:c11]) by CY4PR1801MB1880.namprd18.prod.outlook.com
 ([fe80::5613:d461:fe85:c11%6]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 12:25:15 +0000
From:   Rakesh Babu Saladi <rsaladi2@marvell.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: RE: [EXT] Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
Thread-Topic: [EXT] Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
Thread-Index: AQHZTpkfRmUXy9+RCE2hd17UxtuJXa7t2BKAgAL7jgA=
Date:   Wed, 8 Mar 2023 12:25:15 +0000
Message-ID: <CY4PR1801MB1880A1E3C8EE68B5484536238AB49@CY4PR1801MB1880.namprd18.prod.outlook.com>
References: <20230304125850.32687-1-rsaladi2@marvell.com>
 <ZAX9G5mqGqzTZZ5N@FVFF77S0Q05N>
In-Reply-To: <ZAX9G5mqGqzTZZ5N@FVFF77S0Q05N>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccnNhbGFkaTJc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy00NTFlZjNjZi1iZGFjLTExZWQtYWU3OS01OGEw?=
 =?us-ascii?Q?MjNmY2RlYzNcYW1lLXRlc3RcNDUxZWYzZDEtYmRhYy0xMWVkLWFlNzktNThh?=
 =?us-ascii?Q?MDIzZmNkZWMzYm9keS50eHQiIHN6PSI3MzA1IiB0PSIxMzMyMjc1MTkxMjAy?=
 =?us-ascii?Q?NDEyNzQiIGg9IjNSVUhKbjFHZFF1Ynp6VDdWaFFjTjB2WTQ5ST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUhZSUFB?=
 =?us-ascii?Q?QjY4bmNIdVZIWkFaaWViY3NNMCthcG1KNXR5d3pUNXFrTkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFHQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBMUZIM2FBQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFa?=
 =?us-ascii?Q?QUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWNB?=
 =?us-ascii?Q?QmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQWdBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
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
x-ms-traffictypediagnostic: CY4PR1801MB1880:EE_|IA1PR18MB5513:EE_
x-ms-office365-filtering-correlation-id: 8ee036bb-223f-4186-8b9b-08db1fd02bcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOsW1e25wlXK7c9ECrP9lsv7/OTZPBBpuXNeXWYMmynVeIIyAdk+o1y/Gz1HpC2YMpJTnhpi29q0NlTBe6ZCLefzdA493dD4SRizzo38sS3EvsW4P7bS8QWEtAtooytr4vJ2zDzgmpKi+otGwwPFHeg7h0zscB8t/RN9DDvaEISX1WQsDhIFVF6wSQZqKwwimSTiYc7ys9K8eE1S6Z13LG7YLVAkehIK2jojJ8EDpHdGJ2IpIL+7omN8OlXc6LmVGNqUFrHWmOt10idfmqOFkwfvCDF3ENvFHqZFIimlGyOI6id6EI0eeN98O0YWDnKBQ7Uz4Yp2qI4wPo66GFfwHuabk8NdbKjj/DqthKq5a54t/qQ8H1+8U9HbFs68ukeuzFtY6BbFM/MSDkKkdbUKJlq3tvF4JOhVGB/beXfo0E4PYoaANu3RdVvkOW5i4WpWMNQkeCCnFrkiH8X4cuWWEcgzf8jyWVKZiayjbYnjxG4Sc/JdpI6zsR1gBLHHjKWNjj/KxQr3bIC9mbEDc6PVJy3n1P6GdxYlJX9wnSa1R0sk71JjPVjnRDgj5Y+BjTBTQ+vLnzPXdDlG2v9jAHkHzaTqZlBwf2zfmdhLCr7sFu1sbpgvJMIv2ea6qWwO3KltOOKVvMwzy7p9i2vpYULhDyW9/8J4ifRGR/ykq4k0LDUmaolr5jN6/G3/KZkHJr2c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB1880.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199018)(83380400001)(66476007)(6916009)(66556008)(66446008)(64756008)(76116006)(8676002)(66946007)(4326008)(55016003)(9686003)(38100700002)(186003)(122000001)(38070700005)(26005)(966005)(33656002)(54906003)(86362001)(107886003)(478600001)(316002)(53546011)(6506007)(71200400001)(7696005)(5660300002)(8936002)(2906002)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dHVXWUT5P/Qk7kFop0sFnQk1oMPk5fUYdAgd3qJ/dn3HoPxTw5i6qDTzYiK1?=
 =?us-ascii?Q?qTFR65jOF4RIrnHvo/y/iIuvN4rvex1VuaWMGy9T+aF5Th5s98qWKknQ9cdl?=
 =?us-ascii?Q?0v5xkmd4KmWYiWxgY3VtY/pO8fi+fPx5H49ci6xecCdPrYW2n9AHRjoflp82?=
 =?us-ascii?Q?fiXQxqoJ9MR5sJfGCQHxndgPPyIW9WeKjwOZ4DWo7AUUwGJcLz0Qv3tEMPnP?=
 =?us-ascii?Q?8dWtsaRE0e3gi8BCEffZHKRZPoGn8dFAlyv9YCxHNizOwKI2OGLtQLZEICid?=
 =?us-ascii?Q?45IiK04anYL7cF3Tm8VzQ0qeKN4epWwVKfMkqAwypyNc92L2KIGagqfXZz8l?=
 =?us-ascii?Q?VxfvIbPvbRcBdNwEHRY9zAqGrtvoCZxsh3QKlAiYJXy8Qkkgo9sBYyWoZaTG?=
 =?us-ascii?Q?ga2Og5BOVxaC7Wvbe7yyZfQft1ib0LLgeNJ5BcZb69jkUIiHnEyDg3VqyCOf?=
 =?us-ascii?Q?nf3HkTIJvHZlOmLkbjTY1yMljKTZ6dy7lLNCeqSZrqlxGNgSY/bY+USXW7Tw?=
 =?us-ascii?Q?e2G/q5LhyQktD0comE+v97LuzUElzaXScsbxOeTFgfDRJ/1HsT2eT7okayfk?=
 =?us-ascii?Q?o4oGIOjBMSD9jxrwdEDPIMtTfcwTBqHqGuq0Z+/QYDSB7Z19ma39O/HYEhiz?=
 =?us-ascii?Q?81Nuz4Fdir4cqNUKXm4XbNVgwsGmLWJxX0+EIl5gcDmHyXEq4MfEZtaQv/tm?=
 =?us-ascii?Q?CuBvhOpnL392cXt13AkZezY0kTlcTyBP569+fqoO/bQHXO/y1IeRVqGfrpYL?=
 =?us-ascii?Q?WnZRqqytY9jdgyf+myuL5e4CThBhyc5U4lhGXW6jSmnwj1s7uQHsOTaJr4nY?=
 =?us-ascii?Q?WDA6yrxkEriA1HWMxByIzVs77fZsNmMVuAB1V8ChiZewX3piWVeYL9722CjP?=
 =?us-ascii?Q?+rKbcBgD4fBg92Km2tMSVAl499qO+dbAWSz4UjEqXGcuEdWg7N/dObjuRAE+?=
 =?us-ascii?Q?yylO5Cvwg3KhC0OLZR9DbAPhEhU71Fo+dS9hMxsAda3WXxPoz7ZWzETNxyV1?=
 =?us-ascii?Q?nOyccyc2zUImYX+fLPx9Xw6i5N6Cx/Bkm9LYTFzJhf+oL6JJLD4Fm0sjCxKE?=
 =?us-ascii?Q?jFlgkiMbffVRWmUU58qyUkJxXIpVvKt9rSjBu2cTHzgSBzxdIluuqblYRzRL?=
 =?us-ascii?Q?6qiSU3Re+SfupI8k/BfVp3OXQgY8/7arzCu1mOxIrhcBDXE0SVHDIm69Qf2j?=
 =?us-ascii?Q?m1LrzYhXPGVoxRMcH+THE96rcgySW42P7a8OK8P/3SrhaBrAspzo/gz0fcbI?=
 =?us-ascii?Q?I9H1UkNnrQ+U2ypMCyRdYi+uQ+/ZVOivrOG5zvvQNSD1hsRZZH8ZPTRMdnYm?=
 =?us-ascii?Q?BRS35L/XC9ldfhOMdBa7Hf8AHtQ/XlhTEdQNyIeNqsqY/9SOyXIWQ04gmp9u?=
 =?us-ascii?Q?3UYUups9mV5XrkM9zDOhyQbbAdros/2za2lz2OZzISZb3GVpE1waC+mwcsip?=
 =?us-ascii?Q?Siwtcvr7vQGXvSQcmRp+qTKyE5gYJFcl12ktcCMsByhOj0YsVlsFP56Sw1z8?=
 =?us-ascii?Q?jmiqJMAuRTYsQvWwXjppr0eW+l0w9WfxuZZ3+ARddoOpDJ+YbUXc5t0sadLq?=
 =?us-ascii?Q?Fiq6XE8qy3lqNpJgndIxpVHnSVZwp4Idh5cNrRxw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB1880.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee036bb-223f-4186-8b9b-08db1fd02bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 12:25:15.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytJe1IJr+odoVZNmwVHke2slUIyrXJLeacERPIgcdhkGNkwo/L4nOY5qxhYKIcbmkssvzPoSWruShmW+Ri43rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5513
X-Proofpoint-ORIG-GUID: wO-9yoTLKGA_0p8pxCKV-H2GsfSUNKgk
X-Proofpoint-GUID: wO-9yoTLKGA_0p8pxCKV-H2GsfSUNKgk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_07,2023-03-08_02,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,=20

Please see comments in line.

Thanks,
Rakesh.

-----Original Message-----
From: Mark Rutland <mark.rutland@arm.com>=20
Sent: Monday, March 6, 2023 8:18 PM
To: Rakesh Babu Saladi <rsaladi2@marvell.com>
Cc: lpieralisi@kernel.org; sudeep.holla@arm.com; linux-arm-kernel@lists.inf=
radead.org; linux-kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@m=
arvell.com>; George Cherian <gcherian@marvell.com>; Naveen Mamindlapalli <n=
aveenm@marvell.com>
Subject: [EXT] Re: [PATCH] arm64: smccc: Add trace events to SMC calls.

External Email

----------------------------------------------------------------------
On Sat, Mar 04, 2023 at 06:28:50PM +0530, Rakesh Babu Saladi wrote:
> This patch adds start and end trace events to an SMC call sent from=20
> kernel to ATF. The start trace event prints the smc_id and the end=20
> trace event prints the smc_id and the time taken to process the SMC=20
> call.
>=20
> Signed-off-by: Rakesh Babu Saladi <rsaladi2@marvell.com>

We've said no to this in the past:

  https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_lk=
ml_20210923112058.GA14893-40C02TD0UTHF1T.local_&d=3DDwIBAg&c=3DnKjWec2b6R0m=
OyPaz7xtfQ&r=3DOrNjoyjPmqlDfiSr6RMDtAJU4gxiGfgzEtgbqDmoQPA&m=3Dfj6aQCqc0xOY=
gRMw7BGCVRrOEabi2taRuKl63gCdHras-JfpWCGhjp6HqaLZYj9I&s=3D1_EJt65j5EoyHhcroJ=
xJFMIkTqQY6jKtWypPIzmgYK8&e=3D=20

I don't think anything has changed, and this has all the same problems as b=
efore, so I do not think we should do this.
Rakesh >> Can you please be more specific why the changes are not getting a=
ccepted?

Which SMC calls do you want to trace, and why?
Rakesh >> These traces we would like to have for debugging purposes while c=
alling any SMC call.

Thanks,
Mark.

> ---
>  drivers/firmware/smccc/Makefile      |  3 +-
>  drivers/firmware/smccc/smccc.c       | 14 ++++++++++
>  drivers/firmware/smccc/smccc_trace.c |  7 +++++ =20
> drivers/firmware/smccc/smccc_trace.h | 41 ++++++++++++++++++++++++++++
>  include/linux/arm-smccc.h            |  4 ++-
>  kernel/time/timekeeping.c            |  7 +++++
>  6 files changed, 74 insertions(+), 2 deletions(-)  create mode 100644=20
> drivers/firmware/smccc/smccc_trace.c
>  create mode 100644 drivers/firmware/smccc/smccc_trace.h
>=20
> diff --git a/drivers/firmware/smccc/Makefile=20
> b/drivers/firmware/smccc/Makefile index 40d19144a860..e74c35191b49=20
> 100644
> --- a/drivers/firmware/smccc/Makefile
> +++ b/drivers/firmware/smccc/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
> -obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+=3D smccc.o kvm_guest.o
> +ccflags-y +=3D -I$(src)
> +obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+=3D smccc_trace.o smccc.o kvm_gu=
est.o
>  obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+=3D soc_id.o
> diff --git a/drivers/firmware/smccc/smccc.c=20
> b/drivers/firmware/smccc/smccc.c index 60ccf3e90d7d..7631a16479e9=20
> 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <asm/archrandom.h>
> +#include "smccc_trace.h"
> =20
>  static u32 smccc_version =3D ARM_SMCCC_VERSION_1_0;  static enum=20
> arm_smccc_conduit smccc_conduit =3D SMCCC_CONDUIT_NONE; @@ -59,3 +60,16=20
> @@ static int __init smccc_devices_init(void)
>  	return 0;
>  }
>  device_initcall(smccc_devices_init);
> +
> +void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,=
 unsigned long a3,
> +		   unsigned long a4, unsigned long a5, unsigned long a6, unsigned long=
 a7,
> +		   struct arm_smccc_res *res)
> +{
> +	u64 start, elapsed;
> +
> +	trace_arm_smccc_smc_start(a0);
> +	start =3D ktime_get_ns();
> +	__arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res, NULL);
> +	elapsed =3D ktime_get_ns() - start;
> +	trace_arm_smccc_smc_end(a0, elapsed); }
> diff --git a/drivers/firmware/smccc/smccc_trace.c=20
> b/drivers/firmware/smccc/smccc_trace.c
> new file mode 100644
> index 000000000000..6b94d5d9c0f4
> --- /dev/null
> +++ b/drivers/firmware/smccc/smccc_trace.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define CREATE_TRACE_POINTS
> +#include "smccc_trace.h"
> +
> +EXPORT_TRACEPOINT_SYMBOL(arm_smccc_smc_start);
> +EXPORT_TRACEPOINT_SYMBOL(arm_smccc_smc_end);
> diff --git a/drivers/firmware/smccc/smccc_trace.h=20
> b/drivers/firmware/smccc/smccc_trace.h
> new file mode 100644
> index 000000000000..c0ef836bc093
> --- /dev/null
> +++ b/drivers/firmware/smccc/smccc_trace.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM smccc
> +
> +#if !defined(__SMCCC_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)=20
> +#define __SMCCC_TRACE_H
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(arm_smccc_smc_start,
> +	    TP_PROTO(unsigned long smc_id),
> +	    TP_ARGS(smc_id),
> +	    TP_STRUCT__entry(__field(unsigned long, smc_id)),
> +	    TP_fast_assign(__entry->smc_id =3D smc_id;),
> +	    TP_printk("SMC ID: 0x%lx", __entry->smc_id) );
> +
> +TRACE_EVENT(arm_smccc_smc_end,
> +	    TP_PROTO(unsigned long smc_id, u64 elapsed_time),
> +	    TP_ARGS(smc_id, elapsed_time),
> +	    TP_STRUCT__entry(__field(unsigned long, smc_id)
> +			     __field(u64, elapsed_time)
> +	    ),
> +	    TP_fast_assign(__entry->smc_id =3D smc_id;
> +			   __entry->elapsed_time =3D elapsed_time;
> +	    ),
> +	    TP_printk("SMC ID: 0x%lx time taken to process : %llu ns",
> +		      __entry->smc_id, __entry->elapsed_time) );
> +
> +#endif /* __SMCCC_TRACE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE smccc_trace
> +
> +#include <trace/define_trace.h>
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h=20
> index 220c8c60e021..39588c3db486 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -358,7 +358,9 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, uns=
igned long a1,
>  			unsigned long a5, unsigned long a6, unsigned long a7,
>  			struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
> =20
> -#define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
> +void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
> +		   unsigned long a3, unsigned long a4, unsigned long a5,
> +		   unsigned long a6, unsigned long a7, struct arm_smccc_res *res);
> =20
>  #define arm_smccc_smc_quirk(...) __arm_smccc_smc(__VA_ARGS__)
> =20
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c=20
> index 5579ead449f2..3a3bf2d674a3 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -192,6 +192,13 @@ static inline u64 tk_clock_read(const struct=20
> tk_read_base *tkr)  {
>  	struct clocksource *clock =3D READ_ONCE(tkr->clock);
> =20
> +	/* At the time of kernel booting some SMC calls are called before the
> +	 * clock is initialized, in such cases it would lead to kernel crash.
> +	 * To prevent kernel crash in such cases this check is included.
> +	 */
> +	if (unlikely(!clock))
> +		return 0;
> +
>  	return clock->read(clock);
>  }
> =20
> --
> 2.17.1
>=20

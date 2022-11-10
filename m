Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236056237F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKJAHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiKJAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:07:26 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C386B1759D;
        Wed,  9 Nov 2022 16:07:25 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9MitbZ013916;
        Wed, 9 Nov 2022 16:07:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=QEpp4Gfl/o+y10IGBpFWtHrsbT53GC5g1IxmTXzp8kM=;
 b=s3RjIrWFIbX/HUHg11V9pqXw5XBLSzAHmLLrsSoLb7k4SnHXHSYIYDCqG3WEM7CA7f2s
 bD4olz3jXY5GbD1fh7VN+7CBqAfzsTA+sXoXu6XU8DhaCHFecrwxs2aYCd7Qd3sBlFmY
 GAeZtCwgbbm6nxIyki5+CwOetzZLJHzGKXAmIlcPWCfjvUJR6A2QEw5Kq9Ikfe9/dT3R
 8bF8NNHZQ65p6PkieVDHhGSsjM/QuXXRkkjEtbhC+9IVGDi0FPAxM27OD1lyai1nEyXD
 TQI1gU+lqxIozTKfDTz1ixw/g/Sha7yjqW5n+1WRWwsqsye+6NGsX/VTOjiF67G2DEBG Ag== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3kqkhh3qgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 16:07:06 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0049D40133;
        Thu, 10 Nov 2022 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1668038825; bh=QEpp4Gfl/o+y10IGBpFWtHrsbT53GC5g1IxmTXzp8kM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XRX4H0lY21BMKUo7vRniRC1ycXo4+pOk434KZac14qBGXcWrZbfLACCN8lf77BxBC
         lpKoqSOXWSAvgHSDD/wl+LllNnsKUZmk5OGPIM7lIWjPA078ekcUpWuu0Oa2oMaGWA
         Mg5CVvI9PlaF2y2leWN8cRUvjrw1GSYj43rUYI6gnF8jAgeQFyqhgBDDuvlH9uVQ58
         XosPGHyOakuzZwY8vJgJ5J/D2cEQDwDEx1y4uWMzlDAO3p+PyeOxGkUph/DmxJJgoT
         CxQN2VkKzMHPGBuX9Ip5bhSzxofNDZ4KivHFj5FMdDKb9ueUSwpid6hxSRVNtGvJhV
         bwfY6RxTvHEFw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DF1FEA006A;
        Thu, 10 Nov 2022 00:07:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DCDFA40052;
        Thu, 10 Nov 2022 00:06:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UOTzkVPX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmsRZcHbT1BsN7/D2VLYkUM8x2q37xlQjlG6SIxTtXMzgjrVFvEzTSN6YrHIMkZDPM2r9KKYwdzm+VcTlvSRrkMFdFSRwdtWxt26/6V/pKrdtuCdiYqyxzC+F2YFxGFOQ0Kq4As5jfmG0gcf6wdEj5U28nSWmmoyWUuKSVH83zVqGEd7wA9Q609YsCYtrufe4+5a0ext2u8O9ZxpCiQtXI1RBrTIIc5Ho7m1LQjBtGJPs76Hau2Ts4D6UXLgtZjJEQ2lmptGqNYk2mhU2LusK/boqOvIX5UMu1tgLFXLd6mUEZUf7aBDoFYS+feYIQRzBjHr0MeLmeRGK2rRUZeu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEpp4Gfl/o+y10IGBpFWtHrsbT53GC5g1IxmTXzp8kM=;
 b=Xmu5VL9Hxf7v9E+ordXoPzy8S46FeK4BXTmLmztjRsPwTCgRkNGfs62oyy40MDrbpX3C3i7Gt0gSQF40dKvKVKxdnwSE66reePGvxgQDDA3v9uItssUoN7QDrifaiZO26Kszi1dV8HTAzNDKm9BpHnacwu9y4OFtZXYp4alXHzipxpPFlcxjExYKMr+DUOFsnWM7KjaJF5GVd7j3762r7+noSIhOWXkjEm01eNzvb/UU82RJg9KAKTMWdjlN70KYSJVIE2r4qt0bH5I47uKu5OsHZ3/SfnVzw1AJso1THZ1A+fxmPzw10h8u2IGw1P22jVYzQufbMzNNdb7gCcO8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEpp4Gfl/o+y10IGBpFWtHrsbT53GC5g1IxmTXzp8kM=;
 b=UOTzkVPXXM51Wmk+rugGCgfKnNQxjs5v9+z5nL1dZ6TH0gSVYPGCUfkp15wymzvLnOTdZObe7Zwep5nIwxjdZlRx4vISv3vutFXMrp+FrxfzTmHwK0PzTmVCYcGOpCbycwv7ldV9YQGS5mSpx1sq7AFQq/XLpd+7yQRrv7oLnV4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 00:06:55 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f%2]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 00:06:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Ferry Toth <ftoth@exalondelft.nl>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Thread-Topic: [PATCH v1 1/1] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Thread-Index: AQHY9IlJN29tIhObE0O0gi/uwdEV+K43R46A
Date:   Thu, 10 Nov 2022 00:06:54 +0000
Message-ID: <20221110000643.xdoav4c4653x3tjd@synopsys.com>
References: <20221109221749.8210-1-ftoth@exalondelft.nl>
In-Reply-To: <20221109221749.8210-1-ftoth@exalondelft.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7564:EE_
x-ms-office365-filtering-correlation-id: 13018a58-2c01-4cc0-3d80-08dac2af79f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zebc2Qzz958xCmoDwgMDL/OxVODu1Z0gnEsWPQ5TV3Vo/c03X7qshxMhr/PPmQWzsV8r6dxObOODIHC0AkHFVnxYx4lSWauvy+0zKK+Qt7spu9R31YGsrcD10kUjl+J6ug+42GEUNpjhhA3UYSI9cb0aVOczUzKRPZrIhwa7v5XZNeBoLoLRsUEaaDo9KWXtqv5koNcza0s3Mcy5b72AcJtUXmMcxAG3MZTfcyTkwWYj2NcQIA34FNotIXr/3tnk1YGtvIFANzrUOIKn4LwIsCLs+KygiZtVt6Ka1kyeuZeuwiTF8kBGtoV5gCN+qDefFF+aIMLsQS4oB/iyS5RYi1/5I4Tp5e+sslclDeIFS+wU16TtBwzt2INbfaEH4XZ1Oust1X7RDWuZxs8e06Aade8INkb/37CRbKBB+gCtIJgEystXgeiwOQJ9D3zvpslQwy8SKgpzLdKOZvM3ZhhTbBAhhv9MlV70Gcu/cyUGd3Kc4ps7fWTCYEe/CsFFnvmbYxJuXyL9xaN1bBm303fg2HHsyRw3xcVSJI4sMlBwAW2gmi/lGlJsfUKBuyE4MJ5D/e5hDbFfpIuF+7w+8pgFjxRSrDFUtisMvd1MgqZmpslbqcoChq6v5YP2cZ3zjK30fjhbzDjNOrBBxiFErkLtya5APNm6Nc3xeoq21kR6g61jjrtw68OUIQ3nVWo4SUPmf4k4Lzxy4uWWUwL75iMTg9WY9hKTsvHS4ykTYEHcYTub+p5ndaaMAAY/SLaecHkI10w77oUglSWtNm4ZhjmeKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199015)(7416002)(83380400001)(6916009)(76116006)(5660300002)(66476007)(8676002)(2616005)(66446008)(66946007)(66556008)(64756008)(4326008)(1076003)(186003)(54906003)(41300700001)(6512007)(8936002)(2906002)(316002)(86362001)(26005)(6506007)(38100700002)(36756003)(478600001)(38070700005)(6486002)(71200400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0dzRmhVQkcyQTBkYlJEbXI2dzNVY3Z5ZlZ4Rjg2Qk1zcWtxRXNwYzJpbHNM?=
 =?utf-8?B?bENFZTFzWFpWcEh6VVNyVXk2VzF3RWt4Nk9wOTFnV2xJeExsWGRIRDVWdk1u?=
 =?utf-8?B?UG1jdS9PczFZOWp2bmd6cmxxcTFSSnlKcDBMSTlxN0VBK2ljZTM0a0VmekhL?=
 =?utf-8?B?TkZsZEZlZWJCMWxFeXhNcHdSdkNVbjlLR0pyWkc5WS9yU2lzMEVYYk9jR09h?=
 =?utf-8?B?aTh3aHZsVHRhNjlWcWt5VWZkTzBhbWhuVjR5b1hkOHdxTzd0THgra2JQc2Qz?=
 =?utf-8?B?b05DWjNZcWFmeVFZVGN4Q25BUXZoTnBJM2huMkt3anRVWGcrblp3ckl4cERh?=
 =?utf-8?B?YlZMVzdFdm5jZkkvNjJ1Rm5HQzgwWE5CdmEwcmpYRVNobERsdDB1VE1zaVlt?=
 =?utf-8?B?TWd1WXR2T3BZV2FQVWs5eHBBOTlsdUpHSlRFOVUrQ1Z4Tk15NHVNVkVMMm9S?=
 =?utf-8?B?VlNRVllVZnhVUHFBaGtxNlc0NXNJWllWUlpzWXcxNjJ2K0N3bjFDZ3pneFRU?=
 =?utf-8?B?dmJzanVvcXd6NzFyTjBydXZCdW9lQ1MzVU1HZXRBUDM0eExhYVgxQmcxaFA4?=
 =?utf-8?B?OStXZ0RoMHFMMXRRdGxqdnYyN0xPRzlBdGRMRjVLaTg4ZDBwYWJUQVBhcVNC?=
 =?utf-8?B?V1laRVdBaE5BQVl4QWEzMVpkMkhkZDhybi9VYTl6aG9XclQ1c3g2TzZnMTNz?=
 =?utf-8?B?SngzYzhXQ1J6OWZ1N1llb3JSamo4L1grK1h5NUNHRDFRbDJ3SU10UDJ0Q3NJ?=
 =?utf-8?B?K01SWllob1pvY1BFaGJZYllsT09ldGM0WWhLRnlyUXZhTUQydER6MjEvUXI3?=
 =?utf-8?B?OEtaTGlGbkFTVkI5MEd5SkxFL2plZXFiL3FDdG0xRURJSXhRRFg0bWtUeGZl?=
 =?utf-8?B?VjlQL1E3eStJY1JCSUxpc1Rib21BZDkzWUFFdjltWDFpMjlVYklqM21rN1JL?=
 =?utf-8?B?RDJkY3VnUTZjK3JKU0duNDc3SWtwaFVjWFE5c0tTaGxqcVVFSHZ3YXY4TEpk?=
 =?utf-8?B?Umt5QW5XVmpZVjl6Mmw5Qmt0bHJ5YVJnZG5XbGlMdk5lWlp4T3M1TVRReHc3?=
 =?utf-8?B?V1RxQUR1Q1Qxa0hUZVJpbmFGa2Vub3JwVlJYT1FEajAyckduWkpIaGRmb2Iv?=
 =?utf-8?B?bCtzYmRDRENTcW41b3psUHY5VCtvcDB1WUV4NHh5L0M1VDJIb29RNDYrOGJS?=
 =?utf-8?B?bWR0dzJVbSsrdDc3cEgzbFk3cUN6TTcvSlpoTFlHdGlOUUlYL2wrdFI2bG5O?=
 =?utf-8?B?NUU4WXk4Qk9nbUVvb2QrcHhyMXRYRkdXU2h6U01ONVRWTUI0TC9SWlJxRllZ?=
 =?utf-8?B?MmxVY2Q1NTJnOG82YlkySjNpZkFLOUp6MVVQOXJUOE1iaUhuRHVCOGM0Nk8y?=
 =?utf-8?B?T1d0WFBGQitxRXhHTG9RNWtrTzZlSGMvNTFUMDRJUGZQNWM3RDlFZ3I2SUNB?=
 =?utf-8?B?WEVZdGNjR3BTMjhmM2JwS0NPRm9sRWMzU1VnNk4xVFdnSVBET1JFZUx5M0g0?=
 =?utf-8?B?MUhmaVR5WFVGa3llU1AvNXVmSXkyeGhiTXc2Q3Z6dS9yc0xONU4xaS9EKzRt?=
 =?utf-8?B?Tm01NjBDYjY0NmZsTnNOK1lwTzlzWFByOEhvTm5LUjc1bDNxbkRseXJzdE9o?=
 =?utf-8?B?REJGelVGMWNhUnpoSi8vV2RFandGZnhXOWZQSTI0bCtncHphZnNSRXN3NGVF?=
 =?utf-8?B?TDZMVkpzYmkzQXkxUkFDdjJQWWFpdGxmTDhFOWpTRm1Fa0NRZXpzQ2hZUnpV?=
 =?utf-8?B?eWk1dkh3REV3ZGR5TEtsUW9DeFlxZi8xNlJjUnE4OU1hYk1Tdlp6TGVIVnlU?=
 =?utf-8?B?VGZTdlFhUTdiTStmNUgzWkhaYW9vY3VlcUgrb2xmeUJXOGNqVUhpTVo5ZWdB?=
 =?utf-8?B?MEdlc3NEMTdnUC9kNjM1M0R0NDhEN0xGMkt2RDVCV1ZtTmU3NjhWYmZwUGg3?=
 =?utf-8?B?Q01vc3VyY1BiNGtBd1pEajJTbGhHbFYxTmt6WW1PVEtYRkpPQmNPZjZBWENa?=
 =?utf-8?B?VGVNMEZWU0IxdnNLSU1DWHRKdUZEYmhmang5VVgzT0hReTN3M29jVm55bFds?=
 =?utf-8?B?dy82NVJMVjNCc1UrQlkyYVRQcC85M2hRZEZNUmtHUkZzdVpVK2RpSGwzUFVY?=
 =?utf-8?Q?QDaJOS4/j2YtVdZX4FlyIZTeL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9D96BEDA1A5C64DB3628372C0279430@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13018a58-2c01-4cc0-3d80-08dac2af79f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 00:06:54.7174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYH8fDwna7OfZSBceZ+4h8c64oaOeq6e09XpAK5PimBZXTl8j6SKN5vTma6tditVUKu+guIO6jx6g+3qE0Kp1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Proofpoint-ORIG-GUID: _wQBBbC1dyYJhCk9Ud1SZZRCTQDjutXS
X-Proofpoint-GUID: _wQBBbC1dyYJhCk9Ud1SZZRCTQDjutXS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVycnksDQoNCk9uIFdlZCwgTm92IDA5LCAyMDIyLCBGZXJyeSBUb3RoIHdyb3RlOg0KPiBT
aW5jZSBjb21taXQgMGYwMTAxNzENCj4gRHVhbCBSb2xlIHN1cHBvcnQgb24gSW50ZWwgTWVycmlm
aWVsZCBwbGF0Zm9ybSBicm9rZSBkdWUgdG8gcmVhcnJhbmdpbmcNCj4gdGhlIGNhbGwgdG8gZHdj
M19nZXRfZXh0Y29uKCkuDQo+IA0KPiBJdCBhcHBlYXJzIHRvIGJlIGNhdXNlZCBieSB1bHBpX3Jl
YWRfaWQoKSBvbiB0aGUgZmlyc3QgdGVzdCB3cml0ZSBmYWlsaW5nDQo+IHdpdGggLUVUSU1FRE9V
VC4gQ3VycmVudGx5IHVscGlfcmVhZF9pZCgpIGV4cGVjdHMgdG8gZGlzY292ZXIgdGhlIHBoeSB2
aWENCj4gRFQgd2hlbiB0aGUgdGVzdCB3cml0ZSBmYWlscyBhbmQgcmV0dXJucyAwIGluIHRoYXQg
Y2FzZSBldmVuIGlmIERUIGRvZXMgbm90DQo+IHByb3ZpZGUgdGhlIHBoeS4gRHVlIHRvIHRoZSB0
aW1lb3V0IGJlaW5nIG1hc2tlZCBkd2MzIHByb2JlIGNvbnRpbnVlcyBieQ0KPiBjYWxsaW5nIGR3
YzNfY29yZV9zb2Z0X3Jlc2V0KCkgZm9sbG93ZWQgYnkgZHdjM19nZXRfZXh0Y29uKCkgd2hpY2gg
aGFwcGVucw0KPiB0byByZXR1cm4gLUVQUk9CRV9ERUZFUi4gT24gZGVmZXJyZWQgcHJvYmUgdWxw
aV9yZWFkX2lkKCkgZmluYWxseSBzdWNjZWVkcy4NCj4gDQo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB1
bHBpX3JlYWRfaWQoKSB0byByZXR1cm4gLUVUSU1FRE9VVCB3aGVuIGl0IG9jY3VycyBhbmQNCj4g
Y2F0Y2hlcyB0aGUgZXJyb3IgaW4gZHdjM19jb3JlX2luaXQoKS4gSXQgaGFuZGxlcyB0aGUgZXJy
b3IgYnkgY2FsbGluZw0KPiBkd2MzX2NvcmVfc29mdF9yZXNldCgpIGFmdGVyIHdoaWNoIGl0IHJl
cXVlc3RzIC1FUFJPQkVfREVGRVIuIE9uIGRlZmVycmVkDQo+IHByb2JlIHVscGlfcmVhZF9pZCgp
IGFnYWluIHN1Y2NlZWRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmVycnkgVG90aCA8ZnRvdGhA
ZXhhbG9uZGVsZnQubmw+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvY29tbW9uL3VscGkuYyB8IDUg
KysrLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCA1ICsrKystDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQoNCkNhbiB5b3Ug
c3BsaXQgdGhlIGR3YzMgY2hhbmdlIGFuZCB1bHBpIGNoYW5nZSB0byBzZXBhcmF0ZSBwYXRjaGVz
Pw0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jb21tb24vdWxwaS5jIGIvZHJpdmVycy91
c2IvY29tbW9uL3VscGkuYw0KPiBpbmRleCBkN2M4NDYxOTc2Y2UuLmQ4ZjIyYmMyZjlkMCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvY29tbW9uL3VscGkuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9jb21tb24vdWxwaS5jDQo+IEBAIC0yMDYsOCArMjA2LDkgQEAgc3RhdGljIGludCB1bHBpX3Jl
YWRfaWQoc3RydWN0IHVscGkgKnVscGkpDQo+ICANCj4gIAkvKiBUZXN0IHRoZSBpbnRlcmZhY2Ug
Ki8NCj4gIAlyZXQgPSB1bHBpX3dyaXRlKHVscGksIFVMUElfU0NSQVRDSCwgMHhhYSk7DQo+IC0J
aWYgKHJldCA8IDApDQo+IC0JCWdvdG8gZXJyOw0KPiArCWlmIChyZXQgPCAwKSB7DQo+ICsJCXJl
dHVybiByZXQ7DQo+ICsJfQ0KPiAgDQo+ICAJcmV0ID0gdWxwaV9yZWFkKHVscGksIFVMUElfU0NS
QVRDSCk7DQo+ICAJaWYgKHJldCA8IDApDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDY0OGYxYzU3MDAyMS4u
ZTI5M2VmNzAwMzliIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTEwNiw4ICsxMTA2LDExIEBAIHN0
YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIA0KPiAgCWlmICgh
ZHdjLT51bHBpX3JlYWR5KSB7DQo+ICAJCXJldCA9IGR3YzNfY29yZV91bHBpX2luaXQoZHdjKTsN
Cj4gLQkJaWYgKHJldCkNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZHdjM19jb3JlX3NvZnRfcmVz
ZXQoZHdjKTsNCg0KV2Ugc2hvdWxkbid0IG5lZWQgdG8gZG8gc29mdCByZXNldCBoZXJlLiBUaGUg
Y29udHJvbGxlciBzaG91bGRuJ3QgYmUgYXQNCmEgYmFkL2luY29ycmVjdCBzdGF0ZSBhdCB0aGlz
IHBvaW50IHRvIHdhcnJhbnQgYSBzb2Z0LXJlc2V0LiBUaGVyZSB3aWxsDQpiZSBhIHNvZnQtcmVz
ZXQgd2hlbiBpdCBnb2VzIHRocm91Z2ggdGhlIGluaXRpYWxpemF0aW9uIGFnYWluLg0KDQo+ICsJ
CQlyZXQgPSAtRVBST0JFX0RFRkVSOw0KDQpXZSBzaG91bGRuJ3QgYXV0b21hdGljYWxseSBzZXQg
ZXZlcnkgZXJyb3Igc3RhdHVzIHRvIGNvcnJlc3BvbmQgdG8NCi1FUFJPQkVfREVGRVIuIENoZWNr
IG9ubHkgdGhlIGFwcHJvYXByaWF0ZSBlcnJvciBjb2RlcyAoLUVUSU1FRE9VVCArDQphbnkgb3Ro
ZXI/KS4NCg0KPiAgCQkJZ290byBlcnIwOw0KPiArCQl9DQo+ICAJCWR3Yy0+dWxwaV9yZWFkeSA9
IHRydWU7DQo+ICAJfQ0KPiAgDQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNClRoYW5rcywNClRoaW5o

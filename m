Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0ED6F6159
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjECWhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECWhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:37:38 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262376AB;
        Wed,  3 May 2023 15:37:37 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343J8hGv028188;
        Wed, 3 May 2023 15:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=9E1rpNML2/a7/SOWWSHs6g42ILTASDgBVDVwdoIpCgI=;
 b=iGB/DDpVIOUtuz/r+91H27tksZq79FX4c5+wEEVKFknvDnomLmuV4MQU6i1/klpC6zg6
 BHbo6EOoCDGEyT5OK6z535OVh5Vb4inu7tIjKDkB73ybi7qIuE3IjkeUugQydgd2gVyX
 URCfHmmybd8VVSrwbcc76fBg6skmEXaN7kojv2yu+8eBRslD6ZU/IztfMQ7SPg3+gnb7
 GsS4KLzko79HG4r210fd6vHoH2QRzHJ+wO5TqCxThOJe3BTSWPHPmkjSksp42SshvL0f
 D/7WRD2bNSsGatWfVjo2sq72tTJXua04l1OqN9ap4tuxgUxZcHfTyPLm2GMj0cH8GZ9Y 4A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q925xddq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 15:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683153438; bh=9E1rpNML2/a7/SOWWSHs6g42ILTASDgBVDVwdoIpCgI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YgdB8Jne1vC956m8wLK3ebQN4aM/hyEjzKvDFOGR5TGoAX9xJD+6C3D8LITr/0kMz
         QmaWCO5Iz5qHPDaE4SBVpIyjy7e6Lg62/4kxNd8rBJZaRqWGNujM60rEgE+4nOEGf+
         DNPLF8Ux/e+Y7IHdM63Ejxg7Pir0G7y5zwio/KKqWa9mQGmLhXZxYRnWYSphjwkYm0
         oLNvHKwiiMny01O/t08N8PRAQe5aHvudTHsUVN9mrvjr7z0qPwujxyoVDHPGJXdgd0
         RwiKb8l4Aypl6zLhJzvNnhJ5jR335SFpUlfQSrJerh3drI1utJjXyqBkjHbvKYq3Hn
         1DfinzIDna8nA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6A70A404D1;
        Wed,  3 May 2023 22:37:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 01C5EA007F;
        Wed,  3 May 2023 22:37:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=iQhlwekw;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AE5554045C;
        Wed,  3 May 2023 22:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvazSRwbtLcavXRWKJv6t6uTQfssPJI3fJ5wAAa9C7Q/4QWjebbDpeCb1FXsqqBWRQCpVRGTw62+8iQTUMzeCOwZKqY2jVAI9ZzNloYLZ+XaA7n6Of3gK83mgZCM7KWi+C3yU4zGkHHBgxv8DgZcL6oUWRWPvEwdLWWzk/FHKRnxZVevggrwwPsKly/3WSoTuC33BmrITXeJDKyf8G47yO2Q5OpsB8O4JAhedLVI8KiBouvSr+QrgbD7+KRQ87qORM8AeECtON3adTd9vkUEeuQWMi4yGUFVifKxTHAT0k4pq5M23eVbD08EG7nz/4bPEKinyhvl8EDxfs5SyuOm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9E1rpNML2/a7/SOWWSHs6g42ILTASDgBVDVwdoIpCgI=;
 b=OfnBCYMaMEo4j5OFz1txl9UPg5uqma1RS98mkM9tazYqRpftd0OLFsdIMsIQaeXmBWezJw7SzmRCwadRm0rfcX8DAgBfYXIgxXbsGW251Z1eueQcJ4nWbudRN/4I85HQO7/vn9qp421JszR5SDFk9ZvLDFncW3bisdefvfN/jWQGv7OqhE6/pQcPDN7fUIJB1Jo018JTOQLseC99TbaGKZks8CzSArg6QbcEUazVUHK5fUgNCYDzC3ssY+k59cQcmqDOMIek0lk+V19NOqLRXZnqDp7XAkoWk/FETKGeT5LpP8lU4godCIP6uU8ZlHgcaLFoc+CVyGh50sw/jdfIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9E1rpNML2/a7/SOWWSHs6g42ILTASDgBVDVwdoIpCgI=;
 b=iQhlwekwuNHBaPBHiDJeQNRCKJX367129x0weQ3RzbPiuFJ9pNaHSCe9mv3E21OMY4wifBL/njWMMiXaST1ukFFZe7allq4NdKj+4dSHBq3cnQXHwMWavZaSfYOcaUPrqeeWITwrg1eP9n+6YzJmS7gzlMy+y6UJnve2tXuHJp8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 22:37:12 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 22:37:11 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Topic: [PATCH v4 1/2] usb: dwc3: core: add support for RTK SoC custom's
 global register start address
Thread-Index: AQHZfLOqlY1W2Ii4CkekbWMOKFVBP69Hk6cAgABMHgCAAUZkAA==
Date:   Wed, 3 May 2023 22:37:11 +0000
Message-ID: <20230503223704.c3kccy74o7h3iawx@synopsys.com>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502223626.uyld3tv7d7fnbt7h@synopsys.com>
 <05bcd78a37e945528ec68592eb73d755@realtek.com>
In-Reply-To: <05bcd78a37e945528ec68592eb73d755@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4504:EE_
x-ms-office365-filtering-correlation-id: 957b2c16-5831-439a-62b1-08db4c26efd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M62PtJ6gJxvOv7P23M+30ANfW71lXbgvz2zKF4BFHE5pt1W244CJc+sit9j9r6vYQHpS5QSH4mGhIU1cXh1MeRbFweF9JtbqqCAY3vnsv3Df06f8k5NScRAwadMn53DO/rA9a9DyQpSyiCYZ3fWasXlS24ByBAsY++An+SHTt75DpC1HZUNDNXc3d6Ehe4tp6ueEUbEO1kwvw4F5AEIAUhQmwMQOjzhZPgs15tzytggIw4sl0KPXWwbH/KTAH63jIu3eKEac0LfF+f3BM6qU4Ohn/ixM/+AWfHr0qYnbOSvJxCGzMVtc84jO4puAi28TogjZAao1SNn4eLa/FgXNa1A8YPv84XeKgpSWas9Kn/4aPF6/vxXVO4Kp+Gl1UYaC14xz87BJhi2IkZiWVOAA2YbxQP9q6rp4YDCqeku2SL/e93kSZbbUlbVa/vNn5IHV8ZOJ1hqmumQCjEAV6/TWL7eFkxamdmRK9VmMP8lwUdMoDEs3+1uFnYUcENOIfhS/D5dLU4PYS3cCG//+2uxD4hyBhU7PeKshfmXIfl8kVeUMkmalq3wN9vkvHf55DMprD8NHOzeDO+jqcLlR9cKYIft5bJKSiKusqa4ydcR6wfBuHyu7PrJefGOM+3VqTrRAZQ249OqkS5sUeWXTsOMab0LT64IFVqeFEki7IvoOISA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(8676002)(8936002)(316002)(71200400001)(36756003)(6486002)(41300700001)(4326008)(5660300002)(64756008)(66446008)(6916009)(66946007)(66556008)(76116006)(66476007)(2906002)(54906003)(38100700002)(478600001)(83380400001)(86362001)(38070700005)(2616005)(122000001)(186003)(1076003)(6512007)(6506007)(26005)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3E4TG9LN1ZZMkp4Z3ArN3l5b2svUFBFUVl2eHdQcmJMdmUzb2V5OWZNTVNs?=
 =?utf-8?B?bXpvckhtMVh5eFBHemJKQnErdkFrZEF3OUxYYTVjTEpobFhzZlJhejFza1R4?=
 =?utf-8?B?ZEhpWU1lM1JQcHhKSG1LbU5sdkJLcTlLSjg3TDJUY3FXOUNjQ042S3NqVzUy?=
 =?utf-8?B?eFdYcitnWk5CUVBPVVhrV3VQTXczaE1jcFFNS2lIQXNQb0dEalA3a0xRNzdp?=
 =?utf-8?B?ZDJlY2FFd1prazBnK1VpNEhvbHhCa2pFbjZUa0xQMDdJVDBxdnRzdzFtQTQ5?=
 =?utf-8?B?bzNLdWJwZlVQNm1Tb201V2Ryb2NWajgvc2VFTGVkNngrT1llOXZvVEpLSkpi?=
 =?utf-8?B?MXo3ZW1mU1BYV0JZY1c2VG9HaTdSTlV1ck93WkJzY3UySnE1aTB0TVFpUURs?=
 =?utf-8?B?cW04dzhpUTBlNDBjZUt5MFZmbXcvaHhHNTk4RHpJYzBXcTJJa0NxZUN1ajI0?=
 =?utf-8?B?NEdDOFhyVkRhUSs1YzhIdzhseHl5TWlrSmo0Nm1YdW8ralQyWjM0OC9KL1Na?=
 =?utf-8?B?WGJCSittN0JBa05DNjhFYjRpQWY3ek5MVjhyUmxOU1VtT0tqeFB6K3prME0w?=
 =?utf-8?B?aFZLcDcwU0ZrUEpTQld4VWRsZ3Aza0dIQXk4d1ZwVzM3K2VCVjB4THRSRGgz?=
 =?utf-8?B?cG1sc01KZDRrU2lUVjVjL1NUakdqMVZsRkcxUllzRTJiY3dMMGpNc1lVazhE?=
 =?utf-8?B?VytLWmE4dVBIK1ZVcTZENWk2c1cvTHd3a0tNRjd3TGVmc2trSXEwaDNZaEc3?=
 =?utf-8?B?RnFVMFAyWU05VkJReUlzVWE0WWJOUGFXNVN6YTF6cGhnRGc4Vi81S2RZT09r?=
 =?utf-8?B?c3ZOZFVlUHBzcGNjZGFCYkRod2owbzlGM05NdWo0bkpRY0J6ZlY2Tms2aVZp?=
 =?utf-8?B?T2V6VWdvY2N5b1FUMlVicFF1TDBJNmlzUmhxRm0yMUNnY0VYWWVtUHFjSHNh?=
 =?utf-8?B?WDZLS3R3b2F4bUVJQ0U2Vy9XWG9LTmxsR1A3a0UxWnVaSklGd0N3cWNZUDdM?=
 =?utf-8?B?SERhMG5xdlJpRUg3QkdEVEtJemhZSmpnVXB0Q1FUcUhKam1NRVRrZ2VWcXA2?=
 =?utf-8?B?M0hIVmJSc2szcU5hdkZSYVcrdGg1VENXeGttZ2duTyttWEF1VkRrWUhCM3Zt?=
 =?utf-8?B?STltZnd4LzB1TUZ2R0VWOEtJVEtZVHlHcXU4NG5kR1VLbHM2ejN0OURjWHNy?=
 =?utf-8?B?c1UwR1lzTVZKdHA3enY0R1VCT3RHeFU0d0VWNFdXanFaMU1YUk5CdDJ2ZWpK?=
 =?utf-8?B?cFNaKzNBUVhUaHBSdmYyZCtQeHdBWU1hamNPNGQxd2pNaWV0RTY0MGJSYlZW?=
 =?utf-8?B?MTNpaVVKbC80akpxVk1CMFNEaWlyZTJVaUsrTDAyekxmMkJXOGtJcm9RQnNt?=
 =?utf-8?B?NHcyNmpBMkxBYy85N2lZYTRPeWN3cE5VeTg1bUtDdFUvTUJPRzh6TlY5NWlC?=
 =?utf-8?B?WVh5ODVsSldJVy9hQTJjVUR3UE9OOVJWaVo3ZW56MVdRMHJwOVhjK3plMitu?=
 =?utf-8?B?U1ZSNmxQVWpXUDdNRDA5MzA2bzlQUmlreG1BcnIxQjZXdk5jVmM5eGJQTW40?=
 =?utf-8?B?Y2dmSVdRTTl3bmFyRjJ2RDBtZTAyZ2c2cWhBY0J3REJhRVZtaTVPRVgxSE5v?=
 =?utf-8?B?clNlYXF0M0UzdUo0clBQckdFTUhFamlnb3FxbE1ibnNEeVVmR2RLa0VjL1Q1?=
 =?utf-8?B?ekR0THVCY0xZN3NpVDBuU0tjalJSN3FRVlByTWtzbWFqZWptamNIUlNxYTl0?=
 =?utf-8?B?LzdJaFRxRGVHeFgxNG9qN01aZjl5NDlHYVJsRnhCVEJuUDlrUGRxTzBYcmFE?=
 =?utf-8?B?OExZNS9pMkREbjFjaHJBVnErWGtuVnJEcVZCM0hmZlZueWF5L1NwQTFiM0Ux?=
 =?utf-8?B?V0VoVmtOSW9LUFJpcUpKS0xkSFltNCtsa3pQVG1JTlZrRGxZK2RZWS82bXN1?=
 =?utf-8?B?VHRPdTJUNVVqSzFuQlU3N0VBTmRsN3J5cFB4ZTlMMjlsQ0gyN0tMbXNzeGZQ?=
 =?utf-8?B?aHRNRFNFN01Ec1V4VTMzUnN1bGs3N3BVMjlyTlZHaXNoTU1PWXB3dkkvMUpj?=
 =?utf-8?B?RlpkWllob0RUZ1REZElrVmFkS2ZGVDYycWdmdm5yaG4wUkFtWFVMOWJQbWlw?=
 =?utf-8?Q?Z1lJpzTP2tFnxE06vF5uyfkVR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA970DD0CBD66F45A9223CAE1633AF32@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cG9SaWxrZCtrZ3pnWXBNdzcyU1pDRy9vY1pPUHBzQVU4YkllZ1FaSmM2eHVK?=
 =?utf-8?B?QXh5U1M1MDNPMkdqK3RPOTNYd2E5SmxCd3hhMmpGSHdqcEV1VllLL0RzeWhq?=
 =?utf-8?B?OUpVd1pXZG1lYzI2ekprRkNjT1lIU1JpTmJWQ0psRTJPeTNWU2VSMHordGJw?=
 =?utf-8?B?eTNXMzJGdW9Zc3Q3ekRaZWxsZEJNcHRSUXNWQXpXamMzQmtvMXZydWNBdXB4?=
 =?utf-8?B?eXJ3cW5hNXNhbVkrZW5RMkU1WXhGL3NMOXp2TXlKZURoY3JBRUp4a0ZuWWFZ?=
 =?utf-8?B?WnowK0pzRGc5UkRnUWhiT3N2SFQ1MFI4akd2TG95eDNiYnl1UW0zbGg2dW9H?=
 =?utf-8?B?TUNSckJ3bE9Qc3NHbmxGTUNjejdMUmtCSndjbkpidkw0OEEvYjIvMVJsZmNm?=
 =?utf-8?B?RisrQXBkckp4L01jTERlZTVpSTVMZWo4R1FhRUhVYzN4U2RvUVdJUHlwZUxX?=
 =?utf-8?B?dmUrSk5aWVFHT1UrUm5vMlR0blU0MnRPZ2hQRTZnUXpUdjdaVGlsQnB0YlhH?=
 =?utf-8?B?azFlWEI0TGUyTHhHZXRnU0ZDdzZka1BMTmY2cEpxMDlIYWc5OURRTE1OZG43?=
 =?utf-8?B?RTBUK0pjUGFiekV2Z2h4NGFlSGdBNmVOdW9jb245YTJPTU81OFBTaGZQUVQz?=
 =?utf-8?B?TGVoazBIcXVIaEpON3c5L2ZPakpmTjZMUzVzL3VmWTN3bklOWDV0RHhWcUNI?=
 =?utf-8?B?Zkc3TCtaL21rTnRCbjY0Njc1Slp5Ym9WUHY1dldsdzVtSDNueFd5ZldpanFC?=
 =?utf-8?B?cDZSa2VidEJhU0QrVThDTDd5bUx4cVNjQUthQ0xBeDhUay9uMUk5TUFlcGJv?=
 =?utf-8?B?VkRscFA2cDErR0JwNXBLR1VhellyVC80NUVRbmZ0TkJzRERxbkN0b1U1TG1C?=
 =?utf-8?B?anpaeWdXTWFSYXIrY3c0M0VKZlVPbE9nWC8xakxiS1doVTNJVE91SlF0b1dH?=
 =?utf-8?B?S0JFS0hBdDBQTzlPcUM3OGdOV1E5VjBTWWovSHlyRDZmd0pDRmNtR3dGUHE3?=
 =?utf-8?B?cmx6UU8vcUdYSXdnWXdwWUZCcDdsU3lncHZrQitqUXNBS29hanBITTJVQVB1?=
 =?utf-8?B?TDB5b2xUKy90a2JSNVRqS2FRMzBVRk4zK2ZZcjc2dmtSM2Nha0o2NDB5MnM3?=
 =?utf-8?B?ajVhYWtncGlvTFpQUVF2a0xZZ09Dc0hqNWdncy9jWU1ZRnIxL2JuWi90eWZQ?=
 =?utf-8?B?bFQrOUNCNE1kLzlZRGMzWHVteTdvT0FRNFZqVitFUnptREk4YW91YVdwV1U3?=
 =?utf-8?Q?Lj4iq1JnTVfLlvb?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957b2c16-5831-439a-62b1-08db4c26efd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 22:37:11.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UF8ufBhAqdaxFnDZym6qSXyeQx26i/udbJTo1vYhDdN50e/8GCLmWGHvX98hEPXexwi1m6bngieah+5+BWt1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Proofpoint-GUID: poF2vWiZx4aKGrSTXEiqeAg7jmqMbFNT
X-Proofpoint-ORIG-GUID: poF2vWiZx4aKGrSTXEiqeAg7jmqMbFNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMDMsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4g
SGkgVGhpbmgsDQo+IA0KPiA+IEkgdGhpbmsgeW91J3JlIG92ZXJjb21wbGljYXRpbmcgdGhpbmdz
IGhlcmUuDQo+ID4gDQo+ID4gQ2FuIHdlIGp1c3QgbWF0Y2ggdXNpbmcgY29tcGF0aWJsZSBzdHJp
bmcgYXMgbWVudGlvbmVkIGJlZm9yZT8gSSBiZWxpZXZlIEkNCj4gPiBzdWdnZXN0ZWQgdG8gdXNl
IHRoYXQgYmVmb3JlIGJ1dCBJIHRoaW5rIHlvdSBoYWQgaXNzdWUgd2UgZ2V0dGluZyBpdCBiZWNh
dXNlIGl0J3MNCj4gPiBmcm9tIHRoZSBwYXJlbnQgZGV2aWNlPw0KPiA+IA0KPiA+IERpZCB5b3Ug
dHJ5IHRoaXM/DQo+ID4gDQo+ID4gICAgICAgICBkd2NfcmVzLnN0YXJ0ID0gRFdDM19SVEtfQUJD
X0dMT0JBTF9PRkZTRVQ7DQo+ID4gDQo+ID4gICAgICAgICBpZiAoZGV2LT5vZl9ub2RlKSB7DQo+
ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50ID0NCj4gPiBvZl9n
ZXRfcGFyZW50KGRldi0+b2Zfbm9kZSk7DQo+ID4gDQo+ID4gICAgICAgICAgICAgICAgIGlmIChv
Zl9kZXZpY2VfaXNfY29tcGF0aWJsZShwYXJlbnQsICJ5b3VyLWNvbXBhdGlibGUiKSkNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBkd2NfcmVzLnN0YXJ0ID0NCj4gPiBEV0MzX1JUS19BQkNf
R0xPQkFMX09GRlNFVDsNCj4gPiANCj4gPiAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQocGFy
ZW50KTsNCj4gPiAgICAgICAgIH0NCj4gDQo+IFRoaXMgaXMgYSBnb29kIGlkZWEuIFRoYW5rcyBm
b3IgeW91ciBzdWdnZXN0aW9uLg0KPiBUaGlzIHBhdGNoIHdvcmtzIGZpbmUgYW5kIGl0IGlzIHNp
bXBseS4gDQo+IEZvciB0aGUgY29tcGF0aWJsZSBuYW1lLCBJIHVzZSB0aGF0ICJyZWFsdGVrLHJ0
ZDF4eHgtZHdjMyIuIA0KPiBydGQxeHh4IGlzIHRoZSBuYW1lIG9mIFNvQ3MsIGZvciBydGQxMjl4
LCBydGQxMzl4LCBydGQxNnh4LCAuLi4gZXRjLg0KPiBEbyB5b3UgaGF2ZSBhbnkgY29uY2Vybj8N
Cg0KSSB0aGluayBpdCdzIGZpbmUuDQoNCj4gDQo+IE5ldyBwYXRjaCBhcyBmb2xsb3dzDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IGluZGV4IDBiZWFhYjkzMmU3ZC4uY2Q0YjY5NTQxNzc2IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBAQCAtMTgwMCw2ICsxODAwLDE3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIGR3Y19yZXMgPSAqcmVzOw0KPiAgICAgICAg
IGR3Y19yZXMuc3RhcnQgKz0gRFdDM19HTE9CQUxTX1JFR1NfU1RBUlQ7DQo+IA0KPiArICAgICAg
IGlmIChkZXYtPm9mX25vZGUpIHsNCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqcGFyZW50ID0gb2ZfZ2V0X3BhcmVudChkZXYtPm9mX25vZGUpOw0KPiArDQo+ICsgICAgICAg
ICAgICAgICBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUocGFyZW50LCAicmVhbHRlayxydGQx
eHh4LWR3YzMiKSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBkd2NfcmVzLnN0YXJ0IC09
IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBkd2Nf
cmVzLnN0YXJ0ICs9IFJUS19SVEQxWFhYX0RXQzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiArICAg
ICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAgICBvZl9ub2RlX3B1dChwYXJlbnQp
Ow0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIHJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3Vy
Y2UoZGV2LCAmZHdjX3Jlcyk7DQo+ICAgICAgICAgaWYgKElTX0VSUihyZWdzKSkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybiBQVFJfRVJSKHJlZ3MpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBkNTY0NTdj
MDI5OTYuLmRiNDhhYWUyMTFiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTg0LDYgKzg0LDggQEAN
Cj4gICNkZWZpbmUgRFdDM19PVEdfUkVHU19TVEFSVCAgICAgICAgICAgIDB4Y2MwMA0KPiAgI2Rl
ZmluZSBEV0MzX09UR19SRUdTX0VORCAgICAgICAgICAgICAgMHhjY2ZmDQo+IA0KPiArI2RlZmlu
ZSBSVEtfUlREMVhYWF9EV0MzX0dMT0JBTFNfUkVHU19TVEFSVCAgICAweDgxMDANCg0KTGV0J3Mg
a2VlcCBjb25zaXN0ZW50IHdpdGggdGhlIERXQzNfIHByZWZpeC4gU29tZXRoaW5nIGxpa2UgdGhp
czoNCg0KI2RlZmluZSBEV0MzX1JUS19SVEQxWFhYX0dMT0JBTF9SRUdTX1NUQVJUIDB4ODEwMA0K
DQo+ICsNCj4gIC8qIEdsb2JhbCBSZWdpc3RlcnMgKi8NCj4gICNkZWZpbmUgRFdDM19HU0JVU0NG
RzAgICAgICAgICAweGMxMDANCj4gICNkZWZpbmUgRFdDM19HU0JVU0NGRzEgICAgICAgICAweGMx
MDQNCj4gDQoNClRoYW5rcywNClRoaW5o

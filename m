Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E8C672E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjASBtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjASBpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:49 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3474E529;
        Wed, 18 Jan 2023 17:44:27 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30INvE4P004920;
        Wed, 18 Jan 2023 17:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Qb8iTjtDPQmunJauXEUkNd8/s2kmGbjtaMAOoTgfbU0=;
 b=Y/votQ/ivxqyTsJqpKXCC3jAG4t6nXwE2k8Cz81HvNHNFjIs6FsAfBb3hfH7FCGVnKxg
 lA33+CH6TDLw6yBMeWD5FzsX0rZq9zgeWpULNnXbwu0FEuCI7tket4fzN1VsXxCC03ty
 zs6GjHdrd1YQcyruMt3KvaHmYxbLB8daXxV1vFB6yOWytaO4p0T6/pTKQ+orC/0415sF
 JaVhu2v8BobhLSA9HxSdAwFO+XLlz/LAxMkd24eEyMmKG3+lM4huA0KoSTwrz3vzKYRv
 yN/0DUNnE4mXqdQJ0NBbtnDBjcJ0kZtYtP0L4jrlqKoq1vOfmu5phKiNw8VNlEQt7LkM 3g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3n3uwmhqsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 17:44:20 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 463C5400E6;
        Thu, 19 Jan 2023 01:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674092659; bh=Qb8iTjtDPQmunJauXEUkNd8/s2kmGbjtaMAOoTgfbU0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DEf+NWg3Rx4X4ZOSmpG1su/UncQ8z9yTGNDq3xze/csU3mYHkeikLWBNSADUdH2r5
         zkK9az84Ql/5cW6dUV3qbfVwhfUP4ZTs345n0UZuMHFNYYbVRDLlU9uEkbRoSqrLq/
         EeskctFwK4cT1VWyp3IFab6L15H7OC8H2D33IaTZhNDwH+7jegldInhjyexVQ0I6ew
         UZKu9Lgda74TEc5u2A7ivcFJ+wsCjcl4YpXws0IdtnTnchCsz1vOW1J7pbJL+zsOPm
         n3JuwcMaikEUZUcF2G0yRe0AeOhx9YDtXqPTQDW/dt40U90m1Sj07+b7v+7zDnGlYf
         f5EkpCb0jr4zw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CCD19A0073;
        Thu, 19 Jan 2023 01:44:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 10ADC400A3;
        Thu, 19 Jan 2023 01:44:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="RTvHpN54";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ2mw9XRtHxmnN0OFUs9MfKm18kKoccy+d+fA7SYww/yLCbhngHJw82ftQdweYeSpqRWoNEstabesIwiljsZmu1HWbbPyYK6VAgiJ4epwYG8c3l2T5vsDdLv8WVUu7NSzR1kNt4URLC8rgl8FkjuH4n10Wcib24VXjb5ASo815RRCkJxKvhYGYRekBJz4UcE1S5tK3rtWLp6RAgFUJ07rPocOvEA+qn46kMxkR4tNFkI49RUoqL25LNwq3jo28HF/dO58k5pkwez/8/zdYawRqklXWDIpXiP6raJlSu5E7uRUmpW3IvHO2HIzsk+am310DoiBOTd0418gL0OqNLgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb8iTjtDPQmunJauXEUkNd8/s2kmGbjtaMAOoTgfbU0=;
 b=Eba9/ZOQg7YFWPnpolY1jeeolUD0VBk6rDQC8+Z4tnwUeLt8kb3g17FnmYweTYM/QuXNIVMx0Uw9afz0/VB2hH3VIsKNEyHdbYitZJH66MlLj3Y6zPUNHypN0xNhTYr0tRbAhTNoDqkP+MIlpYsk4lToSPRwebtSzmWdAOOY8XoJm0unhHtlx+TqpwqPEeVFkTLhKdTtBOFQZNibo34+/3ySjONr0dSVbRFqZ5CjhXdx5zJegvjMp+KftS8q7cbg4ITIZ3wtv+9Z/GHzmpjM19EcjIdlHay06PqR/Px6sbwcg5YRsM/Y8nLBRbSRdzuLfaVaEAHliRDosGVDSA6MzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb8iTjtDPQmunJauXEUkNd8/s2kmGbjtaMAOoTgfbU0=;
 b=RTvHpN54QbRbrIdKDn330eJmHxs6AAv+s+BlBDfGX7eM1scdo/jGcEniIkQgx+QwW2BcQJW9rRJKAqU56QaZsqZwZXoQQfYltYIYlWtkA+tLI6RHVDiW2kN8VjV6RvV29fVHdTYz207LtnEeS36/1kQvEJxjfTeNYMC2krAXsQM=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 01:44:14 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.5986.021; Thu, 19 Jan 2023
 01:44:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6A
Date:   Thu, 19 Jan 2023 01:44:14 +0000
Message-ID: <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|PH7PR12MB7425:EE_
x-ms-office365-filtering-correlation-id: 8e951e68-498d-451e-0ae7-08daf9beab5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQi4r2sLnT4t0PXxPXdgAljnRv955r5wNTtjf0ksAxUkuevc4nkCVcIncXP3A5yCMac0wRqY67fkDAmB+XJz/y5uurAAmRdYZF7PlDF7Zi4KX7WXr1bS5Fgybkz9FczPE0GAPNJ+zwYyUHulNOe5N71rKR5uYXo+eqyurjGXwgNEWzQZWhK68Aid+xRnrv07ANA2e7JQgQ0SbQzqGpG9T1xWBcThY/+9BD9h1OTmjDL5gBzqBIX860TJ+whFp04RW2T51tiEBSq+9+thbxgkKFecIFgd0MJCkgcDvs1hc1xTYCbdUEhyt3Sm+hETuqNfPufBBiKvh6azoRW0uSaok56RxclhdVY1d+75/THLR7mITnTb3bhUwD5s95n4snspa/0iuoBnAzryCKCthDslBHzpF2JZmxye8SxIZV+YPr6XjAA3QNzss5M3eCtXcrx5q2NHr4Jsdo5NxhOrYqb8rrUP7Iga6DMOXCRWxNFsqEaZStjki+4YIimYedcHAERIhX3XvwQsKVk/wEh0E+HgatF2EPw8CsEvyrt2UVXAEezgwqGk0yqE8JqomsmpXooO2h71zSWu29MunmokS9thpgVpgdYNeakv227Sw4E1vTmOZvC3vYcmKVgXIuYpxy06ZdZOFS3HMq17XcGoUw7ITOufnubbFrDRjh3EB29JA7oP0sY2mAh3izt1EDXvWZ2UCK3qvXQOGXcVUfdAsM7lhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(38070700005)(6506007)(86362001)(76116006)(91956017)(66556008)(5660300002)(2906002)(8936002)(66476007)(122000001)(66946007)(316002)(38100700002)(64756008)(71200400001)(54906003)(6486002)(478600001)(36756003)(6916009)(41300700001)(8676002)(4326008)(66446008)(1076003)(186003)(6512007)(2616005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NEcEdHS2VseHVBbEhJRVAvRkNDNnBxdGRNQTVURmNmY0tDMDVMbkVBSkNk?=
 =?utf-8?B?blkrQllEd3pOZTlCaDc3UzZLOVJQNnlQRmxsVFlFSHpiMllaL0doN0NNbHp0?=
 =?utf-8?B?QU92SlF1UDM0YzlBaXpZYkYzZFNhUnNPUFk2RXpMbzdnTjF1NExVSXhrT1Z1?=
 =?utf-8?B?Qm9tWlk2dWk5aitVRkxIcFJEbGp0UUx3VFFoQkcrT1VQb2k5eTNaOXZHNytv?=
 =?utf-8?B?NDJRK3NmOXpkR3dlc0w0Y1hlT285aGZCT2srU0JaZDZPVlVCdVZTME5hSmJv?=
 =?utf-8?B?OG1WbEFHMXkxSjZCU3U4MzNHQ09LVGVXdnFIWmo0QTU5ekRkT28rVk84YVZ3?=
 =?utf-8?B?ekRRempITWhqbCtSS0k1Z2pkRU5mYWxZVDB1YkpVWEtSS3dTL1U2ak9UY1ZP?=
 =?utf-8?B?enhtVEtyeFNGOUh4L1cxVVBPSm1SS1FjN0FiNndpcktFVUJabXFqTTlJUlFi?=
 =?utf-8?B?UUg3bmJJMExLbTdpN2NQRlE1TVFSOTV3ME9BQWt4WkkzTk00QlpjTitTb0Rx?=
 =?utf-8?B?cWwrYnB5RlZ3bUFZbzZkU2c4SWFOazl2bjdLZW5lTUNBQ2dWUUZ4M2lDa240?=
 =?utf-8?B?RklGTmxkSGJ1ZXNOSDlWcHkxcUxYanRNd05IdVJETGs2c2tqUWpoQWN0TkR4?=
 =?utf-8?B?TUQwNkVXZk1FSzhYNW5iZ3NPbHdWUi80UXJ1N085L3dNekJ1N0ZkWFpMNEwx?=
 =?utf-8?B?ZWZ2WjJ5MFdhQ2g0M3JHdjdEMnVraHhITU92SjhzZmdNQUhOMWlTeFlsa1hh?=
 =?utf-8?B?ZVNTbGdpelR3ZTBrdHlSUmIyR1J0ejFDL1hmZk9XMk1ERE8wTFlKUkt6SDdG?=
 =?utf-8?B?WGMwY1JGVWVrL084NHBLV3I5Q0pXd0FQMmUwOEF0YzdjM0tQVjNMclFrSU9N?=
 =?utf-8?B?c0RCVEdwc0xtM2RuSG12Z0RUUDNQbEZRK1liZklKZ2tLckFmb2xYY2VJd0s0?=
 =?utf-8?B?ZWFXOUxZYm1qUHBsRDgwanBaSlIrOTNIUzRac3d5ZS84RldzZmdGSDdpZU1F?=
 =?utf-8?B?a1lQckhTWnRqL1lPZ0x2dFdLSWZDODdCbml0bno3Z09kclNpUE00VklwcXcv?=
 =?utf-8?B?SXZ1cWVBblNtUlpNWmppUFY3UUNWUXVBRGowNXNsMVRRU1d6MERJYi9sRk1m?=
 =?utf-8?B?ODlhSVZLTDJiMDNzeHdmaHF0eFZBb04zNzFWNUxGaU9MQWRSWHR6RGpKWXpr?=
 =?utf-8?B?VEJRdGViYVoxMjNqS2ZWdVFJTEVDcUQ5eGRhREpQU3ZFZ3I4clg0RjVIc3hN?=
 =?utf-8?B?L1V6aVN5c25HaVR0VlM0TDFjaWdDUDM0VHVBNTh3aTd4a3NWUHB0d3R4VlVJ?=
 =?utf-8?B?eGU3Yzh6WXJ0TDNxN2p0MkhIeUxMUHF6cjc4YVEvcXZ5dmYvMWtXTnNGQVFU?=
 =?utf-8?B?SjUrQ1BXcWJsNTZhZVpEQytKdlprQ1JOUVJ2TWhXUEozbzQ5bVJ6L0VCR3oz?=
 =?utf-8?B?U2ZmZ2E1b1VySVo4OHNzSGlWZU81YUQxQ2NEVFN4RUJKWlo0MnVzOUFoWkNu?=
 =?utf-8?B?S3NpNTlIV0hOQVhQUVJNSk83ZWFYOEZnMlpSKzIzL3hTZnZLMmlDb2lpS0Y4?=
 =?utf-8?B?dklyWTRUMmRPM3FsR1YzMUhvV1N5amdoSTI5Ti9XdkVQeTBia2pSeDJWS3hz?=
 =?utf-8?B?TUFKYS9lNlNBSlFXYUE2QVAzQWJQOXFSQzF3a2dNaUZSNG9CVzZ0aGovNTdU?=
 =?utf-8?B?Q3d4RG9CL2Z5d1dWaXErUEV2K0pIM2NiU0RzaEhvbktSTEVqdm51dEdIOHlU?=
 =?utf-8?B?UXpNS2J3OUxMTFBCeTNORnlNU1N5SklERzFqSUVJdHZscng0ejRNOFFqWUFO?=
 =?utf-8?B?WVpZVVlyeFdhbDEzT21jaG9lOWlCcmx0U1Z2OGFuRnBUQzR4WUJWYlN5TDNs?=
 =?utf-8?B?V0s2Q0xjR1hMUXY0SE5XSHRPK2dCVE93Rlh3N0Q3Um5NWkRwTnpFem9KcE1U?=
 =?utf-8?B?ZHRCS3ZPMmRNVXkwUVBVY1l2TFZMaEhaVXJlQlpxVERaWGdlM0RuK3BHL1NB?=
 =?utf-8?B?enl4Y2t0VExHNkZEbkU1NW9UeWdkcTZkSUlXUVViNGNHSVN3OGoyNXBCNzlQ?=
 =?utf-8?B?TmpNdXRYVTNpMkg4Z2pGZzBLbFVkaElTemwyOU1LdUNLdUZYM3lNVGRuVkdQ?=
 =?utf-8?B?U0YzZ1E0STlpWk5oWTJ3KzVBY3ZNbjlGZkI0cW04SmFRZnYrTTIwejVPWXM3?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4C056434A053B4A819ED045BB1029F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gEr8b+1lUBzYiU9oVyDrBhLm4elTHQ6V+Te8Sa+D+6G8jIo1rXFOdMlqjyXxkrQuOIuCdye4qWvzFZvM5sq1z1up2cSqMr4mYJ7+sQt1trzF5IvrW+L5QDB1wmhCSpC76XRVk79jgDlmCOX4eCqSz2ldoiIclcybOcwzI3p2H4CBqXopXJTtCzDrMdc8iBtTCViJkxovR4jQhrSX9pnES4IYGcw80DOu96Vle+M7u7IMyFHfhJEMduxx0fkFzZFvxtxEXUzyg15D6Wr3k+/xDV4D3akfmZOgMvaIs8BYTPEAGg6i49VwMrY4vdNTJj8hZx14pFAko+NX4k9VbEXl2vfcbeUWOOBaTo9GYicuIWmb469idZOiG9yKbf4ucQVEo1+CDdcJtK8pXWGJAnY6jeOOzXuhzuDy3XbbWUhs4kG5MPRhO55WVK5DxOUO9i/Syg+fCy4pl6YpKe8751cWLGZCHueShSkmVqhlvXyFEZf4WL5QZ8IgMFYjj/dAUoyJuO+Z85aXf/++w+5IG+POQR5UFG4UYkCAa/w/53TQETQrEB+gnpbAzXs3YAE+p3k2cmIwf3ymZa5pMkLyXovKk24ZH1QiFsV7fPQcK/2o8il+V6d6tctdunoQWxdRUBA03YTXi6i1m+3M+cwCqgAN+rdIEy8vbZ0sBXT5FkDR0YDC11dFMESOd0RbaV2vreotBYY314UlWq7HESP4J0sMDNVVo/NIKMaNxjRgS+zlvCodampNEPpxET7UVNpBwgXQf0N995wR1LhoxS13N18BlocZFmRekbD85uvgRCn+xiCT8AvA8oqbG2QmO91idBBjTfB18qkboW2pKT6XkR5mZV7kuBdNj8fSMyzfdPLDIX3LNyjnwAhdtZsQjK1cMdaTvgaOJ87HCo91E5vMdmlIrW53B/pZcAjueb+HF1BGJrg=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e951e68-498d-451e-0ae7-08daf9beab5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 01:44:14.0425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqS3ZIAIR8qRNbzgjP2sWOz7zEFJHxJDUr38jSvAr2a0bw4nBOZaTcnyxFoM1eHvklOaYWdFqd0hkH0KHsTT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
X-Proofpoint-ORIG-GUID: EqmSVKDmPoIw6JqPR9GNs1_f_S8xuOGj
X-Proofpoint-GUID: EqmSVKDmPoIw6JqPR9GNs1_f_S8xuOGj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=667 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMTcsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFkZCBhIGZs
YWcgdG8gaW5kaWNhdGUgd2hldGhlciB0aGUgZ2FkZ2V0IGlzIGNhcGFibGUNCj4gb2Ygc2VuZGlu
ZyByZW1vdGUgd2FrZXVwIHRvIHRoZSBob3N0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWxzb24g
Um95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
dXNiL2dhZGdldC9jb21wb3NpdGUuYyB8IDMgKysrDQo+ICBpbmNsdWRlL2xpbnV4L3VzYi9nYWRn
ZXQuaCAgICAgfCAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2RyaXZlcnMv
dXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBpbmRleCA0MDM1NjNjLi5iODM5NjNhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IEBAIC05NjUsNiArOTY1LDkgQEAgc3RhdGljIGludCBz
ZXRfY29uZmlnKHN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiwNCj4gIAllbHNlDQo+ICAJ
CXVzYl9nYWRnZXRfY2xlYXJfc2VsZnBvd2VyZWQoZ2FkZ2V0KTsNCj4gIA0KPiArCWlmIChVU0Jf
Q09ORklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJpYnV0ZXMpDQo+ICsJCWdhZGdldC0+cndfY2Fw
YWJsZSA9IDE7DQoNClNvbWUgZGV2aWNlIG1heSBub3Qgc3VwcG9ydCByZW1vdGUgd2FrZXVwLiBn
YWRnZXQtPnJ3X2NhcGFibGUgc2hvdWxkIGJlDQpzZXQgYW5kIHJlcG9ydGVkIGJ5IHRoZSBVREMu
IE1heSBuZWVkIGEgZ2FkZ2V0IG9wcyB0byBlbmFibGUgcmVtb3RlDQp3YWtldXAgaGVyZS4NCg0K
VGhhbmtzLA0KVGhpbmgNCg0KPiArDQo+ICAJdXNiX2dhZGdldF92YnVzX2RyYXcoZ2FkZ2V0LCBw
b3dlcik7DQo+ICAJaWYgKHJlc3VsdCA+PSAwICYmIGNkZXYtPmRlbGF5ZWRfc3RhdHVzKQ0KPiAg
CQlyZXN1bHQgPSBVU0JfR0FER0VUX0RFTEFZRURfU1RBVFVTOw0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC91c2IvZ2FkZ2V0LmggYi9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaA0KPiBp
bmRleCBkYzMwOTJjLi4xNTc4NWY4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3VzYi9n
YWRnZXQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaA0KPiBAQCAtMzg1LDYg
KzM4NSw3IEBAIHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyB7DQo+ICAgKglpbmRpY2F0ZXMgdGhhdCBp
dCBzdXBwb3J0cyBMUE0gYXMgcGVyIHRoZSBMUE0gRUNOICYgZXJyYXRhLg0KPiAgICogQGlycTog
dGhlIGludGVycnVwdCBudW1iZXIgZm9yIGRldmljZSBjb250cm9sbGVyLg0KPiAgICogQGlkX251
bWJlcjogYSB1bmlxdWUgSUQgbnVtYmVyIGZvciBlbnN1cmluZyB0aGF0IGdhZGdldCBuYW1lcyBh
cmUgZGlzdGluY3QNCj4gKyAqIEByd19jYXBhYmxlOiBUcnVlIGlmIHRoZSBnYWRnZXQgaXMgY2Fw
YWJsZSBvZiBzZW5kaW5nIHJlbW90ZSB3YWtldXAuDQo+ICAgKg0KPiAgICogR2FkZ2V0cyBoYXZl
IGEgbW9zdGx5LXBvcnRhYmxlICJnYWRnZXQgZHJpdmVyIiBpbXBsZW1lbnRpbmcgZGV2aWNlDQo+
ICAgKiBmdW5jdGlvbnMsIGhhbmRsaW5nIGFsbCB1c2IgY29uZmlndXJhdGlvbnMgYW5kIGludGVy
ZmFjZXMuICBHYWRnZXQNCj4gQEAgLTQ0Niw2ICs0NDcsNyBAQCBzdHJ1Y3QgdXNiX2dhZGdldCB7
DQo+ICAJdW5zaWduZWQJCQlscG1fY2FwYWJsZToxOw0KPiAgCWludAkJCQlpcnE7DQo+ICAJaW50
CQkJCWlkX251bWJlcjsNCj4gKwl1bnNpZ25lZAkJCXJ3X2NhcGFibGU6MTsNCj4gIH07DQo+ICAj
ZGVmaW5lIHdvcmtfdG9fZ2FkZ2V0KHcpCShjb250YWluZXJfb2YoKHcpLCBzdHJ1Y3QgdXNiX2dh
ZGdldCwgd29yaykpDQo+ICANCj4gLS0gDQo+IDIuNy40DQo+IA==

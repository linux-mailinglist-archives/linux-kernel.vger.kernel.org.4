Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA06762CD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjAUCDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAUCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:03:02 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384DF742;
        Fri, 20 Jan 2023 18:02:58 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KNrKPa031520;
        Fri, 20 Jan 2023 18:02:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=iybRACPgXy5tF3FM4BvsXVX1qw+glow/X7TX8rpo5Is=;
 b=fSgVFGC4cmom8taamulg32BAREvlNiUZCzN7XfwA+JOBViyKQAPAA1kBkdmhyBL4vzB1
 DaNIddYLwHV+HRdp9Te6wfQTTSK7dwNDOunNQvX23OMenULJjb1/s11z2/J/0lkE7U+X
 QmN91bL5Bq0Lw2WJbFcLu2AD+4l/M7r4rNd8OJJSBVxpVu/th7w7EAVSShWq5e90WS0T
 e8Aymg6qCaD7WVBLkf/WqeyK9tKF0eJb+O4gQFe+mEutorbjtjj69HD6JsraRw0Lu8r6
 sNXciYnJfooeT3n5wZMkxqENc8UA1QvhJ52S3Ol8zUzlRITBvlNLncWl5noT2cJ7PxCj XQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3n3uwn0ycf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 18:02:44 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9FA5C400FB;
        Sat, 21 Jan 2023 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674266563; bh=iybRACPgXy5tF3FM4BvsXVX1qw+glow/X7TX8rpo5Is=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KRID5nBcRxZNb0T3rryX3xOeW5ej8o05W1Sky+mv2elkFxLubaLJnCmKXrKg2qpG4
         Eo88rrqFZa5jjuugrg3hmmN9fvkgR6TPLGzW4i07iWFcbe2ZN//mt4OjCGt1SstDaV
         cp/e0fZnsgYh5HFSqtd7BgYPjFGPXWhU1ypOekmYGfzcEbgFMwJpMq8UE++1aJbEcC
         /svkM2ToRqdOTXGUrzfAQt1zc4mSo2TwO7A6nEdg5vV6iCWs6Jfi4PsYsSmguIB9pv
         vMU1QUiMmMsMFpyL/L0DUvFtQntXn5ImV2hzwOCFgoqshh/z+Jb7F4NBOQbZYgFC6d
         nljc4TcPIVmwg==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CE058A006E;
        Sat, 21 Jan 2023 02:02:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7D3538007E;
        Sat, 21 Jan 2023 02:02:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="C7J7do7h";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYelySjLm2gdG6m5ztZ1AP8thIus3P3Rz/JCHEKLovqmOg+SsGBHam5H4sasuewO1jUbciH1LelXzZcacXsbG25GiD3LH6jlGnHJ2VHRVvKsUf5n4YsE5uK9HzDFWO2K6aATHSyb5KTQ1FqrlbZpxGIdkwBlhKM4H/Hy9FUx6USkzKcjRFubdbi/XgyNiQLGrpnEeuqGgkLkxg5SIv4Z0UJ7PQFgEQSkQdiOUalIvcbaMX0xxmucf9HkQ7HYK5u2ouFQRrkTlqhGIny0FP1H91peoK5U6c0fPde5/31WB++NCbwxsJQhHDhDdlvCbamwHBj1NnkiRXPXr7iwMqTitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iybRACPgXy5tF3FM4BvsXVX1qw+glow/X7TX8rpo5Is=;
 b=cmvZjfPuW0zviZCobNmL5p/ozLIWdlV/8O9XaYAwt4glOj15g8mfKqxp0edca0V0TNRg/eDtgcYqtLmDrXal/whfZDK5TQreh56Ac1Y5qsHmVFiMQk0WPH+KCxAOj37GBH9tMPLEFnjakxMxXm8nFf1U4Y3OwPZtWb0rKjpl3XJLw3ONqbvg4a5qbPdtC0jkTPdyyor+a6AnVA7iKaIOIivZ5cpqhh8daU5mp8ovjAz0krK/jytCD08r8gk8aJzrCUTh0Vyy1QjPifqXK58lysCo7FhlhxBXV/Nq0bEPw5Qsvhsgn6tFmhBKwZd3ZEtC5h3/jm0styt6UuefN03zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iybRACPgXy5tF3FM4BvsXVX1qw+glow/X7TX8rpo5Is=;
 b=C7J7do7hbeh5el0L29Gv3qFBXXZGCCcoxUFGO2J0OvG2e7z68jgHNjW+2/5S/rMjrWCTuc5dsydqemT0DCXYp2tcypyOPcnoOLs/y87v44OzfySQu1HpGZJzzaAxlTgk9smk5VA72dAdBu6tS9ZYpbGdmPVPwTBBCgK8pM3uM3o=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 02:02:37 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 02:02:37 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Elson Serrao <quic_eserrao@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6AgAF5HgCAABEigIABfykAgAAEBYCAABpUgIAAAgCA
Date:   Sat, 21 Jan 2023 02:02:36 +0000
Message-ID: <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
 <20230121002059.mpiqavemelnntxd7@synopsys.com>
 <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
In-Reply-To: <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|DS0PR12MB8501:EE_
x-ms-office365-filtering-correlation-id: 94a3b5e9-dcd9-4d79-f060-08dafb539198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXTlpRc6nLGY9iI+9N0CXRq77NTBaxxYLY5yZb6qlRfMY9rYAf2PK1MPBFhnmQ+k2vGC/+Wr9rDFq93hMKVxezl6r6FnC9zGuWRmdXGfuDrwoTL1DGbkPccrwwei77ebXd7ZztEvLCNolN7GQwGP4Mx/3lAV4S4tFDgwXu0JA3RR4QCYfoQlzvDyu9fZjJ30NKgE+UWGhdLUVF85XScHhtGYN291HuXKiOvV1pGA4xeDJaFZjJz82gW6sPGbHlawAjfsnbRcq3H8bJCcsBGKQTPLc/8If4u4PuhoGXCZv4htCBFGg/D552Y8vUB4aNeJ9V1Isujf2gvME6jlF0xXkkosgod1c+FKTqgg5Ifz6udcmymZ9nROvGfZ2fU/9RNnbpluKajDdp5CvU88O8VzPYTaBJO+FtACSJL0tCpAcTR2FBF9TPE+YxF44nJfLs9nYwkNxnlgajEar5TVKn7Nyxa3mbgxohemiOlaP2Xbfs0RYZmqQP4PP0SMdkeQb3ZlyBPA182NY6/Rt8H6g0umzROvvTTmnGyGavEvVY0jR1U0LXoGsmqhaJcL0CAwQ9Pm4vTKUBUe3yzFSEaHPslBqv9mGUkWeDMUs5kkxNiQsFSQPtHl21ZWSKi6i74vva9/A+L8jZ7jsKbEdL/0ri8G4dk341PphyvBnMKSR52VzFeq2kD+B5fBYVAZL9RN3LJ2BQEBzV9SqV3TVVnE/2Ahtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(6486002)(478600001)(1076003)(41300700001)(6512007)(36756003)(54906003)(38100700002)(316002)(83380400001)(86362001)(8936002)(5660300002)(71200400001)(186003)(122000001)(76116006)(26005)(91956017)(38070700005)(6506007)(2906002)(2616005)(66446008)(66899015)(66556008)(6916009)(64756008)(66476007)(8676002)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UitPTDVsZ1FNRlYyUXkvNHorOUlZQWZRUmQvVE1LRnFtdkxiTlNxU3UyQTdH?=
 =?utf-8?B?NE8reVNkd0lXdXZReEdoamFCYm9QbHZkaXhndFhkeml4cFBMMGwrcUtRL0xM?=
 =?utf-8?B?cnRSU1NMampCVERrY2xQUHB1ZnVzc2lIbHZUWFZpRUpGU1czNVlxL2Jncmhm?=
 =?utf-8?B?NDc5dGtOS2JwREJ1alU3cXNmMUs2Rjh2ZnBjc0h1ZERtazdqbFRnQ0xzQ2JF?=
 =?utf-8?B?Y0NRb2Z1TFlqaXpVK1JLemN1b055eDdxcGRYMUJGVE9odGR6RGpZQXBteGVO?=
 =?utf-8?B?TjNmcXYyWEQ4NHZ2dGdVWUVQWmpqMTllWVBobnoyNHVmR3lvUWNrVDlYWGxV?=
 =?utf-8?B?NlZpeStWbGpETzVneW1hV09oWndiVHNZVVpXUWo2bkNVaXh3NUZRTjEyWkht?=
 =?utf-8?B?YS9jY1EwUDdnKzVqWmRxRGRaeGQvYXl6bEpTd3dsZWY5anJZOG9sd09Zb1c0?=
 =?utf-8?B?ZGVZa1pKTmlPRFdGU0d6RURMNklyckxsc0VSc0xRdndRNTArMXovMnlETUt1?=
 =?utf-8?B?R0hXK2VjNkZ6VVlwamVESUVrL015d1EzVHlOb3dIYTd0bFU4YzdOWVd6c1lz?=
 =?utf-8?B?ajJrZzNtcTVZNDQ0YmEwcXJrWnV1M3BFTTB6MEJrRktrK0pkM3h5LzFQZ3Fm?=
 =?utf-8?B?Vy9xWDhxTzVVeFB2bHR0RE9YU3czcTVMdzVLMkMyK2FjcWE4QTh3bVZyRGY1?=
 =?utf-8?B?ZjZnWCt4b1dyVnIxREZ0TVkyckVUeHE1OExkNVRRTDhYd01IU1Qrckg2RkdZ?=
 =?utf-8?B?eGZCYWpLQkpMdncwYWc1ZG42dzR1OGxpbCs2T0VUOTVSNGJHSzNnSnFtSUc5?=
 =?utf-8?B?UUpUYmg3UmJKeWtsWlE3WHY2RHFVNy9uTXZ4VitZVUMxRWU3YXdVa21HY3Vu?=
 =?utf-8?B?V2RYUGZmb2hBRTduU0g4UTVoTHJ5UmRyUGIzcjN4eGJyRjJPbUlyMWdUUVRa?=
 =?utf-8?B?c3BLWDVhbWRYaWZxbHIwQWN3R0tSOS8vSVEwdk5tK2VrK2cwc2dxOUFFeXlC?=
 =?utf-8?B?OWtjMFFleGFGUVlyTWFIaFpmdEJzUmhCZ252VDYwOWlSZm9uZ0haTUNZNmU4?=
 =?utf-8?B?anp5MVlQNEVwNFVTd0FNdnhhN1BIWmVaNkVWZnVPZVkxaEhHaHZwTngyRDdi?=
 =?utf-8?B?M0duL21aaG5TTUZxNWxLZHNJcHVnMlN6YXJjNTBaY2NKOHAwSWFnWmhFbjRs?=
 =?utf-8?B?WWNLWWNGREJLK2pDZ0F0ZkpKdm02VUZGNjNiNjBXNFkybFFIcURFc01wRzVL?=
 =?utf-8?B?dktmWHAvUXAzZENQbUhqL2Q2c1JoZEJGbHpxR2NtK1dJSmh3ZEZoeE5XNlF5?=
 =?utf-8?B?SGUwV09tSW9WQXltVVViS3Aza0Zsa2VzdnJINDJocVdXZkJwdGN3c29XTy9i?=
 =?utf-8?B?WGM5aDN2SVpGU2NYMjR0d1lMa2JqMmZiNlpGd0tpM29PT05nVEk4TC9CR1Uy?=
 =?utf-8?B?M1hyTU1Dd2kvUzNsTWtQN2Z2UDFtU05qbkUxZmdWUXkvRzl3S2ZRMGJGVThz?=
 =?utf-8?B?TXZQVzdWaDBGM1RlaS85WkNpU1NHSTRuMS81T2JJeUpxbVgyQUt2eVN1K1hD?=
 =?utf-8?B?dXRpL0FDak5Wa2JRam1kYUJxendvQkFnNUdHQUtmME9vLzk5L3hUZlMyWkMr?=
 =?utf-8?B?OVp1ckt5RURCcU5hajlZTlZBNXB3cTZLb3B3cVhIdnA4ZHBVWWRnd0grc2g2?=
 =?utf-8?B?OXIxdDJZLzBvTTFGU1I0TXNlOWRieXdDTncrQmV1U0hVZ2Q1bmxrZlFRbFlt?=
 =?utf-8?B?SDNBeDBYSlJVNWY3UVY3aWVEQUk1NGpVQmxodE1nRm56cmNabEh1dS9RYzNL?=
 =?utf-8?B?bzNEKzk4NnI4RVZYRGNQeEJMby84RTNMak1CTHRuYVE0OFVKVjJ6dEJPZHJT?=
 =?utf-8?B?TlB5MmZreFlWMzliQ05ReXBVZWcxOFlQU1ZvYmtCNitNbmRxajBianlJcFgz?=
 =?utf-8?B?ZGptZEZvZnpSTFhaZXpGT2E3VEE4UFNYRmFOV3h2aEhhTVdKQWFQTmkwY3N2?=
 =?utf-8?B?VU5pcVJLaXgxZ1huUGhFd1k0SkxIY0ZKQjZQZjZHdS81Y3BJVUlVTXBDdW9a?=
 =?utf-8?B?UlJDclhrVDNLcU9jU0tFMGwzSktLeEUzenBEbWQ5bHllOHI5VUFNVUZtL0VO?=
 =?utf-8?B?MWVEMTBrb210R1RMNk1UanhDazQyMFdxeW1vcEFBMmtIUGlBaDU2emoraUpP?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34BD3E4CA0442046B49EEC4F642452E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ukpoa1FqRDE2OUVTMUlPTWtBYTZTc0lRNzI5YzVoUGcrVFlPOC9xaVIxTlVX?=
 =?utf-8?B?N05RZkxrczkydzRzbXQxWE1HYWkyZDlpenRLamFYamh6RXJMT1o2aVlBM1BD?=
 =?utf-8?B?dTQ2M2RHWGRRbnB0cFhwK3A3SEI2VDVZa0s4RVNLZFU5WDh5SU9EUTdpWHo4?=
 =?utf-8?B?RWdVWEJBV1hETFoya09jbEdiMDlvdTNOanV2N2lUMUFHWkk3R0hCZmlwcDdl?=
 =?utf-8?B?YjZBcGtNZ1dTdmlIaGxZMTJvZDZlWmlTT3VLWW14bmtKM1JHUzErTHZUeDRE?=
 =?utf-8?B?UHNEN2pKcVZWV0hBenhrbGZxUWdyRXpDUHJkcGdSYm03QUNHWDdISTQrK1FN?=
 =?utf-8?B?K3cwZ3JTQmZHS00rUklPOVNSeVNEWUFvd1NVc2tLWlJ4ZU9HWnRnV1lycGhY?=
 =?utf-8?B?bW5vMVM0cjRZZ3BGOHBKYlo0ZUU4UUlvRi9JOWNFVkZNVmxWYUdtRFVoclhP?=
 =?utf-8?B?N2dkeEc2SlFzV3I5YUw2RDZBeStGYVhwOGZpdGxhVnVVb21oMnNTQkRlekJR?=
 =?utf-8?B?eXp6eUdUQm1Kcit2cHZmQWhiaUtQcG8zcjhvb1I4aFYyOUQ3RUk5Ym9NWXRp?=
 =?utf-8?B?d2gxcE42b0liaWx1TUw1M3N4d2VKZjJYN0M0V25xMXZuS2RDWERlVW90M3VZ?=
 =?utf-8?B?cU0vQXJLUkdOWnFkcWN0ZGR6UjBXOFhwVDlDckZxRm00VGd4aUgyVWFwcXNq?=
 =?utf-8?B?VU8zS3VEMXFUa0hCYTd0TDRmU3cvS1d2THZmazJTbklOMnZOY1RBZUVybVl3?=
 =?utf-8?B?L2t3VWxFTU9qUHhnSy9MV0c2T1pCVWJBd3piYjF4TVBOaHRVang2VVRDTm5y?=
 =?utf-8?B?RXJUZjJ5ZUtTZHJBMVRDNEsxYW1KNTkxOXJCS2crSlp5dUhpZXRBZ0FoRzZr?=
 =?utf-8?B?a0ZTbzh1ZUFXR21xZmhrMWNFRjZWcjY2VFZjUXpmKytLR2gxc3hLWlBWYXFK?=
 =?utf-8?B?UDl6MHIrcGUyckpOdGVaTjQzeXFJMnRaMEt4eTB4bnVZc2ZjTGRpL0tmV09z?=
 =?utf-8?B?NFU5SmVHdzc3VExDUUNOenYrY0xvSXVTK0JmMGFEVS85NVcyNEVsRGlWZzEr?=
 =?utf-8?B?dm1WZlFtSk5OZ1RnTVg5dm9BUFFERXlLenpwMzNCemhRMWZ3RXBjUllGZ1JM?=
 =?utf-8?B?WVRqWUVyMkNRc012Ym1vZ3NMNGlWRlZDT2tWbnZTS2FEUjlWRG9vZEdLeFJp?=
 =?utf-8?B?VC9aRDJHWWlHOTA4Uk1VRXZQSEl6NGo1MUhWa2N4bGJuWFZseDZZcWgvb1Uw?=
 =?utf-8?B?SDVLVGk1OFNkRmdmMVRUMjJoeDhra0tsUGF4eG9VUVFBa2FJQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a3b5e9-dcd9-4d79-f060-08dafb539198
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 02:02:36.9766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jt/aYo2UW9oIMQlBf6m8Li54MomM+Li+VuNXA0bXEesYv/VxMAWpELhjoX65ObeP8z1D4fyT+4KwQyoNnkOlJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
X-Proofpoint-ORIG-GUID: zWNKnq9Jt6HkBBxM_yjrGQXcMlnVRKj_
X-Proofpoint-GUID: zWNKnq9Jt6HkBBxM_yjrGQXcMlnVRKj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=850 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301210017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMjAsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFNhdCwgSmFuIDIx
LCAyMDIzIGF0IDEyOjIxOjEwQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBUaGUg
d2F5IGdhZGdldC0+cndfY2FwYWJsZSBpcyBuYW1lZCBhbmQgZGVzY3JpYmVkLCBpdCdzIGEgY2Fw
YWJpbGl0eQ0KPiA+IGZsYWcuIFRoYXQgaXMsIGl0cyB2YWx1ZSBzaG91bGRuJ3QgY2hhbmdlIGZy
b20gdGhlIHVzZXIgY29uZmlnLiBQZXJoYXBzDQo+ID4gd2UgZG9uJ3QgbmVlZCB0aGF0IGluIHRo
ZSB1c2JfZ2FkZ2V0LCBhbmQgd2UgY2FuIGhhdmUgc29tZXRoaW5nIHRoYXQNCj4gPiBsb29rcyBs
aWtlIHRoaXM6DQo+ID4gDQo+ID4gaWYgKGdhZGdldC0+b3BzLT53YWtldXAgJiYgKGMtPmJtQXR0
cmlidXRlcyAmIFVTQl9DT05GSUdfQVRUX1dBS0VVUCkpDQo+ID4gCXVzYl9nYWRnZXRfZW5hYmxl
X3JlbW90ZV93YWtldXAoZyk7DQo+ID4gZWxzZQ0KPiA+IAl1c2JfZ2FkZ2V0X2Rpc2FibGVfcmVt
b3RlX3dha2V1cChnKTsNCj4gPiANCj4gPiBUaGUgc2V0dGluZyBvZiB0aGUgcmVtb3RlIHdha2V1
cCBjb25maWd1cmF0aW9uIGNhbiBiZSB0cmFja2VkIGludGVybmFsbHkNCj4gPiBieSB0aGUgZHdj
MyBkcml2ZXIgYmFzZWQgb24gdGhlIHVzYl9nYWRnZXRfZW5hYmxlX3JlbW90ZV93YWtldXAgY2Fs
bC4NCj4gDQo+IEEgVURDIGRlc2lnbiBtaWdodCBoYXZlIG11bHRpcGxlIHZlcnNpb25zLCBzb21l
IHN1cHBvcnRpbmcgcmVtb3RlIHdha2V1cCANCj4gYW5kIG90aGVycyBub3QuICBCdXQgZHJpdmVy
cyBnZW5lcmFsbHkgdXNlIGEgc2luZ2xlIHN0YXRpYyANCj4gdXNiX2dhZGdldF9vcHMgc3RydWN0
dXJlLCBhbmQgdGhleSBkb24ndCBtb2RpZnkgaXQgYXQgcnVudGltZSB0byBhY2NvdW50IA0KPiBm
b3IgaGFyZHdhcmUgZGlmZmVyZW5jZXMuICBTbyBpZiBhIHNpbmdsZSBkcml2ZXIgY29udHJvbHMg
dGhvc2UgbXVsdGlwbGUgDQo+IHZlcnNpb25zLCB5b3UgY2FuJ3QgcmVseSBvbiB0aGUgcHJlc2Vu
Y2Ugb2YgZ2FkZ2V0LT5vcHMtPndha2V1cCB0byANCj4gaW5kaWNhdGUgd2hldGhlciB0aGVyZSBh
Y3R1YWxseSBpcyBoYXJkd2FyZSByZW1vdGUgd2FrZXVwIHN1cHBvcnQuDQo+IA0KPiBJZGVhbGx5
LCB0aGUgdXNiX2dhZGdldCBzdHJ1Y3R1cmUgc2hvdWxkIGhhdmUgYSB3YWtldXBfY2FwYWJsZSBm
bGFnIA0KPiB3aGljaCB0aGUgVURDIGRyaXZlciB3b3VsZCBzZXQgYXBwcm9wcmlhdGVseSAocHJv
YmFibHkgZHVyaW5nIGl0cyBwcm9iZSANCj4gcm91dGluZSkuDQo+IA0KDQpJIHdhcyB0aGlua2lu
ZyB0aGF0IGl0IGNhbiBiZSBoYW5kbGVkIGJ5IHRoZQ0KdXNiX2dhZGdldF9lbmFibGVfcmVtb3Rl
X3dha2V1cCgpIHNvIHdlIGNhbiBkbyBhd2F5IHdpdGggdGhlDQp3YWtldXBfY2FwYWJsZSBmbGFn
Lg0KDQpCUiwNClRoaW5o

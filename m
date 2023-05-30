Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002627170F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjE3Wv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjE3WvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:51:22 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B155115;
        Tue, 30 May 2023 15:51:20 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ULJfkk018007;
        Tue, 30 May 2023 15:51:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=lAzDMz/6y98blMFq+QpMulvxXmq+eUcygEkgjl5viXE=;
 b=nb6jVDyTZ1OAedQgPEXNV+whHsG5VMuLTOluttgQuIMs55dLcY/F/Z72xhwKFQ5eFl7V
 Fh+6AkCabcguknrbXG87YLku4YxLP3tivaDScOmQ7GKkNf3T9T0TtDiGwVnt51B5/mGc
 BehNFDIreCa/50M+UwY1EDXIED+YhLj0gE5VI/vvfriofev3vgWzaZAepbfLrzV6TQy0
 m1PnEL2CXWSpWTfY7BHSMPuc9wXMla/17EnbwBh2FIYvDo1FwDI5YX3l9OD9U4bwD50R
 nT67LowMe//GcSnuDN0UzXiyVdYE+xxnKvYegwjPERb5wAuq5ZooXz/So8MRMgv4Ulbr ug== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3quh44mmhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 15:51:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1685487076; bh=lAzDMz/6y98blMFq+QpMulvxXmq+eUcygEkgjl5viXE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=K7i7jW5yCK1XKKEDCXxDMBpWTkKKP+Lx8R64eQj/ya9MrE9wEV3bakYiC2mcLN0JE
         DajAxq0AuuM/AroOHBJGMzo+JZt0d+/tRM1C+b5SDG/4BeDjX5hLeBVFpj+7PpN5hz
         D6ad1N+BxY1ZimVtjJJmwb7cumXPstglpNR6bQVnyjjzI98wTJcSCJD7p0i6L/oLNs
         WzCwiCwYy/jcaHZBqIngHPUGzqHXyXiQKq19tkh5+jGoSJCkCA4WCnuTrA1yEJ5y5Y
         0lwlyYgN5d6NnCpGaia4pA/qaET7lKDUoN0aNoZsqvDNSnpudVq6z8Et3bNioTngM1
         0dPMLE9p9S8Dw==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ADB06401E3;
        Tue, 30 May 2023 22:51:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E0AC3A0083;
        Tue, 30 May 2023 22:51:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZNq29cv9;
        dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B046F4013A;
        Tue, 30 May 2023 22:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv3NqiBx1B3ecyJHhg9eEP9A3FhRK0rWYDnE5snDOHLYm8A8GJWpcP/cFhYhirHHmLJFl81aM4Km+1pyauEokXTVac5Vekg3aouLFPY3AwJknVzgFOTuSDySTBtetjVDxyoD6eC3ZDo8s5LZi4I35KmdGHgudLFp2eIL8f7muwp+k2D5xglZ/0L20d7nILBdAv5dumjqbYHfkIn6y6K7h1fRgZSxD4QsiSFs4C8+nHkAWoHn8sNd+UpngK8gJ2brXebCjV2xR8MxP+ZV4NFfqn4sBCYEdqfkCAfMhs6s0K4tIruZHcqSdECIsMMOy/v9gxVlvkhJjsHRUHUAFqDZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAzDMz/6y98blMFq+QpMulvxXmq+eUcygEkgjl5viXE=;
 b=MlMy/PC+J4PIxhYoRP0r/4jXCSCzAnaGeESP/NdXApUVC0P+5NDStfQNZjTPhmzzRyqoJOCtnKxCQQGeRacVNuEMNLuk0bKauC3LOa6crz+JIpLN1Wcq87aSJVmUcXYx5jcX3moBXoPTVaqnYoEHOTbKaIzqc/Y3CnfwZnFShZXRZtpxNtlgIXOLHd4vNoaDoy3Lhec+fw/Hz9w5YTfRqV3OSP1Wbf1Wv6Mk9LHjCLMEz3XQNl/5CIyUgmYwaFLHp277vnzWKSseE2BhE37HJddpUS7ow6en8E5vvLP4VWOTjs12NKES++BqVaZ1DGq4adS2g8YUVuqfsoD0JZDsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAzDMz/6y98blMFq+QpMulvxXmq+eUcygEkgjl5viXE=;
 b=ZNq29cv9hRcrAutajsYP0R8eS/V0ZgmKmteHkYvM1uP5groR9xKWEMUZS0WspZt9WaiL49tKdJFSdJwbU6Q6alOV0zzyZ+MxLUzYxMAZkmRHJzPzoY5VueHFmzkJ6wF2mbyzlJ5IcIxssx2WOpY+/YmHjMFbUz9o8DyqD2b3q58=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:51:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:51:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Thread-Topic: [PATCH v2 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Thread-Index: AQHZkCPWoyb7AC3RH0W4PeCdk3PdyK9zciAA
Date:   Tue, 30 May 2023 22:51:09 +0000
Message-ID: <20230530225100.wkeai3arwg6cmjjw@synopsys.com>
References: <1685141140-26228-1-git-send-email-quic_eserrao@quicinc.com>
 <1685141140-26228-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1685141140-26228-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4467:EE_
x-ms-office365-filtering-correlation-id: 87b262ee-aac9-4ac1-b35a-08db61605c85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVP3kNTHKmeJPTKhyM8eoypdRuRMg3x0dIkptw6TQSLKUB1Vxa2R0raECjb0xS8QlP9or3tzR+P8VC8E8dsilYv4xcN+X1SMKQ1FS4afkO7sDguDiPOEzzfzEnwv71BaqJsPZAJF8LKRXMOyhvTuDDl6xz1G4EL5rSTbj/XC2bEmLl7gUVBDKJjKmJ1RJ6LjTIcqhOIQFrxMmOCM11wIqKtmDuFQMM9lRJCiw3qy7b6i5Ao2DgvwiUM9kYKf7ztDwRk5OLWCNYf5lfTkcxMC5UX75u94IZv5ADZi2Q9270psCJbRPZGpUiQezaB7mInkVn+Lw9I9nJI8oWcq0hYi3S7g9Q+ZYPLhJeN7xhyBId6SwWm2JOZ1nXrT2V+yjDHHH5ybMxgcPsYz3WqIQiXzpu2j3lzZqI35Q0TFP/HcJxpHHzOEgwZnO7h9n38w3VQQbsrm6MADuMqFdApB64uYwQ2kr82iJF4gOotaEBBnKQO34A8vLVUwyPJLqKyY6dzDk2lzg9Kz9oO3CRdoKZFzaOr92j7PWeG8RKw5jAXYHZfEGFCfWJmK9mQD97Bz5vpuWAYaYhVFB5YJysBme/X1MTEUHeg1MtNIVndu7kizhUct9ncuWccgCmsTZkAXgUCI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(38100700002)(2616005)(41300700001)(83380400001)(6486002)(26005)(6506007)(1076003)(6512007)(186003)(478600001)(71200400001)(54906003)(66476007)(6916009)(66946007)(66556008)(76116006)(4326008)(66446008)(64756008)(316002)(122000001)(8936002)(36756003)(2906002)(38070700005)(15650500001)(5660300002)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hGYlJwanQ4ZEx6WTczdEd4MklpZGl6WjA3UENjbTZsN1g1RXlTZFd6cVha?=
 =?utf-8?B?VklSYUhDZGVKVVU4eUJoVFhIdmFCV3doSko4R1NHMFk4N0lTT0tibWFMS29G?=
 =?utf-8?B?QTR3RGI5MDBuVjNoeUdjYzFHQ1A2dW9INEhadGZvTThzSUYzU0FjQmNMWXI3?=
 =?utf-8?B?NXV4UUwzSVloWWs2Rkk2cEFjSndwQm1hYmwwbVJUZk83K1dXcE5wMjlNMCtt?=
 =?utf-8?B?T2ZkODlUZXhPc093UTVRaWRzdVJrcTI4NnNrUjR3K1Jicnh2ZjljdDhZVjF4?=
 =?utf-8?B?L3pudDJtUVFpS3ljSjEyc1NwdGJZcldFNEFUdkFLUVoyQ1Q3elc0a3graGZw?=
 =?utf-8?B?dUZJNkhzZ3R4VDZlTHBOYVJsQy9wbmpydjNnOE83N2dUYVdtYXVSak1vK0Zt?=
 =?utf-8?B?Y0NqeVB5aDZRM3puajBVWlUrZGx4RmFTN0tTVnJuQnIrVElNRFlObTdjRHdx?=
 =?utf-8?B?aWFGWVpvU0tTZm83VjhIeFpPQ05jQ3QyaENaZ0twSUp5MnI0dFZHR2RHZElV?=
 =?utf-8?B?KzJndFZ4cUIyMEFqT2h0VWp5aWE2eHRaSkdWVEV3b0lXbkM4S3Y0S3Zma25U?=
 =?utf-8?B?dE16c3dGY1VZNTdoZ3ZuQ0JvSngwU2lSLzF0V3VQS2JxSXZMNTBYWnRvcDFv?=
 =?utf-8?B?T2dYUFd4RjJCZ01GMmY0bDVuVW1TYUV2dHJUYm9uMGpVbFduMW4xSEthZU9O?=
 =?utf-8?B?MWkwUnV2YWZkWEhsb2I2WUE1dlN0T2RWR0NmS1QwNklGaUgwRUxWeXVWY3Js?=
 =?utf-8?B?QllreTJtQWxYdmM5MXdYTkdyS3JLaFIyNlJIaUNPdGt3VTdxNGQ3ZDBDQWh5?=
 =?utf-8?B?bVJzQUV6MUo2d1hlYnlONlA1Vk4zbEZucFBHV2pKSElkdU1lLzNVZU1WRmoz?=
 =?utf-8?B?eGc0OHVoOFV4Z3crSUx4amJ6bG9YWkh5TGcxMHB2WDYwOU0yV1I5OWY1OGZh?=
 =?utf-8?B?aTJaL0h4ZUF5RjZBYWR2WnpDV1BsZUY1eHpnSng5N3pXNlNqdm00SEpEMWhr?=
 =?utf-8?B?U1FEblNuQ3RKdFZZaWI2TmN6MktvTXIxYUtrQTdUdjZtb0Z3Y28yYWg5NHNL?=
 =?utf-8?B?SExFRFdIaytqSWxSR1VNQjVXeUxWY2E4djIyelVtM2hjRE1DL2x3S0VEYWxt?=
 =?utf-8?B?UUtMb1Y2MktkeFAyVStnSElPRlVERmE2RG1tREEreUh1Sy8wR1U0TWZSSXRB?=
 =?utf-8?B?WnBpelZkTzNBTzZqSzNYWUN6WWcwUnJFeWpxbzdFRXFFdTA2T1B0RVRIbFds?=
 =?utf-8?B?cmlkbVN3WUhjNmtZMm1VRzNQR0hmNUcrdmFPNlJJU3BseEJtZWh1TXJzclhQ?=
 =?utf-8?B?M0Y3OGd5dTFnTW1RRFUzWlB3UGZpZWRwUWVWMGwvTXRHOFpzVVZSYklKOFM4?=
 =?utf-8?B?dHpuWk1xK3BqTVZpREM3K2ppQ09oNVo4R2hKNkFKcGdLamk2eEYwb2tqZVpR?=
 =?utf-8?B?Zjg3bXA5aUdQU0V5RVorRGxyQ2NDRnBEMmEvdXZIcDVWaFM2bC94djU2Z2RV?=
 =?utf-8?B?eVhsWk5yS0wwSUR0NlVkTnlOMGpQbUV3N1VuYUhURlIyYWZ0ZWtCb0lsMUd0?=
 =?utf-8?B?R2pNcml1MVVhVytaTngrQ2FFMUlsc3FuUWV4cTh3ZS9hUmtDUmJTNCtzVFdZ?=
 =?utf-8?B?eHpzOU8ySkpSRFZDenRVVE02enc0NU04MmZXckJpK3FzZVhONVNLZ0RhaXNy?=
 =?utf-8?B?YVBKeEVScTZQUUVRbXRkNFJmdTFGRVNpQ2FwcFdaTXBNZkRKREQvUEFWblFj?=
 =?utf-8?B?TjhIL3dEU0hma0JwaWxmZzNLUEFmVXJ5RExBdElwMXlLWkRKOUw3WFc2WEtT?=
 =?utf-8?B?MzdOT0Y5VXYrNytIS1ptc0QzUWR0UWNLUU8vbExBNTY0MFZzUFhoanhDbG5j?=
 =?utf-8?B?cUVRRzdlR2VkaUpMamVBYjFTeWpwcURDVzN0RDF4Y3lFTkt4OHdnQ1ZJcWYz?=
 =?utf-8?B?K1RtRXZWYVJxMlgxWC9XVFpQaXpLT0U0RGxKRUs5UmtTd0R5bG5mR2lpbjZ1?=
 =?utf-8?B?aVVOczVFdy9UVEFCMmp3bWVaRllRb3k1cHlLSEdaQWdROHcyTWdjZ1JDaEgr?=
 =?utf-8?B?a2FYeUZ3NHY0MVE2YmFnaTFrcFRqQjFZU2Q3TnJTZzc3RitiMWQvRlpoS3Aw?=
 =?utf-8?Q?AbcnMc0rY+RZrtXjQr2NvoYIQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B055459950D6C4EB17A7D03EE5A44AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I2u7vK+JgCnond642OkqKclRaj2ZFE339caso7VAtSgGVCPDfutBfDYhIntT4fXS3jX9KLm9j+nkHdjArL7R7EvZfodV/jt4jT8kyhDs16ZWVsgXaZ9brMJyrZxIDASdGWZTfpTWNsgN69KtRjDtBgsG8d58HwQHg/ZPJPaIA7bmCeYbaniiwHxEsPdOcBQ/jEYnNgj3D3/Hp/32VLBGExfzOTN1TDTIIwIA5GN/gc1knVFJ7bRu3Oc6VXLn7AwEBXEzI32GESF1mdB7A6qYcWvRK2zwLuFM4QAl3gpwR4jXzrYtGy4vjKaebZza6WgVL0QDwWhWTHSGy9WSoGVG2BigwO9dh/HO97sCWxDAX2/u0LyKc29uAP6hQICPBQumiiWkpzjJPhxIts/qFTi8IZKw1xDf2F8zXU8+kyy3A41RLf7pKAV9xZScbrmIkz4sB02LzUZFJpGsBIKoJv/33ih1qIjZ4+d+uj+pUiRGohnZIPE89l653aRN/wk3foNsUKlbyYieaNK1m9r6qE/hEmlsNp0AhlSWn3/eaw9MDnxt2BXAX22zzJlszv0Qxxnii39t6A03bpB/GLANaxehSskq5uL4hagK2Mp48nV6v3u8Rj81rotLGqwqzOOgkfBn4h1MO7nSUEn9IXmAh2TyZ0YZo2Jf2Y79tGCZf8KnLU/7YrR3z5Ujn++ZLfxRXiL4eyU6P5gbYZJefCht4rdWLC3t3Lkk3S9XMZPJaUAqS6QPjIwEr6lGQFa8B3paOmlXic1Ej5U5ZU4Bi5a/m3ejPEVkkFPnWo6FWmPwmLJG1dOiZArf0XcMyvnnoWvliE/yB1FlFF/9zfK1xjK3wBIEcIzKPtBQgr8ftLIxZsMSTPGB0tmNcK83dG91bBWUO8AhkNuAsYC1sDkD+R+q6qgXsg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b262ee-aac9-4ac1-b35a-08db61605c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 22:51:09.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7Hr6uOwgDTqRhNzAO5l2sxfa7a84EiM4pMb+TiX85TIAgY342W91NDieVAjCqctpPGuHM8AlhlheIe9SkDpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
X-Proofpoint-GUID: E1XIMUTWlUNsNrpzgVNSfQN3nznxAhsm
X-Proofpoint-ORIG-GUID: E1XIMUTWlUNsNrpzgVNSfQN3nznxAhsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=623 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgTWF5IDI2LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiBG
b3IgYnVzIHN1c3BlbmQgc2NlbmFyaW8gd2Ugc2hvdWxkIHNraXAgY29udHJvbGxlciBoYWx0DQo+
IGFzIHdlIHN0aWxsIGhhdmUgdGhlIHVzYiBjYWJsZSBjb25uZWN0ZWQuIFNvIG1vZGlmeSB0aGUN
Cg0KSG93IGNhbiB5b3Uga25vdyB3aGVuIHRoZSBob3N0IHJlcXVlc3RzIGZvciByZXN1bWUgdG8g
d2FrZXVwIHRoZSBkZXZpY2U/DQpXZSBoYXZlbid0IGltcGxlbWVudGVkIGhpYmVybmF0aW9uIHRv
IGhhbmRsZSB0aGF0LiBJZiBpdCdzIGNvbW11bmljYXRlZA0KdGhyb3VnaCB0aGUgZ2x1ZSBsYXll
ciBzcGVjaWZpYyB2aWEgdGhlIHBoeSdzIGV2ZW50LCB0aGVuIGhvdyBkbyB5b3UNCnBsYW4gdG8g
bWFrZSBpdCBnZW5lcmljIGFuZCBub3Qgc3BlY2lmaWMgdG8geW91ciBwbGF0Zm9ybT8NCg0KVGhl
IHJlYXNvbiB3ZSBoYWx0IHRoZSBjb250cm9sbGVyIGFuZCBmb3JjZSBhIHNvZnQtZGlzY29ubmVj
dCBpcyBiZWNhdXNlDQp3ZSBkb24ndCBoYXZlIGEgaGFuZGxlIGZvciB0aGlzIHlldC4gUGVyaGFw
cyBJJ20gbWlzc2luZyBzb21ldGhpbmcgaGVyZQ0KYmVjYXVzZSBJIGRvbid0IHNlZSB5b3UgaGFu
ZGxlIGl0IGhlcmUgZWl0aGVyLg0KDQo+IHJ1bnRpbWUgcG0gb3BzIHRvIGhhbmRsZSBidXMgc3Vz
cGVuZCBzY2VuYXJpby4gQWxzbyBpbnZva2UNCj4gYXV0b3N1c3BlbmQgd2hlbiBkZXZpY2UgcmVj
ZWl2ZXMgVTMgbm90aWZpY2F0aW9uIHNvIHRoYXQNCj4gY29udHJvbGxlciBjYW4gZW50ZXIgcnVu
dGltZSBzdXNwZW5kZWQgc3RhdGUuIEVuc3VyZSB0aGF0DQo+IHRoZSBjb250cm9sbGVyIGlzIGJy
b3VnaHQgb3V0IG9mIHJ1bnRpbWUgc3VzcGVuZCBiZWZvcmUNCj4gdHJpZ2dlcmluZyByZW1vdGUg
d2FrZXVwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVpY19lc2Vy
cmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAx
OSArKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNDAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA1MiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5k
ZXggMjc4Y2QxYy4uNzc4NzgwNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTIxMTksNiArMjExOSwx
MiBAQCBzdGF0aWMgaW50IGR3YzNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMyAgICAgKmR3YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiAgCWludAkJcmV0Ow0KPiArCXUzMgkJcmVnOw0KPiArDQo+ICsJcmVnID0gZHdjM19yZWFkbChk
d2MtPnJlZ3MsIERXQzNfRFNUUyk7DQoNClRoaXMgZnVuY3Rpb24gaXNuJ3QgZGV2aWNlIG1vZGUg
c3BlY2lmaWMsIGJ1dCB5b3UncmUgY2hlY2tpbmcgZGV2aWNlDQptb2RlIHNwZWNpZmljIHN0YXR1
cyBoZXJlLg0KDQo+ICsJLyogRm9yIGJ1cyBzdXNwZW5kIGNhc2UgZG8gbm90IGhhbHQgdGhlIGNv
bnRyb2xsZXIgKi8NCj4gKwlpZiAoZHdjLT5jb25uZWN0ZWQgJiYgKERXQzNfRFNUU19VU0JMTktT
VChyZWcpID09IERXQzNfTElOS19TVEFURV9VMykpDQo+ICsJCXJldHVybiAwOw0KPiAgDQo+ICAJ
aWYgKGR3YzNfcnVudGltZV9jaGVja3MoZHdjKSkNCj4gIAkJcmV0dXJuIC1FQlVTWTsNCj4gQEAg
LTIxMzUsNiArMjE0MSwxMiBAQCBzdGF0aWMgaW50IGR3YzNfcnVudGltZV9yZXN1bWUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBkd2MzICAgICAqZHdjID0gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+ICAJaW50CQlyZXQ7DQo+ICANCj4gKwkvKiByZXN1bWUgZnJvbSBidXMgc3VzcGVu
ZCAqLw0KPiArCWlmIChkd2MtPmNvbm5lY3RlZCkgew0KPiArCQlkd2MzX2dhZGdldF9wcm9jZXNz
X3BlbmRpbmdfZXZlbnRzKGR3Yyk7DQo+ICsJCWdvdG8gcmVzdW1lOw0KPiArCX0NCj4gKw0KPiAg
CXJldCA9IGR3YzNfcmVzdW1lX2NvbW1vbihkd2MsIFBNU0dfQVVUT19SRVNVTUUpOw0KPiAgCWlm
IChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+IEBAIC0yMTQ5LDYgKzIxNjEsNyBAQCBzdGF0aWMg
aW50IGR3YzNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCQlicmVhazsN
Cj4gIAl9DQo+ICANCj4gK3Jlc3VtZToNCj4gIAlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRl
dik7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gQEAgLTIxNTcsOSArMjE3MCwxNCBAQCBzdGF0aWMg
aW50IGR3YzNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgc3RhdGljIGlu
dCBkd2MzX3J1bnRpbWVfaWRsZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0
IGR3YzMgICAgICpkd2MgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwl1MzIJCXJlZzsNCj4g
IA0KPiAgCXN3aXRjaCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gIAljYXNlIERXQzNfR0NU
TF9QUlRDQVBfREVWSUNFOg0KPiArCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19E
U1RTKTsNCj4gKwkJLyogZm9yIGJ1cyBzdXNwZW5kIGNhc2UgcmV0dXJuIHN1Y2Nlc3MgKi8NCj4g
KwkJaWYgKERXQzNfRFNUU19VU0JMTktTVChyZWcpID09IERXQzNfTElOS19TVEFURV9VMyAmJiBk
d2MtPmNvbm5lY3RlZCkNCj4gKwkJCWdvdG8gYXV0b3N1c3BlbmQ7DQo+ICAJCWlmIChkd2MzX3J1
bnRpbWVfY2hlY2tzKGR3YykpDQo+ICAJCQlyZXR1cm4gLUVCVVNZOw0KPiAgCQlicmVhazsNCj4g
QEAgLTIxNjksNiArMjE4Nyw3IEBAIHN0YXRpYyBpbnQgZHdjM19ydW50aW1lX2lkbGUoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiAgCQlicmVhazsNCj4gIAl9DQo+ICANCj4gK2F1dG9zdXNwZW5kOg0K
PiAgCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2KTsNCj4gIAlwbV9ydW50aW1lX2F1dG9z
dXNwZW5kKGRldik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDU5NjU3OTYuLjc1ODc5MTIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjQwMCwxNSArMjQwMCwyMSBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZykNCj4gIAkJcmV0dXJuIC1F
SU5WQUw7DQo+ICAJfQ0KPiAgDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxh
Z3MpOw0KPiAgCWlmICghZHdjLT5nYWRnZXQtPndha2V1cF9hcm1lZCkgew0KPiAgCQlkZXZfZXJy
KGR3Yy0+ZGV2LCAibm90IGFybWVkIGZvciByZW1vdGUgd2FrZXVwXG4iKTsNCj4gLQkJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJCXJldHVybiAtRUlOVkFM
Ow0KPiAgCX0NCj4gLQlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dha2V1cChkd2MsIHRydWUpOw0KPiAg
DQo+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkd2MtPmRldik7DQo+ICsJaWYg
KHJldCA8IDApIHsNCj4gKwkJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGR3Yy0+ZGV2KTsNCj4g
KwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+ICsJcmV0ID0gX19kd2MzX2dhZGdldF93YWtldXAoZHdjLCB0cnVlKTsN
Cj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwlwbV9y
dW50aW1lX3B1dF9ub2lkbGUoZHdjLT5kZXYpOw0KPiAgDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0N
Cj4gQEAgLTI0MjcsNiArMjQzMywxMiBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2Z1bmNfd2Fr
ZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaW50Zl9pZCkNCj4gIAkJcmV0dXJuIC1FSU5W
QUw7DQo+ICAJfQ0KPiAgDQo+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkd2Mt
PmRldik7DQo+ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVk
KGR3Yy0+ZGV2KTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gIAlzcGluX2xvY2tf
aXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJLyoNCj4gIAkgKiBJZiB0aGUgbGluayBp
cyBpbiBVMywgc2lnbmFsIGZvciByZW1vdGUgd2FrZXVwIGFuZCB3YWl0IGZvciB0aGUNCj4gQEAg
LTI0MzcsNiArMjQ0OSw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZnVuY193YWtldXAoc3Ry
dWN0IHVzYl9nYWRnZXQgKmcsIGludCBpbnRmX2lkKQ0KPiAgCQlyZXQgPSBfX2R3YzNfZ2FkZ2V0
X3dha2V1cChkd2MsIGZhbHNlKTsNCj4gIAkJaWYgKHJldCkgew0KPiAgCQkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJCQlwbV9ydW50aW1lX3B1dF9ub2lk
bGUoZHdjLT5kZXYpOw0KPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJCX0NCj4gIAkJZHdjM19y
ZXN1bWVfZ2FkZ2V0KGR3Yyk7DQo+IEBAIC0yNDUwLDYgKzI0NjMsNyBAQCBzdGF0aWMgaW50IGR3
YzNfZ2FkZ2V0X2Z1bmNfd2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaW50Zl9pZCkN
Cj4gIAkJZGV2X2Vycihkd2MtPmRldiwgImZ1bmN0aW9uIHJlbW90ZSB3YWtldXAgZmFpbGVkLCBy
ZXQ6JWRcbiIsIHJldCk7DQo+ICANCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gKwlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZHdjLT5kZXYpOw0KPiAgDQo+
ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gQEAgLTI3MTEsMjEgKzI3MjUsMjMgQEAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4g
IAkvKg0KPiAgCSAqIEF2b2lkIGlzc3VpbmcgYSBydW50aW1lIHJlc3VtZSBpZiB0aGUgZGV2aWNl
IGlzIGFscmVhZHkgaW4gdGhlDQo+ICAJICogc3VzcGVuZGVkIHN0YXRlIGR1cmluZyBnYWRnZXQg
ZGlzY29ubmVjdC4gIERXQzMgZ2FkZ2V0IHdhcyBhbHJlYWR5DQo+IC0JICogaGFsdGVkL3N0b3Bw
ZWQgZHVyaW5nIHJ1bnRpbWUgc3VzcGVuZC4NCj4gKwkgKiBoYWx0ZWQvc3RvcHBlZCBkdXJpbmcg
cnVudGltZSBzdXNwZW5kIGV4Y2VwdCBmb3IgYnVzIHN1c3BlbmQgY2FzZQ0KPiArCSAqIHdoZXJl
IHdlIHdvdWxkIGhhdmUgc2tpcHBlZCB0aGUgY29udHJvbGxlciBoYWx0Lg0KPiAgCSAqLw0KPiAg
CWlmICghaXNfb24pIHsNCj4gIAkJcG1fcnVudGltZV9iYXJyaWVyKGR3Yy0+ZGV2KTsNCj4gLQkJ
aWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4gKwkJaWYgKHBtX3J1bnRpbWVf
c3VzcGVuZGVkKGR3Yy0+ZGV2KSAmJiAhZHdjLT5jb25uZWN0ZWQpDQo+ICAJCQlyZXR1cm4gMDsN
Cj4gIAl9DQo+ICANCj4gIAkvKg0KPiAgCSAqIENoZWNrIHRoZSByZXR1cm4gdmFsdWUgZm9yIHN1
Y2Nlc3NmdWwgcmVzdW1lLCBvciBlcnJvci4gIEZvciBhDQo+ICAJICogc3VjY2Vzc2Z1bCByZXN1
bWUsIHRoZSBEV0MzIHJ1bnRpbWUgUE0gcmVzdW1lIHJvdXRpbmUgd2lsbCBoYW5kbGUNCj4gLQkg
KiB0aGUgcnVuIHN0b3Agc2VxdWVuY2UsIHNvIGF2b2lkIGR1cGxpY2F0ZSBvcGVyYXRpb25zIGhl
cmUuDQo+ICsJICogdGhlIHJ1biBzdG9wIHNlcXVlbmNlIGV4Y2VwdCBmb3IgYnVzIHJlc3VtZSBj
YXNlLCBzbyBhdm9pZA0KPiArCSAqIGR1cGxpY2F0ZSBvcGVyYXRpb25zIGhlcmUuDQo+ICAJICov
DQo+ICAJcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhkd2MtPmRldik7DQo+IC0JaWYgKCFyZXQg
fHwgcmV0IDwgMCkgew0KPiArCWlmICgoIXJldCAmJiAhZHdjLT5jb25uZWN0ZWQpIHx8IHJldCA8
IDApIHsNCj4gIAkJcG1fcnVudGltZV9wdXQoZHdjLT5kZXYpOw0KPiAgCQlyZXR1cm4gMDsNCj4g
IAl9DQo+IEBAIC00MzEzLDYgKzQzMjksOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9zdXNw
ZW5kX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQlkd2MzX3N1c3BlbmRfZ2FkZ2V0
KGR3Yyk7DQo+ICANCj4gIAlkd2MtPmxpbmtfc3RhdGUgPSBuZXh0Ow0KPiArCXBtX3J1bnRpbWVf
bWFya19sYXN0X2J1c3koZHdjLT5kZXYpOw0KPiArCXBtX3JlcXVlc3RfYXV0b3N1c3BlbmQoZHdj
LT5kZXYpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9pbnRlcnJ1cHQo
c3RydWN0IGR3YzMgKmR3YywNCj4gQEAgLTQ3MDMsNyArNDcyMSwxNSBAQCB2b2lkIGR3YzNfZ2Fk
Z2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudHMoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAlp
ZiAoZHdjLT5wZW5kaW5nX2V2ZW50cykgew0KPiAgCQlkd2MzX2ludGVycnVwdChkd2MtPmlycV9n
YWRnZXQsIGR3Yy0+ZXZfYnVmKTsNCj4gKwkJcG1fcnVudGltZV9wdXQoZHdjLT5kZXYpOw0KPiAg
CQlkd2MtPnBlbmRpbmdfZXZlbnRzID0gZmFsc2U7DQo+ICAJCWVuYWJsZV9pcnEoZHdjLT5pcnFf
Z2FkZ2V0KTsNCj4gKwkJLyoNCj4gKwkJICogV2UgaGF2ZSBvbmx5IHN0b3JlZCB0aGUgcGVuZGlu
ZyBldmVudHMgYXMgcGFydA0KPiArCQkgKiBvZiBkd2MzX2ludGVycnVwdCgpIGFib3ZlLCBidXQg
dGhvc2UgZXZlbnRzIGFyZQ0KPiArCQkgKiBub3QgeWV0IGhhbmRsZWQuIFNvIGV4cGxpY2l0bHkg
aW52b2tlIHRoZQ0KPiArCQkgKiBpbnRlcnJ1cHQgaGFuZGxlciBmb3IgaGFuZGxpbmcgdGhvc2Ug
ZXZlbnRzLg0KPiArCQkgKi8NCj4gKwkJZHdjM190aHJlYWRfaW50ZXJydXB0KGR3Yy0+aXJxX2dh
ZGdldCwgZHdjLT5ldl9idWYpOw0KPiAgCX0NCj4gIH0NCj4gLS0gDQo+IDIuNy40DQo+IA0KDQpC
UiwNClRoaW5o

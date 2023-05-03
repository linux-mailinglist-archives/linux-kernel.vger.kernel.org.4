Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F017F6F60A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjECVuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:50:10 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE072BE;
        Wed,  3 May 2023 14:50:08 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343J8UVQ024943;
        Wed, 3 May 2023 14:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=xhG+eK1NNyMpLHC+dkx6nhuBqJhn9HMGdrJpbqpx920=;
 b=N5R48Drh3blTuasXmS+ucGkx/mrXd0xRMHi7MgAlAuic8pILjYDAhdlH6l2f/cs/IaiW
 VC/FJJanBoDUAqhRQacRrzPN6Nv4nWUcL6PISXeuSBde2HmpzkNZ/wxF2B7P5p6K8RX7
 kUxJTwKuLBtTV4kMtoWpVgwrbJ02I4sV+PeSsax+A6u7turc7ZVuHkgT9xnAqXtO8XGK
 NHL0RBqFA6JakSUeu2C9QbgzCx+TRDzAXZaj1vqhFpIZ7JL3LO88xHooupHa465KMy9g
 AhLmWKtak6WBSbCySkGPzRhu0H2x9WEO3GTSZnitiCtpYfYmf4uYYO6yX2wNc5ckWFhZ ZQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q928sk1bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 14:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683150585; bh=xhG+eK1NNyMpLHC+dkx6nhuBqJhn9HMGdrJpbqpx920=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=O+eoZVRwla67GW3VwMDDNkM+iwAa4bIgnvklCL5yWx4rXtLaeOTNsmCht50QS3jrQ
         vn7Qt5obUlDDWQ1VKhbPXZjXaE2e7ebVM7jc0zm+8y/IH5y3Ld6r1grBKb+kYIE/V1
         8wRx8oeDlf7s5MH0KW2SbyUnNLg0l1y7nhvHmD0HuTZCWmKkFaBAHnq6CE2ROCTntS
         F0tO314LLRpysrd0coreEf1OnYM05+x5Bf4hnFwRo08b2XVYb5Ujgp8i3kC4ZE3Bz+
         T9qbSG0vnx+skZFpdiBlKiCXFufkRxRBWzL18kyaaZK+83xYB59KLeI6cubN6QFqR9
         /4NH9nUp+GRpA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DCF8D404D1;
        Wed,  3 May 2023 21:49:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4CEA5A0062;
        Wed,  3 May 2023 21:49:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OJo7SrP9;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7714540605;
        Wed,  3 May 2023 21:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFT/WTDDYS12oRxBWmUfdT9xXHboiCN1B4aoU2gehXbBbXKKIaKUIutRLw6vVXG8zcQMJV53oL3+m+fi43aIlmokYunW9NWrlL6suVqflzbBnvoaiASkCnIicqBf1AcneJ2Ogcp2g3E/ZPwezfk/FWORYCvMpYznwLTfI22IqB0xOY7SB1L3PDkOJCFMqSZXSFao8ryXixrNxcalhlcHC6s3kGCTl/m5G1OizMBnu0ffr7wniRibxKrzw+6338cICU0eQvZGalg4B0yv7PESZTajwl4MOG/pNcXvo71UuFmaAQvkKfM+sxJaXdKh+qhz7lLOp0JMgAzi9P/4r5OhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhG+eK1NNyMpLHC+dkx6nhuBqJhn9HMGdrJpbqpx920=;
 b=BWDtYXR7Gfwfh8xhGFTMTblWSOjlY2V500lGdKIiiDw0y9PVDpZKOHjbi0ZclzEALlew5XjRTP6/ZGQCaqbwGKtwtDN/V/RoeOJ+mbDYb2aZ+W315Il5YxWYN3ahOyh7zjQxQ7QzBm5ysNWz9PC45TNIkpg8IK5DNzHbnS2ytE0tHAvMM9CJYRiMxiJFyQ0EWTb1cFTVgUJxoxeOheWB6ngcCiHbJr922VpFs+YfMWDMoxB0Os8I9oct6BrfcahoULqHpkUnOKRFXWLlSiHMEAIc/wsb3VphWh/YngbSGwjqqVPA9krBCKNr0zZO+jp6Lv6HcLgaJFviEUNc2TfzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhG+eK1NNyMpLHC+dkx6nhuBqJhn9HMGdrJpbqpx920=;
 b=OJo7SrP9xIEdp1OZP+ORscuRYrrtCXiZkvEyzloALOLyAStzHe8Zy7Godc29jGVNGqOwNqePOm75rhRQD9odW1t+wdJyg4cqw2g4AqBJY6odj0IQnhjzRiJLTJrusbbGYfOKWgoRvVhaqBNodNhCUYiXUh91hCvBVPnxKX9bxas=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 21:49:34 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 21:49:34 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZfDo86WSzaQCTUEyAS9trpGt8y69HhUWAgABmdICAAS4UAA==
Date:   Wed, 3 May 2023 21:49:34 +0000
Message-ID: <20230503214926.x76cb5p2neaie2hq@synopsys.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-4-quic_kriskura@quicinc.com>
 <20230502214133.fovxi3vfh2s6ujpz@synopsys.com>
 <2b60b5cd-df7e-0686-cdcb-4a7ccac360cf@quicinc.com>
In-Reply-To: <2b60b5cd-df7e-0686-cdcb-4a7ccac360cf@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB6329:EE_
x-ms-office365-filtering-correlation-id: 4b47e7bf-ddf3-4571-dc22-08db4c204871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uMLho8o19hf9Ju2jLhHl0Km4wXVc+Dc0IKsgEyDUrlqolgPUXkUdLVe3pSZRfnQBnKWnk70LGXjllMpzLCkDj/jn7Ct6knaijiMvvxPDRDZ06ZeCBmrW9ojAgxQSVndar5vYAx14e4qb4whvMSPOatVr1RSrTHQfmSj3N3a2VH7kVMacanoFavIMxG1TCt3A3XaGZHXqs0JfX2ky6iG9mUDnRy+6iovjvrjA4vBC4RRT2SjqGM+K69GCSKOXprJWumMvyVHdCQn+LUlKkPGPGy1BawlVR7gN+YrH9BpvxzquqMBWsypv/Ns4hDZ9Avse2UlnCpKM767Ti7N1GDxmOdThCQhk0tiWu2xUnyfqvGCVlGd98EOXqNd02+LbO5Lj0orZQVZiLsafEi0TDWwdje/H1XsRafNtmofqeTQN9Xge1DxAqk4JBHX8TGK+3o+3yfIAmBQCHsTMZNIUqyDi28SC3s+vFTg/c7awpliq9hvCkzyzDn1ccxrT3xNMrCC0+Nbk4CNCJ7NzIleoMQQ95pxOLI2hn8EnMq0q1ugA3JlMkOkesDFb8g0cn6FL2KDoN/+sUHp1cv58IvHjPzrBTOE1zoID3QqCHTFVaqjUeDgfLSScFxQLEGDc1L9rlSXe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(38100700002)(122000001)(38070700005)(71200400001)(478600001)(6486002)(7416002)(5660300002)(316002)(66446008)(66556008)(66476007)(41300700001)(64756008)(8676002)(8936002)(6916009)(54906003)(4326008)(66946007)(76116006)(83380400001)(2906002)(6512007)(26005)(186003)(6506007)(53546011)(1076003)(2616005)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjZBZVFDUFJUNnNlUms4VTJ4TTRPMlkyUExJdENBaEg0aU0xM2JqSFpmL3Qr?=
 =?utf-8?B?VC9JQWNSaWhPMjBpQ2NRcmJZVHhsK2lCZkRPY2NFUGJCeHZUMGwzZm42RWx1?=
 =?utf-8?B?VmdEejZTQ3N0VmNoamhHVGpnR0wvZWhJNmtHdkhOSmZ0WDZUa3BvcFpRQ2Q0?=
 =?utf-8?B?cWVNVkJHaEJPMU5RSFY2NkFiSHVvUkZFNEMwdlJRRStmNDFzVGorU25QOVZn?=
 =?utf-8?B?enlqNEVRVlROZFV2cE8yUUV0SDdRT3VKZ2U1WjFsZzRVendIUDJlSXBVSnNl?=
 =?utf-8?B?RFM4REdHWi9IR056dmtuZHIwNWF5NVdwYU1JL2w4UXhVK2RFMmdFRDlMcE9L?=
 =?utf-8?B?SHU4cCt6K1RxTUd2RE5KTGlCWGU5WjZNS01yWUxuTUVqanhvVnlZVjRmU3hs?=
 =?utf-8?B?ZmtPQlQ1R3NvdkR4WWNRSEZxM1RPenh6SUpZV09TQVZyR0NyT0RrcVdOdFRD?=
 =?utf-8?B?MWNOblhlQzM5MWFXZTROcFdaaXAxWksybmovc3hYOXIyL2NEY0Y2enJUeTln?=
 =?utf-8?B?QmZublhITWgvcnRpc1hiQ2xEc3lqZzU5MzVXbXVpVFhHV2ZwSzBtSFIydzNF?=
 =?utf-8?B?ZlpkWGZjVTc1SW0yeitsWFZ5eEcvT0dLSG1zZVYydE13ZHJsK3FVSkhudk81?=
 =?utf-8?B?cXJieVpEaHM3VVo1bkVjMXR2K0RURDY4WFoxWFFBUitqRXU2akwyNXFTL2Jl?=
 =?utf-8?B?Sk5rSmhCazhoemxsTDFST1poQzF5ZVNQNGxRNGdKckpreE9ma3hzNm00N2ho?=
 =?utf-8?B?RkVtemhLVzd2L1JkbkNnUXIwZWQ3ME9CS1lIMGNkS2Jxa1FDK24yVDQzb1R4?=
 =?utf-8?B?TDIyQncweERUS3hDcWoyc0NpSTdGdkkxQW9IRkNWaDY3OVFlVFdyMC9Ka292?=
 =?utf-8?B?VG1MemszWW5vYmd5QnNSUnRZcW9tMS9HVVM1RXJtcTU0enFrK2tJVXFSNC96?=
 =?utf-8?B?b3dVUU9nZk5VK1BGZUZDeGZQS3pkZGdYbWJFbUdKbGNsT014VXRHMzJKYXJZ?=
 =?utf-8?B?bFY5d0o0ZWt5cW95U1Nlb09OQi9jMDdWV1V4OVdKTXFNNllQRG56RW0zVEV5?=
 =?utf-8?B?ZWUra2diODZTUGdXeW5sQkpvN0FhaGJIaUFnUkpWd2gwZll1emtWVERaS3Jw?=
 =?utf-8?B?OFFHMlNJRXpnS21UV0FOQnV3MzYvQlhyZjFLamI0bnBuL3MrR3QzajVKV0Ft?=
 =?utf-8?B?ZDVLZFVlVU81MFFLV2pBNWdBdjY4ZnRNWkxJWFJsVXBJQW1sWlc0SEFjRkor?=
 =?utf-8?B?WmRtSkZ6RzdkaTdobVdLMklkUnpqcjdiYzNTc2M5TlFWQ2lOd2ZjUk9vNzA0?=
 =?utf-8?B?R2hJbDFnTE90NEQwUytoS00zY2w2b0JueGZMeUxDRG1nSXlCSm9LSmgydlNx?=
 =?utf-8?B?dlZRNXRxbFNvYlZGeTdBT1k1Nk05Yi9VRkVzV2ovZUJrLzRyUFBoOU4yVUFL?=
 =?utf-8?B?cFRzQnJ6cEk1cW1jbVVwQm4rM1NXczZ6WHhZM0p6ZWpvaGRNY00zT0poSTg4?=
 =?utf-8?B?OTV2aFhrK3F6RjZFRzlqNjVwN2t4OHdiRklmOWNlYit0L2NMM2ZVZ0dHSXdJ?=
 =?utf-8?B?djdXVXJoYXhPeThQL2xSMkRFaDZvK3ZUZWRXcGdwcFpLSW10cWQzQlRLVEds?=
 =?utf-8?B?ZXd4QXZkU0dDRlF1SGxKbEdibjE5djhjTmxXdWxyaHVNRG9CVDc4eDFtQnB4?=
 =?utf-8?B?NjF1WGgrc3BQVnhWSnFGUlpvZVNMcHo1YWlnUkUzSGVtKytRdEt2U0pXWmEx?=
 =?utf-8?B?KzQzS2F1UVZaTGxEeVQ3R1VFTjJidGZxY0R6RUcvam12aFpwWDc2K3dSWXEr?=
 =?utf-8?B?OUVOVEsyc29SeEYxTm15djk0UHBGR3NBUWV0d3JZL1cwTjRYcHlleU03Ynkv?=
 =?utf-8?B?S2pzbkFoSWluMmxZeGFHd3RKN1JNQVc0Wjh6ZnM3dDBlenh3UklrRUJIMnpS?=
 =?utf-8?B?b2FscGFobXZ3cXFZb1VwY3F3aitMSTB6SkhwTjZUaVVyWkRQMmJBNThZN0Z6?=
 =?utf-8?B?Y3ZLZU9VaWR6Y1kxdlp0d3M4RnRtTlVKTkZtVU1SVUxURmZxVThjdjdiUlVo?=
 =?utf-8?B?WVBuQWRIc1Z5ajRsVlU1dzg1eEcyWXNFWDdJUDdCVm4xR3JaeG00MnFKRC9Q?=
 =?utf-8?Q?uWNIRM9c/lQ7jQBd+yUs2YR3/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47D9E6CBBDBDA942B68F339EF7E8FB64@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TGZsNGV2TGw4c2luRHNsdzUyZW0xMCtoNTF3bXRGZWxGT0pEYjdaNXQ4aVpm?=
 =?utf-8?B?U2dvSnhWYnh0emlxTGQ1YWlPUWhNd2J2bnMwSjljMVorbUV4d2dwLy9BS0hm?=
 =?utf-8?B?ei83RnBVUFhwaTBRTDI1NUlHbnhMYVMwem5EN2NXL25Md3FlR1NuSlBSNHZu?=
 =?utf-8?B?VFYzZnNvWWNzNWJZMElSUWs3bFRJRmxZUk8zUWd1dm50bDI5YU9ZTnZ0NE9s?=
 =?utf-8?B?NzJSK0VTNVQ0VGVVK044Y0lRY0VXVFA0aGdHMlpheEQzcENQdnQ3M0ZucGk3?=
 =?utf-8?B?dERqS1MrZTgwTnFydEhFTTVDOHhtamEvRC9qQlNHUFhFdFUwd1N6ZmNMdkN4?=
 =?utf-8?B?L0pxaHo0OGVQYWEzcXlWZFUyZmd0a3Z4dFFCUmpQNkpoY21zQUJuYnpuQmxG?=
 =?utf-8?B?aXJLbFlvTFNmSzdia2ZxMG1ublVPUnE5VlI1Y0hwS3lTZEdCY0J6cXNQeHkw?=
 =?utf-8?B?WkdINlhQNU9kaVNUVFRUbDltWmliRkZuT2Nlc0k4cnVGQzFmeDdmTVFnTDN1?=
 =?utf-8?B?OEV1NmN0TXdoRGJYdE5VZWptMXJDYjlCTDQ2dnp5RnMrQXEvRjlVcUFWbmdp?=
 =?utf-8?B?Z3BzV0lQamI5WGFXWVdMTTlDRGp3WXlxWG5EamxJSjd4MUNRaXNMcktIcEto?=
 =?utf-8?B?Q1YyQTVTVFNkYkI1UFVEeFBkMU52Qk9kTkUyODlzajJGNit5ODNxVm5yTjFU?=
 =?utf-8?B?TmhRaUFVV3dReU1KRzIxUW11K0tnMFVsb2M0VTNrVXF1WGRuREx5M1MvVFJW?=
 =?utf-8?B?TjN4clhmWVlaQXZlWFVDdmZRKzhvem9RakxYQUpHR3IvUUNwM0t2b01iZlBo?=
 =?utf-8?B?eVhsM0J2TWMyLzhoRVRqTTdscGFnSFpLRkJ2NXpMOFVaWUM0T3l4TzRzeWIz?=
 =?utf-8?B?WWRKUjhyeTZLYnpzSWFSOUxUQjd2UDNSOFBWL0gvandqYUdNVVRsQWZ1SEJp?=
 =?utf-8?B?TktaaG1jbnVTR1VjbkJxOXBkSTBLdi8rK1RMZ2gwdjRtR1NwZFFNNzA5bmph?=
 =?utf-8?B?Vis3ZE9UcVVoMzIvNk1DL0JTSXV6b0lCNFFQMEhBWDdBeU9tenZHL0NjREZn?=
 =?utf-8?B?UmNFRTZBV2Q1cUJJZ1dIRXVVUXF0MHVvWTJjNjIxaDl2cWp5WGpKR2tCNVds?=
 =?utf-8?B?SXhzNkpuL2l3bGlvSlNnOTQvakYwZEdTenhZQlVpTURmSHI0ci9wZERKNzlH?=
 =?utf-8?B?a3AwVXpkZ2RrZ3hHWDNJM2pjL0RDMzI1MXc4dm5zeGRMbytrREQraVdIbGZD?=
 =?utf-8?B?NTJIekJmVGxaM1Y0U0lUUUswZ0tyTjFMZklDcnhvdVU0UUdkdkdlWmpIbDFy?=
 =?utf-8?B?dnFPZ0JIaFd6cHFLajhRcWtDc3pMUnlwbXNvbUczb251VmJrbEx2dG1xdnE5?=
 =?utf-8?B?cEtMaE9FaE1WOGc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b47e7bf-ddf3-4571-dc22-08db4c204871
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 21:49:34.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15AIOgyLlW85YVzrHzaL5O9OqiGncn2mVPmbDNXJJoRQhkzcXF6yBZzBbg0F9jKqeVD94QtrYcO5aZ2+vPK7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
X-Proofpoint-GUID: Ifrqp4TfV-vIxDpTg2nwGRIn6I3XKjcW
X-Proofpoint-ORIG-GUID: Ifrqp4TfV-vIxDpTg2nwGRIn6I3XKjcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305030187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMDMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8zLzIwMjMgMzoxMSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0K
PiA+IA0KPiA+IE9uIE1vbiwgTWF5IDAxLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0K
PiA+ID4gQ3VycmVudGx5IGhvc3Qtb25seSBjYXBhYmxlIERXQzMgY29udHJvbGxlcnMgc3VwcG9y
dCBNdWx0aXBvcnQuDQo+ID4gPiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZv
ciBob3N0LW9ubHkgY29udHJvbGxlcnMgYW5kIHBhcnNlDQo+ID4gPiBYSENJIEV4dGVuZGVkIENh
cGFiaWxpdGllcyByZWdpc3RlcnMgdG8gcmVhZCBudW1iZXIgb2YgdXNiMiBwb3J0cyBhbmQNCj4g
PiA+IHVzYjMgcG9ydHMgcHJlc2VudCBvbiBtdWx0aXBvcnQgY29udHJvbGxlci4gRWFjaCBVU0Ig
UG9ydCBpcyBhdCBsZWFzdCBIUw0KPiA+ID4gY2FwYWJsZS4NCj4gPiA+IA0KPiA+ID4gVGhlIHBv
cnQgaW5mbyBmb3IgdXNiMiBhbmQgdXNiMyBwaHkgYXJlIGlkZW50aWZpZWQgYXMgbnVtX3VzYjJf
cG9ydHMNCj4gPiA+IGFuZCBudW1fdXNiM19wb3J0cy4gVGhlIGludGVudGlvbiBpcyBhcyBmb2xs
b3dzOg0KPiA+ID4gDQo+ID4gPiBXaGVyZXZlciB3ZSBuZWVkIHRvIHBlcmZvcm0gcGh5IG9wZXJh
dGlvbnMgbGlrZToNCj4gPiA+IA0KPiA+ID4gTE9PUF9PVkVSX05VTUJFUl9PRl9BVkFJTEFCTEVf
UE9SVFMoKQ0KPiA+ID4gew0KPiA+ID4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19w
aHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiA+IAlwaHlfc2V0X21vZGUoZHdjLT51c2Iz
X2dlbmVyaWNfcGh5W2ldLCBQSFlfTU9ERV9VU0JfSE9TVCk7DQo+ID4gPiB9DQo+ID4gPiANCj4g
PiA+IElmIG51bWJlciBvZiB1c2IyIHBvcnRzIGlzIDMsIGxvb3AgY2FuIGdvIGZyb20gaW5kZXgg
MC0yIGZvcg0KPiA+ID4gdXNiMl9nZW5lcmljX3BoeS4gSWYgbnVtYmVyIG9mIHVzYjMtcG9ydHMg
aXMgMiwgd2UgZG9uJ3Qga25vdyBmb3Igc3VyZSwNCj4gPiA+IGlmIHRoZSBmaXJzdCAyIHBvcnRz
IGFyZSBTUyBjYXBhYmxlIG9yIHNvbWUgb3RoZXIgcG9ydHMgbGlrZSAoMiBhbmQgMykNCj4gPiA+
IGFyZSBTUyBjYXBhYmxlLiBTbyBpbnN0ZWFkLCBudW1fdXNiMl9wb3J0cyBpcyB1c2VkIHRvIGxv
b3AgYXJvdW5kIGFsbA0KPiA+ID4gcGh5J3MgKGJvdGggaHMgYW5kIHNzKSBmb3IgcGVyZm9ybWlu
ZyBwaHkgb3BlcmF0aW9ucy4gSWYgYW55DQo+ID4gPiB1c2IzX2dlbmVyaWNfcGh5IHR1cm5zIG91
dCB0byBiZSBOVUxMLCBwaHkgb3BlcmF0aW9uIGp1c3QgYmFpbHMgb3V0Lg0KPiA+ID4gDQo+ID4g
PiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRvIG1vZGlmeSBHVVNCM1BJUEVDVEwgcmVnaXN0ZXJz
IHdoaWxlIHNldHRpbmcgdXANCj4gPiA+IHBoeSdzIGFzIHdlIG5lZWQgdG8ga25vdyBob3cgbWFu
eSBTUyBjYXBhYmxlIHBvcnRzIGFyZSB0aGVyZSBmb3IgdGhpcy4NCj4gPiA+IA0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDY4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oIHwgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiA+ID4gaW5kZXggMGJlYWFiOTMyZTdkLi5iOGFjN2JjZWUzOTEgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gPiA+IEBAIC0xNzY3LDYgKzE3NjcsNTkgQEAgc3RhdGljIGludCBkd2MzX2dl
dF9jbG9ja3Moc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+ICAgCXJldHVybiAwOw0KPiA+ID4gICB9
DQo+ID4gPiArc3RhdGljIGludCBkd2MzX3JlYWRfcG9ydF9pbmZvKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ID4gPiArew0KPiA+ID4gKwl2b2lkIF9faW9tZW0JCSpyZWdzOw0KPiA+ID4gKwl1MzIJCQlv
ZmZzZXQ7DQo+ID4gPiArCXUzMgkJCXRlbXA7DQo+ID4gPiArCXU4CQkJbWFqb3JfcmV2aXNpb247
DQo+ID4gPiArCWludAkJCXJldCA9IDA7DQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4gPiArCSAq
IFJlbWFwIHhIQ0kgYWRkcmVzcyBzcGFjZSB0byBhY2Nlc3MgWEhDSSBleHQgY2FwIHJlZ3MsDQo+
ID4gPiArCSAqIHNpbmNlIGl0IGlzIG5lZWRlZCB0byBnZXQgcG9ydCBpbmZvLg0KPiA+ID4gKwkg
Ki8NCj4gPiA+ICsJcmVncyA9IGlvcmVtYXAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5zdGFydCwN
Cj4gPiA+ICsJCQkJcmVzb3VyY2Vfc2l6ZSgmZHdjLT54aGNpX3Jlc291cmNlc1swXSkpOw0KPiA+
ID4gKwlpZiAoSVNfRVJSKHJlZ3MpKQ0KPiA+ID4gKwkJcmV0dXJuIFBUUl9FUlIocmVncyk7DQo+
ID4gPiArDQo+ID4gPiArCW9mZnNldCA9IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcChyZWdz
LCAwLA0KPiA+ID4gKwkJCQkJWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCk7DQo+ID4gPiArCXdoaWxl
IChvZmZzZXQpIHsNCj4gPiA+ICsJCXRlbXAgPSByZWFkbChyZWdzICsgb2Zmc2V0KTsNCj4gPiA+
ICsJCW1ham9yX3JldmlzaW9uID0gWEhDSV9FWFRfUE9SVF9NQUpPUih0ZW1wKTsNCj4gPiA+ICsN
Cj4gPiA+ICsJCXRlbXAgPSByZWFkbChyZWdzICsgb2Zmc2V0ICsgMHgwOCk7DQo+ID4gPiArCQlp
ZiAobWFqb3JfcmV2aXNpb24gPT0gMHgwMykgew0KPiA+ID4gKwkJCWR3Yy0+bnVtX3VzYjNfcG9y
dHMgKz0gWEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gPiA+ICsJCX0gZWxzZSBpZiAobWFq
b3JfcmV2aXNpb24gPD0gMHgwMikgew0KPiA+ID4gKwkJCWR3Yy0+bnVtX3VzYjJfcG9ydHMgKz0g
WEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gPiA+ICsJCX0gZWxzZSB7DQo+ID4gPiArCQkJ
ZGV2X2Vycihkd2MtPmRldiwgInBvcnQgcmV2aXNpb24gc2VlbXMgd3JvbmdcbiIpOw0KPiA+IA0K
PiA+IENhbiB3ZSBwcmludCB0aGlzIGluc3RlYWQ6DQo+ID4gCWRldl9lcnIoZHdjLT5kZXYsICJV
bnJlY29nbml6ZWQgcG9ydCBtYWpvciByZXZpc2lvbiAlZFxuIiwgbWFqb3JfcmV2aXNpb24pOw0K
PiA+IA0KPiA+ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4gPiArCQkJZ290byB1bm1hcF9yZWc7
DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+ID4gPiArCQlvZmZzZXQgPSBkd2MzX3hoY2lfZmluZF9u
ZXh0X2V4dF9jYXAocmVncywgb2Zmc2V0LA0KPiA+ID4gKwkJCQkJCVhIQ0lfRVhUX0NBUFNfUFJP
VE9DT0wpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXRlbXAgPSByZWFkbChyZWdzICsg
RFdDM19YSENJX0hDU1BBUkFNUzEpOw0KPiA+ID4gKwlpZiAoSENTX01BWF9QT1JUUyh0ZW1wKSAh
PSAoZHdjLT5udW1fdXNiM19wb3J0cyArIGR3Yy0+bnVtX3VzYjJfcG9ydHMpKSB7DQo+ID4gPiAr
CQlkZXZfZXJyKGR3Yy0+ZGV2LCAiaW5jb25zaXN0ZW5jeSBpbiBwb3J0IGluZm9cbiIpOw0KPiA+
IA0KPiA+IENhbiB3ZSBwcmludCB0aGlzIGluc3RlYWQ6DQo+ID4gCWRldl9lcnIoZHdjLT5kZXYs
ICJNaXNtYXRjaGVkIHJlcG9ydGVkIE1BWFBPUlRTICglZClcbiIsIEhDU19NQVhfUE9SVFModGVt
cCkpOw0KPiA+IA0KPiA+ID4gKwkJcmV0ID0gLUVJTlZBTDsNCj4gPiA+ICsJCWdvdG8gdW5tYXBf
cmVnOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCWRldl9kYmcoZHdjLT5kZXYsDQo+ID4g
PiArCQkiaHMtcG9ydHM6ICVkIHNzLXBvcnRzOiAlZFxuIiwgZHdjLT5udW1fdXNiMl9wb3J0cywg
ZHdjLT5udW1fdXNiM19wb3J0cyk7DQo+ID4gPiArDQo+ID4gPiArdW5tYXBfcmVnOg0KPiA+ID4g
Kwlpb3VubWFwKHJlZ3MpOw0KPiA+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ID4gK30NCj4gPiA+ICsN
Cj4gPiA+ICAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ID4gPiAgIHsNCj4gPiA+ICAgCXN0cnVjdCBkZXZpY2UJCSpkZXYgPSAmcGRldi0+ZGV2
Ow0KPiA+ID4gQEAgLTE3NzQsNiArMTgyNyw3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gICAJdm9pZCBfX2lvbWVtCQkqcmVnczsN
Cj4gPiA+ICAgCXN0cnVjdCBkd2MzCQkqZHdjOw0KPiA+ID4gICAJaW50CQkJcmV0Ow0KPiA+ID4g
Kwl1bnNpZ25lZCBpbnQJCWh3X21vZGU7DQo+ID4gPiAgIAlkd2MgPSBkZXZtX2t6YWxsb2MoZGV2
LCBzaXplb2YoKmR3YyksIEdGUF9LRVJORUwpOw0KPiA+ID4gICAJaWYgKCFkd2MpDQo+ID4gPiBA
QCAtMTg0Myw2ICsxODk3LDIwIEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gICAJCQlnb3RvIGVycl9kaXNhYmxlX2Nsa3M7DQo+ID4g
PiAgIAl9DQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIEN1cnJlbnRseSBEV0MzIGNvbnRyb2xsZXJz
IHRoYXQgYXJlIGhvc3Qtb25seSBjYXBhYmxlDQo+ID4gPiArCSAqIHN1cHBvcnQgTXVsdGlwb3J0
DQo+ID4gPiArCSAqLw0KPiA+ID4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdj
LT5od3BhcmFtcy5od3BhcmFtczApOw0KPiA+ID4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BB
UkFNUzBfTU9ERV9IT1NUKSB7DQo+ID4gPiArCQlyZXQgPSBkd2MzX3JlYWRfcG9ydF9pbmZvKGR3
Yyk7DQo+ID4gPiArCQlpZiAocmV0KQ0KPiA+ID4gKwkJCWdvdG8gZXJyX2Rpc2FibGVfY2xrczsN
Cj4gPiA+ICsJfSBlbHNlIHsNCj4gPiA+ICsJCWR3Yy0+bnVtX3VzYjJfcG9ydHMgPSAxOw0KPiA+
ID4gKwkJZHdjLT5udW1fdXNiM19wb3J0cyA9IDE7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+
ICAgCXNwaW5fbG9ja19pbml0KCZkd2MtPmxvY2spOw0KPiA+ID4gICAJbXV0ZXhfaW5pdCgmZHdj
LT5tdXRleCk7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4gaW5kZXggZDU2NDU3YzAyOTk2Li4yMTMxMjcw
M2UwNTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+IEBAIC0zNSw2ICszNSwxNyBAQA0K
PiA+ID4gICAjZGVmaW5lIERXQzNfTVNHX01BWAk1MDANCj4gPiA+ICsvKiBEZWZpbmUgWEhDSSBF
eHRjYXAgcmVnaXN0ZXIgb2Zmc2V0cyBmb3IgZ2V0dGluZyBtdWx0aXBvcnQgaW5mbyAqLw0KPiA+
ID4gKyNkZWZpbmUgWEhDSV9IQ0NfUEFSQU1TX09GRlNFVAkweDEwDQo+ID4gPiArI2RlZmluZSBE
V0MzX1hIQ0lfSENTUEFSQU1TMQkweDA0DQo+ID4gPiArI2RlZmluZSBYSENJX0VYVF9DQVBTX1BS
T1RPQ09MCTINCj4gPiA+ICsjZGVmaW5lIFhIQ0lfSENDX0VYVF9DQVBTKHgpICAgICgoKHgpID4+
IDE2KSAmIDB4ZmZmZikNCj4gPiA+ICsjZGVmaW5lIFhIQ0lfRVhUX0NBUFNfSUQoeCkgICAgICgo
KHgpID4+IDApICYgMHhmZikNCj4gPiA+ICsjZGVmaW5lIFhIQ0lfRVhUX0NBUFNfTkVYVCh4KSAg
ICgoKHgpID4+IDgpICYgMHhmZikNCj4gPiA+ICsjZGVmaW5lIFhIQ0lfRVhUX1BPUlRfTUFKT1Io
eCkgICgoKHgpID4+IDI0KSAmIDB4ZmYpDQo+ID4gPiArI2RlZmluZSBYSENJX0VYVF9QT1JUX0NP
VU5UKHgpICAoKCh4KSA+PiA4KSAmIDB4ZmYpDQo+ID4gPiArI2RlZmluZSBIQ1NfTUFYX1BPUlRT
KHgpICAgICAgICAoKCh4KSA+PiAyNCkgJiAweDdmKQ0KPiA+ID4gKw0KPiA+ID4gICAvKiBHbG9i
YWwgY29uc3RhbnRzICovDQo+ID4gPiAgICNkZWZpbmUgRFdDM19QVUxMX1VQX1RJTUVPVVQJNTAw
CS8qIG1zICovDQo+ID4gPiAgICNkZWZpbmUgRFdDM19CT1VOQ0VfU0laRQkxMDI0CS8qIHNpemUg
b2YgYSBzdXBlcnNwZWVkIGJ1bGsgKi8NCj4gPiA+IEBAIC0xMDI1LDYgKzEwMzYsOCBAQCBzdHJ1
Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gPiA+ICAgICogQHVzYl9wc3k6IHBvaW50ZXIg
dG8gcG93ZXIgc3VwcGx5IGludGVyZmFjZS4NCj4gPiA+ICAgICogQHVzYjJfcGh5OiBwb2ludGVy
IHRvIFVTQjIgUEhZDQo+ID4gPiAgICAqIEB1c2IzX3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0K
PiA+ID4gKyAqIEBudW1fdXNiMl9wb3J0czogbnVtYmVyIG9mIHVzYjIgcG9ydHMuDQo+ID4gPiAr
ICogQG51bV91c2IzX3BvcnRzOiBudW1iZXIgb2YgdXNiMyBwb3J0cy4NCj4gPiA+ICAgICogQHVz
YjJfZ2VuZXJpY19waHk6IHBvaW50ZXIgdG8gVVNCMiBQSFkNCj4gPiA+ICAgICogQHVzYjNfZ2Vu
ZXJpY19waHk6IHBvaW50ZXIgdG8gVVNCMyBQSFkNCj4gPiA+ICAgICogQHBoeXNfcmVhZHk6IGZs
YWcgdG8gaW5kaWNhdGUgdGhhdCBQSFlzIGFyZSByZWFkeQ0KPiA+ID4gQEAgLTExNjIsNiArMTE3
NSw5IEBAIHN0cnVjdCBkd2MzIHsNCj4gPiA+ICAgCXN0cnVjdCB1c2JfcGh5CQkqdXNiMl9waHk7
DQo+ID4gPiAgIAlzdHJ1Y3QgdXNiX3BoeQkJKnVzYjNfcGh5Ow0KPiA+ID4gKwl1MzIJCQludW1f
dXNiMl9wb3J0czsNCj4gPiA+ICsJdTMyCQkJbnVtX3VzYjNfcG9ydHM7DQo+ID4gDQo+ID4gY2Fu
IHdlIHVzZSB1OD8NCj4gPiANCj4gPiA+ICsNCj4gPiA+ICAgCXN0cnVjdCBwaHkJCSp1c2IyX2dl
bmVyaWNfcGh5Ow0KPiA+ID4gICAJc3RydWN0IHBoeQkJKnVzYjNfZ2VuZXJpY19waHk7DQo+ID4g
PiBAQCAtMTY1MCw0ICsxNjY2LDQ2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX3VscGlfZXhp
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gICB7IH0NCj4gPiA+ICAgI2VuZGlmDQo+ID4gPiAr
LyoqDQo+ID4gPiArICogZHdjM194aGNpX2ZpbmRfbmV4dF9leHRfY2FwIC0gRmluZCB0aGUgb2Zm
c2V0IG9mIHRoZSBleHRlbmRlZCBjYXBhYmlsaXRpZXMNCj4gPiA+ICsgKgkJCQkJd2l0aCBjYXBh
YmlsaXR5IElEIGlkLg0KPiA+ID4gKyAqDQo+ID4gPiArICogQGJhc2UJUENJIE1NSU8gcmVnaXN0
ZXJzIGJhc2UgYWRkcmVzcy4NCj4gPiA+ICsgKiBAc3RhcnQJYWRkcmVzcyBhdCB3aGljaCB0byBz
dGFydCBsb29raW5nLCAoMCBvciBIQ0NfUEFSQU1TIHRvIHN0YXJ0IGF0DQo+ID4gPiArICoJCWJl
Z2lubmluZyBvZiBsaXN0KQ0KPiA+ID4gKyAqIEBpZAkJRXh0ZW5kZWQgY2FwYWJpbGl0eSBJRCB0
byBzZWFyY2ggZm9yLCBvciAwIGZvciB0aGUgbmV4dA0KPiA+ID4gKyAqCQljYXBhYmlsaXR5DQo+
ID4gDQo+ID4gSSBrbm93IHRoYXQgdGhpcyBpcyBhIGR1cGxpY2F0ZSBmcm9tIHRoZSB4aGNpIGRy
aXZlciwgYnV0IGNhbiB3ZSBmaXggdGhlDQo+ID4ga2VybmVsZG9jIHN0eWxlIGFzIGluIG90aGVy
IHBsYWNlcyBpZiB3ZSdyZSBnb2luZyB0byBrZWVwIGl0Pw0KPiA+IA0KPiANCj4gSGkgVGhpbmgs
DQo+IA0KPiAgSXNuJ3QgdGhpcyBzYW1lIGFzIG90aGVyIGZ1bmN0aW9ucyA/DQo+IA0KPiAvKioN
Cj4gICogPGZ1bmN0aW9uIG5hbWU+IC0gZGVzY3JpcHRpb24NCj4gICogQHBhcmFtcw0KPiAgKg0K
PiAgKi8NCj4gDQo+IEkgbWlzc2VkIHRoZSBmdW5jdGlvbiBuYW1lIGluIGNvbW1lbnRzIGxhc3Qg
dGltZSwgYnV0IGFkZGVkIGl0IGluIHRoaXMNCj4gdmVyc2lvbi4NCj4gDQo+IENoZWNrcGF0Y2gg
dG9vIGRpZG4ndCBnaXZlIGFueSBlcnJvcnMvd2FybmluZ3Mgb3RoZXIgdGhhbiBhbGlnbm1lbnQu
IENhbiB5b3UNCj4gaGVscCBwb2ludCBvdXQgYW55IG90aGVyIG1pc3Rha2UgaW4gdGhpcyBmdW5j
dGlvbiBkb2MvY29tbWVudHMgc28gdGhhdCBJIGNhbg0KPiBmaXggaXQgaW4gbmV4dCB2ZXJzaW9u
Lg0KPiANCg0KSXQncyBtaXNzaW5nICI6IiBhZnRlciBAcGFyYW1zLg0KDQpZb3UgY2FuIHVzZSB0
aGUga2VybmVsLWRvYyBzY3JpcHQgdG8gY2hlY2sgZm9yIGRvY3VtZW50YXRpb24ncw0KZXJyb3Jz
L3dhcm5pbmdzLg0KDQpIZXJlJ3MgdGhlIG91dHB1dCBpZiB5b3UgcnVuIHRoZSBmb2xsb3dpbmcg
Y29tbWFuZDoNCiMgPEtFUk5FTF9TUkM+L3NjcmlwdHMva2VybmVsLWRvYyAtbm9uZSAtV2Vycm9y
IC1mdW5jdGlvbiBkd2MzX3hoY2lfZmluZF9uZXh0X2V4dF9jYXAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCg0KZHJpdmVycy91c2IvZHdjMy9jb3JlLmg6MTY4NDogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnYmFzZScgbm90IGRlc2NyaWJlZCBpbiAnZHdjM194aGNpX2Zp
bmRfbmV4dF9leHRfY2FwJw0KZHJpdmVycy91c2IvZHdjMy9jb3JlLmg6MTY4NDogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc3RhcnQnIG5vdCBkZXNjcmliZWQgaW4gJ2R3
YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcCcNCmRyaXZlcnMvdXNiL2R3YzMvY29yZS5oOjE2ODQ6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2lkJyBub3QgZGVzY3JpYmVk
IGluICdkd2MzX3hoY2lfZmluZF9uZXh0X2V4dF9jYXAnDQozIHdhcm5pbmdzIGFzIEVycm9ycw0K
DQoNClRoaXMgaXMgYSBtaW5vciBzdHlsZSBpc3N1ZS4gV2hpbGUgSSBkb24ndCB0aGluayBpdCdz
IHN0cmljdGx5IG5lZWRlZCB0bw0KZm9sbG93IHRoZSBrZXJuZWxkb2Mgc3R5bGUgZm9yIGEgbm9u
LWFwaSBmdW5jdGlvbi4gQnV0IGlmIHdlIGRvIGZvbGxvdw0KaXQsIHdlIHNob3VsZCBkbyBpdCBj
b3JyZWN0bHkuDQoNClRoYW5rcywNClRoaW5o

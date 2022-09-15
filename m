Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197495B9283
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIOCG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIOCGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:06:55 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C089F8E9A4;
        Wed, 14 Sep 2022 19:06:53 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKJJBg014070;
        Wed, 14 Sep 2022 19:06:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=bSk5Qpie5PNHAbF+k5kCzMHGiwfJsyNVKe6AZMr03/I=;
 b=rt5jzk8aXKzHOMj7WdSIqpCXYPgRJggpMZ3ZvxEsW+vNY7KmApGOxE5qIHs3oa9D1T6T
 /jq3XAeVBCKvxYssAbpWg+khbuQCmHNdWAcRnA08bvO8KWP3ZyMUow6mMAMkIKbSgxq0
 0PfTjvp4eZKw9P4l3dhjVBqBHq24GIF+bF4zC0ztk0LmOxqdGf7tnRmRugHqnHBbsbpZ
 76x8Wk8pTlwph3TEWg9aNDj/aYMKvdgKMCxDRpozlCksKCjuDZsM4gW3pReoMOWYgVeN
 zUbEwI0GGOefNF/CFscJkemAUrzVac62mYDwJk8u5nPg9HtwWxbrfK7mxeKNLSMnW4pm aA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3jjxy68ngm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 19:06:38 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 481A840502;
        Thu, 15 Sep 2022 02:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1663207597; bh=bSk5Qpie5PNHAbF+k5kCzMHGiwfJsyNVKe6AZMr03/I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EHPlccX35XwPV3MW1Z1VKsyFuAFHzZMEmdntWg7UTnOKVL92AWqo1UZlWh0XGZgs+
         hBGc4Y8YWvMchDw+VxYHB3UkMaulYzPx0iZ8n3eIWWPlHL6KxoNao6+BpExjNFGdzr
         Kv2RwjI/U+FB0ZGewWjjSffTpIXHlqNdlyPIQimTMAWoqPrmOYqWEBLRgH+ADaFhwO
         Z0aYd/kh40TPWUjmEN/TYiFThNLaZbKlNusESAyskizBCQi+LXVm1CwoI7EaJf+le1
         gtYn9ItWam6Um8/brjqgphjDbW8Y2J7Q4VSjLNJnS89YlFum2/Gz22OlxmKyXCPDoX
         40xuyX40wIQsQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 98AA9A0085;
        Thu, 15 Sep 2022 02:06:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C1659400AD;
        Thu, 15 Sep 2022 02:06:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vJt2vn0w";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBsYUZitREMZGtk0oyBwVxzcBpQ44xmOJrmWfASD6hLTnJ1cZAuZ8KoZrnhNvRNpTY29rDibkHNLT+4rBSpbrL4yoDkDI5+0D8mRew4gwqpxgoc9fQpPGlVJEPDkSaiI9/SR9VnNi7K+4rVGgAPxYAzgWBqcZ05n48SSrSuGP5Wy+P1fMLKQrmTRJDhCNCynWKQ1STc9JTL3xBfcDIU2B7v0FwV6bsASwQGlkyBZmVDdTfLT/hRCufXsvV2SRpe+2HlIUGCSrDGF3QWE1KNV/Tu/uCDMe/KAC/5uUdbFB88Tvti9BT15LfswbQl3TDSZXS+uPB7jD9ZutVUrGT/P9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSk5Qpie5PNHAbF+k5kCzMHGiwfJsyNVKe6AZMr03/I=;
 b=JMi/JqbK4T6u2PbxdSIoGj7M+K1rW1GdcJbiYyn+PaMoQhyCGlajWT9+vUJB2tiaRHC1ri6/vCbMll3uNXHsyDUMp5W2kXfcWKHvmrbECl+yFHCMMVF1TSNUdquzqAPATO3RkKQ6X8BIX2tvbu6jdafGtBz7MtLP9Ui0ZIGkEMTKHBxM5EOXmNirWelOlVXhkRjIeFPnqG6EfB3vni+HOFlM32fPFcsZ5uST1y4pKgLHHRVt1BpplNQugG9jan740b5Cx3s4n9n9UhH5E6TfOG9nIGW1nBDcKwddG0lTjigX3j2sL2fzfVwqkgv3H1yt1up46zbEJLnLch8JhpUVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSk5Qpie5PNHAbF+k5kCzMHGiwfJsyNVKe6AZMr03/I=;
 b=vJt2vn0wEBbWaL+9d7hHXRn7zzmh81/l1wiAWGwCwuXHCZ2F5/arktlbmjNlEClH1IEUufWtusYqTxro+LWtgwjo/uB/FV3gzpzLWzOzgpDj5EMRswolFHkAwSn09rqjF0s3VsNCJUSJUUh3asfeeo5hnXwX+7zYP413p3Mry4Q=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 15 Sep
 2022 02:06:33 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::69ee:633:f068:3ca1%3]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 02:06:33 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH 2/5] usb: gadget: Add function wakeup support
Thread-Index: AQHYpqSxYg+mSBtinkWEjfftWY3s8a2cSDKAgAMApwCAAD6nAIAHe4yAgABbB4CAAtc4AIAAXAqAgAAFJ4CAAXhZgIAF+LQAgABBaYCAAsdLAIAGuhMAgAFhiYCAA12tgIAdg7AAgAH06QA=
Date:   Thu, 15 Sep 2022 02:06:32 +0000
Message-ID: <20220915020602.tsdrw6cbmpqsypuf@synopsys.com>
References: <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
 <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
 <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
 <20220823010056.5yvd6223awab47vl@synopsys.com>
 <281aae0d-6146-bf65-cf23-2ddf7e16ae1c@quicinc.com>
 <20220826013021.xrvhi3xrgyz2dkin@synopsys.com>
 <3edfc616-1b6f-98f3-79f8-be208ae9a738@quicinc.com>
In-Reply-To: <3edfc616-1b6f-98f3-79f8-be208ae9a738@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SN7PR12MB6958:EE_
x-ms-office365-filtering-correlation-id: d82728f2-1031-48fb-605d-08da96bee97b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U85yTjbemmeEXyDwdUv5PXmpo79641Y0vxzJBEjXyG7WuDJqd+CIZL7FJ/fYwgolUzWHwuwR7f3tlJchmxSdOm+ZU0FHz4nRWbQm/Opqavx8fxV+T2vVQkQeQmLzGvPnZlLUWnGjzEpMJ/j3c2E4OvBa5s0g2tthyWvAeKhRuSYXCmcgwx/W6HRl4bqVU6ZqdHrMlr4o8Dsi/19r75pVUjISZyDbFH/R1N+elPhHixSfFtd84eT9TVBztvkfzbyerinkbACWxu3LKOvnafGiHlQVJXRmCnWho95lkm84DxxhAn1in/qQcaGzyZYD3nSuLwhjDAc2zvZlC3vxkcCb4WAZuUgYEc7Z0TcJgD3XOu58r0dnxx+aVvHG/L/iJvm7uzqZJ1FoeM7spWnLqMT80XRMUDKafEjy2BAuynzuVye50gbsrzvyCBtCXWxYCENxNqAbq9o9JcWZjb/ceUsH7Ry1N1yEt7UM0q0dj3/KuYaiN2gvqLe412yZ/9cP/VReI5QvMrCaDZ1pucf1b43R4V0MKdBBHle3yDvhqSIac2IQwioO/W5YputBZySs5/kNomC0QBdSInYS0Q6ZNFBVKF5Lq/hTh3SKa6X0Blf9LMu2Lq+xXbUUEYmd11Wb9H+vEoi79VZ9QeFh+Qdw4X5SmXCd2KZbaXtbdOnfdp0wcS2xzxNPL/h6qTZH/WCtkt7krHFCP4ppx4tEWJxNbKSQuoSzhhvytDlU4QHjBXOOyrDzMfB1e5jRDBFqsNIqPKWPCoxCIzv8szMIMvCAxWusCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(86362001)(4326008)(66446008)(66946007)(66556008)(83380400001)(8676002)(76116006)(64756008)(1076003)(66476007)(8936002)(5660300002)(38070700005)(2616005)(41300700001)(316002)(122000001)(54906003)(38100700002)(36756003)(53546011)(6506007)(26005)(6512007)(6486002)(2906002)(71200400001)(478600001)(6916009)(186003)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHcvNjFiU2xMMFlFS00wK2ticnhGbFNVWm91cDdqOEdjZnZTUW5BV0ZNRytI?=
 =?utf-8?B?bkFYamMrYnRLOVJvVlIyYitBUGpESkdrbWx4MHhHY0hOR1RZdGJsWGhpeTlk?=
 =?utf-8?B?Y0c2RE5nWExwVjlhZk91WnZQM3ArN1BDT2JZbGFEVGhkV0pMdWVXR05vWm1W?=
 =?utf-8?B?bzhaQ1cwazgxNHJweFV2bEl5S2RSNVZkcFkyTHc5VUxpdjBGcTdObi94MjFQ?=
 =?utf-8?B?VzkvcUw4dXJaaGFvelFoZlJoUGxMRHBtYlAzSmFYelBDMnFZa21NNTB6SU8z?=
 =?utf-8?B?ZDJPQU8yY1VOZVk5aFNBbnBsdFZJaFBUbCtPbEdEK2RGcWlhTWdyZUxyUDdF?=
 =?utf-8?B?TlplWVUzK2lldFJpMzIvaWhHNFlqWXdEV1hYMCs4RTcwS2Y1a2o0dDNnakRv?=
 =?utf-8?B?Rkx6RjFIQSt2KzNiYjJPdzVLSGNuQzdubFZLbERjSzg2bFVFWndaMGRUdTJ0?=
 =?utf-8?B?SWRPYnR1SkI0NVA5TVJtbnBvT3ZFQ2ExY21LSTRZeUF3M2pWMEU2VHZ6eDdN?=
 =?utf-8?B?OVVRbTVna0JsOWRUY0FGUWhHTFJuTlVWeUVHVzhMRHFMajJCaHFVdUJhTE0y?=
 =?utf-8?B?dVpudzVLcHQzRUp2OUtEOUxxWDJ3N0VEdExka1FOZ2I3d2ovdnMwc1EvcG9u?=
 =?utf-8?B?R1BVQUR5NWJLdUI5YTBha3Vpay8zWWZUVzQ5QmViMzM5N2MyNmVTL3NJOVlE?=
 =?utf-8?B?Ly9ORUcwNjFKK29zbTBQUVFGRXpRY2RlaTg5MVB4djFuKzl4UXE1amR0dW1i?=
 =?utf-8?B?QkxoZ3VtOGxOa0Jwck9xTE9jODR5VVZNUFNhS283WW01QlY0VkdQTVZ4eUpv?=
 =?utf-8?B?QytrZnNhOHg5Ym9za0tUMGZ6SU1pR1RCYWxlR29GMlhQOXpzMmhhL2NVNmdr?=
 =?utf-8?B?WlFnMG1VNXA0VW94a1J5cnZNNzRxRThBNEZxNFpDSmpFQWZYeS9hdGZlci80?=
 =?utf-8?B?R2ZWUFBmYmhFWWNEdUlOVWk1YnZnbDRBUWIwaDk4ZkFtTEFxZ2VQbHc1R0VS?=
 =?utf-8?B?U1hPdDNLOFBIQjl4UCtxRUZDREQwc0JrT3IxbFRnUVJCckZRQ2lvQkVEQVRF?=
 =?utf-8?B?cmRFcXVlSC9rTUQxREplQ3pZK3ErVlZHb0Q1ZE1ERGc5b28rVTI4VXJkM1Rm?=
 =?utf-8?B?Mi9wN3ozRUl0aDVLWnZMSmdWSk9WTTNWL1FoaFFQVmJVdlJ4QUw1dXRCUGZz?=
 =?utf-8?B?WU9UWWNnV1IyL0g1MTgzd3hrRFBnM1FLazAveDRIdlBPRnBBNjZLYXA3SUZp?=
 =?utf-8?B?TGViaVpCYU1lazk4cm5tdEpJb2tON1ZQV2luMFF6TXliZEVRMXNQRld3S1hj?=
 =?utf-8?B?OEZ1MnRrUFFEU0IvdHF5dWdLRDVXSnlNeTZUMFhIc1AyelRzT2dOam1QNVcv?=
 =?utf-8?B?L0MvMitGTmxXNDNLN2JCT21SUWxONW1zdEp4Q3Z4NmxEVkJmcTFpalMxejFL?=
 =?utf-8?B?YytIcitNMnpqS0dISnlTMjlWNU8veHBnYndqMC9RRE9tUG5sYUp5enBzck4z?=
 =?utf-8?B?czJUSXpBbnF3UjMrQXdtRmRqc0NWV2wwZDlnZm5RNWlJT3RUV1BGSWNIcTcy?=
 =?utf-8?B?RC9CY1I2dXlwem85VHhrWEJpK0t6WDRsdC9vVGJ0MFZ6dG1CZHdGZ0kvS3RM?=
 =?utf-8?B?dmZBVEJaYzVBQ3RnczFVTjY5RFdXQWdaQmI3emJEMlpvWTlmSE5LOFpiRTVJ?=
 =?utf-8?B?c3l1endTQ2JzRmJVUUFiUGZkVTUvRVExR1I3UnhzZFRqSVdiL2UvSkQ4QjIy?=
 =?utf-8?B?MEEvb0R0VTZNenFiU1VwR2ZzemNJb1RUNTYwOHJ2eC8wWkdzbmhRbTBUU1My?=
 =?utf-8?B?d0ZueVRtbFl3YnFEWGRaSytZUU5YazJzUXdXMjQrTjJpQVNVRlQyYm9abWlR?=
 =?utf-8?B?M1cxVFhpTWtRMGdiaGkyZUFNL25xR0FzWXhXMFYwRUYvOG5xNGJ4dnBGVjc5?=
 =?utf-8?B?T3Z4a3NQeC9KMVA5SERrM3V6bEZqcXQ1ZllTRmlseE1ycm9xTW95SlZja25i?=
 =?utf-8?B?V2llWmEyUkNDTUpkcy9RamxQRmZ2ZkhqVndHaXRXdFFKVjk0YW5USXBrdlhC?=
 =?utf-8?B?ZnRmcEdGMmRtYXBacDNReElRSTA1aERSRHM0d29IbnRMZCt1OHhvTVM5ZVV2?=
 =?utf-8?Q?yigLryxj3R8dXcNMCpC9hT4zW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D89BD514ECA5C42B5248F1A5D1F73D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82728f2-1031-48fb-605d-08da96bee97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 02:06:33.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl9zqbWd4j4L2HO4sQfDXrhZ1jLSBNy/UUkgqL0/PiP/k6YyDM3rkjJ6AOygUOBIe/RBavijeaP7UaUMC/AEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958
X-Proofpoint-GUID: Uxj5Vh4ry1oX11fTC7vv3kZivwzGwQpE
X-Proofpoint-ORIG-GUID: Uxj5Vh4ry1oX11fTC7vv3kZivwzGwQpE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_11,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2208220000 definitions=main-2209150009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTMsIDIwMjIsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4
LzI1LzIwMjIgNjozMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgQXVnIDIz
LCAyMDIyLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiBPbiA4LzIyLzIwMjIgNjowMSBQTSwg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIEF1ZyAxOCwgMjAyMiBhdCAxMTox
NzoyNEFNIC0wNzAwLCBFbHNvbiBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gT24gOC8xNi8yMDIyIDQ6NTEgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4g
PiA+ID4gPiA+IE9uIDgvMTYvMjAyMiwgRWxzb24gU2VycmFvIHdyb3RlOg0KPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IE9uIDgvMTIvMjAyMiA1OjQ2IFBNLCBU
aGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gT24gOC8xMS8yMDIyLCBUaGluaCBO
Z3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBPbiA4LzExLzIwMjIsIFRoaW5oIE5ndXll
biB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ID4gT24gOC8xMS8yMDIyLCBFbHNvbiBTZXJyYW8g
d3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gT24gOC85LzIwMjIgNjowOCBQTSwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPHNuaXA+DQo+
ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IFRvIHN1bW1hcml6ZSB0aGUgcG9pbnRzOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAxKSBUaGUgaG9zdCBvbmx5IGFybXMgZnVuY3Rp
b24gcmVtb3RlIHdha2V1cCBpZiB0aGUgZGV2aWNlIGlzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBjYXBhYmxlIG9mDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiByZW1vdGUgd2FrZXVwIChjaGVj
ayBVU0JfQ09ORklHX0FUVF9XQUtFVVAgaW4gYm1BdHRyaWJ1dGVzIGFuZA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gaGFyZHdhcmUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGNhcGFiaWxpdHkp
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDIpIElm
IHRoZSBkZXZpY2UgaXMgaW4gc3VzcGVuZCwgdGhlIGRldmljZSBjYW4gZG8gcmVtb3RlIHdha2V1
cA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKHRocm91Z2gNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IExGUFMgaGFuZHNoYWtlKSBpZiB0aGUgZnVuY3Rpb24gaXMgYXJtZWQgZm9yIHJlbW90ZSB3
YWtldXAgKHRocm91Z2gNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNFVF9GRUFUVVJFKEZVTkNf
U1VTUEVORCkpLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiAzKSBJZiB0aGUgbGluayB0cmFuc2l0aW9ucyB0byBVMCBhZnRlciB0aGUgZGV2aWNlIHRy
aWdnZXJpbmcgYSByZW1vdGUNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHdha2V1cCwgdGhlIGRl
dmljZSB3aWxsIGFsc28gc2VuZCBkZXZpY2Ugbm90aWZpY2F0aW9uIGZ1bmN0aW9uDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiB3YWtlIGZvcg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYWxsIHRo
ZSBpbnRlcmZhY2VzIGFybWVkIHdpdGggcmVtb3RlIHdha2V1cC4NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gNCkgSWYgdGhlIGRldmljZSBpcyBub3Qg
aW4gc3VzcGVuZCwgdGhlIGRldmljZSBjYW4gc2VuZCBkZXZpY2UNCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IG5vdGlmaWNhdGlvbiBmdW5jdGlvbiB3YWtlIGlmIGl0J3MgaW4gVTAuDQo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gTm93LCByZW1vdGUgd2FrZXVwIGFuZCBmdW5jdGlvbiB3YWtlIGRldmljZSBu
b3RpZmljYXRpb24gYXJlIDINCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNlcGFyYXRlDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBvcGVyYXRpb25zLiBXZSBoYXZlIHRoZSB1c2JfZ2FkZ2V0X29w
cy0+d2FrZXVwKCkgZm9yIHJlbW90ZSB3YWtldXAuIEkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IHN1Z2dlc3RlZCB0byBtYXliZSBhZGQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHVzYl9nYWRn
ZXRfb3BzLT5zZW5kX3dha2V1cF9ub3RpZmljYXRpb24oZ2FkZ2V0LA0KPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gaW50Zl9pZCkgZm9yIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9uLiBXaGF0IHlvdSBk
aWQgd2FzIGNvbWJpbmluZyBib3RoDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBvcGVyYXRpb25z
IGluIHVzYl9nYWRnZXRfb3BzLT5mdW5jX3dha2V1cCgpLiBUaGF0IG1heSBvbmx5IHdvcmsgZm9y
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBwb2ludCA0KSAoYXNzdW1pbmcgeW91IGZpeCB0aGUg
VTAgY2hlY2spLCBidXQgbm90IHBvaW50IDMpLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayBhbmQgc3VtbWFy
eS4gSSB3aWxsIHJlbmFtZSBmdW5jX3dha2V1cCB0bw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNl
bmRfd2FrZXVwX25vdGlmaWNhdGlvbiB0byBiZXR0ZXIgYWxpZ24gd2l0aCB0aGUgYXBwcm9hY2gu
IFRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHJlYXNvbiBJDQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gaGF2ZSBjb21iaW5lZCByZW1vdGVfd2FrZXVwIGFuZCBmdW5jdGlvbiB3YWtlIG5vdGlmaWNh
dGlvbiBpbg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHVzYl9nYWRnZXRfb3BzLT5mdW5jX3dha2V1
cCgpIGlzIGJlY2F1c2Ugc2luY2UgdGhlIGltcGxlbWVudGF0aW9uDQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gaXMgYXQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBmdW5jdGlvbi9jb21wb3NpdGUgbGV2
ZWwgaXQgaGFzIG5vIGtub3dsZWRnZSBvbiB0aGUgbGluayBzdGF0ZS4gU28gSQ0KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IGhhdmUgZGVsZWdhdGVkIHRoYXQgdGFzayB0byBjb250cm9sbGVyIGRyaXZl
ciB0byBoYW5kbGUgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbm90aWZpY2F0aW9uDQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gYWNjb3JkaW5nbHkuIFRoYXQgaXMgZG8gYSBMRlBTIGhhbmRzaGFr
ZSBmaXJzdCBpZiB0aGUgZGV2aWNlIGlzDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc3VzcGVuZGVk
IGFuZCB0aGVuIHNlbmQgbm90aWZpY2F0aW9uIChleHBsYWluZWQgYmVsb3cpLiBCdXQgd2UgY2Fu
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZGVmaW5pdGVseSBzZXBhcmF0ZSB0aGlzIGJ5IGFkZGlu
ZyBhbiBhZGRpdGlvbmFsIGZsYWcgaW4gdGhlIGNvbXBvc2l0ZQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IGxheWVyIHRvIHNldCB0aGUgbGluayBzdGF0ZSBiYXNlZCBvbiB0aGUgZ2FkZ2V0IHN1c3Bl
bmQgY2FsbGJhY2sNCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBjYWxsZWQNCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiB3aGVuIFUzIFNVU1BFTkQgaW50ZXJydXB0IGlzIHJlY2VpdmVkLiBMZXQgbWUga25v
dyBpZiB5b3UgZmVlbA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNlcGFyYXRpbmcgdGhlIHR3byBp
cyBhIGJldHRlciBhcHByb2FjaC4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSByZWFzb24gSSB0aGluayB3ZSBuZWVk
IHRvIHNlcGFyYXRlIGl0IGlzIGJlY2F1c2Ugb2YgcG9pbnQgMy4gQXMgSQ0KPiA+ID4gPiA+ID4g
PiA+ID4gPiBub3RlIGVhcmxpZXIsIHRoZSBzcGVjIHN0YXRlcyB0aGF0ICJJZiByZW1vdGUgd2Fr
ZSBldmVudCBvY2N1cnMgaW4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gbXVsdGlwbGUgZnVuY3Rpb25z
LCBlYWNoIGZ1bmN0aW9uIHNoYWxsIHNlbmQgYSBGdW5jdGlvbiBXYWtlDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IE5vdGlmaWNhdGlvbi4iDQo+ID4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+ID4gPiBCdXQgaWYgdGhlcmUncyBubyByZW1vdGUgd2FrZSBldmVudCwgYW5kIHRoZSBob3N0
IGJyb3VnaHQgdGhlIGRldmljZSB1cA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBpbnN0ZWFkLCB0aGVu
IHRoZSBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGlzIHJldGFpbmVkLg0KPiA+ID4gPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gSWYgd2Ugc2VwYXJhdGUgdGhlc2UgMiBvcGVyYXRp
b25zLCB0aGUgY2FsbGVyIGNhbiBjaGVjayB3aGV0aGVyIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4g
PiBvcGVyYXRpb24gd2VudCB0aHJvdWdoIHByb3Blcmx5LiBGb3IgZXhhbXBsZSwgaWYgdGhlIHdh
a2V1cCgpIGlzDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGluaXRpYXRlZCBwcm9wZXJseSwgYnV0IHRo
ZSBmdW5jdGlvbiB3YWtlIGRldmljZSBub3RpZmljYXRpb24gZGlkbid0IGdvDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IHRocm91Z2guIFdlIHdvdWxkIG9ubHkgbmVlZCB0byByZXNlbmQgdGhlIGRldmlj
ZSBub3RpZmljYXRpb24gcmF0aGVyDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoYW4gaW5pdGlhdGUg
cmVtb3RlIHdha2V1cCBhZ2Fpbi4NCj4gPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+
ID4gSWYgd2UgZG9uJ3QgaGF2ZSB0byBzZW5kIGRldmljZSBub3RpZmljYXRpb24gZm9yIG90aGVy
IGludGVyZmFjZXMsIHdlDQo+ID4gPiA+ID4gPiA+ID4gPiBjYW4gY29tYmluZSB0aGUgb3BlcmF0
aW9ucyBoZXJlIGFzIHlvdSBkaWQuDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiBJIHN0aWxsIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHNwbGl0IHVw
IHRoZSBvcGVyYXRpb25zLiBUaGUgd2F5IHlvdSdyZQ0KPiA+ID4gPiA+ID4gPiA+IGhhbmRsaW5n
IGl0IG5vdyBpcyBub3QgY2xlYXIuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4g
SWYgdGhlIGZ1bmNfYXdha2UoKSByZXR1cm5zIC1FQUdBSU4sIEknZCBleHBlY3QgdGhhdCB0aGUg
cmVtb3RlIHdha2UgZGlkDQo+ID4gPiA+ID4gPiA+ID4gbm90IGdvIHRocm91Z2ggYW5kIGV4cGVj
dCB1c2VyIHRvIHJldHJ5IGFnYWluLiBCdXQgaGVyZSBpdCBkb2VzIGluaXRpYXRlDQo+ID4gPiA+
ID4gPiA+ID4gcmVtb3RlIHdha2UsIGJ1dCBpdCBqdXN0IGRvZXMgbm90IHNlbmQgZGV2aWNlIG5v
dGlmaWNhdGlvbiB5ZXQuIFRoaXMgaXMNCj4gPiA+ID4gPiA+ID4gPiBjb25mdXNpbmcuDQo+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQWxzbywgaW5zdGVhZCBvZiBhbGwgdGhlIGZ1
bmN0aW9uIHdha2UgaGFuZGxpbmcgY29taW5nIGZyb20gdGhlIGZ1bmN0aW9uDQo+ID4gPiA+ID4g
PiA+ID4gZHJpdmVyLCBub3cgd2UgZGVwZW5kIG9uIHRoZSBjb250cm9sbGVyIGRyaXZlciB0byBj
YWxsIGZ1bmN0aW9uIHJlc3VtZSgpDQo+ID4gPiA+ID4gPiA+ID4gb24gc3RhdGUgY2hhbmdlIHRv
IFUwLCB3aGljaCB3aWxsIHRyaWdnZXIgZGV2aWNlIG5vdGlmaWNhdGlvbi4gV2hhdA0KPiA+ID4g
PiA+ID4gPiA+IGhhcHBlbiBpZiBpdCBkb2Vzbid0IGNhbGwgcmVzdW1lKCkuIFRoZXJlJ3MgdG9v
IG1hbnkgZGVwZW5kZW5jaWVzIGFuZCBpdA0KPiA+ID4gPiA+ID4gPiA+IHNlZW1zIGZyYWdpbGUu
DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSSB0aGluayBhbGwgdGhpcyBjYW4g
YmUgaGFuZGxlZCBpbiB0aGUgZnVuY3Rpb24gZHJpdmVyLiBZb3UgY2FuIGZpeCB0aGUNCj4gPiA+
ID4gPiA+ID4gPiBkd2MzIHdha2V1cCgpIGFuZCBwb2xsIGZvciBVMC9PTiBzdGF0ZSByYXRoZXIg
dGhhbiBSRUNPVkVSWSBzdGF0ZSwgd2hpY2gNCj4gPiA+ID4gPiA+ID4gPiBpcyB3aGF0IGl0J3Mg
c3VwcG9zZWQgdG8gcG9sbC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEZvciB0cmFu
c2l0aW9uaW5nIGZyb20gVTMgdG8gVTAsIHRoZSBjdXJyZW50IHVwc3RyZWFtIGltcGxlbWVudGF0
aW9uIGlzDQo+ID4gPiA+ID4gPiA+IHRvIHBvbGwgZm9yIFUwIHN0YXRlIHdoZW4gZHdjM19nYWRn
ZXRfd2FrZXVwKCkgaXMgY2FsbGVkIGFuZCBpdCBpcyBhDQo+ID4gPiA+ID4gPiA+IGJsb2NraW5n
IGNhbGwuICh0aGlzIGlzIGEgY29tbW9uIEFQSSBmb3IgYm90aCBIUyBhbmQgU1MpDQo+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAgICDCoMKgwqDCoC8qIHBvbGwgdW50aWwgTGluayBTdGF0
ZSBjaGFuZ2VzIHRvIE9OICovDQo+ID4gPiA+ID4gPiA+ICAgIMKgwqDCoMKgcmV0cmllcyA9IDIw
MDAwOw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gICAgwqDCoMKgwqB3aGlsZSAocmV0
cmllcy0tKSB7DQo+ID4gPiA+ID4gPiA+ICAgIMKgwqDCoMKgwqDCoMKgIHJlZyA9IGR3YzNfcmVh
ZGwoZHdjLT5yZWdzLCBEV0MzX0RTVFMpOw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
ICAgwqDCoMKgwqDCoMKgwqAgLyogaW4gSFMsIG1lYW5zIE9OICovDQo+ID4gPiA+ID4gPiA+ICAg
IMKgwqDCoMKgwqDCoMKgIGlmIChEV0MzX0RTVFNfVVNCTE5LU1QocmVnKSA9PSBEV0MzX0xJTktf
U1RBVEVfVTApDQo+ID4gPiA+ID4gPiA+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
DQo+ID4gPiA+ID4gPiA+ICAgIMKgwqDCoMKgfQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gSW4gbXkgZXhwZXJpbWVudHMgSSBmb3VuZCB0aGF0IGNlcnRhaW4gaG9zdHMgdGFrZSBsb25n
ZXIgdGltZSB0byBkcml2ZQ0KPiA+ID4gPiA+ID4gPiBIUyByZXN1bWUgc2lnbmFsbGluZyBiZXR3
ZWVuIHRoZSByZW1vdGUgd2FrZXVwIGFuZCB0aGUgcmVzdW1lIEsgYW5kIHRoaXMNCj4gPiA+ID4g
PiA+ID4gdGltZSB2YXJpZXMgYWNyb3NzIGhvc3RzLiBIZW5jZSB0aGUgYWJvdmUgcG9sbGluZyB0
aW1lciBpcyBub3QgZ2VuZXJpYw0KPiA+ID4gPiA+ID4gPiBhY3Jvc3MgaG9zdHMuIFNvIGhvdyBk
byB3ZSBjb252ZXJnZSBvbiBhIHBvbGxpbmcgdGltZXIgdmFsdWUgdG8gd29yaw0KPiA+ID4gPiA+
ID4gPiBhY3Jvc3MgSFMvU1MgYW5kIHdpdGhvdXQgYmxvY2tpbmcgdGhlIHN5c3RlbSBmb3IgYSBs
b25nIHRpbWU/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IENhbid0IHdlIHRha2UgdGhlIHVw
cGVyIGxpbWl0IG9mIGJvdGggYmFzZSBvbiBleHBlcmltZW50PyBBbmQgaXQNCj4gPiA+ID4gPiA+
IHNob3VsZG4ndCBiZSBibG9ja2luZyB0aGUgd2hvbGUgc3lzdGVtLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IE9uIHRoZSBob3N0IEkgd2FzIGV4cGVyaW1lbnRpbmcgd2l0aCwgdGhlIHRpbWUgaXQg
dG9vayB3YXMgYXJvdW5kIDExMG1zIGluDQo+ID4gPiA+ID4gSFMgY2FzZS4gVGhhdCB3b3VsZCB0
cmFuc2xhdGUgdG8gYSByZXRyeSBjb3VudCBvZiBhYm91dCB+MTgxLDAwMCBpbiB0aGUNCj4gPiA+
ID4gPiBhYm92ZSBwb2xsaW5nIGxvb3AuIFdvdWxkbid0IHRoYXQgYmUgYSB2ZXJ5IGxhcmdlIHZh
bHVlIGZvciBwb2xsaW5nPw0KPiA+ID4gPiA+IEFuZCBub3Qgc3VyZSBpZiB0aGVyZSBhcmUgb3Ro
ZXIgaG9zdHMgdGhhdCB0YWtlIGV2ZW4gbG9uZ2VyIHRpbWUNCj4gPiA+ID4gDQo+ID4gPiA+IFdl
IGRvbid0IHdhbnQgdG8gcG9sbCB0aGF0IG1hbnkgdGltZXMuIFdlIHNob3VsZG4ndCBkZXBlbmQg
b24gdGhlIGRlbGF5DQo+ID4gPiA+IG9mIGEgcmVnaXN0ZXIgcmVhZCBmb3IgcG9sbGluZyBpbnRl
cnZhbC4gQ2FuJ3Qgd2UganVzdCBzbGVlcCBpbiBiZXR3ZWVuDQo+ID4gPiA+IGludGVydmFsIGF0
IGEgcmVhc29uYWJsZSBpbnRlcnZhbC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFNsZWVwaW5n
IGlzIG5vdCBhbiBvcHRpb24gYXMgdGhlIHVwcGVyIGxheWVycyAodGhvc2UgYmV5b25kDQo+ID4g
PiBmdW5jdGlvbi9jb21wb3NpdGUgbGF5ZXIpIG1heSB0cmFuc21pdCBkYXRhIHdpdGggYSBsb2Nr
IGhlbGQuDQo+ID4gPiANCj4gPiANCj4gPiBZb3UgY2FuIHVzZSBtZGVsYXkoKSBpZiBpdCBjYW4n
dCBzbGVlcC4gQnV0IGlmIHRoZSB3YWl0IGlzIGxvbmcsIGl0DQo+ID4gc2hvdWxkIGJlIGFsbG93
ZWQgdG8gc2xlZXAuDQo+ID4gDQo+ID4gPiBJIHJhbiBpbnRvIGJlbG93IEJVRyB3aGVuIHJlbW90
ZSB3YWtldXAgd2FzIHRyaWdnZXJlZCB2aWEgYSBwaW5nKCkgY29tbWFuZA0KPiA+ID4gYW5kIGF0
dGVtcHRlZCBzbGVlcCB3aGlsZSBwb2xsaW5nDQo+ID4gPiANCj4gPiA+IFsgICA4OC42NzY3ODld
WyAgVDM5Ml0gQlVHOiBzY2hlZHVsaW5nIHdoaWxlIGF0b21pYw0KPiA+ID4gWyAgIDg4LjkwMDEx
Ml1bICBUMzkyXSBDYWxsIHRyYWNlOg0KPiA+ID4gPHNuaXA+DQo+ID4gPiBbICAgODguOTEyNzYw
XVsgIFQzOTJdICBfX3NjaGVkdWxlX2J1ZysweDkwLzB4MTg4DQo+ID4gPiBbICAgODguOTE3MzM1
XVsgIFQzOTJdICBfX3NjaGVkdWxlKzB4NzE0LzB4YjRjDQo+ID4gPiBbICAgODguOTMwNTY4XVsg
IFQzOTJdICBzY2hlZHVsZSsweDExMC8weDIwNA0KPiA+ID4gWyAgIDg4Ljk0MzYyMF1bICBUMzky
XSAgc2NoZWR1bGVfdGltZW91dCsweDk0LzB4MTM0DQo+ID4gPiBbICAgODguOTQ4MzcxXVsgIFQz
OTJdICBfX2R3YzNfZ2FkZ2V0X3dha2V1cCsweDFhYy8weDU1OA0KPiA+ID4gWyAgIDg4Ljk1MzU1
OF1bICBUMzkyXSAgZHdjM19nYWRnZXRfd2FrZXVwKzB4M2MvMHg4Yw0KPiA+ID4gWyAgIDg4Ljk1
ODM4OF1bICBUMzkyXSAgdXNiX2dhZGdldF93YWtldXArMHg1NC8weDFhOA0KPiA+ID4gWyAgIDg4
Ljk2MzIyMl1bICBUMzkyXSAgZXRoX3N0YXJ0X3htaXQrMHgxMzAvMHg4MzANCj4gPiA+IFsgICA4
OC45Njc4NzZdWyAgVDM5Ml0gIHhtaXRfb25lKzB4ZjAvMHgzNjQNCj4gPiA+IFsgICA4OC45NzE5
MTNdWyAgVDM5Ml0gIHNjaF9kaXJlY3RfeG1pdCsweDE4OC8weDNlNA0KPiA+ID4gWyAgIDg4Ljk3
NjY2M11bICBUMzkyXSAgX19kZXZfeG1pdF9za2IrMHg0ODAvMHg5ODQNCj4gPiA+IFsgICA4OC45
ODEzMTldWyAgVDM5Ml0gIF9fZGV2X3F1ZXVlX3htaXQrMHgyZDQvMHg3ZDgNCj4gPiA+IFsgICA4
OC45ODYxNTFdWyAgVDM5Ml0gIG5laWdoX3Jlc29sdmVfb3V0cHV0KzB4MjA4LzB4MmYwDQo+ID4g
PiA8c25pcD4NCj4gPiA+IA0KPiA+ID4gVGhlIGFib3ZlIGV4cGVyaW1lbnQgd2FzIGRvbmUgYnkg
cmVtb3Zpbmcgc3Bpbl9sb2NrcyBpZiBhbnkgaW4gdGhlIHdha2V1cCgpDQo+ID4gPiBwYXRoIG9m
ICBmdW5jdGlvbi9jb21wb3NpdGUvY29udHJvbGxlciBkcml2ZXJzLiBJdCBpcyBydW5uaW5nIGlu
IGF0b21pYw0KPiA+ID4gY29udGV4dCBkdWUgdG8gdGhlIGxvY2sgaGVsZCBieSBsaW51eCBuZXR3
b3JraW5nIHN0YWNrL2dlbmVyaWMgcGFja2V0DQo+ID4gPiBzY2hlZHVsZXIuDQo+ID4gPiANCj4g
PiA+IFNvIGJlbG93IGFyZSB0aGUgb25seSB0d28gYXBwcm9hY2hlcyBJIGNhbiB0aGluayBvZiBm
b3IgZHdjM19nYWRnZXRfd2FrZXVwKCkNCj4gPiA+IEFQSQ0KPiA+ID4gDQo+ID4gPiAxLilQb2xs
aW5nIGJhc2VkIGFwcHJvYWNoOiBXZSBwb2xsIHVudGlsIHRoZSBsaW5rIGNvbWVzIHVwLiBCdXQg
Y2Fubm90IHNsZWVwDQo+ID4gPiB3aGlsZSBwb2xsaW5nIGR1ZSB0byBhYm92ZSByZWFzb25zLg0K
PiA+ID4gDQo+ID4gPiAyLilJbnRlcnJ1cHQgYmFzZWQgYXBwcm9hY2ggKHRoZSBwYXRjaGVzIGJl
aW5nIGRpc2N1c3NlZCBjdXJyZW50bHkpOiBXaGVuIGENCj4gPiA+IHJlbW90ZSB3YWtldXAgaXMg
dHJpZ2dlcmVkIGVuYWJsZSBsaW5rIHN0YXRlIGludGVycnVwdHMgYW5kIHJldHVybiByaWdodA0K
PiA+ID4gYXdheS4gVGhlIGZ1bmN0aW9uL2NvbXBvc2l0ZSBkcml2ZXJzIGFyZSBsYXRlciBub3Rp
ZmllZCBhYm91dCB0aGUgT04gZXZlbnQNCj4gPiA+IHZpYSByZXN1bWUgY2FsbGJhY2sgKGluIGEg
c2ltaWxhciB3YXkgaG93IHdlIG5vdGlmeSBVMyB0byBjb21wb3NpdGUgbGF5ZXINCj4gPiA+IHZp
YSBzdXNwZW5kIGNhbGxiYWNrKS4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIGxldCBtZSBrbm93IGlm
IHRoZXJlIGlzIGFueSBhbHRlcm5hdGUgd2F5IHRoYXQgeW91IGNhbiB0aGluayBvZiBoZXJlLg0K
PiA+ID4gDQo+ID4gDQo+ID4gVGhlIG1haW4gaXNzdWUgd2UncmUgdHJ5aW5nIHRvIHNvbHZlIGlz
IGtub3dpbmcgaWYgdGhlIGhvc3QgaGFkIHdva2VuIHVwDQo+ID4gYW5kIHRoZSBkZXZpY2Ugbm90
aWZpY2F0aW9uIGlzIHNlbnQgc28gdGhhdCB0aGUgZnVuY3Rpb24gZHJpdmVyIGNhbg0KPiA+IHJl
c3VtZSgpLg0KPiA+IA0KPiA+IElmIHdlIGNhbiBzYXkgdGhhdCB1cG9uIHVzYl9nYWRnZXRfd2Fr
ZXVwKCkgc3VjY2Vzc2Z1bCBjb21wbGV0aW9uLCB0aGUNCj4gPiBsaW5rIGlzIGluIFUwL09OLCB0
aGVuIHRoZSBmdW5jdGlvbiBkcml2ZXIgY2FuIHNlbmQgdGhlIHdha2UNCj4gPiBub3RpZmljYXRp
b24gYWZ0ZXIgYW5kIHJlc3VtZSgpLiBUaGF0IGlzLCB3ZSdyZSB0cnlpbmcgdG8gbWFrZQ0KPiA+
IHVzYl9nYWRnZXRfd2FrZXVwKCkgc3luY2hyb25vdXMuIFdoZXRoZXIgaXQncyBwb2xsaW5nIG9y
IGludGVycnVwdA0KPiA+IGJhc2VkLCBpdCdzIGltcGxlbWVudGF0aW9uIGRldGFpbC4NCj4gPiAN
Cj4gPiBVbmZvcnR1bmF0ZWx5LCB0aGUgQVBJIGlzbid0IHZlcnkgY2xlYXIgd2hldGhlciB1c2Jf
Z2FkZ2V0X3dha2V1cCgpIG1heQ0KPiA+IHNsZWVwIG9yIHN5bmNocm9ub3VzLg0KPiA+IA0KPiA+
IEhlcmUgYXJlIDMgYXBwcm9hY2hlcyB0aGF0IHdlIGNhbiBoYXZlOg0KPiA+IA0KPiA+IDEpIENs
YXJpZnkgdGhhdCB1c2JfZ2FkZ2V0X3dha2V1cCgpIGlzIHN5bmNocm9ub3VzIGFuZCB0aGUgbGlu
ayB3aWxsIGJlDQo+ID4gaW4gVTAvT04gdXBvbiBzdWNjZXNzZnVsIGNvbXBsZXRpb24sIGFuZCBj
bGFyaWZ5IHdoZXRoZXIgaXQgY2FuIHNsZWVwLg0KPiA+IEludHJvZHVjZSBhIHNlcGFyYXRlIEFQ
SSB1c2JfZ2FkZ2V0X3NlbmRfd2FrZV9ub3RpZmljYXRpb24oKSB0byBzZW5kDQo+ID4gd2FrZSBu
b3RpZmljYXRpb24gc2VwYXJhdGVseS4NCj4gPiANCj4gPiAyKSBDcmVhdGUgYSBuZXcgQVBJIHVz
Yl9nYWRnZXRfZnVuY3Rpb25fd2FrZXVwKCkgdGhhdCB3aWxsIGNvbWJpbmUgYm90aA0KPiA+IGRl
dmljZSB3YWtldXAgYW5kIHdha2Ugbm90aWZpY2F0aW9uLiBUaGUgZnVuY3Rpb24gY2FuIHNsZWVw
LA0KPiA+IHN5bmNocm9ub3VzLCBhbmQgYm90aCB3YWtldXAgYW5kIHdha2Ugbm90aWZpY2F0aW9u
IGFyZSBkb25lIGFmdGVyIHRoZQ0KPiA+IGZ1bmN0aW9uIGNvbXBsZXRlcy4NCj4gPiANCj4gPiAz
KSBDcmVhdGUgYSBuZXcgQVBJIHVzYl9nYWRnZXRfZnVuY3Rpb25fd2FrZXVwKCkgdGhhdCB3aWxs
IGNvbWJpbmUgYm90aA0KPiA+IGRldmljZSB3YWtldXAgYW5kIHdha2Ugbm90aWZpY2F0aW9uLiBU
aGUgZnVuY3Rpb24gaXMgYXN5bmNocm9ub3VzLiBXZQ0KPiA+IHdvbid0IGtub3cgaWYgdGhlIHdh
a2V1cCBpcyBzdWNjZXNzZnVsbHkgc2VudCwgYnV0IHdlIGRvbid0IGNhcmUgYW5kDQo+ID4gcHJv
Y2VlZCB3aXRoIHRoZSBmdW5jdGlvbiBwcm9jZWVkIHdpdGggcmVzdW1lKCkgYW55d2F5Lg0KPiA+
IA0KPiA+IEJSLA0KPiA+IFRoaW5oDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlv
bnMuDQo+IEZvciBoYW5kbGluZyBmdW5jdGlvbiB3YWtldXAgKGFwcGxpY2FibGUgdG8gZW5oYW5j
ZWQgc3VwZXItc3BlZWQpIHdpbGwNCj4gaW1wbGVtZW50IGEgc2VwYXJhdGUgQVBJIHVzYl9nYWRn
ZXRfZnVuY3Rpb25fd2FrZXVwKCkgdGhhdCBjb21iaW5lcw0KPiBkZXZpY2Utd2FrZXVwIGFuZCB3
YWtlLW5vdGlmaWNhdGlvbiBsaWtlIGJlbG93IGluIGR3YzMgZHJpdmVyIGFuZCBvcGVyYXRlcw0K
PiBzeW5jaHJvbm91c2x5Lg0KPiANCj4gZHdjM19nYWRnZXRfZnVuY193YWtldXAoKQ0KPiB7DQo+
IAlpZiAobGluayBpbiBVMykNCj4gCQlDYWxsIGR3YzNfZ2FkZ2V0X3dha2V1cCgpDQo+IAkJUG9s
bCBmb3IgVTANCj4gCQkNCj4gCQ0KPiAJSWYgVTAgc3VjY2Vzc2Z1bCwgc2VuZCB3YWtlX25vdGlm
aWNhdGlvbg0KPiANCj4gfQ0KPiANCj4gT25jZSB0aGUgZnVuY3Rpb24gY29tcGxldGVzIGJvdGgg
ZGV2aWNlIHdha2UgYW5kIGZ1bmMgd2FrZXVwIG5vdGlmaWNhdGlvbg0KPiBhcmUgZG9uZS4NCj4g
DQo+IEZvciBoaWdoIHNwZWVkIHVzZS1jYXNlcyB3aGVuIHVzYl9nYWRnZXRfd2FrZXVwKCkgaXMg
Y2FsbGVkIGZyb20gZnVuY3Rpb24NCj4gZHJpdmVycywgY29uc2lkZXJpbmcgdGhlIHBvc3NpYmls
aXR5IG9mIHNpZ25pZmljYW50IGRlbGF5IGFzc29jaWF0ZWQgd2l0aA0KPiByZW1vdGUgd2FrZXVw
LCBkd2MzX2dhZGdldF93YWtldXAoKSBzaG91bGQgb3BlcmF0ZSBhc3luY2hyb25vdXNseS4NCj4g
aS5lIHJlbHkgb24gbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cyByYXRoZXIgdGhhbiBzbGVlcGlu
Zy9wb2xsaW5nLg0KPiANCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGFyZSBhbnkgY29u
Y2VybnMuIElmIG5vdCB3aWxsIHVwbG9hZCBuZXcgcGF0Y2gNCj4gc2V0cyB3aXRoIHRoaXMgY2hh
bmdlIGFuZCBvdGhlciBjaGFuZ2VzIHN1Z2dlc3RlZC4NCj4gDQoNClRoYXQgc291bmRzIGdvb2Qg
dG8gbWUuDQoNClRoYW5rcywNClRoaW5o

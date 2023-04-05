Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECC6D8646
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjDESuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjDESt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:49:57 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21F5589;
        Wed,  5 Apr 2023 11:49:56 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335HJNif024742;
        Wed, 5 Apr 2023 11:49:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=yTqGFOY3At0IMstJuTRre150LHj1G+zapGCiF4JwfrE=;
 b=ewsg7hpV3j3mU7H+AXBcDaYT4NVfyTFTaEE5jmLQh2FqNeJ4fy1wYeSSDWQkrhsw/mf2
 plx5atkLO3arinT1W0OVGury7h1W29nbNjiaeITcHAF6+OcyS3VQVB4QnY5gKs0xFkoQ
 v+mbJ/pzvRNrNfvZqShgJFXkgEVCGUgDtLOlhs3Vt92jxCJtfTfqi5ZWlOwylbPG6D0X
 xadk6HouZlbq0hH7s6GWlkUHTO5aX75i4ouZ8zrU4Abh3AAsSlYEhtfTW9v/cEG+sG5A
 8m+njPG9fgqdHtvR8Vt2+1c2a9k1TOGI3OnVTqdfkRQLzr7crqrobZf6G+HftZeM/ViB BQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ppk8jgex8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 11:49:52 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F02DC04C2;
        Wed,  5 Apr 2023 18:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680720591; bh=yTqGFOY3At0IMstJuTRre150LHj1G+zapGCiF4JwfrE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Pdrfy2hqR29ZnvWHIaflqcvsKnJpZSRdPd6OqqfHXQCbeM52EIDs5azpZZwiKmYjO
         3OI3LDso4G+GS9mZoN+COT5+KX1ce0XPu3IsoJXOpFwSL00k1gAlFdesl+wp8JSqcF
         wtT0y8uxRGv9xMN0q9eCMCzpYFffD4xudCeQOc87sRuXtEOa3JJMqciimQ+Kmbto2a
         0s5lrAlbPKb6/X00rRlaO8hg0NLtMDbbM5Cu1QN3WGuAEGxLRzW0lcwQcPfA2q4Gvb
         XBnI0J+mK9jWP2A3p7NabXoPt73yaxRzx7UR/ba5LNXZYc4iOJjIZkiwky46PTJykU
         GbhpQhAkQNVGw==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 355C5A0071;
        Wed,  5 Apr 2023 18:49:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 27353800BF;
        Wed,  5 Apr 2023 18:49:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="W96i8LNR";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbHOvKFspMCNdWMVcbfZjt9vIiY+kRZKI7CRBFDpw/AnOd/Eb4o1rXmjwJB/8Z74IfRId+za0n8ZxzLdLNIh0HMLOzl5AZ0GmWVlnkAckXWt8076tGVX4+ZQ0y41Up2da6wAJnNkjLEC7cCHe5vNIUW8ckK8hnm4Fl6owRM4sTE88cppIvgYb/xbG0KP4ZRaHfrhWwEn6gH2orvwE+yZAC/6Vt9USEuFsx/hO9O16aS3RQGqxLN0JLb0gd9ekJWbd5hma53gmTnnspMiooGzMHIJSM0BDSlqV/me7lOYNuSv/sHcQeV633h6f0ADLdIvq0rhobsGyTgHNQylzTvK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTqGFOY3At0IMstJuTRre150LHj1G+zapGCiF4JwfrE=;
 b=N+qgfE5EGKVxOeaxhTVWQEj/s/sXpeE6hnhhK5N8QaPnETnFsc/JTCbEkhRzaw3cr+gg2FIsxNgpJ9Ev1y2lGEOMLsMSZztN7ru02t6BVSfwbZAyevnXJwUMbGAWBtRQWljHD0qxM1ahCrcaI6BeAov8q+YKAPOvZO8YGdrEhhzJgbU2CPz79qCs3kGy87ZyDQmQQFhSikbXku3bVJ1pDxkgVPxGQDJx506uaNRabC077tI9a7WDaK9PPY4gVS8uh79c4H0kDHd2eevFqjY7w92ZxHp9FExEFy8J1Aj6IQafDJtziluBcI8wQ+CqdAJ48aH2JCKGUx8mPJ8eiXvZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTqGFOY3At0IMstJuTRre150LHj1G+zapGCiF4JwfrE=;
 b=W96i8LNRJdN0u72YuEn5sZFJUK4Z46hdGOdPkWUJ8GKLgnhhdQ2PprmFDCFsnaDjyAL4Z1vRVlCc65x6/SYht0G1NvIalBzzhwwwEUHwlxEevFaUfDToMV9uuCobuDdWd9gfx/mQp2e5SWL3yJ4NSbfAkwJiZVM91gQk/mOz9mU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 18:49:47 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 18:49:47 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Thread-Topic: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Thread-Index: AQHZZCdzfLLJh52qvUySQjzgywjsKK8aXF0AgAEnp4CAADn4AIAAAcoAgAFWr4A=
Date:   Wed, 5 Apr 2023 18:49:46 +0000
Message-ID: <20230405184943.fajtjau2dcgylg25@synopsys.com>
References: <20230331232039.1407-1-quic_wcheng@quicinc.com>
 <20230404011108.727htmnllj7ojwqm@synopsys.com>
 <c8181845-0f6a-9c6b-69bc-4ce9dabdf041@quicinc.com>
 <20230404221648.5fbajncfhd6wxkku@synopsys.com>
 <f1ff2346-0fd5-2e77-044c-9dc95cd5683f@quicinc.com>
In-Reply-To: <f1ff2346-0fd5-2e77-044c-9dc95cd5683f@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4249:EE_
x-ms-office365-filtering-correlation-id: dd829943-1c1c-4d7b-bd11-08db36068741
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vq1paKddbGwgoP7K8k3vZuuxMCd9pClxCpkRJIuqJZ/KaUzn/nsNPF5b8V/nvhCRSdtOKROh59F9ZtSPpQUUwF21R6zNT7kpv7/T7WRQoJO77NXjzCvAqRgXF6M6DBzCm2qoK5p0WBWJMkzj4u+6MCfntIumH/jOIEP9kl51Q/Ty03w8Yxx9dU6ZgGsG6JbWDpj1T0LtXszHXMKkLuSrgu4vRXFi5YXNTeN4flUhNnxJQN+55aVZf9dPQ6JDgzCuiQTibJOBHw6pI5WpLjp0HhK7FP7V44gsgOwZX4dUWkR3RG6C2VSd4XazEpgkjcEDA0wilVxJxPg6QGIA+OmptiSyAerfFYZo/gVATL8iu1IK85vj3j5eRz4b0QeJDT/X7QJuk5w4NpN5GSm87jrctAdDllfikdlf97UHLxuzU9+wbP5gGgn0KXEueyy+TjCWlhKRTMwlS2236xSzp+fqZpUJRl0yhz3odjIK+c8lf/yDjK7bAJ2OSho61vnk0edGT4kuVcRsPZR6nVLMtaCExb98H7LRANaKYD0+MKIkeTClzEPyGMpda2zav8T7P+H71xlOUwdDRdz8cFZ1e/nZADdC53IkJ/bLIfUAqGxneFRPMaFhjXWnZ7jkbeo0lKz5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(66946007)(478600001)(54906003)(66446008)(316002)(66476007)(8676002)(6916009)(66556008)(76116006)(64756008)(6486002)(6512007)(4326008)(71200400001)(2906002)(122000001)(38100700002)(5660300002)(41300700001)(8936002)(86362001)(2616005)(38070700005)(1076003)(53546011)(26005)(6506007)(186003)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1QyTHR5cHM4NHNid1krak5YcHdnUmFvaXgwLzBUdk4zKzFReC9UQUVGQzNN?=
 =?utf-8?B?MmZIMm9ueEM4eFBQY1hxZ2p1Ykw3ZDJZQmlhdXJaQ0cyV05jOFBOa2RGZW1D?=
 =?utf-8?B?NFNjQi9OV0dVV1Y0dXpTZ2NkM29HZWVXaXhxVW5pZXhYVU9QQXoyUTR4cDZk?=
 =?utf-8?B?SmgvTU5TVysyRXJYLzlFWXJzbHNsemNLZ3FPakpJOVpVRUJYWFRaTERwa1kx?=
 =?utf-8?B?dDZNWGxJUHpCRHg4VkMwVXE5eDdFeThON09qWHhZY3hSOGtiTHpVWnFKREEz?=
 =?utf-8?B?YmFmcnIyOEttQSs2eTQ5WUtTeWNDZ0tkcVRmZXdyNXpCRkM5WWFxWExlU1Q1?=
 =?utf-8?B?dzRZZjhsK2xzb21oOStJM0pBUmc5dTJZMEFPcENUUHZUV0RWS1laMGFkNDhB?=
 =?utf-8?B?L2NlbUpGM3kxTitmRUEzTVFmUGcwQTJ3WnlKcllkbGtqeCtoMU9QdlRsZklk?=
 =?utf-8?B?TVVzWG5KRmhnRnRva2xyWEFQaHkwWW1nTDJUb1N6VnlwZzMvaWZMOWUzZCto?=
 =?utf-8?B?Um5HNmxCMC9YaVVrcTlyWDYveFg0eXBXVXl5TGlKcVRxb3FBeUZKNEZ6VFhU?=
 =?utf-8?B?Ym44NDdFZncxb2dIQkE3QlAzL1JicDVDMVVoZURRcDhkNENVLzZRM0VqUytn?=
 =?utf-8?B?R2ViOG5qUXNXRzN3SWlabkpjZGxwbm9aaHFydkk3Zm1PSDlNNEtzSjRLaEtt?=
 =?utf-8?B?TFE2bmtIRms3UWNNZWZwMXJjTzJoVE11U2IzTmR6ZWNNdjRyc1BadmVXb2tl?=
 =?utf-8?B?ZGJSdVdnZHhnWld5TUlna3RuTStZbUU1bkRJdytzWXpUclF5YndIR3N4RjBI?=
 =?utf-8?B?dFRyNFBxZkxtRmZ6ckxzSTFxMFA0RHdzaTFNTnlyU3NRUzF5K2RJRXAzRUNX?=
 =?utf-8?B?Wkh6cm1BM09YQVNRZGNhejlZYjRVWEtTN0JPRUJQbzZSanV3Sk1QZWViTGpD?=
 =?utf-8?B?cDJsZzRMQmV5aHNDaGFVYksxeDNubnZacHZjN3ZhZE9xZ2tzZ0JSS1QwczBH?=
 =?utf-8?B?TUw4RHBxR1hQWnpTdWN0bFR6V1pVa2ZnK0FMazhCZGx0eVdKRG1IWDA5c3R3?=
 =?utf-8?B?RkgyOTNUcWdrK0FXWTY0UkNwMkpiMUhqajRGSVcrWWJ1NXlUOG90dGFNN1RX?=
 =?utf-8?B?S1pJQXA4VjRiVmNQcjdoN2dmNU43NGR0YVdaNmV0emUyRFd0T0l2ZmpsdVAz?=
 =?utf-8?B?VEVYa3BubFR3RGZDRDdyZGlicXFCVWwxTXFweUtOdW9XWlZoMTNMY0RMakQv?=
 =?utf-8?B?blpJb1J5UXV5L0xwWEcvemM3K1ZObkpWckJMYkVERWFSN0dLc3hydXo4cG9K?=
 =?utf-8?B?ZlVuUFZ2MmtaV2o0V0tOM0J5RFRhMnlQZlNyQkIvMzZNdXcwYXpEVWVnSU9s?=
 =?utf-8?B?L1ppNEUvc1N3NTNJVzZrQzRIRktTcU11SVhrYXU3SzNsaDZpVzYxUFlnbFh2?=
 =?utf-8?B?WDBGT3ZYMmJXZ09Gd0RyZW9EUCtMNGt6N3ZkS1RnM2RkVGg3ck1UMDNuYnRW?=
 =?utf-8?B?NUxIVmhjaVdnNjhaQlBicE9XaVVOQlk1aXdFN085Mnd0d3VBbnB6UXNzcmEr?=
 =?utf-8?B?UGlpSWhsd3pzLzNMWnhrTkp5WVVqWFlTVm05dlp1bGxUM1VmRUh4ckVHMGVM?=
 =?utf-8?B?S3JTU0o4M2tJUFRkWE85UU50S2pxUndkVi9lZVVlazNDd1ZLazBFVFRGK3U0?=
 =?utf-8?B?M0l5WXUyWVFRM2Z6MkRtNVlSRDlWSjdCWERBaW1vZUl3STUrb2NzUnkwMjJ1?=
 =?utf-8?B?L2M3a0tSWWJhOTJUemdSakRRYVZ2alZUVWc3dTRMUE5MOGFaK2FvU3dOTFpv?=
 =?utf-8?B?TXNwYW9MSDdVMWhXNHZnd05CcGVpQW9TTlBBQXlFUnBqNGZoMjZiT1VKZjFI?=
 =?utf-8?B?R3V5UEliNlFvWEFrQXZydVF5WG1ISnNXbUtpTjg1K21CcTlvWXFMc2VLVXlh?=
 =?utf-8?B?VEJLUy9LN0M5MktFMEJkWTl2SGg1cXora050dExCbEp1RzljbnNMelFWamxN?=
 =?utf-8?B?cTFnQkxEbVpOa24yS2cyY3hkVHpkWThjMFZjWkdkQmhkY0x1aWp6czZqZTg1?=
 =?utf-8?B?MGV4MTNZOThjYVZieXVjM3VEWTF3SEJiMHBWUFl0UVRZclNXY0wrK2o4K0JM?=
 =?utf-8?Q?QRV9Zv2YoH8OThyHoVDG2TuRQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F90CD6D16360AC4490178E9034159DC4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LLwoE2L4QAMj5rj9DG6tq7ntb0dZrrka9c4gj5JlyQGgsjd0zcIsEIBiEksVRNYHZyb3rI6jsBKIA/C0CciLBDXlobEMcbNimUko8Lm5S9y+AG6gMUvXjW4gVNtVa+h9mjMj7vBgCmY2oN5kM8tDAgdaTNo8ItcC3nAiKPmgN0PhOVg1Dt++eDcKH15ZIY72drAfA5vr/tPwqiy6ergBHvWiFNMmPHg6OAv8z0LTdCwghrmbB1ZRM2Qr9CQVHho1j/Vlz2B1nIynfQkSpeZfmna2w+AB2fRbLds5XGzWA1wP+sm7cqvXrfO6vXHMsn6l2QBO6HS3RclLnnAEwujKsJahD+5pVRx41tTZsR74kd0XOvp0+ipqsEgtwIcu/jvK0WkkEFZ0BqtblITxLfcYiK7jK3G/wPlgMjx2al5e5sMbDAM/WqmE+Ab+QvzE+MEo4A5Fq6AUUGkZtJit6MNNT4G55pzuagf2dTU+h6UFeVzDytV8EkKZ/A0XeIt39IBjZY12xQNaTF27yrv+4izPOTH8CrUdjohWSydz2o/UXY8wz17Xy+2Ljr4l3PwSMiscHR463PHqf8qbtgXm10xz5G8sw4t34JcWvcpOtT/JrYL0Mmt5Mo9JZVUhK3p9j+LDPOS6xNLP6yN08cHys/b8pc41LRHRQlQmkc7G53u5Q/qIs6JaxYMqg9LYMt4/uvf+zW7ttx/SCmkv+3TVmpJ3AWvHDLmMVVuK4Zv/TkYPKR/zx5WWfTMaD/SVFC+g3I8xOs8HatCB4yB01KMLmZnoOHwT40kZooK2NKnqlO9FJYlfMUUq1KiFcCZVT6iOIu29t+GJRSYd1ekkYe0Jr4RXDi/W8aaOd1jLEm+6sxxEUTu2Pd4IUiZxwQwOSaclpDaJ
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd829943-1c1c-4d7b-bd11-08db36068741
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 18:49:46.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79Wj6Zelncrwq0jT8d9AN1V6qg6ik1HgmPjJaG/WB44a980jlHe9Pfiru1/8Sa+BHnNU6KDSmnZzpt9nOj9c6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
X-Proofpoint-GUID: GtObiMws4Y64QlDJhv6IWqABa8H5Mz9V
X-Proofpoint-ORIG-GUID: GtObiMws4Y64QlDJhv6IWqABa8H5Mz9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_13,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050169
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBPbiA0LzQvMjAyMyAzOjE2IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVHVl
LCBBcHIgMDQsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gPiA+IEhpIFRoaW5oLA0KPiA+
ID4gDQo+ID4gPiBPbiA0LzMvMjAyMyA2OjExIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4g
PiA+IE9uIEZyaSwgTWFyIDMxLCAyMDIzLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+ID4gPiA+ID4g
SXQgd2FzIG9ic2VydmVkIHRoYXQgdGhlcmUgYXJlIGhvc3RzIHRoYXQgbWF5IGNvbXBsZXRlIHBl
bmRpbmcgU0VUVVANCj4gPiA+ID4gPiB0cmFuc2FjdGlvbnMgYmVmb3JlIHRoZSBzdG9wIGFjdGl2
ZSB0cmFuc2ZlcnMgYW5kIGNvbnRyb2xsZXIgaGFsdCBvY2N1cnMsDQo+ID4gPiA+ID4gbGVhZGlu
ZyB0byBsaW5nZXJpbmcgZW5keGZlciBjb21tYW5kcyBvbiBERVBzIG9uIHN1YnNlcXVlbnQgcHVs
bHVwL2dhZGdldA0KPiA+ID4gPiA+IHN0YXJ0IGl0ZXJhdGlvbnMuDQo+ID4gPiA+IA0KPiA+ID4g
PiBDYW4geW91IGNsYXJpZnkgdGhpcyBhIGJpdCBmdXJ0aGVyPyBFdmVuIHRob3VnaCB0aGUgY29u
dHJvbGxlciBpcw0KPiA+ID4gPiBoYWx0ZWQsIHlvdSBzdGlsbCBvYnNlcnZlZCBhY3Rpdml0eT8N
Cj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFllcy4uLkkgZGlkbid0IHVuZGVyc3RhbmQgaG93IHRo
YXQgd2FzIHBvc3NpYmxlIGVpdGhlciwgYnV0IHRyYWNlcyBjbGVhcmx5DQo+ID4gPiBzaG93ZWQg
dGhhdCB0aGUgY29udHJvbGxlciBoYWx0IHdhcyBzdWNjZXNzZnVsIGV2ZW4gdGhvdWdoIHRoZXJl
IHdlcmUgbm8NCj4gPiA+IGVuZHhmZXJzIGlzc3VlZCBvbiBzb21lIEVQcy4gIEFsdGhvdWdoLCBJ
IGNhbid0IHNheSBmb3IgY2VydGFpbiBpZiB0aG9zZSBFUHMNCj4gPiA+IHdlcmUgYWN0aXZlbHkg
YmVpbmcgdXNlZCBhdCB0aGF0IHRpbWUuDQo+ID4gPiANCj4gPiANCj4gPiBUaGUgY29udHJvbGxl
ciBzaG91bGQgb25seSBiZSBoYWx0ZWQgYWZ0ZXIgdGhlIChub24tZXAwKSBlbmRwb2ludHMgYXJl
DQo+ID4gZGlzYWJsZWQuDQo+ID4gDQo+ID4gImV2ZW4gdGhvdWdoIHRoZXJlIHdlcmUgbm8gZW5k
eGZlcnggaXNzdWVkIG9uIHNvbWUgRVBzIiwgd2hpY2ggRVBzIGFyZQ0KPiA+IHlvdSByZWZlcnJp
bmcgdG8/IElmIHRoZXJlJ3Mgbm8gRW5kIFRyYW5zZmVyIGlzc3VlZCB3aGlsZSB0aGUgZW5kcG9p
bnRzDQo+ID4gYXJlIGFjdGl2ZSBhbmQgc3RhcnRlZCBkdXJpbmcgZGlzY29ubmVjdCwgd2UgbmVl
ZCB0byBmaXggdGhhdCBpbiB0aGUNCj4gPiBkcml2ZXIuDQo+ID4gDQo+IA0KPiBTb3JyeSBsZXQg
bWUgY2xhcmlmeS4gIFdoZW4gSSBzYWlkIHRoZXJlIHdlcmUgbm8gZW5keGZlcnMgaXNzdWVkLCBJ
IG1lYW50DQo+IHRoYXQgdGhleSB3ZXJlIHBlbmRpbmcgKERXQzNfRVBfREVMQVlfU1RPUCBpcyBz
ZXQgZm9yIHRob3NlIEVQcykuICBIb3dldmVyLA0KPiBzaW5jZSB0aGUgaG9zdCB3YXNuJ3QgbW92
aW5nIHRoZSBFUDAgc3RhdGUgZm9yd2FyZCwgd2UgbmV2ZXIgbW92ZWQgYmFjayB0bw0KPiB0aGUg
U0VUVVAgcGhhc2UsIHdoaWNoIGlzIHdoZXJlIHdlIGZsdXNoIGFueSBwZW5kaW5nIGVuZCB0cmFu
c2ZlcnMuDQo+IA0KPiB2b2lkIGR3YzNfZXAwX291dF9zdGFydChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiB7DQo+IC4uLg0KPiAJZm9yIChpID0gMjsgaSA8IERXQzNfRU5EUE9JTlRTX05VTTsgaSsrKSB7
DQo+IAkJc3RydWN0IGR3YzNfZXAgKmR3YzNfZXA7DQo+IA0KPiAJCWR3YzNfZXAgPSBkd2MtPmVw
c1tpXTsNCj4gCQlpZiAoIWR3YzNfZXApDQo+IAkJCWNvbnRpbnVlOw0KPiANCj4gCQlpZiAoIShk
d2MzX2VwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RPUCkpDQo+IAkJCWNvbnRpbnVlOw0KPiAN
Cj4gCQlkd2MzX2VwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9QOw0KPiAJCWlmIChkd2Mt
PmNvbm5lY3RlZCkNCj4gCQkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihkd2MzX2VwLCB0cnVl
LCB0cnVlKTsNCj4gCQllbHNlDQo+IAkJCWR3YzNfcmVtb3ZlX3JlcXVlc3RzKGR3YywgZHdjM19l
cCwgLUVTSFVURE9XTik7DQo+IAl9DQo+IH0NCj4gDQo+IFRoaXMgaXMgcGFydCBvZiB0aGUgcmVh
c29uIGZvciBtb3ZpbmcgdGhlIHdhaXRfZm9yX2NvbXBsZXRpb24oKSBjYWxsIHVudGlsDQo+IEFG
VEVSIHRoZSBzdG9wIGFjdGl2ZSB0cmFuc2ZlcnMsIHNpbmNlIHRoYXQgaXMgdGhlIHBvaW50IGF0
IHdoaWNoIHdlIGNvdWxkDQo+IHBvdGVudGlhbGx5IHNldCB0aGUgRFdDM19FUF9ERUxBWV9TVE9Q
LiAgSWYgdGhlcmUgaXMgYSBob3N0IG5vdCBtb3ZpbmcgdGhlDQo+IEVQMCBzdGF0ZSwgdGhlbiB3
ZSBjYW4gYXQgbGVhc3QgdXRpbGl6ZSB0aGUgdGltZW91dCBwYXRoIHRvIGZvcmNlIEVQMCBiYWNr
DQo+IHRvIHRoZSBzZXR1cCBwaGFzZS4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRp
b24uIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIHRoZSBpc3N1ZSBoZXJlDQppcyB0aGUgbWlz
c2luZyBoYW5kbGluZyBvZiB0aGUgdGltZW91dCBvZiB0aGUgd2FpdCBmb3IgY29udHJvbCB0cmFu
c2Zlcg0KY29tcGxldGlvbi4gVGhpcyBjYW4gaGFwcGVuIGlmIHdlIGVudGVyIGZsb3cgY29udHJv
bCBhbmQvb3IgaWYgdGhlIGhvc3QNCmRlbGF5cyBwb2xsaW5nIGZvciBkYXRhLiBJZiBpdCB0aW1l
cyBvdXQsIHRoZW4gd2UnbGwgaGF2ZSBwcm9ibGVtcyBhcw0KeW91IG1lbnRpb24gYWJvdmUuDQoN
CkluIHRoYXQgY2FzZSwgd2UgY2FuIGhhbHQgdGhlIGNvbnRyb2wgZW5kcG9pbnQgY2F1c2luZyBp
dCB0byByZXNwb25kDQp3aXRoIGEgU1RBTEwgdG8gdGhlIG5leHQgaG9zdCBwb2xsaW5nIG9mIGRh
dGEsIGNhbmNlbGxpbmcgdGhlIGNvbnRyb2wNCnRyYW5zZmVyLiBUaGlzIGlzIHdoYXQgeW91IGRp
ZCB3aXRoIGR3YzNfZXAwX3Jlc2V0X3N0YXRlKCkgb24gdGltZW91dA0KcmlnaHQ/DQoNCkkgdGhp
bmsgdGhpcyBzaG91bGQgd29yayBhcyB0aGUgRW5kIFRyYW5zZmVyIGNvbW1hbmRzIHNob3VsZCBj
b21wbGV0ZQ0KYmVmb3JlIHRoZSBjb250cm9sbGVyIGlzIGhhbHRlZC4NCg0KVGhhbmtzLA0KVGhp
bmg=

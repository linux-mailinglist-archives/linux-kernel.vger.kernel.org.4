Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427596F3918
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEAUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjEAUUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:20:19 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BFD199B;
        Mon,  1 May 2023 13:20:17 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341J0HJk019813;
        Mon, 1 May 2023 16:20:07 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3q8w0emsnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 16:20:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkh4NK7hNIhSu35a6/spCMX7yewPi8pwmijmb1Fx20FvNO2eh07Y7jiU5Wq47n4UeLglg3nASJJ9K3Cs2Lzv3bF/iwu137LvKEyDPYxahhgRxaxMGmrGNpHA5tNKVw86Y6jLtjAep6h5nb1joR4StJLzHi9G+NoHlCqodft0fPOvW8T8b81Mcmf8aVNs52x20cJ6igzc8z9YnFTRZdqbb5AVFIMSrGwedx75KFytRSePbuKVPp7riKmfnhoTKPOgeZdGrBXZFXJ1Cxw2Vdus/GTI+UC51jJe29lIQKTI5mZFvanKUJw2rpe2aM29RSmOXK3UEoUyRG5V2+QoUOMdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLJ1qQuYjR6s1k9FyRWFfrSNAkh/ScQThKqRAmeo7TU=;
 b=d3Q3gN0HARTSFFuJTQ9iJnhJRnQWC5v9hEdWdOINQTMAmXr+mZoJWI3jhyOp5mfSMKj9+cpgDrSwAruIe7oHJZR2FOfbD5chBoXfW1y+eulDqNNdKE6WZuab8VjnqnOmVEUUAuq+BtFcktXcKHqpQ/LOBN2mcotS6vRJTAn17pk2TP0pfr1fZtOPNm4fe7w8TMv1zL3VPr6kJ1PUScnSY+uZRrJkCpu7iiDDra/MS3eN456NCwFx3EhStv2Jd/B3iCUzFmuERNmb5nsQecw1h/T4rRM5E+unaX/56+Qzu8W+eTbnRCR5HhhvT5uwr2bzsyC3SIe7murzHFZmcFfxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLJ1qQuYjR6s1k9FyRWFfrSNAkh/ScQThKqRAmeo7TU=;
 b=w6mPFwK0PeaCXLK3FZNDAzmGKqmntsKMCPA9F24Y2GB8XJdhzaaxKOAcTyXIL/88q2OdxFYlszsBtsDruxN1wkNFVReOj4UlKTBseDyDFu5gt30JoqERftpfpB13WIh5ZPqiRcRRszVWNAQkx343NXWXnCHg6iS5fuSA97WzC0A=
Received: from MN2PR03MB5197.namprd03.prod.outlook.com (2603:10b6:208:1f0::18)
 by SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 20:20:04 +0000
Received: from MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b]) by MN2PR03MB5197.namprd03.prod.outlook.com
 ([fe80::c8df:77bc:8e3c:f92b%5]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 20:20:03 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Thread-Topic: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
Thread-Index: AQHZXINPA5Z0YHRJuk2oYLjOoq53Ia8GeBmAgD+WG0A=
Date:   Mon, 1 May 2023 20:20:03 +0000
Message-ID: <MN2PR03MB5197BC6AEE58EFE098AF08358B6E9@MN2PR03MB5197.namprd03.prod.outlook.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-6-Zeynep.Arslanbenzer@analog.com>
 <afeecd42-ecda-4d92-bbb5-6dcff84fca7d@linaro.org>
In-Reply-To: <afeecd42-ecda-4d92-bbb5-6dcff84fca7d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFRoaU9UTmhNbVprTFdVNE5XUXRNVEZs?=
 =?utf-8?B?WkMxaVpqUmpMVGcwWVRrek9HRXhPRE16Tmx4aGJXVXRkR1Z6ZEZ3NFlqa3pZ?=
 =?utf-8?B?VEptWmkxbE9EVmtMVEV4WldRdFltWTBZeTA0TkdFNU16aGhNVGd6TXpaaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJamN6T1RRaUlIUTlJakV6TXpJM05EUTJNREF3TURJ?=
 =?utf-8?B?ME16Y3dNaUlnYUQwaVoyTldWblZpWW1SSGMxaERRVWgwWkVaME5VdEVlSGRT?=
 =?utf-8?B?ZW1GSlBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGRU1sUXZTazVoYm5wYVFW?=
 =?utf-8?B?UlRUbGxRTDNWbmRWRmFUa2t4Wnk4ck5rTTFRbXRFUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2Fr?=
 =?utf-8?B?RklWVUZqWjBKc1FVWTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZ?=
 =?utf-8?B?NFFWcG5RbWhCUjNkQlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRC?=
 =?utf-8?B?WkdkQ2JFRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0?=
 =?utf-8?B?UVdOM1FteEJSMDFCWkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJX?=
 =?utf-8?B?WGRDTUVGSVRVRllkMEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldW?=
 =?utf-8?B?RkNhMEZIYTBGWWQwSjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBK?=
 =?utf-8?B?MlFVZHZRVnBSUW1wQlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZC?=
 =?utf-8?Q?QUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5197:EE_|SA3PR03MB7187:EE_
x-ms-office365-filtering-correlation-id: 61a77232-c4aa-4c95-6b38-08db4a817296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KA3RvMejdZF+F+3Ym3t+4hmTxSkTzNb+3PmxqiaI+nwBkQwnuVkEm6Hb9iCieOJpbNKk4+9c7AaBIVd6lXBHv4Goa/cB33z9Zl+rwMyhb16ByOisr+XEEHwItPgc3OPqYiJlRdkFPD25YET9RmHLHhyKPC5vXbCoQishIugbjEqtnOv6gSNV4nkoSmDUkyaWpNKGFX+VU+XW6iBCqHOoPUFeAjP/Vb6wrW04NCQWChhBN/RwmDl6CyA5VSlFUSZqjwvSMGKd8At6ua94L65EBgTGNfPODJzXG9btwuJ1Hg13wVfi5TSDI4Xo5JQ4wKVvZ786KK8mNcXvlrqaQ1cS8vr5lVqho65o3Sj6l2Q0ZGbIPQoGyp1QJ8GmP4y63/tJ+PJ082IiLe2w6kuuMsGjwbUjLG/y/uJF+nV9DBWwD8t8/bVsDzeotLB+J16M5TAWe3d9ZuTchs1Xl2e9z05j8QIEeeT/2OeugTUWMlv4F9S9LK552YxlKUStqUQE1wdFPbzzjY5o9i/mhtcNys4jVCsv2KxAxHO3W3bfwUw8eUNW+qFw3BGP7kdZtSEEK2wLpbL8/RBZ/daf5Xy2gzsJjiU/jXp3nFqeBwOsIyIhocUROe3JsPPry0oelNCHtV/2O1oA/Bu/MXonHvq3qSeTsW/bhuH19s1xuZcxCQDTSRnawTs7V6qstMmwj8IBxOgF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5197.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(478600001)(66946007)(54906003)(66556008)(66446008)(66476007)(76116006)(6916009)(4326008)(64756008)(55016003)(316002)(26005)(71200400001)(9686003)(6506007)(186003)(7696005)(2906002)(8936002)(41300700001)(8676002)(52536014)(5660300002)(7416002)(122000001)(38100700002)(38070700005)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE9semkxYVdSVm5zRTlvMmNSTGI3NFBtcGlJNnczWFFGb2h0TFkydGRqeVlZ?=
 =?utf-8?B?Ukxpc241S0NURko4dFBmdXJyQUlpRTN0aUhrKzF1SmdRcWJKb1lUd2JWakFD?=
 =?utf-8?B?MStSbG1OYzRBZEdnMUwvKzZEQ0RvZUlXcjBHY3V4VkE5RDJHSnlCTy95RXRk?=
 =?utf-8?B?eDZxL1lUSXZwWGIrRkUvdnV3Umd3UG9mTHJ1T3hIaFhuc0RaYnJ0NHhDWGtJ?=
 =?utf-8?B?QURXb1d3VGxBdnhJMXlkSkwwQ1loQ0djQ01JRHIvanpINUM0TVI0T1VzQjNG?=
 =?utf-8?B?OGRERGV5TjV2VysxUkVYYWY1eWlCVDN6T1o0VHBCRHU3emw5WnI5Wml4Z29E?=
 =?utf-8?B?Uk5hMzhRL1U1UWJRUUR5N01JM3kwdjZJM2t1T2ZYbmVpK20ydnBYSCsyUktp?=
 =?utf-8?B?cDRkM1FGYXNqRkUwKytPUlFSMFFVdktwZUJjV0lVVUFJbC9WZ0x5em01L3V0?=
 =?utf-8?B?aVFYNzFid3p2dG90QUZPSGY4b1o1RjIxMnh2bTZQS1EvWjk5ZzRvMVBTVVl6?=
 =?utf-8?B?SXJlVSs2dmYyRFBKRkxyc2pTbE5mRUVBdE9FTkZ4ZjFXSmtwcmdHSVpwL3dO?=
 =?utf-8?B?Y0kzeGhoekV0ZXhLU0FmV084SDhwdlFJTkRFbkZ1S0tJQ3hBVVRLcGMzYzUz?=
 =?utf-8?B?TlpTZWoyY1c5SWxBRG8yaTRjWXcrb2o2L3Y4azhDdWUwRzRUV3lTSkhoNFY1?=
 =?utf-8?B?YW5QY1pZcGcrY2UvMzNyL3hpT3pXL1pSdTMvL3pJdS9hcTRkczlXZkpOOE05?=
 =?utf-8?B?Vk9IT2ZzdzdHUzRaekoxcFRpU25acWQ4RnN6THlMN0IwOHVpcTc4dWtmM1lv?=
 =?utf-8?B?b1R4Y3h1S3ZhMzF1L0hndXR3ZStCMVdHa2FteVpCRVMydTRqUFlKNmdmUjhU?=
 =?utf-8?B?VjNwZWRBS1FvRWtBbU9SclpjU0tlcXI5R2k3RnFvcWh2L05iejAvcFJtMUNt?=
 =?utf-8?B?TkFsbHRvSnhIcTRSN0w1eU1IWlFuRXBXT0h6YkpsWEhJS1RldklPSDMrS2lX?=
 =?utf-8?B?Z29QaUl5aGxra080VGpJSXVYd3A1c2JNRERGbEUwZWF3OEtFU2F4QnZkdkhG?=
 =?utf-8?B?emJEZXI5OGl4anZhVDlsa0pjMmJTQ0VSUzVyMzlta0lvNGY3dGdOb3hIL0ti?=
 =?utf-8?B?M3BSTFRvNFVCRXUreXdyWTJKRzNrTUdGc3RINkM1ZVVWakEzZVp3ay9Od2dJ?=
 =?utf-8?B?eERuU0ZBY0pQWnpqMnN0bFM4OTl5UnNBc1R2V3VJUWVvM2VhNktqVWpRdUpT?=
 =?utf-8?B?YjBVNmc3Y1NqM3FlL2pFd2xjMnd3THdOT2VwRHlKOE1aWitKL1QyWUo3ajhm?=
 =?utf-8?B?YldSdE1xVjdNRzl4bXpwazk3dUFCYnpNMG1TODVGY3MrYUZuWFZLQzNDR05i?=
 =?utf-8?B?MnRrclNZdzR5eDgzTkdKWG9NdVpwbTRZYWcxdGlVL0xBK1V5QmhpTTBpaklC?=
 =?utf-8?B?dXNuMWJQNHRadnpSckVBOUZNdlN0ZjFtTnlPYmFoWTdQbDZlSHY3K3VRNFR6?=
 =?utf-8?B?OHpuR3AwZVdrcm4xL0laU1dNSTFRYzBhSmFldm5KN21PN1dnSFhBalpyVFBp?=
 =?utf-8?B?a0YwOHFMUUkxM3MwcTB1OHZXM3BXcTlZNlVzMFRLZW9mV1ZUcWN3THNBZkIv?=
 =?utf-8?B?Q0gyeXZYcUdiaDcrZWtSL1hhWWxPWmZjRDRtditKUzlPN2hXRDNCZXlYcXFV?=
 =?utf-8?B?Z2ZlelFEajVFbEZtY09JZElHR2ZYOXAxc01YTzBhMy8wbGlEYzlYdXUxWEpu?=
 =?utf-8?B?dmpGTlh6SzZRS2FLWGxsWmI5QUo3blRmQ0VtWVIvZ2RPNWdOK0VUTHNuejVu?=
 =?utf-8?B?TTkxVWw3UEp6ejEwY2dJbGxzNm5xY0tYbjlLUElrSW9WdURWZlN5SEpPcnJh?=
 =?utf-8?B?UFBvVzZpYzk4czZSalJwbWdvWDZodWh1RUtPSEFPS293c1RYc1pKWGNXTnU5?=
 =?utf-8?B?RUV4YWpDdmdzdkJ2V0FaNTh3WER1SGQyeDJyUkQxSGJMRk4raUh2S01GZ29Z?=
 =?utf-8?B?QWxOeE9VQ0I4REh5WlkvSTNFbWYyWkk2a1E5T0RoVFFMWTViVTJkL0NnSjdQ?=
 =?utf-8?B?dGdWUXZFQVRZS0x3UUo2MllpMFB2d3VQTHc2OE5aeTRubUhXLzNmdGdtd0Nh?=
 =?utf-8?B?OFRNMkd6WEZSWUhsakhsdGNUOVpNTVJVNXhBdkpOSjQ4MXl4NWZLUHpMSDk0?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5197.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a77232-c4aa-4c95-6b38-08db4a817296
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 20:20:03.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4+YQoGOqb2UycS/CejiaehEPTC56wAe1/602TkAYszcNRT/k5LrsnCA6VIHKOzenWeg0FZ/ePEzMzzMclsUYkt1iWO//yQBvsIVACmPQ1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7187
X-Proofpoint-GUID: X7PxUFh_YMGsylzSt4AqvCkVKL8kpDM3
X-Proofpoint-ORIG-GUID: X7PxUFh_YMGsylzSt4AqvCkVKL8kpDM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010164
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMiBNYXIgMjAyMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj5PbiAyMi8w
My8yMDIzIDA2OjU2LCBaZXluZXAgQXJzbGFuYmVuemVyIHdyb3RlOg0KPj4gQWRkIEFESSBNQVg3
NzY1OCBwb3dlciBzdXBwbHkgZGV2aWNldHJlZSBkb2N1bWVudC4NCj4+IA0KPj4gU2lnbmVkLW9m
Zi1ieTogTnVyZXR0aW4gQm9sdWN1IDxOdXJldHRpbi5Cb2x1Y3VAYW5hbG9nLmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IFpleW5lcCBBcnNsYW5iZW56ZXIgPFpleW5lcC5BcnNsYW5iZW56ZXJAYW5h
bG9nLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9wb3dlci9zdXBwbHkvYWRpLG1heDc3NjU4LWJhdHRl
cnkueWFtbCAgICB8IDU4ICsrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwg
NTggaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvYWRpLG1heDc3NjU4LWJhdHRlcnku
eWENCj4+IG1sDQo+PiANCj4+IGRpZmYgLS1naXQgDQo+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvYWRpLG1heDc3NjU4LWJhdHRlcnkuDQo+PiB5YW1s
IA0KPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L2Fk
aSxtYXg3NzY1OC1iYXR0ZXJ5Lg0KPj4geWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uMGI2OTZmN2M0ZDFiDQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L2FkaSxt
YXg3NzY1OC1iYXR0DQo+PiArKysgZXJ5LnlhbWwNCj4+IEBAIC0wLDAgKzEsNTggQEANCj4+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlICVZ
QU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogDQo+PiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Bvd2VyL3N1cHBsDQo+PiAreS9hZGks
bWF4Nzc2NTgtYmF0dGVyeS55YW1sKl9fO0l3ISFBM05pOENTMHkyWSE3anpNcjhVYWxFampZZm1x
dUU2SXF0DQo+PiArU25kVTdmLWM5dmE3ODljQzJWbVNwdnN0QVotQW9rb2Z0RjF2WF9aZGVMeEd1
RTQ1NWs0RU1hRzBCZHlFQUVlcUNUNHJzDQo+PiArenJrdm13UzlGJA0KPj4gKyRzY2hlbWE6IA0K
Pj4gK2h0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueQ0KPj4gK2FtbCpfXztJdyEhQTNOaThDUzB5MlkhN2p6TXI4VWFsRWpq
WWZtcXVFNklxdFNuZFU3Zi1jOXZhNzg5Y0MyVm1TcHZzdA0KPj4gK0FaLUFva29mdEYxdlhfWmRl
THhHdUU0NTVrNEVNYUcwQmR5RUFFZXFDVDRyc3pyb216T0QxZyQNCj4+ICsNCj4+ICt0aXRsZTog
QmF0dGVyeSBmb3IgTUFYNzc2NTggUE1JQyBmcm9tIEFESS4NCj4NCj5JbXBsZW1lbnQgYWxsIHBy
ZXZpb3VzIGNvbW1lbnRzLCBub3QganVzdCBzb21lLg0KPg0KPg0KPj4gKw0KPj4gK21haW50YWlu
ZXJzOg0KPj4gKyAgLSBOdXJldHRpbiBCb2x1Y3UgPE51cmV0dGluLkJvbHVjdUBhbmFsb2cuY29t
Pg0KPj4gKyAgLSBaZXluZXAgQXJzbGFuYmVuemVyIDxaZXluZXAuQXJzbGFuYmVuemVyQGFuYWxv
Zy5jb20+DQo+PiArDQo+PiArZGVzY3JpcHRpb246IHwNCj4+ICsgIFRoaXMgbW9kdWxlIGlzIHBh
cnQgb2YgdGhlIE1BWDc3NjU4IE1GRCBkZXZpY2UuIEZvciBtb3JlIGRldGFpbHMNCj4+ICsgIHNl
ZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FkaSxtYXg3NzY1OC55YW1s
Lg0KPj4gKw0KPj4gKyAgVGhlIGZ1ZWwgZ2F1Z2UgaXMgcmVwcmVzZW50ZWQgYXMgYSBzdWItbm9k
ZSBvZiB0aGUgUE1JQyBub2RlIG9uIHRoZSBkZXZpY2UgdHJlZS4NCj4+ICsNCj4+ICtwcm9wZXJ0
aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6DQo+PiArICAgICAgYWRpLG1h
eDc3NjU4LWJhdHRlcnkNCj4NCj5JdCdzIG9uZSBsaW5lLg0KPg0KPj4gKw0KPj4gKyAgcmVnOg0K
Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgYWRpLHZhbHJ0LW1pbi1taWNyb3ZvbHQ6
DQo+PiArICAgIGRlc2NyaXB0aW9uOiBNaW5pbXVtIHZvbHRhZ2UgdmFsdWUgdGhhdCB0cmlnZ2Vy
cyB0aGUgYWxhcm0uDQo+PiArDQo+PiArICBhZGksdmFscnQtbWF4LW1pY3Jvdm9sdDoNCj4+ICsg
ICAgZGVzY3JpcHRpb246IE1heGltdW0gdm9sdGFnZSB2YWx1ZSB0aGF0IHRyaWdnZXJzIHRoZSBh
bGFybS4NCj4NCj5Vc2UgdGhlIHNhbWUgc3ludGF4IGFzIGJhdHRlcnkueWFtbA0KPg0KPj4gKw0K
Pj4gKyAgYWRpLHNhbHJ0LW1pbi1wZXJjZW50Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogTWluaW11
bSBwZXJjZW50YWdlIG9mIGJhdHRlcnkgdGhhdCB0cmlnZ2VycyB0aGUgYWxhcm0uDQo+PiArDQo+
PiArICBhZGksc2FscnQtbWF4LXBlcmNlbnQ6DQo+PiArICAgIGRlc2NyaXB0aW9uOiBNYXhpbXVt
IHBlcmNlbnRhZ2Ugb2YgYmF0dGVyeSB0aGF0IHRyaWdnZXJzIHRoZSBhbGFybS4NCj4NCj5UaGF0
J3Mgbm90IHN1aXRhYmxlIGZvciBEVC4gRG8gbm90IGVuY29kZSBwb2xpY2llcyBpbnRvIERULg0K
Pg0KPj4gKw0KPj4gKyAgYWRpLGlhbHJ0LW1pbi1taWNyb2FtcDoNCj4+ICsgICAgZGVzY3JpcHRp
b246IE1pbmltdW0gY3VycmVudCB2YWx1ZSB0aGF0IHRyaWdnZXJzIHRoZSBhbGFybS4NCj4+ICsN
Cj4+ICsgIGFkaSxpYWxydC1tYXgtbWljcm9hbXA6DQo+PiArICAgIGRlc2NyaXB0aW9uOiBNYXhp
bXVtIGN1cnJlbnQgdmFsdWUgdGhhdCB0cmlnZ2VycyB0aGUgYWxhcm0uDQo+PiArDQo+PiArICBt
b25pdG9yZWQtYmF0dGVyeToNCj4+ICsgICAgZGVzY3JpcHRpb246ID4NCj4+ICsgICAgICBwaGFu
ZGxlIHRvIGEgInNpbXBsZS1iYXR0ZXJ5IiBjb21wYXRpYmxlIG5vZGUuDQo+PiArDQo+PiArICAg
ICAgVGhpcyBwcm9wZXJ0eSBtdXN0IGJlIGEgcGhhbmRsZSB0byBhIG5vZGUgdXNpbmcgdGhlIGZv
cm1hdCANCj4+ICsgZGVzY3JpYmVkDQo+DQo+WW91IGFscmVhZHkgc2FpZCBpdCBhYm92ZS4NCj4N
Cj4+ICsgICAgICBpbiBiYXR0ZXJ5LnlhbWwsIHdpdGggdGhlIGZvbGxvd2luZyBwcm9wZXJ0aWVz
IGJlaW5nIHJlcXVpcmVkOg0KPj4gKyAgICAgIC0gYWxlcnQtY2Vsc2l1cw0KPj4gKw0KPj4gK3Jl
cXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+DQo+V2h5IHJlZyBhbmQgbW9uaXRvcmVkLWJh
dHRlciBhcmUgbm90IHJlcXVpcmVkPw0KPg0KSWYgbm8gbW9uaXRvcmVkLWJhdHRlcnkgaW5mb3Jt
YXRpb24gaXMgc3VwcGxpZWQsIHdlIHNldCBkZWZhdWx0IHZhbHVlcyBmb3IgYWxlcnQtY2Vsc2l1
cy4gVGhlIHJlZyBwcm9wZXJ0eSBpcyB0aGUgSTJDIGFkZHJlc3Mgb2YgdGhlIGRldmljZSBhbmQg
aXQgaXMgcGFydCBvZiB0aGUgcGFyZW50IHNjaGVtYS4gVGhlcmVmb3JlLCBib3RoIGFyZSBub3Qg
cmVxdWlyZWQgaW4gdGhpcyBmaWxlLg0KDQpCZXN0IHJlZ2FyZHMsDQpaZXluZXANCg==

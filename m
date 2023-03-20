Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB086C20AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCTTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCTTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:01:18 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4E6E8F;
        Mon, 20 Mar 2023 11:53:26 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFYKPi012554;
        Mon, 20 Mar 2023 11:52:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=XcvJtzWcrL4pm1JBqnvtN4vDItU+8ILC7Il/aezGGLg=;
 b=phHPQh5wtgArsrXLXdd4G6iNJdro+Uie+oaQ6b4bb0kACCeupL7yVZLEZ0C1B3nKpXJ8
 8kJQE8RzCi8hWh/Qa4MNKywfT20SHBz31bO8QqPP5/bt2Ll5jJX6KZ8ghC0KVevwErZ8
 FXc5cbU00oJiCh0k5/QSRnSnqS0kkdv5vzs0aexgKrey17zIusHv5lcDjkscYIndreW2
 TIsvXp83yQSkGcYB4+jPuZXOy+8H05XQ5As9mGBsY+Y+phb1lOsXXsO3D4o+b5gilz35
 wm3dUv5Ick6DBjWBxE3l2H+VmFidpo8ecFi6RiJ8wGaDyhmPAEYi5Qg88tVsTbnJlJeX mA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pdc7w9gcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 11:52:16 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A7DA4404EF;
        Mon, 20 Mar 2023 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679338336; bh=XcvJtzWcrL4pm1JBqnvtN4vDItU+8ILC7Il/aezGGLg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WBvBLA9e5gREQ3FzF1CrMstfhleWBCnYSK07UkdthRWYPYL55Lrnt1PYG10XQFSKE
         lX38JduTLexWeXIQe6CYDSmEVXxzlIFk4qol4K+35WxIG9ew6a2BYaRAypixQhq2gP
         QB5id0CCQRj854y9g7Z700B1uJGvp56m+/xeIUR8LhmF+21c/8KGBwhuxfV8hk7O9v
         9musoxO72XHptZOMdVjlvSq5enKRRFF8U7e75I+CdaXXG2BhDxEcVdYZ6f5CFgQWuh
         5YmQjTypc0e7Xu+K9ukOD1KTbnhTLNTtHfvUHCkn00NLVEjuspQ4dr48RdW5/abQU9
         pVB8JH4GXzWRA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0C2B2A00AC;
        Mon, 20 Mar 2023 18:52:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 276154011B;
        Mon, 20 Mar 2023 18:52:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oOIQW5MF";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+sniW78n9yNG19fxYUnEDOxdOKRQX8umQb2vRLDO7BSd/0o1mplAgtruYkaWrwYwhaLnvcEuLFl4HAnCorotnHQ8ckDqqGN1R3wXwwQ64UWYn0QUHKuhepFeoHqGVhwtEDbutT4pS2NQpuvij3gbRGErZKN2eU+qg6ho7FmY0cEG3hdB6BT1vhM7Gfbx9s9MZi4eEBhvc2T65qehYAr596B1/wnEgBf6Y7RHc54pM1Wwtt3l4V8AVnKlH8Rz0DT/N11gvWSerd511gaFiWyCPbITYqtYEXKkdvoHz37YLmaS1s13PdcQBEFaB+Ijz9ekhrY3vnOuuYTbIwI3oJbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcvJtzWcrL4pm1JBqnvtN4vDItU+8ILC7Il/aezGGLg=;
 b=MmDtTRflv2dtFY61GQ3iilnC1bwdGq4/9niDVI4oxngjP10G5xHsqvE/hRVfcEm7cI4c4wch6DvGGv+wvhhyLpYk2ir9AqnVsXIwt+hIWTTp6H9YQK/O7iEq7Ri2sYpaVOGLQ+ZjsY07ZAR4G+fzE2MIZz7GE3Ej4dGiVArFLf6L42wU/TN3vpmI+HN9xemcLNb64g/yd0V7mkNaBZgK89sMIreecncQmM5hb9CxYgowk40f6tQB8Y4j0cRq9WaxJYk7+SYqKgJrc8XI/1A3llP0d2iYcs3w9mnFyUd1ai9casDTB+6o7sHZT/KAA5KCi6q75ALP7hTxyUNXHL9UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcvJtzWcrL4pm1JBqnvtN4vDItU+8ILC7Il/aezGGLg=;
 b=oOIQW5MFmYFrmsk9nzoRaJhBUKtQYWOd07r3CfvF2otTA1+WRuhBVwgHdyc8vWVwW/1aDQBevTinTMaZkEW9NC3rkbWmZl0l7HCnT+NW7cEAEethiaw+yRVcGi09h7PPnc0kllU7zG99k6VvVglF92ivx9IASLqrhUmaqrdYaNQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:52:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:52:06 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Topic: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMA
Date:   Mon, 20 Mar 2023 18:52:05 +0000
Message-ID: <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-3-rogerq@kernel.org>
In-Reply-To: <20230320093447.32105-3-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5141:EE_
x-ms-office365-filtering-correlation-id: d6d66e11-abc5-40b4-8a28-08db29743396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVU8rGsF/9uBjigVaDFCjaxLI/Lp+GqtLCw54nx6lyMWiflcWYjK6hLZ0Wg5I+Ft0aydV7ZbasVIbP5RCiquR9VAwooZOm4hXrEaCHJFVDE8UoemTgm5VJgy0bSXVVqfgBWnN9IEMqvICVt8wSLBCChfUdBFCZ/ExrpghODdg8PUB3G8XYD3ReVxVp90uWgcRPDgTrpeYH2dqRbhLhmi9T94KZ8JxLAy0mjwLyJhnce2YvAd7aCTEHgvn5iXhiT7eJwVpvaq6lP46FuZm8zyEagxEV9+GiZb2FSHJFCNgzW6eTqRJlHZwqwQKDTlq5xVxnLFkYALwCipKydQ1krYDRGw7Ft8KhaahpfGokkidehXjjOnFZUmbDB6k5gBOmNdQ/5EKMm3AfsEvFfVYC0m7J5wGgcpGqIE45FI3AyIhpXdJua4mB/GRUA2Pnj8hdttjgwKi9ny18mU8RgT9/myTIWrktbVmRXfr5IaECo57f7efq5TN8uH9XlVGThQJy7R06AQVopawE2m5tfCsUFkcbBf7nIW1+/me+tP4UhvhW9lGquSCCc9P8zYnxZYwa0kpZ6QQOCbpPIjeltaRAwgGeYtn7nzYdfXyZkKqic7wipfwY7fxvzETzjJzLFGUV/x/UUJLwfN16HpKCz6di0aHREi8pZL0m3dhjkpZooFkKGc8DFQ8QOrKRRTheFMwJen+ongg5SXyYG0o2ZuPAoxBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(2616005)(54906003)(83380400001)(6512007)(478600001)(71200400001)(6486002)(6506007)(316002)(1076003)(26005)(186003)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(8936002)(2906002)(66946007)(41300700001)(76116006)(6916009)(64756008)(4326008)(8676002)(66446008)(66476007)(36756003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJLOThyM3NLaGRZZ0srMlp3bmdXaEVFbUtMenJKWVIwUnUyZlFUVzdOR1Rl?=
 =?utf-8?B?VVBZTmdzRkdkSzBUckNBaU0yS3dmbnZMM3lGUzBWc2g3ajZ0T0cvZGdwcWw4?=
 =?utf-8?B?VXBWR3l6UW4vNHRkaXhZNFNtb1NMV0hsOHBoZG8wdHo3RU5vbnhWMVI0SVFR?=
 =?utf-8?B?b0I3MVVIU3ZMNjIrVWg4VlVUYTUwenNUY3dEVEM3T0l3ZnVoUjZlZGNRVHl3?=
 =?utf-8?B?VHdua0JzYUdRQlR0VUF5aUlBeVNnaWRLK2RHSCtseHdMeWt4eHNBTEloNGhJ?=
 =?utf-8?B?bGV0RWJ3ZFg4WnJoUUcxNzl5T1VHTTkyT2U0YnRDTjBxV0xtbmYxTVc1ODNQ?=
 =?utf-8?B?Z0hQTFdUMGxpeFMvd3NMNStmWjEyM3d1eEpHb0dyUXNVaUFZZFArQzR2TjBi?=
 =?utf-8?B?N0xQRG1yU2FNWDdkaStFWnkwL1E4V2VTa1VZdUZvd2FUQ1Fza2Q5ZkgvOGtw?=
 =?utf-8?B?cGZzQ0dJMzlpUjJHNWMxOGVYVEV6LzB3ajk4ajBzZ01RbTROVURLV3VPMHZ2?=
 =?utf-8?B?VWllTmxlSFYrcnNZeFdjQ1JQZG5OR0pzdkRyUlZTOUFudFFlSnNzODVTUXlH?=
 =?utf-8?B?S3lmcjRkQisrU3d0UjhqNEQ0eU5jR0pGdUFJUWtCeDlXWXhNMUYrVm9vaHZj?=
 =?utf-8?B?S1d3RzBZTVJuV0lmbkYvUFFSK05YVW9VVkdwMzROQ1hFVGhiczkrWjNyOEZB?=
 =?utf-8?B?aUR0cXA5bG5GNVdWSXNjVDdvMUlwNmZSZmtQSGhnZ0s1amsxOWQ5NHBtSE1z?=
 =?utf-8?B?d0Zzd2pwOVZ0SDFaVWsrMWFaS3BnSyt5cDFuOVRjU3MxNTRhMGlHU1lPWHVN?=
 =?utf-8?B?aFpuNXJuVmsva3haQStyUmRLc2trbFF3MUt1YmdyK0E4eFZCNDZDR0FPTjVQ?=
 =?utf-8?B?Q0h1VG0rZElSa2NxQnV3aldueG9zTWNYNWRQcmQrNzRpTSt3a2Ezd0UzSTR4?=
 =?utf-8?B?ajFXaEJ0c2x6bGMrdndGOUlCRHFXYUVlaVVOSGFqaHpxeUY2UldVZWZ5K3hQ?=
 =?utf-8?B?TFJiQjJ5elFHVWlCZ1Q2alJrbXl1R1JWZWs2d1YwOWxLVVFQZUp4M2ZwSG00?=
 =?utf-8?B?eCtMdTFtcjUyQm9qS3NJSGpKbk5KU3BYVWdTV21ReWFIN0JRdFVnODFzbE9F?=
 =?utf-8?B?R0hnMnNFQUtnVnhuQ2lscUU4TERTT25XY2dXU1ZUOHhFcEIwS1dmemNGVnZJ?=
 =?utf-8?B?QldCc0pDT3FPS3BiM0JjY3k2bVVYOHF3VUpxam8vY2ovMnp3QnBFeEZ2dy9Q?=
 =?utf-8?B?MWNaWm14SHRwQkJZMVZ0QS92MVduTkZiVUUxWm1hS2VMZnFWdXc1d3luNXZY?=
 =?utf-8?B?b0pZYmFwZmZ1eGcwUUJHZk9udmhWc2lvTFduRlBXS2N5TytqdVQvYU5YNFhr?=
 =?utf-8?B?c2ord28zeWtDdDZZdEQyWnYwQk1yOEZhTG4wWjhyV2ZkSThpZHRzUmM3VTRp?=
 =?utf-8?B?R2FibVl3OG53cDB2TzFDK0dNVmN5OUVsUEFoTDV6VmtEWTBNVWNsVjlwRVN3?=
 =?utf-8?B?TjdCVDcvVVJXeFZYOG1kM3pzOHJoMmNXUGdCZ08rMzdrOFUxcUN5ZnZVd2RJ?=
 =?utf-8?B?V2U3K1k4dVAwK1lPV09mQUw4YWYxL1ZxTzRjZDhPZjdmekJWdGdSbGo2Y0pu?=
 =?utf-8?B?cXNuSkZIblNZUFR4KzR2bkJPSHRWRTNUOG54OTlZbVBXOUVEaWNEelJsVmw3?=
 =?utf-8?B?Qk80ZndwRjVsNjY5azF4MnRJWC92VkprMGNpVEFXY2RUZ0R5RThaYldObW5Z?=
 =?utf-8?B?K1FMaWg1bFNjQjlwbkdiakQrcFV6OENjWXkyNW9TZ3RKZ3MzdE5CVXJTY0xS?=
 =?utf-8?B?bGpvU3U0YlZXc0RUTmhhWENjS29iTGdBaFVuWlAvR3hDQS9RalFzYzJ5UWJR?=
 =?utf-8?B?dUtKbENaNCs2SzlPZjZ5MXRKMi9LV1llYXQxMGswQ2JjaU5TaVBWS0ZPVWZI?=
 =?utf-8?B?Tld2QUJVWStZTlpxMEJLTVRGdFAxdHEyZmFKa3RoN3VFSFFZOTdrQjZNeFFE?=
 =?utf-8?B?a09sNEMzZ3NUM1QvTjBPb2NTZ21oallSMHNOaHdxbndnRmxOV3l1RFFQR3Yr?=
 =?utf-8?B?aS9iQjdZWVZsZ0Nha0ozVkxWZ2ZiSnl5UC9LVTNmTUlzVThTZHc2VVQ3WnVU?=
 =?utf-8?Q?h1TFcZ5cOU5F/0Bq8R+VWY68K?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93AA95FDD1504A49ADC5E42A7BE26E71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a2lrOTc4cWgyVE9lQkhsOEp5SHBRVVEzeCtXV3ZDWno5TFJ6R0hnaUpDWnpr?=
 =?utf-8?B?ME1sVy9namtyYklhN3U4SW1aV3ZCU2k3dTR1dnd4OVRoNTBuUTJXVUlSSjZK?=
 =?utf-8?B?a2hTTTVYZkVKR2FvdkExYXl1QWZuaTAvWFdOL1duSHFpRFNjZVd2STlieXdM?=
 =?utf-8?B?c0g5ampZc3NMTUFTWUtyMnhpOGdGcnFSZnRLcDkxYm8zbmVMclByc2FxYlZP?=
 =?utf-8?B?WmtJZjVkMnJNd1F6Q3Y3Z2o3Ym9SWnVhOS8yd2dIUWFMeStmSkE3UEhlN3dj?=
 =?utf-8?B?WGpaU244U1VOcWcrcDRwbGRIYlcvSmc0UERXL2QxaTJnMnN4ZWMyUmtNb0hS?=
 =?utf-8?B?QStEdkZYYldrMWsyam4xek1hZDdkTFJWMUcyK2s2WGdlajFGb1RncHZmZXJY?=
 =?utf-8?B?QndrWHJaaWV4Slllbm9xVVJYendpUmsyVFN0SnNZUlNqdUdoR2VHU0F5Wlll?=
 =?utf-8?B?U3J3bGk4emJhODFwd21BNDI4eUZhOUZESHhMb0NpMzVtaEtCZGRsS0t4UHpz?=
 =?utf-8?B?dXczdWRvQy9RTmk4Y3hkbVpLM3l0VE1rbFJjT284ZFdiL0hvQnAzWEthTjhu?=
 =?utf-8?B?UlpPUzZXVDBmcWVyOTFiQmlxNnZPd0NVYngyZG9aQ0FmeDZKWVROT2ZUSENS?=
 =?utf-8?B?Y2dqRnlMMStTeGpIL0RsRTVqNlNzR2g0UkdiRkVKNVpONTBGTU9SR3NSd25P?=
 =?utf-8?B?WU5aa1NBYWRnWGY2VndyUkpwWWhsNndFVGo5cjNqMkRnaWJYWnA3c09PV0pW?=
 =?utf-8?B?ejJJRUJycHJ6S01aV1dTOVk5QmVESVBieGFCZUhieENzWEd3ekFrMmxwN2RR?=
 =?utf-8?B?Q2lNVU9EUk0vcGJvK2Z3ZDk4SDUwVnlIenRxQjlQR1JhN2lOZXRkQ3B4VURM?=
 =?utf-8?B?ZHBpcWZ5eHhYcXpYdTVmNjdXeEkwZnFOYnZuRG4yL1l2bnZOZDJEZXFGWmRM?=
 =?utf-8?B?eWZIMThKdkx3Ynd6M3g1N21qUmVMQmNkdWpiaEZEdEFQa25jU3A1dUtxRFp0?=
 =?utf-8?B?YmVCUE1MdC9IeU83M1N1THlaMnJvWjEvSFc5SVRwVGFlVXFndHN1a3FQZk0w?=
 =?utf-8?B?Q3lHOFRzbVp4NkUzSUZya3FLVjhqSnJaYlJHbE1PVndlQXhBRnBldGQzWmVi?=
 =?utf-8?B?WmhROWpKUjZCZEZ5NGJSa0NsMWlPKzc5dUt1ODA5K0srWmRpbmxrdlZFWmVs?=
 =?utf-8?B?L1IyWU9rNFU0bXFyeWR3Rm1XeVhNbHltU3IydWVjdUt2UjU4NUpaNFQxU1Vw?=
 =?utf-8?B?K0oyWk5oaVRvekMzK2RtRmEvNGZnazNmVU1tWU1Lb2VZMm03QT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d66e11-abc5-40b4-8a28-08db29743396
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 18:52:06.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDxqvIAFw7EgzxAna3VdsPeSMfwENPvtaTU39B6diRK54F0wE0g31nw9zU+bNJl30C4NYYLavmrzuZDMiQKbPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
X-Proofpoint-GUID: 4EevFlLhHQDaUtgApuoR1nltp3M3NYXK
X-Proofpoint-ORIG-GUID: 4EevFlLhHQDaUtgApuoR1nltp3M3NYXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303200158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgTWFyIDIwLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiBJbXBs
ZW1lbnQgJ3NucHMsZ2FkZ2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAnIHByb3BlcnR5Lg0KPiAN
Cj4gRG8gbm90IHN0b3AgdGhlIGdhZGdldCBjb250cm9sbGVyIGFuZCBkaXNjb25uZWN0IGlmIHRo
aXMNCj4gcHJvcGVydHkgaXMgcHJlc2VudCBhbmQgd2UgYXJlIGNvbm5lY3RlZCB0byBhIFVTQiBI
b3N0Lg0KPiANCj4gUHJldmVudCBTeXN0ZW0gc2xlZXAgaWYgR2FkZ2V0IGlzIG5vdCBpbiBVU0Ig
c3VzcGVuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAyNSArKysrKysr
KysrKysrKysrKysrLS0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysN
Cj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiBpbmRleCA0NzZiNjM2MTg1MTEuLmE0N2JiYWEyNzMwMiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gQEAgLTE1NzUsNiArMTU3NSw5IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3By
b3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MtPmRpc19zcGxpdF9xdWlyayA9IGRl
dmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiAgCQkJCSJzbnBzLGRpcy1zcGxpdC1xdWly
ayIpOw0KPiAgDQo+ICsJZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCA9IGRldmlj
ZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiArCQkJCSJzbnBzLGdhZGdldC1rZWVwLWNvbm5l
Y3Qtc3lzLXNsZWVwIik7DQo+ICsNCj4gIAlkd2MtPmxwbV9ueWV0X3RocmVzaG9sZCA9IGxwbV9u
eWV0X3RocmVzaG9sZDsNCj4gIAlkd2MtPnR4X2RlX2VtcGhhc2lzID0gdHhfZGVfZW1waGFzaXM7
DQo+ICANCj4gQEAgLTIwMjcsMTQgKzIwMzAsMjAgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRf
Y29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICB7DQo+ICAJdW5z
aWduZWQgbG9uZwlmbGFnczsNCj4gIAl1MzIgcmVnOw0KPiArCWludCByZXQ7DQo+ICANCj4gIAlz
d2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQ
X0RFVklDRToNCj4gIAkJaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4gIAkJ
CWJyZWFrOw0KPiAtCQlkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICsJCXJldCA9IGR3YzNf
Z2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZGV2X2Vycihkd2Mt
PmRldiwgImdhZGdldCBub3Qgc3VzcGVuZGVkOiAlZFxuIiwgcmV0KTsNCj4gKwkJCXJldHVybiBy
ZXQ7DQo+ICsJCX0NCj4gIAkJc3luY2hyb25pemVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+IC0J
CWR3YzNfY29yZV9leGl0KGR3Yyk7DQo+ICsJCWlmKCFkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rf
c3lzX3NsZWVwKQ0KPiArCQkJZHdjM19jb3JlX2V4aXQoZHdjKTsNCj4gIAkJYnJlYWs7DQo+ICAJ
Y2FzZSBEV0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQo+ICAJCWlmICghUE1TR19JU19BVVRPKG1zZykg
JiYgIWRldmljZV9tYXlfd2FrZXVwKGR3Yy0+ZGV2KSkgew0KPiBAQCAtMjA4OCwxMSArMjA5Nywx
NSBAQCBzdGF0aWMgaW50IGR3YzNfcmVzdW1lX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9t
ZXNzYWdlX3QgbXNnKQ0KPiAgDQo+ICAJc3dpdGNoIChkd2MtPmN1cnJlbnRfZHJfcm9sZSkgew0K
PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+IC0JCXJldCA9IGR3YzNfY29yZV9p
bml0X2Zvcl9yZXN1bWUoZHdjKTsNCj4gLQkJaWYgKHJldCkNCj4gLQkJCXJldHVybiByZXQ7DQo+
ICsJCWlmICghZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCkNCj4gKwkJew0KPiAr
CQkJcmV0ID0gZHdjM19jb3JlX2luaXRfZm9yX3Jlc3VtZShkd2MpOw0KPiArCQkJaWYgKHJldCkN
Cj4gKwkJCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJCQlkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0Mz
X0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+ICsJCX0NCj4gIA0KPiAtCQlkd2MzX3NldF9wcnRjYXAo
ZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+ICAJCWR3YzNfZ2FkZ2V0X3Jlc3VtZShk
d2MpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmgNCj4gaW5kZXggNTgyZWJkOWNmOWMyLi5mODRiYWM4MTViZWQgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+
IEBAIC0xMzI4LDYgKzEzMjgsOCBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJdW5zaWduZWQJCWRpc19z
cGxpdF9xdWlyazoxOw0KPiAgCXVuc2lnbmVkCQlhc3luY19jYWxsYmFja3M6MTsNCj4gIA0KPiAr
CXVuc2lnbmVkCQlnYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcDoxOw0KPiArDQo+ICAJdTE2
CQkJaW1vZF9pbnRlcnZhbDsNCj4gIA0KPiAgCWludAkJCW1heF9jZmdfZXBzOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gaW5kZXggM2M2M2ZhOTdhNjgwLi44MDYyZTQ0ZjYzZjYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiBAQCAtNDU3MiwxMiArNDU3MiwyMyBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIGludCBkd2MzX2dhZGdldF9zdXNwZW5kKHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKwlpbnQgbGlua19zdGF0ZTsNCj4g
IA0KPiAgCWlmICghZHdjLT5nYWRnZXRfZHJpdmVyKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiAt
CWR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gKwlpZiAoZHdjLT5n
YWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCAmJiBkd2MtPmNvbm5lY3RlZCkgew0KPiArCQls
aW5rX3N0YXRlID0gZHdjM19nYWRnZXRfZ2V0X2xpbmtfc3RhdGUoZHdjKTsNCj4gKwkJLyogUHJl
dmVudCBQTSBTbGVlcCBpZiBub3QgaW4gVTMvTDIgKi8NCj4gKwkJaWYgKGxpbmtfc3RhdGUgIT0g
RFdDM19MSU5LX1NUQVRFX1UzKQ0KPiArCQkJcmV0dXJuIC1FQlVTWTsNCj4gKw0KPiArCQkvKiBk
b24ndCBzdG9wL2Rpc2Nvbm5lY3QgKi8NCj4gKwkJZHdjM19nYWRnZXRfZGlzYWJsZV9pcnEoZHdj
KTsNCg0KV2Ugc2hvdWxkbid0IGRpc2FibGUgZXZlbnQgaW50ZXJydXB0IGhlcmUuIFdoYXQgd2ls
bCBoYXBwZW4gaWYgdGhlDQpkZXZpY2UgaXMgZGlzY29ubmVjdGVkIGFuZCByZWNvbm5lY3QgdG8g
dGhlIGhvc3Qgd2hpbGUgdGhlIGRldmljZSBpcw0Kc3RpbGwgaW4gc3lzdGVtIHN1c3BlbmQ/IFRo
ZSBob3N0IHdvdWxkIG5vdCBiZSBhYmxlIHRvIGNvbW11bmljYXRlIHdpdGgNCnRoZSBkZXZpY2Ug
dGhlbi4NCg0KQlIsDQpUaGluaA0KDQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4gIA0KPiArCWR3
YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gIAlzcGluX2xvY2tfaXJx
c2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJZHdjM19kaXNjb25uZWN0X2dhZGdldChkd2Mp
Ow0KPiAgCV9fZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KPiBAQCAtNDU4OCwxMSArNDU5OSwyMSBA
QCBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+ICBpbnQg
ZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+IC0JaW50CQkJcmV0
Ow0KPiArCWludCByZXQ7DQo+ICsJaXJxcmV0dXJuX3QgaXJxX3Q7DQo+ICANCj4gIAlpZiAoIWR3
Yy0+Z2FkZ2V0X2RyaXZlciB8fCAhZHdjLT5zb2Z0Y29ubmVjdCkNCj4gIAkJcmV0dXJuIDA7DQo+
ICANCj4gKwlpZiAoZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCAmJiBkd2MtPmNv
bm5lY3RlZCkgew0KPiArCQlkd2MzX2dhZGdldF9lbmFibGVfaXJxKGR3Yyk7DQo+ICsJCS8qIGNo
ZWNrIHBlbmRpbmcgZXZlbnRzICovDQo+ICsJCWlycV90ID0gZHdjM19jaGVja19ldmVudF9idWYo
ZHdjLT5ldl9idWYpOw0KPiArCQlpZiAoaXJxX3QgPT0gSVJRX1dBS0VfVEhSRUFEKQ0KPiArCQkJ
ZHdjM19wcm9jZXNzX2V2ZW50X2J1Zihkd2MtPmV2X2J1Zik7DQo+ICsJCXJldHVybiAwOw0KPiAr
CX0NCj4gKw0KPiAgCXJldCA9IF9fZHdjM19nYWRnZXRfc3RhcnQoZHdjKTsNCj4gIAlpZiAocmV0
IDwgMCkNCj4gIAkJZ290byBlcnIwOw0KPiAtLSANCj4gMi4zNC4xDQo+IA==

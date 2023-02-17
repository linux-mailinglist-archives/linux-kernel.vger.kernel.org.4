Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE269AF51
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBQPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBQPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:18:27 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1F627F9;
        Fri, 17 Feb 2023 07:18:25 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCpGCh018651;
        Fri, 17 Feb 2023 10:17:46 -0500
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ns8d03dt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 10:17:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSFNb5R+sh83vYEC9TA6RUsvpFG0fg4NvvRyKbAGol47ZE7LkEcb4EC3c5jPK0qQIFX8araVRxBgUMOhbuk3y/wPMoHGYDS9inzzjYAa4LC17lT96MeL7eyAbx2zorKpMXwz5dH0m4I/5IWnbtsdoBkWsa7HeT+almCaWR7jCAoymMUvjW8k/0lskqCNweDE9qqhKGd47mS8PinlwWXSwvA3EY/mK1N1/MXaT/aXD+D/5DvrmiXb2r9dQwTfkxWAQBZbCUmW522IRAodP/GJNzPgY80dqgSkUOWGjyce0TEfI+ddtwHin/BL0NxYQ+ZrWwnNC/tNu9Mxc/69rDPBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TChBTsr0EbeTpeRsYmT2vv4O1rU4+lAyIMctlW0qhxg=;
 b=GCu7PUWkpy6zTyMSKkABAKXFpgfLevTgO7A7RH7JGmphBvKYJoKMnkolo21KYJN02BKc7rguTY1QvJTNs2E0Tm5grFf6fLH1Zj6PWyU438vekia6IdZc9dPMrl+WT92i3Av3oyBoP11ZWDrEMJVudsHogD4UQUbK2lRFTLiwEZfnU88pxzE90gQtbIgD6WGj4ZRctzkGRABOLKkdFzHt5FgxEI7pii67wHDhhITNugUILfcGt2OLk1wqeaXOHa2ozTovkp5eKq1HeEpAOZ1AAXHUMx7sgfD5w5Lh7nzTaqNAGJJCe/dGyY9LNSb6MtrEfxf74SZ6cNjViGxLSWjfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TChBTsr0EbeTpeRsYmT2vv4O1rU4+lAyIMctlW0qhxg=;
 b=psxPoykHSgCOAiot00w5HAiq3bi+/qzzinXMaqCPQsEXiW+cnQvrwfDukiaPnfGOcSqeUnAdJsmYIbixA2YOiSD+KQ2qpzNFdco+LMyspQoUvmYfj4ihbmaoNuTl64NUuxNFQVTvk2jLLyJ2zLwRfpo4hCEjX57uMUl+3O1LVPE=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by PH0PR03MB7115.namprd03.prod.outlook.com (2603:10b6:510:290::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 15:17:39 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::4491:dc12:90b8:5a36]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::4491:dc12:90b8:5a36%7]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 15:17:39 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v3 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHY82zoMmUFCuabDUKYu/SMHPm8sq7PftWAgARO7TA=
Date:   Fri, 17 Feb 2023 15:17:39 +0000
Message-ID: <CY4PR03MB2488B54E722831F0375430CA96A19@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20221108122254.1185-1-Ibrahim.Tilki@analog.com>
 <20221108122254.1185-2-Ibrahim.Tilki@analog.com>
 <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
In-Reply-To: <68ddb833-f38e-a05b-82c4-ce12330410a5@alliedtelesis.co.nz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxUTTBNbUV4WVRZM0xXRmxaRFl0TVRGbFpDMDRaVGMy?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGd3pOREpoTVdFMk9DMWha?=
 =?utf-8?B?V1EyTFRFeFpXUXRPR1UzTmkwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpFMU5UQWlJSFE5SWpFek16SXhNVEl3TmpVMU5UWTVNalF6TXlJ?=
 =?utf-8?B?Z2FEMGlVWE5MV1hNd1kwZGthRTFaV21kbFRrMDVXRE01ZVZsQ1kzWk5QU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkRVbUprY2pJMGEweGFRV0Y1ZVhFclRY?=
 =?utf-8?B?ZDRReko0Y2t4TGNqUjZSRVZNWWtWRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZTY3pGblJsRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|PH0PR03MB7115:EE_
x-ms-office365-filtering-correlation-id: a6d87a9b-8d04-4016-f983-08db10fa1b72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nU1XTRsNOBAhHCiRcYMTjZR3RvSKblT15eC4ZzPTa77qKRhDPJWdUH6f+2OgF6HNipcTwL4Xkcre/aM88uelJCWrejTbG8OSxeATjvvpewJfYrLIUyNFfkeUFRUsSIwr61NHnHlrsLBWIzKT/F8zB/5OR7N9rEZdFQcxphNuTuqVPM4gZlYk3O21gZrULF2p0ZZbhNjGdZtnkYJNxwBECP+1MGooFNkZ7olfLYZeK4VZ2w5UgUzmUwmIwUlSmf3Ir1wJlYbhw+s6Q+aGXCRoiZ2BTtKHzZRzWPV++DHTf1SQoje4YR5HF9gDVqB4mSh7RovrparMBMrUhUAOYbTNPTwFg1Rhxagq4bEj0zdr5EpjFITQrhSFG0vPM7ObiiZX45LOLmZNmq89V6RkkoFSX6L4bYizCdcZzjwftgn5/nubogBMa1Re50CyVnusvuMluyndeNXmhP5mHjWlGLZ1D5ZPg9XZWXEF5fFjsBVBgt5O6Qo/C42P0dXrOg7GGB8X47YP7GQZLPRG3Cetr3o+upnFu9vLDyQZtmyl/HJ8EHpeYbGYD4qq+pzFwjThnmzMlngQuv4CQj3qtklosXx+2JM31GJRaSyusnFwVBQPx67wK1X3xBkQb3+DFKIi4DZel16amndybDvThQ9/gAchXSSFmlLS4BGt0hNinlaLybIWzM6vFhJ34/JD0tbBe2fKeAcTj8BlO5t1ikpjH8mR0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199018)(83380400001)(7696005)(122000001)(86362001)(33656002)(9686003)(6506007)(26005)(107886003)(186003)(53546011)(71200400001)(478600001)(55016003)(38100700002)(110136005)(8936002)(7416002)(52536014)(316002)(54906003)(2906002)(8676002)(41300700001)(4326008)(5660300002)(66476007)(38070700005)(66446008)(66946007)(66556008)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUY2eHpoMHdnUURHSWFhYmlWYnZmV1RQeTVHMFJDWVFMVzQ3SzZTWG1oRnJV?=
 =?utf-8?B?NW9TUTVoSWMyazMrNDJoUG0zZHpDeWZWQVFEYXVickpVbnhUcE4rR0VYUUg0?=
 =?utf-8?B?aityV0tYbDVjU2hvR0xSR0tCcE9aNUpFamphRmk1ZjhZVVVVSXVtMUdkOUV3?=
 =?utf-8?B?b3lhRlZMcGRMdlV5K3lRaDErci8yU2ZDTzFHN3c5WjZqcjlRZDNiYnBGVlVG?=
 =?utf-8?B?RHBFWHZSZE43dkdrQUx0TEpnY2Nkbk5BQlRncmdMbkdMaG9oaG9YbHMvM282?=
 =?utf-8?B?UGp2M3EvL2pxS0FDMjZzQngycEEzMytLSXBkQWEzVW01c1VnbW8renJJdTVE?=
 =?utf-8?B?UlRNdHhjSkdwc0F0YmU0c1Q4VEJhUTdxbWtDM0dXaXd1djYzaEJQUVRNUkhy?=
 =?utf-8?B?aVR3N1JwSk42aEExQW9zWlpJc28wSDRzRmFVMVpabnNWRDZwT2RPdnFjOCti?=
 =?utf-8?B?S1huZE9LWXJ4SlloaStjbm5FS29NVytSam81TUJvbW9WSWRaNVV4WWhRZTBI?=
 =?utf-8?B?cGlHVk0xUHpOejB5QmZpMUJqdnpmUE55allrVnNpVEZQV1l4MTA5dk1rREF5?=
 =?utf-8?B?S2c0TkVSMGdxYjc4bnFpNFRmMitzWXI3L1pHMVpBa1p5MWEzTHgvQWZJWCti?=
 =?utf-8?B?a0dkYzd2enQvV2lYamNDc2pnUXF2MEhIMENidElkMFJxK1Q0TG5udkFoSFNn?=
 =?utf-8?B?K3U4ZzhlNzczdml0d1JUdUZiT3c5TG5UbXBjNWk2QXQ2ek03dDhScDl3S080?=
 =?utf-8?B?blZsNkkwckJ4bTVkSWVVOGFPQ2JORjdtcU1Mbk02VjBEWm1WbHlHN3Jqb0hD?=
 =?utf-8?B?TE9DZmYrclZtVzNDMzhhbml5dGQ2anNab0FXZXdMZVlmbGUzS1k2TzJUNUR5?=
 =?utf-8?B?eTUwbXl1aVFIcWJJdVRoaGc4S3ZPblRlM1BJUlZUaXZWSmczN1JJNk5mSHd3?=
 =?utf-8?B?YUpYS1NoSWFrTUpocFpKZ2t5cHcyaWNxTjVmNEkwYVJjbCtHZ0tiQ2FzbzRK?=
 =?utf-8?B?Y3g5aU03Y3g0TFVadGVoWUwya09wTkV5Sk44RVlGdzY3elFZYk9Ja2pOQXlj?=
 =?utf-8?B?UVdSRXhFY1pBZHZSdUlyZjBJcWlSR2J1MUFlY0U1NTNUbmdUK2hvQnI5RG5T?=
 =?utf-8?B?bkptVUpvaE9kT0lnM25uOGROQ25EMGxJcGo1c3BGYzBRTkVKRjhiQ1B1UFhs?=
 =?utf-8?B?YldmRWtpTWFrZXkzWTRPVEFmYmprVGVYbkpqZVRQbCs3V2NjSGEwd3RmN2JC?=
 =?utf-8?B?ek1zWFhxNVZoa0ZObnZjRnkyRzRiMmVGZUhqY0l0d0JGTnJReFZPaG5tUmpn?=
 =?utf-8?B?OXd1L1I1ejBmT3hiVG9GMW5YUjRWYm1PYWNaby8vUnlYeHNVTnhoRi9XMHJl?=
 =?utf-8?B?QzlZNm5KbTBkZS9GTjFtQUtlY09ELzA0RUhwM3o0NWNrb2JsTlBRWEhURVNk?=
 =?utf-8?B?T2JKWmFZQ09vMkNkQmcwa3U4SG1QYUxDcUJrOCtzck82YTVGZ1F1ak0yb296?=
 =?utf-8?B?YXA1ekRmMjVLVmY1ZVhNMGd1cWFaeSsxQVI3RHRVV3VHM0trb21ISEZ6ZGdP?=
 =?utf-8?B?Mi81MnJqQ0p4RzQxRFYwMGZxWUpHUXZmN3kxRUh2cVJxQWgraGVnaUpzS3Z1?=
 =?utf-8?B?eU04NUtaWENIcUpTd3dnTnRHa3BXZjdvK2dZS2ExL0ZlZlhKQkZ4Ti9RNmI2?=
 =?utf-8?B?eTlESjJEa29Cdms0ZGR4cDRTdDFiUWkzNHNZVDMzWlNkdnVraTlqK3I3cVVV?=
 =?utf-8?B?dHNNZWh2L1RDWGVuZXpaaUZJSzFkcGVnbzc3Z2QwMmpZdVBxM2gyeWhSQ0Vw?=
 =?utf-8?B?U0MzeTNDMUc2NnJFalR1eGtMYlRWQ3o2OXJDTTFFY1hqc25MaGJTTXplZFpQ?=
 =?utf-8?B?TWJWRWg2aWs0M05RcWVWSDZianhGd0E5WERYbVQ3L0ErTHJnUS84Sld1RU03?=
 =?utf-8?B?WEdoVnZTSnVHUEQ3SnZUV3RhcS9ONzBFT09VbE02aXF2YWROeERZOENrWk1I?=
 =?utf-8?B?eGFnbi9NNlRvN1NTYjhFbkVWQXRuRGNJWTZ1ZXdULyszYUhja2QvMldSNkFo?=
 =?utf-8?B?TDd5dStNZHJQR0FCZDY1VTMvWjN5VmluSytkV3hOa1dkOE5SR1Y3amwyKzBM?=
 =?utf-8?Q?/1qnmRDQTWBw0Jnlg2s9j1Bqj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d87a9b-8d04-4016-f983-08db10fa1b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 15:17:39.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGhonTHXDVgzO/vfDQeNaFTupIWqBxpF2ee5g+RCZwv+6HPsOLcrudC32A8s/sFHLWF0dPBZ5AsZ6VxZ8Gmetn4wgBNfeBUqggI7OXybjvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7115
X-Proofpoint-ORIG-GUID: 1wnsx-rE-9ZWne3RnsKtm1VeqgXKg-oP
X-Proofpoint-GUID: 1wnsx-rE-9ZWne3RnsKtm1VeqgXKg-oP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170139
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBJYnJhaGltLA0KPiANCj4gT24gOS8xMS8yMiAwMToyMiwgSWJyYWhpbSBUaWxraSB3cm90
ZToNCj4gPiBBZGRpbmcgc3VwcG9ydCBmb3IgQW5hbG9nIERldmljZXMgTUFYMzEzWFggc2VyaWVz
IFJUQ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJYnJhaGltIFRpbGtpIDxJYnJhaGltLlRp
bGtpQGFuYWxvZy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmV5bmVwIEFyc2xhbmJlbnplciA8
WmV5bmVwLkFyc2xhbmJlbnplckBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9y
dGMvS2NvbmZpZyAgICAgICAgfCAgIDExICsNCj4gPiAgIGRyaXZlcnMvcnRjL01ha2VmaWxlICAg
ICAgIHwgICAgMSArDQo+ID4gICBkcml2ZXJzL3J0Yy9ydGMtbWF4MzEzeHguYyB8IDEwNzAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQs
IDEwODIgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcnRj
L3J0Yy1tYXgzMTN4eC5jDQo+IA0KPiBXaGF0IGlzIHRoZSBjdXJyZW50IHN0YXRlIG9mIHRoaXMg
d29yaz8gSSBzZWUgdGhlcmUgYXJlIHNvbWUgY29tbWVudHMgb24gDQo+IHRoaXMgdjMgaXRlcmF0
aW9uIGZyb20gbGF0ZSBsYXN0IHllYXIgYW5kIEkgY291bGRuJ3QgZmluZCBhbnkgbmV3ZXIgDQo+
IGl0ZXJhdGlvbiBvbiBhbnkgbWFpbGluZyBsaXN0LiBXZSd2ZSBnb3Qgc29tZSBuZXcgaGFyZHdh
cmUgYXJyaXZpbmcgc29vbiANCj4gdGhhdCB3aWxsIGhhdmUgdGhlIE1BWDMxMzMxIFJUQyBhbmQg
SSdtIGtlZW4gdG8gc2VlIHRoaXMgcGF0Y2ggc2VyaWVzIA0KPiBsYW5kLiBJcyB0aGVyZSBhbnl0
aGluZyBJIGNhbiBkbyB0byBoZWxwIGl0IGFsb25nPyBJIGNhbid0IGJlIHZlcnkgDQo+IHNwZWNp
ZmljIGFib3V0IHdoZW4gSSdsbCBzZWUgdGhlIG5ldyBoYXJkd2FyZSAod2hvIGNhbiB0aGVzZSBk
YXlzKSwgdGhlIA0KPiBsYXN0IHVwZGF0ZSB3YXMgImJvYXJkcyBhcmUgZHVlIGluIE1hcmNoIi4N
Cj4gDQo+IEZvciB0aGUgbWFpbnRhaW5lcnMgb24gdGhlIENjIGxpc3Qgb25jZSB0aGUgZHVzdCBz
ZXR0bGVzIGhvdyB3b3VsZCBJIGdldCANCj4gdGhpcyBzdXBwb3J0ZWQgaW4gYSBMVFMga2VybmVs
ICh3ZSdyZSBjdXJyZW50bHkgdXNpbmcgdGhlIDUuMTUgc2VyaWVzKT8gDQo+IE9yIGlzIHRvdGFs
bHkgb3V0IG9mIHRoZSBxdWVzdGlvbiBiZWNhdXNlIGl0J3Mgbm90IGp1c3QgYSBuZXcgZGV2aWNl
IGlkPw0KDQpIaSBDaHJpcywNCg0KUGF0Y2ggdjQgaXMgb24gdGhlIHdheSwgSSB3aWxsIGJlIHNl
bmRpbmcgaXQgaW4gYSBmZXcgd2Vla3MuDQpJdCBpcyBoYXJkIHRvIHRlbGwgd2hlbiBpdCBpcyBn
b2luZyB0byBsYW5kIGJ1dCBJIGV4cGVjdCB0byBiZSBtb3JlIHJlc3BvbnNpdmUNCnRvIHJldmll
d3MgYWZ0ZXIgcGF0Y2ggdjQuIA0KDQpJYnJhaGltDQo=

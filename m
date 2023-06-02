Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87ED720AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjFBVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjFBVQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:16:23 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034B5E45;
        Fri,  2 Jun 2023 14:16:21 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352JbgXs007401;
        Fri, 2 Jun 2023 14:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Uy0adevUVHypfcXSy7mqe5JgpSEcI0sPIq5gCMacw40=;
 b=JU5Cql6iK2BjRJvPgpdmU3vkFjVTlrKH48vCdiACCpyR4gpdd/Nxhg/RM7S7RT3QkB9v
 l92MIzINmk+fy1Lg4vaYLMjD6f3458Woel6JvK3KcDt574AVL2gbLtDRKhf4iO2YkHmm
 QRObIaK4MdBqzK+yZzzmv6Nr+PLXeFkPoc+D4n4vo5CjWeYNxqMUzSuwTWVIQdAZWkXF
 eOxct6shcO4Zu9dDlOJYdoRJnIVYq4evXmrINYp5lCwLn89apB5MrSSW6wpDw4ywBMIg
 LWBvO0K25ZtMU7yHFbPZ30sMghaNVzIvSyAykrVjdFRl7luy+EKhgVqbv7pxbtps4u1o Gw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3quggehjy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 14:16:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1685740573; bh=Uy0adevUVHypfcXSy7mqe5JgpSEcI0sPIq5gCMacw40=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q5qKCfH+1FLDnPM5BlGgZAfIQVVSfnQ408IOogsOUYHspwzXW5y5kyNT9RD4R2ab8
         VekKwRqAm2mPTOBNVESE4md+EGL2qC1jy480hZ/Yy9Cf1F9RLX0IhP6tJf3XhaUMse
         w0BqnebDc1Tp9XfHUaAlZvh4GYR+C0OzMJiOb+cmGO6Tr/MOXAYiZplSAEqmQVKe/M
         M1riSvVuWHpwHqHlr+X7O0HEfLPbkJH4fH2QLeWrxLgYzhY1e8E4POnzO9t9M6EfX6
         Lg9tl908BEekB6RgzejcjSNl96bM6hy/mXpA97C3zTOE71soejRbMbzIEsCGr37OaN
         ME/8hiSfKZDfw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 92C4F40132;
        Fri,  2 Jun 2023 21:16:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 63754A005C;
        Fri,  2 Jun 2023 21:16:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=YplmuaoN;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5562040123;
        Fri,  2 Jun 2023 21:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG6cDKUsng1bqeL0IcIq3SWwbta0daFIpJFuHspWRc6qU6Fn30ezAGGCcN4RqUqvd9e1AuGsbpJssYtNs6P700aEW+Ei9Kf9ciFfzvrTRjwfv/2eNay0KYuZhfSBWr0ILrA2mVKavExksHZJ9muk5iHPKyGPhdUY1rqGKn0AcpMczXEKEcz1qjtVZ2/ne6+lQ7Gr5Elraa+NEVoGby6nr7Q2tM3mk0PytbRLp9CSC7z14uOZgIypsaBGXy3IHycdoZnjQ4OELwEajvBRvqhJfO0JbgBbTpZ1TBvn0rm3Qrrt8ce8tlYHYF70qgMPWSvNJ/Hk2d/PHYqTpKOy7T6oWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy0adevUVHypfcXSy7mqe5JgpSEcI0sPIq5gCMacw40=;
 b=bD83v2wRyqaNYub8BhqaXhzxkth5Oxv1Pfx7/2LIG36EMgglspJyzzCDKERttN/j0OKpOLHXZjJ1xZZ4tDPq5oxH3vcpMCLFUwUqpdsx3d5Dw2p0DRpo2dKOWCNootsIN6CRJlopXcLaDKi8HIOjAVzf9atQZR/A7X8owsBANr94kT0m5I/ZC74SMCfGxogTEQtmx4Aw/4v6QCBNHy7kvJzl/Vq7zLMsxN9Ly99J7vVbSIc1EQEzC03LY1f/1uPuXlqF3GvoMaE1pCWG/apd9XKyNqJZsnUHkOVeo6huJFxepHOmMl4xZ712W8un6KgJCpO8TlEXS1+B8Cn3Wc2UxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy0adevUVHypfcXSy7mqe5JgpSEcI0sPIq5gCMacw40=;
 b=YplmuaoN2VvHAENHP89vnVsmbxi+g9G92O4VGqw/bmLdjIHJeRnS2qHqOPXsCgt6stWhRrIbxZXiwsLSGrask+NtLG+UeYIGPOZuE8Q2wzqesf+aNF3i8kwiE05vDVMJIaqHwI9KPJmUsitpBUNrjVE6h2UdP1XE9PCO8XgwISg=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 21:16:06 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::7a8:9367:70bf:2491]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::7a8:9367:70bf:2491%6]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 21:16:05 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Avichal Rakesh <arakesh@google.com>
CC:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
        "etalvala@google.com" <etalvala@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jchowdhary@google.com" <jchowdhary@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] usb: gadget: uvc: queue empty isoc requests if no
 video buffer is available
Thread-Topic: [PATCH v2] usb: gadget: uvc: queue empty isoc requests if no
 video buffer is available
Thread-Index: AQHZlZIpS/+IMAtb20WpXSvpNlDbnK94A7kA
Date:   Fri, 2 Jun 2023 21:16:05 +0000
Message-ID: <20230602211602.3b7rfa252wliiszp@synopsys.com>
References: <20230602151916.GH26944@pendragon.ideasonboard.com>
 <20230602203746.288881-1-arakesh@google.com>
In-Reply-To: <20230602203746.288881-1-arakesh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|CY8PR12MB9034:EE_
x-ms-office365-filtering-correlation-id: 8fe6dc8b-0224-46d8-57fc-08db63ae9362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJpJrCoCexll3dwy/SYEnpCsT1bYSIgYPwBICg0mvxxGaFwnzxpYr4l+7NVbz5ciZq8qppIM8gV2NHNZDA4ynhS9a5Zapx5fydxr2UZEY10ns8acQYXm8N8UAm5SA8OuQf+swz2RoF3uwOll/22ZaiptKTPOz1SsDQOXYQeCZaz21c7No+qHiv1E99TqEnpWme3vIkNTrcC+bf0kBQKL2QokmU6f6rflDjTLN7t2Z9qVYJlZlLZB31Z3x6qQJdkdHN2UJStryNdmLxUOZl7gqFA/V05P9VXY2EAsW8+nhxNYLrLZBYb9Ku8peJztl766dm1mdnvTPZexxWYpPuaKzlrgyVy+bgA4dFrFS4xTi/I7qQ9YFD1jKZgJ28k/Q2okbQwTI0dW+Ig49UvgBmnrkzScA3owKYgYxqs/1ERmbG6ESbYFMZyIpPuiE8i+Q4g1DR4DGaKKGcDBskgiBXbwAM4DLEetnh4RiWowaNRViuLri1i8AS+/9f4Q93/stfYHypDfn9NMmRmq7/QwDnGSAUCAZB4LCEqQ5KNW0TpcsNOyR3J4Zent1Tj7tPkB0Vh4iZsia5Ir26YParTahlPpEVWfKD3fFCEEJL5bp8n+gUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(478600001)(2616005)(6512007)(26005)(6506007)(36756003)(186003)(83380400001)(6486002)(1076003)(71200400001)(966005)(41300700001)(38100700002)(122000001)(6916009)(4326008)(64756008)(76116006)(66446008)(66946007)(66476007)(66556008)(316002)(86362001)(2906002)(38070700005)(5660300002)(8936002)(8676002)(54906003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1dWdnJBcEYvVytMTFlQT0ZXWWd1OVZaejZld0Urcyt4eWc4NUdYWWkzRWdl?=
 =?utf-8?B?Q0k1ei9GTzVZVlJ2ekRtVFlrYjFHMG51RmdoQkRlbnhhMzMzNWN5Z3FIZ0dB?=
 =?utf-8?B?VEd4MWgxSk9yTEs5VExCcWFrV0JjSWZ0Q1BCcjRLcVBPdU5pTzQ4dHEwaEVq?=
 =?utf-8?B?VUxRWm1uMk96dThjTmJGVmtRTVd3THVOL0RnVVM2bDk4SGpJTDlNdVcvQUxN?=
 =?utf-8?B?MkQxUlVQL1pRMk5vSmpsd1hRVVQxOWVNVHArY2VvNWRmTjlQQkNYOS9UMmdl?=
 =?utf-8?B?Y3o1WXYybmdza3I4a0tseFM3NDN1cWJxTmYwdlNhT0JFOWwraUt3VVBaVjFU?=
 =?utf-8?B?Y1NzZy9VTmxuRmdmTklIVFJiTDgzbUNvK3NSOEdGY2JuT1ExK01mSHVLYkky?=
 =?utf-8?B?cHc3UzRFOWFQeW4xd1RkUE1MRjFNTklKeU9TUCszVWZyc2c1YUJVUVNPY3Bh?=
 =?utf-8?B?RzhkK3RydjdOU2UyYWhLaTQzNTV6cmhBNnpqbXB1OHRsT1dFeHVXM3RPQ290?=
 =?utf-8?B?WUN4a0Uwc3k1YStCaFVVVm5nRmY3cTh1Y3I1WjR1WXNaci9ZQXJ2Q2VCeXRH?=
 =?utf-8?B?Rm5RWk56dlNoaDlJYkp4b3J2REhlZnFBbTc0YnB5bUtZaHVaOGh0QUVEOWkv?=
 =?utf-8?B?SExiRkxJVTNGR3l2NzBzcy9iSmtWUS9TOFZ1bkJ3NnB4RWwvbExIV1l0K0Yv?=
 =?utf-8?B?c2RhaGNLMW1GZFdaMzN1YXR6VzgvYjZRTjVyUHhtU1NwUW96V2owT0tmOTAv?=
 =?utf-8?B?bW9zWmRTS2xoYks3M2ZQR2FucmtxdmQ2OHVCUVJGbmZGTW9FZHhZMGVnRjc5?=
 =?utf-8?B?NkYrUzY4aWVGZVNpNGRoTFlqaTYrNDRseEdnWTZ4emh1T29vVi80UUR1VlhL?=
 =?utf-8?B?VWhLeEU1bjJveENBcWRyTFlhVTh3SFZla29yY2F4OCtBWUkxbTZWdVpaeDYw?=
 =?utf-8?B?cjQ0dHQrRG9wUWhiS0ZEOXRtenZiSVBVTlNXZE10bDBJTGNmdE9CTVNEWmli?=
 =?utf-8?B?dlFabXgyYmR0RHp6dllRRU1HSjRXc0ZWZGR6SVRWNFNGa3N3UWZOUWhJUXB3?=
 =?utf-8?B?ZEdnb01QVFB4aU96REtPeWhvNDdKWXR4TjI5NmU3LzlHRFIrNDkrQ3pRdFBj?=
 =?utf-8?B?WHZzd2RqVDdReEU3MHRVUk4wYWh3VVBvelJRUTBUUDRTVWg1c21BTUYrdVVn?=
 =?utf-8?B?bENjSjdkVjBsZWtISnkzVkQvQlA3V1ZNNG0zaGlVNXlPdEkwVCtaKzREdzhj?=
 =?utf-8?B?M1k3cnZXOTBlS3pPRWowVUY2bkVlUlZOcVJkV1JseGZCZmZJVXg3Zy96S1ho?=
 =?utf-8?B?Qm1mNFNidHlBdFVRUVBqbXpqNUYya1I2RSs5RjRPQUo5QklTeU9qRDBDTUhU?=
 =?utf-8?B?RDA0Qi80ajA3ZGdDZEdWM3N5U3BVR01PUDV4NzFBNzdRTWxvTkdZSGowaUtD?=
 =?utf-8?B?OGt2MmFEaWh0cVNNTi9xSUkzeHdkZ2xLWHFqSmFPV0NxRTZUVmlHNHVxV2J3?=
 =?utf-8?B?OU5tR0llaGZnbmJkYkNIQ0VPZGxTOFVOUmttcFd0TSs4Zm94dWhMNnVEM29w?=
 =?utf-8?B?UlRwUUY2cXJOOCttZ0ZjSXhhQSsyVTJzd01aYldwNy91RW9lYlNBS3NBMjYz?=
 =?utf-8?B?Nk5pVTFha2w3eERWeU9SeUQ3akIxd2xFWi9QTkNkTlZiQk1qbjhGbW56R3F3?=
 =?utf-8?B?NmduUEd0TklHOFc0MTZkMzcxV2N2YndHWGVaSHBPU3FmOHlaWnp1YlNYaC9o?=
 =?utf-8?B?ZWlueG9qampKd21JdHd5VHFoK2lzL0hxU3U3dnQ3bExyWWJ0RUd4OWhIWHVV?=
 =?utf-8?B?WmZKR3hhZ2hmdmFFUXBNTTUvREhDZk1IT2JJWjNITE1wMExrUnN5SzRIRkRq?=
 =?utf-8?B?SHBqNlVXUTliNjg0UzJNaW1XS3pRUFZ4UjJkcGJoOXdnRGRkSEZEb2lNY2tV?=
 =?utf-8?B?NGErb0tXQTNWbm90d3dPbnBQa2Uyb0tNZFNTWnRCczU4SE9qbkEybzRyV2N6?=
 =?utf-8?B?bFRqWVp0ektGNHBpQ2dHVG42RXNlalYrVWkrbUVaUnBwMHl1dk40QVJWQ20x?=
 =?utf-8?B?TjdQUTVmUXVNQWdVVmJib00xTnBldHJTTFFNWVNBelk3U1BINXlKcS8xMFc0?=
 =?utf-8?Q?Q3J3obiOsxkDdRxR405gFRj4n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <388C5A193C74DF498294D5551B69BAD3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVNZenlicjYyQ0c5ZVpTMENiNVZNL1V2N2xqVU1UZXFzeGZxbzJOTnR3c3VB?=
 =?utf-8?B?VVkwem9nTDR4eFJoWVJsZ3U1U00wbEJyT1ZPaDBQMXdZMVR1K09peEtMOXFt?=
 =?utf-8?B?ZU1hTmxVYkduUjhGUjkvTW1DNEZrMGZVQ1licUoxb1VtbGpKUHJ5MmUxYkpq?=
 =?utf-8?B?SERwL2NSUGNEWmlCU1VjQzMzR1NjY1VVNlBsRUJFb1RHR0QwTUtpUzg2YUlo?=
 =?utf-8?B?d250cVM2Y2JDc1RBanJtM1ZRSzNPM1F1NzdCUmpOYkgxa3RNNHQyT211U2lH?=
 =?utf-8?B?ZVR1aTkvK3Y2dkNWb1VqMkxycXpGMjNlVEJPZzRGRkdnMzB5Wm9ENmtDaTY2?=
 =?utf-8?B?alRTRnhKd1VabTM3REFZQzJCYXIycjZma1R3OUMzVzlYVnNoZnhIMFZLNUVU?=
 =?utf-8?B?bE9SZGxKU292Q21iMlVoZ3F5aFF3YkxpQVNobkRKRVEydzVVcFdLT2NwaWo0?=
 =?utf-8?B?cEtpbUlrbEwwVFB0OXcvSURiVUowVVozWWVzb2pLR2NRbVNsTmIvbXpSeTkv?=
 =?utf-8?B?QXczcU9BbTQrUjduSEQxY1k4Z1lxZ2VkdkRyR0hoREg2TU1KZHdaVm8xbXFI?=
 =?utf-8?B?cUg5KzViR0llTmFERnNmTnM1UEpzMXVPZU0xZXlIUHcxRzlMSWRGN0NXZjha?=
 =?utf-8?B?M1dteXFwYks5RGZ6U2l4TnJFWHhQMU5EN3BmZ05pYmdBbmF2QUJwMGtlcTc2?=
 =?utf-8?B?MittbzhscElMMjhpQytwSHhJSmJFeTVSZWlobzJzejRnOXZjSVZjQ2hhajhT?=
 =?utf-8?B?V2NMYnVJVDQ1a2h4VGNNSWR0NFJuYVB0Q2x6c25tMTNBcVFrci9yUEo3MFVP?=
 =?utf-8?B?K1ZISjZxaVRTWlQ0SWZEZkdCcHo0UGo5UFlxOXU3aGh5NUZvMkVjdzBTUVZo?=
 =?utf-8?B?dy8yMkd2YkQ2eXZRMXk5RWQyN3JjN04yUlp3b3RoRTRIZWNZZjZBTzJuOFZs?=
 =?utf-8?B?UzhiVHBaTHp1Ymp5MHBMbDVuWS9VbEJCb05QVEp2cFdFVWNSZHJYUEFkYlhn?=
 =?utf-8?B?UWFyQnFQOXlSVU1CVHpoOXExczhxblI1VHl4VEtBcHZoRTdGZGE0ZFhBNnVK?=
 =?utf-8?B?a2JvdVFVUG82NGZ5Q3JlWE1ZWHlvUGhsbjJEYkJBMXV4VWJXRmJyUXBZQ3h1?=
 =?utf-8?B?N2pGUnpKY2FHWTJ1ZjR0ZitERVFSZjQ2em90S05jNnpRajB5YkNKTm5TTmJN?=
 =?utf-8?B?ck5ETWo5R3NyZy9SdUdLNUZXQ1dVejVPTjlGVFVYWlZFTEdiWS9Eb1AwM3hG?=
 =?utf-8?B?Y3FzOHdBRVBnOEs2NytMcDlKaVpHODVHdGl2TkNvV3Bzb0tHaHN3Z1FyaGIw?=
 =?utf-8?Q?qUUqBkNK8mD9Q=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe6dc8b-0224-46d8-57fc-08db63ae9362
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 21:16:05.0714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhyrG1kXmPdIVYSDksceES5/cWe3UWbjYwvUeU71av/Wx/M1vBmzPivtju/cXYkqcrK8VnMjrYYFqusPnhTouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
X-Proofpoint-GUID: Z9OXSV_DEzt1qax2mSI6GLvaB7VKgRJL
X-Proofpoint-ORIG-GUID: Z9OXSV_DEzt1qax2mSI6GLvaB7VKgRJL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=579 bulkscore=0 clxscore=1011 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306020165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIEZyaSwgSnVuIDAyLCAyMDIzLCBBdmljaGFsIFJha2VzaCB3cm90ZToNCj4gSVNP
QyB0cmFuc2ZlcnMgZXhwZWN0IGEgY2VydGFpbiBjYWRlbmNlIG9mIHJlcXVlc3RzIGJlaW5nIHF1
ZXVlZC4gTm90DQo+IGtlZXBpbmcgdXAgd2l0aCB0aGUgZXhwZWN0ZWQgcmF0ZSBvZiByZXF1ZXN0
cyByZXN1bHRzIGluIG1pc3NlZCBJU09DDQo+IHRyYW5zZmVycyAoRVhERVYpLiBUaGUgYXBwbGlj
YXRpb24gbGF5ZXIgaXMgbm90IHJlcXVpcmVkIHRvIHByb2R1Y2UgdmlkZW8NCj4gZnJhbWVzIHRv
IG1hdGNoIHRoaXMgZXhwZWN0YXRpb24sIHNvIHV2YyBnYWRnZXQgZHJpdmVyIG11c3Qgbm90IHJl
bHkNCj4gb24gZGF0YSBmcm9tIGFwcGxpY2F0aW9uIGxheWVyIHRvIG1haW50YWluIHRoZSBJU09D
IGNhZGVuY2UuDQo+IA0KPiBDdXJyZW50bHksIHV2YyBnYWRnZXQgZHJpdmVyIHdhaXRzIGZvciBu
ZXcgdmlkZW8gYnVmZmVyIHRvIGJlY29tZSBhdmFpbGFibGUNCj4gYmVmb3JlIHF1ZXVpbmcgdXAg
dXNiIHJlcXVlc3RzLiBXaXRoIHRoaXMgcGF0Y2ggdGhlIGdhZGdldCBkcml2ZXIgcXVldWVzIHVw
DQo+IDAgbGVuZ3RoIHVzYiByZXF1ZXN0cyB3aGVuZXZlciB0aGVyZSBhcmUgbm8gdmlkZW8gYnVm
ZmVycyBhdmFpbGFibGUuIFRoZQ0KPiBVU0IgY29udHJvbGxlcidzIGNvbXBsZXRlIGNhbGxiYWNr
IGlzIHVzZWQgYXMgdGhlIGxpbWl0ZXIgZm9yIGhvdyBxdWlja2x5DQo+IHRoZSAwIGxlbmd0aCBw
YWNrZXRzIHdpbGwgYmUgcXVldWVkLiBWaWRlbyBidWZmZXJzIGFyZSBzdGlsbCBxdWV1ZWQgYXMN
Cj4gc29vbiBhcyB0aGV5IGJlY29tZSBhdmFpbGFibGUuDQo+IA0KPiBMaW5rOiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvQ0FNSGY0V0tiaTZLQlBR
enRqOUZBNGtQdkVTYzFmVktyQzhHNzMtY3M2dFRlUWJ5OT13QG1haWwuZ21haWwuY29tL19fOyEh
QTRGMlI5R19wZyFlN0E2OHVVUlRoSDJlOExuTHliZnRCeFpXYVVWbDVld1dmR2wxd0lEVXFBdlZR
d1dpX0tFMnJPVVpGb0RmX19wcTA1cFgzSlhDM2lHWWlRalNJbmskIA0KPiBTaWduZWQtb2ZmLWJ5
OiBBdmljaGFsIFJha2VzaCA8YXJha2VzaEBnb29nbGUuY29tPg0KPiAtLS0NCj4gQ2hhbmdlbG9n
Og0KPiB2MjoNCj4gICAtIFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UgdG8gbWFrZSBpdCBjbGVhciB0
aGF0IHVzZXJzcGFjZSBhcHBsaWNhdGlvbiBpcyBub3QNCj4gICAgIHJlcXVpcmVkIHRvIG1hdGNo
IHRoZSBJU09DIHJhdGUuDQo+ICAgLSBTdHlsaW5nIGFuZCBjb21tZW50IHJldmlzaW9uIGJhc2Vk
IG9uIHJldmlldw0KPiANCg0KDQpCVFcsIHlvdXIgcHJldmlvdXMgdmVyc2lvbiBpcyBhbHJlYWR5
IGluIEdyZWcncyB1c2ItbmV4dCBicmFuY2guIEFueSBuZXcNCmNoYW5nZSBzaG91bGQgYmUgcmVi
YXNlZCBvbiBoaXMgdXNiLW5leHQuDQoNClRoYW5rcywNClRoaW5oDQo=

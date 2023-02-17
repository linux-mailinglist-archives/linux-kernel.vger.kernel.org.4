Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E5A69A3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjBQCDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:03:13 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855C498AC;
        Thu, 16 Feb 2023 18:03:11 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GMOlCa021935;
        Thu, 16 Feb 2023 18:02:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=CPRrN6xlrNyqnp2oqHcFVmMi8PwFp23WZ84nImDoC5U=;
 b=TM3p+1ak0PLH3tNoArw3mRVjuqp40WkFP0ORHXhnyIXkM+HcmGRPZjHH9xobsshJb0/w
 e7bSQDgLCxZ05vC2woUqeuqvxs6WkpPipe+3qh5esjUMTW+3OAtfUmFZl3x0GcNQQuca
 ubh2NC7IWhAAS2sHNUMBQBxJY9Raoa+R03+yt6zKjI3MB9PMIx2LmOXgxOzkCBXOB3rn
 g1gRMueS9J7JwdsfubeLhf+DK9Xd5YacGTFd5GdsRXGgNixq5CJUAqkILRPlWzo0ctfN
 6p9LVkkz2JmLLSRNURiJJ3Ho6/IxZwEJVzo04YB9X4jDthfvOc7RLxeifR6bjswthHJr fA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3npawurpdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 18:02:49 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3833BC00F4;
        Fri, 17 Feb 2023 02:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1676599367; bh=CPRrN6xlrNyqnp2oqHcFVmMi8PwFp23WZ84nImDoC5U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PScX1sHnlr9mM7usKMYZndsWDTl9MqtrA2wgDDPBqRotmS4bkHmFy/0cpVH9XP9be
         cTMJHt4jzKYrzln5rQuwEJG5SPIg4g/oWii4HVHJzKhgPIz2TV5Bff5YVpQ+xwfq2D
         qP9yz5XM1wh2E/Oivv35nmS0NC3hxYQMLkxZM6Tu3nuBzbC/bnva5zLnpsvTmEBRqA
         /Fr5G7sZrV8kjcOCTI6akef5M7ayXhEMVc5dv1k8gAj+karcce9OxtCiKeLSPss/Xf
         Y8McyHHA8yCW0NbqMwtmcDFW7CtaoJPob5PFr7ALt817wYN3S9CKuOophEF70nNDCn
         t1zLEBaKRj2rw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B59C6A00A4;
        Fri, 17 Feb 2023 02:02:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 88B73800C4;
        Fri, 17 Feb 2023 02:02:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VtkDPYmR";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWKC34y0v5OUzRJxu9Vqrf5REvX7IVMl8SOjttlF1fLfw1wY5+wrLgrASs1GQVmiRu9gTVFOZAO6tlqocAWrhoxTey5VLlqTGUbjghNUZskUWHr2EP8qR6qpblE6seTTGJquKgnn6ktSWMb+skDKOTDr3T5aL1BNJ3Palm3rJaYUscSvZ4V8xTKW8jcr6osBc3f1aNoN2VdEhTVUl0GuzFOx7AtMRwqtxgN54UBtf0zJVaQP1fJdRsyyeKkTUm+OE9ABxhSxZsP2ACt/+JMpytZIFzrupSWnfUyAbOQXg5U6r27IGJBltQK97kKL/FleuN5ei9+3G9DzY99igsv59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPRrN6xlrNyqnp2oqHcFVmMi8PwFp23WZ84nImDoC5U=;
 b=hp72K4NubMeXpesKF81XjwDhwhNzjXbdxOYyfAuPKd4KosG+p2P86ud0TpjAIM3en5cyfD/NZ7t/M1jKuwrHRh1uz7AdNKiZyuMPxXO0HMJJE4UXjogb3ZN/+opC2+ClzjMrFRsOO/oQzZDLrdiFfuKGDAREJxfQvcqk4gSRWOtVH6aBbmlxzYqA8ZVyM6ATFVwkUVrtVAIJ62VAGlh2Waw8KZyJxFyA3FO1zQTqLq9/WE3pdjBxjr9uegskrXtGX3belT9EyUL2ED5nvgLjleMTcyqlL0mU8lyz/pNTCFHoaKQKceJG949iRkWCCg/Bxx69oZrjutTf/oLX0CyCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPRrN6xlrNyqnp2oqHcFVmMi8PwFp23WZ84nImDoC5U=;
 b=VtkDPYmRTSZfC01BVvUuUKwLtJ7CIJSf9pTewZLUUWtNte7Cq0SWZZrUD8qpOSQHbiNNYugIuQy9ojzPmVmkHm9pE1kk5OtmH1LpXoEOyUNPm6h15xY2gZhMzu47SckMwx0SveRLf2mB5qnQjwrVUyLN3AS6pKoZQvC88dQOjeg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 02:02:43 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6086.021; Fri, 17 Feb 2023
 02:02:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v5 3/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH v5 3/5] usb: gadget: Add function wakeup support
Thread-Index: AQHZQlY4XOoXRUKvaEeTokZYNCs0ja7SQFGAgAALSwCAABeDgA==
Date:   Fri, 17 Feb 2023 02:02:42 +0000
Message-ID: <20230217020233.ptta6otn6f77chn4@synopsys.com>
References: <1676586588-25989-1-git-send-email-quic_eserrao@quicinc.com>
 <1676586588-25989-4-git-send-email-quic_eserrao@quicinc.com>
 <20230216235759.ylqsrsyp3tpppmef@synopsys.com>
 <96bbacbc-35d5-b8a4-938b-53259dcc03a7@quicinc.com>
In-Reply-To: <96bbacbc-35d5-b8a4-938b-53259dcc03a7@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7635:EE_
x-ms-office365-filtering-correlation-id: 86b4c026-0f37-4f59-10e4-08db108b0e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxAWijcaPlEvvZVqupMBrVZA0CXAjvsOcL81mfFmxteB2/y1JRsQZiHBWLCNR7Fl4ZjKT0zxqxqLKjexcoDyBcF+kjG4beZoRhlvMGdKgKvYpgR289KgbhSvsxEEksWJDu/sNai6OoY+Bm/uGQZ5TjvgJajpB9G9zF3IslXhZ88ZmYKwtwOuSfWxz/asK06IgxErVXG57h3YXg604TTSFx4iK9GggLPEVFxMuauxOfLcTgUI8j48DvWIUjWp5Nym3Vpapas0SgOi+66J9YARp6cpcuPkSmYMaUca8EYI5hp4FLKL4x7Ektu/OvUT8/Gtfk36233881X5IAdA8LWo72OMYSFNPJt+eDH/NBXnfgdkhBYKOxmQbnTonloJuY+6hz5zmFFY4iNvnDvfWmCRCUTEXtuGN6M8Kq0sRtoA4BiRk8j0q1vy26lLhE2/T7Dj2DpvLI9MQ+x0WUaR01HKl5vyrXJU1CaXM9Mc+R5dogQ1ffX82qDDG6k9IUkWGT75/YBUBcF8zYy3JBI5gdBUikbRsu0G5wHoZz3QDFgernagm7fZIB6QxCF00GsnJtZVZ0rVGXy8IDeFLz9lFdQgb5TNtWUV2yVMJhDsMj9EqfRYTNFd+m1a4yuuJW5PRXoUKEGDRtM7pbZaSB02UlFDizyOw3oAvvlVRY344X/RIs/CupScXoT5c2lla3IxZaAcIbo+Mp0zIXm+lH8vqf1tqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(54906003)(66446008)(4326008)(6916009)(64756008)(6486002)(8676002)(66556008)(76116006)(478600001)(66946007)(316002)(53546011)(86362001)(36756003)(66476007)(6506007)(38070700005)(71200400001)(2616005)(26005)(122000001)(186003)(6512007)(1076003)(83380400001)(41300700001)(8936002)(2906002)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE5YckpTQmxJeklKemdVVmdrVy9UM1RlTHFkU0lEd045aXFFQUxNcmVmYUNF?=
 =?utf-8?B?WURzS1NKU3RSNDBCSXMvOGxyemJTaWlsSGRWV0pOcFgrTS9tZ1l3YlpPVWNX?=
 =?utf-8?B?WStMUFZFdU5pYmE3OUlsN1FaaHlsQVZ0elJ6YVpONEYydytWSUlmL1ZQQmE3?=
 =?utf-8?B?dElPUzg5NmZGZTRCc0UybjNGU2hWN01kUDBDb3VMYkJYTm16anFRRUFpOUNM?=
 =?utf-8?B?STFLaHBvRk81cjFtd2NoVm5vUFhGb2FpR05iZEZPV3VkN0w5K256aG51cWpK?=
 =?utf-8?B?RVBLdzlGVlZDbGxnS0hidjZuNlJkeUR4RUZHMW1tSDJNUXBmblRkdysvMlB2?=
 =?utf-8?B?WTQrQW5Qc0tIQ1RLSUY0SWg2clE0WGRZbHdXcWZkU05jRFVybk9ub3Z4NlFp?=
 =?utf-8?B?eVp3TUhCVDg5dTVqU1UzMy9BczlobXNxYkhlM0J4d0oxQXkxcFR4SFR6YUhG?=
 =?utf-8?B?eEw3TmRCMldLb3RjN3FKUGJMdHYvL3hRS0tGeFRQME1vcHFXY2lqR3BaUHQv?=
 =?utf-8?B?TEMwVVk4K0h5SFF4QWpwaDBVbm52OWpteVI5WnBvRkpFaktRZ2lmKzNQV3RS?=
 =?utf-8?B?TEVMVWFsOW5MWDAwWkErb3pjdzliOHplYUwzQ1pLc2tFQXVka0NEVlJIRGZu?=
 =?utf-8?B?S1FFbEcvMjdPNzROQ3RVSSsweHBWYnYrZE81MGc1dXRpbDhkMW9wNE5sdVdN?=
 =?utf-8?B?Q0Q3cXhSYXhEeFdvYlZMTkE3Wk91UWhlUDZsbmIwZU1nbVVuWGFJRm84VSsr?=
 =?utf-8?B?eFRsd0J3OFVwWldFRGxTWGo4S0N3aG9Jb0VNNWNlK0U0alZJRUJLbGcyblFX?=
 =?utf-8?B?bUthL1Y0ei9WcXc3eldQMnRyUEd3RXM0Y21lZGQyc2tRWDBKUDE4T0hHVVJz?=
 =?utf-8?B?ODY0aXlEZS8vZlpYd1VvZzhpSTVLc1k5RFBWM1NxN1NpZlpPSlZWeEZoOElD?=
 =?utf-8?B?R2Y0TWo1YnhRK3pGWUt5M2R6VFEwbmFzSHZjRTUzcjA5em1uOGtQbS9oWFBQ?=
 =?utf-8?B?ZWNWaXBaVW5oS1BFRUZFcVRuYXRXYzNSZzNZZXJJTCtKYzRXdjFhMC93Rm4y?=
 =?utf-8?B?WjN2K1kxcjZEMmdnV2pDMnJMTytUZjJZOTdWWVZlbHVFN1pnTWFrUFk4UnZt?=
 =?utf-8?B?Z0wwQ1BvSTVPTUxTc2c1WmJXbDFvMzVJNEJTZ3BRZW10b0dqblYrU3ZjNWhL?=
 =?utf-8?B?TnQ3UmxsaXhhbDNkdnVGRG4xQVpSQTNFRDMzSWZnb2NFRG1VZnVTZGcwTEZZ?=
 =?utf-8?B?K1hBTGRsMXA2Vnd0Y0pEaFM5WW13K0FhakFIM25YcnlYMXBES2hKdnpTWHRV?=
 =?utf-8?B?ejQxV3hCdU5KK3N4dHFVTFVxU2lUTVY0VDFVUWEzM3Q0ejBmbUZSNHJUN3hM?=
 =?utf-8?B?R2lIV3BlN3cwaUphOHA1a3I0S3g3ZFAxblZJWHJURHNEQ2xMd3dMbkk3M05I?=
 =?utf-8?B?OEhBdTE3aUNMZ3ZRWTVydEJYT1YwTzA5K1Z4RUVPdnpsSlMySGU0UFRtdnlx?=
 =?utf-8?B?M0VqSWo5bzFNWnVGNlg5enRTcWdrWVk4TTd5SUl6ZVUrak80emk2S3dacENY?=
 =?utf-8?B?cUJ0dWorT25RZTdwUXJuNVZnb04yQ3g0SGIwcFpNZDFzR0R3eGVaeEFqK2M5?=
 =?utf-8?B?ZFM3VXRrdFRpUFQ3TVhoUkJFSFBaYjJkWGg5WnluZ0h2NXBCR3dIRlNpZ1lN?=
 =?utf-8?B?Zm9OTEp1UHhiRld3TnRrSmluYy9LNDhaNTEyS1Y2RUtNcjhvK3JBNU1yWCtP?=
 =?utf-8?B?OEg3RXpYZTUydU1sejFBK25acVQ0cHBRK0Nzdll4WlNzcVQ0Z2IzUFIyb3BF?=
 =?utf-8?B?b0pCMkJxZXJNYklnb1VFVHJ4bTZKR3VWZ2JFZWRDWTJvWDJrazRONXJDRXRr?=
 =?utf-8?B?QUpLbmRVeDFwZng4S0Zlc3pxa3I0MllKQjBXMWRUZk1hM3BXNGhGTDh2Ty81?=
 =?utf-8?B?d3F0eDVTZDAwU0krSUtOSnNVcjk1VHFyMzdhY0FWSkNjM1BWajV6UEpXckNs?=
 =?utf-8?B?eEpha1Z3NHNtMm95aUZFRk55TEI3SU5NU3IvWkxRY1YwclpxamIyRVdEeU92?=
 =?utf-8?B?dW1vK0lmNkpReC9SbmlBSUQvR2t4WmJncWU5cDlzU29SUzZRWTIzcElsaFZ1?=
 =?utf-8?B?TGNEUXlyeDUwV21LNy9heXpidnE4eGVMV0t3d3RUOVdJSmR4cG43U1o1YUJz?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <759AF6A4264E0E41935F6767CB98E93B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xs23NvxsY2YTJgh93L+zugA/NfCul8SobVbfilzEFNIuIoGlEY1JYrBenV61cm6xB6V3kJknLQ98mqSfBrn7U52A8QivoQn3kEPhdSNuBIuDgsHH9pXbsIG3HSBjXWD9+Xlo+AYSbwI0jH9O8Bs7aR35pIyBJUjPcWSbIfsegnH5XOdhMYAoWwrGUfvgzfj5WTp+YNqQQ5go2FLbYn1CRwSo/BZgOZ3Cjf+J/F4MlEHEXdywUgIW5K6Z/+73s8JNw4lcBn0rOTv0OZa59yXZZaA0I9pIbmCWRxKTXragEEqeG7TlZvIOGcjcn6zlBt7Btdsnh/vXLzUDPIV2DEFGJfYuhikH57XBurUUaTku0WPVB0YSOswLgrLfZ2JPKk7cNZAjqmnMuO4D3698a5pKXN2d8xcW7gvdzOjhF7XVrj/eL70dQ2dkQTqhFTmT0ab7A2ppx5g859KhnYDOsosuur/KA1zNtTF5S2bc9jpk0G7ZuqrNm0sf7g83Ewp4a9Xd8so9O219IXFG078APjenj58BS+ZOL1BWzUS7pSrsjIDjMtFw3Rb3xwD582MW5zR8qJJgmh4FJUPdTNONWQ5XJWj3r8Q7URmAXlgr8FJ5bkacYh5s5Qh80PtEM6BPq7NRQ1cwSAiG3c+EW3cdjN9qWwDcR4xvACafTRrWP3OHkZeDi4Fy5hSvRS205TDox7adS2gQdU7uuZJb8L+DDt6IZ4fOsSyFkFLnowjJ02Ga5N61bzC+Z31LLgofHp5mhxbD/vNbLppRF/kvW7x1YcZx2qwsvoDcV41ZEmLYb8FIp2npigjjq9ZvnZS7im53DTzrlPZtUieI1tBZSGm4SRr8+vNBV5rGsiXeKIqqThQtjUAsE8QrkJhU/LCY5us6N2CIUXy3I0EDbfqyCtZmOJFalNdyu853EZEx/NolwGZsLCw=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b4c026-0f37-4f59-10e4-08db108b0e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 02:02:43.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPihJFjjsJvfEWnqXmGnEOanhxTks3tjFFZLuRNFObT00HxKYR4+5kxpheW8o99UXb5GpMSr9If8EmNlZtgNhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
X-Proofpoint-ORIG-GUID: aNcUPVDgLfE6MsE98L57d9ww3ROoaAN4
X-Proofpoint-GUID: aNcUPVDgLfE6MsE98L57d9ww3ROoaAN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_18,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=649 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMTYsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAy
LzE2LzIwMjMgMzo1OCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRodSwgRmViIDE2
LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gQSBmdW5jdGlvbiB3aGljaCBp
cyBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGhhcyB0byBzZW5kIGENCj4gPiA+IGZ1bmN0aW9u
IHdha2Ugbm90aWZpY2F0aW9uIHRvIHRoZSBob3N0IGluIGNhc2UgaXQgbmVlZHMgdG8NCj4gPiA+
IGV4aXQgZnJvbSB0aGlzIHN0YXRlIGFuZCByZXN1bWUgZGF0YSB0cmFuc2Zlci4gQWRkIHN1cHBv
cnQgdG8NCj4gPiA+IGhhbmRsZSBzdWNoIHJlcXVlc3RzIGJ5IGV4cG9zaW5nIGEgbmV3IGdhZGdl
dCBvcC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVp
Y19lc2VycmFvQHF1aWNpbmMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2dh
ZGdldC9jb21wb3NpdGUuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gICBk
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYyAgfCAyMSArKysrKysrKysrKysrKysrKysrKysN
Cj4gPiA+ICAgaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmggIHwgIDYgKysrKysrDQo+ID4g
PiAgIGluY2x1ZGUvbGludXgvdXNiL2dhZGdldC5oICAgICB8ICA0ICsrKysNCj4gPiA+ICAgNCBm
aWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29t
cG9zaXRlLmMNCj4gPiA+IGluZGV4IGEzN2E4ZjQuLmY2NDlmOTk3IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Vz
Yi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gPiA+IEBAIC00OTIsNiArNDkyLDMwIEBAIGludCB1c2Jf
aW50ZXJmYWNlX2lkKHN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqY29uZmlnLA0KPiA+ID4gICB9
DQo+ID4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHVzYl9pbnRlcmZhY2VfaWQpOw0KPiA+ID4gK2lu
dCB1c2JfZnVuY193YWtldXAoc3RydWN0IHVzYl9mdW5jdGlvbiAqZnVuYykNCj4gPiA+ICt7DQo+
ID4gPiArCWludCByZXQsIGlkOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIWZ1bmMtPmZ1bmNfd2Fr
ZXVwX2FybWVkKSB7DQo+ID4gPiArCQlFUlJPUihmdW5jLT5jb25maWctPmNkZXYsICJub3QgYXJt
ZWQgZm9yIGZ1bmMgcmVtb3RlIHdha2V1cFxuIik7DQo+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlmb3IgKGlkID0gMDsgaWQgPCBNQVhfQ09ORklH
X0lOVEVSRkFDRVM7IGlkKyspDQo+ID4gPiArCQlpZiAoZnVuYy0+Y29uZmlnLT5pbnRlcmZhY2Vb
aWRdID09IGZ1bmMpDQo+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiArDQo+ID4gPiArCWlmIChpZCA9
PSBNQVhfQ09ORklHX0lOVEVSRkFDRVMpIHsNCj4gPiA+ICsJCUVSUk9SKGZ1bmMtPmNvbmZpZy0+
Y2RldiwgIkludmFsaWQgZnVuY3Rpb25cbiIpOw0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJcmV0ID0gdXNiX2dhZGdldF9mdW5jX3dha2V1cChm
dW5jLT5jb25maWctPmNkZXYtPmdhZGdldCwgaWQpOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4g
cmV0Ow0KPiA+ID4gK30NCj4gPiA+ICtFWFBPUlRfU1lNQk9MX0dQTCh1c2JfZnVuY193YWtldXAp
Ow0KPiA+ID4gKw0KPiA+ID4gICBzdGF0aWMgdTggZW5jb2RlX2JNYXhQb3dlcihlbnVtIHVzYl9k
ZXZpY2Vfc3BlZWQgc3BlZWQsDQo+ID4gPiAgIAkJc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpj
KQ0KPiA+ID4gICB7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9j
b3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiA+ID4gaW5kZXggM2RjYmJh
Ny4uNTllN2E3ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29y
ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiA+ID4gQEAg
LTg0Niw2ICs4NDYsMjcgQEAgaW50IHVzYl9nYWRnZXRfYWN0aXZhdGUoc3RydWN0IHVzYl9nYWRn
ZXQgKmdhZGdldCkNCj4gPiA+ICAgfQ0KPiA+ID4gICBFWFBPUlRfU1lNQk9MX0dQTCh1c2JfZ2Fk
Z2V0X2FjdGl2YXRlKTsNCj4gPiA+ICsvKioNCj4gPiA+ICsgKiB1c2JfZ2FkZ2V0X2Z1bmNfd2Fr
ZXVwIC0gc2VuZHMgZnVuY3Rpb24gd2FrZSBub3RpZmljYXRpb24gdG8gdGhlIGhvc3QuDQo+ID4g
PiArICogQGdhZGdldDogY29udHJvbGxlciB1c2VkIHRvIHdha2UgdXAgdGhlIGhvc3QNCj4gPiA+
ICsgKiBAaW50ZXJmYWNlX2lkOiBpbnRlcmZhY2Ugb24gd2hpY2ggZnVuY3Rpb24gd2FrZSBub3Rp
ZmljYXRpb24gaXMgc2VudC4NCj4gPiANCj4gPiBEZXZpY2Ugbm90aWZpY2F0aW9uIGlzIG9ubHkg
YXBwbGljYWJsZSBmb3IgZVNTIGRldmljZXMuIFdoYXQgd2lsbCBoYXBwZW4NCj4gPiBpZiB0aGUg
ZGV2aWNlIGlzIG9wZXJhdGluZyBpbiBsb3dlciBzcGVlZCBhbmQgdGhlIGRyaXZlciBjYWxscyB0
aGlzDQo+ID4gZnVuY3Rpb24/DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFRoaW5oDQo+ID4gDQo+
IA0KPiBTaW5jZSB0aGUgbm9uLWVTUyBkZXZpY2VzIGRvbnQgc3VwcG9ydCBmdW5jdGlvbiBzdXNw
ZW5kLCB0aGUgZnVuY3Rpb24NCj4gc3VzcGVuZCBmZWF0dXJlIHNlbGVjdG9yIGlzIG5vdCBzZW50
IGJ5IHRoZSBob3N0IGFuZCB0aGUgZnVuY3Rpb24gaXMgbm90DQo+IGFybWVkIGZvciBzZW5kaW5n
IGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAuIFNvIHRoZSB1c2JfZnVuY193YWtldXAoKSBBUEkgdGhh
dA0KPiBpcyBjYWxsZWQgZnJvbSB0aGUgZnVuY3Rpb24gZHJpdmVycyBmYWlscyB0aGUgYXR0ZW1w
dA0KDQpXZSBtYXkgYmUgYWJsZSB0byBzYXkgdGhhdCBmb3IgdXNiX2Z1bmNfd2FrZXVwKCkgYW5k
IGRvY3VtZW50IG1vcmUgb24NCnRoZSBmdW5jX3dha2V1cF9hcm1lZCBmbGFnLiBIb3dldmVyLCB0
aGUgZHJpdmVyIGNhbiBzdGlsbCBjYWxsDQp1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKCkgZGlyZWN0
bHkgcmlnaHQ/IENhbiB5b3UgZG9jdW1lbnQgdGhlIGV4cGVjdGVkDQpiZWhhdmlvciBvZiB1c2Jf
Z2FkZ2V0X2Z1bmNfd2FrZXVwKCkuIFdvdWxkIGl0IGZhbGwgYmFjayB0byBiZWhhdmUgbGlrZQ0K
dXNiX2dhZGdldF93YWtldXAoKT8gT3Igd291bGQgaXQgYmVjb21lIG5vLW9wPyBXaGljaGV2ZXIg
eW91IGNob29zZSwNCnBsZWFzZSBkb2N1bWVudCBpdC4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiAN
Cj4gaW50IHVzYl9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmdW5jKQ0KPiB7DQo+
IAlpbnQgcmV0LCBpZDsNCj4gDQo+IAlpZiAoIWZ1bmMtPmZ1bmNfd2FrZXVwX2FybWVkKSB7DQo+
IAkJRVJST1IoZnVuYy0+Y29uZmlnLT5jZGV2LCAibm90IGFybWVkIGZvciBmdW5jIHJlbW90ZSB3
YWtldXBcbiIpOw0KPiAJCXJldHVybiAtRUlOVkFMOw0KPiAJfQ0KPiANCj4gTGV0IG1lIGtub3cg
aWYgaXRzIGJldHRlciB0byBhZGQgYW4gZXhwbGljaXQgc3BlZWQgY2hlY2sgYXMgd2VsbCBoZXJl
Lg0KPiANCj4gVGhhbmtzDQo+IEVsc29uDQo+IA==

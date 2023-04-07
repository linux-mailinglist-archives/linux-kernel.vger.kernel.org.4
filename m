Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F036DA784
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbjDGCLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbjDGCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:11:06 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65756BDF8;
        Thu,  6 Apr 2023 19:09:56 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33727H2E016181;
        Thu, 6 Apr 2023 19:09:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=oICCBCUwfIdcpgqmXkbSwvvmMablpZ2w6yaS2xwjt6c=;
 b=HA2Q6NIyI8w05R4tst+ujJEgBisPGBzNUW/mTwDf7xegUk7CY3JTI/tIVTJ0QJ48A+Mv
 17k9h46umAwGE3ee19tltajeT6K53fRJ8nZ48XjGKKqwUas1kSUBzVuDPcKceXtf1XtA
 T6W9o+3FglQcyJnhEoepvtjPUDp8Ic14DfqWIP1+zM0nllup6KZ+XnHqvDmMgwXXGojE
 hGk9DLgqQK6i+KB9UOoHsz0NZhPjvLkENnL6FpVG2uZr97j2gNuhx2Cg0WhmGqi3sQfn
 5Ffg8TfNqHvFa19+ilv6e5XEVmI3EZxCQ1odjw3NZe1QPIkYSgVqQWngpWeNsETMvnBj Rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkv9eusj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 19:09:34 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 26565400B4;
        Fri,  7 Apr 2023 02:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680833374; bh=oICCBCUwfIdcpgqmXkbSwvvmMablpZ2w6yaS2xwjt6c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kGsRtr3Lvt/ddfKwh2TJBw7lIhKUkHvdfzk/t2n0zvsNOOM1redBA9vQjKVwDG2WL
         veS27IjVPzLn2tcbvBD7Ct5GX/DM71auxXetTkatUJGGVdBIMQqTXzhWC+PhQVoDyK
         uXQY+LU0kTMY1Oic6SsUBcBg6xutilWwQLoBbeMnfH8k3KbRAMdhFXgG3X5jZq9qE7
         siyuF3+y/6E+VloN3L+ya1z5lHgKGRJJFwageKFwdmYQljDRE4ROVMib6NpatXUog3
         GfMnq0iZKnBCDqhPLWARETAYwKFR0Qm5gxSEr3tQzD0nnQENdMzOv6DLFLn4Xtr8ea
         0WifdCb+kfcLA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A35F1A006F;
        Fri,  7 Apr 2023 02:09:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2E152400F7;
        Fri,  7 Apr 2023 02:09:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="bJ3UGfho";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV5KOMRzPEw4ZNoTzCYVvWQxGjAu7JdXl667388VjxemkIPc2z9avCUWKqRrF2/UdeM4w0I8UxIHSXJSOP3+rULn3Csa0460Qed0KHL/bskC2MpUHp4ET+Bkr0Kc8Lz7MqGAkqGcfV7h9iwjpZ11OgsLR2d2RQ23r44pN3+YzTUgpBtuKex35wXZ89O7w1+GQBy5CXIYBKc5e73+h8tM164D5TGDV+TDdCuofErvn7ZU792cXvdG0k6QM5izbCSYaquNC/l+jorf0VR9GmizFXIDTXSXRk2ciQLQcK8ZGq3dyrwb9WYUfk+b8S04sDeAemU5oZ5BtvQKM98T/sTryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oICCBCUwfIdcpgqmXkbSwvvmMablpZ2w6yaS2xwjt6c=;
 b=ERtZrtlCk3tVfISY1Aur+AiLPohiIzW3cZuZ80ysu1fL9OdimdxcdKLBmUhH8nefHTg+sA4maToJXFPE/owwwsJKUMrByPHs0yhYnKSwDqCmmJoDg5Xj2XdVB/NkR6AxL0Bgm43Lymy/K3kcc3rjG4EqWpM55bFTtSoQrAS7Iec6oK1YUm6fV11Uau21Ck9qLFhATfiSRF3xPrjIFfKeaTXWgZHHp0h8qa+OF/pBSaOdEtpbHH1b/UMGFWC54hTkYalyKyAhgwYY0nrOLnk2sL+1/EvK1IYB115lGQbwe2XetKb8rdOEN69i7JzEYWpM3oR8KCgfK5qHgyWm3kJrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oICCBCUwfIdcpgqmXkbSwvvmMablpZ2w6yaS2xwjt6c=;
 b=bJ3UGfho4Y+Hu5dY8YYxBH6/p3GSJ3uYDeB7H4adF2Fy2j3FnVzVl0ZnWNcfg+6C7DtEwFlXJjPEl/uis5j8QBJAZJQArQHdhdyDwQN4L2QhFL34+vT/tcnycFwR77nT8j6eUQXlwSVt/FGPs4OHhDsRsW9VxnTQOhUoQqCduuE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 02:09:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 02:09:30 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] USB: dwc3: error handling fixes and cleanups
Thread-Topic: [PATCH 00/11] USB: dwc3: error handling fixes and cleanups
Thread-Index: AQHZZsaw8uxvYmwus0yh0K6vPOxF368fHlqA
Date:   Fri, 7 Apr 2023 02:09:30 +0000
Message-ID: <20230407020915.hg547t2mcc22ckwn@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-1-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA1PR12MB6018:EE_
x-ms-office365-filtering-correlation-id: caa4f94a-7224-467c-17ac-08db370d1f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxd13t8tY0W6flZ0wFV+KY5HAc3th56enp8JkS0C1lvM9aopyrf/EqYpkAMkxY6u0r1qgoBEtKmhWZDomOI3Gs6jPWPDHoHY7zVH9i6bGYqc56D7HCa546A/dfFM1IaTi1TSglM4/CMfJrRF1yTtsF6Tc62VYpO7ONPEKAJlguTyfUgq7GfVABH2Oilhzmb57TxVRu5PdWjbehRlE/o+4Zuc9Sy9V2S8DL7kX8Zrfqn2504lVnf1nreo6/ZSMxKUzb4FOjqnkWPOyVdP/EokGN4B0trlYQNYKGA4DKt7xgcfNUU+7bcKfcTIotfUl4WlflOqEGGeLSxrXUwUmg0mvIfxzhYlqe19CmUKbN2stttIYznK19rjtFTvjpy+z3QWTLtv3mZCi0Q4Rqgl8amYdWj1xCot5+sXnZwuFW2oQqzSEb/stfBxBWmu6fxoTU/7a5qmki4JalU0Uk/oHEaxEPAUps07hbF7Mol2JEG3dJsCG9QGcJC/JV5TiwixQJR3vXW7N0PcRFqO0Vd/pFqOPRlYxUmKNtZchdshFzd6uoejvCTIk+1t3Fj44TpsymYfzA84hh0iawa1+Nzma2A+us7WNPzOFJT2JsfpW8zhufpgYDhkqXrHNUqFk4r6gyFN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(122000001)(38100700002)(86362001)(36756003)(38070700005)(66899021)(71200400001)(8936002)(6486002)(478600001)(316002)(5660300002)(6506007)(2906002)(6512007)(1076003)(2616005)(26005)(186003)(4326008)(66446008)(64756008)(76116006)(66946007)(66476007)(66556008)(8676002)(54906003)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdkNmljR1Ryd3pHQkFzdHZCRklHSFo3MVNMUmpsSGFKTGpqdTRjQm9qRlc0?=
 =?utf-8?B?a0x2dmNhL2xqRlM5MVJySmlSK3FnRExRcjZQaE5tVzNTditIZlV6V1ZjWGxw?=
 =?utf-8?B?YkNzZ3A3Ni9USkJyVjJzR0YxaDRZNlM1RmprKzVJWERxb1dVMjl2RUdHS21B?=
 =?utf-8?B?bGF4RW5pSGlZOFhDMnZhVjVmQmo3Z3VQWXJSMnVHQWhNRzVWV1VtelpWKzE4?=
 =?utf-8?B?aTlTaWpVMW9wVEg5M3RCL0JVdEMxZ2ltdFBCNnBLYktwMk5uR2FiRmNQK2Uw?=
 =?utf-8?B?Rm4rNEpOWFoxQmp0M2c4ZSt1bGNhdDVOU0RPTVBBRUxEa29hYkFydjBYZTJp?=
 =?utf-8?B?aVVVNTlVdk55NzJYRzJGUmxPcGlRcmxrL1hSVWlnQzJHRDlpWU5JeU1rVFYw?=
 =?utf-8?B?ZDlwTW91bWorS0hhdE9jMGFQYTZSVHduMmRmQ3RvdWl1MTY0aGJEL04wZWlw?=
 =?utf-8?B?VndkUE8wS2RDc2NqN3lVbVUzMk00TlRoRXcxNDVFL0NMQndHS0lKdmhjY1py?=
 =?utf-8?B?bzB4RlZDV1FyZDlrOExRenFHL3l6LzN1cDBCd0psRldiSVpQZkI2SUFUQWZV?=
 =?utf-8?B?THdmcFNPa0NrWXA0ZlU0ZUtENU8wanFDM3NPM1BNb1ZaK3cra0tZZ055dEhu?=
 =?utf-8?B?akdXNXkzME5NZFR5QnZBVy96MTZtN3VhOFlycnpDUWpYci9zOHBkYjR0UHh0?=
 =?utf-8?B?UTB0YmJVYnB5eW5vQVI4TlJTY1Y0UEpRbm90TnVPTDhHQ0s2blJQNUtTcVh5?=
 =?utf-8?B?RmNYbHhzZXhMTy9TVHRJNVY5OFljRlAxaXRXekZid2hiMDJOb2gxN2FkeTJC?=
 =?utf-8?B?WCs0SnRtOXBGMzdJb1B2QVZFVTlKTThKUURydHFjVXE3VTA3VUo0NXhkcTRv?=
 =?utf-8?B?UGxVdzRpOHFNdE80ajYzbGtKOEtIa1drbUF5eVk3TCtUVi9JbitVdWU2ZExO?=
 =?utf-8?B?bkl5VjFNanZXWHJiRU1zV2Zqc09meGoyMER2NUkwWXlmdGlsNDVIcFRhRFI3?=
 =?utf-8?B?Uk1mSndLckhLdTJnTHlQUzhKY0dMcDdLbmhtNmMzTWZpc04rU3RNNy93SUNQ?=
 =?utf-8?B?a2dOZ2lRTWVXV1A3YVBGNmVVajl1UU1ncUFCSzZXcVFSOWZuR1VRNDcvZVFG?=
 =?utf-8?B?NisrSWdvS3J0T2kycDJKTGNvUnhYc3pUalRuRmE5QkpiOTI1UnBoSEQ2dkNY?=
 =?utf-8?B?VHV0emJlT3FpbHcraDk5OGlueE9mYUNHNEk1eFEvMkNWL0hVVDd6aHdhMGlG?=
 =?utf-8?B?cWllUkd3bnh4ZExMYWEzUFIxZTJrOWFJdzVOTGlJVXBPK2lDQUl3S2ROMWc5?=
 =?utf-8?B?N0ZFNERXVWx2Nk5oS25JT0p0VGNkV28wQ0dsVjdrakFvMVVINzlUbGtrRjlC?=
 =?utf-8?B?V3plYmt1S1NxcGVUVUJwSm1SUXA1MXVzRmFPb1ViZ0t3bFlFeTNVcmMwWjdt?=
 =?utf-8?B?T1lCb0Q1NDNrWGJYQ3poVXM5cnc2NXY5Z0d6b1gxUDNHN1VpcU5CNnpyYUcy?=
 =?utf-8?B?SFg4U3ZVMmpjR1BTYklmOUZPN2pncFVvVHFsWVAvdmppcWtCc2o3MjdlVXd4?=
 =?utf-8?B?cXRtMGNzVEVTV0J1VlVCZkUwSi9NdTJTc09lbnUvRWxUTEFnQXduVW4vTmtK?=
 =?utf-8?B?QlNzV0diRTFTLzBYSXpGSFp6T3VQMnZBczladWdjekNjcStMRDlIbEpSM1la?=
 =?utf-8?B?YzU1N1c0TGZaZHFYWnBKMHBRVWhYenlEM3lZWkRlK0N3Q2ZYYnd3N0JEZzl5?=
 =?utf-8?B?RFhReGpTS3JBZCs0UXRRVllTUHZ6a3hIbjFNM3czU2xIbnc5Y3UzUWhoc1Vy?=
 =?utf-8?B?TkIrQllpbGxXZWtFc1cvWERtQnkvQk5OS0l4OWJnSlloelM1R0xIMWtGTUF1?=
 =?utf-8?B?Mjh6TW9sR0c1ZnJSZkNIRHE4SXBCVFl1b29PdFlkRDBnQVhBRDJYV0x2R2Ex?=
 =?utf-8?B?OGtMWTVDcFpGVjJvL1FWTjNveENLUkpjb0ZoSitLNU9vRXpFVEowZVpBbVVJ?=
 =?utf-8?B?a0laWndvMUpOT2lDTUIweDVVOHJmU25YUFFkVmR0WDNOVW8yRFR5Q2tacDl1?=
 =?utf-8?B?TkQrMFkwNDVxNXlGL3A5czBVV2g3UW1lczlHU0xlcU5EbjZjbVpmZ0NFL2U1?=
 =?utf-8?Q?Ax6IIvJbsw421t5LkhojpNJB9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6F2F05ECD944B43B820C1218D790796@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KQNAzFiaIFo9Q2n2UMDQYTI7ixHnp5vbGMtrMeylou13GKOv27vq4NwlxQOPqQiw7TFdo8b9O6JiRGwGAmiJB+cV3hZSjWFOXnHJE6XqVITWu6hwxCs9Linnp+nNREOuQ6bwOqK3sxMvmhMhqnNvN33sxzHVDz1+JfO10g4G3HPYsHV3NuyvkNoIVYqxMGSQGqyPp03MUfYmsqnxSQsV9qCFs6+7VgIDeikJeMFS37xQMxnEfHSCJuqrBSIEoqm0HQhwhlm7YDH5k3g5K12lAxgLSFGXQMrzChvU90ejLChHZ+BcpAdSB5lFiXFWy9Sa226h/S2ik/qsXV0X3FUGiamjdEMCDFmznJ2mdET0b1+e7QbJLat8424T1csfwKav/7WBHV8JYqslYU2q4Pl/5tuBqBMLG7hoc+cZ2Ni7Ef5KW2bUgf8fSQuYwSO4/e3FaiK9N8VNvGkOizwdMw0aQgTdlz+5ot8z3RE3M9NkpZltt1Cno2x93/BYNQ8yFb6EgxQ9h92di5h2NlZhuS/+9HcNGuU8afxFcsonavT04qrK6OkVojYLF89zFr6h4oUC3Te47LBC+bydAfqw4UE3iBYMlBFoMNafu8Of61talG0xhroyXAwhVivLdqNLgrsrhlTCrL5iTiwC1U/5VwEWZXCDiH8FATLinkXDsVjOWd5G8WL3hyoGWd43750sMH+Zrr7Fml/Im0Rvh0nxtZNi1CnsWm2ENwQSCsFuJ5AanSruLtSLdYb6GaGtrgylbgOuMv4i3DdJqWuckPA6laKxgF5Gm1i65CISBjjIZ0o5J30oGWslYsPj9Ua8PbmxeCMNpe3EdhgQx8Qr3VUOHO/7gyYMjyB3mYaHz6Mfh16L6GPQLov75LxwoShxbI4sJMQK
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa4f94a-7224-467c-17ac-08db370d1f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 02:09:30.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OKd9RRy6Gb8LFuXsrQLkieUemvQBpR/0UVPOGf7wnNbcaJZ9yzQpKU66NyZ5g2QlPZP+FnAP2zqRPaChVZYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
X-Proofpoint-ORIG-GUID: PaBu40p7QLUh0mUUuv7jxFYQf_0-4a-y
X-Proofpoint-GUID: PaBu40p7QLUh0mUUuv7jxFYQf_0-4a-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=800
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070018
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gV2hlbiByZXZpZXdp
bmcgdGhlIGR3YzMgcnVudGltZSBQTSBpbXBsZW1lbnRhdGlvbiBJIG5vdGljZWQgdGhhdCB0aGUN
Cj4gcHJvYmUgZXJyb3IgaGFuZGxpbmcgYW5kIHVuYmluZCBjb2RlIHdhcyBicm9rZW4uIFRoZSBm
aXJzdCB0d28gcGF0Y2hlcw0KPiBhZGRyZXNzZXMgdGhlIGNvcnJlc3BvbmRpbmcgaW1iYWxhbmNl
cy4NCj4gDQo+IFRoZSBwcm9iZSBlcnJvciBoYW5kbGluZyBoYXMgc3VmZmVyZWQgZnJvbSBzb21l
IGJpdCByb3Qgb3ZlciB5ZWFycyBhbmQNCj4gYW4gYXR0ZW1wdCB0byBjbGVhbiBpdCB1cCBsZWFk
IHRvIHRoZSByZWFsaXNhdGlvbiB0aGF0IHRoZSBjb2RlIGRlYWxpbmcNCj4gd2l0aCB0aGUgImhp
YmVybmF0aW9uIiBmZWF0dXJlIHdhcyBib3RoIGJyb2tlbiBhbmQgaGFkIG5ldmVyIGJlZW4gdXNl
ZC4NCj4gUmF0aGVyIHRoYW4gdHJ5IHRvIGZpeCB1cCBzb21ldGhpbmcgd2hpY2ggaGFzIG5ldmVy
IGJlZW4gdXNlZCBzaW5jZSBpdA0KPiB3YXMgZmlyc3QgbWVyZ2VkIHRlbiB5ZWFycyBhZ28sIGxl
dCdzIGdldCByaWQgb2YgdGhpcyBkZWFkIGNvZGUgdW50aWwNCj4gdGhlcmUgaXMgYSBtYWlubGlu
ZSB1c2VyIChhbmQgYSBjb21wbGV0ZSBpbXBsZW1lbnRhdGlvbikuDQo+IA0KPiBUaGUgcmVzdCBv
ZiB0aGUgc2VyaWVzIGNsZWFuIHVwIHByb2JlIGFuZCBjb3JlIGluaXRpYWxpc2F0aW9uIGJ5IHVz
aW5nDQo+IGRlc2NyaXB0aXZlIGVycm9yIGxhYmVscyBhbmQgYWRkaW5nIGEgZmV3IGhlbHBlciBm
dW5jdGlvbnMgdG8gaW1wcm92ZQ0KPiByZWFkYWJpbGl0eSB3aGljaCB3aWxsIGhvcGVmdWxseSBo
ZWxwIHByZXZlbnQgc2ltaWxhciBidWdzIGZyb20gYmVpbmcNCj4gaW50cm9kdWNlZCBpbiB0aGUg
ZnV0dXJlLg0KPiANCj4gSm9oYW4NCj4gDQo+IA0KPiBKb2hhbiBIb3ZvbGQgKDExKToNCj4gICBV
U0I6IGR3YzM6IGZpeCBydW50aW1lIHBtIGltYmFsYW5jZSBvbiBwcm9iZSBlcnJvcnMNCj4gICBV
U0I6IGR3YzM6IGZpeCBydW50aW1lIHBtIGltYmFsYW5jZSBvbiB1bmJpbmQNCj4gICBVU0I6IGR3
YzM6IGRpc2FibGUgYXV0b3N1c3BlbmQgb24gdW5iaW5kDQo+ICAgVVNCOiBkd2MzOiBnYWRnZXQ6
IGRyb3AgZGVhZCBoaWJlcm5hdGlvbiBjb2RlDQo+ICAgVVNCOiBkd2MzOiBkcm9wIGRlYWQgaGli
ZXJuYXRpb24gY29kZQ0KPiAgIFVTQjogZHdjMzogY2xlYW4gdXAgcHJvYmUgZXJyb3IgbGFiZWxz
DQo+ICAgVVNCOiBkd2MzOiBjbGVhbiB1cCBwaHkgaW5pdCBlcnJvciBoYW5kbGluZw0KPiAgIFVT
QjogZHdjMzogY2xlYW4gdXAgY29yZSBpbml0IGVycm9yIGhhbmRsaW5nDQo+ICAgVVNCOiBkd2Mz
OiByZWZhY3RvciBwaHkgaGFuZGxpbmcNCj4gICBVU0I6IGR3YzM6IHJlZmFjdG9yIGNsb2NrIGxv
b2t1cHMNCj4gICBVU0I6IGR3YzM6IGNsZWFuIHVwIHByb2JlIGRlY2xhcmF0aW9ucw0KPiANCj4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCA0MjYgKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgfCAgIDggLQ0KPiAg
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8ICA0NiArLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDE4MiBpbnNlcnRpb25zKCspLCAyOTggZGVsZXRpb25zKC0pDQo+IA0KPiAtLSANCj4gMi4zOS4y
DQo+IA0KDQpUaGFua3MgZm9yIHRoZSBjbGVhbnVwIHdvcmsuIEkndmUgcmV2aWV3ZWQgc29tZSBw
YXRjaGVzLCBidXQgc3RpbGwgbmVlZA0KdG8gc3BlbmQgc29tZSBtb3JlIHRpbWUgcmV2aWV3aW5n
IHRoZSBydW50aW1lIGNoYW5nZXMuDQoNClRoYW5rcywNClRoaW5o

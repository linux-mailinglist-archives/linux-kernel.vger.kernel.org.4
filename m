Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E473C41E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjFWW3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFWW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:29:01 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE8F172D;
        Fri, 23 Jun 2023 15:29:00 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NMJIm5030329;
        Fri, 23 Jun 2023 15:28:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=6vuWh6s61AmVJpFKsQLJhYZdwRUK3wGzL7q7Kfu++V8=;
 b=Np7uuNIFGq9H4Cpz5ok3ripCpr/aSkLAlg6KeUbeB5z3G1Y9Hlfi12APpgJ2+JcRy4oT
 36/sOEOTdJFG3PRTMX7kSQXAyj2m/r/pH/VKrIyTBLlmXL+G/o/OxSSYimqIRMEbNIyq
 YIjJsUERyLzlO+KKxfCFIak314rkTCSptImDFlZiasy+RO9N+ALlsOeu0sfU6662/t+b
 UjA86JiFHhEaN83RBak6Ao3XAQ6DNx8Pwu5Cc11Aj26DJDQtrUW8Yjb+61vC+XntMbgs
 Nt7UEFSHvViSgaHlrR1irHwdLQVoNbVA5ayVQ6qLBfgbKqHjMN2FFPo6ILjc1xt1nJui FQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3r9bunmfkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 15:28:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1687559313; bh=6vuWh6s61AmVJpFKsQLJhYZdwRUK3wGzL7q7Kfu++V8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gFEJkZ3sCTVkHRbUi8oCKT4miAdspinWhQ9ifvoIyZ4ix5NkqnvC9cqR/Viso9Qet
         Q1iqVNnqVkowlLnuJbANyIctd61QXkoVr7vRS/f/8MIMRveIUgQYf5weGGzxj0D3n0
         x1RLeUkfqs++IWgJNjcNwY/Lp3HrG8rNqKe8+maN8dPbEW7PsmldPonxtfAApbr3JI
         BzEnnA+kFdqEIl6izkKopDDCiDRuYjpBaNNkEC3L7mdSjV7ECfoswIT9oVkrHT0xwN
         vD1M1unuRMtRfBZWg0YlblSy2fJnIZP1nEPgRugT5NB1RWkYZ42w4k6TIV2kmur0GG
         DYn0e039nSuRw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 77F15401F3;
        Fri, 23 Jun 2023 22:28:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5104BA0071;
        Fri, 23 Jun 2023 22:28:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EziwpRvR;
        dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 265FE40642;
        Fri, 23 Jun 2023 22:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4xlHOYjpfZTKCOsVrQCSvrVbAXC/QTtydHl1JtLRGgM5VWi0T9c6tRN9klFWE8NSZc61xKhPuSeYV3S8kPAi9zytPax3LDinlqlDvzYNunj0RQjw3fQOTQAtrXvIl3+bRlDzBirzZaVtpfBnyfh+JwGcx9eJK0IjwOJY9EB1g4MVl6RQH2qjnniPTfQr11c9La5kvPwPHNx3QeRIXrQ+ubvLZtTP37NOy68BSPkX0GeWbdXfXCmuDXCUE8DGzlT//HS3/mpM5Y0uBDeS2/9GmXmN/Pd+XDPQ829n0N4h0X+KpAcJuTLzsrchwQlLCjJfXnOUgy9gMly1jUncQr22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vuWh6s61AmVJpFKsQLJhYZdwRUK3wGzL7q7Kfu++V8=;
 b=W7TT1lCnQT/RKy9FtSGqvRZhT3ig3EhahryBuCJrMmEOsX814Caqgl6zIiJxZfm8eKuXnTz/buw2gUS8FKlalXMyfS19vBcRcqPAk/YS9B2Az+/m79cRTDpNnpg6qYXS8o411W7hvx4An31CL7wxuWW4JdYMw7COPHnKS6sd02En74JgdyiT1aqjiazSsEchQSDoyQS+yzfjIrAHPnMJTA6b869+ZmPYT+ogo5slSOfnCaPuZzlw0rH7eAt5vwswe40nbrZ/tJzHD0aezrDzXAM3KUqaq5NJavq9gK/5eHrlq8vEtvPm8Iw8Jy8cRVbR2H8f2YhuvPGqNIPHEWaxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vuWh6s61AmVJpFKsQLJhYZdwRUK3wGzL7q7Kfu++V8=;
 b=EziwpRvRTu2dGLGO/4UUlKAdklW8MkbhMwnIeH1haazv5oWaJBTGlTGeukV7c2PjCgD/b36VTz8cWZO5ibvo1EKp5Bd/3qeq/8RY4YYQDe7xjl4P6gQr/SiYNmDtFMqU/YL5jQ70p0zlaVclK5OC5nWqAce1PULYRzOUMDkq9fg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 22:27:57 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:27:57 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
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
        Johan Hovold <johan@kernel.org>,
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
Subject: Re: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Topic: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Index: AQHZo/oUWyyJ3lQGykedS+ST62GFCK+Y+/MA
Date:   Fri, 23 Jun 2023 22:27:57 +0000
Message-ID: <20230623222754.auuce7y6c2e7ymvw@synopsys.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-5-quic_kriskura@quicinc.com>
In-Reply-To: <20230621043628.21485-5-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB8121:EE_
x-ms-office365-filtering-correlation-id: ea48a013-c8b0-42e7-6a0f-08db7439183f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRu3QRcy5Sm+tJFF/lbx1T4bSZCgnMH2Qs6xs2msswe5iCmnQ1QnMkpWGwgWjgoGWJze+MHlf/mwrvE2vS6geCiD651X7iqPZ+p5hQrCmR1+yb9r4c+wi3UEGsnZcLW/HRoH41RrJXdjGyiwqNRmmmK6Hk3sXLeBnn+o5uUrsyCjHv0epyHvf7IMV1CMRVnPt4L9efSK55y18jLnHJjGAmH/sA/KefppsREwFIxwe0z+qWp1muIjeRbE2PqcNdp/lBRR5Qj4RFdI/ur3VzUkYUyU1aHkbh3KXTMFrczeBmxOrH0IaVFYTTkYi6Z1c/aT7YtHyEckobNVPx40GTNQYBXEpiePN1RqHTciSu2pgCrSUSyqs6qic2d35mKrkxG6FD6K4YmhjbRNtXIu16LV8xQBkx0TQL4HXgJEbV7YVQ6vWs8nPwV6iDLBFWkKfgf+0RgVXSJOFCHihjTUVPTWhlMrKjWxaQYCaohmtfgf7ghidOq0kgRC4uQBi8mfY9dFj1SmV8YZbAMiYSgJAv9/w8A1jlFDj8k++zo1hotM+WL6jXBQri2wEQ+g4pAK8oiyx+uMtrGp0SYYiDAgA0siRjvMDcjAMgRJf97dajdU7c1WlHaDsm8dWXnS0VlUYY46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(8936002)(316002)(41300700001)(8676002)(122000001)(36756003)(6512007)(186003)(26005)(38100700002)(7416002)(478600001)(86362001)(6486002)(2906002)(38070700005)(71200400001)(6506007)(1076003)(5660300002)(2616005)(83380400001)(54906003)(76116006)(64756008)(6916009)(66476007)(66446008)(4326008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzZTekUzdERSZHNWSDlxbUZvVTZhL2dBb1ZzMGsvNEJ1MW9XYzJUV0ZySGFo?=
 =?utf-8?B?dDdTaGdVVkU4Ly9ndVRXalFFNWgvZGs0alVtazZrd2F1b1R5d21SZi9XN2Vl?=
 =?utf-8?B?UmpWOGJpQURmRmdHSlJiNUpTSm50aUJoUXhKelE2bDgwbS9Ocy9UNlBSckdD?=
 =?utf-8?B?U1ltZ2N0Rk10U3IrQ1R4T1g0ZjBEZlFUZVhsdDRSblo2ZHVtU2VSRmZvU3Nx?=
 =?utf-8?B?Y3NwQ2ljUW91SnFUNWdMb3FsUjZ3VmFCMjBVdTR5M1FuRFVLdUpQdmRZVEFV?=
 =?utf-8?B?QUcvUndBM1lQZEoxNmJXcWpPeWpQbUtINjdLMldIaUEvajdRMGZWU2czU1ND?=
 =?utf-8?B?WTZSd2lmWGFRazByUmNDSG9MeHkva0VVbWxuV1pKemlZZzRseFJNcUZwOTBV?=
 =?utf-8?B?VFhYOEdndFNnNmk1VlIrQkpGdTczc0NCWElDZjJRc3JwMW9XckR6a2FUblhJ?=
 =?utf-8?B?Wlo2WnRKWFdOaERab2lOVXRPcEpGbDR2T2tCZ1dUTWMvNnJ5Y0lQNzduZ2RT?=
 =?utf-8?B?QjNnUmFtdWJ0VGQ1LzZaYXljV2NTeVlKQXVQTVd3OW9hUVZOS0lYZVo5aE5O?=
 =?utf-8?B?TTdiL2VGRUxWdFkrckdpNjJrSGJ6R25hellqYTZUNnBzOWFzalYyU0FBYzJu?=
 =?utf-8?B?N01OYkFkMzBwa3pBenpTVkQ5MHZyZjBuOWkralRRdE9WaHNIcTlWelc3eUZ4?=
 =?utf-8?B?blhUODhJWUoxdmQzN0wrdlRHMWZzZUtxZ3hURlJEQkNHOXVDZ0lIalQ5dnNu?=
 =?utf-8?B?ZkJZOGdNVTQyYytLOTlGSnJJR0Y4STJ1RzNZeDdPd29pai83dlg3U2xIdTFz?=
 =?utf-8?B?c1JUY3lDakh5aGtQWEdxcUt0L1kyUzliN2RUUlUxQ0tETVRiV1ZScHZpT1Z2?=
 =?utf-8?B?L3FUeHlCOHN5TmtVa09DZVF3SmQxSy9CMXVpMmdCdEEvckdwRFpKMVN1Sjl5?=
 =?utf-8?B?ZzZBcm9nUkJlTGtxTjBnYktNY2xqaFF5Z3NXemxYRmp4VXM1RW0rTnJESXda?=
 =?utf-8?B?NTg2ZE9mQlhmajhJaXNEUENuWXRqZTVBQmY4OEJ6L24xc1NHbWZ0VmNwNUlt?=
 =?utf-8?B?SU5mNDRzbXY3ZGdJdHZYNVRFZ3U4N05UVVZ4RGJVellEc2RnN3pISFpTUzBO?=
 =?utf-8?B?NG1GUVVtNkJjQ1NtT3N4VGZrQnFBSGtLYjdWaitWWkhXbGdQS2xYanJsQkhn?=
 =?utf-8?B?UXRpY0hxNXo3QXlISFJZOHJsWWxsSGVDbktSQmJNalp2V3hGa09FZDZNNjFw?=
 =?utf-8?B?VHZnK2lzY0pLZk5pWFNIVkNRV2dMZ214L0o2R1BPcSszYXMrblRwcnhvK2VS?=
 =?utf-8?B?ajdZczFwSUs5RHNPTjFpZ3VtbXJIZm5DMEVXRitUcVZNYXhyQ09DUDI0YkhI?=
 =?utf-8?B?OVNPdnJYUEc5UmdQNGRBZE1pVUt6ZDZWeitFdmpkbzJWNjNXQXFrU0h3N2FH?=
 =?utf-8?B?NEYrRjdocURoVUUvbDU5eEI5blBiR3BnVlIreXhVVDFxL3FvUS9mODdJdFk1?=
 =?utf-8?B?bkpjR1VRczc2R0gxQ2dzcGxkUHl0a3BYZ01BZzd4MDUyU2h0ZmhhSFNDbWJr?=
 =?utf-8?B?cGdmcTlib0FYYTdyNElxdHZhMHpQdDkzOXd4VWdWUThwWTc2ZnRhVHc2ZUhh?=
 =?utf-8?B?REYwRmhGSXh0eVlBdm14VFR0MFVkSmJqRTZuR2RnZUtYWGhqVm9jZEdJS2cy?=
 =?utf-8?B?MVFraUgrdzl2VmFxZCtFUGx6elR4L01qOUVZN2FEL1ZTaGNKWEZMSHBseVRG?=
 =?utf-8?B?SERUa0NBcC9WMnFkZE10NHJvdUtuYk1QeUcxQ2w5S1I5S2FTRlVKUk9vL2Mz?=
 =?utf-8?B?R0o0R1Q4b1ExK1N0elUvN0U2NGlmVTM1YjR1M0VtS0pFM0s1OUNSa1ZDRjZh?=
 =?utf-8?B?bkw4eGg5aGdxN3lSVVVrVWlmRnhFRDNPekJCR0N0QTdRWlFoTlRNSytkVUN6?=
 =?utf-8?B?dWMrSFFWMGxWQUZsMlB1Y0pCVlBUcTgvUmRZM2U0UHB0SkZQbCt1eUhHelk1?=
 =?utf-8?B?N3ZTelh0NXJaZXVOVXVCMUVCU2ZFYlhQR3JFOGk1cHZSQStSU3Zvbml1NjJx?=
 =?utf-8?B?RlV6QXJPVTVuLzJ6amNCcW9GT21kc3A3Z3JINTFxVnZTMnNlWnJjMEZvKzdM?=
 =?utf-8?Q?3EzR1T+ACB5KZnRbnMd+ST4zC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B6D2498E0251F45B218058F4303A29D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cnVRbEhRU293RmxuRTBWUlRrbGI2ZURRbTBsaHdET1kyZUg4SUpWM0hJbjYy?=
 =?utf-8?B?ZjF2WVA3eHFWLy9Zc3NHN2orcTArUmxMMmtUTHdxMDBFeUVsWnB3ajJMNU56?=
 =?utf-8?B?aVplamRaaWFaMFI5ZWJ6UlR0MVJnNXBoaTg4Y0VRK2tYaERZdlFmeXBwVjAy?=
 =?utf-8?B?YUZLeklHRFdJU29CSWtiK1o1dlFXNTdCenFHSllCeEc3Ulg3UDR6RXVhQnV1?=
 =?utf-8?B?Z3lQeDg4dVFDSFByTGdMN1psanQ0Z09PaFZad1FUajRjT3JqU0orbTZ0bzdR?=
 =?utf-8?B?VGU1RWFSdU1IeUNoUWpibGk5RUt2b0FWSUtvMmlQRnRGMThhZGhEYWFnSEdr?=
 =?utf-8?B?Q2IzRFlxcWg2YmtzOTI2RHpQelU1VVhsa3RuT3pYZ01lZFB6UFFWU1ZpdWdJ?=
 =?utf-8?B?a0hPb20rVEVDbzZSSDRLQ3R5MktCbE1VUEtKS29CcGgwK2VEU2FQSnZpOGJH?=
 =?utf-8?B?MFNhUkl1c0JUVW9zbCs0WXMvWTczNldRSjhXVy93Rlp4L3EvSTc0WEtzSlRG?=
 =?utf-8?B?cjd1UGxKbk1YTjl3RDV3cVNjT3FpWU11ZTlnalA4UXovS2JOODMxMFQ2aWNs?=
 =?utf-8?B?Kzg0Y2NYSFIwQnUybEtXb2l3cS90V2Ryd2hCS29QSktHeEJzY0ZTYXNiUS8r?=
 =?utf-8?B?bEVPSU9rcUtacmQvTEZVS0owY0RNRFp6NDc3ZlFFSTFCZ083SmFYUm5NR25L?=
 =?utf-8?B?Nk1tTG50aHpuK25UbzRFVW10Y1E2WDlVTHZKeFYxTnRHZ0pJNTJuUjRTZzgv?=
 =?utf-8?B?SmJlbERoMWlZM1hUbWtDZnB3TDhNZEk1b1FNTERYenljNi9Uak1WQmY3endE?=
 =?utf-8?B?NnQ4Yk1UMDc2THNjOWJGRzNONHB6THNMMzBnMnc1N0p6Rm0zMENHNlpqTXFI?=
 =?utf-8?B?czR2QXdDWjlyWmdvWkNlMGluaThjdTlpOGpWNzg1aFQ2ZCtEWG5NSWpHb2JU?=
 =?utf-8?B?aDd2UWdzNEJuR1lVMzEzWm9UWXQzakwwcjdCZ1FBbmZtQkdQWVNLSTdrQjdG?=
 =?utf-8?B?eFR2bzNXMDk5TGtjZDl5cWwyMmlGdEEzYkk3NFpwMGtBalhXbmtnOGpvUVZh?=
 =?utf-8?B?dHBVQ3RaeERHQ3N1UUlXWkdocFdFZ1V1QmxQcWJmbGRockhuZmx1L2dvMVpm?=
 =?utf-8?B?QUxIT0pKK0tVUWhweFROSEc4ZktjdW5NRkZ2SDhRTndjbjJJb0dBa2RrYm14?=
 =?utf-8?B?RUlySnNFdWloeGc5VUdaakRQcjlMRFNPRGxHSVhGWFFXUTdSMzhKOTdEc2pv?=
 =?utf-8?B?L2F5Y2FxcEtMdzg3YUdIT1FVbmk0UnMyeG05WGpodjRPR1A2dk1OZ3gxc3JO?=
 =?utf-8?B?Uzkxa1RJbFJjWnQzTDNMOUFZMEI2VVpaZStudUJWOEhsTm11SWNJd3A4RnRj?=
 =?utf-8?B?aDRXbm5TbkJvT2c9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea48a013-c8b0-42e7-6a0f-08db7439183f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 22:27:57.1473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baNRQtQUCCP/tt49awxGMO7Z/l1qXIKBH3AKUOm5VrFTuwWBrZlqqrszSm+YB9XE7XhRVw4B3nsid/ahiAb7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
X-Proofpoint-GUID: JnJ1--CTZxud3GxTe7JhHM3JRVjC5FKN
X-Proofpoint-ORIG-GUID: JnJ1--CTZxud3GxTe7JhHM3JRVjC5FKN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE9uIHNvbWUg
U29DJ3MgbGlrZSBTQTgyOTVQIHdoZXJlIHRoZSB0ZXJ0aWFyeSBjb250cm9sbGVyIGlzIGhvc3Qt
b25seQ0KPiBjYXBhYmxlLCBHRVZUQUREUkhJL0xPLCBHRVZUU0laLCBHRVZUQ09VTlQgcmVnaXN0
ZXJzIGFyZSBub3QgYWNjZXNzaWJsZS4NCj4gVHJ5aW5nIHRvIGFjY2VzcyB0aGVtIGxlYWRzIHRv
IGEgY3Jhc2guDQo+IA0KPiBGb3IgRFJEL1BlcmlwaGVyYWwgc3VwcG9ydGVkIGNvbnRyb2xsZXJz
LCBldmVudCBidWZmZXIgc2V0dXAgaXMgZG9uZQ0KPiBhZ2FpbiBpbiBnYWRnZXRfcHVsbHVwLiBT
a2lwIHNldHVwIG9yIGNsZWFudXAgb2YgZXZlbnQgYnVmZmVycyBpZg0KPiBjb250cm9sbGVyIGlz
IGhvc3Qtb25seSBjYXBhYmxlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBKb2hhbiBIb3ZvbGQgPGpv
aGFuQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNf
a3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
fCAxMSArKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+IGluZGV4IDMyZWMwNWZjMjQyYi4uZTFlYmFlNTQ0NTRmIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiBAQCAtNDg2LDYgKzQ4NiwxMSBAQCBzdGF0aWMgdm9pZCBkd2MzX2ZyZWVfZXZlbnRf
YnVmZmVycyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgc3RhdGljIGludCBkd2MzX2FsbG9jX2V2ZW50
X2J1ZmZlcnMoc3RydWN0IGR3YzMgKmR3YywgdW5zaWduZWQgaW50IGxlbmd0aCkNCj4gIHsNCj4g
IAlzdHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKmV2dDsNCj4gKwl1bnNpZ25lZCBpbnQgaHdfbW9k
ZTsNCj4gKw0KPiArCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1z
Lmh3cGFyYW1zMCk7DQo+ICsJaWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVfSE9T
VCkNCj4gKwkJcmV0dXJuIDA7DQoNClRoaXMgaXMgYSBsaXR0bGUgYXdrd2FyZC4gUmV0dXJuaW5n
IDAgaGVyZSBpbmRpY2F0ZXMgdGhhdCB0aGlzIGZ1bmN0aW9uDQp3YXMgc3VjY2Vzc2Z1bCwgYW5k
IHRoZSBldmVudCBidWZmZXJzIHdlcmUgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZQ0KZnVuY3Rpb24g
bmFtZS4gRG8gdGhpcyBjaGVjayBvdXRzaWRlIG9mIGR3YzNfYWxsb2Nfb25lX2V2ZW50X2J1ZmZl
cigpDQphbmQgc3BlY2lmaWNhbGx5IHNldCBkd2MtPmV2X2J1ZiA9IE5VTEwgaWYgdGhhdCdzIHRo
ZSBjYXNlLg0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICANCj4gIAlldnQgPSBkd2MzX2FsbG9jX29u
ZV9ldmVudF9idWZmZXIoZHdjLCBsZW5ndGgpOw0KPiAgCWlmIChJU19FUlIoZXZ0KSkgew0KPiBA
QCAtNTA3LDYgKzUxMiw5IEBAIGludCBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoc3RydWN0IGR3
YzMgKmR3YykNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19ldmVudF9idWZmZXIJKmV2dDsNCj4gIA0K
PiArCWlmICghZHdjLT5ldl9idWYpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICAJZXZ0ID0gZHdj
LT5ldl9idWY7DQo+ICAJZXZ0LT5scG9zID0gMDsNCj4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3Ms
IERXQzNfR0VWTlRBRFJMTygwKSwNCj4gQEAgLTUyNCw2ICs1MzIsOSBAQCB2b2lkIGR3YzNfZXZl
bnRfYnVmZmVyc19jbGVhbnVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJc3RydWN0IGR3
YzNfZXZlbnRfYnVmZmVyCSpldnQ7DQo+ICANCj4gKwlpZiAoIWR3Yy0+ZXZfYnVmKQ0KPiArCQly
ZXR1cm47DQo+ICsNCj4gIAlldnQgPSBkd2MtPmV2X2J1ZjsNCj4gIA0KPiAgCWV2dC0+bHBvcyA9
IDA7DQo+IC0tIA0KPiAyLjQwLjANCj4g

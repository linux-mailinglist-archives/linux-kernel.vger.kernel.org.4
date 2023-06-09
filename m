Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5B72A1F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjFISRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFISQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:16:58 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F43AB2;
        Fri,  9 Jun 2023 11:16:40 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359EpjJa004580;
        Fri, 9 Jun 2023 11:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=kRBGRNrqyzdy5IOsYQyGhZSz0t/DUNjO12CnnPPDvWc=;
 b=FB3Y0jJ59Eal+qpQjV8KSEeNGV73jYtMjkyAzgKi2kiaEWlsOLGt1wqJuDBUAXTJ0oW0
 BxmhwWTYuAp3SINLuYQijfW3Z+Jozj+nYzS2tOlaqZELSWGlKxeTg3pMWup8PUNXKYxC
 QQTaAHY4aidlLeCnC6NGnmTLy5UGqGSOfQrewZbTH1e0tVfwtNsvvnvjP4+Rym/hHyZ0
 sF2lmDonCnuOsaQHJHdfwCvnp+qfuW7rKfWkAGAL2uOYbLdz9aPXXgrmN72AIZnwSieb
 N4jPUAB9vmG99OCuFucayqx4ulxaNXCDm5vn9XCUM/jgI0ItqjipnVpMk9tdJti6OHZM kQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3r2a8etgr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:16:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686334583; bh=kRBGRNrqyzdy5IOsYQyGhZSz0t/DUNjO12CnnPPDvWc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X+OKFox3vN75sgm5ZKUp32ywq0Pkw4TEth8KB8xPM6RMO4M8glbl/2bsMEtDCH9++
         mS4dEnj07Fr+tbpzewWrvdYkOBsLN8CiDmevlKAZy/G8c5WWmQtxPqIW3tRlieAiCy
         lBfVlcuXe10hFO1zpFwadgyNpUKMJeNTEQMsf/UMlujsPXVWuXs+NjYeF6BaxiBFE4
         Lx7SQ3rCBsRZ5Jlh8ODuCCporS4cYkCaTfqTC7d7AqQp3Fc+AEBkyeBkYG1SgqBHBK
         KjudnFkPfMMJq41oiPTtpbDHLJjxNv0RcIoPp2psyxJ3KaEyNHjnJl6yK1LnCtj4it
         VH/W06Obn22zw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4490B40364;
        Fri,  9 Jun 2023 18:16:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EDBC2A005E;
        Fri,  9 Jun 2023 18:16:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NdBvaouf;
        dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CED0040143;
        Fri,  9 Jun 2023 18:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjPt8wX0NujNbhZ6iCvYoK/LSzAF8ggmeRhqwFOp2AhIpdI4YkORbHsTuzOKj3CX/ulQFDARIQQLZQk+cc5pp0tbfOEU7P8iHsMt+GyVp455yHBI2STs32kgTLHRRknv9hCNdbGodutsti8rxi7Kgrc/ZB9OAilBWRLpJrHqVmwsanXF0JA4RES5Nc80y/K7iDUprWQjrA3hlQ1YeuQETq2yayJ3Vef+uSn8WQ5v8TiYE5mYY616DcAFijOnI9DO+ZMLJY8MnND56sh6LrXtTcEwbiUvLo/2z7zTXJCU3NhxzzXSfYgR8SrQxXeX2jvLQ+OMJ0EJvyUDjCmg3qy4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRBGRNrqyzdy5IOsYQyGhZSz0t/DUNjO12CnnPPDvWc=;
 b=nDsUkeZ9rI8S5osnB+Ns2ewe4EX1t9vfFqhJrAE8/3We6k3DP1WBP4TWT3VeAw3nmniVF6XJ8pMRBjL61WahJf0vF7JgbnpJesisLvan2hKpdsDN/140iOhXwRIR6ecMSnt8us3DpA2AeNAqeABBxfWXFnhpDT8Mim9ymMwsj3Lc9/4OkABl3MXDah2p9PzIsIXKHhga1TFcJWzjHiSaRXxPlMudgFQC67sGNjsjg0XXK0Z66fO8pfgi8hJDve7bM7Tv9KebqnisglWHdkiXxwiCq1rIlgtE1h9Q33wpO7/kiu1E0vHVNRezuR0b8csZNf6UvWaIkV6j0/ad93mhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRBGRNrqyzdy5IOsYQyGhZSz0t/DUNjO12CnnPPDvWc=;
 b=NdBvaoufq3J5SUUXaTXL4tFkPscnkV7pkSOQZ3sSmScBLe5F5S8iqrREQNN8puQSXTsZiw4OIxc0skjKtrKMJwIE53K9mAoABiXZx9j/xVfwJM+KEH33IpgC+9tTQbNPEx0K6hR3jIUxiABmkXWsPRJN6AtG9yvW9xTg9TMSvGg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 18:16:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 18:16:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Thread-Topic: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Thread-Index: AQHZhif6/qSXXM0dd0yowK/+LbRnLK9b7I4AgABAvwCAAoIhAIAEyu8AgBviTICAAInNAIAA6E6AgABfQACAACrxgIAA8LOAgACm7QA=
Date:   Fri, 9 Jun 2023 18:16:13 +0000
Message-ID: <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
References: <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
 <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
In-Reply-To: <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB7599:EE_
x-ms-office365-filtering-correlation-id: 079797b8-6515-4372-8bab-08db69159c4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZkufUyXy8N81BfLZmNLoAS1zK3WF3mfcjmZfG2IY/nudwHKzv8NmrmgNizOPT/p45hfuAAnNY/l2dlJy3HicsgzYAt8Hesx5Ett8B8NHEZRTqR0WxxV5uHtphBwyHgWXIBoCRn1hzC7sjfkJAD3tow+hHlyJ5jS7fUhd+7XvNqC/thp6yuprnHPRn1LsgSHJIuxisu+MoC/4sG45AP8DI5PVEXRSLRGTUJ73RGjkXQ3NTIkEOM99n+OABJldpRQCZ9pOSiQAmB8DQ9Ey6PHYDbRXrmFSHgWQ0kE3/b9R/3sPwnEwNcdJlyszUhCgPUxDMEOv5TN0ye/pn78U5QzCIUsOaszWbAlFLBkbfv9hFAgdW6/XyjwcxkzyaKUhDC+qdO0F0ZNTVv5zvy8ditPpqwwzyjxDUV6igcLPHAQtSTbJkmcGTis1Xq4wEf9B/JOqfyRrDk6DL1ACXW5YWa6ZfajSplpDgFHxMni0aUAJQxu7t1MwIYQrq4mDAf3iWAyS0FwSqvuLFJpjapT/+pEBr8luFHDIEZT5BkgmIKUmeSoMSguThvxgsbbzOXstZNNRH1bncbideSe3VPCLacCdYSQvp/MCoMTaBCjlbgPUK1mE5omtSjncVYi89KCY9A5tc25JHuGMLsAlEIyPQcbh8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(478600001)(54906003)(966005)(1076003)(5660300002)(41300700001)(316002)(6486002)(26005)(7416002)(4326008)(76116006)(6506007)(6916009)(64756008)(66446008)(66476007)(71200400001)(91956017)(66946007)(6512007)(66556008)(53546011)(2616005)(186003)(83380400001)(2906002)(122000001)(38100700002)(86362001)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHRZZWpnbXdVYXhMNzByeDF6WkVINGVZY2JBOXFWWG83aWR1N2JhZzhLdjhT?=
 =?utf-8?B?bDFsU2ZqVk5leVR3bWZJYXJpYWxMQkErV0JZek1HT1lqNnFLeFNDN3UzK2pl?=
 =?utf-8?B?aE9BWlhucFhNL2RiczJUdHlMcDdHWWZscVNLU0pmVjUxRXNCYkZtYTdYYzF4?=
 =?utf-8?B?SjM3bVdrRDd3Zk80QVFKZERkTDhlMmsrd3o1U3lDc0JpTTF0S0VGakVtNFA1?=
 =?utf-8?B?MGRkSjEvanRscTYraDN5THN6QzBNYnkvVXZnMFRzakpCekdIMVAyWk9CV3BK?=
 =?utf-8?B?QVRMQ0QrVGdsTzBoMDlab2V5MTJadkNSbmNGT0ZldWVJSVp5a0lWbmVRT3ZY?=
 =?utf-8?B?aXRoTU9CcW9sWCt3VEVrWGtvb0ZCZzhiWFR1RjdsYnZoWjlGV2RnT2V4RG1v?=
 =?utf-8?B?M2xyZXRIRldhWWZlNjlKQU5iR1hKelpLcGxSdGZZTkdsZVlxYmM2ckc2bnNs?=
 =?utf-8?B?aXBmODJ5aEM2dWh6T01RMTd6TzlNRzVOTVg1aWxwNVBiekdRUWE5b2lxWUhU?=
 =?utf-8?B?Nzh1b3pSOEVDcEowUUpIUlpTL0NOVnI3K2xZTTZvTXV2d3gxRHNTOHFsVkZj?=
 =?utf-8?B?djhac1E3VVRmUXExayt4cXMxakNPSWZNS0lEdmd1VVdmNngxdTM3eXRjUWVL?=
 =?utf-8?B?ZDRGcEhRbHBMM040d3BQWmp3N3ZQS2lRQUNCOGlCd2xPMElZWHRSdVVVZTFQ?=
 =?utf-8?B?Umk4Q1p5bGZGUzhzcVU2eitUNWk2a3hVWHJBMWlRakRMWnZZZjZ6UTErZlNM?=
 =?utf-8?B?b0VldGFaTzJkL1dwTmRiTlZXTlVDZ2pjaCtOSWJlUVBQajh3RGNKTGlLQlFB?=
 =?utf-8?B?TzFaeHhORk5zNVFkazAvUDZhMHNGc09DNTZvUW56RWhuYU9vSjhUQ2RScCtW?=
 =?utf-8?B?cDE0bjE5ZTA3enh3NWdUQmw4YWY0UUVhTWRiRWlDeVpMTURnUis3dHZlMHY1?=
 =?utf-8?B?eS9PalVvditGdlYrd1d5MzI0NXV5T2tDdmR0VjRESGpRYUc4RHN3RkpKUjdH?=
 =?utf-8?B?c05TQjJBWHZNTFBNTUMxd3crNDQvbGdtb2U2VFdVK3lvbTBQYzQ4QU1WNzBz?=
 =?utf-8?B?dEIvNXQ5dzNDcktYQzR1OVNTRUkxMEVsYzVDZGZiZUpGK2FSTlpMdWQ1bmhD?=
 =?utf-8?B?dTNkcWFRdkJMdkh4dkovK2M0bEFSRHB4aUhjbHU4czMvblJFekI3MjRGTlVB?=
 =?utf-8?B?bTVvMUovSTduUDU2NFBMb0dnUTNxK2wrWUt0azZjOUxsMTRSdjQ3OE1nVDNm?=
 =?utf-8?B?cndwbnQ5UjZEampsN1dMWEJWVTVUT0IyV0FraTRPMGVtUTA1SjE3Q296WFJw?=
 =?utf-8?B?QVZUU0h4NU5TdFV0dzVoY2tyM3ArdmhUYTBjdXh2OVRaQ0xGYnY2dUtpN0xC?=
 =?utf-8?B?WTh6ZXFCbE1tUlFSWklUMktXS3pLcitpbjROUlJOc05DVDdsejJUYkRhZTlO?=
 =?utf-8?B?ZVBwb3A5d1FpSGEwUlNOSHpiWFlPYTV3K0FxM1ZKdjV5OUVBYXh4MlI3Y29s?=
 =?utf-8?B?Nmk4U3BscFBFQjVCSnVmZWpFNnY1KzVJcENzS1FRbStMUmU4UEh0NzNnTGNZ?=
 =?utf-8?B?WmxjMEJBMTRKU2xZbEZvanNHeEJtYmoxS25ES1RHenhRQW50MURDcXlveklN?=
 =?utf-8?B?OHhoY1QrdlE3THhCTUdvMVZ2YVlLa1BSUWNPWXJHS3hsWGlMdWxnTFV2RTNV?=
 =?utf-8?B?TkxnelZyandvRHY1ZDl2bFVmbUM2TGQ1VzFSMlNDK3laOUtDNk5nZkc2RkxE?=
 =?utf-8?B?QmtCdklUa0l4OUZuYS9JVWpOU1FJb3ozOHA0MzJrS01NTTFyUkNSTGdKMEJO?=
 =?utf-8?B?NzNGVldoSmtId3Uyc0VYQml3UG1yVU9zZlltanJCN0JCWlZvbk96OHpldEVt?=
 =?utf-8?B?aW1wQStQVEpySzhJekM3ZGRaT0I4WSthcWp2K3E5RldlYVFadis0cmdPdGM1?=
 =?utf-8?B?bmIxVDlxUGNqanlPeStJRkplRTJ0MGlRMGc0NHZkV2pKaVNjY1UycjJUaHZu?=
 =?utf-8?B?bnAvUmlwVWZmUmpJczFnc2JpdVgydVF6TkdXVjZNeXM2YytyTitub014d3du?=
 =?utf-8?B?eElqRENOanN6S1FTOGEwM2lZS01PazFRVlo4MTI5MkxDenJRNXJhTlhGVnAz?=
 =?utf-8?Q?ZAhTbs2qnTd74DofIbQEhdwQa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBB33752EB3C4144858D38F5A89F0817@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Y01UTmliREZxNnlxZldPNFYxS3pFRmlwbXI2Rnppejc4Smh3cHhVdHJ5Y3Na?=
 =?utf-8?B?a2IzVkJCZ2Vmb2VCSjR1UHlic0JTTXUySllRRmtIUGRYYytlcXNCb2hTT1Bp?=
 =?utf-8?B?bFN6U2RDL3p4dzZpLzAzRjdnd3ZCTVJBdFVhd0t6a2tMV0pTMm9rQUljaHFV?=
 =?utf-8?B?K2I0bFkwRkxkNjM3VnFkQUlVUEFwd0JSVjdRMCtzT1U5ck9DQS9Ka1Rkc0tT?=
 =?utf-8?B?NHRuK3kzcVl6cXFEb05CeEN0TUpBdFpzYUpwQVVkbk5QTGxER203aDMxQ01X?=
 =?utf-8?B?WjB4NkpFK3hqMlUySm1qU0x0SnRGblhhWmswdzJSc2FRQjQ3di9VVERQNWVo?=
 =?utf-8?B?UkRhWXZjbWozaXlkcnhPNFZYS0FBTkhjaFVBSXVPWkNqTy9tZnBxQVJ0Zmsw?=
 =?utf-8?B?eTFXS1hDNGMzNldVcVVwaTQrUjFwR0RHSTFrQWR6c2NYZDdMYzdMUGo4KzJr?=
 =?utf-8?B?c2xxTUhrZmg3YTRRWFFkd2VjNUVUeVlrN1BUd0JuanZxMTFSODVBemY4UEhq?=
 =?utf-8?B?QzhXd3I5L0xaSGtLNGs1Y0szVWlxVnd6NGd5U0NONGM5a0ZxYlJnMWxnMXFj?=
 =?utf-8?B?aStTYnpSRldiZWpBd0hKdTBSNUJPMUxJT3V3NFhIYjJXRWxEQ0pwTGJQVGRH?=
 =?utf-8?B?NHN0eWJWS1RzVFNobDFaOUJObEdIMjZxRDZ5SWw4T0RJd25Ga25sVitlM25r?=
 =?utf-8?B?STBlODYwNzhqc2k4MUE3aWNZM2UwY3hVY05iNmY4Wkp5Q3JvZFltUGhQekFp?=
 =?utf-8?B?cFJCU1RYV3VnRmZvVkhJMGxQMEc2cmNmTlV2V2hJc1NJRXFCK1UxSUNXSy8y?=
 =?utf-8?B?TERHMnhBSlpkSUpDMHdDbGNTdTJvYW1WSmwxaVlGMmtGa1dJMjdkQ2tNZ3Np?=
 =?utf-8?B?K2JRazJ6dCsxeUQ1SkR0UDFzdW5aS05qWHBLaDdoQlB5RjVvMWsxS3B2OFNq?=
 =?utf-8?B?SnJjY0hYOG9IY2JvcW0xOFpBRGcwcW16RGxGUUg5YndPNzhNc0hjcE5LTmU0?=
 =?utf-8?B?Ujg1MFhlVndtSnEwY0lHd1l6NXl1T0tnRC9DODJub0F0OHVlUGQ1M2gyVlY3?=
 =?utf-8?B?TXhpYVVRUWhUbWZKUUxpeU5jZzFMMFl1SWJVZ0VYS3JVK1dJQ1hOTXRLY0Q4?=
 =?utf-8?B?ZG52SlJHeVh4eExvcFpIVWlCV3dOTmtVaVp6SkRIZU1tVm5tMDZYcTRZUVpq?=
 =?utf-8?B?QmRjR2pzVnEybXZ2TDMxcSsweE9CQW82WVlKRVBlUnRpOWIwTEZLeElXMFl2?=
 =?utf-8?B?bTE3U3hkNm9XSThPUTg3TmhLcGpGa0FkUzV0M2VESkhkaG9sZk9RZnowM2tu?=
 =?utf-8?B?dWY2RXF0VDEyeE5XSldsR29UVkVZdUo5NjdhQk5haW5XWFlpT0kzZE82bjZ3?=
 =?utf-8?B?NS9uWEJwQjZaZ0E9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079797b8-6515-4372-8bab-08db69159c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 18:16:14.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RG56WE/idVAFTPhRYT4lDdAwUe0nn88+JxSloJ1R7tZJjdi+SR7rLUorAeuoO0m+waBrAO9NXRjm62LBWZZ72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
X-Proofpoint-GUID: HEZr_VpG3PivjY39arbmumW7HHv03vEA
X-Proofpoint-ORIG-GUID: HEZr_VpG3PivjY39arbmumW7HHv03vEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_12,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMDksIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MDgsIDIwMjMgYXQgMDU6NTc6MjNQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9u
IFRodSwgSnVuIDA4LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4g
T24gNi84LzIwMjMgMzoxMiBQTSwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUs
IEp1biAwOCwgMjAyMyBhdCAwMToyMTowMkFNICswNTMwLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05W
IHdyb3RlOg0KPiA+ID4gPiA+IE9uIDYvNy8yMDIzIDU6MDcgUE0sIEpvaGFuIEhvdm9sZCB3cm90
ZToNCj4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTbyB0aGVyZSBhdCBsZWFzdCB0d28gaXNzdWVzIHdp
dGggdGhpcyBzZXJpZXM6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IAkxLiBhY2Nlc3Npbmcg
eGhjaSByZWdpc3RlcnMgZnJvbSB0aGUgZHdjMyBjb3JlDQo+ID4gPiA+ID4gPiAJMi4gYWNjZXNz
aW5nIGRyaXZlciBkYXRhIG9mIGEgY2hpbGQgZGV2aWNlDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IDEuIFRoZSBmaXJzdCBwYXJ0IGFib3V0IGFjY2Vzc2luZyB4aGNpIHJlZ2lzdGVycyBnb2Vz
IGFnYWluc3QgdGhlIGNsZWFyDQo+ID4gPiA+ID4gPiBzZXBhcmF0aW9uIGJldHdlZW4gZ2x1ZSwg
Y29yZSBhbmQgeGhjaSB0aGF0IEZlbGlwZSB0cmllZCB0byBtYWludGFpbi4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gSSdtIG5vdCBlbnRpcmVseSBhZ2FpbnN0IGRvaW5nIHRoaXMgZnJvbSB0
aGUgY29yZSBkcml2ZXIgYmVmb3JlDQo+ID4gPiA+ID4gPiByZWdpc3RlcmluZyB0aGUgeGhjaSBw
bGF0Zm9ybSBkZXZpY2UgYXMgdGhlIHJlZ2lzdGVycyBhcmUgdW5tYXBwZWQNCj4gPiA+ID4gPiA+
IGFmdGVyd2FyZHMuIEJ1dCBpZiB0aGlzIGlzIHRvIGJlIGFsbG93ZWQsIHRoZW4gdGhlIGltcGxl
bWVudGF0aW9uIHNob3VsZA0KPiA+ID4gPiA+ID4gYmUgc2hhcmVkIHdpdGggeGhjaSByYXRoZXIg
dGhhbiBjb3BpZWQgdmVyYmF0aW0uDQo+ID4gDQo+ID4gVGhlIGNvcmUgd2lsbCBqdXN0IGJlIGxv
b2tpbmcgYXQgdGhlIEhXIGNhcGFiaWxpdHkgcmVnaXN0ZXJzIGFuZA0KPiA+IGFjY2Vzc2luZyB0
aGUgcG9ydHMgY2FwYWJpbGl0eS4gT3VyIHByb2dyYW1taW5nIGd1aWRlIGFsc28gbGlzdGVkIHRo
ZQ0KPiA+IGhvc3QgY2FwYWJpbGl0eSByZWdpc3RlcnMgaW4gaXRzIGRvY3VtZW50YXRpb24uIFdl
J3JlIG5vdCBkcml2aW5nIHRoZQ0KPiA+IHhoY2kgY29udHJvbGxlciBoZXJlLiBXZSdyZSBpbml0
aWFsaXppbmcgc29tZSBvZiB0aGUgY29yZSBjb25maWdzIGJhc2UNCj4gPiBvbiBpdHMgY2FwYWJp
bGl0eS4NCj4gPiANCj4gPiBXZSdyZSBkdXBsaWNhdGluZyB0aGUgbG9naWMgaGVyZSBhbmQgbm90
IGV4YWN0bHkgZG9pbmcgaXQgdmVyYmF0aW0uDQo+ID4gTGV0J3MgdHJ5IG5vdCB0byBzaGFyZSB0
aGUgd2hvbGUgeGhjaSBoZWFkZXIgd2hlcmUgd2Ugc2hvdWxkIG5vdCBoYXZlDQo+ID4gdmlzaWJp
bGl0eSBvdmVyLiBQZXJoYXBzIGl0IG1ha2VzIHNlbnNlIGluIHNvbWUgb3RoZXIgZHJpdmVyLCBi
dXQgbGV0J3MNCj4gPiBub3QgZG8gaXQgaGVyZS4NCj4gDQo+IFRoZSBwYXRjaCBzZXJpZXMgZXZl
biBjb3BpZWQgdGhlIGtlcm5lbCBkb2MgdmVyYmF0aW0uIFRoaXMgaXMganVzdCBub3QNCj4gdGhl
IHdheSB0aGluZ3MgYXJlIHN1cHBvc2VkIHRvIGJlIGRvbmUgdXBzdHJlYW0uIFdlIHNoYXJlIGRl
ZmluZXMgYW5kDQo+IGltcGxlbWVudGF0aW9ucyBhbGwgdGhlIHRpbWUsIGJ1dCB3ZSBzaG91bGQg
bm90IGJlIG1ha2luZyBjb3BpZXMgb2YNCj4gdGhlbS4NCg0KIFdlIGhhZCBzb21lIGZpeGVzIHRv
IHRoZSBrZXJuZWwgZG9jIGFzIGl0J3MgaW5jb3JyZWN0IGRlc2NyaXB0aW9uLg0KIFBlcmhhcHMg
d2UgY2FuIGZ1bGx5IHJld3JpdGUgdGhlIGtlcm5lbC1kb2MgaWYgdGhhdCB3aGF0IG1ha2VzIGl0
DQogYmV0dGVyLiBXZSBjYW4gc2hhcmUgZGVmaW5lIGltcGxlbWVudGF0aW9ucyBpZiB0aGV5IGFy
ZSBtZWFudCB0byBiZQ0KIHNoYXJlZC4gSG93ZXZlciwgd2l0aCB0aGUgY3VycmVudCB3YXkgeGhj
aSBoZWFkZXIgaXMgaW1wbGVtZW50ZWQsIGl0J3MNCiBub3QgbWVhbnQgdG8gYmUgc2hhcmVkIHdp
dGggZHdjMy4gWW91IGFncmVlZCB0aGF0IHdlIGFyZSB2aW9sYXRpbmcgdGhpcw0KIGluIHNvbWUg
ZHJpdmVyLCBidXQgeW91J3JlIGFsc28gaW5zaXN0ZW50IHRoYXQgd2Ugc2hvdWxkIG5vdCBkdXBs
aWNhdGUNCiB0aGUgbG9naWMgdG8gYXZvaWQgdGhpcyB2aW9sYXRpb24uIFBlcmhhcHMgSSdtIG5v
dCBhIG1haW50YWluZXIgaGVyZQ0KIGxvbmcgZW5vdWdoIHRvIGtub3cgc29tZSB2aW9sYXRpb24g
aXMgYmV0dGVyIGtlcHQuIElmIHNoYXJpbmcgdGhlIHhoY2kNCiBoZWFkZXIgaXMgd2hhdCBpdCB0
YWtlcyB0byBnZXQgdGhpcyB0aHJvdWdoLCB0aGVuIGZpbmUuDQoNCj4gDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IFRoZSBhbHRlcm5hdGl2ZSB0aGF0IGF2b2lkcyB0aGlzIGlzc3VlIGVudGly
ZWx5IGNvdWxkIGluZGVlZCBiZSB0bw0KPiA+ID4gPiA+ID4gc2ltcGx5IGNvdW50IHRoZSBudW1i
ZXIgb2YgUEhZcyBkZXNjcmliZWQgaW4gRFQgYXMgUm9iIGluaXRpYWxseQ0KPiA+ID4gPiA+ID4g
c3VnZ2VzdGVkLiBXaHkgd291bGQgdGhhdCBub3Qgd29yaz8NCj4gPiANCj4gPiBTZWUgYmVsb3cu
DQo+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgcmVhc29uIHdoeSBJIGRpZG4ndCB3
YW50IHRvIHJlYWQgdGhlIFBoeSdzIGZyb20gRFQgaXMgZXhwbGFpbmVkIGluDQo+ID4gPiA+ID4g
WzFdLiBJIGZlbHQgaXQgbWFrZXMgdGhlIGNvZGUgdW5yZWFkYWJsZSBhbmQgaXRzIHZlcnkgdHJp
Y2t5IHRvIHJlYWQgdGhlDQo+ID4gPiA+ID4gcGh5J3MgcHJvcGVybHksIHNvIHdlIGRlY2lkZWQg
d2Ugd291bGQgaW5pdGlhbGl6ZSBwaHkncyBmb3IgYWxsIHBvcnRzDQo+ID4gPiA+ID4gYW5kIGlm
IGEgcGh5IGlzIG1pc3NpbmcgaW4gRFQsIHRoZSBjb3JyZXNwb25kaW5nIG1lbWJlciBpbg0KPiA+
ID4gPiA+IGR3Yy0+dXNiWF9nZW5lcmljX3BoeVtdIHdvdWxkIGJlIE5VTEwgYW5kIGFueSBwaHkg
b3Agb24gaXQgd291bGQgYmUgYSBOT1AuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IGRvZXNuJ3Qg
c291bmQgdG9vIGNvbnZpbmNpbmcuIENhbid0IHlvdSBqdXN0IGl0ZXJhdGUgb3ZlciB0aGUgUEhZ
cw0KPiA+ID4gPiBkZXNjcmliZWQgaW4gRFQgYW5kIGRldGVybWluZSB0aGUgbWF4aW11bSBwb3J0
IG51bWJlciB1c2VkIGZvciBIUyBhbmQNCj4gPiA+ID4gU1M/DQo+ID4gPiA+ID4gQWxzbyBhcyBw
ZXIgS3J6eXN6dG9mIHN1Z2dlc3Rpb24gb24gWzJdLCB3ZSBjYW4gYWRkIGEgY29tcGF0aWJsZSB0
byByZWFkDQo+ID4gPiA+ID4gbnVtYmVyIG9mIHBoeSdzIC8gcG9ydHMgcHJlc2VudC4gVGhpcyBh
dm9pZHMgYWNjZXNzaW5nIHhoY2kgbWVtYmVycw0KPiA+ID4gPiA+IGF0bGVhc3QgaW4gZHJpdmVy
IGNvcmUuIEJ1dCB0aGUgbGF5ZXJpbmcgdmlvbGF0aW9ucyB3b3VsZCBzdGlsbCBiZSBwcmVzZW50
Lg0KPiA+ID4gPiANCj4gPiA+ID4gWWVzLCBidXQgaWYgdGhlIGluZm9ybWF0aW9uIGlzIGFscmVh
ZHkgYXZhaWxhYmxlIGluIERUIGl0J3MgYmV0dGVyIHRvIHVzZQ0KPiA+ID4gPiBpdCByYXRoZXIg
dGhhbiByZS1lbmNvZGUgaXQgaW4gdGhlIGRyaXZlci4NCj4gDQo+ID4gPiAgIEFyZSB5b3Ugc3Vn
Z2VzdGluZyB0aGF0IHdlIGp1c3QgZG8gc29tZXRoaW5nIGxpa2UNCj4gPiA+IG51bV9wb3J0cyA9
IG1heCggaGlnaGVzdCB1c2IyIHBvcnRudW0sIGhpZ2hlc3QgdXNiMyBwb3J0IG51bSkNCj4gPiAN
Cj4gPiBXaHkgZG8gd2Ugd2FudCB0byBkbyB0aGlzPyBUaGlzIG1ha2VzIG51bV9wb3J0cyBhbWJp
Z3VvdXMuIExldCdzIG5vdA0KPiA+IHNhY3JpZmljZSBjbGFyaXR5IGZvciBzb21lIGxpbmVzIG9m
IGNvZGUuDQo+IA0KPiBUaGlzIGlzIG5vdCBhYm91dCBsaW5lcyBvZiBjb2RlLCBidXQgYXZvaWRp
bmcgdGhlIGJhZCBwcmFjdGljZSBvZg0KPiBjb3B5aW5nIGNvZGUgYXJvdW5kIGFuZCwgdG8gc29t
ZSBkZWdyZWUsIG1haW50YWluaW5nIHRoZSBzZXBhcmF0aW9uDQo+IGJldHdlZW4gdGhlIGdsdWUs
IGNvcmUsIGFuZCB4aGNpIHdoaWNoIEZlbGlwZSAocGVyaGFwcyBtaXN0YWtpbmdseSkgaGFzDQo+
IGZvdWdodCBmb3IuDQoNCldlJ3JlIHRhbGtpbmcgYWJvdXQgY29tYmluaW5nIG51bV91c2IzX3Bv
cnRzIGFuZCBudW1fdXNiMl9wb3J0cyBoZXJlLA0Kd2hhdCBkb2VzIHRoYXQgaGF2ZSB0byBkbyB3
aXRoIGxheWVyIHNlcGFyYXRpb24/DQoNCj4gDQo+IElmIHlvdSBqdXN0IG5lZWQgdG8ga25vdyBo
b3cgbWFueSBQSFlzIHlvdSBoYXZlIGluIERUIHNvIHRoYXQgeW91IGNhbg0KPiBpdGVyYXRlIG92
ZXIgdGhhdCBpbnRlcm5hbCBhcnJheSwgeW91IGNhbiBqdXN0IGxvb2sgYXQgdGhlIG1heCBpbmRl
eCBpbg0KPiBEVCB3aGVyZSB0aGUgaW5kZXhlcyBhcmUgc3BlY2lmaWVkIGluIHRoZSBmaXJzdCBw
bGFjZS4NCj4gDQo+IERvbid0IGdldCBodW5nIHVwIG9uIHRoZSBjdXJyZW50IHZhcmlhYmxlIG5h
bWVzLCB0aG9zZSBjYW4gYmUgcmVuYW1lZCB0bw0KPiBtYXRjaCB0aGUgaW1wbGVtZW50YXRpb24u
IENhbGwgaXQgbWF4X3BvcnRzIG9yIHdoYXRldmVyLg0KDQpJdCBkb2Vzbid0IG1hdHRlciB3aGF0
IHZhcmlhYmxlIG5hbWUgaXMgZ2l2ZW4sIGl0IGRvZXNuJ3QgY2hhbmdlIHRoZQ0KZmFjdCB0aGF0
IHRoaXMgIm51bV9wb3J0cyIgb3IgIm1heF9wb3J0cyIgb2JmdXNjYXRlZCB1c2IyIHZzIHVzYjMg
cG9ydHMNCmp1c3QgZm9yIHRoaXMgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24uIFNvLCBkb24ndCBk
byB0aGF0Lg0KDQo+IA0KPiA+ID4gSWYgc28sIGluY2FzZSB0aGUgdXNiMiBwaHkgb2YgcXVhZCBw
b3J0IGNvbnRyb2xsZXIgaXMgbWlzc2luZyBpbiBEVCwgd2UNCj4gPiA+IHdvdWxkIHN0aWxsIHJl
YWQgbnVtX3VzYjJfcG9ydHMgYXMgNCBidXQgdGhlIHVzYjJfZ2VuZXJpY19waHlbMV0gd291bGQg
YmUNCj4gPiA+IE5VTEwgYW5kIGFueSBwaHkgb3BzIHdvdWxkIHN0aWxsIGJlIE5PUC4gQnV0IHdl
IHdvdWxkIGJlIGdldHRpbmcgcmlkIG9mDQo+ID4gPiByZWFkaW5nIHRoZSB4aGNpIHJlZ2lzdGVy
cyBjb21wZWx0ZWx5IGluIGNvcmUgZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBUaGluaCwgQmpvcm4s
IGNhbiB5b3UgYWxzbyBsZXQgdXMga25vdyB5b3VyIHZpZXdzIG9uIHRoaXMuDQo+ID4gPiANCj4g
PiA+IDEuIFJlYWQ6DQo+ID4gPiAgIG51bV91c2IzX3BvcnRzID0gaGlnaGVzdCB1c2IzIHBvcnQg
aW5kZXggaW4gRFQNCj4gPiA+ICAgbnVtX3VzYjJfcG9ydHMgPSBtYXgoIGhpZ2hlc3QgdXNiMiBw
b3J0IGluZGV4LCBudW1fdXNiM19wb3J0cykNCj4gPiA+IA0KPiA+ID4gMi4gUmVhZCB0aGUgc2Ft
ZSBieSBwYXJzaW5nIHhoY2kgcmVnaXN0ZXJzIGFzIGRvbmUgaW4gcmVjZW50IHZlcnNpb25zIG9m
DQo+ID4gPiB0aGlzIHNlcmllcy4NCj4gPiANCj4gPiBEVCBpcyBub3QgcmVsaWFibGUgdG8gZ2V0
IHRoaXMgaW5mby4gQXMgbm90ZWQsIHRoZSBEVCBtYXkgc2tpcCBzb21lDQo+ID4gcG9ydHMgYW5k
IHN0aWxsIGJlIGZpbmUuIEhvd2V2ZXIsIHRoZSBkcml2ZXIgZG9lc24ndCBrbm93IHdoaWNoIHBv
cnQNCj4gPiByZWZsZWN0cyB3aGljaCBwb3J0IGNvbmZpZyBpbmRleCB3aXRob3V0IHRoZSBleGFj
dCBwb3J0IGNvdW50Lg0KPiANCj4gVGhhdCdzIG5vdCBjb3JyZWN0LiBEVCBwcm92aWRlcyB0aGUg
cG9ydCBpbmRleGVzIGFscmVhZHksIGZvciBleGFtcGxlOg0KPiANCj4gCXBoeS1uYW1lcyA9ICJ1
c2IyLXBvcnQwIiwgInVzYjMtcG9ydDAiLA0KPiAJCSAgICAidXNiMi1wb3J0MSIsICJ1c2IzLXBv
cnQxIiwNCj4gCQkgICAgInVzYjItcG9ydDIiLA0KPiAJCSAgICAidXNiMi1wb3J0MyI7DQo+IA0K
PiBTbyBpZiB5b3UganVzdCBuZWVkIHRoaXMgdG8gaXRlcmF0ZSBvdmVyIHRoZSBQSFlzIGFsbCB0
aGUgaW5mb3JtYXRpb24NCj4gbmVlZGVkIGlzIGhlcmUuDQo+IA0KPiBJZiB5b3UgbmVlZCB0byBh
Y2Nlc3MgcG9ydHMgd2hpY2ggZG8gbm90IGhhdmUgYSBQSFkgZGVzY3JpYmVkIGluIERULA0KPiB0
aGVuIHRoaXMgaXMgbm90IGdvaW5nIHRvIHN1ZmZpY2UsIGJ1dCBJIGhhdmUgbm90IHNlZW4gYW55
b25lIGNsYWltIHRoYXQNCj4gdGhhdCBpcyBuZWVkZWQgeWV0Lg0KDQpQZXJoYXBzIEkgbWlzdW5k
ZXJzdGFuZCB0aGUgY29udmVyc2F0aW9uLiBIb3dldmVyLCB0aGVyZSBpc24ndCBhIG1ldGhvZA0K
dGhhdCBldmVyeW9uZSdzIGFncmVlIG9uIHlldCByZWdhcmRpbmcgRFQgWypdLiBQZXJoYXBzIHRo
aXMgaW5kaWNhdGVzIGl0DQptYXkgbm90IGJlIHRoZSBiZXN0IGFwcHJvYWNoLiBZb3UgY2FuIHJl
c3VtZSB0aGUgY29udmVyc2F0aW9uIGlmIHlvdQ0Kd2FudCB0bzoNCg0KWypdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXVzYi85NjcxY2FkZS0xODIwLTIyZTEtOWRiOS01Yzk4MzY0MTQ5
MDhAcXVpY2luYy5jb20vI3QNCg0KPiAgDQo+ID4gTW9yZSBpbXBvcnRhbnRseSwgdGhlIGhvc3Qg
Y29udHJvbGxlciB0aGF0IGxpdmVzIG9uIHRoZSBQQ0kgYnVzIHdpbGwgbm90DQo+ID4gdXNlIERU
LiBUaGlzIGNhbiBiZSB1c2VmdWwgZm9yIHNvbWUgcmUtY29uZmlndXJhdGlvbnMgaWYgdGhlIGNv
bnRyb2xsZXINCj4gPiBpcyBhIFBDSSBkZXZpY2UgYW5kIHRoYXQgZ29lcyB0aHJvdWdoIHRoZSBk
d2MzIGNvZGUgcGF0aC4NCj4gDQo+IE9rLCB0aGlzIGlzIGEgYml0IGhhbmQgd2F2eSwgYnV0IGlm
IHRoaXMgZXZlciB0dXJucyBvdXQgdG8gYmUgbmVlZGVkIGl0DQo+IGNhbiBhbHNvIGJlIGltcGxl
bWVudGVkIHRoZW4uDQoNCldoYXQgZG9lcyBoYW5kIHdhdnkgbWVhbj8gV2UgaGF2ZSBjYXNlIHdo
ZXJlIGl0J3MgdXNlZnVsIG91dHNpZGUgb2YNCnRoaXMsIGFuZCBpdCB3b3VsZCBiZSB1c2VmdWwg
Zm9yIFBDSSBkZXZpY2UgdG9vOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2Iv
MjAyMzA1MTcyMzMyMTgucmpmbXZwdHJleGdrcGFtM0BzeW5vcHN5cy5jb20vDQoNCj4gDQo+IE9y
IGp1c3QgZ2VuZXJhbGlzZSB0aGUgeGhjaSBpbXBsZW1lbnRhdGlvbiBmb3IgcGFyc2luZyB0aGVz
ZSByZWdpc3RlcnMNCj4gYW5kIHJldXNlIHRoYXQgZnJvbSB0aGUgc3RhcnQuIChBcyBhIGJvbnVz
IHlvdSdkIHNocmluayB0aGUga2VybmVsIHRleHQNCj4gc2l6ZSBieSBnZXR0aW5nIHJpZCBvZiB0
aGF0IGlmZnkgaW5saW5lIGltcGxlbWVudGF0aW9uLikNCj4gDQoNCkkgZG9uJ3QgbGlrZSB0aGUg
aWZmeSBpbmxpbmUgZnVuY3Rpb24gZWl0aGVyLiBXZSBjaGFuZ2VkIHRoYXQgaGVyZS4gVG8NCnJl
d29yayB0aGUgeGhjaSBoZWFkZXIgYW5kIGRlZmluZSBpdHMgZ2xvYmFsIGhlYWRlciBzZWVtcyBh
IGJpdA0KZXhjZXNzaXZlIGp1c3QgZm9yIGR3YzMgdG8gZ2V0IHRoZSBwb3J0IGNhcGFiaWxpdHku
IFJlZ2FyZGxlc3MsIGFzIEkndmUNCnNhaWQsIGlmIHdlIF9tdXN0XywgcGVyaGFwcyB3ZSBjYW4g
anVzdCBpbXBvcnQgeGhjaS1leHQtY2Fwcy5oIGluc3RlYWQNCm9mIHRoZSB3aG9sZSB4aGNpLmgu
DQoNCkJSLA0KVGhpbmg=

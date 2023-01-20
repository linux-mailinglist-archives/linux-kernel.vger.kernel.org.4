Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DDB6760D8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjATW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjATW61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:58:27 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA269EB61;
        Fri, 20 Jan 2023 14:58:01 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KM6bLj013792;
        Fri, 20 Jan 2023 14:57:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=DYbUlFEUiofi1JN6RBnFN/KHLfo6+WyOEe05sxpSPRA=;
 b=H21tSaoDETLqTKBFJQmR+nR0zgpSfDieaZh4mUGD/zjHV6EtY+0xIRvIb9X/fnmTF1SJ
 hGttW1xd/0C7WJq/RpywyswRCZJl2Eq/dQuLpRIWznxKXZdMcH5AvXYxwV8G0Wj9Rvpj
 CDgsUJu+yRibZi6NakbfL7RxSEal6OnLn89FXOC0BUmF/Pq9IS3kgpfVgNbaLpBcjJLj
 dtxe2GZqzX6gUTtPRa8blWOFTgy7LRHM7wMXIkIhTHVpMGvFy2Wf5nktq+D53gZDS3nq
 absN/YuKnemSa5N44NKI/tbVBg+J/uEPbqh1ta52RB8nUPw3LMJk8H02urgFy14KZIHW FQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3v9ssn8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:57:35 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3AF73C098D;
        Fri, 20 Jan 2023 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674255455; bh=DYbUlFEUiofi1JN6RBnFN/KHLfo6+WyOEe05sxpSPRA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VyxoIs/fNw4X++LOznfZRGXNF0bl7hd02HmMe94+cYG0m60BXo+DuSuLiGIwAv/ST
         ak0JZr45f+TWMvDs+bQsM6dMI7a4jTDCESv3vpTAv8TcbMH0zMxIU9IlXPejzp9FBt
         kDzGrsQs8fPOZQQiU34GUJD5SebR9lSMT10OB34IISj21ROQQ0Blp0qIfH6nx1I8J9
         iF9/dmisN9pVttw+scbRkxe6rMRZiDr0wtcPIm0AtN6kMbCHdrzDoNY6iaf1KyHFGx
         f2/yz5aXs6DmSaVjhn3qSxUMJAvIm6cBny43tHRxpZITKkWdAQszgLqC2FMc3t5F+S
         NUpZm6U8jga7A==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3BE38A006E;
        Fri, 20 Jan 2023 22:57:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 01B2E400BF;
        Fri, 20 Jan 2023 22:57:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="w+sxK5nv";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv2njZEw55vhRzfRtDnZ72ZkYlREMWqhmFCEMgt3QogrTZcCVsGRqxlnO6KFGsnOxSW887Z/jYWJOQKfzioxt0xxAYzWTuHh59QfR0phXUa2YnmDR1j8WQ85gdZhkIHBNCe8zjbxCQ8dTUtwsHhQHBRNP8+Yu+vrmt6OGgsuFp7hb6Y5UFNRKSu8wOTYsghVFPJ8RjxxzAZxZWSElumpvhUEUb2ASq6M8AyL4PIHmEFHG2vi2Q7feZ14qgp1bhvyXm2mflwvIJb/Jz+yTfx1zgr8lwaf06lWQBsTpnvxEhNGRLC6qGBKUbN+/iLf9cJ8l9V6+0qd9rg6iwkE3io6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYbUlFEUiofi1JN6RBnFN/KHLfo6+WyOEe05sxpSPRA=;
 b=ODizfGhpco5JnoMUQemXxgp2WNoWr8rLwQGh5EQZ9gncNgB4RhSVg9oBB0RBKucEcnR3y49ff7JzfdMjVbZ0WDnAhjSgTQeK0V+Upo7As2hv6zbGzOhTB0kqViEx2q7peqSe//GkNsle4fzuXj6rhlJ341AmEv8c0+A3ou1SyuGEatB1pxWjJhSI4jk4Wzu26UC49I/jUxh6l6PHvSJgrupC228viIlmtI47eDgokrT3FocOM/e59hsXKQwj+cf9cKeTzU4SyoNgoRSgZ8hhD/xYGc6x+ir/pPYgmKL8a0gqZGfn6k21KUSEuYO4arcGftgsOb2zyaiJ6dHJeGBfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYbUlFEUiofi1JN6RBnFN/KHLfo6+WyOEe05sxpSPRA=;
 b=w+sxK5nv+fLoot0wWvRMaOaxd/k0LKgghR16xcwQwjSiCtNdOrBEzWhlxeBuDmcZH95JgOQbGElLp9eycPyeTz16i4KyrzikhpNa8kyNC6uwT3oYeUAT08baz4DZTOqjHw/I44qhJuNeDMu/2EXfZfPXxvkowTP6m+kl2Kpsg9A=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 22:57:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Fri, 20 Jan 2023
 22:57:28 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAMJAIA=
Date:   Fri, 20 Jan 2023 22:57:28 +0000
Message-ID: <20230120225719.3xau7vwlzxrtbnad@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
In-Reply-To: <20230119003619.ane3weigd4ebsta6@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB7715:EE_
x-ms-office365-filtering-correlation-id: 366c5ea2-c46f-4109-a295-08dafb39b446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+lI8bRisdWIRxD14YoiT/aZbdjRfQYCZejomZ1nc74mWFFO8CmRODdVjOCatk4qAnU8UEx19n4szCTMjpwQUr5LA28SF2hqJJxxzB9U+JejLvAWznjmKiZaFHMseD8fScbZUNUaCaytq7TwKC6hTeovU3tf5qDkGqAhF3L1L9plitvzjXP6+gVokTazQZRSNwaMkLdUpMcvEA1TrL8/J+8xC4bo6Uj6e6VbV+wm6I+LCXQskbvHoDV3sZ7uer6tQXGvneWczSrA3+/IDTUiu1MC1KdzyvqaT0i0uB+UwYDCBU66eBAnad76NRLFeOgQyU//Pt6gaN7cWpu1fBfPLxr2r7AnXaL5rvUjCliE88RgDejE7LaOfcZjhmI/chcK/X7KIcmzQfpMkYI58+0PspH1UWRebfqBxDwq9XTjHBDOAP9PL3/TdTDhaAu6fsObqlD2dzGXL4at5R0TgcF5wYu5ii+UrxcCnkCHAYrbxLKkmNXCAcOhEuJGLR6aMhKZ5CL7JBmarl1wAtBWCQowQeTVTSJ4UZUrC3jJegn0JqBhzX95Y4mdvdzhTbrWNtwv6PKlw2HF+E8GZHqMXKhPUcoaSt5IhsVAGLr9L+ObQw5uDvWWSUbP0He4LLlU/SjNA/0VIFuSNLMvg4+2jo3pPsGFSD+/9SBYlNuUVvT/s1JrDgKwcBwrsoqDbxdU7BNELjcGn5IKe8v8RlaBrBzmHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(66556008)(5660300002)(4326008)(66946007)(66476007)(6916009)(7416002)(1076003)(64756008)(8676002)(478600001)(6506007)(186003)(6512007)(8936002)(26005)(6486002)(41300700001)(83380400001)(2616005)(71200400001)(54906003)(38070700005)(316002)(76116006)(66446008)(2906002)(122000001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RStibGFoRmZ1VTFpenRuUlNXQVFMMTRCckxFRFdMUHhlRW0vbFFDWFB4YVd3?=
 =?utf-8?B?cVJXaDI2YlBvZElYWVU1dU5QMWVPTmkvaEszaEI2YnVLSGZyLzdPcFJyeTI4?=
 =?utf-8?B?TlFIRmc3WFdiTXk2TVUzdUs5ZjZBNlI4dTl0ZDVnNWpaVU5hOUVFRVVFQkVl?=
 =?utf-8?B?RzA1TTV3V1A1dURCT2pRU1BUZ0JtTGV6cHN4VXRjdEhqVElTQ1IybmVVRWdY?=
 =?utf-8?B?eUp3WHpRWm1ETTVTWi9mbzQvUWxBT1VPTERmVk56QkFvU3ZXMWRCNDZLeEIz?=
 =?utf-8?B?eXNyQk5jenNNOXFJdWlXaXBxem9BYms2aWRSdzlkaUNIZCtWZ3d0RFdlT01z?=
 =?utf-8?B?STB2a1JRdkNCUjhlcklIZU9PNytNcm1QWThrcnRqUmtYeHYwR3VsS3pHL3hv?=
 =?utf-8?B?V1huR2RQV0V2cDhFWEQrRmVzUnJoY25ocWQrTE14ZHJBVzl6RG1kMy9yRGF4?=
 =?utf-8?B?NlI3cnVkQ1BKVTljYmgvUHVXOXZrR1R2bXNUQ2tCUENmVitmZWRsNUFrOWRR?=
 =?utf-8?B?eEVabUZIbGpxR1BVQTVIZ1M5SDFoYktOOW1mS25KWFJ5SHdUQ3RrNDZhZXFa?=
 =?utf-8?B?RWlNN0ZZRkNTb25sV0NxNXJxY0c5VndjNXJ4K0pmT3RQV0hHbmpzUFVSazAr?=
 =?utf-8?B?RmlZNmk5ZkdsVGJrUzNkTGYxbFViYXQ5dE9QRlY5UlIwZnJjK05oZTZIclVv?=
 =?utf-8?B?NnpXbGRIdUV5emhPRUhYd3BHdkY2M0N3UWhBMWViUTZIZmFvWER0SGloL3VZ?=
 =?utf-8?B?c0xibTR1RG5TamdBKzByN1FuVzRKTWFLWGJoK3VNS09FTEJJMEQxQkVBbW41?=
 =?utf-8?B?dThldW9zR2dxbkoxYm9GS1JaZVVzZzIwaGhxOVpMZGVSU0RSdmlxbXBuZU94?=
 =?utf-8?B?WHF1eVRUNHNaTC83MEtUU1dmaG1ILzdGSGp1NE9GVG12SW1LQmNSd0VoV3JP?=
 =?utf-8?B?bnhIYVRZS0Z4VUJSMDNWZVc5Tlo2Nm5LeXUyMTluSFRQNThVeEhDY3BWSUlY?=
 =?utf-8?B?V3Z5Tk1GTk16VGFURU1JcklVQ0o1UWNDMVRHL2Q1MXJiR3V4R0IxUTBMdHNv?=
 =?utf-8?B?anFSelA3RU5zR0JMZmxwVkhtdnlLczNMbFVLZEJaTHk0L2Z5aE1zV1BQQWFW?=
 =?utf-8?B?NVcrSkZFODdvVzExMVBHd3NZK1Q0TElYd1QzMHZvaFFLcGw3bThOS05rUy92?=
 =?utf-8?B?UTZWaVJpUjVaV0hEL1BkK0lMcUFEZExSNFNTNkEyWHg0TzBEZFFFTXh1Q2hC?=
 =?utf-8?B?OEwzdTUxNUVtVUZMQVJxOVlmUDc5MGJnaXdwLzRTbEtVaVdIS000bWMweVdE?=
 =?utf-8?B?dlNNV2VMRFlRQm1wY3dlTThzZXh5NC8wcFltUDdsZHgwN2t2UGw4YzlJRVBJ?=
 =?utf-8?B?RmxHQXhKeGljZFVxZEo3Y0tiRU94cVdtbFVuaTBjb0hpV3JaWnVscFZmenZa?=
 =?utf-8?B?TVNKREVxT1RnQW96R2l4SEVRN2xXRW4xOVhNV0RVQXdwQXMyWlpOcTlBZURX?=
 =?utf-8?B?dkJuT1o1a3BqTGZPL0E1dC9Jc1BtMUFqMWV2eU9tM240YlI1T0JwY3ZzUEtL?=
 =?utf-8?B?WURDaVJWYTVPeFZRWWY2N3Fnc1pSVUxRbk1vbGJpdEtNcWh2ZVJiZG5pNGFz?=
 =?utf-8?B?cGlRVTZDbVAweXVBMHhGNzMvZVYreU5ZckpkbXhZT3FoR3dOY2ZvMEthb2dB?=
 =?utf-8?B?RFZ0cEU3QktPeExUM012ZkZuNTF4M0c0d3Y4MXhSbmQrdzJkVkRMaWhmcTZM?=
 =?utf-8?B?a0ltMVNseGlMRVVBRmVsOC9LS3FUY2ZGNnJZWFRXSUMvYmhKd0owUmcrUVdv?=
 =?utf-8?B?amdOcURDV0lVS016Yi9hVzF2cWtFKzdGcXhYTktMSm43eWo5TjluZFUwMlJW?=
 =?utf-8?B?WnFrc1NqMWhVaHJxSjBOcXFDcG14a0QvSk4vODVDZ085MDJUTTNxTFhVczJE?=
 =?utf-8?B?MmMyWCtxa2xXK1RlcVZrODVBUFFjQmQxcG1oTnhCWG01REhUb2pZK2RhLzlo?=
 =?utf-8?B?U3B3N0J4eDZZdFEyVmZjeDJ1OGFDc1N1dnh0QzBDM0JOdVRlL0tTUURKMEQr?=
 =?utf-8?B?L0JtOGk0N09yQWxFZUIwenhqK21ORXdZUkY1amV0aUdPMXlLZkx2ci9NS3ow?=
 =?utf-8?B?ZlNjY25KL0dHek9aMEUxc20wNWFTdDhoRDJSZkRqblVubUwwQlJBelYwZWZW?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D5A071679027A42A24ABE4AE6F7B185@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T0wrZSt0bU5xOXJWalJROEN1czNVa0lMWEtyNVBwNnEzODI3RmZYNDEvL3pM?=
 =?utf-8?B?WXV5bVAwSm9kODBkNnFvaFRhU1NuY3NYelV1YVI5NnJOZWs5RHhGNHlUQVNq?=
 =?utf-8?B?cno0MksyUjhVeTVFRXlTSEJGWnNKenNwdElMa0tmWEFrQmJzQ3NteTVNb1hE?=
 =?utf-8?B?cDFodWEzRHU2VXZVMEc3MENaMmJsN2VQZ3Q1TzhpRlZyU1RVbGVRdzhtdDVv?=
 =?utf-8?B?MWE2YjlEZjVtcTJablpxdmUrdXcrZ3QvY2hrblhIa1Bub01CRHFBTjQ0MEhQ?=
 =?utf-8?B?THVobFVuZmRDVnJLM1FXMG5LSDNBdkhMQy8yK1MwQyt0Z0toVVJqbFhJRDBO?=
 =?utf-8?B?YnVOeVF0YVBrdU5tTE9zRlJwc0h6NnJSb3RWcXhJS0Jnc3FqTjU2eVpVREND?=
 =?utf-8?B?YXJLdlJlU0lNRVJwZ0E4QVIxQXZFeVhjTmYwanBZZlpNWW5jSGxPQURvWkFs?=
 =?utf-8?B?QXRMRHdiY3ZUVUpvTXhsRkU4b2pjRzJHSno5dit0bXl1bmhRNFd3WWp5N2Iz?=
 =?utf-8?B?SDBoYW9nNExxWllaMW9Od3JDL2VjcndPTUZ0VGlyeXVkeWh1WkhQRzBEVlYw?=
 =?utf-8?B?UjFCY3FaYlJoejdDczlTbGUwWWxSWXRsNEdaVGpsbkZoZU1mbDlTU2REblR1?=
 =?utf-8?B?NjM0Tmo3NmYwbGFCQmFNRnQvVVY2Vk5WdjNQNnpPSEo2TXVnOWRmQnNYSTRF?=
 =?utf-8?B?SXFtTDdzZnE4aVJ6Ymp3QVI2S0gyWWxJZENzYVhFd0hlV3JKeTVFNDNuK0Jp?=
 =?utf-8?B?TFg0dG1kelltbkRWT3FseW5ZUTY4TC9ybVA1VVd6MFVvcXcxdHN6L25aNWxC?=
 =?utf-8?B?THJ0NHpHbFFjZ2FHa0JSajk1RUZmaXRkWXE4RER2SFBmU3VldXQ4MTZQVHZU?=
 =?utf-8?B?bzhNajFEOVNwMXJPMU1SRTFxUEJ3TG5SeERvNzNnUmVva2hadm00YWFWTGEw?=
 =?utf-8?B?SlBPK2tuWVd4bGhhUjBpSjk4bFN3OE1jWGxzNUZrbCtWVUorQjh2WGtxdGM2?=
 =?utf-8?B?M1hDV3dkdmxDODJlS2ZFaGl3NE1ESkNsSlFuREM3MWg0S0ZwNk1yT05iYkVI?=
 =?utf-8?B?LzQ4d0hUYjdKSmgyb09LYlNVaTlxdUNLNUtRbU9qakxZaUJpeVZla2tFaW1S?=
 =?utf-8?B?SEdIWHJhRmpDbkREbFdJNDU2ODAycDM1b0FuRktDV3NGYS9lWG1GMjdCR2pC?=
 =?utf-8?B?N3VWd2NVQTZJL1d3VlJ4WkhFOGJINytCNlN5QkZKelBQai8rRWRwU0pSa2VW?=
 =?utf-8?B?MmFGdXo3eUtRSHZVUHhOOFg3SE02YUtuWUs1dHg3SmNnOXErRm9BYStNSm1J?=
 =?utf-8?Q?Dfy/ik1Z/VBJ8=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366c5ea2-c46f-4109-a295-08dafb39b446
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 22:57:28.2425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdWh+Z57gApCmrbvpGwyX2oenusYJsreaoPUgrkquyveoLAcJAl/S0EdY/h4tn2cu2a/7hG/f2OGQdsNrgtNgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
X-Proofpoint-ORIG-GUID: WW07k7XBhos8fr77SAX3bmYIQIARe59E
X-Proofpoint-GUID: WW07k7XBhos8fr77SAX3bmYIQIARe59E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=943
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKYW4gMTksIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGksDQo+IA0KPiBP
biBTdW4sIEphbiAxNSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4gPiBDdXJyZW50
bHkgdGhlIERXQzMgZHJpdmVyIHN1cHBvcnRzIG9ubHkgc2luZ2xlIHBvcnQgY29udHJvbGxlcg0K
PiA+IHdoaWNoIHJlcXVpcmVzIGF0IG1vc3Qgb25lIEhTIGFuZCBvbmUgU1MgUEhZLg0KPiANCj4g
QWRkIG5vdGUgaGVyZSB0aGF0IG11bHRpLXBvcnQgaXMgZm9yIGhvc3QgbW9kZSBmb3IgY2xhcml0
eS4NCj4gDQo+ID4gDQo+ID4gQnV0IHRoZSBEV0MzIFVTQiBjb250cm9sbGVyIGNhbiBiZSBjb25u
ZWN0ZWQgdG8gbXVsdGlwbGUgcG9ydHMgYW5kDQo+ID4gZWFjaCBwb3J0IGNhbiBoYXZlIHRoZWly
IG93biBQSFlzLiBFYWNoIHBvcnQgb2YgdGhlIG11bHRpcG9ydA0KPiA+IGNvbnRyb2xsZXIgY2Fu
IGVpdGhlciBiZSBIUytTUyBjYXBhYmxlIG9yIEhTIG9ubHkgY2FwYWJsZQ0KPiA+IFByb3BlciBx
dWFudGlmaWNhdGlvbiBvZiB0aGVtIGlzIHJlcXVpcmVkIHRvIG1vZGlmeSBHVVNCMlBIWUNGRw0K
PiA+IGFuZCBHVVNCM1BJUEVDVEwgcmVnaXN0ZXJzIGFwcHJvcHJpYXRlbHkuDQo+ID4gDQo+ID4g
QWRkIHN1cHBvcnQgZm9yIGRldGVjdGluZywgb2J0YWluaW5nIGFuZCBjb25maWd1cmluZyBwaHkn
cyBzdXBwb3J0ZWQNCj4gPiBieSBhIG11bHRpcG9ydCBjb250cm9sbGVyIGFuZCBsaW1pdCB0aGUg
bWF4IG51bWJlciBvZiBwb3J0cw0KPiA+IHN1cHBvcnRlZCB0byA0Lg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEhhcnNoIEFnYXJ3YWwgPHF1aWNfaGFyc2hxQHF1aWNpbmMuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMzA0ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmggfCAgMTUgKy0NCj4gPiAgZHJpdmVycy91c2IvZHdjMy9kcmQuYyAgfCAgMTQgKy0NCj4gPiAg
MyBmaWxlcyBjaGFuZ2VkLCAyNDQgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gPiBpbmRleCA0NzZiNjM2MTg1MTEuLjdlMGE5YTU5OGRmZCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ID4gQEAgLTEyMCw3ICsxMjAsNyBAQCBzdGF0aWMgdm9pZCBfX2R3YzNf
c2V0X21vZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qg
ZHdjMyAqZHdjID0gd29ya190b19kd2Mod29yayk7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiA+IC0JaW50IHJldDsNCj4gPiArCWludCByZXQsIGk7DQo+IA0KPiBDYW4gd2UgZGVjbGFy
ZSB2YXJpYWJsZXMgaW4gc2VwYXJhdGUgbGluZXMgaGVyZSBhbmQgb3RoZXIgcGxhY2VzLg0KPiAN
Cj4gPiAgCXUzMiByZWc7DQo+ID4gIAl1MzIgZGVzaXJlZF9kcl9yb2xlOw0KPiA+ICANCj4gPiBA
QCAtMjAwLDggKzIwMCwxMCBAQCBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPiA+ICAJCX0gZWxzZSB7DQo+ID4gIAkJCWlmIChkd2MtPnVzYjJf
cGh5KQ0KPiA+ICAJCQkJb3RnX3NldF92YnVzKGR3Yy0+dXNiMl9waHktPm90ZywgdHJ1ZSk7DQo+
ID4gLQkJCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19waHksIFBIWV9NT0RFX1VTQl9I
T1NUKTsNCj4gPiAtCQkJcGh5X3NldF9tb2RlKGR3Yy0+dXNiM19nZW5lcmljX3BoeSwgUEhZX01P
REVfVVNCX0hPU1QpOw0KPiA+ICsJCQlmb3IgKGkgPSAwOyBpIDwgZHdjLT5udW1fcG9ydHM7IGkr
Kykgew0KDQpCVFcsIGlzIG51bV9wb3J0cyB0aGUgdG90YWwgb2YgdXNiMiArIHVzYjMgcG9ydHM/
DQoNCj4gPiArCQkJCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19waHlbaV0sIFBIWV9N
T0RFX1VTQl9IT1NUKTsNCj4gPiArCQkJCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2VuZXJpY19w
aHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiArCQkJfQ0KPiA+ICAJCQlpZiAoZHdjLT5k
aXNfc3BsaXRfcXVpcmspIHsNCg0KVGhhbmtzLA0KVGhpbmg=

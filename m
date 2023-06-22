Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0D73ACA7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 00:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFVWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 18:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjFVWmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 18:42:35 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B2B1981;
        Thu, 22 Jun 2023 15:42:33 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MHWi4w007588;
        Thu, 22 Jun 2023 15:42:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=OO/+qcmbQS9aib7wv+6AtOoEeeWNBEbFVet2+NxFn+4=;
 b=Xy5ejUYNjEzSncw9r6LG1Y5cNHLtciIwVIkY+2EAhB1mm0Pm64vMpv57/qrk7pa6CkUM
 P3zPHHwVPKZjbGRegGFHD1Brx10oGj/SANdVYWD3yY2pYTJIJaWkbR91W5ip+UZoNVtc
 PIHguKy6Pmsa6KZukH6Ha1btczbrPX1eSHyDJJXZmg6XxhH+k5OJ9sGjz8c82DOcy1sK
 6yqnJNk21rZ2lvVnHZSL1h3ANkO/xPGwl8jrJ/NLvs3EX4dRQAEH2DNiCcHI8YrR3CfS
 +toXajF2xvhiGgW5WPuT+GQc1T+yTcEOS0jAUsH9OL+rjHIEpYBVYBf1YDcF+6G8NtSq GA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3r9bruthna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 15:42:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1687473726; bh=OO/+qcmbQS9aib7wv+6AtOoEeeWNBEbFVet2+NxFn+4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ainotieXaW5Tz3tvm43CqnyDArO+WvlO8cV6Q6ubpLGNdiLEXqlR1bzmUXXwcVljk
         lecg46FbxNb66zzh7y/Uy/cTB+SVmD3i94ymRvRukN5qtKr3HBvbv6ssNewVgNQFU4
         t/0VWhI1Lax9JYgE+UcELwTXm9fqsa5Wl3X7Ueq4v+kX5UYSqd6FLYmGCm8Kx2w6Ov
         J7V/7DqYUIJkVF6arl9olKEQKh3bXBMyYEmchlNP6VbmXbduq4FVyxBlwuK5pe5cJa
         tM0zn/fWxI1hynJV2QMvbYwlMCqiTnsIxM47fewn/flFA7v3PdWSZgd1Re2+LHSjAG
         w71IOr4uAj/Ow==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B92B4011F;
        Thu, 22 Jun 2023 22:42:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7E6FFA005F;
        Thu, 22 Jun 2023 22:42:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eSfrrAYi;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D88A040218;
        Thu, 22 Jun 2023 22:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGSEz6wSZaf9ou/yH+dEyuk3KtR/+RRWS8SY8GdtYK/utcmVYaJdFcy4+yaPj/zDbZBQSWsQ7JgBrB7TD538KUyoDLm6W583MMLLDuDHFOZQTsVbwik1sG/PQ1CMojiRxXPyj/BD62JhEF35IwjuSVtVWT76iOfY44/QxoPAif08TYI2RGGmXUMGH0rcZ3L4HVjVigC4r/eRFbrfSVUg1REFd4j/6xOh8phyjWukCtHouyERpkYsJi5o4o5+Zbs1GNCSbeCnsj36v45iiNaXtkRlJjU4puc6WVB3R34tkHB6YGxO7G+sKooEfJngg37RZ0QgEQjcJF1exiDXPSYXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OO/+qcmbQS9aib7wv+6AtOoEeeWNBEbFVet2+NxFn+4=;
 b=DePx/VrhG0ps/zXc/S8kURLTuI8+hpp3eJq10hhKl3/tTes6OGlh4Id6MnxFpqR7E7vENWvC9SgJYO4PwuVXDMxEp6Y/uW0s2hkzFQ2+F1Ry5IBgbFmmt5C0egRUSzDw6A/5doGE+TMc7AhrLJF0GXe4EkPg2kICMGdmAFgs5LsyVpI2Kv7lEx84ivLNGUq3mmfN7YIA4trY8cbSC0aqOVkZJzTSQlnyqKuzta7moMD1tv0bHSF2ZNxNgv5V2oPg1CEd4hhJFJ6F0hQfGYOBHU7s6/SHbfDcqp3fPyyMLrThYImcnkN7ZXcp2Bp+dlPrjXjQ9gPu2N8up/OEO7HBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO/+qcmbQS9aib7wv+6AtOoEeeWNBEbFVet2+NxFn+4=;
 b=eSfrrAYiDtAESLAR0BeWE+sZq8N+4eo3EdpjeE3N2LY0LwxJEfHQsQ3TSXp6oclKAyusZ0XwAJFr0Ch86w/D+etf2wGeC/bmpOmgYSflgfV4Z4SeNvhEvhO5YaCOOGWFxNupm1zAnrvIwXQXfftL0AsanasZyjE4pNeXp+cIqgw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 22:41:58 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 22:41:58 +0000
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
Thread-Index: AQHZhif6/qSXXM0dd0yowK/+LbRnLK9b7I4AgABAvwCAAoIhAIAEyu8AgBviTICAAInNAIAA6E6AgABfQACAACrxgIAA8LOAgACm7QCAEijWAIACj8CA
Date:   Thu, 22 Jun 2023 22:41:58 +0000
Message-ID: <20230622224153.tqmurlezqk5jcozu@synopsys.com>
References: <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
 <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
 <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
 <ZJKoHEi6A3I_APGI@hovoldconsulting.com>
In-Reply-To: <ZJKoHEi6A3I_APGI@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB8860:EE_
x-ms-office365-filtering-correlation-id: 2aa830f5-d06c-44d6-3cb6-08db7371e313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKW3vJevobJN30SVI/9HlzoBdbz9feMpen3XVGCfZM4OUpiV1zYrTMkcllFe7WeL5HJdioiQSJom/LLBHEzAp6L0xOhkQ8BBKXr8rjF47c7HT93p/mBDLs2+tvoJ0SQ7u76nzJ1v9QmdLrlbnp0rG8o2lW1S71jJTkZGJJ3tqXCSFseafsh/mXCDPksLsRACHWVdQOgkHaKhrvs7Dqo/wlLJz+oHQWuwKLBLlMP0elERlFduN2f4gSsgZV6mmWK2kR94VmCQGbph/3DhsMry+IRrdetaqnX6Y0vczniw7B6+5q1GnX+0fnMgUHhLr7Y0sX3jpFPCCn9d46VKYvDrhBM7JK9dGmG+fRHiG0fXov0bLyfJNAhf1dz5iJzyuIqyQsSl43Ug9YJnt7hrRDD/3WjHdTmNc+gKd/r2Bk/f7NJU0AInh0O7D+USPxpZTF9L/ascKDCXIXKIBXD/bA+ApDpgCav/f/VncgY+mgqNJQBnHyxGz0izju/DA2TFtfhzwBYkA+AomogTptb8kF6AAPanDp5HIeKAVh+PvaYbvFml7CFsJzlfm+tWrWMifEitBm37epQhkutItiDR5ieYRY7qvmQvWzjEw7vDc/yaZXrfnCsMve4YAl+9KZ1HOkXitUF1FALVFYk77xG1I5i4ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(38100700002)(122000001)(2906002)(7416002)(38070700005)(83380400001)(66574015)(36756003)(86362001)(2616005)(53546011)(6506007)(6916009)(1076003)(6512007)(26005)(186003)(966005)(71200400001)(478600001)(54906003)(6486002)(66476007)(66446008)(66556008)(66946007)(76116006)(64756008)(316002)(8676002)(5660300002)(8936002)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9wVW14VTNNelZnVVQ1ekJqWWFISms4QWYzcTZ6ZGN6aENreERYMlJnUXI5?=
 =?utf-8?B?cHNsbUJrY25GTS9xSkhlN0lGcnY1b1NQMlg0eDhqMzQzMEZCSlYxTG1YNGp3?=
 =?utf-8?B?TjVKalBmQzArTHBkWWxjeiswY2JUZitEWW0raUw3bnlxM2MwUGdoVmphMXpm?=
 =?utf-8?B?eUwvRTZ1ZS9pd2R3OU1XVWdOUEs0am5TbnB5bGo4TnA1V2phNW5naDZraHRz?=
 =?utf-8?B?ZkpqdDBvUjJBaUFEVUtuZjdtMWMxYjgxcUVzL0J5Vkd3Q0ZsdU8rOEI4Zzhl?=
 =?utf-8?B?TXBZZGM2VGxtend6ZDR3OE0vNTJxY1Fvd3dWWS9JZDNmNUU2S0VkeCt3UUo3?=
 =?utf-8?B?QTlmcEE4aVU4aVlrOVVUallXN2FiSlMyMEFxMzFESFYzc0JLV3NXQlFnWWtN?=
 =?utf-8?B?WGtCLzBwd0VoZ3hMQ1g2alJFd0svUmJsTGJTMU5pZWwyS3NiWDZBNGc0NXhn?=
 =?utf-8?B?VSswdGNRUi9rMnJPN0NjZkRYLy90WUU2ZGpWV2JOVlVlREpvS1dRRXVyVkww?=
 =?utf-8?B?RWRmT2pUM0FSNkxHTURzQjZGZWFxenRtQ0FXRllKYUR6Wkp0a3VubUZ1dUNF?=
 =?utf-8?B?TVlsSU1PT2Y4RE5LR2hhbzZEcms2UDVlOU5HZm9VNlZualQxVnBPanBJandJ?=
 =?utf-8?B?WlU1MWl6aTBzN0NkWkQySkRDaVNqOHd0cWl4ZTRSUHFsMDZ5U1dBaWc2aUpr?=
 =?utf-8?B?dFZjZFNRampwbjJzQU1iYUVzOFlmSG1ESTZqYnIvcVVqMHFEd2xIamJZYjFY?=
 =?utf-8?B?UnNZajVzaTc1SmRUd2cyRmd1bnZvVExoUGlJb0RTYTVXKzlFUWlCK2MybDRr?=
 =?utf-8?B?Y3RyVDY4ZlQ3dm45NHNNK3ZlTm5wcmlWWFoyYmZQc0p4TDNXOGZQYythYlZO?=
 =?utf-8?B?am5LL09rNWV0RzRLNmw3b1Z2RDhHWXQ0Q3pXTHpJNlJGTU5zZ2Q4MUZoY3I4?=
 =?utf-8?B?N1l3ajlIYXh4TXJZanBMR2lhRXVuMXBPRURONy9ZeDdVTUhRY0NrcGk5ZkNy?=
 =?utf-8?B?cGdveEpDck43dmZ0bGpvZk0wRlAydDdTM2dOcUtCK2k5SFZ1TXp6dHYrdGFV?=
 =?utf-8?B?L1NJblRtMjh2cTVKaEYreHEwc3pOYVJYeXRXNmcwK3FReTZlN055MG5Ba2xK?=
 =?utf-8?B?ZmhMazh2ZC8wNG1NOWtzdTVKVHA3bEE5YnVWQzNRZFdzRUpJTjBsZ0YvMXpS?=
 =?utf-8?B?Ykk3ZzJNTFZ6VnQ3eGxoVEJJNXpNWEZzR3NSWkp0OWhWVVZGTTcxbXMvZTdk?=
 =?utf-8?B?QnYwTEhFM1cra1ZFbnYxVktqdHlkNGxFUlN5WEpqbDloRmNGMEZmSXpoZTRL?=
 =?utf-8?B?VFF1ckdMa0FmOU9mb29jUWQ3dksrSkljdGc3RllLZ0ZzZHRRcXZsUDNsM0RW?=
 =?utf-8?B?QVJYOUR3K08wMGVtbnhwVElxbjNKN1hqSlp2ZmpqeU5HU1dsRlhkdm9GZWdP?=
 =?utf-8?B?WStXVGtFM2xZUVNFeVBOY1lOSEl5Sms1d1dPakNIUFlqOXZ6S2E0YTVwWTB5?=
 =?utf-8?B?ZmZlMXZZM3pkNG5KWWlkWjBZM3Jzc1Rzb25CZ0hOMElhWE5Obkp2ODJndFRD?=
 =?utf-8?B?UlRhMldhR2VRdGF1M3o0M0JTYjc0aHlEby90NE0rQ0NNUDU2MEhFUVQ3MUtU?=
 =?utf-8?B?cFVWVHpXNmZrUWdJejJxV2F4OSt4cGdwS2d1Q1gyN2RhK0hnT2kwYzNnbnFY?=
 =?utf-8?B?dlNWMkRtRWxxazZWSTkxTHlQYjlIZjF2UG9QZGNjcGpVdU15ajdzUGFXbWp2?=
 =?utf-8?B?SWdnUlhaVk51ZmhIbzM5aEdhVUlNdCt6T21KOWxyWklLS0lFejZTNUdqOTdQ?=
 =?utf-8?B?TmVoTmsvbENQdVhSN3R4cWtkSmkwSVoyL2p5YVRnT3Jzdk1DZllZYlZEb0pt?=
 =?utf-8?B?bm5nYURreWdreGVuNGxJQkhrOFdqcGx0Y3pUSWRKS0Y0S0FnTkNZek1Qa01k?=
 =?utf-8?B?TXVSZ3VoWXB3VkRzSFJScCtXcUxSNTVaVVA3SExjQUVadzgwVFZ4WnZzRlIv?=
 =?utf-8?B?VEpvU0R2Slg3M2Q0VGs4VHdoRGdVcUFzOWVHTU9IbHBGZmtFLzMra1dYWGdF?=
 =?utf-8?B?UzFlZFFTM1JqUDQxL2VjZWVTN2o1UWY5dDdKd0FaQ01DUWZ5R1V5elVFbldZ?=
 =?utf-8?Q?bLxXG47MCW1jEp6XXaHCTE1lM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF17516932DADE4EA6BC86EF5A0E0F05@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUpMNXhlOVVpRlYwRFZpYnhSUlB0UzBkV3k1UnBpZzNqTDFGKzBFRE9vbm1U?=
 =?utf-8?B?WmVCc2FqTVhGT3dNMGEwSGozVXRpQm9MVXFZd2szeGhHQzV5NkdmVkZhdmM5?=
 =?utf-8?B?WUpudXNBTVlhNFVuTzNxZTBucG9tS0JZYk83WDBNRm1ZL28wcDJ1RnM0S01H?=
 =?utf-8?B?NmIyQ09kcmQzeEVCeEdmcko0clVlQkVuVm8wVkFDMkdHcStoME9xQkl3eHBt?=
 =?utf-8?B?MDRENERLMVU3d2puWUtKWHcrdVFONnF5aDJrTTlvVGF1TkZMcndRZlJrZmRD?=
 =?utf-8?B?NEVTVmF0aTJjcUpLODNoUm9NMzk2UHl1UW1OcmtLU2pWZnpYRHFQWE9tK3Rq?=
 =?utf-8?B?SHlqMHVCYmtCZU50NGtTb1hwVnlhQkpFbjBLUzdISDhhZVFGWFRQbllURTVB?=
 =?utf-8?B?b3dEWDRxWVpPR0NGZktrZDNnd0RzL0NJcWhjeGpLQVhuWnpjaG9iVk1md3Jt?=
 =?utf-8?B?dGo0L0txUTZmd1NQWmdwUDJLUmMrUFhkbjM1Q2JZOVVwUEJJZVVFdVJBVFBo?=
 =?utf-8?B?QmlSamwrOTc5UWpWU0JYWE5yLzFsU2lJT1hQRUUydVpLd25Rbk9sMkQrUXZD?=
 =?utf-8?B?aGFzbjMwbWJyRlRrU1lOVGN2ck4rWncveWEvbDJYNmtxME5OOXhJeHZvVnFK?=
 =?utf-8?B?QTlRbDc2NE5IbzYreVkwaXVKQTlxNzdaUm1zZWkzQUZMY29WZ1A0MUZ1WllK?=
 =?utf-8?B?SGZPRTNCMy9WVk9UWUkxZzdvc2pmazhucU8waEJ2NE9uZG5NMGYxaGk4YTND?=
 =?utf-8?B?Y3FaczlGWGNwOW1tMVcyTjAwWDRPTVlPb0lyNzF2WHQzWWFPVWgrd3NjdjNv?=
 =?utf-8?B?SXRxaVVMZXFua014dnlxVG5ZcW1KWjd4MXEyODNvdUlSQlFlcHgzcTQvRGVG?=
 =?utf-8?B?NTVKSU5GaWRSSFdmWUp3Y2xIcE9uUW5pSUhGcFJBREMzNGw2d1BRRlhEUnJE?=
 =?utf-8?B?T3orS0RnWU1QeUM3eXZmSEtueDRCMTY1SHBDTmtzcXJGc20zSDZFbXA1cS94?=
 =?utf-8?B?dEhHaWR4Tm1oaVU5VzMzM0M3OGpMSWtkV1lwWTFPd2l6MUMwTFlCTnNTTW8r?=
 =?utf-8?B?S3FpekNtQlNRTXhjOGh0WjVFK3RHQ2NYaW0xdVdIM1dlRDRUQmFOdTdPS1ox?=
 =?utf-8?B?aXM2VnJHMWM2eEVuUWoxMXhEc2JrcDI1QzlYZHJBWWFGeWNNUTVZWWpacm1q?=
 =?utf-8?B?SktXdUNlS1o5b3B5eTVVSXp3aDZENjMycmtuOUJ0VkoyenRIYjNsbkZQMkU5?=
 =?utf-8?B?bjFNSlVVS3VTb2FVZUJseVJqc0duSU9tMjFXMkdZRmJNWnpDTTNTMzBmMGh0?=
 =?utf-8?B?dUlzUzdrYTNTOGRmRk0yTy9xQkk1aEgwMkVTTk1GVW4vZTNmM2RVakVhUlZa?=
 =?utf-8?B?TEs2T2haZXdlRVE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa830f5-d06c-44d6-3cb6-08db7371e313
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 22:41:58.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+ZqwD4MGYuUpeF/ne5JxGuWQH3c6cn7pamHRM9C/ey3J1t38yFAj+lR1MBdtNGjPM2KETgA4NUBN5wSQhabEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Proofpoint-ORIG-GUID: NFwwZFlIhfl1Jk2NTxkoNLoeh6ZYg4WS
X-Proofpoint-GUID: NFwwZFlIhfl1Jk2NTxkoNLoeh6ZYg4WS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306220194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMjEsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBhbmQgc29ycnkgYWJvdXQgdGhlIGxhdGUgcmVwbHkuIFdhcyBvbiBob2xpZGF5IGxhc3Qg
d2Vlay4NCj4gDQo+IE9uIEZyaSwgSnVuIDA5LCAyMDIzIGF0IDA2OjE2OjEzUE0gKzAwMDAsIFRo
aW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBGcmksIEp1biAwOSwgMjAyMywgSm9oYW4gSG92b2xk
IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdW4gMDgsIDIwMjMgYXQgMDU6NTc6MjNQTSArMDAwMCwg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIEp1biAwOCwgMjAyMywgS3Jpc2hu
YSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4gPiA+ID4gPiBPbiA2LzgvMjAyMyAzOjEyIFBNLCBK
b2hhbiBIb3ZvbGQgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAw
MToyMTowMkFNICswNTMwLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4gPiA+
ID4gPiBPbiA2LzcvMjAyMyA1OjA3IFBNLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiBTbyB0aGVyZSBhdCBsZWFzdCB0d28gaXNzdWVzIHdpdGggdGhp
cyBzZXJpZXM6DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gCTEuIGFjY2Vzc2lu
ZyB4aGNpIHJlZ2lzdGVycyBmcm9tIHRoZSBkd2MzIGNvcmUNCj4gPiA+ID4gPiA+ID4gPiAJMi4g
YWNjZXNzaW5nIGRyaXZlciBkYXRhIG9mIGEgY2hpbGQgZGV2aWNlDQo+ID4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ID4gMS4gVGhlIGZpcnN0IHBhcnQgYWJvdXQgYWNjZXNzaW5nIHhoY2kg
cmVnaXN0ZXJzIGdvZXMgYWdhaW5zdCB0aGUgY2xlYXINCj4gPiA+ID4gPiA+ID4gPiBzZXBhcmF0
aW9uIGJldHdlZW4gZ2x1ZSwgY29yZSBhbmQgeGhjaSB0aGF0IEZlbGlwZSB0cmllZCB0byBtYWlu
dGFpbi4NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBJJ20gbm90IGVudGlyZWx5
IGFnYWluc3QgZG9pbmcgdGhpcyBmcm9tIHRoZSBjb3JlIGRyaXZlciBiZWZvcmUNCj4gPiA+ID4g
PiA+ID4gPiByZWdpc3RlcmluZyB0aGUgeGhjaSBwbGF0Zm9ybSBkZXZpY2UgYXMgdGhlIHJlZ2lz
dGVycyBhcmUgdW5tYXBwZWQNCj4gPiA+ID4gPiA+ID4gPiBhZnRlcndhcmRzLiBCdXQgaWYgdGhp
cyBpcyB0byBiZSBhbGxvd2VkLCB0aGVuIHRoZSBpbXBsZW1lbnRhdGlvbiBzaG91bGQNCj4gPiA+
ID4gPiA+ID4gPiBiZSBzaGFyZWQgd2l0aCB4aGNpIHJhdGhlciB0aGFuIGNvcGllZCB2ZXJiYXRp
bS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBjb3JlIHdpbGwganVzdCBiZSBsb29raW5nIGF0IHRo
ZSBIVyBjYXBhYmlsaXR5IHJlZ2lzdGVycyBhbmQNCj4gPiA+ID4gYWNjZXNzaW5nIHRoZSBwb3J0
cyBjYXBhYmlsaXR5LiBPdXIgcHJvZ3JhbW1pbmcgZ3VpZGUgYWxzbyBsaXN0ZWQgdGhlDQo+ID4g
PiA+IGhvc3QgY2FwYWJpbGl0eSByZWdpc3RlcnMgaW4gaXRzIGRvY3VtZW50YXRpb24uIFdlJ3Jl
IG5vdCBkcml2aW5nIHRoZQ0KPiA+ID4gPiB4aGNpIGNvbnRyb2xsZXIgaGVyZS4gV2UncmUgaW5p
dGlhbGl6aW5nIHNvbWUgb2YgdGhlIGNvcmUgY29uZmlncyBiYXNlDQo+ID4gPiA+IG9uIGl0cyBj
YXBhYmlsaXR5Lg0KPiA+ID4gPiANCj4gPiA+ID4gV2UncmUgZHVwbGljYXRpbmcgdGhlIGxvZ2lj
IGhlcmUgYW5kIG5vdCBleGFjdGx5IGRvaW5nIGl0IHZlcmJhdGltLg0KPiA+ID4gPiBMZXQncyB0
cnkgbm90IHRvIHNoYXJlIHRoZSB3aG9sZSB4aGNpIGhlYWRlciB3aGVyZSB3ZSBzaG91bGQgbm90
IGhhdmUNCj4gPiA+ID4gdmlzaWJpbGl0eSBvdmVyLiBQZXJoYXBzIGl0IG1ha2VzIHNlbnNlIGlu
IHNvbWUgb3RoZXIgZHJpdmVyLCBidXQgbGV0J3MNCj4gPiA+ID4gbm90IGRvIGl0IGhlcmUuDQo+
ID4gPiANCj4gPiA+IFRoZSBwYXRjaCBzZXJpZXMgZXZlbiBjb3BpZWQgdGhlIGtlcm5lbCBkb2Mg
dmVyYmF0aW0uIFRoaXMgaXMganVzdCBub3QNCj4gPiA+IHRoZSB3YXkgdGhpbmdzIGFyZSBzdXBw
b3NlZCB0byBiZSBkb25lIHVwc3RyZWFtLiBXZSBzaGFyZSBkZWZpbmVzIGFuZA0KPiA+ID4gaW1w
bGVtZW50YXRpb25zIGFsbCB0aGUgdGltZSwgYnV0IHdlIHNob3VsZCBub3QgYmUgbWFraW5nIGNv
cGllcyBvZg0KPiA+ID4gdGhlbS4NCj4gPiANCj4gPiAgV2UgaGFkIHNvbWUgZml4ZXMgdG8gdGhl
IGtlcm5lbCBkb2MgYXMgaXQncyBpbmNvcnJlY3QgZGVzY3JpcHRpb24uDQo+ID4gIFBlcmhhcHMg
d2UgY2FuIGZ1bGx5IHJld3JpdGUgdGhlIGtlcm5lbC1kb2MgaWYgdGhhdCB3aGF0IG1ha2VzIGl0
DQo+ID4gIGJldHRlci4NCj4gDQo+IE5vLCB0aGlzIGlzIGFuIGV4YW1wbGUgb2Ygd2h5IHlvdSBz
aG91bGQgbm90IGNvcHkgY29kZSAoYW5kIGRvY3MpDQo+IGFyb3VuZCwgZm9yIGV4YW1wbGUsIHNv
IHlvdSBkb24ndCBoYXZlIHRvIGZpeCB0aGUgc2FtZSBidWcgKG9yIHR5cG8pIGluDQo+IG11bHRp
cGxlIHBsYWNlcy4NCj4gDQo+ID4gV2UgY2FuIHNoYXJlIGRlZmluZSBpbXBsZW1lbnRhdGlvbnMg
aWYgdGhleSBhcmUgbWVhbnQgdG8gYmUNCj4gPiAgc2hhcmVkLiBIb3dldmVyLCB3aXRoIHRoZSBj
dXJyZW50IHdheSB4aGNpIGhlYWRlciBpcyBpbXBsZW1lbnRlZCwgaXQncw0KPiA+ICBub3QgbWVh
bnQgdG8gYmUgc2hhcmVkIHdpdGggZHdjMy4gWW91IGFncmVlZCB0aGF0IHdlIGFyZSB2aW9sYXRp
bmcgdGhpcw0KPiA+ICBpbiBzb21lIGRyaXZlciwgYnV0IHlvdSdyZSBhbHNvIGluc2lzdGVudCB0
aGF0IHdlIHNob3VsZCBub3QgZHVwbGljYXRlDQo+ID4gIHRoZSBsb2dpYyB0byBhdm9pZCB0aGlz
IHZpb2xhdGlvbi4gUGVyaGFwcyBJJ20gbm90IGEgbWFpbnRhaW5lciBoZXJlDQo+ID4gIGxvbmcg
ZW5vdWdoIHRvIGtub3cgc29tZSB2aW9sYXRpb24gaXMgYmV0dGVyIGtlcHQuIElmIHNoYXJpbmcg
dGhlIHhoY2kNCj4gPiAgaGVhZGVyIGlzIHdoYXQgaXQgdGFrZXMgdG8gZ2V0IHRoaXMgdGhyb3Vn
aCwgdGhlbiBmaW5lLg0KPiANCj4gSnVzdCBiZWNhdXNlIG5vLW9uZSBoYXMgdXNlZCB0aGVzZSBv
dXRzaWRlIG9mIHhoY2kgdG9kYXksIGRvZXNuJ3QgbWVhbg0KPiB0aGF0IHlvdSBzaG91bGQgY29w
eSB0aGUgZGVmaW5lcyBvbmNlIHRoZXkgYXJlIG5lZWRlZCBvdXRzaWRlIHRoYXQNCj4gZHJpdmVy
Lg0KPiANCj4gQW5kIGluIGZhY3QsIHRoZXkgYXJlIHVzZWQgb3V0c2lkZSBvZiB0aGUgeGhjaSBk
cml2ZXIgcHJvcGVyIGFscmVhZHkNCj4gdG9kYXksIG9ubHkgdGhhdCBwZW9wbGUgdG9vayB0aGUg
bGF6eSBhcHByb2FjaCBhbmQgc2hhcmVkIHRoZSBpbmxpbmUNCj4gaGVscGVyIGZvciB0aGF0Lg0K
PiANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBUaGUgYWx0ZXJuYXRpdmUgdGhh
dCBhdm9pZHMgdGhpcyBpc3N1ZSBlbnRpcmVseSBjb3VsZCBpbmRlZWQgYmUgdG8NCj4gPiA+ID4g
PiA+ID4gPiBzaW1wbHkgY291bnQgdGhlIG51bWJlciBvZiBQSFlzIGRlc2NyaWJlZCBpbiBEVCBh
cyBSb2IgaW5pdGlhbGx5DQo+ID4gPiA+ID4gPiA+ID4gc3VnZ2VzdGVkLiBXaHkgd291bGQgdGhh
dCBub3Qgd29yaz8NCj4gPiA+ID4gDQo+ID4gPiA+IFNlZSBiZWxvdy4NCj4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFRoZSByZWFzb24gd2h5IEkgZGlkbid0IHdhbnQg
dG8gcmVhZCB0aGUgUGh5J3MgZnJvbSBEVCBpcyBleHBsYWluZWQgaW4NCj4gPiA+ID4gPiA+ID4g
WzFdLiBJIGZlbHQgaXQgbWFrZXMgdGhlIGNvZGUgdW5yZWFkYWJsZSBhbmQgaXRzIHZlcnkgdHJp
Y2t5IHRvIHJlYWQgdGhlDQo+ID4gPiA+ID4gPiA+IHBoeSdzIHByb3Blcmx5LCBzbyB3ZSBkZWNp
ZGVkIHdlIHdvdWxkIGluaXRpYWxpemUgcGh5J3MgZm9yIGFsbCBwb3J0cw0KPiA+ID4gPiA+ID4g
PiBhbmQgaWYgYSBwaHkgaXMgbWlzc2luZyBpbiBEVCwgdGhlIGNvcnJlc3BvbmRpbmcgbWVtYmVy
IGluDQo+ID4gPiA+ID4gPiA+IGR3Yy0+dXNiWF9nZW5lcmljX3BoeVtdIHdvdWxkIGJlIE5VTEwg
YW5kIGFueSBwaHkgb3Agb24gaXQgd291bGQgYmUgYSBOT1AuDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFRoYXQgZG9lc24ndCBzb3VuZCB0b28gY29udmluY2luZy4gQ2FuJ3QgeW91IGp1c3Qg
aXRlcmF0ZSBvdmVyIHRoZSBQSFlzDQo+ID4gPiA+ID4gPiBkZXNjcmliZWQgaW4gRFQgYW5kIGRl
dGVybWluZSB0aGUgbWF4aW11bSBwb3J0IG51bWJlciB1c2VkIGZvciBIUyBhbmQNCj4gPiA+ID4g
PiA+IFNTPw0KPiA+ID4gPiA+ID4gPiBBbHNvIGFzIHBlciBLcnp5c3p0b2Ygc3VnZ2VzdGlvbiBv
biBbMl0sIHdlIGNhbiBhZGQgYSBjb21wYXRpYmxlIHRvIHJlYWQNCj4gPiA+ID4gPiA+ID4gbnVt
YmVyIG9mIHBoeSdzIC8gcG9ydHMgcHJlc2VudC4gVGhpcyBhdm9pZHMgYWNjZXNzaW5nIHhoY2kg
bWVtYmVycw0KPiA+ID4gPiA+ID4gPiBhdGxlYXN0IGluIGRyaXZlciBjb3JlLiBCdXQgdGhlIGxh
eWVyaW5nIHZpb2xhdGlvbnMgd291bGQgc3RpbGwgYmUgcHJlc2VudC4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gWWVzLCBidXQgaWYgdGhlIGluZm9ybWF0aW9uIGlzIGFscmVhZHkgYXZhaWxh
YmxlIGluIERUIGl0J3MgYmV0dGVyIHRvIHVzZQ0KPiA+ID4gPiA+ID4gaXQgcmF0aGVyIHRoYW4g
cmUtZW5jb2RlIGl0IGluIHRoZSBkcml2ZXIuDQo+ID4gPiANCj4gPiA+ID4gPiAgIEFyZSB5b3Ug
c3VnZ2VzdGluZyB0aGF0IHdlIGp1c3QgZG8gc29tZXRoaW5nIGxpa2UNCj4gPiA+ID4gPiBudW1f
cG9ydHMgPSBtYXgoIGhpZ2hlc3QgdXNiMiBwb3J0bnVtLCBoaWdoZXN0IHVzYjMgcG9ydCBudW0p
DQo+ID4gPiA+IA0KPiA+ID4gPiBXaHkgZG8gd2Ugd2FudCB0byBkbyB0aGlzPyBUaGlzIG1ha2Vz
IG51bV9wb3J0cyBhbWJpZ3VvdXMuIExldCdzIG5vdA0KPiA+ID4gPiBzYWNyaWZpY2UgY2xhcml0
eSBmb3Igc29tZSBsaW5lcyBvZiBjb2RlLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIG5vdCBhYm91
dCBsaW5lcyBvZiBjb2RlLCBidXQgYXZvaWRpbmcgdGhlIGJhZCBwcmFjdGljZSBvZg0KPiA+ID4g
Y29weWluZyBjb2RlIGFyb3VuZCBhbmQsIHRvIHNvbWUgZGVncmVlLCBtYWludGFpbmluZyB0aGUg
c2VwYXJhdGlvbg0KPiA+ID4gYmV0d2VlbiB0aGUgZ2x1ZSwgY29yZSwgYW5kIHhoY2kgd2hpY2gg
RmVsaXBlIChwZXJoYXBzIG1pc3Rha2luZ2x5KSBoYXMNCj4gPiA+IGZvdWdodCBmb3IuDQo+ID4g
DQo+ID4gV2UncmUgdGFsa2luZyBhYm91dCBjb21iaW5pbmcgbnVtX3VzYjNfcG9ydHMgYW5kIG51
bV91c2IyX3BvcnRzIGhlcmUsDQo+ID4gd2hhdCBkb2VzIHRoYXQgaGF2ZSB0byBkbyB3aXRoIGxh
eWVyIHNlcGFyYXRpb24/DQo+IA0KPiBJIG1lbnRpb25lZCB0aGlzIGlzIGFzIGFuIGFsdGVybmF0
aXZlIGlmIHlvdSdyZSBhcmUgaGVsbC1iZW50IG9uIG5vdA0KPiByZXVzaW5nIHRoZSB4aGNpIHJl
Z2lzdGVyIGRlZmluZXMgYW5kIHBhcnNpbmcgY29kZS4NCj4gDQo+ID4gPiBJZiB5b3UganVzdCBu
ZWVkIHRvIGtub3cgaG93IG1hbnkgUEhZcyB5b3UgaGF2ZSBpbiBEVCBzbyB0aGF0IHlvdSBjYW4N
Cj4gPiA+IGl0ZXJhdGUgb3ZlciB0aGF0IGludGVybmFsIGFycmF5LCB5b3UgY2FuIGp1c3QgbG9v
ayBhdCB0aGUgbWF4IGluZGV4IGluDQo+ID4gPiBEVCB3aGVyZSB0aGUgaW5kZXhlcyBhcmUgc3Bl
Y2lmaWVkIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gPiA+IA0KPiA+ID4gRG9uJ3QgZ2V0IGh1bmcg
dXAgb24gdGhlIGN1cnJlbnQgdmFyaWFibGUgbmFtZXMsIHRob3NlIGNhbiBiZSByZW5hbWVkIHRv
DQo+ID4gPiBtYXRjaCB0aGUgaW1wbGVtZW50YXRpb24uIENhbGwgaXQgbWF4X3BvcnRzIG9yIHdo
YXRldmVyLg0KPiA+IA0KPiA+IEl0IGRvZXNuJ3QgbWF0dGVyIHdoYXQgdmFyaWFibGUgbmFtZSBp
cyBnaXZlbiwgaXQgZG9lc24ndCBjaGFuZ2UgdGhlDQo+ID4gZmFjdCB0aGF0IHRoaXMgIm51bV9w
b3J0cyIgb3IgIm1heF9wb3J0cyIgb2JmdXNjYXRlZCB1c2IyIHZzIHVzYjMgcG9ydHMNCj4gPiBq
dXN0IGZvciB0aGlzIHNwZWNpZmljIGltcGxlbWVudGF0aW9uLiBTbywgZG9uJ3QgZG8gdGhhdC4N
Cj4gDQo+IE9rLCB0aGVuIG1ha2Ugc3VyZSB5b3UgcmV1c2UgdGhlIHhoY2kgaW1wbGVtZW50YXRp
b24gZm9yIHRoYXQgdGhlbi4NCj4gDQo+ID4gPiA+ID4gSWYgc28sIGluY2FzZSB0aGUgdXNiMiBw
aHkgb2YgcXVhZCBwb3J0IGNvbnRyb2xsZXIgaXMgbWlzc2luZyBpbiBEVCwgd2UNCj4gPiA+ID4g
PiB3b3VsZCBzdGlsbCByZWFkIG51bV91c2IyX3BvcnRzIGFzIDQgYnV0IHRoZSB1c2IyX2dlbmVy
aWNfcGh5WzFdIHdvdWxkIGJlDQo+ID4gPiA+ID4gTlVMTCBhbmQgYW55IHBoeSBvcHMgd291bGQg
c3RpbGwgYmUgTk9QLiBCdXQgd2Ugd291bGQgYmUgZ2V0dGluZyByaWQgb2YNCj4gPiA+ID4gPiBy
ZWFkaW5nIHRoZSB4aGNpIHJlZ2lzdGVycyBjb21wZWx0ZWx5IGluIGNvcmUgZHJpdmVyLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoaW5oLCBCam9ybiwgY2FuIHlvdSBhbHNvIGxldCB1cyBrbm93
IHlvdXIgdmlld3Mgb24gdGhpcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAxLiBSZWFkOg0KPiA+
ID4gPiA+ICAgbnVtX3VzYjNfcG9ydHMgPSBoaWdoZXN0IHVzYjMgcG9ydCBpbmRleCBpbiBEVA0K
PiA+ID4gPiA+ICAgbnVtX3VzYjJfcG9ydHMgPSBtYXgoIGhpZ2hlc3QgdXNiMiBwb3J0IGluZGV4
LCBudW1fdXNiM19wb3J0cykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAyLiBSZWFkIHRoZSBzYW1l
IGJ5IHBhcnNpbmcgeGhjaSByZWdpc3RlcnMgYXMgZG9uZSBpbiByZWNlbnQgdmVyc2lvbnMgb2YN
Cj4gPiA+ID4gPiB0aGlzIHNlcmllcy4NCj4gPiA+ID4gDQo+ID4gPiA+IERUIGlzIG5vdCByZWxp
YWJsZSB0byBnZXQgdGhpcyBpbmZvLiBBcyBub3RlZCwgdGhlIERUIG1heSBza2lwIHNvbWUNCj4g
PiA+ID4gcG9ydHMgYW5kIHN0aWxsIGJlIGZpbmUuIEhvd2V2ZXIsIHRoZSBkcml2ZXIgZG9lc24n
dCBrbm93IHdoaWNoIHBvcnQNCj4gPiA+ID4gcmVmbGVjdHMgd2hpY2ggcG9ydCBjb25maWcgaW5k
ZXggd2l0aG91dCB0aGUgZXhhY3QgcG9ydCBjb3VudC4NCj4gPiA+IA0KPiA+ID4gVGhhdCdzIG5v
dCBjb3JyZWN0LiBEVCBwcm92aWRlcyB0aGUgcG9ydCBpbmRleGVzIGFscmVhZHksIGZvciBleGFt
cGxlOg0KPiA+ID4gDQo+ID4gPiAJcGh5LW5hbWVzID0gInVzYjItcG9ydDAiLCAidXNiMy1wb3J0
MCIsDQo+ID4gPiAJCSAgICAidXNiMi1wb3J0MSIsICJ1c2IzLXBvcnQxIiwNCj4gPiA+IAkJICAg
ICJ1c2IyLXBvcnQyIiwNCj4gPiA+IAkJICAgICJ1c2IyLXBvcnQzIjsNCj4gPiA+IA0KPiA+ID4g
U28gaWYgeW91IGp1c3QgbmVlZCB0aGlzIHRvIGl0ZXJhdGUgb3ZlciB0aGUgUEhZcyBhbGwgdGhl
IGluZm9ybWF0aW9uDQo+ID4gPiBuZWVkZWQgaXMgaGVyZS4NCj4gPiA+IA0KPiA+ID4gSWYgeW91
IG5lZWQgdG8gYWNjZXNzIHBvcnRzIHdoaWNoIGRvIG5vdCBoYXZlIGEgUEhZIGRlc2NyaWJlZCBp
biBEVCwNCj4gPiA+IHRoZW4gdGhpcyBpcyBub3QgZ29pbmcgdG8gc3VmZmljZSwgYnV0IEkgaGF2
ZSBub3Qgc2VlbiBhbnlvbmUgY2xhaW0gdGhhdA0KPiA+ID4gdGhhdCBpcyBuZWVkZWQgeWV0Lg0K
PiA+IA0KPiA+IFBlcmhhcHMgSSBtaXN1bmRlcnN0YW5kIHRoZSBjb252ZXJzYXRpb24uIEhvd2V2
ZXIsIHRoZXJlIGlzbid0IGEgbWV0aG9kDQo+ID4gdGhhdCBldmVyeW9uZSdzIGFncmVlIG9uIHll
dCByZWdhcmRpbmcgRFQgWypdLiBQZXJoYXBzIHRoaXMgaW5kaWNhdGVzIGl0DQo+ID4gbWF5IG5v
dCBiZSB0aGUgYmVzdCBhcHByb2FjaC4gWW91IGNhbiByZXN1bWUgdGhlIGNvbnZlcnNhdGlvbiBp
ZiB5b3UNCj4gPiB3YW50IHRvOg0KPiA+IA0KPiA+IFsqXSBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzk2NzFjYWRlLTE4MjAtMjJl
MS05ZGI5LTVjOTgzNjQxNDkwOEBxdWljaW5jLmNvbS8qdF9fO0l3ISFBNEYyUjlHX3BnIWJ0Y19m
a3JuQW0xZUZHNWM1VjBiV01uUG5xNHl2Rnl6YTFuRFJKRThtUHZTU3JZSXl4a1V4akFBUlU1MWNS
c29vMm4wZUx3VEd0X1NZdm5RT2FRJCANCj4gDQo+IFRoaXMgd2FzIHRoZSBhcHByb2FjaCBzdWdn
ZXN0ZWQgYnkgUm9iLCB0aGUgRFQgbWFpbnRhaW5lciwgaW4gdGhhdCB2ZXJ5DQo+IHRocmVhZCBJ
SVJDLg0KPiANCj4gPiA+ID4gTW9yZSBpbXBvcnRhbnRseSwgdGhlIGhvc3QgY29udHJvbGxlciB0
aGF0IGxpdmVzIG9uIHRoZSBQQ0kgYnVzIHdpbGwgbm90DQo+ID4gPiA+IHVzZSBEVC4gVGhpcyBj
YW4gYmUgdXNlZnVsIGZvciBzb21lIHJlLWNvbmZpZ3VyYXRpb25zIGlmIHRoZSBjb250cm9sbGVy
DQo+ID4gPiA+IGlzIGEgUENJIGRldmljZSBhbmQgdGhhdCBnb2VzIHRocm91Z2ggdGhlIGR3YzMg
Y29kZSBwYXRoLg0KPiA+ID4gDQo+ID4gPiBPaywgdGhpcyBpcyBhIGJpdCBoYW5kIHdhdnksIGJ1
dCBpZiB0aGlzIGV2ZXIgdHVybnMgb3V0IHRvIGJlIG5lZWRlZCBpdA0KPiA+ID4gY2FuIGFsc28g
YmUgaW1wbGVtZW50ZWQgdGhlbi4NCj4gPiANCj4gPiBXaGF0IGRvZXMgaGFuZCB3YXZ5IG1lYW4/
IFdlIGhhdmUgY2FzZSB3aGVyZSBpdCdzIHVzZWZ1bCBvdXRzaWRlIG9mDQo+ID4gdGhpcywgYW5k
IGl0IHdvdWxkIGJlIHVzZWZ1bCBmb3IgUENJIGRldmljZSB0b286DQo+ID4gDQo+ID4gaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8y
MDIzMDUxNzIzMzIxOC5yamZtdnB0cmV4Z2twYW0zQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdf
cGchYnRjX2Zrcm5BbTFlRkc1YzVWMGJXTW5QbnE0eXZGeXphMW5EUkpFOG1QdlNTcllJeXhrVXhq
QUFSVTUxY1Jzb28ybjBlTHdUR3RfU3FQSl9UbjAkIA0KPiANCj4gSGFuZC13YXZ5IGFzIGluIGxh
Y2tpbmcgZGV0YWlsIHdoaWNoIG1ha2VzIGl0IGhhcmQgdG8gZXZhbHVhdGUgdGhlDQo+IGFyZ3Vt
ZW50Lg0KPiANCj4gPiA+IE9yIGp1c3QgZ2VuZXJhbGlzZSB0aGUgeGhjaSBpbXBsZW1lbnRhdGlv
biBmb3IgcGFyc2luZyB0aGVzZSByZWdpc3RlcnMNCj4gPiA+IGFuZCByZXVzZSB0aGF0IGZyb20g
dGhlIHN0YXJ0LiAoQXMgYSBib251cyB5b3UnZCBzaHJpbmsgdGhlIGtlcm5lbCB0ZXh0DQo+ID4g
PiBzaXplIGJ5IGdldHRpbmcgcmlkIG9mIHRoYXQgaWZmeSBpbmxpbmUgaW1wbGVtZW50YXRpb24u
KQ0KPiA+ID4gDQo+ID4gDQo+ID4gSSBkb24ndCBsaWtlIHRoZSBpZmZ5IGlubGluZSBmdW5jdGlv
biBlaXRoZXIuIFdlIGNoYW5nZWQgdGhhdCBoZXJlLiBUbw0KPiA+IHJld29yayB0aGUgeGhjaSBo
ZWFkZXIgYW5kIGRlZmluZSBpdHMgZ2xvYmFsIGhlYWRlciBzZWVtcyBhIGJpdA0KPiA+IGV4Y2Vz
c2l2ZSBqdXN0IGZvciBkd2MzIHRvIGdldCB0aGUgcG9ydCBjYXBhYmlsaXR5LiBSZWdhcmRsZXNz
LCBhcyBJJ3ZlDQo+ID4gc2FpZCwgaWYgd2UgX211c3RfLCBwZXJoYXBzIHdlIGNhbiBqdXN0IGlt
cG9ydCB4aGNpLWV4dC1jYXBzLmggaW5zdGVhZA0KPiA+IG9mIHRoZSB3aG9sZSB4aGNpLmguDQo+
IA0KPiBObyBvbmUgc2FpZCBhbnl0aGluZyBhYm91dCBpbXBvcnRpbmcgdGhlIHdob2xlIG9mIHho
Y2kuaC4NCj4gDQoNClRoaXMgd2FzIGhvdyBpdCB3YXMgb3JpZ2luYWxseSBkb25lIGluIHRoZSBl
YXJsaWVyIHZlcnNpb24gb2YgdGhlDQpzZXJpZXMuIFBlcmhhcHMgdGhhdCdzIHdoeSBJIHdhcyBh
Z2FpbnN0IGl0LiBJdCBsb29rcyB3cm9uZyBmb3IgZHdjMyB0bw0Ka25vdyBhYm91dCB4aGNpX2hj
ZCBzdHJ1Y3R1cmUuDQoNClRoYW5rcywNClRoaW5o

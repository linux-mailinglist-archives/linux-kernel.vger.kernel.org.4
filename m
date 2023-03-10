Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0AC6B5577
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCJXSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjCJXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:17:41 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF61125A4;
        Fri, 10 Mar 2023 15:17:39 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALn8Yf024195;
        Fri, 10 Mar 2023 15:17:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=dyidMSBGczqKGBPXdq2X++7SQAg5DMMcliAFeexdqg4=;
 b=mmzgOLy6T7IaTOnR4H3dNjL8wlbfv6rsIOuJO6bcPxexYVoqdgsY6f1VUhXzpN2Vr+d9
 iNw/yp61IgXableKHRgxFOQ3L6turmyCRtB2M9VtY9uoswlzm4v94cprNTjcoohIqQEo
 graadMSEST9eMQvm+t95ymcpqrEO93i5nxXL3ZXcHlXP6LzC4Mh9nKkp9oKBJlFnToCN
 d02gUQ1XRuyf16IW9VYfL9zUKYyBpeVnScboqzTtYB2PnYOPbiRUxBynMTQFYMBGkY0h
 3MoaUtV3cjgVuhmjAQ8IouTpa52WZuf4QYevl7FjavRBq5fFVDl1ICb5KkK7a0d4Mxd6 Yg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p6fen4q1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 15:17:32 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E21240083;
        Fri, 10 Mar 2023 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678490252; bh=dyidMSBGczqKGBPXdq2X++7SQAg5DMMcliAFeexdqg4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KMuycf16zKZhkZDVYy0X/naOnkJ6xlYHU45lDyU75hMvVcE7LLuWrsAwKxfh9eyYw
         hcsxZiqarZz07oQp4EEhJLMtZYCxHuaZIfe/mE4vxya4eUh5cjT1LwdQEk6YI9C1MU
         r3uTcZ80cy3Od8B1wsmmlj+FRJSYthj7Y5ISEN4HVNbhtMgNG2nUZg7k19/rz4coha
         e1tjpsdteO4Mafl6bzA98CjfxL8NvLHZul56gXtryJZASN6d3K13YXo1KwA+swJl53
         BFpCC4qNYz59GXdU9LG1o7Zlx13u9J1F6NPsoLnELqL1WJKw7AIOjZ6k7r3gzaL1mL
         m/MnMpICDriyg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A284BA0062;
        Fri, 10 Mar 2023 23:17:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 42FD8400A3;
        Fri, 10 Mar 2023 23:17:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TkL23qeq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf+yD+mO7uTPPhkXvAUEPy2XepZpHec/W48+j0xXuxmkC8xR3ki5b1SgZPFLIpOLqSQ/r3yR1s0jGj/NrsU9yOSwPrJnvKRbBvstGiM7ZSfTl2T9P+R1wj6s7Qep9hIx1M+bdudLIlT3ULf81jUr0wpQRMAGrK+DYKJW2FolHj3P+reTuM6hTrz5hbHRg4moztHfeWPI5oyXDUrFwKb0etiTOEOzRC67MIE5wpD7scVFSV5JV9T/E+DwTeNMITvO0IzVhWJoaBYEa652+E8W8OB7tnWjzrwXkcGvYEif6M7VkkaTIGy7mxyuNH9d+gJM8TeDXAY1o5POJba66EUGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyidMSBGczqKGBPXdq2X++7SQAg5DMMcliAFeexdqg4=;
 b=Q0anI4jZ/rBCqPze0+zwOpyVapbr6B2G59N3s0zrfTm/pQiXbuaURhJ4giQl1yck9vQtQxbBH7JGmU+ZpZbPWCtwJJOCMjVNzGHH4nDnlrmhfihxS/RHdvVWlgpFERu8kGhgxtSf9zRIM9SLxbRRBgvzzKZ44qrwN+oWPp0bR1M+7NXZtK/R6CQ8OsG7Sid6zyYA2hs8jZTEen6Ht/p8eHegn9yOKNbZz2nEXgczFqlI48j+zPdBG7hhfyZ608xDP4mJoVHCnWsWmsGXe+KvJ2JItrvaN38D6nlBtwGBPh5IHdoSshjr+lyJlFj+/ey/X7RUt+XJVkARTB5H42I0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyidMSBGczqKGBPXdq2X++7SQAg5DMMcliAFeexdqg4=;
 b=TkL23qeqrqB/ylovaMcEsvjni3sg/jB63lWBGFvRZOSJANHYeyURRW6zXgkE9dfpRd00St2vTS2MuzjeX4XKb3LPt49bdKkeG6PwsFm9u3eGyl7eKlqTqi+xIYKN88cxAyCnlgkrirvobgI5U4oatgcjul+72ALmbdpQEdaL5Ls=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 23:17:27 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 23:17:27 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v7 3/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH v7 3/5] usb: gadget: Add function wakeup support
Thread-Index: AQHZUsVANwPDcup/MU2LfLlbjMdWnq70p2WA
Date:   Fri, 10 Mar 2023 23:17:26 +0000
Message-ID: <20230310231723.toshpghfenuymjnd@synopsys.com>
References: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
 <1678393499-7366-4-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678393499-7366-4-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA0PR12MB8351:EE_
x-ms-office365-filtering-correlation-id: ad7178bf-fbb9-483c-693b-08db21bd9cca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ren7MLWU2ks30EsbBGRYkYQO36A91ACWtmjhkWawJuIdpv0/ZJQRem/T3KdzxfLBJWALyHOjA9Oz9mY7b/hadNvYmDwlSsLe7WH1xn0YaiLkXxl4mQC5fZzly+satHrHv1oQW5OoZlB5QnTJ5Lqi0gjk0MhVC+7ChIIMJMIlsqW5MnoN/OhntN5FPpZilGXHoMC1l/4ZOICBEAwILE0HQka5tAp2i1AAj+22Bm4ZE7/4/6bLfmAiHvlgxvinEU4Y132Fx0sVmDxI4ijfKC74yfEKD+r1SQG+bB0q/gJQBUQj7FTeAg+7K+lEc61pEr0F1nS3c2xsWHuCDD5zS22PM1Aj+mN9W7GdUTr25XjC/s5yEwSx8u3fS60Can4XnzXq/yb5Eu9nWaqrhdybmJTjcbp//5NUkK3KzR50BkD33ixBdn8V9d7Rd0nLHKG4caFnrI4iXRdMIwhxNaqwUGzZ6yGrJiFyiNhO3uhMDpBIiUY69beqqwXv60kF4Ho8qiWqUcm2fzQqwsYMvE0P2t4s++lbM+t7aP2Qed3MQ9TCWkoL5/zGsELXg1MSThzZa1RQQ1UrzCXlm+dHchdbb4ZK+ObRiH5UiTo1oWLmoUdG94WfLfCxM9asltbzkGwv0OTefV3f+iXhoItIkfWo7EkHQXGmAefbUJPRyFB3Pok8tMFADbsG5yXFjPuduLdK6+AJMlv+p8hcSyeHV9Vg8QY7Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(83380400001)(2616005)(3716004)(71200400001)(4326008)(64756008)(66556008)(66946007)(8676002)(66476007)(76116006)(66446008)(5660300002)(26005)(2906002)(186003)(6916009)(122000001)(478600001)(41300700001)(36756003)(38100700002)(8936002)(1076003)(54906003)(6486002)(6506007)(6512007)(38070700005)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WE1ONW1BY2pObFJVbDdKU0lKVk93ZW0ycVpUN3NPaGRjVDlsT2Y2WEdyTVFI?=
 =?utf-8?B?cXlTRDQ5MGhSR0U1Wk9qVXk5WGlBV0x0RlNXRHJVeXluWTdKUzJWb2pVSmlW?=
 =?utf-8?B?OGVtNXZwS3JzKzRObnFvR0N6WGJxUlUrbGZhM0FkcjhBdTE1NWV0T2c0UDcx?=
 =?utf-8?B?SlhMTXZ0RTZNQ21Kc0I4OGtENVVUUHFNdm0vcHliaUR2VTBnWUlwYUFlUU5i?=
 =?utf-8?B?VHdoMnFCeFhDYWxRS25OcnNGd05vV3hHWUF1Um05a2lyZVAxV0VnSmZsRU5D?=
 =?utf-8?B?SHk4MDRBSU5BZ0N2MFpPWDFickJEMnJ1cDZYZHdBMWtVRUdZN3lTRGdqUGQ3?=
 =?utf-8?B?QWNuZ2drRFFUR0pTYll2TlU4Q3MvalJjTXYzenJXVEc1eUNZK3FIQWhFdEJW?=
 =?utf-8?B?VTRPUXB5S1h5cHVKK2UwZXRuOG5WN2JLTmRiSnR6aFJNQTNkWFRFWUhBSE13?=
 =?utf-8?B?eitmc0JKL3dtdFVzREZuSVRLc1BvVmdaRmRCbkQzM01FMmFSUnUxS2EwQkVy?=
 =?utf-8?B?RWs1TWowbUJVbEZXOUdVY3RsanFqYnJvMXpBUlNUUmpmWjdpTTk0RytPaTk5?=
 =?utf-8?B?TGVsQlNZNzVxemxLK3NGNDduS2NwdS9QSlZjVXVpTUhGSHpPVkkvN1VtWE5p?=
 =?utf-8?B?SDMvK1o5U2FPL1p3U2sxRkVlQUx1M2ZkMGk5U0FwNU01NTdGMkUzVmROUUlz?=
 =?utf-8?B?Wm81YWI2RHo3TGlZOXFhTlJ5RlFmYVo2aE42dE9ETWFQbkZna3JoNjMzVm5X?=
 =?utf-8?B?REcvK0kzZmoxTE1IUmZDQ01DaTh2NXl5NmRIVmcyaVdHRXgraDkyVDduRnIz?=
 =?utf-8?B?ejI1R2QvZTRMenlBckJLRUVIZFh0dWxrVHdCclYxOGI5MGhraVZaTVA1VEZL?=
 =?utf-8?B?SEllQ3dzRzRnRlZvTVpCS1NVOVVnUDNJVG5CV3RtdmJaMkxxcHd3WGVRdDM3?=
 =?utf-8?B?S3lQTXRZUUJlMFNmNWtQYmtSVGc3Qkt1YXFqVGFhZnVpeWlVSEJqRUNoOEJn?=
 =?utf-8?B?YXV4Q1dmeEV3M3B6Q0NKSmlOOEVUR2NYbitiNmxZQmt0QWgvbUtBc2U2SFJS?=
 =?utf-8?B?c0VnS2pJaGwzOEtQcFdzaXlRWUdRR1VoV1VKT0FDb2dlVEIrZklDWDc0Znpn?=
 =?utf-8?B?SzROdlg0Tnk0cCtUWk5wWWNZS01GWENPV0Jhd2NrTXhqc2hoSDNZOWFpbTBw?=
 =?utf-8?B?d1BrdHFzNExKNndUbEdNNG9kU1B1ME56elFZOEZZWURXK2k5cWlRWkdYcVJH?=
 =?utf-8?B?WWFESXhQNk5hTkgwQ0ZLRUF1a1NLVTZzRFQ2N1F0RzF0TDIxVXpoTWZmakVl?=
 =?utf-8?B?MktDaWFUQ1dYbHAwMWVmaVVCamdva2Nad0F3ZDQxQjR2S2NNcWpMbnlDSFN1?=
 =?utf-8?B?aGVhQjdZSVVKVzczWExzeVJPNEVyVFFUeVFRQTJ3MG40b3hGVHdQajhSdzZO?=
 =?utf-8?B?c1E0R0I3YkwrcTh1WlF6ekY2VWJhVlZSMzlyVU55dDJZWmZvVnJMUTdMNXBm?=
 =?utf-8?B?WW1qL3hmR3llQ0UvMGN6TVFXRnh6U2VjbmRHb0ErcXhyL3dFQTFSU2l3YTE1?=
 =?utf-8?B?ZnQ3dnNpN1R0RDZkSzRxZDJWTHpxY1AwNG9ZVkQ5OHcxdG5sc0VTVlZtR1pM?=
 =?utf-8?B?L2JmVFpSc1Fzc0VndkJaMDZFaTlFQ2cwK3d4b1NLOWNqVlV2d01JdmluTnB0?=
 =?utf-8?B?T1hzK0JEenQ2TWVxbnN6NDJZM3NWVnQzY2JMY3pGdEF1c1BzUXpweVdPY0Q1?=
 =?utf-8?B?Vy9FZXMzYnZrR0UvZlJxdzV5QjZKUEZBRzZqaHcycnB6emxRcWhOL2wyVVc0?=
 =?utf-8?B?NGlTYVlpT055ek4vNDUvRU5aaWpub2hTQWk3YktOaWdSS2tvaGVsS0ZRaTFz?=
 =?utf-8?B?Y2Q2MkltbURkNzdEWXd5VHZNVHFxQ0VGUmxJUkxCWU1PMHFCTlJnZ1pZNGpM?=
 =?utf-8?B?WDZ1cHk0N2xZNnNEZXdQK2duYy80TS9IV1FJcmNMSGlDVHl1TzFjWlVqdEhs?=
 =?utf-8?B?WnlhQllnMjgzcmE1bWZ4QkdZa3dJek9oM3B0YlZQL05Nc242ZitlVklMRXFz?=
 =?utf-8?B?bW1DakJmemhoREtLcThSOFR2cGFWalp1NHNEdnZJeC9ablplVFlZckRzR3dt?=
 =?utf-8?B?MHZ3U09PcXZXQVppdVlwUHNtZ3FGQU1ZNk81djdjVnRROHhIeGppMG5DRDB3?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7111EE808F54014C9F1EBA3388F46E19@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RtrH64ZOO6/CGJdld/z4HpadeaHjDB+F7EWOwRS6cN4j843opLOV9NtQL4dxYIY42kgj480YOU7HmbitCC4O8t4WYPXfyWykpm7oeE8pyD/BjtTQt3QCEX8qipy2f4coGDAVVg5/QDjnynTZmR6qURwlrRwoLZgEs7y9iaxQMq8M7ATb6HNrG2BKX8as0Ue3WzQVH604JaIBhSRxkDhjaEb1XcMSZQSLg13ykHNr/5FpdMuEz487s20olJi0wVQv4SdNk7h9WX2NTwE8cXX1yAamZ2/kRyY9U0sIeH2CaZDvA1NlsahzerE5Rr0z53sij0Y6XG93z/W9vzfVkKw0dNYps6ug7TuGatz5iYaIMbAPBNYWmg1Uj3ViDjdgHnCvybpfFny4lRCAcuWltrz6E16LXQj6KyjbpDsvbZIijl3ICDWlelt+Z18FyN3B5M4CNbmv4VfGwJ9QJSRp3pAUk8hY9cAjE1465xvGOPoHT5RoQ/kJvGj+1abi6ey36GgWvbpkMAi8mOvZiZFTtO0KBIdimjJaIZDjoZGdFwz99PYM6k+LzQJx+EvAF+pjKeaNMdLd4i1bG7i76hvbRGOkSNqigr73bWsiwkKQ/SZcs4a+vK71rVRBHgKr8PZbB0NCV7wVJg9Be8nyoC0QIi78PPoVro6FhwdJUUX70rlLv/QjkRxW7FunbYnQHO3P1L6kwdEfqMNhq/Z1P8x7rN4QE/RHLKwcokJUEqJaDqRKARrZLyPTEvcgrbC1xsuTB7GOs0ekvfxnGtvbhHHNTMYbX++8gRKIYDXQz5JTVnFNTJlfl6S4trn00PYDppNof1yc92x9QqzhDO3mDZEe1cNfE+6i620fAVTqj4r325lcZtzDuiuM6wbUC5jDAh3MrzZzuwaU67xbpE8R6ijrWu9NlmrmhTz5LKGBA1zDw9lpy+o=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7178bf-fbb9-483c-693b-08db21bd9cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 23:17:26.5791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZNoL7tXJqPseGmUrjM0JhDJLLwB+tORBEiNwXYWuveRRmksg1is/Nr9C8ErI5WHgXfpWtMVmlGJiu6V5q++kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
X-Proofpoint-ORIG-GUID: FByp8MSxUvmlF8R2xDuWqLTCZBQ9O8Q7
X-Proofpoint-GUID: FByp8MSxUvmlF8R2xDuWqLTCZBQ9O8Q7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=713 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMDksIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFVTQjMuMiBz
cGVjIHNlY3Rpb24gOS4yLjUuNCBxdW90ZXMgdGhhdCBhIGZ1bmN0aW9uIG1heSBzaWduYWwgdGhh
dA0KPiBpdCB3YW50cyB0byBleGl0IGZyb20gRnVuY3Rpb24gU3VzcGVuZCBieSBzZW5kaW5nIGEg
RnVuY3Rpb24NCj4gV2FrZSBOb3RpZmljYXRpb24gdG8gdGhlIGhvc3QgaWYgaXQgaXMgZW5hYmxl
ZCBmb3IgZnVuY3Rpb24NCj4gcmVtb3RlIHdha2V1cC4gQWRkIGFuIGFwaSBpbiBjb21wb3NpdGUg
bGF5ZXIgdGhhdCBjYW4gYmUgdXNlZA0KPiBieSB0aGUgZnVuY3Rpb24gZHJpdmVycyB0byBzdXBw
b3J0IHRoaXMgZmVhdHVyZS4gQWxzbyBleHBvc2UNCj4gYSBnYWRnZXQgb3Agc28gdGhhdCBjb21w
b3NpdGUgbGF5ZXIgY2FuIHRyaWdnZXIgYSB3YWtldXAgcmVxdWVzdA0KPiB0byB0aGUgVURDIGRy
aXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJh
b0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMg
fCA0MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRl
L2xpbnV4L3VzYi9jb21wb3NpdGUuaCAgfCAgNiArKysrKysNCj4gIGluY2x1ZGUvbGludXgvdXNi
L2dhZGdldC5oICAgICB8ICAxICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2Ry
aXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBpbmRleCBjOWM5ODNlLi4yMTExNzMyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IEBAIC00OTIsNiArNDkyLDQ2IEBAIGludCB1
c2JfaW50ZXJmYWNlX2lkKHN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqY29uZmlnLA0KPiAgfQ0K
PiAgRVhQT1JUX1NZTUJPTF9HUEwodXNiX2ludGVyZmFjZV9pZCk7DQo+ICANCj4gKy8qKg0KPiAr
ICogdXNiX2Z1bmNfd2FrZXVwIC0gc2VuZHMgZnVuY3Rpb24gd2FrZSBub3RpZmljYXRpb24gdG8g
dGhlIGhvc3QuDQo+ICsgKiBAZnVuYzogZnVuY3Rpb24gdGhhdCBzZW5kcyB0aGUgcmVtb3RlIHdh
a2V1cCBub3RpZmljYXRpb24uDQo+ICsgKg0KPiArICogQXBwbGljYWJsZSB0byBkZXZpY2VzIG9w
ZXJhdGluZyBhdCBlbmhhbmNlZCBzdXBlcnNwZWVkIHdoZW4gdXNiDQo+ICsgKiBmdW5jdGlvbnMg
YXJlIHB1dCBpbiBmdW5jdGlvbiBzdXNwZW5kIHN0YXRlIGFuZCBhcm1lZCBmb3IgZnVuY3Rpb24N
Cj4gKyAqIHJlbW90ZSB3YWtldXAuIE9uIGNvbXBsZXRpb24sIGZ1bmN0aW9uIHdha2Ugbm90aWZp
Y2F0aW9uIGlzIHNlbnQuIElmDQo+ICsgKiB0aGUgZGV2aWNlIGlzIGluIGxvdyBwb3dlciBzdGF0
ZSBpdCB0cmllcyB0byBicmluZyB0aGUgZGV2aWNlIHRvIGFjdGl2ZQ0KPiArICogc3RhdGUgYmVm
b3JlIHNlbmRpbmcgdGhlIHdha2Ugbm90aWZpY2F0aW9uLiBTaW5jZSBpdCBpcyBhIHN5bmNocm9u
b3VzDQo+ICsgKiBjYWxsLCBjYWxsZXIgbXVzdCB0YWtlIGNhcmUgb2Ygbm90IGNhbGxpbmcgaXQg
aW4gaW50ZXJydXB0IGNvbnRleHQuDQo+ICsgKiBGb3IgZGV2aWNlcyBvcGVyYXRpbmcgYXQgbG93
ZXIgc3BlZWRzICByZXR1cm5zIG5lZ2F0aXZlIGVycm5vLg0KPiArICoNCj4gKyAqIFJldHVybnMg
emVybyBvbiBzdWNjZXNzLCBlbHNlIG5lZ2F0aXZlIGVycm5vLg0KPiArICovDQo+ICtpbnQgdXNi
X2Z1bmNfd2FrZXVwKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmZ1bmMpDQo+ICt7DQo+ICsJc3RydWN0
IHVzYl9nYWRnZXQJKmdhZGdldCA9IGZ1bmMtPmNvbmZpZy0+Y2Rldi0+Z2FkZ2V0Ow0KPiArCWlu
dAkJCWlkOw0KPiArDQo+ICsJaWYgKCFnYWRnZXQtPm9wcy0+ZnVuY193YWtldXApDQo+ICsJCXJl
dHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KPiArCWlmICghZnVuYy0+ZnVuY193YWtldXBfYXJtZWQp
IHsNCj4gKwkJRVJST1IoZnVuYy0+Y29uZmlnLT5jZGV2LCAibm90IGFybWVkIGZvciBmdW5jIHJl
bW90ZSB3YWtldXBcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwlm
b3IgKGlkID0gMDsgaWQgPCBNQVhfQ09ORklHX0lOVEVSRkFDRVM7IGlkKyspDQo+ICsJCWlmIChm
dW5jLT5jb25maWctPmludGVyZmFjZVtpZF0gPT0gZnVuYykNCj4gKwkJCWJyZWFrOw0KPiArDQo+
ICsJaWYgKGlkID09IE1BWF9DT05GSUdfSU5URVJGQUNFUykgew0KPiArCQlFUlJPUihmdW5jLT5j
b25maWctPmNkZXYsICJJbnZhbGlkIGZ1bmN0aW9uXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIGdhZGdldC0+b3BzLT5mdW5jX3dha2V1cChnYWRnZXQs
IGlkKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVzYl9mdW5jX3dha2V1cCk7DQo+ICsN
Cj4gIHN0YXRpYyB1OCBlbmNvZGVfYk1heFBvd2VyKGVudW0gdXNiX2RldmljZV9zcGVlZCBzcGVl
ZCwNCj4gIAkJc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjKQ0KPiAgew0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmggYi9pbmNsdWRlL2xpbnV4L3VzYi9jb21w
b3NpdGUuaA0KPiBpbmRleCBkOTQ5ZTkxLi5hMjQ0OGU5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3VzYi9jb21wb3NpdGUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3VzYi9jb21wb3Np
dGUuaA0KPiBAQCAtMTUwLDYgKzE1MCw5IEBAIHN0cnVjdCB1c2Jfb3NfZGVzY190YWJsZSB7DQo+
ICAgKglHZXRTdGF0dXMoKSByZXF1ZXN0IHdoZW4gdGhlIHJlY2lwaWVudCBpcyBJbnRlcmZhY2Uu
DQo+ICAgKiBAZnVuY19zdXNwZW5kOiBjYWxsYmFjayB0byBiZSBjYWxsZWQgd2hlbg0KPiAgICoJ
U2V0RmVhdHVyZShGVU5DVElPTl9TVVNQRU5EKSBpcyByZXNlaXZlZA0KPiArICogQGZ1bmNfc3Vz
cGVuZGVkOiBJbmRpY2F0ZXMgd2hldGhlciB0aGUgZnVuY3Rpb24gaXMgaW4gZnVuY3Rpb24gc3Vz
cGVuZCBzdGF0ZS4NCj4gKyAqIEBmdW5jX3dha2V1cF9hcm1lZDogSW5kaWNhdGVzIHdoZXRoZXIg
dGhlIGZ1bmN0aW9uIGlzIGFybWVkIGJ5IHRoZSBob3N0IGZvcg0KPiArICoJd2FrZXVwIHNpZ25h
bGluZy4NCj4gICAqDQo+ICAgKiBBIHNpbmdsZSBVU0IgZnVuY3Rpb24gdXNlcyBvbmUgb3IgbW9y
ZSBpbnRlcmZhY2VzLCBhbmQgc2hvdWxkIGluIG1vc3QNCj4gICAqIGNhc2VzIHN1cHBvcnQgb3Bl
cmF0aW9uIGF0IGJvdGggZnVsbCBhbmQgaGlnaCBzcGVlZHMuICBFYWNoIGZ1bmN0aW9uIGlzDQo+
IEBAIC0yMjAsNiArMjIzLDggQEAgc3RydWN0IHVzYl9mdW5jdGlvbiB7DQo+ICAJaW50CQkJKCpn
ZXRfc3RhdHVzKShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICopOw0KPiAgCWludAkJCSgqZnVuY19zdXNw
ZW5kKShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICosDQo+ICAJCQkJCQl1OCBzdXNwZW5kX29wdCk7DQo+
ICsJYm9vbAkJCWZ1bmNfc3VzcGVuZGVkOw0KPiArCWJvb2wJCQlmdW5jX3dha2V1cF9hcm1lZDsN
Cj4gIAkvKiBwcml2YXRlOiAqLw0KPiAgCS8qIGludGVybmFscyAqLw0KPiAgCXN0cnVjdCBsaXN0
X2hlYWQJCWxpc3Q7DQo+IEBAIC0yNDEsNiArMjQ2LDcgQEAgaW50IGNvbmZpZ19lcF9ieV9zcGVl
ZF9hbmRfYWx0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmLA0K
PiAgDQo+ICBpbnQgY29uZmlnX2VwX2J5X3NwZWVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBzdHJ1
Y3QgdXNiX2Z1bmN0aW9uICpmLA0KPiAgCQkJc3RydWN0IHVzYl9lcCAqX2VwKTsNCj4gK2ludCB1
c2JfZnVuY193YWtldXAoc3RydWN0IHVzYl9mdW5jdGlvbiAqZnVuYyk7DQo+ICANCj4gICNkZWZp
bmUJTUFYX0NPTkZJR19JTlRFUkZBQ0VTCQkxNgkvKiBhcmJpdHJhcnk7IG1heCAyNTUgKi8NCj4g
IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmggYi9pbmNsdWRlL2xp
bnV4L3VzYi9nYWRnZXQuaA0KPiBpbmRleCAxZDc5NjEyLi43NWJkYTA3OCAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91c2Iv
Z2FkZ2V0LmgNCj4gQEAgLTMxMCw2ICszMTAsNyBAQCBzdHJ1Y3QgdXNiX3VkYzsNCj4gIHN0cnVj
dCB1c2JfZ2FkZ2V0X29wcyB7DQo+ICAJaW50CSgqZ2V0X2ZyYW1lKShzdHJ1Y3QgdXNiX2dhZGdl
dCAqKTsNCj4gIAlpbnQJKCp3YWtldXApKHN0cnVjdCB1c2JfZ2FkZ2V0ICopOw0KPiArCWludAko
KmZ1bmNfd2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBpbnQgaW50Zl9pZCk7DQo+
ICAJaW50CSgqc2V0X3JlbW90ZV93YWtldXApKHN0cnVjdCB1c2JfZ2FkZ2V0ICosIGludCBzZXQp
Ow0KPiAgCWludAkoKnNldF9zZWxmcG93ZXJlZCkgKHN0cnVjdCB1c2JfZ2FkZ2V0ICosIGludCBp
c19zZWxmcG93ZXJlZCk7DQo+ICAJaW50CSgqdmJ1c19zZXNzaW9uKSAoc3RydWN0IHVzYl9nYWRn
ZXQgKiwgaW50IGlzX2FjdGl2ZSk7DQo+IC0tIA0KPiAyLjcuNA0KPiANCg0KUmV2aWV3ZWQtYnk6
IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhp
bmg=

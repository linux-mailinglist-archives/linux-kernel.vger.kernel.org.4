Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C86D7005
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjDDWRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjDDWRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:17:04 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785A40FD;
        Tue,  4 Apr 2023 15:17:02 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334LZTI3016763;
        Tue, 4 Apr 2023 15:16:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=yt+tqEvrdaEIDs4CSI10NdQ6yeyKgS1CTAKduziSsQo=;
 b=upw1EW4svPjDSD9S+pAhjI+ajn5hIckDy0lpxmsV7xxzFCGfsMu407LSxQD79i2s70dc
 wPRFLDXiN2EEzOd5f/ZGfodi+QUqUoMA1mTrDY17vKzBvnYvNMb8Ri+ZWX4ZK9Ih7Abc
 m5Aqrfnpbxr8jO0eJzlJeZB8ltb0pfm2Al9yDCX+iOwCT2/6EmcZYN0P89zXYcO2/Ppa
 smCx7HMURgKMPfEdrYSYkRIKhGhDumBnZ+gULnYAwQw8wHDoOx+6YC+eNmFAVIAUrZkd
 CHlzEu/iFNwqOOIWGx2Aorwz5KSFStsYZK2F4kAN0HZFTMg8Bxj+06pUezrRXjAoiYv5 pg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhxjd2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 15:16:58 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EFB454014D;
        Tue,  4 Apr 2023 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680646618; bh=yt+tqEvrdaEIDs4CSI10NdQ6yeyKgS1CTAKduziSsQo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MA0lqPJR4iLsiHOCH97Mw7GC4Z44m5UAxszEjlsCyrYsMZZynf+ZMhK3hokk/e2ST
         8c4nCafMkF/oyadFCSMA2WOTdV7C89/E318otUUAQcpt6xR/R3GeG9JwofLgyT2XHt
         4qyT52PESOQW+xQOJbDmRg3nF6db5sPY1sWxC7WaYjFUmgwZhhCj7xtfu8nJcRUPAY
         4YweWBvKAgxXZjbBHWuRWjYN3dpUdleKt16jrKVdssPUhFXi5EnAhR1Ldw/304fnYJ
         UYcz3lz2S2WK41gpsbNiSHaAuzN9k3kym4Sxd/fmJiNvhEvYwV1MkJYxswS3EKqwgf
         rBr9/LSB25JBQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A741BA0063;
        Tue,  4 Apr 2023 22:16:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 42B564010A;
        Tue,  4 Apr 2023 22:16:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="OC7K9FQB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COiit1qiupR41Kq1fmyeh/XC5i07+R9bWKA6O0ZT3xtjBJf/tCafGkPqOCTIMQozER0Kg0gJQzVDk0/LSdtEZt7X6/leDcMSh6aOzXSJhZN6HAWqwY+e6Cq0NkcJneVpftaAIFMY9aoyxhrhVpy7UFI+g9GmAj2o6BZOC//D2Pb/LtWrkp60g8k+SDbt9Ju69ZHbRK2BL1sJjWLDDvoFMVTB/qgc1SOLGhXmknSlKq0wN7NW1VmpZPJZETawZLT8YQs43zaGiXXVIkWZetFHFwHJBS031wEdKE3I/uOPfbgXYEF7tpBWljEHkCULPxQr8uRMGifZ6O0O7O8+ChZMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt+tqEvrdaEIDs4CSI10NdQ6yeyKgS1CTAKduziSsQo=;
 b=hrsf3TpS5OZtazCeCipFrqKswsbbmrN19Zk2e1DukzWSdw6ZTcE7ZxsTIUlwLwHdn3VpHFpqel+6SjoXPvSi3F0vgN22ZcTIk4WwuctrisehHkJnjM+e7smdPi2m43sR5F8VmGeycxi1m/9SCjDP1zdRfUCBo8k0lX1c0d054zEh8TJ6CH1SWGTdbZuCCIqxRKqVPH9MeI5kG64Z/aD2KlKdS41tfdYZeeGckRLYmNUz1gPtp7o3K/SVwyPDgB5/npETJhkq0cuIFbrSmQdxphtTkREy4xqHkNVPs/hUFV06zBcl91WOpYtft6iiQfe0etAk3ayHyRZa3mv6OcvsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt+tqEvrdaEIDs4CSI10NdQ6yeyKgS1CTAKduziSsQo=;
 b=OC7K9FQB4Kb5RAwa+4xLaiC2NOUuLbsDgfARiJZhFuhoZUnjwthlpioNhn/cvoK0FoEbs7UWTZr1sprzQtMkA6mofyDF/YVDxMyRMuK7u9YwXHDCOTPJYttQrtOS36FSui474p/BKAnTObZKgrQv7WrY/fYJBfAWfwjbypP1jQ4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 22:16:53 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 22:16:53 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Thread-Topic: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Thread-Index: AQHZZCdzfLLJh52qvUySQjzgywjsKK8aXF0AgAEnp4CAADn4AA==
Date:   Tue, 4 Apr 2023 22:16:52 +0000
Message-ID: <20230404221648.5fbajncfhd6wxkku@synopsys.com>
References: <20230331232039.1407-1-quic_wcheng@quicinc.com>
 <20230404011108.727htmnllj7ojwqm@synopsys.com>
 <c8181845-0f6a-9c6b-69bc-4ce9dabdf041@quicinc.com>
In-Reply-To: <c8181845-0f6a-9c6b-69bc-4ce9dabdf041@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7289:EE_
x-ms-office365-filtering-correlation-id: 622e815d-3894-474f-5bc2-08db355a4ad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrpWbI71JKBR8kqumfkBK7hqdyvkMaGM2otUqHOdspUrVBQrzo7HnFjX9PAM0UKy0owxmNRQRKcMiZV0fGCxYBPF8K/pWm1HOx/DfzF191ct64xlQdn+IBTVZYhAg8J8T04d+x0o3nNYiWa77tti74KVq/RctPZf2kR4h1wh6VIIkyLfdNpJJXO7FwIdpcFi+n/q0x8uwc7KtSOqrub4H56FVic2aHPDH5NvjWqGnABYy3QuTzFJEtvICUizozG9YIBL1gvLjX12sjMZUrqcCgO3jedLy9K383/ms8UPXdE3np4CurkUf1qdTq1sm3b15feR+3Kau7pEUYKa+QqjI4bRoNjyyzJPj2XXxeoMbjWU6/XojBorcPw43MCF+5X/SYOXoLmGu2rC2FNv3AtpKb1X5kCnv7aZilfLQ4VbD8t5cAstbMe0KkAACYOjXRjMtQwPAz5uZ15LYJ28e3mnSXfSWiuWfqcrHYelq5WOUz4BPZ9JWc59MqtEyp19nFFhgblYwRvlmDA0AorsTbBoOKHTKXKSw0bldguB33bVzvmbDLKBmWQ17bXncEH/mdFglHF62TEZChP8HenmlV9ttrhE7e46xehUnlOSnldbbMVFC41Dq1+8vxyV+PKrSPgi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(86362001)(38070700005)(36756003)(2906002)(2616005)(71200400001)(6486002)(186003)(53546011)(83380400001)(6506007)(1076003)(26005)(6512007)(66946007)(76116006)(66476007)(66556008)(8676002)(4326008)(478600001)(66446008)(64756008)(122000001)(41300700001)(38100700002)(316002)(54906003)(6916009)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUlHbFdwK29mUWx5cWFmNTkzTkpIK0lJSXBOTW01Wjhkdko3aWRDY3FwaXRE?=
 =?utf-8?B?bXZ3WHVPTDNRS2grVy90L3lsWFJmOE55OHFVVnJvaXRzNERrY0tQazArVTVV?=
 =?utf-8?B?UnU4cmczRldMZUd6WXpPSm9pN1l2c2ZEYzBSV3BmbTR6MnVUTlF2dXRhZ3J5?=
 =?utf-8?B?WHJOU1FvcndITStsQ1hiUWJRbmVObW9VMGVXbDB0QmpyRWpmWVEyQmloMlRw?=
 =?utf-8?B?cTFrbS84Ym1sSzI2SnA0WllXbGxSVnQyTVpMZnA4eU5RYmIxT3k0Vjd0bWJn?=
 =?utf-8?B?aCt1UEE0MEpBa0xva1EwYTQ2cnhPeDVISkE2WTJjZ3ovMHB4TlBUYzVFZWc2?=
 =?utf-8?B?Z0JlQnh5N05ydmxrODY1WGYxZUdJUGhQSDBsODU4Z01nRmNYSXY5c2FJYU8v?=
 =?utf-8?B?a2FwS2dTYzBGdmtaWkhxdmVWMWpxTjI3ZXZjWTFnbEVXaWtPZlRlczZ1TzE4?=
 =?utf-8?B?a3R3QmhXdGE2TXYyMXJBNVkxQldXbHdMdXJKRUwwVEdReVhKQmFGMGt0WTZT?=
 =?utf-8?B?dVp6aG90TmRQcVpUb2N4dmQ2SE9WZzU3Q1Qxaiswa1RDWUQrUXhFSlhnTXVF?=
 =?utf-8?B?VWRkUjl0bmlzZkdZYU9ZeUpza3RqbVFqWlI4dlVFZTNrR0Y3RDJ2WGdYTGx0?=
 =?utf-8?B?WWhNTTl4RjZjZGw0dDJUcEJWWTBiOXRhdzNIckxmSnRTYkRIRmZIZERqWUxz?=
 =?utf-8?B?TU5oRFV3bmxxNnh4enljL1NBSm13dkxGZm1heHFRTU4yMVJYUzZ4cXFHZjcw?=
 =?utf-8?B?V05oUWNEVk9POUlEVHU3Nk5NMERsajZwMnJCRlhNTEtjTzRBUHdtS2hkeWI5?=
 =?utf-8?B?Z0pqSFAxdWdSNW5NeTE1bU5ZWUNIa2t5bk5UWFF0cnhIWEtDbXBvNTNDWlVQ?=
 =?utf-8?B?d09NRFhpbkNhRnp5dlhXNkpreGN5dVRxK1VMdkxXS01qcmRMV3ZIZGwwMGtW?=
 =?utf-8?B?RzVVY3ZhUHFtS0pDNGZMcG9QSDNDc2pyVDRBd0JMZTBlRGJqMVNxZnRrSlRV?=
 =?utf-8?B?UWgvWGVPVkJEWE9LeUpOUnBMS3VzVElwVTUzM1ZZQm1YYmF2UzlMcm5GbGRB?=
 =?utf-8?B?L0dyckxBdGRSV2xvc3BlR2VwbWIwVE5SUXVVRlF2VG1CUUQ0OWszWVRJUi9D?=
 =?utf-8?B?L0o0aVIrdjVMYXNYdUhIOStsM0lUeTA3SG5KNzVlYVN1Q09kUlR2TTk3Kzlu?=
 =?utf-8?B?bDFEdEdYay9oLzZQSjVmaUw0NStkNE9IbVMva2FKVXRPKzA4ZFVzRzk4RGJZ?=
 =?utf-8?B?V0RsVzF4dkJPSmxULzVNdVB0TE8zWGVKcnNsMWY5YTgrWnpGZGQvS3Q2QWNu?=
 =?utf-8?B?SUtzeHVqSUhHRGNIcnVKbGJTMzRzcGJsaGJTZk5hcEZ2Q2NzQ0FIcTFzbFZa?=
 =?utf-8?B?Q2FpU0FxRFNucFRjUzlPKzhVNzJmQ0E4eTdvL3NxbVhhQW1KRE5Ja0l1VmV2?=
 =?utf-8?B?eExNckJTS0Z2cHorcEFLM1podUpzQ3Npemh2d0QrWFhrNk9DOHRyd2VtY0FI?=
 =?utf-8?B?eUZINjAzajRXNGZoeE9seTJ3UTJBc2NGTlFnODRSVjJLekZ1VnVydlRaWlgx?=
 =?utf-8?B?Q0luQWZEVzRkV1RIa0J3ODc0anB1eHVVY0NhY3ZaTlM4YVBobm44OGxEZmNv?=
 =?utf-8?B?LzlkVTFyQ3Q4a3pRNk5VbjdHamYwbVFEb2pVZFcyVjVRYlBYVFdQRXg2VGND?=
 =?utf-8?B?OXcyWkdiamQ5MDRIZHJqSHZUek1ieWtnQi94VHVaclZJWTBlRThtbEtzR3BI?=
 =?utf-8?B?WW9XNnVJVFVJSjBycEhYS0dwZHFvTzkxQ0dNTmNldzM1aUpVUk96cHpwS1ZM?=
 =?utf-8?B?UEF1dFRybVBTbXM4cE9ISVBYTmMxckRtUVFnVlNHbTBxU2d4UmFTWXVITkFJ?=
 =?utf-8?B?alNkUHQxYzdYUUcxOFNUNHF1WjkrYVFBMEhvZWUzbXkweXBsR1lWZ1p5YlNo?=
 =?utf-8?B?aTlxWGVMa1IyM0dWSmZlYkEyTnNvTkdoeTlQZ0dpbUFzSEMvMDFpbFVGcVlQ?=
 =?utf-8?B?T3pHYVp6aGgyc3ZUdzM1Y25tMXZuUmZWQmVXSEtsRmpZdGJVNVk0WGVMM0dU?=
 =?utf-8?B?S0hSYnNsbnNzaDRFcnRkRzlQOVphNG01cTlkb2N4a3ZLeHJXalpmWE9uM2Js?=
 =?utf-8?B?RThJSm9uM0ErQUU3a3RPVDBPVXJUL0p6R3EyQTFzUnJtMkVaQ1A1Rzc4MTRq?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C76C8D9E7BB4CD4CAA77BC15C86227E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: saXgSNA/jdwFHxY4wSpof96HnCwkK/xI9JOnbX546HSnMzoumjFRikRzImiOKx3uTWFa/rG9pVgglxH3VWPQiJj5Sptt18pe8T+ODFCUTQeRgVr5zjv+kCwCc57wqMxZKPhwpaDrvaiOLCRMqU/OnznAYTcVQJ3wN5oWnJyq9byAyE6DIXdeW/iX1QnyXcF6msSDrtvRJkRZysSXYZ+yC/1BReoJfyfaEaX5aGVbS2L8aqmyl0hPtbBklaahM8uAFCdl/NgPjMy3+9MRODA9RgzILEBMj+DEHEmCGC3d0iNLhdV8yMRAmSxfnr4mmLCRPnfgpCAiNOj9CNog3zCh8SCugqhjA7Nj5j2XzEWDx+ruNeGp/ujYtW4GYqE0hJT79fYq/ooqwr74UYJkRUJw/4/3QQls/aDx14qKmd/YySlnhDcc+vyWKNe0Cl6dQCX0fgV8caNGZLxXMLgaGi5BiGvk1qDlv5CRoQbkx5he398e0ydZhiBzpBOBzjqKZv5GG3uSyOFpJJWKuzo/byfo1E0TkTuYsDcv3m+k7ikEBdQJJSjc/gRD1TlAq6t+Uw2cpr8zNT0mJmksyX+jUpRYF3wq4HciamGeQmswL97KlBaEYqTbWjFAPVU5bHXGQq4VM2+FVyEXch2TYAUGJtARd2/L9HT5h6ZdbJllql0bXapgLu2jfBONyeuq83mFkj0mGi+C9NcKyTWZxJGh+YJKduQr0UmGGOuh3CAGoVI5zrSmOKAQluILwT8s3D3WU0HPP6OSPI0hBjosxxckn+I/1HPMXCJL9QQpqsxDBI0Y0JiohSZffN5+yIPxFnOPHT7sCTqHILTlpsj3osVaoKHJ4ORO2c3994RcS63ybfMAS4c10CykOn6nE9vFPQigH3I6UwHA6gVx7CaWq9IGHhjvTA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622e815d-3894-474f-5bc2-08db355a4ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 22:16:52.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCVVl9eSQcc27a4SYM8JTpL0a0yKypPX//FzGkTFe0fTmf9OmV21tOsHmj4o/TELWWEh4LCwjg/3hQrZUx9Dzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
X-Proofpoint-GUID: d3ZoJnADY7wFjXHlFmpk1FoXUZgxC4-0
X-Proofpoint-ORIG-GUID: d3ZoJnADY7wFjXHlFmpk1FoXUZgxC4-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=803 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040202
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gSGkgVGhpbmgsDQo+
IA0KPiBPbiA0LzMvMjAyMyA2OjExIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gRnJp
LCBNYXIgMzEsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gPiA+IEl0IHdhcyBvYnNlcnZl
ZCB0aGF0IHRoZXJlIGFyZSBob3N0cyB0aGF0IG1heSBjb21wbGV0ZSBwZW5kaW5nIFNFVFVQDQo+
ID4gPiB0cmFuc2FjdGlvbnMgYmVmb3JlIHRoZSBzdG9wIGFjdGl2ZSB0cmFuc2ZlcnMgYW5kIGNv
bnRyb2xsZXIgaGFsdCBvY2N1cnMsDQo+ID4gPiBsZWFkaW5nIHRvIGxpbmdlcmluZyBlbmR4ZmVy
IGNvbW1hbmRzIG9uIERFUHMgb24gc3Vic2VxdWVudCBwdWxsdXAvZ2FkZ2V0DQo+ID4gPiBzdGFy
dCBpdGVyYXRpb25zLg0KPiA+IA0KPiA+IENhbiB5b3UgY2xhcmlmeSB0aGlzIGEgYml0IGZ1cnRo
ZXI/IEV2ZW4gdGhvdWdoIHRoZSBjb250cm9sbGVyIGlzDQo+ID4gaGFsdGVkLCB5b3Ugc3RpbGwg
b2JzZXJ2ZWQgYWN0aXZpdHk/DQo+ID4gDQo+IA0KPiBZZXMuLi5JIGRpZG4ndCB1bmRlcnN0YW5k
IGhvdyB0aGF0IHdhcyBwb3NzaWJsZSBlaXRoZXIsIGJ1dCB0cmFjZXMgY2xlYXJseQ0KPiBzaG93
ZWQgdGhhdCB0aGUgY29udHJvbGxlciBoYWx0IHdhcyBzdWNjZXNzZnVsIGV2ZW4gdGhvdWdoIHRo
ZXJlIHdlcmUgbm8NCj4gZW5keGZlcnMgaXNzdWVkIG9uIHNvbWUgRVBzLiAgQWx0aG91Z2gsIEkg
Y2FuJ3Qgc2F5IGZvciBjZXJ0YWluIGlmIHRob3NlIEVQcw0KPiB3ZXJlIGFjdGl2ZWx5IGJlaW5n
IHVzZWQgYXQgdGhhdCB0aW1lLg0KPiANCg0KVGhlIGNvbnRyb2xsZXIgc2hvdWxkIG9ubHkgYmUg
aGFsdGVkIGFmdGVyIHRoZSAobm9uLWVwMCkgZW5kcG9pbnRzIGFyZQ0KZGlzYWJsZWQuDQoNCiJl
dmVuIHRob3VnaCB0aGVyZSB3ZXJlIG5vIGVuZHhmZXJ4IGlzc3VlZCBvbiBzb21lIEVQcyIsIHdo
aWNoIEVQcyBhcmUNCnlvdSByZWZlcnJpbmcgdG8/IElmIHRoZXJlJ3Mgbm8gRW5kIFRyYW5zZmVy
IGlzc3VlZCB3aGlsZSB0aGUgZW5kcG9pbnRzDQphcmUgYWN0aXZlIGFuZCBzdGFydGVkIGR1cmlu
ZyBkaXNjb25uZWN0LCB3ZSBuZWVkIHRvIGZpeCB0aGF0IGluIHRoZQ0KZHJpdmVyLg0KDQpUaGFu
a3MsDQpUaGluaA==

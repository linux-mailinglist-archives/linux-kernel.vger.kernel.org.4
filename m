Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6156B5582
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCJXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjCJXVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:21:39 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244BE10F445;
        Fri, 10 Mar 2023 15:21:36 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALn91r015789;
        Fri, 10 Mar 2023 15:21:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=5ofEJoUVtgmxHn/CpvWKOAKamQ8ZK9/Wl7HaukwyoVI=;
 b=chSnCH//3PNlqr2SEE5BXCdM9AuJcTGihMyAOXP1eWV1eBtHLEihn4H2FjMst8qAD9+S
 FUMVy0PUw2boSnMqxymPaVnZY83IA3yl/3LRvT/mWUibq7NzxEIHkZ+jDHveDZPTSOi6
 CJZIGXb3Pt0+Mzlik1il4R7b/4eh47oQd4xFWCzRB+uvWeGtd33hAqBPhU1sFBbmDRvv
 P14W0csKMOb9VwKGl+97eBCUV23ALTrcFpy4ZL8FjoxOkUlukBXX5AerPUoSJutOAIba
 adBpvt9+WniCMDx1p0VplW0s8kAdCVpsx97bJ1AixrbuekZyQ0qyLE2bGVF6JkTP57wT Hg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3p6tgsh9e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 15:21:31 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D61BA40083;
        Fri, 10 Mar 2023 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678490490; bh=5ofEJoUVtgmxHn/CpvWKOAKamQ8ZK9/Wl7HaukwyoVI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=A+lgFDSDHDp4gbemuwujPjd4P4bZV+XS8WrXsasp3CbvqdsJs+TzltErWjwrSnbmN
         4D2+fIytGAEs7ZzgDsjS/cR7ag/6dlb1NOc5if5fk0Z3BLWY8SfAaJvB07oWJraXrH
         6CFvF1adon+DWzfvDTPmaSZnL1p2AZLJfUfbriKhlW8X/r+sie8GMZszul5orGnzRc
         QmoY0oz6DsZG3EQD3ToyoeUS6rl/HKLKtYME1l7zyQ7mIpCN12fzwBRtPJckOw83MF
         0e30CL1N4gRq5G9lFoMsGAbL4ULPt5CDj79tQ8FWDuAr3LEhS4i+Cf14s2Q/Rm8p4w
         UHgZ6YjOBT7FA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 83C73A0253;
        Fri, 10 Mar 2023 23:21:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 16732400A3;
        Fri, 10 Mar 2023 23:21:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="r5FBih/K";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W51qBYRKIcMJk51zWSSmh+8axa4ol27izBTr9ZxjU87fVuC6+N107NGLkseJMWWwleBq09EGmHfp2nyoA/UbDVWehi7Db36IkHMnotNw7/i1N6F1DwNzrBDk2xP4x2tGdhZi0+2tOswQxxOFknOBIZN3ZM8l0Jl8D7s7CfZAXLVCp5wZTM4mBpj2n3oCBNcJhK73WAl22W10sSUP28s69cOlskUyuzb6fahyVR8SEkvwIamQ82+058D8bPeDlfRM4UOn7L50vDXgASPF247b7FAU0yzk4wAksQ24j2H4fLB5hJZgHOzSEugx8k55L0gcEn4wO81kKVOQ+gClN2zZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ofEJoUVtgmxHn/CpvWKOAKamQ8ZK9/Wl7HaukwyoVI=;
 b=lEV25eIahpUvdiW6b48palHlL18ub7iim522GBaU8Wc90RY/K/kAwhsVB34j7OiK+5FKRrZZ9twq8GMeoO9X3jwAzGT44WNr/vp/G1kLehtg+m0cW9FBda5drhb7dRPXFWb1eeTa8cP3LgdhK1qbqpn1MDLdxXrhOFOO4tTKkDePbT/m8oH8bI9GXrQLBOub50RQMoaVB+6xen+uAtWub2pGchwwCQ+n56bsZKjwt9tPwvqkGK3DBcMH9csc+LpIJNTp48iRV4/tAIsxhed8/RaiD8lhCjSl9f9mO9a4FaP2Ro4tfJK7aVIY0ttKUouByI0SI/5UhMekBRfXZ4TBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ofEJoUVtgmxHn/CpvWKOAKamQ8ZK9/Wl7HaukwyoVI=;
 b=r5FBih/KNWgikWryt1t+pXbMra6rYbFZC/DF5ruZ9sfvrnuvwVrVQLW2FlhsJq4wBgj0hWnXAkT19T9whcz+msCOQKt6+7dZ7B9sFS+eUaLwFHa1l2CBAS8gfGuvBVkD/+GrElZftrPZTeLZOVcBparvcEFAwEHe/R0AAHRzPGY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 23:21:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 23:21:28 +0000
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
Subject: Re: [PATCH v7 2/5] usb: dwc3: Add remote wakeup handling
Thread-Topic: [PATCH v7 2/5] usb: dwc3: Add remote wakeup handling
Thread-Index: AQHZUsVCYVcJtf8cxECM9I0/MqF8NK70qIaA
Date:   Fri, 10 Mar 2023 23:21:28 +0000
Message-ID: <20230310232125.7dbwynzxziyd3l3y@synopsys.com>
References: <1678393499-7366-1-git-send-email-quic_eserrao@quicinc.com>
 <1678393499-7366-3-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678393499-7366-3-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA0PR12MB8351:EE_
x-ms-office365-filtering-correlation-id: 705bb9c3-033d-4a98-d108-08db21be2cc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: REpTEm7n1fO/xMtgHPhVdmp0Jq+aYtq7FLFUmh3+cQcFs/I1jGQsmUjDU3fmuzSl8aWzXMhPznbJcMXh4hNphM1KSOMIck98VR5hQA1wMFOYRJ1Ha2qigIi82DWZlXhTglcOyeTb1dfkeYE0OZlCul3CJxl/Mz/30UqFjVZd28v5Urov3RFBWhLO/d1G+mpkhHoaZNwwCYnLKVqbT0u6+rDHGDtcxMmks/Mik5xxZr0W2iHQirMjnxXFeqGTFh6E0yGwanlKJ48E7xKtehiiuyTFSrU5Hhy9p1EhG1dVEZJpKNN20pWl7GB+qeBqZbJ6Y5Id3whUtip60TOw1G/fmikvKGHdjDV97P2n7ifCj/WX78KrCEPSgNlMLmUjNBJb3NEi4bjsS7Pr1F7WDZDQZH53wJGrNLKaU9IGEMU9/FhgxlNmPfq58Qty8jwR2lfw+8ePTg9tWUB3PIdx58BT9c+9ImzBZsrO/az4SzjbeAjdOZPrsiFvurv3iFMTn59tNHNRHQ7v4zG/8xokp+pqqH+BgrOfNbHVT4loDkSKGjjYeDzj0+KE4FupJOmdBDvObzcFfWkAHk/PiVUJ7zl1CIXUyjgU0geS93JYa3S9/zLNYQAjwSaGwP4ARW6XLjkq60000ua5QcUUBu7j7f+x3g8Qeo+McEgdOwocErdNmwWf+ZB2OKCYgxNfNzjwJIRgV/Xg4aoqTAJv0zYAXA3p6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(83380400001)(2616005)(71200400001)(4326008)(64756008)(66556008)(66946007)(8676002)(66476007)(76116006)(66446008)(5660300002)(26005)(2906002)(186003)(6916009)(122000001)(478600001)(41300700001)(36756003)(38100700002)(8936002)(1076003)(54906003)(6486002)(6506007)(6512007)(38070700005)(316002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cS9sVXJOcmRiT2U5SHQxV1pkVTNDWHNlUS9JUEY4RDFudkUweXBwYWFjVEVr?=
 =?utf-8?B?L1E3Z1UvcEwvbkRMb3dpZDNlVzRCcGZyYUhTOC9aSTBiUWN2ZVBiejBTTkFj?=
 =?utf-8?B?ZVNBQ040R01qd2oySzFvMXpCRlM5SWZNZzJoRUlqaXUyMlpkaHVNam5QWDdY?=
 =?utf-8?B?ZkkzOERSSEFDUjh2WXJ2MldUVGxVdXBPMnpSMnNRYzU4c2dtWWtlOFkyQkxY?=
 =?utf-8?B?aWxXZ2RCbzJNZVc5Mm40RmVZTFBjV3hoRXZBM3hmNVVHUXpHMDkrUVQxQ1VN?=
 =?utf-8?B?OHZ4eFJxUUp1Rm4rVXZCQVc4TlpLNy9IVDNyUTFLYVVGd3lkQ09JN0JjV3lZ?=
 =?utf-8?B?WVcvQzRJQ3ltTTZCbll0V0lPekJUMTFaUlBscit0dFZleGFMellOTFR0eG1E?=
 =?utf-8?B?bmdUdG9ULzM5RG11WDI3NVJOc1BjWk4vVVhNU1NBVWxZcTNyYzZFUjNjVEF5?=
 =?utf-8?B?M2lPbE85b1l1TDZLcVFhTWg1RC9jZzVRenRPMys5V2JFNHByS25WWlgwMUJw?=
 =?utf-8?B?dURRTkZ4MDNzUzRESlBHcmMwS3p5K1lIYWpWUWFXVWY5RFBPSlpXZEtJUU50?=
 =?utf-8?B?cjY2cmpzbTJZUVBDWXUyRy9rRHhxbzk0ckxMS3FBUXN0bXlHWHpMeUx6M0Uz?=
 =?utf-8?B?NmlHUjNDRUI4NmRXV3ltUmc3K0pwSEh5S29oTDVUaUhnRzRTWnpRMEJLTUlI?=
 =?utf-8?B?ZldLaDF0VkZZOEpIZEN5U29DZU1reWpxMUIrTGxPMTBrQzY3ei9JR0NNUmVP?=
 =?utf-8?B?L2EzVGFXTUlXbzFEb0tubUNpUm9RUi9aUStIOFBhcHZZdjBONW5xRk9QU0xz?=
 =?utf-8?B?NmJqeS9Ga05PdHRFRENxRG1EdDZsckFyZU5SQ0U4bXpHTmJkY3BERG1kbDBq?=
 =?utf-8?B?MHNiYU1WM01ubHNkeU03ZzBCZ3I3MlBUQlhOMzE5ckZtdE1YMTJKWWFDcWFI?=
 =?utf-8?B?QWpQck9nZVlGZDR5eHFiWGJLWEVzRENDdkg4cUpXc3FZdFhHU2U4Ym1wdEFB?=
 =?utf-8?B?c3FsenI5UUZyTlNjZFZHVDc2Z2hhTUJNVFVVTFBoMGFSK0RWTGw2U0JlU0di?=
 =?utf-8?B?N0drb1o0ZGUySTArL09OWUlpZml1NHF6MzR5OXBFSmtjcXJKaE1leGFNM3pW?=
 =?utf-8?B?aWtnaytjRjNIWVd5SE1xcWI2eUg0M0lLRnI0WFJrR08vL0JPdndYbnFPaC9B?=
 =?utf-8?B?NUNpUEppNndZejU2Qko0VHZYb2UvYlZ1dmNZamRTL1g1OXpWQk5WZUFudEVM?=
 =?utf-8?B?YmVPSmk0S2RaN0pUZ2NMeG9MSzk3dHNWT28zNGhHb3VkSnVPWklNdGN4eU44?=
 =?utf-8?B?Y3I0Zkgrd2pEbWN5KzRJdWJUVkhUYUFlS2JOSlBjUStIMC9FOTNDZFJtM2Fa?=
 =?utf-8?B?Y0NUbDRtT1Y0U0FtUlhnKzlsd2p2eGV2T2ZRTTYxcFhEL2tRb0kzL2s5Mk1U?=
 =?utf-8?B?WFdHVWpNTnQ1WVdqbUx6Y0RkSS9USjFUc01udFJUU1FuVTBXYzhVT1hJZkxs?=
 =?utf-8?B?WUkyNzQxbk9sTEkwQXR5NEZvT2dxNzFoY3YyOXJFSS92S0FWeXpEcDRpeTJ6?=
 =?utf-8?B?Y014NDZTYi9saXRjQncrRi9RSE5ZakEvb1VSZzdJSGRrdGhyeDhjQ1JEcVZO?=
 =?utf-8?B?cEY2a2dQZjlzM2RzUHV1RnBiQ1QraE5BaE9LNkc1WlBCQ0N1NXA0VVJqSWlp?=
 =?utf-8?B?TitJNEYxamF6UHQrTC9NZDlSSjVIalI2ZDdtRTFyWE51OFdremo0RnhDOWJZ?=
 =?utf-8?B?Mmo4UExNemJLVUovY3NDcFhyd09STzNjYmpnYTBEQmxhK1RDbDY0S3d5NENo?=
 =?utf-8?B?REZMTE5NTGNKZEt3U1VWVysvR21JTzkzRWZ5M1J0SkErd1FiT0ZZT3cyeHc1?=
 =?utf-8?B?TTZqYnM4WDJhNi9UQ0NJclpEa1ZLcGdoUUVhU0JpYXFVTyt0TWRBdzJzdXVr?=
 =?utf-8?B?QitQcERSbzZpRTF6OXoxYktBOHNkQjl1aTZWMXQ0clNIZEhyYkpYU2llN2xY?=
 =?utf-8?B?aldjdW5Ob1NwSWkyaU5nTTZzTmwyem1sa056MnkrTFc2cUFTaFdNSXB1djNk?=
 =?utf-8?B?dVpUTHZNQ0VDbVdwWmV5UGpVN0hpclY5Vm9tMnc1UDBsM04rSm5paW1YaGpD?=
 =?utf-8?B?V2dnOFNQY0RMaUZXUFBxTzhuSlcxSVNTTldvMlhhN2E4aTdzSXdYRFFJSGJD?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D6731208361EE49A896067165E7C389@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UQi3OXhmVQCuCflipRPOXQzwEewrFNsF8JO7BksprXiYmI5YiVJZX3dyXxF8PyDuGMDhavyjrZldYy+H7MXQ1p0SW0v9oUwOC81IKkaAJdHgskVt/4sprLYmDXEseO/RcV86H+CV6I6L4rf/PmK6g5UwrmZHmpxVTUM6bg9HI4gG/mZGI87h4ejppphQSRUFwxacecJOOv2fA52AchB9wCuBnrGhbY9VUsSuo0hnRiOsVtS+D70eAYudYPEF7MLiNml+hpzYj1Zb9YrtpWqBLsenSO1mvx1gHnABAwbJg9asW5VWWaSdXC4rMJYRPxsmnX2/76swWWJOIrYZ6pOpBVA+gxXOboqZe97wWv8WQ3P0TWFQ3ZjeNmGZO35SZfnrxbxp9j9mcCZLd73ycc2PlyzKWk8rl9afIx/+Njnzg1pByOui41wyNbZjosvKm0SyVUwMhsPVT6l8xfAU7f0KTaRah1Pvf8PhXs5BQriDPgN1XExqI1fix8ttK+htm8jErmzaqGW5KBcjCFAevhD8fNOWc3O0eLMGw7sjdZzm1HlhQXZI5KiMeGAXV3eNxB2dROqywtj541Q5YneFr05zY4rX/jnX/x0zhhkxxNKY1BVGrZWMXurW5HBO8h2GWgsFI+3NAj85mBJKBO50HcNAXDiuWZO1CIzGrm7JoKN/GBQ6ybDgR5BwoqKc2DNxFwFqpndzYMbUZzyeRvLlHLnDI/MnuDFb7HL4rjPmnrSDoKuTqUCf7/iA9fCw4eYDBDRpHh0OY2N4hNSqrpSgQXYugfDNPQAmQE93krqizGsKD7wTdA9WZyNvgKD73NKLvfvqOc+NT9baX2Wvne2O2HXr/fiPZyNRhPm0L5q6uNyPabXigK9UPDE9+vD6zAXz83LDbjIZpFdNP39O1qFoCYZbF9HaNFdSLOOoOpjhe7UhdMg=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705bb9c3-033d-4a98-d108-08db21be2cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 23:21:28.1096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dY+m3WRdjvdBQ5BP2K4A5yxxvFOVtRsCUArbvDe2MNPRqSQrXADlhLsUsE+TsARzIDGB1s1JrZ78jfMFCAuj+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
X-Proofpoint-ORIG-GUID: trQSSNL3W_EiRt-bpNamaEWw7BHcmZz2
X-Proofpoint-GUID: trQSSNL3W_EiRt-bpNamaEWw7BHcmZz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=939 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMDksIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEFuIHVzYiBk
ZXZpY2UgY2FuIGluaXRhdGUgYSByZW1vdGUgd2FrZXVwIGFuZCBicmluZyB0aGUgbGluayBvdXQg
b2YNCj4gc3VzcGVuZCBhcyBkaWN0YXRlZCBieSB0aGUgREVWSUNFX1JFTU9URV9XQUtFVVAgZmVh
dHVyZSBzZWxlY3Rvci4NCj4gQWRkIHN1cHBvcnQgdG8gaGFuZGxlIHRoaXMgcGFja2V0IGFuZCBz
ZXQgdGhlIHJlbW90ZSB3YWtldXAgY2FwYWJpbGl0eS4NCj4gDQo+IFNvbWUgaG9zdHMgbWF5IHRh
a2UgbG9uZ2VyIHRpbWUgdG8gaW5pdGlhdGUgdGhlIHJlc3VtZSBzaWduYWxpbmcgYWZ0ZXINCj4g
ZGV2aWNlIHRyaWdnZXJzIGEgcmVtb3RlIHdha2V1cC4gU28gYWRkIGFzeW5jIHN1cHBvcnQgdG8g
dGhlIHdha2V1cCBBUEkNCj4gYnkgZW5hYmxpbmcgbGluayBzdGF0dXMgY2hhbmdlIGV2ZW50cy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgNSArKysrDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIHwgNzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IGIxYmQ2MzEuLjQxNmUwZWYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+IEBAIC0xMTEzLDYgKzExMTMsNyBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsN
Cj4gICAqCTMJLSBSZXNlcnZlZA0KPiAgICogQGRpc19tZXRhc3RhYmlsaXR5X3F1aXJrOiBzZXQg
dG8gZGlzYWJsZSBtZXRhc3RhYmlsaXR5IHF1aXJrLg0KPiAgICogQGRpc19zcGxpdF9xdWlyazog
c2V0IHRvIGRpc2FibGUgc3BsaXQgYm91bmRhcnkuDQo+ICsgKiBAd2FrZXVwX2NvbmZpZ3VyZWQ6
IHNldCBpZiB0aGUgZGV2aWNlIGlzIGNvbmZpZ3VyZWQgZm9yIHJlbW90ZSB3YWtldXAuDQo+ICAg
KiBAaW1vZF9pbnRlcnZhbDogc2V0IHRoZSBpbnRlcnJ1cHQgbW9kZXJhdGlvbiBpbnRlcnZhbCBp
biAyNTBucw0KPiAgICoJCQlpbmNyZW1lbnRzIG9yIDAgdG8gZGlzYWJsZS4NCj4gICAqIEBtYXhf
Y2ZnX2VwczogY3VycmVudCBtYXggbnVtYmVyIG9mIElOIGVwcyB1c2VkIGFjcm9zcyBhbGwgVVNC
IGNvbmZpZ3MuDQo+IEBAIC0xMzMxLDYgKzEzMzIsNyBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICANCj4g
IAl1bnNpZ25lZAkJZGlzX3NwbGl0X3F1aXJrOjE7DQo+ICAJdW5zaWduZWQJCWFzeW5jX2NhbGxi
YWNrczoxOw0KPiArCXVuc2lnbmVkCQl3YWtldXBfY29uZmlndXJlZDoxOw0KPiAgDQo+ICAJdTE2
CQkJaW1vZF9pbnRlcnZhbDsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9l
cDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gaW5kZXggNjFkZTY5My4uNDQyZDhmZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2VwMC5jDQo+IEBAIC0zNTYsNiArMzU2LDkgQEAgc3RhdGljIGludCBkd2MzX2VwMF9o
YW5kbGVfc3RhdHVzKHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCQkJdXNiX3N0YXR1cyB8PSAxIDw8
IFVTQl9ERVZfU1RBVF9VMV9FTkFCTEVEOw0KPiAgCQkJaWYgKHJlZyAmIERXQzNfRENUTF9JTklU
VTJFTkEpDQo+ICAJCQkJdXNiX3N0YXR1cyB8PSAxIDw8IFVTQl9ERVZfU1RBVF9VMl9FTkFCTEVE
Ow0KPiArCQl9IGVsc2Ugew0KPiArCQkJdXNiX3N0YXR1cyB8PSBkd2MtPmdhZGdldC0+d2FrZXVw
X2FybWVkIDw8DQo+ICsJCQkJCVVTQl9ERVZJQ0VfUkVNT1RFX1dBS0VVUDsNCj4gIAkJfQ0KPiAg
DQo+ICAJCWJyZWFrOw0KPiBAQCAtNDc2LDYgKzQ3OSw4IEBAIHN0YXRpYyBpbnQgZHdjM19lcDBf
aGFuZGxlX2RldmljZShzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgDQo+ICAJc3dpdGNoICh3VmFsdWUp
IHsNCj4gIAljYXNlIFVTQl9ERVZJQ0VfUkVNT1RFX1dBS0VVUDoNCj4gKwkJaWYgKGR3Yy0+d2Fr
ZXVwX2NvbmZpZ3VyZWQpDQo+ICsJCQlkd2MtPmdhZGdldC0+d2FrZXVwX2FybWVkID0gc2V0Ow0K
DQpXZSBzaG91bGQgc2V0IHJldCA9IC1FSU5WQUwgaW4gdGhlIGVsc2UgY2FzZSBzbyB0aGUgZGV2
aWNlIHdpbGwgcmVzcG9uZA0Kd2l0aCBhIHByb3RvY29sIFNUQUxMIHJlamVjdGluZyB0aGUgcmVx
dWVzdCByYXRoZXIgdGhhbiBzaWxlbnRseQ0KYWNjZXB0aW5nIGl0Lg0KDQpUaGFua3MsDQpUaGlu
aA0K

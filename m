Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723366E7077
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjDSAdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDSAdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:33:49 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0773897;
        Tue, 18 Apr 2023 17:33:47 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IN0Pkw016870;
        Tue, 18 Apr 2023 17:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=X7Q+vR7bRRnrZ0JDdzU+81E+kTuJZ4ssbFUGMakTUd0=;
 b=M5x9F3ps/Utb3KXidUD1ebiBFOwA7r3B1jbo37xvzk/iSKN7A2+KwaJYG5XI1MSA7pao
 Jcpb7hfnXTJOXTCszjHl4GthWxUKAI4XLVW6L0q2tgpCGXmPFEm5DQfHGR2hoiUhWvLD
 SoBPYgKcK7iO8a1sjWLG3fJeP+VDKl7PEGU38Jld952LGmRXCaHlACqJqTBT4NUT9mMm
 fpLedLlDgccBtkt+5dsQkT6moXVTmA60bbVBSZ/YdVDvKx7U+14gyOsJ00oCRDvFVZ/W
 wDwtz+DxiNbr35N3+69zGkBTc7rpMRrp9583TbpBE6fujIy3pFAqRIU7FpLcN3Dr76f/ nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pytjf7cra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681864414; bh=X7Q+vR7bRRnrZ0JDdzU+81E+kTuJZ4ssbFUGMakTUd0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=T/37uUx8c5/mBbl5cG2W+z46Vfz5ZR9GR/nhrsBou7eFd6fd6Bu9Vk73kxgHIE6XC
         2ZT41Fa3kquIOu6Agj8QMaHnWsRbLcR72K3Yl7/9pxg4roEXxWldMyFEC77BByh8x4
         2nLZnJtgPnDMHnI3v4+ApO+itJXfgPYUQzjibtP7WFs5Sv5d6KIs/lmplFk4mrya98
         RKyEOULpNiW7CzNJDzO13CN+TLdiKGZdRsxMZPMCdGO756nOzoBgLrjv5cbQ47PkhA
         XXPWPWpt8vUaxZQaBgR8RndPUo3OXe78zSoDkgvatG9I8FVV4CxlzQRsKquS0Uu1+H
         QKTBqfQ56cMRg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4E15C40D88;
        Wed, 19 Apr 2023 00:33:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B1E47A0068;
        Wed, 19 Apr 2023 00:33:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Y1qG1xNb;
        dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 150EA40DCB;
        Wed, 19 Apr 2023 00:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl306qV5BjAUT/fsk4+XcQ8bkEgKccf2UvmlSvt1lsm5GOothp4kUBNmviF76OCEeA5tEE8jOBk0/QWNHLoTbA5V5ZfeWeQqGkDWVyT3aJAj4oD2MUqqnwl++J6mfLjoxDhrXjbbKomf+YqJLtryBz7BCEmnnLB0tnAMIrgmHYF8YNiFXXBhjBw6s5iliXyHsYpi3glJLFd2HhhA5UE/mbhwSklM/4lo+auecLDRdmHPR/SxWGF4EJEDFgMxOxUUf+12HvfDA1iWgjaGz7lNHjZwowHmXNaIJyrVBZCl/mRnCEd8LwEcFhCtfqVk1qOGoqIwriSDeDkTOnnmjBvXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7Q+vR7bRRnrZ0JDdzU+81E+kTuJZ4ssbFUGMakTUd0=;
 b=QBOGcBxbljYfU2C3fnpgnNIfGNZzQAzGwiWiUm/OU1UWVKz9uUDqSjTepzn8ZjBsmowVWnsUg8CMVO6n4CqHreBPR4NgClIYTTcMD2knN6W3pMyXvwwizPtTJnhGN1Bx45022LgD32upDbg/pKb+oI8Rwt3LdJ0N0FvSjSMoqDEx4iI1+XWzNtP0qgZI+Goo+HXjElYs5ZdP6OOXX1sGjKI5U5XCTl04p0Q/fjVNfuYfs/Jdtil8In2Ob9sMzTXBHh6FKrUSNWx/gwX6TTwema4KGbNsP4qxEsIplJYJ2SCryncXK+d5rxUB5phkax8OYW/czgvsNrisq2m+CBYyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7Q+vR7bRRnrZ0JDdzU+81E+kTuJZ4ssbFUGMakTUd0=;
 b=Y1qG1xNbZqxHSJ7qWWI7rHG9Bz8SHP5wq6XcQK66F6Phz5+VMDh83c91GQqvs79Eu8Lu0j+6DX24+P3l3Cw5ZoOEqgbGXtrOTe7AkJWJlJ/yNycSgUsrnio3f2PE6GbZ2M8hlu0kOhjpDUvLZ374yWNghldIdCRIXga9xHjSo54=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 00:33:28 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 00:33:28 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3: core: add support for disabling
 High-speed park mode
Thread-Topic: [PATCH v3 1/2] usb: dwc3: core: add support for disabling
 High-speed park mode
Thread-Index: AQHZbfAta6P3eikHuUKCqhSFbI+D868xzY+AgAADooA=
Date:   Wed, 19 Apr 2023 00:33:28 +0000
Message-ID: <20230419003317.rmowuprficuhwclx@synopsys.com>
References: <20230413100914.7890-1-stanley_chang@realtek.com>
 <20230419002017.rnrduds7ci4bdftu@synopsys.com>
In-Reply-To: <20230419002017.rnrduds7ci4bdftu@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA0PR12MB8840:EE_
x-ms-office365-filtering-correlation-id: 50a037b9-fdc2-48f2-7689-08db406db1e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DedMSeIytyRYVIjdfsDoDU3tpB7kDtR932orgnKYy51K8CkMMDUjrd5txL42weG8sFD+IyyuDEBBfQOekEi80wfHAXtrfHfQRrBQ3h2SUP8uMrZyIp8okN5K/ehR4Dac/K65vfMBmVqEq6+4pWNHDe/5dmw+7ykKP4zoyYrzOKhwyXz2h7of4GQ9oPmB5sQDlxQjv/K8A23TFyu7wTBOYtdes0PDIs4bDKraNCStYeE/Mwul6w95BHLnEVRE8gJ+uth0Ag0oiu0FFrsdrNl1TZUNJbRaO/BwOLzRocXGWpKFDl7l8Mw3RVfciyjMonGlHWXSmJzlaRlOyDPBUHSOQFxwWFtZ5+JvZA4H/hqFFG5iOJfojbhXpPhHYLbKJUkgYhBLDUF8l9yQlbvufzhBduHtpHdtSRMo9VvhuM5Ni8V6sjK4qBnpiZvn2JYrpzh1EFVKHfvCNWH3eh7WRXVZe2B8VSm9GLKpi+1JxGmzU1JSwYsSPiRhjilLn2eGM40bg8Me+tecYEnPNB7fLxK0aSE8FO53RSFFzwkjhd19Vx0MRwt8Rj42ztiMufnXIyyMyd14j2L3Sx3ldnRG6koos+5/L8lVAZ0nZvClBRwzW2XRHLQbDMAxgeFS16ncDtiR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199021)(76116006)(316002)(6916009)(54906003)(66446008)(64756008)(66946007)(66556008)(66476007)(4326008)(36756003)(26005)(1076003)(6506007)(122000001)(38100700002)(2616005)(6512007)(186003)(83380400001)(5660300002)(3716004)(8936002)(8676002)(478600001)(71200400001)(6486002)(41300700001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTluaUw3M3pacTVtRCtacksvSjdiWkZEQThuQ04xS3ErTHNXK3BsVVJMeGsx?=
 =?utf-8?B?Q0JMdWRwZ0dTdWZmdS9kS2hTSlB5VC9TMkgzVHpKcm55L3p2dDhLT0Nlc3F5?=
 =?utf-8?B?OFdZeGJiZXBWTWxZOGtwSEpDY1RjN2VEb20wWWh3NHR1NkNGc3J0ZnVUYlZ1?=
 =?utf-8?B?c2hQaVFkMzhKUFBQemY3RHBIaitURWlLWjBzTW9nd29iOUs1YXAraklqM0ZU?=
 =?utf-8?B?OW1CUWQ2NmZEY051NGwwZE45UFhsZWZ3b3NVS0tVVG94dTJWUUpkMlhLd2gr?=
 =?utf-8?B?c0JBS2NqaklUTTZuM1F4eGw4ZlIyZlNkeGg4SXlqYTl1MlhseUpFVE5VUkNu?=
 =?utf-8?B?aGsrUlE3dlBCMWFCY3VzY25RVE93TFZYWFdVbGlHRmhROU5LVFVWdGFMclRX?=
 =?utf-8?B?dktKaEExVmtDTWorbmVBWStESVBPUlN1dDZlTnRGSHltL0NlM25KN1VYWjZy?=
 =?utf-8?B?aTBMMXl2cTFYRWYxeFJ2cS92OFc1QlhmQk9aRWhaeDY1S014SEFpNzRKK21L?=
 =?utf-8?B?WmtsMTJ6SUFpN2RlSDFMbWVzOEtSZGdVTkRXMndFTUNRQzBSa2lGQzExaHYv?=
 =?utf-8?B?Vk9rZmNpVjhhNk1mbVBaSnFHNkxDbGJ0eHQ5N2NndXZyWUZ2bXRTWGNqd21r?=
 =?utf-8?B?ZWVBNFZzdTlYcXlBSUw5UXV2UU44U3MrSWRianNhRHBLOFNXLzR4UFFyUHFr?=
 =?utf-8?B?Q1lZSExkOUpYK09jeFFnNWVrODhCTk55YVA0eUhvd0ovQzE5MWl0QWtEMmNu?=
 =?utf-8?B?ZG94cFNtK3FwNzF4ZnAvVXJ0VnhaWmhhTmNvNUJtaEZUNWtuK3V1Qjd2RktH?=
 =?utf-8?B?OHRZY1Blc1lGZmxERkdsV0daMDVWeW90dEJ3ZEp0dWhpTmczVjFPakRSQzl2?=
 =?utf-8?B?ZHJXZlViNjFKcTUremlwc1V5TEhYU3NpdzVmSHJrSFo2aXRDNmp6ektaRFp5?=
 =?utf-8?B?ZWd2Ly9WYUs5MjZrdzFFYzg3cGEvbzZoN1QwdG05Z25xUGNyVFNyRnRJeGph?=
 =?utf-8?B?V1ZiR1FqcTEwMHBJSjNuVWppK2RKamJoZGN2dUZDcDlSM3NkL2xqRkFJUEZp?=
 =?utf-8?B?M1g5anFWQi9MTm5DWER1Z05aVDkvOGpvOFJSVTh1OEVuaTlzZ0gzRFYxdzU3?=
 =?utf-8?B?V0RlK2NsZ2pYTVJsUGFUakY2clNBemFUUkhsU1ZQRjlJbEVCNFRoSUlQSEwx?=
 =?utf-8?B?UHRFd1pNUmMrZTk1TGxaUGNZUFhER2RBTnRkVnJqRS9wR3ZIVzJZUWI0b0V1?=
 =?utf-8?B?Nkt6M0o2cURrQXNBOFBtSVUxZmJRaFNzNW9BN2F2UkNkenQ5UXAvUDJRbG5E?=
 =?utf-8?B?allGN0dWM2grOTJjOXJZUjFFNWVvblphbDNVeGdzYjBUYmN1Rk5lS1BiQUpk?=
 =?utf-8?B?ek5NdkZrYzMzZXNiYWNLSnozL3lkRXdKQkp2NjdCUTNjUDg0MlUzdm9mSGVQ?=
 =?utf-8?B?bDJKYkR3Y1ZEc29tOStXTFNFWklyNUl4TnFOUHFGa21KU2p1VDk4K044K2JU?=
 =?utf-8?B?WlpMNFdJME1XcVIrT0NXeXdNWHF4SHgzdG50SGs3SFBKTHBEd2pEVHhvOUpo?=
 =?utf-8?B?TEtLelN5cVBtd0IvaXpyWGxVQjIvc2FkOWZBSkV4V2lxKzJoTVhUVXdQNGNx?=
 =?utf-8?B?MWFJS2lXWTRCM0R0NE96R1NHZHQrdC9aSUtmUU9JdlRTd01GMHVsUWUreGZE?=
 =?utf-8?B?ZW9DckNrREJPTmRGQkFnNmJMTjBkQXZRQkM5WitxK00yWUtaZk1wMmRveU8x?=
 =?utf-8?B?cFdzRDVLbElBNGVSNHd3TlQ2b2ZqNit3SVlQUGljdE9OTW9pWXNNTTFWZElI?=
 =?utf-8?B?T1NNTG93c1lYTkxwTm5ISE4rc3cxYkNuUTAwbGlrdWlvMElpYkpLS1c5UVdE?=
 =?utf-8?B?T3hva1JCQTRGU0NKTEg2ZUpWN2RqTDNldHRMd0ZBZGxFRkFoUEFqYzZqTURn?=
 =?utf-8?B?N0JubkRiZFVwRWZaNk5XdFVqMmhWdWx3bmZnb2VrWWluSzBib3dNOEZZeVoy?=
 =?utf-8?B?SUk0cTMwL0dWL1NNNDlxbHN6THRDY3BxbDhoYlZ5L2pGbGgraURBMDhCWE1D?=
 =?utf-8?B?SFhiLytIaVppc0JaMEtuZjd2anN4YU9pUVNvdFJORkdia0NZZmh3NWtqc2pT?=
 =?utf-8?B?TWNld1JQeWxuTGxEMEVFMnN6VkZ2eDkvSlRjYzE4RW1BSHhqTVNHVFBCSS9o?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BC13B2FD85AC94C97532E5B2821F796@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?REhhY1hocUhOOU9hWTdJT2ZhUjJ5ckI1aStSZjNya2p4SVZ0c200R0FZeU9X?=
 =?utf-8?B?K0VGNURrNldnWWFiK05EU00xTGRWdE05K0pWVkpHb2JmUVhTbjMrNjVuZXpV?=
 =?utf-8?B?TURBVlhTUDl6aGdXUGpiMDFxRy9vSXhQbjhzNmdRcUI2cTB6SnJGTENTOHRl?=
 =?utf-8?B?QkhQWUtldm1vNXBwMUhjMlVMSFRwTHdqU1RhOXJZTWRBNnFlMzFYZDlvUmF4?=
 =?utf-8?B?dWNQUUhDT3VDYlhrT1NvRFJVdlVWcUdXM3owV2RsVXJPYzRxMVcrWkNhNVlH?=
 =?utf-8?B?SjRUZGxlVlFIWkNGTmNnY1JYaSs4Sm1oWGxmanczb0Rhc3BoK1VzUWgwb1FJ?=
 =?utf-8?B?aExWTlRqVSt4QXRMTDZrK3dWdFhHN2U5dGxHR1FtV1JOWEVab2FNdExYakhM?=
 =?utf-8?B?UUhxMWl3RWduSEpESDRQWkhXaHV3VGxQUlBQTXl2ZTFoenFkZzljdEhrcGlq?=
 =?utf-8?B?L0tnVlVCNEE1SlU3RElYL3VzWWF6WDBNKzRhZXA1Unl3dVUxOGEyUyttV0t4?=
 =?utf-8?B?aUpWaTF4MUEvUUkyRG5pZE5oYWtnL1ozNkNMOTdqZWJKb0MwVDhWaG5ldXh0?=
 =?utf-8?B?anA2NzBzTHA3SEI0My9nY3BFS1pySEt1SUx2SzVLM09MNGszdjRPS2prbmIw?=
 =?utf-8?B?V0FlTEVENmNqdEx3ZGZqM2ROUmZ4YnFkUVBRMDRwVldwamt4aFVLdkZJMkto?=
 =?utf-8?B?OGxWd1NUSHdKOTJzN2gxZVBuSEZQbFFHdGpjVkhNckU0Vzhxc21teGZ5UmZ0?=
 =?utf-8?B?YkpaSEZPQ1JZRUowOUkwTHhXeThHVTNzYTFZL213eDJndWZhMEZLK0wxL0Jk?=
 =?utf-8?B?RExObzNmOUtOUlM2eE5aQ25tQmVxUG1kZEkzN1VnRWFBeGdPcE1lUnJzcE91?=
 =?utf-8?B?dFVvb0RkbWhveTNkYUcwYkJFd2pVNHZBKzYvVVdxY2F3ZlY0d1cyQTFKbzMx?=
 =?utf-8?B?Wk5HckYxLzdqUytWT3ZtTDNhOHI2ZVZnUDdPL2I3YU81bWZncUtRcFdkSTZH?=
 =?utf-8?B?cDZ6ZGZLSEtQb0V5MXU3bnA1RFNZL25aV202aHZwNXJ3cEgwQVFrV0dNQ29S?=
 =?utf-8?B?c3NqUE0rUkptVFVmaGhJQTV5SERvbWI1dDFlYlZLN2JsQlRSa0lQSnlhWkVG?=
 =?utf-8?B?TVdkc2ZIU1dDVnI2ZHhldU4zS0ZZc0F5eWpEVkxTaWFGTmUvMDNXcndodHZ3?=
 =?utf-8?B?a3BxMzFXYkFFcU5vdERGZjhTelh0SDNwL0dGSjZIRVhxSmcxNTh3dUJ3YnZs?=
 =?utf-8?Q?T5nasMViWaRWaFP?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a037b9-fdc2-48f2-7689-08db406db1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 00:33:28.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqmyuFmcNsdCvzzZ3zpzcb4wJmQKEkUkLj8iL5Jf2NWjEdltz+hTPcOX0VmdHATUaNOB7dsViY4m3diJ+mZWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
X-Proofpoint-GUID: OXpEm1F_zMbihfuPK_XmS2aSmUnpq24X
X-Proofpoint-ORIG-GUID: OXpEm1F_zMbihfuPK_XmS2aSmUnpq24X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_16,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304190002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMTksIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVGh1LCBBcHIg
MTMsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+ID4gU2V0dGluZyB0aGUgUEFSS01PREVf
RElTQUJMRV9IUyBiaXQgaW4gdGhlIERXQzNfVVNCM19HVUNUTDEuDQo+ID4gV2hlbiB0aGlzIGJp
dCBpcyBzZXQgdG8gJzEnIGFsbCBIUyBidXMgaW5zdGFuY2VzIGluIHBhcmsgbW9kZSBhcmUgZGlz
YWJsZWQNCj4gPiANCj4gPiBGb3Igc29tZSBVU0Igd2lmaSBkZXZpY2VzLCBpZiBlbmFibGUgdGhp
cyBmZWF0dXJlIGl0IHdpbGwgcmVkdWNlIHRoZQ0KPiA+IHBlcmZvcm1hbmNlLiBUaGVyZWZvcmUs
IGFkZCBhbiBvcHRpb24gZm9yIGRpc2FibGluZyBIUyBwYXJrIG1vZGUgYnkNCj4gPiBkZXZpY2Ut
dHJlZS4NCj4gPiANCj4gPiBJbiBTeW5vcHN5cydzIGR3YzMgZGF0YSBib29rOg0KPiA+IEluIGEg
ZmV3IGhpZ2ggc3BlZWQgZGV2aWNlcyB3aGVuIGFuIElOIHJlcXVlc3QgaXMgc2VudCB3aXRoaW4g
OTAwbnMgb2YgdGhlDQo+ID4gQUNLIG9mIHRoZSBwcmV2aW91cyBwYWNrZXQsIHRoZXNlIGRldmlj
ZXMgc2VuZCBhIE5BSy4gV2hlbiBjb25uZWN0ZWQgdG8NCj4gPiB0aGVzZSBkZXZpY2VzLCBpZiBy
ZXF1aXJlZCwgdGhlIHNvZnR3YXJlIGNhbiBkaXNhYmxlIHRoZSBwYXJrIG1vZGUgaWYgeW91DQo+
ID4gc2VlIHBlcmZvcm1hbmNlIGRyb3AgaW4geW91ciBzeXN0ZW0uIFdoZW4gcGFyayBtb2RlIGlz
IGRpc2FibGVkLA0KPiA+IHBpcGVsaW5pbmcgb2YgbXVsdGlwbGUgcGFja2V0IGlzIGRpc2FibGVk
IGFuZCBpbnN0ZWFkIG9uZSBwYWNrZXQgYXQgYSB0aW1lDQo+ID4gaXMgcmVxdWVzdGVkIGJ5IHRo
ZSBzY2hlZHVsZXIuIFRoaXMgYWxsb3dzIHVwIHRvIDEyIE5BS3MgaW4gYSBtaWNyby1mcmFtZQ0K
PiA+IGFuZCBpbXByb3ZlcyBwZXJmb3JtYW5jZSBvZiB0aGVzZSBzbG93IGRldmljZXMuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiB2MiB0byB2MyBjaGFuZ2U6DQo+ID4gMS4gQWRkIHRoZSBjb21t
ZW50IG1lc3NhZ2UuDQo+ID4gMi4gY2MgdGhlIHJpZ2h0IG1haW50YWluZXJzLg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDUgKysrKysNCj4gPiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmggfCA0ICsrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+IGluZGV4IDQ3NmI2MzYxODUxMS4uOGZiYzkyYTVmMmNi
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiBAQCAtMTIzMyw2ICsxMjMzLDkgQEAgc3RhdGljIGlu
dCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ICAJCWlmIChkd2MtPnBhcmtt
b2RlX2Rpc2FibGVfc3NfcXVpcmspDQo+ID4gIAkJCXJlZyB8PSBEV0MzX0dVQ1RMMV9QQVJLTU9E
RV9ESVNBQkxFX1NTOw0KPiA+ICANCj4gPiArCQlpZiAoZHdjLT5wYXJrbW9kZV9kaXNhYmxlX2hz
X3F1aXJrKQ0KPiA+ICsJCQlyZWcgfD0gRFdDM19HVUNUTDFfUEFSS01PREVfRElTQUJMRV9IUzsN
Cj4gPiArDQo+ID4gIAkJaWYgKERXQzNfVkVSX0lTX1dJVEhJTihEV0MzLCAyOTBBLCBBTlkpICYm
DQo+ID4gIAkJICAgIChkd2MtPm1heGltdW1fc3BlZWQgPT0gVVNCX1NQRUVEX0hJR0ggfHwNCj4g
PiAgCQkgICAgIGR3Yy0+bWF4aW11bV9zcGVlZCA9PSBVU0JfU1BFRURfRlVMTCkpDQo+ID4gQEAg
LTE1NTUsNiArMTU1OCw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0
IGR3YzMgKmR3YykNCj4gPiAgCQkJCSJzbnBzLHJlc3VtZS1ocy10ZXJtaW5hdGlvbnMiKTsNCj4g
PiAgCWR3Yy0+cGFya21vZGVfZGlzYWJsZV9zc19xdWlyayA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2woZGV2LA0KPiA+ICAJCQkJInNucHMscGFya21vZGUtZGlzYWJsZS1zcy1xdWlyayIpOw0K
PiA+ICsJZHdjLT5wYXJrbW9kZV9kaXNhYmxlX2hzX3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3Jl
YWRfYm9vbChkZXYsDQo+ID4gKwkJCQkic25wcyxwYXJrbW9kZS1kaXNhYmxlLWhzLXF1aXJrIik7
DQo+ID4gIAlkd2MtPmdmbGFkal9yZWZjbGtfbHBtX3NlbCA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X2Jvb2woZGV2LA0KPiA+ICAJCQkJInNucHMsZ2ZsYWRqLXJlZmNsay1scG0tc2VsLXF1aXJrIik7
DQo+ID4gIA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gaW5kZXggNDc0M2U5MThkY2FmLi4zMDkwN2ZmY2IzZWMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+IEBAIC0yNjMsNiArMjYzLDcgQEANCj4gPiAgI2RlZmlu
ZSBEV0MzX0dVQ1RMMV9ERVZfRk9SQ0VfMjBfQ0xLX0ZPUl8zMF9DTEsJQklUKDI2KQ0KPiA+ICAj
ZGVmaW5lIERXQzNfR1VDVEwxX0RFVl9MMV9FWElUX0JZX0hXCQlCSVQoMjQpDQo+ID4gICNkZWZp
bmUgRFdDM19HVUNUTDFfUEFSS01PREVfRElTQUJMRV9TUwkJQklUKDE3KQ0KPiA+ICsjZGVmaW5l
IERXQzNfR1VDVEwxX1BBUktNT0RFX0RJU0FCTEVfSFMJCUJJVCgxNikNCj4gPiAgI2RlZmluZSBE
V0MzX0dVQ1RMMV9SRVNVTUVfT1BNT0RFX0hTX0hPU1QJQklUKDEwKQ0KPiA+ICANCj4gPiAgLyog
R2xvYmFsIFN0YXR1cyBSZWdpc3RlciAqLw0KPiA+IEBAIC0xMTAyLDYgKzExMDMsOCBAQCBzdHJ1
Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gPiAgICoJCQlnZW5lcmF0aW9uIGFmdGVyIHJl
c3VtZSBmcm9tIHN1c3BlbmQuDQo+ID4gICAqIEBwYXJrbW9kZV9kaXNhYmxlX3NzX3F1aXJrOiBz
ZXQgaWYgd2UgbmVlZCB0byBkaXNhYmxlIGFsbCBTdXBlclNwZWVkDQo+ID4gICAqCQkJaW5zdGFu
Y2VzIGluIHBhcmsgbW9kZS4NCj4gPiArICogQHBhcmttb2RlX2Rpc2FibGVfaHNfcXVpcms6IHNl
dCBpZiB3ZSBuZWVkIHRvIGRpc2FibGUgYWxsIEhpc2hTcGVlZA0KPiA+ICsgKgkJCWluc3RhbmNl
cyBpbiBwYXJrIG1vZGUuDQo+ID4gICAqIEB0eF9kZV9lbXBoYXNpc19xdWlyazogc2V0IGlmIHdl
IGVuYWJsZSBUeCBkZS1lbXBoYXNpcyBxdWlyaw0KPiA+ICAgKiBAdHhfZGVfZW1waGFzaXM6IFR4
IGRlLWVtcGhhc2lzIHZhbHVlDQo+ID4gICAqCTAJLSAtNmRCIGRlLWVtcGhhc2lzDQo+ID4gQEAg
LTEzMTgsNiArMTMyMSw3IEBAIHN0cnVjdCBkd2MzIHsNCj4gPiAgCXVuc2lnbmVkCQlkaXNfdHhf
aXBnYXBfbGluZWNoZWNrX3F1aXJrOjE7DQo+ID4gIAl1bnNpZ25lZAkJcmVzdW1lX2hzX3Rlcm1p
bmF0aW9uczoxOw0KPiA+ICAJdW5zaWduZWQJCXBhcmttb2RlX2Rpc2FibGVfc3NfcXVpcms6MTsN
Cj4gPiArCXVuc2lnbmVkCQlwYXJrbW9kZV9kaXNhYmxlX2hzX3F1aXJrOjE7DQo+ID4gIAl1bnNp
Z25lZAkJZ2ZsYWRqX3JlZmNsa19scG1fc2VsOjE7DQo+ID4gIA0KPiA+ICAJdW5zaWduZWQJCXR4
X2RlX2VtcGhhc2lzX3F1aXJrOjE7DQo+ID4gLS0gDQo+ID4gMi4zNC4xDQo+ID4gDQo+IA0KPiBB
Y2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiANCg0K
SSBmb3Jnb3QgdGhhdCB5b3UgbWF5IG5lZWQgdG8gcmVzZW5kIHY0IGFzIHBlciBHcmVnJ3MgY29t
bWVudCByZWxhdGVkIHRvDQp0aHJlYWRlZCBtYWlscy4gSWYgbm90aGluZyBlbHNlIGlzIGNoYW5n
ZWQsIHlvdSBjYW4gYWRkIG15IEFjayBvbiB2NC4NCg0KVGhhbmtzLA0KVGhpbmg=

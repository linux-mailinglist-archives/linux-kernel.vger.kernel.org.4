Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB466C8932
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCXXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:22:47 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4019F3C;
        Fri, 24 Mar 2023 16:22:46 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OMOH7S017053;
        Fri, 24 Mar 2023 16:22:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=vQPMqQD+acyUk1xzyBo1h+EGgH5zYEVCe5JrYYBSJk4=;
 b=XpO2x85HUXFy2IpH7Ohb8Sm4adwPnkNA+qC1hfLIZw5Xfqji3x5Ly+7mJHasfS2kZSCw
 m+iXq4l/prhhvfiOBju70lCS4InQHRvZUFv/4jOnjyPE6ELInoceiYGP+5dxH/mbXncQ
 8NPGAHjeAVvrMp0uRC04lh5qdvTzCdYBQzfP1XTkx/L2hjvMkJJx6bFyTvQ78lRM25hF
 TsnjO9FpDhhD+b7ImASQNzs/420y5UsmRSJ13aYZmie/euzFJiIBmSYK5BoKSh0iQZ2B
 wCMzg2uHNSG/9nxSku9MYO4IoA2nsRUV6hLs3JGdR70hC76kzqEYbLid3OH8dsLESoac vg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxunxdfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 16:22:42 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66A53C0445;
        Fri, 24 Mar 2023 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679700161; bh=vQPMqQD+acyUk1xzyBo1h+EGgH5zYEVCe5JrYYBSJk4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ke5Jr09yELeyccBDtWbHQTHnAFr2xO8HOgkK5r+odMvP+s+lqcZHoiDyR10GEPVzc
         S9zt//er3L7daGOCVQ4RcMlq0kxQS+Fv6kW1cMIhVUxW6ex1stT4QU2L6wsAya9X6w
         vG5HsDLFIJsW0Ty6y7sd0VryR5hpofCGlVkeY46DcHHKTWlQ6DVgzrKIxMyetQcM1T
         CORbNgGbRZwEbrIFabc8f77lpTW8Ga9wek42b+KCPFW/NVoA7Dq1DHRvt+zn/C5maR
         gLL5Vc4aU7r41FCVYPv+rb+zw3QDtVSA7zr3WnfHMfyYi+W8vt2GYohBhZT1zyrD1x
         9RLchRVEPAdHg==
Received: from o365relayqa-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BEB6EA005C;
        Fri, 24 Mar 2023 23:22:40 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XiG9PMZo;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id A070F220415;
        Fri, 24 Mar 2023 23:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0Z4JG2eXhOuEr9ZrVzTbxGCuN76F4w/Ynbz4/JqKOGANmagc0hKIozFEovsYZ5iiUEMBy/PI8wd4vPXX93b06bkDULRN2MkOhcdWwHZSGZznWTEs2twTqj2hnza4N5zqdJxN/4P2bxyr/FUDxyR5BrC+tDvPzTCORE8trEfa4kRCnYwnh61f9bfyBnTnjCvbIvc02mzaCmVYapHmwW3YBmIHXvjutjELtVekffkCdysVrXk2nnW0Q2ti2cCjT9ahEsoNcrxjkQho1cs7VL/o4hGl9DbpP88fnFpoCCdKK+HUIEs7HSeThYjlGHL84u1l4YbkJedpt1SD6ipImO/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQPMqQD+acyUk1xzyBo1h+EGgH5zYEVCe5JrYYBSJk4=;
 b=ckZDFSkY6Q43IAbM03mvY5u8RqAq2yu0c1NSHwaS0qXeNVbLdmORnLK8+46gPijcsSUU8eHzkHoP030JbnD154WnHNwjY1Ly0CYCrZ5zU819nG9sSj6ts7OG4CXYsy/VabHds+kdkz386LPn2tNKINsfOqw+x+Nr6/vngEsy1/W0VKwsEzSR6ENnTuVVO5mw+25UbONOUAr8/XPHWVuFhbJCH4Qq7lf2Wj58e8G2AX1EDsP5HRFOF1dmtEiWSdpiev4LRZYGNEocib27MhudP2Y38OTABtXYLneDQEkY6LUqffZa0atuewIMNsjiAC7RhC+yJU0FBDabf3Ya+rD59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQPMqQD+acyUk1xzyBo1h+EGgH5zYEVCe5JrYYBSJk4=;
 b=XiG9PMZoavfGfV+HOIVxJQHSVO9kn2c5BanCMrwoC7T36eL/kb0kJ+Sq4gecuf+ybNMAQAKyLabhQjwBNqzGPiCD97xP2Nx2ZfnCb7gp81P2JpW++2XiCR0wIPwAGHp+se+PT35chAPJAXLLigmwLCaPQ+x0O4AuLFUX8720fcY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 24 Mar
 2023 23:22:36 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 23:22:36 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v13 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v13 6/6] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZXppUZVOFF6I32EioTnV2GbdA+a8KkceA
Date:   Fri, 24 Mar 2023 23:22:36 +0000
Message-ID: <20230324232225.5xcvln2tfoysosvd@synopsys.com>
References: <1679694482-16430-1-git-send-email-quic_eserrao@quicinc.com>
 <1679694482-16430-7-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1679694482-16430-7-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB8935:EE_
x-ms-office365-filtering-correlation-id: a745682a-f5ed-4f55-f33e-08db2cbea70a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77DIV2NkVt9VIS9yh6D2KXwW5qiqTuLhnP7L1Tgt36i7V/dKhbRYRN5jdMquxBRPxXTqBFWK7gurzm0sPEI+96wjF28mbNBifjz98KPl0J/oQJGZVtIk2wAJT8QUatEX8/uJAiP777VWQnCzlQI9z3y3qRlYs9Z/34kOt3LCMaNrSAGqQm5fybTB8qRQnV6dr2fkNlAWEeGae3XuwY0hSR0ih1iCJlIjt3sbHxSULUZbv5IPKmKutH5L/901cu0UnNIbl8LAjeiTDpoQ2g2qPIO7iv8ep+gmIGwAN4MS+zOT8Xd023NRnORAO51ngBZXlgK/f3jpT1/4l4EaBfIRmI3vCTfQu7o4lLvamj28d3h2ngkjeypXp1HzVtmC6VAcw/UgmtV5bIbQQphaGQZpzhY0/4kVWG5NPcFaGM+02U8w30ioEUPiVD2gslsTC9OXQv8U/7XUGxcJsQ7aluengoJWaELhAxiVHn4G/bweQBILzVP1OsgaQbv9VUwzHy+cPVwAson8Sqwz5IgYxy6OknZ4RrWOAVwpzi4nfSLIFfCbSMS04UN+WyzmVX1LKfB4x0Q8zWoSXcLcQ2wHrkm+urkmThMzIfYMXJHZFv14TJf7dcNxNYCif4+0pkLk2KcXNXKY3FfX+RN4zPTPUZAj9y/45T6Lkhtb/hpwhHYZVBeW9w0haPvHWRtRva5u6iGuLmnEBpC1iQzV6D1o0BQrlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(66446008)(5660300002)(2906002)(54906003)(186003)(122000001)(64756008)(8676002)(41300700001)(8936002)(6916009)(2616005)(76116006)(66946007)(36756003)(66476007)(66556008)(15650500001)(478600001)(38100700002)(4326008)(316002)(86362001)(6486002)(71200400001)(1076003)(38070700005)(6512007)(26005)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTdRZCs1dnBKVnVaT1BtWWZlSS82MEFoWkM3RjhxUS9NdEdLM0p2My9xLyta?=
 =?utf-8?B?UjZOYXJJWVlDNjh3am42K1dMOUJIWVhmcG1qb1dkZ3htajdBeVJ3Qy91L0xL?=
 =?utf-8?B?Nk1manpTdHY0djJic2xmekZ1RmI0TXFvR3NiU2dTN09GVmVEZFRKVzRkbVN6?=
 =?utf-8?B?VW9FQ2hhencwOU5JY3ZSd0JzTUYrQnd3WWpjbzVFWXZOZDdDVUpXQlZXbVY2?=
 =?utf-8?B?Z0htVGlhSnRXdzVrU0RHZkpGa1Z0L1crcmcrSW9ZbE12M0sxU2s5ZnpvL3hs?=
 =?utf-8?B?dGM4dkJYOWdMSk5TNWtSN2Y5Ym5PZm4waHdOclRvb0t6YytNTWE3eDdlTXVq?=
 =?utf-8?B?czVJSXdqSUZVRGpRaXdXL1JRSFJLd0k4QjBsaXpGM3RjTlZ1WWQxRUtMSW80?=
 =?utf-8?B?cnRTTVpiNUNKbWg5M3JsSEZxcjNHSjMvS0NPMGcvenFlK2VxSDFiSnd2aTBh?=
 =?utf-8?B?VmhSMDVxOUR3MEd1bjBqZ3F2UnBsNzBaRjdXU0lBUCs5VVdJd01KUnBMV3lN?=
 =?utf-8?B?aEkxVHAxaDBod0ZVbDNnbjBjVTBSQ3dKeFpQTFNXcysySGJUd3plTGtLTDVw?=
 =?utf-8?B?V3JTQnRiWGxaZFlLTUliaFhTaGtEQTRzZWxuSzFoSGx6b2VWQ2piakNPeGF4?=
 =?utf-8?B?K002aVZ3MW1VSkRCeUlKc2h4WG4vT2owOUtVVmhpaUR4WmY0YWtweWtpbHR3?=
 =?utf-8?B?YUVpMlVzVW9tUmpOMGJjbFIwcklKNEN2UEVLMk9pUnh0UFVMeVp0MnhHeHlt?=
 =?utf-8?B?LzdtZm4yUWlqSGJPS01PS05icmNTUER4aTlNN1dJRnYwdE1Pc09CcTJWbjRW?=
 =?utf-8?B?LzNNMXFBdDZYSlJMYUtsKyswOEs1dElGSytPbHViTkJGR1hFTDViaVhwYXEz?=
 =?utf-8?B?dTZzNzdXSmROREdOK1lObDdmYlRSVktYVzI0NlRmSkppREJrRjZaT1FsUkZq?=
 =?utf-8?B?Y0h6MXFxbCthejNzM2tWMEE1RjY0RU1Wc3JJaHFXMWN4T3VpOW0zTUtsekc2?=
 =?utf-8?B?QXdhanhKcjI3MU9FU2FNSmFpOGwxNUFPY3R3eU42YnNZMzhLQ1I5bWRJM0di?=
 =?utf-8?B?NUNrd3JEZ3U3eDVnd2pBcnAwL1Q2cHhPazBJQzJKclhOcDR0aS9qL2JERzRM?=
 =?utf-8?B?WlVxQU1LYTdGaGhmWEgvcC9FZmZGK0JvMUtySjBPV1hPTS9JZGRxd2NuK1hJ?=
 =?utf-8?B?d2NkZlpUNkFDanVjRkwvaVk5YnRWOFNvbTJLbmwyYnVTaXBHZkZMN2JSN01P?=
 =?utf-8?B?OTJ2L2ZPY2ZJUW8rQVY2L25SZWRRWUc2SkZ4SGpPQkhQZUdGYUU0RWh6Tlc5?=
 =?utf-8?B?NXJWaS9mQkppVmVIaEVXU2pzU2pseWdwOEFqaGZsQzhKejluaXJhU2thUXRi?=
 =?utf-8?B?dFYwL1FtbGFCR1ZlZUJRY2NIR3FVc0hhaDVRa0hFVzZVMlhqRkw0dm5kb2lP?=
 =?utf-8?B?cHpWL2tRWlJ2MEtvbnpqMTlSb2ZqZWZFZjR4UkR6bWx5bktMRngvY3czRmVB?=
 =?utf-8?B?Ync2cEV1WDRXcnlqMkVsQlBDTmxmdTJYSE9YVE5QRnBiU2N4SG15cmU5LzZR?=
 =?utf-8?B?N3h5ekNhL2MraVNaTURsUC9JQlhVNjRwZmNJRFFNQmVuM21NcTNkRldhc1JL?=
 =?utf-8?B?MmRGMm9KODc2aE9kdlNGTUJ5U2kzb2FoWUhGZ05tenl2S05PU284TEFYR0JK?=
 =?utf-8?B?NzN0R3lKa1g1c3Z1dTc4WG5yY0U2bnlVVzREZ0JMN2M0ajJUbldjTzNoc3BL?=
 =?utf-8?B?c3JEUzNBOUNuM2xUM1FWQW1XMzFNMFllMkRsVEZkeGJvb0hoQW1FdGFNUGxl?=
 =?utf-8?B?WUZoYlpwK0l6T3N0NmkydTF5Zk9UMGQwOVF4dDRsYWpsUUp0RjhGaGpqVXY4?=
 =?utf-8?B?MUFsYTF3Rk16S0hvU1lwY3R5a0M5bVZUNUdmdDdzNHpXMXBXYjdXNHlMWVZS?=
 =?utf-8?B?Nzh0SnpMZlh1NS9QWTA3T0VCZWJSRnA2Rkl5T3JTQ2dTc2RjQWNQSGhFZjNs?=
 =?utf-8?B?bHB2ZnUwYm9yVnh1S0Z0M3VOdE54REYrdkkyZ3Nqano0NmZ0enlCek92bnpw?=
 =?utf-8?B?dC81WTAvV2ZXS0RoTHoxQ1FxRDRoVzJlcDRNS29oVWFCU2JrampMeGhuN0Q1?=
 =?utf-8?B?anlzWGpieWt0dkduaVEzWGp2L2hZcEpQUUVGenFXSEhXNXlXcWowbWxqRWc1?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8F126C9FD7304BB36801E480F06A2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W/htrL8Q5ReTH3fuzT8pWsFRk/+DDamTnPv8JySodUfsQLEUkMyEAbonONRZw97jtbkISeowKDj5SYj2AA/TKJPHWjzBMUtaOqIVqyQngWH0/CeFHoO3FPWRn9Uqsgu3T0N0uHHbFwcBdSfVkGfBfLP/agn/biK29DpIe+/SthU8R4scHCM7xsECrxccU2k34x9+SVITyg33Lv11POY1pYHQf3f6jY4ujZdtorffP86FcH567wHrOn4nwbtdyp0m4GwkMAfK4Kd433Mouf/lb9y/qYWYnrMIk+iEC560pbyGMoiJsEib9DFrqlEwT3AM4buv5mlAAweNrjoCFnLAXwZFK140nx9Qs+mnOiRkomAqha8Kr4mlduG/XDFZOMprTI7YcZL2AM7HefMnvSPSTmEin1YFLCbGTif+dmX0gtvw9rrezsfCjCYuQXJjwgFEA693MYupM9GsSm1RT6S3HmevWENanXaSNrQE61a1dAZ2BdyBvgabX5uWWbxy08uRwRg+neO+1xnmsQ7YNYeNuRW5a32B58GhRzm/OjShJDRDtsI9bxXOWZUkhE8qEtCJxP4dHBATWoz188QmfN8jwy92e92Kmummkf/PX2eY3l2y0rXxnocahWIRQZJzrpPWgAFz7/WIW3m6XeLNnPljwu/IQtBWWzcsdN5kf8KDNhIy/toIL4UDDmFu+WI21fTMyXr5JNE7hv1bEE1QbFKa9mwSFvWzTFMrzv9/9ROdwzp0Bf3wOH8dcKsAqpfRy19InywP3qDvvEFqP5rx6Ko0TUzaHxz9bhf5amAnjZsYLr7CzAvesMBqDkkrE6NBXo7t948bEJIIcTb34W0uTrZkVXOWOzHBPrqsVvCTuE3+4WCX9SZPFxKnXyRMzO+Fh8w8smV2hU3GsuWwbBPOK2Dmng==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a745682a-f5ed-4f55-f33e-08db2cbea70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 23:22:36.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EixXU9oWAMBVbYgIYQu/s1QGIUTqHOp5q2ozbRgv5i81ijcgN7j9wIiSU98kQHda8PW6CFdwakBivr1c8l43Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
X-Proofpoint-GUID: mTI4YSlTMDyQgWqAg_3Sx057Oa8LFJth
X-Proofpoint-ORIG-GUID: mTI4YSlTMDyQgWqAg_3Sx057Oa8LFJth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240178
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjQsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBzdXNwZW5kIG5vdGlmaWNhdGlvbiB0byB0aGUgZGV2aWNlLCBoYW5kbGUNCj4gdGhl
IHN1c3BlbmQgY2FsbGJhY2tzIGluIHRoZSBmdW5jdGlvbiBkcml2ZXIuIERlcGVuZGluZyBvbg0K
PiB0aGUgcmVtb3RlIHdha2V1cCBjYXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlciB0cmln
Z2VyIGENCj4gcmVtb3RlIHdha2V1cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQgcmVz
dW1lIHRvIHJlc3VtZQ0KPiBkYXRhIHRyYW5zZmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRWxz
b24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jICAgfCAyMiArKysrKysrKysrKysNCj4gIGRy
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMgfCA2MyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRo
ZXIuaCB8ICA0ICsrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiBpbmRleCBhN2FiMzBlLi5jNmU2M2Fk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiBAQCAtODg1LDYgKzg4
NSwyNiBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZWNtX2FsbG9jX2lu
c3Qodm9pZCkNCj4gIAlyZXR1cm4gJm9wdHMtPmZ1bmNfaW5zdDsNCj4gIH0NCj4gIA0KPiArc3Rh
dGljIHZvaWQgZWNtX3N1c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZikNCj4gK3sNCj4gKwlz
dHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYpOw0KPiArCXN0cnVjdCB1c2JfY29tcG9z
aXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNvbmZpZy0+Y2RldjsNCj4gKw0KPiArCURC
RyhjZGV2LCAiRUNNIFN1c3BlbmRcbiIpOw0KPiArDQo+ICsJZ2V0aGVyX3N1c3BlbmQoJmVjbS0+
cG9ydCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGVjbV9yZXN1bWUoc3RydWN0IHVzYl9m
dW5jdGlvbiAqZikNCj4gK3sNCj4gKwlzdHJ1Y3QgZl9lY20gKmVjbSA9IGZ1bmNfdG9fZWNtKGYp
Ow0KPiArCXN0cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiA9IGVjbS0+cG9ydC5mdW5jLmNv
bmZpZy0+Y2RldjsNCj4gKw0KPiArCURCRyhjZGV2LCAiRUNNIFJlc3VtZVxuIik7DQo+ICsNCj4g
KwlnZXRoZXJfcmVzdW1lKCZlY20tPnBvcnQpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBl
Y21fZnJlZShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiAgew0KPiAgCXN0cnVjdCBmX2VjbSAq
ZWNtOw0KPiBAQCAtOTUyLDYgKzk3Miw4IEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpl
Y21fYWxsb2Moc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZmkpDQo+ICAJZWNtLT5wb3J0
LmZ1bmMuc2V0dXAgPSBlY21fc2V0dXA7DQo+ICAJZWNtLT5wb3J0LmZ1bmMuZGlzYWJsZSA9IGVj
bV9kaXNhYmxlOw0KPiAgCWVjbS0+cG9ydC5mdW5jLmZyZWVfZnVuYyA9IGVjbV9mcmVlOw0KPiAr
CWVjbS0+cG9ydC5mdW5jLnN1c3BlbmQgPSBlY21fc3VzcGVuZDsNCj4gKwllY20tPnBvcnQuZnVu
Yy5yZXN1bWUgPSBlY21fcmVzdW1lOw0KPiAgDQo+ICAJcmV0dXJuICZlY20tPnBvcnQuZnVuYzsN
Cj4gIH0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVy
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jDQo+IGluZGV4IGYyNTk5
NzUuLjY5NTZhZDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X2V0aGVyLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIuYw0K
PiBAQCAtNDM3LDYgKzQzNywyMCBAQCBzdGF0aWMgaW5saW5lIGludCBpc19wcm9taXNjKHUxNiBj
ZGNfZmlsdGVyKQ0KPiAgCXJldHVybiBjZGNfZmlsdGVyICYgVVNCX0NEQ19QQUNLRVRfVFlQRV9Q
Uk9NSVNDVU9VUzsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBldGhlcl93YWtldXBfaG9zdChz
dHJ1Y3QgZ2V0aGVyICpwb3J0KQ0KPiArew0KPiArCWludAkJCXJldDsNCj4gKwlzdHJ1Y3QgdXNi
X2Z1bmN0aW9uCSpmdW5jID0gJnBvcnQtPmZ1bmM7DQo+ICsJc3RydWN0IHVzYl9nYWRnZXQJKmdh
ZGdldCA9IGZ1bmMtPmNvbmZpZy0+Y2Rldi0+Z2FkZ2V0Ow0KPiArDQo+ICsJaWYgKGZ1bmMtPmZ1
bmNfc3VzcGVuZGVkKQ0KPiArCQlyZXQgPSB1c2JfZnVuY193YWtldXAoZnVuYyk7DQo+ICsJZWxz
ZQ0KPiArCQlyZXQgPSB1c2JfZ2FkZ2V0X3dha2V1cChnYWRnZXQpOw0KPiArDQo+ICsJcmV0dXJu
IHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIG5ldGRldl90eF90IGV0aF9zdGFydF94bWl0KHN0
cnVjdCBza19idWZmICpza2IsDQo+ICAJCQkJCXN0cnVjdCBuZXRfZGV2aWNlICpuZXQpDQo+ICB7
DQo+IEBAIC00NTYsNiArNDcwLDE1IEBAIHN0YXRpYyBuZXRkZXZfdHhfdCBldGhfc3RhcnRfeG1p
dChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAgCQlpbiA9IE5VTEw7DQo+ICAJCWNkY19maWx0ZXIg
PSAwOw0KPiAgCX0NCj4gKw0KPiArCWlmIChkZXYtPnBvcnRfdXNiICYmIGRldi0+cG9ydF91c2It
PmlzX3N1c3BlbmQpIHsNCj4gKwkJREJHKGRldiwgIlBvcnQgc3VzcGVuZGVkLiBUcmlnZ2VyaW5n
IHdha2V1cFxuIik7DQo+ICsJCW5ldGlmX3N0b3BfcXVldWUobmV0KTsNCj4gKwkJc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7DQo+ICsJCWV0aGVyX3dha2V1cF9ob3N0
KGRldi0+cG9ydF91c2IpOw0KPiArCQlyZXR1cm4gTkVUREVWX1RYX0JVU1k7DQo+ICsJfQ0KPiAr
DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7DQo+ICANCj4g
IAlpZiAoIWluKSB7DQo+IEBAIC0xMDE0LDYgKzEwMzcsNDUgQEAgaW50IGdldGhlcl9zZXRfaWZu
YW1lKHN0cnVjdCBuZXRfZGV2aWNlICpuZXQsIGNvbnN0IGNoYXIgKm5hbWUsIGludCBsZW4pDQo+
ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChnZXRoZXJfc2V0X2lmbmFtZSk7DQo+ICANCj4gK3Zv
aWQgZ2V0aGVyX3N1c3BlbmQoc3RydWN0IGdldGhlciAqbGluaykNCj4gK3sNCj4gKwlzdHJ1Y3Qg
ZXRoX2RldiAqZGV2ID0gbGluay0+aW9wb3J0Ow0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ICsNCj4gKwlpZiAoIWRldikNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKGF0b21pY19yZWFk
KCZkZXYtPnR4X3FsZW4pKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZXJlIGlzIGEgdHJhbnNmZXIg
aW4gcHJvZ3Jlc3MuIFNvIHdlIHRyaWdnZXIgYSByZW1vdGUNCj4gKwkJICogd2FrZXVwIHRvIGlu
Zm9ybSB0aGUgaG9zdC4NCj4gKwkJICovDQo+ICsJCWV0aGVyX3dha2V1cF9ob3N0KGRldi0+cG9y
dF91c2IpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZkZXYt
PmxvY2ssIGZsYWdzKTsNCj4gKwlsaW5rLT5pc19zdXNwZW5kID0gdHJ1ZTsNCj4gKwlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ssIGZsYWdzKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1C
T0xfR1BMKGdldGhlcl9zdXNwZW5kKTsNCj4gKw0KPiArdm9pZCBnZXRoZXJfcmVzdW1lKHN0cnVj
dCBnZXRoZXIgKmxpbmspDQo+ICt7DQo+ICsJc3RydWN0IGV0aF9kZXYgKmRldiA9IGxpbmstPmlv
cG9ydDsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArDQo+ICsJaWYgKCFkZXYpDQo+ICsJ
CXJldHVybjsNCj4gKw0KPiArCWlmIChuZXRpZl9xdWV1ZV9zdG9wcGVkKGRldi0+bmV0KSkNCj4g
KwkJbmV0aWZfc3RhcnRfcXVldWUoZGV2LT5uZXQpOw0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNh
dmUoJmRldi0+bG9jaywgZmxhZ3MpOw0KPiArCWxpbmstPmlzX3N1c3BlbmQgPSBmYWxzZTsNCj4g
KwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxvY2ssIGZsYWdzKTsNCj4gK30NCj4gK0VY
UE9SVF9TWU1CT0xfR1BMKGdldGhlcl9yZXN1bWUpOw0KPiArDQo+ICAvKg0KPiAgICogZ2V0aGVy
X2NsZWFudXAgLSByZW1vdmUgRXRoZXJuZXQtb3Zlci1VU0IgZGV2aWNlDQo+ICAgKiBDb250ZXh0
OiBtYXkgc2xlZXANCj4gQEAgLTExNzYsNiArMTIzOCw3IEBAIHZvaWQgZ2V0aGVyX2Rpc2Nvbm5l
Y3Qoc3RydWN0IGdldGhlciAqbGluaykNCj4gIA0KPiAgCXNwaW5fbG9jaygmZGV2LT5sb2NrKTsN
Cj4gIAlkZXYtPnBvcnRfdXNiID0gTlVMTDsNCj4gKwlsaW5rLT5pc19zdXNwZW5kID0gZmFsc2U7
DQo+ICAJc3Bpbl91bmxvY2soJmRldi0+bG9jayk7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQ
TChnZXRoZXJfZGlzY29ubmVjdCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vdV9ldGhlci5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIu
aA0KPiBpbmRleCA0MDE0NDU0Li44NTFlZTEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9n
YWRnZXQvZnVuY3Rpb24vdV9ldGhlci5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi91X2V0aGVyLmgNCj4gQEAgLTc5LDYgKzc5LDcgQEAgc3RydWN0IGdldGhlciB7DQo+ICAJ
LyogY2FsbGVkIG9uIG5ldHdvcmsgb3Blbi9jbG9zZSAqLw0KPiAgCXZvaWQJCQkJKCpvcGVuKShz
dHJ1Y3QgZ2V0aGVyICopOw0KPiAgCXZvaWQJCQkJKCpjbG9zZSkoc3RydWN0IGdldGhlciAqKTsN
Cj4gKwlib29sCQkJCWlzX3N1c3BlbmQ7DQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5lCURFRkFVTFRf
RklMVEVSCShVU0JfQ0RDX1BBQ0tFVF9UWVBFX0JST0FEQ0FTVCBcDQo+IEBAIC0yNTgsNiArMjU5
LDkgQEAgaW50IGdldGhlcl9zZXRfaWZuYW1lKHN0cnVjdCBuZXRfZGV2aWNlICpuZXQsIGNvbnN0
IGNoYXIgKm5hbWUsIGludCBsZW4pOw0KPiAgDQo+ICB2b2lkIGdldGhlcl9jbGVhbnVwKHN0cnVj
dCBldGhfZGV2ICpkZXYpOw0KPiAgDQo+ICt2b2lkIGdldGhlcl9zdXNwZW5kKHN0cnVjdCBnZXRo
ZXIgKmxpbmspOw0KPiArdm9pZCBnZXRoZXJfcmVzdW1lKHN0cnVjdCBnZXRoZXIgKmxpbmspOw0K
PiArDQo+ICAvKiBjb25uZWN0L2Rpc2Nvbm5lY3QgaXMgaGFuZGxlZCBieSBpbmRpdmlkdWFsIGZ1
bmN0aW9ucyAqLw0KPiAgc3RydWN0IG5ldF9kZXZpY2UgKmdldGhlcl9jb25uZWN0KHN0cnVjdCBn
ZXRoZXIgKik7DQo+ICB2b2lkIGdldGhlcl9kaXNjb25uZWN0KHN0cnVjdCBnZXRoZXIgKik7DQo+
IC0tIA0KPiAyLjcuNA0KPiANCg0KRm9yIHRoZSByZW1vdGUgd2FrZXVwIHBhcnQgb2YgdGhpcyBw
YXRjaDoNCg0KUmV2aWV3ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lz
LmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

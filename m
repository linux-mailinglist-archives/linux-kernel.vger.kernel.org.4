Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A56B74A71D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjGFWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGFWea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:34:30 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D91FC3;
        Thu,  6 Jul 2023 15:34:25 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366HIjCi009998;
        Thu, 6 Jul 2023 15:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=MsGLhbOIZF5qZoAicBk8AvaAAS/IWkzH3cEf3Rg/HK0=;
 b=Gu+5NVwqNZSM52DAKt2AUehcu7bFPXHsV6Ah0YFhkXEhj+WHTXpTFj5jEMc/xD3gkmEB
 uGmkBxynB7DaJYNB+hs3VOjOVGdHbkDeGID0yTE1P2/wxi6CWXVXhmTwykac/sFok33g
 0ORlNMf9vs16Iv68cGhhdcMpAkvakZtr4h5iyOLcIWDPo4WZLHXhpvHn7UZm6EO+9b6Q
 vxs0BaVQYt3OyWDJq7h8RuFXbwJE0erjBX91hmSpNPivDdNZZVcjRbE3sb5NfUEAU6jy
 uZ/COSVYZQkgkFLnEOnylo2+6IF8t+77AnVIz2QgA4vSRUC/PkLz8WsIWi5UKFZTwzzu Gw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rjk5mdnaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 15:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1688682861; bh=MsGLhbOIZF5qZoAicBk8AvaAAS/IWkzH3cEf3Rg/HK0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SE0z7rLG306qu9lxVYOKFUyUvlszVMkwLFxxPDBQqi9ZS7CsYjGO59TffnMd88dcV
         4VgLhs6FOnmzGPh1oXAfLC3jFsSwsIc0Y+SFpYP1yJlMLbd/CTqlQsuMcdy2kmYNt2
         XjcVt296HA9sXRYEg1nM4a7kTwYBXFRKXlNyJppqPLddjhqckSkbJrHXXicRBomBZM
         t14ZWzoPwJwJCIbWml4Zk21OucC+5EPIaF87NZnpTq4T4ZE3X+4M2+AZJrnZb9iRwv
         30jFmyJTCvpgDKOX62LaiSMtqB78iFpdBGLMSwHWOJvbgsRLVqtI7o4D5GP1XQZY+6
         lMTiplNZ4c17w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2C91140682;
        Thu,  6 Jul 2023 22:34:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7B854A005E;
        Thu,  6 Jul 2023 22:34:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CZcDlyJJ;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 58F26401CB;
        Thu,  6 Jul 2023 22:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWETvfAUKDpgiEQTLpRzxMCL+sXkItq3RAYgmEbrMgWLbkQEPUffr362C1FF6N19Br1dqH+bU+bX3I68818KXQQhpWfTOHqG4gtr3Pu8kqB019kgHjPv69bMOeYB1z7721gcGXjm3eC2UjSzlvl0aoxA3kc/sfOsK5nu1NfoHFkHpUlEvz2n7dJ7Gnguo+4N6Oym9syDxKuMT6rUYl//6zbJVJCoXFglfqCYDWBPLZIFTIlNx285Ezmypij7B/vhfIN21+oRTZA6AcsrGQgIH3YDPEyXCiDvcrnvjvheyeTG9YdPizKrhWgQZfJuYTyG404VmSP2qeSZsaijK5bwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsGLhbOIZF5qZoAicBk8AvaAAS/IWkzH3cEf3Rg/HK0=;
 b=DjFY15D04CFF6iy4gQIrqHUEJRHc9Pep5O/HwagAAPT4HPaQwDV/8E/OlzMc9ImmU21h0thOiPWLQnyIAj6sZDluv1sfT10oKmkxHdfnVJ0KVYtEzZHtVIKebNxjDMzbxf5yz+o/Pwq4/5vNkwyOkeTZ1VNUloYKFKe6YNjzhI4HwWtWIarkkRD5noj40NbGL6riZh2rUwibeWek1WIxxfm4XAUMBYTMxxctyXj9c8YSX9OgZoa5KCX0FHAEGmTvE+WgAxdffS38qIk/bjJepklMIUr61Pymswc0zsKhE5KdoOmehZNIzsKrdpnZmd+IV7Yy61437iEY4uAyr/ol1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsGLhbOIZF5qZoAicBk8AvaAAS/IWkzH3cEf3Rg/HK0=;
 b=CZcDlyJJBjGV90W0fxjQVAAq34zCp5+LhjTYB7+c9QngFGIDkMV1hSbo2CRuKWucczMAvjj37BTdozIruYxOJ1KE4brxSVMVDJcle3y7zYGCyXbNygGrmebkHdEMXGv4FHwnIMCInfuDBHpPdZ7vJIsvZVhn08QwuRGezQW6tEI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 22:34:16 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 22:34:16 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Topic: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
Thread-Index: AQHZhnOYGWoDiciaPkad/64K3wvwX69dmz2AgE95D4CAAJLEgA==
Date:   Thu, 6 Jul 2023 22:34:16 +0000
Message-ID: <20230706223411.mlalnochoabofcmj@synopsys.com>
References: <20230514145118.20973-1-quic_kriskura@quicinc.com>
 <20230517001105.v74dyo6asqtcrpii@synopsys.com>
 <fb973659-c645-a4f2-e0fe-a40536e8b9fc@quicinc.com>
In-Reply-To: <fb973659-c645-a4f2-e0fe-a40536e8b9fc@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB8826:EE_
x-ms-office365-filtering-correlation-id: a1f05fe8-d355-44ee-3767-08db7e7121dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0b9I7L7vrtZivDV5qXkeTD90hQwP0X0vuX+ELd2LManem2nYN1E45Jt0qLol/0/nd9TzU/CBizX2+h9P+eN7f4MoqLF8mAfYk2D8lKdoBoJUlwB+Z0UVWWIgELR7s7VDQu6ULZo55FYXZfpAfuk3Dt02oTFtg0qwHiLrfXg032W0Byc1dg+21GDEYBdmM7myY2euhZPAsFPzDyPH3zDqeDdmNPmTwdYO/8zeHCE5La/r12SNqNv28TPbDL9Yaq+O0r9CSEhhZmisiLgrVw5exNIT6nUDgeXSUpSHD4i2Qt1DZPYXXaG+7H+j9nidXSphDsPbygYJ0gLB7HhGXxUH65DMfC/8oto/mCXRxTgWS/GKr7XaeNodrV6Qu6K2l8zMNCJT/DjFs0f1ZRIBz/XhgEEygxxg62TyRsz9WahXxijU+8pA2xotf3CXeSJ3HuzIbgU3GeCqocBnfEIez9A0ucuMrgqBZEv2UGSFsyZJwenpvQtCkmwjI46ADlRL3C6LxL1pqI16pBDayFaYtjNB5pnQ2tMVKisZSPDygEfEiuoG5SsPZIQm+jrnWulUm17YQDiYMzcSoDNUNB4sMKFAdvlRxFiIC6dZHGMQmqxbK8Wd5TT7X6/CuJN4IEFsw0y/KcPCVbNqWkFt4PR91dV3Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(66476007)(41300700001)(38070700005)(6512007)(966005)(478600001)(54906003)(86362001)(38100700002)(122000001)(71200400001)(6486002)(316002)(66946007)(3716004)(66556008)(4326008)(64756008)(83380400001)(6916009)(91956017)(36756003)(8676002)(2906002)(8936002)(2616005)(5660300002)(66446008)(1076003)(186003)(6506007)(53546011)(26005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHl2eGFqSWRyM29hMXMzM2l5cFUrRFdzN3pOdGM0ZjF4QkUydUxHclpzbUlr?=
 =?utf-8?B?Rm1qTVhLSXRJUVpxdUZTSFJIaXhpcVV2OUc3NjlWNlY2MkNIT2psNUNVbWYv?=
 =?utf-8?B?cllLWFVIbWxKdUdMMW1OdVdmS2YxZitoaEFtdXhLWTgzY2NmblRsd2UzNmYy?=
 =?utf-8?B?bzBEQTU1UHZqWVN1bTZhOHlLWDFHZEVpTmx5YU5SQ29aTFlabFFFaXBpUlY5?=
 =?utf-8?B?L2VDQkJhZVpwRFdENXNTTVc2QnlqMHBEOG1IWXQ3TXVkTmVod1NUQzg5M0NS?=
 =?utf-8?B?WlB2Tk8wa0wvL3Z1d3hUcE50ckRpOWxUUlM1MmFYSjlxSlMwSFlvWTBKRWtS?=
 =?utf-8?B?WXl1RzdjTmMxSVFvUm55YzQwaXBwS3NYRGx1MlVJNk5ZWlFBczVjSG9LTGk4?=
 =?utf-8?B?ZkVmaDFQbzk0Qi9aeDd0Vnp0ZzFHYUdoeHAzajFNVXM1eXNXa21BT0pzbTVF?=
 =?utf-8?B?eGRjdTdjbHdMY1U0UW9MY2JWNGtUbWdZSEo1cmlJTTBkZFhnVHU0eUdPSDh0?=
 =?utf-8?B?ZGpoR1kyQ29MNjdJamFqdzhjMTEyQU5PL09kQzJtRWdmNlFYK05OUDFQY3RB?=
 =?utf-8?B?NldhWFdNTllucTgzYWFZVzFDUHB4Q243eHEyNko2U1FBMlBXZXdpWW1iTXZF?=
 =?utf-8?B?ZnJIbXZ1aXp1NDdSYWt4cFZCY09pVHlxd2gzZForQW5XT0xxRVllSUJSRCs2?=
 =?utf-8?B?ejd0K1FmeHRCcmFGODNLMlZHU24xVUJNZHJQRU5sanhMd1ZXY1hWdHVsUnVn?=
 =?utf-8?B?eTVSc1NiV1ZiR0JLNDB5SVlNZDJjbUM4SHdJS0JoNDlJZDRZcUE2bEFCLy9t?=
 =?utf-8?B?MTBZZFpNb0hGLy9mMkFrcXNTb3JNcjhsOUhCd0tQbitnWkJyRGd6MU5pYVM5?=
 =?utf-8?B?NHJ3VVJCR2M0S0YrWVExVkJyNC9tNU51YXNUb3h3ZTl5eXpzZnBYdlU5M2w3?=
 =?utf-8?B?dTRtbnRocW15ZUhpWUFtc28rNnZuQ3B5Y01Edyt4WWYxOWZmc0tvL0M1UmR6?=
 =?utf-8?B?VnBYNW5DaDN5bzkyUzl3SWZtbkErUHdHaThCRUU0Z2pTK05mMUphK3RMWm9t?=
 =?utf-8?B?bTVqc2ZRK2gyTkxrM010MGcrVWQxOHNGU0Z5UHd0YjFrcG1uRUxhTDY3SXd3?=
 =?utf-8?B?WWN5ZWcwNndRMGJxL1Vqa3l5WC92citnbndkNHc2OTllSnVqQ1lIYk9RU01u?=
 =?utf-8?B?cXpoOStUNXlBazQxdkNKSk91M0c1QUIvcXN5Syt4MitwelhtRUJFNlJXL1hZ?=
 =?utf-8?B?L0k4UFkxQUNWYXhVOWpFNDNqZlpEamlqK1YyV3NjU01lMm8vQmdDUUQvOCtZ?=
 =?utf-8?B?aHhRQXpHV0FoL2hzUEh2M3pXalFXNk1jaFNjQkJHQU10TVJmd3JQbXZ2dUJK?=
 =?utf-8?B?eWhCa1BNdDRTelB2VERJaXhzMEowOEMyRTJ4VEVMOEh0dVpCdVRxcExFaUdU?=
 =?utf-8?B?aVBkRTV0cUNFT3RvekNDTjU5QW56RmlhcWR3REpWdzJOTmU1blBxMVVpOHl5?=
 =?utf-8?B?emQ0STZlRnQ0RUxZM3BFeFoyZzZJLzlYUjFueFhabDRPb0ozOTM4WjhNbzF0?=
 =?utf-8?B?ZjNibDhyVEVFS242aHY2dHBIQk1PMzQyeHJrNGYvMjdsU2hlRktucjZzVHRR?=
 =?utf-8?B?VHNtRGIwQXQrR2JKeXhoOE9ZU0JKN0ZIM3FPSU1Od0pHeVBaMTR4WHVHeXRx?=
 =?utf-8?B?T2cxRlY3SHEvVUFBdkViUStXTVNqZi90V3lDSDF2NGkrbjRMM2JUOCtrcUV3?=
 =?utf-8?B?Ym5nbk1jNWkyejdDMlBFZGY4RHAveTRGWjgwNHRuT0RsSnYxUnJiekl0Zjhz?=
 =?utf-8?B?N3lsUTdXVDVmcjB6blh4WFk2ckNRbjhKSkNZVlpkU21ibFBWOTBVb2pRdUFF?=
 =?utf-8?B?U1FDdUhhRkw4VnJrVElSQ2VSMlJUcjB4eXRPcnRDQmtoWFFDMlFEc21iNHFs?=
 =?utf-8?B?Mm9pWCtiOTR1blczSXB6aEZmem9rV0dDUGxGWHYvR2R2cUhEWkFWRVQ3V215?=
 =?utf-8?B?T2ZtTzNwQVlaREJqY3BDKzVvM1ROKzcxNWJyN1dvN3hEUWJIV2RsR3YzZXZu?=
 =?utf-8?B?MThSamdXeUQ2N05KQWcxZnJZZnlFTmJhSlFMcXZLSkpqamMwSEFtaDgrbDJN?=
 =?utf-8?Q?Y6BNFnfjERXRfP7nC02z2q6fG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED88A2500B97CC46BB7D8345CB094BBA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w5gcXYbpCUR3qbNbkYuA6gjx3/sGX9G4ZADdAgoSnmOXC+VTF7M+l9WDJEIR052dEK+cr1IVGF8+ccJurQMNX8+iR8XG94qURWXiXELZnokTzTdCgwF/ccQmyosbKvaG+HjJWg3bhgIzEePtlwUaBWHuz0K585eLJS+P4kO7UWNqKSGGud1NeZnIV5zEnjCa4DLBmqYEcuFdcibzvOuvfGuXPTSSS0WnFxFx22KTFUsQaRKj8lGEBbNvLtiAEXgtc4rqDtTLyHzN4OBDib3Jb4I4Xre37sul0QvIbf2sOdIZQoKTVWbpoU7fnEB+8G/EdlsmCuQXKs+xvbrlMsOQGI1l7og7guiDmm1H0kWcNldAMZJwh75WSuEPcwDCjkDGXPY0a2g+J7DkeAbu3xWNSEGHXdBy/nR+QC1nTzfLsPIiFf8AcW8KpXK0SHemukcBHdBIAMun2yiIQ3aw21MKmtcbttSWRWP1yDfgzPYfXn+cj6okQ8ixmCa5VNtP9ncYl7u1U8LdfDtrdccaWynBZ3tQn8Z5WdanD22HGegpLQBxjQUKyzeiE0Hvgsa/dps/jHxEJrsMoE47E4ylF87BLSkxFNZDiwPin8R11xeX/fv3yBQD2mDM6L9qpTmT/7NvaszFd6w/0+S+d75ArQhGJf4pti1kAlePdGYKHvvaMiTgpQOVQ2zDlBBI0GF5HTQkcMJvJHYDS/L4izlGQoF+PffMGKjd9OEUr+UfWyD9xdoJrkmyMsbBQpG2FdB5cQHlG+RP6X7bT51Xr9OFWtSM79X0tck56a1mT6GD1J2PjC4bBEpKPKT/hddbHezlvzxQKD7i1EV1XC7Zy7yNhGYRE1ShfEWUuauTGHQidVXgUSJY/9GJaUlhpjEZrEWu3/CBiP3Bifi8ackA6+g2fzQE8A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f05fe8-d355-44ee-3767-08db7e7121dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 22:34:16.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeZGeBbRk5wX1pII56mcEe47eEzvUn+KogjiOthXmjNutt4a7tH4hHR1jVorVrgJoCJ51dTsNnxZpB1bIV61rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
X-Proofpoint-GUID: ck3YFoXDaNIh9_sDtuaEFdQeqXsqC2qT
X-Proofpoint-ORIG-GUID: ck3YFoXDaNIh9_sDtuaEFdQeqXsqC2qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMDYsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8xNy8yMDIzIDU6NDEgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBT
dW4sIE1heSAxNCwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4gPiA+IEN1cnJlbnRs
eSBmb3IgZHdjM191c2IzMSBjb250cm9sbGVyLCBpZiBtYXhpbXVtX3NwZWVkIGlzIGxpbWl0ZWQg
dG8NCj4gPiA+IHN1cGVyLXNwZWVkIGluIERULCB0aGVuIGRldmljZSBtb2RlIGlzIGxpbWl0ZWQg
dG8gU1MsIGJ1dCBob3N0IG1vZGUNCj4gPiA+IHN0aWxsIHdvcmtzIGluIFNTUC4NCj4gPiA+IA0K
PiA+ID4gVGhlIGRvY3VtZW50YXRpb24gZm9yIG1heC1zcGVlZCBwcm9wZXJ0eSBpcyBhcyBmb2xs
b3dzOg0KPiA+ID4gDQo+ID4gPiAiVGVsbHMgVVNCIGNvbnRyb2xsZXJzIHdlIHdhbnQgdG8gd29y
ayB1cCB0byBhIGNlcnRhaW4gc3BlZWQuDQo+ID4gPiBJbmNhc2UgIHRoaXMgaXNuJ3QgcGFzc2Vk
IHZpYSBEVCwgVVNCIGNvbnRyb2xsZXJzIHNob3VsZCBkZWZhdWx0IHRvDQo+ID4gPiB0aGVpciBt
YXhpbXVtIEhXIGNhcGFiaWxpdHkuIg0KPiA+ID4gDQo+ID4gPiBJdCBkb2Vzbid0IHNwZWNpZnkg
dGhhdCB0aGUgcHJvcGVydHkgaXMgb25seSBmb3IgZGV2aWNlIG1vZGUuDQo+ID4gPiBUaGVyZSBh
cmUgY2FzZXMgd2hlcmUgd2UgbmVlZCB0byBsaW1pdCB0aGUgaG9zdCdzIG1heGltdW0gc3BlZWQg
dG8NCj4gPiA+IFN1cGVyU3BlZWQgb25seS4gVXNlIHRoaXMgcHJvcGVydHkgZm9yIGhvc3QgbW9k
ZSB0byBjb250cmFpbiBob3N0J3MNCj4gPiA+IHNwZWVkIHRvIFN1cGVyU3BlZWQuDQo+ID4gPiAN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVp
Y2luYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVmZW5z
ZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA1MTIxNzAxMDcuMTg4
MjEtMS1xdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFkQ2dfM1dLMm9O
WE5iNmQwYV9WdXlqa2VlWkpUVTFhWTRkaWs2ZzM1WEI3bXRHN0VKZVIxdVBNZnhGamE0OU9mWHA3
WWhzZzF5cWpueWxDWVlFZzdZQ0FocWZBWjBRJA0KPiA+ID4gDQo+ID4gPiBEaXNjdXNzaW9uIHJl
Z2FyZGluZyB0aGUgc2FtZSBhdDoNCj4gPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvZTQ2NWM2OWMtM2E5ZC1jYmRiLWQ0NGUtOTZiOTlj
ZmExYTkyQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFkQ2dfM1dLMm9OWE5iNmQwYV9WdXlq
a2VlWkpUVTFhWTRkaWs2ZzM1WEI3bXRHN0VKZVIxdVBNZnhGamE0OU9mWHA3WWhzZzF5cWpueWxD
WVlFZzdZQ0RSTFVySldnJA0KPiA+ID4gDQo+ID4gPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IHwgOCArKysrKysrKw0KPiA+ID4gICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8IDUgKysrKysN
Cj4gPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+ID4gPiANCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+ID4gPiBpbmRleCAyNzhjZDFjMzM4NDEuLjMzYmM3MjU5NWU3NCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiA+ID4gQEAgLTEyNjIsNiArMTI2MiwxNCBAQCBzdGF0aWMgaW50IGR3
YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgIAkJfQ0KPiA+ID4gICAJfQ0K
PiA+ID4gKwlpZiAoKGh3X21vZGUgIT0gRFdDM19HSFdQQVJBTVMwX01PREVfR0FER0VUKSAmJg0K
PiA+ID4gKwkgICAgKERXQzNfSVBfSVMoRFdDMzEpKSAmJg0KPiA+ID4gKwkgICAgKGR3Yy0+bWF4
aW11bV9zcGVlZCA9PSBVU0JfU1BFRURfU1VQRVIpKSB7DQo+ID4gPiArCQlyZWcgPSBkd2MzX3Jl
YWRsKGR3Yy0+cmVncywgRFdDM19MTFVDVEwpOw0KPiA+ID4gKwkJcmVnIHw9IERXQzNfTExVQ1RM
X0ZPUkNFX0dFTjE7DQo+ID4gPiArCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfTExVQ1RM
LCByZWcpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gDQo+ID4gUGVyaGFwcyB0aGlzIHNob3Vs
ZCBiZSBkb25lIGZvciBldmVyeSB1c2IzIHBvcnQgcmF0aGVyIHRoYW4ganVzdCB0aGUNCj4gPiBw
b3J0XzAuIFRoaXMgcGF0Y2ggY2FuIGdvIGFmdGVyIHlvdXIgbXVsdGktcG9ydCBzZXJpZXMgaXMg
YWRkZWQgdG8NCj4gPiBHcmVnJ3MgYnJhbmNoIHdoZXJlIHlvdSBjYW4gY2hlY2sgZm9yIG51bWJl
ciBvZiB1c2IzIHBvcnRzLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBUaGluaA0KPiA+IA0KPiAN
Cj4gSGkgVGhpbmgsDQo+IA0KPiAgIFNlZW1zIGxpa2UgbXVsdGlwb3J0IHdvdWxkIHRha2UgbGl0
dGxlIG1vcmUgdGltZSBhbmQgSSBuZWVkIHRoaXMgcGF0Y2ggdG8NCj4gYmUgcG9ydGVkIHRvIEFD
SyBmb3IgZml4aW5nIGN1c3RvbWVyIGlzc3VlLiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byB0YWtl
DQo+IHRoaXMgcGF0Y2ggYXMgaXMgPyBPbmNlIG11bHRpcG9ydCBpcyBkb25lLCBJIHdpbGwgc2Vu
ZCBhbm90aGVyIHBhdGNoIHRvDQo+IGluY2x1ZGUgdGhlIGNoYW5nZXMgZm9yIG11dGxpcG9ydCBh
cyB3ZWxsLg0KPiANCg0KVGhpcyBpcyBub3QgYSBmaXggcGF0Y2guIEl0IHdpbGwgbm90IGJlIHVw
c3RyZWFtZWQgdW50aWwgdGhlIG5leHQNCnJlbGVhc2UgZXZlbiBpZiBJIEFjayBpdCBub3cuIERv
IHlvdSB0aGluayB3ZSBjYW4gZ2V0IHlvdXIgbXVsdGktcG9ydA0Kc2VyaWVzIGluIGZvciB0aGUg
bmV4dCByZWxlYXNlIGFsb25nIHdpdGggdGhpcz8gSWYgbm90LCB0aGVuIHdlIGNhbiBBY2sNCnRo
aXMgdmVyc2lvbiBmaXJzdCAod2l0aCBhIG5vdGUgdG8gdXBkYXRlIGZvciBtdWx0aS1wb3J0IGxh
dGVyKS4NCg0KSSB0aGluayBpdCBtYWtlcyBtb3JlIHNlbnNlIHdhaXQgYW5kIHNlZSBpZiB3ZSBj
YW4gZ2V0IHlvdXIgbXVsdGktcG9ydA0Kc2VyaWVzIGZvciB0aGUgbmV4dCByZWxlYXNlIGZpcnN0
LiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KVGhhbmtzLA0KVGhpbmg=

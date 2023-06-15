Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B537322BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbjFOW0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFOW00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:26:26 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CA268A;
        Thu, 15 Jun 2023 15:26:20 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FMCSYN026509;
        Thu, 15 Jun 2023 15:26:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Lm8ncHFbDLYkXc4RGL1pg8i4z9RFT79l2IwCpjKrj7s=;
 b=byHIrJvxK27nguHFaL5m9GTFeKlhxdi0aH8XAS5f0N0WkpcGHOO/Vs6sqCs+KoEqrVn2
 v2wb11BrJVU7Q+ywThfBxmJFjP+1v86WTisTFT5ALwnxsz59OLfuhhAjXZLbM1CNcHyX
 LPf8CmXwDadyaKUDIJSN6gybkIeK0anGSog1bRZcbxHI3RL0vn226rfgD8f4r2D8/Y7q
 AHWuzYt5u3OwaBDWkG6FpgZvkBWXgqgcc49VSwOMYsUd3BYd7cGszgLAgLb635CBdvG/
 DyO9lB4mAuZxSnjdqQPnyvDEY4KjrI3ieFppCMpigliZe2coBunfY2wlRqIhRMM8USuQ qw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3r4r3ubb41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686867976; bh=Lm8ncHFbDLYkXc4RGL1pg8i4z9RFT79l2IwCpjKrj7s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UeOvv9FmPABvPEPwgzrK7vtgWVgBQMAPfXHEdkCUC+OyTw7LFS2bXtbzAnkwtUM9T
         9ZPwqcLv8u0xc27qpQvvj3ldjIZa0hJct2k6XHgbnxpBPrAWc3yVN8mIpEtydJESHB
         9zDAc4enkABCjkDtPnNnThnPc6jlsGxOc8kOchstwpF7ujJg4zRLFYkxl2FEJSYVkH
         cqpPVo9xSdB758XG+ol4WjGvyd5S+jyKuic1kstF+yI6vCm8QZvkolAw2v36xINROD
         33gkKH4c7NpDlzgWvEubcjYn4hnWsNY+FEdC96ERdajWFuYDScN1DBVL8eMUebUI9r
         sd3oQ1WgW1hlA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2713D40136;
        Thu, 15 Jun 2023 22:26:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 84899A006D;
        Thu, 15 Jun 2023 22:26:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KUdbt1if;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6CFFC4045D;
        Thu, 15 Jun 2023 22:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcTTwbImDUCvm//1dwiFm6/55Zxrypul44fxh3M034ljZkeJffUaLjjeXjCyJbmJaVdA4hMmZnH1abUAM8n6GWmWAvPSjdBrCb2ONuRsvH9QAweZFq9hWAcv/7zqeTzZHvDmJ226XUptVD+i7tZePmhqQp1PRCBHkaMEgtALN1oq32MspjWRU5sKus2HRAo6FW7suNlJDiLzn4rqWADQbI0UjUkud+9bSsV/QoRNJPPuDBe5u1PF9texu+JElLvWPSbaTkU03dXTX2w9Y0kYTrZAr0cgeLtS1hvSl8dAaBMOVsXGbFmwNCVczJuEVvtj74WqO4sQxmewqfuHh6qtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm8ncHFbDLYkXc4RGL1pg8i4z9RFT79l2IwCpjKrj7s=;
 b=APcl0htgSA4Z1UdLbcx+K26CJly4XvZG7Epr25g2V6m7v9lsd5Yl+9Ok5dgfY9GRMdUYx5PYSUz9eJhXtKDYnCapQSCXgk+hRs8P4HBOWczE50Sa/Qbi3/ZQJ/0/l8WNoywoLe/eVZzUdm0I+KuSvtrWIBL5I1qMfRaXozaM6o0UBDEvDDFlAdQiOA8MWqgr1RV6iPGG9xY7yrEIFVaOyrf4DtANOxf1oSI22Vuvr1Pgb2khUhk2imKHYx+RpRrFinjsittaZSnyZCUkPnw9hsyki2vKK8M3hUOGOTDVAzmk7pydevx1iPBRjAk5Wbfgk4H8yeGLvKfXlZNpq641mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm8ncHFbDLYkXc4RGL1pg8i4z9RFT79l2IwCpjKrj7s=;
 b=KUdbt1ifQyCYx+4pK293k4qI9j8jceGJ7/ngSgnxnjDocPHTwWLyikZuxos7fQi2AJDqM65h19bEAOb0MwzX28Dyur8fmRY1CbrtfZ6HWqGSn47VljuHNxjbAqXEGTm70xJAANSB6IhwlYKof8w466a2gHSDamUsxpwvH68CdHI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 22:26:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 22:26:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Thread-Topic: [PATCH] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
Thread-Index: AQHZnscRxYdAzlx3Gkm9Jifuq9rRaK+McysA
Date:   Thu, 15 Jun 2023 22:26:10 +0000
Message-ID: <20230615222600.er6i6dllmxwylnbf@synopsys.com>
References: <20230614134922.23516-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230614134922.23516-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB6658:EE_
x-ms-office365-filtering-correlation-id: ea3a7e10-e7ea-45c8-c7a5-08db6def8584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6X5pZZzeDXe9Cy3qHIf0WJ51gwA0s6rVruhvFR02hLn2PU5XttFho6cXurw+ZwVo3YUyesFaR03Se6gn7kxMekjxDnvWQYVNSdEe6pJTEQlAnS9sG8fywfX+aY6ZtHmpVQYhvi2jgav8U/HTEuUTMF0HFT92V5oy8QAfVKhSWq7eINaR9wW9QCobGHUG2J9k9QNLuhcF+OZSviwuXBtRbzHT/eh8LZT0sCo2A90/oOFWb4L9m01lSO8eEkJdrh6aSast6UNlrDAlpLgxt3InPtCAz+qvexB90rz5CqFSJ/pob6Nt5ivfeIsVWRrgUnxfmuww//mpc4fhyhYfr7KFt2C0ASva0HbpM8/6NbO6ETjnSX9U6z2GYcGwMFCU+9B7bkifrp3NzdzG7bJVUJHKntezjAc5qWyI+cBoVngFTEiuNzeyl+3MgLHTvYN6GMUX9SrKTzmilKyMUhAlPFUz9y9MHoxALjjfhcD+rqNOJZeK9YDzYpmw0jv0Tr9AS+ytovenLbrREYHmmYtZ6WJvu0Faig5PMieBIx68Azqx+q14KEaqNGwfRyVaOtKSrLGntEogWwObztTCpkbDu4Au3g3MeDy+F+6VQkgLrGv7UAaDZfbQGCP9gRrFPZd93ZiY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(8936002)(26005)(6486002)(8676002)(6512007)(41300700001)(478600001)(36756003)(1076003)(71200400001)(66446008)(64756008)(76116006)(66556008)(4326008)(66946007)(66476007)(38100700002)(86362001)(6916009)(54906003)(38070700005)(316002)(122000001)(6506007)(83380400001)(5660300002)(186003)(2616005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1pvT2NEUVI4dkc1N3dhcGdEcFF5ZnpqSTdtKzAxTmZzL1IydlNwblEyVXdj?=
 =?utf-8?B?djBFNWlJZVRLbUNYRDJRSTR1L3Z2QmlSRWU5S0JKR0thb01vZFoyN1FQNUl1?=
 =?utf-8?B?L0Jick5OMHp0bndqaHhSNGF1N3VnRjZxSE5HRTJKRFBBanpwaEdJR1hIWlhX?=
 =?utf-8?B?T3lVYWl4NUNHdWZEMng5QUFGamRXVkIwTDc3ZTRNZ0NuWDJzMUR3Sk0xUjlE?=
 =?utf-8?B?VEpoYTFZbFdsaHlwL1NPWHFyclBqUTFHbFhmbjg5ZnJ6NzVTZy9LVTJrWEor?=
 =?utf-8?B?Z1VjRUFBSWFrZ1FONkdhemxyMWJ2L29sa002ZzhVcldyYTllZk0vdk5GVTNU?=
 =?utf-8?B?NjFyYUxLQTczQmJ2R2lrS2Z0ZzY1ZkNJUmYzZEYxU3JnMXlzL3NwN01lVEJl?=
 =?utf-8?B?NU1KdzVzOExPckJ4ZW5abi9PbWQ4OHlXdzdBKy8xbThXNHhDWDBPUGN4SHVM?=
 =?utf-8?B?Vnl4REFLTDEwaHNPcnRNSmh1bFJFdHdkUEh6czBtMGZubG53bnV0K1E0RnBR?=
 =?utf-8?B?Sml6bE0zM1dyb3VWQmhCM0ovUmZ1WXBaMS8vSnM2QUpEdGsrZmY4VzIvYnNE?=
 =?utf-8?B?NHJxRjRURlpsV0N6SVRpb25uWFdZNzZVYkVCRVF5cm1LTCt4YjkwL2VWWjNW?=
 =?utf-8?B?NG0vRU9XQXE2MnpSQk5TNFlZaEIycjA1RnZ0dXc1Sm1WRlVrcFRXOXp6Sysv?=
 =?utf-8?B?N1g3TzZnR2xDMzlBMWhnL21aRlN0MDZMaTBTczFHSVlHMFBTUWxZRWZrOHo3?=
 =?utf-8?B?VHh4WjJ2M1kzeURabk9jK1J2bXAxSlo1Y29Fc1JVV3VqSGNMRGpYOGpjT2pH?=
 =?utf-8?B?NXNURVBOWkhFMVZTdWJBaG9uQU1XOFBNQ1d0NTg4ZDlSZ21TcmpSWDZOb0tw?=
 =?utf-8?B?WnFkZVRsV2tCbVdnZ1NVZkMwVU5sQWt1bWJsMndzdjV1Z0lEdUIvelFaUG1m?=
 =?utf-8?B?K0VhZkJPT2lVVHBQZERaY1JMU0l2V0hIbGl4M29VNVhiMExTYk5HRXg2Nzk0?=
 =?utf-8?B?NWVLM3dNVmQ4OXBTbXVCOEFKb0thRnpkcDM1citzb055b01SMURaQXp5d1Vk?=
 =?utf-8?B?SWExSXF6NzRORk5yRC91Vk9DS29rUnJnOHVEMDFCVi9RWGRlbm9xckNNSW04?=
 =?utf-8?B?ZXRvYnNIcUIyVEhoMjMxZjFIcmM2bmRzdmJhUUpRcm9ZUHdqeFJaY3lsbXVo?=
 =?utf-8?B?UlJHM2xtT05DQ2pEcytlemxHTzVJckxBblFOQTBHVlRJYUppRkszNUQ1Ym54?=
 =?utf-8?B?ZEJPT2R2N3JrQ2RtdmVndnRMcHJvZnJ2UnQxd3FLaUc2VnYvNU5lU3NwbWhp?=
 =?utf-8?B?bERvV2krVUpBRDcyTllScGN4UXdXNFBQbks1MmJqbnlLV1BLZktQMERmZERX?=
 =?utf-8?B?VFZCVEdCaUlzdU1ZTitTOTFrNWt2YVBZaVRPVVM3dzV5Y21FT2hEekZyV1Y0?=
 =?utf-8?B?WnNkRU1xNkN5TFRxNUUwMmpmRXFuNDdicXZscEZRZ0pGWnlBQktEY1Y1Mk1x?=
 =?utf-8?B?aUdVOHk2S0c2VXhpMVRjdlpnMDk0RlJGOXBnRmlIaDA0dERlVGhBQ2FCOW1V?=
 =?utf-8?B?TE9YVHdFRU9wb29Ua2JTdzArQ0lxMUdhUThyenRtaFdaV0V1ckl2azZqR3Bn?=
 =?utf-8?B?MXdMcDkwd3VkVVhsUHRHU3hUeDdYTmhoT1c3QzdjT3hVTVVxeml2UXllbXh2?=
 =?utf-8?B?RXR2Mm5JdktWQXpBdHlRL2llVXcwNUVQd0RJZlNMa3pqZjZRcmZUSkltZzBy?=
 =?utf-8?B?cUVreG14bFNsK2RaNzNkbTd6THZtTVpBUGxvTXRRaVg4dFhWaWdjZEJSbWtN?=
 =?utf-8?B?OE1qRlZVTXVuMTU2UFU4M3NjL05SQ21RdEZWbTFvYVFqT1hhemI0SXkweWdr?=
 =?utf-8?B?UkZyb0phWE9mbGF5czIwdUhlTjhqZFJUaFFQdm5lTjAzbU9pRndoNmVCNnJW?=
 =?utf-8?B?UVg4dlJ3ZVFJdXZLd202cm9kMHIrVlNOOE9kSkl4NENPZXRUVURIcnpENGI4?=
 =?utf-8?B?d3l3UkRhL0V1Zkc0bUpzSFYvdTdXMkV6RTFoWGdRdnF3aVdPbUV1THBHZFVt?=
 =?utf-8?B?aGE1bTJMVmxpNkx5amdHRGc5S24rdXB3SWI4RXkxMG16d1c5SFVsUWFzS0Jp?=
 =?utf-8?Q?5IKEBnm3VjicflsN2dYERpMM5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1239BE94DE2E341A7F1CE2D927692D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xxyLte8P/iG840q2zHLlCnUQaxZeARTTs60QVmRocMLC70VhFqsdvA+o3hsEL1bKyqLo/QgU5mpd1ID8fU2AIjnKoQu0khjvsXrl4rv5EsvoJlnTVfDTaOKNWdeU09UosuGUKpW9cDnUqq7gBxfRMT6tuzMtm837W34NaSZALJXtwgFRyk7BcQC8jXHfDyeQshEzNFdSkcEb/NcMNcpJSillw0VXu65ifIV+pRIJu/IiDjtXSFkgAiHWlJb9r2Qinj4d3lWhe4mXxiReQiLdJBwDuWD7cjzvgnWdWhafuHLbrTIki2JkVXWgelhp+CXiuXAZZYv8AQz2QwnFAGJV9T29hC6OyrZ0FmEWGP0F92wWSnX5bmgh3lI3LAO+bAYSivqvWVUz2aKeDcPBl018vczi6oZBoP9Aeghp2sPgRBbP9WmDAV5H2/dN8jw+mxZYRIXHbC14KA4eBfCmgUBime92dWVQGEvvo1m+geqO+SR80pBFyMcb252odC+ogjliQGeXvq4dLEEwRkCDuOuZhAYnufTr8dWri004yP6a2T9ASc3h2M6jRsCFs/NUfJUfpqY5IKsPq+zv8aNy4lhHJopruIqy2kT/LjrWs7UnNumRXnq8dtjzPtKcXp9FPOi8VtdTch4jhM4OcDb723dkQ3BsbYcIbBuQQpoD4g4F9mkyRlb9jymCQButH3/EXLA9RpM79IUB3YXHa4cKqaL5QiAbJG10pZUT3qyuojtXA7S7MAoK+VdYKg/N5ZJjiBl0ASW+mtks53yY07TFOmmnpCeD7/qrLvnZA7QtlFBB0yncQHYmRoOZxpnajFGB3nJNPFmvXorV2aa+yUBC6Y89fd/W8UvfPULuUXbQEEqZRerGjTMYOrWJgCoPha7Iuo5YDPJ0XaRRiwBdQuUTvGTFFg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3a7e10-e7ea-45c8-c7a5-08db6def8584
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 22:26:10.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDcEONL1KOxOLlV3PUhI7n7UmEyivgVeoFRy/h8VS2d5ZzmK2PeH61+Sd93WTXd4dQmFfiZ/YHRy+bzOVT+QZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
X-Proofpoint-GUID: mso6zyx2ZuhzquLLQIhHt5Pf-BdA2jvH
X-Proofpoint-ORIG-GUID: mso6zyx2ZuhzquLLQIhHt5Pf-BdA2jvH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMTQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEluIHNjZW5h
cmlvcyB3aGVyZSBwdWxsdXAgcmVsaWVzIG9uIHJlc3VtZSAoZ2V0IHN5bmMpIHRvIGluaXRpYWxp
emUNCj4gdGhlIGNvbnRyb2xsZXIgYW5kIHNldCB0aGUgcnVuIHN0b3AgYml0LCB0aGVuIGNvcmVf
aW5pdCBpcyBmb2xsb3dlZCBieQ0KPiBnYWRnZXRfcmVzdW1lIHdoaWNoIHdpbGwgZXZlbnR1YWxs
eSBzZXQgcnVuIHN0b3AgYml0Lg0KPiANCj4gQnV0IGluIGNhc2VzIHdoZXJlIHRoZSBjb3JlX2lu
aXQgZmFpbHMsIHRoZSByZXR1cm4gdmFsdWUgaXMgbm90IHNlbnQNCj4gYmFjayB0byB1ZGMgYXBw
cm9wcmlhdGVseS4gU28gYWNjb3JkaW5nIHRvIFVEQyB0aGUgY29udHJvbGxlciBoYXMNCj4gc3Rh
cnRlZCBidXQgaW4gcmVhbGl0eSB3ZSBuZXZlciBzZXQgdGhlIHJ1biBzdG9wIGJpdC4NCj4gDQo+
IE9uIHN5c3RlbXMgbGlrZSBBbmRyb2lkLCB0aGVyZSBhcmUgdWV2ZW50cyBzZW50IHRvIEhBTCBk
ZXBlbmRpbmcgb24NCj4gd2hldGhlciB0aGUgY29uZmlnZnNfYmluZCAvIGNvbmZpZ2ZzX2Rpc2Nv
bm5lY3Qgd2VyZSBpbnZva2VkLiBJbiB0aGUNCj4gYWJvdmUgbWVudGlvbmVkIHNjbmVuYXJpbywg
aWYgdGhlIGNvcmUgaW5pdCBmYWlscywgdGhlIHJ1biBzdG9wIHdvbid0DQo+IGJlIHNldCBhbmQg
dGhlIGNhYmxlIHBsdWctb3V0IHdvbid0IHJlc3VsdCBpbiBnZW5lcmF0aW9uIG9mIGFueQ0KPiBk
aXNjb25uZWN0IGV2ZW50IGFuZCB1c2Vyc3BhY2Ugd291bGQgbmV2ZXIgZ2V0IGFueSB1ZXZlbnQg
cmVnYXJkaW5nDQo+IGNhYmxlIHBsdWcgb3V0IGFuZCB3ZSBuZXZlciBjYWxsIHB1bGx1cCgwKSBh
Z2Fpbi4gRnVydGhlcm1vcmUgbm9uZSBvZg0KPiB0aGUgbmV4dCBQbHVnLUluL1BsdWctT3V0J3Mg
d291bGQgYmUga25vd24gdG8gY29uZmlnZnMuDQo+IA0KPiBSZXR1cm4gYmFjayB0aGUgYXBwcm9w
cmlhdGUgcmVzdWx0IHRvIFVEQyB0byBsZXQgdGhlIHVzZXJzcGFjZS8NCj4gY29uZmlnZnMga25v
dyB0aGF0IHRoZSBwdWxsdXAgZmFpbGVkIHNvIHRoZXkgY2FuIHRha2UgYXBwcm9wcmlhdGUNCj4g
YWN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlz
a3VyYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwg
NCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNTc4ODA0ZGMyOWNhLi4yN2NiNjcxZTE4ZTMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjc0Nyw3ICsyNzQ3LDkgQEAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4gIAlyZXQg
PSBwbV9ydW50aW1lX2dldF9zeW5jKGR3Yy0+ZGV2KTsNCj4gIAlpZiAoIXJldCB8fCByZXQgPCAw
KSB7DQo+ICAJCXBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gLQkJcmV0dXJuIDA7DQo+ICsJ
CWlmIChyZXQgPCAwKQ0KPiArCQkJcG1fcnVudGltZV9zZXRfc3VzcGVuZGVkKGR3Yy0+ZGV2KTsN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gIAlpZiAoZHdjLT5wdWxsdXBzX2Nvbm5l
Y3RlZCA9PSBpc19vbikgew0KPiAtLSANCj4gMi40MC4wDQo+IA0KDQpBY2tlZC1ieTogVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

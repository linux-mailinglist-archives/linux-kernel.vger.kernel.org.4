Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A36F4C06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjEBVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEBVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:19:29 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6197B10FE;
        Tue,  2 May 2023 14:19:17 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JXNP6024100;
        Tue, 2 May 2023 14:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=K9MqpILK5LH2AISHUuKqyHcrxN97bMH5OitgSX/G0ko=;
 b=aM/dB8LUgEkydXkblIqMU74Rb/udANUhvOqNCIe1VIZJze9a+CWywvtAP/jgfnzHHvQJ
 xdsUygddv4v6bhVk6GhBqYdra/nqA30A701iuGYEme8ol8+p29ns4cnD1Db/egXrwY7U
 gw5reDUsuaHTVWrqDINwEKxMabXok1U0DK3dVl04NREmqvhz8OhZEAFhW2OVhOsygNTW
 jMqCACJ4fwZHsTpGufpU3AdJwy77/0xky1d9sHekwgxx/pYlhZL/b3uiKCI3BXTUyBTm
 0lBzuXr1oiEPSoEVJrLdUa03T8y93ZOiFjFm0wOmx42CnXwWhO9eOC0cJxtDcB/OUE7q 0g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q92g9dchs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683062324; bh=K9MqpILK5LH2AISHUuKqyHcrxN97bMH5OitgSX/G0ko=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=klOAo1f8Kv7iEAuCcReDYGusz4y2stzP4KtQS/B89AEUQBrg7sspsitK/JiKKUD+i
         ZLqtitc1S83YkFVmVud7R/2+/DXZYdSUBgrf8tZglFK/Xk0ctJkk94xFxPNkBDssb4
         1WZY4FcdK8IJW+neR0NRj+9R9WMCa/iLQLXkIQmmnzjtrUjUuCp0lPbSD2chApt7ve
         +TBZFsmdWfjGVfB7RHMbrUAiE6heQzH3QAZfUpA/S5aiZ2WzEdoUaqUp9OO+oFzDZK
         GJx3GZKD8dsCXnH9KUgGaQyEj+N6jxAl+pVEXcSzYMQJJohzE5a2f5fViMEE5q133G
         dfXd8YUEqxnpg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6901C40520;
        Tue,  2 May 2023 21:18:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C097DA006E;
        Tue,  2 May 2023 21:18:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FD8xe1K1;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 306244045C;
        Tue,  2 May 2023 21:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qlujw9NApGfFjedyvD4hV2fst6fhOk2aClioRGYg7qRMIEZybGSSMzgO4FGJ8Tkv3vtspc2BQKjLJWnWlL0LhSqI6z/HquUQeobBY0O8mhYz3SKUQoU1xfsObB0vJInl6x6wpvOz7GO1dnVy6QTWYZghcaXY4TvobaTSR/sezCEHOPY2du2SAmgGdlmT4aZ+pHxZOMztC9Z1hOPdZEW70drKVlrR8DCe4BVJXNv5c+2/aVmE4hOD4gd/wRIs7Bf5b5Rb3uyX+EVB9uDeyxjCP6bQlEQavGA+QASEk7kdiOzCszJieXR3v8kvSnFYBjeEht2lOYjEXgp53varQ/pzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9MqpILK5LH2AISHUuKqyHcrxN97bMH5OitgSX/G0ko=;
 b=feUwLtJqgCGZevKLi64zpn5b7joABy2kGzq8G7n3Cjy7B7SRlaWGRD2PIKw0bNGwu6o5kRB2i1Rax3aaXbqkFznkxetWgTVXzxmtjWeLZPeQy+BjNz1lM/YJbQkkC0F1+Kc+j+fNzVdtISQxCzWw/NbO96m6j89hX1NjFQWmsrz/3KMtmJpB+slbJLVmgbFPY2XDswqC/1r66IR5T20j6Kt+Uehp4m0TE95jvvOMAMSvSOhjaGimhQY2DZoqxzK+M8Zy8TD3yarRa4xPDiHZIXc++4a7qoZQjVWvubP+rDEJeDvzwenGSGRyNxALMb1T5xm5HIrMg6rJq2M2NYPrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9MqpILK5LH2AISHUuKqyHcrxN97bMH5OitgSX/G0ko=;
 b=FD8xe1K1qnATPVi8gU/VLN4GL+HqT+4fNMJ+qGQ9eooxsTgLf07aqzaOWGQjlvjc8AVQpej7O3eUIaB1BkjknYCVidgJXG+p+Gyk6ZVV5erCU+a61iI8rSo8ZAHO2xu3/wq5pci7qh2HhN1+ex0Nli/xTKkN1SfnTIXs3ABl4T4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 21:18:40 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 21:18:40 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "wcheng@codeaurora.org" <wcheng@codeaurora.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] usb: dwc3: gadget: Improve dwc3_gadget_suspend()
 and dwc3_gadget_resume()
Thread-Topic: [PATCH v2 2/2] usb: dwc3: gadget: Improve dwc3_gadget_suspend()
 and dwc3_gadget_resume()
Thread-Index: AQHZfRIz0TVhr/7zVka9jMbwy+SCUK9HfSqA
Date:   Tue, 2 May 2023 21:18:40 +0000
Message-ID: <20230502211835.qj3vbe2cu44t3oqv@synopsys.com>
References: <20230502162133.148821-1-rogerq@kernel.org>
 <20230502162133.148821-3-rogerq@kernel.org>
In-Reply-To: <20230502162133.148821-3-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB9090:EE_
x-ms-office365-filtering-correlation-id: 7dc62e24-a34b-442f-8a6b-08db4b52ccfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOowDLmYukowg7xZJ6wPWu7wykhxVOWvHRPt7+sU75n3gE8UhZ9fafg0h0TCbNSoeWv2X2CxlzAffWV8YHtgpAXvj7HuIrgXgEIrIpvMIlaRKNIoeW0yMdvXvL8antP4xEA1g5/8yge4Tf6W2eUuBUJNJi/E5I9PlV2k6ZVebBon5uJEs5fj8s6CkpTDZZhbkwJppm9ep/WlfCD/t7II+4+J/GLbohquVfD76WM+/CJaGoipR/ZAduL5aq1xXxRsnoQ+qVXnI/NgtQwVgh9DFtoQ4teYw7gp/mSbrc15nfQkstMSJ0RnVMBCrIz4TmjtKgxP6nuREUNH9RmZ7Lqi+FisYfprN7harORvgHf1yGSUe21OSCYo1Dc2JIY13Kuimz/OwGJl2KYu+OdFoEtE6PnGx17RXMSsYW0GunTglgQLowolEIRdlrws8WxPcPxb6jL7wAi+HEcKNrwoclqHFEhS1teILoQqUKnR7kjsfo1L13s0pfG1STgWPQdEAVixQJ1PuVOXbFoZSYq3T7t3NNoPkgJ8EURROFp59icnz6H/IS93T+XaNHsWNkYhWFAj53NlwPIipN0hHU1rQf5qJ9/thK6bhwZ/SilSx5Iz3NUGR44OuEy5YLH0bI/0J3sN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(54906003)(86362001)(478600001)(71200400001)(6486002)(38070700005)(2906002)(8676002)(41300700001)(2616005)(8936002)(316002)(122000001)(38100700002)(83380400001)(6916009)(66476007)(64756008)(66946007)(66446008)(1076003)(4326008)(26005)(6512007)(6506007)(66556008)(5660300002)(76116006)(36756003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZTUHB4SXpVbktRMlJTNy8rSDlaZDJ5THpWZzdhVTMvUkd3SzU5ZTU0MWJw?=
 =?utf-8?B?KzRRY3pEdUVvckZhSmVkdG41ejJOYTNqcGhTWkNXMkhxUjAyRlpEaFVpZEta?=
 =?utf-8?B?YXh0ZFU5OGpFUHRVY21rdEdFSDVydDBXOGZBWmJsbnozd05Pdk4vK2Z5MmhS?=
 =?utf-8?B?OTRNT3pOR2FSblJFZTM0SjRmN3ZxbTF5YjFaZFpBclNZM1o4Y1JYQUMyLzRD?=
 =?utf-8?B?QmdhZ2FRUEMvUS9POFBnVWhoK0kvUEV1OXk2TUs0THhlZERUaHY5NjdFTGl0?=
 =?utf-8?B?ejFnL0pjQXA3aGc3WnZ2cms0RzFoMEpVZ3BzZzJOaklKdlA3VzRnOC9wL2Ra?=
 =?utf-8?B?UndtTWdqTGlhVnJrNzdadDF3TEpKT0VCT2djQm9xNE1FOWNkRHFLaHg0T21O?=
 =?utf-8?B?cE5DaVBjZC9Wc21mSnZqWTJLNnNrTDlhUThQNHZnN0hLaXpUdHpHZ1UrcjBm?=
 =?utf-8?B?UUtyay9nenByQWtQekU4bTR3YTdxUy9seGlCdHlsdmM1YUpFVlBKZ010ajQ0?=
 =?utf-8?B?dXZrL3hpaFU5bXVlSWkwRk5MVkI1TEdZY2VqdW4zZE51bExBUFl5N0tFcXV1?=
 =?utf-8?B?WjhyMEtIOW4yQ3AyMm5yaG9XZXRRUHFCaUtQM3piUVZjVER6ZnowcU42ZFVw?=
 =?utf-8?B?ZzB5aDU4ejBnaDVHQUNLWUU5UmtwbE5reTJrVkgyTEZqQU5IdmlVek50NkEz?=
 =?utf-8?B?Rlo3LzZUS0NuRmZrcXg4L2Q3YU1DWjNnQTdRbk1LV3d5NDgrNHdhcVpSdnAx?=
 =?utf-8?B?MkcvbFBzdFJjK0kyYzVEdDRCaStMYkVLaEFaR1FFK3NQeWZjc3N3RWMwM0Zr?=
 =?utf-8?B?RDNCeXNic1UzR2YrQ2lQdDVPcDQ1TXNNMmdFcTFiRkVaNmVxMEU4S0JZTms5?=
 =?utf-8?B?VktQYlNnN0NwOHVYOFpnbWgxWEFaREU0Z1hZL2RpZnp1aHAvUWRiSjhtMVVs?=
 =?utf-8?B?eWVSTlkxK1VTZENLRHU3Q2NMOGt1a0w5aThsYXhCTjZkM3V1eVR6Qkc2V29B?=
 =?utf-8?B?VHA2WUhvbUU5Zm9XQzUxTTRrb1hVZnc2eFA2RXdVZkhIR0U4UnR3RTlRU3JD?=
 =?utf-8?B?S2pucnlZWUpxbkpHRUJENmVGS0hiR1AxdndlT1dqYTFqUlNnNkcraXJOV3pV?=
 =?utf-8?B?RFI3cnR4TnN3RS9aQ0tiVXYxRVc2K3VQUjFZc1RVOHRBbnEvSXBtV0pSTHl5?=
 =?utf-8?B?TFc4UG1UcjMzUFNxV3YwQ084MTM2ZmlLZnlCakNxaGFyU2FSVWhLc2hoTFdV?=
 =?utf-8?B?NmJLVUxMUGJTMFhySjNid0RYRDFiWi9SdGFRQXIwMldyNnhsdU1JV2tCUVAx?=
 =?utf-8?B?QlZweXhYWGdMcktsMk1hZWtNaE45TXAzaHFXKzdwUTlBbU96SUViVTdNc1J5?=
 =?utf-8?B?SzNWMm1kQVdIOEcwdXBqQmZBbjhJNHhKakZzb0htVklPRlMyZVFGdjJLUXcx?=
 =?utf-8?B?bzdITlVvT2d6YldpZnp6Um1GZTYydHk4WEZCQUphYVN4VWRBZDNnY0tqeHg2?=
 =?utf-8?B?c0ErOUcrN2VUTFB0aFRRYWZVSGVuM082QnM2L01ZbzUrRkMzS3RyVHRqTERS?=
 =?utf-8?B?MU5ZUkhtMjhBR1V3KytDblVBTWQwc29vcHFJdUZtTGNRNkM4ZFJDKzFDaVdp?=
 =?utf-8?B?TlpWbmZ2NWc5VDBHaklmOHMzRWpCeVdSWnpoajNWSFhpb3hwaDlHejg3QmZZ?=
 =?utf-8?B?WDEzQTFNVm0xeFc3eFVpVy8vTDZKQ3E1NEtBWVExaDNGNHVsMFVzWU56VDdB?=
 =?utf-8?B?VFo1Ri92c3BSSlZaMjhIT1JFVEJISldSMzN2MXRvWjJTS2FBWEFQOVIyeGNv?=
 =?utf-8?B?U3IzRm83VFRTaG9CN1E4TC81aGpVbjl6TkhJbGpFZmlXbkk4KzJvL3ZQSllN?=
 =?utf-8?B?cnluQU5xNjFQYUV0cnBoMFdVb1pFYXNrelhnWkNNWSs4Y0c4TzdLNjB0dlVO?=
 =?utf-8?B?ZDRmVWRuZU03NDcwcFgrMmV1VFRjWmxvOWpiU2V4WXo5SjhLVUFCYUFBT0pp?=
 =?utf-8?B?enFaMmZuaThQeEJQVFdaRjUyNnpRZmNuOWorejcwQTFrSmxkS2sza1BmeWJm?=
 =?utf-8?B?Z1dpelhkdGUvNUFQeXlqalhYUC9nQ1Q4VnhXT3dVYlBPZmN0djRIT0xHNVUr?=
 =?utf-8?Q?t5LfafHxdtHihd02awf7wZZzg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07AFE102B7D6084EA8AD57A8D0477050@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZG9YOHNRdEFmU2oxaVpmMlBxRTVTYWczR0RHajdBUzh6YTkra1kybkxqQUVH?=
 =?utf-8?B?bWhPOUh1OVFsQkMybFFFQ0xGSWlocFNEZHFrbGdTdmRRWkc1bnluMnIwcjZU?=
 =?utf-8?B?elJQZFFRZVRmYmo3WGE4UTU5SE8wNVFPZ3J5ZHVFb3BlaGNiN1BtOVpWK3pK?=
 =?utf-8?B?OGc4NzlYQytnaWJZMGwxS3FxQ0NPNTNlWElnUFhjOVQ2SEw1b3Rta2JpcEtR?=
 =?utf-8?B?cVB6NDBod0E5U2kzWm1qQzBNdE1xcFpac1oyZW54L0V5RDRkWE5ybEdUejBx?=
 =?utf-8?B?d0pSRUlvY1lXVTRwUzYxTUMyd3J3blkxQVJSSHdXQ2g1UHplc1l5UUZOUVF6?=
 =?utf-8?B?UHRKOWsvejZBTnhBRE1FNXhDMkdNMTlWb25aRHVEVEZodks1ZnZuWTNGNnlE?=
 =?utf-8?B?akVZbk1zV3BGbXJQRC9HLzFWdUpxTk05SmxNZ25VK0NKN2J1L3lxWXNPbXJD?=
 =?utf-8?B?RFFCZk8yeGdBNk9LVTdHN1dvK1Erb2lTcVdRMWkxcHBzRU1SdjNEZW9aQlUv?=
 =?utf-8?B?c2RBOHdiWHYzeUd6UjFqRUZGZTRrSVVkc3pvR1pYR0lBK2dpdCthNktGRlNu?=
 =?utf-8?B?cjBSeEVLTVg3eWEyRjdsQ2Q5ejZucTl5czVncXdIWWw2OGZDb09qSmtIUTd1?=
 =?utf-8?B?bHZqUzNOY0NERWRVNk5nUlR2bVl4Vm8rVnE0VytuLzhFWlFTOVU5VTB4N0I5?=
 =?utf-8?B?UWhRbUtzOTRvN2ZNY25Hc1Y4Q0RlaHlzS0t4VlpCSHM5Nmx2OWJSbWJnMmVq?=
 =?utf-8?B?UTY3NzVJZFVNU20wZFN6aEpPQ1luaVA1emp3NzRPdExQUSs0MGQ1VTdtREI5?=
 =?utf-8?B?UTIrV0R1dUJrMHZLTWFGbnFDWmVhV1grOEZ1bWgwRHB2V0ZJN0g0dURvZVRn?=
 =?utf-8?B?UGpnYU5UUEs2MnNqQ2ZCaDVWemx4RGdsOE1ENTdBQmNWZ01lSU5GZzZabThi?=
 =?utf-8?B?eEtidzM1dlBQUnQrNVk3bDdMOEZyM0lIZzdPczI5S1BrQ3NKemMxeUxnZXNC?=
 =?utf-8?B?UG5nU1hjV28vaUs5VGxLVlN0U0NzdXhrclN0OWFsN0pyT3dqUEdXWjhRM3FU?=
 =?utf-8?B?N2hTQUFGZ1dPV3NldEJlbkJMYmhBMHNKekZOTjliL1JPUVlXRVBUVXJneENO?=
 =?utf-8?B?Mk5xSW83WEN0NzY3blVBcmpTdGJQZno1WDYvRFdaYzY2NitxdDJGd1NCQzY5?=
 =?utf-8?B?T2I3NzcyOUdqQTRTdDZ6ZW11OXowU2x5QTRzc0RCMkdhNHFPVVpENWx5dXcv?=
 =?utf-8?Q?Tt2oKgNDNmjdale?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc62e24-a34b-442f-8a6b-08db4b52ccfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 21:18:40.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EQjqH8/OesI8wGXjiLIqsr8toIUfiZPRog5+2Zo7f+vfNY3hTLb1f1XkSLmr2XIJ0e3B50qX0lx3/EB+elCcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
X-Proofpoint-GUID: zY0u3ClxIinPHMbLH7VIWGHXBH9I3zxp
X-Proofpoint-ORIG-GUID: zY0u3ClxIinPHMbLH7VIWGHXBH9I3zxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=955 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMDIsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IFByZXZlbnQgLUVU
SU1FRE9VVCBlcnJvciBvbiAuc3VzcGVuZCgpLg0KPiBlLmcuIElmIGdhZGdldCBkcml2ZXIgaXMg
bG9hZGVkIGFuZCB3ZSBhcmUgY29ubmVjdGVkIHRvIGEgVVNCIGhvc3QsDQo+IGFsbCB0cmFuc2Zl
cnMgbXVzdCBiZSBzdG9wcGVkIGJlZm9yZSBzdG9wcGluZyB0aGUgY29udHJvbGxlciBlbHNlDQo+
IHdlIHdpbGwgbm90IGdldCBhIGNsZWFuIHN0b3AgaS5lLiBkd2MzX2dhZGdldF9ydW5fc3RvcCgp
IHdpbGwgdGFrZQ0KPiBzZXZlcmFsIHNlY29uZHMgdG8gY29tcGxldGUgYW5kIHdpbGwgcmV0dXJu
IC1FVElNRURPVVQuDQo+IA0KPiBIYW5kbGUgZXJyb3IgY2FzZXMgcHJvcGVybHkgaW4gZHdjM19n
YWRnZXRfc3VzcGVuZCgpLg0KPiBTaW1wbGlmeSBkd2MzX2dhZGdldF9yZXN1bWUoKSBieSB1c2lu
ZyB0aGUgaW50cm9kdWNlZCBoZWxwZXIgZnVuY3Rpb24uDQo+IA0KPiBGaXhlczogOWY4YTY3YjY1
YTQ5ICgidXNiOiBkd2MzOiBnYWRnZXQ6IGZpeCBnYWRnZXQgc3VzcGVuZC9yZXN1bWUiKQ0KPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWdnZXN0ZWQtYnk6IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJv
cyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDY2ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+IGluZGV4IGI1MTcwMzc0Y2QxOC4uODY5ZjE2OTU1NjVkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gQEAgLTI2OTksNiArMjY5OSwyMSBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRf
ZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICAN
Cj4gK3N0YXRpYyBpbnQgZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KHN0cnVjdCBkd2MzICpkd2Mp
DQo+ICt7DQo+ICsJLyoNCj4gKwkgKiBJbiB0aGUgU3lub3BzeXMgRFdDX3VzYjMxIDEuOTBhIHBy
b2dyYW1taW5nIGd1aWRlIHNlY3Rpb24NCj4gKwkgKiA0LjEuOSwgaXQgc3BlY2lmaWVzIHRoYXQg
Zm9yIGEgcmVjb25uZWN0IGFmdGVyIGENCj4gKwkgKiBkZXZpY2UtaW5pdGlhdGVkIGRpc2Nvbm5l
Y3QgcmVxdWlyZXMgYSBjb3JlIHNvZnQgcmVzZXQNCj4gKwkgKiAoRENUTC5DU2Z0UnN0KSBiZWZv
cmUgZW5hYmxpbmcgdGhlIHJ1bi9zdG9wIGJpdC4NCj4gKwkgKi8NCj4gKwlkd2MzX2NvcmVfc29m
dF9yZXNldChkd2MpOw0KPiArDQo+ICsJZHdjM19ldmVudF9idWZmZXJzX3NldHVwKGR3Yyk7DQo+
ICsJX19kd2MzX2dhZGdldF9zdGFydChkd2MpOw0KPiArCXJldHVybiBkd2MzX2dhZGdldF9ydW5f
c3RvcChkd2MsIHRydWUpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3B1
bGx1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGlzX29uKQ0KPiAgew0KPiAgCXN0cnVjdCBk
d2MzCQkqZHdjID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gQEAgLTI3MzcsMjEgKzI3NTIsMTAgQEAg
c3RhdGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBp
c19vbikNCj4gIA0KPiAgCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiAgDQo+
IC0JaWYgKCFpc19vbikgew0KPiArCWlmICghaXNfb24pDQo+ICAJCXJldCA9IGR3YzNfZ2FkZ2V0
X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KPiAtCX0gZWxzZSB7DQo+IC0JCS8qDQo+IC0JCSAqIElu
IHRoZSBTeW5vcHN5cyBEV0NfdXNiMzEgMS45MGEgcHJvZ3JhbW1pbmcgZ3VpZGUgc2VjdGlvbg0K
PiAtCQkgKiA0LjEuOSwgaXQgc3BlY2lmaWVzIHRoYXQgZm9yIGEgcmVjb25uZWN0IGFmdGVyIGEN
Cj4gLQkJICogZGV2aWNlLWluaXRpYXRlZCBkaXNjb25uZWN0IHJlcXVpcmVzIGEgY29yZSBzb2Z0
IHJlc2V0DQo+IC0JCSAqIChEQ1RMLkNTZnRSc3QpIGJlZm9yZSBlbmFibGluZyB0aGUgcnVuL3N0
b3AgYml0Lg0KPiAtCQkgKi8NCj4gLQkJZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gLQ0K
PiAtCQlkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoZHdjKTsNCj4gLQkJX19kd2MzX2dhZGdldF9z
dGFydChkd2MpOw0KPiAtCQlyZXQgPSBkd2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIHRydWUpOw0K
PiAtCX0NCj4gKwllbHNlDQo+ICsJCXJldCA9IGR3YzNfZ2FkZ2V0X3NvZnRfY29ubmVjdChkd2Mp
Ow0KPiAgDQo+ICAJcG1fcnVudGltZV9wdXQoZHdjLT5kZXYpOw0KPiAgDQo+IEBAIC00NjU1LDQy
ICs0NjU5LDM4IEBAIHZvaWQgZHdjM19nYWRnZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
aW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiArCWludCByZXQ7DQo+ICANCj4gIAlpZiAoIWR3Yy0+Z2FkZ2V0
X2RyaXZlciB8fCAhZHdjLT5zb2Z0Y29ubmVjdCkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gLQlk
d2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIGZhbHNlKTsNCj4gKwlyZXQgPSBkd2MzX2dhZGdldF9z
b2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVycjsNCj4gIA0K
PiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIAlkd2MzX2Rpc2Nv
bm5lY3RfZ2FkZ2V0KGR3Yyk7DQo+IC0JX19kd2MzX2dhZGdldF9zdG9wKGR3Yyk7DQo+ICAJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICANCj4gIAlyZXR1cm4g
MDsNCj4gKw0KPiArZXJyOg0KPiArCS8qDQo+ICsJICogQXR0ZW1wdCB0byByZXNldCB0aGUgY29u
dHJvbGxlcidzIHN0YXRlLiBMaWtlbHkgbm8NCj4gKwkgKiBjb21tdW5pY2F0aW9uIGNhbiBiZSBl
c3RhYmxpc2hlZCB1bnRpbCB0aGUgaG9zdA0KPiArCSAqIHBlcmZvcm1zIGEgcG9ydCByZXNldC4N
Cj4gKwkgKi8NCj4gKwlkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsNCj4gKw0KPiArCXJl
dHVybiByZXQ7DQo+ICB9DQo+ICANCj4gIGludCBkd2MzX2dhZGdldF9yZXN1bWUoc3RydWN0IGR3
YzMgKmR3YykNCj4gIHsNCj4gLQlpbnQJCQlyZXQ7DQo+IC0NCj4gIAlpZiAoIWR3Yy0+Z2FkZ2V0
X2RyaXZlciB8fCAhZHdjLT5zb2Z0Y29ubmVjdCkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gLQly
ZXQgPSBfX2R3YzNfZ2FkZ2V0X3N0YXJ0KGR3Yyk7DQo+IC0JaWYgKHJldCA8IDApDQo+IC0JCWdv
dG8gZXJyMDsNCj4gLQ0KPiAtCXJldCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgdHJ1ZSk7
DQo+IC0JaWYgKHJldCA8IDApDQo+IC0JCWdvdG8gZXJyMTsNCj4gLQ0KPiAtCXJldHVybiAwOw0K
PiAtDQo+IC1lcnIxOg0KPiAtCV9fZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KPiAtDQo+IC1lcnIw
Og0KPiAtCXJldHVybiByZXQ7DQo+ICsJcmV0dXJuIGR3YzNfZ2FkZ2V0X3NvZnRfY29ubmVjdChk
d2MpOw0KPiAgfQ0KPiAgDQo+ICB2b2lkIGR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVu
dHMoc3RydWN0IGR3YzMgKmR3YykNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

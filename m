Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229FA6F4BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEBVTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEBVS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:18:58 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3399310EF;
        Tue,  2 May 2023 14:18:57 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342I4qaW021347;
        Tue, 2 May 2023 14:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fJ6WNHK+KFZIEX8tr9xL5ci+DADBDRq0V+J8yh5KuCg=;
 b=UdO598+ezFprBI6PpyhUqHN4bcxgmAtDneWiXrVRPOCeAEndQSQ66MrbH7VR0GA223sA
 WlHfsJF5DQb5iSA+yvcyINz9slIy25uglbKuH5EbZPGJI+NEtvwm/dDQW4ON6RoHiQs4
 3p1GnVDJW9h5OUeQnt2leshDglMEEPzJxRyy+xdJBIexBQnGjc2gOiQ7eEUMIiplWBn1
 KJ3Xod5poHKJOatvLWg2A+x9hDqSn7+GcEkmnd/fNwGzal5qxVTwpYzQQsulb9jxQUL9
 oH3fwKfk7WPwEMGZTwZ63YQ36miMavPMu6llMZKU15Kh1Ulzzjn+3AlHMKOX9WAi6F4y Jg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q928sd91b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:18:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683062287; bh=fJ6WNHK+KFZIEX8tr9xL5ci+DADBDRq0V+J8yh5KuCg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Sca4cwSCM/MfNJ8vUCuJ9PAPVPM3lOynhb89fl9E4QgZbDghjJTt7vnOzt8OGiMp4
         IKaYc9fsTXh6Wi/pUzh15LF6wWTkKm+Ymv8UzEZsYRbEbHT3ey2aPDz93KfS0X+E5m
         QP5NS4+GvbhwD7A1FKnX7DOZzEkueNCzCNdBJ/j/4P4pM8kQHVpEIvDY4wOIQ9RcR8
         PJ/jdAl4/97u9Y6ySeXpnUN05ryEorkQAohGtW+Ip+rxUwAHa6bRGW2xcvCOBMklUh
         Kcyeo3RmiThjv+Rr5nbN1146hkHjFja5rptHAmIBwsJx9eUUg/cdDO7yz/3gCA/9h0
         1Vyw2MOlX2lmQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8385A40520;
        Tue,  2 May 2023 21:18:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E7ABBA0071;
        Tue,  2 May 2023 21:18:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tBTS/OnO;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id CD18240360;
        Tue,  2 May 2023 21:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M07j73qPGCreZ1YJ6LC7qMUFCkQCaTaJ56+cAGYpqzpPeMU9sVEQxf3+nhiDR9PajfVOQQE9AkY3RWiIZzQhxeg3HfVruHDztxaLLcOmeE7hT68z1Cs73YWrtevZgbvBajAWaTT6WHjlUYMpBmS2sKa1K70rD+LZGJ0YTZ+ZMRdUM4txL8WN2wu4xHG8LwKm5jMEc9DHEISJHX6IN3oRpF+V+qgnepKLL/wMKQS0rnwIxgF98RxdboDrxI8d+Q6khO2XFlRz51Uq8zPJJQd8kStt2YcrnwPMtzJQT/uJJtIhhP1L84Sj3VrunQdELFuNRtaXquWaYpza1A7NyKNvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ6WNHK+KFZIEX8tr9xL5ci+DADBDRq0V+J8yh5KuCg=;
 b=oauu4iR2/BrvaD7OyS6T3uVC6ccB8jE1nk/Ma6pye5NZJw4DFv9iMZPj0tzMTL8vyCKwwhPIb0L1qTUJUuVCXD1o/+/bgKiU2kv+oZ7iTEiV17NVx6cpsxmRp11KXGcQSu1zXwJGcI2kL+X77RVNXJpkZNeRFrxRy63+m47D2+gSWRJNosvEfoRocgcm/ZOwhjUWYsPym50KftxUr1YtA0stZiJJBt8pGwET+LgcKK3yo2nYhlRepUBlquB6xeFHVEzVU1HT/R05GZmjIO9j3/sHuxSkny8bwmwFYOj4NhyXVDppaJzjQnPJLIY2o8z2/fnOHkaQ6rSED/qRa7mf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ6WNHK+KFZIEX8tr9xL5ci+DADBDRq0V+J8yh5KuCg=;
 b=tBTS/OnOZGA762vOE8T22QnIcDSd3ny5cchxzKQa6IYRoH4vg5+mhrEmmHQKU+zmMXZmWDjoXYnp36F5k8PmcVEngZeGgrzwY6QEUZUIkRvvAvKbuCke3dSeOxXPFgIH+UdZM7Qbp74YK3fixAbrYpj8rXzESmmBk+qO7k4Mx10=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 21:17:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 21:17:59 +0000
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
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Avoid controller stop in
 .suspend if !softconnect
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Avoid controller stop in
 .suspend if !softconnect
Thread-Index: AQHZfRIyH5ibU6btnkCvRMKjwC7OSK9HfPOA
Date:   Tue, 2 May 2023 21:17:58 +0000
Message-ID: <20230502211749.jbo45lgccs346mjf@synopsys.com>
References: <20230502162133.148821-1-rogerq@kernel.org>
 <20230502162133.148821-2-rogerq@kernel.org>
In-Reply-To: <20230502162133.148821-2-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB4447:EE_
x-ms-office365-filtering-correlation-id: 9acd2f89-52dc-4167-dc39-08db4b52b46e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yApxQBVDyvh2yUXyegwLP3oXk403tKKukVsFglkJ4hZVWhilm1wS78dZ3M72Cvi6CE9SzgsPwRt6EEkVdti6MBdP8Jf32mvGDFKICPKq1ptWxJcIH9f/WIdKYgFLxyNnSpWfzYkWaao19wgJHOfq7c7FQPzTMVpN2KrgLaZzibfKEevSLrRRcqV4zZURQR6JC81Ci0oGYiHqWbL3pAX+u2rB8sSEwnH8cH1TK4bW67XF8ydyQY/UZtPfblk2trpoL30egwxGodnlMon13lU4ZXiKrWoVs3DjHaWBgGziqM9u/mHGLt5JghRnLbToqkTCE35gkQE51+tMtxdw1BilUAOn6eGJQR/k3f3x5MrBiGniC1EahoijsZDWb76YDyrowKhW+AyQXeDXb1G+kleAtcW7+Zpxw+PZ5URNedfakSO0cu7p2e/TDtxPz8Zv9DOuqUlgeSodCr+JayzqhOrkOmAi8JXIRMVzToIajEPOsNRxLFqyWUhKeW0EKSRMLaVsRKqG2nhzDqrKjiI8EZVG+ucGxAaJIL/lXrNnT2JyWFmdrA6VoVIBKUwSEe4V0sEe9N168/3nqdHOSb7wSV9MwkS+72jHhET1dP3SqRkL3Jv28RSg0+l1Tz1BLifnAm2AxmpiY6Hz8TFXCs7W5FiIfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(6506007)(26005)(316002)(1076003)(6512007)(5660300002)(8936002)(15650500001)(8676002)(38070700005)(86362001)(478600001)(186003)(66476007)(2616005)(64756008)(66556008)(76116006)(66446008)(66946007)(122000001)(83380400001)(4326008)(54906003)(41300700001)(36756003)(2906002)(71200400001)(6486002)(38100700002)(6916009)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTdtbHJqRUVSVmo0dDgwclpWa0pnWjRoZFArQ1BYUUN3cjRxQUs4aFFuUWpY?=
 =?utf-8?B?Z1crRTNVekc2Z01iSVowSFJxQStxVGdqdUdxQ0pGUGJxckMreUVzazRhcC84?=
 =?utf-8?B?SUdyQk04RWdJbk4rTEtwazlBZ2dVazkyaStKdnZxZVR2N2pPdUhjNkJQTjNy?=
 =?utf-8?B?VVEyL0hpcXpMSW4waU9rNlhEdmxRdlVPdWpMVzRsV3o3SkFvYVZEZ1hFVXlv?=
 =?utf-8?B?cDR5T3BLTFllaW9ESURyOXZISlI4eWpCYnJpQVZhYVhhYmdSNS9zanBNcGRV?=
 =?utf-8?B?b2djSEgyVzFoaWE5MUdaQUg2NzR1NSs1N1RTdWJkSk5mSDh4MEd0V0V4K254?=
 =?utf-8?B?c3RDOFVPUUpOV0IxczJ0QUJqVzRIc3hRSzJnOU9FVXB4K0xYbnNmT09NTXZQ?=
 =?utf-8?B?SFJXR2YwcHZVV3ZFb1RZNS8yd2E2RTZBTml0VGd4Tk5XOVFQc0dyOFFLVkFJ?=
 =?utf-8?B?WHZ1eTlFWmpyNmd3VVZPbDkwekgrSWlwQjhXcEw5TWpGemt4THg2aUt2RVFE?=
 =?utf-8?B?REtETG1YMmZzMisrM1BwdW0zY0pZUWloQWE2eWRjZ2JOQ3F1UVI2RWdFdGxw?=
 =?utf-8?B?VC9rOGx2NkNDQ2FUVVF3S0x5ZkF0aStGVUY4WmFQSWVwRkVkMHBHcWRwdWJw?=
 =?utf-8?B?ZUJRZEI0QXRMSGpXVDFieXlrcSsweXV5d0hKVWhpbDNNOUdPZjBrc1B5UlNW?=
 =?utf-8?B?dk5FaGU3WTBhbVJiOVZpVThyeXUyTVY3NGxqQ2tXTVQ2NjBISmQvVVpTTDhM?=
 =?utf-8?B?RnZLZitIOXFtSCtidkczWmpjc29qU0x5TUdxNWkzeHlLaUtpLys1dHhEWkRt?=
 =?utf-8?B?YThJVWNjeEptSFZ4aitOa2hyaERaUHZDL0tMWWhSN08vUUd6dXdGVFJSdTFs?=
 =?utf-8?B?dW5MNWV2MmxYakQxMTBHd0s3ckJlaVhKYU04b0ZJbXFpcnZHVC9jRW1BNHNQ?=
 =?utf-8?B?aGFMM3NZMlpQcktIMjdSSmtkNURReDZEM3NhU2oya0Y0TTJKQ1NOQ2dpT1dT?=
 =?utf-8?B?OXRkN2NTeWc3K2lxOTQrVlljekRWbEhFa0c3REhlbHpHbFM5Qms5UmR1TFky?=
 =?utf-8?B?azBkeUFHS3g0WWc5VFVaMGhMK2tybXUvbmVBeWVYNHhhZlYralNSc2VMdDhY?=
 =?utf-8?B?SUdvWEl1Sk1xeks4MnhVNW1xWFpyT21ZdnV3RE9RM293dkZSeFExUHpXR01V?=
 =?utf-8?B?anFYVDJwOEtUck8wbUNnZlJ1MC8xSFRKbFNOcFhzOWsremJ2RkttWnFUZlBV?=
 =?utf-8?B?TG55Wkx4aHgrR3phR1BCQ2drS1BZMEtXSFdybmdKbll5M1V1K1FhTlZvaGt6?=
 =?utf-8?B?TXRLUS9JaWNJME0wNWdKYTZ3OHF6NzJGNmFlTUlaS21lTHczREZDZzFEcDZp?=
 =?utf-8?B?cFh3RVpxN2czNUt2OExVSGdMeE5IdDdvWEY1L2NjT2hLOExGY3lrejF2S1NY?=
 =?utf-8?B?RVBFVUR5TlBhUHZnMWFLS2xJa3hMcjZnK0ZsY3hxZWdkRWVOdDYzV1RlQzVC?=
 =?utf-8?B?eW0wMm54MForTW5WdFJtV3BDZ2hram9MU1dic01OZGdFNk1SS0dHS2ROOTFo?=
 =?utf-8?B?V1c5anVJcU9wOHpjc1NoMm5vY1VHMWljWnFBc2ZBWEdxc1VlWE1IeGJBUVM4?=
 =?utf-8?B?QmZKamx4MWZrWVBDekhJRW4vZ1ZKaFdjUkZ4eUc2QUJMSVE0dnVCSHNGekNv?=
 =?utf-8?B?anZrUWIzbThaWkVJM294RlBiMmRjMU9QaDdmS3B2QjF1Q2VsSmVHTEF4cm1C?=
 =?utf-8?B?c1hHMUY3dGUydTRYS3ppVTE1cUlwV0IrcDBhUGRYb2M0akNld3NWcVlUOHM2?=
 =?utf-8?B?Y3VkSlBheWQ3SGV3T01oYTF2OXlaVVlTUDNFdnllNW9COGJ5eVhQK1FZTlha?=
 =?utf-8?B?NUVqUVhzbnhpZHRWK2FtbmFNSDRnZ2o5ZTdwb3hZdklkWU5ZRWVKa3FQRjJC?=
 =?utf-8?B?UlQ3TzVMU3owaUdnWm5Ed1o1YWs5RTFDRVFVempPdXJ0SDhPYVFIU3ErTWlI?=
 =?utf-8?B?ZE1HcG1LazEzY0pEWGFlUzROL1k1Y0p6S3FOVWNvWkg3YjEwaXJuUmcwaStU?=
 =?utf-8?B?cjdaa0VXTy9Fd3Z1cmMxb1B3dkp2SUlsYzhZSFpRdk1yRStUb0dMU1ovRjJ3?=
 =?utf-8?Q?rgpsv0lKLk1EWrBOmyLlujrK/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47C3E4A2FAF50F48AAAD63801E7A6E14@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L2VKaEhDUW9COGhxN3lZWGJpdDV3eVdORTduQ3JFeG1DR3RhcEJaNVVnZXVY?=
 =?utf-8?B?VjI5VEpVVi9MaXVYSnpENmk0Uy83ZmpIaDhrR2lmNld0bFVSenVYM2t3K3pS?=
 =?utf-8?B?TjV3OVlpUzNoNVZpLzlnektIN2x1bFRwTCtOLzFXSTFidlE0aHBtS2l4QjE2?=
 =?utf-8?B?YitQSWFIZHoxZ29sVXp0bTh5bGNzS3ZROWE0d0E4Vzd3TEI0QjZKYzR2VThP?=
 =?utf-8?B?RkZxTGpYbkMwaHFycmN4cEYzdnhJN0FwMnQ5b0h1ZkZJVFlTd1dhT2s0azVz?=
 =?utf-8?B?UTdBcXRvOXNLSmVxUmlmQm1xMmZ2T3VDWjZVWm84d2lKcnU3bnpqWE9BZHpH?=
 =?utf-8?B?RUp4MzYydEhQOGE1Q0k5THUxQlZNOGhhMVN3ZkgzVjZVeGVqSUd3Y1MyN1R5?=
 =?utf-8?B?aU56Y0VYVmw2Y1BtVURRMDRrY3RMQmt1WUUxYmdTY21BSTlvQnZLVXd5cTFL?=
 =?utf-8?B?ZHBxbk9peDdFVHJKemdqWm1Wait4YXJsUStQVzByZW9EY09rK3RzRFBWQWdr?=
 =?utf-8?B?YkNjeWxGb0p5ZW1kUlRxcWU0Sk93NWhDcXNKeUVpcGFoTXA5czFrUU4vUGRW?=
 =?utf-8?B?bGNjZXZVR1RRUUpDUjlLUU5OTjdOd1llU21WODdHSjZWVmFnSC9YeTJmZVpP?=
 =?utf-8?B?V3p6YWZIZjVDekdzK1djU2l6YkFIUWpJaFNHTlYxNEdsQWNpciszeFRsYng4?=
 =?utf-8?B?Mi9GSE1iQ3hmTWI5WkNFeW9BUzI5MDExR2tZWGFWcDhkMUJZdmVNcjZuYzAw?=
 =?utf-8?B?Zng2OVlyWkdZdWRSVk1xZ3A2UjRSNUVTa1BEZmM0NzFjWnV4RnlXYS9kSW1z?=
 =?utf-8?B?Y1hiUGs2bU9KRmo4OWVWR3RHbGNWWmtIOFQ3enB5RmVpK2NMSVpucUF6YVZa?=
 =?utf-8?B?ZWI3b28vKys4QThHTjhaenYwNzkxNUFDMGdMbkxaeXZRSmVKN0xRb25MeDc2?=
 =?utf-8?B?d3lQenhlMnVyTTBiUmhNYURpY2xZVE1PNkxaZTYzdXArWlhVc2ZCTFgvSnhw?=
 =?utf-8?B?cG9pNDlBVFQyTGJEOENZaERxV205Wlp1by9zWnYzK0NGdU9IbG5FRXdFYTQz?=
 =?utf-8?B?RjJxMVEycDZYQitkZUlWRndlN3o2K2p0MzYxR2U4WndURnlVREYvQzJGNHlC?=
 =?utf-8?B?TmRlNzMzTUp0WXdFR0x1ZDVZbnl5eGZXVC9rbGNFWk8vMys4UkRpZHJEcDRB?=
 =?utf-8?B?cE14U2p2ejJXVE44eVZsWm5yWDREd2NtWlJONkpWSkFWd0dTaE1xZHIyeFQ4?=
 =?utf-8?Q?23w9fcF/IWjNNSu?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acd2f89-52dc-4167-dc39-08db4b52b46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 21:17:58.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hljS3ki3bB10EbH6UeQjE5P7NBuNFyPwbFgfWJYWMcBohVjHWofAqEC0y4wHEvsgncXH/dsE1qHNS+vn4RvdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Proofpoint-GUID: Pnc--VzZJS0ctIsNWvliS8Hse0_mQRey
X-Proofpoint-ORIG-GUID: Pnc--VzZJS0ctIsNWvliS8Hse0_mQRey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=378 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305020181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMDIsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IElmIHNvZnRjb25u
ZWN0IGlzIG5vdCBzZXQgaXQgbWVhbnMgdGhlIGNvbnRyb2xsZXIgaGFzIG5vdCBzdGFydGVkLA0K
PiBzbyBubyBwb2ludCBpbiBzdG9wcGluZyBpdCBpbiBkd2MzX2dhZGdldF9zdXNwZW5kKCkNCj4g
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNS4xNg0KPiBGaXhlczogODIxN2YwN2E1
MDIzICgidXNiOiBkd2MzOiBnYWRnZXQ6IEF2b2lkIHN0YXJ0aW5nIERXQzMgZ2FkZ2V0IGR1cmlu
ZyBVREMgdW5iaW5kIikNCg0KSWYgdGhlIHJlYXNvbiBmb3IgdGhpcyBwYXRjaCBpcyBhcyBtZW50
aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB0aGVuDQpJIGRvbid0IHRoaW5rIHRoaXMgaXMg
YSBmaXggcGF0Y2ggdGhhdCBuZWVkcyB0byBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZS4NClRoZSBy
ZWFzb24gd2h5IHdlIG5lZWRlZCB0byBjaGVjayBib3RoIGR3Yy0+Z2FkZ2V0X2RyaXZlciBhbmQN
CmR3Yy0+c29mdGNvbm5lY3QgaXMgYmVjYXVzZSBvZiBhIHBvdGVudGlhbCByYWNlIGJldHdlZW4g
cmVzdW1lIGFuZA0KdW5iaW5kLiBXb3VsZCB0aGVyZSBiZSBhIHNpbWlsYXIgY2FzZSBpbiBkd2Nf
Z2FkZ2V0X3N1c3BlbmQgd2hlcmUgYQ0KcG90ZW50aWFsIHJhY2UgbWF5IG9jY3VyPyBJZiBub3Qs
IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQpUaGluaA0KDQo+
IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBj
MGNhNGQxMmY5NWQuLmI1MTcwMzc0Y2QxOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC00NjU2
LDcgKzQ2NTYsNyBAQCBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICANCj4gLQlpZiAoIWR3Yy0+Z2FkZ2V0
X2RyaXZlcikNCj4gKwlpZiAoIWR3Yy0+Z2FkZ2V0X2RyaXZlciB8fCAhZHdjLT5zb2Z0Y29ubmVj
dCkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gIAlkd2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIGZh
bHNlKTsNCj4gLS0gDQo+IDIuMzQuMQ0KPiA=

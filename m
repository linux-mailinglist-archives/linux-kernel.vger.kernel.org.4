Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A106B1221
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCHThr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCHThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:37:41 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF2C082F;
        Wed,  8 Mar 2023 11:37:40 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328JUB6k016190;
        Wed, 8 Mar 2023 11:37:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=uY7DqavqMmfG2kiJ0ttqKDnnDnPIXbifOvj3b76xeew=;
 b=ryw7rddfeqKIIL4i1Ei3iswgSGKNsXzY51NXgQzybPOE8f5H2RzprNvbhXC25s1eHUhD
 vJCdPgJ0gaoZLkQ2uae3U8/gDdW3ASe86i+b7l+ETSpfX4/t4SVfakHWca5zkdcSVDVH
 ESVylzFe8BUajtNHRjR7HtXImH1GFLE3QZTwk9jRHs2sbPMg6SPS+0xh27+nHnPkHrXQ
 a7hpidYTMd6PmxGhaY/rE48FrILQWhfS86hbCaHQskBgBYhMwE1n/0sMvvIibJl118L1
 RLwPXHx2tcIGOMnrsd8nVqoqF62UmocarKrbbFPIVrOflcWxcluN/D6g8S1/jdnCGeDW Hg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3p6fk4hq9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 11:37:37 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1474C05AF;
        Wed,  8 Mar 2023 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678304257; bh=uY7DqavqMmfG2kiJ0ttqKDnnDnPIXbifOvj3b76xeew=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=V0MgOqxZTovbtk7DHPOfzBLLti0KpQk5HCN9D2JjSkFILk+6Gqb4k+X14l85E9EkF
         xyQmrq9xcuuv7/AvDnzIFdckQiHSDkaxBhP9Vv2ti8mQdnbrAtK5twGNGQxLAClx7E
         QsDkNUoUBBOLqdPnefP/vbleZu7NYIyDhr2DFR10beKYgVbirZE1M+0IjZVSjHVodN
         9GBBxeB3pAPVO3gNq6IdT2tjg4a46GAzo9XMIeTCmADaWb6+SaFY6KmkcFn2oxiuiC
         lUHXu52lk5yQkMoYns2J/9ggQ1hsJaWEy5Kjta6gv9ivKeyZt3JAinnhw0O3NWEYGe
         7f1DmrdKlx+DA==
Received: from o365relay-in.synopsys.com (us03-o365relay7.synopsys.com [10.4.161.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 974D0A005C;
        Wed,  8 Mar 2023 19:37:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 583FCA0063;
        Wed,  8 Mar 2023 19:37:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VZURsamF";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6pCRHmSFDTDg5ub00di1o5iXQIjbs59drsFKYK8qyZ8nhd3bIP1fYlWGEdQTp5VPrYBTglfHGAkpsL/HUE+ZDV686tK2qvfvqbiCCdOIx38YguMBdTOl5dlWl7V1hFhNH0yjgn2oJPPCaq0/Ceg7ufhjVLvobcdI7WX08hyz8X1OuYoWTzy+yxqejfQv02uTMq14BaJkjkie1+Vehx/++sUbXWzVp8J3o1L1R58BRyYLuoV1SamBsdpXfYVQ+TT0qGoIMMykT+ohs1IMWWLgP/sBYMXoIFl36oKrpgrpp5JBN6x5KIc8iPlxxp01r8dvczCQhAtgSKH8z2aupFB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY7DqavqMmfG2kiJ0ttqKDnnDnPIXbifOvj3b76xeew=;
 b=JTSjfE8fpuv7mAGU5BjUpCRGqbF4odfzFJ005lV9HCIz0mMjUnf9SSmWPhB/IrD2K6RYygQRzwJLga0zr6zBY/SUFo8s5MZ8NUqH4akJEWCMhdsLg6kLlhZTrNfLFnQwkAaSEfWSX7ittqP2JFnR2TI1A0rKnqQ/fPY4cvmHMNW+B+4iDUvrhr+MD52aC+kpcKdtWqnyR7qeCU8kHVUF2bJ6ODSAHPcLgpZDeH7Pb1ufzrvmH9mjlwcJSAriCDgtGc7kYd0RmczAI2GozShA2qh6GMDmktcBmp+XWVWOlC6mFb+N1y6179lM0Iq4NLqMJd+Rc4HQqUFGoZK4VMBXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY7DqavqMmfG2kiJ0ttqKDnnDnPIXbifOvj3b76xeew=;
 b=VZURsamFHlYEA8KR970mo+g/yGhbAIqU/JHw5uWPfm3yF3Jtjjl4t9fUhi+qNcS3dpPAHP4WhdIZEv5CFVfynt7bYByrLZHycsnBL5wQOtG+OO2EgYsqd87my/yLzvxLyNr1n6ZOxcnnuL7yKnCkVQLJffaBhi6yxy9f7xVx99c=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:37:32 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 19:37:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v5] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Topic: [PATCH v5] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Index: AQHZUGccWEgGvlL9Zkql8koD9m4y8a7xSgWA
Date:   Wed, 8 Mar 2023 19:37:32 +0000
Message-ID: <20230308193727.lu42pbidrzwu2l25@synopsys.com>
References: <20230306200557.29387-1-quic_wcheng@quicinc.com>
In-Reply-To: <20230306200557.29387-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB4575:EE_
x-ms-office365-filtering-correlation-id: 301c9326-3167-402c-cf70-08db200c8f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdT8ZVHCjM66rnzCPs9DIQoI40u3HmBLmkas0ybNJ6IAhI6bkh03IfRwx2Bxs5X9EqAZj9NoHPADBIz4FykZeu2xgtk8NVAU2ijv01Sx++EPtC3EPR4ZRygOt4hs7aw+dh9Q0rLS9NuL0BytxTHsT8HQOAgoBKvarySWx0FWmJ9XesQmwpa1w+NBhBS3heMBsJp3HK7NDlUq2Y8Lh8t2CGCv4QCjlWl0Mh3NS9CZ/bLtA8yKUHWvqwdji7/2fNzSQSzfVC61giO0XCwF4OIbADAq2hFGKWM0M8Zwr59lJG+kFbPICooOIXw5J4ly1nNcFWpMh1NRNrjV9OFkZpC0PFUvc/IMwrRlXZRwvcuoNyJBGxNxhwW9MOfBLLkwchj2bMk5QPtu2JdfzEegJf7hwU/97vApTB50FUkeSpplAX+3AZ04UckwlN4gpA5RxZsbGNjSZQ0IOAAgR7JCIGKCYGah0RVX6UDrChkIrkWaT5ban3+NxOlRv7YUVGkLqUQGI7/cMK7EeMdOC+ZZbC2AIWkXaUSidjKt20urUicnm9kRZsT8GO0iYTJ/Xdr1vv/6YC260UcKPL3zoGKThARvp8Ph5J2KmdPsKYN3MPcHPrKNG7Ad+HVIn1ZCTBETQFCPxuioxjQXBFA4nH7+cgCaKsgqdFJ852s8lGhpvIrKFW+yP8yhzbMRcF+AImHJ5Jc+kptNG3HZSsWlFQ1quUfZCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199018)(6486002)(54906003)(71200400001)(36756003)(4326008)(66556008)(66946007)(66446008)(76116006)(6916009)(64756008)(8676002)(66476007)(8936002)(2906002)(41300700001)(5660300002)(86362001)(122000001)(38100700002)(38070700005)(6512007)(6506007)(1076003)(478600001)(316002)(83380400001)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzY4NDJOZEdpM0NxMDNjaHUza2RldVJWR0F1VERlM2lHME84U0VsS0hjMHlr?=
 =?utf-8?B?Y2hRRzZPblIvRzBGZFo4Q0hFT1dsYzEzeTA5MWxaV2JUOHFSTkZZSEZvVHMr?=
 =?utf-8?B?TnVZTlBzNzI0Vi9TaXFXeG5UUVpJTkVYVWZCeXpnWk9ua3pnbW5qajkyWnBh?=
 =?utf-8?B?QWRiZ2RWcHdzY0NtN3YrYnYvcCtwUlAwb085K0xPRGRBenJDZkpXTDJqR0JF?=
 =?utf-8?B?QTJmeHJ0RjZJRXY5Z0Fwaks4eDc2ajAwRC9SMjkzMmo2WUFWYldoNHByT0Iy?=
 =?utf-8?B?dTJOOUYwaTNFMFZBbkJ4UUFsM3lzVVNCMWVkWkZrMXFDODhEWVFNL0doWXFL?=
 =?utf-8?B?RExoU3hBYXh5OVkxaTFsdXdKRXhlTkJFTTNSTFMwbm5TMUk2bEQvSktGaWU3?=
 =?utf-8?B?OEltbnY5NXRid0xIUDFRZHhkaHdiVmNRS0QrS21UMDNwdGptQVFhek44cGJi?=
 =?utf-8?B?VFVXSTBXVjFKUStuWmYyU2VkZGVmNkRuallOMXFpMFhoM1ZjNkJ2dm1IaGpk?=
 =?utf-8?B?WHZXQVBxRlFyVnBZNFJjaG1NYjhTWEFlY0ZOZ3h3bWFBZUh3eUJqU1hvVUV4?=
 =?utf-8?B?bEYvTnFSV09kNnpFK1oybGttYkxhMzJOa3JrQkJhNFFaNXBjc0NaaGN4ZTJ2?=
 =?utf-8?B?K3U4ZVJ4TUxlNW1kRjNnR05FOWYrdXBidnBlMnA2SUR3VmxSazhqYTI0aVVq?=
 =?utf-8?B?Z0lwTmV5cjMyYU9wM0Q1Q1E4d25sQ25WQWNKaXJ5dVdSd3NaMk8xcXVSOUE1?=
 =?utf-8?B?VXZlUzZnVjIzQUdHekJOQkdMU2dsS2t4cjFqaSt0WmVxV1dLQWtIcnpGQUhT?=
 =?utf-8?B?anlVY1FtS3NtUFJWS0FQU1Y2UFArcVhld1VIeUNlL0ZIWmN2ZHJoWHhVcWRv?=
 =?utf-8?B?Q0dJbitpS3lTMFNpaE1ZOWY0bVNmOTZKeVNzdUlBUHhtdlJJREhSVXBzaCts?=
 =?utf-8?B?ZW1McCs4aHZHbGF5SmZqSFNYNHluMC9sTHBFUGExNEQ4R3NjVUxXbm1vZkoz?=
 =?utf-8?B?TEhiWFhsUGFvUVFUWGphR0RYeEwvUm4vZHZGZWg0eEFFTWVKMTNUOTgzZG12?=
 =?utf-8?B?Q2dmZHlGMGNhaVc4UnByNWJ6cCsxUHkrMllSLzkxM05jYVZ5a1BoVVNuQ1pj?=
 =?utf-8?B?eG8vbTByZ3k5dXI2TVpSa1dWOW52QWNaTi9XSGJiUW9DT285NFBmQUVGNWxN?=
 =?utf-8?B?YjFEUEdhZ3RIaGF2ZkZqa3ArWEQ2NXFFRGtHYk1QeFNrRnB4K1V4cDJZbWto?=
 =?utf-8?B?WWpjZmVaYzdIWUY5K1FZY3RVdFVuckJjVnhnYXVlOXltOW1LYW4reEk3Q2Vr?=
 =?utf-8?B?anFEazB3TStXcGJEaGY4TEt4NnRXUHIzRFBiYi9maEhIQTRLRWxuZEx4SEJS?=
 =?utf-8?B?TlNZbG04SWhGQUZCdnF5ZUV1MnZ4T2tsUmxOa0pFcG9MZlVQWkZYWmxDU2pI?=
 =?utf-8?B?RGRWdWFRelZkU054c1dCV2F5UTlhZUZNYWJEUzY0aCtjVisva1FiaklrVkRI?=
 =?utf-8?B?TnovdUNCUFN6aTJkeXd4RWpLU04yZEJ4dkJjSzJGdFJYL1hpNS8wN0RwcXBS?=
 =?utf-8?B?U3RFSnZuVmQySmpwWGRMMEVTMCs1TDFqUC85c1FYTWsvT1pta2RJSEhoUHZo?=
 =?utf-8?B?OS8wMmtuMmhtazV0bSs2YTBNVHJQV25ZWUlCcXFaTmsrNzhTQTA0RmdzTEp2?=
 =?utf-8?B?YTdiWWNKL25BSklvemtncmxLejlweTg5WCtkSzM0Y2pOdnN2NTFLY2xPdEoz?=
 =?utf-8?B?VzdCSDdnZnV5UUtWUlBpMG40TUgzbEtzcTMyS2xZTjMycW5PUUxkdXFRcHE2?=
 =?utf-8?B?U1h2UG1ac3RuMWVDaTlsRkZ1c3hNRFJwb2ViWnkxLzlGNzRLMWQvblBJN1hP?=
 =?utf-8?B?TDh0V2FsWDhUaUh4MGVLbGdxYjRmYk9yZjNhQkN3MnBxUEp3SDFFS2l1SHd4?=
 =?utf-8?B?d2VJdWhsOWhoV282RzJvZG9SSWd6Szl0YkpUWWdVbUs3QWZjbXgwQVI5VWdC?=
 =?utf-8?B?N3Nubk1BVGlTcHB6dFVqcG50Ym1UNnVxOWlSZW54NkxxSmhsdXRnTnV2TmQ1?=
 =?utf-8?B?NmNLVFVkUDZra3Jzeko0SVBMMlpENDFMaGdodVgvMWN5ODRNTGZmc0RjNnNT?=
 =?utf-8?Q?dIrhSfo9YHPZcF2dM818UnXeh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F080A6B953CFF54FA1B7FB958E75A38B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2a7fJp298JB/6Ffns+AhJQE9fHwGi2oZlcN/4XeBoeFKo877dzIjBZYbW0xN2lQMGYIGBAiQGR7YzUhzAB9IMZ1aIzmzbJw6qzAC3HViX4M2CyxzwrILzt0DpLzYUwkM0j59yHjr1hCGC/PjvZ4U6Fww0mAHZcKlx7RyxV0azKrOr/cP9qMhZtZ24O2tyBzCHnjtRqlIzZhFEoaGT390VTn3bDUDhAg9dm+bplPWJ1TUCzIrwlbUr0eXI67RLmldfEmbFRmlgASj0nTPk16Lz2SODMmuEVCI++b/8p/49qb1J9Ek3Sp8cY8t2wxIAafU4338XzHNgQMeeSyM4drGg22hWllZHunaJ0NmSGZwe1Lij1E/OZsc9lb/Yu63rsEFvqMp1PZsCz06NlZhA14PQmcIgWA1+bZbciMZ3ivBQJfzhuB1TwWm+G5eeaO/26nnF4xItt49py00e25R9xnY0dbsTYD+k9N5CqFOkQT8VjmvrN1w1ET7h/BeqwEC4iPHcTLg92FZeRfw35orLMFw2+9BURKN8kMijxCHckoYkObgYHpAxOa6Pe2Ytz11KsCRj8p/w0I5T+Tol0oi24pj/K0dbYL+Mbs+zSt/7cCCvI60M4sB+j56bfMKAfFUdyquCVnbGYyez0XRsZBT50x5Zlc2DPJRSj6EI0HzZ0kwojfmhIhPSfnHG8O6U+/MWgHvplmQudgZ7L5D+0eiDGwog8wPiScJMZtoI2b6wTgUiUDuVjKMWhNASL8m2ZAjKf40FZmaSrWNvFSI66RSI1gbNnC90s/Cr0OBUZvVZBhapQMk5NMuQ9OPoUpbsFoa8Mk3ujNfX1JUB1rNf16bY8rzybW9cxg7S0h4D+ZLPsWDQ9BtM2W0COOMMwIdhXzbi3Qd
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301c9326-3167-402c-cf70-08db200c8f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 19:37:32.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/ypiyKvlnydHIswz8Ie9FWNXYy51T0kcf8R0Tsdzthvd/Gh0zQN5mTR8/OqjJxHqvi/9m7Ux2zG74U/pIMm5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
X-Proofpoint-ORIG-GUID: fusZhco8PhaZa0Wih1tXUNPm14IOZBoJ
X-Proofpoint-GUID: fusZhco8PhaZa0Wih1tXUNPm14IOZBoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_14,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1015 mlxlogscore=891 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMDYsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gUHJldmlvdXNseSwg
dGhlcmUgd2FzIGEgMTAwdVMgZGVsYXkgaW5zZXJ0ZWQgYWZ0ZXIgaXNzdWluZyBhbiBlbmQgdHJh
bnNmZXINCj4gY29tbWFuZCBmb3Igc3BlY2lmaWMgY29udHJvbGxlciByZXZpc2lvbnMuICBUaGlz
IHdhcyBkdWUgdG8gdGhlIGZhY3QgdGhhdA0KPiB0aGVyZSB3YXMgYSBHVUNUTDIgYml0IGZpZWxk
IHdoaWNoIGVuYWJsZWQgc3luY2hyb25vdXMgY29tcGxldGlvbiBvZiB0aGUNCj4gZW5kIHRyYW5z
ZmVyIGNvbW1hbmQgb25jZSB0aGUgQ01EQUNUIGJpdCB3YXMgY2xlYXJlZCBpbiB0aGUgREVQQ01E
DQo+IHJlZ2lzdGVyLiAgU2luY2UgdGhpcyBiaXQgZG9lcyBub3QgZXhpc3QgZm9yIGFsbCBjb250
cm9sbGVyIHJldmlzaW9ucyBhbmQNCj4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaGVhdmls
eSByZWxpZXMgb24gdXRpemxpbmcgdGhlIEVuZFRyYW5zZmVyDQo+IGNvbW1hbmQgY29tcGxldGlv
biBpbnRlcnJ1cHQsIGFkZCB0aGUgZGVsYXkgYmFjayBpbiBmb3IgdXNlcyB3aGVyZSB0aGUNCj4g
aW50ZXJydXB0IG9uIGNvbXBsZXRpb24gYml0IGlzIG5vdCBzZXQsIGFuZCBpbmNyZWFzZSB0aGUg
ZHVyYXRpb24gdG8gMW1zDQo+IGZvciB0aGUgY29udHJvbGxlciB0byBjb21wbGV0ZSB0aGUgY29t
bWFuZC4NCj4gDQo+IEFuIGlzc3VlIHdhcyBzZWVuIHdoZXJlIHRoZSBVU0IgcmVxdWVzdCBidWZm
ZXIgd2FzIHVubWFwcGVkIHdoaWxlIHRoZSBEV0MzDQo+IGNvbnRyb2xsZXIgd2FzIHN0aWxsIGFj
Y2Vzc2luZyB0aGUgVFJCLiAgSG93ZXZlciwgaXQgd2FzIGNvbmZpcm1lZCB0aGF0IHRoZQ0KPiBl
bmQgdHJhbnNmZXIgY29tbWFuZCB3YXMgc3VjY2Vzc2Z1bGx5IHN1Ym1pdHRlZC4gKG5vIGVuZCB0
cmFuc2ZlciB0aW1lb3V0KQ0KPiBJbiBzaXR1YXRpb25zLCBzdWNoIGFzIGR3YzNfZ2FkZ2V0X3Nv
ZnRfZGlzY29ubmVjdCgpIGFuZA0KPiBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoKSwgdGhlIGR3
YzNfcmVtb3ZlX3JlcXVlc3QoKSBpcyB1dGlsaXplZCwgd2hpY2gNCj4gd2lsbCBpc3N1ZSB0aGUg
ZW5kIHRyYW5zZmVyIGNvbW1hbmQsIGFuZCBmb2xsb3cgdXAgd2l0aA0KPiBkd2MzX2dhZGdldF9n
aXZlYmFjaygpLiAgQXQgbGVhc3QgZm9yIHRoZSBVU0IgZXAgZGlzYWJsZSBwYXRoLCBpdCBpcw0K
PiByZXF1aXJlZCBmb3IgYW55IHBlbmRpbmcgYW5kIHN0YXJ0ZWQgcmVxdWVzdHMgdG8gYmUgY29t
cGxldGVkIGFuZCByZXR1cm5lZA0KPiB0byB0aGUgZnVuY3Rpb24gZHJpdmVyIGluIHRoZSBzYW1l
IGNvbnRleHQgb2YgdGhlIGRpc2FibGUgY2FsbC4gIFdpdGhvdXQNCj4gdGhlIEdVQ1RMMiBiaXQs
IGl0IGlzIG5vdCBlbnN1cmVkIHRoYXQgdGhlIGVuZCB0cmFuc2ZlciBpcyBjb21wbGV0ZWQgYmVm
b3JlDQo+IHRoZSBidWZmZXJzIGFyZSB1bm1hcHBlZC4NCj4gDQo+IEZpeGVzOiBjZjJmOGI2M2Y3
ZjEgKCJ1c2I6IGR3YzM6IGdhZGdldDogUmVtb3ZlIEVORF9UUkFOU0ZFUiBkZWxheSIpDQo+IFNp
Z25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+IC0t
LQ0KPiBDaGFuZ2VzIGluIHY1Og0KPiAtIFVwZGF0ZWQgY29tbWl0IHRleHQgd2l0aCBtb3JlIGRl
dGFpbHMNCj4gLSBBZGRlZCBmaXhlcyB0YWcNCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gVXBk
YXRlZCBEV0MzIHJldmlzaW9uIGNoZWNrIGxvZ2ljIHRvIGxvb2sgZm9yICFEV0MzIGJhc2VkIElQ
IChpZSBEV0MzMiBhbmQNCj4gRFdDMzEgdmFyaWFudHMpDQo+IC0gRml4ZWQgaW5jb3JyZWN0IGRl
bGF5IHJlZmVyZW5jZSBpbiBjb21tZW50cw0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBGaXhl
ZCBzdWJqZWN0IHRpdGxlIGFuZCBtb2RpZmllZCBjb21taXQgdGV4dCB0byByZWZlcmVuY2UgdGhl
IG5ldyAxbXMNCj4gZGVsYXkNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gSW5jcmVhc2UgZGVs
YXkgdmFsdWUgdG8gMW1zDQo+IC0gTWFrZSB0aGlzIGFwcGxpY2FibGUgdG8gRFdDMzIgcmV2aXNp
b25zIGFzIHdlbGwNCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMTQgKysrKysr
KysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDNjNjNmYTk3YTY4MC4uY2Y1YjRmNDljM2Vk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE2OTksNiArMTY5OSw3IEBAIHN0YXRpYyBpbnQg
X19kd2MzX2dhZGdldF9nZXRfZnJhbWUoc3RydWN0IGR3YzMgKmR3YykNCj4gICAqLw0KPiAgc3Rh
dGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwg
Ym9vbCBmb3JjZSwgYm9vbCBpbnRlcnJ1cHQpDQo+ICB7DQo+ICsJc3RydWN0IGR3YzMgKmR3YyA9
IGRlcC0+ZHdjOw0KPiAgCXN0cnVjdCBkd2MzX2dhZGdldF9lcF9jbWRfcGFyYW1zIHBhcmFtczsN
Cj4gIAl1MzIgY21kOw0KPiAgCWludCByZXQ7DQo+IEBAIC0xNzIyLDEwICsxNzIzLDEzIEBAIHN0
YXRpYyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAs
IGJvb2wgZm9yY2UsIGJvb2wgaW50DQo+ICAJV0FSTl9PTl9PTkNFKHJldCk7DQo+ICAJZGVwLT5y
ZXNvdXJjZV9pbmRleCA9IDA7DQo+ICANCj4gLQlpZiAoIWludGVycnVwdCkNCj4gKwlpZiAoIWlu
dGVycnVwdCkgew0KPiArCQlpZiAoIURXQzNfSVBfSVMoRFdDMykgfHwgRFdDM19WRVJfSVNfUFJJ
T1IoRFdDMywgMzEwQSkpDQo+ICsJCQltZGVsYXkoMSk7DQo+ICAJCWRlcC0+ZmxhZ3MgJj0gfkRX
QzNfRVBfVFJBTlNGRVJfU1RBUlRFRDsNCj4gLQllbHNlIGlmICghcmV0KQ0KPiArCX0gZWxzZSBp
ZiAoIXJldCkgew0KPiAgCQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJ
Tkc7DQo+ICsJfQ0KPiAgDQo+ICAJZGVwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9QOw0K
PiAgCXJldHVybiByZXQ7DQo+IEBAIC0zNzc0LDcgKzM3NzgsMTEgQEAgdm9pZCBkd2MzX3N0b3Bf
YWN0aXZlX3RyYW5zZmVyKHN0cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wgZm9yY2UsDQo+ICAJICog
ZW5hYmxlZCwgdGhlIEVuZFRyYW5zZmVyIGNvbW1hbmQgd2lsbCBoYXZlIGNvbXBsZXRlZCB1cG9u
DQo+ICAJICogcmV0dXJuaW5nIGZyb20gdGhpcyBmdW5jdGlvbi4NCj4gIAkgKg0KPiAtCSAqIFRo
aXMgbW9kZSBpcyBOT1QgYXZhaWxhYmxlIG9uIHRoZSBEV0NfdXNiMzEgSVAuDQo+ICsJICogVGhp
cyBtb2RlIGlzIE5PVCBhdmFpbGFibGUgb24gdGhlIERXQ191c2IzMSBJUC4gIEluIHRoaXMNCj4g
KwkgKiBjYXNlLCBpZiB0aGUgSU9DIGJpdCBpcyBub3Qgc2V0LCB0aGVuIGRlbGF5IGJ5IDFtcw0K
PiArCSAqIGFmdGVyIGlzc3VpbmcgdGhlIEVuZFRyYW5zZmVyIGNvbW1hbmQuICBUaGlzIGFsbG93
cyBmb3IgdGhlDQo+ICsJICogY29udHJvbGxlciB0byBoYW5kbGUgdGhlIGNvbW1hbmQgY29tcGxl
dGVseSBiZWZvcmUgRFdDMw0KPiArCSAqIHJlbW92ZSByZXF1ZXN0cyBhdHRlbXB0cyB0byB1bm1h
cCBVU0IgcmVxdWVzdCBidWZmZXJzLg0KPiAgCSAqLw0KPiAgDQo+ICAJX19kd2MzX3N0b3BfYWN0
aXZlX3RyYW5zZmVyKGRlcCwgZm9yY2UsIGludGVycnVwdCk7DQoNCkFja2VkLWJ5OiBUaGluaCBO
Z3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

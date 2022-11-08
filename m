Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CE5621B35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiKHRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiKHRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:54:38 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA9101E6;
        Tue,  8 Nov 2022 09:54:37 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8HjZOo031509;
        Tue, 8 Nov 2022 09:54:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=77NI7OFOAHb7hLvVAn0F8g9658uZRESNQPptf9TS41E=;
 b=fauEcEVUNwNLIOBIphIfyw111rGML33gTQDam0cVeIaFSrWX0tDSo7F+SCom1KneCHyU
 DPrFdMV4mu09UvqkK5+CIXAbOKDMduEDxk1tQ4+bO9UqLUWa8SbaKGn7hHo9KLamjrrb
 udOiU+o/SlgFa8+GbFk2pVj1HpEi6ArlntyyZThyE0RO41rKnh7mKKvtRh0makoyejfl
 y91uy54CV3KZPVKgbL7oQhHHuboPdD6UXjRkH9tS9bqFTcqM4z1TUKwnPVcvlocahAXQ
 Q/7ZNZJz8sRUUQPK2l39ZGLrUB1UH0JiEYUj5jBg/rhUqR5S/WZVOSLqQfJckqnzUdfF tQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3kq0mrs4m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 09:54:25 -0800
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2372A40088;
        Tue,  8 Nov 2022 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1667930065; bh=77NI7OFOAHb7hLvVAn0F8g9658uZRESNQPptf9TS41E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DMa4M2ZZQRuWyT192nuIUB0dlZYFsBCZqNRscIwWIieLjClEPVSJMFdRlhiR/kLgO
         +xJSPAqjn3/ifU2OLius13e9xdUfpiq8/i0P67kdVkk/L78CA+sqZe+ET7DGURD3T4
         +SPVx1sCkj/V7nKPlh6bW0eOPDgDArzGSZcONZ1zOwNC7YqY+LJw2Q6/BYODiZRrXd
         jXTzwPWOuiJhPTnHrM6g5qwJQeoLclD+IfPeIu1w96IsrhHRlO1EK36reUQhjTwtMf
         rQVW3inGihlunQSP54gdHQ8aNHvLi2m6qBY3vObi1Ih1rFHs9gGJLPbHPgXiQAf1n4
         3i6V+d+oyBakA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C1006A005C;
        Tue,  8 Nov 2022 17:54:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D1054400D9;
        Tue,  8 Nov 2022 17:54:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uUoq+o/g";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgfI938vBJ+RlALKAAjUtqMCmbnlVrJ+jLBTFTYf4fKKg8KACHgWvAy7H297mVJolJwtW4aVIyadFLaLnqF/uHbK53/4RxTMc/ntuFTMhhX8w6EQBzF/Zgr/7RjVSx5SxW+0Iefm+vlKp696+a0jCAhrLkmkD46GCPFlHH9G6YfcUUgdeJ/26bo6jNbOXZxGBXtbW1WufhOxa5tv77s01AdAbsS35thD+oWNe3XOk6gCPlT1+J8w5Qo1XzftB+Nx8oaUznLbAthkq/h+9GUvQO+FpIcCVjMx4kTfX6bSUbFFzzbCjVYgPjGrOaqCNPpIl0xd+3fa+XkSIxNtfqWFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77NI7OFOAHb7hLvVAn0F8g9658uZRESNQPptf9TS41E=;
 b=UXY5Lgr794fMBuOxwTL/ROfLFbx/EKj/kAcGL6DpzRoqrJYL+p51gBUWokH65xkYegAqz1uNfDQ+hOqtX5KkSHRt8jPG92e9X2gDIxvGClPui+phGlWyxSbR59E2oIfZ8c+xcakpNPY1cUTinTU+xu7ckpmh26Atf9bE/f0a6nkt5sd1NhAQf4kDiNGETZGyZvy0JvUxENOCzc3imL5VfrBKp8h/MRtaZvAG7o67ap6rzoHQIJOy5Yjmv4w1EHQlQD9J5GqygYAAfC/KZfqidANZgXtnBeVI3iPM1yGf1rJSv0TBx/BWfa/YqSl7f4QhyIgWWQd+p/dmLFaoiythtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77NI7OFOAHb7hLvVAn0F8g9658uZRESNQPptf9TS41E=;
 b=uUoq+o/gyzkRwYjbuw9cQzPR6rrfoynmrnsgIFqsQ9Qsm8DqdW/+JnaSJd6dPjfK49X9gjCMzTvAAL9vEkvOcv9eU3h/xvSuQwyDrDwTa5GFCKq4nE8qpfBRd96Ci+KvymqyqqpUGGQZf+igETjtm1VefMRupcujoCBBDfZ0UVE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Tue, 8 Nov 2022 17:54:18 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f%2]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:54:18 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Janne Grunau <j@jannau.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sven Peter <sven@svenpeter.de>,
        "stable@kernel.org" <stable@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: dwc3: Do not get extcon device when
 usb-role-switch is used
Thread-Topic: [PATCH 1/1] usb: dwc3: Do not get extcon device when
 usb-role-switch is used
Thread-Index: AQHY8il5zxvfmPdHA0KFoMfsB3fuRa40R+MAgADliwCAACR6gA==
Date:   Tue, 8 Nov 2022 17:54:17 +0000
Message-ID: <20221108175415.wzb2oc7lnv3bf62f@synopsys.com>
References: <20221106214804.2814-1-j@jannau.net>
 <20221108020208.y3hrbpaxmzke2lms@synopsys.com> <Y2p5LqRrSfwtLRif@kroah.com>
In-Reply-To: <Y2p5LqRrSfwtLRif@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM8PR12MB5431:EE_
x-ms-office365-filtering-correlation-id: ed443684-39e8-4058-f1cd-08dac1b241f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9uRtyPGui9AVFory23Ix1HZ0UFs193it63Po/PB2NPc9gfbWAQYYXrUagLMyDMG++meUEbMt38cA6IFK0FBAWvul/fOXnhAfO7BcB3sece6/47IN3910csb4iVYDOn8wvQ8h1VEy6zZs50hv9ELFea7OUAETIq5cMJ52Xy03XaKOO76mwVvcSDg5qQXCL4UnNJH2+7DiJXtgwkzbeJT6aYbZdVnBJSGO7acpCDx8+TDq4zSkxCmxuRIy4PdKQlE1n/DFtxJ5cFPOuXpkYtdSRXulXNaz0iVsg+lpKUOHSbWISa+T8ccaTkexaoNHhKfg6oU3J12Qx6acVnkPDZHOHB+/T84VKMXIrv9xau0t5lS5Zwq0R16yYKQhz/NscAKSjLUJHK7wE9yuO6fK8+kD1NP91KgAlE2tMvWTQc9OoDcwdQSNWscPCLL8RrBfpdKqxnL7YdPp45hZxJ9iRMDmhie6EOdu8XtXR91s+/q77EtTV+MepZP69mXf0EDPssOT3J4AAz//HqFGzNQLNfSom2G32KryaxjRJTGI0dIcyzhlBd1HUAbpWysa1J4p0dbFgOIqpgunJEcc2VYFWhDqisxROIhtujNO8qna189pAsmjBHLrSqx3wSGNA4MAd2SbfcNoldxBiQs5L/V05gzGJ/pNJKQaCflx/kco+tpMRNyKW2lD12dnEiQphdKTARWw6hVXrrGBfL/+VbgjxIkVJpfzwA3RM29ZdCYJedKcOO6UB9fafoFYpiXvObbuCpVhbuimtPaQw7AW0g6BnxXIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(6506007)(36756003)(6512007)(83380400001)(2906002)(122000001)(41300700001)(38070700005)(8936002)(38100700002)(1076003)(66446008)(186003)(86362001)(64756008)(8676002)(66476007)(478600001)(26005)(66556008)(4326008)(71200400001)(2616005)(66946007)(316002)(54906003)(6916009)(5660300002)(76116006)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGVlMlgrTGdqQTRualRUblErYzZ4bktNUVhPVHhNYlhxdTFHYmhrRmxoMU5w?=
 =?utf-8?B?bEtwZFdMZnd1dGdPaHNOYktLYWMxcUlPMldybG4vS3dQeGtXUkkyNnU1b0dy?=
 =?utf-8?B?by82NHArbFlRaUJic0hzblVxa1VzcFhDZS9jb3l1QXpjdEt1K0NBcGtWRlUw?=
 =?utf-8?B?SnhjRXg3YjUzTk5YbVZwVHJqVjNCTFZMeThhcEliRERoTFgyOC9oVVdyRnJH?=
 =?utf-8?B?TlBOUHZkUnVDZXhFNUc3RWlvMWFZQXRHRTN5cURDZjJXMFRiRVR6Qk9oUWh5?=
 =?utf-8?B?NDNjSWZyaTJsQ0kzL0RLQUlYc01MS24zZkhhQmt2UlZ5TWxTTkJHU0FURUNE?=
 =?utf-8?B?d1o2OThNaFloNG53SG1TQ0w5SDJwL1NJRk0rWXAxQjRsbnNkbmlmNGtvL0dZ?=
 =?utf-8?B?eSt0VVdHUFNncHpLbHpvcDcwNGNXUTUxWTc4RlNmTlRFQm5CTk1oVE96aW5y?=
 =?utf-8?B?VUdXSEtVRmkzTmtUNDFsS0d5RTBCVjZ0RWlSTi85cjlBN0Vxc21sYWJuaUpG?=
 =?utf-8?B?TjBUVlJNdDY2Y01uRk1pU0F2KzA0cm93Vi9wcnVvRmtoVFJtbnBBNms4N3Nk?=
 =?utf-8?B?ejhJMkkzWmVOcElxNnhOemR2UHFDUHhvdkNudHFQQTFvbkZVNVB6Z2lXSmk5?=
 =?utf-8?B?NG9SUURpSEFCTVRZZloyM29jMWtSRXd1dURXZ3RTbjhZdDU4YnJraFgxT3Y2?=
 =?utf-8?B?aTllQ2FSMXVTRHV4VkpkQlozZUlXc25iSTFRNlBEUTh2d1dML3hlbyt6UjBa?=
 =?utf-8?B?MTVLN3d1aERCUGFTWXAzNjk2eDdSOGRzbUljeHFjVWpjZGlzMGVITFZpN3pN?=
 =?utf-8?B?c00rQTcxOWpnbnViTVlra0IrQnYxT3lzY2ZFVklEUkJlL3F0VW1ibVQyV2ky?=
 =?utf-8?B?VW44N2R2UG54S1Rla3VzNjFiY0lXZG5xTFl1aEQ5N1dtVmRGbmtLR2FhVzU5?=
 =?utf-8?B?Ky9XTTJ3UVY3N2hQTmx5WnI3dmp1VlRoRkJTd1FRQnJwalVxN2V5YjhtdXJU?=
 =?utf-8?B?cFB1eDJoRkRiM0dwRmQxTUNPN2h6MjhiSFl0a1BGZFdlUmczaXBsT3dZeFVo?=
 =?utf-8?B?U2UrQk8vTGxPN05XT1QvaGNxRjdqcFpvbjNORTVpWW5KeTAxMCt0anlMeExq?=
 =?utf-8?B?aE1scGxJME5tTjZPUEMrMmoyajZzd0IwQzJJQVp0Ym5tb0x5cHZnMlRNeG16?=
 =?utf-8?B?Vk5PNjRoRnJjOWRKYmZ5WFI1QlFkQmxSb284Nkt5TG03alVyUU1mbjlYL29r?=
 =?utf-8?B?N2hXUmR5QmQ5d1MrdlpoNHhhUExoTWFmWm82Q3ArUVVGMWVRQURkS29jYXNn?=
 =?utf-8?B?Nmhlb1RTQlQycDNjOTBpUHdhOEIyM2xPV1dERUZHR0hBRXRpZmZCZ0FPcWd2?=
 =?utf-8?B?RmF2RHRMUUtLWVloazYza2ErTm9rczV4UWI0NFhLM2s0dk5vOCtNWlVyL2FY?=
 =?utf-8?B?YjBpa0F2K29BM0wyMnNQSktIRDdmZEMxQnUxZll6M0lzdmZyMEV1WmFRd3pa?=
 =?utf-8?B?enMxbC9FNk9GZkZoUDd1cFg3dTlHVFYxMjVKc0RMUmgrdFE2UGRwSE5YSGJr?=
 =?utf-8?B?SERLeXBiQ2dUOS9sQUt6dmRvbEYvUE9nL3h1bE9yRDJaNUl0UHlnc3Mvbm1K?=
 =?utf-8?B?Y3pkbUdFcGQ5VE90OTI5cWJ1TTdRUXdnRFI0THg1UTZydUJpVVBIb1M5TmMr?=
 =?utf-8?B?cHByNHUydDF6MDNYeHNRTk0wUktjdWVEejduZWFvdmJmVlp1VWxmcElrOTd6?=
 =?utf-8?B?d0hhZVJ2WEtMQ0ljdFc1NC9vUXhMKzFvMFlYMGNRL3duSXpZK2pKS0lJdXBi?=
 =?utf-8?B?VEdDbDFLY2ttR1RMajd1UXNiOEtGK2NydW1mNTRCTWw1NU0wT0tPUVdGamli?=
 =?utf-8?B?Mi9UeXFlQytKYWpBLzRzQUhKMmZvL0xmUFhNbmh2ZE5EU1JPWWU3MjQ0T2NJ?=
 =?utf-8?B?clZkdDI3QmFJN25LNkgrNHdNUlNCVmlYSUkyMDZ1Uzh6VzIxQWI0bU4wSEZo?=
 =?utf-8?B?ZjYzRGVrNmMyU3Y4Rmh1RXVYVkNQZXpRVUdnRm14Qko2SWw0aWYxVE9XL2Mx?=
 =?utf-8?B?SitnZnhZRUxTbFpCb1ltN3V4VTNYRmY4N0tWZnFFMU0vaFN3NEdxblhXZW1C?=
 =?utf-8?Q?0w8fmy5gU0Wazr0+EciW716H4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA427917A6CDFE40B8DEB6DFC91C7382@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed443684-39e8-4058-f1cd-08dac1b241f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 17:54:18.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtAmc2Aic3nq0xi+ONLZRKUT3nCUaHcaasGEZZM3Hyq071XgyEgKFgo8JGjXA4UpHxMapz+2WpvrAGdKt9258g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
X-Proofpoint-ORIG-GUID: T0O-Av5cyMcFZfhlfSXSLlYxNpMM3Tos
X-Proofpoint-GUID: T0O-Av5cyMcFZfhlfSXSLlYxNpMM3Tos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=829 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211080113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBOb3YgMDgsIDIwMjIsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24gVHVl
LCBOb3YgMDgsIDIwMjIgYXQgMDI6MDI6MTlBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+IEhpLA0KPiA+IA0KPiA+IE9uIFN1biwgTm92IDA2LCAyMDIyLCBKYW5uZSBHcnVuYXUgd3Jv
dGU6DQo+ID4gPiBUaGUgY2hhbmdlIGJyZWFrcyBkZXZpY2UgdHJlZSBiYXNlZCBwbGF0Zm9ybXMg
d2l0aCBQSFkgZGV2aWNlIGFuZCB1c2UNCj4gPiA+IHVzYi1yb2xlLXN3aXRjaCBpbnN0ZWFkIG9m
IGFuIGV4dGNvbiBzd2l0Y2guIGV4dGNvbl9maW5kX2VkZXZfYnlfbm9kZSgpDQo+ID4gPiB3aWxs
IHJldHVybiBFUFJPQkVfREVGRVIgaWYgaXQgY2FuIG5vdCBmaW5kIGEgZGV2aWNlIHNvIHByb2Jp
bmcgd2l0aG91dA0KPiA+ID4gYW4gZXh0Y29uIGRldmljZSB3aWxsIGJlIGRlZmVycmVkIGluZGVm
aW5pdGVseS4gRml4IHRoaXMgYnkNCj4gPiA+IGV4cGxpY2l0bHkgY2hlY2tpbmcgZm9yIHVzYi1y
b2xlLXN3aXRjaC4NCj4gPiA+IEF0IGxlYXN0IHRoZSBvdXQtb2YtdHJlZSBVU0IzIHN1cHBvcnQg
b24gQXBwbGUgc2lsaWNvbiBiYXNlZCBwbGF0Zm9ybXMNCj4gPiA+IHVzaW5nIGR3YzMgd2l0aCB0
aXBkIFVTQiBUeXBlLUMgYW5kIFBEIGNvbnRyb2xsZXIgaXMgYWZmZWN0ZWQgYnkgdGhpcw0KPiA+
ID4gaXNzdWUuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBkMTgyYzJlMWJjOTIgKCJ1c2I6IGR3YzM6
IERvbid0IHN3aXRjaCBPVEcgLT4gcGVyaXBoZXJhbCBpZiBleHRjb24gaXMgcHJlc2VudCIpDQo+
ID4gPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphbm5lIEdy
dW5hdSA8akBqYW5uYXUubmV0Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgfCAxMCArKysrKysrKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IGluZGV4IGMwZTdjNzZkYzVjOC4uMWYz
NDhiYzg2N2MyIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiBAQCAtMTcxMCw2ICsxNzEw
LDE2IEBAIHN0YXRpYyBzdHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19nZXRfZXh0Y29uKHN0cnVjdCBk
d2MzICpkd2MpDQo+ID4gPiAgCWlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9zdHJpbmcoZGV2LCAi
bGludXgsZXh0Y29uLW5hbWUiLCAmbmFtZSkgPT0gMCkNCj4gPiA+ICAJCXJldHVybiBleHRjb25f
Z2V0X2V4dGNvbl9kZXYobmFtZSk7DQo+ID4gPiAgDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIENo
ZWNrIGV4cGxpY2l0bHkgaWYgInVzYi1yb2xlLXN3aXRjaCIgaXMgdXNlZCBzaW5jZQ0KPiA+ID4g
KwkgKiBleHRjb25fZmluZF9lZGV2X2J5X25vZGUoKSBjYW4gbm90IGJlIHVzZWQgdG8gY2hlY2sg
dGhlIGFic2VuY2Ugb2YNCj4gPiANCj4gPiBjYW4gbm90IC0+IGNhbid0IG9yIGNhbm5vdA0KPiAN
Cj4gImNhbiBub3QiIGlzIGZpbmUuDQo+IA0KPiA+IA0KPiA+ID4gKwkgKiBhbiBleHRjb24gZGV2
aWNlLiBJbiB0aGUgYWJzZW5jZSBvZiBhbiBkZXZpY2UgaXQgd2lsbCBhbHdheXMgcmV0dXJuDQo+
ID4gDQo+ID4gImEiIGRldmljZSwNCj4gDQo+IE5vdCBhbiBpc3N1ZS4NCj4gDQo+ID4gPiArCSAq
IEVQUk9CRV9ERUZFUi4NCj4gPiA+ICsJICovDQo+ID4gPiArCWlmIChJU19FTkFCTEVEKENPTkZJ
R19VU0JfUk9MRV9TV0lUQ0gpICYmDQo+ID4gPiArCSAgICBkZXZpY2VfcHJvcGVydHlfcmVhZF9i
b29sKGRldiwgInVzYi1yb2xlLXN3aXRjaCIpKQ0KPiA+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4g
PiArDQo+ID4gPiAgCS8qDQo+ID4gPiAgCSAqIFRyeSB0byBnZXQgYW4gZXh0Y29uIGRldmljZSBm
cm9tIHRoZSBVU0IgUEhZIGNvbnRyb2xsZXIncyAicG9ydCINCj4gPiA+ICAJICogbm9kZS4gQ2hl
Y2sgaWYgaXQgaGFzIHRoZSAicG9ydCIgbm9kZSBmaXJzdCwgdG8gYXZvaWQgcHJpbnRpbmcgdGhl
DQo+ID4gPiAtLSANCj4gPiA+IDIuMzcuMw0KPiA+ID4gDQo+ID4gDQo+ID4gTG9va3MgbGlrZSB0
aGUgInBvcnQiIG5vZGUgY2hlY2sgZnJvbSBjODI0YzczYTVlMDggKCJ1c2I6IGR3YzM6IGRyZDoN
Cj4gPiBBdm9pZCBlcnJvciB3aGVuIGV4dGNvbiBpcyBtaXNzaW5nIikgZGlkIG5vdCBhY2NvdW50
IGZvciB0aGlzIHBsYXRmb3JtDQo+ID4gc2V0dXAuDQo+ID4gDQo+ID4gVGhpcyBsb29rcyBmaW5l
IHRvIG1lLiBTaG91bGQgd2UgY2xlYW51cCB0aGUgaW5jb21wbGV0ZSBjaGVjayBhbmQgc3RhbGUN
Cj4gPiBjb21tZW50IHJpZ2h0IGFmdGVyIHRoaXMgdG9vIChhcyBhIHNlcGFyYXRlIHBhdGNoKT8N
Cj4gDQo+IElzIHRoaXMgYSBSZXZpZXdlZC1ieTogPw0KPiANCg0KUGxlYXNlIHBpY2sgdXAgdGhp
cyBmaXguDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5j
b20+DQoNClRoYW5rcywNClRoaW5oDQo=

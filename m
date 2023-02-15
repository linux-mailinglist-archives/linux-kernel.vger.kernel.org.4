Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D91697365
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBOBUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjBOBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:19:58 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2CE8A72;
        Tue, 14 Feb 2023 17:19:35 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ENjFDZ013518;
        Tue, 14 Feb 2023 17:19:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Zla946FlRSLITodrxUqt/lUbKqlaX5scYudmISw3qI8=;
 b=YH+2LI1A71HmtI/f00Ut7fwNTk21sdG24dq6D3NM4zN8+XswIw8S85BSZJFvZCPATL4X
 d7naDQvQLyPAuvWH5FE2ILsxxI9z2Qg6kwPcpa6rEgwMey0k6y12fIALQbMMBzgyqqo2
 HIrva4UlAkBK+CZbnbu2ozuoerfNE92BOAaANtRAg3C3EYI0zUY3HaYHEkZdPaT5h4bg
 a+YlZkyFJf601LVMHMZ9skyrkeOwHsTHnOfUIbMniaLYm1+f5OsTIq5KLX+7WFQ3jqsW
 xTXsAW97QBUmW3y20z42YCF8v9x7vzN/QXwUXWXM0qyMkBi/IxxFURcqYnxHHsWM/5lz jg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3npawu3fe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 17:19:26 -0800
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 07511C00E0;
        Wed, 15 Feb 2023 01:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1676423966; bh=Zla946FlRSLITodrxUqt/lUbKqlaX5scYudmISw3qI8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=jAHlqhXpc48Jx8gdF3MQKu/A4ONqlZx1SejDDNYqgGo5g4OKbXY6Pwwj57zHiqrow
         D07oG5Lb/huytRbo8pY0vsbcTTnnHXlmCQyWFywb1h49VONG8ypX1vr+8gtXJh/IH0
         byRaCsDW4j36ymQVb7mG+XzJTNTQ01LgGr5xHpUvk8ATArA19QRMQTRwPzYQaskKqZ
         MKB+12b4I3vdAZv0S/uDui7EUmNwMo/hes8nf+NSXZEMdSHWsIVUZ24x4nQ1WtWCZl
         dLxKpR4IRoTWCZL+dsZaibuqcnMmFtqYwTlDmfya1r9JB8T1OckUoMsBLeghkp6X0s
         IWT1QXXoJfPog==
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C792DA005C;
        Wed, 15 Feb 2023 01:19:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F3A73A005B;
        Wed, 15 Feb 2023 01:19:24 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="SkaTjfK9";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbRalJy2zinYrqjn5ktlnx4vWxpHAarRTd344bUdRV7ZVGykmtOlgl1o6twuBXFIJDtY3/ex+WsFWdzGsfAet5YJfijaPWdivhdtp59RNW+T3ySUrLUvAxzljB5M6L+BOGOBUQ4YpSXOlU2c6tipqkyuWZItZG7oVpLMfll2JbEu1F0ydVekkFFiXNqT7/aQmVl1QD06wj/DQh7EKrYEmGP/yhYZTtKITxq60u+r8x9CE/Y3NJXIssAl7JD52EZQ2J0Bd9uRva9fKGt2v6S+UaVO5MKbJn2kHmqCrTZgXx9EU9d/UP3nDKr9ASc5doDLzNvyohm15nzegoJR868qMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zla946FlRSLITodrxUqt/lUbKqlaX5scYudmISw3qI8=;
 b=ZG5OR4KNB47TVu2hVRJDJqnzTQC+WRxdqLRIBqUH6MjqXrbf52OrSHEhasGBgGwCAOiQjLVkp6zScAfTirqwJCd77XiJNpsrWH8ET/CtqYwCglUZP+cSGl9yOJ+ss5VwuWOHSabPBxsx5N9fa8wsbuu1QlBgVZKfDjEQFATZf/9J5Yktf6NGhaFuBG6f0r8K9ooewort/aidQ9gRaNlYfjzuCW0pf+NSYWyer4CG0qgmyl9izrP4XWXLdUYeyEZKkGpu2OxX9iq68ydbUsxPYlK9eQxnDUQXXErHmE8nJtddWFWQBAGCcTt7c/pHUOUDg8Y7+RxGvbxUCQIXT8algA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zla946FlRSLITodrxUqt/lUbKqlaX5scYudmISw3qI8=;
 b=SkaTjfK9gGSfbHL+N828jqnX3rl3hpNZ+vjebaLUQNm/Fq0NyagxjU3DFdjlEUArODjzm2pZWpF26mAA3rLIBEN4K5RCfqFoelTywlTYBXM4fUeWYfqyM6IXr4NMEN8Gvcskw61gf+jPOIZ4k6u+ppI5kvqjRCqlUdiRup3Fwok=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 01:19:21 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6086.021; Wed, 15 Feb 2023
 01:19:19 +0000
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
Subject: Re: [PATCH v4 4/5] usb: dwc3: Add function suspend and function
 wakeup support
Thread-Topic: [PATCH v4 4/5] usb: dwc3: Add function suspend and function
 wakeup support
Thread-Index: AQHZP+HGEcb2UfFPdU6qvBws9cLVZ67PN0OA
Date:   Wed, 15 Feb 2023 01:19:19 +0000
Message-ID: <20230215011913.hoidj25fjssrwnj6@synopsys.com>
References: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
 <1676316676-28377-5-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1676316676-28377-5-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB7218:EE_
x-ms-office365-filtering-correlation-id: 586c4757-826a-4679-09e9-08db0ef2a99c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4SSG9UYTraXxAO9QbMfyT1IPpid0yPkhG1l3tXY6LU6TZ8wdSTbfneTQPYAJC5nEi1EAPBfXkx3RcpZ1JC7f2yfwul6NV/5dZYGYwNjYWNIkSaqQ5371/1M7rIDTzHLAKYcSfhLRf20Fuix5ajVIckrN0exaPxrTnLWM624xriclSGdVOkJCnUs8MDgVjxeUR19QdGhBxVdjX5L1L22P/mB5rLAFBH2BjH6EAPXnPQeqQdNM92QeFeOqafe+toyIoSCFAgI/H9nVnssEw2Xmca8r5jvuuXSLAMqJrv5GKg67WrPPeSaD69LrJkSEo64PAnfLQmyPNO1TEdSJ/mwXSSlXme3cQiRdNAisJOejbreDmfSnQJ7vAA7ZP/CAm31WeqGk2FPrTsr4qa1bCFn0CaPp0agTf3veXQzwXLsA9u+0MqpyJENdp1NfIlnZPW+xqgZL1eDLL5knLf0DMdi/ebEuHsETSmTKM7IKlZpSEzf0iIUiRqkdSSjtd97y/rYjKCEfWnaPt65r1ubE9mm3NEpH9vmLb/ziB8X6/BYD56Kwe7dYzFq4XM95Gj1cHDKcEQZNjps0Kt56FHW5X0qIJAsscRQgn5SDxqw8xYVlcceLrEGsIan1ya51NGkwIERpv0LWM3u8L8/0yKmQIxtys6QYlpuNa51L22sl3wuUZzUylVS3/5j4+oCa1gkQaW4t/gTKxDNUoIJItF+HuEmdnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(71200400001)(66946007)(41300700001)(38100700002)(8936002)(76116006)(66556008)(4326008)(2906002)(64756008)(122000001)(8676002)(36756003)(66476007)(15650500001)(66446008)(6916009)(5660300002)(86362001)(316002)(54906003)(83380400001)(1076003)(26005)(6506007)(2616005)(186003)(6512007)(38070700005)(66899018)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmtZVjRPeXBqRWszKzM4SGhGeHBHVExXY0xucWhIRVozNVBjRVB4VTNOZGNp?=
 =?utf-8?B?RERwbDBkeVp6dVg5VkdwenE0ZXd0NzNZR091OVptckM2eDBWbzdWN3A5aTRY?=
 =?utf-8?B?OGlLZzJ3VVp1dnVvMUdpdlZyWnNsNWdGUm95bWRMd0hvTmFVeW1sNEJvSVFw?=
 =?utf-8?B?a1pkbW9peXd1ZHZxS0lhcHEzeVBzWG5JRkk5Smk3akNjM3V6TkVDWTN4N2Y5?=
 =?utf-8?B?S3lLZWNwK0NBTURrUXdnS1JvWWZrdDVYL2U1ZlNNNEE0UGE5dldsWDR3SVI2?=
 =?utf-8?B?M0cyaFU2R2dLeEdJOEp6SHZSRDliVExpakltQnh5MEJxbDZQdEdVMEUzODIz?=
 =?utf-8?B?QXZETlFFd3krWWhNVGlpc3E1TElkU00rRU5ORWhCTHN1T3ZJalMxVkw0eFA3?=
 =?utf-8?B?TnlJMHlzQ0lqaUlBOEpyaURYMzVVZklITExwQll6UkJnSC9IMlFQS1R2UjJW?=
 =?utf-8?B?bHRWanJBeDExTzBjSmx1dlBSVVpMdzQvRmdjK0N4MVo3NC9OYzdVRkF2WFZh?=
 =?utf-8?B?Z01nd3c2cjZGUVJmZGhxbjNoK0dFUkd0a1J2Y1dSb0FrdXZzR2cxdHRybDM1?=
 =?utf-8?B?Z3RXci96VStMc1FtWUNrVWZ4TkxKaERhT0hQTkMzQ0tTY0FacHNuQ3NuSkJ6?=
 =?utf-8?B?OHJydlZhcVVRcklOcDZwZENaTTFaK24wUnNFRFlmRWM2cHRZdFlFUk5BeTZy?=
 =?utf-8?B?OTIzWVllU1p5UFhRNUdCMHNrYndDWWpaSUpCZWFWL0V5SUV2cy81d0xRUkx0?=
 =?utf-8?B?TXRQYjIrTkc1OUxDQkc2cVNoYnNLb3h1NmhGdWdyU2NBUlVSb1lVWWdIMHJx?=
 =?utf-8?B?Zzd5aUFORXFLN01pVmwwcmQxckk5VGtIcGVEeWw1RURicVloMlNSUG4zYzgw?=
 =?utf-8?B?WmliWXphQlJGK3NFY2ZiNWh5MFgyM1k3c2NubXovTFBoeGVDS2RYZGhyODNy?=
 =?utf-8?B?OWNGRUYxV1hpU0g3cVRhOTMrNnRkeTBvZlhFa3lZRVpXc20wemxnTlRzT1cr?=
 =?utf-8?B?cG5DTHp3c09OU0pSQ1hPa0ZJZUpKUVUxWXY4VStUTmt1c0VoQmJEZG1xZ2RC?=
 =?utf-8?B?OEdUVG5HOUlMUnNaQWs5YWlseVc1TFRML2NpQUYzRGZSaVR5SG9ycU5IbXhk?=
 =?utf-8?B?S1k0SFZ2Vk04VmZ2cGJGeG5KWXl5eU1IYXZYVG4vSXpMakdyU0g5WGZHRVBm?=
 =?utf-8?B?M3lGVy9CdFhON2d1cTcxdmdORGNxZU5RcVZid0RQNW8vT1ExNzVwU0VRZ3Rs?=
 =?utf-8?B?dGVYWWQvMmVzVWZJWm1xVXMzM2l4VjBiNjdCK1pZSkk2WndtUk1SOHlqbTIr?=
 =?utf-8?B?bWhJakU1Tk9xdlphWGVFNjlLWVRmZ2p0c1o0TVQ2T0E2bTNrY2tadlRhZkRj?=
 =?utf-8?B?a2RXclQ4d1dXQVZaY2J6ZE13cW9ja3h1SHFUK1laNHE0R1JEQ0FuSDNlcE9j?=
 =?utf-8?B?QXdMclJvNnFlMnZRRU9SM3Bid0pSVGk4Tnk4R01pSUpKcll4Q3IwWE4zRFZm?=
 =?utf-8?B?YUFaa1V4R1piczhDYmFrc3F6bDFvNVFUWkQrOGp1Sk16clIxaGNsUU16Ulhh?=
 =?utf-8?B?R2k2MTZjVWY3dFVaMjN2OENVNzQyZVJheEhvRFR0M2g0U0hEaEh6VVhxbGxy?=
 =?utf-8?B?eU45UHVOdHpkem1NL3RweDJwUHlwZmlXd1kyVGMwb0FmbzVpbzJ0eVEzbGlq?=
 =?utf-8?B?K0JyZ0VnckJlbmVWQXRCbGhMY0dhTkJZaGNvcE1hUXQ0UnBUM1pqdXRpYjlJ?=
 =?utf-8?B?SEFZOTNubE5GdzBzK2I5UlRCSVVMSG9JeTdqdjV3cEcwTndpVHh2aFBqZkhr?=
 =?utf-8?B?TkptbitqQlQxOW5KTlk1Mk9kdGNtZ2tUYWZqclZjNGh2bzVUNEF3MUN2aVp2?=
 =?utf-8?B?cGhZdEEzbTZzelB2VkhUcmtoa0R3TWhYVGQzZnY1ZHV2ZEU3cS9pN1loU3Vz?=
 =?utf-8?B?UVh2RUtxeWcrWkZMYkVRb3dBc3Z4V1FJbHNYKzJTNzd3cnJQY1FPUnU1TzFa?=
 =?utf-8?B?cy9kck80ckJMMUYxSi9sQ3FrOHB6eU5zUTgrbHRkYTl5YWhjWHVpZWs0aDFI?=
 =?utf-8?B?K0NtRVNUaW1YaFlqS1ZOK0FnTzRva0ZUUE42RXJQVEJHTnltaFQzUGZjY0Rr?=
 =?utf-8?B?bmEvUk90Y0dVMjhjUEs2RHJhaFVOV0xiZzRkZmovTVV0TXI1ZXZYNkd4WGVG?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA82BB1C9818CB41869D6A8DDE3A8A3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4pbULHPmo11taZB3abCFk708Cl1EPmG25t0XeQxHPXLIc+DJSe+eePE6lXxf7JNHv6x8+RzG2G75dUgtUAMYiCPUTFEiR07I9JuhrrTSpOUC8IsanYqFcXi0zxN4XXzPtRm3b4Ra45t63KmMS7hGMdjnKR28lQfrcPDR5raDpieXhjZN4JiBcO0rmgXSpEq/xFSbZeM6b+MjlkNqXcfGEMcyjz0ujpSuJ8PC1H21PfrO9NgNyv8waY2hVtm1rwCQhaq3/wmKukT1+vVqTXutEaUW9biUMeWQY+sIwkTNbPhelJ8TfPBcTrn5BNLtFgMWg1pi6EKwUzlE0qwlVz1dAJ9WXJxqZiHddBJ1llMf+vY69TUp2o9UkzySAyBijUGUJ0si+JN+sfUJOXom2Z8rji5lmiEszlwGYBG02GhUkOM/UdiLj8BvapqOYBeNELyJjIK/bokoudRZBWwTJX3iuCIw+f0ZuFug+e18RF9PphsBhrZAgQBVpdYxeZPl2C9HokcHKSOAekQx1JlcglrLOOJFWshGCfQ5VhbBrpA4DgjMFssEpxqfrD6dqmdARGjJR4O19zx/12mc2C/YWXLh+7P986kbISfWNcVTroKwPfXAVMSffxymwDYA+/wfW3IXKceCbRtOSUdSfSrSOxRRTApYCmECT3uaskDa/CINQU4oNLvX0l0SVdTro0qWf+9ZebDVBDgVn8LN59BJ1ADrDZIowNTNqKNiDJOMINkIpO2z4nbtmyT9E3Gw68ZAYFkfZVzkCw9bsUUfn3N2IysFxBI7dpmnRhO/iR8WUdhUtIVWAlYyT3e0vJtlzC4S8X1DuoT8PPHmJn1rjqL6rwqGrwbS8HXHKBlFRJ/QpQkqVew82bEFAMaZxnJha1+6JddfTKbh8coSlDWIetzy4+1ni+r24P2zg25x2AMGjIGsd3Y=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586c4757-826a-4679-09e9-08db0ef2a99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:19:19.3351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tq0C+pfFQ3Fdjs09HcAoOd8sgvcWbRQLDNsWLrT+ONEvoRD6ndU8/oICiVV6n97oBANn+0U1YBiXOSuuedKxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
X-Proofpoint-ORIG-GUID: sUi1GSHmTW8D-lGFZAGNa42es926tcUw
X-Proofpoint-GUID: sUi1GSHmTW8D-lGFZAGNa42es926tcUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMTMsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFVTQiBob3N0
IHNlbmRzIGZ1bmN0aW9uIHN1c3BlbmQgYW5kIGZ1bmN0aW9uIHJlc3VtZSBub3RpZmljYXRpb25z
IHRvDQo+IHRoZSBpbnRlcmZhY2UgdGhyb3VnaCBTRVRfRkVBVFVSRS9DTEVBUl9GRUFUVVJFIHNl
dHVwIHBhY2tldHMuDQo+IEFkZCBzdXBwb3J0IHRvIGhhbmRsZSB0aGVzZSBwYWNrZXRzIGJ5IGRl
bGVnYXRpbmcgdGhlIHJlcXVlc3RzIHRvDQo+IGNvbXBvc2l0ZSBsYXllci4gQWxzbyBhZGQgc3Vw
cG9ydCB0byBoYW5kbGUgZnVuY3Rpb24gd2FrZSBub3RpZmljYXRpb24NCj4gcmVxdWVzdHMgdG8g
ZXhpdCBmcm9tIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBF
bHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggICB8ICAzICsrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9kZWJ1
Zy5oICB8ICAyICsrDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jICAgIHwgMTIgKysrKy0tLS0t
LS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNDIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBjYzc4MjM2Li4xNTY1
YjIxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtNTI2LDYgKzUyNiw3IEBADQo+ICAjZGVmaW5lIERX
QzNfREdDTURfU0VUX0VORFBPSU5UX05SRFkJMHgwYw0KPiAgI2RlZmluZSBEV0MzX0RHQ01EX1NF
VF9FTkRQT0lOVF9QUklNRQkweDBkDQo+ICAjZGVmaW5lIERXQzNfREdDTURfUlVOX1NPQ19CVVNf
TE9PUEJBQ0sJMHgxMA0KPiArI2RlZmluZSBEV0MzX0RHQ01EX0RFVl9OT1RJRklDQVRJT04JMHgw
Nw0KPiAgDQo+ICAjZGVmaW5lIERXQzNfREdDTURfU1RBVFVTKG4pCQkoKChuKSA+PiAxMikgJiAw
eDBGKQ0KPiAgI2RlZmluZSBEV0MzX0RHQ01EX0NNREFDVAkJQklUKDEwKQ0KPiBAQCAtNTM4LDYg
KzUzOSw4IEBADQo+ICAjZGVmaW5lIERXQzNfREdDTURQQVJfVFhfRklGTwkJCUJJVCg1KQ0KPiAg
I2RlZmluZSBEV0MzX0RHQ01EUEFSX0xPT1BCQUNLX0RJUwkJKDAgPDwgMCkNCj4gICNkZWZpbmUg
RFdDM19ER0NNRFBBUl9MT09QQkFDS19FTkEJCUJJVCgwKQ0KPiArI2RlZmluZSBEV0MzX0RHQ01E
UEFSX0ROX0ZVTkNfV0FLRQkJQklUKDApDQo+ICsjZGVmaW5lIERXQzNfREdDTURQQVJfSU5URl9T
RUwobikJCSgobikgPDwgNCkNCj4gIA0KPiAgLyogRGV2aWNlIEVuZHBvaW50IENvbW1hbmQgUmVn
aXN0ZXIgKi8NCj4gICNkZWZpbmUgRFdDM19ERVBDTURfUEFSQU1fU0hJRlQJCTE2DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnLmggYi9kcml2ZXJzL3VzYi9kd2MzL2RlYnVn
LmgNCj4gaW5kZXggOGJiMmM5ZS4uMDlkNzAzOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9kZWJ1Zy5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZGVidWcuaA0KPiBAQCAtNzIs
NiArNzIsOCBAQCBkd2MzX2dhZGdldF9nZW5lcmljX2NtZF9zdHJpbmcodTggY21kKQ0KPiAgCQly
ZXR1cm4gIlNldCBFbmRwb2ludCBQcmltZSI7DQo+ICAJY2FzZSBEV0MzX0RHQ01EX1JVTl9TT0Nf
QlVTX0xPT1BCQUNLOg0KPiAgCQlyZXR1cm4gIlJ1biBTb0MgQnVzIExvb3BiYWNrIFRlc3QiOw0K
PiArCWNhc2UgRFdDM19ER0NNRF9ERVZfTk9USUZJQ0FUSU9OOg0KPiArCQlyZXR1cm4gIkRldmlj
ZSBOb3RpZmljYXRpb24iOw0KPiAgCWRlZmF1bHQ6DQo+ICAJCXJldHVybiAiVU5LTk9XTiI7DQo+
ICAJfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMNCj4gaW5kZXggZjkwZmE1NS4uMWU3Y2MxNSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9lcDAuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IEBA
IC0zMCw2ICszMCw4IEBADQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfZXAwX2RvX2NvbnRyb2xfc3Rh
dHVzKHN0cnVjdCBkd2MzICpkd2MsIHN0cnVjdCBkd2MzX2VwICpkZXApOw0KPiAgc3RhdGljIHZv
aWQgX19kd2MzX2VwMF9kb19jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3YywNCj4gIAkJc3Ry
dWN0IGR3YzNfZXAgKmRlcCwgc3RydWN0IGR3YzNfcmVxdWVzdCAqcmVxKTsNCj4gK3N0YXRpYyBp
bnQgZHdjM19lcDBfZGVsZWdhdGVfcmVxKHN0cnVjdCBkd2MzICpkd2MsDQo+ICsJCQkJIHN0cnVj
dCB1c2JfY3RybHJlcXVlc3QgKmN0cmwpOw0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2VwMF9w
cmVwYXJlX29uZV90cmIoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gIAkJZG1hX2FkZHJfdCBidWZf
ZG1hLCB1MzIgbGVuLCB1MzIgdHlwZSwgYm9vbCBjaGFpbikNCj4gQEAgLTM2OCw3ICszNzAsNyBA
QCBzdGF0aWMgaW50IGR3YzNfZXAwX2hhbmRsZV9zdGF0dXMoc3RydWN0IGR3YzMgKmR3YywNCj4g
IAkJICogRnVuY3Rpb24gUmVtb3RlIFdha2UgQ2FwYWJsZQlEMA0KPiAgCQkgKiBGdW5jdGlvbiBS
ZW1vdGUgV2FrZXVwCUQxDQo+ICAJCSAqLw0KPiAtCQlicmVhazsNCj4gKwkJcmV0dXJuIGR3YzNf
ZXAwX2RlbGVnYXRlX3JlcShkd2MsIGN0cmwpOw0KPiAgDQo+ICAJY2FzZSBVU0JfUkVDSVBfRU5E
UE9JTlQ6DQo+ICAJCWRlcCA9IGR3YzNfd0luZGV4X3RvX2RlcChkd2MsIGN0cmwtPndJbmRleCk7
DQo+IEBAIC01MTQsMTMgKzUxNiw3IEBAIHN0YXRpYyBpbnQgZHdjM19lcDBfaGFuZGxlX2ludGYo
c3RydWN0IGR3YzMgKmR3YywNCj4gIA0KPiAgCXN3aXRjaCAod1ZhbHVlKSB7DQo+ICAJY2FzZSBV
U0JfSU5UUkZfRlVOQ19TVVNQRU5EOg0KPiAtCQkvKg0KPiAtCQkgKiBSRVZJU0lUOiBJZGVhbGx5
IHdlIHdvdWxkIGVuYWJsZSBzb21lIGxvdyBwb3dlciBtb2RlIGhlcmUsDQo+IC0JCSAqIGhvd2V2
ZXIgaXQncyB1bmNsZWFyIHdoYXQgd2Ugc2hvdWxkIGJlIGRvaW5nIGhlcmUuDQo+IC0JCSAqDQo+
IC0JCSAqIEZvciBub3csIHdlJ3JlIG5vdCBkb2luZyBhbnl0aGluZywganVzdCBtYWtpbmcgc3Vy
ZSB3ZSByZXR1cm4NCj4gLQkJICogMCBzbyBVU0IgQ29tbWFuZCBWZXJpZmllciB0ZXN0cyBwYXNz
IHdpdGhvdXQgYW55IGVycm9ycy4NCj4gLQkJICovDQo+ICsJCXJldCA9IGR3YzNfZXAwX2RlbGVn
YXRlX3JlcShkd2MsIGN0cmwpOw0KPiAgCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiAgCQlyZXQg
PSAtRUlOVkFMOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYjdmZWY1ZC4uOTkwNTg3NSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+IEBAIC0yMzkxLDYgKzIzOTEsNDcgQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIHZvaWQgZHdjM19yZXN1bWVfZ2FkZ2V0KHN0cnVjdCBkd2MzICpkd2Mp
Ow0KPiArDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2Z1bmNfd2FrZXVwKHN0cnVjdCB1c2Jf
Z2FkZ2V0ICpnLCBpbnQgaW50Zl9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgIGR3YzMJCSpkd2MgPSBn
YWRnZXRfdG9fZHdjKGcpOw0KPiArCXVuc2lnbmVkIGxvbmcJCWZsYWdzOw0KPiArCWludAkJCXJl
dDsNCj4gKwlpbnQJCQlsaW5rX3N0YXRlOw0KPiArDQo+ICsJaWYgKCFkd2MtPndha2V1cF9jb25m
aWd1cmVkKSB7DQo+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJyZW1vdGUgd2FrZXVwIG5vdCBjb25m
aWd1cmVkXG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJc3Bpbl9s
b2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCS8qDQo+ICsJICogSWYgdGhlIGxp
bmsgaXMgaW4gbG93IHBvd2VyLCBmaXJzdCBicmluZyB0aGUgbGluayB0byBVMA0KPiArCSAqIGJl
Zm9yZSB0cmlnZ2VyaW5nIGZ1bmN0aW9uIHJlbW90ZSB3YWtldXAuDQoNClRoaXMgc2hvdWxkIGJl
IHJld29yZCBhcyBiZWxvdzoNCklmIHRoZSBsaW5rIGlzIGluIFUzLCBzaWduYWwgZm9yIHJlbW90
ZSB3YWtldXAgYW5kIHdhaXQgZm9yIGxpbmsgdG8NCnRyYW5zaXRpb24gdG8gVTAgYmVmb3JlIHNl
bmRpbmcgZGV2aWNlIG5vdGlmaWNhdGlvbi4NCg0KQWZ0ZXIgdGhlIGFib3ZlIGNoYW5nZSwgeW91
IGNhbiBhZGQgbXkgYWNrOg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5A
c3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICsJICovDQo+ICsJbGlua19zdGF0
ZSA9IGR3YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+ICsJaWYgKGxpbmtfc3RhdGUg
PT0gRFdDM19MSU5LX1NUQVRFX1UzKSB7DQo+ICsJCXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVw
KGR3YywgZmFsc2UpOw0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQl9DQo+
ICsJCWR3YzNfcmVzdW1lX2dhZGdldChkd2MpOw0KPiArCQlkd2MtPmxpbmtfc3RhdGUgPSBEV0Mz
X0xJTktfU1RBVEVfVTA7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gZHdjM19zZW5kX2dhZGdldF9n
ZW5lcmljX2NvbW1hbmQoZHdjLCBEV0MzX0RHQ01EX0RFVl9OT1RJRklDQVRJT04sDQo+ICsJCQkJ
CSAgICAgICBEV0MzX0RHQ01EUEFSX0ROX0ZVTkNfV0FLRSB8DQo+ICsJCQkJCSAgICAgICBEV0Mz
X0RHQ01EUEFSX0lOVEZfU0VMKGludGZfaWQpKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZfZXJy
KGR3Yy0+ZGV2LCAiZnVuY3Rpb24gcmVtb3RlIHdha2V1cCBmYWlsZWQsIHJldDolZFxuIiwgcmV0
KTsNCj4gKw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0K
PiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX2dhZGdl
dF9zZXRfcmVtb3RlX3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IHNldCkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGdhZGdldF90b19kd2MoZyk7DQo+IEBAIC0zMDI4LDYg
KzMwNjksNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9hc3luY19jYWxsYmFja3Moc3RydWN0
IHVzYl9nYWRnZXQgKmcsIGJvb2wgZW5hYmxlKQ0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2Jf
Z2FkZ2V0X29wcyBkd2MzX2dhZGdldF9vcHMgPSB7DQo+ICAJLmdldF9mcmFtZQkJPSBkd2MzX2dh
ZGdldF9nZXRfZnJhbWUsDQo+ICAJLndha2V1cAkJCT0gZHdjM19nYWRnZXRfd2FrZXVwLA0KPiAr
CS5mdW5jX3dha2V1cAkJPSBkd2MzX2dhZGdldF9mdW5jX3dha2V1cCwNCj4gIAkuc2V0X3JlbW90
ZV93YWtldXAJPSBkd2MzX2dhZGdldF9zZXRfcmVtb3RlX3dha2V1cCwNCj4gIAkuc2V0X3NlbGZw
b3dlcmVkCT0gZHdjM19nYWRnZXRfc2V0X3NlbGZwb3dlcmVkLA0KPiAgCS5wdWxsdXAJCQk9IGR3
YzNfZ2FkZ2V0X3B1bGx1cCwNCj4gLS0gDQo+IDIuNy40DQo+IA0K

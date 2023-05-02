Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3536F4C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEBVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEBVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:44:45 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2F10EF;
        Tue,  2 May 2023 14:44:43 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342JGhSn024465;
        Tue, 2 May 2023 14:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=4F5+Zbw8VIc4b+P5DS+bTbi9avRe7Tai2dW5Y18tvK4=;
 b=eCWDhS6wL9TsMO0Px7uQ269VgKO4LoDsC9uK1J/zK9TbkzWLOjm2mDV3/JrL9AhJd4MY
 SKXG7pvCb++QoFWpC2WHXW1p5YhFD5a978bQELuClM/W1eYFjqDYhOs8ntNgECe/VQki
 htqq+0aH+AamOuXJdCdR79VfVx3p2ufSEJhyvmeOQyhXak6bf0WwaT+3G2M8lSSvowRz
 miuh+souvHGrrLZpgfT+43SFho0M5QXk5VvKzoRRjOoKAWTartpLdRg26V5k1BEdmxjW
 X7QYwftl416R+KBKzqrDl8dlnTla8S4dN32lumAccnU/qk5NCoYPBiXFtRf9ZUFDK6WH 4Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q91vj6vu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:44:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683063870; bh=4F5+Zbw8VIc4b+P5DS+bTbi9avRe7Tai2dW5Y18tvK4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LxGH2CtB5MWSc0rBd7LCSs00SwraFQc3x4iCkYNk7KJmIVuG+C0pIQQDXd9gWIlpj
         n9EqWaRBmDpeBeCZe4EbkN9xfEu7NsPWisEvLBLZ5eNa3a4MKbLXe5UXpySi7lPi5T
         oGXi7aAT+wgBBd6Xryw1J92nrZBTiaIZLhE1FV/Qm8MweSVoAbtauCtPGFZX8T4xO1
         Z70rGsp+EfdscpcARspwKV1PmBngH/CZUoME2TnqivQFsX7Fo5HWdF/xm2+u0XKLqT
         I+ygl8uKK7wmKZrAdIXAwsVwErV+9Dl7cgigwcXcFg17dzKToRMHm0QFX+j+b0g1TK
         VyM2g1akCIABw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D7E3E40408;
        Tue,  2 May 2023 21:44:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C2486A006E;
        Tue,  2 May 2023 21:44:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TC1uvPK0;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 94CDA4045C;
        Tue,  2 May 2023 21:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS5W5puUyzFcd9QIf7zWqC/Wmsvayin3ChI2Q1DgCdV79TTnag7rOUuWN22WSkdm+ZOFY6f58VoTbeJ5YSAKtRcCv5KMAcsZtdjpDAtuRYtJJ77/aiJ8BLyNUYZ5xNBf7oZpgxduCtt589YpDQ9UHSFbDeHGKtSsO8hCf5AznasECxyzm7pwQZdOxdy0dLWRkTrBabvHdEURHPOX6//TMWONYDzZPEF6h5aO/e07POiCsfBdP4Uqg84vM/gkv7qksKf8I5ZHsWEc3WJ+bUh/f+1y/k3XgG+ldPBe9Lm/SU7Cm6xKZRy/IMWSjpL/c0ZCl8tzsXSNV/b59vV/lFqIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F5+Zbw8VIc4b+P5DS+bTbi9avRe7Tai2dW5Y18tvK4=;
 b=Bb0Bo8kcvQlx7IA7qKfl0PsC8Ui+0NUp45SjSAjxKv2JDdc9iHa52QtJON23C9qtMpElPXvi6ArlfXiw8fcmWk7Y0mgBRLkr6uVORi22UrqD/AV9Gn2vl6msOxeJaJDdcayKTRZIMjMwJ9Xw5GERTPCdHIQvQczOYKaq0n58QZ3VbGeULTDlfL4d8A6IVW7jCmu8+TQa4V6NWHVWxoBIKgZNpR9Fkw5vo+XX6vsnypVFrBLg8Jv9NgvTvCAiKxwBqgRx2IRaCqVdjLgWEqpDMxWqgAvB5EWGB1vbANs9DdP0qmqh+EOOtVyS1FYuB7uAhj5rpf5+/nrB6GhPdvXfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F5+Zbw8VIc4b+P5DS+bTbi9avRe7Tai2dW5Y18tvK4=;
 b=TC1uvPK0jq5GsB0d9WbOGYy11YADo6EmM5rweehnnJatlWsGzawICYaDmN5NRQxQQyf5TVIhxSfr6h2evClqdpwzN+yyiRRGXCS9swixfBZ44h/JJGek1hsdPKr+HE9q5HGj0u9f64nhWI/606VVn6AatheUJoZmK9etNpaqUyw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 21:44:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 21:44:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v7 4/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Topic: [PATCH v7 4/9] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Index: AQHZfDo3wz3zuHFkEE+y/MSrO3Rz269HhguA
Date:   Tue, 2 May 2023 21:44:24 +0000
Message-ID: <20230502214419.rzybyuozzvslinwe@synopsys.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-5-quic_kriskura@quicinc.com>
In-Reply-To: <20230501143445.3851-5-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN6PR12MB8568:EE_
x-ms-office365-filtering-correlation-id: 972ad386-019e-4a1b-1ad7-08db4b56654d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnlGssinRaFVd8nsdS0r7wZG4VBDyxOppjMMwR95JyEX6ntdlaucT1D8nvbZqA8eS6sKockz819APkjlmCZeo+3Vbcd9KoXJFU4fD/4leFQqvxA5CVOVnRcU4IAyTsyWj+3C4yEr0vLR0zgJKuq3JB6JGxh0a5Pg11tDESQr0i5tYohisrTUYwQP6Q3V+OMS9ZYZTCHW0Kp9JgPeu/C/luYggDeaitgAIbXqHxej6QDLXNRbgTG0T73anSaZ95QCAcnqGdh4jNNchEZugRPesutUXEBwk8psPOFOjXOs+iNwEaod9KMosSZqHz0MWqGdoAvREnOw6wcUBko8OmSmX5eeYhl44DA+sdDBe1k8duk8cHgyjnTOk/z+dbUQQOPz96jkdqr4pfIUX9QaKgh0ZmR9P7M4TEClvXFqPadnLAdL2x1zGnMScQI2o1WL8w9sbLvXcea5pihbN74wnHwuRftCY1+i2YL+QTAZM3r018BmTfq/Xwf9nijcwSoBNQ6xe7KFpwb9kP4czSbD3IPoQW8nIi28bOL88Yvq0CJ4JIaqM1OdGCg4mO8/BRGaukn73/Uw3MMmFOupltTxmXkpxAsLfUYooJestpzZEvmp2I29atF1EYoy0j+KKOHHAT9p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(38100700002)(122000001)(83380400001)(41300700001)(8676002)(8936002)(316002)(2616005)(36756003)(5660300002)(186003)(1076003)(6916009)(66446008)(66476007)(64756008)(66946007)(4326008)(66556008)(76116006)(6506007)(26005)(6512007)(54906003)(478600001)(71200400001)(7416002)(86362001)(38070700005)(6486002)(2906002)(3716004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmRMTklCcjJpT3JxY2FkbEVCcy9mUVFJMkRqaENNY1U2TWt1NDVWb1NqakI0?=
 =?utf-8?B?emF3YlAwM01MOENKUXBOQUppYVlCVGxBODFnZkpjSzFsWkpqR2JQRGFBK1cz?=
 =?utf-8?B?T0VGbjF6SkJGa1VZbm9BUFByN0RPdVlDNjFHc2VQcHdnY0RrdEkxSVZUOWFE?=
 =?utf-8?B?Z0s3Q3BEMWhwenVnODhZa0dnUkhyS0hkVEFWQTZWNGZmZGxZYjJwQXlJL29a?=
 =?utf-8?B?NG1qbGxxUUtuMkQraW8xYTB3YlBzNXN1N0VRazhnRExsYVNlVW0yTGx6b29z?=
 =?utf-8?B?RitwZWE1YnlXTUx2cDdHK1FiRXorVHFwWUE0MCtiSTVxZmVPdXZXRXZBbGtM?=
 =?utf-8?B?M3h2R0Z6R0Fua1VPc0p4L21BbXF4NDJxQzdYV0d5YUhtN0ZNN0JaRkhreE1B?=
 =?utf-8?B?TzZCejVoNlA4aU1PTlpMT3hlNTBuelU0WG1venRVbVBIUjZYWTBPSm04cEtT?=
 =?utf-8?B?ZzcxK1AxZTl4VjQvbVRqNmJkTkhQS3haU0ZjU0xhZVpvdmxxUDRtWVVFVXhH?=
 =?utf-8?B?VnprK0dCOGhXRytuc3FLelBoaVJCVEY3dEFuQzBUeDJpZmVISlFseld0dVJ4?=
 =?utf-8?B?dFpUazRaRGdpekljeEx3UDZhK2k0bmZHb0tPc0N5b1BqM1VyZjlUN3RyZ2h3?=
 =?utf-8?B?c3FHVlhnSEFOZjZBQTR4VlR4NW9uSzJycUxaQ2U1VHFMemRaQ2pLbUYxNGor?=
 =?utf-8?B?ZkFETmVVdFA5ZERWOFI4Q21GSHJxcUkwZ0VLd2Rld0JGd0ZhYWE0NEFpS0JI?=
 =?utf-8?B?cm94WGtMdU5USWhHN1FLbTBBdE5MQU9VZDJFWkxIWDQxaHhiRkZhakRPS2ZC?=
 =?utf-8?B?RHlvWEpnRTROcDZ5TGFnUURES3RBQXdGZmpyalVwY3RhL25TemhuT25ZUnlp?=
 =?utf-8?B?SVJZZ1NUSSthUUpLZDJaUkQzODZqUkYrMFNuUTRYdTVGZTJBZUJZYjJHOHA1?=
 =?utf-8?B?Q0hoWXhleTU2Z1ZhOW5pd2pxcitOQlA0bTJqMHUvd0NpVFM1TlFKQzdOZWlJ?=
 =?utf-8?B?c0hBLzJjbmI3WndnY1VnYnVRRkJDQlVEc015ZmNtWEtpWmczUjgxQTEwVjNT?=
 =?utf-8?B?b09PSHdRbmdkZThCMXNGQTBJWWxLWDZYV2dPaEhiTHh2RzNIKzhya3U2Wk10?=
 =?utf-8?B?dEhwRUp4d2dTVVNHdlpmaitKd2Z0NVczUU5xMWp2aVI1bDVhcDhuNkdsTHZZ?=
 =?utf-8?B?TDNGcXJuZysyMTFWWjFEUis2bExhemNhMEwyRE41M1FwK2xQNTJ3TnFZRHNK?=
 =?utf-8?B?ZFM3TVJoTFVsYXl1aklVWmQrT3hHc3NoNmZwZjJHaHJUWGwxN3lKMU5nb0t1?=
 =?utf-8?B?d2R6ckFjbHduZmJTNTROV0R2aXF2TXkwT0ZRNFJ4SnpiK3c4c3loR1FjbExS?=
 =?utf-8?B?d2xkTTdaeFc4emNRRUJzZ2cxSjUyMlpQaFhXOWxpT01qOGljam00RDNqdDJr?=
 =?utf-8?B?THVYRVhnanM1UjZNcmZlZEs2aUlzZ2tzSUVpNThEbDZSNG9YUkp3MktTWGd6?=
 =?utf-8?B?am1wc3pOa3FnWVMwOEV1SkVYREMrbldiM2lNVEsrSWRBZW9aMjc3ckFCY0o3?=
 =?utf-8?B?bGhvSUcvVFNJOFBqLzQ0dEtJeXZZY01tMFNqdkVFU1BDK3dFMDRkNkFrdXNr?=
 =?utf-8?B?TjV4eHZBeXBHWEtqcEZrckRhaG5yNmFyNXRFa09XcWE2MVFwMXBRYkVJcHRS?=
 =?utf-8?B?ZjMrTzJwZ21MNWJFcXRHeDh4dEp5blAxZXdTUGJhMXJlSVBFQUc1NHM5eXpQ?=
 =?utf-8?B?L3k4Y29iVHlxcUxVRVd6TzBZREhpc2xWc2pkYzQ2SUdCakZtY3paTDUwNm9K?=
 =?utf-8?B?OWJwZjhTTmxja25CbjFrL2V3WVFZdGpIaUMrb0tQNmJ2eFlPNkIwMHJ5Q1M2?=
 =?utf-8?B?TWN2d2wvNnBqTlZPN3BIQXh5ZlVYU1J3b3d5eGxiVTRyWFQvKzlNZWJHMEJ4?=
 =?utf-8?B?VVJiYXNaNFg4c2F3UXRNYmJVVFV5U3p5T2NidmJIL3owL3g3aHY5b01LTVdu?=
 =?utf-8?B?b2F6WS91Slp0M3ZIVXhHdGpTQ0ZqWEk1ekFBVlJkVkViTEFya2NhYVVlTFVj?=
 =?utf-8?B?VCs2bDg1SnlLQ0NFUHlBYzFsWVVjYzdadWlEaXNDWHpZTC9UNENoQmJIOUhL?=
 =?utf-8?Q?ryOUxJy/PTRhX8dFVHhYc1FHh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFEAD9A34784DC4DA78A815BF123ABA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3F1K28vVHl1eC9kWnIrWXVkV3Z1alJjYVgwd3RKWGhkT3ZlYkt3b2hpZjkx?=
 =?utf-8?B?L3p6elJRU1d6YXZkWkg4MWZmZnpIUjBEMTVLb0RRcmhUakk5UWhucDhocjJT?=
 =?utf-8?B?cE5EYUlsYURibDkrSDBYbkxUVnZPczRWVE5UMkZweCtkR0hqZ1NvVnZxQUUx?=
 =?utf-8?B?S0JMR0JpMEd6QlJucGVicjZpYnpuR0tCcUtSZUxIVlRxdG13bE1pbnhGLytV?=
 =?utf-8?B?K2s2V0kwTldyVzNsc2JPRlEvQ3o3dU9RcEk5aExKa2RaL0VZSlZLMWVQbG00?=
 =?utf-8?B?bVFEdVV3d1JnMTc3d20yU3Y1TlRnanptYWVYYXJNT0xtUGhBSDdYRGh5VTZP?=
 =?utf-8?B?VW1ucVdjb3RpYVZZd0JwZHJ5WHlUdnVleDQ4ZmMxdjROQ29UdGdsYVJLNTBG?=
 =?utf-8?B?RkVGUUJqQ1ZaSTV2UTIyVlcwakpLMWVIZ2lFa00wK0lrWDVuTE56RVVnTldh?=
 =?utf-8?B?T0dGdmM1amhBZjRBcEY3V1ptQWpkY0FvWHhRdTY5d1hEMzE3WEZIUFhzbGE4?=
 =?utf-8?B?OUtkVEVJMGJ0cFRvVWMzUnpDVE9Sd1FoYW8zVGVRMm1EQ2FEMUVBUTkzdnV1?=
 =?utf-8?B?bm94dU1BakZMWUpEbllxbG9tYm8vczlCc2Fpa0N5M1oxSDVvYnVudXZCK0tp?=
 =?utf-8?B?RU8zOW0xQkFSQ3VBU255bE0wTS9pMnFxaSs4bGdjNVZVZnVLak5oVDhiZmJL?=
 =?utf-8?B?WnVteXdwK1p3L0ZXVVFDb2VyYlJSM3pJQ1pPNG4zOHFpUzBuUCtWbmU0bVFQ?=
 =?utf-8?B?YnhCRm9BZEpXZkF3bEErdUc5dzhqUjhyUXdub1dHMnpQd3dqNmE2RzlUNmJo?=
 =?utf-8?B?ZWxTMnZoQ0ZvY0NuZG9NZXdpdTMweUhhcGVDNDZicXFnYWlwdDlXRnlIUWFj?=
 =?utf-8?B?dFVVUWlyQ0h0S2xXRjNORmdiYkpRTHljeVNMVWQxL0VXRUdIWjJxK1Qrdlg4?=
 =?utf-8?B?VmVvTUFOOUJ3MVRDZjl4bnhLWkQ0aUFVb2ZNdVlZRjdwUE9PS2V0VFU1dklN?=
 =?utf-8?B?ZTJ1UHBnVW1iV2lvK2gwbEw4M29RemowS3RJOFNhQXUyenBXckQ4bzJDRzR5?=
 =?utf-8?B?Y1FrVHRrV21iTjUwcWJHQW9USEpucmxGckYxNWlXazBocTBpN2d4c0cxY09J?=
 =?utf-8?B?MW5veE5iODl1TGJHazJrRDUxWWdldExmUndPWDNqeXZBdHJIZDdVN005alVu?=
 =?utf-8?B?WXdva3RmbnJqa01TWEEycTFiTjlFSXlDdTMrbnRWRmZYYk5FNFNnenJqMzBa?=
 =?utf-8?B?SXY5RSsvQk9RTDZTdVBsRXlicjl3anVEYWJtTldZWEtsWU5xUDdGUWhGcURy?=
 =?utf-8?B?VFRTWjZxS3NFOWM3SnliUWFzUHJRbGFBZ3RqOUFQVUhRUFRHdzBqRmQ0ekRy?=
 =?utf-8?B?SHhuZnB1R1RaS0E9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972ad386-019e-4a1b-1ad7-08db4b56654d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 21:44:24.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMYQxUjit4vKNQBkdXFuDMh8bySuBTzjj52MKJQGxv0VKZzvpNpYXDmAAxXxCx8uMOlBanWtkOqQNolWifeACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
X-Proofpoint-GUID: GZDK-UCLGTQ4LJFbE5fGzUYHSVIAsHDh
X-Proofpoint-ORIG-GUID: GZDK-UCLGTQ4LJFbE5fGzUYHSVIAsHDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMDEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE9uIHNvbWUg
U29DJ3MgbGlrZSBTQTgyOTVQIHdoZXJlIHRoZSB0ZXJ0aWFyeSBjb250cm9sbGVyIGlzIGhvc3Qt
b25seQ0KPiBjYXBhYmxlLCBHRVZUQUREUkhJL0xPLCBHRVZUU0laLCBHRVZUQ09VTlQgcmVnaXN0
ZXJzIGFyZSBub3QgYWNjZXNzaWJsZS4NCj4gVHJ5aW5nIHRvIHNldHVwIHRoZW0gdXAgZHVyaW5n
IGNvcmVfaW5pdCBsZWFkcyB0byBhIGNyYXNoLg0KPiANCj4gRm9yIERSRC9QZXJpcGhlcmFsIHN1
cHBvcnRlZCBjb250cm9sbGVycywgZXZlbnQgYnVmZmVyIHNldHVwIGlzIGRvbmUNCj4gYWdhaW4g
aW4gZ2FkZ2V0X3B1bGx1cC4gU2tpcCBzZXR1cCBvciBjbGVhbnVwIG9mIGV2ZW50IGJ1ZmZlcnMg
aWYNCj4gY29udHJvbGxlciBpcyBob3N0LW9ubHkgY2FwYWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAyMiArKysrKysrKysrKysrKysrLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IGluZGV4IGI4YWM3YmNlZTM5MS4uODYyNWZjNWM3YWI0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiBAQCAtODM1LDcgKzgzNSwxMiBAQCBzdGF0aWMgdm9pZCBkd2MzX2Nsa19kaXNhYmxlKHN0
cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIHN0YXRpYyB2b2lkIGR3YzNfY29yZV9leGl0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICB7DQo+IC0JZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAoZHdjKTsN
Cj4gKwl1bnNpZ25lZCBpbnQJaHdfbW9kZTsNCj4gKw0KPiArCWh3X21vZGUgPSBEV0MzX0dIV1BB
UkFNUzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ICsJaWYgKGh3X21vZGUgIT0g
RFdDM19HSFdQQVJBTVMwX01PREVfSE9TVCkNCj4gKwkJZHdjM19ldmVudF9idWZmZXJzX2NsZWFu
dXAoZHdjKTsNCg0KSSB0aGluayBpdCdzIGNsZWFuZXIgdG8gZG8gdGhlc2UgY2hlY2tzIGluIGR3
YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwDQphbmQgZHdjM19ldmVudF9idWZmZXJzX3NldHVwLg0K
DQpUaGFua3MsDQpUaGluaA0KDQo+ICsNCj4gIAlkd2MzX3BoeV9wb3dlcl9vZmYoZHdjKTsNCj4g
IAlkd2MzX3BoeV9leGl0KGR3Yyk7DQo+ICAJZHdjM19jbGtfZGlzYWJsZShkd2MpOw0KPiBAQCAt
MTE0MSwxMCArMTE0NiwxMiBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBlcnJfZXhpdF9waHk7DQo+ICANCj4gLQly
ZXQgPSBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoZHdjKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0J
CWRldl9lcnIoZHdjLT5kZXYsICJmYWlsZWQgdG8gc2V0dXAgZXZlbnQgYnVmZmVyc1xuIik7DQo+
IC0JCWdvdG8gZXJyX3Bvd2VyX29mZl9waHk7DQo+ICsJaWYgKGh3X21vZGUgIT0gRFdDM19HSFdQ
QVJBTVMwX01PREVfSE9TVCkgew0KPiArCQlyZXQgPSBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAo
ZHdjKTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0
byBzZXR1cCBldmVudCBidWZmZXJzXG4iKTsNCj4gKwkJCWdvdG8gZXJyX3Bvd2VyX29mZl9waHk7
DQo+ICsJCX0NCj4gIAl9DQo+ICANCj4gIAkvKg0KPiBAQCAtMTk1OCw3ICsxOTY1LDEwIEBAIHN0
YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+
ICBlcnJfZXhpdF9kZWJ1Z2ZzOg0KPiAgCWR3YzNfZGVidWdmc19leGl0KGR3Yyk7DQo+IC0JZHdj
M19ldmVudF9idWZmZXJzX2NsZWFudXAoZHdjKTsNCj4gKw0KPiArCWlmIChod19tb2RlICE9IERX
QzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpDQo+ICsJCWR3YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVw
KGR3Yyk7DQo+ICsNCj4gIAlkd2MzX3BoeV9wb3dlcl9vZmYoZHdjKTsNCj4gIAlkd2MzX3BoeV9l
eGl0KGR3Yyk7DQo+ICAJZHdjM191bHBpX2V4aXQoZHdjKTsNCj4gLS0gDQo+IDIuNDAuMA0KPiA=

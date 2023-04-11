Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D76DCEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDKBN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDKBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:13:55 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F11998;
        Mon, 10 Apr 2023 18:13:40 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJ5tGc014497;
        Mon, 10 Apr 2023 18:13:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HL09wiykAIo41TmZL8bLZkdzxERYFmTKrYm0jwHe8Bg=;
 b=KasdqH2myiUwSgW2JEzvAgy+QQf7r46UxdiBUAO7C7LBZ0s88aIW62Rz8NB2wwLAzbxa
 pYMj4+/niZ8LxIBgo0IRYgU5rj2t1cHGSG0GHq4CZd+094Ib9pR1/v9n1zy3Wssb1aVj
 t5K9k29bXJC9UwCciXVqsHzjG6GyJ4HDWjTigtIj0KYJU9k7zq/IKJvE0ahQpEJhUxCi
 +yCXgVijM+YEwcX7CZUjD/Bh1Q/eUdOeTx7fpLIIc9dOoS25JLviBuqe9aRFabxf1IlF
 7sNpDIo5l4DXH/XkdGPNxIEoMw+XJP2AWLgw9gucXsBtP/e2wfPSeo0k737SieO1S7nl pQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pu79qjgux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:13:36 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 60AE9400D9;
        Tue, 11 Apr 2023 01:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681175616; bh=HL09wiykAIo41TmZL8bLZkdzxERYFmTKrYm0jwHe8Bg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LUadtC2mVQba8RofWS7mDqoep7OzcXyvPG5aDONPXajmP4QSVco1EUOuAxjIBsYOU
         7o3+aV4dZcx+H/h8/3yi8Beo2o15SEoq2EZZD1xWK5MElFe3Hva2pRde1JlZmGF8+Y
         GVcLXTaiv2XfmziMCNa7qRERVvL/Uct47VsQJmFDqTUeab6fnZ7qjN4n7SWDM6vj18
         fJqxGinTccNi1o4yWYVm+ap/f1yRSTsuMFx5amSdJ/FRLusQccdocJXX3khJrJcsGd
         1kwC8pD3KjUs4MEvthu4eWAhYbc9rT0F62uOFCnhFLU+ITcqkdjXSrynOrfovxP0E/
         6WFfldEZpBYVg==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A382DA00C3;
        Tue, 11 Apr 2023 01:13:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2B01B80008;
        Tue, 11 Apr 2023 01:13:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qnpfc92T";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5lfQnC58LWObdsftzzbg1zuQ4WcIuJP3c1lnJ8F8y4CpmDhgQbAsP05NFsr3n2ORLMXoLEG9RojL2ynbqNV/S+eN0UO9NmiSwv6c//WM+ebjctQ5hGfKmApoTaA9Ixb5I0u48i1O+wDF78kHo5ELAjXvLjRninV6aUxoBX1DbkIUjv368BxwUa7zz42ikCF0BHcYrNAh+jTYaWiKyVx6xbmZVnNu1CNwj/px4lcva2MZKPNJT5SZZa4tykTLO2xg3NjqGkkm5F/N1mYydraYArRmvS4pJVizhipsB2ctO/Lh2AuqkTHSLhiWMPR/FBhfZxcZHfbT9WoSgNB5juLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL09wiykAIo41TmZL8bLZkdzxERYFmTKrYm0jwHe8Bg=;
 b=nu2eIl0ta+1Rx1HK1hDCEK3CLNxoI/Yz56bq2s+xS168NDazQ37zSvKiauX3SadxFTjts7d1Hik2oGPgh/hHyPHrmzxlWuRSXUxtxAtKeGjbwYp5cshTkLkD4y0ELivhaRLMf9gHBPwxmpivTf9dB/luJ6VgFrg16WdewqviCPo7IM2qRjCW4EIavszSWrE3fTbEZ+Ji9mv6C6kMzM1gx1q8o2VNk+JaX0eVwj4v8USEkydT1G8RYZmR9ZYUqBJ8V9U61VWbtPYPR/ODQXuDs6qUpoZ6Wuf1L9fARG7H+h8A/5bCDhIaVcoCDDnZMwGdJvL4xZ7eItmsYwp+GGcBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL09wiykAIo41TmZL8bLZkdzxERYFmTKrYm0jwHe8Bg=;
 b=qnpfc92TYV7drnd2HJf6VL3ljtiSrYcjvL5wxZ2xcKKlfKjm3yrlYHYADFWu9kYcIBwDcMJUULoK7vP9NOAUbnLHCQbQvP8edgoZDAEdj21KAsbDHGsZgSU/vNfIquhxC15mGuMJf6rGJqECucENUh9F4Kkwb0ZRUPM8TWsmQjg=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 01:13:31 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf%6]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 01:13:31 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v3 1/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Thread-Topic: [PATCH v3 1/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Thread-Index: AQHZbAMDFwwSwHNHbUijwcQavNUaaK8lTZ2A
Date:   Tue, 11 Apr 2023 01:13:30 +0000
Message-ID: <20230411011327.l2u4a6ijnvggmbmj@synopsys.com>
References: <20230410231954.437-1-quic_wcheng@quicinc.com>
 <20230410231954.437-2-quic_wcheng@quicinc.com>
In-Reply-To: <20230410231954.437-2-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|MN2PR12MB4439:EE_
x-ms-office365-filtering-correlation-id: 8c6d6a90-94fd-4e62-54de-08db3a29f67b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFRDrBRumI3Mo/JkqgOmjh8Pe+WIggSVumwiVGsb6QSeWgv/s1tDzCBim5RRdFYnyZKTj8dkdwjl5j8ClikcIeCVdwv8ZeaEP1exM/urVYn1JwVc6pb+X8FJVES5YsK37/xBgdXdQE1pxpBfIynndKLdG5miwKmd57epfkTAYMzzcGigGo76zJ+XtgeTCusVZc8KflKBleTvoqdwTZ4yQ3B0UdW8amYStDRIGpcBa5bf2Hc4IYL/6+wLlpe4BZxF6bReFFgbqa6fgr9DW6cmWAkxjKpngZDOvJgwHMXfqL2OhlK0j5DOyTSW0HBVTBlzdL2JvdAKyis8V6DtIC5MzPheDzC6HFvyJ2pSmz7T+zb+1+tH4VqofeWXjVhkdcrsu9E3ckqskn4ue2r++PJjxwLVwb/QBSV3T8mWJRlHz3hBtQHHbRlLFNQ2YhbpL3/eil/qgwdKmaVFMNwTcf3k//YPIW8DZMgPK9a18j6wqCOcrraD6lbQWCFPnySDWHwqZExdeRsrCbVCvGmO6OGzLVj3WmIn4uRjZJtHin9lMjMLHF+tjEFbawL5pH91VQZ62oBe+QtnyPCdXVYoS7Eb3tdvqzIbdG9HgovR7zVGjsONS5Gd0t2MbQwnpU0Cme0eGTQtMqS1QT2xXh/WYVYqtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39850400004)(396003)(451199021)(2906002)(122000001)(71200400001)(86362001)(83380400001)(6512007)(6506007)(26005)(38100700002)(186003)(1076003)(2616005)(316002)(38070700005)(5660300002)(54906003)(8936002)(41300700001)(6486002)(91956017)(36756003)(478600001)(66946007)(4326008)(64756008)(66446008)(66476007)(8676002)(66556008)(6916009)(76116006)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHlmZXB6bFZETVFSRjNBQWdRQ2FtZHE4UVJtZ3gwNEhFUVo4SnMyWFAwcG9n?=
 =?utf-8?B?QTZYUEZ6VDZFNGttK0hHaEFHNzByV3Y5QWJmTVFsYVV4dWlMYldoWWtlYXVV?=
 =?utf-8?B?elF6eFkxT01oWHo1QUsxei9VWTJ6dGJrNXF0by9xM1FUdkVkOEFWc1ViYlVx?=
 =?utf-8?B?S1lWZGpxdnpJcFBkamgrZ1JseGZWLy90Z3F0dTJwUnd0WmFWaFozNC9hNVNv?=
 =?utf-8?B?ZFVBR05VL2JTdXh0TUJNVFlPVzBYY1ZzMGdoYmVKZUphUjBCai82SXc4YUJB?=
 =?utf-8?B?VWM2SVNDU044Y1dObkZqZVhZVStwWXZEck9BeHJQY2FwTW5jR0Njd3pvU1gx?=
 =?utf-8?B?NFJZblVEQkZGMmU2V3VpempGSTJTR0dISzhVYlk3dy9NQ3hDWXY5NEVRZmNt?=
 =?utf-8?B?OGM5VjZwN0ZSWFVMamNscUlvWFNYaEJmakMrdWo2Uk4wZ05pVU9Lb1Zwa3cy?=
 =?utf-8?B?a0lHQWVCZVFqRmMvUERQV0JJdC80ZDJPVC82UllsVExoUncyeDM0L1Rid3cw?=
 =?utf-8?B?WWpUUmNvSlpJeVRscWFyVHUzd1ZKMldWRmVGakRwK1RoektxdjZwVFJiRHI4?=
 =?utf-8?B?dG9hSkpXSWZqcDVOenErN002N2xOVHNqSWFacHJZT2VsUUViNXJ2SVZRNWRD?=
 =?utf-8?B?TjRpWSs3M1VzRXkxVWFOeVdQd1l3SlpLTnA3eFc0Tnp2WklhaEI0bHhlSnA2?=
 =?utf-8?B?dDd0MFhQRTB5elVOSENPYnI1YXlxZUU0Q0VjWTFIbS9OenRFY3lTZUw1cCto?=
 =?utf-8?B?VVJZOGxFSGZPUkdFU3FFY3NPZ1l4cGRQVkY1M0hYTS82VmZNeHk4Zm0xNjRZ?=
 =?utf-8?B?clc1cElJNTVBbXlPWTdPMzRyNmdJNWRrbml1ZkVRL3llRjA0TlV5NnIremps?=
 =?utf-8?B?Z0FBL2tjQUw4VzlBZk95ZEVlN1J1UUMvUGZnVk1hV3lFaWcwYUEwUWRyTmZr?=
 =?utf-8?B?WXM0MW1sRTZteDNGMkZ4WW1lQVk1aURjM1pndGlSYnY0N0R3anlnb2h1dVFF?=
 =?utf-8?B?Tk4vNzVQUlFxckNQUFZ5OHk4RkJoeGVySHA5M1A4QzNmQWpsMDlZcW13cFRs?=
 =?utf-8?B?NXlnWmJ6MllseGgrTmhpbnMyNjNOUWgrZE9yV2o5WE9uRGFJMmlyNG9Va2dS?=
 =?utf-8?B?L1dwazVNZlNxaWNIaE5MWlo0dDNKQVkvQ0I3TkVyb1pPRlhEemNDeXRYNmpS?=
 =?utf-8?B?RUhrdm5GR25mZHhQWmFjN0ZXbHBwcjJLSktoanhsdHVMQ2djV1YyQWJ3WHVx?=
 =?utf-8?B?Y29OWmR5NGFKNUtiS1pNWHp5L2VXdE5vVGtWVm1mdWViTzdpK01XUFlDYzZH?=
 =?utf-8?B?bEUwdUFOaTZidHM2TXZUZ1JZQWZhN1lVQlVUVTkyS29iUVoxNDZVWExkVDZa?=
 =?utf-8?B?WHpIYjJkYWVPRld6RHg1R2UwUzN6dHRyYkdzVWVhK0d1V0JYUFdhTktXY1c3?=
 =?utf-8?B?WDdyV3ZBQngvS0d3UFY4aFFLVEZpd2xCTUNPU2YyMlIyL01IWGJucjM0bGZR?=
 =?utf-8?B?ZHdVVHF3eVhaeFRTUlpDZUhjQUVXaGc2c1JPaTgwQXBGRVNoeUxUNjdJTkR3?=
 =?utf-8?B?WnJTSExwMmQxTmJlR1BCOG8yTXpSRmxPRzFFTTAxTjVWOFZaclBmN0IzZ21s?=
 =?utf-8?B?N0Q0S251akovSnpRSjJZZUZiWXc5c3FNbHNIYXlUSWcwaDVtMzg5Rms3dlps?=
 =?utf-8?B?T0xaTURJak1JbmpBVkRicU9mZE5DSTllSktleWtnRnV4RUtoTWtZNUMwOWwx?=
 =?utf-8?B?T1BQeEE1bVI1ZnZ5d0VqRC90MEZGbkFCWDRaSmpCdXJoTG8wcVMvNjFpRVlZ?=
 =?utf-8?B?WlRUa0NEVEtSL1dGMTNuZTEwME9XWGhqeUtmMmNUMDdXQWZNOWIxc2xjN2xt?=
 =?utf-8?B?SDRUYWZMSHhnRlpOZFZhRGluekFoK3g5b2lhNUpmTjVKVWtlZkZYOHd3bTZP?=
 =?utf-8?B?L3ZiU0VsOUFHeFUvOVVXL2Q0bERaSXNXWWhwWElXanc5d0IxbEpLRFY4OXlK?=
 =?utf-8?B?U01FaW1ZY3N6TU1PbEZpZDBGclpScDVjdlUyeE1Yd3FtNHlmMFlkakdJTHE3?=
 =?utf-8?B?a2xHYVd6dHByZVlQMFJJbVNQUVBYcE1jK2NoRXlUTXNWVFdMNjhWaDhmd1Rj?=
 =?utf-8?Q?WaUY2SNZX/CuE0S6CDR/COIT1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EEC0A8A768B7E4E81631A44ABA1CF7F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jUZlOTuhM5+tdAwlhBNkyvCMzDfw9zq+kNHHo/DUmth665lSsZG80r4WytDFZERKFr5kyWo6HrxMAG/w6hy92OiQBof7oKX8Wwsmm9NyLLQkTDzv4mDN6ikG15726shTW75OjiOuuSjZKBEQ4C5zXdHD4BTi/xaemyFeJRobAJoPluxman/obnlNJxBXOjMRyRbFlHv+uD3BDV/xDEyAniavBs9skfn2u9dcnZ2dred4FP8PfBUfc8MKLFkwPBhsUq8ekYyyv01dKtZeEa17B7+3aUr0aS3f6hqQbWWLJwIIZON64aWHcYbsEYfM/jKVSYGbYZsNW2UB/AG3wgK9UGTGMz/mP62/g4KAYligTLay6IyEY4nnEUXquyh3RnsqzaLPtp8vXDGsV4bSnNSquRJTpoit0IsBkmhmtmwqhGKVtfWhaxElF8S6Gs0feWOK1cgIUF/Gg6d/2k76nN7PyZfTz+bP5pIQRf2HBMzLilJlrT9ENGMK7UYu14azWUug/CdwOl4NtKR5dnnDgCAegUIx/56xz9U5WSF/JbUHJ8psVx3UrrJFlGVsPe7dz3A8AuR0Rza/6BvJpMlIoEEeyfVTe/gCGnlij+oHOPMiJxrmhIlmHeH/Qf47P2KTyzuJDh0jg3zjeTFj3DKKZ6XIunpNpP7OAGeidKZPqrjDqZVplSh4Zj0aB843TTXt1p1cEvn8p2D8wy8vuR+NzKG2GHH1xlRRAAMkuwBidvIIN4GG2jm3ZSyQ7oRsRYEzkbI70I+UBNC4WayAEchSo+l2aaKjAhltDaMLbPDnmjuD8lO8Nf+XDuQLKhubbp+VLOyVbvwhLWKme/8mNMz843rWIrjaGFj5I0WkHrafa2iFJbB+TByJfVYZy4CT55AzPDFcZ02ie3CJOzePAMo46pgeXw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6d6a90-94fd-4e62-54de-08db3a29f67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:13:30.6100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: avCXYa/0omgRIzJC2+rU7TN7bvgrp7wnQgl6wFcPRgWJ+OUisHDYwZ7HEtPvn/Z9yrbGnTmXm1qW/fT5DdT6CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Proofpoint-ORIG-GUID: NwpHQXToeJS9vuoF0b6Soem3UbnMHJJV
X-Proofpoint-GUID: NwpHQXToeJS9vuoF0b6Soem3UbnMHJJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110009
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTAsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gU2V2ZXJhbCBzZXF1
ZW5jZXMgdXRpbGl6ZSB0aGUgc2FtZSByb3V0aW5lIGZvciBmb3JjaW5nIHRoZSBjb250cm9sIGVu
ZHBvaW50DQo+IGJhY2sgaW50byB0aGUgU0VUVVAgcGhhc2UuICBUaGlzIGlzIHJlcXVpcmVkLCBi
ZWNhdXNlIHRob3NlIG9wZXJhdGlvbnMgbmVlZA0KPiB0byBlbnN1cmUgdGhhdCBFUDAgaXMgYmFj
ayBpbiB0aGUgZGVmYXVsdCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVu
ZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IGluZGV4IDNjNjNmYTk3YTY4MC4uMzIwZTMwNDc2Yzg4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gQEAgLTEzOSw2ICsxMzksMjQgQEAgaW50IGR3YzNfZ2FkZ2V0X3NldF9saW5r
X3N0YXRlKHN0cnVjdCBkd2MzICpkd2MsIGVudW0gZHdjM19saW5rX3N0YXRlIHN0YXRlKQ0KPiAg
CXJldHVybiAtRVRJTUVET1VUOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2VwMF9y
ZXNldF9zdGF0ZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXVuc2lnbmVkIGludAlkaXI7
DQo+ICsNCj4gKwlpZiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBfU0VUVVBfUEhBU0UpIHsNCj4gKwkJ
ZGlyID0gISFkd2MtPmVwMF9leHBlY3RfaW47DQo+ICsJCWlmIChkd2MtPmVwMHN0YXRlID09IEVQ
MF9EQVRBX1BIQVNFKQ0KPiArCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+
ZXBzW2Rpcl0pOw0KPiArCQllbHNlDQo+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3
YywgZHdjLT5lcHNbIWRpcl0pOw0KPiArDQo+ICsJCWR3Yy0+ZXBzWzBdLT50cmJfZW5xdWV1ZSA9
IDA7DQo+ICsJCWR3Yy0+ZXBzWzFdLT50cmJfZW5xdWV1ZSA9IDA7DQo+ICsNCj4gKwkJZHdjM19l
cDBfc3RhbGxfYW5kX3Jlc3RhcnQoZHdjKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAg
ICogZHdjM19lcF9pbmNfdHJiIC0gaW5jcmVtZW50IGEgdHJiIGluZGV4Lg0KPiAgICogQGluZGV4
OiBQb2ludGVyIHRvIHRoZSBUUkIgaW5kZXggdG8gaW5jcmVtZW50Lg0KPiBAQCAtMzgyMSwxNiAr
MzgzOSw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2Rpc2Nvbm5lY3RfaW50ZXJydXB0KHN0
cnVjdCBkd2MzICpkd2MpDQo+ICAJZHdjLT5zZXR1cF9wYWNrZXRfcGVuZGluZyA9IGZhbHNlOw0K
PiAgCXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3Yy0+Z2FkZ2V0LCBVU0JfU1RBVEVfTk9UQVRUQUNI
RUQpOw0KPiAgDQo+IC0JaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BIQVNFKSB7DQo+
IC0JCXVuc2lnbmVkIGludCAgICBkaXI7DQo+IC0NCj4gLQkJZGlyID0gISFkd2MtPmVwMF9leHBl
Y3RfaW47DQo+IC0JCWlmIChkd2MtPmVwMHN0YXRlID09IEVQMF9EQVRBX1BIQVNFKQ0KPiAtCQkJ
ZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzW2Rpcl0pOw0KPiAtCQllbHNl
DQo+IC0JCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbIWRpcl0pOw0K
PiAtCQlkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydChkd2MpOw0KPiAtCX0NCj4gKwlkd2MzX2Vw
MF9yZXNldF9zdGF0ZShkd2MpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdl
dF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gQEAgLTM4ODQsMjAgKzM4OTMs
NyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMg
KmR3YykNCj4gIAkgKiBwaGFzZS4gU28gZW5zdXJlIHRoYXQgRVAwIGlzIGluIHNldHVwIHBoYXNl
IGJ5IGlzc3VpbmcgYSBzdGFsbA0KPiAgCSAqIGFuZCByZXN0YXJ0IGlmIEVQMCBpcyBub3QgaW4g
c2V0dXAgcGhhc2UuDQo+ICAJICovDQo+IC0JaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQ
X1BIQVNFKSB7DQo+IC0JCXVuc2lnbmVkIGludAlkaXI7DQo+IC0NCj4gLQkJZGlyID0gISFkd2Mt
PmVwMF9leHBlY3RfaW47DQo+IC0JCWlmIChkd2MtPmVwMHN0YXRlID09IEVQMF9EQVRBX1BIQVNF
KQ0KPiAtCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzW2Rpcl0pOw0K
PiAtCQllbHNlDQo+IC0JCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNb
IWRpcl0pOw0KPiAtDQo+IC0JCWR3Yy0+ZXBzWzBdLT50cmJfZW5xdWV1ZSA9IDA7DQo+IC0JCWR3
Yy0+ZXBzWzFdLT50cmJfZW5xdWV1ZSA9IDA7DQo+IC0NCj4gLQkJZHdjM19lcDBfc3RhbGxfYW5k
X3Jlc3RhcnQoZHdjKTsNCj4gLQl9DQo+ICsJZHdjM19lcDBfcmVzZXRfc3RhdGUoZHdjKTsNCj4g
IA0KPiAgCS8qDQo+ICAJICogSW4gdGhlIFN5bm9wc2lzIERlc2lnbldhcmUgQ29yZXMgVVNCMyBE
YXRhYm9vayBSZXYuIDMuMzBhDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

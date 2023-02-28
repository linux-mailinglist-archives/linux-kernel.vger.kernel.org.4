Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC68B6A63D7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjB1Xlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjB1Xls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:41:48 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A366736443;
        Tue, 28 Feb 2023 15:41:47 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SLX9N3018831;
        Tue, 28 Feb 2023 15:41:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=1omocO2r5/F3Mb1nAWr4ccY0G5BRJTcjcDd9gnOejjg=;
 b=KOTJfgxiv6M3HcZ+q399xi34qUHIdFvYE/UyVAyeTZjqQDW8t9ekIEFmEviJXa6MUWa4
 ngko/pzTq8fpRmueQnOvLWi1ZtgQaT06UkvRSprrX9wMD/lcjbKiQAHT7xd9dlDTnf6B
 3KZJXnG2lBvPwR+aOoyLmji8jm8/2Oqi2ojiR00t2Jekp0zLP0VIMFb9l+Yr/qnbqgoZ
 c+zy6C7nRTWcgGaDovTeoR8WPVtGn5WCYElurMp0LNg1iFH7elpPMtt0Mov0q2CIQB0/
 EguVa5P/AB2wvCdM1L4b2H8XTvBBJuB88OxLF3wzZBc/gZLGRNyMoBMYR9+qhaWPWJn/ +w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nyjfdb161-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 15:41:44 -0800
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2A43C00F9;
        Tue, 28 Feb 2023 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677627704; bh=1omocO2r5/F3Mb1nAWr4ccY0G5BRJTcjcDd9gnOejjg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HW0XOTp8+le/U7veRFTUFGn329ZBIaDgDF/WC8p2qDvpbIAccRIBLsEZAVse2kIoe
         uGW8iMlvogRSH7wy3X2Qqc1aDl3Gh6Mgt99ZgR2rNBfuH5oeTuCwG98eUoxJHDMF3l
         FOF/fiP6CbwPISyqBbWjOkEw3lfsS9HotlgrhGzpAE2aw0PTbdgybmM9EFzzKf9DEY
         ToouquvtAl08GCk3xbri8o/gXnjxZYjkvzXo9eauMj5oUGtp+3xhtpqcCm7goN26HI
         LrwSGI2+VsLkW1czncx85VcnWuPnsE4+2cSnQwGTz3MF7zyT1MMp7JDRw3VrJ9jHMP
         iDZMs9b3g7LBw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D0A4AA00CE;
        Tue, 28 Feb 2023 23:41:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 27B1D800C4;
        Tue, 28 Feb 2023 23:41:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HG19FZi2";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHp86ynkSNFqa8EFkh8Xw9e45UAVwWnrVTx/P53OdmjFTLQYmZk9NCp/+L43CIram2naZvGFdtd1TbW5e8l8z004Ya91OW5asmBUuU9i5EgktK9Do2XyS4LWH1fD/rx0WFfa5Y+TeM8AOfZBb6POWplfGkaOB0em08G0zyBzjqo9nd+Zoq7on/iIqYTtZktS3ZuP2HdxPgk31HXChbbGR56ghsoeS47edpATd710OlBGJKcNlbHLZVPHRn2EzriaWqRm5I13+u26rTd9cU/HoKO3I8qzgfHytJS/pzZV3/RF3hAeDwl+tGsF2r/IWWKEEOSwg9SFJx+PNAcERDgpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1omocO2r5/F3Mb1nAWr4ccY0G5BRJTcjcDd9gnOejjg=;
 b=UwNLuf7g8rlR1gpaFIpbl7xGgdJz4H2TXOKThuTspJliHF1IphgpsLdBy4waHOclRJJDi6fufQ/so3o/BEZJ4i38Qpd5boKSBEhrpC0Jb640zpJAd0xvZc9EaHFpvEm+PDD3jRZLqclWP/TTivXynZ5XCxIhe+FEsmnSEiiky3Er7rTJ06GDceDbQiff1ChYgys/pKCHRaSy1W7QVj9fIbSLa3FksU3fO1YaTzaocneZYjgrleZJDbHJO8vpzdgm7q8zumTO94xW01GFbZ7RWyc9PHfVpSJSyhc/6zjtR3nDQZNTElpG1fam+Id0ZfsnWUit0aRlJ/D/MJ2flzB0pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1omocO2r5/F3Mb1nAWr4ccY0G5BRJTcjcDd9gnOejjg=;
 b=HG19FZi2q+gTcsIe772H+a1TeQlu0bVYd5Q2eWv/LBrB9oZp7ZM1vqzrD+yej5faY9l97ZmGs9Qvamf9mkIxq2PVMyZESP84NuIqgh/QPdCfuWeFktEqv1jmu9x9vXiXUKip2FsqYCoSgojTfQxapCytTKGAp/ajj7ib1IAPYrg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 23:41:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 23:41:37 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Jack Pham <quic_jackp@quicinc.com>
CC:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Add 1ms delay after end transfer
 command without IOC
Thread-Index: AQHZS7KwrAW/39yt4ky5Z3r/ljRbmK7lAWgAgAADlYA=
Date:   Tue, 28 Feb 2023 23:41:37 +0000
Message-ID: <20230228234135.gafwzmokvxmlfhvs@synopsys.com>
References: <20230228202418.9126-1-quic_wcheng@quicinc.com>
 <20230228232846.GB3727894@hu-jackp-lv.qualcomm.com>
In-Reply-To: <20230228232846.GB3727894@hu-jackp-lv.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4109:EE_
x-ms-office365-filtering-correlation-id: 82550572-7a20-4be8-560d-08db19e55560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9mj6hvTINO3h6c7BqJVrws40Mz92ZtKbrN/1UnQrJHDMabAIMw4Wuq/P2z3pLMzLCLDp7RNj3gAA/ZTSyICOJaZmOjmhl5LEFk6koYIOC1RWZo1GvuxpR3PnbsDx6hrqe3mx93zs0kRxcgIuWN6uvomI7xSsmUfIciQAXpPRswT8+TDb/m9K0FZ3f7AGq6NO2+f9LqN09iOGQ3Y8Ll6F/xp7oV6/4e9VIt9bhZOyKvAO+6mY/ltAelCZK8gJWokcGMVYTRRanZcFxDAM/4xvHDqovPymxpouF9/TYEjxcWW/aWMLozCeOtXqsummC3I0P6XCb2u3DCtzAvx2zTskTXeatGNGo3cy9c/6gD3N/EKLLornBuTGvBO6t4ScsMkhcGYBIfkBr0tUT2X6AroClC/KAZDXbYi2i8DPzezmqjfwB64RJTgD3rpPa07nUFpcmq0SvBT9ktKAuXt66W2S10KrjRPgbW1PZ2flU//iFqTl/nwD+fs/8Vr/vaJ1fk8tOV8RYzjd1d4SyB1zKFthySzU+Og1j+/ZM4VP97TKwDitKxt+05Ag/tcny+6Cfd1sjS8JZAxdtnxWVs+CgwA+sNS3ixSSNk0iCR79m4sPHI+uAuIIbBKupngX+Yb5WB8NzEgKKDlO2kLHrhIpAJ1tjBekQ/6fu7a5cdFDy5ecFo3go+oT5zOd0q6k37/luxVd/IQAnAg2W3O2iUtRuG3fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(83380400001)(36756003)(6506007)(316002)(54906003)(478600001)(38070700005)(122000001)(2616005)(26005)(41300700001)(186003)(71200400001)(1076003)(6486002)(6512007)(3716004)(38100700002)(8936002)(2906002)(86362001)(5660300002)(66476007)(66446008)(76116006)(66556008)(66946007)(8676002)(6916009)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW9pK0k4ZGovaFNSc3RQckgzUDROdmNOcUJ6dzNBWXp6N3NMWVhlVkt1ekJ3?=
 =?utf-8?B?VkYwYVgrR1RjYThlYkErUkVudDkxR1RvcHhtV1VtU21TQmZhZ2F2NFJrY0ht?=
 =?utf-8?B?cVdrbWM2VzY5ZGxIQmdtOUpiam1wMWVsZmtMbjFHMi9MZnU2RHdsMUtQTnhS?=
 =?utf-8?B?TzZERS9YaENmZFJmK2dGREdvNm5hREMvTmlrYnYrNjRGaXVRenhhKzYrbW1x?=
 =?utf-8?B?Z3NzNnlzRlc4MDZPaHkvM1NmZDdpcXlEdTF4WUxEZUNWZFBSOWRza3crQm9t?=
 =?utf-8?B?R3lOdGo1NzZrTnc1dlFJa01wbGxlMW5yWHhkYnFaNEh2RVdqMnFld2tIcURO?=
 =?utf-8?B?c2NCMW9ITFBwWVNtMklYcWd2a2R6Mkc5UCtmRFFRYUc0ZEpFWWRLTHVCTmow?=
 =?utf-8?B?K2Y3VHU1dHlRQXpqdkppR1luT0k5WnpMak1laE11bjhvL29ZWlRZcmg3dnJY?=
 =?utf-8?B?TnBHMXNFdi83Wkg0YlRKQ1VLcHc1dm9EVzV3cnFHSmdTTk1UVVNRZFB2MnZj?=
 =?utf-8?B?UkhoV2FkWVZNVDYxUmErZVlnVnA0QTIzLzAxVFZlYXJrQWMrZWMwODhodll6?=
 =?utf-8?B?MXZuRHN4WXM3SVFoeEdVSmRPUnE0Vkpobzg4RWdSbkE2cmk4bU1WQXFxZnVv?=
 =?utf-8?B?b2hBSmFJcm9JdUpINzBwWmV6dlRMa1FsUnVXOUZOalE0Q3FudVBaQzhrQ2M1?=
 =?utf-8?B?SUdQa3pUQURMSzJOUVA1d1BlVzhGbmVLT0FZbDh5aUc5RWJCSmJISHdaU1Zv?=
 =?utf-8?B?TnNNSk1ZY29nbFpvcDU0YnBaQW94T0JXKzBaZnN5c2Zpb1dKd1pFandTYnhv?=
 =?utf-8?B?RzR4NG1QL1IvK3lydGtoM3ZQRmtqeUM3R2dqaUJsdStxaTVlbEU2WEZ3NEF2?=
 =?utf-8?B?NUxadWU0czc5b1ZKOUJoMG1BQzR2Q3dkYVJ3RGkxNkNsUnlZbDZZTWNHd2da?=
 =?utf-8?B?NW5SVTB0S1RYNGsrYU1mdFozUTByam43ZXZXMGQ4Njd4RjlnRzcyR1BVMmhx?=
 =?utf-8?B?T2lGQ2tBeWRlQTg3ZVZkUXcveWNZRFJtVXUvalF4Und4bCt5cXM5cStPbEVI?=
 =?utf-8?B?MmE0dnoxcDBkZkNtZDNoRUJkQzh5UXJ5c2tad1BkSTgvTUpPcmVNTlNxc1R2?=
 =?utf-8?B?dHkybDhRb2tYYjFxSHYxK1M5ZmdPOEVLekQ4QVcybUpCcUlYNWRIVnFzdlV3?=
 =?utf-8?B?MWNBTTNva1NvbitTVTdZNHJLSGJCR1FhY2VuQUlURHJYYWIwNi8zMi9JYWw5?=
 =?utf-8?B?bXlHM1QvVitNMCtBWi9XU1RRbXUwOEU1cTFwM21xaVdPYmw1bUJjTFV5SEx2?=
 =?utf-8?B?RWxmY3ZkUUdPZXNKcmtBYThlNXBiWUlWQjYrcWo0MmgwamF6QWVMQldEd2xU?=
 =?utf-8?B?cXQ4MDhzMUJKRkVXLzVYSFRlbjNuZGFOc2MrVWwwZUEveTRZZ1pQYW5KRzhU?=
 =?utf-8?B?Z2R2S252NjIwbDJERnRBZTFiOFIreFJtM2ZOWHlud1F4VjVmZWxJUkpPUnFU?=
 =?utf-8?B?cDV0OXBLaGJKdHp5a1hrbDhQS3Y4Q3E2SFprYmxYU3ZTaEtMMXZtMHVUL3Jm?=
 =?utf-8?B?SkJZOXVtZ2cxelBZYitMWjEyS0VHUU5xeG9OeVZlelVrS0EwQ0E3VzFxOFlH?=
 =?utf-8?B?UGFnbUcyOXI0OWhRcjdhQTlwcFgwektzVUExZ1dxZ21WaHJSUURwdUd6UlZT?=
 =?utf-8?B?OWxmYzE4eUZKQjVPd2drMldEVzZLcFpiNm11Q1VPZ3VEc0ZUa1Fxam9EMWE1?=
 =?utf-8?B?RGtSSUJzQmRTUEtjdDNNUGU3TWtYdjJGaHovVWxESVM2d0NPaWtYZlczRDhk?=
 =?utf-8?B?Wmw3U3h6ZlFiQ3hhTjdsUDd5bVVFK3RwTE8xUkwzc0l4UTJIRHpaT2RCNWRn?=
 =?utf-8?B?YkthNXlXdnJOQ1ZHYXhuTUtRRjlEcFo0bXY0Z1NETFpjdE1rVTBDM0I0NStZ?=
 =?utf-8?B?R05FVXloWThjaXZVbmRySWd2T1Ntd1A1V2p0MVhVd1JlT2pFeWVYNThMTm0y?=
 =?utf-8?B?WW9uRHJ6UlJyMHU0WmVZaDhMZVlmMlA5V29JQUJmZ2R6SDhZTmVuTDhBZVdu?=
 =?utf-8?B?NWlRRjhBRmpib2RyVy9xY1J2eWlLam1ueUZYUVczQmRVd3Y1TCtnV0p0YVZ2?=
 =?utf-8?B?Q1BiL2ljcWNCMXFiUnZPcTFTZ1ZSMzRZVlN5bWlzdFlJZ1ZhMTRDdW9ib1E1?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8064A64BE861374EB5734E1CA668633A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0mszU/GhSWiKpVU2byu3HbyLcrePluNWeTJ2TDJERbA/eSjA2Rb3ppXA0PkC3CJjC9RM7uuhFssXJTmp/RH9dF9ME5TgaiNcsalqbqSSAJKEn28+5P9m+xYlLYlzQompnbE9AQlaSukUH4SaIK+DZM2EChJVDzpvFkd6coUPqy+Mx+SPNsQ3F8HIp0Ez3hxnPc3o5U0X1RZFznjgqtHLAmp7P48/468jZrZOyShqHJaFED2y0ZHDe6YIfD+vYNcQvkBT7t9jty8+nx6vUXozGTTWrZSdZrvaL60zTPjjJg2/vjF3wpgy5vXzIh6zdud+h9S619CYxMsMy8RwLANejlggksUjAHvN3socBofHRPE4BAYJhZr2O48HDmlUNkAm0pBLR/LwFMgjqbAhBIV65CtuKsjESAlwypDUeNbfkh2LWILmpmAOGHNWoAgvftUy//NLli1GSCHr/DzzxFrKtZR7qtEaj5k5NHYNBhtp+7vjzq6+XbHX0y4y14N+XIgM0Ms5aWl84ilCIIxL2V6jO4fuhRCOFJt2Vmpb6lTOSj6HM6VL5X3TKgb30Ejy6v42ssDKiDCYsSQ5RVH6N9DTlDrPM6JV5AKoR7E2CHbXH9zkvoCPqWM79mDFFOvbcVbASpBRHVYQyPXN3x7VWljclKjbQeG5GupYUTJyRuL+HkQ+oVf/9iWmMO4hGZuMCB8tVNPnTD3E2u1/TxX6JJn48zaYupAwPo46Fujt3JD+DRGfs00pm4QVo1gvnY/LNu9iSqXApgdhesYxQA/XGbMl++pAwDApU3Ca95OH6p2uYzsOAWsVsJO0G4mIMT5fS+TSA9sYbhkUE9pDxShaUo2464GXHynGi4dNlRCIMfY3fRpn/aA9K7oZd2KYy6jbyioDfb5/AyUhFyCS3JfFC4gCTw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82550572-7a20-4be8-560d-08db19e55560
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 23:41:37.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU49cgMhU0F5XeTi34OBDKdg3mVV5qsCdObA0D4Awz7Sc1U9TTeXGxWaxSdeuAADLmJRmcCJyQo1nRT6KNQTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Proofpoint-GUID: Sb8YDaWOo9ZhiixP3zN4EYwVHvMeNze3
X-Proofpoint-ORIG-GUID: Sb8YDaWOo9ZhiixP3zN4EYwVHvMeNze3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_17,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=732
 impostorscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjgsIDIwMjMsIEphY2sgUGhhbSB3cm90ZToNCj4gT24gVHVlLCBGZWIgMjgs
IDIwMjMgYXQgMTI6MjQ6MThQTSAtMDgwMCwgV2VzbGV5IENoZW5nIHdyb3RlOg0KPiA+IFByZXZp
b3VzbHksIHRoZXJlIHdhcyBhIDEwMHVTIGRlbGF5IGluc2VydGVkIGFmdGVyIGlzc3VpbmcgYW4g
ZW5kIHRyYW5zZmVyDQo+ID4gY29tbWFuZCBmb3Igc3BlY2lmaWMgY29udHJvbGxlciByZXZpc2lv
bnMuICBUaGlzIHdhcyBkdWUgdG8gdGhlIGZhY3QgdGhhdA0KPiA+IHRoZXJlIHdhcyBhIEdVQ1RM
MiBiaXQgZmllbGQgd2hpY2ggZW5hYmxlZCBzeW5jaHJvbm91cyBjb21wbGV0aW9uIG9mIHRoZQ0K
PiA+IGVuZCB0cmFuc2ZlciBjb21tYW5kIG9uY2UgdGhlIENNREFDVCBiaXQgd2FzIGNsZWFyZWQg
aW4gdGhlIERFUENNRA0KPiA+IHJlZ2lzdGVyLiAgU2luY2UgdGhpcyBiaXQgZG9lcyBub3QgZXhp
c3QgZm9yIGFsbCBjb250cm9sbGVyIHJldmlzaW9ucywgYWRkDQo+ID4gdGhlIGRlbGF5IGJhY2sg
aW4sIGFuZCBpbmNyZWFzZSB0aGUgZHVyYXRpb24gdG8gMW1zIGZvciB0aGUgY29udHJvbGxlciB0
bw0KPiA+IGNvbXBsZXRlIHRoZSBjb21tYW5kLg0KPiA+IA0KPiA+IEFuIGlzc3VlIHdhcyBzZWVu
IHdoZXJlIHRoZSBVU0IgcmVxdWVzdCBidWZmZXIgd2FzIHVubWFwcGVkIHdoaWxlIHRoZSBEV0Mz
DQo+ID4gY29udHJvbGxlciB3YXMgc3RpbGwgYWNjZXNzaW5nIHRoZSBUUkIuICBIb3dldmVyLCBp
dCB3YXMgY29uZmlybWVkIHRoYXQgdGhlDQo+ID4gZW5kIHRyYW5zZmVyIGNvbW1hbmQgd2FzIHN1
Y2Nlc3NmdWxseSBzdWJtaXR0ZWQuIChubyBlbmQgdHJhbnNmZXIgdGltZW91dCkNCj4gPiBJbiBz
aXR1YXRpb25zLCBzdWNoIGFzIGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpIGFuZA0KPiA+
IF9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZSgpLCB0aGUgZHdjM19yZW1vdmVfcmVxdWVzdCgpIGlz
IHV0aWxpemVkLCB3aGljaA0KPiA+IHdpbGwgaXNzdWUgdGhlIGVuZCB0cmFuc2ZlciBjb21tYW5k
LCBhbmQgZm9sbG93IHVwIHdpdGgNCj4gPiBkd2MzX2dhZGdldF9naXZlYmFjaygpLiAgQXQgbGVh
c3QgZm9yIHRoZSBVU0IgZXAgZGlzYWJsZSBwYXRoLCBpdCBpcw0KPiA+IHJlcXVpcmVkIGZvciBh
bnkgcGVuZGluZyBhbmQgc3RhcnRlZCByZXF1ZXN0cyB0byBiZSBjb21wbGV0ZWQgYW5kIHJldHVy
bmVkDQo+ID4gdG8gdGhlIGZ1bmN0aW9uIGRyaXZlciBpbiB0aGUgc2FtZSBjb250ZXh0IG9mIHRo
ZSBkaXNhYmxlIGNhbGwuICBXaXRob3V0DQo+ID4gdGhlIEdVQ1RMMiBiaXQsIGl0IGlzIG5vdCBl
bnN1cmVkIHRoYXQgdGhlIGVuZCB0cmFuc2ZlciBpcyBjb21wbGV0ZWQgYmVmb3JlDQo+ID4gdGhl
IGJ1ZmZlcnMgYXJlIHVubWFwcGVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBD
aGVuZyA8cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2
MzoNCj4gPiAtIEZpeGVkIHN1YmplY3QgdGl0bGUgYW5kIG1vZGlmaWVkIGNvbW1pdCB0ZXh0IHRv
IHJlZmVyZW5jZSB0aGUgbmV3IDFtcw0KPiA+IGRlbGF5DQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2
MjoNCj4gPiAtIEluY3JlYXNlIGRlbGF5IHZhbHVlIHRvIDFtcw0KPiA+IC0gTWFrZSB0aGlzIGFw
cGxpY2FibGUgdG8gRFdDMzIgcmV2aXNpb25zIGFzIHdlbGwNCj4gPiANCj4gPiAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDE1ICsrKysrKysrKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4gPiBpbmRleCAzYzYzZmE5N2E2ODAuLjE1YWRmMDdhNGRmNCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiA+IEBAIC0xNjk5LDYgKzE2OTksNyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRf
Z2V0X2ZyYW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgaW50IF9f
ZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNl
LCBib29sIGludGVycnVwdCkNCj4gPiAgew0KPiA+ICsJc3RydWN0IGR3YzMgKmR3YyA9IGRlcC0+
ZHdjOw0KPiA+ICAJc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPiA+
ICAJdTMyIGNtZDsNCj4gPiAgCWludCByZXQ7DQo+ID4gQEAgLTE3MjIsMTAgKzE3MjMsMTQgQEAg
c3RhdGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRl
cCwgYm9vbCBmb3JjZSwgYm9vbCBpbnQNCj4gPiAgCVdBUk5fT05fT05DRShyZXQpOw0KPiA+ICAJ
ZGVwLT5yZXNvdXJjZV9pbmRleCA9IDA7DQo+ID4gIA0KPiA+IC0JaWYgKCFpbnRlcnJ1cHQpDQo+
ID4gKwlpZiAoIWludGVycnVwdCkgew0KPiA+ICsJCWlmIChEV0MzX0lQX0lTKERXQzMyKSB8fCBE
V0MzX0lQX0lTKERXQzMxKSB8fA0KPiA+ICsJCQlEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAzMTBB
KSkNCj4gDQo+IEhvdyBhYm91dCBhIGxpdHRsZSBtb3JlIHN1Y2NpbmN0bHk6DQo+IA0KPiAJCWlm
ICghRFdDM19JUF9JUyhEV0MzKSB8fCBEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAzMTBBKSkNCj4g
Pw0KPiANCg0Kb3IgdGhpczoNCglpZiAoIURXQzNfVkVSX0lTX1dJVEhJTihEV0MzLCAzMTBBLCBB
TlkpKQ0KDQoNCkJSLA0KVGhpbmg=

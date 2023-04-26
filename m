Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C92B6EEBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbjDZBHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbjDZBHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:07:09 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECEB23B;
        Tue, 25 Apr 2023 18:07:08 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q0hVvb003923;
        Tue, 25 Apr 2023 18:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=XtBadvPj0MtokK1iUbhNYn5S1K+UTvmoBp13gweGHTA=;
 b=h++7L/p57HjdJzGBfi5P1mSvQu6PRuGyOwj9ONcGO46Cj3JeJ5EzxA5+JYjfCjd3stNd
 h3rriTDQj//RWsq0RyLYfpbfulliUt44IHZfz+qsQ79mTjXdeHpKhcOPrQzMHhygzZnG
 cwUMzNlD6onE1k4q7qQW7WV3LZEprYckBcAH996BRLmIsGtzs0ZQOrhbjiBfuBw5c5X7
 jbDK9Dm/79lbzlUnDVjXw9IzoHB5QDOz9r9FZAiiqWw7IeI+jw8+V7jDvE/7Z4oSGOWl
 y7LKQKW8So8f5A3gS1xO4eaD7yUU61A/JfTcFi/XGjcWMLvjR9DOBoQOS7GFBiasn/B3 yA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q4yqpdjn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 18:06:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682471202; bh=XtBadvPj0MtokK1iUbhNYn5S1K+UTvmoBp13gweGHTA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZMLZ06Z3bhXDx3PnPLRmDrkCh3GYLgVCOTDnvQ1m36R+GoY+icXXdQ3RlDJ0BfUkS
         QeJIeSORhCrJis6cctm7bZHq8VT2tmvrhaX6qkZecYRPhbFHLOwIvWqaGEOiP+AoXK
         N9h1dRL1l+F3jjUxLT0uXNj4Hy/uj2e71wLxdjHWLBo4LUMa8MkrYIkCRtWZ5V/tXJ
         SlbAkbMPKRKdTq2ImjAQFduWcQZLElawrpEnZYBkmcFSyjmnOGYXyGQehumBHo7rec
         VYaiV4xl4DzV4HB5qWNbKC1s0QKj4zqPVesZDhuqL7j0xbjtI3MTaoaxTkJHEL/6L+
         M3PpqJoEY+3Tg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EFC9940408;
        Wed, 26 Apr 2023 01:06:41 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8F656A0071;
        Wed, 26 Apr 2023 01:06:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OQ+KeI1q;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DCE8B40615;
        Wed, 26 Apr 2023 01:06:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xtckt8A2tQYz60fwQ1h8bqxeX5Pxfj82RLa8mu0w2cvBk6A/vyN96RaHjek4BK6dT4DUG6Y8velB+x1oYWgeyQFrwenxKk4NyrFXFhu7V6ugUgNYw3fFFhEcrVYktQhxB426W1RIvLjsaNlBvsH9sQWD6qlQx4t2B99qALkkIIFrFp1WrAihbxnYwW9UOkDOUtMauCqZsTqiKQpOtfOI4Q4/6mXAtC0rpFObzU0C4rBaTZwv7K3uQaisB35bKjNA3IqQmgi2CJyBCPMYKtz8RlMbuA2I7Ig+3VMwSSx0H1kgBPDKY+2SH7M5c3j0Pru1Ih3hHKru2bLM6+sf8eYTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtBadvPj0MtokK1iUbhNYn5S1K+UTvmoBp13gweGHTA=;
 b=gvw3clU3af2aBS9C3GJmm3D4OIRMAB9yGdn+W8F8RVcNaDvawNyMS2MPhKME5oi0bRLPvOewYww3e5NHUtLglkugIbijYzEkBnZXoSzPNt3frfpnw+gjIXC9tgAF1faF6StWk59H7nPtioMzax5q4O5CLGOgxbInBJEojzzr92SSNtnWN9l3f690Oun3V8fano7I3VJwnnSiTI+s936NMkcnWOHAXq6eLy1JohkbYKnv3IXvk4nReJZWlPdeMcg0Ezcb/sL87gGL2nZxBQQZV5pmvhCp/BsuxM+PHv2PeOolEllk8XAoyt5NNpohhIi4bDGwOmAfp6PnwOWuQFSyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtBadvPj0MtokK1iUbhNYn5S1K+UTvmoBp13gweGHTA=;
 b=OQ+KeI1qh0mMlTkwo4EnhyUxQ40KlLSvzky40IPRFodWFo1HDtQTJztNhZVsefhsGLSbeiwCx6bYwYip/d3VOILCKuxI4Bwqm6ffvzNomia9i80yD8oywtCW+w9rFgSLoA1XOm/+U1XGTdIlSt5ciSHae1AWh3Aeueo6dXs/o3E=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 01:06:33 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3103:ba85:b667:315d%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 01:06:33 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Topic: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Thread-Index: AQHZYY+ZaTJWoGmlmk+xC9kJuoh9G68884yA
Date:   Wed, 26 Apr 2023 01:06:33 +0000
Message-ID: <20230426010631.fnncmfiywlm6jsws@synopsys.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
In-Reply-To: <20230328160756.30520-2-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB7713:EE_
x-ms-office365-filtering-correlation-id: 0fdabce7-b42d-4d90-1e13-08db45f279f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3R9O0IfTfg66Ugwb9j9tCQ/YVOmNeANtvEYa+DjP8dvOqc4+coTn792BHQ5cYDDwj5rd58TAtL12Z7LhQxCKygH5wB7PiZu2nlKglCrHtZ7fjm0L7lRye2AnvJ6spL60TAZ0WyjT6Kl4JpULY64ZX6okf8mCY1TXXnorrW1IXLcHJyHeIziQEwvr6uHgdrLxpynXmZpaP/pWDdWneeGeevz66loOkSFnd0TBMovNPxQzyE1rGvuA4UxuJpCG2w1PIp95nc2zuh121xLG0iDUk4oWpQfLTIsvrPqcHNJ1GvcZtXABBEJOS8Yfu6+cNhsSGmDY8rNqXma3sRPz38UQCPU7IP8yaTU0DAzomN11KeNBmU/YalMR+76YvCYt2VawTTY6kxUi/uFY4RMizorEKaaPU7Sfdc8goVL+0x9W/qZFV+IurAfNiE4nDMCaEdRSusuKPeBK0qXdlR6JfYcAG0s5byMOlkPbyuIPSmB3kOugd66uuzQOeeY19OukuPMGPCE1do0yKlHi8mqOzJXbilYPBwALZPnNF8pilKt4/EktT5n4dzM16Q9vGqQIvGzREmso2vdLlAIfvMDyGEyMFfTQ8aCQv+1jKeijq2dXGOL1A9jA8ypu4loOhLfQqxN5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(6916009)(4326008)(316002)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(36756003)(186003)(6506007)(6512007)(1076003)(26005)(86362001)(122000001)(2616005)(38100700002)(83380400001)(5660300002)(41300700001)(8936002)(8676002)(478600001)(6486002)(71200400001)(38070700005)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFZBREFka1Z1MzAxOUtvYWJJREwrQ3NzTXlzNkpBbWh3Ym4yWG1yVkhvUHJH?=
 =?utf-8?B?QUNVU1I0eGZkOW5hZktCckpkQXN2Q1NKUzRhaStra3FxMCs3cklQT1FjQS9n?=
 =?utf-8?B?bEZEZ1VrcC8wUTJXYmlDeGxKTEtmQ2o4OThVb1ZMNXMzOGZyekxhV1J6enU3?=
 =?utf-8?B?TE9kOHZQNXFrNUpaclF3V0JCZFFEYjZJUXlLUWFRbEJpU2lNcW5naDZsSkdW?=
 =?utf-8?B?czREZnJuai9tREJDelQ5NXJKWm9POTdYMnlGTW4zRDNhNGVDTjhlNVFIaFFV?=
 =?utf-8?B?c1BBOVJ3cERwWmtMN2pGZ1Z6VmhBT3FXOFFOdnZPKzVWWXg4cXVZTTdjaU1T?=
 =?utf-8?B?cmpTd2NIK3NLVng2Rk1kRWdLaktMdHFtbW8ybDhJNVNaMUN0cmJ0bGRwaDNu?=
 =?utf-8?B?bThObkMvem9pSEM4Rk1MbkdWNVkyREJDV2pDSjNnTC9vNWN3dnJTbWdqTHhL?=
 =?utf-8?B?bXJBWTVNVS9YVzBNYnlORUhXT1o4bTM0dURYK2Mvd09heDdUSkdOTVlJRHZE?=
 =?utf-8?B?dzlnTU8ydDNNWGxtbGFOT3Jvb01uRWlYbmlQeW5ON0dNZ084eWZwU1p4MkN0?=
 =?utf-8?B?dXNQVjFJaUMyRnhaMzljV3Q0VWZqZjhXekh1Q0lMemZTZDFsc05BbGhScUp4?=
 =?utf-8?B?OVdSbmR6enc1MHVyUEJPc21ZZU1WdkVhVTdQVkVULzBmYXVrTy8xWkN4SmxC?=
 =?utf-8?B?dGc3MDFiRnpIU0tUSUh0YUUza0RncXFDM1FZT2h2ZnJXZlZjbDNTVFJxT0pu?=
 =?utf-8?B?dVVGVExWN1dyQTgrZkxNc0xwbFc0K3dZSjd3YjJCbWRkY2pBd1ZBNzNpcE5u?=
 =?utf-8?B?UXh6aXROc2c2alU0Q21MSHMyTlRqOHBqQmc5dURhbUdiZmZKLzJha1NSZWtH?=
 =?utf-8?B?SWVTaXVKT0VtbG9rTW5ubGdHN2dPQ2dzRHpZWTlhV2s4d3hvMmwrdmFZSzdv?=
 =?utf-8?B?WkVNRElZbiszZnN0dmljN0tzd1V3dEZybFc3dmI0ZnpKS1gxc3ZXUCttcWxN?=
 =?utf-8?B?SmNSVHV0cVpRdW9XSGFOV3QwUU9UM0FnK294QTBpVkx4UjNyMk1sbHVtUkt4?=
 =?utf-8?B?ME1CSjBlNjN5ZTVpdEdvd1hJeEE5MWF6d2krOUVEM3U5ZUhWazlnOUx4SVpW?=
 =?utf-8?B?RHU2M2pOL1VaOGlEbEZvU2tRN0hBeUJNanAyRmNmK1plYlRCajRXUUgwTU5n?=
 =?utf-8?B?MFpydnRXSXpGTm8ycENTcTFYVUhJK2thb1dhRVFHa21LZ3prR0toakVhdEgx?=
 =?utf-8?B?L2ZMeG9SRVY4Z0M5VzRkcDUrZmRvQzhnWnA2TEd0WEFMSjVaUVFmeFptaHdY?=
 =?utf-8?B?ZHh0K0s1dEU5VUgrS0V2N2JKL0xTMXY5a3J1NXE2cVhlZU1kQkVQd2xQWjBj?=
 =?utf-8?B?akRleU9QU1dnbG13cUdxOW5qMS9pR2ZVdlRoSVZQZmdVUnc5eHlDcFBTS1Q2?=
 =?utf-8?B?elZIeW1Tem5ONjhMb0FqdGcxb3JiTi9tenRYMjFTdDB3b1pyMXMzU014blBO?=
 =?utf-8?B?VnFIRTM4bnlFRmNwZnJPbGFrNHN2QTMxOHlkeEU3cmVxM0gvdDUvaUk0dmhZ?=
 =?utf-8?B?YWJaRG5ZT2NXcGlRVzBLOFVFb1FNVTc5Q3Q1SnRTY0hZSjAvY2lGNzhleUt3?=
 =?utf-8?B?ZGp6Q1AyZkFGaFh0RlVXY0xibDlWeGVMVmoxSURrbGJ5V2EvS0JaNERremJE?=
 =?utf-8?B?bFd6L1Fhek5QaFlDSXNUQ2R6blN4WnB3djZMNkRNYkpyT1JkUFNmb1Z4T211?=
 =?utf-8?B?d2tYcUVYbEFlelFMdysyZ0czbWp5RHdVZWlWcmdpZjYyKzc0NFlPeVpuT0ZG?=
 =?utf-8?B?VWgzMnZ6WTJzM1lPYmlIY3hPd0JkMlh2d3AyUmdBLytpQnRWd2RmYk5ZdDBI?=
 =?utf-8?B?VW1jWThvbU9PV044cnBYNGxsNGpoSGNDazVGK0dNTy9JTzIxVG9KcGZWWVdY?=
 =?utf-8?B?ZFhqWVpZdjNCYXRpSnZWQVFSNEw1UzdsZGttNWtvWTlva3RYbFJCRVVkMU1m?=
 =?utf-8?B?M09XdUVCa3l1Y1duYldJTDM4elBrZnJaUUtyeE9JNXMrVWo0UzNBeXVtMERs?=
 =?utf-8?B?ZmdiVkJRL2pudXYvSHRWYUJtWVlkRGlDUGZWQzE0L1R3NTJJNkpCWXE1YWF3?=
 =?utf-8?B?bGozMFhRcjRhQUxpQ29EZTJOcjRUMVFmNTVWNXJCamZKRWZOc3RZOXNnN0Fr?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28416397A154CF47AE1AA01F75C81DA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTNhVXNVVlg5MnM5RGNYdGdJZ1QrakQvNFZ3S3VvYTNESm9VYkVyZzduOWNQ?=
 =?utf-8?B?MFpYU0ROVk9wbjd3MlF1TVI4elU4SGlLRWxDWllCV2pDZ25MeTl6SjloaHdC?=
 =?utf-8?B?R0dSdFB0ek13M2NOUjhIQlNjeHpEbHBrVUFMUC9tVTBaVjI2RHVWVnNVRHZm?=
 =?utf-8?B?WWVPdDUrQmFGYnhyOXllMGZuSjY1cis1WE1WWSt2WkFaWWlvTTBJREdWdHZL?=
 =?utf-8?B?VGpmM0NmMm9YbVBnWjVSS1VCTm5JWE9zL2Y0YTdHRGVjTCtBb3JqWHlFTXRa?=
 =?utf-8?B?UEpMek4vM0JZWHpMY0lYUjJtQUZEUnh6bWZFc2k3VUNFcGJyc2wvMFdKUU9O?=
 =?utf-8?B?ZXZqYTJQSGd5TFZXNkVuZ1dxQ0FEc0J1Z2ZHaEk3SkxrY0lBZWJ1KzFsdDl1?=
 =?utf-8?B?SHc3MUQ2bzNldnZ1SSszQUVjZXAzMFRpYzkxclhob3hVWWJoU0JyYWxlMU52?=
 =?utf-8?B?Z0FLVGY0cXVDVEVVdjNQVVkwMnZVS3phNEpyQmlaMER3eHhia3Rhc1h0bURG?=
 =?utf-8?B?RTk4cE5vWnlnYjBnWmVqMG1nSjRsSXo0VUptS2dwS2UxaEd6MzhMU1Z4enRT?=
 =?utf-8?B?OXdXOWMzVmpDN3lSMGI5UEVkVzFUZnB2MW9LSUFudnVLUFhvb2E5bTJrends?=
 =?utf-8?B?M3NHTHUydmhjN3Y3Y0RxMHJqakU4b2hHbEJiT0RNMHI5UllUNkdnNFhRS1pS?=
 =?utf-8?B?K0NQbDh6WWxTYVlXTWQvdlN2WjkzeWFxTlhRWkVmS2VLSHhKeGhCNDFVMXV1?=
 =?utf-8?B?MUNNMmd2Zms3N3JOckV4QjRIdVBaMHpwOEM1T3I3UWVkUllnbDYyQ0ZPbFdy?=
 =?utf-8?B?akE2TnNCeUVnS2YybnE0ZEtyNExvMFU3RmFFemZzd2s3QmltSXF2b2o3NUtD?=
 =?utf-8?B?ZkRwdjJseUIyZjNnTzk3NnhXdS9YVHN0ZVJQMzgra3Npd3pNNHFpeE1vbndV?=
 =?utf-8?B?bThNZ2dkTXc1dGVZWStuamFzYWlMMXVhZlgrSzJQYks1NGJZa0ZsSjBmczZL?=
 =?utf-8?B?K1N5QzYwdVBlVjhsNm9INXliUEt2dVRxS2tTTno2M1czRVowM0xRQUNnWnlD?=
 =?utf-8?B?UFlteEtSYms1VlVFZEdVSjJITGdyblI5L0hTR2R4aC9aZGlDTW9kMytMMnFQ?=
 =?utf-8?B?TitOOEVtb3FhWW9wSWdobXUxMW45TitQMXVxN1JSN1M4LzU3TEJDaXpCdHk4?=
 =?utf-8?B?VkVQQTFieDB4ME1FcFNDN0hDSmxja1IxTzdsc3dtejJyd2lKb28xR1BtdXU3?=
 =?utf-8?B?TDJSOTA5LzQ0engxeWhtWDl2ZEtSSUFnRUJVRFNQbUUvY21Kb285TjBrUEZr?=
 =?utf-8?B?WnFQUE9TY2MwOU9vaHNMZ2dvUDc4d094aUFNQllNU1dFTVMvRkZNMVc0dHBZ?=
 =?utf-8?Q?iyy3Taxe7sSIeYZyCc42tMsgx886yP4k=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdabce7-b42d-4d90-1e13-08db45f279f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 01:06:33.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6FCVgOWxKDywaiBTfdI5o884JSiq+KB6WEQee0BnSyJCTQUE6QDAxF85C1ZzysMWyAggMti7TuxtfNvFXdXOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
X-Proofpoint-GUID: aB848QYAyZwBVEW0IXXGtOk3TAFML2Hi
X-Proofpoint-ORIG-GUID: aB848QYAyZwBVEW0IXXGtOk3TAFML2Hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_11,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304260008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMjgsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IElmIHRoZSBj
b3JlIHNvZnQgcmVzZXQgdGltZW91dCBoYXBwZW5zLCBhdm9pZCBzZXR0aW5nIHVwIGV2ZW50DQo+
IGJ1ZmZlcnMgYW5kIHN0YXJ0aW5nIGdhZGdldCBhcyB0aGUgd3JpdGVzIHRvIHRoZXNlIHJlZ2lz
dGVycw0KPiBtYXkgbm90IHJlZmxlY3Qgd2hlbiBpbiByZXNldCBhbmQgc2V0dGluZyB0aGUgcnVu
IHN0b3AgYml0DQo+IGNhbiBsZWFkIHRoZSBjb250cm9sbGVyIHRvIGFjY2VzcyB3cm9uZyBldmVu
dCBidWZmZXIgYWRkcmVzcw0KPiByZXN1bHRpbmcgaW4gYSBjcmFzaC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBp
bmRleCAzYzYzZmE5N2E2ODAuLmYwNDcyODAxZDlhNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBA
IC0yNjIwLDEzICsyNjIwLDE2IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVj
dCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+ICAJCSAqIGRldmljZS1pbml0aWF0ZWQgZGlz
Y29ubmVjdCByZXF1aXJlcyBhIGNvcmUgc29mdCByZXNldA0KPiAgCQkgKiAoRENUTC5DU2Z0UnN0
KSBiZWZvcmUgZW5hYmxpbmcgdGhlIHJ1bi9zdG9wIGJpdC4NCj4gIAkJICovDQo+IC0JCWR3YzNf
Y29yZV9zb2Z0X3Jlc2V0KGR3Yyk7DQo+ICsJCXJldCA9IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KGR3
Yyk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlnb3RvIGRvbmU7DQo+ICANCj4gIAkJZHdjM19ldmVu
dF9idWZmZXJzX3NldHVwKGR3Yyk7DQo+ICAJCV9fZHdjM19nYWRnZXRfc3RhcnQoZHdjKTsNCj4g
IAkJcmV0ID0gZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCB0cnVlLCBmYWxzZSk7DQo+ICAJfQ0K
PiAgDQo+ICtkb25lOg0KPiAgCXBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gIA0KPiAgCXJl
dHVybiByZXQ7DQo+IC0tIA0KPiAyLjQwLjANCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

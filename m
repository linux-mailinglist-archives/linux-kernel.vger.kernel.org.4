Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC974FAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGKWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGKWIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:08:14 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE601733;
        Tue, 11 Jul 2023 15:08:09 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BKI5U7016090;
        Tue, 11 Jul 2023 15:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=os4JBmCHJ4HS33pTSuzE0QgQnUUzu/Ddv6dg26TyqXg=;
 b=U9Wjf1rv30PHJrj1WCPD/lNdZWsOJphR8Dpcp2I9Wam7PuewT6HOHNynRMGzmedApJFP
 BMg+5aMQfZlvmUreOF6Z4WINoDvgqw5ESEfgAvUKhD7fh6/s9M0nSFULusUGyrVg7890
 6T5J1RZ5OzUp1z6Wu+/38R5Vlrlr6x3jDCrGFJB0Jv6fz8Wkz3wCoTQsajF1gE6tDh/M
 ElY9/KPp3fnhJuxeR4yhMXaOrqEAxcbR9zBVVuM1J8H5IFtsLb8j8emtWEkYVirlZnRm
 TeMUbNkDo1fbpFp0D+EDXxzy4cKbkrA5NE4TyjTAIqzO02Vauy5OFfPVS8B79zTcrooF xg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rq725ncp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 15:07:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689113279; bh=os4JBmCHJ4HS33pTSuzE0QgQnUUzu/Ddv6dg26TyqXg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XbyUApX6O1UPXLw9rm8X2VaLdOvd/uA2Q0Cc1EWrOIwxbkJ/jG0MS1RbXRJlnVPK+
         S1QkFOPbY/+kjs/ntVMI24zUPgrvU3IvaaVUye0HTxyfDzUUyXinCpE6rSo0e+47aN
         zatcxXjvEzHlGRcr4bWIpNLia76UA3wWhPZ9hioNRyPyX+HRXE+84ng1GZ7F+ohJl+
         NBpAcSKJxU+VnDHQAAJWVM7Nbxv9dXxPQvKSiXlIjFNidN+tHH1294tRGUmF1vv9/8
         E3RILbmXge1HPlwxgRz10DNO4CG36hHbf3A1LJIBxYttZD4cnjszwgyvjQO/rUX3Ke
         AV/IQRT3Jp7qQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F07A404A8;
        Tue, 11 Jul 2023 22:07:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 73FE2A0072;
        Tue, 11 Jul 2023 22:07:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=crZf9LPD;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E410740141;
        Tue, 11 Jul 2023 22:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRu+2v+8y/QRRwnScR7saRhZI8MjDYQwDBHGiTk21K2eElCuMagVY2WbM2XmM/0bIXbVvRA336xTnXTef6wXqXL5yzNF3ktNh34wAPUDrTXYfoNXk71EZvSNK10IO2FdxRQzO8widKMGHHO6RT7h1c5POh+zWBM2UhpSx3tPQHou2f9hqEhlRLpGhS55jwfc+lpPHFD1L+yGgHhHHzfJ/U9BdO77MsSQMfNzo/cmzc/9iltMYHqt1iJMqgg44BQJVzHwoMtaB/Adiy+n/2+qlS78+cP7WudruPn7VAIF2rNinn7iaC2xIu464M119+B1+Hi8x16iqoVtTRnC85cCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os4JBmCHJ4HS33pTSuzE0QgQnUUzu/Ddv6dg26TyqXg=;
 b=n1oLMO0QpgYqLp7WyTzLq7e0ykNDy5y7K1DvPJf0Yh+2NiubnjFs8vwTu3iI8srgEETfBeKCOs6lFJMxIqkmjPAqY2FvNy3IXaDLAqPORoeU8Qo6yDmUhuSgMKEtuzFDkgaUWT5U32A2uWpQNBjLuVytYbfQfdQSoxYYRrRqlbq3DdSVm2EzF3oIF7KWUO1i3i/Undja9qHdOk1z9AlVkJ8HMfwl7g4DJMhZOH5hPXsGUxmjO8laFHcDR+L6+MmZaIzjqBa2FDVYm+kDMPGPiE4MZ/19jbLXOtQCo6rIn2w+5kJFkX2C7GhQN2PMinlq2RH8MqtTTKuh7YA37LeawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os4JBmCHJ4HS33pTSuzE0QgQnUUzu/Ddv6dg26TyqXg=;
 b=crZf9LPDJH+zCNH7s26ZKZrtNFflMXHyld5/OUyiZmkaqbWiRqx3YRH2p+K0DPs5E2MqAqP6aITHpdjpWUXILHwq1bdCwL+8+yXLDMmUz0HlcFjfk61Pl4jDR+vYqXTgSuqHQfQCBDVtm/BaxPUYHaCKlxeHNO44AnGYuS5QDwc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 22:07:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 22:07:51 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v3 3/3] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Thread-Topic: [PATCH v3 3/3] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Thread-Index: AQHZtB89/BU0agvaJkSP+UGyUwVL2q+1IAIA
Date:   Tue, 11 Jul 2023 22:07:51 +0000
Message-ID: <20230711220748.vmnvwwcu5nhrvyvi@synopsys.com>
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-4-quic_eserrao@quicinc.com>
In-Reply-To: <20230711174320.24058-4-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7138:EE_
x-ms-office365-filtering-correlation-id: 5da81c83-2f27-43b8-a544-08db825b44e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bRopSf0PRtq5mHI4OkvMSYNs4WGXK2bkvy1UQvUDhllOjrwRH51VSDmnDTNwEg8CRkUgh2kVgNT79hvKPmpFlJR2oar8ZkFY3tcgffmmnXKUcqIlGefBHYFk98HRVNt7OnPvL/ZR2V9Yxxrj9pOkByh9BOD5WBi2hYTDbEndVawUgSWnBsYnFkw4tJQzN5pxbb4ce1D9ka55WGvDgvxJbXGY5+krOSx+EIHefGr5jt5BMXrBLTbaml+bt+ZirP3AvMXg/SKx/V7fEyWt9k5xSUmsxPj+8JgY8oQ/Kz5jTT1HdGtsQbQ7qAu2gxqbXZfGy6ORC2xVrUfxxtTBqyS5/TgumoU07VJ0lK5hfawwHx0MxJc0XH3YHOQN0tg5FQCAmExaJCi1te9Nf1qoouBhtDhBFdnOIVYfbBehWchvyOlwuGqe0GnaUdj/Uxyyv+fSZ7xQULXib5CPAIItVX+LYwDYv7sazP9QLmltcaiXDjEnWL4YI+i7JzzU2GMzCtaG+ppxrEurXLNOL0axwJSRZ4s/2vmVVCuozWRVH77vJA8dC6EaF0USauP6cNrni/idTHwo3BWrZszbhe8trNBNqW4TLHSq0Mdm4zhqJklY5fWvoJERLXJUj4QtQQhuMr2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(86362001)(38070700005)(36756003)(122000001)(478600001)(54906003)(2906002)(38100700002)(71200400001)(2616005)(186003)(1076003)(6506007)(26005)(83380400001)(66476007)(8676002)(6486002)(8936002)(41300700001)(5660300002)(15650500001)(66446008)(66946007)(6916009)(66556008)(64756008)(6512007)(4326008)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aThiemR0MVhZU1BkUHpUbTVRNTBPRkhGVEUyM1VCd2FycFAvLzVQbURsMXB0?=
 =?utf-8?B?N0oveDZFNEVKWWxjaEdva1dLWVdESWlPc2tid0I2N1JKaUt5bklOR294RVlI?=
 =?utf-8?B?MDBEMFAzUXRid1p3Q0Y0Znc0ay8yVmFlNFFUYjBHbUk1cEZLdyt4V2VRNnBk?=
 =?utf-8?B?Wlk4OUgwUHppT29QaFY5QTFUMGgxUXBXamNzL0ZIYzVyWjY0V0tRTjJ3YytS?=
 =?utf-8?B?RGpmZkdITHdlMnBMMWFPRGhjL2pMaitkNEU5SC9hQlp0UHFYMmhpczdjK2Zt?=
 =?utf-8?B?U2dTSGt3WFJTOVZRb1lmZDZUQ3JtazkvL2U3a1QzaDcrT3NOYTFmcE1CN3V3?=
 =?utf-8?B?UGZPbTlmYjRMYjF1T1E4aVdad01WVHF1d3ZKV1FJNW9hWE9qekM3Tk56SDNB?=
 =?utf-8?B?T0YvT0hjVXNVcTJoVjlRWlp4ZzdGN1JZUWFoY1dzeEZ3NHc1NWNWSlIvSEJH?=
 =?utf-8?B?T3U5TytLajJUamdCL3BubUhvcVVXY3RDVStBK3V5RC9ZWXpSVFpxMFJSRnlH?=
 =?utf-8?B?K1p4eUdKTU5MOFllVEp3ZTljWThtOVFoMVhxWEFpaXRWaHBMSmJtTWx1Q3B4?=
 =?utf-8?B?TWNpZ3hiSnVxVnhpd0VMUUk1RW0rNVphRkdXZW5TQS9VY1N1R2thaSsrbnAv?=
 =?utf-8?B?cm94WU9RSDZVei8rZi9HZlBZWnNXN0phZERwbjhHNkxlQmx3OHpyVmlteTRR?=
 =?utf-8?B?dGkrWFhDMTJlWWh2TTduY0RTR0VhTGtCdDM3RG4xVGtYN0xzQnBiVU8wVVZH?=
 =?utf-8?B?UWh5TVlGbWVVNkw4V0dEcUpkQWRRVkoreU84Z1dzbjUxNnplOEZNYjdXLzJi?=
 =?utf-8?B?bG9TQWVJVmFGNmJBNnJNdG05Nmttdk8rUG9mWm1zUUh6aXptMUt1ZHlsQVRT?=
 =?utf-8?B?WkNHdkJzNFJkVFpidFBuOW9KQWF4T0RuQytFMUJMZ0tQc2xlSUYrRjlIWXlk?=
 =?utf-8?B?QzFUcjhoRVluZWVWT2ZldnM1YWNNVi96RXN3M2grRFNUZXViUDh1K3cvS3Ax?=
 =?utf-8?B?bUZyVCtnS0ZSVmhKaTYxZGt0QWlFaVcxRW9yT1o3V2toOE0ra1pVNTVUUVNl?=
 =?utf-8?B?VUdzZzI1UXg3bm1kU2wzRWpmY1JpMVlTRVNXajMwVnRqTUFmKzI3d281anZq?=
 =?utf-8?B?KyttT05tTlhJWnJnYVJJNDV1bUhhMHRVYk9kREV2NVpldXdvbkpKQmNhRVl0?=
 =?utf-8?B?bE03RnMvNkdQZFhVdjZIWVVHR3RzcEI2S0hxSXVIekU3dEw4eG5Od1U1Tk5D?=
 =?utf-8?B?MEdEVWdjbExhMUJHVDUvV1ovWGZYQ2RZOHlqc1NjZGh2RUZabytSakVnemli?=
 =?utf-8?B?VVlsd2JRZm9aWW5lQWZsSkMvbzBTQlhXSjFtTUNuVlNBMDYydDBMVTQ4MEht?=
 =?utf-8?B?RzU5ZGhtWmpsaVY1Sk8yTnlTcTV2bXJHeG1MWmgrM1d2TFhjVDdWc0NXVXN6?=
 =?utf-8?B?U1lYMU9RZXpPV2NVcHo1WDBoZDE4ekE2Wll6TlBuL2tpU0w3QmlrM0NUalov?=
 =?utf-8?B?UGRldnlLNkp2R2c0WGRxWVdLWUNBRDFjRzFBSzROVkhUWHZhRGFPSjF6Ny9M?=
 =?utf-8?B?aE93VmVDb2c3K0lwTmh5ckJoclFZcHZlVTQ0aW9ZQUlQNzZVMy9ZWEthT3Rm?=
 =?utf-8?B?Mmd0ODZpb2wxdW9DMnU3ai9KS1RzZk15SmtQZHdHcVdkc0xwNzBhcWxCb2p1?=
 =?utf-8?B?cFJTaEdqSHR5R1pkL1R6b1VBRHdHTFNJSmd1QjJRMTVkVVozZ0RMRmhFOWYw?=
 =?utf-8?B?OWxXZjRyMS9ubHVnVEFkdS9nZGorNnpEcGFYbkVHUmYzYXRZUWJjbXI2MnJE?=
 =?utf-8?B?eEJJcDVqeEFTQjhnc1RsS0VZQlVTa3JSYlBBbGhTemRGdFA2R1pTdXpWL0Nv?=
 =?utf-8?B?NUtDV3NBQ2hBWGkwL2NOdXk2RkJkckY3U2h1YWxaUzV1R0lZMHNWRUtFM3dj?=
 =?utf-8?B?SzMwNFVIRlUzU09qSW4yNVpEazZoYjBiZ1RhVXRzOW5Ga1F6MGJoQjNWVXAv?=
 =?utf-8?B?NjQ0dENEbHlQaitGbXNKWWM4Q1JseVpKdkxnU1VDeXNtSG44cy9iMUZPYUdX?=
 =?utf-8?B?ZFpPelFvcy9mWHFPc0VvYmxFY1dYSG1qL09WZHI1MmNvdzB5Q0ZIQ2pvZzFm?=
 =?utf-8?B?SVJFcEY1bnh3ZVEwQVhpaTlYMmdMamNnbFQxUFV3ZE1acEFWbnNVVXAyRjJW?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E5A0125AF34184BB046F417B6E9F10C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RXVtSTVaM1g4SURCWGNFRUt2QW5nMlhWczFuc2JJbE5ZNUM1d1JNN01HeWRW?=
 =?utf-8?B?MHBLb2V0eDNOUmoyeVo0a21KMkVURXJZeHE3bEx4SmNCditlcWtCSklKclJh?=
 =?utf-8?B?NHlqY0FVUTFVUk5JcnQ3TzZDOWhPTU40bWJndXBMK3pkcitNTmEzU295cWpE?=
 =?utf-8?B?ZFNYeTZJVkxoMGJncS9mY2RxTGJod0w3WVU2TUNqWXVZSklya3lrSTRiWlZa?=
 =?utf-8?B?ZDJhQURySVpIVDhWK0JmM2dWVEJrRjF1cExDL1FodmUzdlJVVDlBYm83N24y?=
 =?utf-8?B?Z2tnalhyZ1M3UU8wb0NBUDI2c0pmMlNoalFYV0N5VHRXNTFsTlgzRDlvUGs4?=
 =?utf-8?B?Q1k1YSt2eTBzQmJ3MFIxeklVMkJNZmZ5WUFvK2JrRDF2SW9DUytBM3c2VlpE?=
 =?utf-8?B?UWI5VWRhM0Z2OElOUDROVGdvd3Y3SnZlbGE5TjBVL0dRVjFKU3htSTYwMm15?=
 =?utf-8?B?Y1VZckhSQnBxOG1uRG56Slg3TjNXU21pUXAwaTIwS2hKZnZQOFF6ZUtBeU5m?=
 =?utf-8?B?Nlg2Q0hRd3hTN1lramkzZllTQzRHdHJoV211SUR5bit1ZkJkMGZiV1JvZkNt?=
 =?utf-8?B?NHRPWW5tR25EZUNqWGNTanExR2FVRVVWdjNOQmhOOFNmaTVEMDZwN0M0T2Vu?=
 =?utf-8?B?VFlsSm83ZVNzUDE4elhkOXJ1QVdFSVVqSnFxT1BtU3czWUdyb0phSTJBbDVo?=
 =?utf-8?B?OWZoaTBnVko1WUx1WjZyb1c0anBOenBuN3BNTWlQSndLOStoMGthSFc0YjBo?=
 =?utf-8?B?TyswMXI2UDRQRGd5aUtwNkd5eGdTNjJMU2VEOUIwaFUzbVlwUXRvWWxCeDlC?=
 =?utf-8?B?K0tJSVNheVNXR1BzRXJaRWtxWm53eG95Tml2T0cwSk1jSlRhbExYVmsySHIv?=
 =?utf-8?B?UnVCZUxOVXUvdlZYNmFJMUFJUGJxNjRaRG02eWhNRGtvR1ZQaUFqdXdrNjBv?=
 =?utf-8?B?OXRlK09PdUQwTEpDbE83TW9FOGdzMlR0Q1lSRldkejhVdzE1eXA4QUdYUTNa?=
 =?utf-8?B?akU3VEFZMEV1QXlHL0tmSldha0hPczR6WlJpTlJxL08yd1Z6YURRbkhwRE54?=
 =?utf-8?B?QUZ1Ukk1OUdLOTNLaGVoT2JDaS9QcjNkRVhWbDh6MzV2OFJRMVg1WXc0U25y?=
 =?utf-8?B?U01zOFNVSGVBWDFTeVZRRFI1ZjBMTk1YV3M0SUcxZVo1cFAwTkZKNTE0R2px?=
 =?utf-8?B?TTRYeFh4dHlUdWtjMlpkU3NwYy8zM1JnYjVYWjBlVThDSmxHQ29VeHlzRkEv?=
 =?utf-8?B?Uys3Wi9ZVUVRbVJTMEkzRlJjVFdXRXpoRk1KQnQraFlsTDNxZnpkN0xmbzZa?=
 =?utf-8?Q?FekTa6WJsq3cI=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da81c83-2f27-43b8-a544-08db825b44e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 22:07:51.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJhBPdg9+tyZya100/e6rCG8QUmaNnutCKaw2NgRaszfygqNG8ESS/VcSmkRo/7rTuNq/Z87wTytF9GJ+AYmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
X-Proofpoint-ORIG-GUID: q8kwb-NIEpzxuvHFS1FHQr8PwPYk_Myc
X-Proofpoint-GUID: q8kwb-NIEpzxuvHFS1FHQr8PwPYk_Myc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=967 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdWwgMTEsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIGJsb2NrcyB0aGUgcnVudGltZSBwbSBvcGVyYXRpb25zIHdoZW4g
Y2FibGUNCj4gaXMgY29ubmVjdGVkLiBUaGlzIHdvdWxkIGJsb2NrIHBsYXRmb3JtcyBmcm9tIGVu
dGVyaW5nIHN5c3RlbSB3aWRlIHN1c3BlbmQNCj4gZHVyaW5nIGJ1cyBzdXNwZW5kIHNjZW5hcmlv
LiBNb2RpZnkgdGhlIHJ1bnRpbWUgcG0gb3BzIHRvIGhhbmRsZSBidXMNCj4gc3VzcGVuZCBjYXNl
IGZvciBzdWNoIHBsYXRmb3JtcyB3aGVyZSB0aGUgY29udHJvbGxlciBsb3cgcG93ZXIgbW9kZQ0K
PiBlbnRyeS9leGl0IGlzIGhhbmRsZWQgYnkgdGhlIGdsdWUgZHJpdmVyLiBUaGlzIGVuYWJsZW1l
bnQgaXMgY29udHJvbGxlZA0KPiB0aHJvdWdoIGEgZHQgcHJvcGVydHkgYW5kIHBsYXRmb3JtcyBj
YXBhYmxlIG9mIGRldGVjdGluZyBidXMgcmVzdW1lIGNhbg0KPiBiZW5lZml0IGZyb20gdGhpcyBm
ZWF0dXJlLiBBbHNvIG1vZGlmeSB0aGUgcmVtb3RlIHdha2V1cCBvcGVyYXRpb25zIHRvDQo+IHRy
aWdnZXIgcnVudGltZSByZXN1bWUgYmVmb3JlIHNlbmRpbmcgd2FrZXVwIHNpZ25hbC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyAgIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKy0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICB8ICAzICsrKw0KPiAg
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGY2Njg5YjczMTcxOC4uODk4YzBmNjhl
MTkwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTUzNCw2ICsxNTM0LDkgQEAgc3RhdGljIHZvaWQg
ZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3Yy0+ZGlzX3NwbGl0
X3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ICAJCQkJInNucHMsZGlz
LXNwbGl0LXF1aXJrIik7DQo+ICANCj4gKwlkd2MtPmFsbG93X3J0c3VzcF9vbl91MyA9IGRldmlj
ZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiArCQkJCSJzbnBzLGFsbG93LXJ0c3VzcC1vbi11
MyIpOw0KPiArDQo+ICAJZHdjLT5scG1fbnlldF90aHJlc2hvbGQgPSBscG1fbnlldF90aHJlc2hv
bGQ7DQo+ICAJZHdjLT50eF9kZV9lbXBoYXNpcyA9IHR4X2RlX2VtcGhhc2lzOw0KPiAgDQo+IEBA
IC0xOTg0LDExICsxOTg3LDIxIEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1
Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcJ
ZmxhZ3M7DQo+ICAJdTMyIHJlZzsNCj4gKwlpbnQgbGlua19zdGF0ZTsNCj4gIA0KPiAgCXN3aXRj
aCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVW
SUNFOg0KPiAgCQlpZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKQ0KPiAgCQkJYnJl
YWs7DQo+ICsNCj4gKwkJaWYgKGR3Yy0+Y29ubmVjdGVkKSB7DQo+ICsJCQlsaW5rX3N0YXRlID0g
ZHdjM19nYWRnZXRfZ2V0X2xpbmtfc3RhdGUoZHdjKTsNCj4gKwkJCS8qIGJ1cyBzdXNwZW5kIGNh
c2UgKi8NCj4gKwkJCWlmIChkd2MtPmFsbG93X3J0c3VzcF9vbl91MyAmJg0KPiArCQkJICAgIGxp
bmtfc3RhdGUgPT0gRFdDM19MSU5LX1NUQVRFX1UzKQ0KPiArCQkJCWJyZWFrOw0KPiArCQkJcmV0
dXJuIC1FQlVTWTsNCj4gKwkJfQ0KPiAgCQlkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICAJ
CXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiAgCQlkd2MzX2NvcmVfZXhpdChk
d2MpOw0KPiBAQCAtMjA0NSw2ICsyMDU4LDkgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21t
b24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gIA0KPiAgCXN3aXRjaCAo
ZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNF
Og0KPiArCQkvKiBidXMgcmVzdW1lIGNhc2UgKi8NCj4gKwkJaWYgKGR3Yy0+Y29ubmVjdGVkKQ0K
PiArCQkJYnJlYWs7DQo+ICAJCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoZHdjKTsN
Cj4gIAkJaWYgKHJldCkNCj4gIAkJCXJldHVybiByZXQ7DQo+IEBAIC0yMTIzLDkgKzIxMzksNiBA
QCBzdGF0aWMgaW50IGR3YzNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
IAlzdHJ1Y3QgZHdjMyAgICAgKmR3YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgCWludAkJ
cmV0Ow0KPiAgDQo+IC0JaWYgKGR3YzNfcnVudGltZV9jaGVja3MoZHdjKSkNCj4gLQkJcmV0dXJu
IC1FQlVTWTsNCj4gLQ0KPiAgCXJldCA9IGR3YzNfc3VzcGVuZF9jb21tb24oZHdjLCBQTVNHX0FV
VE9fU1VTUEVORCk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gQEAgLTIxNjAs
OSArMjE3MywxNSBAQCBzdGF0aWMgaW50IGR3YzNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KPiAgc3RhdGljIGludCBkd2MzX3J1bnRpbWVfaWRsZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMgICAgICpkd2MgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gKwlpbnQJCWxpbmtfc3RhdGU7DQo+ICANCj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9k
cl9yb2xlKSB7DQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gKwkJbGlua19z
dGF0ZSA9IGR3YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+ICsJCS8qIGZvciBidXMg
c3VzcGVuZCBjYXNlIHJldHVybiBzdWNjZXNzICovDQo+ICsJCWlmIChkd2MtPmFsbG93X3J0c3Vz
cF9vbl91MyAmJiBkd2MtPmNvbm5lY3RlZCAmJg0KPiArCQkgICAgbGlua19zdGF0ZSA9PSBEV0Mz
X0xJTktfU1RBVEVfVTMpDQo+ICsJCQlnb3RvIGF1dG9zdXNwZW5kOw0KPiAgCQlpZiAoZHdjM19y
dW50aW1lX2NoZWNrcyhkd2MpKQ0KPiAgCQkJcmV0dXJuIC1FQlVTWTsNCj4gIAkJYnJlYWs7DQo+
IEBAIC0yMTcyLDYgKzIxOTEsNyBAQCBzdGF0aWMgaW50IGR3YzNfcnVudGltZV9pZGxlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICthdXRvc3VzcGVuZDoN
Cj4gIAlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldik7DQo+ICAJcG1fcnVudGltZV9hdXRv
c3VzcGVuZChkZXYpOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IDhiMTI5NWU0ZGNkZC4uMzNiMmNj
YmJkOTYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtMTEyNyw2ICsxMTI3LDggQEAgc3RydWN0IGR3
YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAbnVtX2VwX3Jlc2l6ZWQ6IGNhcnJpZXMgdGhl
IGN1cnJlbnQgbnVtYmVyIGVuZHBvaW50cyB3aGljaCBoYXZlIGhhZCBpdHMgdHgNCj4gICAqCQkg
ICAgZmlmbyByZXNpemVkLg0KPiAgICogQGRlYnVnX3Jvb3Q6IHJvb3QgZGVidWdmcyBkaXJlY3Rv
cnkgZm9yIHRoaXMgZGV2aWNlIHRvIHB1dCBpdHMgZmlsZXMgaW4uDQo+ICsgKiBAYWxsb3dfcnRz
dXNwX29uX3UzOiB0cnVlIGlmIGR3YzMgcnVudGltZSBzdXNwZW5kIGlzIGFsbG93ZWQgZHVyaW5n
IGJ1cw0KPiArICoJCQlzdXNwZW5kIHNjZW5hcmlvLg0KPiAgICovDQo+ICBzdHJ1Y3QgZHdjMyB7
DQo+ICAJc3RydWN0IHdvcmtfc3RydWN0CWRyZF93b3JrOw0KPiBAQCAtMTM0Myw2ICsxMzQ1LDcg
QEAgc3RydWN0IGR3YzMgew0KPiAgCWludAkJCWxhc3RfZmlmb19kZXB0aDsNCj4gIAlpbnQJCQlu
dW1fZXBfcmVzaXplZDsNCj4gIAlzdHJ1Y3QgZGVudHJ5CQkqZGVidWdfcm9vdDsNCj4gKwlib29s
CQkJYWxsb3dfcnRzdXNwX29uX3UzOw0KPiAgfTsNCj4gIA0KPiAgI2RlZmluZSBJTkNSWF9CVVJT
VF9NT0RFIDANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDVmZDA2NzE1MWZiZi4uMDc5N2NmZmEyZDQ4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTI0MDEsMTUgKzI0MDEsMjEgQEAgc3RhdGljIGlu
dCBkd2MzX2dhZGdldF93YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcpDQo+ICAJCXJldHVybiAt
RUlOVkFMOw0KPiAgCX0NCj4gIA0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZs
YWdzKTsNCj4gIAlpZiAoIWR3Yy0+Z2FkZ2V0LT53YWtldXBfYXJtZWQpIHsNCj4gIAkJZGV2X2Vy
cihkd2MtPmRldiwgIm5vdCBhcm1lZCBmb3IgcmVtb3RlIHdha2V1cFxuIik7DQo+IC0JCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCQlyZXR1cm4gLUVJTlZB
TDsNCj4gIAl9DQo+IC0JcmV0ID0gX19kd2MzX2dhZGdldF93YWtldXAoZHdjLCB0cnVlKTsNCj4g
IA0KPiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHdjLT5kZXYpOw0KPiArCWlm
IChyZXQgPCAwKSB7DQo+ICsJCXBtX3J1bnRpbWVfc2V0X3N1c3BlbmRlZChkd2MtPmRldik7DQo+
ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+
bG9jaywgZmxhZ3MpOw0KPiArCXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3YywgdHJ1ZSk7
DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJcG1f
cnVudGltZV9wdXRfbm9pZGxlKGR3Yy0+ZGV2KTsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9
DQo+IEBAIC0yNDI4LDYgKzI0MzQsMTIgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9mdW5jX3dh
a2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGludGZfaWQpDQo+ICAJCXJldHVybiAtRUlO
VkFMOw0KPiAgCX0NCj4gIA0KPiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHdj
LT5kZXYpOw0KPiArCWlmIChyZXQgPCAwKSB7DQo+ICsJCXBtX3J1bnRpbWVfc2V0X3N1c3BlbmRl
ZChkd2MtPmRldik7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICAJc3Bpbl9sb2Nr
X2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCS8qDQo+ICAJICogSWYgdGhlIGxpbmsg
aXMgaW4gVTMsIHNpZ25hbCBmb3IgcmVtb3RlIHdha2V1cCBhbmQgd2FpdCBmb3IgdGhlDQo+IEBA
IC0yNDM4LDYgKzI0NTAsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2Z1bmNfd2FrZXVwKHN0
cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaW50Zl9pZCkNCj4gIAkJcmV0ID0gX19kd2MzX2dhZGdl
dF93YWtldXAoZHdjLCBmYWxzZSk7DQo+ICAJCWlmIChyZXQpIHsNCj4gIAkJCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCQkJcG1fcnVudGltZV9wdXRfbm9p
ZGxlKGR3Yy0+ZGV2KTsNCj4gIAkJCXJldHVybiAtRUlOVkFMOw0KPiAgCQl9DQo+ICAJCWR3YzNf
cmVzdW1lX2dhZGdldChkd2MpOw0KPiBAQCAtMjQ1Miw2ICsyNDY1LDcgQEAgc3RhdGljIGludCBk
d2MzX2dhZGdldF9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGludGZfaWQp
DQo+ICAJCWRldl9lcnIoZHdjLT5kZXYsICJmdW5jdGlvbiByZW1vdGUgd2FrZXVwIGZhaWxlZCwg
cmV0OiVkXG4iLCByZXQpOw0KPiAgDQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+ICsJcG1fcnVudGltZV9wdXRfbm9pZGxlKGR3Yy0+ZGV2KTsNCj4gIA0K
PiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IEBAIC0yNzMyLDIxICsyNzQ2LDIzIEBAIHN0YXRpYyBp
bnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+
ICAJLyoNCj4gIAkgKiBBdm9pZCBpc3N1aW5nIGEgcnVudGltZSByZXN1bWUgaWYgdGhlIGRldmlj
ZSBpcyBhbHJlYWR5IGluIHRoZQ0KPiAgCSAqIHN1c3BlbmRlZCBzdGF0ZSBkdXJpbmcgZ2FkZ2V0
IGRpc2Nvbm5lY3QuICBEV0MzIGdhZGdldCB3YXMgYWxyZWFkeQ0KPiAtCSAqIGhhbHRlZC9zdG9w
cGVkIGR1cmluZyBydW50aW1lIHN1c3BlbmQuDQo+ICsJICogaGFsdGVkL3N0b3BwZWQgZHVyaW5n
IHJ1bnRpbWUgc3VzcGVuZCBleGNlcHQgZm9yIGJ1cyBzdXNwZW5kIGNhc2UNCj4gKwkgKiB3aGVy
ZSB3ZSB3b3VsZCBoYXZlIHNraXBwZWQgdGhlIGNvbnRyb2xsZXIgaGFsdC4NCj4gIAkgKi8NCj4g
IAlpZiAoIWlzX29uKSB7DQo+ICAJCXBtX3J1bnRpbWVfYmFycmllcihkd2MtPmRldik7DQo+IC0J
CWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ICsJCWlmIChwbV9ydW50aW1l
X3N1c3BlbmRlZChkd2MtPmRldikgJiYgIWR3Yy0+Y29ubmVjdGVkKQ0KPiAgCQkJcmV0dXJuIDA7
DQo+ICAJfQ0KPiAgDQo+ICAJLyoNCj4gIAkgKiBDaGVjayB0aGUgcmV0dXJuIHZhbHVlIGZvciBz
dWNjZXNzZnVsIHJlc3VtZSwgb3IgZXJyb3IuICBGb3IgYQ0KPiAgCSAqIHN1Y2Nlc3NmdWwgcmVz
dW1lLCB0aGUgRFdDMyBydW50aW1lIFBNIHJlc3VtZSByb3V0aW5lIHdpbGwgaGFuZGxlDQo+IC0J
ICogdGhlIHJ1biBzdG9wIHNlcXVlbmNlLCBzbyBhdm9pZCBkdXBsaWNhdGUgb3BlcmF0aW9ucyBo
ZXJlLg0KPiArCSAqIHRoZSBydW4gc3RvcCBzZXF1ZW5jZSBleGNlcHQgZm9yIGJ1cyByZXN1bWUg
Y2FzZSwgc28gYXZvaWQNCj4gKwkgKiBkdXBsaWNhdGUgb3BlcmF0aW9ucyBoZXJlLg0KPiAgCSAq
Lw0KPiAgCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZHdjLT5kZXYpOw0KPiAtCWlmICghcmV0
IHx8IHJldCA8IDApIHsNCj4gKwlpZiAoKCFyZXQgJiYgIWR3Yy0+Y29ubmVjdGVkKSB8fCByZXQg
PCAwKSB7DQo+ICAJCXBtX3J1bnRpbWVfcHV0KGR3Yy0+ZGV2KTsNCj4gIAkJaWYgKHJldCA8IDAp
DQo+ICAJCQlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoZHdjLT5kZXYpOw0KPiBAQCAtNDMzMSw2
ICs0MzQ3LDggQEAgc3RhdGljIHZvaWQgZHdjM19nYWRnZXRfc3VzcGVuZF9pbnRlcnJ1cHQoc3Ry
dWN0IGR3YzMgKmR3YywNCj4gIAl9DQo+ICANCj4gIAlkd2MtPmxpbmtfc3RhdGUgPSBuZXh0Ow0K
PiArCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZHdjLT5kZXYpOw0KPiArCXBtX3JlcXVlc3Rf
YXV0b3N1c3BlbmQoZHdjLT5kZXYpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dh
ZGdldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YywNCj4gQEAgLTQ3MTgsNyArNDczNiwxNSBA
QCB2b2lkIGR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudHMoc3RydWN0IGR3YzMgKmR3
YykNCj4gIHsNCj4gIAlpZiAoZHdjLT5wZW5kaW5nX2V2ZW50cykgew0KPiAgCQlkd2MzX2ludGVy
cnVwdChkd2MtPmlycV9nYWRnZXQsIGR3Yy0+ZXZfYnVmKTsNCj4gKwkJcG1fcnVudGltZV9wdXQo
ZHdjLT5kZXYpOw0KPiAgCQlkd2MtPnBlbmRpbmdfZXZlbnRzID0gZmFsc2U7DQo+ICAJCWVuYWJs
ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gKwkJLyoNCj4gKwkJICogV2UgaGF2ZSBvbmx5IHN0
b3JlZCB0aGUgcGVuZGluZyBldmVudHMgYXMgcGFydA0KPiArCQkgKiBvZiBkd2MzX2ludGVycnVw
dCgpIGFib3ZlLCBidXQgdGhvc2UgZXZlbnRzIGFyZQ0KPiArCQkgKiBub3QgeWV0IGhhbmRsZWQu
IFNvIGV4cGxpY2l0bHkgaW52b2tlIHRoZQ0KPiArCQkgKiBpbnRlcnJ1cHQgaGFuZGxlciBmb3Ig
aGFuZGxpbmcgdGhvc2UgZXZlbnRzLg0KPiArCQkgKi8NCj4gKwkJZHdjM190aHJlYWRfaW50ZXJy
dXB0KGR3Yy0+aXJxX2dhZGdldCwgZHdjLT5ldl9idWYpOw0KDQpXaHkgZG8gd2UgaGF2ZSB0byBk
byB0aGlzPyBJZiB0aGVyZSBhcmUgZXZlbnRzLCB0aGUgdGhyZWFkZWQgaW50ZXJydXB0DQpzaG91
bGQgYmUgd29rZW4gdXAuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gIAl9DQo+ICB9DQo+IC0tIA0K
PiAyLjE3LjENCj4g

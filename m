Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FB68CBC9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjBGBOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGBOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:14:20 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A5CDCC;
        Mon,  6 Feb 2023 17:14:18 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3170MbOJ011766;
        Mon, 6 Feb 2023 17:14:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=TkIghnHaA3/DZZBeBiMWPGc/orzTBOwTP5gs0EUSADs=;
 b=FGyB7CdRYlL4VruoVhTDmSGWvHY3A7GYzgBe9b4VpWBGwHAQuuT9e3mmxMMmRsMrJKCu
 u6HlCDyLjGZXbpHa2dWzWDtASug7ybakLGiaeKNghqtAv7Onh2KUOT5ABlr+ogUUgWuL
 LiczGOtn1lIy9QlPupS69XhjM0Em62GN+bX3s5wzwgWQo3PIUZV0UB5r8hPEJq2tGvJH
 I2cHoFZg8oCWNQyxEmOj4XZCMMtUx47hC1G7PVcu4em8I8zyz/1qD/Hx7B7XJsBaSnxm
 MQnlF88ZdRHyRkzMTpz/G70asqT54TzmUSi16d8nmSWZq/3OHbXmDaHvhWKv6alix74H 9A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3nhpvmk8gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 17:14:11 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5702E402B8;
        Tue,  7 Feb 2023 01:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1675732450; bh=TkIghnHaA3/DZZBeBiMWPGc/orzTBOwTP5gs0EUSADs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ioYdGkp60+J4s9mw1uxGUQjJPcN2j73FHgE8drBgFAyx5DJroT6kD+NAfEOJAMirb
         bMO3qliCE3pWVYRxrId2a89VSNbLT56rTs1uVTrRMMazASS/IjYrxvSMwzz0J9zveH
         i2BtyphDSVT93WTSXIbCGwULAc1B1wBtJwAm7pMqAq0I8pWdqt6iWtoiYtQD6m7jSI
         TuMGxXWisyPHxGZAoWxtvLcHCZXR9DCJXkCN8RTYmYDUbbR0/k2IGnlnacf7YeJu2i
         ne5gtnfg4TDR3TBP7sXtUxAcJhAd4IykGxVtVjUtBi+/bFCDBeR5LufAiB+aTbg5qE
         XS8hGOksPPo9w==
Received: from o365relay-in.synopsys.com (us03-o365relay5.synopsys.com [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B6C71A0073;
        Tue,  7 Feb 2023 01:14:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 52E398017C;
        Tue,  7 Feb 2023 01:14:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="h0AHP5C0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAAHlojtApntCyJaJXjKpw5Rv0JPTHmfGRBbMOUaXrgiAPOGznL5rkQix/D+whJA1JNTtDh17WMjlaEWLt/kit7PUuw3QNq6QF84smAoH7dXBZSkrQwzTOgmanY2Y+mFyPA4Mwh+8GjVJvdQCd7RAzAEHAOHq3N/hkPW6Kj3/ify9q8OlZlLLIPnmE/kKmfODdG2bxHtXbOtjQebQB2oQS/rMCf7vOtQl6rqNslBcMgUpJUn7J5BJisuygw0Z5PLQX1saM6w3e1YfaQG7NeGfDW1uk1tJUcpLzppst5cgqo/aU/vmbj4Q4j2GVt9TWDDuqP0izEq1zEu3aZFOHrlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkIghnHaA3/DZZBeBiMWPGc/orzTBOwTP5gs0EUSADs=;
 b=YrfLLrbCixqfM5k0LEySbwiKy058fXQ9EDJVB/COlZdr93LTr7vmGFWtigx4dGmtjvYlwBdwn4ujcpjc43OQm79WZiGKHZhrNlsEH+jaG6JnIuFWGE5L2WN3FMHWHCFKR2WM/GvsPe9nOqIT/mM25puYnuGjYzt9jfUZXTFcSQFLFW+F3MMoOu9YH7ylQa/VR+2mJcUlTVIl/QI3PzpidQVAsbesBcChoIThQzsjjqsZKf4aZ0tQ8eSp1u1e9k5JBIMGuYKdEQbmkMhmX67+fmfU1tDb8Ga95Riw7oekICCHmoT/vWeTX1qr4hsu6WV1LNuKdTrHFg7CAW5ffonH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkIghnHaA3/DZZBeBiMWPGc/orzTBOwTP5gs0EUSADs=;
 b=h0AHP5C0YkopRCKQ0CDFqifZod1aSQej8kJm05HUbAZsW3dyvalb0RcJ4cf55wVALd09BV9kYS5jvgurszBuf+BKmfYXmhEvjECesK3MyHCypbFhH4fZ2G70uk/e9VwKFqNMfR9jfwEFT28047imiUjkUP/AQuwYKpIC5iTqfog=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 01:14:04 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6064.029; Tue, 7 Feb 2023
 01:14:04 +0000
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
Subject: Re: [PATCH v3 3/5] usb: gadget: Add function wakeup support
Thread-Topic: [PATCH v3 3/5] usb: gadget: Add function wakeup support
Thread-Index: AQHZOl8idd11Zvmlz0yy069f2DSL5q7CriaA
Date:   Tue, 7 Feb 2023 01:14:04 +0000
Message-ID: <20230207011355.rm6xrg3c55la52wd@synopsys.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-4-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1675710806-9735-4-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: 66903c2e-0278-4eef-4b7b-08db08a89a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USeQU337o7EZ6btvrv28bHASL4zN/3xLjaXB+Xmo3OOyMcQljeWxedkadZdbxSWFxWJB/CTxf8kekaYLMmMiB2GXQe8GUD4y+ZvSpLy6HUJXY1EvUzD1iK56IXNKOa0x8/H/VUX2spszVtMHKQTQs5qgQmijZH40glxgwxXTUiLPC6V7O4pKcS3E3k6kdljJNcqP9jgtiL0hJWIDy9FuXkPzK38pTM2O9MCT66NL9iUu4Hpq3yhy3xYJt6/nc9+0HBzBQdXDK1lFCoYP0Hi9cWLXJjYXsPtHXBDz2Ba4n9oZshnIvzmBFFR/lTM4d2cuz2ianVBUKxe2iW0R4gVIedX4pvamS33Z5jnCwTXdNasGdbDEp/jM46RqpWR9SttyuCoWCEnnUKsDB+83KEde/YWnqdY9j/67AQgnW85qrPgSVUS1B6HPjxOqIDpShYYrzOE3OK0zAudaCMRKKeah7RqezzQWyqbuFa+29gAwciC8VSqxwjUfdZqFCCG9xWzd2S/1EvMAa0LxbgSY6LCGS22GK6ns4Bu2R1XFbkMPwXjrkQMgSdrRTaMoiEUuLtxm0WXa9HA2OaOZeqL3ruhNOrYxUHpFPOLAQm8Z7hMWutQoGIfsxQ9JJGx/9TjUqdpjHBdKQ6R8ICluD6K18K9n9Yh4r19s+piX0jFetHLwzztKKgYa7mpev+OQ35hVDw9L59DQZsknLxPw8pC5XEvaqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(38070700005)(2906002)(41300700001)(64756008)(478600001)(8676002)(4326008)(86362001)(5660300002)(66476007)(6916009)(66446008)(316002)(54906003)(71200400001)(6486002)(8936002)(66556008)(36756003)(186003)(6506007)(1076003)(6512007)(122000001)(76116006)(26005)(38100700002)(66946007)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUxGR0g3dHJwaXBFRWdLak9uK0NmWWZqOXdRSWVjWWt3UVhYMTEvcFc3MzNk?=
 =?utf-8?B?YkNlT2NadVN6SWRpTS9VZk1BY0Z4UGlnWGtzNk1ONGZpd25qb2U0NnJDZHJ4?=
 =?utf-8?B?ckRlYkpYYjVNWktFTDFobVlGZXNuQ09jL1NFUnJZQWtWMUZEWURoVzFKSnV5?=
 =?utf-8?B?SXdBTnlObDFKb1Ira1RNS2lPaVBUYnJlbWZCWkhPUEpZMTdXc29iU1dhTCtM?=
 =?utf-8?B?UWFCN1l1SmR5MkFIMVhmNXRQOFVrVDRKVTl2TnhvS3J3eS80ZS9HU29JSmh2?=
 =?utf-8?B?eGlQQVV6bUFJZnVYR3Z6aitLRmttTzNMTFV5NVo2K01WaDVkdnFKVXJ5Tzdi?=
 =?utf-8?B?WFFmcDhRSmRKbGtOeUNUb3V1RkFzNzVKbkJrekZ3K1N4U0pla3psaFRLWFZr?=
 =?utf-8?B?dVZVZFdQZnZEN3kwK1BaSHAxVWtVeHVoZUxzak1sUXVpcE5QNlVnVVZhZm5i?=
 =?utf-8?B?UzBqZDh0ZFNIclZRZjJ0cWxhNGJ3bDc2UWdET0o1STl6YjZ4d0ZLM05JN3Fl?=
 =?utf-8?B?eWRmbFlRMFFhZlpzNUFoZ2VHdHhvNkIwZFZoUjM1NzYySUZ5dlJmVlpBRXJK?=
 =?utf-8?B?RzdXWWFGczU1QnlTMFRENkIyRlZUL3lUTVkxMW16ZnVUM01WaFpvZWVNSHU1?=
 =?utf-8?B?NDlrWTI2YUk1NHJlY05nWEE2OG1QdVhpNDhhNWJOT01sTzA2N0U4ZHlOd1U4?=
 =?utf-8?B?UmRpcjlHRmF1dmQzK25ISVd5QlU0cENqNkJKRjQ3NVU5NG5WeTFlVVR6VTFI?=
 =?utf-8?B?OHIyZVJyb0pnNHdpbm56d2Q5SkN3VHhGaHBKa21OMGlxcllHcHNrVTlqcGhu?=
 =?utf-8?B?QUd3M1NDYU5QZTVXSmhxZTZyMk1xcGdlZC9mQlAvSzI2NkpESGNmVkxnOVJa?=
 =?utf-8?B?bks4cXhzc09CK0xZWEV2eEJ3WnV6ODNFZ3RNZHpjdzErWFI3OHNibHlqUEll?=
 =?utf-8?B?RkR2Q2hsaGRoOFJkNU5lZENZaStiR3NTakxXVGZRUkNpK29JemVGK0ViQlRn?=
 =?utf-8?B?YXQvVllWWHlwSko0MitqbmZlRUREU2pJU3B2bC9vbno1TitEQTBNLzhDR2Vw?=
 =?utf-8?B?Q3lNMFB6V1ZORUtDZ2ozK09pTGpMRXZBQXRmZHhHbVNyOGVUYnJqQkJqR0lI?=
 =?utf-8?B?d0I3dHhDWkk0ZDdVL0grTkhpVHVud2xSMmlsNURIWUg4U2xTcnZndHhxRjAr?=
 =?utf-8?B?TWVTcjJ1UjgyN0Y0RStPblNJK1dDTlhYVEV6TlhlMzBpZkVhdDYxVisrR1dv?=
 =?utf-8?B?VDg1VVBHSmR0bWxFek9zOWhaL3FXNzVnMno0UStDaWE3bldoeHI2bzFhUHR5?=
 =?utf-8?B?U1pjRzZ1M09UZWJwOHN4ak1UMXhkbStodEp4MVJmSzlrWG1NR2dQMDdCc3Yw?=
 =?utf-8?B?Mzg1WTIvSWhYbnNYRndIVlBjWTlwQytQcVhlSE1ncWo5ZUFObm9EckZpbFp6?=
 =?utf-8?B?L2ZrV3V5SzJqbjBxVlVnMU0zOE5FNER5OStRSUQ5UTBPbEI3MGV3Q2pqbnZm?=
 =?utf-8?B?VGFLTENSZ01PMFlaNGtBSFV5bk9hWjg2NkNuUkZzOUZFNmloZEdYVWdUSWox?=
 =?utf-8?B?cFVza2Zoa2lJRUg5ck1ob1g3b0x3RG5CbEoxRlVHZUtpelhXNGNWT2NnbmJ3?=
 =?utf-8?B?SSswbFl5bEpsUmRyV0U5a0ppaUgrR25oTnAzLzZoaFMvZG5zaTJ3K0ZlcUhC?=
 =?utf-8?B?MkdmRStLNmhhK1R6T0h1QjNCYU11QjNnWW1zOGl1MGR0ZDBZQ3lROHZVeVlx?=
 =?utf-8?B?VzNNMTlMSjQySE1tQ3luZ2pxMlRGeEhUTDF1ejkvOTVrTkZXV1hsaFJFRUkv?=
 =?utf-8?B?WDE4Q0RQNVVGclFtU2VJYjB2VVFKNGpncHZKT0RaVWtjb0syUExKV2tBelNn?=
 =?utf-8?B?bkltWkp5dmQ2ZUZTTWJiQ1NhZTdxMC95RC9CSFg5Y2NVU0Jwd2s1MStOTUU3?=
 =?utf-8?B?c25UendEbTdBS1lYUU1vT2kzTDJmZHAzemFUamJteGRxT0xBZWpCbWkveE41?=
 =?utf-8?B?MUJGTmVvOHlHS2dzVSsvbXdMZVh3YkViMkphbUVWK0pxK1FnOXBLb2dpaXNo?=
 =?utf-8?B?SWcrZWhmaWlYcmFrMEduRW13WnZDWXBFakw0c1VzcURuYXFZVWI3YjVVZmtv?=
 =?utf-8?B?Y0t3Q2kyYnhTRlBtOUhpN2hleHFyaXkwODBkc25GYkErU3lOOTc4L3EzUkRE?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00407BA74218CA41AB789A0E0709F4D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: phITqmr5bEHxh+CCzmef17UXwo3/ZjAOA+y+P6P8atbM6GwQAfl466MSj5AxlN6SX5EtwM5kxb3OMhBohm7eMINStZOQ8YVYOLlPutPTRVEw7cz9bYERWAFpDNCnBsspgIELinSosgXfLZq4LlbI0I0vsGtB+Kiqr2aEAjNU+9+tqajpTrTUf9vMaeHAxmfWSlmXiQfK9a7yntxik7ykVTva7aZx8068W2J3wgZeWwgCfj2tNAM7/RtzL7hVB5/XJ0ZehtIPBOSw4woh1ikystnvR+dgCKVZJo2+ZL+KtWQ1BhXWhX5JzwBo8diz7wKffqO7tFH39XZIvR7jiGVoxE7BcsFRqZ9wz55qAUZP7ajwWHoqe1n7Zs126jLAEOe9McmdM9GqCRUu+eqpofh1SkdA34UXe5fLVOqT3TcC2tMI59TmLagGyCeovA+q/lWr6ekSDlCVFNrKhi4dp+ve4LTEDcp1NcLgk2tr9uLz7nU/7v9YU0ZO6yiz3WtrHKYg205+PFK2MHcd79GX8iprt9ti9cidj8X1ochGrW8iZfWzT/bXUQmwXNFcaXmgNMvft/KqFGio14W59oFjfD6XwUXiSy8TKXBCCUzTMEcWroesafu9fRrQHGJ2f53MIBR5JAIUnYGf9tE3mlXWVZhCmhCarHtaiwEUaoLDZIZ4vYPP9yOieWv9f6J9BWnAhJH+/4Q9ZyjV3HZeYNV+70tba+MkYt/0a6fKabTq8xDcCyy5nhT0JGIaD+eCpwizx473jxAF+nw0of+ZKFX/BSotOR0C/t1DHiS7asdLcXiInNTDsdwY7VwkSpiu3u2ESO+jD6zBSlpNz0ZIKdSn+j89hwyJdkVZhazrE3TU8eqzajcEhd+LrmJx4IYD3XsDAuq2LUCEWMRDHETMYWcp9nU5CQtLxmcJ3i0ag0OvKVDLei0=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66903c2e-0278-4eef-4b7b-08db08a89a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 01:14:04.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7CzCoXrSns2kYk8bPFf2psfD+sBCGGonD1tlQwpCR5JpQrgNOEeOhhryhqAZzNYk7sm92vdutnBR30TPFM6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
X-Proofpoint-ORIG-GUID: eFFrKHpLqTBQQTByywZt0GMtzAjd9rfq
X-Proofpoint-GUID: eFFrKHpLqTBQQTByywZt0GMtzAjd9rfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=506 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBGZWIgMDYsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IEEgZnVuY3Rp
b24gd2hpY2ggaXMgaW4gZnVuY3Rpb24gc3VzcGVuZCBzdGF0ZSBoYXMgdG8gc2VuZCBhDQo+IGZ1
bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHRvIHRoZSBob3N0IGluIGNhc2UgaXQgbmVlZHMgdG8N
Cj4gZXhpdCBmcm9tIHRoaXMgc3RhdGUgYW5kIHJlc3VtZSBkYXRhIHRyYW5zZmVyLiBBZGQgc3Vw
cG9ydCB0bw0KPiBoYW5kbGUgc3VjaCByZXF1ZXN0cyBieSBleHBvc2luZyBhIG5ldyBnYWRnZXQg
b3AuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9A
cXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIHwg
MjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMv
Y29yZS5jICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvdXNiL2Nv
bXBvc2l0ZS5oICB8ICA2ICsrKysrKw0KPiAgaW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmggICAg
IHwgIDQgKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+IGluZGV4IGU0NTlmYjAuLmFhMjQzZDggMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvY29tcG9zaXRlLmMNCj4gQEAgLTQ5Miw2ICs0OTIsMzIgQEAgaW50IHVzYl9pbnRlcmZh
Y2VfaWQoc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjb25maWcsDQo+ICB9DQo+ICBFWFBPUlRf
U1lNQk9MX0dQTCh1c2JfaW50ZXJmYWNlX2lkKTsNCj4gIA0KPiAraW50IHVzYl9mdW5jX3dha2V1
cChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmdW5jKQ0KPiArew0KPiArCWludCByZXQsIGlkOw0KPiAr
DQo+ICsJaWYgKCFmdW5jLT5mdW5jX3J3X2FybWVkKSB7DQo+ICsJCUVSUk9SKGZ1bmMtPmNvbmZp
Zy0+Y2RldiwgImZ1bmMgcmVtb3RlIHdha2V1cCBub3QgZW5hYmxlZFxuIik7DQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCURCRyhmdW5jLT5jb25maWctPmNkZXYsICIlcyBm
dW5jdGlvbiB3YWtldXBcbiIsIGZ1bmMtPm5hbWUpOw0KDQpEbyB3ZSBuZWVkIHRoaXMgREJHIHBy
aW50Pw0KDQo+ICsNCj4gKwlmb3IgKGlkID0gMDsgaWQgPCBNQVhfQ09ORklHX0lOVEVSRkFDRVM7
IGlkKyspDQo+ICsJCWlmIChmdW5jLT5jb25maWctPmludGVyZmFjZVtpZF0gPT0gZnVuYykNCj4g
KwkJCWJyZWFrOw0KPiArDQo+ICsJaWYgKGlkID09IE1BWF9DT05GSUdfSU5URVJGQUNFUykgew0K
PiArCQlFUlJPUihmdW5jLT5jb25maWctPmNkZXYsICJJbnZhbGlkIGZ1bmN0aW9uIGlkOiVkXG4i
LCBpZCk7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCXJldCA9IHVzYl9n
YWRnZXRfZnVuY193YWtldXAoZnVuYy0+Y29uZmlnLT5jZGV2LT5nYWRnZXQsIGlkKTsNCj4gKw0K
PiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKHVzYl9mdW5jX3dha2V1cCk7
DQo+ICsNCj4gIHN0YXRpYyB1OCBlbmNvZGVfYk1heFBvd2VyKGVudW0gdXNiX2RldmljZV9zcGVl
ZCBzcGVlZCwNCj4gIAkJc3RydWN0IHVzYl9jb25maWd1cmF0aW9uICpjKQ0KPiAgew0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2NvcmUuYw0KPiBpbmRleCA1ODc0ZDRmLi42M2I1OTQ0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2NvcmUuYw0KPiBAQCAtODQ2LDYgKzg0NiwyNSBAQCBpbnQgdXNiX2dhZGdldF9hY3RpdmF0
ZShzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwo
dXNiX2dhZGdldF9hY3RpdmF0ZSk7DQo+ICANCj4gKy8qKg0KPiArICogdXNiX2dhZGdldF9mdW5j
X3dha2V1cCAtIHNlbmRzIGZ1bmN0aW9uIHdha2Ugbm90aWZpY2F0aW9uIHRvIHRoZSBob3N0Lg0K
PiArICogSWYgdGhlIGxpbmsgaXMgaW4gbG93IHBvd2VyIHN0YXRlLCBmaXJzdCBicmluZ3MgdGhl
IGxpbmsgdG8gYWN0aXZlIHN0YXRlLg0KPiArICogQGdhZGdldDogY29udHJvbGxlciB1c2VkIHRv
IHdha2UgdXAgdGhlIGhvc3QNCj4gKyAqIEBpbnRlcmZhY2VfaWQ6IGludGVyZmFjZSBvbiB3aGlj
aCBmdW5jdGlvbiB3YWtlIG5vdGlmaWNhdGlvbiBpcyBzZW50Lg0KPiArICoNCj4gKyAqIFJldHVy
bnMgemVybyBvbiBzdWNjZXNzLCBlbHNlIG5lZ2F0aXZlIGVycm9yIGNvZGUgaWYgdGhlIGhhcmR3
YXJlDQoNCk9uIGNvbXBsZXRpb24sIHRoZSBkZXZpY2Ugbm90aWZpY2F0aW9uIGlzIHNlbnQ/IFNv
IGl0J3MgYSBzeW5jaG9ub3VzDQpjYWxsIHJpZ2h0PyBQcm9iYWJseSBjYW4ndCBiZSBjYWxsZWQg
aW4gaW50ZXJydXB0IGNvbnRleHQ/IENhbiB5b3UNCmRvY3VtZW50IHRoZSBleHBlY3RhdGlvbiBo
ZXJlLg0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICsgKiBkb2Vzbid0IHN1cHBvcnQgc3VjaCBhdHRl
bXB0cy4gRHJpdmVycyBtdXN0IHJldHVybiBkZXZpY2UgZGVzY3JpcHRvcnMgdGhhdA0KPiArICog
cmVwb3J0IHRoZWlyIGFiaWxpdHkgdG8gc3VwcG9ydCB0aGlzLCBvciBob3N0cyB3b24ndCBlbmFi
bGUgaXQuDQo+ICsgKi8NCj4gK2ludCB1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKHN0cnVjdCB1c2Jf
Z2FkZ2V0ICpnYWRnZXQsIGludCBpbnRmX2lkKQ0KPiArew0KPiArCWlmICghZ2FkZ2V0LT5vcHMt
PmZ1bmNfd2FrZXVwKQ0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsNCj4gKwlyZXR1cm4g
Z2FkZ2V0LT5vcHMtPmZ1bmNfd2FrZXVwKGdhZGdldCwgaW50Zl9pZCk7DQo+ICt9DQo+ICtFWFBP
UlRfU1lNQk9MX0dQTCh1c2JfZ2FkZ2V0X2Z1bmNfd2FrZXVwKTsNCj4gKw0KPiAgLyogLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAqLw0KPiAgDQo+ICAjaWZkZWYJQ09ORklHX0hBU19ETUENCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvdXNiL2NvbXBvc2l0ZS5oIGIvaW5jbHVkZS9saW51eC91c2IvY29t
cG9zaXRlLmgNCj4gaW5kZXggOTFkMjJjMy4uYzk1NzNiYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC91c2IvY29tcG9zaXRlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC91c2IvY29tcG9z
aXRlLmgNCj4gQEAgLTE1MCw2ICsxNTAsOSBAQCBzdHJ1Y3QgdXNiX29zX2Rlc2NfdGFibGUgew0K
PiAgICoJR2V0U3RhdHVzKCkgcmVxdWVzdCB3aGVuIHRoZSByZWNpcGllbnQgaXMgSW50ZXJmYWNl
Lg0KPiAgICogQGZ1bmNfc3VzcGVuZDogY2FsbGJhY2sgdG8gYmUgY2FsbGVkIHdoZW4NCj4gICAq
CVNldEZlYXR1cmUoRlVOQ1RJT05fU1VTUEVORCkgaXMgcmVzZWl2ZWQNCj4gKyAqIEBmdW5jX3N1
c3BlbmRlZDogSW5kaWNhdGVzIHdoZXRoZXIgdGhlIGZ1bmN0aW9uIGlzIGluIGZ1bmN0aW9uIHN1
c3BlbmQgc3RhdGUuDQo+ICsgKiBAZnVuY19yd19hcm1lZDogSW5kaWNhdGVzIHdoZXRoZXIgdGhl
IGZ1bmN0aW9uIGlzIGFybWVkIGJ5IHRoZSBob3N0IGZvcg0KPiArICoJd2FrZXVwIHNpZ25hbGlu
Zy4NCj4gICAqDQo+ICAgKiBBIHNpbmdsZSBVU0IgZnVuY3Rpb24gdXNlcyBvbmUgb3IgbW9yZSBp
bnRlcmZhY2VzLCBhbmQgc2hvdWxkIGluIG1vc3QNCj4gICAqIGNhc2VzIHN1cHBvcnQgb3BlcmF0
aW9uIGF0IGJvdGggZnVsbCBhbmQgaGlnaCBzcGVlZHMuICBFYWNoIGZ1bmN0aW9uIGlzDQo+IEBA
IC0yMjAsNiArMjIzLDggQEAgc3RydWN0IHVzYl9mdW5jdGlvbiB7DQo+ICAJaW50CQkJKCpnZXRf
c3RhdHVzKShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICopOw0KPiAgCWludAkJCSgqZnVuY19zdXNwZW5k
KShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICosDQo+ICAJCQkJCQl1OCBzdXNwZW5kX29wdCk7DQo+ICsJ
Ym9vbAkJCWZ1bmNfc3VzcGVuZGVkOw0KPiArCWJvb2wJCQlmdW5jX3J3X2FybWVkOw0KPiAgCS8q
IHByaXZhdGU6ICovDQo+ICAJLyogaW50ZXJuYWxzICovDQo+ICAJc3RydWN0IGxpc3RfaGVhZAkJ
bGlzdDsNCj4gQEAgLTI0MSw2ICsyNDYsNyBAQCBpbnQgY29uZmlnX2VwX2J5X3NwZWVkX2FuZF9h
bHQoc3RydWN0IHVzYl9nYWRnZXQgKmcsIHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsDQo+ICANCj4g
IGludCBjb25maWdfZXBfYnlfc3BlZWQoc3RydWN0IHVzYl9nYWRnZXQgKmcsIHN0cnVjdCB1c2Jf
ZnVuY3Rpb24gKmYsDQo+ICAJCQlzdHJ1Y3QgdXNiX2VwICpfZXApOw0KPiAraW50IHVzYl9mdW5j
X3dha2V1cChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmdW5jKTsNCj4gIA0KPiAgI2RlZmluZQlNQVhf
Q09ORklHX0lOVEVSRkFDRVMJCTE2CS8qIGFyYml0cmFyeTsgbWF4IDI1NSAqLw0KPiAgDQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCBiL2luY2x1ZGUvbGludXgvdXNi
L2dhZGdldC5oDQo+IGluZGV4IDA1ZDE0NDkuLjFlNzM5NDMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvdXNiL2dhZGdldC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvdXNiL2dhZGdldC5o
DQo+IEBAIC0zMDksNiArMzA5LDcgQEAgc3RydWN0IHVzYl91ZGM7DQo+ICBzdHJ1Y3QgdXNiX2dh
ZGdldF9vcHMgew0KPiAgCWludAkoKmdldF9mcmFtZSkoc3RydWN0IHVzYl9nYWRnZXQgKik7DQo+
ICAJaW50CSgqd2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqKTsNCj4gKwlpbnQgICAgICgqZnVu
Y193YWtldXApKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsIGludCBpbnRmX2lkKTsNCj4gIAlp
bnQJKCpzZXRfcmVtb3Rld2FrZXVwKShzdHJ1Y3QgdXNiX2dhZGdldCAqLCBpbnQgc2V0KTsNCj4g
IAlpbnQJKCpzZXRfc2VsZnBvd2VyZWQpIChzdHJ1Y3QgdXNiX2dhZGdldCAqLCBpbnQgaXNfc2Vs
ZnBvd2VyZWQpOw0KPiAgCWludAkoKnZidXNfc2Vzc2lvbikgKHN0cnVjdCB1c2JfZ2FkZ2V0ICos
IGludCBpc19hY3RpdmUpOw0KPiBAQCAtNjE2LDYgKzYxNyw3IEBAIGludCB1c2JfZ2FkZ2V0X2Rp
c2Nvbm5lY3Qoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCk7DQo+ICBpbnQgdXNiX2dhZGdldF9k
ZWFjdGl2YXRlKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpOw0KPiAgaW50IHVzYl9nYWRnZXRf
YWN0aXZhdGUoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCk7DQo+ICBpbnQgdXNiX2dhZGdldF9j
aGVja19jb25maWcoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCk7DQo+ICtpbnQgdXNiX2dhZGdl
dF9mdW5jX3dha2V1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBpbnQgaW50Zl9pZCk7DQo+
ICAjZWxzZQ0KPiAgc3RhdGljIGlubGluZSBpbnQgdXNiX2dhZGdldF9mcmFtZV9udW1iZXIoc3Ry
dWN0IHVzYl9nYWRnZXQgKmdhZGdldCkNCj4gIHsgcmV0dXJuIDA7IH0NCj4gQEAgLTY0Myw2ICs2
NDUsOCBAQCBzdGF0aWMgaW5saW5lIGludCB1c2JfZ2FkZ2V0X2FjdGl2YXRlKHN0cnVjdCB1c2Jf
Z2FkZ2V0ICpnYWRnZXQpDQo+ICB7IHJldHVybiAwOyB9DQo+ICBzdGF0aWMgaW5saW5lIGludCB1
c2JfZ2FkZ2V0X2NoZWNrX2NvbmZpZyhzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAgeyBy
ZXR1cm4gMDsgfQ0KPiArc3RhdGljIGlubGluZSBpbnQgdXNiX2dhZGdldF9mdW5jX3dha2V1cChz
dHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LCBpbnQgaW50Zl9pZCkNCj4gK3sgcmV0dXJuIDA7IH0N
Cj4gICNlbmRpZiAvKiBDT05GSUdfVVNCX0dBREdFVCAqLw0KPiAgDQo+ICAvKi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0qLw0KPiAtLSANCj4gMi43LjQNCj4g

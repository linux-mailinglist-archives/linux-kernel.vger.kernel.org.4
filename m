Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8756D553C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjDCXh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjDCXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:37:24 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B9C1BC3;
        Mon,  3 Apr 2023 16:37:22 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333LT1ZW008102;
        Mon, 3 Apr 2023 16:37:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=QsiDrI5sdsuSNMssATvMeF+xbDDN4Q7rx797YFffbu8=;
 b=TnSgU3X0qPpp3z7rBCQ8yic/BoWF7C6aKSVNhO1Jrkjiy/shlRETPicOfmzAyXaSMfmG
 aGK//PELMkUvEe2DPEaZri6ZPwAG2NJYMMTqMf8S3ADnKTzfeFZ4fpx2CJmZFcRuue1P
 ut2W6aasUVzq+U7qxqqxoZXdIIgSxTDGNxNHxlvrNjiJPz9I+vKLqi7y5DfpPVVs4KuT
 39eKamgmzi0ZJ+oiXekx0FAnVW4kWv5x/Buxoi2eF293+Xi9PgzOgnq6HT3k1SQis6a9
 6VHrIbze9b3H6kjfpB1IfYXX50Y42r/e1lO104+5rm7fDda3yMuW+M+qtjdBoVgg8g+e 2Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkmra3gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 16:37:07 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6A188C04C0;
        Mon,  3 Apr 2023 23:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680565027; bh=QsiDrI5sdsuSNMssATvMeF+xbDDN4Q7rx797YFffbu8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KJL1pFG9BRMWKJ2Qh5GBs7AX/JnAcD7+OMe/Hk/6X8xm9tSZRs/2Ck4TGiLxaF/Iz
         6J4cgfGmQ+zg9/I62aHhg4BOWZEqtk4LaHmp6cmjD1Y9FAerpHRxBdFt5ch5Xqg5rZ
         dLwIOG1Hmu3XchUI0n3z06e/+jsZpo/yhXeP5oECv47/RkVe9Ki0Sb9ED8w5M4Lar2
         HOI6Ts5W1U6RNhA8QL6eKoDbUq5F/6TGDkAPapAJLGnaz0omyWRuxxFAKrzhAnNstx
         7w1ameJe3oste4g64yWTaG2Y9PoNcfhF1pW8rvBmnNtc1P4nZHGP1VrR9P/UZ1BMRw
         3LzLvqJ9Vo+XQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 40EC4A005C;
        Mon,  3 Apr 2023 23:37:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 467AF4006B;
        Mon,  3 Apr 2023 23:37:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="fjg00AMm";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zq+r86LdD9D5Ai35BBkTy7S6E70D8S5ERxtQq3dwxt0BFYjPS6FYF60K7u/vho8g6V/0dlaO7feXLZRxt2vRX5k9nvW3Ufb6tU5UL94+kmrghj0NCeYVM4sLLka4LDjX7V2lQGcupBXJ4Ytj64glH0qTZ4cW4Ymho+7rwLXR3hTrqXyLq7NyF67hGO5G4lSL4A4MyoHekSDALqYwAqYW4B1276nCl7c+Lo/cHstiU+jlbv2NiWqbSoe5FLLpaGP3deBFKJ6OGokb38rJ6DTLfI6/MifRKuUe3TL6yiN2eKSY/rMQx7KqrihhM2mgoG9jA3XEVtH/26rZqp3IudPcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsiDrI5sdsuSNMssATvMeF+xbDDN4Q7rx797YFffbu8=;
 b=B7l1n1oLCFE4/EOxwL5uQwMoJv/WElzaTyCt9rzknEVhhAUhY913aM7iZo6oWuHRZURHpYStiQUuYarC9Fu8LWNH7AqKSlgBCZVDEJ4pJQ9Lf7k/u64RQmHz1730nrScMBox3gf+63JueJZkKZgl8oldeE5HIiCGnYtat6cCbi2FuOqLov2RjO0WguLgBNHW83/boNDVy/hek22JE5f3HfUWNRM2X3TyMkzPw0CT49R+ez3HPYEUPiSXeXqVQEpi3wWPpP/QsfGHg6ogWPh4B7ZEKaOtFb9eQNHdNDKAqDfcoQwUYXlk0NvCxqJN/GFQ2BRKgAlorjKvHPxCOooBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsiDrI5sdsuSNMssATvMeF+xbDDN4Q7rx797YFffbu8=;
 b=fjg00AMmczgyXUiSKjTMQN+VdMpPQuP3L95hGJPKlRor9dK3JCk5/LcOd1f1U5x5nYBs27cQncik+/RDXZ689bHaMKpTtKFoPuA5+Uur6y/ieyt9EQ+BsAjkNa+hIOT+MVSaLbeZe2s7oJ9N1Mtlh7JFC6+j490ltquj1TDziHc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 23:37:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 23:37:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Topic: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAIAAkueAgAB4pQCAAL6cgIAL7uaAgAWI6QA=
Date:   Mon, 3 Apr 2023 23:37:00 +0000
Message-ID: <20230403233652.2exkx2ikifuo4m6h@synopsys.com>
References: <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
 <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
 <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
 <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
 <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
 <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
 <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
 <20230323205139.4on6vx555ohdec7y@synopsys.com>
 <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
In-Reply-To: <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW3PR12MB4409:EE_
x-ms-office365-filtering-correlation-id: 357f6b0b-7b94-407d-e2f6-08db349c52a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijRuFpNzZZaS0NFh9vRYrxszAbVyHVTyAnzjKTEJOjjEYNBNcjyWSHGlp6m+Bjr6PNKfbjl1ahRPPomdIRQmN9bzsQiBElWlzRZaBBt8PpfNNXaK91SKi1FfvBUF+eTMAYxCSxlnTuDZXPfR2c+Bdo8AwLqhnXtvmtucFguL/bqDhomyKYg4wXLDQp7IYFbqxd05VkNnseToqjT4WjDOVW/qIQdUIqNmvmPOXfZYuBfjlC54lUmy/yarJd8TuRnXFfh2Rny8SWbiwk6N70osaZvsv6/Gs20NAlBarB7lOS8xFx2e6+/K0369ucash6uPZKeMFMCkfYFzDYsxbTqxqmU0pBKNGIuuT+qBY+Baeduk5X4Vo06Pq6Dl5qR2AiMg/CDrBhBRpyDIuaD69lQTqERz0NhXiLmTaQFHEzedLc+iqeDAI0F5KI0d5HIIQpS8GxKFaXOvVRX/BXN+Nz/8xz5qeKhLMf3w2hF30lLX909usClhYWuibrp80r0xhTOzO367QFmBGmh1Si87n+9/AipOVYS0DAwOlt6jAlOqCGlI9//1omUsiz4vND2ABwUe2HNuE3Y3j/7y+Fa2+I9m0Rp9IgcB6aAgWLcF7G+T2wayDI9kKUrrv6NrgVTyeoWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(26005)(186003)(53546011)(6506007)(83380400001)(1076003)(4326008)(2616005)(41300700001)(6512007)(478600001)(76116006)(66476007)(66946007)(6916009)(316002)(54906003)(8676002)(66446008)(38100700002)(71200400001)(6486002)(66556008)(36756003)(64756008)(122000001)(86362001)(38070700005)(30864003)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEVDZng5QTU5cXdWV3gwTmxBaEdhNFVuaTMyVzNrS1dWTXJnczhEeTdBeDFD?=
 =?utf-8?B?eUV0VXNYYXdkWkMrS2xqVi8rVTJHc0Z5VnFKa21Qa3FGeENUS0hRZTFLenRN?=
 =?utf-8?B?SERBdGJEbVVJSUg1V3FYdVg3ZGFJbWJISW5UNW9PaXRic3F2Mi95NUgvcTNF?=
 =?utf-8?B?Vm5CR202TEIzakIwdVZGeXJXM2x2cXQ5YTRhRWVDakc3MEFRMzM3U0M4OXdS?=
 =?utf-8?B?MWpGS0lsMzZBZ3pHblNLL3kzcWpGQ0s3ZFNkVkMzeitrZHBXa2crdWlpbmR2?=
 =?utf-8?B?bW1yWm44ZHdSSVcrL3FocjdZS2Q5bUVkOEJZV2JhUlRIa25hMU84U1k1ZFY1?=
 =?utf-8?B?WVhaMjFnWVN4eHpiNjFRWU1EdGdUVHV0WVlVRldWd3VYbUVJTHE2RWpQeE1J?=
 =?utf-8?B?aTdxOUxWMExFRFI3UXU2dXJmYS84MkZVZFNJNDE4b1FYeVBQekl2dFc5WXR2?=
 =?utf-8?B?bEtBMHJ2MXl3eGF1anRHNHBseDBFeXBBMUVaS3k5SFJHR09NaEF1d0c4cnpG?=
 =?utf-8?B?WEJBajJjTEFrMmNIbHlHVWpSNkVWVnBTank4WHNwMzBCU0hlQmZ0dGFTdFRV?=
 =?utf-8?B?MlNQeTBNVlM2dnRiU2JXVWo5V2M5UXd0eVZ0bkVvSVoxOUtLSjRKQnRiaWVC?=
 =?utf-8?B?bElsbWpjQmRLQ1NQbHAwQWtpbldiM2hpRGRJb3NxeGtGQWhud2pwN1dCbG5K?=
 =?utf-8?B?a3dvTVZHdWNUaUt5MW1PcUY0MkJyZitMWU9XNmJCRmFPV1pvVTRXclozdko5?=
 =?utf-8?B?blhrSkczYmNYMUpKOVpaa29YYmNyWDgvaEY2NDJ3YlFaeHl2QTVyV3VLclhS?=
 =?utf-8?B?ZWJQcGU0T0pRRVV1cUVvTGVIQUVybG5nQThLa3FqTEs2b2oybERHdkJJT0Ir?=
 =?utf-8?B?UHd0Z3R6c3ZFcFVsRnNTZDlqeVRscVMyTDFIMkhPT2gxUWxMTFRWa0dPS3VE?=
 =?utf-8?B?dHg3L1VGNzZTYlBwNmpGdzQ2WVVhbWFXSXV3b0w3N3dmQWVjMmFwZjB3S2ZO?=
 =?utf-8?B?alVMZnZQT2Jwc0VZczlOcXhERWxnOHBqeGxreXdiN0FJQ0Z0N0pBVTVWSkdq?=
 =?utf-8?B?eFJFWmVkbnFQNWdzekVhcnNrcExEL3lsb21jaTRWNWVxVFU4YXByUjdEek5w?=
 =?utf-8?B?WUFDUFE4Q3Q0SmU4cU1zWk1TOGdmdVJ1ZDQ5QXBWaVB4ZDNzWWE2dE83SGta?=
 =?utf-8?B?MjN6ajY0cGlnK1FLRjUwNHNaRGIwWlNYM2xHVzVVNk04Zk8zTE1RY0R0N1Bt?=
 =?utf-8?B?YVcvZHNKemR4OGY4R1d2S2hhcXFFU2VnYjcrK1QxL24zUHkrVDhzMnA2dnFP?=
 =?utf-8?B?TlhFUnYwcll0TXR4Q1ltZ1htZVh5aWlwQkpIL3FmR2I3bTN4ajVXYnNRKzd3?=
 =?utf-8?B?OTFTTnplVDZVMENQWlZ0U0t1d0x4VHFqNXBEV2NnYUZUWXJqaUtSUmxWaUNW?=
 =?utf-8?B?TU9vcUZIUFdielM1SXN6RkNYUlVmbDkvL2JrVE16a1pUWElCNklSOUU1bUtZ?=
 =?utf-8?B?NldOSTA0ZTFReHdRUGRlZ3NlNVI5NHIxMy8yVnRQVmRQeVExWWV4aTB5NnBO?=
 =?utf-8?B?Z3EzWmpoWVlldjFERVFUcXNnbWkrVDBmMnlMd2M3RVF5d1NCNEZ1SDVrTGcv?=
 =?utf-8?B?MXNJMWcxb3hpSHF6L3ZlRk5yWUxEci8xK2cvUEJtYUJHc1hFNVZjWDZkWllJ?=
 =?utf-8?B?SzM2WUpoVXRUQjU3b016TE9zc1BvN0JnQmFZQkdSQytlM0xYQUh5Snk1dnJl?=
 =?utf-8?B?S3VBZXVXSzRVelptb0ZGTGtTOHlzdVRLT3ZOMDVDcjMxZTFlKzAvWVpNRzhW?=
 =?utf-8?B?S2ExRmpoZmZkRGorVzEveFp0bjh0UVhpQzVKQVBsK2kzL2k2Z0NiQVpiTnRk?=
 =?utf-8?B?aXBNSlo5MGN0N2dVV01WVzlPRUFwZUxUQ3dNM2VlcVJhQkhKcGdTYzVJSEZF?=
 =?utf-8?B?QU13T1JMS210V21JTXk0WERPYzdpazNYYkFOdmE3OHJDZXF3YjNTUG5CTzVl?=
 =?utf-8?B?QjI4YXdUS3A5WlU4S0Y5N2VLM2Vqbi93cjlablN6OXQ1NjkrSlVZS0JWVWR2?=
 =?utf-8?B?dE5MRHhvMDRnQTJ0S2NNOXYyZDF1OVhGTW1yL2FlblR6TlZjWnl2S0FpQXhM?=
 =?utf-8?Q?dqnrXxVNOe/Da04ZPvvhX1jaJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D4329FFD33A246A67C7C5E5A2A6E68@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SFMybm9reS82QWRTS1ZGU0duWndFNXVWOFd2UGdMODNTMHRLcm1oLzdjQVo0?=
 =?utf-8?B?WlBpbVJjS3doMGNCZkYxRHRkbzAxb3FtK09LZERoTy9YR2V6REJ4N1d5ZExZ?=
 =?utf-8?B?Wm5xbk5Da0pBWFFlU1dGbGoxbzhBc09lRW5tNHp3VHY2NG1UOUVDa09TT2Fm?=
 =?utf-8?B?TEFKdDY5SXBSOElyQ1FpV0YzS0hwZzJWVVVSeFM2azk1NXBYRjBmSlhGTXFt?=
 =?utf-8?B?YklwWWtPVW5ZMU5keFVQYkpDU2lKd2hoQ3IrR1N2Ym1pbFBrWmRHbjlZWWxL?=
 =?utf-8?B?TU9MQ3dJaW93QkRJOWU1M0ZmRUFsL2htekw4UnJKblFWei95eXg3WDJoTGlq?=
 =?utf-8?B?aks4RmVSSS80NHRnOENFbUNsaVFNQ3FoMFZjd1M0T0NNY3kzV1JHUXliRUZy?=
 =?utf-8?B?S2hnUURqSG54WXpuM0h5am12dUpOZDJIakp0eGdNejdIWTl0ZjQwajdYWGdV?=
 =?utf-8?B?cWt3YnRjVVpLdVhKRitKYmd4K0JKeFhNMEs2Wk4vdFRkZXp0aEEyMjg2cFho?=
 =?utf-8?B?R0hPNEJUWEJwM2l0dkRPSVZtRnlacUlWeTlLeUI2UjhFbDkzdU5rMlQ0TVpl?=
 =?utf-8?B?UU01RG9QMVpHWkozdFl3cExEY3luVkhDbmQ4TWVyYVlFM2RmZGFKNGdoRUJz?=
 =?utf-8?B?TktWZzBBbzRLNktIRkdzcTRFMGx4K1R3bE93TGk4MFpZTkMyYU9hRkthL3FL?=
 =?utf-8?B?RjRINVVUR2NNamVHaEExWHZmdFhTSnJwSmYrcXdqckh3ci9Wa3Y5c3NLdGtL?=
 =?utf-8?B?WmJjL1BrbmNzQzRaTGQralhySnNSQ0VWMy9ER1YxTExKWVk0b1lUbWdGdk9K?=
 =?utf-8?B?OUxyRlU3QW5pQlRQOTVKRWRrSFBLNTdyZkRLc0xoZ3FrR09sSlFqMHo4U2dL?=
 =?utf-8?B?Qlc2c0hKMGpmNWJITTFqa0pEb0VjaG5wU1ErWno3YktvRUFLaXZGS0trbW9t?=
 =?utf-8?B?Q2pHbC9IeUI4VkVrMVpqVFhoVGZwc0NSTTB0eXN2Q3huM2wzaE5VZjlPbU5o?=
 =?utf-8?B?UlBXNEN0ZkV6TTN4TFZzQmoyc0ZJWGprVk5tMzFUVTlsREJTQU0rakxiS1BT?=
 =?utf-8?B?eGZxdzUxYVRqckpieUtHUXo0M1IyaGJQWHpjMngvSjBJbjcvVlVPSHVTbzcr?=
 =?utf-8?B?Sjl0aHR6ODducUtCK0ZZcG9KSEpQMGxUb0dKQ2xFbTNabVYreFo2WGtST1JT?=
 =?utf-8?B?QThMOWhpS0thVS9maHdnOFJPajFMcmkwaGY4WWVHSUpwVWRvTUI1NDRCRW5u?=
 =?utf-8?B?bWN2Z2tzbVNxcll6ZDd4M1VBMGRGc2U4K2puVHhJWlo4aXc4UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357f6b0b-7b94-407d-e2f6-08db349c52a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 23:37:00.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW+1GYmeUicGQ9At9W7GEUQXL3aC92DLgoTx/aly9wKzKXk8XY7sp7KsUm8f4hatDncAcJiTRIxpvz044uzW4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
X-Proofpoint-ORIG-GUID: zlV8anLCgCEafpuE_MLY4g9OnBCdiZhq
X-Proofpoint-GUID: zlV8anLCgCEafpuE_MLY4g9OnBCdiZhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030187
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMzEsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEhpLA0KPiANCj4g
T24gMjMvMDMvMjAyMyAyMjo1MSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRodSwgTWFy
IDIzLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMy8w
My8yMDIzIDA0OjE3LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+PiBPbiBXZWQsIE1hciAyMiwg
MjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4+IE9uIFdlZCwgTWFyIDIyLCAyMDIzLCBS
b2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pj4+PiBPbiAyMS8wMy8yMDIzIDIxOjA1LCBUaGluaCBO
Z3V5ZW4gd3JvdGU6DQo+ID4+Pj4+PiBPbiBUdWUsIE1hciAyMSwgMjAyMywgVGhpbmggTmd1eWVu
IHdyb3RlOg0KPiA+Pj4+Pj4+IE9uIFR1ZSwgTWFyIDIxLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdy
b3RlOg0KPiA+Pj4+Pj4+PiBIaSBUaGluaCwNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gT24gMjAv
MDMvMjAyMyAyMDo1MiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4+Pj4+Pj4gSGksDQo+ID4+
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gT24gTW9uLCBNYXIgMjAsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mg
d3JvdGU6DQo+ID4+Pj4+Pj4+Pj4gSW1wbGVtZW50ICdzbnBzLGdhZGdldC1rZWVwLWNvbm5lY3Qt
c3lzLXNsZWVwJyBwcm9wZXJ0eS4NCj4gPj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+IERvIG5vdCBz
dG9wIHRoZSBnYWRnZXQgY29udHJvbGxlciBhbmQgZGlzY29ubmVjdCBpZiB0aGlzDQo+ID4+Pj4+
Pj4+Pj4gcHJvcGVydHkgaXMgcHJlc2VudCBhbmQgd2UgYXJlIGNvbm5lY3RlZCB0byBhIFVTQiBI
b3N0Lg0KPiA+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4gUHJldmVudCBTeXN0ZW0gc2xlZXAgaWYg
R2FkZ2V0IGlzIG5vdCBpbiBVU0Igc3VzcGVuZC4NCj4gPj4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiA+Pj4+
Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4+Pj4+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyAgIHwgMjUg
KysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+Pj4+Pj4+Pj4+ICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuaCAgIHwgIDIgKysNCj4gPj4+Pj4+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+Pj4+Pj4+PiAgMyBmaWxlcyBj
aGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+Pj4+Pj4+Pj4+DQo+
ID4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gPj4+Pj4+Pj4+PiBpbmRleCA0NzZiNjM2MTg1MTEuLmE0N2Ji
YWEyNzMwMiAxMDA2NDQNCj4gPj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiA+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+Pj4+Pj4+
Pj4gQEAgLTE1NzUsNiArMTU3NSw5IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMo
c3RydWN0IGR3YzMgKmR3YykNCj4gPj4+Pj4+Pj4+PiAgCWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0g
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+Pj4+Pj4+Pj4gIAkJCQkic25wcyxk
aXMtc3BsaXQtcXVpcmsiKTsNCj4gPj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4gKwlkd2MtPmdh
ZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChk
ZXYsDQo+ID4+Pj4+Pj4+Pj4gKwkJCQkic25wcyxnYWRnZXQta2VlcC1jb25uZWN0LXN5cy1zbGVl
cCIpOw0KPiA+Pj4+Pj4+Pj4+ICsNCj4gPj4+Pj4+Pj4+PiAgCWR3Yy0+bHBtX255ZXRfdGhyZXNo
b2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiA+Pj4+Pj4+Pj4+ICAJZHdjLT50eF9kZV9lbXBo
YXNpcyA9IHR4X2RlX2VtcGhhc2lzOw0KPiA+Pj4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4+PiBAQCAt
MjAyNywxNCArMjAzMCwyMCBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0
IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPj4+Pj4+Pj4+PiAgew0KPiA+Pj4+Pj4+
Pj4+ICAJdW5zaWduZWQgbG9uZwlmbGFnczsNCj4gPj4+Pj4+Pj4+PiAgCXUzMiByZWc7DQo+ID4+
Pj4+Pj4+Pj4gKwlpbnQgcmV0Ow0KPiA+Pj4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4+PiAgCXN3aXRj
aCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gPj4+Pj4+Pj4+PiAgCWNhc2UgRFdDM19HQ1RM
X1BSVENBUF9ERVZJQ0U6DQo+ID4+Pj4+Pj4+Pj4gIAkJaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVk
KGR3Yy0+ZGV2KSkNCj4gPj4+Pj4+Pj4+PiAgCQkJYnJlYWs7DQo+ID4+Pj4+Pj4+Pj4gLQkJZHdj
M19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiA+Pj4+Pj4+Pj4+ICsJCXJldCA9IGR3YzNfZ2FkZ2V0
X3N1c3BlbmQoZHdjKTsNCj4gPj4+Pj4+Pj4+PiArCQlpZiAocmV0KSB7DQo+ID4+Pj4+Pj4+Pj4g
KwkJCWRldl9lcnIoZHdjLT5kZXYsICJnYWRnZXQgbm90IHN1c3BlbmRlZDogJWRcbiIsIHJldCk7
DQo+ID4+Pj4+Pj4+Pj4gKwkJCXJldHVybiByZXQ7DQo+ID4+Pj4+Pj4+Pj4gKwkJfQ0KPiA+Pj4+
Pj4+Pj4+ICAJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiA+Pj4+Pj4+Pj4+
IC0JCWR3YzNfY29yZV9leGl0KGR3Yyk7DQo+ID4+Pj4+Pj4+Pj4gKwkJaWYoIWR3Yy0+Z2FkZ2V0
X2tlZXBfY29ubmVjdF9zeXNfc2xlZXApDQo+ID4+Pj4+Pj4+Pj4gKwkJCWR3YzNfY29yZV9leGl0
KGR3Yyk7DQo+ID4+Pj4+Pj4+Pj4gIAkJYnJlYWs7DQo+ID4+Pj4+Pj4+Pj4gIAljYXNlIERXQzNf
R0NUTF9QUlRDQVBfSE9TVDoNCj4gPj4+Pj4+Pj4+PiAgCQlpZiAoIVBNU0dfSVNfQVVUTyhtc2cp
ICYmICFkZXZpY2VfbWF5X3dha2V1cChkd2MtPmRldikpIHsNCj4gPj4+Pj4+Pj4+PiBAQCAtMjA4
OCwxMSArMjA5NywxNSBAQCBzdGF0aWMgaW50IGR3YzNfcmVzdW1lX2NvbW1vbihzdHJ1Y3QgZHdj
MyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiA+Pj4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4+PiAg
CXN3aXRjaCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gPj4+Pj4+Pj4+PiAgCWNhc2UgRFdD
M19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+ID4+Pj4+Pj4+Pj4gLQkJcmV0ID0gZHdjM19jb3JlX2lu
aXRfZm9yX3Jlc3VtZShkd2MpOw0KPiA+Pj4+Pj4+Pj4+IC0JCWlmIChyZXQpDQo+ID4+Pj4+Pj4+
Pj4gLQkJCXJldHVybiByZXQ7DQo+ID4+Pj4+Pj4+Pj4gKwkJaWYgKCFkd2MtPmdhZGdldF9rZWVw
X2Nvbm5lY3Rfc3lzX3NsZWVwKQ0KPiA+Pj4+Pj4+Pj4+ICsJCXsNCj4gPj4+Pj4+Pj4+PiArCQkJ
cmV0ID0gZHdjM19jb3JlX2luaXRfZm9yX3Jlc3VtZShkd2MpOw0KPiA+Pj4+Pj4+Pj4+ICsJCQlp
ZiAocmV0KQ0KPiA+Pj4+Pj4+Pj4+ICsJCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4+Pj4+PiArDQo+
ID4+Pj4+Pj4+Pj4gKwkJCWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVW
SUNFKTsNCj4gPj4+Pj4+Pj4+PiArCQl9DQo+ID4+Pj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+Pj4+IC0J
CWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gPj4+Pj4+
Pj4+PiAgCQlkd2MzX2dhZGdldF9yZXN1bWUoZHdjKTsNCj4gPj4+Pj4+Pj4+PiAgCQlicmVhazsN
Cj4gPj4+Pj4+Pj4+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiA+Pj4+Pj4+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+ID4+Pj4+Pj4+Pj4gaW5kZXggNTgyZWJkOWNmOWMyLi5mODRiYWM4MTViZWQgMTAw
NjQ0DQo+ID4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPj4+Pj4+
Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+Pj4+Pj4+Pj4+IEBAIC0xMzI4
LDYgKzEzMjgsOCBAQCBzdHJ1Y3QgZHdjMyB7DQo+ID4+Pj4+Pj4+Pj4gIAl1bnNpZ25lZAkJZGlz
X3NwbGl0X3F1aXJrOjE7DQo+ID4+Pj4+Pj4+Pj4gIAl1bnNpZ25lZAkJYXN5bmNfY2FsbGJhY2tz
OjE7DQo+ID4+Pj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+Pj4+ICsJdW5zaWduZWQJCWdhZGdldF9rZWVw
X2Nvbm5lY3Rfc3lzX3NsZWVwOjE7DQo+ID4+Pj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+Pj4+ICAJdTE2
CQkJaW1vZF9pbnRlcnZhbDsNCj4gPj4+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+Pj4gIAlpbnQJCQlt
YXhfY2ZnX2VwczsNCj4gPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4+Pj4+Pj4+PiBpbmRleCAz
YzYzZmE5N2E2ODAuLjgwNjJlNDRmNjNmNiAxMDA2NDQNCj4gPj4+Pj4+Pj4+PiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+Pj4+Pj4+Pj4+IEBAIC00NTcyLDEyICs0NTcyLDIzIEBAIHZvaWQgZHdj
M19nYWRnZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+Pj4+Pj4+ICBpbnQgZHdjM19n
YWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+Pj4+Pj4+ICB7DQo+ID4+Pj4+
Pj4+Pj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+Pj4+Pj4+Pj4+ICsJaW50IGxpbmtfc3Rh
dGU7DQo+ID4+Pj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+Pj4+ICAJaWYgKCFkd2MtPmdhZGdldF9kcml2
ZXIpDQo+ID4+Pj4+Pj4+Pj4gIAkJcmV0dXJuIDA7DQo+ID4+Pj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+
Pj4+IC0JZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiA+Pj4+Pj4+
Pj4+ICsJaWYgKGR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXAgJiYgZHdjLT5jb25u
ZWN0ZWQpIHsNCj4gPj4+Pj4+Pj4+PiArCQlsaW5rX3N0YXRlID0gZHdjM19nYWRnZXRfZ2V0X2xp
bmtfc3RhdGUoZHdjKTsNCj4gPj4+Pj4+Pj4+PiArCQkvKiBQcmV2ZW50IFBNIFNsZWVwIGlmIG5v
dCBpbiBVMy9MMiAqLw0KPiA+Pj4+Pj4+Pj4+ICsJCWlmIChsaW5rX3N0YXRlICE9IERXQzNfTElO
S19TVEFURV9VMykNCj4gPj4+Pj4+Pj4+PiArCQkJcmV0dXJuIC1FQlVTWTsNCj4gPj4+Pj4+Pj4+
PiArDQo+ID4+Pj4+Pj4+Pj4gKwkJLyogZG9uJ3Qgc3RvcC9kaXNjb25uZWN0ICovDQo+ID4+Pj4+
Pj4+Pj4gKwkJZHdjM19nYWRnZXRfZGlzYWJsZV9pcnEoZHdjKTsNCj4gPj4+Pj4+Pj4+DQo+ID4+
Pj4+Pj4+PiBXZSBzaG91bGRuJ3QgZGlzYWJsZSBldmVudCBpbnRlcnJ1cHQgaGVyZS4gV2hhdCB3
aWxsIGhhcHBlbiBpZiB0aGUNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gRHVlIHRvIHNvbWUgcmVh
c29uLCBpZiBJIGRvbid0IGRpc2FibGUgdGhlIGV2ZW50IGludGVycnVwdHMgaGVyZSB0aGVuDQo+
ID4+Pj4+Pj4+IGFmdGVyIFVTQiByZXN1bWUgdGhlIFVTQiBjb250cm9sbGVyIGlzIG1hbGZ1bmN0
aW9uaW5nLg0KPiA+Pj4+Pj4+PiBJdCBubyBsb25nZXIgcmVzcG9uZHMgdG8gYW55IHJlcXVlc3Rz
IGZyb20gSG9zdC4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFlvdSBzaG91bGQgbG9vayBpbnRvIHRo
aXMuIFRoZXNlIGV2ZW50cyBhcmUgaW1wb3J0YW50IGFzIHRoZXkgY2FuIHRlbGwNCj4gPj4+Pj4+
PiB3aGV0aGVyIHRoZSBob3N0IGluaXRpYXRlcyByZXN1bWUuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4NCj4gPj4+Pj4+Pj4+IGRldmljZSBpcyBkaXNjb25uZWN0ZWQgYW5kIHJlY29ubmVjdCB0byB0
aGUgaG9zdCB3aGlsZSB0aGUgZGV2aWNlIGlzDQo+ID4+Pj4+Pj4+PiBzdGlsbCBpbiBzeXN0ZW0g
c3VzcGVuZD8gVGhlIGhvc3Qgd291bGQgbm90IGJlIGFibGUgdG8gY29tbXVuaWNhdGUgd2l0aA0K
PiA+Pj4+Pj4+Pj4gdGhlIGRldmljZSB0aGVuLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBJbiB0
aGUgVEkgcGxhdGZvcm0sIFRoZSBzeXN0ZW0gaXMgd29rZW4gdXAgb24gYW55IFZCVVMvbGluZXN0
YXRlIGNoYW5nZQ0KPiA+Pj4+Pj4+PiBhbmQgaW4gZHdjM19nYWRnZXRfcmVzdW1lIHdlIGVuYWJs
ZSB0aGUgZXZlbnRzIGFnYWluIGFuZCBjaGVjayBmb3IgcGVuZGluZw0KPiA+Pj4+Pj4+PiBldmVu
dHMuIElzIGl0IHBvaW50bGVzcyB0byBjaGVjayBmb3IgcGVuZGluZyBldmVudHMgdGhlcmU/DQo+
ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBJdCBzZWVtcyBmcmFnaWxlIGZvciB0aGUg
aW1wbGVtZW50YXRpb24gdG8gYmUgZGVwZW5kZW50IG9uIHBsYXRmb3JtDQo+ID4+Pj4+Pj4gc3Bl
Y2lmaWMgZmVhdHVyZSByaWdodD8NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEFsc28sIHdoYXQgd2ls
bCBoYXBwZW4gaW4gYSB0eXBpY2FsIGNhc2Ugd2hlbiB0aGUgaG9zdCBwdXRzIHRoZSBkZXZpY2UN
Cj4gPj4+Pj4+PiBpbiBzdXNwZW5kIGFuZCBpbml0aWF0ZXMgcmVzdW1lIHdoaWxlIHRoZSBkZXZp
Y2UgaXMgaW4gc3lzdGVtIHN1c3BlbmQNCj4gPj4+Pj4+PiAoYW5kIHN0YXkgaW4gc3VzcGVuZCBv
dmVyIGEgcGVyaW9kIG9mIHRpbWUpPyBUaGVyZSBpcyBubyBWQlVTIGNoYW5nZS4NCj4gPj4+Pj4+
PiBUaGVyZSB3aWxsIGJlIHByb2JsZW0gaWYgaG9zdCBkZXRlY3RzIG5vIHJlc3BvbnNlIGZyb20g
ZGV2aWNlIGluIHRpbWUuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBEb24ndCB3ZSBuZWVkIHRoZXNl
IGV2ZW50cyB0byB3YWtldXAgdGhlIGRldmljZT8NCj4gPj4+Pj4NCj4gPj4+Pj4gVGhhdCdzIHdo
eSB0aGUgVEkgaW1wbGVtZW50YXRpb24gaGFzIGxpbmUtc3RhdGUgY2hhbmdlIGRldGVjdGlvbiB0
bw0KPiA+Pj4+PiBkZXRlY3QgYSBVU0IgcmVzdW1lLiBXZSBhcmUgZG9pbmcgYSBvdXQtb2YtYmFu
ZCB3YWtlLXVwLiBUaGUgd2FrZSB1cA0KPiA+Pj4+PiBldmVudHMgYXJlIGNvbmZpZ3VyZWQgaW4g
dGhlIHdyYXBwZXIgZHJpdmVyIChkd2MzLWFtNjIuYykuDQo+ID4+Pj4+DQo+ID4+Pj4+IERvIHlv
dSBrbm93IG9mIGFueSBkd2MzIGltcGxlbWVudGF0aW9uIHRoYXQgdXNlcyBpbi1iYW5kIG1lY2hh
bmlzbQ0KPiA+Pj4+PiB0byB3YWtlIHVwIHRoZSBTeXN0ZW0uIGkuZS4gaXQgcmVsaWVzIG9uIGV2
ZW50cyBlbmFibGVkIGluIERFVlRFTiByZWdpc3Rlcj8NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+
IFdlIHJlbHkgb24gUE1FLiBUaGUgUE1FIGlzIGdlbmVyYXRlZCBmcm9tIHRoZSBQTVUgb2YgdGhl
IHVzYiBjb250cm9sbGVyDQo+ID4+Pj4gd2hlbiBpdCBkZXRlY3RzIGEgcmVzdW1lLiBJZiB5b3Vy
IHBsYXRmb3JtIHN1cHBvcnRzIGhpYmVybmF0aW9uIGFuZCBpZg0KPiA+Pj4+IHRoZSByZXN1bWUg
c2lnbmFsIGlzIGNvbm5lY3RlZCB0byB0aGUgbG93ZXIgbGF5ZXIgcG93ZXIgbWFuYWdlciBvZiB5
b3VyDQo+ID4+Pj4gZGV2aWNlLCB0aGVuIHlvdSBjYW4gd2FrZXVwIHRoZSBzeXN0ZW0gb25lIGxl
dmVsIGF0IGEgdGltZS4gRm9yIGV4YW1wbGUsDQo+ID4+Pj4gaWYgeW91ciBkZXZpY2UgaXMgYSBw
Y2kgZGV2aWNlLCB0aGF0IHdha2V1cCBzaWduYWwgd291bGQgdGllIHRvIHRoZSBwY2kNCj4gPj4+
PiBwb3dlciBtYW5hZ2VyLCB3YWtpbmcgdXAgdGhlIHBjaSBsYXllciBiZWZvcmUgd2FraW5nIHVw
IHRoZSBjb3JlIG9mIHRoZQ0KPiA+Pj4+IHVzYiBjb250cm9sbGVyLiBUaGF0J3MgaG93IHRoZSBo
b3N0IHdha2VzIHVwIHRoZSBob3N0IHN5c3RlbSAoZS5nLiBmcm9tDQo+ID4+Pj4gcmVtb3RlIHdh
a2V1cCkuIEZvciB0aGlzIHRvIHdvcmssIHdlIGV4cGVjdCBzb21ldGhpbmcgc2ltaWxhciBvbiB0
aGUNCj4gPj4+PiBkZXZpY2Ugc2lkZS4NCj4gPj4+Pg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gV2UgbWF5IG5vdCBiZSBhYmxlIHRvIHN1c3BlbmQgZXZlcnl0aGluZyBpbiBzeXN0ZW0g
c3VzcGVuZCBmb3IgdGhpcw0KPiA+Pj4+Pj4gY2FzZS4gSSdtIHRoaW5raW5nIG9mIHRyZWF0aW5n
IHRoZXNlIGV2ZW50cyBhcyBpZiB0aGV5IGFyZSBQTUUgdG8gd2FrZXVwDQo+ID4+Pj4+PiB0aGUg
ZGV2aWNlLCBidXQgdGhleSBhcmUgbm90IHRoZSBzYW1lLiBJdCBtYXkgbm90IGJlIHNpbXBsZSB0
byBoYW5kbGUNCj4gPj4+Pj4+IHRoaXMuIFRoZSBsb3dlciBsYXllcnMgbWF5IG5lZWQgdG8gc3Rh
eSBhd2FrZSBmb3IgdGhlIGR3YzMgdG8gaGFuZGxlDQo+ID4+Pj4+PiB0aGVzZSBldmVudHMuIEht
Li4uIGl0IGdldHMgYSBiaXQgY29tcGxpY2F0ZWQuDQo+ID4+Pj4+DQo+ID4+Pj4+IEFzIHdlIGFy
ZSBnb2luZyBpbnRvIHN1c3BlbmQsIHdlIGFyZSBub3QgcmVhbGx5IGluIGEgcG9zaXRpb24gdG8g
aGFuZGxlIGFueQ0KPiA+Pj4+PiAoREVWVEVOKSBldmVudHMgdGlsbCB3ZSBoYXZlIGZ1bGx5IHJl
c3VtZWQuDQo+ID4+Pj4+IFNvIHllcywgd2UgbmVlZCB0byByZWx5IG9uIHBsYXRmb3JtIHNwZWNp
ZmljIGltcGxlbWVudGF0aW9uIHRvIHdha2UNCj4gPj4+Pj4gdGhlIFN5c3RlbSBvbiBhbnkgVVNC
IGV2ZW50Lg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gWW91IG1heSBiZSBhYmxlIHRvIGRldGVj
dCB2YnVzIGNoYW5nZSB0aHJvdWdoIHRoZSBjb25uZWN0b3IgY29udHJvbGxlci4NCj4gPj4+PiBI
b3dldmVyLCB0aGUgdXNiIGNvbnRyb2xsZXIgaXMgdGhlIG9uZSB0aGF0IGRldGVjdHMgaG9zdCBy
ZXN1bWUuIFdoYXQNCj4gPj4+PiBwbGF0Zm9ybSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiBkbyB5
b3UgaGF2ZSBvdXRzaWRlIG9mIHRoZSB1c2INCj4gPj4+PiBjb250cm9sbGVyIGRvIHlvdSBoYXZl
IHRvIGdldCBhcm91bmQgdGhhdD8NCj4gPj4+Pg0KPiA+Pj4+IEknbSBub3Qgc3VyZSBpZiB5b3Vy
IHBsYXRmb3JtIHN1cHBvcnRzIGhpYmVybmF0aW9uIG9yIGlmIHRoZSBQTUUgc2lnbmFsDQo+ID4+
Pj4gb24geW91ciBwbGF0Zm9ybSBjYW4gd2FrZXVwIHRoZSBzeXN0ZW0sIGJ1dCBjdXJyZW50bHkg
ZHdjMyBkcml2ZXINCj4gPj4+PiBkb2Vzbid0IGhhbmRsZSBoaWJlcm5hdGlvbiAoZGV2aWNlIHNp
ZGUpLiBJZiB0aGVyZSdzIG5vIGhpYmVybmF0aW9uLA0KPiA+Pj4+IHRoZXJlJ3Mgbm8gUE1FLg0K
PiA+Pg0KPiA+PiBObywgaW4gdGhpcyBUSSBTb0MsIGhpYmVybmF0aW9uIGZlYXR1cmUgaXMgbm90
IHN1cHBvcnRlZCBpbiB0aGUgZHdjMyBjb3JlLg0KPiA+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4g
QWN0dWFsbHksIEkgdGhpbmsgdGhlIGR3YzMgY29yZSBpcyBzdGlsbCBvbiBkdXJpbmcgc3lzdGVt
IHN1c3BlbmQgZm9yDQo+ID4+PiB5b3UgcmlnaHQ/IFRoZW4gSSB0aGluayB3ZSBjYW4gdXNlIHRo
ZSB3YWtldXAgZXZlbnQgdG8gd2FrZXVwIHN5c3RlbQ0KPiA+Pj4gc3VzcGVuZCBvbiBob3N0IHJl
c3VtZT8gWW91IGNhbiBpZ25vcmUgYWJvdXQgUE1FIGluIHRoaXMgY2FzZS4gWW91IG1heQ0KPiA+
Pj4gbmVlZCB0byBsb29rIGludG8gd2hhdCBuZWVkcyBzdGF5IGF3YWtlIHRvIGFsbG93IGZvciBo
YW5kbGluZyBvZiB0aGUNCj4gPj4+IGR3YzMgZXZlbnQuDQo+ID4+DQo+ID4+IEJ1dCBpbiBTb0Mg
ZGVlcC1zbGVlcCBzdGF0ZSwgYWxsIGNsb2NrcyB0byB0aGUgZHdjMyBjb3JlIGFyZSBzdG9wcGVk
Lg0KPiA+PiBTbyBJJ20gbm90IHN1cmUgaWYgZHdjMyBldmVudHMgd2lsbCB3b3JrLg0KPiA+Pg0K
PiA+IA0KPiA+IFJpZ2h0LCB5b3UgbmVlZCB0byBrZWVwIHRob3NlIGNsb2NrcyBydW5uaW5nIHRv
IGRldGVjdCBob3N0IHJlc3VtZS4NCj4gPiBUaGVyZSdzIHN0aWxsIHNvbWUgcG93ZXIgc2F2aW5n
IHRocm91Z2ggdGhlIGR3YzMgY29udHJvbGxlcidzIGhhbmRsaW5nDQo+ID4gaW4gc3VzcGVuZC4g
WW91IG1heSBoYXZlIHNvbWUgbGltaXRlZCBwb3dlciBzYXZpbmcgZnJvbSBvdGhlciBzdXNwZW5k
ZWQNCj4gPiBkZXZpY2VzIG9uIHlvdXIgc2V0dXAuIEhvd2V2ZXIsIEkgZG9uJ3QgdGhpbmsgd2Ug
Y2FuIGV4cGVjdCB0aGUgcGxhdGZvcm0NCj4gPiB0byBnbyBpbnRvIGRlZXAtc2xlZXAgYW5kIGFs
c28gaGFuZGxlIGhvc3QgcmVzdW1lLg0KPiANCj4gV2h5IG5vdD8gaWYgdGhlIFBIWSBjYW4gZGV0
ZWN0IHRoZSBob3N0IHJlc3VtZSBhbmQgd2FrZSB1cCB0aGUgU29DIGl0IHdpbGwNCj4gd29yayBy
aWdodD8NCj4gDQoNCkhtLi4uIEkgc3VwcG9zZWQgaXQgbWF5IGJlIHBvc3NpYmxlLiBCdXQgaXQg
bWF5IG5lZWQgc29tZSB1bmNvbnZlbnRpb25hbA0KZGVzaWduPyBUaGUgZHdjMyBjb250cm9sbGVy
IGlzIGN1cnJlbnRseSByZWdpc3RlcmVkIHRvIHRoZSBwaHkuIEZvciB0aGF0DQp0byB3b3JrLCB5
b3VyIHBoeSBuZWVkcyB0byBiZSBhYmxlIHRvIHRhbGsgdG8gYm90aCB0aGUgZHdjMyBjb250cm9s
bGVyDQphbmQgc29tZSBvdGhlciBjb250cm9sbGVyIChlcXVpdmFsZW50IHRvIGR3YzMgUE1VKSB0
aGF0IG1hbmFnZXMNCnBvd2VyL2ludGVycnVwdC4gVGhlIGR3YzMgY29udHJvbGxlciB3b3VsZCBu
ZWVkIHRvIHJlbGlucXVpc2ggY29udHJvbCB0bw0KdGhpcyBvdGhlciBwaHkgY29udHJvbGxlciBv
biBzdXNwZW5kLiBUaGUgcGh5IGRyaXZlciB3b3VsZCB0aGVuIGJlIGFibGUNCnRvIGFzc2VydCBp
bnRlcnJ1cHQgd2FraW5nIHVwIHRoZSBzeXN0ZW0gb24gcmVzdW1lIHNpZ2FsIGRldGVjdGlvbiwN
CndoaWNoIGluIHR1cm4gcmVsaW5xdWlzaCBjb250cm9sIHRvIHRoZSBkd2MzIGNvbnRyb2xsZXIu
IEFsbCBvZiB0aGlzIGhhcw0KdG8gd29yayB3aGlsZSB0aGUgcGh5IHNpZ25hbGluZyByZW1haW5z
IHN5bmNocm9uaXplZCB3aXRoIHRoZSBkd2MzDQpjb250cm9sbGVyLg0KDQpGcm9tIHRoZSBwYXRj
aGVzIHlvdSBzZW50LCBJIGRvbid0IHNlZSB0aGUgY2hhbmdlcyBuZWNlc3NzYXJ5IGZvciB0aGlz
DQp0byB3b3JrLiBJZiB0aGVyZSBpcyBzb21ldGhpbmcgdGhhdCBJJ20gbWlzc2luZywgcGxlYXNl
IGFsc28gbm90ZSBpdCBvcg0KYWRkIGl0IGhlcmUgdG8gdGhlIHNlcmllcy4NCg0KVGhhbmtzLA0K
VGhpbmg=

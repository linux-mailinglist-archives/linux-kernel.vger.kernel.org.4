Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9597208E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbjFBSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjFBSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:17:06 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B6918D;
        Fri,  2 Jun 2023 11:17:05 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352HfTTi008753;
        Fri, 2 Jun 2023 11:17:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2zVjmnY6sS4SF1MgYOor17EoSB9C2oquvKRjQl+8ljY=;
 b=m1WfAQXBHMWdooU2NNPzckUnArkXBiTa2PWHE5k+XQBRv7khZYZrTusls4nd+BSm718l
 DZeeDf6jxXvuXfwDs5Bg6DQAgB8IN+e95KUWzUVwRgj3/nKj639x14Bm082oHMgYUVwU
 ZQPP/4owZpBB6Y/oOMvd8Y8ySG3CEU3bQ/WigzNfloDP2xJ3nDLfNa02CtaR1IMk9DRf
 8/IiRHZfwGipFL6yBcEx8GwqkKN6QslrES9Di48PFeORSQ0ij3z6iMFeXcSQNyEbuJar
 lFD9glMt2cZG98/W9it4ySTosDm31Jgp0T+Z1eVFOq+Il9YysfZf6ap0KJO46P9bsLn8 8Q== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3quh454ewy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 11:17:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1685729821; bh=2zVjmnY6sS4SF1MgYOor17EoSB9C2oquvKRjQl+8ljY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XzjBz1APRwqkznSYGJFl4dKoThhqN84nZVxj/EvFqNpGM3mXdSyEct4g2A2qzLm3B
         OSw+d4FFZzFZS45yyAfhAr0a2tE1pzYFwPvacwwFPd8T6ZPZsZvET89IKHo113njnT
         BdOJYcGlHrgrDRQzS2mm7jYF9CYCTxpYXen6CY/oasgmIYKmlamvuXpOQ8hXP8Cdf4
         vrkT4m4bKPpWSBYYjMAxWSaBtd5yCOov7ytM381atyQ9cS7yJUUuwGqo5psp1Reuxu
         jCPXePPqQ/3y//fPbpRKjqyh5Bl4IUTkYv2CJpn70NQ3tUZM138z2Mpu+RXWdb/9VI
         s6svLM66djLeA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AADE240145;
        Fri,  2 Jun 2023 18:17:01 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2A46EA00A0;
        Fri,  2 Jun 2023 18:17:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Sls+W4D/;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7353F4012B;
        Fri,  2 Jun 2023 18:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yzr8wNLNwi+zl99jNko0wZFDcevwE/QI8oq1e0tkuO+Aauj+j6WYnwDljgp8sZcJbEPKVVDYkQQHjRgk2bml4D/AkPdCXBCCzQGswhwbyRxMiifyJiEuDMuS9JJsjb4HsurYq6B8zDKRwrkLg2Cx6wYsNdjP3oi0ks+CwpKK2bCW+q+wRQVfUNGZnfjlNQmTA1dA9o1Cf+8uSxisiTY+j63by/+LTIior0TKd5tK3gflHd/iGNsotUjbrNZ8Ke1OtTnFQx3KmvdipE+87x/pYyaWDvssAzHIvRxiSyi6YwG6Q0HeMP51679onPmK1kOOMcNj9PTaEWretlxjPNWLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zVjmnY6sS4SF1MgYOor17EoSB9C2oquvKRjQl+8ljY=;
 b=m5fGTR5Pfz/BRN2DH6M1s0/ZtO0sIUPANB8ppzKjQbNXaF14ilM4LHkJv+7iDPXjGqvRqEdDPKOq14wEj64K1px8KxqR+oPr+Hk4WzwfV71PJd0hV2iMPpHZjh4BryfG4YY4h4em2KoW2syXWAJeI6a8SMFwj87oJavOIXu46/zFYWL1WkaxzkW0Uc1v9KHROtH8gm7/aAg+DBBrSmSl8mH5Ee+NGLEtfW/c6mLfXmblwPe/GGpkDecpIrHja5SaGGOYmSDoEi9tJkAeSd43WGSdmMhYW0OA4E3WZ3GKqFlTNQvWmHLAWZkIA71TClGTU89rc2KwZrYbfvbjcsk6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zVjmnY6sS4SF1MgYOor17EoSB9C2oquvKRjQl+8ljY=;
 b=Sls+W4D/fk7OywBRSvFC0o0w8081rUzGvxt+Uwg6rViW+QkSi9ZzEu01n3aypjxEhrRQK50oHHcc8mDSngHErgS6R5c+9a/Hr4YIDabwbdSpaj5aTmnHRGayjQ7aTDk3zdM3GOigxpGVAX1oPCmqmK9cwRHnsQU6P18mpxK61ao=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 2 Jun
 2023 18:16:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 18:16:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Thread-Topic: [PATCH v2 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Thread-Index: AQHZkCPWoyb7AC3RH0W4PeCdk3PdyK9zciAAgAMoSwCAAUIPgA==
Date:   Fri, 2 Jun 2023 18:16:56 +0000
Message-ID: <20230602181641.7wwcj4ywjaaw5f6o@synopsys.com>
References: <1685141140-26228-1-git-send-email-quic_eserrao@quicinc.com>
 <1685141140-26228-3-git-send-email-quic_eserrao@quicinc.com>
 <20230530225100.wkeai3arwg6cmjjw@synopsys.com>
 <11a60626-2363-e743-8136-3233acf5b85e@quicinc.com>
In-Reply-To: <11a60626-2363-e743-8136-3233acf5b85e@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB5419:EE_
x-ms-office365-filtering-correlation-id: 27846159-ebb0-4f56-674e-08db63958ca2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H2ghp7laTwYmgBxmOLkgnVcnr4LqcyENo3RnTtVgaJudJhs4E0rUksyMfNquDzX4xuI+LTAoMfpyqEvtm9zjtyDp3SzA0+JXLLBhGoEO5F97UMt/vcbCWjQT/bEutEayGhgSyH3fiCG6ZgbGLJfLrEAUo2QeQ9vWDeZpYkiED2CIjaOb8rbJQZW5tP5QyweVrXfSL3D37wowheOmO6PNfC79oks+hJTxLZ0nnbflKsC8j9iWxUr2dvpsONX6NJoCWuKk1xYkd8U2m6ZPj0VUCh6/tJVcdiKWpXbDiMgF8g+RpmKMLwyYpLLusJEt/ncz/IfnR+PVjO5Nnc6bZj8+ANiQQxfm11LPGy8VQAFpKRxZtBM2sAT1Z1HK6hSdh27+RB9Cr/TVmxBZCF7XEv2lpc87sLSMZ4l5zYTG/lXqqHx8hCyLNdyWopNOwXR7D956RAt4e46KZFk5D6Bf7QlMRVykY+XcgJlEp0FftxBrJ/SP4h/kjaRuE8XCKvUDh90amqkEC919gg+ivSoVkFzbJILOTzvxSoGHFPFP5uQwMTPNMvS8js52obHOwrSr2nTrVhM0p8rDiYoRQ1tPPSBpEWMJcpPyRRd9O8wMbxSIzVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(86362001)(36756003)(122000001)(38100700002)(38070700005)(478600001)(71200400001)(54906003)(966005)(6486002)(15650500001)(8936002)(8676002)(5660300002)(76116006)(4326008)(6916009)(66476007)(64756008)(66446008)(66556008)(2906002)(66946007)(316002)(41300700001)(186003)(53546011)(2616005)(1076003)(83380400001)(6506007)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEFDMmZZWUNHdVdPRm4weUlmekRvQ2ovNkNaeko2SS93ZGFtK0RJM3JwUnd1?=
 =?utf-8?B?ZjRuNnY1dFI1a0lEc0NNUTAwbHRPL2FLdmU1Uk1mYjRoMlEyVmVmRm1Mei9x?=
 =?utf-8?B?ai95UU9aUUVDeGR4TFA3QVBPMXJJQXhYVUpMRTBNQmNENHFqa2pROUFSMTFH?=
 =?utf-8?B?K3IzNUpULzNzZS9uSjVNZHU1R2JmYzBHemduNUtaN21lUFVzM3NvS1NNcUVw?=
 =?utf-8?B?NGU2MEdSR25FdVlIck1iR2dLT0lnTlpoOTNkRU83QVJQWHFFY1BpVHlLcnZv?=
 =?utf-8?B?dHV4T3dxVldnY1kwMEVlYjNsRFM0QzhJWjBmUDRlSWRWS1JCSitiL3pVZW9Z?=
 =?utf-8?B?NEx0eXd6UXNPTkV6clByNk8zM3MyV1F5SzBpNGpNRzdrd3Y3eGE1aWl2UUd4?=
 =?utf-8?B?YjBHNWhMaW4zQ2oydmhwOU01ZHV0QjNWM3JmalJPUWI3QXBqQktyc29SbXVJ?=
 =?utf-8?B?VXVmV0VTR25XQkc3WXhCTWFuRUhvUGx5eCs4bnRtazV0NW4xK1Z1V3ZVUlJI?=
 =?utf-8?B?UVpUSVQ5djVmSUwySU5KUGxXN2VIYThvZnBzYmkvRUNXKzdzNWJlY1Q2T3hW?=
 =?utf-8?B?R0dvaUZjV3ZxOW9GbmNLbzdGVzNCekVmeFdpYVRsY0NwemUxcHp3OVp1MHdn?=
 =?utf-8?B?cWRNZmdhTVhuQUR3TlBlNmdGdTV5UUFGWjdDYisxUXdHNzloZlZSR1MvVWE4?=
 =?utf-8?B?bnkyUUttcTVHZXVmclpLb0pWcUtpY2VVVmhRYitQRW5sYzV6WXhjN25Kc0Jy?=
 =?utf-8?B?M2ZVUUpQTW91NW51RnpWMjRseGhZbU1kbUZxUklhVUlsc0hrRnI0K2RRUWFQ?=
 =?utf-8?B?Ymo5QXZmdHJVSTVKcmNhRWU5NjRYVTUxbEIzYm9Xam1mV2pFcktycUQ0Vmds?=
 =?utf-8?B?Slg4TTJRNzUvdzB2SFRZdXZMQjR4akkreWpreWZFOUU1VWY1QnBpcTAyQTVH?=
 =?utf-8?B?bkY2ejhPcXdSMkpQVFd0ZXNLS2NseEV4K3ZPVW1QZ0Q4UmhqdW0zeS9Uekcz?=
 =?utf-8?B?ZkMwY1MxbWJhcForWDVxamRjTGo0N2JEY1AwR25HbDh2Q1c5TXd1RjhUdHhY?=
 =?utf-8?B?MGpWbUJtaFdxbWNjck1FeGpTQjVJUUREOEhRNm9lc2tTT2VKVlVQZnIzWVdm?=
 =?utf-8?B?NTlDcXJBZm5aSmdCeTV6TjcxazVTMU1taHdzQytKa0gzLzNyeUI5QnArUXZF?=
 =?utf-8?B?YytzcjYxeXBrYkZDZW1qdXRPNDFqdlRmUG9nelRtR1JRd29yUXg0WmJwcWc3?=
 =?utf-8?B?QW5mTDRMMjg2Y2JhWG9SK2xJL0dFNjRKWGZ5aXhlR1ZUNERpU2VtRVYyTjBV?=
 =?utf-8?B?VTEwb3gvRGVnKzB5YnZFV0RUbGVYMldzMHFHdmR0YWpCTGVGeU1LdHVqR1N2?=
 =?utf-8?B?MlhkOFlMRnkxRjZQYkdOdmtWVzA4dVhQRnZhR1hjM0ZpT2xpZkdlRlgzZ0NT?=
 =?utf-8?B?K1FndHhsNmpUTWhJc1NKeDRCVWJzcVZkd2RqcGZmdXdRWGhyVHplWis4ZDQ3?=
 =?utf-8?B?cWk2MXl1NVVjeEdVTWluc0drbk5kVTRkTzFvMEpSb0hxZnNzUzNFZ09pTE8v?=
 =?utf-8?B?TEJ4MGJsZ2ZvblhqR1k0QTF0RlZzL0ovVVowYUV2cks3cjZrSElTeitjam9k?=
 =?utf-8?B?OEpWV0lMMFZwQWJ6YlUrQmRuWHBhVHNQcnhFQnVDcWtGTTJZdzFVQ0NCWHNx?=
 =?utf-8?B?Y294TXN4c0JoVkRCbU9GdzBUNmh0SGpoVjZONnZ4Z2NJbGM2N0FKVXlMSlRH?=
 =?utf-8?B?V0RxcFNpNXVERG55Z2I1TUx3K21sQjRlbG40WmIrYjZHYkI4aWFoWEhBRTkz?=
 =?utf-8?B?OWlqR0poNWQydHpibjIvdzJMMWVrL3ZvcDBLMk8rQ0dvL0ptVGI2bTJvTmt1?=
 =?utf-8?B?VjFBeHcrTnIxNXBueFlDN25vUm9wUU9lMEV5eEttVlpOcVFTMXU2ZFkwVm9p?=
 =?utf-8?B?Q0ZpS1RkUXVDclBBR2pKcUVBZHFCS0NzV2ZJVU1Fb0FpNkUzcGI1NXJqZ2xK?=
 =?utf-8?B?bUIrczVMMnYyKzdHUS9XdTNJWXFnSnI0QTg3ZFJrd0c2OGNaZXhNM1dJbkVC?=
 =?utf-8?B?cDZGRk02bWI4OVdJNFowQnJRR0NTV3dhSGx4cVpkeDMxa1U5UERyTGdTZldK?=
 =?utf-8?Q?/jqguqmTvoViwUAaPfjc4kHie?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF61C9F3C040D84D95B4C69901070E6C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mWcWoKn0MUWPleeMmzOZnFRrg3jAxuJt5TGg4bYp4n0SyqYnw7QAi3yDtFq7cLQi+wnvazKRjS0V4/cjs2+J/sLA4YJMzpJgeEdEYNckZg01Q4y2DzYlD/ZgxVIqfuk2iWiVCZKCrDBgx3x4SJcXEoMI8LDkFdMePV4hFOjtjVTcTrWgklCu0PpFEZNkcOIqHCXp5Kjm2XfUVaLAYakVQf1vV/bSC+jzWAdFvRvoNiEJ4LOs8wnEkfqZaIvF5hR48Yusrx6cWqdgHy/+iUsg8GuIO9nQ7DGxZ3SfdnGRz0jQAWFEG4ZqFl6GTfXeXDpSQAOt2s6fEDmRMshDdZL8djDyHGNJBzg7PfxSm6MOsCWdcOP9JfPX4wqMoNFxJMXuMqGzO4Yi+EPrJ88H9JVUeNGHJYE90CPsSOR3AjVWMyPM9e6HI72AhXU5T1X3s4vtLQRcLXZsfGa3nHCs27ef1UYpVNcH5XvrlPt99X+EX6Zu2PNyv6/80mKjH4dCcyu7lk2uhbDqalHsHp3Rg2o6cbb7Ueh+bxAys11ZHgg0sM2Qxlj+W2/3vMiVVqLfQM+hwQ2aRwo6Cr62KvajSMQd9VSPg9HUaeP/5JwtlFnXpSGdwqh3YSXMTq2n6NuZroYBllBwzokVW7LevjHh6Nd9PbfITyauutwbaxTftnsF0qUdMhGfOgS5uqODc0ew4Fhai/Guexrjx/d4BqobVkfK2B3LimCSd9vQARi3W8Cv34KIoQ2uI4aYRVFUJIE//KBXteY34SiitItTCSsGwellLkj7ca+O57UFyY08DsQykhT4+UvEByMnjmG51TRd4l3j3QKmlgi2mGy99xaESAOrfhbaZfK7ys7dstWj9OeqEdPbg8rhD6fwjEKL45L/3gW5
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27846159-ebb0-4f56-674e-08db63958ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 18:16:56.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYK68/mcLry9JDQHadsXF+BlWunQR0kUYslJBoHh+0jgwpZcs0gpNyukBhIeMZvSf538pXgSa4HdLM2KyXz0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
X-Proofpoint-GUID: v_-roFb44SEpv5CQM5rytPSbyrfECHwN
X-Proofpoint-ORIG-GUID: v_-roFb44SEpv5CQM5rytPSbyrfECHwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_14,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=720 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdW4gMDEsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA1
LzMwLzIwMjMgMzo1MSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+
IE9uIEZyaSwgTWF5IDI2LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gRm9y
IGJ1cyBzdXNwZW5kIHNjZW5hcmlvIHdlIHNob3VsZCBza2lwIGNvbnRyb2xsZXIgaGFsdA0KPiA+
ID4gYXMgd2Ugc3RpbGwgaGF2ZSB0aGUgdXNiIGNhYmxlIGNvbm5lY3RlZC4gU28gbW9kaWZ5IHRo
ZQ0KPiA+IA0KPiA+IEhvdyBjYW4geW91IGtub3cgd2hlbiB0aGUgaG9zdCByZXF1ZXN0cyBmb3Ig
cmVzdW1lIHRvIHdha2V1cCB0aGUgZGV2aWNlPw0KPiA+IFdlIGhhdmVuJ3QgaW1wbGVtZW50ZWQg
aGliZXJuYXRpb24gdG8gaGFuZGxlIHRoYXQuIElmIGl0J3MgY29tbXVuaWNhdGVkDQo+ID4gdGhy
b3VnaCB0aGUgZ2x1ZSBsYXllciBzcGVjaWZpYyB2aWEgdGhlIHBoeSdzIGV2ZW50LCB0aGVuIGhv
dyBkbyB5b3UNCj4gPiBwbGFuIHRvIG1ha2UgaXQgZ2VuZXJpYyBhbmQgbm90IHNwZWNpZmljIHRv
IHlvdXIgcGxhdGZvcm0/DQo+ID4gDQo+IA0KPiBUaGUgd2FrZXVwL3Jlc3VtZSBwYXRoIGlzIHBs
YXRmb3JtIGRlcGVuZGVudCBhbmQgaXMgaGFuZGxlZCBieSBwaHkgc2lkZWJhbmQNCj4gc2lnbmFs
bGluZyB0aHJvdWdoIGFuIGV4dGVybmFsIGludGVycnVwdC4gVGhpcyBwYXRjaCBoYW5kbGVzIHRo
ZSBkd2MzIFJUDQo+IHJlc3VtZSBvbmNlIHRoZSBnbHVlIGRyaXZlciByZXN1bWUgaXMgdHJpZ2dl
cmVkIGZvciBidXMgcmVzdW1lIHNjZW5hcmlvLg0KPiBBY2NvcmRpbmcgdG8gdGhlIGR3YzMgZGF0
YSBib29rIChTZWN0aW9uNy4yKSBoaWJlcm5hdGlvbiBpcyBhbiBvcHRpb25hbA0KPiBmZWF0dXJl
LiBTbyB3ZSBtYXkgbm90IGJlIGFibGUgdG8gbWFrZSBpdCBnZW5lcmljPw0KDQpJdCB3b3VsZCBv
bmx5IGRvIHNvIGlmIGhpYmVybmF0aW9uIGlzIGVuYWJsZWQuIFRoZSBkcml2ZXIgY2FuIGRldGVj
dCBpZg0KdGhlIGNvbnRyb2xsZXIgaXMgY2FwYWJsZSBvZiBoaWJlcm5hdGlvbiBhbmQgaWYgaXQg
aXMgZW5hYmxlZC4NCg0KPiBBZGRpbmcgYSBkdCBub2RlIChzYXkgc25wcyxleHRlcm5hbC13YWtl
dXApIHRvIGRpc3Rpbmd1aXNoIHRoZSB3YWtldXAgcGF0aA0KPiBhbmQgaGF2aW5nIGEgY2hlY2sg
YWdhaW5zdCB0aGF0IGZsYWcgaW4gdGhlIGR3YzMgUlQgcG0gb3BzIHRvIGhhbmRsZSBidXMNCj4g
c3VzcGVuZC9yZXN1bWUsIHdvdWxkIHRoYXQgYmUgYW4gYWNjZXB0YWJsZSBzb2x1dGlvbiA/DQo+
IA0KPiANCj4gPiBUaGUgcmVhc29uIHdlIGhhbHQgdGhlIGNvbnRyb2xsZXIgYW5kIGZvcmNlIGEg
c29mdC1kaXNjb25uZWN0IGlzIGJlY2F1c2UNCj4gPiB3ZSBkb24ndCBoYXZlIGEgaGFuZGxlIGZv
ciB0aGlzIHlldC4gUGVyaGFwcyBJJ20gbWlzc2luZyBzb21ldGhpbmcgaGVyZQ0KPiA+IGJlY2F1
c2UgSSBkb24ndCBzZWUgeW91IGhhbmRsZSBpdCBoZXJlIGVpdGhlci4NCj4gPiANCj4gPiA+IHJ1
bnRpbWUgcG0gb3BzIHRvIGhhbmRsZSBidXMgc3VzcGVuZCBzY2VuYXJpby4gQWxzbyBpbnZva2UN
Cj4gPiA+IGF1dG9zdXNwZW5kIHdoZW4gZGV2aWNlIHJlY2VpdmVzIFUzIG5vdGlmaWNhdGlvbiBz
byB0aGF0DQo+ID4gPiBjb250cm9sbGVyIGNhbiBlbnRlciBydW50aW1lIHN1c3BlbmRlZCBzdGF0
ZS4gRW5zdXJlIHRoYXQNCj4gPiA+IHRoZSBjb250cm9sbGVyIGlzIGJyb3VnaHQgb3V0IG9mIHJ1
bnRpbWUgc3VzcGVuZCBiZWZvcmUNCj4gPiA+IHRyaWdnZXJpbmcgcmVtb3RlIHdha2V1cC4NCj4g
PiA+IA0KDQoNCklmIHRoZSBjaGFuZ2UgaXMgb25seSBzcGVjaWZpYyB0byB5b3VyIHBsYXRmb3Jt
LCBtYWtlIHN1cmUgdG8gdGFyZ2V0DQpvbmx5IHlvdXIgcGxhdGZvcm0uIFBlcmhhcHMgdGhhdCBj
YW4gYmUgZG9uZSB0aHJvdWdoIGEgZHQgcHJvcGVydHkuDQoNCkFsc28sIGRvY3VtZW50IGhvdyB5
b3VyIHBsYXRmb3JtIHdvcmtzIHRvIGNhcHR1cmUgdGhlIGhvc3QgcmVzdW1lIGV2ZW50Lg0KVGhl
cmUgYXJlIHVzYjIgYW5kIHVzYjMgcGh5cy4gV2hhdCBjYW4geW91ciBwbGF0Zm9ybSBjYXB0dXJl
IHRvIGRldGVjdA0KaG9zdCByZXN1bWUgZm9yIGVhY2ggcGh5Lg0KDQpGb3IgdXNiMyBwaHksIGNh
biB5b3VyIHBoeSBhc3NlcnQgaW50ZXJydXB0IG9uIExGUFMgc2lnbmFsIG9mIGhvc3QNCnJlc3Vt
ZT8NCg0KRm9yIGV4YW1wbGUsIFJvZ2VyJ3MgcGF0Y2ggcmVsYXRlZCB0byBUSSBwbGF0Zm9ybSBj
YW4gY2FwdHVyZSBVVE1JDQpsaW5lc3RhdGUgWypdLg0KDQpCUiwNClRoaW5oDQoNClsqXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvZmRmZTcwN2UtNzY4OS0zNzNhLTNhYTQtZTgx
Y2ZlYWMxNTYyQGtlcm5lbC5vcmcv

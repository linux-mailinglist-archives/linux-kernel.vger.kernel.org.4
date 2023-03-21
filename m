Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8276C3958
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCUSoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCUSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:44:16 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC3532B0;
        Tue, 21 Mar 2023 11:44:14 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LDP8MS013369;
        Tue, 21 Mar 2023 11:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=GbRfC4/ihq2DN+/2KhYQlIKYy//nB5cUJble8h9kIUw=;
 b=E4/iMChztYNUbCkxdHhjS+DlARbJ0ZpuX356YLcO+jpqt1gSAU9b61/9Q3fFauRbKnOu
 DB2eNkbVGwPMSy3oCroK0dsxpCk9w8i1puqqXypPaSX4gGqrJ/r8v/8NuKWO93L6cZdO
 SsWs1QrHUghYVAcDcfo8lUnjsCqtlU7aFL9om0jJ5FNor78o2c3spmFmmbM7qnQ1Tiry
 1CVaKuXhlBb0XQzdzgYGsnynbwcNWZJkT0jmSWN+LS3dE06BxVK40s24oq9bfPahZxAs
 nluqvXzKRojRYwCdUQJqCtvT1aPH/uvVe5YW0eO3GMJNYmUGf+DoWxj7FerY1seq8VEf Vw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pdcap6w05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 11:44:05 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B02BA4007B;
        Tue, 21 Mar 2023 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679424244; bh=GbRfC4/ihq2DN+/2KhYQlIKYy//nB5cUJble8h9kIUw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=K/5D70oWsyPkYWJpQMzFL62LA9ZXc/onjXaGG1iihr3HzQ/npfy4DigpGccmCs/SF
         fc57u9avQrjhEeYwLFT13++G2jkVa6NVVqJ2yOZ7BjpBGUTPcM1aGH2P+sbywcZ8wD
         lv3tRo4Mw8vKgAPWXF3UVtVDtyccLAV42MO5UWEo3GDj4s0YiN9ndflNBnNXUHnY8N
         D0s3ww+Z5p1tpykuQCbo6tElxFzgbc8mfYXXhd60s2atB6nAo1RAVPcVwYyK5EWLKn
         3e+f86LVTQiKtXmW3trCncuKlt0WtFCuno7AXPZBkEvFAFZOv4nSs3I+Ag3PrKcIoU
         xPgl6OGFF/kdA==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 37391A005C;
        Tue, 21 Mar 2023 18:43:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 853ED40066;
        Tue, 21 Mar 2023 18:43:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="kEjMp+yy";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJQZOqV8+1tom0hgjZL1OpxY0NcRoY2Tk430A1Th8GzfaRmmK0tzdRWAtILB8DqyBvf0NzWdQzKdxDiIlguzXHjdKl9O7ncnqzlfDeMmhWO0ye1uZh81qaZ6BdNaZTAiVHiF4idZtVIk1m56TF+mmX4Tm4rOccsA2EmcjsGti51eu3ZB6Ed7wm5IpTtcL2r2RkIClpH9PgT22prhuxSR7QSwH2UrnNubGEyDyWkuk8bzqmTEp68o0dNW3100qGBbmTsV3yKvRO2xXuYWxjEkn6s/iSH26ejS5n3fdKpqXpXxpyXK0ixppvmYA1BKtxML21IFOaUAMF3mGFARPHuktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbRfC4/ihq2DN+/2KhYQlIKYy//nB5cUJble8h9kIUw=;
 b=nZVEvTpqsyOtHIFbazGlQHOc7jYt2GARCwCA4KXH3u7k1hY0ALr2guIMPNF00guxoPDjrQQuPwr/YHga6e83a/nILIiMNADbgYy7ZEWXNU5zGdQyg7pTervFF4o4rtFvsGUvgxeNPkOtX3TsA+bScOkaH1rs0VWdKKOKIrtCMAWD2QQQzp/U9Rved37bOGMKuZwJGfYBd1araajmO9F2vnDfu+NX/K49YQnehID+NgyMA7ve3WieMgq8wfV4Roj/8AxSIUNyqwQzIGC8Ea2ehgN9FqJXjRpEi81VOn1uyml0WwlQiThhw3uEpviVlY6s70Y5RYjou9WKs7w3EpEf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbRfC4/ihq2DN+/2KhYQlIKYy//nB5cUJble8h9kIUw=;
 b=kEjMp+yylfIKLAypFt6R0DTuI6ASOLNQYPN8Oog9k8q/kQLYjnAuOBZqJuO3LmYCJbZ9LZoRqwZc0gATxkk+Op+ZrHm+p1btdqSjjv2WYdv7XcdYVMOn38e9W3K9f77rLIT1lxiGj9Dh7qtnNJ/pFFGB0I2//okYTgDPtB9Jorc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 18:43:52 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 18:43:52 +0000
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
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AA==
Date:   Tue, 21 Mar 2023 18:43:51 +0000
Message-ID: <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-3-rogerq@kernel.org>
 <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
 <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
In-Reply-To: <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB5151:EE_
x-ms-office365-filtering-correlation-id: fb3e2bd2-d572-422b-4adb-08db2a3c3764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EOzFUKgFsQIgo+z8GP6++B9LtSXdVSaEtkeKV4bdv5DLeol6V4R/CrnWFOnDa32Z/J/XMzbKO8pWEkvQhPhR7E3XC5St8lyNZyFRI3gA04joCYR7OVe5cYQEK4D34CktUvZ2mMSD7GtwCXD4D5H5yEQdotVJoXuce93hSZfQuTrLYwLCyP+IsxP1AJHNiCRd81UgwuxE+P+M7HUQw1CCrLXIoWDK6gwUNG3VfL699UIItCymR0/VwUAPKhV0VHCUGuAzrP/jLzB0TN39EfFydAPtzpm8r6VxnJyUjXqy7f+65CHjKeWli9VC/Xb8xeQ7RfUt94yukzCKNNWGNGbIh7YQ1n2xsglD4hlZOrFb9phkhTJWR7uFRKut4CTAyAKJtd77YaRY8wGyBTx0+lOOMImdR4BovEr50cxxBOQI9SxWi6otBBpKsTixSg+JrvtvUQHU6gCV84s90kQ/d9H5CyAUAn+H5NfKgfecrE6MnAUmxZekfq2b3YDBG3Z4WT52JR86hp82lA+Pn7qg2aZyWr1rZwCKsXQlD479NPu6eqSdO3uIV64fN8jV+RSwVlnXuYxcp1dpaJT5Pp8+OwYisEN4nINyGr96h4764bvbUCzt9cRh1xbUxKK+Nvrqbv+c9cNpWb6U/M6aWKLDNBrALsv10ZGRHayOWGEJhJ7gb6FgAn1vnZzBUO68rxKBhscIw4L2WzRd9Ol9uAmyV5CIpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(83380400001)(2616005)(38100700002)(122000001)(38070700005)(86362001)(66476007)(6486002)(54906003)(66946007)(76116006)(66556008)(36756003)(8936002)(64756008)(41300700001)(8676002)(66446008)(6916009)(5660300002)(2906002)(186003)(71200400001)(26005)(4326008)(316002)(478600001)(6512007)(53546011)(1076003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c09wT0RNYzdkZU9LbVM1VVBvcmM3Mk1NMkRjWUk5cFNFT28zallkZFUyVVNP?=
 =?utf-8?B?dTlQTlErTk9HRWlPNGpUTWZJV2hlQWI5d2NZc3I1bGN4c0dRa1E0R1dzMUVI?=
 =?utf-8?B?clNOWmxKZ3pTek1vcjVhdVh6Y3g4YzgvOUxzNnVValdoZmEwd3B4RXNaanc2?=
 =?utf-8?B?TUJ6R3ZuTDNMTXpjZnR6ellJQkFnTzkyVklndFdIaW9DaFFZcHgyOVllektw?=
 =?utf-8?B?c0NQUzFxL1dWYlQ4cmlOZ1dQTzZLa3VRWXBuK1BUWDJTRWwxcVpMSUkyNVhN?=
 =?utf-8?B?bzhLUVNZeVpEK0RQWjl3RVRoMlYwSGNxLzhUTy9IV056bUMrNnBpUEczaTRT?=
 =?utf-8?B?RnV0Y0h2NnlDc0RXMFZYUTlyQlR3aGdkT2VxS1JUQ2dOSTNRUURoQjZSYzhQ?=
 =?utf-8?B?ZmpObTQxOVNEMW9GWjhBcUl4cTFyem5jZi9Sa3hpeDA0SkVoTitKcnpIdnFE?=
 =?utf-8?B?TXJiYVhpK2Rsa1FZSTk2V2t2U1NLOVNYdmNRVyt0TWJuZE1zYng5Q096Sjlw?=
 =?utf-8?B?aTA3Qm5LbEQ5N2pNR0l6V3BtaGc5NFRYWjZOVnIzOTI2Ylk0YWtTcm5HYkE4?=
 =?utf-8?B?OVFhOU5za2RjMGpzcEhXRCt6bFk1VkRpeDJ4TU9wYlZIT2phN1k0ekhzbjR6?=
 =?utf-8?B?cDhzeERlaXFjR05KTWx5cDZVUTh2VUM3ZmtoaG9XbUdQeWUxR0xuNHVUeXEw?=
 =?utf-8?B?VnpqcGFCMzdmcVZoU3FZaVp1QnhwMTJsb0dpR0ZNSlFmMGtWNGlhbjk5anUx?=
 =?utf-8?B?bE45V0NGUEZHbXVVeGtqcm9IVWtKSHorTnEvVDB1RW5XUE4zVllZS1ZXOXU1?=
 =?utf-8?B?eE9ZcGVxVWp0V0xNUlRKNXZweFUwelcwVmZjbU4xdHF6SWZKVnVwYUVYdXN1?=
 =?utf-8?B?VGo3R2kvOEpmWHlwcHpIM2UwWExJemQ2ZDF0dVVnN3VnZGZRNlBHSGFwMmwx?=
 =?utf-8?B?RHVmMVBWT3VLdDVHOTVlMGZ2Y0R2dWJIbTVjMXhVamFlSWgvME1Nai9pSURp?=
 =?utf-8?B?aGw1Mk9jSk5MMktYaE9uV2pUZjZpMXYwZ0FVVWdxYUl4eUl1bFFmOUVrcnhH?=
 =?utf-8?B?K2hHTmM1bnltSjdVdTh4QWQwU3AwbWkwOExLaGRpM2lnS3VQTFpsUG9oVjlv?=
 =?utf-8?B?T2Q5QVg4WFA1MmJvYThxNFk0UGhNZVhrTmVDdFJvZkR2aTVZbGV4RTZNOTFB?=
 =?utf-8?B?bkl5MG90UGpXeS9ubVBEM0hvejF2QTgrTFZhN2JGTUhQYWpkN2pUQko3aU1L?=
 =?utf-8?B?eGtmQUFkWS82Y0tLRDVkSy9xWm0rL0pFRVB5TVlsbEIwWHpSemQyRURKNkxr?=
 =?utf-8?B?dmJuUTdpUXRGN1AyV2lYYklIU0xZdDRIajh6b3dwOURMOXdZNWp5RkR2LzRP?=
 =?utf-8?B?eDhzNWJjY0Y3VlVncnIvdFowQ2lZSkxGOGoxaFpmSzBMMFdBSWx1ZytNRE54?=
 =?utf-8?B?RmU4a0Z3OU5ieEdoeGdnK3lWeU9lS3lQYndaVzNlaU0yckJZZWF5V3BLaHEr?=
 =?utf-8?B?d3dPbk1XRWZDckNYN0hRWlNXS2xWeW5HcGpYaGF1ZldiNkJ0MmQvdDBTY2Ny?=
 =?utf-8?B?RXJzTDdOa0drWFE2TkFlZzUyODlNUnJOZmQzS0hrMG5NR1J2RUxHR1BaamMy?=
 =?utf-8?B?UTZtcUdLYTVaYUpVSnp3dWd4MWxNbGRyajA4RGhWaW95RVZnNEJhQzcxZWNC?=
 =?utf-8?B?RlNZMTE5UTB1Nnl4blFaczhOMFdxcnBMbU45QkJTN1hVWk1tOHFyN2hJcDJB?=
 =?utf-8?B?WlJadm44M3hDWm1oUjZYMDRybi9sYUVhanc5bDArd0JqOUczclk5eXFYVTJS?=
 =?utf-8?B?YlJzWmlEVHlvUXIzYkIwb29ROW54NlFuR1daQnRoTkxPcWNGdWhsdklnVDdF?=
 =?utf-8?B?SUxidzc0OFhsbGZ4ckp4dEVuaUk2dEsrLzdzbVVWUmxNclJkdDZXcDNqdnE0?=
 =?utf-8?B?OXR1VEpsbnI5YUNOL2R2eEpMZ05SWkRWRlZDaDZxQkZYK0E4OEE5REdlb1lO?=
 =?utf-8?B?M09mNUdJTzJONk1hdHcrcHREamF2SjQ2MEFrTXV4Z2wyT1dzT2NuYVhkNGVK?=
 =?utf-8?B?RTE5c3haTWsvUkphcnBVVnEwQ05zOVZKTmkzUHI0UEhub01aTzVtRGVhTUYr?=
 =?utf-8?Q?jnO/gsflwqaUfWRynNSM02zTe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2859133059F9145AB475A326B60763B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDRZYklyblBMbmNtU0VpYUdPdW0xc0dWWnowNnBzTkdKeTY3QWJ3TEM2WlEy?=
 =?utf-8?B?bTBYWGF4cng0aTIreDNiOTA1cXcxVyswZ05aNzZKN3V2dFJqSk43TXhTb3dy?=
 =?utf-8?B?VWJpbjQ0MW5yWGlLY3Eya1VHaEhEYWJBMnpLNTlKSnF1UDd2SEV0RklkdURr?=
 =?utf-8?B?UWQ0QnhPOVFINzdaeUppcUlQcTJiV0crWW5YaEk0dENMcXRtSlNzM1k3STBB?=
 =?utf-8?B?UnJTbkRvMmd1NWs4MnBlcWU3T2JER0tpSHNBNHV1OGFLYkU2V1EyQndidmhQ?=
 =?utf-8?B?SE8wRGtDYjNkU3JiOVF0Tzh1YllWbjJZdThrb0Era1BEL2dONmdRSjEyaHlj?=
 =?utf-8?B?ZE1rU0pRTTlZMFNPQmZqelUyQXV6T2FqYVphRnJxOVdLekFNN3FjeWlqdmMr?=
 =?utf-8?B?a2JsamRkWFhKTTdRL1VrVGNpWUkvRkFSUlVBRi9vUk9HenV3UkJvK3FnUVNy?=
 =?utf-8?B?U2N5b1N2Rkc1czhvRy9PdUN0UHFVc3F4Z0QwU2FRMzBkWDZvTWFMbi9PQ2FV?=
 =?utf-8?B?a080VDJ5VExhQmdNZkNuZ1MrbGVkU0VETEtZZ1FZVjFpMmg4RUxSbzJwSGlq?=
 =?utf-8?B?Yk5DRG8rWmtHb2U4STdPbll4MFFWU3VpaUxWSy9laWovK0VRd3d2SjZyaTlS?=
 =?utf-8?B?VHBCSGx1a0pKa01JK1ZPYk5SeTRrSytQNGVyYjhiOC93YkVtZFFkRlRTemZx?=
 =?utf-8?B?ZnNQUklZMWtXeG9EYTY5dEExU01hZFhkdEdmbWdFSkFBaWMrbkNTQ25KVTNR?=
 =?utf-8?B?d002c09pdi93VDhGSFFSbXlNUU1nQ2w2a0c1bkZQbHVxVmxsYldXWkx4ZndB?=
 =?utf-8?B?ZkcvZHBaWXU2YURCMWxQSm5kWGZ5VFlJOUFlRzBDd0dzeUtUVUVSaXFTdmQ3?=
 =?utf-8?B?Q3FVaEt6RmovRStZekQwL1BYZVZXM2pvQTZyT1JZdjVUM1E2TWRGZkxKbHdO?=
 =?utf-8?B?Um1qbmQvYVNETWdmOWRGd3dZaWxEQ2RmL0d5elFoSlV2UzBIcmQxV08xSEZu?=
 =?utf-8?B?TVdoQjMyVlQ5WDdhbVNsSUNNdVJDOE5Ic1RPNVcwN2hBNkEwUXQ5WFNwa2xI?=
 =?utf-8?B?enFNZXVWcUFBZ05WNkxLTjViSXZsZ3FXbkIyaitZUHVmc3VIYjV1VG9mMHBY?=
 =?utf-8?B?Y1gzcHRSRkVUQXR2Tm1vTjN3WDJ1RlZ5bkJwZWoyY1FqaWR5OU5lVVczbFlz?=
 =?utf-8?B?TFVDM09pRzBrM21FRlVMS3dpUjRzWnI5UWFzMDI1ZmtWYjgzUW0xY2hKMWRu?=
 =?utf-8?B?aWZ0ZFFBeDBzTUtJa2lSL096Q05UczlwNmw0djBpUEtkbkk5Zz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3e2bd2-d572-422b-4adb-08db2a3c3764
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 18:43:51.8468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqkx1hb4FE/+OsfF9Iy5Hiwt+BEPdeaTgW8E1MbxBMT+m7zLwH3njtGdPLcK3ehNR6Z7fl7Cs0weQQWVNaq7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
X-Proofpoint-GUID: 271OjcGexAimbOeqF3IDaOMXcOGm4u_t
X-Proofpoint-ORIG-GUID: 271OjcGexAimbOeqF3IDaOMXcOGm4u_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMjEsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEhpIFRoaW5oLA0K
PiANCj4gT24gMjAvMDMvMjAyMyAyMDo1MiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0K
PiA+IA0KPiA+IE9uIE1vbiwgTWFyIDIwLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+
PiBJbXBsZW1lbnQgJ3NucHMsZ2FkZ2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAnIHByb3BlcnR5
Lg0KPiA+Pg0KPiA+PiBEbyBub3Qgc3RvcCB0aGUgZ2FkZ2V0IGNvbnRyb2xsZXIgYW5kIGRpc2Nv
bm5lY3QgaWYgdGhpcw0KPiA+PiBwcm9wZXJ0eSBpcyBwcmVzZW50IGFuZCB3ZSBhcmUgY29ubmVj
dGVkIHRvIGEgVVNCIEhvc3QuDQo+ID4+DQo+ID4+IFByZXZlbnQgU3lzdGVtIHNsZWVwIGlmIEdh
ZGdldCBpcyBub3QgaW4gVVNCIHN1c3BlbmQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFJv
Z2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMv
dXNiL2R3YzMvY29yZS5jICAgfCAyNSArKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4+ICBk
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4+ICAzIGZpbGVzIGNo
YW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ID4+IGluZGV4IDQ3NmI2MzYxODUxMS4uYTQ3YmJhYTI3MzAyIDEwMDY0NA0KPiA+PiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYw0KPiA+PiBAQCAtMTU3NSw2ICsxNTc1LDkgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJv
cGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+PiAgCWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0g
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+ICAJCQkJInNucHMsZGlzLXNwbGl0
LXF1aXJrIik7DQo+ID4+ICANCj4gPj4gKwlkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3Ns
ZWVwID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+ICsJCQkJInNucHMsZ2Fk
Z2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAiKTsNCj4gPj4gKw0KPiA+PiAgCWR3Yy0+bHBtX255
ZXRfdGhyZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiA+PiAgCWR3Yy0+dHhfZGVfZW1w
aGFzaXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gPj4gIA0KPiA+PiBAQCAtMjAyNywxNCArMjAzMCwy
MCBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1f
bWVzc2FnZV90IG1zZykNCj4gPj4gIHsNCj4gPj4gIAl1bnNpZ25lZCBsb25nCWZsYWdzOw0KPiA+
PiAgCXUzMiByZWc7DQo+ID4+ICsJaW50IHJldDsNCj4gPj4gIA0KPiA+PiAgCXN3aXRjaCAoZHdj
LT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gPj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNF
Og0KPiA+PiAgCQlpZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKQ0KPiA+PiAgCQkJ
YnJlYWs7DQo+ID4+IC0JCWR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gPj4gKwkJcmV0ID0g
ZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiA+PiArCQlpZiAocmV0KSB7DQo+ID4+ICsJCQlk
ZXZfZXJyKGR3Yy0+ZGV2LCAiZ2FkZ2V0IG5vdCBzdXNwZW5kZWQ6ICVkXG4iLCByZXQpOw0KPiA+
PiArCQkJcmV0dXJuIHJldDsNCj4gPj4gKwkJfQ0KPiA+PiAgCQlzeW5jaHJvbml6ZV9pcnEoZHdj
LT5pcnFfZ2FkZ2V0KTsNCj4gPj4gLQkJZHdjM19jb3JlX2V4aXQoZHdjKTsNCj4gPj4gKwkJaWYo
IWR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXApDQo+ID4+ICsJCQlkd2MzX2NvcmVf
ZXhpdChkd2MpOw0KPiA+PiAgCQlicmVhazsNCj4gPj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBf
SE9TVDoNCj4gPj4gIAkJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSAmJiAhZGV2aWNlX21heV93YWtl
dXAoZHdjLT5kZXYpKSB7DQo+ID4+IEBAIC0yMDg4LDExICsyMDk3LDE1IEBAIHN0YXRpYyBpbnQg
ZHdjM19yZXN1bWVfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+
ID4+ICANCj4gPj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4+ICAJY2Fz
ZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4gPj4gLQkJcmV0ID0gZHdjM19jb3JlX2luaXRf
Zm9yX3Jlc3VtZShkd2MpOw0KPiA+PiAtCQlpZiAocmV0KQ0KPiA+PiAtCQkJcmV0dXJuIHJldDsN
Cj4gPj4gKwkJaWYgKCFkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwKQ0KPiA+PiAr
CQl7DQo+ID4+ICsJCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3Yyk7DQo+ID4+
ICsJCQlpZiAocmV0KQ0KPiA+PiArCQkJCXJldHVybiByZXQ7DQo+ID4+ICsNCj4gPj4gKwkJCWR3
YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gPj4gKwkJfQ0K
PiA+PiAgDQo+ID4+IC0JCWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVW
SUNFKTsNCj4gPj4gIAkJZHdjM19nYWRnZXRfcmVzdW1lKGR3Yyk7DQo+ID4+ICAJCWJyZWFrOw0K
PiA+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+PiBpbmRl
eCA1ODJlYmQ5Y2Y5YzIuLmY4NGJhYzgxNWJlZCAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmgNCj4gPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPj4g
QEAgLTEzMjgsNiArMTMyOCw4IEBAIHN0cnVjdCBkd2MzIHsNCj4gPj4gIAl1bnNpZ25lZAkJZGlz
X3NwbGl0X3F1aXJrOjE7DQo+ID4+ICAJdW5zaWduZWQJCWFzeW5jX2NhbGxiYWNrczoxOw0KPiA+
PiAgDQo+ID4+ICsJdW5zaWduZWQJCWdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwOjE7DQo+
ID4+ICsNCj4gPj4gIAl1MTYJCQlpbW9kX2ludGVydmFsOw0KPiA+PiAgDQo+ID4+ICAJaW50CQkJ
bWF4X2NmZ19lcHM7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+PiBpbmRleCAzYzYzZmE5N2E2ODAuLjgw
NjJlNDRmNjNmNiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
PiA+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+IEBAIC00NTcyLDEyICs0
NTcyLDIzIEBAIHZvaWQgZHdjM19nYWRnZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+PiAg
aW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gPj4gIHsNCj4gPj4g
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+PiArCWludCBsaW5rX3N0YXRlOw0KPiA+PiAgDQo+
ID4+ICAJaWYgKCFkd2MtPmdhZGdldF9kcml2ZXIpDQo+ID4+ICAJCXJldHVybiAwOw0KPiA+PiAg
DQo+ID4+IC0JZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiA+PiAr
CWlmIChkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwICYmIGR3Yy0+Y29ubmVjdGVk
KSB7DQo+ID4+ICsJCWxpbmtfc3RhdGUgPSBkd2MzX2dhZGdldF9nZXRfbGlua19zdGF0ZShkd2Mp
Ow0KPiA+PiArCQkvKiBQcmV2ZW50IFBNIFNsZWVwIGlmIG5vdCBpbiBVMy9MMiAqLw0KPiA+PiAr
CQlpZiAobGlua19zdGF0ZSAhPSBEV0MzX0xJTktfU1RBVEVfVTMpDQo+ID4+ICsJCQlyZXR1cm4g
LUVCVVNZOw0KPiA+PiArDQo+ID4+ICsJCS8qIGRvbid0IHN0b3AvZGlzY29ubmVjdCAqLw0KPiA+
PiArCQlkd2MzX2dhZGdldF9kaXNhYmxlX2lycShkd2MpOw0KPiA+IA0KPiA+IFdlIHNob3VsZG4n
dCBkaXNhYmxlIGV2ZW50IGludGVycnVwdCBoZXJlLiBXaGF0IHdpbGwgaGFwcGVuIGlmIHRoZQ0K
PiANCj4gRHVlIHRvIHNvbWUgcmVhc29uLCBpZiBJIGRvbid0IGRpc2FibGUgdGhlIGV2ZW50IGlu
dGVycnVwdHMgaGVyZSB0aGVuDQo+IGFmdGVyIFVTQiByZXN1bWUgdGhlIFVTQiBjb250cm9sbGVy
IGlzIG1hbGZ1bmN0aW9uaW5nLg0KPiBJdCBubyBsb25nZXIgcmVzcG9uZHMgdG8gYW55IHJlcXVl
c3RzIGZyb20gSG9zdC4NCg0KWW91IHNob3VsZCBsb29rIGludG8gdGhpcy4gVGhlc2UgZXZlbnRz
IGFyZSBpbXBvcnRhbnQgYXMgdGhleSBjYW4gdGVsbA0Kd2hldGhlciB0aGUgaG9zdCBpbml0aWF0
ZXMgcmVzdW1lLg0KDQo+IA0KPiA+IGRldmljZSBpcyBkaXNjb25uZWN0ZWQgYW5kIHJlY29ubmVj
dCB0byB0aGUgaG9zdCB3aGlsZSB0aGUgZGV2aWNlIGlzDQo+ID4gc3RpbGwgaW4gc3lzdGVtIHN1
c3BlbmQ/IFRoZSBob3N0IHdvdWxkIG5vdCBiZSBhYmxlIHRvIGNvbW11bmljYXRlIHdpdGgNCj4g
PiB0aGUgZGV2aWNlIHRoZW4uDQo+IA0KPiBJbiB0aGUgVEkgcGxhdGZvcm0sIFRoZSBzeXN0ZW0g
aXMgd29rZW4gdXAgb24gYW55IFZCVVMvbGluZXN0YXRlIGNoYW5nZQ0KPiBhbmQgaW4gZHdjM19n
YWRnZXRfcmVzdW1lIHdlIGVuYWJsZSB0aGUgZXZlbnRzIGFnYWluIGFuZCBjaGVjayBmb3IgcGVu
ZGluZw0KPiBldmVudHMuIElzIGl0IHBvaW50bGVzcyB0byBjaGVjayBmb3IgcGVuZGluZyBldmVu
dHMgdGhlcmU/DQo+IA0KDQpJdCBzZWVtcyBmcmFnaWxlIGZvciB0aGUgaW1wbGVtZW50YXRpb24g
dG8gYmUgZGVwZW5kZW50IG9uIHBsYXRmb3JtDQpzcGVjaWZpYyBmZWF0dXJlIHJpZ2h0Pw0KDQpB
bHNvLCB3aGF0IHdpbGwgaGFwcGVuIGluIGEgdHlwaWNhbCBjYXNlIHdoZW4gdGhlIGhvc3QgcHV0
cyB0aGUgZGV2aWNlDQppbiBzdXNwZW5kIGFuZCBpbml0aWF0ZXMgcmVzdW1lIHdoaWxlIHRoZSBk
ZXZpY2UgaXMgaW4gc3lzdGVtIHN1c3BlbmQNCihhbmQgc3RheSBpbiBzdXNwZW5kIG92ZXIgYSBw
ZXJpb2Qgb2YgdGltZSk/IFRoZXJlIGlzIG5vIFZCVVMgY2hhbmdlLg0KVGhlcmUgd2lsbCBiZSBw
cm9ibGVtIGlmIGhvc3QgZGV0ZWN0cyBubyByZXNwb25zZSBmcm9tIGRldmljZSBpbiB0aW1lLg0K
DQpEb24ndCB3ZSBuZWVkIHRoZXNlIGV2ZW50cyB0byB3YWtldXAgdGhlIGRldmljZT8NCg0KQlIs
DQpUaGluaA==

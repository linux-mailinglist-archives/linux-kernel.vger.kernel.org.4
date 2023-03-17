Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D916BF378
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCQVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQVFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:05:14 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F42E0C4;
        Fri, 17 Mar 2023 14:05:13 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HFv0sk004976;
        Fri, 17 Mar 2023 14:04:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=OJq8SlADSb1gKJFDeoTRG4qcKn7MlYq8x6N+MKt0yRQ=;
 b=A0iFHRLa23JFNHtWEyEy5McSTeCCmIGQ16wMVdCqAbkprUJ7FCGZD8mQZk+9DgpbVE8v
 Bv3HTR/UuapGI/LuAgZ+ZD5oxr5qD/TY76q7siRsw+kQYkRbMHjO3EeV3xT+Fbs8AQEN
 dzHzUi2QJGc8+xZ8GU3Oj+HZYDHZftfXs2Bl0KKu+I8i+SYVKbWBvGapo7zQ3VMyFGR0
 EytruMnarXUgEDGT+4lTJN0I0JdV3ybqvwXCrg6x0TlXWnQdDP4ttptQ1BwEdZuuJe+8
 INAGiYRoVNPbiJs9bswqNxna4RKacvdGNwsiRrDMCeyM2VLofgQr/dKWcfqyTEAYjnZg kg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pbpxskmgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:04:59 -0700
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 197DD4008A;
        Fri, 17 Mar 2023 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679087098; bh=OJq8SlADSb1gKJFDeoTRG4qcKn7MlYq8x6N+MKt0yRQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Gzu32H/qDSIi5ov3AXQ9SuKIvy33Oy3ZiJ8Z5sseA8+lFhnpeii0LPvm0ujD8l/Tt
         Cl3LquSR5awCVfzudvep+9VMZj81S53WHZreQG7z9vWSVRC07PIf99S20JzerVRKzN
         OqZUYDzN131dpprUaEpLxSysLinUhSpwB23ApVtJh3bpbATXxblLZf+BJKLq8if+7c
         LhDBrwAbZpKKmGq8enhCkPo6oUqjRuzuXjZ0BEEbOtqK+W84LoLfXiVFB9k5yB/uU7
         6U6+T1S5uHPgde6iGHC0KUZhvxgdG9oJhgCeDtqeOqfxPjnzH8LXnVCbZinEOHNV3N
         ZKF4L0SALZskg==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 60C34A005C;
        Fri, 17 Mar 2023 21:04:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DF1CB801AC;
        Fri, 17 Mar 2023 21:04:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qP/gzt0S";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwPBxr/NE1ygt7rCr57QLbMc9kYi8pqyAV2wXCvvMZ19+FhaVHajIX3cQUiDVZoukCombWnq/vjQccDgttwzqGH5Zt7sCJNjr5vRw2CTB2ED/IA0p9DsY6aHc/d2x8rFVCxPcs6ZlpYKzEm+9rAakZKpJZrxDQvKzgH8d1YfUKHaBZK7N1fNQP6kkonMqm8pRCM0SiQX32k5VDCpSoK2CYzHCZyYUBn1mpK5YDydO6FCfB/hdxLaGq1IobsGesqI9mflo6rFGpyNlRCgHxizzuweVOzPcfA7uSc48OV0GvMOYZ56DSnAdXLqxJjvqsGgDUOH7YwscV998zYwylpF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJq8SlADSb1gKJFDeoTRG4qcKn7MlYq8x6N+MKt0yRQ=;
 b=DIx1ZFf3u3BZWDEyNrkuz8FeJsnWXG1FOSalfIhAPt3T7yh3hLXKLRxHa9yGvlEA6+fw8+YVJs1GObWLAcL5CbBuWKmktPD66WOZuCJ4oXwz6LHu1vq18QsW50tREVaaZAJ4J8VvOOcr0amWpjwrxKAp34JRgmToh5Xzdr+HOLEgJymTYEOgNLewOKLSVqy5r+s4Q5LhkPGRqGl8uQ3qhaqH+rsq4qs1rW9KC9VZzlfVVg1KBpdkcNgxt+K8mD45SwdiC/0fF0e7vwUpouAecEzsWHfhPWMit04+kZAlXlb6XiGC3j8MKYFxF+HLpicH8iTOpyPh5L1oN6xu6qzLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJq8SlADSb1gKJFDeoTRG4qcKn7MlYq8x6N+MKt0yRQ=;
 b=qP/gzt0S2nQL5v083sYfhHWX6yS+NbZHuzfYAt/WCebn973/IyiahKawcZCUR906ClTNRMDB0SeQsXpSmYvSGUlVlgV2OTNHihwKVGadHM8rRK+28cqbRP6TJ9mLc3rqpXTuGfKNj9EMlAVQ913RV+TQru+eZIOF5B1VaDY/CPU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 21:03:51 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 21:03:51 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: dwc3-am62: Add system wake-up support
Thread-Topic: [PATCH 0/3] usb: dwc3-am62: Add system wake-up support
Thread-Index: AQHZWAj8vVyKzGJ6TkCa9NEax9c0EK7/d9gA
Date:   Fri, 17 Mar 2023 21:03:51 +0000
Message-ID: <20230317210344.3cns4mlkhsiousqi@synopsys.com>
References: <20230316131226.89540-1-rogerq@kernel.org>
In-Reply-To: <20230316131226.89540-1-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CYYPR12MB8922:EE_
x-ms-office365-filtering-correlation-id: add2e0a2-23b7-400d-5dbd-08db272b1c37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/+YDPPqRYnuAtWj5VckKuu13axCLSlfGSFWo2I/6nwcrfJeWUFJBKoWK4hfYEpNeIgD+oOfaqVuAt1PRlyP0cwyXIpzvBtJXyagJ2ZuOocznIRl+3q6kTAFNZhQM9aNk2Pp2wbPo0zwDmfgxn0IVhMZ1d5aCAbULJLgIVJ1OBQ5RVCLesm2IzYO7svTbk8Kx3ACQ7dFCLU+ljcCA1GTX9u8ucrQO3gnN2oWGnxKKiNehARrWw+qknu1NC4mL0l5ACln7JnbDuFlpaQYiU7Y4RGt9PHa1SME22Z3ZQ70LrLcdbNkMVpSRycNrsj6/jPenqGqpbE8MSd/2ptAMVbyPEebC9A/pqbmdHkuwGYPpMO62c3FvE8HMAABKjtOD9xQ9vSFgj6G8t2gLzyN6WoJQ4sM6vNwzLLhM4nUe4jip+AzwYNmf1ghNWFQ3XAdf4Mha6MfcdtzdPuamvrSXplfKFr5lfX5qp0pMRsfYGz1q09p7V16SX9CRFF7yK4RAmmUpsie65opjVXt5tRfhX0DIZDt+H8GXgHa5ahvbtIgooy6hp3yIUn8PcJ8+BvuUoY4N6L1Zo4XKAY5I3omOMTkeqDBw2vZVJokio+GjWeDwDajMXkU+V2OcIFhUADBpoLUJqoCso7oHK1VJPWT9UG526QhGvDo3V7YDpkwICwuXio8HsDKQC8oKNL5DNnh7udtliSLyepyzdaLUlnHcIItDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(2616005)(26005)(6506007)(1076003)(6512007)(186003)(6486002)(316002)(71200400001)(54906003)(4326008)(66476007)(66946007)(6916009)(66556008)(76116006)(66446008)(64756008)(8676002)(478600001)(4744005)(122000001)(5660300002)(41300700001)(8936002)(2906002)(38070700005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjNrWWtlU3FwQzhIYzlzNkNZdFZ4a3lDdlNLR0VGTE9CUWdsdlpsQTIrUEY5?=
 =?utf-8?B?VTd2Z3U5aTFIVHl4QnI1ZHRoRlRzWjhPREtXTlFYSXhFdU1nSjF4bnFMK3VQ?=
 =?utf-8?B?bmZwUStFZmtUM0FqWXljeG9xVzlVVTkwZ3JZZ1NEOUJvb3lLeG9oRmVGL3No?=
 =?utf-8?B?Z1oxL1VjZnRKSXpiN1JTd0dudlpiRy9FL2YrVzliUWFvYW1NRXZ6ZUNEWk0w?=
 =?utf-8?B?K3NES1BuMUx1dlplcGUrNmxLSXZlMDh1QnNLYVNTMXlMWFlkTm50RkE0RGRn?=
 =?utf-8?B?dDVkWE12NElqYS9QUFBON1d6SDh0SG1xQmFCdlgzZFRoWjdtcXZHeDhabXpL?=
 =?utf-8?B?TzFVVkliWkJJek5sTnNjRnRiWDFLY1pUUCswVS9OaGt0OU1NQ0owdlk0ZTU5?=
 =?utf-8?B?KzM2ZXllN3NwT3h2QW5IV1RrMzJDenZhRVBGRHdOa09LQnJ6bTMyckhUeHpG?=
 =?utf-8?B?d1dYQVhlcE9pa3ZXS1JsMTk4dlJsaFU2WDNRRUJxa2txaVphZUp6T0kyVnYv?=
 =?utf-8?B?VHh0OFR4RDFQWGJmR0lYNTZwaWgxZHFMTDNWRlRvcHpiSHNrTlBqVWhXcTV6?=
 =?utf-8?B?TXhmV2lmZ2Vua2paMW96UnkzY3hFc214NTN1cExmVmdUcE05Yk1sM3VBdTBC?=
 =?utf-8?B?QmxwQUVXd0drdGdwbm94MHFnZjdya0xBaWlBd0ZRKzNma2w4dlVvQUNtL2hN?=
 =?utf-8?B?K2tIbUlnUU5hbFFHSlF1S3pnUWhQWjlmS0JHUTdKMlc3WG85WkNqL1VIb3Bx?=
 =?utf-8?B?ejQ2cktOS2lOc3pINGZpMjRGb0tTTGt4MG9PQmxXVjJQcFpxWmYvR3FKNG9q?=
 =?utf-8?B?VXBzamU5eGdPMG83QXlKbmVxTmsrZUNaUDNRRGZOY1VHMS9MdnNRTFVFdEFF?=
 =?utf-8?B?Q0NQWVh0WkZGNHZ6c1djTXdvcTZyNFpZTzFubUNsVEZQRTFuRGx2bklSSEsz?=
 =?utf-8?B?YmttV1hLTG5OdXpZdnBKK0p5TVlWKy9XdU5GdVpIZVBKencxWlNhWXFIWWpE?=
 =?utf-8?B?VmNyaGxVaDllYU9JWDhzQnZ4blpoaFdSVE5SZHhJNnhvTWVOYXhOcUtzM3hv?=
 =?utf-8?B?cVp2bVB3VlJRLzhuQmRvbDlVRUVERE5mS2VHUzVwM0dEMG1weDhIaHZyWTZ1?=
 =?utf-8?B?Wk44WXNGOVFGdHBSUVk1dGxIZk1FZDd4anorelN0QUpiUVRMOXBMWUMrMnVn?=
 =?utf-8?B?VDI4b3dpTlMvdW8zVDArVnNkRmsrYVdqbVE1ZlVhY1dmUFZocXZkSmlwOU1U?=
 =?utf-8?B?MFNZR3VNazJ2aVNublNOY1V1bVA0ZUc2ZzRuL1lUbTdCTXdLY2VRbjlnVVB1?=
 =?utf-8?B?Zlk1OTl4ZmY5UVcwcmlmL2NiNmNvdHB5TXpKa05YSWtGeWJkNmovbVg3ejBR?=
 =?utf-8?B?VHhRVEZGQ2pvWkcxSmFId2kxdEt4RUpWZ0tKY1lLVjF4ZXlrTm9mYi9kUDFV?=
 =?utf-8?B?R2NKRzZaMWhqSWVvVlNtSm1EMDF5Ym5BZWVMdm9vOHZIdGtHUG91Nk9jTHE4?=
 =?utf-8?B?WkV6MUxmVU5hRkk2MEcvMjd1dVFKdkVwVmtyS3htWWxkNlFPT1BsWmZtZHpE?=
 =?utf-8?B?MWVNRDJsQ0V3M1pFTzJqdExaeGE1UXZPTXZMSjVGeUp0OWZWQ3dPYjZDZVhP?=
 =?utf-8?B?TzlGZ1RUdEZRRkd1TUpDZ2lUSmRMUTZtZ2JyZSszQzFXakd2WVJVN3BycHBQ?=
 =?utf-8?B?VU95K3hXZjFuVUplemo0blhnRllhNHZ2ZlRZMEdNUkJJVUp0eUZIV1paMlAz?=
 =?utf-8?B?QWlzeWY4SUxlZS9xS0FodmJkdERRYjhPYnBqMGhoa2xNYk4zbW1Id1RWWDNw?=
 =?utf-8?B?NDlJcnVYSGx0aHROamhWbWhHUjZhYWJwNFJQZlBubVFVNlZ1WDlWdkpLb2tl?=
 =?utf-8?B?emY1dXk5UWlUbFVacUMxZnpDSlVqeXk0ejBYZGoxUVIxM2pxZmVSeXc0dFkz?=
 =?utf-8?B?bi9NMFZUQVBId1JoMGNCKzBGWklaWm5kcVNSNTRRMHZxUGtmOENjYTB0WEI2?=
 =?utf-8?B?cFRML1crMUlDWVBmYitWOXh6OHdrZmFVS1AvTHRxTnBZdCtQUUFaVlprcE1V?=
 =?utf-8?B?eUFJeFpUYS9YT0MrU3ZtenFVS3pkNVIrVTg5VWlmeUR3MWc5b3RNanpzc3VH?=
 =?utf-8?Q?pxJqMI8e3nVmhJanhN83zaUjr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5D0D52BA6060C49A008ACA4C84FF88E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UVo1RTA2cTd6NjVmYVpjcHQwK1gyaUQrc0hXSnh5VTQyajVQdlZBd2hHaG93?=
 =?utf-8?B?MlEzYnQ3Z2NCbU5XSHkxSXVhdTVtWDA0Q1BGbGxCMUtmSGZhcWlDdEhCS0hu?=
 =?utf-8?B?R01TTTJjQkhaOVRRaXhUcm5iWVBTMDYxcENRdEpMZkNmVm9FSGIzRENOUWp3?=
 =?utf-8?B?eW5Gb0ozSEZWYWlEVkJKZ0ZuYkEyK0Y3YUVXUW1TSTdUS1Nhc0haTXExMkdO?=
 =?utf-8?B?ZkVOb3ZlbXlYRU5HUlBpUnhrMnN4ZUtNaFovaDZKell4SzBPNEUwdFhHd0dp?=
 =?utf-8?B?cWNieUswWGxySDNZUHFsREhFSjhpZTZ5d1pJRHlJWnJnRUVnTmxmcmJ0VUph?=
 =?utf-8?B?YjBCZlR2Q0NIZ1J2NXBlS21wQVRCOTFXWVdCMTJTWHpkdDduSzU4a28vWWNk?=
 =?utf-8?B?SnVPODlncXVxamhKOW00dWF4WTVGRWhaMnc4VGQwQTBDL0k0aDJxcnl4Z1pS?=
 =?utf-8?B?dkw0ZkpQcWpZNGs5R1ZaZHNlNVdiYk50MU9QVU1TdGVKdTkwZ3N6cEp4WGV3?=
 =?utf-8?B?ejk4WitKWFVGWkRtNnVmVmdidzRGMHlZS0Q2by9UcklkWmEzeTM5VWo1MExt?=
 =?utf-8?B?R1NiajFHVERTYTJpQzhuYU9zMmFRWWFNajU3VDdnUXpBL2ErRWN0ZUVPaEZ5?=
 =?utf-8?B?eWk2Q2twYkp3cUNKSHFnd2NnK0xSK2pRYk9tQ25CNmJHSmkrazBUenNuaTMw?=
 =?utf-8?B?TStZUkVPQTdZYm5kOUNLYURBbjM3MFBZMVNuOVVVQ2tOaHg0emtkMGhmZElD?=
 =?utf-8?B?QWZidEQ4dHJkMlVXVFpiWW9jdDRUOEdOZlJ3UzR4b3RKUlg3S3l0R3JRYWpv?=
 =?utf-8?B?Tm1TdzBNMTgzZjRDZ3EyN01uU2NaUndhTU5VcTViSjR6VHEwcXl3TC9VOVVT?=
 =?utf-8?B?SGN2Z1JTYUJjUWZ3cDFwaFZqclcyNTV0Wk43ellxeVNFeU1jT2RvNnZhY3U5?=
 =?utf-8?B?bFNrK0RBQkdDM3pOUGQrbmZKUmVDcEF2YU4rRlpXWDc3K3RRVEUvTVhGeHZq?=
 =?utf-8?B?UjVrdVdzQzc0UnlaWVlBc1FXTG9YQjg4ZkRvaDRuSzcraGI3QkRLWGtqc3RE?=
 =?utf-8?B?U0YyZmlQL2srRUxraGZ1eVc2MXlRTWs5RTNYTmVRNVlyWHFnbzZUWU56U3dp?=
 =?utf-8?B?eTAzeG9xcGxmamRkeEwvRE4rRXkvd00vbnp4ZUJxSDJIWWZMK3grZU1GV3p1?=
 =?utf-8?B?Tm5YS2JURWV4aTlPdStYM2dKN3Q1UENtTWMwT1QwdndIUVdFYjdJb3JkVmpC?=
 =?utf-8?B?WERZZWxMdm9iTjVKRTB4cjJWNy84VUZNdC9WK3hWVnBWeldVZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add2e0a2-23b7-400d-5dbd-08db272b1c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 21:03:51.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYrHl2EiQpwB0Mmaa61U4fhCPNTBRXbkrD+ZUWgHPbafEb3n4/4JVJx7U6WQihoNCH1A2g0VfBvihAd1cQF7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
X-Proofpoint-ORIG-GUID: 7FK9lqX6Vq4_7QNCa8oLr-kLSqNIBLqR
X-Proofpoint-GUID: 7FK9lqX6Vq4_7QNCa8oLr-kLSqNIBLqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 bulkscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=855 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFRodSwgTWFyIDE2LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiBIaSwN
Cj4gDQo+IFRoaXMgc2VyaWVzIGVuYWJsZXMgU3lzdGVtIHdha2UgdXAgc3VwcG9ydCB2aWEgVVNC
IGV2ZW50cyBvbiBUSSdzIEFNNjIgU29DLg0KPiANCj4gY2hlZXJzLA0KPiAtcm9nZXINCj4gDQo+
IEFzd2F0aCBHb3ZpbmRyYWp1ICgxKToNCj4gICB1c2I6IGR3YzMtYW02MjogQWRkIHN1cHBvcnQg
Zm9yIHN5c3RlbSB3YWtldXAgYmFzZWQgb24gVVNCIGV2ZW50cw0KPiANCj4gUm9nZXIgUXVhZHJv
cyAoMik6DQo+ICAgdXNiOiBkd2MzLWFtNjI6IEVuYWJsZSBhcyBhIHdha2V1cCBzb3VyY2UgYnkg
ZGVmYXVsdA0KPiAgIHVzYjogZHdjMy1hbTYyOiBGaXggdXAgd2FrZS11cCBjb25maWd1cmF0aW9u
IGFuZCBzcHVyaW91cyB3YWtlIHVwDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIu
YyB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4gDQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCkkgY2Fu
J3QgcmV2aWV3IHRoZSBkZXRhaWwgY29uZmlnLCBidXQgdGhlIGxvZ2ljIGxvb2tzIGZpbmUgdG8g
bWUuDQpGb3IgdGhpcyBlbnRpcmUgc2VyaWVzOg0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E856F8DAA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjEFBjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjEFBjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:39:07 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF349C0;
        Fri,  5 May 2023 18:39:06 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3460d1ro029779;
        Fri, 5 May 2023 18:39:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=c83virXNmsJ+7Z23ZXvTdh3ZbXAXwDES2346WTFqIJo=;
 b=O75XGISKvQApkc3Svbb+vV/su5Sz4KxrL65fwRWv2ixG5lx5wTcFcRAGMdA0h+/vdVLh
 S3w/Jlh2LWz5CdG/Dzit5dBgQBcc7PxJYebSqhllHLUx3bGgdn2C58MRqfOAw9fjuNtD
 a0LLq3g2m0yV41drH02gQlXvYCTnDV6ZYJsysEbFH4JHEvIzccrDm5CsBXXEmLk6oIo9
 gTrdxIJ0zHqRjUxQF5NvkP32NJNGcm2MNvfDv/lPcwPernp0PG6qFnupQt1vUWvXkz+0
 VyVD8IahR/gcal6Hg6GwPLpvAGe6eRkxlG62CoVl/4K9Zyx9xKH4BfHW/v2UHitHIdxN 2g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q92g9xvub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 18:39:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683337139; bh=c83virXNmsJ+7Z23ZXvTdh3ZbXAXwDES2346WTFqIJo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=d8whK8FIV5RIIUp/l7+M01mJcaLTLzseOZ2EwupxMMZk2Np7y3AusywREAJvcAZyJ
         VkvjWBBdgUeXSrN65N4DoUEvLwUjUrMLDfY0NoQUGrn6+mPfqhKCTrBQrlKVg/MDjX
         xz1DBSNxoktcztIgMSHzES46IiYa5AkNz0tVlh2b5j4yqliAZdv67tsttE9gbXpMHD
         cDM4Ct6hA5J04MuCRKc5OJJUPQaa5TyFTXyie4IENiO0UAqrTtZxqyZIZOP9dB+GQN
         2GT9d3ShxQOD8R55iBBucqqi11NMY5L4o2JYMzi4kVoKwa0qXCuLUe3KUkj+mygT02
         yEulP4Gaxg83g==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 716094060B;
        Sat,  6 May 2023 01:38:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DBB87A005C;
        Sat,  6 May 2023 01:38:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TMqaVMj8;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E5E3040407;
        Sat,  6 May 2023 01:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyO1NqVFlWxYm+tlWUhnp2PP5Pf/rZl2XjA1RWHGK6/ColcL69IR1fRyHXD8P6LeZKo6HaRoxw607hUR6A8ZgDL1bC772QuA+xxF+GAGasD6AdKl3TXI/Qt+njl2ANO6vkIBp/p4mit+FHx+R96YvxT5jjlZwqZsv79Pkb4oFhBJEpnbbuii/iCGNT8BDVcGr45vi9GIkwHxKcbT/JgjgatEYb6+wK3QS432ATr4ea/CyK75Skv34UrRqJCRGFsDLhhgoUnRMMx9fNYJwwaHo6J8wQHvLs10CDTjVMLXQ2sCu6n/IUV3eQyia+3HdatfTVIXIb3j5qmGphZlO21L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c83virXNmsJ+7Z23ZXvTdh3ZbXAXwDES2346WTFqIJo=;
 b=hHA75BrhSBhEFRx7SaYCNvqcc06MqHNac+cw8rcsLkXuyepUOtLGEqTBv8XuBhOzkiNAdUG7EaQtosz20Hh39o6C7RnMlRnjv9xt28Ng/kYd4ihOTmBlJCPY0TmJ3Mul6Yw5TUH9++cK+dKJPmR+wJVevHhKVi4UktKzbQkTjjnWfJXTBwwiHCHTSHwTM8syzUWMcRg9wfjtoqqj//BG6RktMzQxkGd1lZkGEoOyk+YRzHVOc8GBa7Ei5dZpWKAweFKg/0p6uhEetHlhpaxi8dgO7Y+/tM7oGk3AC4yG84g0P3JwXnJZdZKzGnKPZh44aAudYypZlLDSEYtnp8PgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c83virXNmsJ+7Z23ZXvTdh3ZbXAXwDES2346WTFqIJo=;
 b=TMqaVMj8D2tye9HAmYNuR5bKwf+atpvwMj3ESb7W1xkHYL9oT03WTXTayV4TmHF5DFtTzl2a7RQa16LzX/wkN7NuhhJfd10AgBWlNeJvI1KWl3QiHCE2bNIduvzgy2PQoczZBZGKh5jmwNzkQdu/HiF8Sq4EmjEPGnz1uVK/aJo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 01:38:54 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6363.026; Sat, 6 May 2023
 01:38:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] usb: dwc3: core: add support for realtek SoCs custom's
 global register start address
Thread-Topic: [PATCH v6] usb: dwc3: core: add support for realtek SoCs
 custom's global register start address
Thread-Index: AQHZfvx13m4Tu4feIUCbDoNY4rTDja9MeQEA
Date:   Sat, 6 May 2023 01:38:54 +0000
Message-ID: <20230506013842.7iu4hq35uyamt6np@synopsys.com>
References: <20230505025104.18321-1-stanley_chang@realtek.com>
In-Reply-To: <20230505025104.18321-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB9104:EE_
x-ms-office365-filtering-correlation-id: c8000fb2-e727-41c7-82a6-08db4dd2a6eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRq+f2a6WNppoGbqt5g1IILWdfbZCHDX3Z41Ic94+uz+fpnhiN/nwcHu9glR1pnVOV2edLy7A4fouYiN4JYGmrGG9r53ZTbs90P6CZIu25WvVZbXW8bafVxm6LF6a7V4DfMbaA8z1zVvjqRAOV2nuuxOYEVK24GVGIqC6hkF6aYfYbXyTfyP7HNMnkKyCt2jJle89LXeRzBaVpKXTT7RSHL6XCAoeh9ndrxj0Q5kqOxqOwAdKRFAybs3/xd4VNGNOL9zilo/fKdo1ziZj5rYmZOlmhoGbmPscLrxcD6YjGf/YrwIgaWWlV2YwzIAiPZMAGsTMflubf3+TpIKywPCmzaLfgOcx5WNkGN7q+3gH0g1XeB6vPvZnfFenUoj3w5uslw/3CkCJYClhKcP4HFhQvzjpkSbCPZtiyB315GXIKCiXfZK6Wsq4BicryVCDxU5Bk9BhcIk9ekrZYEg2Dqxi3XFWD2yAiEEctNlaf2DTP32DTb2VT1j062vsfnsJH/SHmrtUluznvDRhVRc7+rnl1GXoTKtUdaPeQPctVOTN1KYgwcSN1J3r00uMzqLAesf4ZnTrOZO7m79YRx2H0OD/9HLThAQylDLjdmnWWojdgicc32mdccIrfpGSjckLuM9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(2906002)(186003)(2616005)(6512007)(6506007)(4326008)(1076003)(316002)(66946007)(66556008)(66446008)(6916009)(76116006)(71200400001)(66476007)(64756008)(41300700001)(54906003)(478600001)(5660300002)(26005)(6486002)(8676002)(8936002)(38100700002)(38070700005)(122000001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ZGcFYxOHMzb3R1bEViblE5dDJBdXYxYnphemgxSFdhTmMrdGM1RnE1WU9w?=
 =?utf-8?B?Y0tpK0greUp6NWRRbWxSZUhnc1E5Q0ZCdjFRdEttem81a3VEeUZERFNhSENz?=
 =?utf-8?B?QkZFNTZhK04rUWNWRWJiTzVGMHhqVmgydFhsWFROTXFPczVobGMzNmhoQVhY?=
 =?utf-8?B?MXBnM2hUb1VmYWl0SUcxbjF2S1lQSGVTQXRWeXFveEtWVWtaSUJUUGNPQ1J6?=
 =?utf-8?B?K1BvNlpSN20xS2pNTm5zcFBFR2ZPRFpXclBaK0M3WnZBWmEwLzRLQTJPOWhP?=
 =?utf-8?B?cDh6OGMzOVU1dVl2TmE0QitzNCt6MmFiNHNCa21DeVZuQnFhSFVVOEt4a0kr?=
 =?utf-8?B?REMrWjd1dmxGU0I3b3VZSlA0QzNpYnA5Uk1aUjl1Q0tXUVdENGpQQmludHZ1?=
 =?utf-8?B?RkpzUW9wbE1ZSGFqVUczM0RwYXlXODhaL0FsY0pNQThYOTlVZEpKeWlGcHRi?=
 =?utf-8?B?MTJhVTRNRUJ1dFh4TnhFQjdPNjJYVVRkVERBMmRmeDFwTGh2WXVjYlRmVU91?=
 =?utf-8?B?M3hZd0RibTZOZmZzRmRJVHNncHhGMzNUc09Lc3VLaUVXRHY2OU5KYm1NQ0Fr?=
 =?utf-8?B?ZnNJOXVtODU1NjZqMXZqNmxFZUVIL1RYaGdEOEs4Wi9USHRQTkNVaUpKbXR1?=
 =?utf-8?B?ZmV2SFVySytSaUxLWXN2WjJuZm5TeVdVbG5tQStkYWlLVzRhMVA4VTI0cnJN?=
 =?utf-8?B?eWlKWDhLWW5KMUtETFR5OVhINmx3OHpLYjE4bSs1aFIzeDNmRGZmUzAyVExx?=
 =?utf-8?B?Z2h3NVYyd1dGdUxDbjg2SUYyL1N1L0F5YWlXOGs3b0NzOE54R1dEbmhycGpN?=
 =?utf-8?B?NG5wL2tLNjNGZEN2MkpKRGVEc1RqeHgzbk11MC9OUElJM1doNldoTGVBVkc3?=
 =?utf-8?B?cDlxUFN6T3dmV0pJaW5xS05nMjVkdm5maUUrdHd0RXRQUkd0UWFFWmVuY2gy?=
 =?utf-8?B?eERXWXdSREg0SUJiZ2tFcmJxMURQUW5sT1l6ZFA4VjU3V2owbFZHUTdkSmty?=
 =?utf-8?B?cVNKWURta0c1Ulg3OXdZNlJIMDdPYTZSUzFpQk5UTGgxWDJVb2o0TStVTW9o?=
 =?utf-8?B?YnIzZlRVelJ4VTIrSEVxTlIxd3h6aTFOK3NuZGZST3FZZXE2eFBBYmx0SzVw?=
 =?utf-8?B?aXluZ25INm1TZzdYVGZIUHQyTElqS1IzdVRxV2Yrdjg3YkU5ODBVOXpNclhF?=
 =?utf-8?B?M2NtRUZSQjBUMmRHblJRU29Za3h5TFE5a2VlNGZDM044a0VIQ04yb0RSaXFD?=
 =?utf-8?B?ZnNsNHRpdzA5OXNzV2R1UThZTXo5OFZLdUVYYlcxK0x5clllSklYMyttTEJI?=
 =?utf-8?B?aXFJMkEwMVNtY0NhWXh2bW50OW9wV3lVMlBkSEN4Y3BtakRLK2ZVYUNiWnlu?=
 =?utf-8?B?RW81cUZ4RmNaOWpSTFErd1FjUVgrVDZWVTBSclBQZU1VcWR0SytqVE90NlVB?=
 =?utf-8?B?dDdGWVdUNFUvMEV1QmNRVVNuVCtHUGVtZlNlSFduc0oyOUFnZmlFcXdVQ1Ix?=
 =?utf-8?B?ekJlMUFRVk5DYTZiUHF6WEtMSjEyUDlnYldpREJUVmx5UUNoVkhDd2hpN0M5?=
 =?utf-8?B?bTV3N09xdDhkTmN0SWg2ZWJmNERvaDR1S0dxZDcxVkllRWY3UHZ0TGhaVE5h?=
 =?utf-8?B?WFIxSHBHVS9YSHMxRzltT3NrOXY4aER4ZEJPaVJ5T2ZDYXlYbGMzR1Z5eDBs?=
 =?utf-8?B?V1Q4eUVDaVdqeXZHOEwyNGJ4cFVaM0NxKzM1RVRMVlhkeGhDY0ZMbSt3WjYx?=
 =?utf-8?B?WGgyNjdrYVE3Qmlsbi9vSjNFbnYzeDQxZWhQVDgvQTJtWUQvT3FLRjZMVTJH?=
 =?utf-8?B?OGErcjZJc0JDektRREdYU0pUYXdEdXJSUDFiZFFOa3cwbVBiQXdQc0JnT01M?=
 =?utf-8?B?cmtrSE8xTm1tOS8zOFdJTGxpSTc3T2dpYjRqMEI3bTh0WmRPS254RG1wdm5U?=
 =?utf-8?B?TDVPMmhkVy8vWFdUUldjM2hZT0dBU0psWSthaXRKVHREZ2t6ckFnZzV1WDVN?=
 =?utf-8?B?Und6Y1VmRnZkeTVXYlE4M1M5d09zZ0FTRldtUDdWRERkZkRoZkhjZFFaM0ow?=
 =?utf-8?B?a1hhZXdlbUZqZnp1RDB3MDFNajFDVWlaaE5nS1R5aCt6ZWt2a2xXTTNCTW1U?=
 =?utf-8?B?NUdDdmtjSFJDZHNvMHNaaWgwRk5ZRHZWR0FIc2FvQ2hBZUtPVU1KMmJTYWhn?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C063EACC7FAB3C43A10D7495DE39E3F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /Iq1rBwYSKhzoyOrDqVvmqpnZWltHre1+4HaTkVSP6NoVzGMLGZg7DCpD7RZjcoWmwNUUu2cHWWBaWoLcBEuo85ZLJjEEizs+/0Jn2iVJdRnU8ACtVnCVdB6X77oduzOXz37plGbaw6o/sPyensRS4GYsshn94vicqipFAB5NMYKDhF2QQ2B4D6PD/pEcgBJht7cbohJXPmJYdh6yceFtRBXG4Uc88JdmHN0I4jgyhjdTsos/Ord4JcEmavnhKVJaKBSe70lYx4gqe02oi4jLDykrRBQ32kMA9hP929G4rV3L9pqrAxhP2gGaCsLuBbqq5gUXl4wiunZZ6H069h12l8FirRe7F5DD8aJfoCCwg0it8hh9+riTrPa+KyC79UJn5Kuqyavdq+8WGEvrPbOPMvfOcrYQvACn5uSti9JE3frGQfXvpoZLsqMfNeodR9T1tocW/hJgVlNgmUUkDywUlvWTS+EWA9fr0h4ZMFj8JF40r/zDXa6JbyDuoJsEw61u8YYBYtxATlm57n5ZSSA6ltrH0dmbEe+xnmhwlkBZu7iYJmFgmaRoqBakRQSKJ3sHWhu/TijlhEZ7Vrbvk7CV3be58Cmpwr0jIN2cxPpjV+h/39ZILN7imRFnxJGjYFXvPq0jjspUPyiGQM1NeAmUUsEVs5q/kgblRklEUiONqh5V6xLjTQ4+AhLEAbCHRpAV9/08UeaoDhG8ot92YEpDJuIeCYFQ5DBQr0Eo5n6k8P6/49QJiHZaRnK1oQd+Q5LYb8heXloDyRi3n+4DcPJPDjL5VGhdBcW8EfYr6XMuBLTNZ1kImlaS/tTsyc0PFxy5ixG6yglsAFy+t2qBompM+dMoeHsq96dnqXcLrx4jQ2hZLDIw2CqinYALn/vuNJs
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8000fb2-e727-41c7-82a6-08db4dd2a6eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 01:38:54.1857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmAMacVlYR0quOj60VzximadVEQTZ06XVzuOSgLlTNIOBgJ//9j6FHYZPICxOe51fqzoLxLnI9qBi4awgmv6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
X-Proofpoint-GUID: BbjGaTGnujXt9FBRsa-gccLJn39tYfYA
X-Proofpoint-ORIG-GUID: BbjGaTGnujXt9FBRsa-gccLJn39tYfYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_29,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305060010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMDUsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IFRoZSBSZWFsdGVr
IFJURCBTb0NzIHdlcmUgZGVzaWduZWQgd2l0aCB0aGUgZ2xvYmFsIHJlZ2lzdGVyIGFkZHJlc3MN
Cj4gb2Zmc2V0IGF0IDB4ODEwMC4gVGhlIGRlZmF1bHQgYWRkcmVzcyBvZmZzZXQgaXMgY29uc3Rh
bnQgYXQNCj4gRFdDM19HTE9CQUxTX1JFR1NfU1RBUlQgKDB4YzEwMCkuIFRoZXJlZm9yZSwgYWRk
IGEgY2hlY2sgaWYgdGhlDQo+IGNvbXBhdGlibGUgbmFtZSBvZiB0aGUgcGFyZW50IGlzIHJlYWx0
ZWsscnRkLWR3YzMsIHRoZW4gZ2xvYmFsDQo+IHJlZ2lzdGVyIHN0YXJ0IGFkZHJlc3Mgd2lsbCBy
ZW1hcCB0byAweDgxMDAuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFu
bGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiAtLS0NCj4gIHY1IHRvIHY2IGNoYW5nZToNCj4gQ2hh
bmdlIHRoZSBjb21wYXRpYmxlIG5hbWUgdG8gYXZvaWQgdXNpbmcgdGhlIHdpbGRjYXJkLg0KPiAN
Cj4gIHY0IHRvIHY1IGNoYW5nZToNCj4gVXNlIHRoZSBjb21wYXRpYmxlIG5hbWUgb2YgdGhlIHBh
cmVudCB0byBtYXRjaCB0aGlzIHNwZWNpYWwgb2Zmc2V0Lg0KPiANCj4gIHYzIHRvIHY0IGNoYW5n
ZToNCj4gVXNlIHRoZSBjb21wYXRpYmxlIG5hbWUgdG8gc3BlY2lmeSB0aGUgZ2xvYmFsIHJlZ2lz
dGVyIGFkZHJlc3Mgb2Zmc2V0Lg0KPiBJZiB0aGUgY29tcGF0aWJsZSBuYW1lIGlzICJzbnBzLGR3
YzMtcnRrLXNvYyIsIHRoZW4gdGhlIG9mZnNldCB1c2UgMHg4MTAwLg0KPiBPdGhlcndpc2UsIHRo
ZSBvZmZzZXQgaXMgZGVmYXVsdCB2YWx1ZSAweGMxMDAuDQo+IA0KPiAgdjIgdG8gdjMgY2hhbmdl
Og0KPiAxLiAgRml4IHRoZSBkdHNjaGVtYSB2YWxpZGF0aW9uIGVycm9yLg0KPiANCj4gIHYxIHRv
IHYyIGNoYW5nZToNCj4gMS4gQ2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBwcm9wZXJ0eSAic25wcyxn
bG9iYWwtcmVncy1zdGFydGluZy1vZmZzZXQiLg0KPiAyLiBBZGp1c3QgdGhlIGZvcm1hdCBvZiBj
b21tZW50Lg0KPiAzLiBBZGQgaW5pdGlhbCB2YWx1ZSBvZiB0aGUgZ2xvYmFsX3JlZ3Nfc3RhcnRp
bmdfb2Zmc2V0DQo+IDQuIFJlbW92ZSB0aGUgbG9nIG9mIGRldl9pbmZvLg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTEgKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3
YzMvY29yZS5oIHwgIDIgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gaW5kZXggMGJlYWFiOTMyZTdkLi4yNzhjZDFjMzM4NDEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IEBAIC0xODAwLDYgKzE4MDAsMTcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJZHdjX3JlcyA9ICpyZXM7DQo+ICAJZHdj
X3Jlcy5zdGFydCArPSBEV0MzX0dMT0JBTFNfUkVHU19TVEFSVDsNCj4gIA0KPiArCWlmIChkZXYt
Pm9mX25vZGUpIHsNCj4gKwkJc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQgPSBvZl9nZXRfcGFy
ZW50KGRldi0+b2Zfbm9kZSk7DQo+ICsNCj4gKwkJaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxl
KHBhcmVudCwgInJlYWx0ZWsscnRkLWR3YzMiKSkgew0KDQpJcyB5b3VyIHBsYXRmb3JtIGFscmVh
ZHkgcmVsZWFzZWQgb3IgaXMgaXQgc3RpbGwgdW5kZXIgZGV2ZWxvcG1lbnQ/IEp1c3QNCmN1cmlv
dXMgc2luY2UgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGlzbid0IGZpeGVkLiBJcyBpdCBnb2luZyB0
byBiZQ0KY2hhbmdlZCBpbiB0aGUgZnV0dXJlPw0KDQo+ICsJCQlkd2NfcmVzLnN0YXJ0IC09IERX
QzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiArCQkJZHdjX3Jlcy5zdGFydCArPSBEV0MzX1JUS19S
VERfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiArCQl9DQo+ICsNCj4gKwkJb2Zfbm9kZV9wdXQocGFy
ZW50KTsNCj4gKwl9DQo+ICsNCj4gIAlyZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwg
JmR3Y19yZXMpOw0KPiAgCWlmIChJU19FUlIocmVncykpDQo+ICAJCXJldHVybiBQVFJfRVJSKHJl
Z3MpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuaA0KPiBpbmRleCBkNTY0NTdjMDI5OTYuLjE5Njg2MzhmMjllZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gQEAgLTg0LDYgKzg0LDggQEANCj4gICNkZWZpbmUgRFdDM19PVEdfUkVHU19T
VEFSVAkJMHhjYzAwDQo+ICAjZGVmaW5lIERXQzNfT1RHX1JFR1NfRU5ECQkweGNjZmYNCj4gIA0K
PiArI2RlZmluZSBEV0MzX1JUS19SVERfR0xPQkFMU19SRUdTX1NUQVJUCTB4ODEwMA0KPiArDQo+
ICAvKiBHbG9iYWwgUmVnaXN0ZXJzICovDQo+ICAjZGVmaW5lIERXQzNfR1NCVVNDRkcwCQkweGMx
MDANCj4gICNkZWZpbmUgRFdDM19HU0JVU0NGRzEJCTB4YzEwNA0KPiAtLSANCj4gMi4zNC4xDQo+
IA0KDQpUaGFua3MsDQpUaGluaA==

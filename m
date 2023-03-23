Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC686C71E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCWUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCWUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:52:13 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A320A12;
        Thu, 23 Mar 2023 13:52:12 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NHPaeI029443;
        Thu, 23 Mar 2023 13:51:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=FpfGrrO3GxKBmD9knae7oXPFYs7RWmqdWaF5bhhvXm4=;
 b=pde0MOaG0s2tGAEvAzA2MgKmIrddmvV2KBHr5/v31sYynBUg+tLuTpoClRtheweAcFF2
 CTTPN761vANI/Tjmrf++mBMi54D/huWSMcVMOxB72X16wJYbWkm5QgMPsbGWXXIN5Noh
 fgMY0UjxyK2x8hXOFqW/IRcCBkgdqm+l8T+Gd2K2ZRumVnQkPl/vmMr0CdtdwAPR3NXv
 pzVUZn/PP3TW4LdrzFYpnS1XGCI9gE+6pI6l+plqopP4bcMrtjKdPhLCguscKsJ7vhrW
 CaP3IWnwDtHkhyE3d7AZnT6eSl5KcNPIjFmfGgda4/ZmYSvy/JHxpnSoQoTE8LNLREUN Hg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pdcj7m7k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:51:56 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2FB1140103;
        Thu, 23 Mar 2023 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679604715; bh=FpfGrrO3GxKBmD9knae7oXPFYs7RWmqdWaF5bhhvXm4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H5OM4MpUYxvp0s8PMACm6mynH2AkiZUbX/Rx8pfJjh5cKbBI7oWNflkfTZOwTFnep
         zxNoH/hApQA2yhfcRGNabGGm0mXjnsrTQZ8PVR6mvj8G/alFcU4U/V4Ur9QKJC7D1H
         KrgkTCqGHTDprVOcSH9x3AZI1+UbhV6FT9GVSObgI3GeR7+0hna2sbMTXY9oq8kvcO
         WanmvbKeO4+yfWxtIdZIXgYSj9eYdqYUCFga0izxvctOwfQRJRdd/c7C5xzpKn2pLj
         zBNYCjKo+cxi2CDhsBMubXVVJilj7+NxwMMXjLiHE/Cjfvrj3JrmtdOfwMOm+9UYHG
         +aEOngElaYFjQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6C888A0060;
        Thu, 23 Mar 2023 20:51:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1E46340060;
        Thu, 23 Mar 2023 20:51:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NKE/1T5H";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3wglkrUpj/2qO4aXaI0EKuiNrZEmwhWPQxZ5Y14+lHF83w/AUs2naU/kPYoc0Mz3VGvl7NTanbfzd4IfBbO2EZryq0eKptMNyvIusGJKX7lZPDwBhzl4ROOeq2XZwuRJDRUDqKgCcL94nA7U/iPxEE+nJzJfnMPB8Jibn15sAfHiROS2b0+D+on0p2mwUbMINb+oPL1gDTCRRTgtB9X1hIQcBtDQThEino61rhGnbASAkPLWybwLNKw9esi6W+GbrvlApO8PxU84j/AtlQaZPv2KHvAe28X25ldqh776Zy+cBjilc3cGlsUG8kyFDnNl/dZ8IycM/DaoYfnxnUZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpfGrrO3GxKBmD9knae7oXPFYs7RWmqdWaF5bhhvXm4=;
 b=X5T7SBSR94xw9J+ffMzoICK5VI3QsRUrD9W9WbxdVtlKNcg6N4BMaHqIKy8N6apzRE9mJfvVu+23l+/i9Y/cw2jgyJrkrzT0mzGD+H7fhEg856aiKbDkLbcSMrCqO6SgpSUj7POqPLXgeHOOq1eLhLCBYOBbybBNHKnFr7Fyz5Vz460OQN4oD30666mVLxIwbL5YXWwPzoWimkYqYBaGPHSve7o4t8izWHsZk6qvee1Hn8NtQ9768pUWXbLa9lA+uUL1/PAuAZ8LGfXXKRwHcCDAN5z1FztAtlP5WIwP0Dv2vi6bNPHbuM0xvNUSpFxCRbVtk+i1QNfBD4rFVa52XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpfGrrO3GxKBmD9knae7oXPFYs7RWmqdWaF5bhhvXm4=;
 b=NKE/1T5Hmc9PbIxFzvRSPdrzKYVBNqFvQsUo6FuENPPZPCRQImhIyq9T3qjf06jF+pVFhJNID3hQlu3htSFt0rR0qQmxq3I5yWAdX8tJVYvW1crsdNo/OXsdyzFo2Jq19V9MyRYbnK+Vg4KkEeb8vhc5F7M1YrgQcUj/VER/DGU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 20:51:49 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 20:51:47 +0000
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
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAIAAkueAgAB4pQCAAL6cgA==
Date:   Thu, 23 Mar 2023 20:51:46 +0000
Message-ID: <20230323205139.4on6vx555ohdec7y@synopsys.com>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-3-rogerq@kernel.org>
 <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
 <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
 <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
 <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
 <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
 <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
 <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
In-Reply-To: <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM6PR12MB4188:EE_
x-ms-office365-filtering-correlation-id: 9adab4c5-118d-4c30-25c9-08db2be06ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oOf218QT1vB8Ua7jFa2PpdbmJq+U9a6BPtnu3Lp+gZM6fP2jQp1wtP3gejzw1iHVFlm4wX+V7zAc5Vcq2Y4oGZeIpU8XJaHqXByDK/IN9ehJyv5iLnRHuXgVVbBYd+gh94g6SIvbORr6fz5tZnS0x0RHhmHMy1yEYxXwnKj0H/wpgSrD+Bx/Ib3vdFYr7A2CY6mVm/vGBSDSdsjj3++LXGKT8bQswcka2CahArCqV6nEUoXHAozQ2lQsIyCr8WE3YVVuSPstw5aaJx4RU0RjcQUaf9GhKRe8XVyIKBl3/mdO9n1UO4GGh0l15zyyZbg7YJiywqHa9XtopP0F8xtldPwwtHsimkaxqehwPCCZLpFiCFwPlp1DNYKCWTnhhxD3fvD2R1fQWBBiHpCwW3bluF6BKIVOT0H5pjJodCEilJo1VaUyyzwFlATUsC6l2o+DR8I80QtXS9hHAoc7v95WRVRcprUKgf1gEovlMOMW5dEgkYMQjlHFT2o9EVuxBmZ5e5I7s/RL67i+XSeSlCNq716KDgVrPKJDO1G1rJl9fW3U9rSLMs13O9eSnH9CD2sSPz4AllcI9iyFih2gGLIXpZN10+W9PilwziZTAHFbWvplkCeoBwo1RNG1ymxx4aFfgoKjLRM+8OgL1ACLj9kpJApIf39AsQ8vhdsLPLwfiinfRD+D6WH9U51JeHIEV4MSNzYtfRTz0Soacod58pHpiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(36756003)(38100700002)(6916009)(86362001)(8676002)(4326008)(66476007)(64756008)(66446008)(66946007)(66556008)(8936002)(41300700001)(76116006)(71200400001)(6486002)(316002)(478600001)(54906003)(2906002)(5660300002)(38070700005)(26005)(53546011)(122000001)(6512007)(6506007)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2NqMndtTFVVNVpnVE8zY2tTTzdqN0c1UU0zaHcvTk1vcHVlNUFZUGp1UzIv?=
 =?utf-8?B?WjRXQitzdmx2S1h6aE1pcmk1VWZFWHNuZzdDNGJ1SVpXVUttckh4NHRDNUtX?=
 =?utf-8?B?dTBqT2ZVWmhqakpvYWVKdklBeXVlbFR5V09STnR5M0dCSzJSQ0x0a3RyMFg0?=
 =?utf-8?B?WjRyQWJPSXkxUkJNWmE5TlJOakZ2TWJMMGZPMy9FWjJOeXd6SGpNMmIwQ3px?=
 =?utf-8?B?M2lKSDZkRWZzVVVsSkR5U0ZQM0NoUDZBVU9MWDIvUDg4cmFNT2Vrc29lMXRZ?=
 =?utf-8?B?N2xCMzVQcmNCRzA2Q0luK1ZRblpZRE5RVi9SeXdkc2FKM1pxbUZ6NW1GU0Qv?=
 =?utf-8?B?OFNEUTlSNVZqZU5WcnczeGlkOTlWVzAvNS9KeFFJR0d6TVo1MjVaUHR0S2tp?=
 =?utf-8?B?QWdZQzF2ZVdFd2xJTzNUVmdaelpiUTM3T00vMldZdkJiZzNWTVgySFhIVDJQ?=
 =?utf-8?B?Q2l0WGQ3aTNZakVqQnB0ckJkQlllWE5jaTJXQ1VnbVQxSVdqUlZDNFBMdWRM?=
 =?utf-8?B?eFZVbW5naFFaYy96aTJMdDlDRmlQaGc1d0licVZ0bGNiUzlmVml4c2RiVElS?=
 =?utf-8?B?R3k3ZG00VzlaY29PQzRvVU9DRlFWdldiWFZrUjVHZEk5MEpzWTl0VHRSRFNt?=
 =?utf-8?B?RlBJWWI5OXY0bVJ2cVlGdUwxREpuSmVUUXp0bWk4eS9NeVUzbmtRWThjWWVm?=
 =?utf-8?B?NmJWUGswNGhHdlVtSEdFUWl2Qjc1dW8yblE1N2xzRTI2N2dTTFBHcTBGYU1F?=
 =?utf-8?B?YmxnK21sQmt2a3lhdmEzSXB4RzMyczlueUJqQXNpNGFLWG1LQ3lkVVFvaWpI?=
 =?utf-8?B?bjZyZHl4TWx4TEUzaGI3V1o2VVgweDh2Wk5paUcyc0crWUxaV1NQUllyVkw5?=
 =?utf-8?B?ZHFjSkhXRGFmZUs2NUNlOENVbkdCY29oRnhMVTJrbEpJSGwwMUtqOU1pb2Yz?=
 =?utf-8?B?dXFNbTM1WUNzYkI0cXFvRU4zWHFIMWRkMUZRNEJmeHUwUkFMbVozUlZlS3No?=
 =?utf-8?B?OUR4bDQwdm5qT3F4aVJTbXNIczBJQVJrSXAvZkJZS1dOVXFNSDcyMjh0MWR3?=
 =?utf-8?B?bVh1S3RQeDJOQlgwYm9UTmM3RjNQT1FONjJ0TXNlcXcrYktLUEJLRUdDaGFU?=
 =?utf-8?B?WjczNS9NeGZKSTBGYnhSYm52WGdSdzUrbm9ySDhVL2N2ZHVWbTFHRTFCMlg1?=
 =?utf-8?B?a0ZOWlFTdXU3bUR6RVl6SGJZc1IweHM0c1ZueG9KNTZjUTRSakJrTmJLdVho?=
 =?utf-8?B?UHg4RzNmWFp4OG81U09uTlAxZTBoOTRrNkpKYjcyKzBjVlFtU2RwYkxTeVVo?=
 =?utf-8?B?QXpGdC9tODFCSkErMHVVaWN6eURHQ1J1LzNyZ0x2UjBPeTZ4amdDNm1pbnFS?=
 =?utf-8?B?NUp2OEpMOUl4UTBqaGpYd3hReUQ0dXBUYUhMRkNGaVBCV21oeTJEU3FwcERR?=
 =?utf-8?B?aXRYVFF3T3R0dG9Ncks2a3NyZHQxaUh5N3Jqd0N6dmRlNW9uczJTUmU1d05s?=
 =?utf-8?B?eGxYZ3M0SkpVWUFRcCt0SkVOUWpLWEgwWXNRYWovWnY3OGdrUkptZjhRai93?=
 =?utf-8?B?TGVyL1lEa1lkUTlpVlpxb1p3eVpmMDI1b1EwNWU4aXJIY0UwWjM4UHFTa3lT?=
 =?utf-8?B?dkYxMjgwRGtRT0o4YjRJdGIwdTFBTGs1TDBlcHlYV0Fzc0JQTWI5VnF0b0VQ?=
 =?utf-8?B?d3FJK2h2TGpkMTVJdVo3Y1RWNzdQWmtleFV0WnlUWlMyS3o0KzBxaUE0TDBI?=
 =?utf-8?B?L3lzMVUxYXFORWRUbFJ1SkRUaHlNdVNXOCswRWJXdHF6TGcrUFlyQ2lXRnB1?=
 =?utf-8?B?MkRadGMybGVjSWdML01URzFGUDVuNHA1MFo1VHVHRTFrRkY4VTFDRXpvazIx?=
 =?utf-8?B?aGVlUHdpTmdiZUUzM0dod1dLMmtleVVIRDRjSFZDMVNYZ1FuUXdWTEhQemNP?=
 =?utf-8?B?TGx2TXEyQWVsbkZmY0EwUjhQREFDVnVpTUtNZWhvRGpRcHpHOUduUXhlYmw5?=
 =?utf-8?B?L0dzT0lkNktmdW00QVV1NEJXM1dUWFBGRGozcWNuaDVFcnZkSll0cFNyMW1R?=
 =?utf-8?B?VjRTYkNKclUzaFM5K2IxbzQ3U3UwZG5XZGZ0OGtWMENSMjg4dUdSaWJwaGZo?=
 =?utf-8?Q?/76D4n6aOiH+UOvdSm+XkFPPv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A599F61A22955D4E908453BAF4B38A99@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MVdtSnBQY20xMTVpUU5pMEkyYkswMVZzaEQ3Y2V1WlhnWUVwNHBKNTBnanBJ?=
 =?utf-8?B?WGRCNlJRajluS0hnV21mU0J3cEJLd213cUJ5ZTVlVGtWRGJIOS96dmNoUTNW?=
 =?utf-8?B?OXRCMTZjeDU5c1lxUzRJN3hHczFqRnhWRnEzUVhQK1p2ZzY2Q2l3QzYvMDQ4?=
 =?utf-8?B?eUE4SDVxNmVudUQ4Z1czU3RMdTNzTytMbnp4NW0zMmpqYmJQMzNLaXJsVkF2?=
 =?utf-8?B?bW5MSnlMajN4OHN2Qkx3d2IxRVM1N3VpQldhYXJEWWJHeWNwTXN6cS9SNTVV?=
 =?utf-8?B?V3RuaFFqZzBPb0E1UGdNU3phMEI5ZGFLZDBKclBhMWMyZWlUaUFGeG5vYjR1?=
 =?utf-8?B?S1ZBRitKM2FsMTlKNFptTTYvWGVqNWxJZXhLd0dvdWw4WXRyV0hLdUxMcFkv?=
 =?utf-8?B?c1BNMHZFWS9iaU5FU1lKbFBxaXFuNlU3NXRIRHpiM0FnRkQzeDQ4dlcvYith?=
 =?utf-8?B?eldmRkFpTFc1ZU5MRm02cE5rd1I2VCtRcWZoU1ZTQ1pUTFl2VzFRMTk2UW9u?=
 =?utf-8?B?d3FKZ1NwTXk4emtOTkxjR0FCM0ZJWUppdkZzSWp6N1MxVWMwQWw5VVRPVk02?=
 =?utf-8?B?cHMzUjlPb2I2VEFvdjFNNHdiTUJUK0FZb1B0cS9TZG9ucy9PNzRJUTIyNncy?=
 =?utf-8?B?ZG1KUmV4SlhQSkU5SDdwdnlrVDFHcGtxaXJvMERLc0tJVEcwVmpvUWkyaWcz?=
 =?utf-8?B?bXdScktrNmxxUDg2Uk9XVXYrSjU2czE3OEZSeEJ6V041c2dSV1BDdzY0THpU?=
 =?utf-8?B?UkNUcFdEVld5T01OS09FeFFXMEpUMEtYK21rQ3dsWndBc1pzdmlqeUNqZ0Zs?=
 =?utf-8?B?L0IxQlkrUkl2Q0RNamVkWVpneTcrd1hjZGw2SWVOUnJQOGxoamxsY2FRWXhQ?=
 =?utf-8?B?aTg2OGhyMFBSSkI1UlZmZDNlYXc5QXpXWkk1Y2JlTWlYRnFRbWFKeFg3UElV?=
 =?utf-8?B?LzJNRTBaY3hiNXJjWEFEanQweVB1V0lsNGlPcllaVm05Vk9SR2kwMWFjZHRU?=
 =?utf-8?B?dkVGbWZ3L2xBRmpjNVg5SUtablU4eHBjOWxaT1lqTVNCTFBYS1FKaUczUkhD?=
 =?utf-8?B?U0FaRWtzcEsyM1VRdVl6a2FYOSt3UWx0d3puSnlUT1NST2RLNDZhMHIzYnRp?=
 =?utf-8?B?aHdZdjZJMHlQU0I4WGxoNWJESml3OE13Unl5L0lOUjUrVXo3K0hXdm43Ullv?=
 =?utf-8?B?blVKbzY2Y0xsWjhoRlRaSjdUeDd1bFlKbTR6bW8yZGYvdjhIMURBV1ZhQS9i?=
 =?utf-8?B?M20xd3E2N0tGZWRNcGRNOVJLQjZlWHdxekdGMnpFaGpWTjZEUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adab4c5-118d-4c30-25c9-08db2be06ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 20:51:46.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEQWmtiu5abjNhZ6YYY9zsTdVfyomPBvuJqojz0XY7gHFQJvEhsqsiCtvL+lL13dX0N4bNfe5TTq9qa3UKmZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
X-Proofpoint-GUID: 8NBXbkqTDXN6xaCE6_OgnD0FEO6oC4pf
X-Proofpoint-ORIG-GUID: 8NBXbkqTDXN6xaCE6_OgnD0FEO6oC4pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230152
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMjMsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MjMvMDMvMjAyMyAwNDoxNywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWFyIDIy
LCAyMDIzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+IE9uIFdlZCwgTWFyIDIyLCAyMDIzLCBS
b2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pj4gT24gMjEvMDMvMjAyMyAyMTowNSwgVGhpbmggTmd1
eWVuIHdyb3RlOg0KPiA+Pj4+IE9uIFR1ZSwgTWFyIDIxLCAyMDIzLCBUaGluaCBOZ3V5ZW4gd3Jv
dGU6DQo+ID4+Pj4+IE9uIFR1ZSwgTWFyIDIxLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiA+Pj4+Pj4gSGkgVGhpbmgsDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gMjAvMDMvMjAyMyAyMDo1
MiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4+Pj4+IEhpLA0KPiA+Pj4+Pj4+DQo+ID4+Pj4+
Pj4gT24gTW9uLCBNYXIgMjAsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4+Pj4+Pj4+
IEltcGxlbWVudCAnc25wcyxnYWRnZXQta2VlcC1jb25uZWN0LXN5cy1zbGVlcCcgcHJvcGVydHku
DQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IERvIG5vdCBzdG9wIHRoZSBnYWRnZXQgY29udHJvbGxl
ciBhbmQgZGlzY29ubmVjdCBpZiB0aGlzDQo+ID4+Pj4+Pj4+IHByb3BlcnR5IGlzIHByZXNlbnQg
YW5kIHdlIGFyZSBjb25uZWN0ZWQgdG8gYSBVU0IgSG9zdC4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4gUHJldmVudCBTeXN0ZW0gc2xlZXAgaWYgR2FkZ2V0IGlzIG5vdCBpbiBVU0Igc3VzcGVuZC4N
Cj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9n
ZXJxQGtlcm5lbC5vcmc+DQo+ID4+Pj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4+PiAgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgICB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPj4+Pj4+Pj4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgfCAgMiArKw0KPiA+Pj4+Pj4+PiAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+Pj4+
Pj4gIDMgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4g
Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPj4+Pj4+Pj4gaW5kZXggNDc2YjYzNjE4NTEx
Li5hNDdiYmFhMjczMDIgMTAwNjQ0DQo+ID4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+ID4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+Pj4+
Pj4+IEBAIC0xNTc1LDYgKzE1NzUsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVz
KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4+Pj4+Pj4+ICAJZHdjLT5kaXNfc3BsaXRfcXVpcmsgPSBk
ZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4gPj4+Pj4+Pj4gIAkJCQkic25wcyxkaXMt
c3BsaXQtcXVpcmsiKTsNCj4gPj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+PiArCWR3Yy0+Z2FkZ2V0X2tl
ZXBfY29ubmVjdF9zeXNfc2xlZXAgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwNCj4g
Pj4+Pj4+Pj4gKwkJCQkic25wcyxnYWRnZXQta2VlcC1jb25uZWN0LXN5cy1zbGVlcCIpOw0KPiA+
Pj4+Pj4+PiArDQo+ID4+Pj4+Pj4+ICAJZHdjLT5scG1fbnlldF90aHJlc2hvbGQgPSBscG1fbnll
dF90aHJlc2hvbGQ7DQo+ID4+Pj4+Pj4+ICAJZHdjLT50eF9kZV9lbXBoYXNpcyA9IHR4X2RlX2Vt
cGhhc2lzOw0KPiA+Pj4+Pj4+PiAgDQo+ID4+Pj4+Pj4+IEBAIC0yMDI3LDE0ICsyMDMwLDIwIEBA
IHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNz
YWdlX3QgbXNnKQ0KPiA+Pj4+Pj4+PiAgew0KPiA+Pj4+Pj4+PiAgCXVuc2lnbmVkIGxvbmcJZmxh
Z3M7DQo+ID4+Pj4+Pj4+ICAJdTMyIHJlZzsNCj4gPj4+Pj4+Pj4gKwlpbnQgcmV0Ow0KPiA+Pj4+
Pj4+PiAgDQo+ID4+Pj4+Pj4+ICAJc3dpdGNoIChkd2MtPmN1cnJlbnRfZHJfcm9sZSkgew0KPiA+
Pj4+Pj4+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+ID4+Pj4+Pj4+ICAJCWlm
IChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ID4+Pj4+Pj4+ICAJCQlicmVhazsN
Cj4gPj4+Pj4+Pj4gLQkJZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiA+Pj4+Pj4+PiArCQly
ZXQgPSBkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ID4+Pj4+Pj4+ICsJCWlmIChyZXQpIHsN
Cj4gPj4+Pj4+Pj4gKwkJCWRldl9lcnIoZHdjLT5kZXYsICJnYWRnZXQgbm90IHN1c3BlbmRlZDog
JWRcbiIsIHJldCk7DQo+ID4+Pj4+Pj4+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+Pj4+Pj4+PiArCQl9
DQo+ID4+Pj4+Pj4+ICAJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiA+Pj4+
Pj4+PiAtCQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiA+Pj4+Pj4+PiArCQlpZighZHdjLT5nYWRn
ZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCkNCj4gPj4+Pj4+Pj4gKwkJCWR3YzNfY29yZV9leGl0
KGR3Yyk7DQo+ID4+Pj4+Pj4+ICAJCWJyZWFrOw0KPiA+Pj4+Pj4+PiAgCWNhc2UgRFdDM19HQ1RM
X1BSVENBUF9IT1NUOg0KPiA+Pj4+Pj4+PiAgCQlpZiAoIVBNU0dfSVNfQVVUTyhtc2cpICYmICFk
ZXZpY2VfbWF5X3dha2V1cChkd2MtPmRldikpIHsNCj4gPj4+Pj4+Pj4gQEAgLTIwODgsMTEgKzIw
OTcsMTUgQEAgc3RhdGljIGludCBkd2MzX3Jlc3VtZV9jb21tb24oc3RydWN0IGR3YzMgKmR3Yywg
cG1fbWVzc2FnZV90IG1zZykNCj4gPj4+Pj4+Pj4gIA0KPiA+Pj4+Pj4+PiAgCXN3aXRjaCAoZHdj
LT5jdXJyZW50X2RyX3JvbGUpIHsNCj4gPj4+Pj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBf
REVWSUNFOg0KPiA+Pj4+Pj4+PiAtCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3
Yyk7DQo+ID4+Pj4+Pj4+IC0JCWlmIChyZXQpDQo+ID4+Pj4+Pj4+IC0JCQlyZXR1cm4gcmV0Ow0K
PiA+Pj4+Pj4+PiArCQlpZiAoIWR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXApDQo+
ID4+Pj4+Pj4+ICsJCXsNCj4gPj4+Pj4+Pj4gKwkJCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9y
ZXN1bWUoZHdjKTsNCj4gPj4+Pj4+Pj4gKwkJCWlmIChyZXQpDQo+ID4+Pj4+Pj4+ICsJCQkJcmV0
dXJuIHJldDsNCj4gPj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+PiArCQkJZHdjM19zZXRfcHJ0Y2FwKGR3
YywgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0UpOw0KPiA+Pj4+Pj4+PiArCQl9DQo+ID4+Pj4+Pj4+
ICANCj4gPj4+Pj4+Pj4gLQkJZHdjM19zZXRfcHJ0Y2FwKGR3YywgRFdDM19HQ1RMX1BSVENBUF9E
RVZJQ0UpOw0KPiA+Pj4+Pj4+PiAgCQlkd2MzX2dhZGdldF9yZXN1bWUoZHdjKTsNCj4gPj4+Pj4+
Pj4gIAkJYnJlYWs7DQo+ID4+Pj4+Pj4+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQo+
ID4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQo+ID4+Pj4+Pj4+IGluZGV4IDU4MmViZDljZjljMi4uZjg0YmFjODE1
YmVkIDEwMDY0NA0KPiA+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+
Pj4+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+Pj4+Pj4+PiBAQCAtMTMy
OCw2ICsxMzI4LDggQEAgc3RydWN0IGR3YzMgew0KPiA+Pj4+Pj4+PiAgCXVuc2lnbmVkCQlkaXNf
c3BsaXRfcXVpcms6MTsNCj4gPj4+Pj4+Pj4gIAl1bnNpZ25lZAkJYXN5bmNfY2FsbGJhY2tzOjE7
DQo+ID4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4gKwl1bnNpZ25lZAkJZ2FkZ2V0X2tlZXBfY29ubmVj
dF9zeXNfc2xlZXA6MTsNCj4gPj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+PiAgCXUxNgkJCWltb2RfaW50
ZXJ2YWw7DQo+ID4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4gIAlpbnQJCQltYXhfY2ZnX2VwczsNCj4g
Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+Pj4+Pj4+IGluZGV4IDNjNjNmYTk3YTY4MC4uODA2MmU0
NGY2M2Y2IDEwMDY0NA0KPiA+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ID4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4+Pj4+Pj4g
QEAgLTQ1NzIsMTIgKzQ1NzIsMjMgQEAgdm9pZCBkd2MzX2dhZGdldF9leGl0KHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ID4+Pj4+Pj4+ICBpbnQgZHdjM19nYWRnZXRfc3VzcGVuZChzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiA+Pj4+Pj4+PiAgew0KPiA+Pj4+Pj4+PiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ID4+Pj4+Pj4+ICsJaW50IGxpbmtfc3RhdGU7DQo+ID4+Pj4+Pj4+ICANCj4gPj4+Pj4+Pj4gIAlp
ZiAoIWR3Yy0+Z2FkZ2V0X2RyaXZlcikNCj4gPj4+Pj4+Pj4gIAkJcmV0dXJuIDA7DQo+ID4+Pj4+
Pj4+ICANCj4gPj4+Pj4+Pj4gLQlkd2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIGZhbHNlLCBmYWxz
ZSk7DQo+ID4+Pj4+Pj4+ICsJaWYgKGR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXAg
JiYgZHdjLT5jb25uZWN0ZWQpIHsNCj4gPj4+Pj4+Pj4gKwkJbGlua19zdGF0ZSA9IGR3YzNfZ2Fk
Z2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+ID4+Pj4+Pj4+ICsJCS8qIFByZXZlbnQgUE0gU2xl
ZXAgaWYgbm90IGluIFUzL0wyICovDQo+ID4+Pj4+Pj4+ICsJCWlmIChsaW5rX3N0YXRlICE9IERX
QzNfTElOS19TVEFURV9VMykNCj4gPj4+Pj4+Pj4gKwkJCXJldHVybiAtRUJVU1k7DQo+ID4+Pj4+
Pj4+ICsNCj4gPj4+Pj4+Pj4gKwkJLyogZG9uJ3Qgc3RvcC9kaXNjb25uZWN0ICovDQo+ID4+Pj4+
Pj4+ICsJCWR3YzNfZ2FkZ2V0X2Rpc2FibGVfaXJxKGR3Yyk7DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+
PiBXZSBzaG91bGRuJ3QgZGlzYWJsZSBldmVudCBpbnRlcnJ1cHQgaGVyZS4gV2hhdCB3aWxsIGhh
cHBlbiBpZiB0aGUNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBEdWUgdG8gc29tZSByZWFzb24sIGlmIEkg
ZG9uJ3QgZGlzYWJsZSB0aGUgZXZlbnQgaW50ZXJydXB0cyBoZXJlIHRoZW4NCj4gPj4+Pj4+IGFm
dGVyIFVTQiByZXN1bWUgdGhlIFVTQiBjb250cm9sbGVyIGlzIG1hbGZ1bmN0aW9uaW5nLg0KPiA+
Pj4+Pj4gSXQgbm8gbG9uZ2VyIHJlc3BvbmRzIHRvIGFueSByZXF1ZXN0cyBmcm9tIEhvc3QuDQo+
ID4+Pj4+DQo+ID4+Pj4+IFlvdSBzaG91bGQgbG9vayBpbnRvIHRoaXMuIFRoZXNlIGV2ZW50cyBh
cmUgaW1wb3J0YW50IGFzIHRoZXkgY2FuIHRlbGwNCj4gPj4+Pj4gd2hldGhlciB0aGUgaG9zdCBp
bml0aWF0ZXMgcmVzdW1lLg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+PiBkZXZpY2UgaXMg
ZGlzY29ubmVjdGVkIGFuZCByZWNvbm5lY3QgdG8gdGhlIGhvc3Qgd2hpbGUgdGhlIGRldmljZSBp
cw0KPiA+Pj4+Pj4+IHN0aWxsIGluIHN5c3RlbSBzdXNwZW5kPyBUaGUgaG9zdCB3b3VsZCBub3Qg
YmUgYWJsZSB0byBjb21tdW5pY2F0ZSB3aXRoDQo+ID4+Pj4+Pj4gdGhlIGRldmljZSB0aGVuLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IEluIHRoZSBUSSBwbGF0Zm9ybSwgVGhlIHN5c3RlbSBpcyB3b2tl
biB1cCBvbiBhbnkgVkJVUy9saW5lc3RhdGUgY2hhbmdlDQo+ID4+Pj4+PiBhbmQgaW4gZHdjM19n
YWRnZXRfcmVzdW1lIHdlIGVuYWJsZSB0aGUgZXZlbnRzIGFnYWluIGFuZCBjaGVjayBmb3IgcGVu
ZGluZw0KPiA+Pj4+Pj4gZXZlbnRzLiBJcyBpdCBwb2ludGxlc3MgdG8gY2hlY2sgZm9yIHBlbmRp
bmcgZXZlbnRzIHRoZXJlPw0KPiA+Pj4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gSXQgc2VlbXMgZnJh
Z2lsZSBmb3IgdGhlIGltcGxlbWVudGF0aW9uIHRvIGJlIGRlcGVuZGVudCBvbiBwbGF0Zm9ybQ0K
PiA+Pj4+PiBzcGVjaWZpYyBmZWF0dXJlIHJpZ2h0Pw0KPiA+Pj4+Pg0KPiA+Pj4+PiBBbHNvLCB3
aGF0IHdpbGwgaGFwcGVuIGluIGEgdHlwaWNhbCBjYXNlIHdoZW4gdGhlIGhvc3QgcHV0cyB0aGUg
ZGV2aWNlDQo+ID4+Pj4+IGluIHN1c3BlbmQgYW5kIGluaXRpYXRlcyByZXN1bWUgd2hpbGUgdGhl
IGRldmljZSBpcyBpbiBzeXN0ZW0gc3VzcGVuZA0KPiA+Pj4+PiAoYW5kIHN0YXkgaW4gc3VzcGVu
ZCBvdmVyIGEgcGVyaW9kIG9mIHRpbWUpPyBUaGVyZSBpcyBubyBWQlVTIGNoYW5nZS4NCj4gPj4+
Pj4gVGhlcmUgd2lsbCBiZSBwcm9ibGVtIGlmIGhvc3QgZGV0ZWN0cyBubyByZXNwb25zZSBmcm9t
IGRldmljZSBpbiB0aW1lLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBEb24ndCB3ZSBuZWVkIHRoZXNlIGV2
ZW50cyB0byB3YWtldXAgdGhlIGRldmljZT8NCj4gPj4+DQo+ID4+PiBUaGF0J3Mgd2h5IHRoZSBU
SSBpbXBsZW1lbnRhdGlvbiBoYXMgbGluZS1zdGF0ZSBjaGFuZ2UgZGV0ZWN0aW9uIHRvDQo+ID4+
PiBkZXRlY3QgYSBVU0IgcmVzdW1lLiBXZSBhcmUgZG9pbmcgYSBvdXQtb2YtYmFuZCB3YWtlLXVw
LiBUaGUgd2FrZSB1cA0KPiA+Pj4gZXZlbnRzIGFyZSBjb25maWd1cmVkIGluIHRoZSB3cmFwcGVy
IGRyaXZlciAoZHdjMy1hbTYyLmMpLg0KPiA+Pj4NCj4gPj4+IERvIHlvdSBrbm93IG9mIGFueSBk
d2MzIGltcGxlbWVudGF0aW9uIHRoYXQgdXNlcyBpbi1iYW5kIG1lY2hhbmlzbQ0KPiA+Pj4gdG8g
d2FrZSB1cCB0aGUgU3lzdGVtLiBpLmUuIGl0IHJlbGllcyBvbiBldmVudHMgZW5hYmxlZCBpbiBE
RVZURU4gcmVnaXN0ZXI/DQo+ID4+Pg0KPiA+Pg0KPiA+PiBXZSByZWx5IG9uIFBNRS4gVGhlIFBN
RSBpcyBnZW5lcmF0ZWQgZnJvbSB0aGUgUE1VIG9mIHRoZSB1c2IgY29udHJvbGxlcg0KPiA+PiB3
aGVuIGl0IGRldGVjdHMgYSByZXN1bWUuIElmIHlvdXIgcGxhdGZvcm0gc3VwcG9ydHMgaGliZXJu
YXRpb24gYW5kIGlmDQo+ID4+IHRoZSByZXN1bWUgc2lnbmFsIGlzIGNvbm5lY3RlZCB0byB0aGUg
bG93ZXIgbGF5ZXIgcG93ZXIgbWFuYWdlciBvZiB5b3VyDQo+ID4+IGRldmljZSwgdGhlbiB5b3Ug
Y2FuIHdha2V1cCB0aGUgc3lzdGVtIG9uZSBsZXZlbCBhdCBhIHRpbWUuIEZvciBleGFtcGxlLA0K
PiA+PiBpZiB5b3VyIGRldmljZSBpcyBhIHBjaSBkZXZpY2UsIHRoYXQgd2FrZXVwIHNpZ25hbCB3
b3VsZCB0aWUgdG8gdGhlIHBjaQ0KPiA+PiBwb3dlciBtYW5hZ2VyLCB3YWtpbmcgdXAgdGhlIHBj
aSBsYXllciBiZWZvcmUgd2FraW5nIHVwIHRoZSBjb3JlIG9mIHRoZQ0KPiA+PiB1c2IgY29udHJv
bGxlci4gVGhhdCdzIGhvdyB0aGUgaG9zdCB3YWtlcyB1cCB0aGUgaG9zdCBzeXN0ZW0gKGUuZy4g
ZnJvbQ0KPiA+PiByZW1vdGUgd2FrZXVwKS4gRm9yIHRoaXMgdG8gd29yaywgd2UgZXhwZWN0IHNv
bWV0aGluZyBzaW1pbGFyIG9uIHRoZQ0KPiA+PiBkZXZpY2Ugc2lkZS4NCj4gPj4NCj4gPj4+Pj4N
Cj4gPj4+Pg0KPiA+Pj4+IFdlIG1heSBub3QgYmUgYWJsZSB0byBzdXNwZW5kIGV2ZXJ5dGhpbmcg
aW4gc3lzdGVtIHN1c3BlbmQgZm9yIHRoaXMNCj4gPj4+PiBjYXNlLiBJJ20gdGhpbmtpbmcgb2Yg
dHJlYXRpbmcgdGhlc2UgZXZlbnRzIGFzIGlmIHRoZXkgYXJlIFBNRSB0byB3YWtldXANCj4gPj4+
PiB0aGUgZGV2aWNlLCBidXQgdGhleSBhcmUgbm90IHRoZSBzYW1lLiBJdCBtYXkgbm90IGJlIHNp
bXBsZSB0byBoYW5kbGUNCj4gPj4+PiB0aGlzLiBUaGUgbG93ZXIgbGF5ZXJzIG1heSBuZWVkIHRv
IHN0YXkgYXdha2UgZm9yIHRoZSBkd2MzIHRvIGhhbmRsZQ0KPiA+Pj4+IHRoZXNlIGV2ZW50cy4g
SG0uLi4gaXQgZ2V0cyBhIGJpdCBjb21wbGljYXRlZC4NCj4gPj4+DQo+ID4+PiBBcyB3ZSBhcmUg
Z29pbmcgaW50byBzdXNwZW5kLCB3ZSBhcmUgbm90IHJlYWxseSBpbiBhIHBvc2l0aW9uIHRvIGhh
bmRsZSBhbnkNCj4gPj4+IChERVZURU4pIGV2ZW50cyB0aWxsIHdlIGhhdmUgZnVsbHkgcmVzdW1l
ZC4NCj4gPj4+IFNvIHllcywgd2UgbmVlZCB0byByZWx5IG9uIHBsYXRmb3JtIHNwZWNpZmljIGlt
cGxlbWVudGF0aW9uIHRvIHdha2UNCj4gPj4+IHRoZSBTeXN0ZW0gb24gYW55IFVTQiBldmVudC4N
Cj4gPj4+DQo+ID4+DQo+ID4+IFlvdSBtYXkgYmUgYWJsZSB0byBkZXRlY3QgdmJ1cyBjaGFuZ2Ug
dGhyb3VnaCB0aGUgY29ubmVjdG9yIGNvbnRyb2xsZXIuDQo+ID4+IEhvd2V2ZXIsIHRoZSB1c2Ig
Y29udHJvbGxlciBpcyB0aGUgb25lIHRoYXQgZGV0ZWN0cyBob3N0IHJlc3VtZS4gV2hhdA0KPiA+
PiBwbGF0Zm9ybSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiBkbyB5b3UgaGF2ZSBvdXRzaWRlIG9m
IHRoZSB1c2INCj4gPj4gY29udHJvbGxlciBkbyB5b3UgaGF2ZSB0byBnZXQgYXJvdW5kIHRoYXQ/
DQo+ID4+DQo+ID4+IEknbSBub3Qgc3VyZSBpZiB5b3VyIHBsYXRmb3JtIHN1cHBvcnRzIGhpYmVy
bmF0aW9uIG9yIGlmIHRoZSBQTUUgc2lnbmFsDQo+ID4+IG9uIHlvdXIgcGxhdGZvcm0gY2FuIHdh
a2V1cCB0aGUgc3lzdGVtLCBidXQgY3VycmVudGx5IGR3YzMgZHJpdmVyDQo+ID4+IGRvZXNuJ3Qg
aGFuZGxlIGhpYmVybmF0aW9uIChkZXZpY2Ugc2lkZSkuIElmIHRoZXJlJ3Mgbm8gaGliZXJuYXRp
b24sDQo+ID4+IHRoZXJlJ3Mgbm8gUE1FLg0KPiANCj4gTm8sIGluIHRoaXMgVEkgU29DLCBoaWJl
cm5hdGlvbiBmZWF0dXJlIGlzIG5vdCBzdXBwb3J0ZWQgaW4gdGhlIGR3YzMgY29yZS4NCj4gDQo+
ID4+DQo+ID4gDQo+ID4gQWN0dWFsbHksIEkgdGhpbmsgdGhlIGR3YzMgY29yZSBpcyBzdGlsbCBv
biBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgZm9yDQo+ID4geW91IHJpZ2h0PyBUaGVuIEkgdGhpbmsg
d2UgY2FuIHVzZSB0aGUgd2FrZXVwIGV2ZW50IHRvIHdha2V1cCBzeXN0ZW0NCj4gPiBzdXNwZW5k
IG9uIGhvc3QgcmVzdW1lPyBZb3UgY2FuIGlnbm9yZSBhYm91dCBQTUUgaW4gdGhpcyBjYXNlLiBZ
b3UgbWF5DQo+ID4gbmVlZCB0byBsb29rIGludG8gd2hhdCBuZWVkcyBzdGF5IGF3YWtlIHRvIGFs
bG93IGZvciBoYW5kbGluZyBvZiB0aGUNCj4gPiBkd2MzIGV2ZW50Lg0KPiANCj4gQnV0IGluIFNv
QyBkZWVwLXNsZWVwIHN0YXRlLCBhbGwgY2xvY2tzIHRvIHRoZSBkd2MzIGNvcmUgYXJlIHN0b3Bw
ZWQuDQo+IFNvIEknbSBub3Qgc3VyZSBpZiBkd2MzIGV2ZW50cyB3aWxsIHdvcmsuDQo+IA0KDQpS
aWdodCwgeW91IG5lZWQgdG8ga2VlcCB0aG9zZSBjbG9ja3MgcnVubmluZyB0byBkZXRlY3QgaG9z
dCByZXN1bWUuDQpUaGVyZSdzIHN0aWxsIHNvbWUgcG93ZXIgc2F2aW5nIHRocm91Z2ggdGhlIGR3
YzMgY29udHJvbGxlcidzIGhhbmRsaW5nDQppbiBzdXNwZW5kLiBZb3UgbWF5IGhhdmUgc29tZSBs
aW1pdGVkIHBvd2VyIHNhdmluZyBmcm9tIG90aGVyIHN1c3BlbmRlZA0KZGV2aWNlcyBvbiB5b3Vy
IHNldHVwLiBIb3dldmVyLCBJIGRvbid0IHRoaW5rIHdlIGNhbiBleHBlY3QgdGhlIHBsYXRmb3Jt
DQp0byBnbyBpbnRvIGRlZXAtc2xlZXAgYW5kIGFsc28gaGFuZGxlIGhvc3QgcmVzdW1lLg0KDQpU
aGFua3MsDQpUaGluaA==

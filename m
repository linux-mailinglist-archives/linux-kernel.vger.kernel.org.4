Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77C6F1E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjD1Sdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbjD1Sdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:33:36 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA719B1;
        Fri, 28 Apr 2023 11:33:34 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SGrO2r023001;
        Fri, 28 Apr 2023 11:33:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=bOKmYte5s7ygiBMKeSUdmcDUtopssYt40CSSXDV+Nx0=;
 b=M6zqF0KLSzc0JJW3NfnfMbrwtuUdH3711fOZgQCM6945jLDWEpqrV8msiTVJ+kluteIE
 e/9I5o9ore3I0RbRixshYjynnAyY86csiTi/G9yVJbKQ2f656ZmCsaDd3P44Ikc9oK3u
 xAgHGvDjyjsH9p/SdfEyrD8Uv+8Ivrh+aEjEBxswPkIfeUXvxpaTlxR5a6ebnvAPembS
 1Eu3854LgRi5P4qjQkTP6HyfFL8F29flgbUuXgT7ttbVAfHJFQhoGfFrpqhDFyc80Iqc
 otYwkhdeKI8V31uZ5CzBiJiBhpgDckkRDKx58UCzWUguOb54AYfRGZpve3gujJAVYoN1 oA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q4yqpywhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 11:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682706807; bh=bOKmYte5s7ygiBMKeSUdmcDUtopssYt40CSSXDV+Nx0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=D8SQrTA8ypoCtTMVpQajDsSSlrVyScUeHPRnvtW8DoIbI3y/NO9G2Qn6lkwStEmz8
         7Sl12ts1c/CsNWmsIHPTrTBqO7pLSWB9NAJC+pmGRjoxPPG6cBlSXHQrZsXMISwKjZ
         dP6I7NEnk7g88L0V+8NkV0HfsM18a5T9/u1DGmhzYqZe+GVcrFcqHS/cIo3PvIcghL
         Fy9PfMe3tNn97q/fIldMzcStLXuUCvj72/TNgednn9Evg8mpjG4xQ7V1U56n0T5NBZ
         bxYZR7ObSyveVSa79g1d2ZnuUocF0Wxn+GHFdWJ+Cucz97kW4UjNNQS3Eao89+BCmv
         NaeiNubxwQoAA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8B6F840524;
        Fri, 28 Apr 2023 18:33:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2898AA009D;
        Fri, 28 Apr 2023 18:33:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MY+tRtbp;
        dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7314940703;
        Fri, 28 Apr 2023 18:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsE/v0tzp8/MstDEWUNc6beUhVnO3hnPTsEkDkFqgDu25S2DJzKDf45Xr149PTRzUHXwRCkJFuQUH9+3+U++SqE9/RQanjqXrUoL+MIrXzktGzT8Zf4sMFI1R/UIVlInmA4fNi/ImlASGwA0MZaBnQsBgZGf331aM7lasmyiitctHF7LxU2w6aiN2lkTOIIRQCrv4oehMosHMdn5OycSUJJfmR34nwSmJTkRcVcKA33Xb3RSwYCnvrwcgxFNs2YKnVkO+ntctxp97JYN8M2HQEKpMbsep9zke+iA8ap7kMf1i/cyYYaBefHSxqQLFzYYKoNovlf5HPcmE2kAlRsn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOKmYte5s7ygiBMKeSUdmcDUtopssYt40CSSXDV+Nx0=;
 b=T8+IHdi2WrQIKoooqBNBXXLnSHiDbjkcxWijt2C558uzezUdFWlkAGcDeB5UCAIqMdh+tJm5T0597YfP/fL8MaKcfqDaYfvD7OVlXRslu6StJT/gSz1plwDISv5rbO1CtWVJBJz/ucTIBPndKVtPtKjJ+ZDPEdos7poLGrLTv+2TEtfKthztS1F0Kqt7qO+Kl+y2rsXvgrnReO7AWR/eS0NWPfbb3ckvfscOWgLT3GXDo55iVv6WFKijC38Ua1eMu6ELkHHlkTB3WmLoSLg1xzWQ6AUYZO6EZbFoknuLGC7qyiPab4vghKaU3vualXaaNZlQiZbo2cCh3m3Lz248iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOKmYte5s7ygiBMKeSUdmcDUtopssYt40CSSXDV+Nx0=;
 b=MY+tRtbpWBwJx1/3p8drdZ5sa76OTQwoV6wNlSQN76X1cADzHbJPUMvI9owl0YdBx8HuMmEi+2iHfWrgLjJllAjOn0M7/M4KmxJlwaTTBjLX2CtMqdjRirDEpzMBQoBSQhW7F6AcCc8QdtQpCbEOQ1KjqXZ993b2OsWT5DS0rlw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Fri, 28 Apr
 2023 18:33:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 18:33:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dwc3 gadget: controller stop times out on system sleep
Thread-Topic: dwc3 gadget: controller stop times out on system sleep
Thread-Index: AQHZeFqc4s3gM7Yov0WTj+Z9vn7u3q8+Ax8AgAFWGYCAAGD/gIAA6GCAgABsgIA=
Date:   Fri, 28 Apr 2023 18:33:22 +0000
Message-ID: <20230428183317.seov4hdgewk7wjhv@synopsys.com>
References: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
 <20230426200140.xa4unnbaw2vog2je@synopsys.com>
 <dafed705-292e-6c03-7599-1b1374b95122@kernel.org>
 <20230427221315.nmvy32j6lfxlsmdk@synopsys.com>
 <83dfad53-b38e-54c9-0f90-8fe834a1bca6@kernel.org>
In-Reply-To: <83dfad53-b38e-54c9-0f90-8fe834a1bca6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MW4PR12MB7429:EE_
x-ms-office365-filtering-correlation-id: 01f8e3b7-fd80-477a-3cca-08db48170c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWrfhZ85MRaLtTLqaewXhx0Prx7XSaeKVKqUDBRjT9ipwhSs6m0xY3vyqXYpttNy/TEo91VFusnPpl12k6lGBbpJUNVBZ5YOL1KVi1ry0lXKiJcIieEeLSWW1RuQUSeEQPSQW0erLAXVPgswGvln6Mq5RYceD/ti0FpdFC+bP6Ka/R4xKA4LAejg1omXGGNlvHlTqTwGMwiOH9NiTiZssf7beYYQX1hj3NsZRdijqbcNb5FS+uI8tnUKbRX8tjSJZzdYSN9JLaINtH8I+JmTEgYehfBsxKoW8gVyBOIehJspneXEMVLVP3e0QkAOMT9HskNUE9NNsVN4dxEoDoB/PbcLI0obZS90jEHS2hfcF0KAfWuayCvWMPbazbpkbdEB8ds8cmex0EWPcwuHpPEri8wRWqsh0JEQog5//1Mfr5HvJS90zPXBxdlpNaFFUbXpP95OH9Qs6DofC02s8mcADlT+GxNemudG0mdVTVPE793ajrKsfISuSsblVqjv0lG5/w7tP90vVynzzrppdxDNl9D8SqiJAmnyl5DcjFkTUaMoFX1T4tjRUJZEernGTtzrZ9xhJ//fMu4xNyOlDZ3pv5RnO3OjYBjlMYVIrz78SzHXQc4pGxs2s5cYgJrOxJBL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(86362001)(36756003)(2906002)(38070700005)(66476007)(5660300002)(6512007)(2616005)(71200400001)(83380400001)(53546011)(26005)(1076003)(478600001)(76116006)(64756008)(6486002)(6916009)(66556008)(66946007)(66446008)(6506007)(8936002)(122000001)(316002)(41300700001)(4326008)(54906003)(8676002)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEsxbVNZQXdhT0xEQlRYczR0cFNTSVBnSEdkcGo1YUJFY0pNa3Z5dEloL3lz?=
 =?utf-8?B?eDUxSFM4UlZ2dFJKZzlWMytUb0hFdDlhQlYvQUxOckNXSDdqUUY3VkQ3Zzgx?=
 =?utf-8?B?U2FRMHo3VlQwOURHMmJjSW5PVDU1ZUxaS1F4d2Ruc2RUcG43U3owS3N1K2JW?=
 =?utf-8?B?V20wSzk4MCt6MmtBWWE5VHBnNytkZjY5anRvemJlVWYyanNUUlZsQVJCMk96?=
 =?utf-8?B?ZHd1RXNkV0s4UW42UlRVK1NZTXpEWFNvWG9CNDJhSmFvb1puV2FOK2YxakRW?=
 =?utf-8?B?dW5nN3Q4WSs0MlBJOWhSNk9VWDAxeDdxN3M1Tk5SVk5NZFRoOUwxRy93M2Vq?=
 =?utf-8?B?Q0F3MDJ6V1JyMWtzN0Y4aGVIRUhRN0w1ZUxXUUY2OEVZNW9pSVY1Vkh1SkxD?=
 =?utf-8?B?RnprcTNMSVJPS1hFS09DWXdnd0VNcjRRV2tVSEdDTHpZVHlqUjR3S2VaOTgr?=
 =?utf-8?B?M2JZVE55cWZjellLcFpVS1pRRjJ2VmpKK1RHeVppWEFqN3FwQ0NDTVI1Tmp5?=
 =?utf-8?B?WUgxVlFsa1BSV2hJVkF1MERtUlpXRHFaMDZ5Q211dmh6em5jZDVwa0h3SHcr?=
 =?utf-8?B?MG1sOUN6RDBjVGFFaUoxemRzdGtDbk5weklwSElyRzNyN2F3WDBWQUxKTzE3?=
 =?utf-8?B?UjE1NGlkcGpsNUxBdlhtYm05eW96VUFyc0RNZWVuOWNkQ1hxNzE4V1VMREQy?=
 =?utf-8?B?SitaZlhHRnNQRS91ZHFRL3BPUzdmV3UxY2dlWHBMWm5OMGVtdG9sR2VRUUcr?=
 =?utf-8?B?RmRER1J5c1RFYzJzWG55a0owazdWSzU4MTBVSjV1enBDbUJhOGRQVmZUN0xa?=
 =?utf-8?B?eUlTeUg3V3RvNFhUREN2cWhBbFluTEJRTHJFUFkxQXFlLytxZ0Y0NTJPbndO?=
 =?utf-8?B?YU9aYXRoMXJ5c3d4dmFTVFUyaHVxYzVPcmNUTGlsS3JJc1ZzVVh6aDVtTEl5?=
 =?utf-8?B?ZVU1cFVtWkhwZzYwZHlaVGUvMUpQdStieUV4UVBMV2pEcDh4ZWRkdzR6Znlz?=
 =?utf-8?B?dUVLYlFKMEFXa3dBRnhyNzhKelRBQWF5dkNRcVdGMit5aW4veE5BUEdack9S?=
 =?utf-8?B?YW1UNExSS2xPRkRVMTV2a1FoNnBybHNmYytqMUlQKzdjL0NYazBmS2d1TkpF?=
 =?utf-8?B?R2RGdGpla3lQWGJNSUxaMzlJTWI0aGVYUlV4aTBSS24rYWZMWTlKQnV4TEt5?=
 =?utf-8?B?Q2Uyb05XVWFqS0hSak1rV2g3eWlKeXFSREl0cnBXMzM5bVZOVnRqSVEzMHBY?=
 =?utf-8?B?bGhucFJkZytDQ3B1ak04TUptV2tQNmJPdUlnZHVSUHBXZGhCVWltQnpiVWVz?=
 =?utf-8?B?bjZzN1A1ZUdlWjhNWHM4dEt2SHJrTmQwVElTWjlsSVRvMnVHdE5nZnZKbDhY?=
 =?utf-8?B?alp0VnhrOWs2YUFMK1ZMTFl5bHd5QjZpRjdaU2ZxdU0yMHRHN09nMDJMN1Rv?=
 =?utf-8?B?eGFkQ0c2QUpGcWJiWTgySUZLanl0SDhNRUgvWmpDUmgzbndUYXgxcGtmeFlL?=
 =?utf-8?B?K2lnM3pvV2ZJSjl4d25RRHc3UloxR2tuQ0IrZ1BDVjhqeDcybEtjeUVwTjJ6?=
 =?utf-8?B?SGRpRTRGMDl2VkVkNWZXcGx4OWVad1B2WENyMngvNlErZVJaaE14Uk9LR0Fx?=
 =?utf-8?B?S1A4R2ZCNWtoeFlxYmw3WHpVRG92SUxleUxzbXZoZS91TU5kL3FjV0MyVXI4?=
 =?utf-8?B?eUFWaXVrbkYxNjlERmU1Q3prT1JzRFVySUFRTSs5ZVUyMFNkOFBhRG1FaDdZ?=
 =?utf-8?B?SWQ4U3hFV3NVa3FkUzZDZlJFWlAzckxGU3cxcmtYUHZBK0tETVZ6WHcvalhP?=
 =?utf-8?B?ZmdENGdNVWlXSW1JRjlaQjdZRU5WYnIyeWhZb0NlOXJWREk2SjZ0Rmsrdm1E?=
 =?utf-8?B?WXlBV1REV1FITm5ZNUl1UjBTN3Y2ZWxLMlN1V2lUYVk2ZGdObHlrNmQrcCs5?=
 =?utf-8?B?a3hUbi9CaUY4bnVpeDZaMURPTFpnRTIvaTJ3ZFgvc0dudTFyaEg3YVhkYkMv?=
 =?utf-8?B?RmI4aXFiSlIzVm9RV2xhcW5rMTVvT2FwcllDSjZseEk3T3NzK0lQY2pTaURF?=
 =?utf-8?B?NGt6OHBZdVNoS0ZTYVRTWHBpNkpIYjc2UFhjNUNkaGF2ZkVmSkloWjhUREJD?=
 =?utf-8?Q?iRtl+RwQ1BE0+cIyyjETBg0Xz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52A6CA152F97B8458668714A6670C5C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x8N5ageM/4Ch43ABohBRALG+uNflRDvbjj8PTdJ+lhgu3wTdJCxB8prDXDpqKWFkqmUV0X4LPMlvFMR9aiEiPXo/vNRUyVzH+krHG1KBMeQbpajPsDjK8+ri25Z1fc10djjMLJTtUfCHQY1YAofIV8VBetS4jC31I8ISpiViLX57I2CDmv1fJ47+p0PTtNkXetp/zQPNfm5dVFOir8+vqjgm0mWm6mTX3niIEQFfb344rehXkRBbfLQxy0ZyENEV6qfVhPCzFILYQG0WqLVVqNfj/84cL5AOSZ1kOXmn5zbTt80yGbYjECwI2ADTXa4mf9tOzFF05dSoERC15lf5qAnVBL2vg2cGfembngidcfQplWetF1cRneefjQnVyK9o8sURn7V1ZwzwRAgICqQnXVBi0AZm+/gWBO24HCaeYumCNhj7a7tQI5YKNPvXgUBEVgf8jWzEKnFjPnLVEbZkIz1da3FqVrEqus8QWI8engM4TvrSL13YqfZuibpPUEg84L6nWAeBH3RhZbMWZ8VhN0MU3y6848BwYp1Me5MH3aHLzvudk21PPoFkKdvnqUX6SeH9qQq2Pb8vRTQypxvcUDzAf+LPtsgIng8jnsvClh2q1ncLq4i7CAlAEKUC9Kdsxj2txreyh7uT6Boat0yXFwDogaZsEVfXoRoSXtrP1MvTGcSD1XDhYW/nU1Tdkmk87ODywxTzNe3eLGIt0+dehfCaw2F04gep5aPhRSrSdSt0RE+3hn8bc6/YqxqqbTzqiKGxfUlTHQo3b232kADj9P60hXWmDJ4vraqV4mM+irXif9ESe+4e0q/plX4TVbyZjFplhVjdIOiHaqA0Ts+eUQ3x3JptxmNYwmf8Ye73FfoLGrjjFhQg283L6MLBAbit
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8e3b7-fd80-477a-3cca-08db48170c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 18:33:22.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoWtl7PaB06fCpAfoRyJiazektA6s3IND68G0moURVLo6+QLvq2JuC+MekyW4bvOFHzgdDZavYuCvjAaB7n1cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
X-Proofpoint-GUID: Mh338VcHeWXxiDWeOM6BQdX2F_mn2FAt
X-Proofpoint-ORIG-GUID: Mh338VcHeWXxiDWeOM6BQdX2F_mn2FAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMjgsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IA0KPiANCj4gT24g
MjgvMDQvMjAyMyAwMToxMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFRodSwgQXByIDI3
LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gT24gMjYv
MDQvMjAyMyAyMzowMSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+Pj4gSGksDQo+ID4+Pg0KPiA+
Pj4gT24gV2VkLCBBcHIgMjYsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4+Pj4gSGkg
VGhpbmgsDQo+ID4+Pj4NCj4gPj4+PiBPbiBMaW51eCBrZXJuZWwgdjYuMw0KPiA+Pj4+IFRlc3Qg
cHJvY2VkdXJlOiANCj4gPj4+Pg0KPiA+Pj4+IC0gbW9kcHJvYmUgZ196ZXJvDQo+ID4+Pj4gLSBD
b25uZWN0IHRvIFBDIGhvc3QNCj4gPj4+PiAtIHN5c3RlbWN0bCBzdXNwZW5kDQo+ID4+Pj4NCj4g
Pj4+PiBBIGxhcmdlIGRlbGF5IG9mIDMgc2Vjb25kcyBpcyBvYnNlcnZlZC4gVGhlIGRlbGF5IGNv
bWVzIGZyb20gZHdjM19nYWRnZXRfc3VzcGVuZCgpLT5kd2MzX2dhZGdldF9ydW5fc3RvcCgpIHdh
aXRpbmcgZm9yIERXQzNfRFNUU19ERVZDVFJMSExUIHRvIGJlIHNldC4NCj4gPj4+PiBJdCByZXR1
cm5zIC1FVElNRURPVVQuDQo+ID4+Pj4NCj4gPj4+PiBBcmUgd2UgbWlzc2luZyBzb21ldGhpbmcg
dG8gZG8gYSBjbGVhbiBzdG9wIGR1cmluZyBzdXNwZW5kPw0KPiA+Pj4+DQo+ID4+Pj4gRllJLiBV
bmxvYWRpbmcgZ196ZXJvIGRvZXMgbm90IHNob3cgdGhpcyBkZWxheSBvbiBzdG9wLg0KPiA+Pj4+
DQo+ID4+Pj4gY2hlZXJzLA0KPiA+Pj4+IC1yb2dlcg0KPiA+Pj4NCj4gPj4+IFdoZW4gY2xlYXJp
bmcgcnVuX3N0b3AgYml0IGFuZCB0aGUgY29udHJvbGxlciBkb2Vzbid0IGhhbHQsIHRoYXQgdXN1
YWxseQ0KPiA+Pj4gbWVhbnMgdGhlcmUgYXJlIGFjdGl2ZSB0cmFuc2ZlcnMvZW5kcG9pbnRzIHRo
YXQgYXJlbid0IGVuZGVkIHlldC4NCj4gPj4+DQo+ID4+PiBUaGUgZHdjM19nYWRnZXRfc3VzcGVu
ZCgpIGRvZXNuJ3QgcHJvcGVybHkgZG8gYWxsIHRoZSBjbGVhbnVwIGJlZm9yZQ0KPiA+Pj4gY2xl
YXJpbmcgdGhlIHJ1bl9zdG9wIGJpdC4gSSB0aGluayB5b3UganVzdCBuZWVkIHRvIGNhbGwNCj4g
Pj4+IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpIGluIGR3YzNfZ2FkZ2V0X3N1c3BlbmQo
KSB0byBmaXggdGhpcy4NCj4gPj4NCj4gPj4gVGhhdCBzZWVtcyB0byBkbyB0aGUgdHJpY2suDQo+
ID4+IEhvdyBkb2VzIHRoaXMgbG9vaz8NCj4gPj4NCj4gPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0gZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+PiBAQCAtNDY3NCwxMSArNDY3NiwxOCBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3Ry
dWN0IGR3YzMgKmR3YykNCj4gPj4gIGludCBkd2MzX2dhZGdldF9zdXNwZW5kKHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ID4+ICB7DQo+ID4+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4gKwlpbnQg
cmV0Ow0KPiA+PiAgDQo+ID4+IC0JaWYgKCFkd2MtPmdhZGdldF9kcml2ZXIpDQo+ID4+ICsJaWYg
KCFkd2MtPmdhZGdldF9kcml2ZXIgfHwgIWR3Yy0+c29mdGNvbm5lY3QpDQo+ID4+ICAJCXJldHVy
biAwOw0KPiA+PiAgDQo+ID4+IC0JZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSwgZmFs
c2UpOw0KPiA+PiArCXJldCA9IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KPiA+
PiArCWlmIChyZXQpDQo+ID4+ICsJCWdvdG8gZXJyMDsNCj4gPj4gKw0KPiA+PiArCXJldCA9IGR3
YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gPj4gKwlpZiAocmV0KQ0K
PiA+PiArCQlnb3RvIGVycjE7DQo+ID4+ICANCj4gPiANCj4gPiBXZSBhbHJlYWR5IGNsZWFyIHJ1
bl9zdG9wIGluIGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpLg0KPiA+IA0KPiA+IENhbiB5
b3UgdHJ5IHRoZSBmb2xsb3dpbmcgY2hhbmdlIChub3QgdGVzdGVkKToNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gPiBpbmRleCBjMGNhNGQxMmY5NWQuLjI5OTZiY2I0ZDUzZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+IEBAIC0yNjk5LDYgKzI2OTksMjEgQEAgc3RhdGljIGludCBkd2MzX2dh
ZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgCXJldHVybiByZXQ7
DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBpbnQgZHdjM19nYWRnZXRfc29mdF9jb25uZWN0
KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBJbiB0aGUgU3lu
b3BzeXMgRFdDX3VzYjMxIDEuOTBhIHByb2dyYW1taW5nIGd1aWRlIHNlY3Rpb24NCj4gPiArCSAq
IDQuMS45LCBpdCBzcGVjaWZpZXMgdGhhdCBmb3IgYSByZWNvbm5lY3QgYWZ0ZXIgYQ0KPiA+ICsJ
ICogZGV2aWNlLWluaXRpYXRlZCBkaXNjb25uZWN0IHJlcXVpcmVzIGEgY29yZSBzb2Z0IHJlc2V0
DQo+ID4gKwkgKiAoRENUTC5DU2Z0UnN0KSBiZWZvcmUgZW5hYmxpbmcgdGhlIHJ1bi9zdG9wIGJp
dC4NCj4gPiArCSAqLw0KPiA+ICsJZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdjKTsNCj4gPiArDQo+
ID4gKwlkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoZHdjKTsNCj4gPiArCV9fZHdjM19nYWRnZXRf
c3RhcnQoZHdjKTsNCj4gPiArCXJldHVybiBkd2MzX2dhZGdldF9ydW5fc3RvcChkd2MsIHRydWUp
Ow0KPiANCj4gcmV0dXJuIGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgdHJ1ZSwgZmFsc2UpOw0K
DQpZb3UgbmVlZCB0byByZWJhc2UgeW91ciBjaGFuZ2UgdG8gR3JlZydzIHVzYi1uZXh0Lg0KDQo+
IA0KPiA+ICt9PiArDQo+ID4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1
c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkd2MzCQkqZHdj
ID0gZ2FkZ2V0X3RvX2R3YyhnKTsNCj4gPiBAQCAtMjczNywyMSArMjc1MiwxMCBAQCBzdGF0aWMg
aW50IGR3YzNfZ2FkZ2V0X3B1bGx1cChzdHJ1Y3QgdXNiX2dhZGdldCAqZywgaW50IGlzX29uKQ0K
PiA+ICANCj4gPiAgCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiA+ICANCj4g
PiAtCWlmICghaXNfb24pIHsNCj4gPiArCWlmICghaXNfb24pDQo+ID4gIAkJcmV0ID0gZHdjM19n
YWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+ID4gLQl9IGVsc2Ugew0KPiA+IC0JCS8qDQo+
ID4gLQkJICogSW4gdGhlIFN5bm9wc3lzIERXQ191c2IzMSAxLjkwYSBwcm9ncmFtbWluZyBndWlk
ZSBzZWN0aW9uDQo+ID4gLQkJICogNC4xLjksIGl0IHNwZWNpZmllcyB0aGF0IGZvciBhIHJlY29u
bmVjdCBhZnRlciBhDQo+ID4gLQkJICogZGV2aWNlLWluaXRpYXRlZCBkaXNjb25uZWN0IHJlcXVp
cmVzIGEgY29yZSBzb2Z0IHJlc2V0DQo+ID4gLQkJICogKERDVEwuQ1NmdFJzdCkgYmVmb3JlIGVu
YWJsaW5nIHRoZSBydW4vc3RvcCBiaXQuDQo+ID4gLQkJICovDQo+ID4gLQkJZHdjM19jb3JlX3Nv
ZnRfcmVzZXQoZHdjKTsNCj4gPiAtDQo+ID4gLQkJZHdjM19ldmVudF9idWZmZXJzX3NldHVwKGR3
Yyk7DQo+ID4gLQkJX19kd2MzX2dhZGdldF9zdGFydChkd2MpOw0KPiA+IC0JCXJldCA9IGR3YzNf
Z2FkZ2V0X3J1bl9zdG9wKGR3YywgdHJ1ZSk7DQo+ID4gLQl9DQo+ID4gKwllbHNlDQo+ID4gKwkJ
cmV0ID0gZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KGR3Yyk7DQo+ID4gIA0KPiA+ICAJcG1fcnVu
dGltZV9wdXQoZHdjLT5kZXYpOw0KPiA+ICANCj4gPiBAQCAtNDY1NSw0MiArNDY1OSwzOSBAQCB2
b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgaW50IGR3YzNfZ2Fk
Z2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgew0KPiA+ICAJdW5zaWduZWQgbG9u
ZyBmbGFnczsNCj4gPiArCWludCByZXQ7DQo+ID4gIA0KPiA+ICAJaWYgKCFkd2MtPmdhZGdldF9k
cml2ZXIpDQo+IA0KPiBXZSBuZWVkIHRvIGNoZWNrIGZvciBkd2MtPnNvZnRjb25uZWN0IGhlcmUu
IElmIGl0IGlzIG5vdCBzZXQgdGhhdCBtZWFucw0KPiBjb250cm9sbGVyIGhhcyBhbHJlYWR5IHN0
b3BwZWQgc28gd2UgY2FuIHNpbXBseSBleGl0Lg0KDQpUaGF0IG1ha2VzIHNlbnNlLiBQZXJoYXBz
IHRoYXQgY2FuIGJlIGEgc2VwYXJhdGUgY2hhbmdlPw0KDQo+IA0KPiA+ICAJCXJldHVybiAwOw0K
PiA+ICANCj4gPiAtCWR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UpOw0KPiA+ICsJcmV0
ID0gZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+
ICsJCWdvdG8gZXJyOw0KPiA+ICANCj4gPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ss
IGZsYWdzKTsNCj4gPiAgCWR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4gPiAtCV9fZHdj
M19nYWRnZXRfc3RvcChkd2MpOw0KPiA+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5s
b2NrLCBmbGFncyk7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnI6DQo+
ID4gKwkvKg0KPiA+ICsJICogQXR0ZW1wdCB0byByZXNldCB0aGUgY29udHJvbGxlcidzIHN0YXRl
LiBMaWtlbHkgbm8NCj4gPiArCSAqIGNvbW11bmljYXRpb24gY2FuIGJlIGVzdGFibGlzaGVkIHVu
dGlsIHRoZSBob3N0DQo+ID4gKwkgKiBwZXJmb3JtcyBhIHBvcnQgcmVzZXQuDQo+ID4gKwkgKi8N
Cj4gPiArCWlmIChkd2MtPnNvZnRjb25uZWN0KQ0KDQpJZiB3ZSBjaGVjayBkd2MtPnNvZnRjb25u
ZWN0IGF0IHN0YXJ0LCB3ZSBjYW4gc2tpcCB0aGUgY2hlY2sgaGVyZS4NCg0KPiA+ICsJCWR3YzNf
Z2FkZ2V0X3NvZnRfY29ubmVjdChkd2MpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4g
IH0NCj4gPiAgDQo+ID4gIGludCBkd2MzX2dhZGdldF9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykN
Cj4gPiAgew0KPiA+IC0JaW50CQkJcmV0Ow0KPiA+IC0NCj4gPiAgCWlmICghZHdjLT5nYWRnZXRf
ZHJpdmVyIHx8ICFkd2MtPnNvZnRjb25uZWN0KQ0KPiA+ICAJCXJldHVybiAwOw0KPiA+ICANCj4g
PiAtCXJldCA9IF9fZHdjM19nYWRnZXRfc3RhcnQoZHdjKTsNCj4gPiAtCWlmIChyZXQgPCAwKQ0K
PiA+IC0JCWdvdG8gZXJyMDsNCj4gPiAtDQo+ID4gLQlyZXQgPSBkd2MzX2dhZGdldF9ydW5fc3Rv
cChkd2MsIHRydWUpOw0KPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gLQkJZ290byBlcnIxOw0KPiA+
IC0NCj4gPiAtCXJldHVybiAwOw0KPiA+IC0NCj4gPiAtZXJyMToNCj4gPiAtCV9fZHdjM19nYWRn
ZXRfc3RvcChkd2MpOw0KPiA+IC0NCj4gPiAtZXJyMDoNCj4gPiAtCXJldHVybiByZXQ7DQo+ID4g
KwlyZXR1cm4gZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KGR3Yyk7DQo+ID4gIH0NCj4gPiAgDQo+
ID4gIHZvaWQgZHdjM19nYWRnZXRfcHJvY2Vzc19wZW5kaW5nX2V2ZW50cyhzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiANCj4gRXZlcnl0aGluZyBlbHNlIGxvb2tzIG9rLiBJIHdpbGwgc2VuZCBhIHBhdGNo
IHNvb24uDQo+IA0KDQpUaGFua3MsDQpUaGluaA==

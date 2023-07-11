Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30E74FA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjGKVtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGKVtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:49:00 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D951731;
        Tue, 11 Jul 2023 14:48:54 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BKf3Oi008609;
        Tue, 11 Jul 2023 14:48:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ZwrJpcoBM6Aj/MuDjHHfi5/v3B7ZXFvb2C3iJNcZU04=;
 b=MwWvmoKO8pkplSB6Y53UQ4KR5ix4QN5C4n+PHM7I7yhqnmemeHwE5pQFFb7v9zwnF5dw
 igdz2lrLWBYKe0a9+2auNw4ZLTLcOs7GJuJh8FzQ5YQUjNtGBOHc5XELZR+lHx3pHhKk
 7W9/T/IojAZTFlWlQ4CSL1KI3FQ9vPoV5SzQ8IdSLb9SBZCj/YjZS3p4tKEA20mu96x8
 Fqby2cEm6vF77dXydMuqu1BE3m7QXsxCzds7zRl/SBWYaN2uBq3+d40V0Li0g4ZDVGr0
 HruNkajAx/WIpmLcfgnxz9pvm5DhkGZt7w7iE12sF4YHKSISin6df7KWEg3IH3GW3MeY mA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rq6tmnavy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:48:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689112125; bh=ZwrJpcoBM6Aj/MuDjHHfi5/v3B7ZXFvb2C3iJNcZU04=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Lluylzdd3rc1n5QtU1n0OC+K5PFqif0zznoyvdbuBYJzuj0f8a5HAxAk5GYZ0l7IV
         BGhVWeC34BJJVt/1C83aWmUzwQljQL3dLc4jR5757D90dOC3o3Iue7m7cc5maPPlpk
         fb7dGoZ5iaVUDSQ/9aNUDewEy8de8ztFFobvcyxMzNYI6lF9MvwjsAiz2GJy67R6dk
         yPuZesFEdU+VF7wgn1HhHFJ8mVwmvqIIGhd+c+N2H0b6fsBO02vEjlE6CnpnNzq3AC
         JEHw6jlnVFojPhi0BV08KcD7k85TGaTfFFko4bUTM8SUxUNocQ63vwOMmGiSxJReF+
         1eGclOVK82rLg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C8AC40638;
        Tue, 11 Jul 2023 21:48:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7CD09A008A;
        Tue, 11 Jul 2023 21:48:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kmVx6HTs;
        dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 38B3840236;
        Tue, 11 Jul 2023 21:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7WA9tr1BQvN20r32NwRJlZIyK1AYQylzViVL0KEtqkk75hBTEKG2zUOQ7ayjqpUyxP1FxJ+JKwTloYXiQTY5grnPL5v09B8HzKkZ7cajr6cZqrewkOREM8nJPFXpme0wjihcLj3I4Jl1S+scyTBhPYeu9rT4AbppOnmgrC6/JfvGbNQh0Q7Yp7/YUsJmcwzmOjWH7uXguLmLhy5uK3mBgrZ3hJaIxWWVLRUW6/wOEJMDHRdsEYbr0zOowf2cq6SqEBntEZZYP/fQepAvt71y0Yo/9zHRXt4eKgVWWqJzF1gn9xT8jv4NbKRUNPcsV/0MSEubTdMiCTY6JSOx97thA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwrJpcoBM6Aj/MuDjHHfi5/v3B7ZXFvb2C3iJNcZU04=;
 b=BxUTF8abU+WjpB9S5Jzc7eKSAxDmZcGynlztCe+rS8x9jB6Q95myAfIRYGsu0wgrC1Qc3obcsPCsiiv83MZ7wjL6KEuweNO8cE7DCfFk8V1G5Da+kie6jQKCRSGjzEfXd8XAbAn59M/FjYueFbjQPco3VZeXuwKQlLd2IcVElyDOIYP6E44hYflTgWmwR/5Z55V9k9RfQpIktqF4Ap91KkVcOoE2wPQONBz4fXF/fjejczx4dAk1JaL9zQ4HJevPjXa/z26BaB4kNYKFuBK/wzHZ/onYZsLESH8Nw49najkRVG+o/oZJoZtHcg9DnLcmeVxbYAuCsAeoToiLOyMsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwrJpcoBM6Aj/MuDjHHfi5/v3B7ZXFvb2C3iJNcZU04=;
 b=kmVx6HTsZ8NpbvxxsdQA9gZ3ZWOqK0Ha45kxVnsq0qb3ZYh8sF/Yd8MgVZWYxc9G00bK0yA+EO4ZsmvhuvhJsrQFg5G5E1UloTjk2cEv5HEH1/PGO86XVa7lW7ktksnWUBC16BKUEhRvCECuXlrHy5eAWVcALCFp9sydnLLzohI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 21:48:38 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 21:48:38 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?SmFrdWIgVmFuxJtr?= <linuxtardis@gmail.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
Thread-Topic: [PATCH] usb: dwc3: Disable AutoRetry controller feature for
 dwc_usb3 v2.00a
Thread-Index: AQHZq6N8Rx/zK10gr0O1P8J0n8tAsq+rzjEAgAEZboCACEP7AA==
Date:   Tue, 11 Jul 2023 21:48:37 +0000
Message-ID: <20230711214834.kyr6ulync32d4ktk@synopsys.com>
References: <20230630223638.2250-1-linuxtardis@gmail.com>
 <20230705224754.zmffebz2geg3bclh@synopsys.com>
 <d4576e776d49498dcc1f82ddf2b81b415e0c6e4b.camel@gmail.com>
In-Reply-To: <d4576e776d49498dcc1f82ddf2b81b415e0c6e4b.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB9179:EE_
x-ms-office365-filtering-correlation-id: 06ec1ef0-6a4a-4b82-ba16-08db82589560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ErGHnW9pNEwt6U+sWW5zRmbFrMYnG3ALjlPxTb515zBwWZs1+zjKCgtwLfsn2xOd610YPcl7mf3ZvimlwW/W6T2FPIzw8+m4elKR1yXvyeUjwJw7ULspdv+Z5kyAkPJl0g8tbguqK9MOz54pEAkpPgInl2PtQ6hLXL7SEQDj7hvM+7KEWUznykDcP3Yr7pCwj1qxmXVmEf36lcTbkgj7ivJiHat/cbcvhzae/YWYxSCY7ON0c5kKP4ewBealI9S1wfeRpE7AeKlE1+DjP/z9jm3f5EnrEKiA//bzAvqztzzgAZiz02KnCBH2ZpIAn62Zrn34P+DobB1DGwsus52WYzRhbRolVxzf/h1cILmoCuhz4ksNLbzKxI+OvTFKubNV5qRM/dA2/JEpc/VHCmnyL9kPUCTx1Ttembm3WlTqs7gcKv4ga6m4v9M39eQH75nUaOael9jYDnXr3grGfP+vjtbIH65lxwQmkiuDhvH/HLMB4syNkQfIAGbxSJaTtTui0sq7lmp5u+e5YEtTvCJHZcKKekEZ9ASSE8INB6XWQD2Nbc/s8x6UjUff0Oac49KCP9T45PLmdlxE8skt6hz1sOhLWB7LCYxPYFYowPnEjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(71200400001)(966005)(6512007)(316002)(6486002)(54906003)(4326008)(122000001)(76116006)(38070700005)(38100700002)(16799955002)(478600001)(36756003)(2906002)(66556008)(64756008)(66476007)(66446008)(66946007)(6916009)(2616005)(83380400001)(66574015)(5660300002)(8676002)(8936002)(186003)(41300700001)(86362001)(26005)(6506007)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3ZLdWN3ZkIrVjJSMWQ3T1lPVDk2MGtQeDFyYkE0Tjg5bmJsUFdYYUpINWdl?=
 =?utf-8?B?SHdWRzdZMlVFanhmclJQUEdiQmVDTjZQMHdkeGhtNlhLNzVZb1AraWIzS3Rq?=
 =?utf-8?B?TURZNzdMaVEydWx1QWZKVzRWVC96YSt3Q0NuMTZWVTZNMkcyVmIyaU5YanB3?=
 =?utf-8?B?WlRvNFFYc21TMTdidGUwUm9xd1dBeHh6enJ2eUxTR2pHOVNBcVZvdUhnb1dB?=
 =?utf-8?B?dGNlTDNQUzhOYnQvK2UwaXFJTTlFSTk0MGFjb0hnNytXaTdSaXZxUkVSNldU?=
 =?utf-8?B?VktJNGxvekJURS9hd0lLMjZLVThxMk5xSXhpa2hnR1J5V3BCUTNlNUJLaTBm?=
 =?utf-8?B?WTRoOVFDOEl3bkk0dzVsOUNjT1I3RGRNcFhoRHRLWXYwQW50K2tXS29DM04x?=
 =?utf-8?B?a0FWcytmemJHdGhETWdDWkRndU11SkpzRXZoUEtGQ1lhOUx5RzdHZDhtQzhi?=
 =?utf-8?B?TDdObzk3MXdsZUtZMGtZSFIzSUV3SDZXc1pCMkhjcmNKbWpkR1RnZ0phZ3VR?=
 =?utf-8?B?VHliK1VZRUJWaVpTTXZWQ1RjRkQxN3NYdlZFSy8rcS9ia3BZVHNLK3RiYWM1?=
 =?utf-8?B?b0xnOXhJRjhhSHU2aWVQU1FyekFyWXd6c3NqZG9jMDB4bzg3bGxTYjJoRnF5?=
 =?utf-8?B?ZWFTL2VkWVprUGVVaFZicGV1WVhia0JWcFJxMG1JNS9YVWZ0NTYzRjdGNERI?=
 =?utf-8?B?TVBCR3FZeHk1aDJFUGtnK1N2cUxsWUNVNGN6SjAwYlJKcHhVRkVoTHlxd0pE?=
 =?utf-8?B?SExWRXhFbWppbkdYZUd6NkJSd3llNkhEcCtmajFXUGtUelRaY1M0czFZNENy?=
 =?utf-8?B?Uk15Z0hGR2EybDhxckRMOW56RU1mdm1RMG8wUnBZYkc0SkN6OVQ3bFpMODZL?=
 =?utf-8?B?dWxPRkpibW80KzVCNXM2OVZlV3lLdzJmUk1OVlhkN3d2MmFGR3FmNVRUbmxv?=
 =?utf-8?B?TXpyYzg3QTREaitRRCtOMzhqeTkxRUZMUVlKcStvZkYrWHI4ZURPWFI3REV4?=
 =?utf-8?B?L1grMGswaDdVSzNlV25iclNIQVdjclJiTlNGK01pZkdoQlpiSndNR2QwOTZ3?=
 =?utf-8?B?TE45emV6c0ZLSGNHWjNLYWFyNjgrNWZiSWJKTVYxVXhVWVFTNTZZaWZLMTVx?=
 =?utf-8?B?YXBraGpjSXg4M0pVamlSYk5RYk5vNjhzRHE4emR1bTNVU3hxUTdMakJ3V3NS?=
 =?utf-8?B?OTVDWXVXcW8zWUxqNXFVVW42UmRqTHd5cTZzSVp3T3llWVRYOEJoL3lUNndt?=
 =?utf-8?B?QXExZENYbTBxbDA4a3NyMkRCZ0dLMG1aYmJvVnFhd2hYeFZkYk51RWsyRlVV?=
 =?utf-8?B?WTJyS1Bzd2s2anRqeWh0L0MrNkxGNFpaeXU5WVU3M2JEQmJPTE8rTDV5L1Er?=
 =?utf-8?B?OFY1a21Xb0Z3anNpRzJnVVBEdFpLcnpTODVjREtvRkk4R0kvc2VWUlExa25K?=
 =?utf-8?B?WGtWWk5CRWVyTG5kVHhpYm5VOVcvMUlNR2ZzVWNFMjdBNDNBbm5jeUZuM1lI?=
 =?utf-8?B?SERBOFJaSGpvVmlnVzNqS3B1bDlqbVdQbXBVVnFIek9BWkVXeElCaWhIZ0pR?=
 =?utf-8?B?VlA0ZWQ3VXRUWGdDcEdqTzhjU2lLbHV0d2pBL0dnTkh6d21sQWxpS0tZUGVC?=
 =?utf-8?B?NVBibndSZDhreUpWZXd0VXNzK0ltVDBZbm8wL2pMdHFTVGxCSDdDSWMzVzlF?=
 =?utf-8?B?RVdFMDVpU1JEcFN1QkQwYWlIalNOaEFFTURUUnVkTW9IZnVLY3grenlwVkRG?=
 =?utf-8?B?Yk5reXBQdFNJYWphYXppOWZ4MHNweHRNRnJ4cW1WNkwrWi9XbmU3eGl4L29M?=
 =?utf-8?B?TnptVUp6bWlXcU91UVFydWZVbktIanRJVy83Q3UyM0czU0ZXWnhldGdTcWEr?=
 =?utf-8?B?d08zZ0YrZTlIcjFSdENHVi84bHMrWUpYRHVWT2pabTFDdTV2clpCTVhuSXZs?=
 =?utf-8?B?YldYNFZDQnJrUG5HazhSS0o5cXN2dGlRSDVOMkhBYkVScUg1RXZJRG90TUQ1?=
 =?utf-8?B?SmltR2JKaUM0b3hnSm5KMmdtWXhrRTU1bGpFbnc3TkFxanlvT2U2TnZ2OWQ0?=
 =?utf-8?B?eDRVQU1qMVd2WExjNFhCOEl6VlQ4QnFGNEVCWXpPYXZrdDZSS1hvSTVMbDJC?=
 =?utf-8?Q?XwOpYBzZx5VPtoGXemZH8rUx+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFF1FE4FC02FD643AACAD340935A3ED2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q1M3OHpyaXBaek5PUWppOHRyaUg0QUluZ2ppU1VxeXBGWEN4SXhBTVNFL1Iy?=
 =?utf-8?B?cDZCWFUvWG1QMEY2QjR2MXVaSjE4dTN2SFJXRDBRYUdNOG5UOGhueWdUVTR6?=
 =?utf-8?B?ZnBydjAwY3Q0NkFwblV5M0txbnlTaHF1SDhnU1FaWm4zTkE1UUJITGQvNUY0?=
 =?utf-8?B?Q2xhWmRVZUlGeXpGNUZtMXFuT0tYQ1BqZXNqbzhha2syY2hUTkJWTlBrQnZ3?=
 =?utf-8?B?bHlDSy9xSmlOa1I1WDJrS3M1QnNVRlppN1dPSVZRenZrQm5qemp2V1UrQ3Ix?=
 =?utf-8?B?aFJoUlhXRml6bnN1aENYL01vVUVGVHRsODd6N2o0MmdqaVB2eEZyYUtqM0g5?=
 =?utf-8?B?K3ltekF0MWJMTmNnd0c1cWVTdkYyNHpvYmVKQkllK29QRWV1SUxnVitVdVNq?=
 =?utf-8?B?amZhNys5NnlOY3B5bmhFaGptZmV3ejlWbmJldjg4OFdUSXQyMS9Ec2dxV3lx?=
 =?utf-8?B?NThqcTB1UXZyNjlCcmtZSTJNcnRQWjJvWjF5eEcxajFJU3N4QjI5M3dxRm1q?=
 =?utf-8?B?YVM2aWhDTVBFOFBCWEFRU1FyaXlWQVZVTVFjK29iWkRDT2d2MkJtSXBmQXVa?=
 =?utf-8?B?MEN6KzNUbHVjZ1M3TmVUNjVqTGJaVkk4aXB3QUk3MytSVk9WSEY2a1RybWxI?=
 =?utf-8?B?ZVVHdXR6b0pnL0hIWkY2VDFSK1FuanlINXVLWnliSENtVzgxcklWc2NuUFIz?=
 =?utf-8?B?eWpERnBERU53bkU4clpYWFBrbk0zY1BTMUZtYkxNNDVYKzZ2WEdaS3ZXWGlE?=
 =?utf-8?B?and1blNidERzTm5BQU9vcWdxazlMRzliM1dXU05VYmRpajM4Tm1CN2NJKzNn?=
 =?utf-8?B?UjlDZ1JSNkJaM09kcmlPSTZDVVEwS3FMcTk2b2Q3eTR6SEdBREk5MmF1MTB5?=
 =?utf-8?B?OURkMUdEeENTRWkxb05ZVExTbXIrd1FSR1VoU3VVVFlhTlJhL0ZyWDFJa1Ez?=
 =?utf-8?B?QjZKT2IzdHQrUFM0ZlBFWEJEdUZ2UE9hUStMR0J1Q2lMUTY1b0p1dTJNM1pq?=
 =?utf-8?B?c0lzY3FHUHQxbVJ3TVB6OElNUGpDMUNLaGJRNzdWUU1icGtHcS8xSDNBOUwr?=
 =?utf-8?B?bjlzUFBOTEFCbmdrWFVOU3NzYUd3bmVNWVYweTVneGowRy9yN1FHZzlMck9t?=
 =?utf-8?B?ZUZEdm56THdvcEJUV1FWV2FCK3FZOWlXQ0l5VHNKZm5hdDR5U0JobGhaNU53?=
 =?utf-8?B?akh2YnZxUCtvcGU3U3h1djFjNUJRWDZ0Ly9FN1pFUzhGaFM3cWFnRndtRkY3?=
 =?utf-8?B?d1hRR0ZQVGcwNmlCZHBLTmJhYkxSSkNVVHQvanZ2SE9LWURadz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ec1ef0-6a4a-4b82-ba16-08db82589560
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 21:48:37.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6/h7IG1pMZ8NDFReXmivsT7AQakms9AD1GJurOuQ6JQ04E4cuby91g7MhrZp4zc11RhB6c2BvvWviQUrdRD4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179
X-Proofpoint-ORIG-GUID: Qa2-uRCQAUxEwjZ_D7VNq8i_DWl7yfg-
X-Proofpoint-GUID: Qa2-uRCQAUxEwjZ_D7VNq8i_DWl7yfg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFrdWIsDQoNCk9uIFRodSwgSnVsIDA2LCAyMDIzLCBKYWt1YiBWYW7Em2sgd3JvdGU6DQo+
IE9uIFdlZCwgMjAyMy0wNy0wNSBhdCAyMjo0NyArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+IEhpLA0KPiA+IA0KPiA+IE9uIFNhdCwgSnVsIDAxLCAyMDIzLCBKYWt1YiBWYW5layB3cm90
ZToNCj4gPiA+IEF1dG9SZXRyeSBoYXMgYmVlbiBmb3VuZCB0byBjYXVzZSBpc3N1ZXMgaW4gdGhp
cyBjb250cm9sbGVyIHJldmlzaW9uLg0KPiA+ID4gVGhpcyBmZWF0dXJlIGFsbG93cyB0aGUgY29u
dHJvbGxlciB0byBzZW5kIG5vbi10ZXJtaW5hdGluZy9idXJzdCByZXRyeQ0KPiA+ID4gQUNLcyAo
UmV0cnk9MSBhbmQgTnVtcCE9MCkgYXMgb3Bwb3NlZCB0byB0ZXJtaW5hdGluZyByZXRyeSBBQ0tz
DQo+ID4gPiAoUmV0cnk9MSBhbmQgTnVtcD0wKSB0byBkZXZpY2VzIHdoZW4gYSB0cmFuc2FjdGlv
biBlcnJvciBvY2N1cnMuDQo+ID4gPiANCj4gPiA+IFVuZm9ydHVuYXRlbHksIHNvbWUgVVNCIGRl
dmljZXMgZG8gbm90IHJldHJ5IHRyYW5zZmVycyB3aGVuDQo+ID4gPiB0aGUgY29udHJvbGxlciBz
ZW5kcyB0aGVtIGEgbm9uLXRlcm1pbmF0aW5nIHJldHJ5IEFDSy4gQWZ0ZXIgdGhlIHRyYW5zZmVy
DQo+ID4gPiB0aW1lcyBvdXQsIHRoZSB4SENJIGRyaXZlciB0cmllcyB0byByZXN1bWUgbm9ybWFs
IG9wZXJhdGlvbiBvZiB0aGUNCj4gPiA+IGNvbnRyb2xsZXIgYnkgc2VuZGluZyBhIFN0b3AgRW5k
cG9pbnQgY29tbWFuZCB0byBpdC4gSG93ZXZlciwgdGhpcw0KPiA+ID4gcmV2aXNpb24gb2YgdGhl
IGNvbnRyb2xsZXIgZmFpbHMgdG8gcmVzcG9uZCB0byB0aGF0IGNvbW1hbmQgaW4gdGhpcw0KPiA+
ID4gc3RhdGUgYW5kIHRoZSB4SENJIGRyaXZlciB0aGVyZWZvcmUgZ2l2ZXMgdXAuIFRoaXMgaXMg
cmVwb3J0ZWQgdmlhIGRtZXNnOg0KPiA+ID4gDQo+ID4gPiBbc2RhXSB0YWcjMjkgdWFzX2VoX2Fi
b3J0X2hhbmRsZXIgMCB1YXMtdGFnIDEgaW5mbGlnaHQ6IENNRCBJTg0KPiA+ID4gW3NkYV0gdGFn
IzI5IENEQjogb3Bjb2RlPTB4MjggMjggMDAgMDAgNjkgNDIgODAgMDAgMDAgNDggMDANCj4gPiA+
IHhoY2ktaGNkOiB4SENJIGhvc3Qgbm90IHJlc3BvbmRpbmcgdG8gc3RvcCBlbmRwb2ludCBjb21t
YW5kDQo+ID4gPiB4aGNpLWhjZDogeEhDSSBob3N0IGNvbnRyb2xsZXIgbm90IHJlc3BvbmRpbmcs
IGFzc3VtZSBkZWFkDQo+ID4gPiB4aGNpLWhjZDogSEMgZGllZDsgY2xlYW5pbmcgdXANCj4gPiA+
IA0KPiA+ID4gVGhpcyBwcm9ibGVtIGhhcyBiZWVuIG9ic2VydmVkIG9uIE9kcm9pZCBIQzIuIFRo
aXMgYm9hcmQgaGFzDQo+ID4gPiBhbiBpbnRlZ3JhdGVkIEpNUzU3OCBVU0IzLXRvLVNBVEEgYnJp
ZGdlLiBUaGUgYWJvdmUgcHJvYmxlbSBjb3VsZCBiZQ0KPiA+ID4gdHJpZ2dlcmVkIGJ5IHN0YXJ0
aW5nIGEgcmVhZC1oZWF2eSB3b3JrbG9hZCBvbiBhbiBhdHRhY2hlZCBTU0QuDQo+ID4gPiBBZnRl
ciBhIHdoaWxlLCB0aGUgaG9zdCBjb250cm9sbGVyIHdvdWxkIGRpZSBhbmQgdGhlIFNTRCB3b3Vs
ZCBkaXNhcHBlYXINCj4gPiA+IGZyb20gdGhlIHN5c3RlbS4NCj4gPiA+IA0KPiA+ID4gUmV2ZXJ0
aW5nIGIxMzhlMjNkM2RmZiAoInVzYjogZHdjMzogY29yZTogRW5hYmxlIEF1dG9SZXRyeSBmZWF0
dXJlIGluDQo+ID4gPiB0aGUgY29udHJvbGxlciIpIHN0b3BwZWQgdGhlIGlzc3VlIGZyb20gb2Nj
dXJyaW5nIG9uIE9kcm9pZCBIQzIuDQo+ID4gPiBBcyB0aGlzIHByb2JsZW0gaGFzbid0IGJlZW4g
cmVwb3J0ZWQgb24gb3RoZXIgZGV2aWNlcywgZGlzYWJsZQ0KPiA+ID4gQXV0b1JldHJ5IGp1c3Qg
Zm9yIHRoZSBkd2NfdXNiMyByZXZpc2lvbiB2Mi4wMGEgdGhhdCB0aGUgYm9hcmQgU29DDQo+ID4g
PiAoRXh5bm9zIDU0MjIpIHVzZXMuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBiMTM4ZTIzZDNkZmYg
KCJ1c2I6IGR3YzM6IGNvcmU6IEVuYWJsZSBBdXRvUmV0cnkgZmVhdHVyZSBpbiB0aGUgY29udHJv
bGxlciIpDQo+ID4gPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci9hMjFmMzRjMDQ2MzJkMjUwY2QwYTc4YzdjNmY0YTFjOWM3YTQzMTQy
LmNhbWVsQGdtYWlsLmNvbS9fXzshIUE0RjJSOUdfcGchWVdnRjZvcWZ1Vlk2eHN0Wm1yb3Vramxy
d0FGRVlFUUU4dWpfaVV1NGZkMTBtbkp4RVBHMzQ1azc1ZE1MTGRORlA4clQxbGVvay1hUE5rel9G
dUFKMXp4bm13JMKgDQo+ID4gPiBMaW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9mb3J1bS5vZHJvaWQuY29tL3ZpZXd0b3BpYy5waHA/dD00MjYzMF9fOyEhQTRGMlI5R19w
ZyFZV2dGNm9xZnVWWTZ4c3RabXJvdWtqbHJ3QUZFWUVRRTh1al9pVXU0ZmQxMG1uSnhFUEczNDVr
NzVkTUxMZE5GUDhyVDFsZW9rLWFQTmt6X0Z1Q3pPR0lWUEEkwqANCj4gPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogTWF1cm8gUmliZWlybyA8bWF1cm8ucmliZWlyb0Bo
YXJka2VybmVsLmNvbT4NCj4gPiA+IENjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gPiBTdWdnZXN0ZWQtYnk6IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEpha3ViIFZh
bmVrIDxsaW51eHRhcmRpc0BnbWFpbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IMKgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgfCAxMCArKysrKysrKy0tDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4g
PiBpbmRleCBkNjg5NThlMTUxYTcuLmQ3NDJmYzg4MmQ3ZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiA+ID4gQEAgLTEyMTgsOSArMTIxOCwxNSBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0
KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIEhvc3QgbW9kZSBvbiBzZWVpbmcgdHJhbnNhY3Rpb24gZXJyb3JzKENSQyBlcnJvcnMgb3Ig
aW50ZXJuYWwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogb3ZlcnJ1
biBzY2VuZXJpb3MpIG9uIElOIHRyYW5zZmVycyB0byByZXBseSB0byB0aGUgZGV2aWNlDQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHdpdGggYSBub24tdGVybWluYXRp
bmcgcmV0cnkgQUNLIChpLmUsIGFuIEFDSyB0cmFuc2NhdGlvbg0KPiA+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIHBhY2tldCB3aXRoIFJldHJ5PTEgJiBOdW1wICE9IDApDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcGFja2V0IHdpdGggUmV0cnk9
MSAmIE51bXAgIT0gMCkuDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoN
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBEbyBub3QgZW5hYmxlIHRo
aXMgZm9yIERXQ191c2IzIHYyLjAwYS4gVGhpcyBjb250cm9sbGVyDQo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcmV2aXNpb24gc3RvcHMgcmVzcG9uZGluZyB0byBTdG9w
IEVuZHBvaW50IGNvbW1hbmRzIGlmDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogYSBVU0IgZGV2aWNlIGRvZXMgbm90IHJldHJ5IGFmdGVyIGEgbm9uLXRlcm1pbmF0aW5n
IHJldHJ5DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQUNLIGlzIHNl
bnQgdG8gaXQuDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiA+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyB8PSBEV0MzX0dVQ1RMX0hTVElO
QVVUT1JFVFJZOw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghRFdD
M19WRVJfSVMoRFdDMywgMjAwQSkpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlZyB8PSBEV0MzX0dVQ1RMX0hTVElOQVVUT1JFVFJZOw0KPiA+
ID4gwqANCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZHdjM193cml0ZWwo
ZHdjLT5yZWdzLCBEV0MzX0dVQ1RMLCByZWcpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoH0NCj4g
PiA+IC0tIA0KPiA+ID4gMi4yNS4xDQo+ID4gPiANCj4gPiANCj4gPiBJIGJyb3VnaHQgdXAgdGhp
cyBpbnF1aXJ5IGludGVybmFsbHkuIFBsZWFzZSB3YWl0IGFzIEkgbmVlZCB0byByZXZpZXcNCj4g
PiB0aGlzIGZ1cnRoZXIuIFRoZSBoYW5kbGluZyBmb3IgdGhpcyBtYXkgYmUgZGlmZmVyZW50IGRl
cGVuZGluZyBvbiB0aGUNCj4gPiB0ZWFtJ3MgZmVlZGJhY2suDQo+ID4gDQo+IA0KPiBPSzsgZmVl
bCBmcmVlIHRvIGNvbnRhY3QgbWUgaWYgSSBjb3VsZCBiZSBvZiBhbnkgaGVscC4NCj4gDQoNClNv
cnJ5IGZvciB0aGUgZGVsYXkuIEFmdGVyIGRpc2N1c3Npb24sIHRoaXMgYmVoYXZpb3IgaXMgdGhl
IHNhbWUgYWNyb3NzDQpkaWZmZXJlbnQgY29udHJvbGxlciB2ZXJzaW9ucy4gVGhlIGNvbnNlbnN1
cyBpcyB0byBkaXNhYmxlIHRoaXMgZmVhdHVyZQ0KYWx0b2doZXRoZXIuIFRoZXJlIHdpbGwgbm90
IGJlIGFueSBub3RpY2VhYmxlIHBlcmZvcm1hbmNlIGltcGFjdC4NCg0KV291bGQgeW91IG1pbmQg
cmV2aXNlIHRoZSBwYXRjaCB0byBkaXNhYmxlIHRoaXMgZmVhdHVyZSBmb3IgYWxsPw0KDQpNYW55
IHRoYW5rcywNClRoaW5o

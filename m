Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261D6D7748
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjDEIsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbjDEIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:48:43 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496C449A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:48:42 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3355a4W8013654;
        Wed, 5 Apr 2023 01:48:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2jS3tH9Uv9B2SxmiQYDSu8v00I8PdMP/a+dhvWzkgUk=;
 b=jYfdtETICMiF1BOwE2nzSh5E1lw6YSOepVwi9NJr18LIEtSqCSPZgSDpK/bmqW2kD4Rm
 Payv2Tq2HCg+m0YX+L3JDGFYVVH8ZSxSEg3oNn8WQfYZWh9J381Eo01ozSK6wyvmqUiE
 fEY601aUGm5HMJwu5xr2yX+sBQq1MBAp95FHIBEFupxvVCxraGs9eL3oKR+yB45b/6o7
 eVJkQpo24VPhIhjL/Czo6qr9lY32rSotBwJfnTvW+t0VWH7fJXWzAUgmHM+Z76Bfwvtv
 lKYWitp8Wrg+oYG3n6YymvK+xIizg2vo8gD0K9BgqRxiBfIl4NIuJZTsG5OFNcYXWSId Rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkv92se1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 01:48:27 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 41858C05B2;
        Wed,  5 Apr 2023 08:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680684506; bh=2jS3tH9Uv9B2SxmiQYDSu8v00I8PdMP/a+dhvWzkgUk=;
        h=From:To:CC:Subject:Date:In-Reply-To:From;
        b=D37HU+Ea+GejpTFWiunw2eMGnknG3wMj5LA5f2PpEkq1iPsFFYZgBB0lTudcZXyBJ
         Lg1nQ1RIl+cCU8gklh2IUNdyA0RA71JH8cLPQiuuJaona2sGQ5JICKhPCOIAIEJV4v
         4LEx3WESS+XTZ5TJKZH2h6PoLQCw2uh+gYqikKYypaaPLXKt8dy5+l+xktjVYuH6ZF
         jvkVjIELfadPssdCTaNmIpHdarQzfvE+YpPV3CqjzKizvYfVjQVNOCWtXQCU8wEl7w
         8kVFWumwRoQQxbRF9v9kiO5c2FgjxzLL4t0iR9J7iZJZy0bah8bjV5gjdqsEgDP9RU
         cXOVfOzuumvQg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AFBE8A00A1;
        Wed,  5 Apr 2023 08:48:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 67FE94006C;
        Wed,  5 Apr 2023 08:48:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=shahab@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dAmL2cSF";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF6i68g8B7kYVHCDuGCDhrLP9ZwnGKKbrmOK4ivlcAwEXDlru4pJLq2pak2owecLiWTO98wNRhSSxr8VKISrbBm/WOupll1AvhhaLLMy0vH+Mi+buVX3ZV6wahipuMh3uDMfr0YQrN56IK3bLo8dkoi2gNwU0omYepBVpqVhAFFnVe9EResuDIfI4AByC6e2RcLQ9X7dRyEpO86CKdCUerxInEux3lQtaj2q/IGxLWxS5RvD0XNzpk3s1IeRfID3cUuhO5TcX7b+ApyisonhnE5Bf8rAQ7I0HQXDLuORjoR1SQrvQLZbFqAIY+3tE4nAMM03HBsw+4jRmc9l5wvyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jS3tH9Uv9B2SxmiQYDSu8v00I8PdMP/a+dhvWzkgUk=;
 b=gDpfNtOzFNh86zsV+lkluy3Lf1XqpXaZtC/wZ3EL+Ct1p2ubIqtDjqpXck0LPTbwaQerdqAJdb7oKUKQso80FGwQWHKPmKIYupNKZiLg3yakMUK15yQF6GGgiUzzVN7g94OjmZklPHFtBrs4yZydk05bMIGtKEGiE86jYICVpvMi/QFgFKpTztzaSx2I0aOYHhkX66Xb3or6CwCP4ixQ19xic07C2bCTwNZavJKAUQFk2kcrYFZ6loZL3aOm7r/tZ8LGoNBYEBpQgD8VdaWZqjvu8fFGJPnwtN/pV0J1BvQnszowqrdDVHms5/le5IyFw2F9FqlrXv2cuOus9FyW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jS3tH9Uv9B2SxmiQYDSu8v00I8PdMP/a+dhvWzkgUk=;
 b=dAmL2cSFLzaJXRqlcxv49SOaVw30FA82/TF/KXmHSXSOho7BW/weEwFGRHQMj7Tjl+1+qrpmH9QyJrGw0u+YAMy5x+LRaxENxvG4DrwPM5HlRhlRbxqEwYUEvpx4+dsl0uJbecbCINnXUbXNzOXvt4zG8VVhHdswzTktpkfpPBY=
Received: from SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 08:48:20 +0000
Received: from SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::16ef:a4:a1eb:6c6]) by SN6PR12MB2782.namprd12.prod.outlook.com
 ([fe80::16ef:a4:a1eb:6c6%4]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 08:48:19 +0000
X-SNPS-Relay: synopsys.com
From:   Shahab Vahedi <Shahab.Vahedi@synopsys.com>
To:     Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.torgue@foss.st.com andrew@lunn.ch boon.leong.ong@intel.com davem@davemloft.net edumazet@google.com hkallweit1@gmail.com hong.aun.looi@intel.com joabreu@synopsys.com kuba@kernel.org linux-arm-kernel@lists.infradead.org linux-stm32@st-md-mailman.stormreply.com linux@armlinux.org.uk mcoquelin.stm32@gmail.com netdev@vger.kernel.org pabeni@redhat.com peppe.cavallaro@st.com peter.jun.ann.lai@intel.com weifeng.voon"@intel.com,
        <"alexandre.torgue@foss.st.com andrew@lunn.ch boon.leong.ong@intel.com davem@davemloft.net edumazet@google.com hkallweit1@gmail.com hong.aun.looi@intel.com joabreu@synopsys.com kuba@kernel.org linux-arm-kernel@lists.infradead.org linux-stm32@st-md-mailman.stormreply.com linux@armlinux.org.uk mcoquelin.stm32@gmail.com netdev@vger.kernel.org pabeni@redhat.com peppe.cavallaro@st.com peter.jun.ann.lai@intel.com weifeng.voon"@intel.com>
Subject: Re: [PATCH net v5 2/3] net: stmmac: check if MAC needs to attach to a
 PHY
Thread-Topic: [PATCH net v5 2/3] net: stmmac: check if MAC needs to attach to
 a PHY
Thread-Index: AQHZZ5te562vZwfErk6r9bP/RDaizQ==
Date:   Wed, 5 Apr 2023 08:48:19 +0000
Message-ID: <4b0261ef-a747-cd88-3fc1-6d99ff3d8913@synopsys.com>
In-Reply-To: <20230403212434.296975-1-martin.blumenstingl@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2782:EE_|DS7PR12MB8250:EE_
x-ms-office365-filtering-correlation-id: 9ccf48c5-6ab5-4cb3-4700-08db35b28135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FTjuL+u5vTCqTVeKRSIe1ouf4iBI28vw1XCendyxcAtlBonB0VZK6AuGtOWuGnze7aqc1ATglYlremwKvNfsWhlOsZOe77u2ozPEleBNUjiUTpRp4v83l5lSGsM/dsE4CnX87PNsPb+6Ep68euSsqevHYIG5DCOsk6+V4h3CJfmUy/ZdJVzeoAyn62rT1gb2hlVhKFe6THZdLQNuL4f430gRtEfk5qX92I14oSLaYuqOgl41luP8Iz47OiTVadFltgYmorNaEYiYiYxryKeBMMCgE58Luu7ZdyFCAW7LEg7Prghd1oIRB4VXG7Nk/ex/EhdT6AcAsMTKpXLeVcaZq93m0pJ/oJDdqvimKDkTe6GJ+9EREBQPx2sJJqRHUFwqzXurEiL2LeIm9y5X6wbptPLjYHKgkDSMU5xtgRuNoM3bbtElHXSlvU7kTiE/ADPYXLZxchWYhP65QOfaiYVVBwWk3KCGXtnPpKe+/aSy4KMHDPyWNb5Jkmf7aE55TwO95exlwPPrNMtFazh1vEeXOGY1mfMb60pjEezbymPsEhALVBv7Ck6Oyf7fkBxs0hkIqR5/rseX9zE+/rgRT8+fYmMItTiWU45fc/Nbswq/9hzxo6hJ1K4gE8xeqATcX4+CH6YR/rIFHEbONz9APr+/NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(38100700002)(5660300002)(86362001)(2616005)(6486002)(26005)(6512007)(6506007)(83380400001)(122000001)(55236004)(38070700005)(8936002)(66476007)(66556008)(6916009)(64756008)(66946007)(478600001)(54906003)(71200400001)(8676002)(31696002)(36756003)(4326008)(76116006)(66446008)(316002)(41300700001)(186003)(91956017)(31686004)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anVpZDR5V3VkL1hSUzg2TWhrbE9zQ1FoTkJzK0hDT1FOZnFiaTgwU2VPUFpL?=
 =?utf-8?B?Y3NrOFA1WWU5WDNFNjhUcHoydXQ2QURiRllpdEoxemVsLzBXanpKTGtkRGVk?=
 =?utf-8?B?eWUrUFVINHdBOGR6OXE2RTJqOGdXQ1VpV2tXYjFoUzZSbk9UMldUNzJNODd2?=
 =?utf-8?B?eFBURHEyTTB4d0pra0V6MU9SS1kyYWdlaXhINzRiMkJIZ3FRM0VKeEZKWFg3?=
 =?utf-8?B?RjQwbXRIdFBJRTFvaXlrUUhmcmF1VHd1M2tZQ0FyckdZQXZBSDRYRHl0MkRs?=
 =?utf-8?B?clpvZUJJMzU1LzZtbEdXQXF4N2x4c0RxRGh5Mk1KSDdKSFNFNW82Z252MXlx?=
 =?utf-8?B?c01BNi9NZWlqUlhtc0FwTTZxeUxGY2d6Q3hTR0RNWlV0SmVwcit2NzRMK1dh?=
 =?utf-8?B?OUc5RytHaklWSTZtUy9DY2VLMW5sSjloM3lVM1pyRStGWlRZVnZEYjR2Ylgz?=
 =?utf-8?B?YXRWT25TQ3FzWk5JMnBlUUdTSXhvdjdONEFqeDUyZ1ppZ3pyQVVIbnFqWVBa?=
 =?utf-8?B?RjlQbjJ4ZEpqL21pdnFEZkJ5Q0FnTVVQZVozcDY3N3hmSFB6cHI1eGJxUTFz?=
 =?utf-8?B?WFBqaVY1QlBKcHY1YVRDQi9tWE1aZDVLTGs4VXVCRUFLc2MycFJ1QklwUTBO?=
 =?utf-8?B?N0RLNnRHKzBqdFlkckZyOUVySmRnaWhQZDhSS2pZQzNJTlFOZ0wwWEdHcSsw?=
 =?utf-8?B?bWZlSXZuT0tYeVBPTG9CS0o0S0VvT3pYelNnZmF6eDdxNWFTS2JwM0tCNmZ6?=
 =?utf-8?B?NXA1REl6WEk0TmZGZGlCRFZ2U1NCN3lVMU5weGx5UDF0OVJPeElmMTFmUTFE?=
 =?utf-8?B?WTRreUxaOWZpVTE4T0w0enBrVm9LQVF3WExCK3p6Y2xXTEZvRDF6WkdVQnZr?=
 =?utf-8?B?bGU2TXFuaG9GeUlyVHpaVXNmZVN6cld6R1dKV3JYZzFlVnBvZHA4ZUpYaVUz?=
 =?utf-8?B?QXIxaVBHVm45R0xaMWZDZGVUNWxjL2xhcnFEOTRUTVlYQUZsTTlGak5lNDVW?=
 =?utf-8?B?TFN1aHpmR1FGVTVvV2dtTEtKWTdHZ1RlcGNXODVNbjhpMktBVU13ZVNBa1Nt?=
 =?utf-8?B?aGx4SzBZc0tWSjgrVGxyTXZ5YTZyY1MrWlZ2VG1sYlpwNkxHaHlzSnRlMHRk?=
 =?utf-8?B?K3BVdVF5eVFIWXQ4Ty94UHA3T2M1dmQwYlpoSEZSdUhhTWNHYXlkZWVPQXVU?=
 =?utf-8?B?Tjl3Q0I2dHNnOUorR3NscjZYaCtxcFZoc1M2SmZXTklubEwvb2Q0Y2ROb0Jl?=
 =?utf-8?B?VTB2UWlhQU5JZERmWUZUdzAwTWt5UU1hQkR5U0tQUHVBdzdPcnBJUlIxc1Vn?=
 =?utf-8?B?MVNzek1QUUVFNkowWk9jNnRBRUxiWk4yVklaRERubE5XWE5vbzcvNjAwSml1?=
 =?utf-8?B?L3AxNVhVSXJndWdrSmlVWjFZNTVxOWxETThSem1pQkN4UmhJeHZ4czJrdUxv?=
 =?utf-8?B?czlmRjBIWVVIaUF0ZjNxenZhRllBN25TWS9YMnVJYUlSMThDNDN0YlU3TzRJ?=
 =?utf-8?B?dTU3K3Q1WWVoMWcyYTdDUjlPL3V4Qm5iMWdmcDVLSWFJNFJWZ0FIYzlXVFRZ?=
 =?utf-8?B?ZTlEaDk0ZnU5RUJSb1N6Zk9WWkFKQkU5MFZzY3NVUFlodUVzY1UrWVUvSVE4?=
 =?utf-8?B?YU9JY2R6TVhvak9iWjZVYUwxVUxTeFh4OU1UdlFLN2JCbkJpSnliVkRCWFNR?=
 =?utf-8?B?VnFFTWNPaWhvZWhsYjZBMDRLOWU4NUMwN1VDVFpMbWUvM0V3dE93bXBINWVP?=
 =?utf-8?B?NGpEZUJPTUtPb3BUUVdOSUdSbEJRdUpPRWR1V3MxejdicENDRW9jSFZtbnpG?=
 =?utf-8?B?bDR6ZnhTQkJlYWFVeEFjTEUrTkh2dkhKbkphWGFsTW02YndPeEpDcWx1Ynp1?=
 =?utf-8?B?T2RNd3Vqa3A3eVZJbVdabFlsV2w4eHBGZ0V0QVovaDdxNW5xeFRKczJCOGtq?=
 =?utf-8?B?aEJ1NkJCY2NTT0hYYTZjSEZ4NThsUFQxbGpvZk54ZVhVeWlnUUp6cEdlVDFX?=
 =?utf-8?B?Qmpiblpja1grOWlkb2tCMVR5UFpRdG10WGM5d2Zaei9YaWFJQit5NmtVSG1C?=
 =?utf-8?B?MlcwT0JCZ1Y2UFFkbFNPb28rU0RtcGVoTm9iMmxoWVNDU3BRajFyZUpUVnd4?=
 =?utf-8?Q?02g8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A238E57FBDAB564298C07264B2A3E38F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OElwaWpIbkE4T2laWmJXLzFKYzljUVA3NU5MN1dxKzNZZFAvWGhUYWtzbWh1?=
 =?utf-8?B?am5keEN1aUdGMTBOZWtSbzJabHhWYUxIRnlYdjlYWm1HNGF3b1VtSXlveWhH?=
 =?utf-8?B?aEpUL0xqVUhybGZuTWlIR0FnRXM2dGNvRVRONGh1cFh4ZVlvUzdXaE5VODhl?=
 =?utf-8?B?SWQrNmdSU0lBdlJuSHVjeWQ1bnlicUVSdFN3Z3RpVUkzTmNobU85dzdUb2dp?=
 =?utf-8?B?ZzNkMURiZEF6Y2l3SEhlNUxNWkNwNSswcDhjcFhDZFNVcU1IblN3M0QvYXVP?=
 =?utf-8?B?MEd2M1BLTy9ISGdaNFFsL201ZGtQM3NqUGdibXBzTnZJem5KSm5XUXNieDZ2?=
 =?utf-8?B?US9JN1g4SFRKTGFkbDE2SXhHdjBPckprck4wU1hlMmRtd25tRDlHWDlsdDhh?=
 =?utf-8?B?Q0h4TzBPckpneVZDaUJSSXRyN2hQYVdYRG8ySjRpWm1yOUVoN3RKa1kyaElE?=
 =?utf-8?B?cURxNUFXVDZVcjlodzduWGNjNG1HYVNVMHRxaVcva2haUWgvbGVEVVdoOHhV?=
 =?utf-8?B?enJibmNHTFZYKzF3Q25kWkUwenRVdkNEdlpvYWVwSXQ0aGE3Qk4vd1drSnV3?=
 =?utf-8?B?MitkMTRtQnNyTjRXYXpVYzBDU2VqaTZINUR1MUFaSUlndWlaZUhyd0dwSTlM?=
 =?utf-8?B?SnpIb1VOUEpra1l6MGgzSEVOS1ZHUGVPbmt3TGtzSkNKNkNtN0ZaZlkwM09H?=
 =?utf-8?B?TnhjZHJBbm41OE5ZcjRkUk91cmgxS0xsVFlIM1VKc21ZSjV6OVlETWcxcnh1?=
 =?utf-8?B?YVhqNVc5UDNJZGRlVldzdi9hWUppNWlUMGF5QWRwM1cxcUdjUUFUYzMrSGFy?=
 =?utf-8?B?ZUNxNWxGV0FNNlhObERodlJNNzl2YnBNQys3R3YxYjRwYktkZWczRG9nbDNy?=
 =?utf-8?B?MjU3amc5cnJNQWk0MHpJYW01QmQwbVZDZU5tWHZoWHBveDZRbUxlY0d4MXhl?=
 =?utf-8?B?RzJjMEt2UUxGdFgwdW9pTGovRjhoWHFTcUY2UEV3NlVoQUh1N2M1UHZLOWVX?=
 =?utf-8?B?d0V5OGkwZzB1aXdraFMwcUR4WTBxcU9XUW1IWjFNLzQzODVocnhqV0NoY09U?=
 =?utf-8?B?d2JVeGNneDRVWkh2ZjRUd3dMVkttcmFsVzFXNkw1bkd3VmJHVTdKeGFpbnhB?=
 =?utf-8?B?NzRlYlRzYVdRNDFMMmxNeDR5U01EYWJvdldZVG1kVTJXZ0p0Mmh0elZZdDlZ?=
 =?utf-8?B?eDllR3FNa3VQV1NJSENFMUJvZVpmT3ZmdjNNUUVtZVVJc2pvYWJLNGtBUkRX?=
 =?utf-8?Q?CFZtdbBhVX0uiHk?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccf48c5-6ab5-4cb3-4700-08db35b28135
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 08:48:19.0990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0rsVAtRkTSBzKJgJa4N3nfuAuaUSjlpBmYmydXcym46cJzPVYEIcaNCgb88R+zTyZSZ//j24a7f3JdGh8k/Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
X-Proofpoint-ORIG-GUID: JTHJWOdpIB5fG-wO1lpUJkSN20I4dOAo
X-Proofpoint-GUID: JTHJWOdpIB5fG-wO1lpUJkSN20I4dOAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_05,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=355
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304050081
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2FtZSBoYXBwZW5zIG9uIEFSQyBIU0RLIFsxXToNCg0KIyBkbWVzZyB8IGdyZXAgc3RtbWFjZXRo
DQogIHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5ldDogdXNlIGNvaGVyZW50IERNQSBvcHMNCiAg
c3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0OiBJUlEgZXRoX3dha2VfaXJxIG5vdCBmb3VuZA0K
ICBzdG1tYWNldGggZjAwMDgwMDAuZXRoZXJuZXQ6IElSUSBldGhfbHBpIG5vdCBmb3VuZA0KICBz
dG1tYWNldGggZjAwMDgwMDAuZXRoZXJuZXQ6IFBUUCB1c2VzIG1haW4gY2xvY2sNCiAgc3RtbWFj
ZXRoIGYwMDA4MDAwLmV0aGVybmV0OiBVc2VyIElEOiAweDEwLCBTeW5vcHN5cyBJRDogMHgzNw0K
ICBzdG1tYWNldGggZjAwMDgwMDAuZXRoZXJuZXQ6ICAgIERXTUFDMTAwMA0KICBzdG1tYWNldGgg
ZjAwMDgwMDAuZXRoZXJuZXQ6IERNQSBIVyBjYXBhYmlsaXR5IHJlZ2lzdGVyIHN1cHBvcnRlZA0K
ICBzdG1tYWNldGggZjAwMDgwMDAuZXRoZXJuZXQ6IFJYIENoZWNrc3VtIE9mZmxvYWQgRW5naW5l
IHN1cHBvcnRlZA0KICBzdG1tYWNldGggZjAwMDgwMDAuZXRoZXJuZXQ6IENPRSBUeXBlIDINCiAg
c3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0OiBUWCBDaGVja3N1bSBpbnNlcnRpb24gc3VwcG9y
dGVkDQogIHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5ldDogTm9ybWFsIGRlc2NyaXB0b3JzDQog
IHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5ldDogUmluZyBtb2RlIGVuYWJsZWQNCiAgc3RtbWFj
ZXRoIGYwMDA4MDAwLmV0aGVybmV0OiBFbmFibGUgUlggTWl0aWdhdGlvbiB2aWEgSFcgV2F0Y2hk
b2cgVGltZXINCiAgc3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0OiBkZXZpY2UgTUFDIGFkZHJl
c3MgN2U6MTQ6ZGY6NWY6Yjg6NzgNCiAgc3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0IGV0aDA6
IFJlZ2lzdGVyIE1FTV9UWVBFX1BBR0VfUE9PTCBSeFEtMA0KICBzdG1tYWNldGggZjAwMDgwMDAu
ZXRoZXJuZXQgZXRoMDogUEhZIFtzdG1tYWMtMDowMF0gZHJpdmVyIFtNaWNyZWwgS1NaOTAzMSBH
aWdhYml0IFBIWV0gKGlycT1QT0xMKQ0KICBzdG1tYWNldGggZjAwMDgwMDAuZXRoZXJuZXQgZXRo
MDogbm8gcGh5IGZvdW5kDQogIHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5ldCBldGgwOiBfX3N0
bW1hY19vcGVuOiBDYW5ub3QgYXR0YWNoIHRvIFBIWSAoZXJyb3I6IC0xOSkNCg0KQWZ0ZXIgcmV2
ZXJ0aW5nIHRoaXMgcGF0Y2g6DQoNCiMgZG1lc2cgfCBncmVwIHN0bW1hY2V0aA0KICBzdG1tYWNl
dGggZjAwMDgwMDAuZXRoZXJuZXQ6IHVzZSBjb2hlcmVudCBETUEgb3BzDQogIHN0bW1hY2V0aCBm
MDAwODAwMC5ldGhlcm5ldDogSVJRIGV0aF93YWtlX2lycSBub3QgZm91bmQNCiAgc3RtbWFjZXRo
IGYwMDA4MDAwLmV0aGVybmV0OiBJUlEgZXRoX2xwaSBub3QgZm91bmQNCiAgc3RtbWFjZXRoIGYw
MDA4MDAwLmV0aGVybmV0OiBQVFAgdXNlcyBtYWluIGNsb2NrDQogIHN0bW1hY2V0aCBmMDAwODAw
MC5ldGhlcm5ldDogVXNlciBJRDogMHgxMCwgU3lub3BzeXMgSUQ6IDB4MzcNCiAgc3RtbWFjZXRo
IGYwMDA4MDAwLmV0aGVybmV0OiAgICBEV01BQzEwMDANCiAgc3RtbWFjZXRoIGYwMDA4MDAwLmV0
aGVybmV0OiBETUEgSFcgY2FwYWJpbGl0eSByZWdpc3RlciBzdXBwb3J0ZWQNCiAgc3RtbWFjZXRo
IGYwMDA4MDAwLmV0aGVybmV0OiBSWCBDaGVja3N1bSBPZmZsb2FkIEVuZ2luZSBzdXBwb3J0ZWQN
CiAgc3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0OiBDT0UgVHlwZSAyDQogIHN0bW1hY2V0aCBm
MDAwODAwMC5ldGhlcm5ldDogVFggQ2hlY2tzdW0gaW5zZXJ0aW9uIHN1cHBvcnRlZA0KICBzdG1t
YWNldGggZjAwMDgwMDAuZXRoZXJuZXQ6IE5vcm1hbCBkZXNjcmlwdG9ycw0KICBzdG1tYWNldGgg
ZjAwMDgwMDAuZXRoZXJuZXQ6IFJpbmcgbW9kZSBlbmFibGVkDQogIHN0bW1hY2V0aCBmMDAwODAw
MC5ldGhlcm5ldDogRW5hYmxlIFJYIE1pdGlnYXRpb24gdmlhIEhXIFdhdGNoZG9nIFRpbWVyDQog
IHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5ldDogZGV2aWNlIE1BQyBhZGRyZXNzIDI2OjA1OmVh
OmMwOjY2OjE2DQogIHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5ldCBldGgwOiBSZWdpc3RlciBN
RU1fVFlQRV9QQUdFX1BPT0wgUnhRLTANCiAgc3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0IGV0
aDA6IFBIWSBbc3RtbWFjLTA6MDBdIGRyaXZlciBbTWljcmVsIEtTWjkwMzENCiAgR2lnYWJpdCBQ
SFldIChpcnE9UE9MTCkNCiAgc3RtbWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0IGV0aDA6IE5vIFNh
ZmV0eSBGZWF0dXJlcyBzdXBwb3J0IGZvdW5kDQogIHN0bW1hY2V0aCBmMDAwODAwMC5ldGhlcm5l
dCBldGgwOiBQVFAgbm90IHN1cHBvcnRlZCBieSBIVw0KICBzdG1tYWNldGggZjAwMDgwMDAuZXRo
ZXJuZXQgZXRoMDogY29uZmlndXJpbmcgZm9yIHBoeS9yZ21paS1pZCBsaW5rIG1vZGUNCiAgc3Rt
bWFjZXRoIGYwMDA4MDAwLmV0aGVybmV0IGV0aDA6IExpbmsgaXMgVXAgLSAxR2Jwcy9GdWxsIC0g
ZmxvdyBjb250cm9sIG9mZg0KDQpbMV0NCmFyY2gvYXJjL2Jvb3QvZHRzL2hzZGsuZHRzDQoNCi0t
IA0KU2hhaGFiDQo=

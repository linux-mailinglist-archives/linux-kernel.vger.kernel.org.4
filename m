Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E470E749
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238465AbjEWVXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbjEWVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:22:59 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5212C184;
        Tue, 23 May 2023 14:22:56 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NGHLiY025348;
        Tue, 23 May 2023 14:22:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=GDa96W0yqju6QY9w8TiRZUlcaIMcWm8iUgGAJhnXHCQ=;
 b=Wo7Jgh/TsGNyDN7VKgsUh7QZjMH0fqLF0GVb01F3WtJqTqZZSjz3jfO1YxjmXwtupIgO
 XquHO3qt9NRIUJCnoa55mTYS/MV5fNSSr0Cf0pPgbil5bWVUK8bBpd5rXqKhruqyJaRC
 vdJu9M1PI2aPHm4pw8dd0lQr7SxKjGXAtSh3pLpGJ1v5U9UEmBgByh7JtI6qeEzzRvCZ
 OCea0bXOoQJOelz8inX12rTk8GcoaiOVvyVGOOIk/MQmL1tZjQXkRImitYIWM5B6v+5l
 gpd1vPkAZJVZcHlT5fmqkCceT0IEXx950cSLc8yqAHFp7UjJxreXFbFZ9xyTPGF/lsy8 pw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qpw7mdtfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 14:22:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684876971; bh=GDa96W0yqju6QY9w8TiRZUlcaIMcWm8iUgGAJhnXHCQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KX40xEuqkVOOO4mPDgZkldtobiAUMX7IvDdXG/fAhwFZR8goQg1ymfh23WlrutKvY
         sAElTxugeRAHuyaQJEBfUg7Nxt/gG82ReNWmlcp0P9kY0zr5Q8EVYNfRIwivGk01Tw
         yqv+eXlNWYd9wUllSkKbZARP66n1AnvHGgtyr6wIJN8ZrjR46qvuootTzdLvbjuZ86
         tqVauPg4FZcSavHWZIH53yDV8TrAlgsYgzlBHK+dCUgv3WnGyXHQQr05yC3tVeKb8S
         mJBJkHh8aKDLlAdH5lkGuWI8QVOMlO3kPXSBPxtjEZBf6NdTS5l9Qh/0dilFiURq+E
         iAS4aG8pnc5Uw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 036B74048F;
        Tue, 23 May 2023 21:22:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 233B0A0071;
        Tue, 23 May 2023 21:22:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=YWpzww2i;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4C50040609;
        Tue, 23 May 2023 21:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln6yfqwluHxdWdgwkPQqBG8rIWrAQE2pmfcHuSM1tzsFboim+ShQxOLxq+knY4umy0fREdQ9JyTp7t4bdLtLe8e/ja6pUGJeQocymfFOjibzwNFIjt0C1rh6Jc/UKgMatVINJY52dd7/f0KVbC6MYaQXzUIFqMWphQo4h2opRp6PVQXNq1HmbySpX4/Ck4U6y1NujX2TGF15QPjfxrX9ANu9Ao6/6l36wPKo6v++UTUNJ0qSRd/r9PBeJ8W53ShjOtqwQIdw9OuSiQO/SXaHQgal8v3N67F0UKwsFSXaBxE3P5B9hJB8x0ZbShXleVfCqnOBCt4KxQ02lPvKjA1neA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDa96W0yqju6QY9w8TiRZUlcaIMcWm8iUgGAJhnXHCQ=;
 b=NQbA1AisU/feIG5u7yt0/uCZsL8XcfcW2B8Btvnw9vcf4kEI31yw4Zy6cx6mf7OC4YSvd0rJeqmu0PtXRQOoaVmiFmWXfObC/wPEOiIiDhWnu6LaJDlwKncOCH4q0wegZTDc3XL3oGL/r3k7w2xf/FLqUvIFe9Tb3pEeAjqePjS3nOabwzanSjIrlXkHbrUwGRyIzBMM0jZUytn444lVVuYri0o1seePUx5y3ve+bxICzaXPBoR7iE3+vjYvGmNWusrJDTVu8urqJsgH+SpYDS/knxPjY0kRIQU6zxQgi6G1mFm8unhUD2m11NbgP3GYHp23s7S9YzbA6NOQZFNasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDa96W0yqju6QY9w8TiRZUlcaIMcWm8iUgGAJhnXHCQ=;
 b=YWpzww2imHR4fgDcAGQf64wpGCn/T/tk5hBLoFp0XPP5Ux0jkjZjZgH8Yp3W8ui9MxXcCNcR5eTKBel3g56nPV2aK/b80NgCx3NmrfYQ6x7dedKcMFQNOvcVAXhr4nStrpNw+KJVstKARZIncfhBbcsif6OfSjrvKymaAHM6zOg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 21:22:44 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 21:22:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [RFC] usb: dwc3: gadget: Fix amount of data copied from event buf
 to cache
Thread-Topic: [RFC] usb: dwc3: gadget: Fix amount of data copied from event
 buf to cache
Thread-Index: AQHZi8uJ8yaHXEonWUKmsB+vQuMnU69mzdyAgABFewCAAU57gA==
Date:   Tue, 23 May 2023 21:22:43 +0000
Message-ID: <20230523212241.av5tts233p5hlodm@synopsys.com>
References: <20230521100330.22478-1-quic_kriskura@quicinc.com>
 <20230522211651.rr2r3caz6ni7m6xr@synopsys.com>
 <e0f0275a-9418-5aa7-58c6-4ac9ae03e0ae@quicinc.com>
In-Reply-To: <e0f0275a-9418-5aa7-58c6-4ac9ae03e0ae@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5349:EE_
x-ms-office365-filtering-correlation-id: 4ab223b3-0492-4a2a-4d16-08db5bd3d883
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPIRkEYEI35H+3ibI4U2Is3+YunOPTDD2pN+rAGT0esQygPSxX/DPHFEoJQ21fNvDQMNynzYwehIx95O3H7A+0CaSLXCME0gwIsm1B6NaxcfvBBYS0BZDSoqgo+EI4A3n/YHaVpB6V0NJQ8tWPF4FUIciW+Y3qtq671z99A0ykBjQHiibA8MPMyovZdgiWYKytlXKPmzR/Ej9wTf4dSAkNZcPQ0qqxlkynUKXazBh7UZ1tMXu0jf6MKS/A6vwu02gLlI9+925IVak8RDZ6FYMBrJmibjK9igFsb5UfofqgilO0Kn/iqR0adPyaKPVMJTTaOgAA6FC5teSBQUne17b/RJc1ikkTkicU1mWnkrHY+/zlU1VfuiOJrOlEjpB/GIRcC5NzfbFJWTW5jdwAIJGGXnDeFIB5YA+ofwCriWb32Z+2gd7+0s56qpZD7M8yIY4/VCxnm/6UZnT5kWayzqVJm8LBbtjXDN8H95tXAvDov4rFHPVnKPEjK5Gw0H2XHvpY0ViIrM0rdyy34mXEFY+y59rqqEw8mLNS2GFvQqCqov/Vub8jcFkbdHPRMEUntK7O+jlG0JvtyeGaqr7QAEwZw72TfVfc9yXuUw9R7lFbNXWatbq5C0JbpOZgpL5UXa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(478600001)(66476007)(66946007)(66556008)(66446008)(64756008)(76116006)(4326008)(6916009)(6486002)(41300700001)(316002)(54906003)(71200400001)(5660300002)(8936002)(8676002)(38070700005)(86362001)(38100700002)(122000001)(26005)(6506007)(6512007)(1076003)(186003)(53546011)(83380400001)(2906002)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTB1cHlNRUdNYmhHSEV0YlRVdnZUaFc1bnh5U3lhQTd2SXpuZzYrdUx2SkFa?=
 =?utf-8?B?TzJLanptQ2FZQzBNSkUvU01KRklaR1JOVkwxV1NUcm41eVZNL2lEcUgyT3Zj?=
 =?utf-8?B?b2hvamhsVnBJbWV4T2dyWXJLbVc2Q2h2VTBZY04ybk9WWHdDUFJwdEFLdzRF?=
 =?utf-8?B?Y0RycDdKdUF2dWNIK3djVnBYZHRoR2lVdHpjSWdVQm5rRTFucDdKVUFzMGFL?=
 =?utf-8?B?cXFQUGt5K0ZyQzB5a1BPYmVYeDJTdjNxb3ZOQ0tMa3dsZkU0dmVMYjJPaHhw?=
 =?utf-8?B?akdCTCtqRG9hMnh0Sjhpbi92VC9DQnlYQXk2bWxNeFVBc3NJSE05SDNKNHo5?=
 =?utf-8?B?dG5qa2huRlVDMFoxMHpLM1hQaEVKZEdIY0psQURHL3lhUDJLSDlKUGk2b0Q4?=
 =?utf-8?B?eVdtNkJCYWdLdnVVZjFRbUxmekNKditvQWZFbTFtR1RXTVNVMUIwdXNHa29I?=
 =?utf-8?B?R3NXQ0pPMDdGd3orVnYzZVNlN1Z6Ulg4dVhkL2k5d0xMQjB5VHpDMXBsUklP?=
 =?utf-8?B?ZGVvdVVrbm5JL3k2YXJDaGYxalBCb21nc1NFN2FHbEdXQ1RwOFp1N0xFNkdI?=
 =?utf-8?B?WllTQlc0Q0Y0ald2Zy9OVnkyazhwL2xia1MvZkVyUnJVclE4dWppR29vTU1M?=
 =?utf-8?B?Nkl0ZXJXR1lBSmF6RjhSSlRGVTlITkE0aHNFM1lFV3RwbkJobmhhQThqdHJv?=
 =?utf-8?B?YUpYakF3OGpjY2dJU3BoTUlZclBmREEzVE5YOHZ2cW1VUlV6elhJb0tUb3V0?=
 =?utf-8?B?WlN5cVBQL0w2SzhKYXlxS2xYVWxyOGVjdTJvL1E1bFJ1S2ZPb0M0aCtDNXJ0?=
 =?utf-8?B?dHlBZE5oSlBiOWtQeDZhUDlTU0JQY3p6UThGT3BkeEk3UEhHeVNFaDdHQnlG?=
 =?utf-8?B?VU5QaHdLNzVHc2I2aGk5RWg2bjBzU0Rzbkl1bE0yMVlWOVN0eldpa1djaTFn?=
 =?utf-8?B?UXB6d0JrSjZrQVlBSDIyeXFFMVlkMUZGdTVCcEZoNkovYit6RDh3Q0Y4SGxJ?=
 =?utf-8?B?a3M0R3lFN0ovdzlTZmRpSzRFTVJSZjJycUMzK3ZyLzZERHRTcGwwamlCaHpj?=
 =?utf-8?B?aDhoSWR3M2k5WlFwZnVEa2FWMW9tQUhUdzVqQXpiOWVsaERwWjMrbmlkaEI0?=
 =?utf-8?B?STBLWWpMY1RhOFF4Nmw2Nm1FZDFLREhYaHNYUkVaL291M0pqdHlTVTJiWEFn?=
 =?utf-8?B?UmNjTk1LOUdZMlozU2VrOFJ1dm1qT1MwSWhEbWVJVEhQcnhJQUZ3SThQeXkv?=
 =?utf-8?B?c2dPL2pydE84N2tRRWhaeE1YdWhreTRRN1JkWXhQcU1pdWZEY2xDTkxnYk41?=
 =?utf-8?B?dGFpU2QzWUt1MFY2d3dQWjljemVtN2NuUmQ0L25aaytUeVRUNnVIdGVWeHVF?=
 =?utf-8?B?THBBYkt1c0NUNmI5b2dOVUJVeEt1dXUxQkVmQ0dhT0d2UklMOWllUnVDWm92?=
 =?utf-8?B?RW85dlo5UDZidzc2UHI4Y2c0NEZtRERJWEZBQXYxNU4rVWhKYm9mYVdHdTZU?=
 =?utf-8?B?SjdoTFQ1OTV3dWlZQlRuazY1UmhxenREdDNsNFl6UVZJc09QYjZEWHYzcDBQ?=
 =?utf-8?B?UGtKWXF1TzlHU1ZoWCtBMi9TTkhudjJKclhMalc1b2c3Mm45REFkQ0FnQjRS?=
 =?utf-8?B?NjdNRWF5YTBySXJEZXpRYktBMStYV3BVem52czF2dmZnV0NMSElhYm0yYWZW?=
 =?utf-8?B?Z01ic0R2aG9nc2V3d0hEaFdzUFpENkJOMlNjNUxCZW9jMmR4ekVXM3NKc21H?=
 =?utf-8?B?TnUxSWVjTStIRnZ0SXg0VGJCZWIxN2N6MmJ3bzNYZVI5RXRWUUY0eUp5Z3dE?=
 =?utf-8?B?dmI1TDlJUXVKR1lPRjRrZlp5SVFMZEorYW8rclVUaE1VS1dpK2RjeG9YOCtl?=
 =?utf-8?B?NHpoTWVSUVFhVGh3bFpDRk5BV1JVMUR5K0lvMHFCRFpNOEhCeUtDRnIrQnhL?=
 =?utf-8?B?M29udnRiOFQ5UStxVHhyRThXSmtVWk9jdDVyNlg3aFJvc0hzdmxncER2OUs0?=
 =?utf-8?B?R0k4YitEYkN4SjlFNmo1Y0VVVmZ5aitITmhNWmk1ektXRXl1cURxNmRrY1hl?=
 =?utf-8?B?dTYwaUk0TVlRM01wUE5JS1p1S3NGbGRzYnFvL3F0MFpXOTZrNXNXaU5wSWtZ?=
 =?utf-8?B?aTdKM0dlZjJmd3c4ZWJqck03WWs1Q09EcktkK2FKdWViUUpIbkFFbElIODgx?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D805C511471A234183F12855C6929E35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BeHe7e9qKHs6ZYfdAKUsxiR3sqO8t9jVRl1X9huUvxe1zWqZwwvR6WJ7A4mJ1MgD1X/IL5PiKtZZn2Hz6xpSFi24U8JYZxYzq4TReQAa64cPVv2uohDCPCTrtpfZ1lUQy2KOGgNKwdcHyULZiTLu6walqI3mRVWm6eFGF8V94b6WtTdxod/ZcDoy89pZEKQlVkUIK3XybOfGs3FylYYO1YuS4IDcZGaBJyXSD3xEbSvVB1WAn11qESOsYoNIt9hNYN0/APzLKmRfqtXPwCC4nOEtwRIZm7cv589pSl1CJKlFMQoNuAeLF+sJ+PuWQPHbnRn6WwrGdGeu3z+F3f/Wl1+eqxJ+jJ9bMwg+PlFY6bo4k+GYt2v1oDXltKMywhDRKAgu/lFKvkbDo3y+OzCmYh7Wc4EOJXqQLHzcjzYt4d0XDO7fhOvqZIvtz3Ypmhn+nWanQw/6P74JUMh8rr6HnOFFkbTjuxF+q0sCIPM7bhejwRExdR59O1JRSjZTiREt9bQXh+B9EyaPQ3jRVELfuzOqyks/rOYMzfhbjSDBWZDs9seySothD77mLpuFyK3QXknGxE6aY08mSF+XlllWgmhZJcak4BGXbBvvkNxGeimBVrZRZze9PEh/iilfFOhHvjOmgaRDkOQmFe0xN/Ltv7lZHTtC78YehPwewe4QbaimWcz1sTYxwHo3oNgeiVx3YRlVMJEmjoCCl4Lxg9xxyx8lzVI+eJRnZLRkrxQdxS/gfNFk7/xzM4vLAb2zcW0kx/yad+Vhx98CUnRsTl5QH8cmlH8++kmHh9/bOuvtsTbj4rd7lznPt4hg/CBZuPS2791zZ+MQIIbCAcIYaXpbhiNm+95MbgsRa1nbOYGV7/V5MJJbwG4wBbvHsh326PtAfe80Q7x1NYYm/vlNtGR+pA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab223b3-0492-4a2a-4d16-08db5bd3d883
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 21:22:43.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JQbLOcwHWTl3o8XsXLFwY48owCAJfHsyX8q+dW1PKFp9Tc138wU/W1soR5cl0eo3pPd0yV4RC6fsieyhk79KAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-Proofpoint-ORIG-GUID: fvFnD7Tt6hplrb1gr4kJaZB_pAn_gKzD
X-Proofpoint-GUID: fvFnD7Tt6hplrb1gr4kJaZB_pAn_gKzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_13,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 phishscore=0 mlxlogscore=851 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305230170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXkgMjMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8yMy8yMDIzIDI6NDcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBT
dW4sIE1heSAyMSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4gPiA+IEluIHRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uLCB0aGUgY2hlY2tfZXZlbnRfYnVmIGNhbGwgcmVhZHMgdGhl
DQo+ID4gPiBHRVZOVENPVU5UIHJlZ2lzdGVyIHRvIGRldGVybWluZSB0aGUgYW1vdW50IG9mIGV2
ZW50IGRhdGEgZ2VuZXJhdGVkDQo+ID4gPiBhbmQgY29waWVzIGl0IGZyb20gZXYtPmJ1ZiB0byBl
di0+Y2FjaGUgYWZ0ZXIgbWFza2luZyBpbnRlcnJ1cHQuDQo+ID4gPiANCj4gPiA+IER1cmluZyBj
b3B5IGlmIHRoZSBhbW91bnQgb2YgZGF0YSB0byBiZSBjb3BpZWQgaXMgbW9yZSB0aGFuDQo+ID4g
PiAobGVuZ3RoIC0gbHBvcyksIHdlIGZpbGwgdGhlIGV2LT5jYWNoZSB0aWxsIHRoZSBlbmQgb2Yg
NDA5NiBieXRlDQo+ID4gPiBidWZmZXIgYWxsb2NhdGVkIGFuZCB0aGVuIHN0YXJ0IGZpbGxpbmcg
ZnJvbSB0aGUgdG9wIChscG9zID0gMCkuDQo+ID4gPiANCj4gPiA+IEluIG9uZSBpbnN0YW5jZSBv
ZiBTTU1VIGNyYXNoIGl0IGlzIG9ic2VydmVkIHRoYXQgR0VWTlRDT1VOVCByZWdpc3Rlcg0KPiA+
ID4gcmVhZHMgbW9yZSB0aGFuIDQwOTYgYnl0ZXM6DQo+ID4gPiANCj4gPiA+IGR3YzNfcmVhZGwg
ICBiYXNlPTB4ZmZmZmZmYzAwOTFkYzAwMCAgb2Zmc2V0PTUwMTg4ICB2YWx1ZT02MzQ4OA0KPiA+
ID4gDQo+ID4gPiAob2Zmc2V0ID0gNTAxODggLT4gMHhDNDBDKSAgLT4gcmVhZHMgNjM0ODggYnl0
ZXMNCj4gPiA+IA0KPiA+ID4gQXMgcGVyIGNyYXNoIGR1bXA6DQo+ID4gPiBkd2MtPmxwb3MgPSAy
MDU2DQo+ID4gPiANCj4gPiA+IGFuZCBldnQtPmJ1ZiBpcyBhdCAweEZGRkZGRkMwMDkxODUwMDAg
YW5kIHRoZSBjcmFzaCBpcyBhdA0KPiA+ID4gMHhGRkZGRkZDMDA5MTg2MDAwLiBUaGUgZGlmZiB3
aGljaCBpcyBleGFjdGx5IDB4MTAwMCBieXRlcy4NCj4gPiA+IA0KPiA+ID4gV2UgZmlyc3QgbWVt
Y3B5IDIwNDAgYnl0ZXMgZnJvbSAoYnVmICsgbHBvcykgdG8gKGJ1ZiArIDB4MTAwMCkuDQo+ID4g
PiANCj4gPiA+IEFuZCB0aGVuIHdlIGNvcHkgdGhlIHJlc3Qgb2YgdGhlIGRhdGEgKDY0Mzg4IC0g
MjA0MCkgZnJvbSBiZWdpbm5pbmcNCj4gPiA+IG9mIGR3Yy0+ZXZfYnVmLiBXaGlsZSBkb2luZyBz
byB3ZSBnbyBiZXlvbmQgYm91bmRzIGFzIHdlIGFyZSB0cnlpbmcNCj4gPiA+IHRvIG1lbWNweSA2
MjM0OCBieXRlcyBpbnRvIGEgNEsgYnVmZmVyIHJlc3VsdGluZyBpbiBjcmFzaC4NCj4gPiA+IA0K
PiA+ID4gRml4IHRoaXMgYnkgbGltaXRpbmcgdGhlIHRvdGFsIGRhdGEgYmVpbmcgY29waWVkIHRv
IGV2LT5sZW5ndGggdG8NCj4gPiA+IGF2b2lkIGNvcHlpbmcgZGF0YSBiZXlvbmQgYm91bmRzLiBN
b3Jlb3ZlciB0aGlzIGlzIGxvZ2ljYWwgYmVjYXVzZSBpZg0KPiA+ID4gdGhlIGNvbnRyb2xsZXIg
Z2VuZXJhdGVkIGV2ZW50cyBtb3JlIHRoYW4gdGhlIHNpemUgb2YgcmluZyBidWZmZXIsDQo+ID4g
PiBzb21lIG9mIHRoZW0gbWlnaHQgaGF2ZSBiZWVuIG92ZXJ3cml0dGVuIGJ5IHRoZSBjb250cm9s
bGVyLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWlj
X2tyaXNrdXJhQHF1aWNpbmMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBPbmx5IG9uZSBpbnN0YW5j
ZSBvZiB0aGlzIGNyYXNoIHdhcyBvYnNlcnZlZCBzbyBmYXIuIEFzIHBlciB0aGUNCj4gPiA+IGRh
dGFib29rOg0KPiA+ID4gDQo+ID4gPiAiVGhlIGNvbnRyb2xsZXIgYWx3YXlzIGxlYXZlcyBvbmUg
ZW50cnkgZnJlZSBpbiBlYWNoIEV2ZW50IEJ1ZmZlci4NCj4gPiA+IFdoZW4gdGhlIEV2ZW50IEJ1
ZmZlciBpcyBhbG1vc3QgZnVsbCwgaGFyZHdhcmUgd3JpdGVzIHRoZSBFdmVudA0KPiA+ID4gQnVm
ZmVyIE92ZXJmbG93IGV2ZW50IGFuZCB0aGUgVVNCIGV2ZW50dWFsbHkgZ2V0cyBzdGFsbGVkIHdo
ZW4NCj4gPiA+IGVuZHBvaW50cyBzdGFydCByZXNwb25kaW5nIE5SRFkgb3IgdGhlIGxpbmsgbGF5
ZXIgc3RvcHMgcmV0dXJuaW5nDQo+ID4gPiBjcmVkaXRzIChpbiBTdXBlclNwZWVkKS4gVGhpcyBl
dmVudCBpcyBhbiBpbmRpY2F0aW9uIHRvIHNvZnR3YXJlIHRoYXQNCj4gPiA+IGl0IGlzIG5vdCBw
cm9jZXNzaW5nIGV2ZW50cyBxdWlja2x5IGVub3VnaC4gRHVyaW5nIHRoaXMgdGltZSwgZXZlbnRz
DQo+ID4gPiBhcmUgcXVldWVkIHVwIGludGVybmFsbHkuIFdoZW4gc29mdHdhcmUgZnJlZXMgdXAg
RXZlbnQgQnVmZmVyIHNwYWNlLA0KPiA+ID4gdGhlIHF1ZXVlZCB1cCBldmVudHMgYXJlIHdyaXR0
ZW4gb3V0IGFuZCB0aGUgVVNCIHJldHVybnMgdG8gbm9ybWFsDQo+ID4gPiBvcGVyYXRpb24iDQo+
ID4gPiANCj4gPiA+IEkgZGlkbid0IHNlZSBhbnkgb3ZlcmZsb3cgZXZlbnQgaW4gdGhlIGV2ZW50
IGJ1ZmZlciBhZnRlciBwYXJzaW5nDQo+ID4gPiBjcmFzaCBkdW1wLiBBbHRob3VnaCB0aGlzIGNv
dWxkIGJlIHNvbWUgSFcgaXNzdWUsIEkgdGhvdWdodCB3ZSBjYW4NCj4gPiA+IGluY2x1ZGUgdGhp
cyBmaXggaW4gc29mdHdhcmUgYXMgd2VsbCB0byBhdm9pZCBzdWNoIHNjZW5hcmlvLg0KPiA+ID4g
DQo+ID4gDQo+ID4gV2hhdCdzIHRoZSBHRVZOVFNJWiBhdCB0aGUgcG9pbnQgb2YgdGhlIGNyYXNo
PyBUaGF0J3Mgd2hlcmUgdGhlIGRyaXZlcg0KPiA+IHRlbGxzIHRoZSBjb250cm9sbGVyIGhvdyBt
dWNoIGl0IGFsbG9jYXRlZCBmb3IgdGhlIGV2ZW50IGJ1ZmZlci4NCj4gPiANCj4gPiBDaGVjayB0
byBtYWtlIHN1cmUgdGhhdCBpdCB3YXNuJ3QgcmVzZXQgZHVyaW5nIG9wZXJhdGlvbiAobm90IGNs
ZWFudXApLg0KPiANCj4gDQo+IEhpIFRoaW5oLA0KPiANCj4gIFRoZSBsYXN0IDMgUlcgdHJhY2Vz
IHdlcmUgYXMgZm9sbG93czoNCj4gDQo+IDxpZGxlPi0wwqDCoMKgIFswMDFdwqDCoCA1ODM0LjQ3
MTY0MDrCoCBkd2MzX3dyaXRlbMKgwqAgYmFzZT0weGZmZmZmZmMwMDkxZGMwMDDCoA0KPiBvZmZz
ZXQ9NTAxODTCoCB2YWx1ZT00MDk2DQo+IDxpZGxlPi0wwqDCoMKgIFswMDFdwqDCoCA1ODM0LjQ3
MTc5OTrCoCBkd2MzX3JlYWRswqDCoCBiYXNlPTB4ZmZmZmZmYzAwOTFkYzAwMMKgDQo+IG9mZnNl
dD01MDE4OMKgIHZhbHVlPTYzNDg4DQo+IDxpZGxlPi0wwqDCoMKgIFswMDFdwqDCoCA1ODM0LjQ3
MTgwMzrCoCBkd2MzX3dyaXRlbMKgwqAgYmFzZT0weGZmZmZmZmMwMDkxZGMwMDDCoA0KPiBvZmZz
ZXQ9NTAxODTCoCB2YWx1ZT0yMTQ3NDg3NzQ0DQo+IA0KPiBUaGUgZmlyc3Qgb25lIHdhcyBhdCB0
aGUgZW5kIG9mIHByZXZpb3VzIHByb2Nlc3NfZXZlbnRfZW50cnkgY2FsbCB3aGVyZSB3ZQ0KPiB1
bm1hc2tlZCB0aGUgaW50ZXJydXB0Lg0KPiANCj4gVGhlIHNlY29uZCBvbmUgd2FzIHRoZSByZWFk
IG9mIEdFVlRDT1VOVC4NCj4gDQo+IFRoZSB0aGlyZCBvbmUgd2FzIHdoZXJlIHdlIHdyb3RlIDMx
c3QgYml0IG9mIHRoZSBHRVZUU0laIHJlZ2lzdGVyIHRvIG1hc2sNCj4gaW50ZXJydXB0IGFsb25n
IHdpdGggNDA5NiBieXRlcyB0byBbMTU6MF0gYml0cy4NCj4gDQo+IFRoZXJlIGlzIG9ubHkgMTAw
LTE1MHVzIGdhcCBiZXR3ZWVuIGVhY2ggb2YgdGhlc2UgcmVhZCB3cml0ZXMgYW5kIGlmIHlvdSBh
cmUNCj4gcmVmZXJyaW5nIHRvIHdoZXRoZXIgdGhlIEdFVlRTSVogZ290IG1vZGlmaWVkIGluIGJl
dHdlZW4sIEkgYW0gbm90IHN1cmUgb2YNCj4gdGhhdC4NCj4gDQoNClRoZSByZWFkIGZyb20gR0VW
TlRDT1VOVCBsb29rcyBjb3JydXB0ZWQuIFdoZW4gd2FzIHRoZSBsYXN0IHRpbWUgKGRlbHRhDQp0
aW1lKSBhbiBldmVudCB3YXMgaGFuZGxlZCBwcmlvciB0byB0aGUgZmFpbHVyZT8gSWYgaXQncyBh
IHNob3J0IGRlbHRhLA0KaXQgZnVydGhlciBpbmRpY2F0ZXMgdGhhdCB3aGF0ZXZlciB0aGUgdmFs
dWUgcmV0dXJuZWQgaXMgaW52YWxpZC4NCg0KU28sIHNldHRpbmcgY291bnQgPSBldnQtPmxlbmd0
aCBpZiBjb3VudCA+IGV2dC0+bGVuZ3RoIGlzIG5vIGdvb2QuIFRoZQ0KZXZlbnQgY291bnQgaXMg
cHJvYmFibHkgbXVjaCBsb3dlciBhbmQgeW91IG1heSBlbmQgdXAgcmVhZGluZyBzdGFsZQ0KZXZl
bnRzLg0KDQpJdCdzIG9kZCB0aGF0IHdlIGFyZSBvbmx5IGFibGUgdG8gc2VlIHRoaXMgaXNzdWUg
bm93LiBGb3IgdGhpcyB0eXBlIG9mDQpmYWlsdXJlLCBpdCBzaG91bGQndmUgYmVlbiBleHBvc2Vk
IG11Y2ggZWFybHkgb24uIElzIHRoZXJlIHBvdGVudGlhbGx5DQpzb21ldGhpbmcgZGlmZmVyZW50
IGZvciB5b3VyIHNldHVwL2NvbmZpZ3VyYXRpb24gdGhhdCBtYXkgY2F1c2UgdGhpcw0KaXNzdWUu
IEFsc28sIGhvdyBlYXNpbHkgYXJlIHlvdSBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzLiBEaWQgeW91
IHRyeSB0bw0KcmUtcmVhZCB0aGUgR0VWTlRDT1VOVCBtdWx0aXBsZSB0aW1lcyB3aGVuIHRoaXMg
aGFwcGVucyB0byBzZWUgaWYgdGhlDQp2YWx1ZSBjaGFuZ2VzIGRyYW1hdGljYWxseT8NCg0KVGhh
bmtzLA0KVGhpbmg=

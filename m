Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5D571F5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjFAWTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFAWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:19:28 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6A5189;
        Thu,  1 Jun 2023 15:19:27 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351KLEwJ019640;
        Thu, 1 Jun 2023 15:19:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=CVqnfU3Xy5qpC9mldelWVQK/U4AG1P0reC+FzuY/dMM=;
 b=k8jGYFtsUCbHYdKte9bOjQ++etQs4Y/ptQUjxcqtr3+q5wkWfPDZimR9ki/NY6H6SxAT
 gux+ugxPuSbtr6pcT0Mxe8dGaJp5blTYcFoEJov36dS6t9LNAoohV2Ok0eByHTu7Os6B
 0DvTqCDgy+xYO6S9FIqLU28ASUjzkoU1lMoeqMcZaLid6LPyGI7lqopqzC5LkyGShTTH
 r4yCLrPE9TAJ7SCHJebyyWbK//SkzF05c8chSHGSKcqNX7Aukx0xE/EAuKfwuji80x+f
 Go31qxON7Ei7C1vTtwXxyYQ24YBGIJKb41CFifV2SWJGyit1QpzVSRUvOQm3IcHC0KgZ Yg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qugsuc5d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 15:19:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1685657960; bh=CVqnfU3Xy5qpC9mldelWVQK/U4AG1P0reC+FzuY/dMM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QpCsmrRiZtWi3E4g97hQZQPA0iBuhiV0ridA3z3oZ4BewfBFWg+asLUokOOpwFzzY
         7Rp1Gu2xFxFAwBGIa41DuFeKdHkOuLMqH/bx83xYTwsvNMP8hC14R2cRTUySYBazqH
         /Qj0Wz1GAw9E5ifBMQbwkTiSswCb7Huwc83fyOCQJ+j5n2jYMU64bZDEqdIkqVXNiA
         g+qb+Mhwcw1u1n1iQ+RuE9uEkw/MoPczmdxbcgmDRni3SAWKQvLH/snn1Thzln09bx
         Xk5fXq7riO97SRnYoAUtAb7QSj10fgcNX0CB5Oxds/5EhhMENm++N65P1CCrwqec4P
         MWr6yC1hy6Jkg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ECE8D40605;
        Thu,  1 Jun 2023 22:19:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 339CCA0071;
        Thu,  1 Jun 2023 22:19:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UZYlPtNH;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id F207C4013F;
        Thu,  1 Jun 2023 22:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF7wCs/GiHr/kqafPImH98UuHQj+fZ0EVFLoceJi6/C25mF1MBYlMvrd5Dst4A451p6JlLsaY6MJi/WUvR4HpkrmibV3Ln+QJHwNEW5xkK9P9JdDStJOJWzr/IfP0ZVvb5qL6znyY+hRuXZWjVEHLnwo+m83U4bFTXAdLia2hZ0s4UO2iTN1n4JjVSkUxcWN/AxV+HGe+ij5W1NWQWyjwDtp5kOL+hLbwKLMWS8tkeIhZtk1s4ZUE1Hgd2qHrX9Sf1DKjRUTSgbTf4DHb0/wmOFeneY5SB/aIaa/zJYKgM4eqPs2aORdnvYVgx8GsUpNK7SugxpUgCsxotOE5BH3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVqnfU3Xy5qpC9mldelWVQK/U4AG1P0reC+FzuY/dMM=;
 b=HXJmdnKrbyOZx1Zs0d4JrK5CsX0Mvocv4pR0SzIHkDkY+iCq+pzkgfU4g9Ar6lNmNsnjPCH3pZbCcn8PK9op+y4684esXLfhmCMbbnMQ87rVOOyAlBBrAP0yyMZ4NDwz08NYzL1gMjhltrjvZwibawNUcWp+r+MZs6nM29PgKvPRe8+Zna3uacFyLnP+/RJJ9VJoC6nkJ18RzGC7JCvir9t2i2iTV9z4PPuIfAd9hIxTou0CsLMhYmEHEK552wdz/tPTwAdKlHAgdSDWpRvGmETwBs0c3qBUXS34u8u/0rS1KZdkHiLLLC/u6huL6NA9FQOqAkdAG2p1XT/9nAmwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVqnfU3Xy5qpC9mldelWVQK/U4AG1P0reC+FzuY/dMM=;
 b=UZYlPtNH2QSDKD/cIE0K2oeQIi524Rua2Im0v5xiSepaGjoZzowpm/eyIsNfnbGjD581gatYK7JaGXydDvos66NDZeLWRVVdDqzGPBqIsHNA/c3KuMLA5jRLU6YbQfOBntBmSdg+FmMm9iMhL7pY2ZH9KzhfqZ3wSoUh0wSogGk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Thu, 1 Jun
 2023 22:19:12 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 22:19:12 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Reset num TRBs before giving back
 the request
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Reset num TRBs before giving back
 the request
Thread-Index: AQHZlM/p+fejoPzXEEW9Hz5l7Szzw692hIuA
Date:   Thu, 1 Jun 2023 22:19:11 +0000
Message-ID: <20230601221909.eh7tbq6nr7lsv53e@synopsys.com>
References: <1685654850-8468-1-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1685654850-8468-1-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BL1PR12MB5349:EE_
x-ms-office365-filtering-correlation-id: 4d39d870-1381-434f-3e65-08db62ee3a0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4zwq90LUoeeygBnEj6VM0KQWorwkm6VJOo24uzKxQKlWCP5EEMRQJfmofAAvQRkgXErfT6kRUJcgw2XNGCv8Vb7GwtoC+d6NWdKkkqk8ddNT0mHFttzHi791VAhhwH7G7jxoOz57o9ZYkmTHRsxvbbxnseGU2uv8dX6J0RtIbfLMVo9aU+YiXiEkMYAlwa1bqmFim9qzRfwgl+JCFIVRDB1onsBcAYyo9Bt9b4XzeUmXdnwhtu5sNIAVtN1Lu365RWws+FjYOb0Z+MN2+ByUXcTsuLgJB5qjgqXU3BE/RYk+pvTTIGy1JXdfz7+NfS4Zlfs1iMOzyucvPRJnYmiht2Hx1l/eO+RUvKc2cdkOZfdHX++FOp7YN5LqJZI3bUjxMD772RMO2TdT0SM2fK2K0eLAP66GNabIfHzy7jQQiQNFoUoQmjkzP1hW/y/U/wrUVFgWyCGzuERVkf4oAqrTtTUbdyG1bS3vnHqAzDPSXyMj0uLGy6ogxAbPzLBv5UIExXjBZrVVYBDSp6HdpugR4nw4CFFRX043GTVTUbySFfztzT235Mx/gnjFAygRQTpzQnJsxSZSrBmtRXLt20TsDHNy1IuueSeiEkXMn7kdgPyVGqJQ62KVim9BAGPsUFb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39850400004)(366004)(451199021)(122000001)(38100700002)(4326008)(1076003)(26005)(6506007)(6512007)(86362001)(2906002)(5660300002)(8676002)(8936002)(186003)(71200400001)(6486002)(36756003)(2616005)(54906003)(66556008)(66476007)(66446008)(64756008)(66946007)(316002)(38070700005)(83380400001)(41300700001)(478600001)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1djVkd0bGxsMGRxRnFDZnQ1VndoajFSRXhqc3hKMU84Z0M5RjFXM0xmT3NC?=
 =?utf-8?B?M2lydllUOEZ6K0tqL1NmMmpoZUU4ZmVwQmkvQkhNb3pQQ0IycVZmTit3c1lX?=
 =?utf-8?B?ZjNyTVExVlJETll3aDBYL1dvTVZIK0twVFpid0lnbzlweUlpcVJpcC80SGR1?=
 =?utf-8?B?UHVHTjVHUk9La3JzbjZZaHFvZlk2WTdXWW90cXN4YldCRWpaOGc2SHFrQVpo?=
 =?utf-8?B?WlhJbHp3Q2xpRXVFaFQxbXhRNTdlK1IvOFVFZEtKN2tyMC93cmtDTCtBNnJu?=
 =?utf-8?B?RzVvTm5mWG0xS3FnU1FKeEZLOXc2dXJPQW5OaTF4VWR4Wm1JbHFrMnBSMWlB?=
 =?utf-8?B?Qk1lT28vbGN3a1dQVWMrL0UwMHNYU2RjbHA2VW95TVUxWEpKRm5rc1FyQWNy?=
 =?utf-8?B?NEo2N1NOWmdZT1lSOWMvcDBTZUJMa3h6RGVabk5BMlh5d1VTb3BzbnJqMEp0?=
 =?utf-8?B?QTRRQTVTMUJVUzA1WnVBaVFFTG9GUkp2OWVaenY3OGFnZkwvZytnZ0Z4WWc2?=
 =?utf-8?B?a2twTmJoUjFKVTJSMDV4Tzl6VU94akdiOEtKWDZBeUMyRENKeU11K3BYZGVE?=
 =?utf-8?B?WS9wWXdadTRaenBoT2xrSWdna3lyK0xGdTN3dGpyUkE1d3IxWkdFSnZVemtt?=
 =?utf-8?B?MVdmUU1WNnhTckpwalRKOEgzbVJWaHZiZFRzUm5UaHJicEVZckxYbUYwVlFL?=
 =?utf-8?B?VFBrMHFZNjNlVTI4amt1eUtxZ1dNNXVNV3ZDN2tBN2xEYzVuSjlLSGJYTnMr?=
 =?utf-8?B?R0U1Wk9QMjhIUGg2VXRoVkJEUFFreGxEUkxRZXphSWR6bllDY0UwUnQwZktl?=
 =?utf-8?B?T3hPYTRUa0xmYU1mWlljV0NWSWVMZ2FPRnJtSDFyamZEUGxSZkN4clM1dzMw?=
 =?utf-8?B?cTdiaVlrRlcwWS9OMkdaYVZGUjlybnpVbXdIVXEwV1lxaldEVzhML051dVk4?=
 =?utf-8?B?dVVMaGVoUFdQeFI3K1gwdDdyT21QRlRpVVVnMmlwZTd5cUVkdVphVzN2a1Ar?=
 =?utf-8?B?aTJkNXlKdndnVVc1NEgyNWhXZ1FqRmdMRUJ3bGFCd0tJdFY2MnFlYVB1czNJ?=
 =?utf-8?B?NWxqNStUck16YVQ5aXBYRXhObUtoNVRFNm5YU1dacndQM2FZbnJVcSsySlNw?=
 =?utf-8?B?NE95cmJ2MVpCRVplVE9BdGFlSEd4YkZXRGJ0bXFuL2RiM1lFakFsMzV1S250?=
 =?utf-8?B?S1U0bW5JTVRPUDROWHMxOVNxQ2xtTVNaaTh5K2hjeFB2WC9kYVRZbVdHVW5O?=
 =?utf-8?B?cllMNXhOS0M2NkV2MjJQWVU4ZEdHOHczZTQrM1JLdG5sSGhJT205N2xSUTcw?=
 =?utf-8?B?QlN1dytGcnpLUnlkZnRnQ2RRZWFqYXltaFBVQXcycW5Da0ZlOVdIUE5PQjJz?=
 =?utf-8?B?MjV0dmlFaUFpZHFrSC9XZXlOeVM3RGdWRlN5b2xDd1JpSHBsekVaWGVXekVV?=
 =?utf-8?B?TlpYYmY4WkUzY1AwSzAxZ3BlNm1ucUJoemhDNzdBTFQyUy9uYytsLzk1SmJ0?=
 =?utf-8?B?K25FMDN3Ryt5UkVFd0RBT0NzUEZXQXZvM3pycWo5THEranVTSEZkdmg5MjZl?=
 =?utf-8?B?Zlh0bzVVemVhSngxKzdSUG5xUHdBWXIxTU0xUVd1d3JESmpTMEFWOEJJVC9s?=
 =?utf-8?B?a0FrbTJGUEpUa2orR3Q0dzh2UExZK21OS083ZHE3eTZwcC9LdU9RelV2TWJ6?=
 =?utf-8?B?V0FuVzc0ZFB0UE9PNkl3bDk3SkdRM1VaQW4xalNnN0F1b1o3cGhFV2lMRENl?=
 =?utf-8?B?Z2lCS3JwaXpuK29aOVB2VUt3MUVOSXVTb2RacVJIK3czU2psNjVDZGhEeklm?=
 =?utf-8?B?TTZGTm1zdnlDdFVzV05xY0xLVkpyR1A2OG0ydzV2ditQNFFPdnRISXlxaDZy?=
 =?utf-8?B?ZnJTZE1uM3VzanJxa1p2WDZvWGtwN1hXeEk2cmZzWTBzNy8wY0EzTHFla25p?=
 =?utf-8?B?OEdoRWxVb2VTMjhnVnAvZGVhY3BFY1ZNNHdHM01nNTgwSWJMQ3c5cWhJOXA4?=
 =?utf-8?B?djhaRDFsZFU0YXc3ZFh1NWZiV3VwQ1A5MlgvL3U1R1lLYnZRNHpJTVd4MktJ?=
 =?utf-8?B?cnRLam83MEhkS2puc253MGhIWU0yMzJXUGRYT1FQRjlMUS9TdlFYZXIvS09K?=
 =?utf-8?B?OUh2RmZFNkI5UU0va1JFMzdGbEJvT0R3VnliY20vQzN4TVNEWklRd0JlRUtn?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AEEB3E669BE0F46A027D1AF0898B51F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MrxGmU5Cvkd3lh/jD33CHkvJ3wrRyLdDNGLrUNPzUsdSG3NMF/noB1fGDZfQI+5gAyr1icOH+Q37uTkPvagQELIO11PRRbRof7OBq4DdF5PEtofCxo/NITwICIikWi4EsZ2ZbmSEgISlcNYKf8XBv8xnAiIJc2r6VxPkCC7ac3823pSoQyC2Y3oBFYA6fm9luDSO1X+0W/z0hCFwiUJQR+zNk6Bz6op7cYIAzY+yBS/OUH/TlrcW1ZaPwJ33OEGf2OhGNojFBkjt5XvvVOgaO7I0oEOO25kqDre1c0xxBSYtMMZJ34kRGgQiPAZnZIuiwglzI4ffWRF94dU7xkS7AlJHycaj1pezalBR3KKXtg67JRzetFu2lwxzpmxKPhfPau3l2oITzUR+NhufDYFEDgATqjAzpU05ZPIBjVkVH63Th11mfAbhmwiY5E3hJjRBM870YBHwlFs0gfz6K9zUiPa3t0wrVaXbgoOLYYSMcTsL1LjQVcYmCYIWJdX3+ru3dxoWzwfKe88NqKsiJpeIyDbzGoFteousqHuIN6Vo3+t0N/UfER1VNTxiCc37tITReoe8ybnkS8ZPmqs3ZAsWLzZfqERaIbFEI1ZIraDcr2rIWqAtCzfvn/X3vWc8K00dOmDybiJrye7NC77EcuA2N/UBap5hr9/60qy9NcWypteKAcTb+cXDejFpKM4iB39rgHXslhfhVLlJgum9/g0t5vuRlgSU4U1jFnBTZQbnHCmWXy//SCJCD+9ZCkOsX6Mw2JMfgNaWmqFooo/jCZsIADd87cL2dJ/fOiqGpiMvzYyrnM1+gUX51gZhx9JBZs1CDCluPqjLNNF93MDsGs1FbuFTA9JhiMygMJg+UQTquYlOx9QbPkEie844yVxZpdKnNtnnp1iln9uF0IFW0e44VQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d39d870-1381-434f-3e65-08db62ee3a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 22:19:11.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dpRRDyILuViU+rndHZvSsjTlrxnhAHl87y9VrkXXcjE4vVB8PRa3pePxhKLAGBhNoyZkzUzUpTX4uzDqUb/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-Proofpoint-GUID: 6wXGx2GI58N-z0dLxS37GWSsau1HYLvM
X-Proofpoint-ORIG-GUID: 6wXGx2GI58N-z0dLxS37GWSsau1HYLvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdW4gMDEsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IENvbnNpZGVy
IGEgc2NlbmFyaW8gd2hlcmUgY2FibGUgZGlzY29ubmVjdCBoYXBwZW5zIHdoZW4gdGhlcmUgaXMg
YW4gYWN0aXZlDQo+IHVzYiByZXFlc3QgcXVldWVkIHRvIHRoZSBVREMuIEFzIHBhcnQgb2YgdGhl
IGRpc2Nvbm5lY3Qgd2Ugd291bGQgaXNzdWUgYW4NCj4gZW5kIHRyYW5zZmVyIHdpdGggbm8gaW50
ZXJydXB0LW9uLWNvbXBsZXRpb24gYmVmb3JlIGdpdmluZyBiYWNrIHRoaXMNCj4gcmVxdWVzdC4g
U2luY2Ugd2UgYXJlIGdpdmluZyBiYWNrIHRoZSByZXF1ZXN0IHdpdGhvdXQgc2tpcHBpbmcgVFJC
cyB0aGUNCj4gbnVtX3RyYnMgZmllbGQgb2YgZHdjM19yZXF1ZXN0IHN0aWxsIGhvbGRzIHRoZSBz
dGFsZSB2YWx1ZSBwcmV2aW91c2x5IHVzZWQuDQo+IEZ1bmN0aW9uIGRyaXZlcnMgcmUtdXNlIHNh
bWUgcmVxdWVzdCBmb3IgYSBnaXZlbiBiaW5kLXVuYmluZCBzZXNzaW9uIGFuZA0KPiBoZW5jZSB0
aGVpciBkd2MzX3JlcXVlc3QgY29udGV4dCBnZXRzIHByZXNlcnZlZCBhY3Jvc3MgY2FibGUNCj4g
ZGlzY29ubmVjdC9jb25uZWN0LiBXaGVuIHN1Y2ggYSByZXF1ZXN0IGdldHMgcmUtcXVldWVkIGFm
dGVyIGNhYmxlIGNvbm5lY3QsDQo+IHdlIHdvdWxkIGluY3JlYXNlIHRoZSBudW1fdHJicyBmaWVs
ZCBvbiB0b3Agb2YgdGhlIHByZXZpb3VzIHN0YWxlIHZhbHVlDQo+IHRodXMgaW5jb3JyZWN0bHkg
cmVwcmVzZW50aW5nIHRoZSBudW1iZXIgb2YgVFJCcyB1c2VkLiBGaXggdGhpcyBieQ0KPiByZXNl
dHRpbmcgbnVtX3RyYnMgZmllbGQgYmVmb3JlIGdpdmluZyBiYWNrIHRoZSByZXF1ZXN0Lg0KPiAN
Cj4gRml4ZXM6IDA5ZmUxZjhkN2UyZiAoInVzYjogZHdjMzogZ2FkZ2V0OiB0cmFjayBudW1iZXIg
b2YgVFJCcyBwZXIgcmVxdWVzdCIpDQo+IFNpZ25lZC1vZmYtYnk6IEVsc29uIFJveSBTZXJyYW8g
PHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAt
IEFkZHJlc3NlZCBUaGluaCdzIGNvbW1lbnQgdG8gcmVzZXQgbnVtX3RyYnMgaW4gZHdjM19nYWRn
ZXRfZGVsX2FuZF91bm1hcF9yZXF1ZXN0DQo+ICAgIHJhdGhlciB0aGFuIGNhbGxpbmcgc2tpcF90
cmJzLg0KPiAgLSBNb2RpZnkgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIG1hdGNoIHRoZSBtb2RpZmlj
YXRpb24uDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDEgKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggNTc4ODA0
ZC4uMGRlZDkxOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xOTgsNiArMTk4LDcgQEAgc3Rh
dGljIHZvaWQgZHdjM19nYWRnZXRfZGVsX2FuZF91bm1hcF9yZXF1ZXN0KHN0cnVjdCBkd2MzX2Vw
ICpkZXAsDQo+ICAJbGlzdF9kZWwoJnJlcS0+bGlzdCk7DQo+ICAJcmVxLT5yZW1haW5pbmcgPSAw
Ow0KPiAgCXJlcS0+bmVlZHNfZXh0cmFfdHJiID0gZmFsc2U7DQo+ICsJcmVxLT5udW1fdHJicyA9
IDA7DQo+ICANCj4gIAlpZiAocmVxLT5yZXF1ZXN0LnN0YXR1cyA9PSAtRUlOUFJPR1JFU1MpDQo+
ICAJCXJlcS0+cmVxdWVzdC5zdGF0dXMgPSBzdGF0dXM7DQo+IC0tIA0KPiAyLjcuNA0KPiANCg0K
QWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhh
bmtzLA0KVGhpbmg=

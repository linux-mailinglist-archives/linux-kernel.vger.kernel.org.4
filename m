Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33936C834F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCXRYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjCXRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:24:47 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6956E18156;
        Fri, 24 Mar 2023 10:24:38 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OG63HO017053;
        Fri, 24 Mar 2023 10:24:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rMkVGtS6gam6t7aHF9jLa24kOLxMEnR7HVMgLdRSP68=;
 b=VuDb9HzYYf9TScsUWCnKJBgXLpODwOExAO9GGr8h1c6XeOLfGDUYJEnMyG/mbDSF+qwS
 HvNez+X5QzS9HH9iNh5RYmfD4JgcwLXaXQSrEeeJxnFX7999uxUhhlqltjCpsKgU+c59
 96+jA2vb9wPpdCDP2rhdlsCefV9dp7TdBndgBm6tcflEQO0Jk91WCRuFE+ISIdaNr2Lh
 dfsFlOi9iJmCxEQRU19CkeuI4wYNMQxCxadwC1/PXBgRW7R+w+kZ9D9AZN0xpDehJFZW
 sCjbbW7uj8rSMK7jxV+xxa4JPAOuoycgRQxhlHVpXwR1AbsYljXEmCklq1Rnc7DFpsdy Dg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxunw1wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 10:24:22 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8B4A540165;
        Fri, 24 Mar 2023 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679678661; bh=rMkVGtS6gam6t7aHF9jLa24kOLxMEnR7HVMgLdRSP68=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZQ8agBsYSIflulDX0RnLU+9G+WhFFFsq9zdUJK2OPW/EwZD7wR2jFiftVgUfpnAzZ
         D/w5pR3xKFZnjrCIyNwxan8qyP5laVx0Q4DxTxjNVRG9jnMXdWxHIXjppMCaUqfyp6
         rSPdxMyLt8PIhi5Z69dt5sghttAXaZ2mywOKBQsIBCn4pkuAtHjl9XFOG7PGNtmgCw
         7YkZWxoDyQWIgKzQ9cM+LZ6Mtidsxg8qwHizZFGaQ6akCiAYXz6FHDzK6Vn7x7amRn
         eXqfzVPyLYxn1m4BxNb2cE+iyr6jwjg5EuSiRZtUUfb/14r4IdoCMT8mc3Q1FWUaIX
         DlkaV3ir0OytA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BC56EA0063;
        Fri, 24 Mar 2023 17:24:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 757FB800DC;
        Fri, 24 Mar 2023 17:24:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="oktbT72x";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFhT2mxWn/b83OM+UjlPLo3mctoJO6/pDxUPkhFYN1og4G5gRaI+6pReAljwtzBKy2RNGUrzK9dW5XWJLC002wroL7BBWJ7NtNHSI3VlhWQUHvWud1qGMKwOt/AIfkKjtkWFXSA8M2AuqZAcOyDIziBJvwCX42Mk1o/Eb2QYC+hkeMWXMUKdImV0CocVNWSQR1+HGFZSjHTqtR2j+sTuBRu5HZaWT4yjTWX7MQ20q1tkhxNUs99uFpLGk68bfyzKK7Ut3MzAIudCJUsxf4WW+9nwWJYfF5NdypkmsLe8at8HOWL6EdImKAuMaEhxs1L6HufFAdl1IfvbqRk6AZacvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMkVGtS6gam6t7aHF9jLa24kOLxMEnR7HVMgLdRSP68=;
 b=kPLmKhEuhUc0WxlwSeL6wo6zLZmg+EajKDC50bxzjxfkb0PcOTsS+tY97NsuiPYgTo9qqrATturREA+zVqbuOwEI9EANzkRLAej25Wrg43lBavHd660w10zOngwBarkOe5HOadlSRlFQwICgulbcgSKFxIHC3TeJlyxIJvCwkgdQpLqqfrutinvoU6uUoxHbm0YBHWa3RmvQCuYiy/5nSJjCFx0JzJVrO6mTlZ4Qw8aOez4/vAdUNDezft08ZC4adRZfMgGvNs7v+xa6JVC3+JDjY+Gy6Lf9uAJou7p/r1VTwNhrJ/om3FF6nWYlOSzF87UzcmM3qB64pNiEeZcmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMkVGtS6gam6t7aHF9jLa24kOLxMEnR7HVMgLdRSP68=;
 b=oktbT72xB2DHViapaW+r8ADoU0rGWp0Sw0yqyXXVgrXc736i6sd73MsZbtPiAS7KNyos1PFl7FWrfAYKwVdXCywZzoBkfz/uMvNEB5SNsCuhfKvgLBJumM4zsb9OZZkwlzJ7+8hXgPAjhEKt8qea7DRlv7p2p/zBWwcAGsfwWkI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:24:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 17:24:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: gadget: lower informal user notifaction
 dequeue operation
Thread-Topic: [PATCH] usb: dwc3: gadget: lower informal user notifaction
 dequeue operation
Thread-Index: AQHZXaupiPw/2dpwu0W+BQUYZ9zkua8JBoSAgACVeoCAAJOSgA==
Date:   Fri, 24 Mar 2023 17:24:13 +0000
Message-ID: <20230324172413.lpd3cces7byoe7tk@synopsys.com>
References: <20230323171931.4085496-1-m.felsch@pengutronix.de>
 <20230323234103.mx7f3pzvbrrguzqe@synopsys.com>
 <20230324083603.vkbnyygx645fcfxl@pengutronix.de>
In-Reply-To: <20230324083603.vkbnyygx645fcfxl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB6966:EE_
x-ms-office365-filtering-correlation-id: f858cb9d-961f-40ee-cb1f-08db2c8c9699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSJ6U+vYF0JJEHkzVD3S4Qt2zFMhuAcbc9UYRVlYTha3Zq/o0TkgSy0KP6hG+uWrTWXHDBwp0x2XT4yiJZZQNu0JJ/Uvu1+HpJpk9xxIPc6MbmS/a1D7pWKAGs8OpRGqyHNPEJ4oxKJksQMXAiQESdgZ/f1W6wpu+asqM1dv+uiEEHZPD4xazVHRuAztEvyNOBa5kxR0IvEAzQLgRVjQnwbpsEqa8+WD0L/Ywy1U3KqMXLvNg0XQ3lpA5b7FweDhyvJ379cKsY3sWzxrxnvUPlfgwRLkfkBI+lWJLg79KvwbDloO/caBuZ2dKGFSU3ty/XKiGU6Smt+SufEU6dZWjWDo/GrP78x36B/5j6MO9wB0egQN0jhwNGf9Nqe231F1FaVvC0kDhjwhGNxJ05VhWvmtBnqL9UI91hjee8lFPkKseqxVyNUqgRsFVLKKICRQEqZR2jVztFj8D8p6LgeQZb9j1ZgrRjBep/+okCJLNm+7HyJH63rZinp+jOpcZUgdFIeq9FIrZfZN5ICDS+V7KWeHe7NGsYR6T+svfZe5j49Yp54tOF8m8p2qdeXAd19khoCT1Nh7mq6+Q65Kmv3QiDgZRN9wQqx2SVy1l5KlYkYeyHM2YUYEbrqHEsQOCNjsGQrj/WAC7pJRUhyu9i0lgJou6oiEld9CnGkWUqwiV7+OwSRjpLMF+F4wdMqx0sX6L6IFA82k86jKRY8HE8oqhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(2616005)(38100700002)(64756008)(6916009)(66446008)(4326008)(76116006)(66946007)(122000001)(5660300002)(41300700001)(316002)(1076003)(6506007)(26005)(8936002)(6512007)(8676002)(86362001)(83380400001)(478600001)(38070700005)(66556008)(71200400001)(2906002)(6486002)(54906003)(66476007)(36756003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OElTSWYwN1o4cUFmRzNFQk1IQzUxSmF5MFlOVTk0OC96Q0NBQXpuajNucCtN?=
 =?utf-8?B?OVp5cGIrQzJiRVJLRXMyVElKMWc4RFdkT1RabEd4dHhZTlU3WXV3L1hWVDc5?=
 =?utf-8?B?SngyMTUrQWV4d092cW9teG9zR2tEQ2dxendPaFY0UzdZSUpIVk9ZS2hxUlZ0?=
 =?utf-8?B?N0E5QXgrYkVCQTZVeTJ0ekpYcUZjdHN1M1hoWGkwbm9mZ0N6TXVnOGsyL2ww?=
 =?utf-8?B?ci9GM242VStmZDFRdGxVcXVVTkdEL0ZMUzIzYkVwZWRrcWVOMU9WNEJ2czhi?=
 =?utf-8?B?Vml2Y0ZNMmhZdnlaU0JNbmFweEFYM2xNZW1Rb3kwckxVcWxac1FpSGlOemlW?=
 =?utf-8?B?ZDRsYnQvWkdPTElod3h0cGNZbU9UUHRtMVpuQUlkcXh6VWZObUN6UkRxRXFY?=
 =?utf-8?B?ZVROM2dzYjFsRUJjWHJUenNFVndzcTA0Z0wzRFBlU2V6a0xUWlRlRXhQNGw5?=
 =?utf-8?B?TCtYd1NEYVlnWG1sZXFjUjlRbWJJRFRlRklkQ2pTc0hXb3M4SndPT2xyZ3l0?=
 =?utf-8?B?a2djTGFYc0dCdEVnZ2FEdUxjbXo2aDVHYVZ0RnUzTHdwS1QweFRWekJlRVVz?=
 =?utf-8?B?T2JSWlYwL3Z3TTcxZVJ6ai9Tc0Z3aGFyM0lKL1JWR3VaQTEyTUNHbmZHRTRX?=
 =?utf-8?B?cFpYenMzcmx6YTBCQlBmb2dPdm9vdFBiYTJRdHgwQk15aFZqeVRMVmhiS3Z6?=
 =?utf-8?B?SVU3cVN0UDVucVhCb09qZ3kwRlVFa0hlQm9DcTU5T2VIQm9Kenh1WDBVR1c0?=
 =?utf-8?B?RWg2M3dZWnA2TVhQelZKdjFWSEdnSkdTbWdLYlA1VUFtN2dGMndONGZnS2tQ?=
 =?utf-8?B?VzVuQStYTWx6b1lNbU5UUkFncjJPSzA4NFkwRUNhTTRBRm01YXFUaGRJTGxU?=
 =?utf-8?B?bDVsWW8yd0Y4OWtUdlFaODhnd3c5SENySloyQ0NjRFBpQXlpTEtJWUtWMDlm?=
 =?utf-8?B?U3BpRGxETlE2b2xXR0JrVFIxZDIrRjUwYUZCdmNUbXVnbng4dFcvMys1cmtT?=
 =?utf-8?B?TkNUekNNS1NkM09RdC9CTEgwR2lMbTN4cUJQaEQ3d1J3WDYvbUZmRFdUNXNQ?=
 =?utf-8?B?Uzc5T2hycno5cXo3YUFqbXpFU3IrQWRWSlNYOEp0QXlyYUF2cDd0WndYVXhL?=
 =?utf-8?B?WEdNL3Q3cGxoSDRtU1VrSXVLZDZtWDZoNm1va2VBY1pQa3ZBdHpiekNvdDVk?=
 =?utf-8?B?ZXNCQlJneW02QXFWV3V5OW1sQzQ2ckhhK3dndm50NjNxWkxra3FsczM2YUJ3?=
 =?utf-8?B?SkUvSEQxTjFIc1ZMelBjU01nTm5KU3U4M3UyOW1WL1h2RXZZTXVaWjhUOWRR?=
 =?utf-8?B?TEFCWjA0WC9CSlA5T0xPeFFDeXZJQkZ4WWtiU0NLZ2ZVY2NYOEp5YysxUlBL?=
 =?utf-8?B?eFNtV29TS2hRc0llTTBVU0pMdEVTYWdJOFZncmpQKzNuczdVQ2U5R2VOejhv?=
 =?utf-8?B?S0krOERUTTlNN1pNRDNMN2tFWFBhOC9oNVRkeDlwbEE0Y3IyaE1UalR5KzU5?=
 =?utf-8?B?ajdjdFJmanVMMmxXWG5kandyL0gzcGhob3RST25JV0grTUlwaUlTaUd2eGhQ?=
 =?utf-8?B?WmZ5bExBWXdtWDE1RHlnRGlOTDNCVjU0RHpYTUh2Q1JMZDczWnhmSmtBV05a?=
 =?utf-8?B?YU82cFBFYkpiS1NFYXM0bndjZVRNckFucXRJNFh1WkRqWHM3aHo5YnhCZzlB?=
 =?utf-8?B?MkxTM1lwemdNY2xkQ1RRYm1Eb2FUSXA2Wk5TTjBCaWo5Y201Y1lHQ0xJWVRu?=
 =?utf-8?B?Sk8wcFNRZ3h1dFpwL09MSzBSbkh4TjQyejVxSmN0Q1JiYnViTDFsTEkxbG44?=
 =?utf-8?B?M2pHV1RGOUwvWFJ4V0l3SUJMNkJKMDdacmxBNlRtWkRxTHRaQ1lHRlptQXBB?=
 =?utf-8?B?WkpVMHBESGh0TWk4YXVkNExQNHJRNjcyOWZQOVVhWHc1SlMyVXdVbFkwVGFm?=
 =?utf-8?B?UG1YYmJnUDF3dXc4dktMU3BCRGtXcytSdGtOM3RGellOTlJ1aGRQUWUvQ3Nl?=
 =?utf-8?B?VWZiNFhWVjlUanR2WVBSeFZxZmNwSjJtdW0wWDRqKzdHc0tnV0gvRHJBa2NK?=
 =?utf-8?B?NGo5YXJDYXgzdVhBUHhYVFlTUGg3R0FpNmxpUUt6L1BzZjdCK0FDUENXV2Zk?=
 =?utf-8?Q?/O/gh/3Zb15Gd7CpSWIkIkcy/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18F80AE252D1DC48A3E9C4DB67568826@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y+cpx+9dTEHEnsOBs7Dc/cqUnbJthVjyX/Pvmbl55ZW/PEA1KBo6pG8XczrTERxkDcsWDGLsQ3vvWLBrsog/DHjFiQU0YtGaieX7pRnrtlgTMVyL7rCqM88SBiqVC2uceeidPSTzLrU4+aNCndDHb2/qmWdvqdRLsfW7t05fRlujBaC2j6e64Z1sLh6R3Y3JzH5Jw4U9y9rqlzpDOc8PkxRXwIZR4G1jCFLqCeGBZ57todE7bcGIzJFCrT57qnPSxcp5sZgc0tYWzHhLfglIk7CtFyhFXjqhXCOevX0wO4mdWEr8xJzjb5k1yqXBJOeuUCn25iqwrTHlMbdjPhk8hhmimLqpM9YKwPKl2m+pqexJBtnugUpR79ZFRKYXxURlvKm23bP5yVswWWfifj6i7i01PsQewo8j5G7cW5Z+LoWYdo+Tm4qf2H0d9hVgJe9MEYlIA0St8JNSqCoVyMQ/d2F1vBV4PHJqHosldxtxAA0ni0EFl14CyaLc637Ej6cGvuIxjVFo/T2YMPpeSSJo4E+FZgazCz6re1MCP9pk89SXQYf2qvjYdMazEjNZMUORSk704/u/xpij+FFVmL6IP8K2bLETC6+sd3X1l7Wu53+CsxS6ZQnYOdej9o+O3eE7BweOnGuL5EpXZawvkmrjTf+Itqfvj1a+OA7Lodkv/grEmv2b7JivxhCMNyfSannCrvCn6uY2zO1UUDbPcOzQkNmSUaYOcRZdjlwWrpicplI9NqlY8ZxUWFIAdOxE/BASYIpGA/vDNyL6VGP7JKjUxYJRny1fUeGdBHrH14/YGP0751sLcLmbj9UWtVS8Ba+4kC974YVeptpYXov3achyM5L6dD6W9nqtJQHcAt51H+16z+15irOxqhHoRECSNxq6Zq20RrdHLtmt3c4jXXoKA5WbpzbgkWF5m2AW9BW7uKo=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f858cb9d-961f-40ee-cb1f-08db2c8c9699
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 17:24:13.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKburkimbBDx4JypXLRZW0ZyyUduo+kNxepTZh9/SgCqeeDookqM0oLF3Q3Upo+Qd3waIZetlZflZrQGvfI+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
X-Proofpoint-GUID: FHnAw5fMVs7ugluvRGaKMBFtiHlsADtQ
X-Proofpoint-ORIG-GUID: FHnAw5fMVs7ugluvRGaKMBFtiHlsADtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=810
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240137
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjQsIDIwMjMsIE1hcmNvIEZlbHNjaCB3cm90ZToNCj4gSGksDQo+IA0KPiBP
biAyMy0wMy0yMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IE9uIFRo
dSwgTWFyIDIzLCAyMDIzLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+ID4gPiBQcmludGluZyBhbiBl
cnJvciBtZXNzYWdlIGR1cmluZyB1c2JfZXBfZGVxdWV1ZSgpIGlzIG1vcmUgY29uZnVzaW5nIHRo
YW4NCj4gPiA+IGhlbHBmdWwgc2luY2UgdGhlIHVzYl9lcF9kZXF1ZXVlKCkgY291bGQgYmUgY2Fs
bCBkdXJpbmcgdW5iaW5kKCkganVzdA0KPiA+ID4gaW4gY2FzZSB0aGF0IGV2ZXJ5dGhpbmcgaXMg
Y2FuY2VsZCBiZWZvcmUgdW5iaW5kaW5nIHRoZSBkcml2ZXIuIExvd2VyDQo+ID4gPiB0aGUgZGV2
X2VycigpIG1lc3NhZ2UgdG8gZGV2X2RiZygpIHRvIGtlZXAgdGhlIG1lc3NhZ2UgZm9yIGRldmVs
b3BlcnMuDQo+ID4gPiANCj4gPiA+IEZpeGVzOiBmY2QyZGVmNjYzOTIgKCJ1c2I6IGR3YzM6IGdh
ZGdldDogUmVmYWN0b3IgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZSIpDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gLS0tDQo+
ID4gPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDIgKy0NCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ID4gPiBpbmRleCA4OWRjZmFjMDEyMzVmLi42Njk5ZGIyNmNjN2I1IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiA+ID4gQEAgLTIxMDYsNyArMjEwNiw3IEBAIHN0YXRpYyBpbnQg
ZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwNCj4gPiA+ICAJCX0NCj4g
PiA+ICAJfQ0KPiA+ID4gIA0KPiA+ID4gLQlkZXZfZXJyKGR3Yy0+ZGV2LCAicmVxdWVzdCAlcEsg
d2FzIG5vdCBxdWV1ZWQgdG8gJXNcbiIsDQo+ID4gPiArCWRldl9kYmcoZHdjLT5kZXYsICJyZXF1
ZXN0ICVwSyB3YXMgbm90IHF1ZXVlZCB0byAlc1xuIiwNCj4gPiA+ICAJCXJlcXVlc3QsIGVwLT5u
YW1lKTsNCj4gPiA+ICAJcmV0ID0gLUVJTlZBTDsNCj4gPiA+ICBvdXQ6DQo+ID4gPiAtLSANCj4g
PiA+IDIuMzAuMg0KPiA+ID4gDQo+ID4gDQo+ID4gSG93IHdlcmUgeW91IGFibGUgdG8gcmVwcm9k
dWNlIHRoaXMgZXJyb3IgbWVzc2FnZT8NCj4gDQo+IFdlIHVzZSB0aGUgZHJpdmVyIHdpdGhpbiBi
YXJlYm94IHdoZXJlIHdlIGRvIGhhdmUgc3VwcG9ydCBmb3IgZmFzdGJvb3QuDQo+IER1cmluZyB0
aGUgZHJpdmVyIHVuYmluZCB1c2JfZXBfZGVxdWV1ZSgpIGlzIGNhbGxlZCB3aGljaCB0aHJvdyB0
aGlzDQo+IGVycm9yLg0KDQpJIG1lYW4gd2hpY2ggZ2FkZ2V0L2Z1bmN0aW9uIGRyaXZlciBkaWQg
eW91IHVzZS4NCg0KPiANCj4gPiBEdXJpbmcgdW5iaW5kKCksIHRoZSBmdW5jdGlvbiBkcml2ZXIg
d291bGQgdHlwaWNhbGx5IGNhbGwgdG8NCj4gPiB1c2JfZXBfZGlzYWJsZSgpLiBCZWZvcmUgdGhl
IGNhbGwgdXNiX2VwX2Rpc2FibGUoKSBjb21wbGV0ZXMsIGFsbCBxdWV1ZWQNCj4gPiBhbmQgaW5j
b21wbGV0ZWQgcmVxdWVzdHMgYXJlIGV4cGVjdGVkIHRvIGJlIHJldHVybmVkIHdpdGggLUVTSFVU
RE9XTi4NCj4gDQo+IFNvIHRoZSB1bmJpbmQoKSBmdW5jdGlvbiBkcml2ZXIgc2hvdWxkIHVzZSB1
c2JfZXBfZGlzYWJsZSgpIGluc3RlYWQgb2YNCj4gdXNiX2VwX2RlcXVldWUoKT8NCg0KTm8sIGl0
IGNhbiBkbyB3aGF0ZXZlciBpdCB3YW50cy4gSSdtIGp1c3QgcG9pbnRpbmcgb3V0IHRoZSB0eXBp
Y2FsDQpiZWhhdmlvciB3aGVuIHRoaXMgY2FzZSBoYXBwZW5zIGR1cmluZyB1bmJpbmQoKS4NCg0K
PiANCj4gPiBGb3IgeW91IHRvIHNlZSB0aGlzIGVycm9yLCB0aGlzIG1lYW5zIHRoYXQgdGhlIGZ1
bmN0aW9uIGRyaXZlciBpc3N1ZWQNCj4gPiB1c2JfZXBfZGVxdWV1ZSgpIHRvIGFuIGFscmVhZHkg
ZGlzYWJsZWQgZW5kcG9pbnQsIGFuZCB0aGUgcmVxdWVzdCB3YXMNCj4gPiBwcm9iYWJseSBhbHJl
YWR5IGdpdmVuIGJhY2suDQo+IA0KPiBUaGUgdW5iaW5kKCkganVzdCBjYWxscyB1c2JfZXBfZGVx
dWV1ZSgpIHdoaWNoIGlzbid0IGZvcmJpZGRlbiBhY2NvcmRpbmcNCj4gdGhlIEFQSSBkb2MuIFdl
IGp1c3Qgd2FudCB0byBlbnN1cmUgdGhhdCB0aGUgcmVxdWVzdCBpcyBjYW5jbGVkIGlmIGFueS4N
Cg0KSXQncyBub3QgZm9yYmlkZGVuLCBhbmQgaXQncyBub3QgdW5leHBlY3RlZCBmb3IgdGhpcyBt
ZXNzYWdlIHRvIGJlDQpnZW5lcmF0ZWQgaWYgdXNiX2VwX2RlcXVldWUoKSBpcyBjYWxsZWQgYWZ0
ZXIgdXNiX2VwX2Rpc2FibGUoKS4gSG93ZXZlciwNCmtub3dpbmcgdGhlIGJlaGF2aW9yIG9mIHVz
Yl9lcF9kaXNhYmxlKCksIGRvZXMgaXQgbWFrZSBzZW5zZSB0byBjYWxsDQp1c2JfZXBfZGVxdWV1
ZSgpIGFmdGVyIHVzYl9lcF9kaXNhYmxlKCkgY29tcGxldGVzPyAoSSdtIGFzc3VtaW5nIHRoaXMg
aXMNCndoYXQgaGFwcGVuZWQgaW4geW91ciBjYXNlIGZyb20gdGhlIGNvbW1pdCBkZXNjcmlwdGlv
bikuDQoNCj4gDQo+ID4gRXZlbiB0aG91Z2ggdGhpcyBlcnJvciBtZXNzYWdlIGlzIG5vdCBjcml0
aWNhbCBhbmQgc2hvdWxkbid0IGFmZmVjdCB0aGUNCj4gPiBkcml2ZXIncyBiZWhhdmlvciwgaXQn
cyBiZXR0ZXIgdG8gZml4IHRoZSBmdW5jdGlvbiBkcml2ZXIgdG8gaGFuZGxlIHRoaXMNCj4gPiBy
YWNlLg0KPiANCj4gQXMgeW91IGhhdmUgcG9pbnRlZCBvdXQ6ICdpdCBpcyBub3QgY3JpdGljaWFs
JyBhbmQgdGhlcmVmb3JlIHdlIHNob3VsZG4ndA0KPiB1c2UgZGV2X2VycigpIGZvciBub24gY3Jp
Y3RpY2FsIGluZm9ybWF0aW9uIHNpbmNlIHRoaXMgY2FuIGNhdXNlDQo+IHVzZXItc3BhY2UgY29u
ZnVzaW9uLg0KDQpJIG5vdGVkIHRoaXMgcGFydGljdWxhciBjYXNlIHRoYXQgaXQncyBub3QgY3Jp
dGljYWwgYmVjYXVzZSB3ZSBrbm93DQp3aGVyZS93aGVuIGl0IGhhcHBlbmVkIGJlY2F1c2UgeW91
IHBvaW50ZWQgb3V0IHRoYXQgaXQgb2NjdXJzIGR1cmluZw0KdW5iaW5kKCkuIEhvd2V2ZXIsIGlu
IGFueSBjYXNlLCB3ZSB3YW50IHRvIG5vdGlmeSB0aGF0IHRoZQ0KdXNiX2VwX2RlcXVldWUoKSB3
YXMgdXNlZCBvbiBhIHdyb25nIHJlcXVlc3QsIGFsbG93aW5nIHRoZSB1c2VyIHRvDQpyZXZpZXcg
YW5kIGZpeCB0aGlzIGlmIG5lZWRlZC4NCg0KVGhhbmtzLA0KVGhpbmg=

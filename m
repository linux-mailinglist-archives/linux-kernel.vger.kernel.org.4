Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE2620669
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiKHCCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiKHCCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:02:51 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5E1B1E9;
        Mon,  7 Nov 2022 18:02:48 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A81MjQf007929;
        Mon, 7 Nov 2022 18:02:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=+HvB7xdcccb1OnjdZO5bf38Qs6/jxHvgbuBA4lIANeY=;
 b=p/7zdBPGtRLLAgmhIqf/W64ydsjIWM4+vQZzrT+ZWdtAe7G20jg4ug4qT0O6XPC4tUjF
 w2kFg6SkpefzcGH+VGZX0wW7Z7v/FjTRm34SCaoPDfiSWPjdA8UBCCR/eVekBlex9bxG
 E/WDg+fd/Y9cfmNNs1If7oMoRh1+NxfmjXQrR/f7E4TCFsM0CetvZ68vsBQP4fWdv/dj
 s4dAHnPMEfo2tg5v/JCR/YF1y+l0Xg4g2VVLlztegPyBkZenuoiQIUeV1SYDTnPsE3eJ
 DFvfGsFGctvR98wJlf91/FGNnenuD3H4hcbfXi0hBxHSQuaecIQcusm/uSp9jeTDCMK/ nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3knpfeumnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 18:02:29 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DD41440100;
        Tue,  8 Nov 2022 02:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1667872948; bh=+HvB7xdcccb1OnjdZO5bf38Qs6/jxHvgbuBA4lIANeY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=esDUF9YwvKtDd6wNNOkV4CkdIQ06qY+ptZn7ztliAfzhVM0EPKxKAElMqMzZvea/5
         812Yo+hWh2CqtFNe/e9YMrm5W52BOm2+qe7OyG7xK7U/cFkVthUkd1WISl3MrIylU7
         7hdgS/oRhHMnUHNS3ielL7QkjXwVpyOO9xbd61lTIAXd/j218Lo0HAGKFAMtwdZomR
         OrSH6NtW7TDUym3uGrnKbPChFX+UojBfkvtivMCy4tx6hoVjruFCHOnQm41irEJw0Q
         Wh39EnLf5SWFETKRXGF8j64OiL7wulH8oZVSlt7LOGUVUgSpNGUMfupPmuOPTn/DdC
         JA29Yj0YGCeZA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CC97DA0080;
        Tue,  8 Nov 2022 02:02:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1C7DF80218;
        Tue,  8 Nov 2022 02:02:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Wmx6OsR1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzNYQ8ssgxtKgXHqyrvCGXj3XpZvMk0fTpc0JaaiJpInhsf43O/PoA1pzjfGMBhgdcqUS/qRSVrrNkpTWkQLxIADAYm3pA/DXHomGyIaXwPSp1WO1SZx99ebIcjYHyG3kUPcbxurlVnxfVWwbklgPb3NVH/1GSkD92QibtVPA0KU6cvjzti7Y2gfyma9wyGR+Y9MJsdqo/uALz+fVhK3TZETvhx/levL5ZhZaNifchnwythAgAPu8l7CM71m3yHPHO5Cgil3/dOfCXHiZdUDPUe25Lp/713b/06V+mJES1jTMicOz6dABwrzSNeDtZv1nuUgLTTLwpvqYSQIi3Hs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HvB7xdcccb1OnjdZO5bf38Qs6/jxHvgbuBA4lIANeY=;
 b=nWOOKxXmpnI3pd0jiJTUt5uo7mvldMMXFuL3FVR/lcvu4g22jnZG7k8gwW3Ty5/gTFVePAvZIylO/vnajW3ITJHX6VEIRH+o9ah6mgM/Oey/MZkdvvLxprDrZtbnUrSCP+kbiiM2QwfNxA8UAqbVT/X09B64COtthaehar3MkhCdmy61ZdvlAZ6u1AqhVvmvZduR3AsWjn5yzc0UfwoBJ7YrPofWuGx7SsEiEW2Ug37DnjEBj+XqlXChL7LzzsNA40Y9syRlUSxMy3anZU1KpNQoGVkBu08GUSXJh/sx3gt53qEuHa25RPKczJU3bpV3LBY7lC6/VfE8kciY+dD/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HvB7xdcccb1OnjdZO5bf38Qs6/jxHvgbuBA4lIANeY=;
 b=Wmx6OsR1ex30WwTlr1tLq8vtuumiNagnce2PEUA5NZBS2J93nXAIVQWxRtFwMNOfmqsvOnPGqSvFf+pe9JqQ4ycaEJakE+kKFDrtVikrnVrOEy0CWoyTkkuD9UoIIGBIhnn7kqZSg1u+cONobJRj4+aFy0L9ok7JELu/F0LFW6w=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:02:20 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::9f62:5df9:ad93:5a1f%2]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 02:02:20 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Janne Grunau <j@jannau.net>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sven Peter <sven@svenpeter.de>,
        "stable@kernel.org" <stable@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: dwc3: Do not get extcon device when
 usb-role-switch is used
Thread-Topic: [PATCH 1/1] usb: dwc3: Do not get extcon device when
 usb-role-switch is used
Thread-Index: AQHY8il5zxvfmPdHA0KFoMfsB3fuRa40R+MA
Date:   Tue, 8 Nov 2022 02:02:19 +0000
Message-ID: <20221108020208.y3hrbpaxmzke2lms@synopsys.com>
References: <20221106214804.2814-1-j@jannau.net>
In-Reply-To: <20221106214804.2814-1-j@jannau.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA0PR12MB8087:EE_
x-ms-office365-filtering-correlation-id: f3d8d0da-b4fe-4d86-89b6-08dac12d44e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKr5wspSwxDGWIY3klIJNQR06b0Ql5fj3sEnCss2bo0ZBj7Ie3MY9OQUiBvqhB/1P7J8YMVS9k20y6WTRJIPAmirouKPQFtc4TLhUZgt3PWAkSzvZD2ka3OXfUhhjvfb0rwu9mkrSnGTaiMBam6zBaYvW0wCMssXS3WH6r+FXGoiEOUknBs1K9k//9w2kZv0lsn6xwiggjkqSVepABOw20OjUiJtQmf85G7kwdm1hmcjwXa7KWgUtNDR7MTHIN3Fzyl1fdWCncuOmR3/RG3h+vGmRaeG+qlr3zPTyuk3kJ7SC0HxWfjbaz2D2GYk17cY/9d67n689zpgYOaNfC5PCKtJLYg792Fzm6RC3ufWlIjDSqjrsF3Y69NPsfwVHOL5twEm2t3anyb3dmpvskp6BqO5ym7+ut3N/UeUM8kgqhvGI9U3/yPzLgyOhzApIeVDlRRiWy93C/jcClgxkIFtlU5pMCkDmJzRsol9CdqseC9D0btgFBsldhRt74FqZpq3jqUkVCwsf4M5aGVneDpU/VGuKnUlYfT2vm7ZW8ry7GKuL05/eAXAYMuY4ke35XjahTPlmGT87UgrGkb6Q24eogEwnHJR9HW2W0gpQrG7eaEmCPuWqEqSjMHxY8gDpZK5eIINtQFQ+CBCtbo3Gi6sLegVp0OYqQYYYXbr+dztiePEWuXdQ66XAmT9EmhKRjfPQtHB4j1j1zFWU7mUsQ4XxWaj5OgOL4HHwWHCFbKN1jHrSKpKeaUA7NhD9iQ6CAzTxA2JWVerFWcUaIuqIoX2dqWWuBnj7x9EPDsT2CaujXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(186003)(83380400001)(38100700002)(26005)(1076003)(6512007)(2616005)(6506007)(122000001)(5660300002)(2906002)(6486002)(6916009)(54906003)(71200400001)(8936002)(478600001)(66946007)(66446008)(316002)(41300700001)(64756008)(8676002)(76116006)(4326008)(66476007)(36756003)(38070700005)(66556008)(86362001)(781001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUFCelV0UzQ5QzdQb1JZYUExeXVGS01xK1ArRTBCc3JHdytiNGQremVPaXlZ?=
 =?utf-8?B?dmZzQThJS1JKc3lFSENKUUpwTW9aTHYrWjVWL3k3elJKYXJHNUVlUTZqYjJ2?=
 =?utf-8?B?MVJoL0xyOEh1MTFqNVJlR0dlaWh6TityamR5N1dLMVp0NnFaY1dyRno3VVdl?=
 =?utf-8?B?WWZQbDZob3FoRDhWMHkvTXR3RHJZMklzby9tZTAweHFJWDdLdHJTelo0clV6?=
 =?utf-8?B?cEVQcnJITXdUSHVvcHJXVDNwbHNMNW5hb1BaaS9Ja2NrbW16ZUNKMkZoUDIx?=
 =?utf-8?B?YzFlSXFsZ2d5T0h3dzdXVzFaZjRjWVdQN3FvRC9qQ250bjhSRjRJMW0reE5L?=
 =?utf-8?B?Ty9DUkpxZWRnNHY1VlkySnVyeWlHVDlhdjg4TTJlZHpQTkE1Q3dBeDBXK3Jx?=
 =?utf-8?B?dFFpWHFJci9BMWJ6eUNaY3o3UGZiV2FTVGhXRWJvOUlyWDFPZ0RCeG5NTmhY?=
 =?utf-8?B?MlZkbzZuaDdNb01TTXhkeE5GdnZUWk0zOW96OGtGcTFkdFkzbCtRd2F3MUty?=
 =?utf-8?B?MElhSGZPQUZZNWFvTHRJd1FzaHo5MnJqY0JCLzJ2bXFteDY1WTFQVDlGRDFw?=
 =?utf-8?B?ZEdlbUNuNjBpaXVxRUtRRW44VTNHT0wxSVNCcDVhN3JCSWtZejNDdVA2L21B?=
 =?utf-8?B?SkZaMk5nYjAvbmo3YWtpNjBwWUNGMHNZNXJlV01hdXhEZ2RwSXJNMmk5Tkd2?=
 =?utf-8?B?bzlUTnE2UmRJZHhxNjNNOGhPVUdkQlhDYmRmaTdKSEZJMGlYRXdNeUZERlpa?=
 =?utf-8?B?aEZ3cWtaSzkwNytudWlzUHJYbGo0Q2ZiQlQ3bjdGWnVzYVNDK044dVE4NXhG?=
 =?utf-8?B?TXowdFBhMlFZREw2NUgzRDVlZXJEWVpHclFFUFhLYUhMbzlSUmVONENhSUtE?=
 =?utf-8?B?b0V5RXQxdVJnaHBVU3Q0MU9QS3pzZTFIc09acFJHVm9BYVhKQmJOdUZja0Mx?=
 =?utf-8?B?bkJ6OG1vNnY1NFpSVnpJdTFiVEN6b2dCTkNxbzNsOXpNVFhWRTBkQjdaU0tz?=
 =?utf-8?B?VHB1RTBGZ1laTEVGTGN1RmZiaVowVU9QandIa1JPblhlQkxINDBjOFRwN0to?=
 =?utf-8?B?QVBad1puZmlra3h1VHRCZ3dodUNwck1nRk42bktyVG5rS0wvM1MyV21PaXdX?=
 =?utf-8?B?S2F5eWVWZzF6enVVTmlwdTgxNmFuU0NXbVQ1ajRpVDRJaVNuR1h1NXlydldz?=
 =?utf-8?B?N3E2ZG00TmZ0bnd2MUtoTExaQjNzZVdYejdaN0ZVbEZtaDRONGVLRy9XZnFB?=
 =?utf-8?B?NCtFSWVETkhhSGRnZkFhY1ZXc1lsTC9pSUNoSWdDTFRlVTh2UXBHWnBHaE9J?=
 =?utf-8?B?Mm1udUd0MmwrUjBXYUIvK1hVOElOdlExOVNTZVp4enl0bi9Nem5ZcHRlQmRn?=
 =?utf-8?B?djZTSTVHQmFST3krRCthVDZtY21vMzRCRDdLWCtyT1dRdVdFQ09DR0FIQU0y?=
 =?utf-8?B?RmVCUXhYcTE2ZWw3eS9QRzloV0NKK2dJWW9oVm83K3B4ZVhnRS8zZmlBaFBy?=
 =?utf-8?B?OVJuYUk4UlpYUmtINE1Dc3ZkRXBsZ1dlaU1PMzlBVGdIZDhOOG5tdHJZa3hz?=
 =?utf-8?B?V3psdGtTeWM5aXZLVjkyUnFEVEQwNG5uM3hlZFY2M0lFcTdnZCs1RFE4ZzMx?=
 =?utf-8?B?K2RxRlFiN2xEakhBZkNua2RHQ2Z0em41dlRHVjdybG9YRTFRZ1l3QWZBa2ZB?=
 =?utf-8?B?NE5PQTJ5a29UQVlNVDhuWTNaMnYzTkZiMkpxTHNBVDBKcnpERTM5S0s3N3RQ?=
 =?utf-8?B?eDQ3VkROWlRUZFQ5amt0bVRvOE8rcGZ3RnFFMG1DOGZjdTY2Z243QXpUdGt3?=
 =?utf-8?B?c2ZENkt3aUFBcDRsS2tnUkZkQWlTclFuZ0RIcmVsYmtnZStnWFFGME5jdVNC?=
 =?utf-8?B?SGRFSGc5TTlqZ0VLN1NjdGhybThhTXFrUnMzYVV3V0JqaS95VENKSzdBclkx?=
 =?utf-8?B?TVJOWS9QaCt5UUw1OElRWk5ENkpKeHpuMGlEVGZGRHl3SitIcjVHczJEUjdm?=
 =?utf-8?B?NjBWSkI0aUhsYU5HRnBnWWx5YzM1ZjIwTXJwd3plQXNHU2FtM1YrTUxlUkhS?=
 =?utf-8?B?VXp0SWRFVUVXTno2VHJBT2Y1SXNPNVY2cU91aEVMdEwzVE5VSys4b3V5Q3ly?=
 =?utf-8?Q?09RClVuc7ToxkekWuqanUcVxg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C765143A54C9CB48801AF5968E4BAD1C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d8d0da-b4fe-4d86-89b6-08dac12d44e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 02:02:19.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJYys7u/TtMurC2YjSwdTWCshx1f60m14RwyffkbZKTUwQf6o7kJd0XLn3BeqJKuevZ1/uETm9nk3rS/m0XIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
X-Proofpoint-GUID: TqOlEOGQgkuG4QlDGAME8bEiicVcpnlj
X-Proofpoint-ORIG-GUID: TqOlEOGQgkuG4QlDGAME8bEiicVcpnlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=690 priorityscore=1501 clxscore=1011
 bulkscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFN1biwgTm92IDA2LCAyMDIyLCBKYW5uZSBHcnVuYXUgd3JvdGU6DQo+IFRoZSBj
aGFuZ2UgYnJlYWtzIGRldmljZSB0cmVlIGJhc2VkIHBsYXRmb3JtcyB3aXRoIFBIWSBkZXZpY2Ug
YW5kIHVzZQ0KPiB1c2Itcm9sZS1zd2l0Y2ggaW5zdGVhZCBvZiBhbiBleHRjb24gc3dpdGNoLiBl
eHRjb25fZmluZF9lZGV2X2J5X25vZGUoKQ0KPiB3aWxsIHJldHVybiBFUFJPQkVfREVGRVIgaWYg
aXQgY2FuIG5vdCBmaW5kIGEgZGV2aWNlIHNvIHByb2Jpbmcgd2l0aG91dA0KPiBhbiBleHRjb24g
ZGV2aWNlIHdpbGwgYmUgZGVmZXJyZWQgaW5kZWZpbml0ZWx5LiBGaXggdGhpcyBieQ0KPiBleHBs
aWNpdGx5IGNoZWNraW5nIGZvciB1c2Itcm9sZS1zd2l0Y2guDQo+IEF0IGxlYXN0IHRoZSBvdXQt
b2YtdHJlZSBVU0IzIHN1cHBvcnQgb24gQXBwbGUgc2lsaWNvbiBiYXNlZCBwbGF0Zm9ybXMNCj4g
dXNpbmcgZHdjMyB3aXRoIHRpcGQgVVNCIFR5cGUtQyBhbmQgUEQgY29udHJvbGxlciBpcyBhZmZl
Y3RlZCBieSB0aGlzDQo+IGlzc3VlLg0KPiANCj4gRml4ZXM6IGQxODJjMmUxYmM5MiAoInVzYjog
ZHdjMzogRG9uJ3Qgc3dpdGNoIE9URyAtPiBwZXJpcGhlcmFsIGlmIGV4dGNvbiBpcyBwcmVzZW50
IikNCj4gQ2M6IHN0YWJsZUBrZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEphbm5lIEdydW5h
dSA8akBqYW5uYXUubmV0Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTAg
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jDQo+IGluZGV4IGMwZTdjNzZkYzVjOC4uMWYzNDhiYzg2N2MyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0K
PiBAQCAtMTcxMCw2ICsxNzEwLDE2IEBAIHN0YXRpYyBzdHJ1Y3QgZXh0Y29uX2RldiAqZHdjM19n
ZXRfZXh0Y29uKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYgKGRldmljZV9wcm9wZXJ0eV9yZWFk
X3N0cmluZyhkZXYsICJsaW51eCxleHRjb24tbmFtZSIsICZuYW1lKSA9PSAwKQ0KPiAgCQlyZXR1
cm4gZXh0Y29uX2dldF9leHRjb25fZGV2KG5hbWUpOw0KPiAgDQo+ICsJLyoNCj4gKwkgKiBDaGVj
ayBleHBsaWNpdGx5IGlmICJ1c2Itcm9sZS1zd2l0Y2giIGlzIHVzZWQgc2luY2UNCj4gKwkgKiBl
eHRjb25fZmluZF9lZGV2X2J5X25vZGUoKSBjYW4gbm90IGJlIHVzZWQgdG8gY2hlY2sgdGhlIGFi
c2VuY2Ugb2YNCg0KY2FuIG5vdCAtPiBjYW4ndCBvciBjYW5ub3QNCg0KPiArCSAqIGFuIGV4dGNv
biBkZXZpY2UuIEluIHRoZSBhYnNlbmNlIG9mIGFuIGRldmljZSBpdCB3aWxsIGFsd2F5cyByZXR1
cm4NCg0KImEiIGRldmljZSwNCg0KPiArCSAqIEVQUk9CRV9ERUZFUi4NCj4gKwkgKi8NCj4gKwlp
ZiAoSVNfRU5BQkxFRChDT05GSUdfVVNCX1JPTEVfU1dJVENIKSAmJg0KPiArCSAgICBkZXZpY2Vf
cHJvcGVydHlfcmVhZF9ib29sKGRldiwgInVzYi1yb2xlLXN3aXRjaCIpKQ0KPiArCQlyZXR1cm4g
TlVMTDsNCj4gKw0KPiAgCS8qDQo+ICAJICogVHJ5IHRvIGdldCBhbiBleHRjb24gZGV2aWNlIGZy
b20gdGhlIFVTQiBQSFkgY29udHJvbGxlcidzICJwb3J0Ig0KPiAgCSAqIG5vZGUuIENoZWNrIGlm
IGl0IGhhcyB0aGUgInBvcnQiIG5vZGUgZmlyc3QsIHRvIGF2b2lkIHByaW50aW5nIHRoZQ0KPiAt
LSANCj4gMi4zNy4zDQo+IA0KDQpMb29rcyBsaWtlIHRoZSAicG9ydCIgbm9kZSBjaGVjayBmcm9t
IGM4MjRjNzNhNWUwOCAoInVzYjogZHdjMzogZHJkOg0KQXZvaWQgZXJyb3Igd2hlbiBleHRjb24g
aXMgbWlzc2luZyIpIGRpZCBub3QgYWNjb3VudCBmb3IgdGhpcyBwbGF0Zm9ybQ0Kc2V0dXAuDQoN
ClRoaXMgbG9va3MgZmluZSB0byBtZS4gU2hvdWxkIHdlIGNsZWFudXAgdGhlIGluY29tcGxldGUg
Y2hlY2sgYW5kIHN0YWxlDQpjb21tZW50IHJpZ2h0IGFmdGVyIHRoaXMgdG9vIChhcyBhIHNlcGFy
YXRlIHBhdGNoKT8NCg0KVGhhbmtzLA0KVGhpbmg=

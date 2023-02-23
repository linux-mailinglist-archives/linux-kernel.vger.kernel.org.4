Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E356A110E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBWUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBWUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:10:41 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D3928209;
        Thu, 23 Feb 2023 12:10:31 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NJt3vX032619;
        Thu, 23 Feb 2023 12:10:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=/LRwIyUlQ3ZKOTv+ewT7b1Y5pGiYFJyxBH35/rmuJLM=;
 b=UlGyW37yodULlcK9j2IjHN501yDPepygWGAELG1haWxXrOcQBk4utcszzkWDe1+0SNk2
 cbZW5arYuP/mlvQW45hnNJ/BV5512cwyxjgFkzMFnmf+yKV6R93bLHELMnzyJKI5F29l
 1LsvgEkIo3JPL8YQCzTpDY23UswXXDns+eLBIzxDA6CghnlvFk+IATsChbOk3erXkgNO
 ZCdmNmtUaq/Gk6worLSicjjGgXxpUnLNJQL/VKBqx82Dmv1+eJ7M9tTelYvA8d9zuzDA
 RdtQPKKTjyw2nFrxxLmWqNUrmmpVmgGJQBHveVXrW21/Lp1lbxh/pMk3IMgMsR+areDT sw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nwy6m7d3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:10:27 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6087CC00E0;
        Thu, 23 Feb 2023 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677183027; bh=/LRwIyUlQ3ZKOTv+ewT7b1Y5pGiYFJyxBH35/rmuJLM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kqWhPeUTlG/0OLITXzOGhQ+8m/MARDh4FjGE8FaFxtISVzc3utxBDfcZrcuHRydPK
         T95+xaCqTYd/KvZAKc2wPsJB19Um+vhorT0f7KdVb3xMIoMvoMNTtt3A3Mnfq/7Lag
         bgWvFHTtW/Ve42EBnCf7xYS4lvzIDrp/B16yH1BcBfWuBfPm3Vq1IoUqHBqXAwHWAQ
         kHjl+QVg052wt+C2yvKzaUdg6t38vRwJ+xrRh54y9kkiP85m83MvFkvtr09t9yqn4+
         NXWpPv8ein+aG8vELVmpb89ODgqVMZE3iwnhA5jzk2FJTJUtXt5mfTBYc2EjZQ8nFu
         WhuOg/gPyJN2w==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id AB6C2A0060;
        Thu, 23 Feb 2023 20:10:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7F55A400A3;
        Thu, 23 Feb 2023 20:10:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QBTbJuwm";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UomN6w+bv0PuztRley0cuYOIYYLPrSdh2TjdNJSiEAFJaRsjgSX551E0Oool9j9O3Bjy8Gke3NRLM4b86i4Aa45CZWmm7UjfSnRrR5D1aRfnHMewwcFWcObI7BE/KdehulJtc6wTIUUT9aYqtL6+ZWjxij12tYtE+N/3RgJZ1kjdhzzcv5cgB+Jk/x9BQYLLVDoG+7CBMGCY5Jo4Y60xMgnaragYEX3Ze8iaiHiLg4YVhBHRuBvEn2FRdKIqGBfljKkusccKMQO7fUwNe0oIfNMjFNDWYbHLjHIC/t9zX2uJdvbcIfT51D52oCPTGNy7yn75slWX3mx8TckReIzgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LRwIyUlQ3ZKOTv+ewT7b1Y5pGiYFJyxBH35/rmuJLM=;
 b=fTYGB3M/WKGWV/91MMPUK970jSTvQ9zgDK/8c7acxaCxiFld9ysQBuPMMZyidw57Mk3yjx9Y6hdBuX5/y/R6UgLgwM6Cs9FAmPxfoladKpBsPKXscP9CYfuP3flgFcpQ60BK67Hwy5StwRwvM54DAdeLQ1R+ZnVwq72aylDck18550Lqvs1K2jPrUxuonSbYdyi4kSpC6lGXf1ozkkC8iA7wGIBbXNBkX1nXAsGuSO+VIV4+hjSnAv8/3iUItO+1lBxhbBzU7wxjJXTS5lmr9SbMq9TBdWg9MmDKHlAMhw2JIGqXqHNaDQRMlcqMvL502i39iXDvkUIlOgsqBHhyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LRwIyUlQ3ZKOTv+ewT7b1Y5pGiYFJyxBH35/rmuJLM=;
 b=QBTbJuwmnGfVnm9qKfy9zZ7r2IwWW6p/x3zIXzzssD0y2xbbIuIRN+NXZmPol+/reyaKDPOM5p4haODx90Gi8DXMjF+34iWVAfHpiaVnleo+mehWjwdCpF2gQZTyjj5zUBQhJCQqGXRLsMAjb8ZQMq7R35wt66aYPKxymKgunZk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 20:10:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 20:10:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Prashanth K <quic_prashk@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?utf-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Thread-Topic: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Thread-Index: AQHZR4RI6tyX8XGkuEOVkCA1IEksoa7c9quA
Date:   Thu, 23 Feb 2023 20:10:22 +0000
Message-ID: <20230223201019.3a5njywzchztcs5e@synopsys.com>
References: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
 <1677156121-30364-3-git-send-email-quic_prashk@quicinc.com>
In-Reply-To: <1677156121-30364-3-git-send-email-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY5PR12MB6623:EE_
x-ms-office365-filtering-correlation-id: 87033ea9-4ca9-448b-339c-08db15d9fe95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ON6cSkcC9tHz+BomJ7sbL7AOuB/GwDtL07IVfZLlgUwbMeEFQHT74pjrIDgJ9veJ5dOncAiyLaCdj/Ex4MJSXwSKkW7GOCD/rXG3Dm8PEQFqdjpQqWAo9+GJt3FUWy+9a7Tfa/dfrOwMUdxYY7/HS5PH7M7A9wbhWbiNTE/wkNVVlr2wIrE/gkahMaGSJT/WF2ZDPqfElEGbvQPN4nb6LwYI/DkmvWTzSHxMfjueeb1q76ATU5of6AQ4j6Yrei7x/vRqqzDsihlHA4SG+0YW0Rf2qvxwDaLHRECJd0gBQXBewt8UVmfzOdMvzEzrZwW1QEcRQRQmvvT6+Lpdk39CWPIhMRaYglMm7AlWtdTAJ/jX1zXBPP/FA4KmsGcSX1J5v/f3/Zc8BuTxlMRVgtmuKrCeOoQKh2kBKo+4ew/jcsHl8OPWcSY4I4EvRzw3NgSS727XyrDvkwseKBGJTMloJdNy7NVsu6C5m9w85hfItw9GT7dmBfCLx/CzrHr5RS/XrpSDQZezyX4XA98ecZ/l9rf6FslDg3UkmiPUCcOVLKOcSErdGxfG3A7hgRyc0vxvcrVqJrOmyXXbN4yUcnWOUWwWWULDde//PmO5dFfxrrOy2IiZ6eegiEUZ2U0YTv+8oXwX1qEyNASpIjtwf6GRmL7MOg1Xz2qElkFlYdhlC0A8q4dkMhtpzCW22ZYOf+gamp3/3iRyNRsXFTKXm7Ey4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199018)(316002)(54906003)(8936002)(2616005)(2906002)(38070700005)(38100700002)(122000001)(26005)(6512007)(6506007)(186003)(1076003)(71200400001)(36756003)(478600001)(6486002)(83380400001)(86362001)(41300700001)(4326008)(6916009)(64756008)(66476007)(66556008)(76116006)(8676002)(66446008)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak1tUHJEeWMyQkJ1U21ZV1JtV3AzODZPRkxUQmtRTkIrTitFd0NRMWtXeFFS?=
 =?utf-8?B?OXJRMmdHcVhzL21lOTQ3clVjbitpZnN6dzZXVzFFMzI5KzFSVU05NG9yazRW?=
 =?utf-8?B?UWpGMkRpVHB5QTRuR2xUenNsdGtoS0oxMWZCWlh2SlBUNHVIbXEzQTJ3NHcy?=
 =?utf-8?B?d0NiOVp2MHc3TzAwY1kyWTVUMytqb2F4MjQwekdnclZ6NFhrQ1pUcE12Mmtk?=
 =?utf-8?B?TmxSRFNBZkZZSm56VElvdE9TaGxhL1BMOFFmN3FlWnZlZlhMSVNiWEp1R09C?=
 =?utf-8?B?TWVDeFZiKzNuS1JNK2RWVnRrNkt3YVJOUXdPTnp4STVWeWtERWpZUUZZM2hp?=
 =?utf-8?B?b3B0SFBWZ0Yrd0N0TXNqZHp3SmZBcXZEc1lWek0wSHpkVTRtSWxDeDE5czNT?=
 =?utf-8?B?Y09kTExkeFF1bDFaLysrRk5hc1V2Uzk0aUtlNjNZZ1YzVmdTRVhqSlAvazla?=
 =?utf-8?B?aEJCVWYwNWgycFVQQzBMOGx5SnovTjEvMG4wRlprRXA3NmFCZit5RUQ5cDdn?=
 =?utf-8?B?aEdFVjlxT0JUYitTVXNmRDJlWHRPa1A5RWZzaW9QYzQ3OWJQbWg4ejFiVSty?=
 =?utf-8?B?YnBLSkUrdTcrQ1dHK2pJRGo5cG5QMlNYWlAyeElqYlZ3Y1NDYklCOFBqNmEv?=
 =?utf-8?B?c2dXbk1YSjdUbnRGbCt5STQrWHJvL2VaT2s3V1J6QmErWUFkTGltOS9peUJo?=
 =?utf-8?B?TllpU3cyTjNMd2RhY09uWU01ZjJWZVI3Ym9uMnY1SGdacE9Ja2xEbElwalJJ?=
 =?utf-8?B?WVJGVmdrbHpneFp2YTVpZ2F1K1orTllvK2FQVXZKUUhvSEhsVWFlWGV1K0sv?=
 =?utf-8?B?cWl1L3h4TWpkOW1ObDkxRWE2b2d5aGJvM3RMcEgvNkd0RXAyY2ZuSFdteWNk?=
 =?utf-8?B?ZjV0ejV6WjMxclVYTlVXcjJLdGdlSytPdUQrcnVwVzlRMWI5aitQV241V0Fn?=
 =?utf-8?B?WEZQdzJBZ215djlRRDNISlJiMTU1RlBnakFGQXM5WSsvaXdlL1pJSVErYk5T?=
 =?utf-8?B?dGlxN0hiWlhuY3cvZFRXbDI3bXlGV0R0NjFzUTdYM2cwUHVPeU1FdGkvMlFr?=
 =?utf-8?B?bU1nR1dHRE43dkxEWUIvL04rdDNzY3A5bWo1bU9DM0U3VjQzTDZsRXdKZ0hr?=
 =?utf-8?B?S084ZzdGUXRQVnJNQTBXUDFGSS9QWFB2QjBpK1VEZ1RBTW5oUFNUb0dvd0JC?=
 =?utf-8?B?VE1ZWEVkeVlPVkJ4VXkza2wycnVyMHJ0YmI0Zkw5NlozVW9vR0k2Wk9xREJa?=
 =?utf-8?B?RDVFc3N5QUxrVFI5UEE3TGRuUnV5V2R3TnZOcGV6SStXWEc1ZG9WZGVRaXdB?=
 =?utf-8?B?STdUTENCRzZPN3JDT084dVBSdUo4ZVh0cE0xNmFMOFFtRXpJQWFma09EbmZJ?=
 =?utf-8?B?bnFsZDB3bVlyT2kwZGYybDh4NjI1QUM5RHBZMWlxa05sRTFZNzlOUnV5c2ZL?=
 =?utf-8?B?WTB3TjNqQjNGbTYvM0dFam80eFkzeVNwMU9Gb1BXdittOEpEZU1QSWx5ak9X?=
 =?utf-8?B?d2gxbWNqSkRYUE4xcGtFZHlsSzZ1Q1QwRnJtMnd1dGdxaEg0R0ZZdlZhclRu?=
 =?utf-8?B?aTJlMlJZWWU5eTNEZjZtMnd5VXFYcEJ0ZTdneis2S3Q5bVdFVDIwNExBR0Jt?=
 =?utf-8?B?RzRzRG9OSW5ZUVJKUDdRUEljTDh2YlJjZ1BmN0oyeE04bjI2YTFha2Q3RElB?=
 =?utf-8?B?M2tPL0szc2RUMENDVEdYQzFvcm9VMjZyQ2pIUUE2Nk0xVDYxdzRoRGdxMk5C?=
 =?utf-8?B?a3BjWHAwRE83S0pnS2dLZVczb2IxWFg4YjhtUklreDN2eGFycS9UOW0rTkow?=
 =?utf-8?B?MlBPNW1xUmN1eWxxK2Z6VGVkNVlhbWxNbVNrNmRMQi9Vd1dMbjFReDV3SGxm?=
 =?utf-8?B?cHRRQ0pUUU5hOHMwVE51Z1RsY0c2aUcwa2VqbFdrSjNKUDZUYUt6aVphdUR2?=
 =?utf-8?B?QUJ3S1liMHc4TUwvdFhGeW9FZVhWMFM3RVRkOGFuNHYxQzJDbU1YRUJ0R3Vs?=
 =?utf-8?B?a1hqeVZyemV6UmdZWmlROVNPQ1YzTWJXbjA0UUhnY3NlVGRxRkFVMUFvUlhX?=
 =?utf-8?B?ak1TYlB2TGNTMDRtaC9ZMVFqZDVHR2dIQzJMVmp5WnJxcVVncXh6amJSY1Bo?=
 =?utf-8?B?SE1iSW44MDNpQ0V4aG45eldkWWh3cGNTdkdEeGRrZ2hEcGZSMjUrQkVzajYv?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C19569F46B44A4FA52D149787BBFC0B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R2ZDKzdIL3RuQ1pSYjdIZWRRRnR3OVJDb0txdUJRdE0vcGViMk8wZnZCdzVO?=
 =?utf-8?B?QW94RjJwQjBRYXU1eldiOVRYVGJkU0VJN0pwcDFtQys4YmdjYzNqQ284Q3Qw?=
 =?utf-8?B?cVVvTmRtaFJGRjM3SDZoNWV0bmRzL0Y5OVFIaGNYU0VXalR0NEJHVnNQei8y?=
 =?utf-8?B?Zml1NWJ1N0RBU0lUTmhhdGRic0RuSFNLS1RXSkVrMURKMm5KTUt4QjhxUFI4?=
 =?utf-8?B?RWVrWXBNZ1BtNTFyTFZhTm94bnAzaXRkRkJLVlBCOVhvTE9wa2taOFl2T0JX?=
 =?utf-8?B?Wk1PSW1jYmRWK2xReGxCaWpmUnBJVlRaK3ZOcHBPck9iKzZBdnpUNVJwbk5x?=
 =?utf-8?B?cmlDNndUbHdNdkR2Um56SjNORG9hQ3l6NXRydXZIVTJDMWJJNTJLcWU5TFNV?=
 =?utf-8?B?VUcwZEcwQUVSdUZicG9uR29vdUhNb082RHpqVWc5TkFXQ3ErdC9OWFZNZGJI?=
 =?utf-8?B?Z2FVWlVsTFpodytjVzBwYnBGcUlkQS85OFh5SmR5YXo2Rk5jV3MwaFhra0FU?=
 =?utf-8?B?RGEzRDlSb00wclkvcHpFTzFzaGEwYmJxaGRJcjNOY1RMYklrSjVWNExLSk0v?=
 =?utf-8?B?NzJpd3hjNUIydjFBOE5FVjVsMmpKQ3UwbWNCU0l5VUtIUjdjRDJNbEVmZGkx?=
 =?utf-8?B?MmlTVFY1cG40SmVLclhoeEx2ZTB0RjIrM3JJZTgxVGs4OVBNbjFXOEx2dE80?=
 =?utf-8?B?VW9lWW9zaDFOUkNVb2RCcDFhN1hxV3l3SkVGU3R6WmtDdWIvSHVkYmRjc3pW?=
 =?utf-8?B?ZE1peXZLenk4L0VYSDFoQzdkMWxBYkhycmJNTDhJbzVrUGs1dHNCUEwxSFNk?=
 =?utf-8?B?dTl0UEgycW5INjh3NFQ1QmN6aUFDRllvaUowcVBhZktURU9ObDhHRlpjK2lC?=
 =?utf-8?B?dEh5SlhCRmt2WDR3WlZPNTZyalBDOG5INzg3N2VCNWMwT3JzTTZuNGVzZHgy?=
 =?utf-8?B?QWNnRHJ5NGdOY2lOK0M5M1BOY0FMdEg2eVcyb0Rjc21jT2RVaDk2VUdsVE9z?=
 =?utf-8?B?VFg0NDRjYXNEcGRVT3RwR3d6YXJmQXFIejZLRXB1cnV0aWQzMkxWblY4U0ZE?=
 =?utf-8?B?eEtnTWNlbDNIOXljcVd6ZHRWYnJhNDdsVStzc0lqUzdKUVdnKzlKajJiRjJR?=
 =?utf-8?B?ZEVYREZEemdwU2RadTFodEVxMU5tM1AzcExzWnUwMnFFbVpVak9vZS9IMWd5?=
 =?utf-8?B?TDhaTWp3Nnpvc0p0UWRwdTN1dnpZRVJBd00xSGNmWWFUTnBxVk1zMFNyK2pO?=
 =?utf-8?B?UFB3RUF6RW14V2p5RlBuR1BHVnBDazhVdlU4WmZpWXBxQ0o5QT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87033ea9-4ca9-448b-339c-08db15d9fe95
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 20:10:22.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAkk1MM5cC9c7HuGt7QBZRmK1tVrqTEOHNfK2u8owFsjZUpoxsH2G7ZIe0EXzWQzUuFS9iWe8aWH3dId1SvQOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
X-Proofpoint-ORIG-GUID: 5FOZf2Qsn_F7CZzjjGuUZwEqH2BY8-jS
X-Proofpoint-GUID: 5FOZf2Qsn_F7CZzjjGuUZwEqH2BY8-jS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxlogscore=816 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302230167
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBGZWIgMjMsIDIwMjMsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgd2Ug
ZG9uJ3QgY2hhbmdlIHRoZSBjdXJyZW50IHZhbHVlIGlmIGRldmljZSBpc24ndCBpbg0KPiBjb25m
aWd1cmVkIHN0YXRlLiBCdXQgdGhlIGJhdHRlcnkgY2hhcmdpbmcgc3BlY2lmaWNhdGlvbiBzYXlz
LA0KDQpDYW4geW91IHByb3ZpZGUgdGhlIHNwZWMgc2VjdGlvbiBhbHNvPw0KDQo+IGRldmljZSBj
YW4gZHJhdyB1cCB0byAxMDBtQSBvZiBjdXJyZW50IGlmIGl0cyBpbiB1bmNvbmZpZ3VyZWQNCg0K
SXMgdGhpcyByZWxhdGVkIHRvIGJlaW5nIHNlbGYtcG93ZXJlZD8NCg0KPiBzdGF0ZS4gSGVuY2Ug
YWRkIGEgVmJ1c19kcmF3IHdvcmsgaW4gY29tcG9zaXRlX3Jlc3VtZSB0byBkcmF3DQo+IDEwMG1B
IGlmIHRoZSBkZXZpY2UgaXNuJ3QgY29uZmlndXJlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBy
YXNoYW50aCBLIDxxdWljX3ByYXNoa0BxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvY29tcG9zaXRlLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRl
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gaW5kZXggNDAzNTYzYy4uMzg2
MTQwZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiBAQCAtMjQ0OSw2ICsyNDQ5LDEw
IEBAIHZvaWQgY29tcG9zaXRlX3Jlc3VtZShzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0KQ0KPiAg
CQkJdXNiX2dhZGdldF9jbGVhcl9zZWxmcG93ZXJlZChnYWRnZXQpOw0KPiAgDQo+ICAJCXVzYl9n
YWRnZXRfdmJ1c19kcmF3KGdhZGdldCwgbWF4cG93ZXIpOw0KPiArCX0gZWxzZSB7DQo+ICsJCW1h
eHBvd2VyID0gQ09ORklHX1VTQl9HQURHRVRfVkJVU19EUkFXOw0KPiArCQltYXhwb3dlciA9IG1p
bihtYXhwb3dlciwgMTAwVSk7DQo+ICsJCXVzYl9nYWRnZXRfdmJ1c19kcmF3KGdhZGdldCwgbWF4
cG93ZXIpOw0KPiAgCX0NCj4gIA0KPiAgCWNkZXYtPnN1c3BlbmRlZCA9IDA7DQo+IC0tIA0KPiAy
LjcuNA0KPiANCg0KVGhhbmtzLA0KVGhpbmg=

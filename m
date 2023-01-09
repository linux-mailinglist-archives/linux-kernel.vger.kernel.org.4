Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23950662F22
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjAIScP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAISbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:31:50 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7C3C725;
        Mon,  9 Jan 2023 10:28:43 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309GvQx9032602;
        Mon, 9 Jan 2023 10:28:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=wtnSt6XB8d5zAQl/nPF++vtAgBZJfRwtod8YmMQyrVA=;
 b=K1pRFmwcSdc2++epyByJ2hTcFvtzTq/nb+8ciSQzkzI4sLJhkh+FQhNCxwoy2Zkj51q8
 fb0oFupre4iuHjHGX05dd2llXD9Cuh3pXLCdl+QLnE5Zjr5zmjxnH+5fKxwIHIUqIHVk
 CyleqjbcXnpnl6RjS+A7dRb1jAo2ITL6IRuPFhDWFoEHAxw4iNj020LaGZ7+dzK58hiU
 rVhUNaA/g/BmEHJv2TgrXfpIM8Ro6d9rZusRhfoJFUOQQ6D8hQos56XAiSSbcpGIhh52
 6C57eBd90lclSkO1QFho/SOWk11P827Us8byMJxzcG5YwzyIvV3UyJdd/VWiSYCG/h/H dQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3my8j113f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 10:28:25 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 777E64008A;
        Mon,  9 Jan 2023 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1673288903; bh=wtnSt6XB8d5zAQl/nPF++vtAgBZJfRwtod8YmMQyrVA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EtZQCSY9GyYaa+WEgUP16UFAE+XJb94KZ/2S1mGk3syo97kec1THm99d0FL8d7m6P
         ZBdnqIvVCkBg7mDTtPN0UmHg4fj51JW0xKJkkGP2Z1D00VQAv3Zy/CpRR71aR6m585
         apVg/d19MXIg2vPSJdctC7VKSpBaBiNRs7RyqsX8XdpzBc0mOmrbVrQGLnXcZ5BtPh
         I7sLErUl6ImA0G+USH86pjk7ZcrpS8FQn2zWBxKqSULWcHyX9v+sIhFk70O8Goh9xJ
         8Hmifn5e/hlz/qjQr/DfcdVZavOULdT50ERx8xJlEbddUDeCKwLiMmnGLLtdAjqinW
         DJbjJIovSmeEw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id A027CA0060;
        Mon,  9 Jan 2023 18:28:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9F83080095;
        Mon,  9 Jan 2023 18:28:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="BQJfunyV";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR+EioRRb3RxKb++y6fEkpJRSPDiUbUQHqKtOeqJqizaYAaqK4QMJKS8lhVOJvi5siZV8oVgDTb/rMiAJ936x6i269Hz/+mDncg5P1+udzFMBuyACqHP9GsLytXuowX0QouoZHHKB4g2EIafMwFCEeVoH4BTAOiAOEvKQkrwvIaKrAeId3Xv2rm+aITfwwmWpkk2DlHJmNv3FZp/xR8+YJ0Ol/6ji7YejXZ6wwc4YUeslAFJjqCHTzeq5axreQ6O9w3JngizKBmg+edENBJ0Am+0wgnBS6M6GI8nu87rVuLfa7Xmcg1n+Cd0JFnPx1iGGkKObTPEcIO4MQ9NrDt3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtnSt6XB8d5zAQl/nPF++vtAgBZJfRwtod8YmMQyrVA=;
 b=h+Y529fA1I45HcxR/UDjsW93DHfbxs2brIHZpBh9YtjFcUW+ahmq1ThhzwFkIzMvJBAhK+kdmeu2Q2K5tVxln84syOfTl2JmI9Jo1RcaZZFUhpbsH2x2p2RLXluebSZAOAfb7zWY63u8/3nOPoRpFdM2NWIMXfowGVnV/HICqXm/iBw6tmAMBQjr26Bo3zcPetyNn3RTvvwtrXhCc3/A5QX4szUiNa8fkwVPFZmZMKsI1lGxoTqDtlTbLdlw4uDKreUVrE0nSRr92u0MyDrb52zB4yiwvjdJKUNungmDFvFxkWerqhG+oHSoUehjeYLiZE1xZVSWoNiD2PdAo7Akpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtnSt6XB8d5zAQl/nPF++vtAgBZJfRwtod8YmMQyrVA=;
 b=BQJfunyVXV9OpzpUe4FutVxA+MK/rN8bk5hben2nxDbrhZPiLB0B4V1t+dKs1z3bBnG0ISfMM0ZU3MTUPgyem40yZOEHpq1IJmRjZ6w6hgOT41nDc8WAad5UqpfMsNpc3rvqeqXgEGe7tUQrCnRYcdATsea8ganiJvUpaSGlXAE=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 18:28:18 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 18:28:18 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
CC:     =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Topic: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Thread-Index: AQHZHmjkAYxM4HeOyE6Dd8zsa51+rq6PLu+AgAABtICAAGoRgIABIhKAgAW2rIA=
Date:   Mon, 9 Jan 2023 18:28:18 +0000
Message-ID: <20230109182813.sle5h34wdgglnlph@synopsys.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
 <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
 <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
 <000201d920eb$c3715c50$4a5414f0$@samsung.com>
 <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
In-Reply-To: <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4520:EE_
x-ms-office365-filtering-correlation-id: f61aec4e-75de-45d7-2b43-08daf26f47a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SII7aFRIsgxMMqBA9MXKG+CFx/ElDytbg5wCaO/qQGY5zFpOpbsitXFmZ6aHQT8yJOfFUybI3COPbycjQUxKf5izE1HkzvglWbdPdqQ2xnwWiXPPsQhZ+ieHDb+xNm5lm3+/dpXrPJIHxM8VFBEb46Tc3YEyQlYuDxWmuJX8EcGZ6ItMWpUxFWcmHlyq4HFFENh6cqCQU0ywQ+144YmnHdzyTezQXXNjLQkIwb0WpPCoYk6YefgdaE3LQmrnXdgQu68wGDroKKt82eiGGNOnZrLrbaauhSH7TOdzyzbXc2s+Z4bzSbqiJ7aVN2s0szJZMYt+KaMkKxy8viDk+gZSgffoOrgiUYIAW0fYvnOkNIILlbA+rO/HpJF1OoUhPJS6DsdtF6duzGNeqIh/7FEqxriduZgQaUAUqXB1EhM7J9skypSzrmhoNzDRX3g75o6h6gxKYwhC5Yke0AZQ5zr4DMN6l4M4Fcm1P0e/Fk/87tatbfAqbccGyFdYEqxg9cUM9VLL/G6Uj5/RfJXlUfkQZh3Q2sZLkYiFbaYs/76uDpm0amBVLwCg81eSOtqCu0ZSaILfQdypD0trzjQKh9Za4jzW2IVzkQBzC2WFzeHQcvNl3sHD91UFS86Gw1JXw5xrvwDaYM+SXEMHQ2ZTvJxI95XAVBIBKvEFtysr9pYNSzIyCDaswn+V+F9lAm3og7BkXtUILPfbJNFGDOeAIDS1/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(6506007)(38100700002)(122000001)(53546011)(2906002)(186003)(478600001)(6486002)(2616005)(1076003)(8676002)(26005)(6512007)(5660300002)(316002)(71200400001)(8936002)(83380400001)(36756003)(38070700005)(86362001)(41300700001)(66446008)(66946007)(4326008)(76116006)(66476007)(54906003)(66556008)(64756008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTd4Wk5XdW1uWUhDbWpQZS85K1FRL3RTWCtESEZ1SXRJRmM1eHpXdjdpT0lY?=
 =?utf-8?B?MDNmM2FQbFBiQXBYUlNjakt3SGZZKzh0bmJXZUxxU3U3dENwaEhXY1FuanM1?=
 =?utf-8?B?TFJhUzZuU0ZWQmc5NE9lbk5Hckk1bm1maHZ6ak8yVG1adjk4Zm1hUytlRjBC?=
 =?utf-8?B?NjBzeStuTTFtYmFjNksxMWoxdGxjaDZOWHNsK2ZRNG5Id1JtR1pOeG04cDRn?=
 =?utf-8?B?bkorMWlsSzRzRVV6WGdNOXZwVElYcW9iZlJSb1pINEQvMVdDVFZXMm1IMytE?=
 =?utf-8?B?QU5USjM5eURHOWZqeEpBc0lJUHViRWo5YWdkSDVzM0MyQ3pzQ3RGL296Mk1x?=
 =?utf-8?B?VkV2ZDU4bUVYYWRBcUVlWmlPOHg1TEdDbGFVem9uRXp6RUYyY21tbnAxZnNR?=
 =?utf-8?B?WVdid3pDUG5iRk5odDhuOFp6U2JKNmdCcnl1RzZVaVNGL3MwaDhDUGFnNGxI?=
 =?utf-8?B?TXRqdytqb0lldTBuUmc2MzRNZHFUWVN2ckFpOWVKWjEra0ZzRXZtQmZyNGg5?=
 =?utf-8?B?ZE1FODJRNTg1dVgyaktLUXhhdHpkN2dwc3hwcUNMM2pwdHQvbys2dUt6Sk1B?=
 =?utf-8?B?M0VMcERVc0RIcjA2elFyTFBPVmgyU2RXTGhGdVJXVTR1ZG95Skp3M0g3cXIw?=
 =?utf-8?B?VmhBQWdmeVhoM0t2djlGZFNzWjVXRCtCUVVGWUkwTlNBT08rcWZJaytWYnYz?=
 =?utf-8?B?MG1lNFVDUENXQ1M2Mkc3KzVEY0U0T2VVVTJFczg3amxJencxUlVjODhxS1Iy?=
 =?utf-8?B?ZGdFZnVlMVlKdnF2QzZrd1JnSVRlRmR4WmFyVXpLZXVQRDFKNEg4NklPcks4?=
 =?utf-8?B?Ni9CTmMvT3JVdC9PTWRKMk9LYWx0UE9vbUxtTXhBZ2dTcDVDQTdVbmlEdks1?=
 =?utf-8?B?eTlFeExVNmlSYWlmNlYzM29IYUthUllNZlhKZWpYS1BjU3NkV2ZHbjFjUEJT?=
 =?utf-8?B?MmY2U0Y3a0RHN0xHZStDZXlmQVc5eFdLdElNTlhMbktmZDJjR0hrZ2JuT0tr?=
 =?utf-8?B?M0w4KythSmo2UDhoTXdGT3VrS2VTOFNxRnhwVG1MVVU1NHJ1Q2NXSTZmVDMr?=
 =?utf-8?B?SFVZTG0wNUJxTjZHb1pTSXJ3QU0rc0w5Q3FUNkdXY3ZtU29UZVl6OG5HVStr?=
 =?utf-8?B?NE5zVXdkTGdKNFNodVkwZVZGWGZuRVg5OEgvaXNUeEY5T1FIMjZIeXQwOHVj?=
 =?utf-8?B?YW96b25MSm43R28wSmFDWkFlbzlQdHFSRmI5ZElYYW5URWRlR2U3UjdwdnZH?=
 =?utf-8?B?TWZuR09zalFKVFlJTGgwdDdVeTFLQmFocGZhaHgzZEU1OUIxckZVTXN2bjhR?=
 =?utf-8?B?OWJLVGZaRHFvRGp2U3NKL0FxUDlsSDJaNDVNMzVHNE9rd1d0UHVhbmlLc3d0?=
 =?utf-8?B?S3cxOEdEbjNVOUxxWnNXUy8wRk5wbHBGYTZobGppckFzNUF0R29HQlE0SGlO?=
 =?utf-8?B?WWdIcWV3NnRGR0xzWjVEb3ZuYUxXcTRQZWpmai9sNnVaSkltMC9BUGJ6KzlJ?=
 =?utf-8?B?SS8ybXRESDdvclArcVBCQ2I2WVV1WmpsYXA4QWFPWVRSNFA0UXF2b2UxS0Fv?=
 =?utf-8?B?MTVsSjlZU1ZOQlpndXBpNVFJcERud00wbVZMdVNrVmpMMEN1UTk0QmVsalRC?=
 =?utf-8?B?alRWbFBvYnF6NkdrdW5laDFEUG53YjU3bllMdUR4M0hlaktlYWNxaW9VR3hZ?=
 =?utf-8?B?OGgzWUlMYWNCTENuOXphSlYyWFo1MldKZWxXN1JhUWhvYWovWlFueFlZeGZ1?=
 =?utf-8?B?bmxJTkFOQTFtK3VjaGVxY2RTb3hGZkRCZWFETXJOakdXb1U4dktvUnUybkdq?=
 =?utf-8?B?dDRlcjVyU21hdzA1SWdEaVZ3UFZIdXh0UnQ3c3dJVUZhTkpvNk9STFdLcytK?=
 =?utf-8?B?b1FPVW82Z3FsOFRtZXZtanVHU3J5aE1Kajl0Qm1yNDRhV1IwZldUZUdoTTZ5?=
 =?utf-8?B?UktsakdBenRqUEFmck82dFh6WW94dlJPeGRvR01hSzhQYWJsK3JBU0MwTmxR?=
 =?utf-8?B?MDNJUjd5eDJpNjZERHpSWHNMVDlOZzF5ZlkzV0xTbzM3YWI4VE91bzllY0VN?=
 =?utf-8?B?OEF5Q1JnNzl4bUxYenFMamx5TGFzLzFtU1hjVXRJbDZmUTlndEVDSi9mSEpN?=
 =?utf-8?B?WVhNQ1c0amVPOVZLcXNacHdaOUdTTmFiUFByMFp3YVRYYTJ5VUhwOUVWWk5T?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C96655975E2F69459A747E6824C23D36@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ejQzdXgxY3hkVlh1bGlTc0ZpdnFEVG5FVHNhUHF3elFQMWt6eVZCeUVJWmRP?=
 =?utf-8?B?dURQY3NqZnVMNGozc2prZ1hSVzdITHVrWDVGSndMTUNQaXVuZC90UnRZRmRG?=
 =?utf-8?B?MmhjalNZMDU0YWx0S3FJR1hqdU9jVXJYNGJmbkMrK2xuMVVCcWlDUTZjNUth?=
 =?utf-8?B?b0w4RWVkN1Yya1dwa1VNeWFkblNWQmZaMlNvMlo2RVNxR3FPN1FTTXR5VlN0?=
 =?utf-8?B?Tm1IK2IvbEsvd0t2MnpsZEVYVDdMbTJON2VZUnVWeTExSzJHS1lLVFduM2tr?=
 =?utf-8?B?QU1SSC9ncDlsZks0ZU5QT0xoTGlzV1N5aG9laFRUekd5ZGQydUEyb2h5MjJp?=
 =?utf-8?B?cDUxeUlxNWdqamNaQ0hXRTZaYWRPTFd6V0Z1NjVQZ3FxQjQ4alVITDdnVnJV?=
 =?utf-8?B?c2I1b3B5c01nYUFUTkZSbTFWUnlTUi9ZQWVua1hDVTNBbU5SMzRLU3QwUEda?=
 =?utf-8?B?N2xSUy9Bamk0RHJxTWMyMEdnMmpzWUZxVi9uVE50U3pyWWN1aGhyZklXYU1D?=
 =?utf-8?B?MVpEbnZIdEtOTlAvS2lHVzhFZDJwL2NtQ3FEME1Zb1JsVUVTMUlLNFV5d0p3?=
 =?utf-8?B?alVrSWNTZTYwVW43Z01DWTBPd2REN1lHTEhudzUxVWIxU1FkTys1VlVLRGwz?=
 =?utf-8?B?NndvK3QwREdJS3BoMjJ4MFBDWTJxRFpqMXdKNG5NeWgvYi84SSsyTkZic25F?=
 =?utf-8?B?dDlJNFFlNUlUMVluZVlvTVlWdmpOUE9CcU1keWhoRmI5ZDhlY3NpcDVuVU9N?=
 =?utf-8?B?YXl6Nml3WS8wb3lnZmdhZDBkUDlWNXZvS2p6b2o2UEtHNkdUU1plQXRCRXJL?=
 =?utf-8?B?K3BXK2dlSG52cWtzOERzallDaXJmVER0cXhxdVNjQTI0N1Z3eitDSnI2L0NG?=
 =?utf-8?B?UkFEM0NjcTJ1TWxUbW5oVjNJbTVNMUR1VWFjdm84V01HR1hMcmVUTTVXdm1y?=
 =?utf-8?B?N3FaZTh2U3UrTE1RVWhyck1rZVlYL0U5Q1QxSi9PV0JLVEdFVWVpMDgyYzRR?=
 =?utf-8?B?UXg4K2hZYU1iYWRYOFRmdVhyUUVnQWpoTFowUUttQ2g5YllnY012UWd3NG5s?=
 =?utf-8?B?bHpSUmJPRDNCczhkc2JkeEVhdUVhSE9UVnVlSHloUmJJd1NPWGVJREhXUEdI?=
 =?utf-8?B?dC9qbHR6SzhlWnRRS1ZEVVkyaklhOXNNSU1aRk0rVE5XakVFNFd1ZkR2V002?=
 =?utf-8?B?YTJ2Q3R0blZrbThvSnUyWXJjdm9SbnNLVWRTdkFyWTN4bEdMcWRyenJlMHBw?=
 =?utf-8?Q?djQQFjJd/dT8YRw?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61aec4e-75de-45d7-2b43-08daf26f47a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 18:28:18.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WVpB+2H20HrTfR5I/AV3QF8HqkVMageZEeiCltk5ld3uUGjn/wbpWwLSsk414mQwpJtdt5IguFazycK86N6Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-Proofpoint-ORIG-GUID: _O1mXEjWkFlbyzb9k5XUSr1-W72f3aMo
X-Proofpoint-GUID: _O1mXEjWkFlbyzb9k5XUSr1-W72f3aMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxscore=0 suspectscore=0 mlxlogscore=435
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMDYsIDIwMjMsIExpbnl1IFl1YW4gd3JvdGU6DQo+IE9uIDEvNS8yMDIzIDU6
NTQgUE0sIOygleyerO2biCB3cm90ZToNCj4gPiANCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBMaW55dSBZdWFuIFttYWlsdG86cXVpY19saW55eXVhbkBxdWlj
aW5jLmNvbV0NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDUsIDIwMjMgMTI6MzUgUE0N
Cj4gPiA+IFRvOiBKYWVIdW4gSnVuZzsgRmVsaXBlIEJhbGJpOyBHcmVnIEtyb2FoLUhhcnRtYW47
IFRoaW5oIE5ndXllbg0KPiA+ID4gQ2M6IG9wZW4gbGlzdDpVU0IgWEhDSSBEUklWRVI7IG9wZW4g
bGlzdDsgU2V1bmdjaHVsbCBTdWg7IERhZWh3YW4gSnVuZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gdXNiOiBkd2MzOiBDbGVhciBEV0MzX0VWRU5UX1BFTkRJTkcgd2hlbiBjb3VudCBpcyAw
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gMS81LzIwMjMgMTE6MjkgQU0sIExpbnl1IFl1YW4g
d3JvdGU6DQo+ID4gPiA+IE9uIDEvMi8yMDIzIDE6MDggUE0sIEphZUh1biBKdW5nIHdyb3RlOg0K
PiA+ID4gPiA+IFNvbWV0aW1lcyB2ZXJ5IHJhcmVseSwgVGhlIGNvdW50IGlzIDAgYW5kIHRoZSBE
V0MzIGZsYWcgaXMgc2V0IGhhcw0KPiA+ID4gPiA+IHN0YXR1cy4NCj4gPiA+ID4gPiBJdCBtdXN0
IG5vdCBoYXZlIHRoZXNlIHN0YXR1cy4gQmVjYXVzZSwgSXQgY2FuIG1ha2UgaGFwcGVuIGludGVy
cnVwdA0KPiA+ID4gPiA+IHN0b3JtaW5nIHN0YXR1cy4NCj4gPiA+ID4gY291bGQgeW91IGhlbHAg
ZXhwbGFpbiB3aXRob3V0IGNsZWFyIHRoZSBmbGFnLCBob3cgaW50ZXJydXB0IHN0b3JtaW5nDQo+
ID4gPiA+IGhhcHBlbiA/DQo+ID4gPiA+IA0KPiA+ID4gPiBhcyB5b3VyIGNoYW5nZSBkaWRuJ3Qg
dG91Y2ggYW55IGhhcmR3YXJlIHJlZ2lzdGVyLCBpIGRvbid0IGtub3cgaG93IGl0DQo+ID4gPiA+
IGZpeCBzdG9ybWluZy4NCj4gPiA+ID4gDQo+ID4gSC9XIGludGVycnVwdHMgYXJlIHN0aWxsIG9j
Y3VyIG9uIElQLg0KPiANCj4gSSBndWVzcyB3ZSBzaG91bGQgZml4IGl0IGZyb20gSVAgbGF5ZXIu
DQo+IA0KDQpIb3cgYXJlIHlvdSBjZXJ0YWluIHRoZSBwcm9ibGVtIGlzIGZyb20gSVAgbGF5ZXI/
DQoNCj4gDQo+IGJ1dCB3aGVuIGNoZWNraW5nIERXQzNfRVZFTlRfUEVORElORyBmbGFnLCBpdCB3
aWxsIGF1dG8gY2xlYXIgaW4gZHdjMyB0aHJlYWQNCj4gaXJxIGhhbmRsZXIuDQo+IA0KPiB0aGVy
ZSBpcyBvbmUgcG9zc2libGUgcm9vdCBjYXVzZSBpcyBpdCBjbGVhcmVkIG9ubHkgYWZ0ZXIgaXJx
IGVuYWJsZWQgaW4NCj4gZHdjM19wcm9jZXNzX2V2ZW50X2J1ZigpLA0KPiANCj4gd2Ugc2hvdWxk
IG1vdmUgdW5tYXNrIGlycSBvcGVyYXRpb24gYXQgZW5kIG9mIHRoaXMgZnVuY3Rpb24uDQo+IA0K
DQpUaGlzIGludGVycnVwdCBzdG9ybSBjYW4gaGFwcGVuIGJlY2F1c2Ugd2UgY2xlYXIgdGhlIGV2
dC0+ZmxhZ3MgX2FmdGVyXw0Kd2UgdW5tYXNrIHRoZSBpbnRlcnJ1cHQuIFRoaXMgd2FzIGRvbmUg
dG8gcHJldmVudCBmYWxzZSBpbnRlcnJ1cHQgZnJvbQ0KZGVsYXkgaW50ZXJydXB0IGRlYXNzZXJ0
aW9uLCB3aGljaCBjYW4gYmUgYSBwcm9ibGVtIGZvciBsZWdhY3kgcGNpDQppbnRlcnJ1cHQuDQoN
CnNlZSA3NDQxYjI3MzM4OGIgKCJ1c2I6IGR3YzM6IGdhZGdldDogRml4IGV2ZW50IHBlbmRpbmcg
Y2hlY2siKQ0KDQpUaGUgY2hhbmdlIEphZUh1biBKdW5nIGRpZCBzaG91bGQgYmUgZmluZS4NCg0K
QlIsDQpUaGluaA==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384F06EA307
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjDUFJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDUFJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:09:45 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67B35AF;
        Thu, 20 Apr 2023 22:09:44 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KNk3jT013392;
        Thu, 20 Apr 2023 22:09:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=O8tPWBWENx7nI0JVbT4dIXoe4Y05j3fADOmRkUx/XCA=;
 b=G+clZq06bHqIVhy8JZN7X17jaK++fzrbNJPXz3G6WizNoqjdj2hq1sCexmtNLNEtzhHJ
 H8o3xaecsKti7tmNtmH+2HROuFGXaQVr4MG08YBz/oHXFLiOmUV60ke6hphnW8OGPocJ
 ngGuIb0KjAN6GCJZOXImyODV7lEUnu9Vr4bquZOdBBN4LklZBt04/nImHSRZVVZcE4sc
 WKPFeVp84HHwsfxdrh8/OeYTgUriEIVNCOsECGBak+P6YjApMJv23ZCNpyvdP3GuYsZS
 KOcogj1sR1I5e5BHWHHJt5F6m8lsreLwwlZQH3qvECOPEAyrj9C3cMIq5hLJUyeJ007c Tw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pyu66k0hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 22:09:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682053769; bh=O8tPWBWENx7nI0JVbT4dIXoe4Y05j3fADOmRkUx/XCA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=f+aLi5FSjrn6HFgEk0CgZe384+EV1WcfYDFPkOGGSAH8un1SXWRiM39lYzh0J9kId
         XJd3UyRdiIzdVpMWxdyfMPY3X2IcuukTX0kETAlfM4bhGoR1k5Jx6a9s94qdxxZ9QF
         YkCBRWOmaQbAG6k0CkC0lZ7Rg84PvQyXduvyEJZN3IL4FUJsJLK1IAFNBPvn9nriGX
         KhXLjiEhoUUdP3BsKypgonBVXiLnnkEuziUJUSFQwysdboD0GZtou4xRFea68a2oJy
         hQ5+L1XQR645BI3lgRgVQui85IBo8eSP2pSl1/bPqEOci3us80oN2Gs/TA4U5mqF4G
         LxjZRKI/SOa+Q==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ED1BD40753;
        Fri, 21 Apr 2023 05:09:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6D980A005F;
        Fri, 21 Apr 2023 05:09:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=j28sZDnC;
        dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5AC0940A63;
        Fri, 21 Apr 2023 05:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J808P+LIQA4y+UJQadT1mhIDCw71y+EUGLvJCZ11dA7xi4Tc9ZqaxyAhvu8ab6QlYNCaOF5Op+j0XC+vi6RdSfbCohj/S/pAbN6XKVAYWURrHO8og12r6YEQ6Rn8fs9toNYdwR+qBkWzqwqytmCWy640/+PPo+gNCQKfikDHRwpL9OSQesSbZL8lY9rKVgl914Cn0hUpybuk6USS+OTwWcSbMGo3cDqWzzwkkWSnlllWHh15Yvg+Zxuverr/gZaLIXHTIConIpZ0ty+9ewxGxc27pXn7sFeoAhieBUOHak2pn79Q/iAe+UuaLgB2lorf9ztauphh1TXBUKazQ3+3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8tPWBWENx7nI0JVbT4dIXoe4Y05j3fADOmRkUx/XCA=;
 b=aAShO5Y1qVmCWTWnbU0qHTwPFPMmlGEI78N39A6z0jWH3yQN6bv7faN670goMn+zfiT1LtWJtK0GMlauhGuO6Cqcs+4B/SA9Rz5GLYiY0PB7f1r+sb3zpm+18NWgnFyDdP69HTRrTUKsBeHNqG1e7b3yEyuAKAD9Xfu5iYF1fP0pOiTsm8I1hHLY/R42YgcXpW4ydeJVE8t3hU3QjbcPJ6UgQu9Z+kWqNNvHPcQSTr1zgqyqrAwYXhB2M0asQU1ttVEbQuHH1DR00H3h9hIXCj670sP+nPz4JApI9iqnQukPdVtuO0N5HBVaUKBe+TeuhjmQzxK+1uvmk2ilCXK4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8tPWBWENx7nI0JVbT4dIXoe4Y05j3fADOmRkUx/XCA=;
 b=j28sZDnCvuDQU0HsWgTjN9SCLsbbqkDSGUxSR/t72Y9ZQlqpS/ZU6IeZY5XF+sutkAPgzVFpD7CSKAroOK4mHv5sfKoOYbqjkOeKU/7SVT5AdFlxyU75N1jbldBnLOcjJzTY3C897anFlP0m8ck6nQ/2T8yrb9DxqkRWiPNViNs=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 21 Apr
 2023 05:09:21 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::2dd9:84:a1cb:ece1%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 05:09:21 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     "cocci@inria.fr" <cocci@inria.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: Move a variable assignment behind
 condition checks in dwc2_hsotg_handle_outdone()
Thread-Topic: [PATCH] usb: dwc2: gadget: Move a variable assignment behind
 condition checks in dwc2_hsotg_handle_outdone()
Thread-Index: AQHZcup6bHV3i4xDiEuwJ6R0DDcCea81OQWA
Date:   Fri, 21 Apr 2023 05:09:20 +0000
Message-ID: <3d57b2ae-125a-3696-6d9b-ae5fee168eec@synopsys.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
In-Reply-To: <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3399:EE_|CY5PR12MB6381:EE_
x-ms-office365-filtering-correlation-id: a77c79ca-c1a6-4ee0-2959-08db422690d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lK4REZaReFbqqWoOVYp92l4f9wDXP+0D3eI5LmWHbm8n5PiPmstGxCjMbXQq4DVcm8FfZNs8x1J2yY3VquiEip8QTECDBZIrHGbI3/W+Q13q6RP4F1UYO4CWmliM804BHTov/9uYkAgLwDuE9zt8khK93MlgPtKXfPw9+mEEEofN01jXpWVb4RCFg/t5IKmDCtNgqW5B3mhITR/CfTv8Rpug0biaylseuFy3urVd624yVY0Mt2BB5XuFfQPsfD95VC2FmIYRQuiig6519AiDQEJRJikpIqoB2eQcThFiB1sDfcyVJ07dBpJaOOg22pXFrcwp2eiBMTc5b23Yjj6sPgzcJSBWG37jbAVqBgRw8e4O8sddb2ZC9S74hT9Irv/amqjsvHmqUstw6vOMP4Sk77EGdfCJVc9GJEyyicT0dcvdu3JqZcZakrBrcR9lqYIPa/fd8MgvLHAgm6slIPIH1wTPcCVf7o00tcLptamAZPZHk3eyjO2NZNSQEDIQDX/yOd+Bff8HYPbgkDAjygEfe2riTPXLbSJTO5jRIqS2uFlyCaKlBK8jA/XmTcUUwI3FT1F5r/0Z/TAdZ+aeSEmrLsfTfHCESmjik1H6IMQjkzrUkJ5JUfNblFRz7XxJepD9B5GTF8eKFoFtKgQL5/Gd6h6VtGya32N4f85oc++KftFUVcqv6WO5Y8wwpfs3Srj1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(26005)(186003)(8676002)(38100700002)(8936002)(6512007)(53546011)(6506007)(478600001)(316002)(66446008)(66476007)(4326008)(71200400001)(76116006)(64756008)(91956017)(110136005)(66946007)(36756003)(66556008)(54906003)(6486002)(86362001)(31696002)(122000001)(41300700001)(83380400001)(31686004)(2616005)(38070700005)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZ2K0JidUExZWpWT1lqMGdPRW5ndjNFSUNFWEp2ZVh1aUU3RkRTQnJFSTho?=
 =?utf-8?B?ZkRNeXEwQXpwVEh1UkRZN0ttKzNyRlRjUk5QMktyMXZTdlovd1huMmtEYzh0?=
 =?utf-8?B?c2Q4MCtpZUNkekdFVGovc25BbEd2NmlUNW9nR21XRHhMNW5VK2Y1WU80UUkw?=
 =?utf-8?B?OTR6VzRBT2JlWDFqVFl5TUZCL0Zua1cxMUJHUVUwTm96elF3dEZTRE1YeHN5?=
 =?utf-8?B?WnlJRCtDU0RRZ0FrYmo1NVhGc2U2dVZONSt1WTRGU3FwcDM4cUxjb0p5NzBC?=
 =?utf-8?B?Ui9OVm9NZW5lb04zT0tXSFFWb0MxRUJlSEtYT1V5UXMyb2ZNR1dlUFpUdDRt?=
 =?utf-8?B?aDQrUzJHckRlaHQyalg4aU1lVVo1aG9TZkNEV1B0Qzd2bW9sZEIwbmloYnBZ?=
 =?utf-8?B?SEk3RjNmU1RIWExmRUd0QTRSeDA4Smt6Um5XOXRwbWttdkQ1UkdHSWdsakxV?=
 =?utf-8?B?OWJpaGlnYVl0a0JuQkZLVmNPenBhaTRqbEtqM0lMUWJMR0pxalF2ODFuUEdQ?=
 =?utf-8?B?K0cvNHNDYWp3NkluNXo2cGhLeGU1Y05IOTB3NlpYc0x6U1U1RVplazltTklv?=
 =?utf-8?B?NUZDa3VLa3d5ZzNqL1RVUVZiSTYyQ0tEcmFUWVNSN0Jxejlvem1vNVI0cm1J?=
 =?utf-8?B?RzB0MzJ4aXc1bWVzM2tsend1WmtTRWN3ZUxHV292ZlM0V1IwMVRzY2h2d3h6?=
 =?utf-8?B?VmFudVVjQ0NtWXdLVzJFSUpyZTQ1Wm4rb1VLZCtlWElleDNXcnV1b1hiZjN5?=
 =?utf-8?B?aDR1VXg2NE9XaUNlbU52czBmMTNKcHRoSzdmUW4ydTNSaVBBblA1a005Zzg3?=
 =?utf-8?B?cG05WjBhanBJYU1RbWc2TncyNEQzaHJSWmo1c09EckVYV3k1cDlSSm1vdzdI?=
 =?utf-8?B?UmlKU2FZaGRkZHZ1TkM2SE1WTkRGZjNQRUVodHRyOFhHY2xlWjhPTCs5OGE2?=
 =?utf-8?B?Yjc4NnVTekt4K0I4UjdmWVAzZG10QkxFbkZ0Nm91Mm9ZWGRHN3ByUHdkbmJC?=
 =?utf-8?B?OWZZS0xkRlhvNlh4QWxMdTJlZHZ3RDdhamd2NDREbzdxZk5GYmtYSGxydk9C?=
 =?utf-8?B?TmhaVVhGSExzOVJmaWNyZHlNcUo0NWxob3I4Z0RZb3BLRnM1QW96dEU1Nm9a?=
 =?utf-8?B?cklCNVdJVVBNd0cxTG9GVzZzc0MvVERGbVhLMko4d1A1d1FzRlRqV1RXOS95?=
 =?utf-8?B?aXMxcWVqVUV2YVBRM1MzYUFZTGFYR0EvNGZGZ053SE9OeFYwaEhCL2ZEZ1VB?=
 =?utf-8?B?dkJhSVFyckNXR3k5VHdadkpRUTRGQUNIbGJMRG1BOW1TRFFiS1FTNVZxODJW?=
 =?utf-8?B?MUMxWk1UMyt3TlhjUDR0YXd6SzJieklIQ24vSU8xWFBYSnBGMUg5NktjY2t2?=
 =?utf-8?B?OG5HUFpDWGZ0ay9FMzIzLy9nYi9QWHQ0cm1BdVMxYm96YzRLL0Jmb3NSSjRL?=
 =?utf-8?B?NlE0aDlQUTVaTWlxUFVsY3pHS21BWFZqT0hNNjJidTkxUFNlNHptSE5hRnRG?=
 =?utf-8?B?aW13NnBDeHM0Sk1ncnNUQm1yT3IzanFoRFI5a3V5K1ptckZiL3djTGZDRDZs?=
 =?utf-8?B?M1pHWlkwek9hUDVQR0tndS9qcDEvZ3YrNG5GNGw5cUhqYWJLSGdDTjZmd2R0?=
 =?utf-8?B?SWIvUWU3ZWdHUFoyc1NBR250Ylp5alozMWJETHRwcUd0VGVkQ1g1WFlkZmNH?=
 =?utf-8?B?aUx3czlHa3JWaFh1VnlKL3MzQzRiMTY2aWFFVGxiTk9kTWJpUkVhbGF3VUNG?=
 =?utf-8?B?VkNjOXlZb0NmTVdTVXcyT2x6RUx0UHZqZUVRckFFNUludStIMkRZV1B2eTJD?=
 =?utf-8?B?eEVUUytqd2dpaEMwdzByc2J1dmlSTjh4cXM0THFBTGtjU2R2SFBkZis3Y2x2?=
 =?utf-8?B?Q1JkOG5Bc0hHamcrQ0ovOVBuVXBudVJjWUpZZFNOdWVHZlR4dkdtZzdEa3BO?=
 =?utf-8?B?Y3hjUHdpS0dETDRXMkFtNWdGRjZCR083TlRndmU3UlZWdXdiVUxUL0ZDdy9E?=
 =?utf-8?B?ckhKazBCZCtVaDUyemNuNThEUHJOaTJhZXZ1cXNzaDlHNW0xSVZTS2RUSFRS?=
 =?utf-8?B?VnFqK2RaR3RLcUh0WG1NbmpHNndCQlJ3N04yUVB5QktzcXA2c2p0dGNGYnIr?=
 =?utf-8?Q?/zILzr1OuPinuVs5pbewXh6cm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <614BF112D16CFE4AA6CAD1AB44D35034@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ajAwMmdyWFNUaDhKcmdjV0xOSFhCeXdiSGNmQmJnL1FvSkwvbnZLck1jT2w4?=
 =?utf-8?B?NU9UbENnV2trY3ZLY3NIY0s2dUVLK3RUeHpnVW04Y3NnaUNKNGl0bkVPUEM2?=
 =?utf-8?B?OVY0b3ZwQ3EwOW5DSnFxRzVqTndUT1VNUE9IK3VKbTljekVmb29hK3N6OTlU?=
 =?utf-8?B?ZFVoZVdnbnk2TXd4aHQzQTZpNEVJWC8reHhqNjNJaDZrWTVHY1ZKejZhd093?=
 =?utf-8?B?UlFlUXoyRC9ER1hYQThVQkY2eGRQMEtnUWwzNURtNkU3ZnFkTlNFaDZ2eDdp?=
 =?utf-8?B?akRYYjlJKzZCenBJZ1VtNmZtRmJ5cjQremhpVEM2RmIxeHdHVi9QT0lHOHJn?=
 =?utf-8?B?WjhKR3FzSGRUb2hVTGdZSnd5bFVPcXVyN0wyODMrWkw1bkg5emFPYlpXR0hn?=
 =?utf-8?B?Q3FwSmZEVmpNVFZzdjI2Q25GaHp0K3BSNXNPNUxkaUt2Y2dVc0lBcllXS0lB?=
 =?utf-8?B?QU1UYVpRTm1RUGRlL0xlbXFmOTBRKzRnMnBWeFZjcHZFZEszTFFxWVVOZDlB?=
 =?utf-8?B?ZnR5T1l0TVFJQ1lBUmhZdFo5VHk0VkU2Tm92ZVZ6TzR0TFZNOHRvaEVoTHVM?=
 =?utf-8?B?b0p6Z3pvelgvSnBTbmpMVHdDOTZCY1R3eEhjWHl0TmpyM2s5YVJEWmoyU3NG?=
 =?utf-8?B?cWwwSEJzNVJEMW45MzltS3JHaGYyY085ZDZhajdCTUI4RWNvblhodGljNmVE?=
 =?utf-8?B?MDByTHFkak1jTTErUEVwTGJPMUQwRDN2Y2ovLy9lUnY2STJLWkJrSllyakxv?=
 =?utf-8?B?MlhWQ2tOaGFSQ0t0NXpYQlFVcDlrMllLcFQ2d2JpZENiaWgxNEwyNEQ3ZTVU?=
 =?utf-8?B?b3Y3eGZZdk5PYUVtcHFNOUJvdHZqa0NIaXBUbEJYdE8xOUI0ditGTWVkUnJJ?=
 =?utf-8?B?aWlML2lyd0oraW5TSTc5MDVma3lRYmIwcUpZRHIyZjJ6L3pwek9ZdGQ2dEJZ?=
 =?utf-8?B?MUpBRFgrY0xYaVdwc015azNHaGIxcW9BaGU1ZHN2T0x3bE0wSVQrQ0VTMnlO?=
 =?utf-8?B?ZjgreXZHc21JZkhNbmZoVTZyVzMraDRrNmpBdHEwTGdNOUdkZFlvanNlR1o0?=
 =?utf-8?B?dXlxVTB1eWRpSWJZTDRwU3hDbFdtcGJqdktyZlZCblNndXZFdVJzdmtOWDhv?=
 =?utf-8?B?S1ZtS1FaeTJXeG8zVUlGRDdwSWhTUWdENE9sMWtpWFNqSklNRVlTUDRXdjFo?=
 =?utf-8?B?WHViWU9Na2txZjVyOXB4c285VUF5VU14U2lVbDRURXhFVjN1QUp5aVV4VzNa?=
 =?utf-8?Q?6XFMCBgwQ+ivFJM?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77c79ca-c1a6-4ee0-2959-08db422690d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 05:09:20.8721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T66smsxaz4u8B0T8/yrSFY70PSzFs+7IkI54sfKrLcT8We1wbMQuEXybuawfAVTAoKzcCgh4DXsThOKV5Y24NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
X-Proofpoint-ORIG-GUID: Okmnp77rDXNRtmt3Ybc1YeC0x0rh1jj_
X-Proofpoint-GUID: Okmnp77rDXNRtmt3Ybc1YeC0x0rh1jj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_17,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=797 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210042
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMyAyMjoxMiwgTWFya3VzIEVsZnJpbmcgd3JvdGU6DQo+IERhdGU6IFdlZCwgMTkg
QXByIDIwMjMgMjA6MDY6MjUgKzAyMDANCj4gDQo+IFRoZSBhZGRyZXNzIG9mIGEgZGF0YSBzdHJ1
Y3R1cmUgbWVtYmVyIHdhcyBkZXRlcm1pbmVkIGJlZm9yZQ0KPiBhIGNvcnJlc3BvbmRpbmcgbnVs
bCBwb2ludGVyIGNoZWNrIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvZg0KPiB0aGUgZnVuY3Rpb24g
4oCcZHdjMl9oc290Z19oYW5kbGVfb3V0ZG9uZeKAnS4NCj4gDQo+IFRodXMgYXZvaWQgdGhlIHJp
c2sgZm9yIHVuZGVmaW5lZCBiZWhhdmlvdXIgYnkgbW92aW5nIHRoZSBhc3NpZ25tZW50DQo+IGZv
ciB0aGUgdmFyaWFibGUg4oCccmVx4oCdIGJlaGluZCBzb21lIGNvbmRpdGlvbiBjaGVja3MuDQo+
IA0KPiBUaGlzIGlzc3VlIHdhcyBkZXRlY3RlZCBieSB1c2luZyB0aGUgQ29jY2luZWxsZSBzb2Z0
d2FyZS4NCj4gDQo+IEZpeGVzOiA1YjdkNzBjNmRiZjJkYjc4NjM5NWNiZDIxNzUwYTFhNGNlMjIy
Zjg0ICgiVVNCOiBHYWRnZXQgZHJpdmVyIGZvciBTYW1zdW5nIEhTL090RyBibG9jayIpDQo+IFNp
Z25lZC1vZmYtYnk6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5l
dD4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5v
cHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDQgKysr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMi9nYWRnZXQuYw0KPiBpbmRleCA4YjE1NzQyZDllOGEuLmNhYjA0ODE2ZGQ2YyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9k
d2MyL2dhZGdldC5jDQo+IEBAIC0yMzg5LDcgKzIzODksNyBAQCBzdGF0aWMgdm9pZCBkd2MyX2hz
b3RnX2hhbmRsZV9vdXRkb25lKHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZywgaW50IGVwbnVtKQ0K
PiAgIAl1MzIgZXBzaXplID0gZHdjMl9yZWFkbChoc290ZywgRE9FUFRTSVooZXBudW0pKTsNCj4g
ICAJc3RydWN0IGR3YzJfaHNvdGdfZXAgKmhzX2VwID0gaHNvdGctPmVwc19vdXRbZXBudW1dOw0K
PiAgIAlzdHJ1Y3QgZHdjMl9oc290Z19yZXEgKmhzX3JlcSA9IGhzX2VwLT5yZXE7DQo+IC0Jc3Ry
dWN0IHVzYl9yZXF1ZXN0ICpyZXEgPSAmaHNfcmVxLT5yZXE7DQo+ICsJc3RydWN0IHVzYl9yZXF1
ZXN0ICpyZXE7DQo+ICAgCXVuc2lnbmVkIGludCBzaXplX2xlZnQgPSBEWEVQVFNJWl9YRkVSU0la
RV9HRVQoZXBzaXplKTsNCj4gICAJaW50IHJlc3VsdCA9IDA7DQo+IA0KPiBAQCAtMjQwOCw2ICsy
NDA4LDggQEAgc3RhdGljIHZvaWQgZHdjMl9oc290Z19oYW5kbGVfb3V0ZG9uZShzdHJ1Y3QgZHdj
Ml9oc290ZyAqaHNvdGcsIGludCBlcG51bSkNCj4gICAJaWYgKHVzaW5nX2Rlc2NfZG1hKGhzb3Rn
KSkNCj4gICAJCXNpemVfbGVmdCA9IGR3YzJfZ2FkZ2V0X2dldF94ZmVyc2l6ZV9kZG1hKGhzX2Vw
KTsNCj4gDQo+ICsJcmVxID0gJmhzX3JlcS0+cmVxOw0KPiArDQo+ICAgCWlmICh1c2luZ19kbWEo
aHNvdGcpKSB7DQo+ICAgCQl1bnNpZ25lZCBpbnQgc2l6ZV9kb25lOw0KPiANCj4gLS0NCj4gMi40
MC4wDQo+IA==

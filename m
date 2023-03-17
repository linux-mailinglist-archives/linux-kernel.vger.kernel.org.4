Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987D6BDD6B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCQAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCQAMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:12:08 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5B46085;
        Thu, 16 Mar 2023 17:12:06 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GMiI7s006752;
        Thu, 16 Mar 2023 17:12:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=RDbhoot/qfj8fET3IDP2EywuOmbxG9qoL6KVo6e/Cog=;
 b=vDNu8bRbCXSn/64/gwWzZLISO40PrGArpGpE+X3sHb8UWBGkedkmUWWnx30ONLwAv8Fb
 W8CcaB8+12nhdj9rMrMqpYouN0JDFU3DFJtryJr3o4SpAqfjKNT8iU/PVF55WK8UmHy8
 K4IY2qcrYGv9U/YISLct29V32b94UlIgmIF7J9hS1Oegs0OnteeHXpTaE4WfKbKEO3+W
 UUsHpcVEUA5kp/4HL9cOxO2NdF/6TmSmNHGNoEOzM41kcci8E4c6vpRY84fjMYTDKZvR
 TAQGbWrNLxGu1r+1VBWwHLzJPY2MmR3aBLFBcoB0jBw80IS+KHeelgX7FvoIZ7v7uEHF 9w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbpxt6aky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 17:12:03 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CDA5F400E7;
        Fri, 17 Mar 2023 00:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679011922; bh=RDbhoot/qfj8fET3IDP2EywuOmbxG9qoL6KVo6e/Cog=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CjqGFlCE4PhfQJzMatSEnywqbh4qliZ4yaweMMvPuuZ6EX3OzbhBDO0z4DODeFyhT
         pKt8ixONQlrHry+dFMCadbqyHMNb/O8vxBld7ECBUIJG2Wk3XKOVGFO6DGwwrwnAD9
         +wJonW38TlGUJOekKJOUnNHt7/nPmBkYeWwWTvzbp44vNyhEFDweXYBwT2GqQ5z6fr
         dkkRCOmmy5dGM1kld3zJYaJW2Kd55i53buIG76CHEt283oj59BWNf8PS4XVfXxxqk5
         KrsxiLRnOeKRU3woYpSkEKUkqIMrGag4sqZDSuJTFTGqkjqATzuPaDs8G4rh4qEO+x
         GKfOqgpHE34vg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2AD2EA0062;
        Fri, 17 Mar 2023 00:12:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7A24A400B9;
        Fri, 17 Mar 2023 00:11:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="UwuKicDN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9iyjeWVDbyu+Bz2fr0H6TiOAxJM+Ha/TfyDu0h1sFnbagom5mlHoLZYr7C6a15kDDfh/+wRf913d+w8rI8NW3fvALyYl6A+lTCDCddO/6PZZ6rAJ61QvNLTxTeNHhibmbLZsp6a8lcONHQQ1z9YTVnPBrQWy1CFDgt3SA3JHm4oyFj+s/ij2D58HqH7LynQUnIulpKjxJYUBrKrIXLY2wbiNLndRrhDYpd8Qpu2aLOdwQDz3qNjDE3eCM8TZTHk9nQDjKClSxbq0uCn4wFz5Abcy4SM6gO0wE+917Udg8/skifUf3dBpTGg+I1UjTbHrkvnbd+eZ54l3OlmgWyovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDbhoot/qfj8fET3IDP2EywuOmbxG9qoL6KVo6e/Cog=;
 b=irIRSHqvLRmX4Ehh+MMa0WQ5L0w6mTOJaTw0UfXvRpys55hoP27oBVtWxWlhHGFRtcHkRh0NSKR/ZiZ46xIxOKD5L8jznizLnleS7z6JikEevGJ5GWm6B534DyupmWTavF/zrdhwviDvKhQoUdofu3ymPDeX1a/W20ZaDN9EVSrXAHYVUXQFkyg1lrKYB2vBCRxvSuBBUNaXuuWGah/NnlXdNEmJ5KPFTMT4EcZiW8/t0Ph0LHWLJeGKMAfhMVkzueEEAc5BqGfxMNW+G99w/ntiHgzIEMOX0X0wmR7XkAhEZ5OnBDnmSfvs6mX/2sGhM83MJEU4cQ/k5In95jrOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDbhoot/qfj8fET3IDP2EywuOmbxG9qoL6KVo6e/Cog=;
 b=UwuKicDNiv1xZKFpRX/t6CJ9kUurREldHy06tTLYWSR11mjnXfd6krfUQ5BTqE6G3Hx5hIRRfchRikuRQkkZSQxarjjhsGHoD//4ig8tbuyrKPv8BL5hux7Zs1g0spBx2w0+scfV5AMp6fWTbt8phuknliFvD162aIw8l2CP+9s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Fri, 17 Mar
 2023 00:11:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 00:11:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZWGBkIcbTRueiF0WmOHHs1egwbK7+GWGA
Date:   Fri, 17 Mar 2023 00:11:56 +0000
Message-ID: <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
 <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB8812:EE_
x-ms-office365-filtering-correlation-id: 238e34ac-e90f-49c2-da83-08db267c381d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gIrcQd8DJ+7XHG6ww+AjauQONqmThOgdcw1Z1SCNk0QCH0wkmA0Pss5iDt/LnuyVWjP8Y+lTZDAYq1+mPMR9es1ZX0ruSl66W0vyyt6OO7l+y4Sz+taefa++EDxpYG69Gi2/CNasLsGXM2Dvsp3VK+cBy2UqDE3GXIuWoU0/3DTj/9YWWeLTGsVT44kKjoH5IgPXgrOfDHMFI7riDZ1m8Cg7ncT+GPRRWOtLFRGAybgWbiV3y0Wc832EGIUZI/p09ZQvTowkPFzJhnV8S7Ec+wHZ+vlFhuOD2KhMioC1gxKELjRjQTGkIA0A2bRHt7wAaYMOKHsKwShTk2/Ej9qejvDvGqBeOeX/UNRO+vUqlc7vnUqDJiIMF3FkWjYsXkOixooJ3z0siq8bsCzRdd6TtxAi1gyD+YnyJxGkBmuEubbH2GAk/WQ2UJSphK52KMqTiBqOMkSIWo3QAU666v6zSEdMkbUDIZ3xXUVsmy+XgETscoDkK0+dzzJgkP/XmqlJG4RzYEa0GTuqHzE95eLNbS156XydoAWh8cDMpBHCl7uKLzedTo1gZjPpt3eWVEMDM5b5Vw41tCOCW0Z+GLfrb6svGB/vWMhhEPR3G6FJS2jhFuh9GJKAYYbLymeULFNzViBwyIqL24Vgn8R37evRFgJhmsKIPVXSV8FOUq1B9yDBqe2ysmH5ekLngZZdB6ZimnyL4QvNylsHuSFSkKsSvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(8936002)(5660300002)(4326008)(41300700001)(8676002)(6916009)(36756003)(38070700005)(86362001)(38100700002)(15650500001)(2906002)(122000001)(6506007)(26005)(2616005)(71200400001)(6512007)(83380400001)(478600001)(6486002)(186003)(1076003)(66556008)(64756008)(66446008)(66476007)(66946007)(316002)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y09FQXZWMkdmYUpIZnlKS1FkK0U4bTcwbisxWDhlQ2dSaDhBeDJsM0c2eVhV?=
 =?utf-8?B?TjF0a2trNkMyR2ZCaWhtMXNmd2hoVUR2RTRKWnd3Zm5zeDNqV01veDI5UCtD?=
 =?utf-8?B?RjEwNERaYlhsVENqUDd6TllZOVZmU0xTSHlxcVRzUEFqYXpUWXhzalk2STQ4?=
 =?utf-8?B?NXowK3VHdnpFWmtGZXNuRDh2aXROTXdwd0tkcHFPZmJ6NjlEdWpReGlCejBV?=
 =?utf-8?B?bTFubk5mMnpQNUd1c2d2VmVxbDNpMU9UOGI4dlcrNHpNN3pHUWk1d29sa2FE?=
 =?utf-8?B?eUlrVGl5aTRwMjB5dFhPQ1Z3S0MrNDFabE1lT3NjK29pdnJ5NHllUWJWOVJ5?=
 =?utf-8?B?YkVjQmdrV2d4NEVYdGhweEwyWXdOK2NXdWJOd2Yyb0Jnak8rcDNZakNWZzNF?=
 =?utf-8?B?SUZsYzVuQnRodDlrL0pYaDAzRWc1YkpVamVhMGk5MjA4MEV0NDUvUVZIY3B5?=
 =?utf-8?B?MlhLOC9xUGZVM2xOd0t3QkdLbmRKMzlqWVd1eUc4cWhXRU82Ymd0T1BQKzZr?=
 =?utf-8?B?SjhHMENjMWVSZmkydHQrME9jd0l0eXpDRjhqWWU2UktadW9FaFZyQWZIa05w?=
 =?utf-8?B?QWsxTmpZZEVGTlQ2dzY5YUFLT0NQZkNtSG1PVG1VVnVPWHhER0E1M2NnelBG?=
 =?utf-8?B?SkZxL1JnNE5yQlVzY1dxQjVCcmI3RlNWTHhvKzloUTlDQTluWDQyWkxYdUpR?=
 =?utf-8?B?QnYwbWNlOWY4ZXB4Unp2R29LaG4xZWhTd0IvdlJJQS9xOTA1dEV6UEN3dldq?=
 =?utf-8?B?YW9pN294ZzVNbGRBZUVPWVQrY0NjcktvdUNOR1g1dG5pMW1zM0Z4R2xTVnQz?=
 =?utf-8?B?Q01JMWdBRE0rYk1jdUUxUDhWTVdObytYV2F0RFN4d0o0ekEyTjgxVUlpYUQw?=
 =?utf-8?B?STI3ZjU5bkJnNS9WTFF5WFRoSlFmTHNnU20yb2pxOHN4UzBhN1RDMHRqM2tP?=
 =?utf-8?B?MEQya3U0OE5rMWNFbWtvNk9kS1BDVzFqTmh6aDdjbVM1N0hFSEswVUhDa1I2?=
 =?utf-8?B?bHJNbzlEMnZoRGFVVUVMcHk1dUNINnhlNktzdnc0Z0ExNjRCcTc1WmNrRUlG?=
 =?utf-8?B?aEtodjViUlcyaFJ5cTVkN1U1Ym9aRFZYVi9tTE43b0ppeFMwNVVaU01aYlY5?=
 =?utf-8?B?ZmJJNTFNbTRiaWl4dG02eXQzZUdDZm8vdDdKNlZOM2lMdzVsdEdzZHNjWTg2?=
 =?utf-8?B?bDZWSU1jVXlvWWlCekFnQXVFVTFUT0RLYVZ1a3dxRGpUNTlSaEpzUGF5QUVw?=
 =?utf-8?B?SExFY05yLzNhbEZMNHJpREV2eU41ZUJkMmk4UWQ1S2pJV2tDOXRpdGE3N1Z1?=
 =?utf-8?B?M1drN3RMMzQzRmZ4cUJYM0NoQkdLSUNwTDVWTHI5ckxrNUNUbVhOR0Q1Vkl2?=
 =?utf-8?B?K3locXVxTC9ub0hyaGtCOENJNk1tKzNGZUszRGZpYlJxT1RGTTFXMG1TWFRK?=
 =?utf-8?B?TWoxWWM2WnIvdDV0dnFwYnZGUm13S041YUNLckpJRThmNFFqV1RLOXE0TCt1?=
 =?utf-8?B?cWZBN1hrZXlyQTFON2NPTzhKT0gxQnQ3ay9TOGFveEx4SUs5UytIOUZRM1hD?=
 =?utf-8?B?YW5NYXZ6Y0FYOVNFUTByb2xqYmdCMzBGTjdkS1RWclNkcEtRRXVDM2VZQzFT?=
 =?utf-8?B?RDd2cDhSMjJqeFFpUjlTVEMybldiM2NGVDg0ckJyOGdjTCtveG9kMDJ4QlRE?=
 =?utf-8?B?dHNoa2U4OVJIek1hOXYyejI3dFFTQWFZakQ2eHNWNmtEWHZHd0cyYUl5RjdF?=
 =?utf-8?B?K2UvWjBJeVN6ejVWS0xGZFRqVlJIemN6UjFrREg4WnZiRnVINXlVbE9weHJt?=
 =?utf-8?B?R0xVMUtYc0tDZUQxTjU4RnpLUHVoVHFnMEZkMThqNEJWQmNMaXllMXFWS3Ns?=
 =?utf-8?B?ZkRGaHVIWFl2THlTYUJhQXV6RHRDMFlHeGljM1RVQy9jU3lHWjc3dy9md20z?=
 =?utf-8?B?eDZVNU0zKzFCamRXWXNHNThIaEpuRXNiM0FJMlJRWkJMN0YwdmczUTQ5RXpx?=
 =?utf-8?B?NTV1QWFKY2lBQi9US3J1WlBnYjNYUFd2TGNNTEFIMWw5VHNtSzllN3cvV1hx?=
 =?utf-8?B?VTg1cXFMSlFhb0RtWkpIVDY2YUZkSUI3NVNFSElISCs4T3hmTXoxZ1QxYVYy?=
 =?utf-8?B?VE53ZE5zMEo5cUl6dGlhLy9LOGxWa1puaGQ2WThSMnhWem85MWFma3lzSEM5?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2901CA1BFADE34AAA8A28F9E7D210D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +WindvXqgFNm1y3umOzSsSxVlJuozMKnIeN/bMwk8MEaMEW2udn36k6tz1UJDo2QHEAmRd8MxUBF8M234oVr0OkkUcYuWPaEX9rUmEJlPgFH3Dt8vvGu2s6i7w7zLP0znDahBWNAPXVo0DMCOQ/NkbxowWNKppH4Oux7gRRsFtkcnkIvrCgCmAtidhUg1pBxGkayza/CyAkXg7LVu/q/sIO5UGgjE78UjAcu5v1FOPmKXNM2/exeHf60LvoIkdyVrvLttCLbGrwXyJg3llU1PO/AWFsUNSwZ0luKD1FJo1lSxoW59NiI976Gm1Xb3Ae7ifSAgwFvJ99aXJl21nMpL9ysUwja3+A2+GY/huGVA5tgTcrRZDe7o6QYxwkJ5O1c9DiAmbJyks6/5pWQN0OTZiMYaNhFlS4hf3RjjDIJ610C4p3w0IDX04oAAB3F10IT+qva0lUIPriG85zN2IoUL96uT17gWQT2WHCaQ1sV3VK3eVPrXxcnzS5I1CObxkf+AE7bRU70xZORZEoGZVP5QjMKQ/OXbxNKTyJ8ygDY4BpVlusEN47IyHFlshxZv4MgL9rJry+nDGoYfgndJD/iGtQ+FpDQ5ww+y5Zd8+eTEUxUVMs7ugife6BvjejCenSFrH+y2ocYdr/n1WHfdmn1mY6KgOYUAtwg9QN50NEY/JI64q4lAAshTWm5jqXxUB/OBGJ2Tp5IkLqRkIygaYWoaCZrjDacPGjpfuL/nZ6RS6DlcD8c6EgA0UKsf9Oa/ctzBuDYJ2i9m1ikQ3IUgOqDW2dh64tKsrpC4GRTm9lVxvzAygd8eYxzzEOLY6554JKBDWAXzs5DsdSakbWvxqIQJfYOwgasFycjp9WZmITHPEtoeRV/Yp9NIj/xxfKFxLW8pR7RXILshEpmG7VXsDc3Ow==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238e34ac-e90f-49c2-da83-08db267c381d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 00:11:56.2025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdnqWUzTCQugmD5o5gccPipffTiMcejKy2p3eOFTUNnkU/zZccq7hGV6UW0Rk0pm22BL6g7ixNYMCc1zq9ux9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
X-Proofpoint-GUID: IDlyQeBgY1qxGHk6rn7TwxdwCSDIjEHI
X-Proofpoint-ORIG-GUID: IDlyQeBgY1qxGHk6rn7TwxdwCSDIjEHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_15,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMTYsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBhIHN1c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiB0
aGUgc3VzcGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3Vw
ZXINCj4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVuY3Rpb24g
c3VzcGVuZCBjYWxsYmFjay4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBj
YXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1
cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQgcmVzdW1lIHRvDQo+IHN0YXJ0IGRhdGEg
dHJhbnNmZXIgYWdhaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxx
dWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWNtLmMgICB8IDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vf
ZXRoZXIuaCB8ICA0ICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEzOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiBpbmRleCBhN2FiMzBlLi5jNDNj
ZDU1NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4gQEAgLTYzMyw2
ICs2MzMsOCBAQCBzdGF0aWMgdm9pZCBlY21fZGlzYWJsZShzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpm
KQ0KPiAgDQo+ICAJdXNiX2VwX2Rpc2FibGUoZWNtLT5ub3RpZnkpOw0KPiAgCWVjbS0+bm90aWZ5
LT5kZXNjID0gTlVMTDsNCj4gKwlmLT5mdW5jX3N1c3BlbmRlZCA9IGZhbHNlOw0KPiArCWYtPmZ1
bmNfd2FrZXVwX2FybWVkID0gZmFsc2U7DQo+ICB9DQo+ICANCj4gIC8qLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSovDQo+IEBAIC04ODUsNiArODg3LDcxIEBAIHN0YXRpYyBzdHJ1Y3QgdXNiX2Z1bmN0aW9uX2lu
c3RhbmNlICplY21fYWxsb2NfaW5zdCh2b2lkKQ0KPiAgCXJldHVybiAmb3B0cy0+ZnVuY19pbnN0
Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBlY21fc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0
aW9uICpmKQ0KPiArew0KPiArCXN0cnVjdCBmX2VjbSAqZWNtID0gZnVuY190b19lY20oZik7DQo+
ICsJc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5wb3J0LmZ1bmMuY29uZmln
LT5jZGV2Ow0KPiArDQo+ICsJaWYgKGYtPmZ1bmNfc3VzcGVuZGVkKSB7DQo+ICsJCURCRyhjZGV2
LCAiRnVuY3Rpb24gYWxyZWFkeSBzdXNwZW5kZWRcbiIpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0K
PiArDQo+ICsJREJHKGNkZXYsICJFQ00gU3VzcGVuZFxuIik7DQo+ICsNCj4gKwlnZXRoZXJfc3Vz
cGVuZCgmZWNtLT5wb3J0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZWNtX3Jlc3VtZShz
dHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiArew0KPiArCXN0cnVjdCBmX2VjbSAqZWNtID0gZnVu
Y190b19lY20oZik7DQo+ICsJc3RydWN0IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5w
b3J0LmZ1bmMuY29uZmlnLT5jZGV2Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBJZiB0aGUgZnVuY3Rp
b24gaXMgaW4gVVNCMyBGdW5jdGlvbiBTdXNwZW5kIHN0YXRlLCByZXN1bWUgaXMNCj4gKwkgKiBj
YW5jZWxlZC4gSW4gdGhpcyBjYXNlIHJlc3VtZSBpcyBkb25lIGJ5IGEgRnVuY3Rpb24gUmVzdW1l
IHJlcXVlc3QuDQo+ICsJICovDQo+ICsJaWYgKGYtPmZ1bmNfc3VzcGVuZGVkKQ0KPiArCQlyZXR1
cm47DQo+ICsNCj4gKwlEQkcoY2RldiwgIkVDTSBSZXN1bWVcbiIpOw0KPiArDQo+ICsJZ2V0aGVy
X3Jlc3VtZSgmZWNtLT5wb3J0KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBlY21fZ2V0X3N0
YXR1cyhzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiArew0KPiArCXN0cnVjdCB1c2JfY29uZmln
dXJhdGlvbiAqYyA9IGYtPmNvbmZpZzsNCj4gKw0KPiArCS8qIEQwIGFuZCBEMSBiaXQgc2V0IHRv
IDAgaWYgZGV2aWNlIGlzIG5vdCB3YWtldXAgY2FwYWJsZSAqLw0KPiArCWlmICghKFVTQl9DT05G
SUdfQVRUX1dBS0VVUCAmIGMtPmJtQXR0cmlidXRlcykpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+
ICsJcmV0dXJuIChmLT5mdW5jX3dha2V1cF9hcm1lZCA/IFVTQl9JTlRSRl9TVEFUX0ZVTkNfUlcg
OiAwKSB8DQo+ICsJCVVTQl9JTlRSRl9TVEFUX0ZVTkNfUldfQ0FQOw0KPiArfQ0KDQpXaHkgZG8g
d2UgbmVlZCB0byBpbXBsZW1lbnQgZWNtX2dldF9zdGF0dXMgaWYgaXQncyBhbHJlYWR5IGhhbmRs
ZWQgaW4NCmNvbXBvc2l0ZS5jIG5vdz8NCg0KPiArDQo+ICtzdGF0aWMgaW50IGVjbV9mdW5jX3N1
c3BlbmQoc3RydWN0IHVzYl9mdW5jdGlvbiAqZiwgdTggb3B0aW9ucykNCj4gK3sNCj4gKwlzdHJ1
Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBmLT5jb25maWctPmNkZXY7DQo+ICsNCj4gKwlE
QkcoY2RldiwgImZ1bmMgc3VzcCAldSBjbWRcbiIsIG9wdGlvbnMpOw0KPiArDQo+ICsJaWYgKG9w
dGlvbnMgJiAoVVNCX0lOVFJGX0ZVTkNfU1VTUEVORF9MUCA+PiA4KSkgew0KDQpUaGlzIGZlYXR1
cmUgc2VsZWN0b3IgZG9lc24ndCBpbmRpY2F0ZSB3aGV0aGVyIGl0J3MgU2V0RmVhdHVyZSBvcg0K
Q2xlYXJGZWF0dXJlIHJlcXVlc3QuIGVjbV9mdW5jX3N1c3BlbmQgaXMgc3VwcG9zZWQgdG8gYmUg
Zm9yDQpTZXRGZWF0dXJlKHN1c3BlbmQpIG9ubHkuIFBlcmhhcHMgd2UgbWF5IGhhdmUgdG8gZGVm
aW5lIGZ1bmNfcmVzdW1lKCkNCmZvciBDbGVhckZlYXR1cmUoc3VzcGVuZCk/DQoNClRoYW5rcywN
ClRoaW5oDQoNCj4gKwkJaWYgKCFmLT5mdW5jX3N1c3BlbmRlZCkgew0KPiArCQkJZWNtX3N1c3Bl
bmQoZik7DQo+ICsJCQlmLT5mdW5jX3N1c3BlbmRlZCA9IHRydWU7DQo+ICsJCX0NCj4gKwl9IGVs
c2Ugew0KPiArCQlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gKwkJCWYtPmZ1bmNfc3VzcGVu
ZGVkID0gZmFsc2U7DQo+ICsJCQllY21fcmVzdW1lKGYpOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+
ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICs=

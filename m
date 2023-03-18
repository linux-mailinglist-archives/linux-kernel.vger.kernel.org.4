Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202EC6BF761
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 03:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjCRC0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 22:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCRC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:26:29 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9614177991;
        Fri, 17 Mar 2023 19:26:25 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HLnEBO003861;
        Fri, 17 Mar 2023 19:26:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=y0iSUY3CATBzK5QxqGFTzHFwH9PErNT+Azj/WbQ/Q0M=;
 b=ay2prOR1e/ANrIcJV23Yd4wTj+V4lsn/nCGxQkpblcnd/cPbNSCd9xUnhXvoA/LATXJV
 CDmxSuYir7yoBebkWMUK2E21ltA4Ydm1UVaDZoAagxpi3AYkgURwgB87/JQXvvH6YjjA
 dmDexm3bWbAVrzWPsnJYb3ttOA1h7qx6jaei77EV/EifjCLVdgbM+3IivjtT/Zg5LLpg
 iNvOZwXquZNeiHCkdj8tCLq56VlXE9zY/wQVh67b6ivXC0DvSe5BOpeMFdTASDpxmxOk
 E8DfbhCPBcHwrE5pFKb7GuUEv9kwW3Oq/lhdb4tX5uPUN4nGOoJRseAzt7M58Q/b7xc2 Eg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pbpxtcsux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 19:26:21 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B1559C00AF;
        Sat, 18 Mar 2023 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679106381; bh=y0iSUY3CATBzK5QxqGFTzHFwH9PErNT+Azj/WbQ/Q0M=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h10zvXb42psoq1IBgUzwlTVwfWw5uyK3t+2/0/mGO9OATkt0nkAgJRVmvzi3g2ANK
         YpZe9HgmkeJZ08/xfqs/pIWcVrr/Dcczyae+lJUNAOg7dMpuIQ10Pm4sY86HrAFwj+
         +LauUoQDKytE46ZwWTobOdSmWc8iMn//IFz+UFqrjr/2BnCy1FVh738Hr9DyKsaG02
         TkJGgkcOu0qfOPQIwAbi0wVTXfajc+9IvNFEUHDvIVP2uGob8CRWTQ/RXadwUCzzVc
         78XzRvv1CAkY2DP40VDGCR/RiLZxTlvsx+u6GLVarwAvkMfSL8wg2JylP9B7P9y13t
         VJGalZx6Du3uQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D3E8BA0093;
        Sat, 18 Mar 2023 02:26:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2D55C40073;
        Sat, 18 Mar 2023 02:26:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MTcG/mxd";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL4GAn1tzRD9lRJU2begPDCeUZyr8DdMHwxwtJO1mR6NjWS6pTfxYbUqUZqN5kcPGRcT76a+trfdm9IP1rd7WAMcjFAASczLkSGIzvtxvwOxuIAkecGL98y10riqYdOGozfeXZjyLjK9iydD0g44JGRM7hC+robmH00Cob/jenU5JYarsQz0fNiZAQmm1aG7NIV6nAUQioJCvNDrTY9Qs6t2+641X3H7t5BEYoJmdOdeKrclW+WSybbWRCDR65HBW+G7Z4ed3u7J7NgF87DybIIvuUGbXNr4ls7EWBJfizxH5iYizmvTsU2thk3LPMpKsS4fLdfBKlWjrQpNbKZDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0iSUY3CATBzK5QxqGFTzHFwH9PErNT+Azj/WbQ/Q0M=;
 b=H691zt8maHICZQYxpfRV+Y4oZIHaUgZRdKiMRDfNCdHH2D6R8SBxB3vrNXVA5EuCajNFdZ906uIfswiCTw/GAueTSgu5566+/xprhXqpwKvZOi2RctpAM4ZgbEP8z+vINryEDiRjpU13XfgnZbaeIyOckChXTjeLqeQdaCtSEpiVGUnrn88Qg/rFkkJR/UxqPnP+PBXPaJk/sP4B5PT/bRMp5dVAcdh+JA9qkIYkrHwtB2oH9FyXph93i1lV5DAXdTQ7CAes5RWII7CvjYGYzazhAeUhG9/W2raKF1PhBCNKlqlClCmqldj1dNfhw1qBMOpnqgVpmVbJhwJGZ/Tf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0iSUY3CATBzK5QxqGFTzHFwH9PErNT+Azj/WbQ/Q0M=;
 b=MTcG/mxdDx6cyLranf5+8oyLBKLx8uQWtBVYuKbgIMcbk6V/hrigC7qZV0Vau7Q/n/XZlrVG8a289A7pswYRcYn3sBvjr7ILa7DVU3Tax7FI1wp+8Xl3jEwSYLeyqVO488pl8+dZELPjNCO9CBPOxwHmztrn9Ov9ihymdvSFAFY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Sat, 18 Mar
 2023 02:26:13 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.035; Sat, 18 Mar 2023
 02:26:13 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZWGBkIcbTRueiF0WmOHHs1egwbK7+GWGAgAEqaoCAADpLgIAAHyEAgAARwACAACI6AA==
Date:   Sat, 18 Mar 2023 02:26:13 +0000
Message-ID: <20230318022558.z5v5ktfus5yt4atc@synopsys.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
 <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
 <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
 <0bf5bddd-515b-76b6-f22f-9da10a140d83@quicinc.com>
 <20230317212831.bcapq26jnuk2vkws@synopsys.com>
 <20230317231956.w3kr3zcy44odxdko@synopsys.com>
 <2632a958-2750-c057-2606-c2541efff392@quicinc.com>
In-Reply-To: <2632a958-2750-c057-2606-c2541efff392@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB8193:EE_
x-ms-office365-filtering-correlation-id: fc12a312-6358-4555-f8f1-08db275824cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ceViSKY9VI/yYAicl9o+bGIc7h8q68n8WMqVW2pHCNdOhjdovGAQ/pkN8fkpUaYZAvl3+c8VOTBeGgPEuPPmyITdWQjF19MzEcHB4Q9ROt5mj5G0ot+i4xbCVbMOY1dxcyQ/0lLFrZ++XhxcfQ8ew1aSmywpAm2vw0VPPmLhlPZhxqoevl9K+hRK7qxa4Hq/d+fliz0NniFj2C7N53U/pkmDNBK4EsddfsgXxa0K+W9c4NC5hDnOWiYz3UF6WhdBK25yJ3B65r0wSDrbYBg5bhQsSQL70nKwQOlCAjJcBEcxyJ5o75ncALXQi4CLyD0x72uPXa5OjwHmp/icAxnwNA4XxT5X/c7TnFqpWgxezeUTi1L0qOamQuYv970N2Z6XsrshptqY2S/V4pLxppuxWFnronE9IdVXvzR2F+uWUeHlibKB//NioarDI8oidlVVtxAtiijABwFeyAIEALKJ/lj2LVs1GM236wkwb4N4rWJj/Vv4KnHA2bEBhZmG6b1t2msGYbFnj/4x7Lm92R6ebR43XxclsL7gzct/ADyBLWvI7iPutHppTkyxAMkbEH8kToKGI1Mrkqrz68fdGCsGBFV86Cqph2RMnCksO1ecKWKiFQd0NIXii1MqDxuwZQY41NH9NtU/wseLMPRMwAFjhs6ORJgfnSz1wvzRCd2o5QQpWczsDFviQaJ+iygVFa+c0vYoq6qhq8gaRwJOIzTxqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(5660300002)(15650500001)(2616005)(8936002)(38100700002)(186003)(122000001)(38070700005)(6506007)(6512007)(26005)(1076003)(41300700001)(53546011)(86362001)(2906002)(66556008)(4326008)(478600001)(6916009)(8676002)(64756008)(66946007)(66476007)(76116006)(66446008)(316002)(36756003)(6486002)(54906003)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFN3QkZRTlAyd0xjRUFIVlZmTERuVy9STUUwZGp5MUVLcklEZjVXc01ZbkJZ?=
 =?utf-8?B?U3A5TVVnNTNwQVRCd21DaythOWIrSE0xNERBQnNWbWR1SEpyNllkYnZQQ2U5?=
 =?utf-8?B?S3M4Mlc5MEtRVndVRzF2UFY5TEZqYVZPY3RmYjVGOW1GNFh0cmtyY2k3Qy92?=
 =?utf-8?B?WldOdGliNjk5amVWSUhaNlIwUG5QTGhqK1VaWXZKQTE0RzZab25rNmlvK1dx?=
 =?utf-8?B?Q3N5dHFIYVpRNzFYZnFQSXQxdzNJWUtLNGRJZG9ieHVJYnVGQzJBWFhKeFpE?=
 =?utf-8?B?dXhUa2J3VGlOTDBTb0tDNFNDR1pMQWtQZ1R5SHB2dmF3bThzNDRKVmNBaTV5?=
 =?utf-8?B?MThUWmJXV3R1UUZvV3ZldDJwUmRJRG5CUWJDQjk1SUErNE9xNGNJV1dmQlN1?=
 =?utf-8?B?ZXd5aGl4QnVwenNPVUZaZEtFRzEwM2w5YjNCaFNESmE5aEdpaU8wUDdZYVRz?=
 =?utf-8?B?c1VLbFZBMWxnOWdYczdmYk9TOHVCM1BObkUwbnZod1pxVzZFUWhKczNFV2pZ?=
 =?utf-8?B?ZGRpWHZpT1BLaUlHNytMMjdrb0crQWxsNXZPNmkrbTQyemNPdklxQ1VlNEtS?=
 =?utf-8?B?bEFJWVNJT1JmSVRnZzZ1czZBTmg1K3lLNXlmOHZvQS94QnVlSSsyUXJWaWxW?=
 =?utf-8?B?NUNDaW5VZTdXdDRGWmR2Q3hPaWdSMGJ3RGU2NTViV3BERHdLbzBDT0RHam13?=
 =?utf-8?B?aHltcWJWWW80V3NZVTQ4WkdobkdNMTBMcTllMEw5dGorbUJMSzBtQ01sT25l?=
 =?utf-8?B?YWVwRC9Kd0ZkWFRtQ25hSjF2NDZxVWQyU0dNRW1jVWFQUTU5c3pTczdrOUtM?=
 =?utf-8?B?WmxuUURQa0l5N3JpbDRwWEN3RVRwV3kxbGtvS2Yxbm50V1hOdjNQU3lwTG5a?=
 =?utf-8?B?Ulk0VnE3UHZFUXBRaEd1UEYrTEUzMytncGNva3JJYlZEQ1pSNHpvTXpqOFZr?=
 =?utf-8?B?Rk9ROWdMa0ovdVNVZEw4TUpPUVlieVYyUk5naGN6TWFyWFJXZGhsb3lHOGVQ?=
 =?utf-8?B?N1JoQUNSM0FUalRsSnNZTFdlckJUTlRVVGdSaWRITURHbitTblBCNk5DTE5K?=
 =?utf-8?B?SEVuN2c2b29ycHd1WlVZMzNlWmVLQStmYi9yTUJwYTNoOUpLMGcrd1I0WG02?=
 =?utf-8?B?Q0NwOTRaZG1HNGFpS2t4L2lad3lRZTM2elE0cUZsRUZGYnc1U0hyUDRaRGZP?=
 =?utf-8?B?a2YxaHdVOUdQRFNFNHVVaFFsWHh3U2pjVkxKUHVrY1dxL2phRXdzY0lteEUx?=
 =?utf-8?B?WlcwWVZUV3BhQ3Y3MUQyNi9LNkdMQ0VsT2NJSUhrK1RpakR5ZEM0VzVnRURT?=
 =?utf-8?B?REJSL0Q5L3ZwVFBzNVFNQmVDbFRTREt1Vzg2YkNucFNQbWwxYi9jcnl4S3pQ?=
 =?utf-8?B?bFpxUEw1UmdhOFEwMFRCZzhSVDdKd0dmWXpwVXo1OFhwZVgwODZndkF5alRY?=
 =?utf-8?B?dThuWEdQYnNXMldjWFJHcURGc2FuK2Zoc2ZwQVkvSW0wTzdHZ011aFNXVjE2?=
 =?utf-8?B?N2VESVR1bXNqaGNBRUFUelpOVFUwRHc2VzZqVnNaTm02bzgyaWJuVnYvL2pU?=
 =?utf-8?B?L0haNk0vNkhmRHQ4TGxSSE55enhNVFNZSVB5NDhCdUdvLzB1SjBFckFPL3Iy?=
 =?utf-8?B?UzhybCtFVmJwaG9nVi9PMDVzSWZOTFhvbkRaTzlvSit5WXNkU2JocDZVS0ZO?=
 =?utf-8?B?bEpZbUZwK1NkNUhmdXIxUEl4TWhkdWZIRkt1a3ozTkF5ZTFZWFVCU1Ixb3Yy?=
 =?utf-8?B?Yk9tK1hYNXIxOVRzN1hvMGtwU2oxNWZNemlQQ3habTk5eEhHeFREWkpIVkpF?=
 =?utf-8?B?bm8zUEc0ZXl0RTlNdFNWVnV4R3hWWitnbHZGTUxWNVI5UjY1YTRyMVp5bjFv?=
 =?utf-8?B?UHpBRjFONmhkT29MVlBaaUhKOUN0Y0wrM1hvcVNsWHAyQ2tWend5NmcvQ0cz?=
 =?utf-8?B?ZHNJY3gycXpHeHdqRDczQzUwcUFaS1dGZk5aVmVXSmJGNTlaRFJ6R2F3cTJm?=
 =?utf-8?B?QXRJM3JuZG5SMVljenhjTWVONTlIKzdlN3puTTV4cGdyZlhSdGx1SUp4YmFL?=
 =?utf-8?B?VkRuZlZYblQxSmdNUFlBT3lNakJvU2FmdWZYYWJ3aGVCT3YxSWVITytZSnor?=
 =?utf-8?Q?UP0EgwIX9KVvwHKG2JZF+iHlN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0687B469C860CE479DA62C4C983F5691@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: spQpWECsF00KPcK5yfvpi01k58AH1/DBtkQ/RGJrN5d5S1LHGCF8QjpwKgfXoVObZNbDrRFm/uOQRDkh8TKLaNOFpRpQJ5BfcAQWlW4ROgYlOhq82G/i7+5SdaSPVMVWSRlMlcJm/AZLmcTLzqiSH+vlwNZPSwytu/vY/3/Yb1roQ1E2pHYloFfb/zj/SDzGbpNsQngdxJuHFMOa1aAqHQOIu4vQA7NQsUIs9Y68mhrhrgky+K3h7OA/vqCr6nTB82nePW5XNx28w5a1dQVb8xwapKrYRJTO4v8gr002CphkdVhUuWpYOSmmqtwIA6lGPx3h6CprLR83KNjrrL5Gv0HNXWDw/GlmUI6DOIg/DMdGCDhYC0Q166OPYorpkDi5phQEaTToGTQBNM9LLocdtKTVKjFXKD1MtdEi4x92q24SkbRTGOlXGxZqMiBEsI+7fHwPGIf3saCnaOxCi23eSgkrbiXAY8pC0evGD5m42lJogSr77oeJ+VR5SmzpPHTmz+7nGSFPsRwHarbrvmIQ3IHHNKRmelua6pIRujtXokNilH+DpY8qbKZ8NkbVf0EbX/yYMo5gHoGO3z7BH8c/8jL1s+QTj3h7llmwEaU1KniUZ4sjrUXwbQa0K2KcrjUr7GoaAdNgWMDH+qwjm/C/17aCizRN3TVApGA1gLUKFhT+hZj8GiqfCyFT7F+11JiO6AXM/2fQ7FbuCMZXylVQYG6oBy59U8+yiB8MZM7pQMhcmNj16l4KYdn7dyUqvzfWZ8arhliPjlV7nKvyuMAstJRbWL+UhL0yBWSxyrvXD0fp3MzupLn5tAalLc0v4pPhkaEdS0eRpJh7VGuEk2iRnvBjDkYgDB1LmG1LiXdvHSEEbwDzyppMDjNQcqB5muUcHkrb1lDewYBPZ9HgWNmtWA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc12a312-6358-4555-f8f1-08db275824cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2023 02:26:13.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUKYL/e0YEG20J1MC7F0MvciJtvPuo/vyD0V3+tjnAYOqEqxfhDctDaQSeD3FBPZ8vQJldRm3fJgg+HoCKteYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
X-Proofpoint-GUID: lp8nIjHWp3nOL_rbTphBkLAQesKn0-SS
X-Proofpoint-ORIG-GUID: lp8nIjHWp3nOL_rbTphBkLAQesKn0-SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_20,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303180020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMTcsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAz
LzE3LzIwMjMgNDoyMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTWFyIDE3
LCAyMDIzLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIE1hciAxNywgMjAyMywg
RWxzb24gU2VycmFvIHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDMvMTYv
MjAyMyA1OjExIFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiA+ID4gT24gVGh1LCBNYXIg
MTYsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+ID4gPiA+ID4gPiBXaGVuIGhvc3Qg
c2VuZHMgYSBzdXNwZW5kIG5vdGlmaWNhdGlvbiB0byB0aGUgZGV2aWNlLCBoYW5kbGUNCj4gPiA+
ID4gPiA+IHRoZSBzdXNwZW5kIGNhbGxiYWNrcyBpbiB0aGUgZnVuY3Rpb24gZHJpdmVyLiBFbmhh
bmNlZCBzdXBlcg0KPiA+ID4gPiA+ID4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlv
biBzdXNwZW5kIGZlYXR1cmUgdG8gcHV0IHRoZQ0KPiA+ID4gPiA+ID4gZnVuY3Rpb24gaW4gc3Vz
cGVuZCBzdGF0ZS4gSGFuZGxlIGZ1bmN0aW9uIHN1c3BlbmQgY2FsbGJhY2suDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBjYXBhYmlsaXR5
IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiA+ID4gPiA+ID4gdHJpZ2dlciBhIHJlbW90ZSB3YWtl
dXAgb3Igd2FpdCBmb3IgdGhlIGhvc3QgaW5pdGlhdGVkIHJlc3VtZSB0bw0KPiA+ID4gPiA+ID4g
c3RhcnQgZGF0YSB0cmFuc2ZlciBhZ2Fpbi4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogRWxzb24gUm95IFNlcnJhbyA8cXVpY19lc2VycmFvQHF1aWNpbmMuY29tPg0K
PiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vZl9lY20uYyAgIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiA+ID4gPiA+ICAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMgfCA2MyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gPiAgICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5oIHwgIDQgKysNCj4gPiA+ID4gPiA+ICAgIDMgZmls
ZXMgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2VjbS5jIGIvZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMNCj4gPiA+ID4gPiA+IGluZGV4IGE3YWIzMGUu
LmM0M2NkNTU3IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWNtLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5j
dGlvbi9mX2VjbS5jDQo+ID4gPiA+ID4gPiBAQCAtNjMzLDYgKzYzMyw4IEBAIHN0YXRpYyB2b2lk
IGVjbV9kaXNhYmxlKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gPiA+ID4gPiAgICAJdXNi
X2VwX2Rpc2FibGUoZWNtLT5ub3RpZnkpOw0KPiA+ID4gPiA+ID4gICAgCWVjbS0+bm90aWZ5LT5k
ZXNjID0gTlVMTDsNCj4gPiA+ID4gPiA+ICsJZi0+ZnVuY19zdXNwZW5kZWQgPSBmYWxzZTsNCj4g
PiA+ID4gPiA+ICsJZi0+ZnVuY193YWtldXBfYXJtZWQgPSBmYWxzZTsNCj4gPiA+ID4gPiA+ICAg
IH0NCj4gPiA+ID4gPiA+ICAgIC8qLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovDQo+ID4gPiA+ID4gPiBAQCAt
ODg1LDYgKzg4Nyw3MSBAQCBzdGF0aWMgc3RydWN0IHVzYl9mdW5jdGlvbl9pbnN0YW5jZSAqZWNt
X2FsbG9jX2luc3Qodm9pZCkNCj4gPiA+ID4gPiA+ICAgIAlyZXR1cm4gJm9wdHMtPmZ1bmNfaW5z
dDsNCj4gPiA+ID4gPiA+ICAgIH0NCj4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBlY21fc3VzcGVu
ZChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ICsJ
c3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4gPiA+ID4gPiA+ICsJc3RydWN0
IHVzYl9jb21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5wb3J0LmZ1bmMuY29uZmlnLT5jZGV2Ow0K
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4g
PiA+ID4gPiA+ICsJCURCRyhjZGV2LCAiRnVuY3Rpb24gYWxyZWFkeSBzdXNwZW5kZWRcbiIpOw0K
PiA+ID4gPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiArCURCRyhjZGV2LCAiRUNNIFN1c3BlbmRcbiIpOw0KPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gKwlnZXRoZXJfc3VzcGVuZCgmZWNtLT5wb3J0KTsNCj4gPiA+ID4gPiA+ICt9
DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgZWNtX3Jlc3VtZShzdHJ1
Y3QgdXNiX2Z1bmN0aW9uICpmKQ0KPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ICsJc3RydWN0
IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4gPiA+ID4gPiA+ICsJc3RydWN0IHVzYl9j
b21wb3NpdGVfZGV2ICpjZGV2ID0gZWNtLT5wb3J0LmZ1bmMuY29uZmlnLT5jZGV2Ow0KPiA+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ID4gKwkvKg0KPiA+ID4gPiA+ID4gKwkgKiBJZiB0aGUgZnVuY3Rp
b24gaXMgaW4gVVNCMyBGdW5jdGlvbiBTdXNwZW5kIHN0YXRlLCByZXN1bWUgaXMNCj4gPiA+ID4g
PiA+ICsJICogY2FuY2VsZWQuIEluIHRoaXMgY2FzZSByZXN1bWUgaXMgZG9uZSBieSBhIEZ1bmN0
aW9uIFJlc3VtZSByZXF1ZXN0Lg0KPiA+ID4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gPiA+ICsJaWYg
KGYtPmZ1bmNfc3VzcGVuZGVkKQ0KPiA+ID4gPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gKwlEQkcoY2RldiwgIkVDTSBSZXN1bWVcbiIpOw0KPiA+ID4gPiA+ID4g
Kw0KPiA+ID4gPiA+ID4gKwlnZXRoZXJfcmVzdW1lKCZlY20tPnBvcnQpOw0KPiA+ID4gPiA+ID4g
K30NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IGVjbV9nZXRfc3RhdHVz
KHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+ID4gKwlz
dHJ1Y3QgdXNiX2NvbmZpZ3VyYXRpb24gKmMgPSBmLT5jb25maWc7DQo+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiArCS8qIEQwIGFuZCBEMSBiaXQgc2V0IHRvIDAgaWYgZGV2aWNlIGlzIG5vdCB3
YWtldXAgY2FwYWJsZSAqLw0KPiA+ID4gPiA+ID4gKwlpZiAoIShVU0JfQ09ORklHX0FUVF9XQUtF
VVAgJiBjLT5ibUF0dHJpYnV0ZXMpKQ0KPiA+ID4gPiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArCXJldHVybiAoZi0+ZnVuY193YWtldXBfYXJtZWQgPyBVU0Jf
SU5UUkZfU1RBVF9GVU5DX1JXIDogMCkgfA0KPiA+ID4gPiA+ID4gKwkJVVNCX0lOVFJGX1NUQVRf
RlVOQ19SV19DQVA7DQo+ID4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoeSBk
byB3ZSBuZWVkIHRvIGltcGxlbWVudCBlY21fZ2V0X3N0YXR1cyBpZiBpdCdzIGFscmVhZHkgaGFu
ZGxlZCBpbg0KPiA+ID4gPiA+IGNvbXBvc2l0ZS5jIG5vdz8NCj4gPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IFllcyB0aGlzIGNhbiBiZSByZW1vdmVkIG5vdy4gV2lsbCBtb2RpZnkgYWNjb3Jk
aW5nbHkuDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGljIGludCBlY21fZnVuY19z
dXNwZW5kKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYsIHU4IG9wdGlvbnMpDQo+ID4gPiA+ID4gPiAr
ew0KPiA+ID4gPiA+ID4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBmLT5jb25m
aWctPmNkZXY7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCURCRyhjZGV2LCAiZnVuYyBz
dXNwICV1IGNtZFxuIiwgb3B0aW9ucyk7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCWlm
IChvcHRpb25zICYgKFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfTFAgPj4gOCkpIHsNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBUaGlzIGZlYXR1cmUgc2VsZWN0b3IgZG9lc24ndCBpbmRpY2F0ZSB3aGV0
aGVyIGl0J3MgU2V0RmVhdHVyZSBvcg0KPiA+ID4gPiA+IENsZWFyRmVhdHVyZSByZXF1ZXN0LiBl
Y21fZnVuY19zdXNwZW5kIGlzIHN1cHBvc2VkIHRvIGJlIGZvcg0KPiA+ID4gPiA+IFNldEZlYXR1
cmUoc3VzcGVuZCkgb25seS4gUGVyaGFwcyB3ZSBtYXkgaGF2ZSB0byBkZWZpbmUgZnVuY19yZXN1
bWUoKQ0KPiA+ID4gPiA+IGZvciBDbGVhckZlYXR1cmUoc3VzcGVuZCk/DQo+ID4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+ID4gSG9zdCB1c2VzIHRoZSBzYW1lIGZlYXR1cmUgc2VsZWN0b3IgRlVOQ1RJ
T05fU1VTUEVORCBmb3IgZnVuY3Rpb24gc3VzcGVuZA0KPiA+ID4gPiBhbmQgZnVuY3Rpb24gcmVz
dW1lIGFuZCBmdW5jX3N1c3BlbmQoKSBjYWxsYmFjayBjYW4gYmUgdXNlZCB0bw0KPiA+ID4gPiBo
YW5kbGUgYm90aCB0aGUgY2FzZXMgPyBUaGUgZGlzdGluY3Rpb24gY29tZXMgd2hldGhlciBpdCBp
cyBhDQo+ID4gPiANCj4gPiA+IEhvdyBkbyB5b3UgcGxhbiB0byBoYW5kbGUgdGhhdD8gUGFzcyB0
aGlzIGluZm8gaW4gc29tZSB1bnVzZWQvcmVzZXJ2ZWQNCj4gPiA+IGJpdCBvZiB0aGUgIm9wdGlv
bnMiIGFyZ3VtZW50PyBJbnRyb2R1Y2UgYSBuZXcgcGFyYW1ldGVyIHRvIHRoZQ0KPiA+ID4gZnVu
Y19zdXNwZW5kKCk/DQo+ID4gPiANCj4gPiA+IElmIHRoYXQncyB0aGUgY2FzZSwgdGhlbiB5b3Ug
bmVlZCB0byB1cGRhdGUgdGhlIGRvY3VtZW50IG9uDQo+ID4gPiBmdW5jX3N1c3BlbmQoKSB0byBh
bHNvIHN1cHBvcnQgQ2xlYXJGZWF0dXJlKHN1c3BlbmQpLiBSaWdodCBub3cgaXQncw0KPiA+ID4g
ZG9jdW1lbnRlZCBmb3IgU2V0RmVhdHVyZSBvbmx5LiBBbHNvLCBtYWtlIHN1cmUgdGhhdCBvdGhl
ciBleGlzdGluZw0KPiA+ID4gZnVuY3Rpb24gZHJpdmVycyB3aWxsIG5vdCBicmVhayBiZWNhdXNl
IG9mIHRoZSBjaGFuZ2Ugb2YgdGhlDQo+ID4gPiBmdW5jX3N1c3BlbmQgYmVoYXZpb3IuDQo+ID4g
PiANCj4gPiA+ID4gU2V0RmVhdHVyZShGVU5DVElPTl9TVVNQRU5EKSBvciBDbGVhckZlYXR1cmUo
RlVOQ1RJT05fU1VTUEVORCkgd2hpY2ggY2FuIGJlDQo+ID4gPiA+IGVhc2lseSBkb25lIGluIHRo
ZSBmdW5jX3N1c3BlbmQgY2FsbGJhY2sgaXRzZWxmLiBXZSBjYW4gYWRkIGFub3RoZXIgY2FsbGJh
Y2sNCj4gPiA+ID4gZnVuY19yZXN1bWUgc3BlY2lmaWMgdG8gQ2xlYXJGZWF0dXJlKEZVTkNUSU9O
X1NVU1BFTkQpIGJ1dCB3b250IHRoYXQgYmUNCj4gPiA+ID4gcmVkdW5kYW50IGFuZCBtb3JlIGNh
bGxiYWNrIGhhbmRsaW5nIG9uIGZ1bmN0aW9uIGRyaXZlci9jb21wb3NpdGUgc2lkZSBhcw0KPiA+
ID4gPiB3ZWxsPyBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBvcGluaW9uLg0KPiA+ID4gPiANCj4g
PiA+IA0KPiA+ID4gV2UgYWN0dWFsbHkgZGlkbid0IHByb3Blcmx5IGRlZmluZSBmdW5jX3N1c3Bl
bmQgYW5kIGl0cyBjb3VudGVyIHBhcnQuIEl0DQo+ID4gPiBzZWVtcyBjbGVhbmVyIHRvIG1lIHRv
IGludHJvZHVjZSBmdW5jX3Jlc3VtZSBhcyBpdCBzZWVtcyBtb3JlIGludHVpdGl2ZQ0KPiA+ID4g
YW5kIGVhc2llciB0byByZWFkLiBMZXQgbWUga25vdyBob3cgeW91IHBsYW4gdG8gdXNlIGZ1bmNf
c3VzcGVuZCgpIGZvcg0KPiA+ID4gYm90aCBjYXNlcy4NCj4gPiA+IA0KPiA+IA0KPiA+IEhvdyBh
Ym91dCB3ZSBoYW5kbGUgZnVuY3Rpb24gc3VzcGVuZCByZXN1bWUgaW4gY29tcG9zaXRlIGFsc28/
IEkgbWVhbg0KPiA+IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21w
b3NpdGUuYw0KPiA+IGluZGV4IDM2YWRkMTg3OWVkMi4uNzlkYzA1NWViNWY3IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
dXNiL2dhZGdldC9jb21wb3NpdGUuYw0KPiA+IEBAIC0xOTQ4LDkgKzE5NDgsMTggQEAgY29tcG9z
aXRlX3NldHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsIGNvbnN0IHN0cnVjdCB1c2JfY3Ry
bHJlcXVlc3QgKmN0cmwpDQo+ID4gICAJCWYgPSBjZGV2LT5jb25maWctPmludGVyZmFjZVtpbnRm
XTsNCj4gPiAgIAkJaWYgKCFmKQ0KPiA+ICAgCQkJYnJlYWs7DQo+ID4gLQkJc3RhdHVzID0gZi0+
Z2V0X3N0YXR1cyA/IGYtPmdldF9zdGF0dXMoZikgOiAwOw0KPiA+IC0JCWlmIChzdGF0dXMgPCAw
KQ0KPiA+IC0JCQlicmVhazsNCj4gPiArDQo+ID4gKwkJaWYgKGYtPmdldF9zdGF0dXMpIHsNCj4g
PiArCQkJc3RhdHVzID0gZi0+Z2V0X3N0YXR1cyhmKTsNCj4gPiArCQkJaWYgKHN0YXR1cyA8IDAp
DQo+ID4gKwkJCQlicmVhazsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQlpZiAoZi0+Y29uZmln
LT5ibUF0dHJpYnV0ZXMgJiBVU0JfQ09ORklHX0FUVF9XQUtFVVApIHsNCj4gPiArCQkJCXN0YXR1
cyB8PSBVU0JfSU5UUkZfU1RBVF9GVU5DX1JXX0NBUDsNCj4gPiArCQkJCWlmIChmLT5mdW5jX3dh
a2V1cF9hcm1lZCkNCj4gPiArCQkJCQlzdGF0dXMgfD0gVVNCX0lOVFJGX1NUQVRfRlVOQ19SVzsN
Cj4gPiArCQkJfQ0KPiA+ICsJCX0NCj4gPiAgIAkJcHV0X3VuYWxpZ25lZF9sZTE2KHN0YXR1cyAm
IDB4MDAwMGZmZmYsIHJlcS0+YnVmKTsNCj4gPiAgIAkJYnJlYWs7DQo+ID4gICAJLyoNCj4gPiBA
QCAtMTk3MSw5ICsxOTgwLDI4IEBAIGNvbXBvc2l0ZV9zZXR1cChzdHJ1Y3QgdXNiX2dhZGdldCAq
Z2FkZ2V0LCBjb25zdCBzdHJ1Y3QgdXNiX2N0cmxyZXF1ZXN0ICpjdHJsKQ0KPiA+ICAgCQkJZiA9
IGNkZXYtPmNvbmZpZy0+aW50ZXJmYWNlW2ludGZdOw0KPiA+ICAgCQkJaWYgKCFmKQ0KPiA+ICAg
CQkJCWJyZWFrOw0KPiA+ICsJCQlpZiAod19pbmRleCAmIFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRf
UlcpIHsNCj4gPiArCQkJCWlmICghKGYtPmNvbmZpZy0+Ym1BdHRyaWJ1dGVzICYgVVNCX0NPTkZJ
R19BVFRfV0FLRVVQKSkNCj4gPiArCQkJCQlicmVhazsNCj4gPiArDQo+ID4gKwkJCQlmLT5mdW5j
X3dha2V1cF9hcm1lZCA9IChjdHJsLT5iUmVxdWVzdCA9PSBVU0JfUkVRX1NFVF9GRUFUVVJFKTsN
Cj4gPiArCQkJfQ0KPiA+ICsNCj4gPiAgIAkJCXZhbHVlID0gMDsNCj4gPiAtCQkJaWYgKGYtPmZ1
bmNfc3VzcGVuZCkNCj4gPiArCQkJaWYgKGYtPmZ1bmNfc3VzcGVuZCkgew0KPiA+ICAgCQkJCXZh
bHVlID0gZi0+ZnVuY19zdXNwZW5kKGYsIHdfaW5kZXggPj4gOCk7DQo+ID4gKwkJCX0gZWxzZSBp
ZiAod19pbmRleCAmIFVTQl9JTlRSRl9GVU5DX1NVU1BFTkRfTFApIHsNCj4gPiArCQkJCWlmIChm
LT5zdXNwZW5kICYmICYmICFmLT5mdW5jX3N1c3BlbmRlZCAmJg0KPiA+ICsJCQkJICAgIGN0cmwt
PmJSZXF1ZXN0ID09IFVTQl9SRVFfU0VUX0ZFQVRVUkUpKSB7DQo+ID4gKwkJCQkJZi0+c3VzcGVu
ZChmKTsNCj4gPiArCQkJCQlmLT5mdW5jX3N1c3BlbmRlZCA9IHRydWU7DQo+ID4gKwkJCQl9IGVs
c2UgaWYgKGYtPnJlc3VtZSAmJiBmLT5mdW5jX3N1c3BlbmRlZCAmJg0KPiA+ICsJCQkJCSAgIGN0
cmwtPmJSZXF1ZXN0ID09IFVTQl9SRVFfQ0xFQVJfRkVBVFVSRV9GRUFUVVJFKSkgew0KPiA+ICsJ
CQkJCWYtPnJlc3VtZShmKTsNCj4gPiArCQkJCQlmLT5mdW5jX3N1c3BlbmRlZCA9IGZhbHNlOw0K
PiA+ICsJCQkJfQ0KPiA+ICsJCQl9DQo+ID4gKw0KPiA+ICAgCQkJaWYgKHZhbHVlIDwgMCkgew0K
PiA+ICAgCQkJCUVSUk9SKGNkZXYsDQo+ID4gICAJCQkJICAgICAgImZ1bmNfc3VzcGVuZCgpIHJl
dHVybmVkIGVycm9yICVkXG4iLA0KPiA+IA0KPiBBdCBpbmRpdmlkdWFsIGZ1bmN0aW9uIGRyaXZl
ciBsZXZlbCB0aGVyZSBpcyBubyBuZWVkIHRvIGRpZmZlcmVudGlhdGUNCj4gYmV0d2VlbiBzdXNw
ZW5kKCkgYW5kIGZ1bmNfc3VzcGVuZCgpIEFQSXMsIGFzIGJvdGggYXJlIGludGVuZGVkIHRvIHB1
dCB0aGUNCj4gZnVuY3Rpb24gaW4gc3VzcGVuZCBzdGF0ZS4gU28geW91ciBpZGVhL2ltcGxlbWVu
dGF0aW9uIGFib3ZlIG1ha2VzIGl0IG11Y2gNCj4gbW9yZSBjbGVhcmVyLiBMZXQgY29tcG9zaXRl
IGFsc28gaGFuZGxlIHRoaXMgYW5kIGNhbGwgZWl0aGVyIGYtPnN1c3BlbmQoKSBvcg0KPiBmLT5y
ZXN1bWUoKSBjYWxsYmFjayBiYXNlZCBvbiB0aGUgc2V0dXAgcGFja2V0IHJlY2VpdmVkLiBUaGFu
ayB5b3UgZm9yIHRoaXMNCj4gc3VnZ2VzdGlvbi4NCj4gDQo+ID4gDQo+ID4gQWxzbywgZG8gd2Ug
bmVlZCB0aGUgZi0+ZnVuY19zdXNwZW5kZWQgZmxhZz8gd2UnZCBuZWVkIHRoZSByZW1vdGUgd2Fr
ZXVwDQo+ID4gZmxhZyBmb3IgdGhlIHN0YXR1cywgYnV0IHdoZW4gZG8gd2UgbmVlZCBmLT5mdW5j
X3N1c3BlbmRlZD8gSXQgc2VlbXMNCj4gPiBsaWtlIGl0IGNhbiBiZSBoYW5kbGVkIHdpdGhpbiB0
aGUgZnVuY3Rpb24gZHJpdmVyJ3Mgc2NvcGUuDQo+IA0KPiBmLT5mdW5jX3N1c3BlbmRlZCBmbGFn
IEkgaGFkIGFkZGVkIGZvciBiZWxvdyBwdXJwb3Nlcw0KPiANCj4gMS4pIEZ1bmN0aW9uIGRyaXZl
cnMgc2hvdWxkIGtub3cgdGhlIHJpZ2h0IHdha2V1cCgpIG9wIHRvIGJlIGNhbGxlZC4NCj4gVGhh
dCBpcyBpZiB0aGV5IGFyZSBpbiBGVU5DX1NVU1BFTkQgdGhlbiBjYWxsIHVzYl9mdW5jX3dha2V1
cCgpIGFuZCBpZiB0aGV5DQo+IGFyZSBpbiBkZXZpY2Ugc3VzcGVuZCB0aGVuIGNhbGwgdXNiX2dh
ZGdldF93YWtldXAoKS4gKHdlIGNhbiB1c2UNCj4gZi0+ZnVuY193YWtldXBfYXJtZWQgZmxhZyBm
b3IgdGhpcyBwdXJwb3NlIGFzIHdlbGwpDQo+IA0KPiAyLikgSWYgYSBmdW5jdGlvbiBpcyBpbiBV
U0IzIEZVTkNUSU9OX1NVU1BFTkQgc3RhdGUgdGhlbiBpdCBzaG91bGRuJ3QgYWxsb3cNCj4gZi0+
cmVzdW1lKCkgY2FsbGVkIHRocm91Z2ggY29tcG9zaXRlX3Jlc3VtZSgpIGFzIHRoZSBleGl0IGZy
b20NCj4gRlVOQ1RJT05fU1VTUEVORCBzdGF0ZSBpcyB2aWEgQ2xlYXJGZWF0dXJlKEZVTkNUSU9O
X1NVU1BFTkQpLg0KPiANCj4gU28gd2UgbmVlZCBhIHdheSB0byB0ZWxsIGZ1bmN0aW9uIGRyaXZl
cnMgaWYgdGhleSBhcmUgaW4gVVNCMw0KPiBGVU5DVElPTl9TVVNQRU5EIHN0YXRlIE9SIGRldmlj
ZSBzdXNwZW5kLg0KDQpPay4gU28gZG8geW91IHBsYW4gdG8gdXBkYXRlIGNvbXBvc2l0ZV9yZXN1
bWUgdG8gY2hlY2sgdGhhdD8gUGVyaGFwcw0KZG9jdW1lbnQgdGhpcyBleHBlY3RlZCBiZWhhdmlv
ciBhbHNvPw0KDQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHNlZSBhbnkgYWx0ZXJu
YXRpdmUgb3IgYmV0dGVyIGFwcHJvYWNoIGhlcmUuDQo+IA0KDQpJZiB3ZSBoYXZlIGEgdXNlIGZv
ciBpdCBpbiBjb21wb3NpdGUuYywgdGhlbiBpdCBzaG91bGQgYmUgbWFkZQ0KYXZhaWxhYmxlLiBP
dGhlcndpc2UgaXQgc2hvdWxkIG9ubHkgZXhpc3QgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlciAoaWUu
IGluDQpmX2VjbSBzdHJ1Y3R1cmUpLg0KDQpUaGFua3MsDQpUaGluaA==

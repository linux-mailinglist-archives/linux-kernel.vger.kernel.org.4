Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27CC64520D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLGCbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:31:22 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3C54375;
        Tue,  6 Dec 2022 18:31:21 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LwF6o014711;
        Tue, 6 Dec 2022 18:30:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=+UdZ5oDIu00mwTc5IuNOqGcMIBzxeRKrO9rdrR/mx/4=;
 b=tIqLH0iw2HKEtKJ1LQ93A/GJuktGTUkVHb/N34uhwOZNzAHl3vQu6HpuLsRm/rrx1YCl
 KRv7aBZb1PUPcEJqq18w0hrE2h2KtZ7In3LFcXb/9FGElqM7xOz39R6AWmSE/TjnA/rS
 deihgjdIDgldNWV9PcwE/x5cPaWqV1kAm8iwMy4iQMuHiDtYQ2Q9EX7MfopM75Ao8Rfc
 iwefXaDnCWaGuY4p/Sc8zwLDrFPmHm4udnWdfKzIkNNoY1FBTXAkLY24PW7YRYFk6Lq0
 a6A+LzM081y0YbHhxvd+4a613CHzOYfYpDmclV7G+UZEWRgT2waPvtQAs4nQrKk6E0Zu Jg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3m86ka881n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 18:30:34 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C09F9C00FA;
        Wed,  7 Dec 2022 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1670380234; bh=+UdZ5oDIu00mwTc5IuNOqGcMIBzxeRKrO9rdrR/mx/4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UW7ivB9x5WvWcx6s8pN1F/f9TaGb8E3iZxs7vkdVR65g7ONs1P8kLg3DAuQfy2dNF
         2YKn3yFluc4RbhPzpBPi+rosCdqXSM0MU97YLyAW1tVRc1BjxOr+7/PzCCvgpqv874
         K9L4s48blzuHfdmAr9Zhiw9+e6+/4a5u4WvP83OSejcRLe5NCVr2GQCjAVaFMu13Qk
         ZJLrcCwiDxW3DvfMvjFLu9i93LioPRgf++4v1m2iXRXoiTI0L0Lx+vCJKaDB9e6kDv
         751P2+Kz1LoZ+FC/lyrQiP6ZNTlCA9sdTeKg+piyrGBtt4+YSIsRb0DsZH/YpHXl2n
         Lm32f/dAxbDHQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EC9F6A007F;
        Wed,  7 Dec 2022 02:30:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2B21A800E9;
        Wed,  7 Dec 2022 02:30:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rd1LDP+x";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K80g18ZKdzZFj1HLXTLRR8Zwm2gmM7QR6ZQyPNsQAuYJ34jLTF+I9vNDiFJMLz2ciBRx6/Ofyge4NADUReJdYANlnRP0Iv8YNtJw4Nugp07cEm/BvxhA4IwJIvzeyWmE+KqzicDnv/cTda9XHFzJ7hKkpcq8rRdzBjwJCBg62GvJxqUY1VKfztO7z35IU/XjkGKSrNTi571q9E9qliximldk4veVanQx1MNomKu840KtoZcOpB+GHDWdra52uKkVJbevD79xKABr6vmhTvYXwcld5UwkG+VYP2oV4OhtjVBzXRCZCxy3Luw2nHw6YGYcReCLnYFlEv9X/IEvmfQ9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UdZ5oDIu00mwTc5IuNOqGcMIBzxeRKrO9rdrR/mx/4=;
 b=KtI8FpH2/CtcogNr1/NZANpcjxcnK+gUiWkxAQ+GHBwoNQ9hge/je/mqpv02+xzR44wDL9VflHtMgAVW/9ZItFkDRUGbueJ/l7DKr7DMcy0BRouCS0lXsrxuohRrNqel0ZXP1N4qr8xLRKfca1I+LypG83GF18m4/aG831lbNk7ttYmSFyTb/601OnZCAq4A1fCSHUfyZmGYquBTMQjJggOtUakMzLnU67aznwtSH66lgRzUjwuJwP6ElYgnpqcOhyEDaXjB1tdWHgNNJfU2NdJUuicZyvnp7Qw6tXGTqduvJtgiiwKLG3wbaUMiTD9wHtwcc08x9GSv59XKXqyd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UdZ5oDIu00mwTc5IuNOqGcMIBzxeRKrO9rdrR/mx/4=;
 b=rd1LDP+x44cnKXvkPJLYyndblcQOs8La1K7lectU+DYzZ3nbL0tQQuo7J8fVlIxqyLiL0Sx6I/uUxXwj2wPDvxLMzPV/pekBnU8uf1jgUKiPJdQRvajZlmfHN8zdWFJm14GDGiZo86coZDofz0vJaxsOb/lFCuEx0xqWJtIvaDM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4904.namprd12.prod.outlook.com (2603:10b6:a03:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:30:25 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:30:25 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: qcom: Fix memory leak in
 dwc3_qcom_interconnect_init
Thread-Topic: [PATCH] usb: dwc3: qcom: Fix memory leak in
 dwc3_qcom_interconnect_init
Thread-Index: AQHZCUs5C+7LjkGso0WxGqMobmnyG65htR8A
Date:   Wed, 7 Dec 2022 02:30:25 +0000
Message-ID: <20221207023022.ubukexlvhrfrw4dy@synopsys.com>
References: <20221206081731.818107-1-linmq006@gmail.com>
In-Reply-To: <20221206081731.818107-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4904:EE_
x-ms-office365-filtering-correlation-id: 7b2dfd08-0468-450b-a7e4-08dad7faff5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9U6SPG4rrXJrGm1O2o3t8ohqSgQdewOZ7grawf+jbDqNU/eNI1sV3OH8O0hpqmFtD38jlXjt7AFIv5vXOk9Fao0d3O/2h491WSpq6bK9xuBKKYCCImQlvtC1/b3VwaLvei1PO5BhGcze+kHSjcyp6hDSVSHLEO9XFh0LEmk0ja1PQPFAvow9lAlpjFdOfbtqWUJAAKSvLjJqFZs3uWFdP5aovfsdWmqZOzNLHOEy+xxmwSziEpuOycVLrSGpV7V+g63x/kd0Pam9xykczLmm9Uv5cJUvtQbC2sEGkdasr2CRfcrRzT+HwpLYHPBQ+yAbnW6n3QEr1qwyvPWXZ5MTrn7gAETTCxOVt+rzMm5C3d7jhopQiCobH9bm0Mwnx/KPimiUPKyTOQCbyxxOqfRVyt5fOWk9IKGU/DkkQ5lADBMVNxLqstLQBfGpbxeSQD2upHLyOpkb4ZM2c/Fjr979ajc008s+saK/GeYsiZj69nNNifMGIoN7Ku71Ab+E6anZjpA5aYjEvXnd1avpIXXyl2+058v9ljNSgxrqNiIsjJrG+rUyWAOm4ZVSK3BpOymDTWRU74PdJoQac9WKympcaiNv3RJih2bWg9m13JWKKBNXqR7JbbI0iholjkPQAU0s1KWNIhmL7G4qHgdQ8BDQMu1HwX5S0J6wU6oc6whRy2WP5ZDVnw1aWbj0SaE6fig2I1L402WgSjw9DLrdZJCX5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(366004)(346002)(136003)(376002)(396003)(451199015)(2906002)(83380400001)(36756003)(66946007)(76116006)(1076003)(41300700001)(186003)(86362001)(66556008)(38100700002)(26005)(6512007)(38070700005)(4326008)(8936002)(2616005)(66476007)(7416002)(122000001)(66446008)(71200400001)(64756008)(8676002)(316002)(54906003)(6916009)(478600001)(6486002)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGpmS0JLaDdrd0FqVXBDMXJyL0VYSzBCY0FVV0dyLzR6Rlg5UFF0MEEwc0xX?=
 =?utf-8?B?ZUx6Qk9naFcxQ2hlQ2JhVi91VW1TcW5SRU03czZ2NmZnS1JzWUV1cndIOFg1?=
 =?utf-8?B?WEZlRjlaQXQ0SE5aNnliK1d5eCtwSUtMMk5mdjZ3dS9GaC9KTlJmdzJxRmt4?=
 =?utf-8?B?YjNvS3JQOVhjaS81aUh1TFlOeWdUOGpkVnpGYlYrdEl6TjExNzNtbWMwRENj?=
 =?utf-8?B?ZFk2alhlbjJwbWQvOHhFNFhlejNCTzNEMkYyUjRhMjFBbHNCc1BLTUpkVkoy?=
 =?utf-8?B?QlVGR0c2RituSVN0ZDQ3QmNNejE0a1pubnVPclp6SDUvVlJyMHFvODNOMkR6?=
 =?utf-8?B?NHUvUU9ITzFyVDVwWlVhdjJRUmIwZEczd1VLZFdqZE16aTNoVDdIRkh5dXlT?=
 =?utf-8?B?ZVJOMmlXTTluZ0tnWTJ0MGZSQ3F0Nk1tMUlxMTl3R0I4UGhsYUhDVnhwK3Bw?=
 =?utf-8?B?SFZxVjJpbUE4bGZaZzB5cDZuWVlJOXFsYTBzNkRxV0dUcUoxWFQ2QUpieUR0?=
 =?utf-8?B?bWhFdmFXb3dNaXlsWTl5VkJGZllzb1c4QWplbTk2VVE0OTFmcW4vOEF2VU5K?=
 =?utf-8?B?VTJSVUxiS0xDMG0zREg5MXlxV1gydXoyaDgzRGVVQ2ZKcUVVZEFCZlg5OU1w?=
 =?utf-8?B?T1l2L1c4WlkvcGc0cnpRYjNXT0pmYU10MlR6K3o4VU01aHk1ZjBOZUgydVVD?=
 =?utf-8?B?dytobXh2MzVZWmFManlranVRQzRyb3RqczhSTnZ1bHpTSi9CUVUvanNvRHNi?=
 =?utf-8?B?SUhyZ3Q2dVBmREFmMFRIdkFRaWFkUmZnWHBSYzlWN25ocEg3VGM5bjc0ZmFC?=
 =?utf-8?B?Snc3S05MMFBBd2pGWmNpZXhJUFdDMkRVNGlZODJRSjkrYUNtS2l4b2IwY3Jv?=
 =?utf-8?B?OE9qNFNlMHBTRWpybEd6OWNmbVlEUTU3TTF4cmNUSXlYYXRiVWRkcEFDK3Qx?=
 =?utf-8?B?Wm9HeC90OFpxZGtJRXMvZW9OK0hLZmF5UlFRYkFkSDVEUzE3RUVaM3cwbHF6?=
 =?utf-8?B?T3Urczc3ZFVDVmFIekxkWnZxQmJNOEpITmNhYytENmVKa0FPb3B0V1dUZjc2?=
 =?utf-8?B?MVBlbjNud3RiQzJwQnFhWTI2ckRnZm5PNnpiQXhsYmxnajY4anlsc2d6NzFn?=
 =?utf-8?B?VDJ1bkJyK2V3QjVPRFBMb0JtSXBlNFNqeEFHdDRVVUI1NDdYbVB0K3JlQUJp?=
 =?utf-8?B?MnNNQmFvVmU0anJ2RkpNMDVLeDFnZTZjSTlwOVBZbEx1N3ZGUE1EUTk1ZlZo?=
 =?utf-8?B?WFFyVFFPd3U4L1RwRE1hQm9lYTBXYmU5T0IwNUNrU2REOW5CL1dXSG1ERHFZ?=
 =?utf-8?B?VjQxZkN0WHBTVWxEd1dQUGRkamFIM0psR1NHSkpxMjc4TnprTVRydFZOWXI1?=
 =?utf-8?B?OTZUcHFSQ21DQnNORkJObzJnOUpSd0pLRWxEa2xWVXdZTVBLUXF6UFFHRFJ0?=
 =?utf-8?B?SEpHVlY3UDVEQm1qVVFhMk9oMzhJbUVDRmU0ZE13U3RYUnR5ZzNoNkUxS1g1?=
 =?utf-8?B?K0oyWHAxME16R0c2NzlNak5qTkxoZG1Yalg0YmEzRnlVd3A4Zm9TcjNsQnMr?=
 =?utf-8?B?dGd1MXJIUzd1T2xJazc4b3o3U29Od3hPNzJwNnRNWGV4Z1liT25XbGFMbXZ2?=
 =?utf-8?B?NWtPYis5em15YWVVTWs2VHRDQmhScjR4VG9sbVk4c2x0YkozdE1JMmNnaUhE?=
 =?utf-8?B?RWN6ekZSQWI3Zmg0UXhVRlNkRkxWdGhybW93R1IzRE9idUwrWDQwNUhEUzJW?=
 =?utf-8?B?SFJ5N0ZMclpseFFUdXczN1dkckJrVFlxaUFkUmNQZkFGdTFSVGVSenRrR2Iy?=
 =?utf-8?B?UThHdy9wMUlkNlJoeXRVZ0xrejZySGg2M2p0K1NkS01Vcmh5Q2FhKzZkRkpE?=
 =?utf-8?B?YktBZ0tNL283eWlHYXF4WDkxMm56Y01qZzRQTmJwWGlRSU1MelZiZFBJc0Ro?=
 =?utf-8?B?N2kzL3FsMVV3dHd4T2RrZGxYZGpYMkxIbzF2RldVRDhIeWFNZCtpU0c4TzRr?=
 =?utf-8?B?YVJOS0dKSXhkSUE2OTVUaTdneEtrVUM2eHEwSGRYTDNmeFhTdGtxcW5xMDNw?=
 =?utf-8?B?Y2tJcW9Gd1VHOVBwWUc3eDRlWkVwZzhZTkVoSHA1dGJJQkY2K3NFZlE0TUZU?=
 =?utf-8?Q?v31pGqLtX/lGB4idv/2tyreHS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12DAD83EF9066A46BBA3508F5E83B1B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzJvb1VZcVIxNEpMWldNeTVKNWk2U1kvdVh2ait0bU5KcWxPUk1yZnVuTFYx?=
 =?utf-8?B?SlZ6RHhFNUNibUtXRzV5Kyt3Y0tCZGl2azFpWWdGK3ludWg2ZTd1cmNQQzBw?=
 =?utf-8?B?aFhvM3RUNHFxcDd6K3huWmFRbXpVVFlDSll5UDh2OVVQZ1U4TjZEQ3pSczJo?=
 =?utf-8?B?SkNNcVhWaHlRaXlKWHhNaTJ4bUtISTVkR2taWHcremo3SjkwM0FKallVbmpJ?=
 =?utf-8?B?dzBSTUhsRkRML1ZBeEowVWRISHVMOTc5M2pjQWVPVzZyN3B1WE8rc0duQXhR?=
 =?utf-8?B?a0ZGTC9kNFRmbmc0V0Q5S2VqcXY4RzQvbEErVEdFaXIwbGdJNHdqekQ4T1Yy?=
 =?utf-8?B?MWErbGp0eS9yQ0V1RjFwRHFOc3NJRWpCeWtCRVY5WjlJeUJjeDNxOWZoMWRv?=
 =?utf-8?B?cGttVGdsMmlQaXEwbndTaVhwME84dGVsdEg4cjBab09XWHB6L1BSMHEvaEtC?=
 =?utf-8?B?MHIrVzJYUkovTUdieldiOGhEZmlWSHZpNVVhSm12bVFwcm1qUXJjemlKTHkv?=
 =?utf-8?B?VFBhc1BMZU5udHNOQmZ2NlVjN1lSQ3g5V1BsTnRrTEx0bEpCVjVsRE9WaFlu?=
 =?utf-8?B?TVRwT2Z1eGRDRmtxZHgyRWNsNDcxcnd2YVRNSUlvVUg4dXdYQll2bndWSnYv?=
 =?utf-8?B?YTVUV0xJOTNzMHo2U01rTFM4YjVTN2lraVc2SWhPckdJRFhERUlvemVGeDF3?=
 =?utf-8?B?aDREREtMcWkwZ0ZqdlRmMDhmTUpxVWFHTUhXZDV0Snh0cWFDczdPRHhMYnZU?=
 =?utf-8?B?RFlIaXA1M29TelZiZEt1R0F4emI0OURpZlZGRkp4Y2QzYmZtOEpaa0hRay9m?=
 =?utf-8?B?UGhTaHhtbzFQZkhpZWxMSERNcWpkRGxvOCtWcjlpcEcya3Yvckx1NFdDcEk0?=
 =?utf-8?B?SXcyS2tabjhlSyt2a0FvQTQ1b2VUaDFtajlacVdSYmo2K0NTSmpxbDNFZkJr?=
 =?utf-8?B?Q0JNbXBpeTBDUXlJMWw4MFQwbGlMV0ZDemIyL1kvdDVHMG9LU1N2RHcwZTlC?=
 =?utf-8?B?WG13WVExajZxaUtRcHgybDBrV0xGb2tnV0lEb0RzcEZpR0dZakJjcnZRVVZJ?=
 =?utf-8?B?djJ0YytrR0lzZFNBYnE5bU5SZ01FYWd1WnhrYmJ0bVdDN24wUGJrcGd4MStB?=
 =?utf-8?B?cWVmckxWbHF6NnE2MWdYczJia0h4Nm5Yd0pJMjQ0NmtpWHVVREEraVBibEJv?=
 =?utf-8?B?YzZZTXFnQk5HMG5wYWpNTzVQR3VBUStYQ2ZiN080WTZRL0F0cFk2NnBFZzVJ?=
 =?utf-8?B?QVFkN21aTlRwVWlJYXVOYXMvL2t2VHgvZmk3ZXdCTHZERHNQa1BvZyt1NmRy?=
 =?utf-8?B?QmticU5FTTh2bUJ3bS91VkE3UzhJVVBrNkVCcklBYzE4S25DQVA5ZDNhL2Fv?=
 =?utf-8?B?YVc2ZldPQzRHcVNlSFFIdlB1ZExUMWczMjNWQVJYQ09ERkZiaXJNTTlXU2x4?=
 =?utf-8?B?dUVHSEFUaXFjaGZjRWJoOHdDZm9RVGJkZGJWUk1ZUENPZmkxUGxvbGlmcGVR?=
 =?utf-8?B?ZVY3T25QV1ZpV0tCUUMzdHBDRjRJeEtrcTRhY3kyVjZWK0NBRzV6Rlp0Rmx6?=
 =?utf-8?B?MVZMeWdEOFBzaHN1RHBnVlZwM0dJbDkrVnhpOVJsSnhPdmVVRWc5WVZVNUZ2?=
 =?utf-8?B?bWhLT1RraEIwd3FqMFNpV0lNaUR1WEE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2dfd08-0468-450b-a7e4-08dad7faff5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 02:30:25.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8iMVFnBJNhuv+kKF0BbZS64HRlbSZlo/JjSFOpaFQ04sb4+zGq2QmvocXc41VWHYLtH4/lSj4nNzgNT2+GLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4904
X-Proofpoint-ORIG-GUID: Fk5c99R_xCrm2amMDqQ22uF9kRXghUwh
X-Proofpoint-GUID: Fk5c99R_xCrm2amMDqQ22uF9kRXghUwh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2212070015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBEZWMgMDYsIDIwMjIsIE1pYW9xaWFuIExpbiB3cm90ZToNCj4gb2ZfaWNjX2dldCgp
IGFsbG9jIHJlc291cmNlcyBmb3IgcGF0aCBoYW5kbGUsIHdlIHNob3VsZCByZWxlYXNlIGl0IHdo
ZW4gbm90DQo+IG5lZWQgYW55bW9yZS4gTGlrZSB0aGUgcmVsZWFzZSBpbiBkd2MzX3Fjb21faW50
ZXJjb25uZWN0X2V4aXQoKSBmdW5jdGlvbi4NCj4gQWRkIGljY19wdXQoKSBpbiBlcnJvciBoYW5k
bGluZyB0byBmaXggdGhpcy4NCj4gDQo+IEZpeGVzOiBiZWE0NmI5ODE1MTUgKCJ1c2I6IGR3YzM6
IHFjb206IEFkZCBpbnRlcmNvbm5lY3Qgc3VwcG9ydCBpbiBkd2MzIGRyaXZlciIpDQo+IFNpZ25l
ZC1vZmYtYnk6IE1pYW9xaWFuIExpbiA8bGlubXEwMDZAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgfCAxMyArKysrKysrKysrLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXFjb20uYw0KPiBpbmRleCA3YzQwZjNmZmMwNTQuLmIwYTAzNTFkMmQ4YiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMtcWNvbS5jDQo+IEBAIC0yNjEsNyArMjYxLDggQEAgc3RhdGljIGludCBkd2MzX3Fjb21f
aW50ZXJjb25uZWN0X2luaXQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAlpZiAoSVNfRVJS
KHFjb20tPmljY19wYXRoX2FwcHMpKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdl
dCBhcHBzLXVzYiBwYXRoOiAlbGRcbiIsDQo+ICAJCQkJUFRSX0VSUihxY29tLT5pY2NfcGF0aF9h
cHBzKSk7DQo+IC0JCXJldHVybiBQVFJfRVJSKHFjb20tPmljY19wYXRoX2FwcHMpOw0KPiArCQly
ZXQgPSBQVFJfRVJSKHFjb20tPmljY19wYXRoX2FwcHMpOw0KPiArCQlnb3RvIHB1dF9wYXRoX2Rk
cjsNCj4gIAl9DQo+ICANCj4gIAltYXhfc3BlZWQgPSB1c2JfZ2V0X21heGltdW1fc3BlZWQoJnFj
b20tPmR3YzMtPmRldik7DQo+IEBAIC0yNzQsMTYgKzI3NSwyMiBAQCBzdGF0aWMgaW50IGR3YzNf
cWNvbV9pbnRlcmNvbm5lY3RfaW5pdChzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiAgCX0NCj4g
IAlpZiAocmV0KSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHNldCBiYW5kd2lkdGgg
Zm9yIHVzYi1kZHIgcGF0aDogJWRcbiIsIHJldCk7DQo+IC0JCXJldHVybiByZXQ7DQo+ICsJCWdv
dG8gcHV0X3BhdGhfYXBwczsNCj4gIAl9DQo+ICANCj4gIAlyZXQgPSBpY2Nfc2V0X2J3KHFjb20t
PmljY19wYXRoX2FwcHMsIEFQUFNfVVNCX0FWR19CVywgQVBQU19VU0JfUEVBS19CVyk7DQo+ICAJ
aWYgKHJldCkgew0KPiAgCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBzZXQgYmFuZHdpZHRoIGZv
ciBhcHBzLXVzYiBwYXRoOiAlZFxuIiwgcmV0KTsNCj4gLQkJcmV0dXJuIHJldDsNCj4gKwkJZ290
byBwdXRfcGF0aF9hcHBzOw0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KPiArDQo+ICtwdXRf
cGF0aF9hcHBzOg0KPiArCWljY19wdXQocWNvbS0+aWNjX3BhdGhfYXBwcyk7DQo+ICtwdXRfcGF0
aF9kZHI6DQo+ICsJaWNjX3B1dChxY29tLT5pY2NfcGF0aF9kZHIpOw0KPiArCXJldHVybiByZXQ7
DQo+ICB9DQo+ICANCj4gIC8qKg0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpBY2tlZC1ieTogVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGlzIHNob3VsZCBnbyBv
biBzdGFibGUgYWxzby4NCg0KVGhhbmtzLA0KVGhpbmg=

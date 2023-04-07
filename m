Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D541C6DA6B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbjDGAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDGAt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:49:57 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007886B0;
        Thu,  6 Apr 2023 17:49:57 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N3C9n020846;
        Thu, 6 Apr 2023 17:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Vrt2fdpbmiMghd/ij+9vfleh9wwfJA1bPXWjaB4omOY=;
 b=o3bRgtEBHty/bJ1LMZwnrBh8M9r6dRpge+D+/L7waXRVVY6Ak9owS1sY/n8gVf9M+OrS
 BJXcTWfkLRGDh/8eBdzulKjgsx6RPuOIwePt0xz0sdoQWOf12AFmtr1YjUPSuzl8FuH7
 Ts2fLNlmlQ+iGQEtRaC2sZoVM8BemVDPRBZCMED0TQfNJbR2+Cv//oB179NlWkPmF/Hy
 TjEos6MRC46Av4BR+DwjiNAXXct/dtY6/XNJVgzeQJP3b2kFII0Zs/DBzPC4w0I0febM
 dlXv9HfEy02hcbdJj5QEfBfe5a839GDCJMjUapMR0Pyq8ESQKbNTI/f/Ybvus/YkAniV xQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkmrwrkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 17:49:52 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 96C91C04C2;
        Fri,  7 Apr 2023 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680828591; bh=Vrt2fdpbmiMghd/ij+9vfleh9wwfJA1bPXWjaB4omOY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=G0zEfNK18obkhy64nW9W5obLknxPBpsOtqUIo2X5Bj56wTm00MjEhgt1dzHVd6XMw
         hpga6ZfhBF+qcHEpet0XUaKH+qVepGAw7K6SI+Zjfx/BJUQsIv/MHwXP0lm9i6EikP
         pNfm0ItjmhXNyJXH2ySMxsA/7OA8XxesKqcasJMO4qKS24GggTL0pNdPvRbpJ2ajQ1
         q9tvamuWWHT94JlWaNQA6GDKn+F9xh68vAvExtdONR4FY1BMl0tMxA8CT57PCjZrqI
         4GNVHW0+DAFLiQ8f+PQpLhjXRGDkk3EE3YRmXG73xCuISbGW8gKmuB74Vc4XE4+V5K
         9IK7glAhgi+0Q==
Received: from o365relayqa-in.synopsys.com (unknown [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6B203A007A;
        Fri,  7 Apr 2023 00:49:51 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=q/Vfcza4;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id 31F8A2209CA;
        Fri,  7 Apr 2023 00:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsxfOXl74lx0aw/uzvYmV6uXS48ocABr/h5NM9QEUiFUHoqx/6fy/uBk4gjSOn6KUtIXwtCF+4BRPArhu4PboUVc6tiXDtZdWQQwSZma6okDkYKJ9/4GjjVp3APAHNxvAc9rf5sJ033mIR/74oeFw/saO8P+JMSzRMD8lj8vsunKGw5CQK6YT3Obyg+meTGPJLCoREYMUB6w8cotg9b7ndgDLbw0dUdhsBRK+7Os4/VNeEVReEHgzWVP7nRtTIR3kX51f6kETbzG/iAH90M2WpuPOBJp+3XrB/5+DugrqoGvDpr587YwwoEBfYkaD0OkVXxklt3XVLyo6GdB80MwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vrt2fdpbmiMghd/ij+9vfleh9wwfJA1bPXWjaB4omOY=;
 b=NIblScqel+sCVbrOxJOcHhIx5XixaiRs37jYCFwn92k8Kq2K5ruHf8MwAUcEe46SwsZlx/JXUuSybYplpwJq5nuxaUiY4FG/dwgB8JxgOG2ltEI2pnOBp6H1eas21CLYD0gWBTXjjylvxdBEltZFXFJYOeowqIrxsYNlTNQy5+ZE2txAkXk7+FzcpwuafgsOX+ckm9LKKo+8aWy2uQW9zy4ovKjOi3BiQWoY1lrN0G0Cb037nNj8M+QlL3hh3t6vmkcC5O4Q9Kpj3jK5Jo5J3Jbtpri0DoM8iBM+QsODyMsNCglhl+GRSKYVqRoBF/bL/KOVbK8UZIYtX/74UKeKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vrt2fdpbmiMghd/ij+9vfleh9wwfJA1bPXWjaB4omOY=;
 b=q/Vfcza4nC7i1puPQy0BbjqN9amajveljNGUNfH1eGexx16RYmZJUT7oJWWeBrGCUzCgCB2yFJXXtNrWJid+7dbS8pl+XK+vKKJgTRl4jgdZjRcSbEy0eMm1T3NVIDAvxsgOSPMESv1TLtmWifiTS2ddBaLgRMxbU4up6p29GMc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 00:49:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 00:49:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/11] USB: dwc3: clean up probe error labels
Thread-Topic: [PATCH 06/11] USB: dwc3: clean up probe error labels
Thread-Index: AQHZZsayQLLi52aoEUybPL7jBOjOia8fCBYA
Date:   Fri, 7 Apr 2023 00:49:47 +0000
Message-ID: <20230407004934.wqjz3d6kvwxfqmfa@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-7-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-7-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CY8PR12MB8244:EE_
x-ms-office365-filtering-correlation-id: ea7ad237-1dac-47aa-6f9c-08db3701fcdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qx8jB+xV/LVUQnAZgVcvBv10PE9QIkxnOzEI3BzizchsPcMJQP8VHvu8IASjUDlTVVN49UZAxQyL3zjimV7Prjk1tCCECPGktRmkqTxniLDipbqcjwhDffuck6Y0OeY/3NYyz8/12LlRozwoe81XC63P+ooHmRjNcDzKC/WdPsKrGiBRk+1oZWQU1zsGI94yr5akCo9IVJR6OIZSuGwH7hQEqp0/Coq0VWWyWz6QlL0/ksRFMREGR8a0UmbvZaTIQtIjkxDOWHEBcavduviYSvlcWaH7DA8jaCVEOtN0xxePTxBscziRbIvCEQXy6tupDZSjhv599h4TfH2r5kZ5tCS1ZUIfhDZrxNPGzUHEaTDMA/8Txx90PODS5DVkccblJOxUXuEV5ULKJidp5XrukbZXWmkGmccolfFocWLyWYjgX2qkQoW7urldwzNdqi0omqtHqxFFys2ugEcOAetP4j7rQrzMidky0z7LTaDaCX0w3RKil2hUe2/L5RE016JIlWlbMUxiJ2AkzIJa7LQFYudhjizoNZwm4glmMMjBqxDsx5i76N9JoMY5wEVU1cySoR5DHAMiI6qugwTvJ0ru/5tG8+0CBnHDXcR9zNVj2Zz8B+Nh7Efo6iN+d61YtWnQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(66476007)(38100700002)(122000001)(5660300002)(66556008)(54906003)(38070700005)(66446008)(8936002)(64756008)(76116006)(4326008)(66946007)(41300700001)(8676002)(1076003)(316002)(36756003)(83380400001)(2616005)(6506007)(6512007)(26005)(186003)(478600001)(71200400001)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW50aGRRMjB2Mjc3YXlMMDdjSm84NkQ4T29BbHlFTU5oQ0M4MG0xZEFkUk9t?=
 =?utf-8?B?N2dJaFRTUmpvZkUvSVIwZXh1dUk5ejh4eTBxV3d0elRtUXJqYkZUV1pQdmFL?=
 =?utf-8?B?cVcrN2dwYXNvQ2pNYVVxK3NlRlMxbDUzTXBoZU1sUnYvcXk5RVhtcU84N1Z3?=
 =?utf-8?B?NlN6dFZ2MmcxbTBJUmZudllxeDVMQmY3L2FDQWNBaHZUT0ppbkFJMEFWdmpN?=
 =?utf-8?B?L2lPSTVML2k5UDVrUVo3aUFWSFkrb3I5cmZLVlpjaUZpQS9RUTJTeEszaXND?=
 =?utf-8?B?M1FqVll2ZTdiSEpyOGErQjM3ZXVTTTYwM2NpYW8rQ0hXb2MrOEllZ2NadUFC?=
 =?utf-8?B?OXZqOTQ5UjVSbi9BYlJQL3ZuMW9LOS96S1pkK21nNmtoelRCa1ZFTHVYUm1L?=
 =?utf-8?B?Q0NPUFE5VFN4VUdCbFUwL1hYMnlXUEIrd1hTOEo1Q2tPYTVhcDFYT0phbWlX?=
 =?utf-8?B?d2F4d01oMjN1Um9GdnhtaTk1eWdJMUhybFhkenJEN3pqMzRSZmJ0QTFGSllH?=
 =?utf-8?B?NTV4Rk42UzYyVXFYL0JsRy9tTmRaazk5OXJKQmVkWkRpMHJoZFJDclp3Z01n?=
 =?utf-8?B?V0ExMm8ycEl5V1lqT2VHbWtQbDErTFZoZW9ZRGJGa1hERnVWV0dicnJySUtn?=
 =?utf-8?B?USt2bWNzbnB1LzdKeEtETTAwY091Wi9CTnVDNTVKNnFMS05sVHBUZW1xZmdx?=
 =?utf-8?B?Ny9MWExjYkVxdFNjbWpla0x4WDVIb1Q5VldKdmNHWXk5a0dJZkN6aXBQa2Zw?=
 =?utf-8?B?ZU1WbzRiVk44NGhlQVFocnY3S3BtT3lKc0J0dzBxTGpnS29iQmU2aXp1NlJT?=
 =?utf-8?B?RWtyL1RDbVY4bTFTZFpvTUVTc3JlV3BhWTVwY1JxSWN3NjA3bStGeHhoQkgy?=
 =?utf-8?B?U0l3SENwWStmQUpJaHRrWm1PMEIxd1FzWjRBVGN2TmVwMTFpMzNXOVFxWCtX?=
 =?utf-8?B?eWkvWkZhbGtSdUpLZEhuNHl2Q2hialdWVW5sUWRaQWNCL1NYaFlrWkVld0Qr?=
 =?utf-8?B?czIxWnVJZzVJUmdwajRVTDdMa0VRd0hWQUhERE53Q3MrZXczWjUyU3pvVWNz?=
 =?utf-8?B?ODNIMG5DTzhjZ0NBeVBqQWNJV1BPSFljcXdOM3IzTXNQWlBRL2R1V29uYTBt?=
 =?utf-8?B?dDFiMzB4Z3FYZmtWOUkxdG1YMkw5aUN3d2o4bVZ4T0lvNUU3NTFjeXM1VDI5?=
 =?utf-8?B?dnlSRDBSZ0VsMDBsKzh1Y0xkSXRUWHRPSzFkbEQ2NU1VOUVGcENYYWQ2bkJW?=
 =?utf-8?B?bW5HUWpQWVREeFVyMmFmbFc0cVJ2bmRQa2tpby9OSCtKd29NMnhEL3ZsU290?=
 =?utf-8?B?T2ZwMjJCTWlXWnk4SVFYOUxBbmFkaEVPekoybWpTcnBESjU5UG5qWlAxRXVT?=
 =?utf-8?B?Tml4VFMrYVFPS3lxekczak9xTkZack8zK3YvNWpLb1FLVGRWcG4zUXlUamtl?=
 =?utf-8?B?bEdPb0d5YVVtckhCU3JhdDdQMUtNd0tDcjUrQ2U1dEEwbTl6Vm9BRmU2Z0Zp?=
 =?utf-8?B?YVNSditCUS9VdFhLT1J6T2ZLSDFuUHRjSjNkKzNlNm9sRVJ5bHk0eE9PS1F3?=
 =?utf-8?B?bjlNa2Z3VUwrLzdDUnlnclJzU0R0a3VHYmVoSjNFNERTZTZLN2ljRm1FZlEw?=
 =?utf-8?B?OWpGVm8vKzY5RnA4VElUL1ZpbGlsTnFrRHdXY0VPaGFmVXk2bXVOTjdCQzlj?=
 =?utf-8?B?Wm9uMjVkamlJRW0xMStycVRYbzEvL0srdjg3T2FLbjQ1L0lvTU1WTzZES0Mr?=
 =?utf-8?B?YUR0cFRiTklLcXp2T1V6bUtXYnJtUVIrUlJlQlZyM1Nqakh2YWJIdmtnK2lB?=
 =?utf-8?B?N2hnWjVqRTh5dElvSkdoUDhSdjBIWU5SMjAycXQzUWFCeWdSc0Z3eUpLQ3kx?=
 =?utf-8?B?NzhOLzROZnVOSTFQSnBjc011Y2JmM1QwTTNpSjJUZFJJVE5sSlJiNU5xWVZG?=
 =?utf-8?B?czVQZ1JONmE5aFV3dG1oc2ZJSlZFek9GY2ZIYlhkRFlUeDkvZkFseFhqUlIr?=
 =?utf-8?B?S3VIUEl2UDdrQTc5OGd6SHpJMWJpbFVsakZjcjcxWGsvR3lVeWxwc0EyaHBu?=
 =?utf-8?B?d09DK0pwOXRXZ2FGTXFnbUhaRFpWQlpFTlpRSkxCVm5BSjZOSFNkNllQalZn?=
 =?utf-8?Q?uW+dGIq/EeT+Vc5FjUXH92Zj1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F87ED700C68FFF49812283A1B33F93CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xIeqdTlhnXqONVelAnpLc6jDvd8RGRldRFpLXiGY52Kk8nXChyNpVsvyM4suAVJDCzjK90ao6E5nwQ2UJx+1JjDJPLcfelGrLI93iQizJ56YDgZ6UqkEhUhy/U5y30eW6a1djjYYnVGaOO3DbJ3Ke3RXKOpUxvCZT0D1UAnkDpwVNdxU3/Ap/CViO00mdTWcN/3SQbs0p0zHHOBTK/xepeBDTyZ4Pq1xD7AMPw8WF7TX35z5Emst7ATGp2uP8lM/zxC/dX6QizlCVxsWBW++XQ+TpQrFh2ippzDTUSLErIWLixuxY7sIf9xnAcTM0Imw93xTHbYeuRx4Cfpp4cUfnAREUY2WNDrgN3myCJZVv3IBGjeuyS+mJIoylj2yGZY9uyq2DVPP3g6ceU2Y4dIMn1J8agN15x9/5PedwwVw9Xgtg996UEqjqu7qy/fClIU4GWbe+Mh06NG+haF7fxcZ20vOu2f8kR//nJlKtX+9IWMxXHR8cRXl3D6RFvHda771dMqHaCcOnySAcgCSROyAQfvYdRaDJDOqN3x/tqxK5u13ReR63FUHxXV5pajuoGkjVPeCu9JXWFXNfy7tMIodPqp0V8myvKTse8Gkq+QwJcHo4XAptW+Jne8nYsARLV7KQXecDwSCjUsmh9I2ty20BvqQsrmqM2pPKNBX55PXfyW06vwu85dM8HT4iBNj6mvodzR2PIM3/O3L9AqDMmNcAIKSlgdrtB7quyquCu1p6mXYyKyvGAO1aP3L6zmUXhmrhbjA95d9L9sAb+7ZUsOxN9wyHAZ0+hA92eO8kxy9LiWKUuiBJx7jAd1UR1FpZfm+06846RJQxjQ77frXkTHH5jx/xRgYzFxTc75QlIg5R9xuF00LupXExwSW6mVQxB+y
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7ad237-1dac-47aa-6f9c-08db3701fcdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 00:49:47.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDi4Yj60qfxXaHkcWLYycu3z9UJlqFOYkM4AeQqSWzVJAd8xKxQoAPJNToNSrkfZK9NRE25dfv6V2XNbXc3wnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Proofpoint-ORIG-GUID: oJV9BMhACFXw-ME2dEguczst75j6cORA
X-Proofpoint-GUID: oJV9BMhACFXw-ME2dEguczst75j6cORA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=693 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070005
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gVXNlIGRlc2NyaXB0
aXZlIG5hbWVzIGNvbnNpc3RlbnRseSBmb3IgdGhlIHByb2JlIGVycm9yIGxhYmVscy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJvQGtlcm5lbC5vcmc+DQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA0NSArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMo
KyksIDIzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggZDgzN2FiNTExNjg2Li5k
ZTg0ZTA1N2QyOGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xNzA1LDcgKzE3MDUsNyBAQCBzdGF0
aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlkd2Mt
PnJlc2V0ID0gZGV2bV9yZXNldF9jb250cm9sX2FycmF5X2dldF9vcHRpb25hbF9zaGFyZWQoZGV2
KTsNCj4gIAlpZiAoSVNfRVJSKGR3Yy0+cmVzZXQpKSB7DQo+ICAJCXJldCA9IFBUUl9FUlIoZHdj
LT5yZXNldCk7DQo+IC0JCWdvdG8gcHV0X3VzYl9wc3k7DQo+ICsJCWdvdG8gZXJyX3B1dF9wc3k7
DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKGRldi0+b2Zfbm9kZSkgew0KPiBAQCAtMTcxOSw3ICsxNzE5
LDcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAJCWlmIChJU19FUlIoZHdjLT5idXNfY2xrKSkgew0KPiAgCQkJcmV0ID0gZGV2X2Vycl9w
cm9iZShkZXYsIFBUUl9FUlIoZHdjLT5idXNfY2xrKSwNCj4gIAkJCQkJICAgICJjb3VsZCBub3Qg
Z2V0IGJ1cyBjbG9ja1xuIik7DQo+IC0JCQlnb3RvIHB1dF91c2JfcHN5Ow0KPiArCQkJZ290byBl
cnJfcHV0X3BzeTsNCj4gIAkJfQ0KPiAgDQo+ICAJCWlmIChkd2MtPmJ1c19jbGsgPT0gTlVMTCkg
ew0KPiBAQCAtMTcyNyw3ICsxNzI3LDcgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQlpZiAoSVNfRVJSKGR3Yy0+YnVzX2NsaykpIHsN
Cj4gIAkJCQlyZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkd2MtPmJ1c19jbGspLA0K
PiAgCQkJCQkJICAgICJjb3VsZCBub3QgZ2V0IGJ1cyBjbG9ja1xuIik7DQo+IC0JCQkJZ290byBw
dXRfdXNiX3BzeTsNCj4gKwkJCQlnb3RvIGVycl9wdXRfcHN5Ow0KPiAgCQkJfQ0KPiAgCQl9DQo+
ICANCj4gQEAgLTE3MzUsNyArMTczNSw3IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlpZiAoSVNfRVJSKGR3Yy0+cmVmX2NsaykpIHsN
Cj4gIAkJCXJldCA9IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGR3Yy0+cmVmX2NsayksDQo+
ICAJCQkJCSAgICAiY291bGQgbm90IGdldCByZWYgY2xvY2tcbiIpOw0KPiAtCQkJZ290byBwdXRf
dXNiX3BzeTsNCj4gKwkJCWdvdG8gZXJyX3B1dF9wc3k7DQo+ICAJCX0NCj4gIA0KPiAgCQlpZiAo
ZHdjLT5yZWZfY2xrID09IE5VTEwpIHsNCj4gQEAgLTE3NDMsNyArMTc0Myw3IEBAIHN0YXRpYyBp
bnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQkJaWYgKElT
X0VSUihkd2MtPnJlZl9jbGspKSB7DQo+ICAJCQkJcmV0ID0gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIoZHdjLT5yZWZfY2xrKSwNCj4gIAkJCQkJCSAgICAiY291bGQgbm90IGdldCByZWYgY2xv
Y2tcbiIpOw0KPiAtCQkJCWdvdG8gcHV0X3VzYl9wc3k7DQo+ICsJCQkJZ290byBlcnJfcHV0X3Bz
eTsNCj4gIAkJCX0NCj4gIAkJfQ0KPiAgDQo+IEBAIC0xNzUxLDcgKzE3NTEsNyBAQCBzdGF0aWMg
aW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJaWYgKElT
X0VSUihkd2MtPnN1c3BfY2xrKSkgew0KPiAgCQkJcmV0ID0gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIoZHdjLT5zdXNwX2NsayksDQo+ICAJCQkJCSAgICAiY291bGQgbm90IGdldCBzdXNwZW5k
IGNsb2NrXG4iKTsNCj4gLQkJCWdvdG8gcHV0X3VzYl9wc3k7DQo+ICsJCQlnb3RvIGVycl9wdXRf
cHN5Ow0KPiAgCQl9DQo+ICANCj4gIAkJaWYgKGR3Yy0+c3VzcF9jbGsgPT0gTlVMTCkgew0KPiBA
QCAtMTc1OSwyMyArMTc1OSwyMyBAQCBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAkJCWlmIChJU19FUlIoZHdjLT5zdXNwX2NsaykpIHsNCj4g
IAkJCQlyZXQgPSBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkd2MtPnN1c3BfY2xrKSwNCj4g
IAkJCQkJCSAgICAiY291bGQgbm90IGdldCBzdXNwZW5kIGNsb2NrXG4iKTsNCj4gLQkJCQlnb3Rv
IHB1dF91c2JfcHN5Ow0KPiArCQkJCWdvdG8gZXJyX3B1dF9wc3k7DQo+ICAJCQl9DQo+ICAJCX0N
Cj4gIAl9DQo+ICANCj4gIAlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGR3Yy0+cmVzZXQp
Ow0KPiAgCWlmIChyZXQpDQo+IC0JCWdvdG8gcHV0X3VzYl9wc3k7DQo+ICsJCWdvdG8gZXJyX3B1
dF9wc3k7DQo+ICANCj4gIAlyZXQgPSBkd2MzX2Nsa19lbmFibGUoZHdjKTsNCj4gIAlpZiAocmV0
KQ0KPiAtCQlnb3RvIGFzc2VydF9yZXNldDsNCj4gKwkJZ290byBlcnJfYXNzZXJ0X3Jlc2V0Ow0K
PiAgDQo+ICAJaWYgKCFkd2MzX2NvcmVfaXNfdmFsaWQoZHdjKSkgew0KPiAgCQlkZXZfZXJyKGR3
Yy0+ZGV2LCAidGhpcyBpcyBub3QgYSBEZXNpZ25XYXJlIFVTQjMgRFJEIENvcmVcbiIpOw0KPiAg
CQlyZXQgPSAtRU5PREVWOw0KPiAtCQlnb3RvIGRpc2FibGVfY2xrczsNCj4gKwkJZ290byBlcnJf
ZGlzYWJsZV9jbGtzOw0KPiAgCX0NCj4gIA0KPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IGR3Yyk7DQo+IEBAIC0xNzg1LDcgKzE3ODUsNyBAQCBzdGF0aWMgaW50IGR3YzNfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkgICAgRFdDM19HSFdQQVJBTVMwX0FXSURU
SChkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCkgPT0gNjQpIHsNCj4gIAkJcmV0ID0gZG1hX3NldF9t
YXNrX2FuZF9jb2hlcmVudChkd2MtPnN5c2RldiwgRE1BX0JJVF9NQVNLKDY0KSk7DQo+ICAJCWlm
IChyZXQpDQo+IC0JCQlnb3RvIGRpc2FibGVfY2xrczsNCj4gKwkJCWdvdG8gZXJyX2Rpc2FibGVf
Y2xrczsNCj4gIAl9DQo+ICANCj4gIAlzcGluX2xvY2tfaW5pdCgmZHdjLT5sb2NrKTsNCj4gQEAg
LTE4MDMsMjMgKzE4MDMsMjMgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyKGR3Yy0+ZGV2LCAi
ZmFpbGVkIHRvIGFsbG9jYXRlIGV2ZW50IGJ1ZmZlcnNcbiIpOw0KPiAgCQlyZXQgPSAtRU5PTUVN
Ow0KPiAtCQlnb3RvIGVycjI7DQo+ICsJCWdvdG8gZXJyX2FsbG93X3JwbTsNCj4gIAl9DQo+ICAN
Cj4gIAlkd2MtPmVkZXYgPSBkd2MzX2dldF9leHRjb24oZHdjKTsNCj4gIAlpZiAoSVNfRVJSKGR3
Yy0+ZWRldikpIHsNCj4gIAkJcmV0ID0gZGV2X2Vycl9wcm9iZShkd2MtPmRldiwgUFRSX0VSUihk
d2MtPmVkZXYpLCAiZmFpbGVkIHRvIGdldCBleHRjb25cbiIpOw0KPiAtCQlnb3RvIGVycjM7DQo+
ICsJCWdvdG8gZXJyX2ZyZWVfZXZlbnRfYnVmZmVyczsNCj4gIAl9DQo+ICANCj4gIAlyZXQgPSBk
d2MzX2dldF9kcl9tb2RlKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gLQkJZ290byBlcnIzOw0KPiAr
CQlnb3RvIGVycl9mcmVlX2V2ZW50X2J1ZmZlcnM7DQo+ICANCj4gIAlyZXQgPSBkd2MzX2NvcmVf
aW5pdChkd2MpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
ImZhaWxlZCB0byBpbml0aWFsaXplIGNvcmVcbiIpOw0KPiAtCQlnb3RvIGVycjM7DQo+ICsJCWdv
dG8gZXJyX2ZyZWVfZXZlbnRfYnVmZmVyczsNCj4gIAl9DQo+ICANCj4gIAlkd2MzX2NoZWNrX3Bh
cmFtcyhkd2MpOw0KPiBAQCAtMTgyNywxMyArMTgyNywxMyBAQCBzdGF0aWMgaW50IGR3YzNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCXJldCA9IGR3YzNfY29y
ZV9pbml0X21vZGUoZHdjKTsNCj4gIAlpZiAocmV0KQ0KPiAtCQlnb3RvIGVycjU7DQo+ICsJCWdv
dG8gZXJyX2V4aXRfZGVidWdmczsNCj4gIA0KPiAgCXBtX3J1bnRpbWVfcHV0KGRldik7DQo+ICAN
Cj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAtZXJyNToNCj4gK2Vycl9leGl0X2RlYnVnZnM6DQo+ICAJ
ZHdjM19kZWJ1Z2ZzX2V4aXQoZHdjKTsNCj4gIAlkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChk
d2MpOw0KPiAgDQo+IEBAIC0xODQ4LDIwICsxODQ4LDE5IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXBoeV9leGl0KGR3Yy0+dXNiM19n
ZW5lcmljX3BoeSk7DQo+ICANCj4gIAlkd2MzX3VscGlfZXhpdChkd2MpOw0KPiAtZXJyMzoNCj4g
K2Vycl9mcmVlX2V2ZW50X2J1ZmZlcnM6DQo+ICAJZHdjM19mcmVlX2V2ZW50X2J1ZmZlcnMoZHdj
KTsNCj4gLQ0KPiAtZXJyMjoNCj4gK2Vycl9hbGxvd19ycG06DQo+ICAJcG1fcnVudGltZV9hbGxv
dyhkZXYpOw0KPiAgCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiAgCXBtX3J1bnRpbWVfZG9u
dF91c2VfYXV0b3N1c3BlbmQoZGV2KTsNCj4gIAlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoZGV2
KTsNCj4gIAlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCj4gLWRpc2FibGVfY2xrczoNCj4g
K2Vycl9kaXNhYmxlX2Nsa3M6DQo+ICAJZHdjM19jbGtfZGlzYWJsZShkd2MpOw0KPiAtYXNzZXJ0
X3Jlc2V0Og0KPiArZXJyX2Fzc2VydF9yZXNldDoNCj4gIAlyZXNldF9jb250cm9sX2Fzc2VydChk
d2MtPnJlc2V0KTsNCj4gLXB1dF91c2JfcHN5Og0KPiArZXJyX3B1dF9wc3k6DQo+ICAJaWYgKGR3
Yy0+dXNiX3BzeSkNCj4gIAkJcG93ZXJfc3VwcGx5X3B1dChkd2MtPnVzYl9wc3kpOw0KPiAgDQo+
IC0tIA0KPiAyLjM5LjINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXll
bkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o

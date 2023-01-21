Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B60676333
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAUCzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUCzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:55:48 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BABA6AC91;
        Fri, 20 Jan 2023 18:55:47 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30L2kv6a010421;
        Fri, 20 Jan 2023 18:55:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fiSS+3zjEvaWpNGNCarfeq+i4vp0IKlARGAmJh7HjoI=;
 b=BKAyb7Y/6mWn+Y2v3W6ZjliG/Qh71egYVUtuMg2g1lKEy9+B4LOCCsyAYDGNskhGjlHG
 qT/DAksY0gxRLgwprw4qt+Cqz2pzPYBS4cpdo1uQShWOmKiktY4nnrSefPwn7rHuRLfl
 +tDUMcx2kyRXSWxgT0JWEqQGUuHCDUjnc22ZLqhsLXgAtRIFA5A9aryQVcq8PcB6x1qg
 9+v1Q/mF/cMUYL6iHZr0kaimCQuFw/MQ7KfBqzC8Dw9YC9qEki5wfP/gKdHe1nP4tcdf
 WRXJbMCHMIjVdysODgmUTV86TnL638BJRJKl3Fxo6tSgv0HNBg9mIvR2pwjX+uvm7BuT Bg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3vhbad8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 18:55:31 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D4463400FB;
        Sat, 21 Jan 2023 02:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674269731; bh=fiSS+3zjEvaWpNGNCarfeq+i4vp0IKlARGAmJh7HjoI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=itAA3c/pIXCzCu8u5mQxTUfzzmnfMnKXFuWjDY29oelA8UqbVQ5JZJwi3T1iqj9Io
         HXJU461IvYG1yB6beQerB53h4agu3cejOG+7sBdSF/qPIA6dLAT6OfrA2TOLDBRvHS
         BgvLmwhttix9ReILmecNJIwl7xGa3Kt5rHS4NrOcxbeMvI6TdRbP7j2jfVatXIsKVr
         JH7Nxt4LI52wDdnirYXBxj2BfTV5+vKB0QwDCF+JlQZVBPUY5J2MB8NljByBIueH5P
         QkmTw0GhLtLtt1mLRhktaDDWSgTxCLwM5MiJd088NmrV0JC5LWjo4q5jCkhlN64Hpr
         iigLslal3KRIA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3E12EA006E;
        Sat, 21 Jan 2023 02:55:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4A799400B9;
        Sat, 21 Jan 2023 02:55:29 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="leHzFZC0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fATHPXcreXNxyKzE6Fv75BIAv1qcGRiWjTV0AFTLLOTv/d1g/dc/nd05vs8aiI/LETQm8qQGJ2hL1olrfI0zlpfXVemLmPNbyU9j+tJE3GLlOWpmyOTbKpxwH22JiHIO1T0ThNqCDoktoe2DT2kr6mHFkx/VjrXoFcYlWnkE6jigoN/ik9KqFNVENqFP02cJtgcZESZT3rFJblAlcO+NT0FVJBaScIiUkgId/7d84fOWaSor+EgdWhX1NWQ0JV2yOL5r+0c0MQak1nwik/TiiJ3w2dE1QwK6+ahg3TqG1nW95mIl7/fOhEbXMiK5KH4ALUDuCpHozvwiavI1Kk65gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiSS+3zjEvaWpNGNCarfeq+i4vp0IKlARGAmJh7HjoI=;
 b=L8HnbIVX3yV/ioQDbZL0QjxM1R1CENzaR22fvuMwVbzb/qp3hvVIkaUs80QvNCe2yxqtmTFhOJrQJWQn9xOaWrkx2qCjO0QCCUxYZmeSMJAgVNgr8KWlWMixwG0tpZG+K3Dh1XyT9WuNvGrokx16vZ6rhssWHB9Rv/zqt3Kdd7d2K9K8yo45PBkqX77YpCgbSnPtsdZJKEHUnV84/nTDLIAp2SfQLg3AxwBXbpSVrrNM899N2wjkjhaSnfPLDrMhQh7R+Q1tS899WoiGASpIeu8fAOn2PrZTURpzhFqKgZMbcPONldAxUhzOsrJz2fZOGMTdxT23Oire1dSfCk04Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiSS+3zjEvaWpNGNCarfeq+i4vp0IKlARGAmJh7HjoI=;
 b=leHzFZC0J3qX3qzcUDbS5hTnveqIGVW2Zgg23Rl1H+Ll84/oNiwXwjMWnRcliNZuh5sfuxiWVtypoOtEH+z97GRWb/+hCJ8G7a+QUNBDl271gJDZsHQC9IC2OvvOU9SIPgui+sOEQWicX+xQJE7c6hSRg/K3gbDjafpG7URX6D0=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Sat, 21 Jan
 2023 02:55:25 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.6002.026; Sat, 21 Jan 2023
 02:55:17 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAMJAICAADTgAIAAA64AgAABeICAAAhmgA==
Date:   Sat, 21 Jan 2023 02:55:17 +0000
Message-ID: <20230121025503.slgyuzyicpdzfw3h@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <20230120225719.3xau7vwlzxrtbnad@synopsys.com>
 <d2f541bd-ced6-d7b9-a2c3-43e78c249643@quicinc.com>
 <20230121021944.woat55q4qgq43ucq@synopsys.com>
 <91dc8c42-3fda-1386-586a-59d0a9b6b153@quicinc.com>
In-Reply-To: <91dc8c42-3fda-1386-586a-59d0a9b6b153@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|BL1PR12MB5924:EE_
x-ms-office365-filtering-correlation-id: 54d3b4a5-f9fd-4b76-acb4-08dafb5aed59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qB9pJJ7RcU4xZHt0hj8yNJPkY+5I5o1aRY9SVDM4jCvNj8AbAAYIeJnQ8B9zJloiTzXHIy2zViki9b4HlO+EGIKCgza9TB+AIhEM2+OLdHaWxA3hmpNYAlrJj7XAVYN9Ty2mHtOm/1+C2GQwi7msfTdoLVoG3PqxafzdM4E1c+uZhS7ZTtjM5Vk7+RqjlyrciWo1A4J8LKH93TBaxraAnD+Ihr9dtAhUndAyLQ6AwHR/3x8JxKKaCka1Sy7jakc/k+W3UoKBKq+/o6/vAtiP10rq/3+F7nMWkMhOMeTY5wHssQFiqJV0uCSpfUS6o8hYE+QRSUUYF5Zc1WL1ZxjxRDYCZNo6K8v0TlVuZz2vbvsnK+fkkT0L7/aH46E13NfoiI93LoSdVpAja24TtEfABd7x9rYiyLmnqha3deRlovzr0z1WlVAJKVQkzpqhoXYfOtrB2DAThHvpF685jx+aksRwWo/u82CEYJpNC8JgAEt8R0JJ3Yut5Hogxyj5WTsUnSzgYEqxSJgfTQZLxV+zON1HmSf5kw6pNgOKvUFOCAfefoLRSPcl6GFonmFlKNuHizNDOJ3UryvlfLnnx1i2d7L/TUY8tYSfSOdJubxguon3njwpXXMKLmt62p0cxagL3cYV8xtGWaPbWnpB8nnk93VkZ4O0kJo0j6orUZw2m3Sbtw8cjUV8NVJIVXLkdfV6KdzREkNvNquHP/TY7EjRzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(122000001)(478600001)(186003)(6506007)(6512007)(2616005)(6486002)(53546011)(41300700001)(26005)(66476007)(66556008)(8676002)(66446008)(1076003)(66946007)(6916009)(54906003)(64756008)(4326008)(76116006)(91956017)(316002)(83380400001)(8936002)(7416002)(5660300002)(2906002)(38100700002)(38070700005)(86362001)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmZ1b3BlUk5lOWlKbjNWazFTWlhPRHVvWTdkZ0lBY3dnS2RYcFpUT2srS1Ez?=
 =?utf-8?B?SXhQV1VNTTAvS0lsS0tZN1hrNUJ1NUF1aUtIQ2Rta0N5ZjFnU1dHSFE2dUtO?=
 =?utf-8?B?Z3o5dVJjOFdpdUJybFdHWXpYZkMxKzY2dG9UeDFCOEx3YnUwdVdneDJzY2lD?=
 =?utf-8?B?NE1wT1Y3WG1pM1hnRUdVQ3FCV3U0dHNFMFNWWk5lTGhqUFFHWkR5U0R2em1C?=
 =?utf-8?B?SnJSdlFWUk1QZ3doaXV1ZFUxaUZFUktXejdiSlRSc1cwbE1lR001cGpmNTYz?=
 =?utf-8?B?eWt0emptL3ZYMlM0NUlHL2xHbXF3RnF2NW50RzhtL3RnamYzMmJvaGhTYnE5?=
 =?utf-8?B?OUpiUndUQ1MyaUJxcTZVU2x5QXBzNXY3bWZSSDc5L1VwZWtlekV0dzlaY1Bj?=
 =?utf-8?B?MFZiUlNPNGRodndHZzlLM2xwT0JZcEZIRTluMlpFU3NUYlZBWXFLZjRUcUxK?=
 =?utf-8?B?Z21IN2FGNmJSY3UzRWdIWWcrRG4zaTZWR2M0TlZUbllnNnB3cTNLdUxBM0M3?=
 =?utf-8?B?YVNUL0lUcEZWU1Z1aG45UVIrN3Z4Sm50UStLY0RsblNIa0M4czlleXkyb25F?=
 =?utf-8?B?MGxWeEsxSEhLTW9SN0w4NGZTRFR3TGtDTm11V0pGc2ExTVY3aDMrMWk3R2ww?=
 =?utf-8?B?VU1teGprdkMyYk4ySzNKdithMlBxM05aT0F4TlcrMU1kalE4RTYvS1VtWFRj?=
 =?utf-8?B?S3Eyei9xNjEwZ0Vkdzg2SS9EUWRpSER4VTZKZTF2ZktrK3FERzIwN1VxelZJ?=
 =?utf-8?B?all2U09IejkzK25SU1UvUU5OeGNqSWYxeUJkRTFwa1dacGc5OXNyeEx6TXJK?=
 =?utf-8?B?M3pITE5JV0IyMUFuRFFaejZaZEVJMHN6eFJ5TERnd0VQY2FNRTVCT2JiUGZ3?=
 =?utf-8?B?WTZtU0lkRlBKWGowelo5d2FYUXJYTkx6TXM4VkFKQXpYbWxDTDVhMGp2YVFl?=
 =?utf-8?B?c0lYUG8zdjFENldkdFFsek9wWml6amU4dE03NStENVJ4cWNRMklVaFJGRzJx?=
 =?utf-8?B?SThpdWFZV2E0QzEzV1lGTllOTEo4cDJhRWJEZGRvRmZSOVNSZzNpcGhGVHZ6?=
 =?utf-8?B?NTJ6NC9aSGltTHY4QkxNVUFDUHBQdWRTRS90aXpidmNhVCtVOW1CZnJkaldL?=
 =?utf-8?B?WUFRM3JBSytmdGtvbGVLOW9sNXBub3IxSmtWMm91RXFjbis3QUxzNEduQXkw?=
 =?utf-8?B?eXRHSjJuTWE1UFNzVTc4dTZ1eU9sZGhoTjB5NDQxeS8zdlpxelYvQXlpdDJB?=
 =?utf-8?B?b0hlTGpFSFhLcFFjNXVNcTFwSUN1MkV1Sk16NEJyN1VxNVQxL0JkY3ByZ3U4?=
 =?utf-8?B?WXVpZ1MxTzFKQmFFRk1LM1JrV1h4U1dtUEZBaUYybml5em16emtkMWVBbytE?=
 =?utf-8?B?Zk5pUk90NnRqQmRpZkI5U0lHYktNN2dNZjN1QmwySWFiNjZqS05VSGtZdzR4?=
 =?utf-8?B?UWt3RDB0SHRDbzIrRnE0MmZVN0ZGZGRBcW5KY2V3c2RZclZ0WExVS1dnUHBX?=
 =?utf-8?B?eDFOSU52b1pCSERpR2tOYk8zeTFadkdXcmFIcHYvMmlySzdwdTdodmdhVjlm?=
 =?utf-8?B?UVUybnROVC9Ubm9md3BLcWE1S1krS0FhR2U2UUl4Z1JUc3Fjdkc1U0VjOFM0?=
 =?utf-8?B?N1BpZnBZd0VnSzJaTW9qQjJsWmh0aEF5Yjh1UmROc2VCK1NVaU5SZmpaKzJo?=
 =?utf-8?B?N1M2cG9nbE1Ub3VicVo1dmNpR0ppUVN0aFYyQU54c2F3aU9vditWSjVGVFhD?=
 =?utf-8?B?b1BkbUJUL0JZaUdhVHJHdlIxSGtWTGZMbXJwT3JYWFdseVltWWdBN3lWTy94?=
 =?utf-8?B?ZXIrTnIzZ1pDRUpJNHFuZmlSN0k1M0NCY05leVAxTmhTbGE4L2pCaXJuN2dE?=
 =?utf-8?B?R0RRcEt3WndVT2YzQlE2N1czVXZoOWVQUU9lNk52bTVvZnFPWjJQaWNseUI0?=
 =?utf-8?B?bjVQTVIxb3ZCNkNnZk45Rm1mcURsWEhuVHg0eENkbUlFaXVlOGFiQWt6d1VG?=
 =?utf-8?B?Wlp3TUt3SDA4dDhOYis3Wm1MY2czZ3pDa2xKQWxwU2dubUVTbnBXNHF2a0ta?=
 =?utf-8?B?cHRkNm5Odm4wa0JMcHQzODZvM1VQOE9Da2pVclFRc2p0bWpST2lCM0loZWpU?=
 =?utf-8?B?SERLd0hFUjBpUVN6bDdBQVBqcHBRK1ptUTFKeDV3b1pNbGpWeHQ3WkxJOU9N?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6428DE6E010C040879D5DD838D723F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzdKQlFCVXRiTnkyNzNnS1JXUTI0NHV1bytWQ1Z5UHNLV0NSQWRaTTBNWW94?=
 =?utf-8?B?dS9WcUE0MVYxV1B0UURaRnVVajA3MXRWZ2MxRFAvcENJYnhxU3lMOGpqWGVj?=
 =?utf-8?B?bzhRVk9aVlNvWFNIZml3VjdWT2wwNXJIWmM4QmZOUDRqclhLY3BFRldVbDZI?=
 =?utf-8?B?OXdROTFVQjdmeFVwY3EyWVh5US9PSTZyenl0YmlOajh5bUUyT3lCUEZFUWJw?=
 =?utf-8?B?c2MwV3hJYWtHQnFCRkF1MEQzdVpvQkFOWVlYMU9saFhqOWpHWlFBekprNHFz?=
 =?utf-8?B?ak5UWXJDZS9TNWFxZHdDdUU4SzZrY21MbmlRUDZhSTRmQzhMUXhzaWtTNW90?=
 =?utf-8?B?R1ZzUGRZR3JzeHRjOGZ5OUh5Q25qQmFHTjVxZzJjSnE3ZWJ6MWtOdXcydlB2?=
 =?utf-8?B?NWRDSTFuQmo5bGNvL1VHcGJSU1MyVkNUU1pnRTVTSzlWYjI0elg1c2hYR0Y4?=
 =?utf-8?B?ZDQ2YzFmYzVTTTNFcVV4bVNybWtSdnA1Qko3L3pVbjl1MkNYS1VTeU9oWSt1?=
 =?utf-8?B?dk5uM3k5bUlodXA0YnFVSDhjWUdZbnRoZndWZVRoeWVYYVdrSE9oNExzbHBG?=
 =?utf-8?B?VWVvWmllQ3JOTDYvZFp6YXhBQytXcHdSdGxYSG4yaXZ6OEZwV2Q5SjZoams4?=
 =?utf-8?B?V0gzUnpDS0doL0FKMkQ0MFl1Q0xUY3hDODNPQytPYit0ckpQWUVBUkQ3eVor?=
 =?utf-8?B?cWtsVTVTaW1EdktHZitpRDIxN0JLaitENjd6aVFpZkFTN2plUkxkNXdXbklX?=
 =?utf-8?B?dmZaSjJKektURzVNQ3ZGdlFRaFdkcVYveWY3TGZLd3dHUUtyUHBNa3F0aFNT?=
 =?utf-8?B?UG9EN2hyM2FIVWRVUUhFYkZrWG4ybm5RK2pSOVI4bk5YR1hjNTg1eE14UXUx?=
 =?utf-8?B?ckw4Y0xTV3NoeHNoRFhDTCt1Uks4cDJtMHRVUkRoeUthSCt4cnBsMVBsWjJp?=
 =?utf-8?B?TlBwLy83eGF6c0J6MWpjc3RnQVNZUWgzWnBOUkt1VWZDUDZaQmtqN000bDJp?=
 =?utf-8?B?eE93SzRhR0F3TGRObTlWSEJ5SzA2VEVNNlJsRXMyQzdSK0FQT3dQWnFUbE1V?=
 =?utf-8?B?cXZNZVFyQTBlTTZCZEM5U0swMXlGMTF2Z0xTSUMrbDJyMzRsQUFLbktWS0Q5?=
 =?utf-8?B?NkVURWdpaXBFS3ZvMmR3a0lBT3RBbTg0NEMyZVVOMmVRZzFSMG50Z0hhcmNG?=
 =?utf-8?B?b3hDU05LY2xaeFZOaElWV3U1anZ4a0xjV1ExbVNDRytXMWZ1dTFBWGZXR3Bn?=
 =?utf-8?B?Tzg0Nm1BRHl1TlRLWVowdnMxU3IrMkVPVnFoK2R2VmpWR3YrZXV4NlcrWDdi?=
 =?utf-8?Q?mM8fV5SEi4QO8=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d3b4a5-f9fd-4b76-acb4-08dafb5aed59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 02:55:17.3739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftbIoeKmKtCxBgGk/rqt3sm73vDmC077FghCH13MnF41IaCxzdV+XjfSRD2wdko5vneHXvDhwait1O/4JFNpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
X-Proofpoint-ORIG-GUID: PkNRDkZ9lgONA9ZofIclqcm39ziqW89D
X-Proofpoint-GUID: PkNRDkZ9lgONA9ZofIclqcm39ziqW89D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301210026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBKYW4gMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMS8yMS8yMDIzIDc6NDkgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBT
YXQsIEphbiAyMSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gDQo+ID4gPiBPbiAxLzIxLzIwMjMgNDoyNyBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0K
PiA+ID4gPiBPbiBUaHUsIEphbiAxOSwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4g
PiA+IEhpLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIFN1biwgSmFuIDE1LCAyMDIzLCBLcmlz
aG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gPiA+ID4gQ3VycmVudGx5IHRoZSBEV0MzIGRyaXZl
ciBzdXBwb3J0cyBvbmx5IHNpbmdsZSBwb3J0IGNvbnRyb2xsZXINCj4gPiA+ID4gPiA+IHdoaWNo
IHJlcXVpcmVzIGF0IG1vc3Qgb25lIEhTIGFuZCBvbmUgU1MgUEhZLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEFkZCBub3RlIGhlcmUgdGhhdCBtdWx0aS1wb3J0IGlzIGZvciBob3N0IG1vZGUgZm9y
IGNsYXJpdHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEJ1dCB0aGUg
RFdDMyBVU0IgY29udHJvbGxlciBjYW4gYmUgY29ubmVjdGVkIHRvIG11bHRpcGxlIHBvcnRzIGFu
ZA0KPiA+ID4gPiA+ID4gZWFjaCBwb3J0IGNhbiBoYXZlIHRoZWlyIG93biBQSFlzLiBFYWNoIHBv
cnQgb2YgdGhlIG11bHRpcG9ydA0KPiA+ID4gPiA+ID4gY29udHJvbGxlciBjYW4gZWl0aGVyIGJl
IEhTK1NTIGNhcGFibGUgb3IgSFMgb25seSBjYXBhYmxlDQo+ID4gPiA+ID4gPiBQcm9wZXIgcXVh
bnRpZmljYXRpb24gb2YgdGhlbSBpcyByZXF1aXJlZCB0byBtb2RpZnkgR1VTQjJQSFlDRkcNCj4g
PiA+ID4gPiA+IGFuZCBHVVNCM1BJUEVDVEwgcmVnaXN0ZXJzIGFwcHJvcHJpYXRlbHkuDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IEFkZCBzdXBwb3J0IGZvciBkZXRlY3RpbmcsIG9idGFpbmlu
ZyBhbmQgY29uZmlndXJpbmcgcGh5J3Mgc3VwcG9ydGVkDQo+ID4gPiA+ID4gPiBieSBhIG11bHRp
cG9ydCBjb250cm9sbGVyIGFuZCBsaW1pdCB0aGUgbWF4IG51bWJlciBvZiBwb3J0cw0KPiA+ID4g
PiA+ID4gc3VwcG9ydGVkIHRvIDQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEhhcnNoIEFnYXJ3YWwgPHF1aWNfaGFyc2hxQHF1aWNpbmMuY29tPg0KPiA+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5j
LmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gICAgZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMgfCAzMDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+
ID4gPiA+ID4gICAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgMTUgKy0NCj4gPiA+ID4gPiA+
ICAgIGRyaXZlcnMvdXNiL2R3YzMvZHJkLmMgIHwgIDE0ICstDQo+ID4gPiA+ID4gPiAgICAzIGZp
bGVzIGNoYW5nZWQsIDI0NCBpbnNlcnRpb25zKCspLCA4OSBkZWxldGlvbnMoLSkNCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gPiA+IGluZGV4IDQ3NmI2MzYxODUxMS4u
N2UwYTlhNTk4ZGZkIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+
ID4gPiBAQCAtMTIwLDcgKzEyMCw3IEBAIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPiA+ID4gPiAgICB7DQo+ID4gPiA+ID4gPiAgICAJ
c3RydWN0IGR3YzMgKmR3YyA9IHdvcmtfdG9fZHdjKHdvcmspOw0KPiA+ID4gPiA+ID4gICAgCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gPiA+ID4gPiAtCWludCByZXQ7DQo+ID4gPiA+ID4gPiAr
CWludCByZXQsIGk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ2FuIHdlIGRlY2xhcmUgdmFyaWFi
bGVzIGluIHNlcGFyYXRlIGxpbmVzIGhlcmUgYW5kIG90aGVyIHBsYWNlcy4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ICAgIAl1MzIgcmVnOw0KPiA+ID4gPiA+ID4gICAgCXUzMiBkZXNpcmVkX2Ry
X3JvbGU7DQo+ID4gPiA+ID4gPiBAQCAtMjAwLDggKzIwMCwxMCBAQCBzdGF0aWMgdm9pZCBfX2R3
YzNfc2V0X21vZGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ID4gPiA+ID4gICAgCQl9
IGVsc2Ugew0KPiA+ID4gPiA+ID4gICAgCQkJaWYgKGR3Yy0+dXNiMl9waHkpDQo+ID4gPiA+ID4g
PiAgICAJCQkJb3RnX3NldF92YnVzKGR3Yy0+dXNiMl9waHktPm90ZywgdHJ1ZSk7DQo+ID4gPiA+
ID4gPiAtCQkJcGh5X3NldF9tb2RlKGR3Yy0+dXNiMl9nZW5lcmljX3BoeSwgUEhZX01PREVfVVNC
X0hPU1QpOw0KPiA+ID4gPiA+ID4gLQkJCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2VuZXJpY19w
aHksIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiA+ID4gPiA+ICsJCQlmb3IgKGkgPSAwOyBpIDwg
ZHdjLT5udW1fcG9ydHM7IGkrKykgew0KPiA+ID4gPiANCj4gPiA+ID4gQlRXLCBpcyBudW1fcG9y
dHMgdGhlIHRvdGFsIG9mIHVzYjIgKyB1c2IzIHBvcnRzPw0KPiA+ID4gSGkgVGhpbmgsDQo+ID4g
PiANCj4gPiA+ICAgIE5vLCBudW1fcG9ydHMgaXMganVzdCB0aGUgdG90YWwgbnVtYmVyIG9mIGh3
IHVzYiBwb3J0cyBwcmVzZW50IChwcmVzdW1pbmcNCj4gPiA+IGVhY2ggcG9ydCBpcyBocyBjYXBh
YmxlLCB0aGlzIGlzIGp1c3QgdGhlIG51bWJlciBvZiBIUyBQaHkncyBhdmFpbGFibGUpLg0KPiA+
ID4gDQo+ID4gDQo+ID4gSSBzZWUsIHRoYW5rcy4gQ2FuIHlvdSBhbHNvIG1ha2UgdGhpcyBjbGVh
ciBpbiBpdHMgZGVzY3JpcHRpb24uIEkgZ290DQo+ID4gbWl4ZWQgdXAgYXQgc29tZSBwb2ludCBm
b3IgdGhlIGVxdWl2YWxlbnQgb2YgSENQQVJBTVMxLk1BWFBPUlRTLg0KPiA+IA0KPiA+IFRoYW5r
cywNCj4gPiBUaGluaA0KPiANCj4gU3VyZSwgV2lsbCBhZGQgdGhpcyB0byBjb21taXQgdGV4dC4N
Cj4gQnV0IGFzIHlvdSByaWdodGx5IG1lbnRpb25lZCwgSENTUEFSQU1TMSBnaXZlcyB0aGUgdG90
YWwgbnVtYmVyIG9mIEhTK1NTDQo+IFBoeSdzIGF2YWlsYWJsZSAoSENTUEFSQU1TMS5NQVhQT1JU
UykuIElzIHRoZXJlIGEgd2F5IHRvIHNlZ3JlZ2F0ZSB0aGlzDQo+IHZhbHVlICh0byBqdXN0IG51
bWJlciBvZiBocyBhbmQgc3MpLg0KPiANCg0KV2UgbmVlZCB0byB3YWxrIHRocm91Z2ggZWFjaCBw
b3J0IGFuZCBjaGVjayBpdHMgY2FwYWJpbGl0eSwgYW5kIHdlIGNhbg0KY2hlY2sgdGhlIHBvcnQn
cyBtYWpvci9taW5vciByZXZpc2lvbiB0byBkZXRlcm1pbmUgd2hldGhlciBpdCdzIFNTDQpjYXBh
YmxlLiBTZWUgeGhjaSBkcml2ZXIncyBsb2dpYyBhbmQgaG93IGl0IGNhbGxzIHhoY2lfYWRkX2lu
X3BvcnQoKS4NCg0KVGhhbmtzLA0KVGhpbmg=

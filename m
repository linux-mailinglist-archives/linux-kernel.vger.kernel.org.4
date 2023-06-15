Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B3732158
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjFOVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFOVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:08:28 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA38726AA;
        Thu, 15 Jun 2023 14:08:26 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FKfrjm006422;
        Thu, 15 Jun 2023 14:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=uClux9TyPVUN43KMVAwXS7GvvsaktIQgoHgX8qSer08=;
 b=b8cx2gTg9iL08XxKsDYS0lcidp5oN+qtBEpDQoMmhpLaVw9N1+ofYDQ2GaUm1evY9vZ5
 vtZJ/8Gc6c6p7cOQX9VzMLwM2D5z3DX7eNjR53BVgh8YU3FJvG1yLo3KQ284k2JG9pXi
 slhQA4dVUSQ1J66bdp9PU6UW2kRJJ9cBh4MZpqDjglhHZMhCDUsQtHIZvNWsSGc5g0/X
 LiRkSejtl1aRiAlBlwxzy8D/ouYqZEKtofMhFjWHBqYRCira9Uz1p+bOZrtReqd0R2pY
 AjKtHt/UUmwYu8bybhy+GKX9LDR6Vu6FHHiG146gN6It+1Ur6XyZvxgxzunf04VUjEXE KA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3r4re5s37p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 14:08:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1686863289; bh=uClux9TyPVUN43KMVAwXS7GvvsaktIQgoHgX8qSer08=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OnwNWU5PJpjOTlWTf5p3w0Bj6dMZ1d+f2tMLly41gBFLL9cnk1bGMWHtJNvgb4nqS
         BGnnMYrwhxXFBUYGZwtSm9KjYlvRuCKxNN1aU3NwQW2EXrA2/I8Iqd7WuPJYsfNpA2
         WIyTVC3JpMFKjXkHF53FcPhge0FNx0KrO0GFoNirj5B5HyvqE3jbfcM+VZBkeQ2Ij5
         /wyWIdLO70FhletK3Sxj5AycztjL5jeJNYhdm7533SWKDK70J4vvhHQeKRvd2qpjMm
         j/THRP0UajPR/2zQu8QzFcuA+T+wr99ckfD7sH3qaTVzgdDqft4k4XvZztFRgA/4KJ
         OTqtsdi5dPJ0w==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 12D77401D2;
        Thu, 15 Jun 2023 21:08:07 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6DC41A0071;
        Thu, 15 Jun 2023 21:08:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eUQWXY3I;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D473D4012E;
        Thu, 15 Jun 2023 21:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdYnPO942NNuQAFybLvIP9Qh9IBpl/De4gm6rS5MGvPOSZPW3HNtz2KIYLBlGKAaVkd/tYsrvIWS+HNacwcKqQ1/eXceK8I3PEUN6wIS8cwS339zRexrGhj71YaijVhLJkpaifAy8R33pVidX9wn40x7Hi3whXva5BlODTkDCperGtDvEMZ96Kb0zX6mqogHXTNH7ngvgTh2ZWK4YMxebUZySpuXNbX0yP5hvQxz704Ia0oObkp6u4KyiJuZVrtNYzTizcil3VBUBBdEtHgF/MLlsRxSj68g0f4S++EqtEiw7E/IEM2onDqVUojA04fie97j7KxxKOKrVxD2zynSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uClux9TyPVUN43KMVAwXS7GvvsaktIQgoHgX8qSer08=;
 b=fhaE4zzSzJWRksaoaTf4FrLCVF4178W5Vc5jF8be7vupyx38by53xyw22B0664ZhJQDQLsXFs5sexnBw4pCFfUrXANTsDIdy33ylBChx+YoHjOs4BghTRcZbPVFz6OYQpXjD59FMRg+ijV6jXBRcs5rgGq/vPWe6SrGs12Cpk78NbWk8d01oZrANiX5JPl9KykgREZVbxMB+rDqrc54roIbYCHHhTEm1BagilBPZrtzj3slEMuBo+xvyhojEyr4X9kkVD4X7+hhXbYYhnsh+ViXZ9ONNtDb3BJtWzim5n5b+ERxdB9lAr0ODGH/6bzx2SnTMLy9UoKBWn0WVzsVvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uClux9TyPVUN43KMVAwXS7GvvsaktIQgoHgX8qSer08=;
 b=eUQWXY3IxCLHgkAvDmfXIQi/AZybW6q+0rxp8ucSCHRk9GHAHn1pQjTXhs3d/biB5M9SEjTqQ5Ofc6Lx7O5ef9zd04S8S7xmRj+jdl1EK1Eezz4LCGa/nH3Cbux9YCjD8jRbUh7nFuEtC9V+osL64FeKH3MlGQCgSW8lUCNEb3s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB8497.namprd12.prod.outlook.com (2603:10b6:8:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 21:08:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:08:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Thread-Topic: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Thread-Index: AQHZhif6/qSXXM0dd0yowK/+LbRnLK9b7I4AgABAvwCAAoIhAIAEyu8AgBviTICAAInNAIAA6E6AgABfQACAACrxgIAA8LOAgACm7QCACISlAIABGWQA
Date:   Thu, 15 Jun 2023 21:08:01 +0000
Message-ID: <20230615210800.lvmekpvxjiszkrh4@synopsys.com>
References: <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
 <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
 <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
 <acd46bb7-0708-d095-c3c6-53653f9e47d6@quicinc.com>
In-Reply-To: <acd46bb7-0708-d095-c3c6-53653f9e47d6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB8497:EE_
x-ms-office365-filtering-correlation-id: e31172ca-bb07-4ea5-c783-08db6de49ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q85lY2Umd/pepUbaFsNPXXLkDUwE/UHN0oCYRw6lwF1Fg+z0QyVV6p+LBOuu8N6FBaVaFulZ40/0IfakJozF7+8MYcsizkC9QnrQxU4S678h48iA/6N+K87yO8ghbD1rV/tSakvGxDOpUrYhcS5gN2UyK8SfJJf2DXN9++VGRsMHnl0TuAZRBu3kK3mFAwi8meM+SS52tPqS0Q5wL7/QiZXYPpRurAhA6FDeYTX4vGa/KCa7DyyQlA7g2F91p4sb95ePqEr3vk/hd6MMT6B08PF6kWB4EBEus8T5A9hxy0TVmZwjiH8VQzMpu4kQtV/tD04ezhhhXWu6mwyTB09YKwAIv+r/s49896bbiRTjWgjWklVzKDp6h2GyCMf+hx7zUCxt8Oj40WUxFnM47+c7W2wAQcAXANBtMC5ApSuTzA5ZO7b6lGdDi91XaBa8+wzOuD0SXI2HEq9O7osQCrQQCi7GUlLeQso0Omff6/qBI02zQ7uDo6b1sWfI1zv9GluWKTwhnA0HrT3vQ6A8bGu+g72QLowTHidk7vwkRgSBi4TtdbwaG/E+PRG9DgBsHnimkTdwkMI/6JAzRWnxjdoWE9kK31xB8JR1Jrai1aFylqTpTY0KvqRB5JyWSj4VNvkUwC3GZm54Rfwmxpoy1KU08g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38070700005)(122000001)(38100700002)(54906003)(8936002)(8676002)(6486002)(316002)(966005)(41300700001)(5660300002)(478600001)(66946007)(66556008)(76116006)(66476007)(6916009)(66446008)(64756008)(4326008)(71200400001)(26005)(53546011)(6512007)(1076003)(6506007)(186003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWpFZ2I5Y1JCczV0QXIwRHlmQ3YwdjZCMjNXSnR6Q2dSOGsvcG5IOGRjeC9v?=
 =?utf-8?B?cGZ4ZVhIOE9uQXo1RUg3ZkRHT0xmV1MzbFlkam1sTHhsR2ZVN0tBL2Z6bHFQ?=
 =?utf-8?B?SVJHdFZHQlUvYytsV1pncmdWaDlFYkhUelZodlFtVll0bUNmNmNKZzJ5Rk5w?=
 =?utf-8?B?T2k1dUwydlc1TWZNUTRkalNMRnVIQ2RqTUFUQmw5ZTErVW9QcStSaHkxazJC?=
 =?utf-8?B?Q2pGa2JQQSt4azlCeGhvdFZCekp6UmJER2VTaVhhb1lCY3UyKzVvSGxQNk5G?=
 =?utf-8?B?NC83YVYwTXo3Tm9aWmpTS1JmZk1NbHUwL0hwMTc0UW9oeWRtV09MR2ZkaUg0?=
 =?utf-8?B?TnMwK2lPNEFpVDl5eE1wWG1qR1VhaHI0M3U1Z0VVcnVEUEErOGhPUGFxd0dT?=
 =?utf-8?B?ekNxT1I0RHVzeGczazJEbFdKRXdqK1laNS9wMXBHRFJIeTE2WEJXcnQrZk5w?=
 =?utf-8?B?VnE3WUV5YThMdDJJRVVLcjZ1em9udzEyd1dwQ2JJY2hnZGpLYnU0SHhYbklx?=
 =?utf-8?B?d1plWjRlK0ZkM1NlY2ZhRFRZVk9hd0t2aEliYUJBTDI5cG5nMzhJTlc4Wnoz?=
 =?utf-8?B?MVBGdU5DTTBlV0xJWHViYkVQellpQ3RXUmlkVzhZa2NiaDZUNjF1cmhHVXY3?=
 =?utf-8?B?cDkzTXNUa1VLSWxpNktDSEU5eDVsWHhlWExrK2o2ZUJzeExNY29yYkIxWW9Z?=
 =?utf-8?B?QnJBdnI4QUtLTzhrWlhSOWZML2hQSmhSYm1JSlNBbWIxSGNWZEpRdGNkM2E0?=
 =?utf-8?B?LzhyZ0M0bzRiSDJ0cWUxYUVDNG4zS1BOWG9NUDI0RmhxTWd0Ris4M1VUUlc0?=
 =?utf-8?B?Qkh1NjlmUXdZS0RmNGJib3RObTU2b2hWSzdldmFhSldtSmRLMmNjVExFLzlL?=
 =?utf-8?B?MUpLZFhEalJNVm5WK1REZForZzVmdGI3UTR3MVJ6bm96Zm9zK3NkRitya05w?=
 =?utf-8?B?aUx0WUVIY0JXMFgrU1JtN0JuK01oK1ZqUk5mTTJtK09VaWtBTXlWbjN1Ympv?=
 =?utf-8?B?NGhYVnliRlgvQ3cvRnV5bndOZDFEUmFJV0o2L1FCY2lkTVNOdTllQitqUHFp?=
 =?utf-8?B?UVE1R3VOQ2hJVlJ4K2xqdmt4c084bzM0NzhBSEpicm9JMHdleVJkRmhPQ1hi?=
 =?utf-8?B?ZVlrRlZHZyt2L3A0UXZDKzNaT0w2eEMxQ3orcXBOMG9aYmRQZVpvSmVzeTZ3?=
 =?utf-8?B?bmpFRlhUVFVvb2IzNkk2VGZmTzA2UTRwbDUxNFpYOHc3SmhaZUlIdTFlQWYr?=
 =?utf-8?B?dXM2Z1Q0ZTcvQytteWViNlA4c1BYbWpJV0o3ekZ4cDVoVnNNOEt1WUFJYjd2?=
 =?utf-8?B?YmdtRjhNRGJqTXlkbE1XTm5CaW9pVURSV1VUU2VTYjNOZ0RHSDBHZWZSbmlJ?=
 =?utf-8?B?TmlXYTlhNjdNcS9UbjVFb21NYzhiWURoaXhUVFpDRklpdEJ6SWF3MGRUaVVs?=
 =?utf-8?B?VnR3KytsQkNxdlVjWTBZMVdBd01qWU16U0xOemhKdW13ZnFQbGhreWpxRUQw?=
 =?utf-8?B?emJ4UDc1SWZqbmd6bERydi9nbmJERGlrUllSaGs0Nnl6alRqV2NQZFRnRXpW?=
 =?utf-8?B?NUNRNGJyanVqb3FxYkZ2TERWNjM1Sk83MmFFVHpCL1NLQndsY29rREtTbDEz?=
 =?utf-8?B?N3prSXNuYmdWdjBqaUNmYjUvNjlkRU9tSHhtLzNRNXRtZFkvU1ovTzhLbEV3?=
 =?utf-8?B?bG9Wd21EQ0pNdGpmOVAveXFkTFBXVGFQQTJaZGVsVFdISVdqK3VaWHpERDBZ?=
 =?utf-8?B?QXhMUG12bXZzVkRhbDZlemRrM29ISUxyWlVjd0pTdWdHejduZXJvTXBtU1cz?=
 =?utf-8?B?aGRXcFNzanU1c3NLMHV4cU5rMXZpbzRGUnpuMXRUMGtPME9XeXdVOTM5Skg1?=
 =?utf-8?B?TmVDZ2FqTUozU1F5b1VleVhYZ2d1dml6aU5xSldMSGVSOUZQWlB0d2UzREwr?=
 =?utf-8?B?VU1ZSkJPWUdvL1JHU3piWklkSVFMUDdNeWFQQ3pQVU5JVDNJaDBvd0FwZmE5?=
 =?utf-8?B?UVVEREdId2VLbjhZU0xXVzEwQ0R5alBOVDlKTWV5eDBkS0R4Qmk3MjcwbmNK?=
 =?utf-8?B?N1NRWW9uK2pidW94bGF3YVFZZmdSSGxSblpaNG9UeDdmWUtFWEEvUjNickl2?=
 =?utf-8?Q?xv+djC1Nm2ohLNY9eG2jU36iM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <447D016A7AA9994385EE64C2A11261F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEhOQU5sSVpRanErTUh0c0VNQWpNaExiL1BDb1VTZWRSVE1iOUxiazQwejdz?=
 =?utf-8?B?TFBLU0NFUDB5RGxtZHJnaHZhN0U4M2ZBYTNkQzBCQTRFYkdlNW9YSVJGeEh4?=
 =?utf-8?B?T3JwM1IrdDAwWnpoS0ZnRVFIQWk1aEpFeWNPMkhQYWRnbDJZTGRBWFR3V3ZQ?=
 =?utf-8?B?UHRUMjhvK0ZiMjl3KzdBTllMYnI2ME9aZWpOcDF6bVZJbmt1MDl0NUpmVnR2?=
 =?utf-8?B?cFl2bjFVVWt0MkY5YmlUL0FmTUc5bE9SZG51OWpYTUtNZHlvUFRHQUJPb3N5?=
 =?utf-8?B?MVpvNmVtcjYydmFPeUNsNExYRHh1dEttZUJUVTNLNnBwZy9RWW5oc3hLdUZl?=
 =?utf-8?B?RDUrSnhXYmhzZU5zSXUreGJaSVJzY2RCcU81ZEFZblBlekZaaW92Mm1Wd0lE?=
 =?utf-8?B?Vm9jblBjdnFzckNKanMxOUErTTBtWTlIOW9uZGx1MTZCL2ExY0duN0hBNVh5?=
 =?utf-8?B?bWFsZE5xaFh5K3JkclQvYndmV2FSa3R2amMwQXBDM1FFNXVLTi9WeStZVnlr?=
 =?utf-8?B?OXV6QWExcWRuL290TEwwRndqL2l3cEtQbVNPbjZSVUx6MWhQVW5sTk5CWEov?=
 =?utf-8?B?elNZSU1yRUh4TWU4MHp0SGx5NExkeEJGTFJOL2VYVlQreHNKNzJ2OWlzV3lZ?=
 =?utf-8?B?QkJzWUMrVkpobGtWMlRLZEJSSXJLNnAxNk5tWHRNU0hHV0ZLZXFxTThQUmh2?=
 =?utf-8?B?bHg2WGVIbXoyTC9HWDhCNzRzSTJ3MmVvNW5yNm1ubWVvbTc5dG9jWnpjM25a?=
 =?utf-8?B?ZlJERXV6L1lnQzkwTld6QWZQTkRJSC9GWlJNU0d3Z25weC82eUcwWXl0eDF0?=
 =?utf-8?B?S1NEVWROMysrTXExRmJkV1M2MVRTM1ZueEtYYmh4Zmcxek5HSjNtTGZHQjFw?=
 =?utf-8?B?Mkt4WEZxZzNhWElMclpsLzBncmE3VkN3TWNnRHF4TW5yNWVESGR5dDU1bThM?=
 =?utf-8?B?UThYSjBDL3pKaEJESUI2Wkc2MGdnWDRZbHpHcTJKSDc5bm9pT2JyZkozYzZM?=
 =?utf-8?B?ZXJPMjE0TGZ2Y29HRFJJSFYwcnUxS2RwNFAyS3JDZXZwcVVpazVGZmRSTDRk?=
 =?utf-8?B?MTV3OFoxSS9tTjVrWWJRdDBJMHY2cURINnFIaDVudElXd1VkNzVMamVCdGdP?=
 =?utf-8?B?ZEFpalpsaHUxZ3llUGZBUDZWdENGOCtuQXZpY0Vmb285VFU3QTRIWXNhd1l5?=
 =?utf-8?B?RzJrelU1V1lkelBtZHgyWW1TQWl3cFh4QkZYRVMrTThnYWlERDlZcU9MY1Vq?=
 =?utf-8?B?NzhXRmNiRVh1MW9uQ05xTUszUGl0Tll1R3JlYzFpRnNwUnozUHcxeWJsbGJT?=
 =?utf-8?B?N0RpSnJCcCs3SmNCYUx6cVN1aDN6MURKeWdTUVRQY0JXb2FXMXlmOUFZNXIz?=
 =?utf-8?B?YkRqWWc2dXkwNHc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31172ca-bb07-4ea5-c783-08db6de49ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 21:08:01.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jaf8GrjIu1ecQ5WkrbGdYe6X9GNw7MeD6xYeixCd3j5LapP9ZPTmfwxGq/CwXnODGvR7wnv1IkU7Saksk+eYJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
X-Proofpoint-GUID: HC25-aNRblw7fGWJBjhoi0uqIwNOzX0e
X-Proofpoint-ORIG-GUID: HC25-aNRblw7fGWJBjhoi0uqIwNOzX0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_17,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306150183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdW4gMTUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNi85LzIwMjMgMTE6NDYgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBG
cmksIEp1biAwOSwgMjAyMywgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdW4g
MDgsIDIwMjMgYXQgMDU6NTc6MjNQTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4g
PiBPbiBUaHUsIEp1biAwOCwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3cm90ZToNCj4g
PiA+ID4gPiBPbiA2LzgvMjAyMyAzOjEyIFBNLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+ID4gPiA+
ID4gPiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMToyMTowMkFNICswNTMwLCBLcmlzaG5hIEt1
cmFwYXRpIFBTU05WIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiA2LzcvMjAyMyA1OjA3IFBNLCBK
b2hhbiBIb3ZvbGQgd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBTbyB0aGVy
ZSBhdCBsZWFzdCB0d28gaXNzdWVzIHdpdGggdGhpcyBzZXJpZXM6DQo+ID4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ID4gCTEuIGFjY2Vzc2luZyB4aGNpIHJlZ2lzdGVycyBmcm9tIHRoZSBk
d2MzIGNvcmUNCj4gPiA+ID4gPiA+ID4gPiAJMi4gYWNjZXNzaW5nIGRyaXZlciBkYXRhIG9mIGEg
Y2hpbGQgZGV2aWNlDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gMS4gVGhlIGZp
cnN0IHBhcnQgYWJvdXQgYWNjZXNzaW5nIHhoY2kgcmVnaXN0ZXJzIGdvZXMgYWdhaW5zdCB0aGUg
Y2xlYXINCj4gPiA+ID4gPiA+ID4gPiBzZXBhcmF0aW9uIGJldHdlZW4gZ2x1ZSwgY29yZSBhbmQg
eGhjaSB0aGF0IEZlbGlwZSB0cmllZCB0byBtYWludGFpbi4NCj4gPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gPiBJJ20gbm90IGVudGlyZWx5IGFnYWluc3QgZG9pbmcgdGhpcyBmcm9tIHRo
ZSBjb3JlIGRyaXZlciBiZWZvcmUNCj4gPiA+ID4gPiA+ID4gPiByZWdpc3RlcmluZyB0aGUgeGhj
aSBwbGF0Zm9ybSBkZXZpY2UgYXMgdGhlIHJlZ2lzdGVycyBhcmUgdW5tYXBwZWQNCj4gPiA+ID4g
PiA+ID4gPiBhZnRlcndhcmRzLiBCdXQgaWYgdGhpcyBpcyB0byBiZSBhbGxvd2VkLCB0aGVuIHRo
ZSBpbXBsZW1lbnRhdGlvbiBzaG91bGQNCj4gPiA+ID4gPiA+ID4gPiBiZSBzaGFyZWQgd2l0aCB4
aGNpIHJhdGhlciB0aGFuIGNvcGllZCB2ZXJiYXRpbS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBj
b3JlIHdpbGwganVzdCBiZSBsb29raW5nIGF0IHRoZSBIVyBjYXBhYmlsaXR5IHJlZ2lzdGVycyBh
bmQNCj4gPiA+ID4gYWNjZXNzaW5nIHRoZSBwb3J0cyBjYXBhYmlsaXR5LiBPdXIgcHJvZ3JhbW1p
bmcgZ3VpZGUgYWxzbyBsaXN0ZWQgdGhlDQo+ID4gPiA+IGhvc3QgY2FwYWJpbGl0eSByZWdpc3Rl
cnMgaW4gaXRzIGRvY3VtZW50YXRpb24uIFdlJ3JlIG5vdCBkcml2aW5nIHRoZQ0KPiA+ID4gPiB4
aGNpIGNvbnRyb2xsZXIgaGVyZS4gV2UncmUgaW5pdGlhbGl6aW5nIHNvbWUgb2YgdGhlIGNvcmUg
Y29uZmlncyBiYXNlDQo+ID4gPiA+IG9uIGl0cyBjYXBhYmlsaXR5Lg0KPiA+ID4gPiANCj4gPiA+
ID4gV2UncmUgZHVwbGljYXRpbmcgdGhlIGxvZ2ljIGhlcmUgYW5kIG5vdCBleGFjdGx5IGRvaW5n
IGl0IHZlcmJhdGltLg0KPiA+ID4gPiBMZXQncyB0cnkgbm90IHRvIHNoYXJlIHRoZSB3aG9sZSB4
aGNpIGhlYWRlciB3aGVyZSB3ZSBzaG91bGQgbm90IGhhdmUNCj4gPiA+ID4gdmlzaWJpbGl0eSBv
dmVyLiBQZXJoYXBzIGl0IG1ha2VzIHNlbnNlIGluIHNvbWUgb3RoZXIgZHJpdmVyLCBidXQgbGV0
J3MNCj4gPiA+ID4gbm90IGRvIGl0IGhlcmUuDQo+ID4gPiANCj4gPiA+IFRoZSBwYXRjaCBzZXJp
ZXMgZXZlbiBjb3BpZWQgdGhlIGtlcm5lbCBkb2MgdmVyYmF0aW0uIFRoaXMgaXMganVzdCBub3QN
Cj4gPiA+IHRoZSB3YXkgdGhpbmdzIGFyZSBzdXBwb3NlZCB0byBiZSBkb25lIHVwc3RyZWFtLiBX
ZSBzaGFyZSBkZWZpbmVzIGFuZA0KPiA+ID4gaW1wbGVtZW50YXRpb25zIGFsbCB0aGUgdGltZSwg
YnV0IHdlIHNob3VsZCBub3QgYmUgbWFraW5nIGNvcGllcyBvZg0KPiA+ID4gdGhlbS4NCj4gPiAN
Cj4gPiAgIFdlIGhhZCBzb21lIGZpeGVzIHRvIHRoZSBrZXJuZWwgZG9jIGFzIGl0J3MgaW5jb3Jy
ZWN0IGRlc2NyaXB0aW9uLg0KPiA+ICAgUGVyaGFwcyB3ZSBjYW4gZnVsbHkgcmV3cml0ZSB0aGUg
a2VybmVsLWRvYyBpZiB0aGF0IHdoYXQgbWFrZXMgaXQNCj4gPiAgIGJldHRlci4gV2UgY2FuIHNo
YXJlIGRlZmluZSBpbXBsZW1lbnRhdGlvbnMgaWYgdGhleSBhcmUgbWVhbnQgdG8gYmUNCj4gPiAg
IHNoYXJlZC4gSG93ZXZlciwgd2l0aCB0aGUgY3VycmVudCB3YXkgeGhjaSBoZWFkZXIgaXMgaW1w
bGVtZW50ZWQsIGl0J3MNCj4gPiAgIG5vdCBtZWFudCB0byBiZSBzaGFyZWQgd2l0aCBkd2MzLiBZ
b3UgYWdyZWVkIHRoYXQgd2UgYXJlIHZpb2xhdGluZyB0aGlzDQo+ID4gICBpbiBzb21lIGRyaXZl
ciwgYnV0IHlvdSdyZSBhbHNvIGluc2lzdGVudCB0aGF0IHdlIHNob3VsZCBub3QgZHVwbGljYXRl
DQo+ID4gICB0aGUgbG9naWMgdG8gYXZvaWQgdGhpcyB2aW9sYXRpb24uIFBlcmhhcHMgSSdtIG5v
dCBhIG1haW50YWluZXIgaGVyZQ0KPiA+ICAgbG9uZyBlbm91Z2ggdG8ga25vdyBzb21lIHZpb2xh
dGlvbiBpcyBiZXR0ZXIga2VwdC4gSWYgc2hhcmluZyB0aGUgeGhjaQ0KPiA+ICAgaGVhZGVyIGlz
IHdoYXQgaXQgdGFrZXMgdG8gZ2V0IHRoaXMgdGhyb3VnaCwgdGhlbiBmaW5lLg0KPiA+IA0KPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gVGhlIGFsdGVybmF0aXZlIHRo
YXQgYXZvaWRzIHRoaXMgaXNzdWUgZW50aXJlbHkgY291bGQgaW5kZWVkIGJlIHRvDQo+ID4gPiA+
ID4gPiA+ID4gc2ltcGx5IGNvdW50IHRoZSBudW1iZXIgb2YgUEhZcyBkZXNjcmliZWQgaW4gRFQg
YXMgUm9iIGluaXRpYWxseQ0KPiA+ID4gPiA+ID4gPiA+IHN1Z2dlc3RlZC4gV2h5IHdvdWxkIHRo
YXQgbm90IHdvcms/DQo+ID4gPiA+IA0KPiA+ID4gPiBTZWUgYmVsb3cuDQo+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGUgcmVhc29uIHdoeSBJIGRpZG4ndCB3YW50
IHRvIHJlYWQgdGhlIFBoeSdzIGZyb20gRFQgaXMgZXhwbGFpbmVkIGluDQo+ID4gPiA+ID4gPiA+
IFsxXS4gSSBmZWx0IGl0IG1ha2VzIHRoZSBjb2RlIHVucmVhZGFibGUgYW5kIGl0cyB2ZXJ5IHRy
aWNreSB0byByZWFkIHRoZQ0KPiA+ID4gPiA+ID4gPiBwaHkncyBwcm9wZXJseSwgc28gd2UgZGVj
aWRlZCB3ZSB3b3VsZCBpbml0aWFsaXplIHBoeSdzIGZvciBhbGwgcG9ydHMNCj4gPiA+ID4gPiA+
ID4gYW5kIGlmIGEgcGh5IGlzIG1pc3NpbmcgaW4gRFQsIHRoZSBjb3JyZXNwb25kaW5nIG1lbWJl
ciBpbg0KPiA+ID4gPiA+ID4gPiBkd2MtPnVzYlhfZ2VuZXJpY19waHlbXSB3b3VsZCBiZSBOVUxM
IGFuZCBhbnkgcGh5IG9wIG9uIGl0IHdvdWxkIGJlIGEgTk9QLg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBUaGF0IGRvZXNuJ3Qgc291bmQgdG9vIGNvbnZpbmNpbmcuIENhbid0IHlvdSBqdXN0
IGl0ZXJhdGUgb3ZlciB0aGUgUEhZcw0KPiA+ID4gPiA+ID4gZGVzY3JpYmVkIGluIERUIGFuZCBk
ZXRlcm1pbmUgdGhlIG1heGltdW0gcG9ydCBudW1iZXIgdXNlZCBmb3IgSFMgYW5kDQo+ID4gPiA+
ID4gPiBTUz8NCj4gPiA+ID4gPiA+ID4gQWxzbyBhcyBwZXIgS3J6eXN6dG9mIHN1Z2dlc3Rpb24g
b24gWzJdLCB3ZSBjYW4gYWRkIGEgY29tcGF0aWJsZSB0byByZWFkDQo+ID4gPiA+ID4gPiA+IG51
bWJlciBvZiBwaHkncyAvIHBvcnRzIHByZXNlbnQuIFRoaXMgYXZvaWRzIGFjY2Vzc2luZyB4aGNp
IG1lbWJlcnMNCj4gPiA+ID4gPiA+ID4gYXRsZWFzdCBpbiBkcml2ZXIgY29yZS4gQnV0IHRoZSBs
YXllcmluZyB2aW9sYXRpb25zIHdvdWxkIHN0aWxsIGJlIHByZXNlbnQuDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+IFllcywgYnV0IGlmIHRoZSBpbmZvcm1hdGlvbiBpcyBhbHJlYWR5IGF2YWls
YWJsZSBpbiBEVCBpdCdzIGJldHRlciB0byB1c2UNCj4gPiA+ID4gPiA+IGl0IHJhdGhlciB0aGFu
IHJlLWVuY29kZSBpdCBpbiB0aGUgZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiA+ID4gICAgQXJlIHlv
dSBzdWdnZXN0aW5nIHRoYXQgd2UganVzdCBkbyBzb21ldGhpbmcgbGlrZQ0KPiA+ID4gPiA+IG51
bV9wb3J0cyA9IG1heCggaGlnaGVzdCB1c2IyIHBvcnRudW0sIGhpZ2hlc3QgdXNiMyBwb3J0IG51
bSkNCj4gPiA+ID4gDQo+ID4gPiA+IFdoeSBkbyB3ZSB3YW50IHRvIGRvIHRoaXM/IFRoaXMgbWFr
ZXMgbnVtX3BvcnRzIGFtYmlndW91cy4gTGV0J3Mgbm90DQo+ID4gPiA+IHNhY3JpZmljZSBjbGFy
aXR5IGZvciBzb21lIGxpbmVzIG9mIGNvZGUuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgbm90IGFi
b3V0IGxpbmVzIG9mIGNvZGUsIGJ1dCBhdm9pZGluZyB0aGUgYmFkIHByYWN0aWNlIG9mDQo+ID4g
PiBjb3B5aW5nIGNvZGUgYXJvdW5kIGFuZCwgdG8gc29tZSBkZWdyZWUsIG1haW50YWluaW5nIHRo
ZSBzZXBhcmF0aW9uDQo+ID4gPiBiZXR3ZWVuIHRoZSBnbHVlLCBjb3JlLCBhbmQgeGhjaSB3aGlj
aCBGZWxpcGUgKHBlcmhhcHMgbWlzdGFraW5nbHkpIGhhcw0KPiA+ID4gZm91Z2h0IGZvci4NCj4g
PiANCj4gPiBXZSdyZSB0YWxraW5nIGFib3V0IGNvbWJpbmluZyBudW1fdXNiM19wb3J0cyBhbmQg
bnVtX3VzYjJfcG9ydHMgaGVyZSwNCj4gPiB3aGF0IGRvZXMgdGhhdCBoYXZlIHRvIGRvIHdpdGgg
bGF5ZXIgc2VwYXJhdGlvbj8NCj4gPiANCj4gPiA+IA0KPiA+ID4gSWYgeW91IGp1c3QgbmVlZCB0
byBrbm93IGhvdyBtYW55IFBIWXMgeW91IGhhdmUgaW4gRFQgc28gdGhhdCB5b3UgY2FuDQo+ID4g
PiBpdGVyYXRlIG92ZXIgdGhhdCBpbnRlcm5hbCBhcnJheSwgeW91IGNhbiBqdXN0IGxvb2sgYXQg
dGhlIG1heCBpbmRleCBpbg0KPiA+ID4gRFQgd2hlcmUgdGhlIGluZGV4ZXMgYXJlIHNwZWNpZmll
ZCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4gPiANCj4gPiA+IERvbid0IGdldCBodW5nIHVwIG9u
IHRoZSBjdXJyZW50IHZhcmlhYmxlIG5hbWVzLCB0aG9zZSBjYW4gYmUgcmVuYW1lZCB0bw0KPiA+
ID4gbWF0Y2ggdGhlIGltcGxlbWVudGF0aW9uLiBDYWxsIGl0IG1heF9wb3J0cyBvciB3aGF0ZXZl
ci4NCj4gPiANCj4gPiBJdCBkb2Vzbid0IG1hdHRlciB3aGF0IHZhcmlhYmxlIG5hbWUgaXMgZ2l2
ZW4sIGl0IGRvZXNuJ3QgY2hhbmdlIHRoZQ0KPiA+IGZhY3QgdGhhdCB0aGlzICJudW1fcG9ydHMi
IG9yICJtYXhfcG9ydHMiIG9iZnVzY2F0ZWQgdXNiMiB2cyB1c2IzIHBvcnRzDQo+ID4ganVzdCBm
b3IgdGhpcyBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbi4gU28sIGRvbid0IGRvIHRoYXQuDQo+ID4g
DQo+ID4gPiANCj4gPiA+ID4gPiBJZiBzbywgaW5jYXNlIHRoZSB1c2IyIHBoeSBvZiBxdWFkIHBv
cnQgY29udHJvbGxlciBpcyBtaXNzaW5nIGluIERULCB3ZQ0KPiA+ID4gPiA+IHdvdWxkIHN0aWxs
IHJlYWQgbnVtX3VzYjJfcG9ydHMgYXMgNCBidXQgdGhlIHVzYjJfZ2VuZXJpY19waHlbMV0gd291
bGQgYmUNCj4gPiA+ID4gPiBOVUxMIGFuZCBhbnkgcGh5IG9wcyB3b3VsZCBzdGlsbCBiZSBOT1Au
IEJ1dCB3ZSB3b3VsZCBiZSBnZXR0aW5nIHJpZCBvZg0KPiA+ID4gPiA+IHJlYWRpbmcgdGhlIHho
Y2kgcmVnaXN0ZXJzIGNvbXBlbHRlbHkgaW4gY29yZSBkcml2ZXIuDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gVGhpbmgsIEJqb3JuLCBjYW4geW91IGFsc28gbGV0IHVzIGtub3cgeW91ciB2aWV3cyBv
biB0aGlzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IDEuIFJlYWQ6DQo+ID4gPiA+ID4gICAgbnVt
X3VzYjNfcG9ydHMgPSBoaWdoZXN0IHVzYjMgcG9ydCBpbmRleCBpbiBEVA0KPiA+ID4gPiA+ICAg
IG51bV91c2IyX3BvcnRzID0gbWF4KCBoaWdoZXN0IHVzYjIgcG9ydCBpbmRleCwgbnVtX3VzYjNf
cG9ydHMpDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gMi4gUmVhZCB0aGUgc2FtZSBieSBwYXJzaW5n
IHhoY2kgcmVnaXN0ZXJzIGFzIGRvbmUgaW4gcmVjZW50IHZlcnNpb25zIG9mDQo+ID4gPiA+ID4g
dGhpcyBzZXJpZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBEVCBpcyBub3QgcmVsaWFibGUgdG8gZ2V0
IHRoaXMgaW5mby4gQXMgbm90ZWQsIHRoZSBEVCBtYXkgc2tpcCBzb21lDQo+ID4gPiA+IHBvcnRz
IGFuZCBzdGlsbCBiZSBmaW5lLiBIb3dldmVyLCB0aGUgZHJpdmVyIGRvZXNuJ3Qga25vdyB3aGlj
aCBwb3J0DQo+ID4gPiA+IHJlZmxlY3RzIHdoaWNoIHBvcnQgY29uZmlnIGluZGV4IHdpdGhvdXQg
dGhlIGV4YWN0IHBvcnQgY291bnQuDQo+ID4gPiANCj4gPiA+IFRoYXQncyBub3QgY29ycmVjdC4g
RFQgcHJvdmlkZXMgdGhlIHBvcnQgaW5kZXhlcyBhbHJlYWR5LCBmb3IgZXhhbXBsZToNCj4gPiA+
IA0KPiA+ID4gCXBoeS1uYW1lcyA9ICJ1c2IyLXBvcnQwIiwgInVzYjMtcG9ydDAiLA0KPiA+ID4g
CQkgICAgInVzYjItcG9ydDEiLCAidXNiMy1wb3J0MSIsDQo+ID4gPiAJCSAgICAidXNiMi1wb3J0
MiIsDQo+ID4gPiAJCSAgICAidXNiMi1wb3J0MyI7DQo+ID4gPiANCj4gPiA+IFNvIGlmIHlvdSBq
dXN0IG5lZWQgdGhpcyB0byBpdGVyYXRlIG92ZXIgdGhlIFBIWXMgYWxsIHRoZSBpbmZvcm1hdGlv
bg0KPiA+ID4gbmVlZGVkIGlzIGhlcmUuDQo+ID4gPiANCj4gPiA+IElmIHlvdSBuZWVkIHRvIGFj
Y2VzcyBwb3J0cyB3aGljaCBkbyBub3QgaGF2ZSBhIFBIWSBkZXNjcmliZWQgaW4gRFQsDQo+ID4g
PiB0aGVuIHRoaXMgaXMgbm90IGdvaW5nIHRvIHN1ZmZpY2UsIGJ1dCBJIGhhdmUgbm90IHNlZW4g
YW55b25lIGNsYWltIHRoYXQNCj4gPiA+IHRoYXQgaXMgbmVlZGVkIHlldC4NCj4gPiANCj4gPiBQ
ZXJoYXBzIEkgbWlzdW5kZXJzdGFuZCB0aGUgY29udmVyc2F0aW9uLiBIb3dldmVyLCB0aGVyZSBp
c24ndCBhIG1ldGhvZA0KPiA+IHRoYXQgZXZlcnlvbmUncyBhZ3JlZSBvbiB5ZXQgcmVnYXJkaW5n
IERUIFsqXS4gUGVyaGFwcyB0aGlzIGluZGljYXRlcyBpdA0KPiA+IG1heSBub3QgYmUgdGhlIGJl
c3QgYXBwcm9hY2guIFlvdSBjYW4gcmVzdW1lIHRoZSBjb252ZXJzYXRpb24gaWYgeW91DQo+ID4g
d2FudCB0bzoNCj4gPiANCj4gPiBbKl0gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi85NjcxY2FkZS0xODIwLTIyZTEtOWRiOS01Yzk4
MzY0MTQ5MDhAcXVpY2luYy5jb20vKnRfXztJdyEhQTRGMlI5R19wZyFZTmI3NnB3a2lOdW5uVkdX
ZnBNMzNMbUNUSlFOTDd6UFJvb0lJeWdBNXJzVXprUEdnbHlyc2o1U0xDeTJyYXFrcXd0aml6ZDVq
czJ3Sl9PQVAxUHAwTjZtTjRteU1nJA0KPiA+IA0KPiA+ID4gPiBNb3JlIGltcG9ydGFudGx5LCB0
aGUgaG9zdCBjb250cm9sbGVyIHRoYXQgbGl2ZXMgb24gdGhlIFBDSSBidXMgd2lsbCBub3QNCj4g
PiA+ID4gdXNlIERULiBUaGlzIGNhbiBiZSB1c2VmdWwgZm9yIHNvbWUgcmUtY29uZmlndXJhdGlv
bnMgaWYgdGhlIGNvbnRyb2xsZXINCj4gPiA+ID4gaXMgYSBQQ0kgZGV2aWNlIGFuZCB0aGF0IGdv
ZXMgdGhyb3VnaCB0aGUgZHdjMyBjb2RlIHBhdGguDQo+ID4gPiANCj4gPiA+IE9rLCB0aGlzIGlz
IGEgYml0IGhhbmQgd2F2eSwgYnV0IGlmIHRoaXMgZXZlciB0dXJucyBvdXQgdG8gYmUgbmVlZGVk
IGl0DQo+ID4gPiBjYW4gYWxzbyBiZSBpbXBsZW1lbnRlZCB0aGVuLg0KPiA+IA0KPiA+IFdoYXQg
ZG9lcyBoYW5kIHdhdnkgbWVhbj8gV2UgaGF2ZSBjYXNlIHdoZXJlIGl0J3MgdXNlZnVsIG91dHNp
ZGUgb2YNCj4gPiB0aGlzLCBhbmQgaXQgd291bGQgYmUgdXNlZnVsIGZvciBQQ0kgZGV2aWNlIHRv
bzoNCj4gPiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtdXNiLzIwMjMwNTE3MjMzMjE4LnJqZm12cHRyZXhna3BhbTNAc3lub3Bz
eXMuY29tL19fOyEhQTRGMlI5R19wZyFZTmI3NnB3a2lOdW5uVkdXZnBNMzNMbUNUSlFOTDd6UFJv
b0lJeWdBNXJzVXprUEdnbHlyc2o1U0xDeTJyYXFrcXd0aml6ZDVqczJ3Sl9PQVAxUHAwTjRDSlBG
N2NRJA0KPiA+IA0KPiA+ID4gDQo+ID4gPiBPciBqdXN0IGdlbmVyYWxpc2UgdGhlIHhoY2kgaW1w
bGVtZW50YXRpb24gZm9yIHBhcnNpbmcgdGhlc2UgcmVnaXN0ZXJzDQo+ID4gPiBhbmQgcmV1c2Ug
dGhhdCBmcm9tIHRoZSBzdGFydC4gKEFzIGEgYm9udXMgeW91J2Qgc2hyaW5rIHRoZSBrZXJuZWwg
dGV4dA0KPiA+ID4gc2l6ZSBieSBnZXR0aW5nIHJpZCBvZiB0aGF0IGlmZnkgaW5saW5lIGltcGxl
bWVudGF0aW9uLikNCj4gPiA+IA0KPiA+IA0KPiA+IEkgZG9uJ3QgbGlrZSB0aGUgaWZmeSBpbmxp
bmUgZnVuY3Rpb24gZWl0aGVyLiBXZSBjaGFuZ2VkIHRoYXQgaGVyZS4gVG8NCj4gPiByZXdvcmsg
dGhlIHhoY2kgaGVhZGVyIGFuZCBkZWZpbmUgaXRzIGdsb2JhbCBoZWFkZXIgc2VlbXMgYSBiaXQN
Cj4gPiBleGNlc3NpdmUganVzdCBmb3IgZHdjMyB0byBnZXQgdGhlIHBvcnQgY2FwYWJpbGl0eS4g
UmVnYXJkbGVzcywgYXMgSSd2ZQ0KPiA+IHNhaWQsIGlmIHdlIF9tdXN0XywgcGVyaGFwcyB3ZSBj
YW4ganVzdCBpbXBvcnQgeGhjaS1leHQtY2Fwcy5oIGluc3RlYWQNCj4gPiBvZiB0aGUgd2hvbGUg
eGhjaS5oLg0KPiANCj4gSGkgVGhpbmgsIEpvaGFuLA0KPiANCj4gIEhvdyBhYm91dCB3ZSBhZGQg
Y29tcGF0aWJsZSBkYXRhIGluZGljYXRpbmcgdGhlIG51bWJlciBvZiB1c2IyL3VzYjMgcG9ydHMu
DQo+IFRoYXQgd2F5IHdlIG5lZWRuJ3QgcGFyc2UgdGhlIERUIG9yIHJlYWQgeGhjaSByZWdpc3Rl
cnMgYXRsZWFzdCBhcyBhDQo+IHRlbXBvcmFyeSBzb2x1dGlvbiB0byB1bmJsb2NrIG90aGVyIHBh
dGNoZXMuIE9uY2UgdGhpcyBzZXJpZXMgaXMgbWVyZ2VkLCB3ZQ0KPiBjYW4gZ2V0IGJhY2sgdG8g
Zml4aW5nIHRoZSBwb3J0IGNvdW50IGNhbGN1bGF0aW9uLiBEb2VzIGl0IHNlZW0gZmluZSA/DQo+
IA0KDQpUZW1wb3Jhcnkgc29sdXRpb24gc2hvdWxkIG5vdCBpbnZvbHZlIERUIGFzIGl0J3Mgbm90
IGVhc2lseSByZXZlcnRlZCBvcg0KY2hhbmdlZC4gSnVzdCBpbmNsdWRlIHhoY2ktZXh0LWNhcHMu
aCBhbmQgdXNlIHRoZSBpbmxpbmUgZnVuY3Rpb24uIEkNCnRoaW5rIEpvaGFuIGlzIGZpbmUgd2l0
aCB0aGF0LiBJZiBub3QsIGhlIGNhbiBwcm92aWRlIG1vcmUgZmVlZGJhY2suDQoNClRoYW5rcywN
ClRoaW5o

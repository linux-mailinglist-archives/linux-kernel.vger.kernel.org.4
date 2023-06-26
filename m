Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7F73EF59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFZXfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 19:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZXfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:35:04 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF172198C;
        Mon, 26 Jun 2023 16:35:02 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QNArGN001502;
        Mon, 26 Jun 2023 16:34:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=wVDLmKFPI0WOph3yebaiJCvmYl27FklNzgalmWMpbNU=;
 b=v/kZ+485DmQXs3Gp/2o1GLszgYJSdS6uRAAKIPm8EDnZoQvOk224qHVQfXxdSpy8KX5E
 AM6R1AH7V8NogQSrfzLRVIoE9k3rxmr2KQjGxkkafRf6bZ3ikP4nM2IC8TNESN7w0dln
 1LhWzKUDlVu1ov9bnVWLCEwKZ4MLBFmuTXWBdETQdrX/Rm5h2xs76DKNOzMquy3d7VtO
 T/qpZHu1zGcklPPz7P1gCQO8GDzWJZaYnQxQco772AGHD+p9MdWulbY7V6nIgTrA1VBw
 GuwiJHaXf077+1GTVk9x8ox0MfgcCabWgUuXkGy5+FoJXTiA2uhN5szO4+uPp7Guq+Io BA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3rdy4e3eh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jun 2023 16:34:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1687822478; bh=wVDLmKFPI0WOph3yebaiJCvmYl27FklNzgalmWMpbNU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EqJTqKMK7zM37QZd7G32SyUz4F0Cfagj/8J6XAdwkiskhEOyOwhCMJpDvClqVG1oq
         GcVI8wvx3Qb2H3pViCRTVRqOooV4LNsOluAMW+L+XK/Np63ogfvNZTzPg4+5G4D0w+
         fQjo3+l0xz9PDchB2+E/l+xLbSRM81vDjMEae3EholvdCKQySPKtSNipT7eC5LW76R
         D0YHpsxilcBawFo8zEPj6BP8LQLzqlzfNnwbEe7EWSLEkN8TXVeNm3UTMiyj5VuY2J
         6a+H3k0WH7r+h6gOiIUbiiDlD/P+o5InbXaKQOBrurK9aIns9NKlnmbCkFzbRnQw7s
         MiQ5Izpw2x3WA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2980840138;
        Mon, 26 Jun 2023 23:34:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D12FEA007F;
        Mon, 26 Jun 2023 23:34:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NN4a+t0u;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3A3E040407;
        Mon, 26 Jun 2023 23:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA1gHffeSwUfvwzCZW9DaXRWrlbD8wXt0q5PGs3c3B9wD0iT23xOiwIuFA7NR+Z/aI6OxXU4MMh+6ajEzJMDHGbgExXOyZ8EEAq4WDOFOAPWreKyrMvWp9wlxb+feQKDWKK+qkxT0QPi+TMxSrmhkmzdzt84+z6PbdJns98K+POdjpkqKLV1vxt9r73APnseZwKkjJlvL4xVW4/DWVJ1VrWCBlLsPAxVnqmLAYgF8DcLSRkzK6hnCZtbXGtsql5WvMdmXI/KcmsCYIDEx869uPNLwRAm5irKwCGxsQswLeQK6lYg3nmgtzVWfIRuwXwSdT4eaRupthYWBxO7rEQduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVDLmKFPI0WOph3yebaiJCvmYl27FklNzgalmWMpbNU=;
 b=UZHiwO3RqefVczQm12RhyVwMgVzGYecniUKpCabNcVM9mPJPAcKa2IwTi8nZYjmbPHq1E86CpLd1Oxvs2nx3Rq5Jm0z8pngQNg3QcbKguEUYcLU3cwZ+XoOy7MXJvYJlW1Xxnx6FgzqzazqNFA9WOVZZ+2kSWfJJxps0Iz6aZzoFMrNDf64SGs2k3QfrRiGLCFphlPhUurBwIQkYCsy3q3S1bt/lFapxG4aGS6s/ZsNNb9Z5QrWnnXYuGGoUBmtjLa+zCySfXI97fMxqg4GQEmnCjHiav1us6bIN5/4gY4mjxeh8Cz9JOeMk1gOgeUlaGPF7scSizg2W8p+TkT3Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVDLmKFPI0WOph3yebaiJCvmYl27FklNzgalmWMpbNU=;
 b=NN4a+t0uSKPoFydzL2N3dpE3lttB1CAcyt0kBrrTlhmuOYTQIOwKCxD+xs7FLnUvibWlQiD71kZS2fXRorKVKaSVtz9yrWKhqBQkqiOvctOtMhlg4ql2awUmEm/GeDu+7EXMWqKK9opllrAuANKSaj7Rss3jyAwKHGR5qBcGjZ8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 23:34:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::b1a4:d803:b2ff:cc6b%3]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 23:34:29 +0000
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
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Topic: [PATCH v9 04/10] usb: dwc3: core: Skip setting event buffers for
 host only controllers
Thread-Index: AQHZo/oUWyyJ3lQGykedS+ST62GFCK+Y+/MAgACUuQCABDTaAA==
Date:   Mon, 26 Jun 2023 23:34:28 +0000
Message-ID: <20230626233424.2flncnsvfzb2ccbt@synopsys.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-5-quic_kriskura@quicinc.com>
 <20230623222754.auuce7y6c2e7ymvw@synopsys.com>
 <19932a93-4fc8-f177-8cd6-b6ecd5e163c2@quicinc.com>
In-Reply-To: <19932a93-4fc8-f177-8cd6-b6ecd5e163c2@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4143:EE_
x-ms-office365-filtering-correlation-id: c7cc217a-a593-4032-af8b-08db769de2c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vQ+IXSiIltid9PN+C7i9rD1ugydBCG9v4P/4vKRfi8fXY2ku8fF2WftshaeChGxrG6+rD/cDiO8VzjsEyqtpnclRaqpu581pwGpU0zXyWoQQZpgt9Hqsp6A51R95BQibSO6+03HClShE/XI+RlV9EzaRFb0j6TcIwTz9WQIRv0zglXN709kHU6tdWM6kddkLRL7MfR9wJViwseTtFWNuc0BTq84Z8TWM7FQXjQgKV1lbU0EChk+ylVAGQOsrOJsda8LPtNR8YpI1A0N/SHJIXW3IyeVBSFH2UOtJHitYXcdAHBqVtMa0uDLGcCwg6ZUfMAVySsM2qCUxgXgYLmOI+NbAgHE63anJyhIWjGnOr1k61ROfOneE4h2jmU7lJtVsUGAbmQm3K4NZGJcPkP0V4xFCqbgoqOsjbUUkArYCB+wwKM27QlrU8bRx0EgtzQfE/SV0LaBY5TaTrMlb2JSrEbA7Ql5nPU+p5TXgqcS24vYFSJogNS05c52hYGp+IQn5bsFSkgH1IWSHBSaExUe+0EBPyV8TlPuHRL1YjeNAOaxIWqCyXvsJj9sdk5Rfs2K9/lB3SWAMPLUuYnyoAYSfv3HnmI6fYUvgEuPvjuk6N+t9VsW3v0vW83Qv/0LEaTE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(83380400001)(6486002)(478600001)(54906003)(1076003)(53546011)(6512007)(66556008)(66946007)(2906002)(6506007)(26005)(186003)(66476007)(64756008)(71200400001)(66446008)(316002)(7416002)(41300700001)(76116006)(5660300002)(38100700002)(8676002)(8936002)(36756003)(122000001)(4326008)(6916009)(86362001)(38070700005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjEvNXN6Zk05dTZxWXAyVzQ0MGZqSDFoQUt2Z0diN1E0SnVOVkJGTCtVcUFy?=
 =?utf-8?B?eEVnSlFMRDhjSC9UZXlDTGxEMHlFNG9jQmt0NktvREkyYjhJMmhjVFJ4a3dJ?=
 =?utf-8?B?Q3duSFJSR2d1K09Wb29JcXFIaS9aL2wwZmdWeGFVUHh2eDlUWE9sQVVQYUxn?=
 =?utf-8?B?QnovS0pWWVR0REpHdWkyWnpjRy9qZWxHOXd0RUtpL2ZDWmRNKzVWUUE4MHBy?=
 =?utf-8?B?N0tONllQZkl3ZVphL2x4RHVJSmIxUE8xV0hZYTRscTluRWVJaGtZRi93UDlZ?=
 =?utf-8?B?VTdRUjc5UzM1amdqRVIwa2NwNHdyallZMTduVko4YmZoc1VuLy90QUp3b09K?=
 =?utf-8?B?cFpOK3ErcXltV05DczBmU0Npa0gvS1dQdFdJZE10ZU9iNVdtUThFUmNIYnl1?=
 =?utf-8?B?ei9Yck5rYndTQUdSWUxSTG1EYkJ3K0QyekF2Mk5oYStqNGo2Qm9FZGwxZFVX?=
 =?utf-8?B?L0N6QzRHcUorMGlaT09IQ2ZUSXVZekFuVGcyRGs1WFIrRlgzYU1rQzJFOEhK?=
 =?utf-8?B?aFZhVjlRbGxpS2dISlpaWFBPb3hkZFJ3cExzNGJyRGFhMjhQVXZEWVEyTERh?=
 =?utf-8?B?NDI2b1o0b01sZUd4UDBpV0ZyZFBFYUJtWGJLZlplRHV4UFhDalNXSlFyZktt?=
 =?utf-8?B?Q0ltdElKTExjUHNWaHl2NEx6TVJrdDdtci9pK2xHWGk3bWZtTVBjOUxrbXhD?=
 =?utf-8?B?a3dnSTl1V3pTREgrMUJIVXM4R08rRkhSUUpQT3IzdlY0ZGxGcml0OURRK1A1?=
 =?utf-8?B?eFczaHRTRG9WVW8vbExLU2FhalBnMzd0czhUalBoSGQxakUrVmp2N0VkUHZa?=
 =?utf-8?B?ajh3NWRtMkI0Q1ZKbUhmMm1yaEYrREZ4UFJnZDloQmw1ZVNuU2NaaEN6b0JO?=
 =?utf-8?B?L2ZKbnVXZkVXYkZYdlJ2MnpFQ3lkbFNMTE9ZdmdqN0ZKNzFsWTJpQzN1RmZD?=
 =?utf-8?B?L1h6WXBJUUJqbHJjNEgrVGdjak95eGdJSWRjZThndDhNb0tTNStWZHdkcUlZ?=
 =?utf-8?B?bVNPWDhrYTMrQmlxTDJ5UittdmVIcTVGY2diSFlCNFRmRkdHR1VrUVhHY0ZU?=
 =?utf-8?B?U2Joblh3dEhHckMwTklVU29FcTlLOSs2VmdyNXkwZE1MLzNxbVZWeUpkWTgz?=
 =?utf-8?B?RGwzRlRjMDBCaWVSTU5lYXAyanVJTUplR2QvdkRnaDMxREh0RitjdDkySVBh?=
 =?utf-8?B?ZEc5dkJZdzJYSnZqN1JDTlM2eDdHcTFuZ01CREtEVmdiWW5kR2x6NUxEVjA1?=
 =?utf-8?B?QmYzQVphZ2VrZVR0akpTdHZkbytGMFJLSkowc3VTSHFDWmptVmdSOS9rY1Fa?=
 =?utf-8?B?cXZhMDV1dytBelcySHVqdlR0OFUrNkV4ck83TWtVZ3BhR1Z1dFB2T3JpUU1C?=
 =?utf-8?B?OEw5R1l2N1JoWFB3Nm1MN0tkRC9OMnQ0bnBMV3M5QUVobHNzbC9MSm9OU0hz?=
 =?utf-8?B?RVdRSGJidHA0dGpjZ2F6SjZhUGx1WXBBM1NRRkNIRHo4QW5BREZFSlRjaWRN?=
 =?utf-8?B?eDlKVnRwMEJxL2grV0dYQ1V4bC94NGsyczdRSmNtUkdRb3Uxam9Qdkt3ZHNy?=
 =?utf-8?B?RndzTTJIelNNeW1vQzVZMVVkdS9VK09mckZLMnorWVZ5ZWhKdDhoQUtLWGx4?=
 =?utf-8?B?b1REQWRTdHZsK2VQNXk0Tm5RTTJ5NjltSGxXaG9RdXhtQXVyS1pEeDRNY1FK?=
 =?utf-8?B?RGphOU1sTmhnVWRxdXRkdnNYakcveDRSRnlTaFZNaXkyUDh5c3pDeGljOFVR?=
 =?utf-8?B?bWM2c0RUaVo3TDJTZGFJZTBwTnlLZWJTcTZVTnQrMWVHczQ5NkVzRXlPTHoy?=
 =?utf-8?B?M1ZQRzhrL2FlbEc5OU1ZcTJWZmNSeE8wdFJnWk9DSEt6em9SNEFsYi80emJW?=
 =?utf-8?B?RXJhdk45dkI3YkVLMjJMaGpuWk95bjZZZ1BJRFBjZ1NPMEh6VzA2YkFSZVpw?=
 =?utf-8?B?SElQZnRQU0haN2NEbGo2dGkrRmJVdDB0UHdJWGsyUS9vN3R0emJwTVJiblJ6?=
 =?utf-8?B?NW1uNmVCdy93QkJ0ek1JZHlaTHZQSmZpRWQzNGFXSXVKV3FYazE4eWNiMFBn?=
 =?utf-8?B?TGlMd3QzN24vaW54NHNielNhMStFM1pZWEVDY0RraEdFbzBvWFhYVnJkS3Ba?=
 =?utf-8?Q?mcYSPMbQileGLGf1pUyK8IPBS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A80C4F169384E4CB0D3338428010344@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S09FVFhjMWFoNDVFV3V2WVdnYkRtS1VidE5BNk9ubTkyTk1xM2ZGSyt3ZFU0?=
 =?utf-8?B?dmVPWDRqd1FXL3pLRjRWcWtOUFZxcUNKQjM4RkI2Wm9vclRkeXA2QlR4NTBI?=
 =?utf-8?B?alh3ZGpRRlZBRUhUdjFlOTB3VlV4eFgweTNUUSttRmswSG5vcW5NdWhwNFdp?=
 =?utf-8?B?NXNtc0J0cERhWlQwbTg0NEVLRFNBUmMvcFBXeTJFRDBFZ2tXdzRnbGR1QnJN?=
 =?utf-8?B?QnJvQm03NFdKWmZyWndhcDA3M0dJNUtGMVo3UUJXcDkwYWNHTHpsQTQxNitp?=
 =?utf-8?B?STMwWXY4WGdOTnBPeUJCa0ZNWStkVkZaUU1ycUgwSFFFYUVyMTdRd0tJNTZ0?=
 =?utf-8?B?ZGF6SmFVWXhmMVNoV3JNdUY5djMxWjNDUHZoeTVXK3hGQ05BdFFEU1E3T0d4?=
 =?utf-8?B?VWJiSk1FQld2V0U0S1lLaUZRQkZQNUxCdXZsd3YxUWxEc2tTMGpKb3paVUNr?=
 =?utf-8?B?NWR0YkxhRjJEMVBRS3ZZUWtMVjgySGRXYzBTMDlQenV5cUszT3EvczdtZTlX?=
 =?utf-8?B?S1R0MWlmcnpJYWNHeWczcTM4RHRKdG90eVRBYVoybi8vSXF2YlhGTHBmcEZ2?=
 =?utf-8?B?VnliaklyZWFIbktVZVg4bGZyUG5Va1VxKzNtdVlRNTlnbzFiRzhMR2dsb21q?=
 =?utf-8?B?eU5RUFBIYlJwUGlxODJ3ZzZZcmdkRnZEQjBiK0FzZVJuT1lJbnA2Q1RuT2Vt?=
 =?utf-8?B?MEpwS3JiSzFWS09LUVpwaXlUM3BnZmhqRHF5dUJCZ3lBSkpkOHlrTWFnc20r?=
 =?utf-8?B?RWJaR2tqaGtVWC9aeW8weXA2UDBjQUZac21Kejd3czIrWVhiTjNsV2JJMnR6?=
 =?utf-8?B?MFNWSExlckZmUG43QWFhTTFlNDZNczVJVDF0VElEd1ZRZGNkOHRPUFJlRTZF?=
 =?utf-8?B?MlFFR3QrL3BiWllaN3UyOEQ2bFBKK05OSGxnWEE2M0ZFNVRWQ05vWWNSWFNq?=
 =?utf-8?B?eGd6RmgzbDhzUHNROVFDT3BwZVU0cVNhSEpKS29EaGhxbGtURjFKOVFzR01Q?=
 =?utf-8?B?eDUzaTE2c3E1c0V6VzBSZlRsbmY5ek9ZT3dlUVQzRUFxajFqVmFMeDdjd2oy?=
 =?utf-8?B?T0pjM052a21iNVFlTFl2U1Y4RlFhMWVBTkN6TllBUmNnVHhyMDRIZUR5Rmhk?=
 =?utf-8?B?aGtOMXZpYjR0UUZvWTVnc3dpeEkwV2dLUUE0SkZtQTNvWHpQbU9GNEpoVitB?=
 =?utf-8?B?d3QxakJmRmc0TGM5UHNEQk0zcWN1a1g5d3ZtSzhSYUpwNHdXaDF4QXliNDZW?=
 =?utf-8?B?Z0tjTlpmc21UeGtsR3VETU5LOXFzbTk2dmgraGQva2FSUzBDclhoS2ZMTmhy?=
 =?utf-8?B?a0w1dU01enZiUXBhSG5GNlBWRzJuRmtHUVZwdFpNcWkvcEU1V1EzRnRXRUlG?=
 =?utf-8?B?NldML0txMmZmemc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cc217a-a593-4032-af8b-08db769de2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 23:34:28.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUp1ba7wV9XiRaLtW9TeM1KaA3N51GYaxn6n4Jkm14chEM8PP+yzy70HJAt6wcz2+bQs8oCtNB53rKBIaVC7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
X-Proofpoint-GUID: T46uW3632Lw1ebU7_uCYm3VR31HTWjOV
X-Proofpoint-ORIG-GUID: T46uW3632Lw1ebU7_uCYm3VR31HTWjOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBKdW4gMjQsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNi8yNC8yMDIzIDM6NTcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIEp1biAyMSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSB3cm90ZToNCj4gPiA+IE9uIHNvbWUg
U29DJ3MgbGlrZSBTQTgyOTVQIHdoZXJlIHRoZSB0ZXJ0aWFyeSBjb250cm9sbGVyIGlzIGhvc3Qt
b25seQ0KPiA+ID4gY2FwYWJsZSwgR0VWVEFERFJISS9MTywgR0VWVFNJWiwgR0VWVENPVU5UIHJl
Z2lzdGVycyBhcmUgbm90IGFjY2Vzc2libGUuDQo+ID4gPiBUcnlpbmcgdG8gYWNjZXNzIHRoZW0g
bGVhZHMgdG8gYSBjcmFzaC4NCj4gPiA+IA0KPiA+ID4gRm9yIERSRC9QZXJpcGhlcmFsIHN1cHBv
cnRlZCBjb250cm9sbGVycywgZXZlbnQgYnVmZmVyIHNldHVwIGlzIGRvbmUNCj4gPiA+IGFnYWlu
IGluIGdhZGdldF9wdWxsdXAuIFNraXAgc2V0dXAgb3IgY2xlYW51cCBvZiBldmVudCBidWZmZXJz
IGlmDQo+ID4gPiBjb250cm9sbGVyIGlzIGhvc3Qtb25seSBjYXBhYmxlLg0KPiA+ID4gDQo+ID4g
PiBTdWdnZXN0ZWQtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+ICAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxMSArKysrKysr
KysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYw0KPiA+ID4gaW5kZXggMzJlYzA1ZmMyNDJiLi5lMWViYWU1NDQ1NGYgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+IEBAIC00ODYsNiArNDg2LDExIEBAIHN0YXRpYyB2b2lk
IGR3YzNfZnJlZV9ldmVudF9idWZmZXJzKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4gPiAgIHN0YXRp
YyBpbnQgZHdjM19hbGxvY19ldmVudF9idWZmZXJzKHN0cnVjdCBkd2MzICpkd2MsIHVuc2lnbmVk
IGludCBsZW5ndGgpDQo+ID4gPiAgIHsNCj4gPiA+ICAgCXN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZl
ciAqZXZ0Ow0KPiA+ID4gKwl1bnNpZ25lZCBpbnQgaHdfbW9kZTsNCj4gPiA+ICsNCj4gPiA+ICsJ
aHdfbW9kZSA9IERXQzNfR0hXUEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsN
Cj4gPiA+ICsJaWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVfSE9TVCkNCj4gPiA+
ICsJCXJldHVybiAwOw0KPiA+IA0KPiA+IFRoaXMgaXMgYSBsaXR0bGUgYXdrd2FyZC4gUmV0dXJu
aW5nIDAgaGVyZSBpbmRpY2F0ZXMgdGhhdCB0aGlzIGZ1bmN0aW9uDQo+ID4gd2FzIHN1Y2Nlc3Nm
dWwsIGFuZCB0aGUgZXZlbnQgYnVmZmVycyB3ZXJlIGFsbG9jYXRlZCBiYXNlZCBvbiB0aGUNCj4g
PiBmdW5jdGlvbiBuYW1lLiBEbyB0aGlzIGNoZWNrIG91dHNpZGUgb2YgZHdjM19hbGxvY19vbmVf
ZXZlbnRfYnVmZmVyKCkNCj4gPiBhbmQgc3BlY2lmaWNhbGx5IHNldCBkd2MtPmV2X2J1ZiA9IE5V
TEwgaWYgdGhhdCdzIHRoZSBjYXNlLg0KPiA+IA0KPiBIaSBUaGluaCwNCj4gDQo+ICAgQXBvbG9n
aWVzLCBJIGRpZG4ndCB1bmRlcnN0YW5kIHRoZSBjb21tZW50IHByb3Blcmx5Lg0KPiANCj4gICBJ
IHRob3VnaHQgd2Ugd2VyZSBzdXBwb3NlZCB0byByZXR1cm4gMCBoZXJlIGlmIHdlIGZ1bGZpbGwg
dGhlIGdvYWwgb2YgdGhpcw0KPiBmdW5jdGlvbiAoYWxsb2NhdGUgaWYgd2UgYXJlIGRyZC9nYWRn
ZXQgYW5kIGRvbid0IGFsbG9jYXRlIGlmIHdlIGFyZSBob3N0DQo+IG1vZGUgb25seSkuDQoNClRo
ZSBuYW1lIG9mIHRoZSBmdW5jdGlvbiBpbXBsaWVzIHRoYXQgaXQgcmV0dXJucyAwIGlmIGl0IGFs
bG9jYXRlZCB0aGUNCmV2ZW50IGJ1ZmZlci4gSWYgdGhlcmUgYXJlIG11bHRpcGxlIGNvbmRpdGlv
bnMgdG8gdGhlIGZ1bmN0aW9uIHJldHVybmluZw0KMCBoZXJlLCB0aGVuIHdlIHNob3VsZCBkb2N1
bWVudCBpdC4NCg0KPiANCj4gICBJZiB3ZSByZXR1cm4gYSBub24gemVybyBlcnJvciBoZXJlLCBw
cm9iZSB3b3VsZCBmYWlsIGFzIHRoaXMgY2FsbCB3aWxsIGJlDQo+IGRvbmUgb25seSBmb3IgaG9z
dCBvbmx5IGNvbnRyb2xsZXJzIGR1cmluZyBwcm9iZSBhbmQgbm93aGVyZSBlbHNlLg0KPiANCj4g
ICBBcmUgeW91IHN1Z2dlc3Rpbmcgd2UgbW92ZSB0aGlzIGNoZWNrIHRvIGR3YzNfYWxsb2Nfb25l
X2V2ZW50X2J1ZmZlciBjYWxsDQo+ID8NCj4gDQo+IFJlZ2FyZHMsDQo+IEtyaXNobmEsDQo+IA0K
DQpJJ20gc3VnZ2VzdGluZyB0byBtb3ZlIHRoZSBjaGVjayB0byB0aGUgY2FsbGVyIG9mDQpkd2Mz
X2FsbG9jX29uZV9ldmVudF9idWZmZXIoKS4gU29tZXRoaW5nIGxpa2UgdGhpcyBzbyB0aGF0IGl0
J3MNCnNlbGYtZG9jdW1lbnRlZDoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCmluZGV4IDBiZWFhYjkzMmU3ZC4uYmJhODI3
OTJiZjZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCisrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQpAQCAtMTc3Myw2ICsxNzczLDcgQEAgc3RhdGljIGludCBkd2Mz
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXN0cnVjdCByZXNvdXJjZQkJ
KnJlcywgZHdjX3JlczsNCiAJdm9pZCBfX2lvbWVtCQkqcmVnczsNCiAJc3RydWN0IGR3YzMJCSpk
d2M7DQorCXVuc2lnbmVkIGludAkJaHdfbW9kZTsNCiAJaW50CQkJcmV0Ow0KIA0KIAlkd2MgPSBk
ZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmR3YyksIEdGUF9LRVJORUwpOw0KQEAgLTE4NTQsMTEg
KzE4NTUsMTYgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogDQogCXBtX3J1bnRpbWVfZm9yYmlkKGRldik7DQogDQotCXJldCA9IGR3YzNfYWxs
b2NfZXZlbnRfYnVmZmVycyhkd2MsIERXQzNfRVZFTlRfQlVGRkVSU19TSVpFKTsNCi0JaWYgKHJl
dCkgew0KLQkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBhbGxvY2F0ZSBldmVudCBidWZm
ZXJzXG4iKTsNCi0JCXJldCA9IC1FTk9NRU07DQotCQlnb3RvIGVycl9hbGxvd19ycG07DQorCWh3
X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1zLmh3cGFyYW1zMCk7DQor
CWlmIChod19tb2RlID09IERXQzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpIHsNCisJCWR3Yy0+ZXZf
YnVmID0gTlVMTDsNCisJfSBlbHNlIHsNCisJCXJldCA9IGR3YzNfYWxsb2NfZXZlbnRfYnVmZmVy
cyhkd2MsIERXQzNfRVZFTlRfQlVGRkVSU19TSVpFKTsNCisJCWlmIChyZXQpIHsNCisJCQlkZXZf
ZXJyKGR3Yy0+ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIGV2ZW50IGJ1ZmZlcnNcbiIpOw0KKwkJ
CXJldCA9IC1FTk9NRU07DQorCQkJZ290byBlcnJfYWxsb3dfcnBtOw0KKwkJfQ0KIAl9DQogDQog
CWR3Yy0+ZWRldiA9IGR3YzNfZ2V0X2V4dGNvbihkd2MpOw0KDQotLQ0KDQpUaGFua3MsDQpUaGlu
aA==

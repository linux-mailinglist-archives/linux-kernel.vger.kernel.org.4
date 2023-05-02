Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6957F6F4C59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 23:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEBVmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 17:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjEBVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 17:42:15 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8691BD3;
        Tue,  2 May 2023 14:42:13 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342INDla010124;
        Tue, 2 May 2023 14:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=cvtT0Xk/wu8k5X29eirQgnZ4EGvTh4BR5rcsMQ9+YR4=;
 b=G5dwkspsQNk6sDnnSjSXu9FLB4KnwHfr2wHP2d/pj4SwJhvY6dZL6ovm9RoDedibgg7y
 ekfb+n5xpWhBI+DK7vBWmxgxBeb4kgnp8rEOltO3v8rMuHKx49LU2FCYOg3QRYygiDHR
 OEnKn4iKW3tEvRKBLG9tMPjYqtj7Wr5Bed4WV/5UoUnTL3GdecdSUuw45EQeojypxmq8
 HHZQRs+Tyui6iAQtsNMQU8i/7GwyBRMekzyCXrZspvvSufUxMDsn9OtYpTTfqBZb2mME
 mStOb1BhXLci3NoEKB4iT4rsaWb3m+CQbQUs5acg7YFLsuWHB8yz3ffRrBEfi7zXakMB Bg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q925x6x8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:41:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683063709; bh=cvtT0Xk/wu8k5X29eirQgnZ4EGvTh4BR5rcsMQ9+YR4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k7tvpJXDAUgIQxIi2IdiK7FDIlXoFkit0KrOV8uZ1gGkz3Urw6wmeMnr/1CLQodXh
         xjokg5n9AE1S49mz2bRcE+RTArVSk4oaXS/K5c49zDr32kda093G0aw52tE+v+RjRy
         /ZoDckjb613HflB7+SbDwj1phWPR5rxQ8I+SunTTpxXTtdQBwxr3rW7CpxztTbKSGN
         To9NN+WpG6AFjMOBIL7Aucvu9BBWT3lkiV1S/891SkC2BW0mtHbzJUg8xF4GNq2Mgy
         NMAsRZ2LrJUTu4+RZs5PKxwE657hWyKSrC/5pT8Zjo0/HDokK2BeHZwI3w2X5rFTvX
         gseR9rVQl6lHw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EFBEB4045C;
        Tue,  2 May 2023 21:41:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EEF86A0070;
        Tue,  2 May 2023 21:41:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=QtKVL81t;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 96AA6404A8;
        Tue,  2 May 2023 21:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfmXL/jh4V6iVlezAGj/nVq8peRNE2ZUOfggtcqK5ugTf6JC6CT17r5Oqx1+AC46IdNoEabZcV0J/aq4iHqgRHFFD5J4hrYhfgYzZ6dRJZt+PQx3iOg6oVB2/VRExkX0Og0WPGilxhxS6hTDx2h7LgD3UvjNPuUZ+JokpdFtw/EJnTEhAiBnftwEgQCwoezDVlL/MKOBkQ8Btm89FHhQKZg2xFv6iCyuOdtrRjyQVKtbR2cZIen8U+DPeGiytdrhOCe5nuKysEwQkQQ476pT5nGekHvUciN7Mtb4RzB1e4sUsY0tz6+r7aie0vDTd4+PAbVo+ex2unZM82TGax0/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvtT0Xk/wu8k5X29eirQgnZ4EGvTh4BR5rcsMQ9+YR4=;
 b=c0ZTJ3lHMRIqbtVlsH8GjDkdKMhKeKmgXStCZj5NwZ0OhNjUZRu4ZVLKnVpG3MeJlLPt6+SfJNIitEM8vQmyXap6stfEDLIFfkDpScPN1i37UuaOqTBz5EOlx7TLahacuWlRbm0gDLRkA0Xnqeue2KkmBu27Jd4wpSAvLtasBTuI49kJlgKwHGpiIs8ixMUV/MfaLVtlmEP+Hon0esTOpQUvMgGhtQhAkMqJzQ9reLbKJYrhqgoc9VtW9CmGMH5lH8pOK3mxWxjcuJxLCrE639rNmAsx18kuvYl+xLG4JiW6IF3t1B+/W7lWJ99mLIluNvPufT1Bog7lOjkT0pnydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvtT0Xk/wu8k5X29eirQgnZ4EGvTh4BR5rcsMQ9+YR4=;
 b=QtKVL81tlNXUp5Gvq/pX/c4/+UOBtUY9fiDyAPhjEaHleQzZqo3dYkdgJ5hvMu0ZW1E7bnz3CPROgXjAam6WGPwobVCprsXm3jpegqa+YEi6MoNaUcfFxn1w1DW3tNFLBBAb4XRr1Rv+Ty6isP1Wh1Tmu1rApAQznqZ2IIiANMQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 21:41:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 21:41:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
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
Subject: Re: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZfDo86WSzaQCTUEyAS9trpGt8y69HhUWA
Date:   Tue, 2 May 2023 21:41:41 +0000
Message-ID: <20230502214133.fovxi3vfh2s6ujpz@synopsys.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-4-quic_kriskura@quicinc.com>
In-Reply-To: <20230501143445.3851-4-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: 2290eaef-a476-485a-57ad-08db4b56045b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2rAZzvZeYq/AOGstagRcNnKauz798ohF8s3eThvhhJdx2QoOyY9FsuFre/DaRUjd6G4gDNqB4vOdpzCfPNnt8kz3MJJkk4dv6vu4vg2rsi6XzbTMvhfB5iM4gC98ytBFqGU/yD1JETUZvwFAg8hDpOwH5I0Gk0b+hD5CbFOLnWasxFFx1S6uMwq7ahNIfM8u7izjgc2GSWecekfSci+/KqkRCIzrnu5QpBCm+PbW9YymPbs1i45GiIQMcXXkos7SykQBMFfOge/ceQTpg5G/5sOwb/RegSK23CX4bpIJjY9uB9k8wvun6uy8PVb9K+hR0MrHajFe1icxdT9yrE/KBVOlJyvBd87kv0k95JbcU+57dNCsUP4BwuRtQNBCyvjf60S/dRk9cE6o0/Gm8cwnvB1vkrxXgbGvGPgw1z6NhN7DPBwBV0taSgOiG8nqi6BblFZpLQU3NiwYs5AEsJAdlnT25r+KGAX9e9NeiepHLMyfmaElnJUTde+d0Z/NwDfZ24GalO11Z+7+Hlp/Im1FLch/k2BKg5tyuIeMg4ET9ZMF6JuKJgXKrCEK3G4XlpEyOnEIhSokMq6H0aW8TYNYsyInYeCucNVTLqaWcMNi6wHiGIOtf3nc4zSwrHf+Rgo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(66446008)(6916009)(2616005)(66946007)(66556008)(316002)(66476007)(41300700001)(76116006)(4326008)(64756008)(83380400001)(478600001)(6486002)(54906003)(8936002)(8676002)(38100700002)(122000001)(71200400001)(7416002)(38070700005)(5660300002)(2906002)(1076003)(6512007)(6506007)(186003)(26005)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVBFVmJnUkR2WU1QNE83OWEzeXdRRWZuVHN1ellnbW1kZ3ozajY2czFWdTUx?=
 =?utf-8?B?RlQ0SWhpUW1VNGpPZVVWYVNjL1FxNW85M055bDZrell4SlNmS09KOGZpMUkv?=
 =?utf-8?B?VjNsOFZ0eXV0a2Jnb05uWjk2NkoraStUdCtuMm0xR2NVeEF4N09rRXZPU3Ey?=
 =?utf-8?B?VHhJcmRjQWF2QnQ3dkNNeEJEZnI0Y3BFcVltL1QvZVdoUGZ1MU9BSTZzNkhG?=
 =?utf-8?B?eXE3cU5FZDd5TlBma1pZelh4VVVPUE9PU0lUQTdSVmIzU1JuREhCZHFmUkhM?=
 =?utf-8?B?ZUh1a3E1cEhFSUdJY2NEUm1PVGFrdnl0TEVUM1ovaDZvM1Z2TXJXL08rNmNy?=
 =?utf-8?B?SW1wbjhJN0dVRDQxUTZ1SFY2ZkV4MURXeVRsNWxFVmRLNDZEWHI5bXIxK01B?=
 =?utf-8?B?Ujg2TGpaUG04Unl2b3FUKzhqZlErbkRTWFFwWmQzVlcvL1pvZWJMbERJZWtR?=
 =?utf-8?B?Q0hnZi9xU2lrNDN2UGErQytYOUVqUWF1cm1vdmU3TEVmVEI4M05UdEFZV1dU?=
 =?utf-8?B?ZjhpMnA5Z2d1YzRMcFRSV2dRLzFqK0R6NU1OZjNLSW01Z2l2RktUM3hCL1ZJ?=
 =?utf-8?B?Ly9oeXFEWnZRMFJxZFhGOCt4akIvSjVJbitmWk51TStuTGk0Yi9KVUJXWWhO?=
 =?utf-8?B?OFVyMnp4Ukt6N3V0Rm9WKy91c1drSG11TmRYUTZlalp5MVFRa2hwd1RrcVBn?=
 =?utf-8?B?VGxaRG5Cc2JjbXBJckdEQ1JQb3BnaDNjREMxSU50aEdJSFBMQkhQTm92NjVi?=
 =?utf-8?B?bSsrTURwOTlQTkUrZm83blB6MTlnSitCN2EwYUxoK09QR3F0dXpJWElTakVW?=
 =?utf-8?B?UG0zL29Ca0ZPKzZFVzMxdlFvNm5aUjVJbEx2S1RaREZGOS9PRitxb1k0aVpl?=
 =?utf-8?B?a2lHSUY1QUJhSTZXVG5tUDRsTnIrcnBVUFVNR2xXb0Yxd0g0Mi9kS3gyWmNB?=
 =?utf-8?B?L2U4MS9QOWZpWEl4TTVITERYaWEvQUd2K0lXSk9hbk11eGxxRWVoY20vOWd4?=
 =?utf-8?B?eFpDV2pkeG91UlVUTjMrblhnd0dkVDBiaWRKTWZhaThleUg2aFphUFlSRFl3?=
 =?utf-8?B?RWtQbC96SGFOTzNUOWZnQnNSdlVlK21kRk1GV01XMWI4OS96ODBsTG1ycEU1?=
 =?utf-8?B?VlR1SCtwYmFheTB3d3gxcDErVUcrN0EzU3FJUXN3VmdIOEdTOHlCQlF4bTV0?=
 =?utf-8?B?V1dKZ1haU3llY3cwVHltK00wZ1dSNlpIOXE0WGhONEZISjMvUVdlSUREb3lU?=
 =?utf-8?B?VzRFSUVPMkpkd1pWK2xRS0hwa1ZwZ2hJcVFwT3Uvc210ODBpaWxXRCt6dkc5?=
 =?utf-8?B?NWdjcEZEY2p5bDFPd2NoZXp3MXpXWkFiTHJFeVRUbzJocDd6eGwrZUpnb0dl?=
 =?utf-8?B?VllDakkyVnB2R2IxbHAzam1FZzRRMTEvbURWaVg2OWxsdmNUS0g5bjR0eDBh?=
 =?utf-8?B?S1NMUWRZZ21kTFdyQ3EzRnVzemFyVlNZUWNwcW85RDVTQkNZU0JRT29zL1lm?=
 =?utf-8?B?YVJEVDVSY21JNlZRMmR4WURVVnFXMVJQNUtPN21NbjRHWVZIQmc3Qjl0S1pM?=
 =?utf-8?B?TkcrekZpSHpDdXVHaE85RFdPandENmNTakxkN3RaS1dtaXR6TDhXMHBnZlky?=
 =?utf-8?B?Zlh3cTJIekd6ZTZuTFkrN2RDZUpsb2NwaU5PQkZjT2lJdG13KzZJVVlRNjZG?=
 =?utf-8?B?RHd3NXVLYStqNXNpN1VvcGNjZ3JoSEprNTk2ZDBVRGxQUE9jSXFzSmJaaEVN?=
 =?utf-8?B?TmkrQXduck5xSldNdS9DUlkraEEyYWcxNVZoYklRNU50VmI1bUxia1ljY1NJ?=
 =?utf-8?B?bjFaNTZUY3ZHSzZaY2hOakdQNW5GeWFtNFdCdkNRMlJ6SVFDLy9ESWlZZG5H?=
 =?utf-8?B?VGRFb2ZLRXZIV3N3SlB6RHovNS84RHdQRjNhVUZNRGEyNlFoM3FsQlZKSmV2?=
 =?utf-8?B?cm9JQ2RKdVJRTlQ2akJyZU1EenJoZTRrQnpNd2xjUlBZbjN2SnJiMThzb1Yz?=
 =?utf-8?B?Y09mV1JqdTdtdGp6cjBBWUFjbDF0SXJ5VEFqUWp1d0gvMzR2Y3NOZFBzU0po?=
 =?utf-8?B?N3RSd05Ba1o1M0V3UnNsbUpFN1ZlbXl1WkN0aXo2OXZ6Z1VEWVNJUis4WitU?=
 =?utf-8?Q?9NG43JbRi+LYdRZ9FEZNLPkcJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <847F6ABB64AB6449BC9C1ED5B8B5C5CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aHp4dUhmYXkwZDlFQXdLQkdGSVkrRnk2SGtHemdlYjd3TEx4emVmQWoxc2xF?=
 =?utf-8?B?akExbmxiYk1hSGg5RjFOaFJjdjlSUXpoZ0MxUWZHZlNtaFN2VnVteWZNUTZV?=
 =?utf-8?B?aFdud0cxV3paaHlreFhuQUh0VVBuYzR5UXdDOVhUaHZZSU51TFlCWkNwcWp2?=
 =?utf-8?B?SGhQQ3k0eFY5cnlUSVpFQUVXMkFHelNLUHN3TWpXNjIvVHhndHcvQU85RVBI?=
 =?utf-8?B?YVRvaU5kcFVmV0Rpa1kvRmJ6SkZUWDc0ZWh5WjFYTGo2ek5VbmFPcTBIWm5Q?=
 =?utf-8?B?cUVWQThEK29VaDliemRxamJmeWxoOUR2WFJNaXFOdlhkMXZYM0lSUjNNSHBB?=
 =?utf-8?B?T09GQ2FZWnRJbGx1RVQrbHFuRzQrN3k2SW1wc05tbW5uK3Nmb09iZDd1RWc4?=
 =?utf-8?B?NkdPUGI1QWM1V2ZtT2hONFNUMkdoa2xtaEh3b2dtc3JKQ1Fsa1BHdmh4MjMr?=
 =?utf-8?B?M1F4aHgwalZUY0x2d2RmbzZuWHRObS91ZGk5bE5XWEpaVTh5Zkk1L0ZQNGNs?=
 =?utf-8?B?VXNnenk0MmpUZmRlS0VzTXlCbCtTbVE5WnZXRWpvV3ZHcjU1SXFLTmgya2dV?=
 =?utf-8?B?ZzY5QW11V2ZyK2ZZc2x0QVNCZTNRYm1QN1U0aVR2V3BSUHBPcmFRRzBPTXBZ?=
 =?utf-8?B?dHVOa0tCcjMyei9QN3dodXNRS3RJSkJHdnlWckJKYzk2WnRYOCs1RytsYytx?=
 =?utf-8?B?WlV1ZUZvdEVPV0VjeUI5b1prSTA5TFRlbFltQ256TUphN3JYY1B1TStha2RY?=
 =?utf-8?B?V281VSsvcDF0NitSZ3A3OFhzRGNRUTZrN1liem9YYXZRdGxFRlNZbXExVWli?=
 =?utf-8?B?NEFmLzRxVzZxTjBFcmhERmIwZFFuNS9FdkxDRkVnZUtOei9rMG50QnRpNHhU?=
 =?utf-8?B?S3l3TlhxT2s4bG9sL1hsbFY1K1EwVjF4bnZuNUZGMUszRENreGMvVkpOZmd6?=
 =?utf-8?B?QVA4ME9nd01lYkdvZGdaMkdrZURwM3A2Q1BDTkpHT3hFcy9Jd0lKMG5iNlpq?=
 =?utf-8?B?MjlrTnE4ZnE3RmpzOEhlUkhveWxRVTl2emZ0eEY3YmY2ZVBiSzhZckJFTkdh?=
 =?utf-8?B?L29rWDd0NDhzN2h1U1FESkVZOHoybEx4OW94Smpuc0FSak5qcHh4WW9mT1ky?=
 =?utf-8?B?UlIxSXBpS1RHdm1uTXFDejBvZXAzOUMyTWJZQVg0c3ZKOGVmWmpzU28yWnY4?=
 =?utf-8?B?K1dkTDBmT3gxMnJkRWUvQmhlSXhYRUovTHdOcmtCMGdtRTFodkdnNXZScFhD?=
 =?utf-8?B?Skk3c21xeUJqNDhNeVJ3RGk2ckJZMmt0T0RzNytxSlR5NEVpcm16eFhyVWFM?=
 =?utf-8?B?U1hsa0VNNEdEcjV4UTlZck1OUklwNndFcHMwQ25GZkViQ0lWVnRzM3ZWSUIy?=
 =?utf-8?B?QzFtU2JOeldDMGc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2290eaef-a476-485a-57ad-08db4b56045b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 21:41:41.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqAkk4gRHKk4uhgUYxynWwM8qkdv0MXn2YiSPKkrAyT6zGVxbVBYKbHLfg41p9IbEh6enU5HSUihMcZUTe5rZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
X-Proofpoint-GUID: ItLMZWGaaTggVIwM1WwntW-PkoBmmbr5
X-Proofpoint-ORIG-GUID: ItLMZWGaaTggVIwM1WwntW-PkoBmmbr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_12,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgTWF5IDAxLCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiBD
dXJyZW50bHkgaG9zdC1vbmx5IGNhcGFibGUgRFdDMyBjb250cm9sbGVycyBzdXBwb3J0IE11bHRp
cG9ydC4NCj4gVGVtcG9yYXJpbHkgbWFwIFhIQ0kgYWRkcmVzcyBzcGFjZSBmb3IgaG9zdC1vbmx5
IGNvbnRyb2xsZXJzIGFuZCBwYXJzZQ0KPiBYSENJIEV4dGVuZGVkIENhcGFiaWxpdGllcyByZWdp
c3RlcnMgdG8gcmVhZCBudW1iZXIgb2YgdXNiMiBwb3J0cyBhbmQNCj4gdXNiMyBwb3J0cyBwcmVz
ZW50IG9uIG11bHRpcG9ydCBjb250cm9sbGVyLiBFYWNoIFVTQiBQb3J0IGlzIGF0IGxlYXN0IEhT
DQo+IGNhcGFibGUuDQo+IA0KPiBUaGUgcG9ydCBpbmZvIGZvciB1c2IyIGFuZCB1c2IzIHBoeSBh
cmUgaWRlbnRpZmllZCBhcyBudW1fdXNiMl9wb3J0cw0KPiBhbmQgbnVtX3VzYjNfcG9ydHMuIFRo
ZSBpbnRlbnRpb24gaXMgYXMgZm9sbG93czoNCj4gDQo+IFdoZXJldmVyIHdlIG5lZWQgdG8gcGVy
Zm9ybSBwaHkgb3BlcmF0aW9ucyBsaWtlOg0KPiANCj4gTE9PUF9PVkVSX05VTUJFUl9PRl9BVkFJ
TEFCTEVfUE9SVFMoKQ0KPiB7DQo+IAlwaHlfc2V0X21vZGUoZHdjLT51c2IyX2dlbmVyaWNfcGh5
W2ldLCBQSFlfTU9ERV9VU0JfSE9TVCk7DQo+IAlwaHlfc2V0X21vZGUoZHdjLT51c2IzX2dlbmVy
aWNfcGh5W2ldLCBQSFlfTU9ERV9VU0JfSE9TVCk7DQo+IH0NCj4gDQo+IElmIG51bWJlciBvZiB1
c2IyIHBvcnRzIGlzIDMsIGxvb3AgY2FuIGdvIGZyb20gaW5kZXggMC0yIGZvcg0KPiB1c2IyX2dl
bmVyaWNfcGh5LiBJZiBudW1iZXIgb2YgdXNiMy1wb3J0cyBpcyAyLCB3ZSBkb24ndCBrbm93IGZv
ciBzdXJlLA0KPiBpZiB0aGUgZmlyc3QgMiBwb3J0cyBhcmUgU1MgY2FwYWJsZSBvciBzb21lIG90
aGVyIHBvcnRzIGxpa2UgKDIgYW5kIDMpDQo+IGFyZSBTUyBjYXBhYmxlLiBTbyBpbnN0ZWFkLCBu
dW1fdXNiMl9wb3J0cyBpcyB1c2VkIHRvIGxvb3AgYXJvdW5kIGFsbA0KPiBwaHkncyAoYm90aCBo
cyBhbmQgc3MpIGZvciBwZXJmb3JtaW5nIHBoeSBvcGVyYXRpb25zLiBJZiBhbnkNCj4gdXNiM19n
ZW5lcmljX3BoeSB0dXJucyBvdXQgdG8gYmUgTlVMTCwgcGh5IG9wZXJhdGlvbiBqdXN0IGJhaWxz
IG91dC4NCj4gDQo+IG51bV91c2IzX3BvcnRzIGlzIHVzZWQgdG8gbW9kaWZ5IEdVU0IzUElQRUNU
TCByZWdpc3RlcnMgd2hpbGUgc2V0dGluZyB1cA0KPiBwaHkncyBhcyB3ZSBuZWVkIHRvIGtub3cg
aG93IG1hbnkgU1MgY2FwYWJsZSBwb3J0cyBhcmUgdGhlcmUgZm9yIHRoaXMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oIHwgNTgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MTI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDBiZWFhYjkzMmU3ZC4uYjhh
YzdiY2VlMzkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMTc2Nyw2ICsxNzY3LDU5IEBAIHN0YXRp
YyBpbnQgZHdjM19nZXRfY2xvY2tzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJcmV0dXJuIDA7DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19yZWFkX3BvcnRfaW5mbyhzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiArew0KPiArCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ICsJdTMyCQkJb2Zmc2V0Ow0K
PiArCXUzMgkJCXRlbXA7DQo+ICsJdTgJCQltYWpvcl9yZXZpc2lvbjsNCj4gKwlpbnQJCQlyZXQg
PSAwOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBSZW1hcCB4SENJIGFkZHJlc3Mgc3BhY2UgdG8gYWNj
ZXNzIFhIQ0kgZXh0IGNhcCByZWdzLA0KPiArCSAqIHNpbmNlIGl0IGlzIG5lZWRlZCB0byBnZXQg
cG9ydCBpbmZvLg0KPiArCSAqLw0KPiArCXJlZ3MgPSBpb3JlbWFwKGR3Yy0+eGhjaV9yZXNvdXJj
ZXNbMF0uc3RhcnQsDQo+ICsJCQkJcmVzb3VyY2Vfc2l6ZSgmZHdjLT54aGNpX3Jlc291cmNlc1sw
XSkpOw0KPiArCWlmIChJU19FUlIocmVncykpDQo+ICsJCXJldHVybiBQVFJfRVJSKHJlZ3MpOw0K
PiArDQo+ICsJb2Zmc2V0ID0gZHdjM194aGNpX2ZpbmRfbmV4dF9leHRfY2FwKHJlZ3MsIDAsDQo+
ICsJCQkJCVhIQ0lfRVhUX0NBUFNfUFJPVE9DT0wpOw0KPiArCXdoaWxlIChvZmZzZXQpIHsNCj4g
KwkJdGVtcCA9IHJlYWRsKHJlZ3MgKyBvZmZzZXQpOw0KPiArCQltYWpvcl9yZXZpc2lvbiA9IFhI
Q0lfRVhUX1BPUlRfTUFKT1IodGVtcCk7DQo+ICsNCj4gKwkJdGVtcCA9IHJlYWRsKHJlZ3MgKyBv
ZmZzZXQgKyAweDA4KTsNCj4gKwkJaWYgKG1ham9yX3JldmlzaW9uID09IDB4MDMpIHsNCj4gKwkJ
CWR3Yy0+bnVtX3VzYjNfcG9ydHMgKz0gWEhDSV9FWFRfUE9SVF9DT1VOVCh0ZW1wKTsNCj4gKwkJ
fSBlbHNlIGlmIChtYWpvcl9yZXZpc2lvbiA8PSAweDAyKSB7DQo+ICsJCQlkd2MtPm51bV91c2Iy
X3BvcnRzICs9IFhIQ0lfRVhUX1BPUlRfQ09VTlQodGVtcCk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJ
CQlkZXZfZXJyKGR3Yy0+ZGV2LCAicG9ydCByZXZpc2lvbiBzZWVtcyB3cm9uZ1xuIik7DQoNCkNh
biB3ZSBwcmludCB0aGlzIGluc3RlYWQ6DQoJZGV2X2Vycihkd2MtPmRldiwgIlVucmVjb2duaXpl
ZCBwb3J0IG1ham9yIHJldmlzaW9uICVkXG4iLCBtYWpvcl9yZXZpc2lvbik7DQoNCj4gKwkJCXJl
dCA9IC1FSU5WQUw7DQo+ICsJCQlnb3RvIHVubWFwX3JlZzsNCj4gKwkJfQ0KPiArDQo+ICsJCW9m
ZnNldCA9IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcChyZWdzLCBvZmZzZXQsDQo+ICsJCQkJ
CQlYSENJX0VYVF9DQVBTX1BST1RPQ09MKTsNCj4gKwl9DQo+ICsNCj4gKwl0ZW1wID0gcmVhZGwo
cmVncyArIERXQzNfWEhDSV9IQ1NQQVJBTVMxKTsNCj4gKwlpZiAoSENTX01BWF9QT1JUUyh0ZW1w
KSAhPSAoZHdjLT5udW1fdXNiM19wb3J0cyArIGR3Yy0+bnVtX3VzYjJfcG9ydHMpKSB7DQo+ICsJ
CWRldl9lcnIoZHdjLT5kZXYsICJpbmNvbnNpc3RlbmN5IGluIHBvcnQgaW5mb1xuIik7DQoNCkNh
biB3ZSBwcmludCB0aGlzIGluc3RlYWQ6DQoJZGV2X2Vycihkd2MtPmRldiwgIk1pc21hdGNoZWQg
cmVwb3J0ZWQgTUFYUE9SVFMgKCVkKVxuIiwgSENTX01BWF9QT1JUUyh0ZW1wKSk7DQoNCj4gKwkJ
cmV0ID0gLUVJTlZBTDsNCj4gKwkJZ290byB1bm1hcF9yZWc7DQo+ICsJfQ0KPiArDQo+ICsJZGV2
X2RiZyhkd2MtPmRldiwNCj4gKwkJImhzLXBvcnRzOiAlZCBzcy1wb3J0czogJWRcbiIsIGR3Yy0+
bnVtX3VzYjJfcG9ydHMsIGR3Yy0+bnVtX3VzYjNfcG9ydHMpOw0KPiArDQo+ICt1bm1hcF9yZWc6
DQo+ICsJaW91bm1hcChyZWdzKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0
aWMgaW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4g
IAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0gJnBkZXYtPmRldjsNCj4gQEAgLTE3NzQsNiArMTgyNyw3
IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ICAJc3RydWN0IGR3YzMJCSpkd2M7DQo+ICAJaW50
CQkJcmV0Ow0KPiArCXVuc2lnbmVkIGludAkJaHdfbW9kZTsNCj4gIA0KPiAgCWR3YyA9IGRldm1f
a3phbGxvYyhkZXYsIHNpemVvZigqZHdjKSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFkd2MpDQo+
IEBAIC0xODQzLDYgKzE4OTcsMjAgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQlnb3RvIGVycl9kaXNhYmxlX2Nsa3M7DQo+ICAJfQ0K
PiAgDQo+ICsJLyoNCj4gKwkgKiBDdXJyZW50bHkgRFdDMyBjb250cm9sbGVycyB0aGF0IGFyZSBo
b3N0LW9ubHkgY2FwYWJsZQ0KPiArCSAqIHN1cHBvcnQgTXVsdGlwb3J0DQo+ICsJICovDQo+ICsJ
aHdfbW9kZSA9IERXQzNfR0hXUEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsN
Cj4gKwlpZiAoaHdfbW9kZSA9PSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9IT1NUKSB7DQo+ICsJCXJl
dCA9IGR3YzNfcmVhZF9wb3J0X2luZm8oZHdjKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWdvdG8g
ZXJyX2Rpc2FibGVfY2xrczsNCj4gKwl9IGVsc2Ugew0KPiArCQlkd2MtPm51bV91c2IyX3BvcnRz
ID0gMTsNCj4gKwkJZHdjLT5udW1fdXNiM19wb3J0cyA9IDE7DQo+ICsJfQ0KPiArDQo+ICAJc3Bp
bl9sb2NrX2luaXQoJmR3Yy0+bG9jayk7DQo+ICAJbXV0ZXhfaW5pdCgmZHdjLT5tdXRleCk7DQo+
ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gaW5kZXggZDU2NDU3YzAyOTk2Li4yMTMxMjcwM2UwNTMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+IEBAIC0zNSw2ICszNSwxNyBAQA0KPiAgDQo+ICAjZGVmaW5lIERXQzNfTVNHX01B
WAk1MDANCj4gIA0KPiArLyogRGVmaW5lIFhIQ0kgRXh0Y2FwIHJlZ2lzdGVyIG9mZnNldHMgZm9y
IGdldHRpbmcgbXVsdGlwb3J0IGluZm8gKi8NCj4gKyNkZWZpbmUgWEhDSV9IQ0NfUEFSQU1TX09G
RlNFVAkweDEwDQo+ICsjZGVmaW5lIERXQzNfWEhDSV9IQ1NQQVJBTVMxCTB4MDQNCj4gKyNkZWZp
bmUgWEhDSV9FWFRfQ0FQU19QUk9UT0NPTAkyDQo+ICsjZGVmaW5lIFhIQ0lfSENDX0VYVF9DQVBT
KHgpICAgICgoKHgpID4+IDE2KSAmIDB4ZmZmZikNCj4gKyNkZWZpbmUgWEhDSV9FWFRfQ0FQU19J
RCh4KSAgICAgKCgoeCkgPj4gMCkgJiAweGZmKQ0KPiArI2RlZmluZSBYSENJX0VYVF9DQVBTX05F
WFQoeCkgICAoKCh4KSA+PiA4KSAmIDB4ZmYpDQo+ICsjZGVmaW5lIFhIQ0lfRVhUX1BPUlRfTUFK
T1IoeCkgICgoKHgpID4+IDI0KSAmIDB4ZmYpDQo+ICsjZGVmaW5lIFhIQ0lfRVhUX1BPUlRfQ09V
TlQoeCkgICgoKHgpID4+IDgpICYgMHhmZikNCj4gKyNkZWZpbmUgSENTX01BWF9QT1JUUyh4KSAg
ICAgICAgKCgoeCkgPj4gMjQpICYgMHg3ZikNCj4gKw0KPiAgLyogR2xvYmFsIGNvbnN0YW50cyAq
Lw0KPiAgI2RlZmluZSBEV0MzX1BVTExfVVBfVElNRU9VVAk1MDAJLyogbXMgKi8NCj4gICNkZWZp
bmUgRFdDM19CT1VOQ0VfU0laRQkxMDI0CS8qIHNpemUgb2YgYSBzdXBlcnNwZWVkIGJ1bGsgKi8N
Cj4gQEAgLTEwMjUsNiArMTAzNiw4IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0K
PiAgICogQHVzYl9wc3k6IHBvaW50ZXIgdG8gcG93ZXIgc3VwcGx5IGludGVyZmFjZS4NCj4gICAq
IEB1c2IyX3BoeTogcG9pbnRlciB0byBVU0IyIFBIWQ0KPiAgICogQHVzYjNfcGh5OiBwb2ludGVy
IHRvIFVTQjMgUEhZDQo+ICsgKiBAbnVtX3VzYjJfcG9ydHM6IG51bWJlciBvZiB1c2IyIHBvcnRz
Lg0KPiArICogQG51bV91c2IzX3BvcnRzOiBudW1iZXIgb2YgdXNiMyBwb3J0cy4NCj4gICAqIEB1
c2IyX2dlbmVyaWNfcGh5OiBwb2ludGVyIHRvIFVTQjIgUEhZDQo+ICAgKiBAdXNiM19nZW5lcmlj
X3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0KPiAgICogQHBoeXNfcmVhZHk6IGZsYWcgdG8gaW5k
aWNhdGUgdGhhdCBQSFlzIGFyZSByZWFkeQ0KPiBAQCAtMTE2Miw2ICsxMTc1LDkgQEAgc3RydWN0
IGR3YzMgew0KPiAgCXN0cnVjdCB1c2JfcGh5CQkqdXNiMl9waHk7DQo+ICAJc3RydWN0IHVzYl9w
aHkJCSp1c2IzX3BoeTsNCj4gIA0KPiArCXUzMgkJCW51bV91c2IyX3BvcnRzOw0KPiArCXUzMgkJ
CW51bV91c2IzX3BvcnRzOw0KDQpjYW4gd2UgdXNlIHU4Pw0KDQo+ICsNCj4gIAlzdHJ1Y3QgcGh5
CQkqdXNiMl9nZW5lcmljX3BoeTsNCj4gIAlzdHJ1Y3QgcGh5CQkqdXNiM19nZW5lcmljX3BoeTsN
Cj4gIA0KPiBAQCAtMTY1MCw0ICsxNjY2LDQ2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBkd2MzX3Vs
cGlfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgeyB9DQo+ICAjZW5kaWYNCj4gIA0KPiArLyoq
DQo+ICsgKiBkd2MzX3hoY2lfZmluZF9uZXh0X2V4dF9jYXAgLSBGaW5kIHRoZSBvZmZzZXQgb2Yg
dGhlIGV4dGVuZGVkIGNhcGFiaWxpdGllcw0KPiArICoJCQkJCXdpdGggY2FwYWJpbGl0eSBJRCBp
ZC4NCj4gKyAqDQo+ICsgKiBAYmFzZQlQQ0kgTU1JTyByZWdpc3RlcnMgYmFzZSBhZGRyZXNzLg0K
PiArICogQHN0YXJ0CWFkZHJlc3MgYXQgd2hpY2ggdG8gc3RhcnQgbG9va2luZywgKDAgb3IgSEND
X1BBUkFNUyB0byBzdGFydCBhdA0KPiArICoJCWJlZ2lubmluZyBvZiBsaXN0KQ0KPiArICogQGlk
CQlFeHRlbmRlZCBjYXBhYmlsaXR5IElEIHRvIHNlYXJjaCBmb3IsIG9yIDAgZm9yIHRoZSBuZXh0
DQo+ICsgKgkJY2FwYWJpbGl0eQ0KDQpJIGtub3cgdGhhdCB0aGlzIGlzIGEgZHVwbGljYXRlIGZy
b20gdGhlIHhoY2kgZHJpdmVyLCBidXQgY2FuIHdlIGZpeCB0aGUNCmtlcm5lbGRvYyBzdHlsZSBh
cyBpbiBvdGhlciBwbGFjZXMgaWYgd2UncmUgZ29pbmcgdG8ga2VlcCBpdD8NCg0KPiArICoNCj4g
KyAqIFJldHVybnMgdGhlIG9mZnNldCBvZiB0aGUgbmV4dCBtYXRjaGluZyBleHRlbmRlZCBjYXBh
YmlsaXR5IHN0cnVjdHVyZS4NCj4gKyAqIFNvbWUgY2FwYWJpbGl0aWVzIGNhbiBvY2N1ciBzZXZl
cmFsIHRpbWVzLCBlLmcuLCB0aGUgWEhDSV9FWFRfQ0FQU19QUk9UT0NPTCwNCj4gKyAqIGFuZCB0
aGlzIHByb3ZpZGVzIGEgd2F5IHRvIGZpbmQgdGhlbSBhbGwuDQo+ICsgKi8NCj4gK3N0YXRpYyBp
bmxpbmUgaW50IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcCh2b2lkIF9faW9tZW0gKmJhc2Us
IHUzMiBzdGFydCwgaW50IGlkKQ0KDQpUaGlzIGlzIGEgYml0IG11Y2ggZm9yIGFuIGlubGluZSBm
dW5jdGlvbiwgY2FuIHdlIGp1c3Qga2VlcCBpdCBpbiBjb3JlLmMNCmFzIGEgc3RhdGljIGZ1bmN0
aW9uPw0KDQo+ICt7DQo+ICsJdTMyIHZhbDsNCj4gKwl1MzIgbmV4dDsNCj4gKwl1MzIgb2Zmc2V0
Ow0KPiArDQo+ICsJb2Zmc2V0ID0gc3RhcnQ7DQo+ICsJaWYgKCFzdGFydCB8fCBzdGFydCA9PSBY
SENJX0hDQ19QQVJBTVNfT0ZGU0VUKSB7DQo+ICsJCXZhbCA9IHJlYWRsKGJhc2UgKyBYSENJX0hD
Q19QQVJBTVNfT0ZGU0VUKTsNCj4gKwkJaWYgKHZhbCA9PSB+MCkNCj4gKwkJCXJldHVybiAwOw0K
PiArCQlvZmZzZXQgPSBYSENJX0hDQ19FWFRfQ0FQUyh2YWwpIDw8IDI7DQo+ICsJCWlmICghb2Zm
c2V0KQ0KPiArCQkJcmV0dXJuIDA7DQo+ICsJfQ0KPiArCWRvIHsNCj4gKwkJdmFsID0gcmVhZGwo
YmFzZSArIG9mZnNldCk7DQo+ICsJCWlmICh2YWwgPT0gfjApDQo+ICsJCQlyZXR1cm4gMDsNCj4g
KwkJaWYgKG9mZnNldCAhPSBzdGFydCAmJiAoaWQgPT0gMCB8fCBYSENJX0VYVF9DQVBTX0lEKHZh
bCkgPT0gaWQpKQ0KPiArCQkJcmV0dXJuIG9mZnNldDsNCj4gKw0KPiArCQluZXh0ID0gWEhDSV9F
WFRfQ0FQU19ORVhUKHZhbCk7DQo+ICsJCW9mZnNldCArPSBuZXh0IDw8IDI7DQo+ICsJfSB3aGls
ZSAobmV4dCk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gICNlbmRpZiAvKiBfX0RSSVZF
UlNfVVNCX0RXQzNfQ09SRV9IICovDQo+IC0tIA0KPiAyLjQwLjANCg0KVGhhbmtzIQ0KVGhpbmg=

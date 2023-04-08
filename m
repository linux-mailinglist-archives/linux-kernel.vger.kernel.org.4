Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D46DBDF1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 01:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjDHXJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDHXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 19:09:40 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B5661B3;
        Sat,  8 Apr 2023 16:09:39 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 338LgcY1023708;
        Sat, 8 Apr 2023 16:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=WhJgilncHr6jGbjfQvq5M2jYblNCG4pTJtLij1wgPoY=;
 b=ochAmhJ+eeHeBQfdwUIWcXa5hp8QY60roCh3HNJqlbGXJW6dG1nAfpgApZSPZtVYXFRT
 X6lCAgHR+poi1DxtgMjefm/rUDjWftxj1VDYl5icscBE4WxKJJbiX6ydaFS+xi7/SxWR
 sVveovvUqcDQC2uXszCuSNTyHKASXBm88Lkeuwx9m67GUp9Iy28FSPmXlIUvU3s3qLrd
 Ftn3gcIACzK3SOSwdruGzcCE55sG/eAxXIMwwD5SK2l4JW7bIaKAw80y2CYW0xW0YmS1
 bDlfWaBApc0R7EqvB3zq5ZXJUTSSLwUr+keKQTfXoWX4t6jyXbyo1bQFFi+7MZ9Axajy 3A== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pu76vhpyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 08 Apr 2023 16:09:23 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1E0C2400B4;
        Sat,  8 Apr 2023 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680995349; bh=WhJgilncHr6jGbjfQvq5M2jYblNCG4pTJtLij1wgPoY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BrdjFp7KV5TnZrw9sdCeJ+Li6t8y4EKzAx2TM7ESSHWRosWzenkR3Y/Yx1+k3A1vX
         C08qsZsJbAFsSQcH+T7yq1p0lwIbkAC98NH7U3D8bda6MVKwdTp9kEZI51KZFHlqM+
         89nLEarhTVlzKmu6EduSkQ352FmOh7xlintnjfRrWfEqTBYY0UUbhboyBlxMGCePui
         f5wKtXijTp+VoCPNN8vLALkRhNNfn2CZj7U88GfqPvK+JKckwipImUkS6IfxTtq6jq
         RWSjLRfWaxOJqSGw3Rff08F2UYZiAL6LUFcQRAi5jeFbvVRLpJOWZtk+bfnu51PYLz
         pxgTODuBy6Azw==
Received: from o365relayqa-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D5528A006F;
        Sat,  8 Apr 2023 23:09:06 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WVoqOUib;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id F2B8C2209CA;
        Sat,  8 Apr 2023 23:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVf4bDbsvO283oiYTSqjgxqXM2QE4J1VrYTlHXJT1D3HjomoxG6/ClPtCw39ejheUn4RBr8rT9GIq/IljtLpwdKVaW6pbAjI+SRPbdhSNuvwRXuFxZKt+PjOYdqsCmiCM0672mM6GbFlS2K75xxw1iAXmTYjuNgUeASyGs6feoYeur8YshhiOheljokH8zGhnCGbUN4I2qA548Iq8qJ3ExPirwceLaaZMFP3S3wgF5Dye9QSh3TvcEg0FRmR9vJS90V/LVQqvOCimlznjYXrka4nohMSDb3zsvNQJCajllGEwKweUSr5wQ7JO3PykuPu8VhV4fo+sOpUdRCO4urIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhJgilncHr6jGbjfQvq5M2jYblNCG4pTJtLij1wgPoY=;
 b=Id7LoGu9YWO7wZRLuCuSq3+jcI4ReB8FmxrjERinfpPAy5SleWW4QuCH2gyhCMhAQhgNgiTawHgK5/J0yxOjhudGAbnrt37TbO8LPG22AovSrPTz3TQICGA8UCzcJzydPUN3jeDc3pJhxWYWFF9Uth1AcheNm4IzFkbv5GBcHi+DijUT8iEY/WBspB9mm7LONBK4rPYXRBckEn9r/R4iWPI3wjsb/wK9JECZTxS0qBYTL6GJ8jsLGwWQF2fQ3a6vE//w8cmjbXn4MC4Mb4VbVCt/Wp5zj+OKRbSiqdmH+0QDB4Fk/uTqLJt4ufOvxJK6nXVnAyI7smB+iqVTrCY0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhJgilncHr6jGbjfQvq5M2jYblNCG4pTJtLij1wgPoY=;
 b=WVoqOUibBLe3InIx2rNIR1LRpEeBz3pCFSEwA1Krl6F1M9xMf+033PDVoqB7xO5kDQ1qVK4LlY7Z4pPMKQtFvJFnDRfXR1Gg4tq6ITEjQ4kkRKVYt3WIxLKp/pYWywhOR+8FKvHK0IHYz76z+e2gghaWuaWfuyB7SMpDJtBrpD0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Sat, 8 Apr
 2023 23:09:01 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25%4]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 23:09:01 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v6 0/8] Add multiport support for DWC3 controllers
Thread-Topic: [PATCH v6 0/8] Add multiport support for DWC3 controllers
Thread-Index: AQHZZ75ThmrIuVEA5kWTiPsuhxFGB68gp1+AgACl14CAAMGDgA==
Date:   Sat, 8 Apr 2023 23:09:00 +0000
Message-ID: <20230408230901.es3b2hetqs53gvqd@synopsys.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230408014251.6cyjwuvsgu7dmz53@synopsys.com>
 <70dd6449-06d2-7182-9922-ddc3476ba472@linaro.org>
In-Reply-To: <70dd6449-06d2-7182-9922-ddc3476ba472@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB5925:EE_
x-ms-office365-filtering-correlation-id: 2474d14b-0a98-4b38-8c91-08db38863d4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lZseppG2j2PKIsqZGunIb9YvQFqkRn6EgG59kSCjEg3U1C7k0K5RCBR51KZjncfHU20xhVU0zrTpjn9D4rAjxz12lgZU2ebImhlMPSFpag4Ex0w2MmntwE65usIFVme3TXZtXqUTqTqzNfs1o4rbGKT+NPyaT6MMjsGURC5jHZCEiMtqRFkkFxHA1GR+5o4DJu7zee2EqbIaPDwoGdKs+HC3gMcQ7cW0zi7O9mDZInCjmYtbFfo/KezdO01MqJH3ZJM15QHShFq47kfv3b/L5Prvztzz2TBFCW0rPslLwlYlmtjP45V8AgwTXVhia7qa4ItVA+CsAxbk0EcLvq6MS6janF9dtUEVWON6eiWdCzo2ASPkdZlm7Y2eTx8uTsvn0GC1i63IADhUmRLOhJRgDmbHw3D30mRRTHRhnra9vi3pj4+UfTPvJaVKNKqpXe4griXB6StWY9JObKDz/BUh2guSsowB8JfSrLdZmO5CDNTlBbcCTWUCIle4CZ42KoCMTeaihh5jG2UOlKGg8boTg9M/92GwQ7Qbpdtoc0OFP2TIrevifxx+09buFVXqBSpbOsctv9EhZejEshxFiwVn9+xqrvaKN03/rbM28dyaQlwznEL5dCrdPlr1THeqiz2dwpJGCt8IAQ5ZL97Ok9TTVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(346002)(376002)(396003)(136003)(451199021)(5660300002)(7416002)(2906002)(66946007)(316002)(54906003)(41300700001)(8676002)(8936002)(186003)(478600001)(64756008)(66476007)(4326008)(66556008)(66446008)(6916009)(76116006)(71200400001)(6486002)(53546011)(1076003)(6506007)(26005)(6512007)(122000001)(83380400001)(2616005)(36756003)(38100700002)(38070700005)(86362001)(299355004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJCdHJCeTRxUW45Z3BKTVZnbk1zNUVrRkdrVE1pazZCRmVUMFhPTXhDbWxC?=
 =?utf-8?B?MngyRkJqMXYycjNNUFIxNU5OTXdvb1NvMmgvc2RZVW1SWFozbkltSSt4SUo5?=
 =?utf-8?B?TlNWa1I4QVlZUG1QUWw1bW9vWmtEYkwyOG95ekNUOE9WNlBiaTJsOTdUVmp6?=
 =?utf-8?B?L2pHN21JZkYzcjk1bmlPWW44b05nZFc1VEN0UjlaOUtBbndsVE5iTGEvczFN?=
 =?utf-8?B?TXZySzZWU1BncTV5cWF6QWNEakhFQTc1R25VZStLdi8ycy9xdUxCUC9LV2I3?=
 =?utf-8?B?L004NjRCR053TGpycDhReWlKMWxSMWpmS3BlUTgzT3V6amNXdGt3Vnowdisy?=
 =?utf-8?B?SS9UVUd3ZWc2dmlKOE1yQXJOMjREY1ZCR1BoM0VwUDhmYitHa2RZNGJ2aENO?=
 =?utf-8?B?eFBKR2M4dSsxVTFFWWxEMG1YVVpqQ1RMNXNaZko1VzQrL2l3eldEdHd6QXJF?=
 =?utf-8?B?djdaN1FZMFpLWjVndmFydklSRHR4VTFyWmRWSGwwRWhMdzNWWWx5K21JWTlI?=
 =?utf-8?B?cmlDTlZBRjJQVVByOGU3S2tLcDVXejdQTGNYK3JMdUl2bmlvM3J2cU1vcXFC?=
 =?utf-8?B?TWhsejljUzR3aC9jOVFJZGt0d3d3ZDZTN3VkOHFPVlF2KzZDZVQrQjVsOXRY?=
 =?utf-8?B?cXFVYjhwMXdqOHp6Qi80ZGgxdWplVTlVc25EaTA4dDc0c0NqOGNYZWhnekVF?=
 =?utf-8?B?WGVzV2xKSGpaYTh0QUErWXY2WFBHVjVYUVB5MDNmR0xYT2J4MWl1TVpIS2NM?=
 =?utf-8?B?MG1aNHVZZHUwRXJIVUpXT2FKTXZDenZRZDZIczlIRWtNOVd3ajM1elhxcThu?=
 =?utf-8?B?Mlp2S1d5ZXYvdW9nTG9oUk5nOTcydXZDOTd5dStWOUFFS1hJcTVxSEZ5WDNV?=
 =?utf-8?B?OG9rekEyMkpnbFc2MlNWMnlqa0xHRlNVclRJeGYzNWJ4eUFjcDhQT0hDRjZa?=
 =?utf-8?B?QkMvSDRQSGR2MFJLS0JEYUxVbXNtVUxDOS9lWS9oamUvWG5vbTR4YlNxbEZv?=
 =?utf-8?B?enVHb1NKQmVuTXN4NXBVMjZ6dzhjNS9pSSszQ0VZTEorR2taVXNrMmUxNlho?=
 =?utf-8?B?MmJHZXdMekVZZ1ZOdVJIUmtwZXlEUXduZHFmQllHamZ6UWJKTkZkUkFLMU5l?=
 =?utf-8?B?cmJmMmFwU0M4UFYra1lsbWpHZElZMFdKM1hvMGJ5NzRra2RXWDl4NGVXcEZw?=
 =?utf-8?B?cVRpa2F6UHBTaC9mbk05QVRRSVFzVHlUa3Y5VnVrNmN0cTF1WFdpamRIS204?=
 =?utf-8?B?NnA3emZiVXc1MEM4dE82QlczWjgvbEk3azhaWG5rWUxKTC9sTlRjRGlQckhI?=
 =?utf-8?B?RklOZVRxY2J2bGR2UUZ4T29mNTByVktMOFFkbWdLbWY1d0dwU1ppUmpUY2k3?=
 =?utf-8?B?SkJZZWQvVGlOcUNQcndxcTh4cWw3anppVFc1TFNrNGY1YXlJa09UK3VRVk5u?=
 =?utf-8?B?d3U4SlN0ZlZxRlhCTUE3a0RRWFIzNE5vazNEOElNNS9GZ1EyL2tiZ3g0d0NP?=
 =?utf-8?B?RmgrY3c3dTk5dVZDWmVCMm84V0o1VDRpeVE5UzdYck90Wmc2aDlZMHJrMUw4?=
 =?utf-8?B?K0E1S0oxM3VZazJ5WWtOSHVEak9vOU8wRnFKWUFSQ1lsVENjcU9tU20yMTlT?=
 =?utf-8?B?TkJQSXNOUm4waUR5OXd2Z2M3RXYwT3dZclRsNFNkQlBnWmVkTG5mbks0RFVG?=
 =?utf-8?B?M2lwNmNiSHZtZzEzK3M3Zy9tN2JrRmdBSzhNSktZTGEwbDB2cXJZemQ5YzFs?=
 =?utf-8?B?UmxaNVpWckxnUWhqRVI2Y0FyOTR5RysxbWZLZkFqdFdnUHl2ZU56MjFKRGJC?=
 =?utf-8?B?L0Vwdnc4czBMUnBTSENDSjdueGNEOFc4Mzl6UFRMV3RjTnFlaFUwTXpCRlVl?=
 =?utf-8?B?S1V5VzZrODkreHRhMHdlNlJyZVpMbTFRck1zSVgxOTJlRk1aOFBFYzNwalU4?=
 =?utf-8?B?c1Z5OEhrQXErYnFYWHByVjRlWmlvMWhuWXNJTVhsWjJBK3NvdEl1c0RoNzdt?=
 =?utf-8?B?SmtESVgrd3A0cnZtbFVKRXNya0pjU0ZJWHp6dVovNXZxVU1McFZhaTZtc3h3?=
 =?utf-8?B?MzRLcllPVnpuWTBrdG9UaEx2OWNWVm9tMmo3bUJqR1BQQU5EQm9OM3pqS3ls?=
 =?utf-8?Q?28v4MbkV+Kk2Sjj0WrIHnCay3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0CE5ED1257AEF44B608AD02C8A033DF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UnJjMnRubCs1R1dKU0lack5JdXNhTjRwakZ3OW5BellZSW9qSlBNVnZQcnU0?=
 =?utf-8?B?UHVMRFk0NUduRyt3Q3ZMUys4SXcxU1RHQU9POUdoNWZZVjFQTm9raEJWVU1Q?=
 =?utf-8?B?djdMUEpEMzg0TlNWZU9nUlBzTytwY0dqSk8wNnltZW5PM1ZCNXFSemtFZFI0?=
 =?utf-8?B?WGEzL2xScHdVazIreXRzVEhKWDRQTzBTaW1KNzQrd1RtRjdOOVVhalNBaXV0?=
 =?utf-8?B?ZHVYV25UcEdINEtZUm5oRTFRc1dVNURuYTlmYlAwOUFIYS85TU4wMUU2YzFu?=
 =?utf-8?B?ZlpHbzg5cWRNSlVqM3pSNVd2K2pQaCs4bkFXdFV2aVBoQTBXc1hnVGVTbGJB?=
 =?utf-8?B?anlzZFdjZnBjY1pwbHVsd3lQV3laelBDWFBNdHNKazVObEliOTRaMDN5SjhO?=
 =?utf-8?B?YmVWNllyQVJCOXVGdkhSanlWVHl2MGtOeXlYZXVLNXlEQnVocjJiM2dQR2Rm?=
 =?utf-8?B?OWtNREo0bEN6MCtsZnB5WEhjUXJoZmNuNGtSbmJIcTg5L1dlNkk3N1pJU1J0?=
 =?utf-8?B?WTVaeHN0RXNSWVp6Y0Q3OHZ4UFY0RnlPVk9aN3h5cEVnN1QrTkpiSStUcTRB?=
 =?utf-8?B?MFJOeFc3MzVpQm90amNBdkRTa0J1SjZZZFZ4WGFxcGMxbnZrdDNWbTNEZ0Vi?=
 =?utf-8?B?OTFmNi9ZS0trTmowOGgzV3dueVpKMjZuUmlzUW10bU5qTEIxQitDME1ZbXR0?=
 =?utf-8?B?dG95M0lKQmtLRFM1enVyOXozckZZbVpyT2huMlQ4THF4dkxNdXRXVGFGMlVO?=
 =?utf-8?B?V2R0UTdrTWpUd2xJVjVaakZwd0RFbmdST3hCNVBYRG9LUVdNQU5ZaVlXcWFB?=
 =?utf-8?B?TFBYZEtuZ296NjBWT3ppV3Q5cGUrZWFwQ0NXZ0Q1R09zRnVyc3N6d2VWc1Nm?=
 =?utf-8?B?b3pzY1o5Nndrc09ZVXk1RzZReU5aNkZWaW1LemY3TUJ5OTFCNWFvSTNqdVdj?=
 =?utf-8?B?TmV1bFNUOXZxTWlrdmNKQnpqSGoxREJiRDJ3YkphSnMrR0thMkxlbllpU3g2?=
 =?utf-8?B?OEUvM2ZwVE9UMThyZkMxRVZIOHNlbE9GclJoTEswdG5JdW13NENYMmJXL05u?=
 =?utf-8?B?Y0tKaktGejVpRWluRXliOEdiQy9uNDBGWXJXWERwRjVkRmd2QXFhejMrbzNK?=
 =?utf-8?B?STNwZ3A1SjA0dUdlZVJLWU1HY0h5QVBwVGV2Zm5qWUpRVXNCS3FwMWg3T1FU?=
 =?utf-8?B?UUNDZXlPaWtqRFM0NzdKVEFzdldyQSt1NWlpVkxzd2dGTUVQcTNyaTk5TkhQ?=
 =?utf-8?B?SmxWaTZ0aDA1azUxRHM3dUdwYUFCdEpKemtOeUtINSszRG5sL3JhalhKWEdl?=
 =?utf-8?B?eEFGNG9UamxncTZsdDJuQ0w3akZKTUVWZmk4dDRlY1Flem1BL29RMkx3ZEEz?=
 =?utf-8?B?STZWdXg2TUF0RWc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2474d14b-0a98-4b38-8c91-08db38863d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 23:09:00.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BS/MiwP+CMm71GPxmzbXSjyZuL1smXu1+T0VsWkR2eEX5sKSBwEvXBusROryBfut3nQwJN0b9pf7dE3VECdQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
X-Proofpoint-GUID: R8_Lu70klcZ5sqFQZ4e02q8dujH6Or0D
X-Proofpoint-ORIG-GUID: R8_Lu70klcZ5sqFQZ4e02q8dujH6Or0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-08_13,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304080210
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBcHIgMDgsIDIwMjMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDA4
LzA0LzIwMjMgMDM6NDIsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4gS3Jpc2huYSBLdXJhcGF0
aSAoOCk6DQo+ID4+ICAgZHQtYmluZGluZ3M6IHVzYjogQWRkIGJpbmRpbmdzIGZvciBtdWx0aXBv
cnQgcHJvcGVydGllcyBvbiBEV0MzDQo+ID4+ICAgICBjb250cm9sbGVyDQo+ID4+ICAgdXNiOiBk
d2MzOiBjb3JlOiBBY2Nlc3MgWEhDSSBhZGRyZXNzIHNwYWNlIHRlbXBvcmFyaWx5IHRvIHJlYWQg
cG9ydA0KPiA+PiAgICAgaW5mbw0KPiA+PiAgIHVzYjogZHdjMzogY29yZTogU2tpcCBzZXR0aW5n
IGV2ZW50IGJ1ZmZlcnMgZm9yIGhvc3Qgb25seSBjb250cm9sbGVycw0KPiA+PiAgIHVzYjogZHdj
MzogY29yZTogUmVmYWN0b3IgUEhZIGxvZ2ljIHRvIHN1cHBvcnQgTXVsdGlwb3J0IENvbnRyb2xs
ZXINCj4gPj4gICB1c2I6IGR3YzM6IHFjb206IEFkZCBtdWx0aXBvcnQgY29udHJvbGxlciBzdXBw
b3J0IGZvciBxY29tIHdyYXBwZXINCj4gPj4gICBhcm02NDogZHRzOiBxY29tOiBzYzgyODB4cDog
QWRkIG11bHRpcG9ydCBjb250cm9sbGVyIG5vZGUgZm9yIFNDODI4MA0KPiA+PiAgIGFybTY0OiBk
dHM6IHFjb206IHNhODI5NXA6IEVuYWJsZSB0ZXJ0aWFyeSBjb250cm9sbGVyIGFuZCBpdHMgNCBV
U0INCj4gPj4gICAgIHBvcnRzDQo+ID4+ICAgYXJtNjQ6IGR0czogcWNvbTogc2E4NTQwLXJpZGU6
IEVuYWJsZSBmaXJzdCBwb3J0IG9mIHRlcnRpYXJ5IHVzYg0KPiA+PiAgICAgY29udHJvbGxlcg0K
PiA+Pg0KPiA+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sICAg
IHwgIDEzICstDQo+ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2E4Mjk1cC1hZHAuZHRz
ICAgICAgfCAgNDcgKysrDQo+ID4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2E4NTQwcC1y
aWRlLmR0cyAgICAgfCAgMjIgKysNCj4gPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzgy
ODB4cC5kdHNpICAgICAgICB8ICA1OCArKysNCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
ICAgICAgICAgICAgICAgICAgICAgICB8IDM3MyArKysrKysrKysrKysrKy0tLS0NCj4gPj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5oICAgICAgICAgICAgICAgICAgICAgICB8ICA3MSArKystDQo+
ID4+ICBkcml2ZXJzL3VzYi9kd2MzL2RyZC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTMg
Ky0NCj4gPj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgICAgICAgICAgICAgICAgICB8
ICAyOCArLQ0KPiA+PiAgOCBmaWxlcyBjaGFuZ2VkLCA1MjMgaW5zZXJ0aW9ucygrKSwgMTAyIGRl
bGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiAtLSANCj4gPj4gMi40MC4wDQo+ID4+DQo+ID4gDQo+ID4g
UGxlYXNlIGNoZWNrIGlmIHlvdXIgcGF0Y2hlcyBhbmQgbWFpbGluZyBjbGllbnQuIExvb2tzIGxp
a2UgdGhleSBhcmUNCj4gPiBjb3JydXB0ZWQuDQo+IA0KPiBBbGwgcGF0Y2hlcyBsb29rIGZyb20g
cGF0Y2gtc3ludGF4IGFuZCBhcHBseSBmaW5lLiBXaGF0IGlzIGV4YWN0bHkNCj4gY29ycnVwdGVk
Pw0KPiANCg0KSG0uLi4gcGVyaGFwcyBpdCdzIGFuIGVuY29kaW5nIGlzc3VlIGZyb20gbXkgbWFp
bCBjbGllbnQgdGhlbi4gSSBnZXQNCnRoaXMgZnJvbSBteSBhdXRvbWF0ZWQgY2hlY2tzOg0KDQo8
c25pcD4NCg0KRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPScgKGN0eDpXeFYp
DQojNDI5OiBGSUxFOiBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaDoxNjk3Og0KKwkJaWYgKG9mZnNl
dCAhPTNEIHN0YXJ0ICYmIChpZCA9M0Q9M0QgMCB8fCBYSENJX0VYVF9DQVBTX0lEKHZhbCkgPTNE
PTNEIGlkPQ0KIAkJICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KDQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0
ICc9JyAoY3R4OlZ4VikNCiM0Mjk6IEZJTEU6IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oOjE2OTc6
DQorCQlpZiAob2Zmc2V0ICE9M0Qgc3RhcnQgJiYgKGlkID0zRD0zRCAwIHx8IFhIQ0lfRVhUX0NB
UFNfSUQodmFsKSA9M0Q9M0QgaWQ9DQogCQkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQoNCkVSUk9SOiBzcGFjZXMgcmVx
dWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6VnhFKQ0KIzQyOTogRklMRTogZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmg6MTY5NzoNCisJCWlmIChvZmZzZXQgIT0zRCBzdGFydCAmJiAoaWQgPTNEPTNE
IDAgfHwgWEhDSV9FWFRfQ0FQU19JRCh2YWwpID0zRD0zRCBpZD0NCiAJCSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4NCg0KRVJST1I6IGRvIG5vdCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24NCiM0Mjk6
IEZJTEU6IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oOjE2OTc6DQorCQlpZiAob2Zmc2V0ICE9M0Qg
c3RhcnQgJiYgKGlkID0zRD0zRCAwIHx8IFhIQ0lfRVhUX0NBUFNfSUQodmFsKSA9M0Q9M0QgaWQ9
DQoNCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6V3hWKQ0KIzQz
MzogRklMRTogZHJpdmVycy91c2IvZHdjMy9jb3JlLmg6MTcwMDoNCisJCW5leHQgPTNEIFhIQ0lf
RVhUX0NBUFNfTkVYVCh2YWwpOw0KIAkJICAgICBeDQoNCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQg
YXJvdW5kIHRoYXQgJys9JyAoY3R4Old4VikNCiM0MzQ6IEZJTEU6IGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oOjE3MDE6DQorCQlvZmZzZXQgKz0zRCBuZXh0IDw8IDI7DQoNCjwvc25pcD4NCg0KDQpU
aGUgIj0iIGdldHMgZW5jb2RlZCB0byA9M0QsIHdoaWNoIGlzIHN0cmFuZ2UuIEl0IG5ldmVyIGhh
cHBlbmVkIGJlZm9yZS4NCkkgbmVlZCB0byBjaGVjayBteSBtYWlsIGNsaWVudC4gU29ycnkgZm9y
IHRoZSBub2lzZS4NCg0KVGhhbmtzLA0KVGhpbmg=

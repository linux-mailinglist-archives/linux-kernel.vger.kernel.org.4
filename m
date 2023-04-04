Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E966D5BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjDDJdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDDJdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:33:31 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C325125;
        Tue,  4 Apr 2023 02:33:30 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3345rfkf002723;
        Tue, 4 Apr 2023 05:32:57 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3pph89n66x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 05:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdtGa9gz9YDr58VVsQCKnJ9knY4THMsNx0fp2AiUKxdQ/f6S0O6mEx2xhWXlXnW8lfLAyNVamhHzhfMbcjpRziynukb7q7FZyRJbldajl3fnz2sTBLFtsF42UndL7y8yAQOKZmxQqRqJzMNIsb52Wv3dAJp8aJxDiSK/CriJWrTujrKpI5hHq0blqKycyE50ybOJoo/x4hofOkTnUrMDEk99QYKQd8d+mLxu6Nikop6vWGyKUXDvDtafzt5lySnouXE6fGYs6SXrva4Rm/IB+e5hu7D/PeXtHd3j7iWGhXkwg9ZmkKTrTB9wYMHUd6ilIvuuuDvjlih5pl1F/f1iqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndz7zMqLPkVc+BEos3Tab6mwCeeEN960o33uuonAvGU=;
 b=UkzUZumYXsbWwEv0Uw291gt5WCbh6n6nXAC+uQ6WjYMtKrpJAy3k1GU97y6or9+2ZYBfFSVldQth1f9E0mMeWzZpTFyW3NBYeABkpnJ/mqLPtl4FgQ+BoSSNiqA93E0yFWtEp+TKsyVtYgIQ753VRDCr0KtQcMPSVNfHC/GeXfc4olN7jphBhmFFTbSWRnf1GAosP94b9+HkUMv+AUuO4EhiypBpNIVi8aAOYYt3JRxVr5zYE7fXmBEyzVm78fbxpwIC5rHytHmisemIyaDCU/2c1tjhmpYAgPS/B44d5dij/B6V3CG6czPrkFQSPfn7ESpUH4M/X/ivnHuY/V2CbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndz7zMqLPkVc+BEos3Tab6mwCeeEN960o33uuonAvGU=;
 b=ioidxVOnz1yH5unQrkiL+4re/UPNrtldfu3OXzwVgjJPCYYP80yV1fOpYwS/I2pI8XvqDc04i42l+Il87cPnGjpqWyDfPHm0v41JyblS0UlVdlWbslI/GQAOdd+Uk9xUG4UDYNmzrxg/WgAzH/ZtVzJW6FFg79fsl/qvUpRrIsk=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by SA2PR03MB5673.namprd03.prod.outlook.com (2603:10b6:806:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:32:46 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 09:32:45 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHZZkM1/0NcmmhHVE+7c9BLHmZIxK8arcoAgAAOpACAAANRAIAABmEAgAAIUoCAABUTIA==
Date:   Tue, 4 Apr 2023 09:32:45 +0000
Message-ID: <CY4PR03MB248830305D843EB345E3555196939@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <996b49ab-5e2e-76bc-efb1-38c6384871f6@linaro.org>
 <2023040407444619bf5596@mail.local>
 <0fd972bd-c5e7-65cc-6992-09c4c3e88f95@linaro.org>
In-Reply-To: <0fd972bd-c5e7-65cc-6992-09c4c3e88f95@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxXRTFaREF3TUdNMUxXUXlZMkl0TVRGbFpDMDRaVGd3?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGeGhOV1F3TURCak55MWtN?=
 =?utf-8?B?bU5pTFRFeFpXUXRPR1U0TUMwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpFd056QWlJSFE5SWpFek16STFNRGMwTXpZek1EYzFPVGM1TWlJ?=
 =?utf-8?B?Z2FEMGlkRkkyUkhGR1NtaE1jMVp4VDBFclZqRlZOM1o2V0VZMU5tOTNQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCUlc5RFFVRkNkMEo1ZEc4eVIySmFRVmR1Vkd0dGRG?=
 =?utf-8?B?UklOR1ZaWVdSUFUyRXhUV1pvTldkRVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJSR0ZCVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZSWkdsck5WRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpvUVVkUlFXRlJRbVpCU0UxQldsRkNha0ZJVlVGalow?=
 =?utf-8?B?SnNRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKNlFVWTRRVnBuUW1o?=
 =?utf-8?B?QlIzZEJZM2RDYkVGR09FRmFaMEoyUVVoTlFXRlJRakJCUjJ0QlpHZENiRUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFJVRmFRVUp3UVVZNFFXTjNRbXhC?=
 =?utf-8?B?UjAxQlpGRkNlVUZIVlVGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hkQ01FRklU?=
 =?utf-8?B?VUZZZDBJd1FVZHJRVnBSUW5sQlJFVkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJXVkZDYTBGSGEw?=
 =?utf-8?B?RllkMEo2UVVkVlFWbDNRakZCU0VsQldsRkNaa0ZJUVVGalowSjJRVWR2UVZw?=
 =?utf-8?B?UlFtcEJTRkZCWTNkQ1prRklVVUZoVVVKc1FVaEpRVTFuUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVRTlQU0l2?=
 =?utf-8?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|SA2PR03MB5673:EE_
x-ms-office365-filtering-correlation-id: 86dfca04-b097-4624-6dbb-08db34ef8c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkOnbabO8yOgNqT83UeDdkTHlZOHLhhaTcuMNv1aKdE0/MWFb5s7pOHAmSAQ9knvqBADtrPOmoRXIOlAqU8zz6yXx4tX1RjEEoDOUjkDcETF3eiT7GzFzrlBb8RDTznWKXUQHEhKOka6lAdgcJTRi74s1+LJdx2LiiXVPVkQiuFnDHv6KhZ8XUaZi/qhFj9wh2FF1ewuFi0mIKgtwOXOrwTkmCw+glI33Tkgax91LA8nLcQVz1JexQTJqbsLH72y5ZgDfAkeqNHSQKP6q0DFPsV+9x72n1TCVq0G840n/uvHO8dVY9KGVjpl/wtOFX1S3doQWPIDQYSntgZ+xNJOvi4urA7sAmv6elTHThet2POlSssJXA6oPHjkK0ws/4w+W7P+opuIvAlE8/vijwmXefNLagVc0bPZMnJtsrS4ubJrSSIKtgG2KEencsSn/KMsutaFbKcvch90V+MTAtuYyi6r4ghmv7Q626QJApC49q5dRXXX0ypdjvum1eIMl8GaApUOklNnDBJrIA3QcKt5q8lgvEI8g04Ey3ZnL5/oimdTDJZzOwA4zPRR2MBtuRa9mf6GA6//SCrGcOC6pB0VBETDq951y41t2r8kwEP/RqA5tJzNLYJGvkri9SAJDReO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(86362001)(38070700005)(33656002)(2906002)(7696005)(55016003)(71200400001)(53546011)(186003)(26005)(6506007)(107886003)(9686003)(8676002)(4326008)(66446008)(76116006)(316002)(478600001)(66556008)(66946007)(64756008)(66476007)(7416002)(41300700001)(38100700002)(122000001)(5660300002)(54906003)(110136005)(8936002)(52536014)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkZBVVVPRHhvVGg4M3F3WnF1aXNqdmxDQ3FWV1NRREpZOElJSHF3OFF0cjdL?=
 =?utf-8?B?UXc2bU1FazR4L0kwQ0FjdmNUQ1NlUENGbnl3TXBteE11ZktwTkplQVdWVHdG?=
 =?utf-8?B?UWp3aGdUUmZlL1RvZlVRVWh3SnpETlczQTNwVlBwbUl3YlpFeXhoaTVrOWg5?=
 =?utf-8?B?ckRFc1pmOWJQRVVYamh4NWx0bmR5Y05NWFdZSUJLbm1BTEVSWFJaRUVJakR2?=
 =?utf-8?B?QVlYT21UTzhxUlQyMDdWMVFyNStOWDVXZ1d3eWcxODZkQ1hONXZNMk5wT3Fu?=
 =?utf-8?B?N3p6TGVReGpiWWI1bXJDSHFjMnRGY3Y4UXliREZCcXRrVFpRdmRBK3EvTHh6?=
 =?utf-8?B?SGxXTTZyZ1k0VnladkxTS3o4VG1za2c2VTdqaE9rMkRlTXY3TTFzaVRQYk5x?=
 =?utf-8?B?MEYwZ1doOHg4eGZwaG45eVRwZzV6MTRaNThKQ1BDSUJBTEFqRG01dEs5ZjBN?=
 =?utf-8?B?dDZ0aWF3ais1RTFORThSalRvMXhTb2hXVVVJSmpySk1xVDVNeVZ3MU9xWEV2?=
 =?utf-8?B?bEU5ajFDbm40Tzc3OVhqQVMzOWFpZEVyV1dlWUIvYWwvSmw1TS9xM3FQTnhF?=
 =?utf-8?B?QmZ6VHVkdFY1eEYxUUM4dmpYZ3FLSDJzUVdKcm55YVBGcFloUGdzYWZTNElq?=
 =?utf-8?B?NGVuWUFWUzlqM1dUMlkwRzhyc2s4ZlZ0cm1sSC9lbjRKZEdCWGpwNm1ycm5N?=
 =?utf-8?B?enNwMjVOU1MwMGlRL09GMU1MY2F3R2x1THNoYmUzZXREZ3p4d2dsckhKQWt2?=
 =?utf-8?B?ekEzZ3BibmVhbXFWK0ZiQ1plYXo5bytpT0YwVUZ6VTVQWUVaU25kdW5ORkRO?=
 =?utf-8?B?ZHRRS3g4Z09vUFhOM1lSbDlVNjd2dWhLbzZ4VXhudVhvUHNWd0lzbFVrb3Vl?=
 =?utf-8?B?TnF1ZGlZR29aL1hOOVFRRzZqV1Voa1dxMjRtMHhNZ2gyNU1YL01FVTdvTTd3?=
 =?utf-8?B?aFh1OFVNQWJSa0Zpc3VsZ05nWG5Rb29WYTNsd0VRQ2lyR1BoYmZGYWk5ajZC?=
 =?utf-8?B?UzJNS29RQmIyb2FkcXRUZk5kQXBjK3ZuVHVvYWd2cmg3SmVOU3UxOGY4NHVH?=
 =?utf-8?B?MEFnSVBTREQrcCtkaFVSTG5Nb1NlaDNDTktBWE4xdTdUd1JydlZvMDNPcGpZ?=
 =?utf-8?B?aC9pWHJtSkFsQk5mUDBidmhYOFhuMmtWLzdTVGNrK1J4dG90Tkp1K1RRUFRw?=
 =?utf-8?B?TzZHSDl6ai9FcTZtSmw1Q0dhQ3YwYjhyMEV5QW5ZRlhiNEZWNHRQYmsyeDZQ?=
 =?utf-8?B?Qmh0U3czSU5CSGduVWN2M09sTGpqcFZNUHAvRDNPc0w2QVk5Y0krR2s3QkNk?=
 =?utf-8?B?WjRhelRIZFRuWWhrcXY4aFZLUXBlVVFoZDluWStTaVdyVEpIT2l5aitzL2xX?=
 =?utf-8?B?Q2hCajFsZXMwUXpnYkZwVHJvMklJdXpKeWVYNkJCcml0STRwbFBDdFZkUFMz?=
 =?utf-8?B?clVJZGNlVWx3NG5NZDM3RFoxYjcrcW9Xb2ljVHZwTDdWNVh2M1AwOWpGM2c2?=
 =?utf-8?B?YkV3OGpNNzJDdnp4UHBwUzhVVkRrdFFIKzVJZFQ4TWVSZ0tZL3pyZXlRb3dO?=
 =?utf-8?B?R1plMklSWitLS01aVEo4YzhhZmplc1o0aGVoaVpjMU5qU0FEMGJFbWRQVU5J?=
 =?utf-8?B?WHUwb2R0YzFBWFMrNmFVTTFkdW9oOFlWNHRhU01SYldwYlJJNHRuN3lhai9F?=
 =?utf-8?B?U010WnJ6djg0N2xIQ3V6SUZzUDBjcEJzbUxEb2d3TklTZkRWS1VGUW8yMVJ4?=
 =?utf-8?B?TEtOaEF3ME5YS2wxSTVQR0JwWVU4bFgrVWZNaFdtRHk3WWVMUnhnNTg2RFY0?=
 =?utf-8?B?RkNEVmx6cEV2RGFacnQ3ZFc2cFBER0FTanlxdWNXcVFXcXdCTjNhSUVvcUJJ?=
 =?utf-8?B?R3FKOUc3cDI1TEVLVWJmQ2lGRGZEbUIwOTFVTE1HQUJRaHZmVW0wbm9TU1lP?=
 =?utf-8?B?RU85bHErWWMwczlOdnRweWcyWG1kbEdTRlhxOVFaSHhnK2h1QzR6T0J3Z2Yy?=
 =?utf-8?B?d1lOUHVqZWgvZWJvblljQzkxdStDZWN0Q2llWUsraTh5Y2JvbUtTb09PbzdM?=
 =?utf-8?B?d2tZeDBFZHFlS1ZXdkZ5aEtEazZPejl1djF0M29kQVZQdXhiNDAwVmJxSFV1?=
 =?utf-8?Q?KSnIh8+Ora5LPODw/Jx6h+3JD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dfca04-b097-4624-6dbb-08db34ef8c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:32:45.8111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pUt9tYRVEm7owFTmpgJtGK7uSD0o5DwJ2VqnF2KS5EwxqRb+6dQtWWOzodLFcQXyoTwW6BcdzDEDysxFSmtBqYDYqGJ/A51zWph+uFs448=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5673
X-Proofpoint-ORIG-GUID: N-BQ2eFrc-3OJ4XHnMXeatJPh7UFmcOb
X-Proofpoint-GUID: N-BQ2eFrc-3OJ4XHnMXeatJPh7UFmcOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_02,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=713 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040088
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwNC8wNC8yMDIzIDA5OjQ0LCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90ZToNCj4gPj4NCj4g
Pj4+IGNoYXJnaW5nIHdpbGwgYWx3YXlzDQo+ID4+PiBlbmFibGUgYSBkaW9kZSwgc2VsZWN0IGEg
cmVzaXN0b3IgYW5kIHRoZW4gaGF2ZSBvciBub3QgYW4gZXh0cmEgZGlvZGUuDQo+ID4+PiBGaWd1
cmUyIG9mIHRoZSBNQVgzMTMyOSBkYXRhc2hlZXQgaXMgZ3JlYXQuDQo+ID4+DQo+ID4+IFNvIHRo
ZSBkaW9kZSBpcyBpbiB0aGUgbWF4MzEzeHg/IFRoZW4gd2h5IGVuYWJsaW5nIGl0IGlzIGEgcHJv
cGVydHkgb2YNCj4gPj4gRFQ/IEVpdGhlciB0aGlzIHNob3VsZCBiZSBpbmZlcnJlZCBmcm9tIGNv
bXBhdGlibGUgb3IgaXMgZXZlbiBhIHBvbGljeSwNCj4gPj4gbm90IGEgRFQgcHJvcGVydHkuIEp1
c3QgYmVjYXVzZSBkZXZpY2UgaGFzIGEgcmVnaXN0ZXIgZm9yIHNvbWV0aGluZywgaXMNCj4gPj4g
bm90IGFuIGFyZ3VtZW50IHRoYXQgInNvbWV0aGluZyIgc2hvdWxkIGJlIGluIERULg0KPiA+IA0K
PiA+IFdlbGwsIGl0IGRlcGVuZHMgb24gdGhlIGJhdHRlcnkgdGhhdCBpcyBpbnN0YWxsZWQgb24g
dGhlIGJvYXJkIHNvIGl0DQo+ID4gbWFrZXMgc2Vuc2UgdG8gaGF2ZSBpdCBpbiBEVC4NCj4gDQo+
IE9LLCB0aGF0IHdvdWxkIGJlIGEgZ29vZCByZWFzb24sIGJ1dCBJIHdvbmRlciB3aHk/IFdoeSBj
aG9vc2luZyBkaW9kZSBvcg0KPiBub3QgZGVwZW5kcyBvbiB0aGUgYmF0dGVyeT8gV291bGRuJ3Qg
eW91IGFsd2F5cyB3YW50IHRvIGhhdmUgdGhlIGRpb2RlPw0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0KVGhlIGRhdGFzaGVldCBkb2Vzbid0IHNheSBtdWNoIGFib3V0IHRoZSBl
eHRyYSBkaW9kZSBidXQgdGhlcmUgaXMgYWx3YXlzIGENCnNjaG90dGt5IGRpb2RlLiBUaGUgZXh0
cmEgZGlvZGUgbWlnaHQgYmUgdGhlcmUgdG8gY2F1c2Ugdm9sdGFnZSBkcm9wLg0KDQpCZXN0IHJl
Z2FyZHMsDQpJYnJhaGltDQo=

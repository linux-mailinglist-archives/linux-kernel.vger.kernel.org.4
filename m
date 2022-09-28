Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD35ED47C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiI1GHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiI1GHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:07:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2C118B09;
        Tue, 27 Sep 2022 23:07:46 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S5X0J7012173;
        Wed, 28 Sep 2022 06:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=MRa7vbF4LYeQIC70b8PNg/GAdorkCBei/1SPggWWBig=;
 b=PHFqcBQN04RSnBquV2bn25BkcjDDX0pR5xZrk9dfTVpi3Lz4QHIK/hxrS0tnJ9Z36Vnq
 P5dVBkvyi754aA3oeNNZ8OfkDGMZuGhMRPzGt5MGU90W1kcrLk9p869BnFDlQT5BX5gR
 bdaWVFLuOAcoIkQ5w6+1OH59k2gw+mVr/qqYw2TWIdI7dFrdMMw+6h/L+/+BCrFE1cm7
 4CAKXcxI6U8+WJkalbGn26ynyl9ncdSestljzapXRx97K1XkrFPxunI72s/4i72TDDIA
 /05a1H0w1wuL+HI/5a+lbUtDFEPoNp7MaDrYSvCUpo8MGO8aR6F559LnC8m4xPOj3Kg7 RA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juq77khd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 06:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+2qbylITRVtD6A3IebJiC1cTT3o3cfr/RW2tE90H7P9LrsyKn8JaE5i1J0JPtjwGL5IsaScWHHOk2AQwR4MD5xuT/I9BTjKm3TQ2gYJTP4KfwlIpCz4/wfiicUF1rOiU35Az3TttorumcrIg6VGpHJp1vftaiugeTjxn0r0G+59AEoTM5L3qph0syZvIO5/El6LXIuyEQOCZYf6FlCDqIFHLhT6mBbNSuzhRZoa0AnHhJJVja4m5r0lPFWHASmy+EvXEdemQv7E0TD8M5KW2nrgdqOU9/vZM7d8p1TCVaQmgUn3CEgAZNQfNduQu30SF71MNI88i9JU1gTsXqnqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRa7vbF4LYeQIC70b8PNg/GAdorkCBei/1SPggWWBig=;
 b=Xkuon2JpRKyBHUjbG6/wN04Obgi+YQVmASQAWmbyfHi5GQm39FX8r5RRk26FLt4IqsI3F0UoEcCHB9TohPaJpz/vjuulWkZ5yv1XGOB1BA+Hy8A9Ru+ZyCnNUSgdenYIWqV7aHXKx9h5e6CeFKuioEZW1h67e9qdFPglleXs0FWTWV6cUjZbRMQbgfADQbpOBPofCUdLogYXViecvrNbhvNzKR4Ce0fK9jjGR0fsSQXFZj1DXdDtGXPu+cxU/brR45fyfepV68NCBqtwe4OxyV88gUZxhGlKiJV/QgAI7p0FWR/mN0DPYSqWu1iOdBB0QDDjekgReY9YS42sM1qGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB5148.namprd02.prod.outlook.com (2603:10b6:5:48::21) by
 CO6PR02MB8836.namprd02.prod.outlook.com (2603:10b6:303:147::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Wed, 28 Sep
 2022 06:07:41 +0000
Received: from DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::fc8b:2732:285f:a20]) by DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::fc8b:2732:285f:a20%4]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 06:07:40 +0000
From:   "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "Maheshwar Ajja (QUIC)" <quic_majja@quicinc.com>,
        quic_jdas <quic_jdas@quicinc.com>
Subject: RE: [PATCH] Allow S/G_PARM for stateful decoder
Thread-Topic: [PATCH] Allow S/G_PARM for stateful decoder
Thread-Index: AQHYu3ybYwsDUJhrBEKWle+K3R+oZK3XFRgAgB11KIA=
Date:   Wed, 28 Sep 2022 06:07:40 +0000
Message-ID: <DM6PR02MB5148A6E6D2DE6D56DBC17772F3549@DM6PR02MB5148.namprd02.prod.outlook.com>
References: <1661759670-19902-1-git-send-email-quic_dikshita@quicinc.com>
 <43a27419-1019-f0df-e9c5-6982bd2481c8@xs4all.nl>
In-Reply-To: <43a27419-1019-f0df-e9c5-6982bd2481c8@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB5148:EE_|CO6PR02MB8836:EE_
x-ms-office365-filtering-correlation-id: 23b8276d-5731-418d-2edd-08daa117c04d
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lkezmBJp94FptyBAlqlYS6kENWu4MJrM6HukQZ2K4BIf/24KB90GJVeoS7D5Lelgj72P4lW5/2WTbZmQ8/p3q1+dOuOSP07tYxQZmCsXKIGPv6Wpw2kRxL4gRn9PYO5CUBzYxxRVkfI3SDxfz45FYqSIOr4Epz9Dbp6gIBGaKDJa8Um7tFe5ek5IEq9woIUUV8z9V2Bxa8VQiFKPaNd/wp80V3zHPIYdf+gP1iZC8CkVDP1r/06pceI5NOjSeF1HM3iL/uLr/xWvLjhyi/erdt7SalhM2dn7lALM1eUvW23qgTMXQXwnMdGza71dv6U+5ycEG5KeCZ7vPkHBBAU0m3hu8hD60lEWvw5+4v0DgY4UwMwcjaXvSljD3NAca/ue3O7kw/Gq/R8uPkkUlDIsuezlrjtjqfc0byH5xBHzfWjtdngvRS42eqpfGaJ+3jQcHa2kHa+nvn/aeHUmmlgxL63o+9jDNwsahpZ2XGdvZWaMufu7ZBTyVvdEsAnKHjBu4GpYTAhQE6iepfLTmwbz85eJ046y+CQpwlaYYsoknKyRGL3qTqZ8WwkngBYbrrlqKGAaLbsWXQbXABRk35wRCx9JkMqwr0KHZbaSiJkalsNoj7DwcHfWYaPN0ItDhbNt07fgivsyQR0H/XrJjwm5SZdxDQ6o57BP/Up4btfGKqBkkFERNodP351Hqe8lky3pjxAmqNuUGcGj/GUwRozerbth4+Pe+olvTNGiS6kzPk+VFLnChlU34zvPoGsLTKIodm405wXnz4wYPmZxdYarlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5148.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(2906002)(5660300002)(66899015)(8936002)(52536014)(76116006)(66556008)(4326008)(54906003)(64756008)(53546011)(9686003)(33656002)(110136005)(7696005)(107886003)(316002)(71200400001)(66476007)(41300700001)(186003)(83380400001)(55016003)(26005)(8676002)(86362001)(122000001)(66946007)(478600001)(6506007)(66446008)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0dLcXZWMHhoV3BTUFpkcFRudDBSMHVNSEVrMTgrSWEwbSs4TmNsSVAwcTF5?=
 =?utf-8?B?amJvUWhEQXI4Um8yVGt5d1JwR2Z0ZjQvNGYrRkFSYTUzSmc3QmpmR2xHM3lo?=
 =?utf-8?B?SFVJWU9ZcldMT3ErNUoyYllUcEhvZ1NVbzNXUE8zTW9KcGZsZFVDRHFJNmJH?=
 =?utf-8?B?U25lbWZpTWhqRTZFbTNaZG9hU2thVy84TjhmUUlNNmVmY0V4WGswQ1BIYkI1?=
 =?utf-8?B?cW01ejNFSCs3TFRSYXlpblpaWEZIV3plY3dpU0dMaTRVU0ViVlJrakZyTkxs?=
 =?utf-8?B?ZW4rVVBGVTFOT1VBOUw3cS82YmFjZDZnSlY5UVFkWXJFRGh3UXdiZFRCdnZo?=
 =?utf-8?B?cEZyaGQ5RWo0MGZHelBEMXZyczVSMFgraUdqRDVsOFV5NnB0S05YeUVSWWwz?=
 =?utf-8?B?dHhLajhQbmpNYklidU1La0VzU1RoKzI5NVVYTWl0OXE0VWx6MXBqbUJ1TUJh?=
 =?utf-8?B?dXFha2MrNmdxeVMraTFBMi80UlRrY0lzbTZaUEgxV3FhYzF2T1cvdTNwOExO?=
 =?utf-8?B?T1NBdjJHTmNybFJ1MkZieXJVRXA2cElqVXBwTldvZmI4ZnJ5RFVVaTdkOHNy?=
 =?utf-8?B?aThEbWpkc2I4MkgrSTNGcXp4enlPRi9acHZPRExYalZETDRYZ2lQOTk5RFQy?=
 =?utf-8?B?cE5lZVVMWVhQU2g0ZDIrb3E5dVV5MEJmNTJYTEN4S2dyNllVZDVxcUVUbFJj?=
 =?utf-8?B?RFlsVVp2QUJXTDBEbGM3eG5GUmFxejRsdUlXWjdXdnRSYnBrVWREc09RaWRr?=
 =?utf-8?B?TEl5a0VuaGswZzdGL2NLa1U0dlE0ZkZtUGlwMzY1UFVuNVNwUXBOREVuTFIy?=
 =?utf-8?B?V0RrV3U1b0dpa0xHUUpmNjZpL1BnUmN4R0NraW1qNGhYZWM5bXY3d0RQQndK?=
 =?utf-8?B?dWxpd3pOcmZzanl3NU0wbml4ZHZPRXBBK0puWk9kcVNaUEVwd0xVRXZFZVBi?=
 =?utf-8?B?YjVyVng2TlB4akxYbzNPQy9PaWloTEoycG5vNmdmczlwZFRoakFFa0x6dFUx?=
 =?utf-8?B?QnJDc3JWOW1zTnJkRUtocy94Qk5pbUZHb281bVVkM3NmaTNVc2ZnU0Yyazdo?=
 =?utf-8?B?Sjdnb2YyQkRsejlRMThGdTcvejNhOXhiZ2ZYcWd1TFh2UllNdjVNaXBEK1cw?=
 =?utf-8?B?SzFKWmhRMVhhNElUdUVmNUU1RkpKd3J2Y0M5RVhQMUZpTlNDTGdVeFJQU0Ex?=
 =?utf-8?B?eGVPNW9RVUJHZ1RkRDIwOVlTWEdXRTI3QUEzTzdiTDZOR09HNnpxeUxIdnNJ?=
 =?utf-8?B?dC8wTTdKREpBSUs4VHdaVytjRGV4REFkR0w5UHVZSWsydTNPV3N5ZmVmRzJT?=
 =?utf-8?B?T01Yc2hzdE5RbWY2elg5ZnBzM0tOS0gvUUJLZUk1d1ByNUxjeGtIODhlVm00?=
 =?utf-8?B?aWs2QWpTaEtFc0tpRFdHUGxoTE5QMEFaTWxRaU1uR2NBQ3pCVmRHcG5DTUN5?=
 =?utf-8?B?ZEpBdyttWVY0YzVCUTUwRVYxYmZMWS9takprOFIwdEtHL1g3Y0owd1ZnckRW?=
 =?utf-8?B?VnlkalVUNDdUdjJyQWUwdSsxMGJoOEJEd0xacDdWbVBFcDFRNVRuckRHTXN0?=
 =?utf-8?B?NkdHeStNQmZWcmVuRzVBbkxqYktEMEk2K1pRZVBCeW00MVRmaUk3djNSK2dF?=
 =?utf-8?B?QnJFVWV2L0drejlFWko0RkNqY3ZkSld3RGYzVnY5dUxNTUcwVFdHeXhFZFlX?=
 =?utf-8?B?TW82WlRiVFg2b0xCa0VEL1lLckwza0p2SUhWOVFidmJUSTZWU3JGWkpxcHRF?=
 =?utf-8?B?VGlrNENweUErcWZmU3JDU09Va2ZlRm81UkZURm9qUTFaQkk0QjVRdjI4aVoz?=
 =?utf-8?B?Zzl1VzdUdGlFekk4MDNITERncVZrQWpWWHI2V3d4dHFSajNwTXdPaFk4SWVH?=
 =?utf-8?B?UDJnamJndW5JMUhXR3dtVjNoTjVBbmZxaUFRUFRlREdjVzR3SU13MDlxN05y?=
 =?utf-8?B?Wm1LalphZTZlcEh1azdFZWlJdWllMHFTb0tBd1o5Rjk0QXdWZ0FiOERXOGQz?=
 =?utf-8?B?RmF1Y1RYNklaTHh2MDRGeGhYTDlLQW1aZkI5VFdjNnBhaUUyU3hkeUI2MVYy?=
 =?utf-8?B?R0tWdDZYVjd4cUtaWGYrNlJFV0pIdTdySUZVQzkwdzFaUW8rWmVjakFLbEN4?=
 =?utf-8?Q?8Lehno3oudHSpReOvjTwJVKXf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b8276d-5731-418d-2edd-08daa117c04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 06:07:40.8793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NilGekRlwN4ApkkeTmNkptHnYpBCcpr8z5Kb72QWNSLxMpLy6avonxoS4E9deyonROIZ1raO5YssqjFXxEKLLaG3roxCvcOc/dCpGsvDj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8836
X-Proofpoint-ORIG-GUID: TfvwwOmJbqXQC18eY7foyoX73MrIJe2c
X-Proofpoint-GUID: TfvwwOmJbqXQC18eY7foyoX73MrIJe2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=961 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280035
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzLCBIYW5zLCBmb3IgeW91ciBjb21tZW50cy4NCg0KSSB3aWxsIHRha2UgY2FyZSBvZiBh
bGwgY29tbWVudHMgcmVnYXJkaW5nIHRoaXMgY2hhbmdlIGluIG5leHQgcGF0Y2guDQoNCldpbGwg
YWxzbyBzZW5kIGEgcGF0Y2ggdG8gdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uLg0KVmVudXMgZHJp
dmVyIGFscmVhZHkgaGFzIHN1cHBvcnQgZm9yIFNfUEFSTSBmb3IgZGVjb2Rlciwgd2lsbCBhZGQg
c3VwcG9ydCBmb3IgR19QQVJNIGFzIHdlbGwgYW5kIHNlbmQgYSBwYXRjaC4NCg0KVGhhbmtzLA0K
RGlrc2hpdGENCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5zIFZlcmt1aWwg
PGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4gDQpTZW50OiBGcmlkYXksIFNlcHRlbWJlciA5LCAy
MDIyIDU6NDcgUE0NClRvOiBEaWtzaGl0YSBBZ2Fyd2FsIChRVUlDKSA8cXVpY19kaWtzaGl0YUBx
dWljaW5jLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KQ2M6IHN0YW5pbWlyLnZhcmJhbm92QGxpbmFyby5vcmc7IFZpa2FzaCBH
YXJvZGlhIChRVUlDKSA8cXVpY192Z2Fyb2RpYUBxdWljaW5jLmNvbT47IE1haGVzaHdhciBBamph
IChRVUlDKSA8cXVpY19tYWpqYUBxdWljaW5jLmNvbT47IHF1aWNfamRhcyA8cXVpY19qZGFzQHF1
aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gQWxsb3cgUy9HX1BBUk0gZm9yIHN0YXRl
ZnVsIGRlY29kZXINCg0KSGkgRGlrc2hpdGEsDQoNCkZpcnN0IEknbGwgY29tbWVudCBvbiB0aGlz
IHBhdGNoLCB0aGVuIGF0IHRoZSBlbmQgSSBoYXZlIG1vcmUgaGlnaC1sZXZlbCBjb21tZW50cy4N
Cg0KT24gMjkvMDgvMjAyMiAwOTo1NCwgRGlrc2hpdGEgQWdhcndhbCB3cm90ZToNCj4gU29tZSBz
dGF0ZWZ1bCBkZWNvZGVyIHN1cHBvcnRzIFMvR19QQVJNIHNpbWlsYXIgdG8gYQ0KDQpkZWNvZGVy
IC0+IGRlY29kZXJzDQoNCkJUVywgd2hpY2ggZGVjb2RlciBkcml2ZXJzIHN1cHBvcnQgdGhpcyBp
biBtYWlubGluZT8gT3IgaXMgdGhpcyBmb3Igb3V0LW9mLXRyZWUgZHJpdmVycz8NCg0KPiBzdGF0
ZWZ1bCBlbmNvZGVyLiBTX1BBUk0oT1VUUFVUKSByZXNlcnZlcyBoYXJkd2FyZSBkZWNvZGVyIHJl
c291cmNlcywgDQo+IGFuZCBHX1BBUk0oQ0FQVFVSRSkgcmV0dXJucyB0aGUgZW1iZWRkZWQgZnJh
bWUgaW50ZXJ2YWwuIEFsbG93IHRoZSANCj4gc2FtZSB3aXRoIHRoaXMgY2hhbmdlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGlrc2hpdGEgQWdhcndhbCA8cXVpY19kaWtzaGl0YUBxdWljaW5jLmNv
bT4NCj4gLS0tDQo+ICB1dGlscy92NGwyLWNvbXBsaWFuY2UvdjRsMi10ZXN0LWZvcm1hdHMuY3Bw
IHwgNCAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS91dGlscy92NGwyLWNvbXBsaWFuY2UvdjRsMi10ZXN0LWZvcm1hdHMuY3BwIA0KPiBi
L3V0aWxzL3Y0bDItY29tcGxpYW5jZS92NGwyLXRlc3QtZm9ybWF0cy5jcHANCj4gaW5kZXggMjY5
YTM4My4uZTk5NjU1OCAxMDA2NDQNCj4gLS0tIGEvdXRpbHMvdjRsMi1jb21wbGlhbmNlL3Y0bDIt
dGVzdC1mb3JtYXRzLmNwcA0KPiArKysgYi91dGlscy92NGwyLWNvbXBsaWFuY2UvdjRsMi10ZXN0
LWZvcm1hdHMuY3BwDQo+IEBAIC02NCw4ICs2NCw2IEBAIHN0YXRpYyBpbnQgdGVzdEVudW1GcmFt
ZUludGVydmFscyhzdHJ1Y3Qgbm9kZSAqbm9kZSwgX191MzIgcGl4Zm10LA0KPiAgCQlyZXQgPSBk
b2lvY3RsKG5vZGUsIFZJRElPQ19FTlVNX0ZSQU1FSU5URVJWQUxTLCAmZnJtaXZhbCk7DQo+ICAJ
CWlmIChyZXQgPT0gRU5PVFRZKQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gLQkJLy8gTTJNIGRldmlj
ZXMgZG9uJ3Qgc3VwcG9ydCB0aGlzLCBleGNlcHQgZm9yIHN0YXRlZnVsIGVuY29kZXJzDQo+IC0J
CWZhaWxfb25fdGVzdChub2RlLT5pc19tMm0gJiYgIShub2RlLT5jb2RlY19tYXNrICYgU1RBVEVG
VUxfRU5DT0RFUikpOw0KDQpNMk0gZGV2aWNlcyBzdGlsbCBkb24ndCBzdXBwb3J0IHRoaXMsIGV4
Y2VwdCBmb3Igc3RhdGVmdWwgY29kZWNzLiBTbyB0aGlzIHRlc3Qgc2hvdWxkIHN0aWxsIGJlIHRo
ZXJlLCBqdXN0IGNoYW5nZWQgdG86DQoNCiEobm9kZS0+Y29kZWNfbWFzayAmIChTVEFURUZVTF9F
TkNPREVSIHwgU1RBVEVGVUxfREVDT0RFUikpDQoNCj4gIAkJaWYgKGYgPT0gMCAmJiByZXQgPT0g
RUlOVkFMKSB7DQo+ICAJCQlpZiAodHlwZSA9PSBWNEwyX0ZSTVNJWkVfVFlQRV9ESVNDUkVURSkN
Cj4gIAkJCQl3YXJuKCJmb3VuZCBmcmFtZXNpemUgJWR4JWQsIGJ1dCBubyBmcmFtZSBpbnRlcnZh
bHNcbiIsIHcsIGgpOyBAQCANCj4gLTEzNjcsOCArMTM2NSw2IEBAIHN0YXRpYyBpbnQgdGVzdFBh
cm1UeXBlKHN0cnVjdCBub2RlICpub2RlLCB1bnNpZ25lZCB0eXBlKQ0KPiAgCX0NCj4gIAlpZiAo
cmV0ID09IEVOT1RUWSkNCj4gIAkJcmV0dXJuIHJldDsNCj4gLQkvLyBNMk0gZGV2aWNlcyBkb24n
dCBzdXBwb3J0IHRoaXMsIGV4Y2VwdCBmb3Igc3RhdGVmdWwgZW5jb2RlcnMNCj4gLQlmYWlsX29u
X3Rlc3Qobm9kZS0+aXNfbTJtICYmICFpc19zdGF0ZWZ1bF9lbmMpOw0KDQpTaW1pbGFyLg0KDQo+
ICAJaWYgKHJldCA9PSBFSU5WQUwpDQo+ICAJCXJldHVybiBFTk9UVFk7DQo+ICAJaWYgKHJldCkN
Cg0KQnV0IG1vZGlmeWluZyB0aGUgdXRpbGl0eSBpcyBzb21ldGhpbmcgeW91IG9ubHkgZG8gaWYg
dGhlIHNwZWMgaGFzIGZpcnN0IGJlZW4gdXBkYXRlZC4NClNvIHRoZSBzdGF0ZWZ1bCBkZWNvZGVy
IGNoYXB0ZXIgbmVlZHMgdG8gYmUgbW9kaWZpZWQgc28gaXQgZXhwbGFpbnMgaG93IEcvU19QQVJN
IHNoYWxsIGJlIHVzZWQuIEFuZCBpZGVhbGx5IGhhdmUgYXQgbGVhc3Qgb25lIGRyaXZlciB0aGF0
IHN1cHBvcnRzIGl0Lg0KDQpSZWdhcmRzLA0KDQoJSGFucw0K

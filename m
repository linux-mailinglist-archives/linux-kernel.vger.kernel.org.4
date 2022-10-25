Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FF60D3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiJYSpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiJYSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:45:36 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77D5543CE;
        Tue, 25 Oct 2022 11:45:34 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PIXA7M022412;
        Tue, 25 Oct 2022 18:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=uS8pHcHHLkq9zkA3QYC045RIeiTWqlRUCgep45PAE4M=;
 b=EGoVESP4bKYxshog04LmCJybvZnQyWUN6BBm6uDHY03TZn6/1CBvB666vSV/OhvDB+w+
 92wrxa650hYtoNCunZXxs6dq1mc4wvE6toB3QAlV3X3/pdRLUXPk1vJWquwBuBegNTSd
 LavUzV02tmR1M4gx3x7CtRA49QyywHewbC4kzld0/HcazLl58AtRpbrfoWdZwk2TUa0q
 52KhccCMvFuWFBtY1X6dl04ofcdTjcY/R+13rCOGpiANTlyYyWidC8AAqWnwvrjVc+4G
 Ry9KhC0qctJ19UMuZF4+94OE2h8FSMY7s+1xt+fgeLvWBNc3oCCgzsO1+D+75cvCAHng Wg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ken6602pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 18:45:12 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EEA74804724;
        Tue, 25 Oct 2022 18:45:11 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 06:45:11 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 06:45:11 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 25 Oct 2022 06:45:11 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 25 Oct 2022 06:45:00 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp3KauGGpV9eNtWt+tI519rovQcgFMJwZbcZS7VIm3DdwWvCNdKmt1fwW/Fv8G8GRC1BhBLnLzzp5934SLMP9uU8tY29n01LCoUaZS25Xakn8AHPIYiIsa06LBOkQf/NQER/1VCbfHvK3tcZkVYpir3va/3xLSPoUobvtuFbLgIiHyuNYGJBpeSC6dBbqiHnTQrtAbkw2Yf5E6+HFgKMtRRDgKVxdQ3/pHWH4uTJp72zrbm0nx3CcUI8EAuyMHBZtRy54+b5MC/YrZAZfwQMiHyCZK3TKnqaI21UWNSC0fVRw8hFCp1I0sGR+rFimEP0Too5AWCIljEZsFcMldiCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS8pHcHHLkq9zkA3QYC045RIeiTWqlRUCgep45PAE4M=;
 b=PQ5lLjW2oCAr98Wt2xJra8HD7FT0+eomdHeuR62JINUWXfCRI7+Kkkue9eJkyZ69tCXzcJZbkr+Bl/7Os5yjJ+0uhhYx7paVDxOgx/tfJmtLNeOCPTSF2Y58+inTU+it9fjB5r6V1S1PLGtn04WxDTfzZtj/EJF0oPv9uOccnAMXbUTx70mv/0klrXXG8XBm8xE5y6qhHiTlqYaK/R4KxqUQPi6snw0peNPB1C8wciFbOr2vSCWy2/3VLM9XK+7GbUE0hChMWHMjydeorXMPjTkZOGEriScm8AV7NyfobSISYyGv6qtcL6jzEeUnPXWd/2jU4zuNE2Gw17bUL9CWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1501.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 25 Oct
 2022 18:44:58 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c%8]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 18:44:58 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Topic: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Index: AQHY3aMniIVqm01b3kyrrbcxm5Jgf64JpGIAgAGGr3CAD3YZAIADo6MQgAANroCAATMrwA==
Date:   Tue, 25 Oct 2022 18:44:58 +0000
Message-ID: <DM4PR84MB19275D8DB8B27CE0D1A05AA588319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
 <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <820095a2-3722-5c3a-77fb-5a6b6b44e1c3@linaro.org>
 <DM4PR84MB19275A47D7006BD5664E1AF488319@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
In-Reply-To: <d51b7f8d-3681-e19d-3ebb-7e021fc50403@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1501:EE_
x-ms-office365-filtering-correlation-id: 4208b727-72fd-4920-51fd-08dab6b9047e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iChMD8lMsHy+3d5b8nB25OeWzxamhTbwXkaR2rWVntbMx1JTJzJzSurY7CmaG+muLbWfOwL0r23xctKcETb0DwrRZW7UHbniQsyl2yNrvmNW5Ozvlvi3Rz148MRikJHoMctxklhouIG+j5+OfGEYSt6j8DbDHdf+CNOg0257T7P4mAO7nO+Gi6pqt0wy8JvRJMeWGvtpv7QhfSSwhxO8vOeFcxIYpQ8uLk4cBtTxSGNAf0fd+1G5zlXYDikc4YtoW17RY9Sr4c9++WlQjVrB6fyDxgGN4igzEUmyCMWcYN5i2ao7GYTQz0wfuHSp3CSvOi/kCFxGPHvkrlXHk9Dvl7fuTMiiPqMCQqOLn9kWsD2oIlrNE1Cm/AbIxKeI1wCTsgS7ybK6ZYXAVs7WWFC98/2jM/Tp3Hap/q8zWUjD4Py415H0Kp3FHtixjw61riP9pbRLry3X4KLnriADN1V9OA4ykC3WAfJtjiuywV2DuFkjluuQLh4yLsmsyc99t6P07n85xp3cN+d+KkSNJXqOkF/h53vbAul3gKR1USbWGZFyQ9esQgx2XPCMPRlsx4628YvNntyEyA11e8aGNl5uqtbV4KbZI00mSNig2tfHgkaPI1KunqYDanzzjkfDB8le9LK9TOs22m16nOOzTVoZBMViTDh2fJhnVpn1cECK0YW65F+JKbgyENq6cPVPEpfvIVYtQgLx1LFxmbqlqcCDWI4gJlBUXGgmmK/s/6a9JF8DfQFqe5uK54Xyz4A9sLaiCWiuETSqsRFuVrsBwGzHBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199015)(41300700001)(26005)(52536014)(2906002)(478600001)(38070700005)(86362001)(55236004)(33656002)(186003)(7696005)(4326008)(8936002)(9686003)(54906003)(6916009)(71200400001)(316002)(122000001)(82960400001)(8676002)(6506007)(83380400001)(64756008)(66446008)(38100700002)(55016003)(5660300002)(76116006)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnBHSWc0WmdscGJRRmlnak5xVU5IT2NGWjF2a1RoK2tGeURlb2ZXckxNMWl0?=
 =?utf-8?B?bCtyQWUzWXNPS3dPTnFjUDNSZDJ0eWNraHVVRHEzMy9vUVBpSSsydXRvUVhJ?=
 =?utf-8?B?UldPa213UmZDdzVDSkRpMkdlREJlSlhHSWhYRUd5bHlKeld5WndPeFRaT0ps?=
 =?utf-8?B?TFBWSGI3ZE9lUmRnK3lXTnBtN1BXSmxHbGl5UVkwRHRzSHc2R3pkWjNDMUxn?=
 =?utf-8?B?K0QyR2JIQkVITWZyOGdnWEo1SnZnSTU3V3dqeTA1MTdHaGs4dkR1eEg4czk4?=
 =?utf-8?B?TlB3cXBSdWRQMzB6WlEwbGhSQXhmSUtRdUQ2c2xNRkY5V09XY1NFMHdxcU1O?=
 =?utf-8?B?Tk5YSno3Y3ZaQnFJL2c4WXQ0REcrQ0UyS3ZDajRLd3J4dXBwS1prTU8vd0dR?=
 =?utf-8?B?a28weE5tL1RudUpVTzNnYVRjdDc5N0w1TGtWdXNkYmEzb3BkRUhsRmU0OVQ1?=
 =?utf-8?B?YW8yVTZhWEgxM3krMEVMNUNFRURvYnhGcnhRSkRXbnJZTERmblZleUN5cjF5?=
 =?utf-8?B?WDhpaERjWnpvSTZaU1FvaEpuYk9DNnNwK3M4STIwVWhzZXpyZ0REKzA4WEoz?=
 =?utf-8?B?SFlGMTlQcDlKd0k0aEtTaHJUdWxjOXVqTmE0OGJSRzdPTzdxWTdPNy9Icm94?=
 =?utf-8?B?MkJueHBHM3VNTk9wYktTZE0yaGZ3TFVBZk45MlArTXZaeHp0ZFZRVHIxOW5S?=
 =?utf-8?B?WDd1bUNMeEFTQmEvYXRqL2pGMVYxQXdoRnlFTlR2cU1HYzNPTVpoUDRHK0g4?=
 =?utf-8?B?RWhuT05TUnprZVlBMnJvNkxZMFZIMWl4TGRxSElLeUQ2VFBYdk9zMS9lZzNy?=
 =?utf-8?B?N3ZnQ05MVFNhZnBjTnduaDZVNmd4L0RxRjJMem5qSUJFT2NBTGM5cFV3clVp?=
 =?utf-8?B?bWNqQlhCQ1VlcGE5SHZ4VDBpbmtJNHZOZi8rU0NheDY3Q2xzTms5aWw5WEl1?=
 =?utf-8?B?Y2hlbUdQeW43OExrVUN5ZGRtQ3BUdlZFOWlyamVEME84Wk9EclJWV0ppVVh3?=
 =?utf-8?B?QnlJZENXZWd4UFdEY2JRVFc0Y1NRbXZUc3BrY1ZxWG9DWWc2TEhvcW54MndW?=
 =?utf-8?B?RDN3azdzNjFiQUx5YnZoQTIxV2c3VGFnSGRLVDZFRjV2SHgxYnpSUitYRTcz?=
 =?utf-8?B?eFc4OFBEcFU4WXMrdHFVWFpGY2RUa21aeW16WVFhaUVXZ0J0MGZqVm1LSUFG?=
 =?utf-8?B?MTVBSmt1ZXZRdHcwN3RJKzNkem1oOUxZNzlYVHRQazJQaE9iQzFkaVZ0RWox?=
 =?utf-8?B?TkhTNVJFZkJiWDJhNDd5alV1VEtHUGl1NXhVTHNJZFNXVURJT3hlb0RIdWNF?=
 =?utf-8?B?VVMxaGpRaE1UcjZta2MvQVVaY0FIS3VzZGQ5VHZtd0RaWW9oZGNRMU5mMCs5?=
 =?utf-8?B?QVBxZEhyRWFQWk1KaThxdU9HdWUwWU9FQmlRenhEMjMrT0hnQk1tR1NGb0Rw?=
 =?utf-8?B?SnE3eGI1RFBKOWlRdk5CS0x2MkkyL3R3eGtDVElic1R3ZGhQdG9LQ1ExOXJE?=
 =?utf-8?B?UExXb1FNc3RwZTZmSC9qK25OYy9MNDlncEdDZUhJOXMzaUJ0Ulg1Q3MyY3NS?=
 =?utf-8?B?dFY5MVpqZndEUDFVVHJZWEd0MDIrT3Y4WVg0Q3pyY094RW90WVN1YkFnWG0r?=
 =?utf-8?B?a3RpcVJBQVd3dStzOStqUmQ0ZUV2YkZwbS9qUFAyendFa05IYzhRRlV0ZGtY?=
 =?utf-8?B?cU5VcGY4dVg0UkpyNWkzaForMFZFZ3MzYjNiZVYwV0tGank1ZmRGK01OUWlW?=
 =?utf-8?B?bjBSN0pFdzQ5RzZta1hUSkZmcTdQQkRoQ1RFbHAxeDZPamordnpjVGlhMGpP?=
 =?utf-8?B?clNvdk13SVl0RGF0LzRYZXZyMFE2RkFuUFBhaW1IaE5CQVd4enFvRVI5M0tO?=
 =?utf-8?B?QUVWcS9FYU1ITk5IMUlHdkJMMHczS2FkNFdPL1dpd3REanBzNm1ZQmh4aWt5?=
 =?utf-8?B?UFViNEdsdTZvNDg4cThpN1NOYjRRVDNDZEtsRHJuSnpjUHdGdngyMnQ0Q3Ni?=
 =?utf-8?B?RWhNRGNaMmNJTmZxRUhZQ0tDelZrTXhsRDRLQmZEVzNLNEhvTE13QWVJNkdu?=
 =?utf-8?B?RHBHVVpHNHF1ejdxMnRZN2VOeGk5Mk1kbi9sSFZhQ3ZsR1dnRk5hUnRtYWdT?=
 =?utf-8?Q?8ebWFQxi1Y+R9aHHyrol6zTYq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4208b727-72fd-4920-51fd-08dab6b9047e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 18:44:58.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHutZVYbXErZJ1uk+2mdn/kOhpGkxhazcifenkUkhT6RZEku2zHdsw/GYMmRZcycEvr6sP09RJYVgO0bwevDfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1501
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: akAv_jc9opK_d-hvsRhHn8YBCMoSGppJ
X-Proofpoint-GUID: akAv_jc9opK_d-hvsRhHn8YBCMoSGppJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_12,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=761 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250105
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHVuZGVyc3RhbmQgd2hhdCB5b3Ugd2FudCB0byBhY2hpZXZlLCBidXQgRGV2aWNldHJlZSBk
b2VzIG5vdCBzZWVtIGEgdG9vbCBmb3IgdGhhdC4gRFQgZGVzY3JpYmVzIHRoZSBoYXJkd2FyZSBj
aGFyYWN0ZXJpc3RpY3MsIGJ1dCBub3QgaXMgZXhhY3QgbWVtb3J5IG1hcC4NCg0KPiBBbHRob3Vn
aCB5b3VyIGdvYWwgZGlmZmVycyB0aGFuIGZvciBleGFtcGxlIGdvYWwgb2Ygc29tZSBkZXZlbG9w
ZXIgb2YgSTJDIG9yIE1NSU8gZGV2aWNlIGRyaXZlcnMsIGJ1dCBlc3NlbnRpYWxseSBkZXZpY2Vz
IGFyZSBzaW1pbGFyLiBXZSBkbyBub3QgZGVzY3JpYmUgbWVtb3J5IG1hcCBvZiBNTUlPIG9yIHJl
Z2lzdGVyIG1hcCBvZiBJMkMgZGV2aWNlcyBpbiBEVC4NCg0KDQo+ID4gSWYgdGhpcyBpcyBub3Qg
YWNjZXB0YWJsZSB0byBkbyB0aHJvdWdoIHRoZSBkZXZpY2UgdHJlZSwgc2hvdWxkIHdlIHJlbHkg
b24gaGF2aW5nIGFuIGluY2x1ZGUgZmlsZSBmb3IgZWFjaCBwbGF0Zm9ybSBpbnN0ZWFkPw0KDQo+
IEkgd291bGQgc2F5IHVzZSByYXRoZXIgc3RhbmRhcmQgTGludXggc3Vic3lzdGVtcyBhbmQgcHJv
YmxlbSBpcyBnb25lLg0KPiBZb3UgaGF2ZSBmYW4/IFN1cmUsIHdlIGhhdmUgc3Vic3lzdGVtIGZv
ciBmYW5zLiBZb3UgaGF2ZSBwb3dlciBzdXBwbHkgb3IgYmF0dGVyeSAtIHdlIGhhdmUgc3R1ZmYg
Zm9yIHRoaXMgYXMgd2VsbC4NCg0KR3JlZXRpbmdzIEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciB5
b3VyIGZlZWRiYWNrLiBJbiB0aGlzIGNhc2UgZm9yIHNvbWV0aGluZyBsaWtlIGZhbnMgYXMgeW91
IHN1Z2dlc3QgYWJvdmUgd291bGQgaXQgYmUgYWNjZXB0YWJsZSBmb3IgdGhlIGZhbnMgdG8gY2Fs
bCBpbnRvIHBscmVnKHRoZSBwcm9wb3NlZCBkcml2ZXIpIGp1c3QgdG8gcmVhZCB0aGUgZmFuIHJl
bGF0ZWQgcmVnaXN0ZXJzIHdpdGggdGhlIGZhbiBkcml2ZXIga25vd2luZyB3aGF0IG9mZnNldCB0
byB1c2U/IE11bHRpcGxlIGRyaXZlcnMgd2lsbCBuZWVkIHRvIGFjY2VzcyByZWdpc3RlcnMgaW4g
dGhpcyBtZW1vcnkgcmFuZ2Ugc28gSSBhbSB0cnlpbmcgdG8gZGV0ZXJtaW5lIGlmIHRoZXkgYWxs
IG5lZWQgdG8gbWFwIHRoaXMgYXJlYSBvciBhbGwgZ290byBvbmUgc291cmNlIHRvIHJlYWQvd3Jp
dGUgdG8gaXQuDQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lucw0K

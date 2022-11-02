Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4D615D07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKBHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiKBHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:35:10 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93336240AA;
        Wed,  2 Nov 2022 00:35:08 -0700 (PDT)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A27URCZ025279;
        Wed, 2 Nov 2022 00:35:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OeOU6LvmsQ+2tIGVw/0wcQ6QrZvG6W8FGlz3DwE60q8=;
 b=ZmSYpCibXPW9rLnr22RjdjW5AUDG5aJgAiEQFRfW/6IwlOhwBjJH1esFOzaawImT7lXc
 i0r5cG0XxGjO9p84FxMXA5gpkdU9jJ8iaOr6ZqXRFsAbyGO+cfH4WlDs/2RXaWwv2KNT
 0jjDCLivzyFM8fpiAJ+ge8Zn01n51hWRJjsH80XteD+qEgYVw6VFAET0tqtbDP0CGMTy
 k/Dd/WPS79J4GNxkL6baalU1+w5gCnpplvfLRdRSp9STunGwDRIwiBvzNwZ1zsMvWUe+
 ROBCqNwuelpf30KxvURYzRf4qid9iwFdX2VBH/LrvXYTfQpRLpqVoghlxf23uLNLI9ld Sg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3kkm7gr0yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 00:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7A4MzHSWR5wUVKRMtl48iceDSxzIOkZSPHCsF7fDaChQJ9pVQTGTzN9UGoxJgwQE/3ajObCjEszfWvvNLZUkvii4ZmXoUZHfLk2HOFUZ3LvrgOromR54Gku/qd88i2JbDI3ecOlrbuXboolJZEHHOOw4X86xVme+5YIkPWKL33xpMrDftD+c8/mEc7f6DZq5lNoXMfzvGTf/v9FQFtHhwKpu+WqHXxDnuUZmfDYoqvZ5APJuFu1rPw2Rf41HySTP+Ecyoji2zNxYRLM9ZhIwgxR2/xn122meaPOd0q03PVgdp0gBTXRmtHl84Ics/ttH6MN3cQSqlsEFqhe7C5gYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeOU6LvmsQ+2tIGVw/0wcQ6QrZvG6W8FGlz3DwE60q8=;
 b=QvXpsjutJy5TWRtd0aj4/BukANnNsCfViRYQhPD2HVj/ZOw91swCs9xjuVKvX6BbjK1xQeXUOigjZvv7br+Xloh5xmeiPn1YsVzVsKoTj9p2Xq5Npw5EUGt2pIAUEmWHoLvhKepHzhiiCZf24yefs7LDh8ekYT4ho32Wfm1E7P9YucW6wrozdV89TqgT7TO/crK0Wm8kVC3J/910bSoXtVgmktA6jJhLYBF1DnefTX3MKihgVbuO/ZvYAH5PjqnX4G9Suqb51efE+yUIsngOSAGMD4ejkT+XZznxkQ455ZzRWlZ3Fqro0R/ZcDrHKEkc27AIMRmtj4lR3/DSK4UVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeOU6LvmsQ+2tIGVw/0wcQ6QrZvG6W8FGlz3DwE60q8=;
 b=mOhiy6gbB2aRi2+iRfLJyU/HKM3ZMI0LgtNmHCIOyM+lJKG+RWT8G+S4oAJuVbtSt2KCbTsvu4AhwACXWS49ZpIV/CNL4xII8FVavM0dO6ZEwgdmFT0DNr83cxc6SRkigzdbaZ4YG66MiYUgZXYONe7KvcSgZsWTPfgEd+c+x/k=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SJ0PR07MB7550.namprd07.prod.outlook.com (2603:10b6:a03:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 07:35:02 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::ea7c:b79f:752e:1afc]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::ea7c:b79f:752e:1afc%4]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 07:35:01 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3] usb: cdnsp: Fix wrong transmission direction of EP0
Thread-Topic: [PATCH v3] usb: cdnsp: Fix wrong transmission direction of EP0
Thread-Index: AQHY7bm9uUxk3j0ujU6Lr3b5nXqmSq4p0U6AgAFt4aA=
Date:   Wed, 2 Nov 2022 07:35:01 +0000
Message-ID: <BYAPR07MB5381D40A2B48BCDEA6ED305CDD399@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20221101044433.5627-1-3090101217@zju.edu.cn>
 <20221101061730.8991-1-jleng@ambarella.com> <Y2DqOefwSAjmExof@kroah.com>
In-Reply-To: <Y2DqOefwSAjmExof@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZGEzMzZhYTQtNWE4MC0xMWVkLWE4NDgtMDBiZTQzMTQxNTFkXGFtZS10ZXN0XGRhMzM2YWE2LTVhODAtMTFlZC1hODQ4LTAwYmU0MzE0MTUxZGJvZHkudHh0IiBzej0iOTkyIiB0PSIxMzMxMTg0ODA5OTE2MjY5NDQiIGg9IkxTVGg2L3EwRTBwSGg2NkV4Y2p0SHdsQlJ1RT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|SJ0PR07MB7550:EE_
x-ms-office365-filtering-correlation-id: f0f4f222-baab-4eb3-4209-08dabca4c067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4V2iot1xZR3XQtPj26akKGkLP+/el6uJsH1+Xz9JIC8xvmvJZwopJMlLNjWXdcYwhIeWT6Z7bodIbaE4QztKg/Il05+J8+3QLqTBcxCq05KtQGI9x3qCmAmvQnpK2+8uOPSeRi0qfCfmoSD2asnX1D7Mf6Ervo5BlaJDZGBIR8laCHy49LOF4PsKpe3Njg4LAR6mWXzPw3LODlmzS1xscEszi+ZawconnkTMLAyFMqww+eZjChAwEOBLKHGowjJgOREtERVFMNyU9bW+xUHYgCNWYFaR2dmdZfJ5A8frcMk6kJcH4FHBgagRstgstzK2DjZ+9XhQAs7cmrUkNsph99D1saNoQYT40lZmaglT1lf8e6KzQ9LU/UG42rwVvYjqWeHzzaG8E4zMdtF94zIxLxlc0WiNgqib50CSojZE3yeZDmI7Zdm89rxcHq6l1PRxW7pX4od4NC25bIA3WNBm3rtQOe9wvTASrtBFVpjbbKfsDT1XvHkYfWIAHwgZZNW7XSnN8WkRuyv6ksdkMbTFuOCeycdc/XbZTxKvitM0t6JOB691WIno+fyvVL266V5ES8kMkxRKVp3oZSsV585XSHGWZrJmVGmNa0fpbq4D/OHG4pz2a3sSBdZYT7D8Hf9m6lYQtdDsp3juzRYhyAdrZQt8DiCyF4mMx3Xe3NUGraC6BbK8qcTHIGRzQEolkxds9CrPCnr3lhoYGI5WqBsm2QwAzFSjfCdttgWFEwmdy1jlaTa5uvzpMght3J4JHMbou9JKlayl3PzPjyEgN4Jdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(36092001)(451199015)(316002)(38100700002)(4744005)(2906002)(5660300002)(122000001)(83380400001)(33656002)(52536014)(26005)(86362001)(38070700005)(9686003)(7696005)(186003)(478600001)(54906003)(6506007)(71200400001)(76116006)(110136005)(66446008)(55016003)(64756008)(8676002)(8936002)(66476007)(41300700001)(66556008)(4326008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FywoJZsYe0cNej/N6/g8EU0OGAXzEw4iDxnmQL7tOjgBgoun3b/7zPe+8d/s?=
 =?us-ascii?Q?f/Pkv0ksyBXvyvL3C3MxuMSwwMlwLDgcLXHAuKbqg1CAMBu4qVMtejUkF/Nc?=
 =?us-ascii?Q?zgzhmqillKGx4dkV1Bd1SSCAboL9G8KpnPSwdLlGehe3UXrWLAJF+yvJuV0J?=
 =?us-ascii?Q?4y77CWxikGJ8d1M22brMGE0h8mvB2NmqfXe300d8pyoLAB+I7DQu85KQv1Fu?=
 =?us-ascii?Q?vItomMO1mEYtOPBkG34rnRbNPXxLnxOBu6thzw7nqPCJLQfFfO6uLkol7Jhy?=
 =?us-ascii?Q?bcM/K7OJ1TBtj9Gr9NlYpMDeV4j69EwEXnlFd30U9IW7hGCzUEfK8/KMw752?=
 =?us-ascii?Q?RO2vjShq3VAf1+qsetyFwRYbNjNrq4spUVcyWrXiFKr8GjF+QNfPhFUJcY/L?=
 =?us-ascii?Q?ZE8kr0NnmkH23zqoVr93FgtYLVNFt1XQrWN5Ngh1m2jXy/YWgm/I+T5XbazK?=
 =?us-ascii?Q?fwtF/fMNT6k1CA+GlLNuFp1lyPcHkOZERnruocLDlym6iaVWZ7mQNjPC/ASh?=
 =?us-ascii?Q?OH0jBjoH+rDjO26WO2FqY/K9uqCSPVad4FfnbI3SsdoOS6j8O/3IhdFiFJdU?=
 =?us-ascii?Q?aY8yH/OaoQ+lI0FcBeSBQAGq9VEXVK54kU8Teurk76evOGKR4rS1ro3uIV6n?=
 =?us-ascii?Q?NCsG4G2oLsljdb623w/IWR9dAg0NqVjr0Ii7jg7/PJ29I2SvkrMXFOiB3ZkZ?=
 =?us-ascii?Q?Ujoto/ZLb8AOCij4iI/AmLH9+DTCma+FYzhsP+PHFGSXv1T2p1hrSZFmHQlv?=
 =?us-ascii?Q?fIu4mlcAZZeyp5/e0OowTY0H4OZ4vXvyeviksMnJQTkwvsZ3fHOp/svJ4hA3?=
 =?us-ascii?Q?r6a4+YfN4LnaLuCD/ZntA4wudGS2OoOky8GZ9WHzOjJvDRytyKOCM0bA5Is0?=
 =?us-ascii?Q?sObGhXap6K8o9DJtOo0nga36h7nHPTYHNAiZPdhHYtcqhyckG/mYnbrRowYg?=
 =?us-ascii?Q?jL5PL+2psYs+JpJpzb7n+KkYlvJDPOC6MA1Y6q1IGEjW3O187ptDAR0Qg5Bd?=
 =?us-ascii?Q?MHZAtIdDNIDQvvrow146xO5pih0c0jTi+8xk7JXJhAyvfnvlParZkiR6ZICV?=
 =?us-ascii?Q?N6xZDwhv4iPJ382SoryQamRSyF15im7M95xRIT+COA2H9M8e6PqQELYeS90d?=
 =?us-ascii?Q?mbNjQr0VqxafPGsItZhEplF7hRQ9J/+wBDv3NAWj+WQDn5hqIE5nsKyPBVwr?=
 =?us-ascii?Q?sjFPQJ/9Z+BTteRnWeE7+978DtNb97lluJp+dzWQkylfNGpnTH9HXILtTwW/?=
 =?us-ascii?Q?sg9FzUYQAVU3wKfT93GO+PIn2ubiL1axM9Em5HCZTnSx+0Ri3t9bLhmdH5Ho?=
 =?us-ascii?Q?AEDwd6O/MALsSc3zsGMPtzCM4Rg7gP0OglMvMyIOV5EOkiJxMV/7ImEXnlw8?=
 =?us-ascii?Q?4WNaGr1sZTU4HlqlYdmIwR0RmoesitrH3ZvFbeeRZ5Ip7gjrtaW4h85Xj4us?=
 =?us-ascii?Q?5F+0nAnpoF40/d84PjufRYHDYKep3xQaA2HpWAz5W7IFto5+QwzB3nb9U+sF?=
 =?us-ascii?Q?Y9D7X0MjNnsFv3jPWirAmSdvigYpFlvo/XRwYAWDWHMXP8kk1OKq7EBkxHK8?=
 =?us-ascii?Q?GdMIeM4dLm4ZC4nzj864k7aizqGIOnH57l66Hy9+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f4f222-baab-4eb3-4209-08dabca4c067
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 07:35:01.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jat3gu4K+vpHd9F2lbLOl6dfvb5dQwkO52tqLMWVy2onwhr7+cVp7TQImvWGmRc0SzZfN1unC/NBxU+yGGosorcHWOWJcE/mDDOWijzZm70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7550
X-Proofpoint-GUID: IWbxhE7zdfbU_JFVtpe8PwfAbKu07aZk
X-Proofpoint-ORIG-GUID: IWbxhE7zdfbU_JFVtpe8PwfAbKu07aZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=560 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020045
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Tue, Nov 01, 2022 at 02:17:30PM +0800, Jing Leng wrote:
>> EP0 transfer is bi-directional, but in the cdnsp gadget, the
>> transmission direction of EP0 is not changed after it is initialized
>> to IN, so the OUT data from EP0 received by the host is invalid.
>>
>> The value of ep0_expect_in will change according to the value of
>> bRequestType in the SETUP transaction of control transfer, so we can
>> use it as the transmission direction of EP0.
>>
>> Signed-off-by: Jing Leng <jleng@ambarella.com>

Acked-by: Pawel Laszczak <pawell@cadence.com>

Thanks,
Pawel Laaszczak

>> ---
>> ChangeLog v2->v3:
>> - Repair my email address.
>
>Yes, it works, and it's validated!
>
>Nice job, thanks.  I'll let the cdns3 maintainer review it first, but just=
 wanted to
>say thanks for fixing this up, it makes my life a lot easier when acceptin=
g
>patches.
>
>greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC96E8E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjDTJvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjDTJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:51:15 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2A1B6;
        Thu, 20 Apr 2023 02:50:49 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K7FKka005133;
        Thu, 20 Apr 2023 02:50:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=v9Fjvh6bjH5MpumYTOS2LM6xznN6XyZ/NhhFQ87feYE=;
 b=Dg7BLo+zXQ6DgjEkSAdG5/lSmzU2dTvdQ4ua87NgwX7vWfE0uOotCET1XPUlBeQHPgv4
 wvr+S3wD9DbpFTaPg51cQpRIFW7PPZSDGciKH61zbR17A7KAlrmxOQdcbOsEFqt4h5zO
 lCudsjog9UVaZXE0Uk6pDrcQGVWdsODL6Mp29BAaM2dsHpe67rNZ1XJ1QiKQpmRf62pr
 GHTC9o5k40XYyDT2heRiIVYyPAv4CKl97OJbHlkkiRgJq1YDNDY1iWTkB3eSXyqL8IOF
 EcdYI7wHCXmtL7uQ3HrrTTOXjLlrVjVwJjO1HX42+A4SZCNX4HbgSSghwxbVIZ3mCt5+ Kg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3q1x59agx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 02:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1rPaE4dXjFDmN6Dy6bPKk+503V2l/aUOzr/gZRWB7HxBGhWP2ed9enn4QTv//7s3ha3g0zvgrkeoaWpFp3od2M19Z77duaa6YZUA/eOcby1QYNbdm2Ji3wycHo9bbKJ5Lqp4TNAfrGXuLijSi/8spu5C3vqosNhskNhEqfCblksmZ4a4d+RFFaZNSIjn6khX1YBVbkSqnvwSQdmlBCLePkDF7XQxUQdcDL6w8J4CxxcEPmwQkeWS1rMKZj1ubi839dV1juuOhFFvibbptKukifXkcOhT8ECdOdLDJsc4BlvFg8kZgVlrsNXVQRFyBpuI3iSN7RhyoMqr65oP6G2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9Fjvh6bjH5MpumYTOS2LM6xznN6XyZ/NhhFQ87feYE=;
 b=dQo/xu1nIYV0ylpnC2BC/FhyqaIgT4UoVw6f2Tct8fWlCnqSc4QdjUO8uQhvxaFtvNbOYGGadZsOgDe2tyeDJ6VcqzqnYAITuTJXU5ptIjT158wCYpOt0p89N/GhkYL4i643Y2HhwaAwaX9x7K5maBZuXCwpEZnP322yPBSsHgnOHy2GYJNMcQKqpUu7nYn9oB0HM8gw5qLN19O6NfKl3NrZoCr+t3Rb4sZ+lf3JX63YfhdzfMJ75k5kOkNumnwVxAxdi717leNCS5pPdaOauW9fFs9ZJX8MgdoRrBZ6JBVSaO23CPCwBBG1bWOIXKIRK07kV5cL3THL+DFKrXbltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Fjvh6bjH5MpumYTOS2LM6xznN6XyZ/NhhFQ87feYE=;
 b=gIcrISozfSOpz1s/csDH9XD1WKmyLcBy/Jz9FxmQMg2Y0qTZTWnX21AKCIMMsIueJpx52wIIL8LquQ63/6M49drlySkGmNnnmr5XpbcrEuB70KRt0bOEbxTBDkH7TMYSgG+bjR8cHWTE1kCiHrt0gZR+gRNVn00JxUGTkKL/paw=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by CH0PR07MB8795.namprd07.prod.outlook.com (2603:10b6:610:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 09:50:15 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::343:e924:8155:ba63]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::343:e924:8155:ba63%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 09:50:14 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Daisy.Barrera@siriusxm.com" <Daisy.Barrera@siriusxm.com>,
        "Cliff.Holden@siriusxm.com" <Cliff.Holden@siriusxm.com>,
        Tony Lindgren <tony@atomide.com>,
        Jean Delvare <jdelvare@suse.de>,
        "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
Subject: RE: [PATCH v2 1/4] usb: cdns2: Device side header file for CDNS2
 driver
Thread-Topic: [PATCH v2 1/4] usb: cdns2: Device side header file for CDNS2
 driver
Thread-Index: AQHZc2av3olF+/G9L0KBvosdFBYx1q8z6x+AgAAHLrA=
Date:   Thu, 20 Apr 2023 09:50:14 +0000
Message-ID: <BYAPR07MB538177517C763C5FFA969ED1DD639@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230420090101.80812-1-pawell@cadence.com>
 <20230420090101.80812-2-pawell@cadence.com>
 <acf525da-9a22-472f-abbb-6d1519be8d2a@app.fastmail.com>
In-Reply-To: <acf525da-9a22-472f-abbb-6d1519be8d2a@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYmRlZjhlNWItZGY2MC0xMWVkLWE4NjUtMDBiZTQzMTQxNTFlXGFtZS10ZXN0XGJkZWY4ZTVkLWRmNjAtMTFlZC1hODY1LTAwYmU0MzE0MTUxZWJvZHkudHh0IiBzej0iMTk3MyIgdD0iMTMzMjY0NTc4MTI0ODk4ODI3IiBoPSJQUzVycXAybDdFVHhjT3hjclBIejhlQnpjVEU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|CH0PR07MB8795:EE_
x-ms-office365-filtering-correlation-id: 157595d0-4ea6-4cf8-091e-08db4184a424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zm73WaCou8qDTIW4tftpiJwXRpVVL9v+BzOLM3xs007xvgNgG58EKlWyaunL3nWZn/fKHXAnxqR80b6Rotwx6tpxGN+1UxTOvRWdP7F95yUKQXh3g+tb4E4d893fN/xylFHIfue9xyic+so/n9i84FLaAaLmhxELLxlzOANgJLh+I+fSvI9hRW73vKLcd6MZXH+vZyeVdxy5FHOyoiq8b6Uf58kaUvlI1s9J8cVpntmpurA3cBwCPdasgy3M75Ad4P2wW32T8NlMFDE37CoEkAiBhF6Uze2L05tpuObrwwtR96oVafzDsBWxSEMpAJ1RRi1v13kBp9Ug5LGlmdAR89QPFOxqQTj9OCqDtsAvjsoRvxP/IvgDPw7cPKaJE3oUXNucgC79QAOJi3VbSmO4dq7K1zB2xCI/GB4eg9LRa4jYmrubGWQ194fie6xAGRjm41PdBzTNpcqHcWszo/Rb6da1QE20AkuUP92rn7hJwBm1vTSpV7cjmI8C9FGjnDCc9OoguKcBMQvV5q1oP3IbtDY6k/e1bCucRSaIItHYhf4QuJXCwr0/GgENBTd5eM0iRX7a+PA256UzAGy8lD6mHh/uMX2fvagSm3x1IBCc8EdIY2TI7hQcEn4EXW9bAlG+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(36092001)(451199021)(66476007)(38070700005)(38100700002)(2906002)(122000001)(8936002)(8676002)(86362001)(7416002)(52536014)(5660300002)(33656002)(41300700001)(7696005)(55016003)(71200400001)(9686003)(26005)(6506007)(54906003)(478600001)(83380400001)(186003)(316002)(110136005)(76116006)(66946007)(66556008)(4326008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dBCdVbM5rKlFQwalQTTR4h82WzCXi6PSoRZsL1XyxQskfGdtEFuUX/YTVfgI?=
 =?us-ascii?Q?IWjAbDwwJrKA3U4zyPw99xsL5qBD0aRXT0UVskmSsw1cUAbPXMGDMZ7QZ4zq?=
 =?us-ascii?Q?ArIXOcOuv5x4nQsBCOvONzxuLnd0lqiKsjNuoPyyaswD6nEuVqoJkGiRirtB?=
 =?us-ascii?Q?5ddjsJbc0H8ANytDhW8THRp8gLFXkeaMZ2s0rxSfJFcrxShM9+1mibrwaHxT?=
 =?us-ascii?Q?uuTew4SwRr/ak0eWLPb7WDLP4zS9icMPoojDUfRUPpqa4X1XCbnx5wPo+G6Q?=
 =?us-ascii?Q?XuMt32PmTlIwYtBaKRTJ2ujOQ8qf9BsxgP88zTyJ4JoamvEnwkaGfaeXUO3D?=
 =?us-ascii?Q?LTKD6sSVrcXtUwD9rQbOPrMW/y0GaD8fMnUQR4LdpEl2/AwZURJtw0cG13BA?=
 =?us-ascii?Q?w5rvpu9pqqVpnjZtP7yMiyUtr1AmKRIDImUiXqNuEUfW+AQ33MoZ5OzYaEMT?=
 =?us-ascii?Q?T4NztWayM39nARNqES2JT/UE/pymOr8qM43Ov/JUyGcSzV4mPwkKUdcmQvTa?=
 =?us-ascii?Q?hDZbz0+5GdRpPNUDaFn9cfnzyxRaGzNeVqqjJp1ywuLIlOsG4EwAbiI2iIEC?=
 =?us-ascii?Q?eIyE8MxsCFRWo94Bbell0UveU4JWsiPgEN05MvJpX1rmWg+iN5bA6mcVUBjP?=
 =?us-ascii?Q?Wnj5Um9tRsqc/yCan/2vkIRM6Ep9eX2u5IBzLNMywSF1PdfWe2PXCBsSsuKw?=
 =?us-ascii?Q?rUXYu2D9AVH4cjIWDKG/aBl2/+L0FxK4LrI1krYWRAwo7b5Qg5Rw0Rg6GKcR?=
 =?us-ascii?Q?8IykT5Da+8j9zQM1BsdxlN3WQ4DyvA2UHore10z8MFaGdeiv4JRwUuXLWbiz?=
 =?us-ascii?Q?KdwE/YtnAYO7YPln1Wa7g1gl3ZgzwGm9Cf0JPYpzC+ZrtG9HHSLFq5nAatIk?=
 =?us-ascii?Q?zidSSXUPonIJThghoh1TL+xxm4V/4bQC/B+jaXnZdC9RIrfx0YDY66vCsSSB?=
 =?us-ascii?Q?6ofR0XTfiVDuds+Rf9CiD/F5ljntJ/9X/qVHx8tEIToGH+KqaeJBW94BfPx6?=
 =?us-ascii?Q?Ma2Plcu6ay0MLGUr8k2Ymm1LRc6+i8j6I4oPWqTUtZdjtwVzOYwNnzKTf2KC?=
 =?us-ascii?Q?++w6mlVF5QHk061egboQoHFjCG6RQjlEw3T46wfrU+ThSgGORDwoMcGaKDcE?=
 =?us-ascii?Q?OpJdNJajC4LCV9nxXd6a4VbNQOSScmVKZohLkN/x13fwk64F+ZPyd2Equbg7?=
 =?us-ascii?Q?3VWrU8yQ7pVeGdIEWLb+VDH1Wv/mP9KHpATRf/LnHNFAE02EfYlArkdsSmiZ?=
 =?us-ascii?Q?lxqCE210jC/V4YaX9VRqbM5esMSnbHEENgaXvOFuw/sUx0jsGG7KZp0/Attz?=
 =?us-ascii?Q?Z+zKw4pwKu/fL1MiRjNW4VK/JTIGJGyyq3LK6PIBYVvxmUZ27eUpPGgWCZwL?=
 =?us-ascii?Q?jJ79qSlFG3QGV7XZAc8ZzRYGjEv5EnM/7O5bXZzppbCPxTve8bs/Gv8BlbTq?=
 =?us-ascii?Q?oqsw4z4SpDlxZkjpp6i8Ju4K1MofdpvOQfm+MGhG01b+JhrbaLS0pJcZACsz?=
 =?us-ascii?Q?qa1vawvkWVWVKGeFmvwSpxU5Vpf0L8nyzBuD7xRR7G/b5MB/iY9axW+eVlzy?=
 =?us-ascii?Q?z4kCBTHxOR+USjPdjQv5SDGEtcz6U/u6XEb0Fo+l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157595d0-4ea6-4cf8-091e-08db4184a424
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 09:50:14.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k91SlMJQdD5K6Ii7F/a5ZV4DsbHzU+zKMouwty9FLB8erUq3U/w8Szn7I3X6/tZ44jeJ8w3EHiRdvy85MwH5Qpo6Pb41SJ74jIKzxgVNYsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8795
X-Proofpoint-ORIG-GUID: WER7iVJ7ayEdmNGVyofyrv57KFnc4zaV
X-Proofpoint-GUID: WER7iVJ7ayEdmNGVyofyrv57KFnc4zaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 suspectscore=0 mlxlogscore=383 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Apr 20, 2023, at 11:00, Pawel Laszczak wrote:
>> Patch defines macros, registers and structures used by Device side
>> driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>
>> +struct cdns2_ep0_regs {
>> +	__u8 rxbc;
>> +	__u8 txbc;
>> +	__u8 cs;
>> +	__u8 reserved1[4];
>> +	__u8 fifo;
>> +	__le32 reserved2[94];
>> +	__u8 setupdat[8];
>> +	__u8 reserved4[88];
>> +	__u8 maxpack;
>> +} __packed;
>
>> +struct cdns2_epx_base {
>> +	__le16 rxbc;
>> +	__u8 rxcon;
>> +	__u8 rxcs;
>> +	__le16 txbc;
>> +	__u8 txcon;
>> +	__u8 txcs;
>> +} __packed;
>
>> +struct cdns2_epx_regs {
>> +	__le32 reserved[2];
>> +	struct cdns2_epx_base ep[15];
>> +	__u8 reserved2[290];
>> +	__u8 endprst;
>> +	__u8 reserved3[41];
>> +	__le16 isoautoarm;
>> +	__u8 reserved4[10];
>> +	__le16 isodctrl;
>> +	__le16 reserved5;
>> +	__le16 isoautodump;
>> +	__le32 reserved6;
>> +	__le16 rxmaxpack[15];
>> +	__le32 reserved7[65];
>> +	__le32 rxstaddr[15];
>> +	__u8 reserved8[4];
>> +	__le32 txstaddr[15];
>> +	__u8 reserved9[98];
>> +	__le16 txmaxpack[15];
>> +} __packed;
>
>Register structures should generally not be __packed, otherwise any multi-
>byte registers will be accessed as individual bytes on architectures that =
have
>no unaligned load/store.
>
>If you are worried about struct packing on OABI arm, you can mark it as bo=
th
>__packed and __aligned(4). Most drivers just avoid the problem by not
>defining these as structures but instead use macros with register offsets.
>

Extra __alligned(4) is ok for me.=20
From performance point of view the accessed as individual byte is not a pro=
blem.
All these registers are used mainly during initialization and enumeration.=
=20

While transfer, when the performance is important driver use DMA registers =
which are
32 bits and are aligned.

Thanks,
Pawel



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D570B66B340
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjAORlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAORlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:41:18 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDAC643;
        Sun, 15 Jan 2023 09:41:17 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FDngTS005019;
        Sun, 15 Jan 2023 12:41:07 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3n3t6bcxg1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 12:41:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/yQtvfDRYbD1UUrGylCmfoSW88WHzUMGxp2Tobii/v51yZI6e17VH7opOFUizt2AmeocnM/u+M2fyxEMexDwnA6QzWxjer2RT/fj6VRz/nP+w+TPtNiDcq7aIvhVpWW0IAc7Xn1D7FLHYP05S45votT1cAkFjJojjyOFw0r/vdsuPPjEXhg14yGKI5w+erp71PtmI7Erq/TM3nK0ANx2WxY2+ooQmIklGr6hIWYtAPbLYrcmPlh9TAFwY3K0QAqIkaP5Um57s0F+8nj8EUZo9fC/tjY67GZ4lpIvxyzanQRdsCqGVlmsaCQlBleUelQG2mYz/0bl4XmZmFTW12jXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5pw/3J27HcamFOVPHR22xWVdp8aJPYl4RXcrLztkJc=;
 b=RRly9k3pqG41WNG6VYkPyuo148dLQPUQ9hwTAA5qowGD/oQ/cFgQb6p78sfqAlS88WUzPiQt6mrSQxHAFrUJhr34t4vGlbsF3v71J/HfjdFz5zJv6PtKMNQdS0k/vG/EUtRrejSu1FjO4xhywLxRxH/3Gu0I8bE+9be/O7qXCCNU4VQYqgS/BksszaxHRzvkKQSabj0kycVV+m3q5SLKNpK9DHNg2lud0DKJ3ieQoy7WVtis7DlFeJCSPOIIjP7ddNyI5kwnPsvCFpsYUVaC3+9+texX8glm4c7DUNk2rDkFiDESodM5I0QsGG2JhOULRlgASHgkUXwD1cr1r/dC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5pw/3J27HcamFOVPHR22xWVdp8aJPYl4RXcrLztkJc=;
 b=tqJl5gFAbHlb+LqE15qnPvn0iPYVADDM7bWzIbkO9t5UKAnDSToNSyr8fz8d+UOaRI96wbqWK6puq2bDuNKwDTVVZy4U4py9A61ih/RoYKkHibcfx6fzrUaNBL1c5bXjtJPRfIOgCYr7zAaMg9JQ3ZZMxXvPZ9OlQrbKfvAy1gI=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SA1PR03MB6532.namprd03.prod.outlook.com (2603:10b6:806:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 17:41:03 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9%3]) with mapi id 15.20.6002.013; Sun, 15 Jan 2023
 17:41:03 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] dt-bindings: regulator:
 adi,max77541-regulator.yaml Add MAX77541 Regulator bindings
Thread-Topic: [PATCH v2 4/5] dt-bindings: regulator:
 adi,max77541-regulator.yaml Add MAX77541 Regulator bindings
Thread-Index: AQHZGXrq9GaVXcoaG0SgDZ9yfIPnAK6BXoEAgB4y4JA=
Date:   Sun, 15 Jan 2023 17:41:03 +0000
Message-ID: <MN2PR03MB51688C9858CC8CA7CACCDB22E7C09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
 <20221226223839.103460-5-okan.sahin@analog.com>
 <74fd9706-119e-c6c3-4c64-c7ee419ce4bb@linaro.org>
In-Reply-To: <74fd9706-119e-c6c3-4c64-c7ee419ce4bb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWMzODljMjMwLTk0ZmItMTFlZC1iZTkyLTkw?=
 =?us-ascii?Q?MmUxNjI0NzhjNlxhbWUtdGVzdFxjMzg5YzIzMi05NGZiLTExZWQtYmU5Mi05?=
 =?us-ascii?Q?MDJlMTYyNDc4YzZib2R5LnR4dCIgc3o9IjM2ODgiIHQ9IjEzMzE4Mjc4MDYx?=
 =?us-ascii?Q?NjIxNDgzMiIgaD0iVXlQQ0dma2JlOXhRVG0zRExaWk5La3o5MVpvPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFBd0NkU0lDQ25aQWZ5K1plSGlFdzZBL0w1bDRlSVREb0FEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSczFnRlFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SA1PR03MB6532:EE_
x-ms-office365-filtering-correlation-id: 5745410d-0f0f-45f1-fafa-08daf71fac36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojIUjvzJAAPiOwCuKYuGeTop4E5T9Te2yl2cppbf+gXczHTKwhDO9e1hovRs3LYQGRpzlr623LpimJGiR9qJJp/o1NHSQk8blZ3ziP71mSHsBB6xsBvUMj/p+8EzcvRxOxQEKqJgVCZWRXV/M5KSl9oN9lshBUJgrw6Uhhk9Par53QtdoYf23TvAtshf1GVM6QRDIDokvwZsRCuESEQILYdBHSEs52xZ4GCnKsJfG+tLmuFzzYpGyyZKu8IQjd8ETri27TwygameBGdsDdNuxm17+s1UEHOMs3FR23wS3TJNL/ccRCbTzzK1l6FGzHwFKQXc3vJVyI0UGWa1Fp+bUgKG9n/FnScCnxwg2hyj3XtTlwx677M/fDvjf+MLQHYZrm82lGC+TulO7UZiAwWalG8Jca4MTtYNWQ23LtZZQ7cOmdsSc3BGjHr2RS2lh+tv8vo6ONTk5Zst7jb6egpJfp6Ke9uKpYfN+WwrxlSc6oAdis8hJdvcRp05a/43ywNt+wIMATzehciHyv5bmC+MqNq7DOw6/4ot+02diuiEEePTmVanRGEwN1692fSDnaZ5GkwqA/VPsYv8++W3Tjg8FGU3HRQNbOedzq1Ru1tljzRufpxYEHZnujOADpKd37JW6/rLjnDDqVXHZjCz11DfpRr1HP3T03GwKFGophaS2wTIz1k8AN4FnatZOkSyAjh3mA2vVVbWDAWVigqj7nriDIseIdm6LQKrv5llDsx5HjG5hH4OI2lwjBZ/pCG0Zynef2DEJ0hAulHcv0rwRG64zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(451199015)(38100700002)(122000001)(9686003)(33656002)(86362001)(8936002)(52536014)(5660300002)(41300700001)(19627235002)(66446008)(64756008)(316002)(66946007)(4326008)(66476007)(66556008)(6916009)(76116006)(8676002)(2906002)(55016003)(7696005)(83380400001)(38070700005)(71200400001)(54906003)(53546011)(478600001)(186003)(26005)(6506007)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/RVywQZkyYqezMwW8Qn06c91kNtHNK1qIFuGjscI2zUWwuQd4o94JklRa7gt?=
 =?us-ascii?Q?QQkZqlGuqP8QGpg9trYhfCH63vUQYL4FFvf5pApkGWFoXDfmuKnXdHSjoZQ4?=
 =?us-ascii?Q?x4Mwxv2b6kUU3H89HaMK8+lcof3IJ7Vg3Pgim14zEqMfdaQ4mO70aQxxzJKA?=
 =?us-ascii?Q?ry7O9W4YV3/+tFJWlTCxjuGIlAvnFpXyiQ1j0N4Y9OG8Axv/cmUO33rSZgzb?=
 =?us-ascii?Q?hM+RsIALPkylcHYw3yqkGMkbxLhs8eYhbZC2+I9hhUSdn6GEF9ZmW+s5YtaM?=
 =?us-ascii?Q?FKYhKkVsLCulQHhT7le6b/3xBuoNSFHNREB19WBxTTg4HTEj2P3nawVWlK+G?=
 =?us-ascii?Q?KOCEAJGa5nk96zRsEb3PzlPVgsCQDn+j8gbBX0BDHYOr04n30d7cBg6kjXlt?=
 =?us-ascii?Q?aQEMxcmY+NyyvtDApIxP8ge+loBh2fjkrjSu8PBMfUiLmCcSyOFHNBbEUdpm?=
 =?us-ascii?Q?dfqx3zQakgEht6HC4252Ilnf+4MQGghTtW4Qq5J9PMSmO9nuX84Yz9n3NAw2?=
 =?us-ascii?Q?ei0X321uTC2/usNNOZG5mNJkxthWom+6vVTlXT94+Qo+0820ORNX6K1I/7Is?=
 =?us-ascii?Q?I4J/X/Ks7KrZQ1IBOK2ZZW/iKeilCIU+eg7eYattp1fOH72MMTsG5kdFrQSD?=
 =?us-ascii?Q?46CPGJYiFtpw9CrkNhRNj46oRKEmht3/qnZf+SPWsnjuY1qiKimB4BkCz2LY?=
 =?us-ascii?Q?8nv6ISdcrigrTk8ReiSLJZIjbbZht8msZkcR/81comsI1zzkF1HRpRRNcTxZ?=
 =?us-ascii?Q?7WcY5UxhJowpZ8OQnHf6OR01xHiJKD3cyhfQHKX3VFanB0tyDEgh0s1VIERw?=
 =?us-ascii?Q?dXvDGHCsweMflRpz0vPKQqNs+K3BVpwfsg6BKfZlSt/oF1szLYxTGO7J1tKc?=
 =?us-ascii?Q?hIIKfmxkgVQNW0dVSIw3MPdbv6nFt4TnywM7imG1lzC6soPKrw4vaJc+GI58?=
 =?us-ascii?Q?Keh5rHqGRV3mKTz3imvWVi9hKNBjSRgJiEZPS9gsy+jBfuJwoIYLIxjCo2/U?=
 =?us-ascii?Q?gUYBcKR1XXihwqkLzdDPOBO7y+fGzjxvpLhI4lErLyvpuy0EhYC2XZe7vcik?=
 =?us-ascii?Q?Y9U7EAUSuGIyVwzimoOMMxrZ1aqVURLG/F0xloGtT5qgv2iVotkA+BoBpz+x?=
 =?us-ascii?Q?vNkQCc0YvohaO58kEMNlh6jw3OnAFa0+iN1vJSAwGC4EULypsD16Phtor3ko?=
 =?us-ascii?Q?RXSGd2GOLrLUPvGxUgAKKpcoOEPRLC7zA19rUOyL7ndXKVNhYqWLFAF0BTJz?=
 =?us-ascii?Q?o37hGxN3DKfHCyO6k2nGGKfdJUvoPZzL3yPjxbyyI7GaB1ZRVICZS2cdj4j7?=
 =?us-ascii?Q?2dwvkTrj/8kZ595c/wfWPJNl38MwyEWuPzRN4gnTq49nyFNX4FyFr+jym9F7?=
 =?us-ascii?Q?T1ik6bNMEpuF4IsS99X4pQqxvcl87t8Hfj/sswChenYcHb8b1lcEHoUFKeN8?=
 =?us-ascii?Q?YMzgUd2QNtSDe3aomvX1TU5g1MO0knpc5h0fKxA1WwONZledhYt0tpfFu8a2?=
 =?us-ascii?Q?Yr3jMEX/8Qgt3/GBkNXCsFDPWc20K/BSc6UoNyjWqi4jdXL9aQifdoCie9Hi?=
 =?us-ascii?Q?TGHu+P2BkgTO8ldD4G5V/VIlSL+kbkrkAQqtCeW4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5745410d-0f0f-45f1-fafa-08daf71fac36
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2023 17:41:03.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cwqym+61lZuSTNbjYIcuj+QRjIU5JoLfchsg9Ls/s3pVl4VJUUv0FikUkqLBitLpI/nHYBnYlPXDBUzXbAyYDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6532
X-Proofpoint-GUID: uR4RRntPYqxtDDZWt4Fg-tp3pVHJeyyk
X-Proofpoint-ORIG-GUID: uR4RRntPYqxtDDZWt4Fg-tp3pVHJeyyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_13,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150138
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for your feedback and efforts. I also have a few question below.

On Tue, 27 Dec 2022 10:57 AM
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/12/2022 23:38, Okan Sahin wrote:
> > The bindings for MAX77541 and MAX77540 regulator drivers.
>=20
> 1. Again:
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/sour=
ce/D
> ocumentation/process/submitting-
> patches.rst*L95__;Iw!!A3Ni8CS0y2Y!7nAM0w0tZiMzaqSFijTSs6_FiIcbPVz-
> n0BajxVC1WDh0GfsgL7XoVFoFToHza-Cy2_p8o0UEEc82BOnwgesjPcas_9m$
>=20
> 2. Please wrap commit message according to Linux coding style / submissio=
n
> process (neither too early nor over the limit):
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.18-
> rc4/source/Documentation/process/submitting-
> patches.rst*L586__;Iw!!A3Ni8CS0y2Y!7nAM0w0tZiMzaqSFijTSs6_FiIcbPVz-
> n0BajxVC1WDh0GfsgL7XoVFoFToHza-Cy2_p8o0UEEc82BOnwgesjE6sDUk6$
>=20
> 3. Subject: drop second, redundant "bindings".
>=20
>=20
I will update like you suggest. Is there any command that you can advise to=
 check format of commit is suitable or not by using check_patch?
I just added checkpatch into .git/hooks/post-commit file.
> >
> > Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> > ---
> >  .../regulator/adi,max77541-regulator.yaml     | 44 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 45 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yam
> > l
> >
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/adi,max77541-regulator.y
> > aml
> > b/Documentation/devicetree/bindings/regulator/adi,max77541-regulator.y
> > aml
> > new file mode 100644
> > index 000000000000..67d48bfcb627
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/adi,max77541-regulat
> > +++ or.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/regulator/a
> > +di,max77541-
> regulator.yaml*__;Iw!!A3Ni8CS0y2Y!7nAM0w0tZiMzaqSFijTSs6_
> > +FiIcbPVz-n0BajxVC1WDh0GfsgL7XoVFoFToHza-
> Cy2_p8o0UEEc82BOnwgesjKsOQbIb
> > +$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> > +aml*__;Iw!!A3Ni8CS0y2Y!7nAM0w0tZiMzaqSFijTSs6_FiIcbPVz-
> n0BajxVC1WDh0G
> > +fsgL7XoVFoFToHza-Cy2_p8o0UEEc82BOnwgesjEgbPQFe$
> > +
> > +title: Buck Converter for MAX77540/MAX77541
> > +
> > +maintainers:
> > +  - Okan Sahin <okan.sahin@analog.com>
> > +
> > +description: |
> > +  This is a part of device tree bindings for ADI MAX77540/MAX77541
> > +
> > +  The buck converter is represented as a sub-node of the PMIC node on =
the
> device tree.
> > +
> > +  The device has two buck regulators.
> > +  See also Documentation/devicetree/bindings/mfd/adi,max77541.yaml
> > + for  additional information and example.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max77540-regulator
> > +      - adi,max77541-regulator
> > +
> > +patternProperties:
> > +  "^BUCK[12]$":
>=20
> Old DT example was correct - lowercase node names.
Actually, I did not change this part of the patch. I checked other examples=
, and it looks like using upper case under regulators node seems correct to=
 me. Additionally, there is no warning or error after "make dt_binding_chec=
k".
>=20
> Best regards,
> Krzysztof

Best regards,
Okan


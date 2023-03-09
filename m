Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2486B20FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCIKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCIKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:12:44 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A782E63CD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:12:35 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3299e9tX005431;
        Thu, 9 Mar 2023 02:12:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=oHXJIvfEl3Kb9tlN8b2YU1cQK1Rwf8/pxsP0JogasQ0=;
 b=b6yLporU4ZN5G68/CEomoecuMbOc/4VN+xdfJPGc1H9grbYm8fS2em5wki++CuR43MIW
 KOw35Q1HZWEi9t5eP2Jr77++d5+VuAt1G7unOqqPLtvv0KKvJVlIPEKnkbJUgc7H/r/l
 nCDLr800XTjBcnmQDfPKUV5zbX/n5UW7kN/W1f97u25wgtbZFOdguYL2J6nI4AcKCzFy
 wLaG0uWBZstwj8iFkdkbw/SL/4Tuw7mOdgdqXsJqiTOx0+shWwx9bawl7sgMRZUVUAkq
 WmYt1FUqyrgNXACMZwepmxfexIhLL9GKmGzha7kv6T03LRDkx6lvHxuKp0fhaIPk1klo mA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3p6ffwnb2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 02:12:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfSowMkv6kKbCR4oXsP56ZpvEB72BIaUuRyEBxHghS0d2wsnx0aNBxXhG6+yGo6j/h4UHEkov2MpLybOaHpCb6683nqSlWcfoz1cv4ObfodOBMd4hxPzHazAPTrzhTnwFFGIn29E5VuCceVNSNFU6QELv8J0AhTcODyPZDDvzaS1/Y7mL3eWWuHGN97ZW18uEdgNP0+gTph8ZR/TejcEXsdoff+jiHdgeyLV3OtUDH6y+zmloPV0WeoGyYrvUnnaKu1J2WUuK1tmI3FD3Gm4AESozunoTZfKD3K3rtamtDc6vS9/6/raTJolnXLHKrpXQCe+8/KfW+fltZSlyURr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHXJIvfEl3Kb9tlN8b2YU1cQK1Rwf8/pxsP0JogasQ0=;
 b=nGu5kQM25x+d5vf0r22Mz0S8wpXDhDE9b6f3TwBUknj22BMBi+a+V+KW9FJU2C2+OUoj6bL8PHlh/kbU0MU0TO/eAT1zaWTNeXyKWSe9MloWb/aya1DeZ4DqKL1iVe8y3W3kIRb5hlMhmT3LIKY8jKNJ69U5VVGxF3TG7Qduc526qSE1DxLd5IBT7oNM+sEx7h4gEOoqIUzfN71CfFNkq57pDTBF/9tp7WyStMao1mjGjSgPGMLCGQ0ODtUYS1bqW6n1gXAJ2FeVwkMdVBml8QeEqTJbgS7YZSicsBFJmN3JDpanZkWHwgfq1Tqio1QMragX1NV1TZC+zJS7E6487g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHXJIvfEl3Kb9tlN8b2YU1cQK1Rwf8/pxsP0JogasQ0=;
 b=cl/2WU1gG6n89/GOk8dfijuj7DDteIC1j30G9TfAqCrN8C5DVQosaaEucDEbVE2xQ9cZeo5/8n1P7ElYAfTbjNZnBs5KInAtP4G9tg4wE0KQGjNDeAfqpYK2NafKpSAfc0u/nG4e09afzasDoHwRBhEJc3ITRNpbEM+X4gzi5Fw=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by BN0PR07MB8296.namprd07.prod.outlook.com (2603:10b6:408:128::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 10:12:05 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::6d9d:8f21:f49b:6acc]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::6d9d:8f21:f49b:6acc%5]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 10:12:05 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, "srk@ti.com" <srk@ti.com>
Subject: RE: [PATCH] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink
 configuration
Thread-Topic: [PATCH] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink
 configuration
Thread-Index: AQHZUm562e2H9T+YfUaPrKqnxxp1M67yOaaQ
Date:   Thu, 9 Mar 2023 10:12:05 +0000
Message-ID: <DM6PR07MB61540CF1BF185DA9D7CE1078C5B59@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20230309100352.446917-1-s-vadapalli@ti.com>
In-Reply-To: <20230309100352.446917-1-s-vadapalli@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kNGQ5NDg3Ny1iZTYyLTExZWQtODVlMS1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcZDRkOTQ4NzktYmU2Mi0xMWVkLTg1ZTEtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxMTc5MiIgdD0iMTMzMjI4MzAzMjE1NTgwMzg5IiBoPSJPSnM0MWtZMWhQZ2xGMmtmUXZmMStTeGRyWXc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6154:EE_|BN0PR07MB8296:EE_
x-ms-office365-filtering-correlation-id: 457c6ef5-1a2c-4db9-d794-08db2086bbfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AJ+tl/9/vLJlwe2uvEqlZT54j9YXlJmWrQfO/pHQ6l6GFsRRVc0md0oAlneGzvxObJ3bwAHNC9F4WhaNWRPuVH7g3GNKJthKfCthn8lbtoWV8rACNiZSXT1QvuL4MQz7YQlll86R6+aK4+Ap2NnoEdP6Z396FN84+1EwOZ328ote7UVFyfK0JwRMn7i8fzncxJqKaTy3URANF32i+nK6twgleqbet9qCz4ZXQWHDysgHYoEJkInLGphUT+FFu2WuZ2W4UktFMtuvqDZCJnHqm8jbtvtOnhCrlGGFvV0ZL+5w0YM4Icobkx26mzpcLw+5wy9kE6UvehZ9xvuKQ20z8gGFxQ9vHchq3rnDs4dwmHRorMj6C7dOJnuWlyYpN4lKWzhJJWtd6qbqZwPKi4Io1yBP6tX6qJbQm1ZLP9tUw7Natd2om5Murowu4Pa+b6tvkDPrvaL06qqXI+lms3R3+X02bXIwLMeZ5dN44Sz1BDWbNrv74jF9a2/erQJg/O+zEMyyfSVLxcVUCEBt/IgH8/lQY9ITEdvQvA7opyYyAQ9OTRwhQI3Y2Aj2sg/KnoSqC7kEbcGLcKWKqt1dKdm4MGLwaUg2EfuBSx+fQxYuLbu+AUk94ClEYYvUuQRNab02sfTkvu7FveK5HC0lfl5Oa3s4v/jzXvow0sG8UcBfJyVoCIEKP81/hyO0hqy4C8bi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(36092001)(451199018)(5660300002)(26005)(186003)(9686003)(30864003)(71200400001)(7696005)(64756008)(66476007)(66556008)(76116006)(66446008)(8676002)(66946007)(4326008)(478600001)(966005)(33656002)(54906003)(316002)(86362001)(38070700005)(55016003)(110136005)(8936002)(41300700001)(122000001)(53546011)(38100700002)(52536014)(6506007)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHrwc8BbbE53+qBnagKIAOmkSabQBScdD0qxuzBd8R6K+hIfffkml3Zmid6p?=
 =?us-ascii?Q?ioO5Rp+cIxTCMCjOYtYNxNRXhp2TzujTsEbCCJ6cph5+hb6mtKvZFHEhjfsD?=
 =?us-ascii?Q?m15ZJrFWV1ZM2kacScLKHIOnxWRJD7mrZyefnyca57S1W5BIwEfUsKG/qJr1?=
 =?us-ascii?Q?uMNqNMUt9iawgr8Q87w8815UykyXBPeCwwsVuyBFEfYFaebiosmP0gLprxKy?=
 =?us-ascii?Q?ZerCz4X/6VJxr26IwzkDI5eXZoxlST3LGZsNDXiI7wiOK5XBsr2uLtPD5ZrV?=
 =?us-ascii?Q?Iuf8r08KAJDnOuG6eFRHWii1OwnBEhpSk7g/tVaEo20c8wyF8TQ0kf8pojZy?=
 =?us-ascii?Q?CzxZy4A96RAA+XfzE7VASVtDySTW1MSYKVq+cgjKQ9XZNSzfUzmI+h4yK3of?=
 =?us-ascii?Q?1eWhG00/xdj710gsx1LqL+q2ER6bfDBcfOBDf9TzpzZRNfROScTqgiTaboIb?=
 =?us-ascii?Q?zTPQMZKiCNsdG/sFNxyr2r+Wyhzk+CHBj7pGpSe74sJ4+pTyDhmQLf2OqkEd?=
 =?us-ascii?Q?zaS7X++sLXaXuJUUYQCzMVzOqJPsftEGvsntkK8ZI69cr7C7kiErgnMmq0Iv?=
 =?us-ascii?Q?jlmQ14lI0Qg1clLJmPoqCL1RsEuLZvSFp/QtGJYnfg3Jhz6CyATPf9rZD9k2?=
 =?us-ascii?Q?axpxrBhMf74YTHEo76fauIQQly0yM7TwWViyA6iKLjsyjJdwFwttvYv1+oPq?=
 =?us-ascii?Q?mTSR+QrQ2Ko1NkQxqGSw/ndO7PsaMGm4f83AZ/sw95T2ngvTnpEM4gcu8HMQ?=
 =?us-ascii?Q?1s8qLddxUh/Vmx8Ibj7aF2XHVMD3KAee8Wv/PPf5X1glGqzwkUrqSyt7CnnL?=
 =?us-ascii?Q?sQs7Y1AYpm1V/GTIUo5RB4fEFZSRYboLi9NOrCBnLXcLqtGUILL0/3iT3iyO?=
 =?us-ascii?Q?QGTujZEezfM1TMDq/0iIXieMKHd2Iqz+JMgAg15B1NhhsjLJx63b6uNPfbTl?=
 =?us-ascii?Q?9woBiuJK9vUtNK94iqpXQzDJbnfD6UtbnzwO6jySW5JmcBiUGu5n5JOM0wv8?=
 =?us-ascii?Q?pYWscrrZtYa4Bu6dcJjYFsx8CKkA3X0/u2uJ3OLsV/J0vkfW6RFBKybJWJcO?=
 =?us-ascii?Q?OsoTFASgV1Mj8z3PyR/OSWJwH5H57yyEWEOJMmjepKm3PVYjMyTgAENxyvis?=
 =?us-ascii?Q?zAi8GzI8ijRyLggj5OBhonxjNQHV85Oa7/O00lw0mrF7dCLgqms1rhh9b+/H?=
 =?us-ascii?Q?nQWW72mA47SUGnxxku1CV87xXvkuGaBZY8DKb4s7voqb+Fbq1lhTRfbVB5lk?=
 =?us-ascii?Q?RFhBIYhAFYzviIOn/z+jjrtiAEo5ftNP9zBfg/NRGCVb0wApzrrbdl4yN8+T?=
 =?us-ascii?Q?AcNDsINA3/Rnl2UwT8QqKNfiFyotmNCvYJ+rV58Nkw9C15Ntj4k8zGj46lsF?=
 =?us-ascii?Q?Aw6v1fx4F/mF4aiT0dDZyCDdRJrJmoh6++noCaAh0PBwBRL66hNep1cSE8Su?=
 =?us-ascii?Q?WdnDHxxmVBxQ3CIQ2v5KP58gm7+BCFfejC/SJ+Aq2YlUvQhMxe6m8m00/hKA?=
 =?us-ascii?Q?8GbMTdBy7fubFn8DMA9FDiM6pXwTJGGcrIX5kA9qSIEMNzicWqwWDGKlv3ZJ?=
 =?us-ascii?Q?5xSFv/SnvzjWDKAtG/+qjKdPkN0fEm7seMo9R+/mcEx1lTbezWJCjscgi/XY?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457c6ef5-1a2c-4db9-d794-08db2086bbfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 10:12:05.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shnQmubaADqZE2H3hYh/N78DZOdYWjfj7vufmf3kdslShPXtMYnW5fQSvfKTuR8Cwjyrk/xaLmJjgsHGrM1stOSOtyU7RuYTJ8ciaQ1RYYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8296
X-Proofpoint-GUID: xdoB4XOPsBYtBfIKUZWeV4mLYE_f3hKj
X-Proofpoint-ORIG-GUID: xdoB4XOPsBYtBfIKUZWeV4mLYE_f3hKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_06,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303090081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

> -----Original Message-----
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> Sent: Thursday, March 9, 2023 3:34 PM
> To: vkoul@kernel.org; kishon@kernel.org; lars@metafoo.de
> Cc: linux-phy@lists.infradead.org; linux-kernel@vger.kernel.org; linux-ar=
m-
> kernel@lists.infradead.org; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>; srk@ti.com; s-vadapalli@ti.com
> Subject: [PATCH] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink
> configuration
>=20
> EXTERNAL MAIL
>=20
>=20
> From: Swapnil Jakhade <sjakhade@cadence.com>
>=20
> Add register sequences for PCIe + SGMII PHY multilink configuration.
>=20
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---

I have already sent this patch for review.
https://patchwork.kernel.org/project/linux-phy/patch/20230220141216.25326-1=
-sjakhade@cadence.com/

Thanks & regards,
Swapnil

>  drivers/phy/cadence/phy-cadence-sierra.c | 141 ++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index 6e86a6517f37..7c0daf3e8880 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -24,7 +24,7 @@
>  #include <dt-bindings/phy/phy-cadence.h>
>=20
>  #define NUM_SSC_MODE		3
> -#define NUM_PHY_TYPE		4
> +#define NUM_PHY_TYPE		5
>=20
>  /* PHY register offsets */
>  #define SIERRA_COMMON_CDB_OFFSET			0x0
> @@ -46,7 +46,9 @@
>  #define SIERRA_CMN_REFRCV_PREG				0x98
>  #define SIERRA_CMN_REFRCV1_PREG				0xB8
>  #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
> +#define SIERRA_CMN_PLLLC1_FBDIV_INT_PREG		0xC3
>  #define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
> +#define SIERRA_CMN_PLLLC1_CLK0_PREG			0xCE
>  #define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
>  #define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
>=20
> @@ -74,6 +76,7 @@
>  #define SIERRA_PSC_RX_A1_PREG				0x031
>  #define SIERRA_PSC_RX_A2_PREG				0x032
>  #define SIERRA_PSC_RX_A3_PREG				0x033
> +#define SIERRA_PLLCTRL_FBDIV_MODE01_PREG		0x039
>  #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
>  #define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
>  #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
> @@ -298,6 +301,7 @@ enum cdns_sierra_phy_type {
>  	TYPE_NONE,
>  	TYPE_PCIE,
>  	TYPE_USB,
> +	TYPE_SGMII,
>  	TYPE_QSGMII
>  };
>=20
> @@ -936,6 +940,9 @@ static int cdns_sierra_get_optional(struct
> cdns_sierra_inst *inst,
>  	case PHY_TYPE_USB3:
>  		inst->phy_type =3D TYPE_USB;
>  		break;
> +	case PHY_TYPE_SGMII:
> +		inst->phy_type =3D TYPE_SGMII;
> +		break;
>  	case PHY_TYPE_QSGMII:
>  		inst->phy_type =3D TYPE_QSGMII;
>  		break;
> @@ -1339,7 +1346,7 @@ static int
> cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
>  			}
>  		}
>=20
> -		if (phy_t1 =3D=3D TYPE_QSGMII)
> +		if (phy_t1 =3D=3D TYPE_SGMII || phy_t1 =3D=3D TYPE_QSGMII)
>  			reset_control_deassert(sp->phys[node].lnk_rst);
>  	}
>=20
> @@ -1537,6 +1544,71 @@ static int cdns_sierra_phy_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>=20
> +/* SGMII PHY PMA lane configuration */
> +static struct cdns_reg_pairs sgmii_phy_pma_ln_regs[] =3D {
> +	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
> +};
> +
> +static struct cdns_sierra_vals sgmii_phy_pma_ln_vals =3D {
> +	.reg_pairs =3D sgmii_phy_pma_ln_regs,
> +	.num_regs =3D ARRAY_SIZE(sgmii_phy_pma_ln_regs),
> +};
> +
> +/* SGMII refclk 100MHz, no ssc, opt3 and GE1 links using PLL LC1 */
> +static const struct cdns_reg_pairs
> sgmii_100_no_ssc_plllc1_opt3_cmn_regs[] =3D {
> +	{0x002D, SIERRA_CMN_PLLLC1_FBDIV_INT_PREG},
> +	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
> +	{0x1005, SIERRA_CMN_PLLLC1_CLK0_PREG},
> +	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
> +	{0x0800, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
> +};
> +
> +static const struct cdns_reg_pairs sgmii_100_no_ssc_plllc1_opt3_ln_regs[=
] =3D
> {
> +	{0x688E, SIERRA_DET_STANDEC_D_PREG},
> +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> +	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
> +	{0x0106, SIERRA_PLLCTRL_FBDIV_MODE01_PREG},
> +	{0x0013, SIERRA_PLLCTRL_SUBRATE_PREG},
> +	{0x0003, SIERRA_PLLCTRL_GEN_A_PREG},
> +	{0x0106, SIERRA_PLLCTRL_GEN_D_PREG},
> +	{0x5231, SIERRA_PLLCTRL_CPGAIN_MODE_PREG },
> +	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
> +	{0x9702, SIERRA_DRVCTRL_BOOST_PREG},
> +	{0x0051, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> +	{0x3C0E, SIERRA_CREQ_CCLKDET_MODE01_PREG},
> +	{0x3220, SIERRA_CREQ_FSMCLK_SEL_PREG},
> +	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
> +	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
> +	{0x0186, SIERRA_DEQ_GLUT0},
> +	{0x0186, SIERRA_DEQ_GLUT1},
> +	{0x0186, SIERRA_DEQ_GLUT2},
> +	{0x0186, SIERRA_DEQ_GLUT3},
> +	{0x0186, SIERRA_DEQ_GLUT4},
> +	{0x0861, SIERRA_DEQ_ALUT0},
> +	{0x07E0, SIERRA_DEQ_ALUT1},
> +	{0x079E, SIERRA_DEQ_ALUT2},
> +	{0x071D, SIERRA_DEQ_ALUT3},
> +	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
> +	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
> +	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> +	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
> +	{0x0033, SIERRA_DEQ_PICTRL_PREG},
> +	{0x0000, SIERRA_CPI_OUTBUF_RATESEL_PREG},
> +	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
> +	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
> +	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
> +};
> +
> +static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_cmn_vals =3D=
 {
> +	.reg_pairs =3D sgmii_100_no_ssc_plllc1_opt3_cmn_regs,
> +	.num_regs =3D ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_cmn_regs),
> +};
> +
> +static struct cdns_sierra_vals sgmii_100_no_ssc_plllc1_opt3_ln_vals =3D =
{
> +	.reg_pairs =3D sgmii_100_no_ssc_plllc1_opt3_ln_regs,
> +	.num_regs =3D ARRAY_SIZE(sgmii_100_no_ssc_plllc1_opt3_ln_regs),
> +};
> +
>  /* QSGMII PHY PMA lane configuration */
>  static struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] =3D {
>  	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
> @@ -2363,6 +2435,11 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
>  				[INTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
>  			},
> +			[TYPE_SGMII] =3D {
> +				[NO_SSC] =3D &pcie_phy_pcs_cmn_vals,
> +				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> +				[INTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> +			},
>  			[TYPE_QSGMII] =3D {
>  				[NO_SSC] =3D &pcie_phy_pcs_cmn_vals,
>  				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> @@ -2377,6 +2454,11 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_cmn_vals,
>  				[INTERNAL_SSC] =3D
> &pcie_100_int_ssc_cmn_vals,
>  			},
> +			[TYPE_SGMII] =3D {
> +				[NO_SSC] =3D
> &pcie_100_no_ssc_plllc_cmn_vals,
> +				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_plllc_cmn_vals,
> +				[INTERNAL_SSC] =3D
> &pcie_100_int_ssc_plllc_cmn_vals,
> +			},
>  			[TYPE_QSGMII] =3D {
>  				[NO_SSC] =3D
> &pcie_100_no_ssc_plllc_cmn_vals,
>  				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_plllc_cmn_vals,
> @@ -2388,6 +2470,13 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D
> &usb_100_ext_ssc_cmn_vals,
>  			},
>  		},
> +		[TYPE_SGMII] =3D {
> +			[TYPE_PCIE] =3D {
> +				[NO_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
> +				[EXTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
> +				[INTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
> +			},
> +		},
>  		[TYPE_QSGMII] =3D {
>  			[TYPE_PCIE] =3D {
>  				[NO_SSC] =3D
> &qsgmii_100_no_ssc_plllc1_cmn_vals,
> @@ -2403,6 +2492,11 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D &pcie_100_ext_ssc_ln_vals,
>  				[INTERNAL_SSC] =3D &pcie_100_int_ssc_ln_vals,
>  			},
> +			[TYPE_SGMII] =3D {
> +				[NO_SSC] =3D &ml_pcie_100_no_ssc_ln_vals,
> +				[EXTERNAL_SSC] =3D
> &ml_pcie_100_ext_ssc_ln_vals,
> +				[INTERNAL_SSC] =3D
> &ml_pcie_100_int_ssc_ln_vals,
> +			},
>  			[TYPE_QSGMII] =3D {
>  				[NO_SSC] =3D &ml_pcie_100_no_ssc_ln_vals,
>  				[EXTERNAL_SSC] =3D
> &ml_pcie_100_ext_ssc_ln_vals,
> @@ -2414,6 +2508,13 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D &usb_100_ext_ssc_ln_vals,
>  			},
>  		},
> +		[TYPE_SGMII] =3D {
> +			[TYPE_PCIE] =3D {
> +				[NO_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
> +				[EXTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
> +				[INTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
> +			},
> +		},
>  		[TYPE_QSGMII] =3D {
>  			[TYPE_PCIE] =3D {
>  				[NO_SSC] =3D
> &qsgmii_100_no_ssc_plllc1_ln_vals,
> @@ -2435,6 +2536,11 @@ static const struct cdns_sierra_data
> cdns_ti_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
>  				[INTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
>  			},
> +			[TYPE_SGMII] =3D {
> +				[NO_SSC] =3D &pcie_phy_pcs_cmn_vals,
> +				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> +				[INTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> +			},
>  			[TYPE_QSGMII] =3D {
>  				[NO_SSC] =3D &pcie_phy_pcs_cmn_vals,
>  				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> @@ -2443,6 +2549,13 @@ static const struct cdns_sierra_data
> cdns_ti_map_sierra =3D {
>  		},
>  	},
>  	.phy_pma_ln_vals =3D {
> +		[TYPE_SGMII] =3D {
> +			[TYPE_PCIE] =3D {
> +				[NO_SSC] =3D &sgmii_phy_pma_ln_vals,
> +				[EXTERNAL_SSC] =3D &sgmii_phy_pma_ln_vals,
> +				[INTERNAL_SSC] =3D &sgmii_phy_pma_ln_vals,
> +			},
> +		},
>  		[TYPE_QSGMII] =3D {
>  			[TYPE_PCIE] =3D {
>  				[NO_SSC] =3D &qsgmii_phy_pma_ln_vals,
> @@ -2458,6 +2571,11 @@ static const struct cdns_sierra_data
> cdns_ti_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_cmn_vals,
>  				[INTERNAL_SSC] =3D
> &pcie_100_int_ssc_cmn_vals,
>  			},
> +			[TYPE_SGMII] =3D {
> +				[NO_SSC] =3D
> &pcie_100_no_ssc_plllc_cmn_vals,
> +				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_plllc_cmn_vals,
> +				[INTERNAL_SSC] =3D
> &pcie_100_int_ssc_plllc_cmn_vals,
> +			},
>  			[TYPE_QSGMII] =3D {
>  				[NO_SSC] =3D
> &pcie_100_no_ssc_plllc_cmn_vals,
>  				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_plllc_cmn_vals,
> @@ -2469,6 +2587,13 @@ static const struct cdns_sierra_data
> cdns_ti_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D
> &usb_100_ext_ssc_cmn_vals,
>  			},
>  		},
> +		[TYPE_SGMII] =3D {
> +			[TYPE_PCIE] =3D {
> +				[NO_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
> +				[EXTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
> +				[INTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_cmn_vals,
> +			},
> +		},
>  		[TYPE_QSGMII] =3D {
>  			[TYPE_PCIE] =3D {
>  				[NO_SSC] =3D
> &qsgmii_100_no_ssc_plllc1_cmn_vals,
> @@ -2484,6 +2609,11 @@ static const struct cdns_sierra_data
> cdns_ti_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D &pcie_100_ext_ssc_ln_vals,
>  				[INTERNAL_SSC] =3D &pcie_100_int_ssc_ln_vals,
>  			},
> +			[TYPE_SGMII] =3D {
> +				[NO_SSC] =3D &ti_ml_pcie_100_no_ssc_ln_vals,
> +				[EXTERNAL_SSC] =3D
> &ti_ml_pcie_100_ext_ssc_ln_vals,
> +				[INTERNAL_SSC] =3D
> &ti_ml_pcie_100_int_ssc_ln_vals,
> +			},
>  			[TYPE_QSGMII] =3D {
>  				[NO_SSC] =3D &ti_ml_pcie_100_no_ssc_ln_vals,
>  				[EXTERNAL_SSC] =3D
> &ti_ml_pcie_100_ext_ssc_ln_vals,
> @@ -2495,6 +2625,13 @@ static const struct cdns_sierra_data
> cdns_ti_map_sierra =3D {
>  				[EXTERNAL_SSC] =3D &usb_100_ext_ssc_ln_vals,
>  			},
>  		},
> +		[TYPE_SGMII] =3D {
> +			[TYPE_PCIE] =3D {
> +				[NO_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
> +				[EXTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
> +				[INTERNAL_SSC] =3D
> &sgmii_100_no_ssc_plllc1_opt3_ln_vals,
> +			},
> +		},
>  		[TYPE_QSGMII] =3D {
>  			[TYPE_PCIE] =3D {
>  				[NO_SSC] =3D
> &qsgmii_100_no_ssc_plllc1_ln_vals,
> --
> 2.25.1


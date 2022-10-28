Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB693610E27
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJ1KMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJ1KMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:12:15 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264E1B2B8F;
        Fri, 28 Oct 2022 03:12:14 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S9UJYG006334;
        Fri, 28 Oct 2022 06:11:46 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kfagcv2r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 06:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUUh1oRIrTakU/6/r1bA8ivBIMCv1rL+az6exzSCpSycV9tH3KFzxJ9+gOcJWiXDhpo8ZIkOoynu0gE0OvMXJPuiPJ6wW3mEW927ungjo2E8nZyIxYW7mW54vP4qduKZ+scBk53t4+8wkr7GTbdLaJTipS4Xx2nqcTKxHyfU0zi1eyvI69d6sG04MkWnbqVMmlOZY/OIqq8ynfYXmhtF/+l5bVA9P+V1kG4P7aJIUpE7IrNcpGndehLV7z6tbwLBih3UU+CYPuR+HRrkdM3+yrFPCFIuil7dHaU98UGQwSeTCXPO+YvqYSRBrG6YHM/FFQ67V7ZddiXxd5or/cKfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvHuaVxvAeCcBrCWI3xkle581ukZhvc6PjXs3AkUeUs=;
 b=Cw9Zdqal5IeST++wMJrJQRYcU8YfnX6E0M2PWjCEUeO1aPvDYjAnG6ks8UdiPWrCklh3S/XsnMOpBC16qXB9gN33kbC/tnap74tIkuH6dO1HLIZqQbiu3FQHi3Mfzkn8uDE9+gFyFREauxtOPNOxkGM6JIfNfYn/mUbPJQT4cXF3wLp8KTyQl2T3E3ipA59BymwF5o+nNa26I2uPgP4ntZInUowfqOBQ9JbX81g19WjKHOQ/oGMG7OvwjHM1jv5dAhOgqDrA1LpPveFkwyMeEb/xSXn4mcik97lJ15G1Ta45efyB5Jt9fyEcywREcVR7ps3JW8FzEiUpqw5b9ucjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvHuaVxvAeCcBrCWI3xkle581ukZhvc6PjXs3AkUeUs=;
 b=PKnzHtF8vzGUHxnCzYTlb07cVpGsrT4R/l7GwDJAimr7raBcLKk+Sq5H0ifdqgEwqiIwpQM32alQ9xRxlmCKVsqSIeDxcbs3Jw3PXuJ0itTpPB3qeW61rxV/oCvZqqq+jVcwufVYP7G1xZjFtQZMM5oHwBCdGwv4MqyZH/690hY=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CH2PR03MB5206.namprd03.prod.outlook.com (2603:10b6:610:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 10:11:42 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 10:11:41 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Deepak R Varma <drv@mailo.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: iio: frequency: ad9834: Use div64_ul instead of
 do_div
Thread-Topic: [PATCH] staging: iio: frequency: ad9834: Use div64_ul instead of
 do_div
Thread-Index: AQHY6k3U7/Rqoif2wk+7cS/MI+s3t64jlq+g
Date:   Fri, 28 Oct 2022 10:11:41 +0000
Message-ID: <SJ0PR03MB6778453D256C9971B950956A99329@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y1r8gMR8VBG/4A4P@ubunlion>
In-Reply-To: <Y1r8gMR8VBG/4A4P@ubunlion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZTk3ZjIwM2QtNTZhOC0xMWVkLWI2YjgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGU5N2YyMDNmLTU2YTgtMTFlZC1iNmI4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iOTU1IiB0PSIxMzMxMTQyNTUwMD?=
 =?iso-8859-1?Q?AzODE0ODUiIGg9Im40bFgvRVV3M1RUOW4zSFQxN0d5Qnc2c1RGYz0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQXRxTmFydGVyWUFiQXZQY3E1ZzM3Z3NDODl5cm1EZnVBREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CH2PR03MB5206:EE_
x-ms-office365-filtering-correlation-id: 74d2d0cf-028e-4f18-0a74-08dab8cccf5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20nTWLaKbZ230x02vx0UJnM5S87S25qnQpy8PHBtN/Rs8DPuvVoUbRaH5imAnqNLDVDYabdKeZI9UeQWO5Ui/3D6rsc3EEDEd4PH75laADCjidZ8XESUpZgj630vVhLu87sFQ1U7UNTh1g3CMNwCu6DL9fuWM8k2FQlmImVQHJfFf7uIVt8HtB/2x2VqKpDQiU10DfFKaxHUD+Li7aGVajbSYFzM5cykD3wnmhffVjpdD0VqxLkl3kbfdVXgsm6Y8Vkj8j/zScrrT7kL11lwNbWjJzMOlAPCGTTlulR6o92lzv7RA32WlhxR+HA3qH340Coua1MFiH7rba40trb8Cw1NAQinAFEAkJ7XUOBsAdOCCachKfqJK/HE4I31TE8txBNrX3+DLhFmb5tH4Ugi7sOUdVat7Ho9qWzoYVZZXpfJa2+jc32RgtqyHuKka8n1sJvT8lr/azyrQZA6XWAC5B6G87qotD7Ny6U9WKZrRDHHtMEFEUdHXJsErqRws5XnziwM48vdbUdOQ4s4hyPIeQU1rzhht+CGOmV4gnWAapj3eJruK0HwckiWPjT+svyb2N8fiUoLKuw3Q2PW97bBgFwkVKaLrACG/XfHlOIhOAFfAkwpU2Rzlg7H/SGpvYwGwwZqtJ5kGJzzayANEZDTKpM0P8JXrnaQBlh1s5mZJn+IvZaYLK+M4pP+TizBjiJhaHn/E6NwZ3vvHTOPiRlzatBrlqAIG1KSU7Z0wBa5WAP0nDzZDrJwKHoD+MFpwd73vFgMNilpJAofl+U0x7eBAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(38100700002)(4744005)(52536014)(5660300002)(71200400001)(478600001)(122000001)(86362001)(66556008)(66946007)(41300700001)(76116006)(8676002)(66446008)(66476007)(33656002)(8936002)(64756008)(55016003)(38070700005)(110136005)(316002)(2906002)(186003)(53546011)(7696005)(6506007)(26005)(83380400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JX0UVkLR6Am+g4rKYb/Oq0v7d/XBxCPNwxzGNDOstGBWYixZNyBgTXdfVQ?=
 =?iso-8859-1?Q?z0cCvwea3DlVTRbIiTUSt2UGY5nkNf2rgFnApMLO9pOj8jHKWOexbSTj8W?=
 =?iso-8859-1?Q?3zhPKDyMRkn4Bo5kKoBNofZi4dOtaWz7FIYBf+M+0UXdvFEmRAGKSWGCZb?=
 =?iso-8859-1?Q?Bc5lT6zYUAKfNNlW9NJCMzstNc45lOrOYZ1YerE+gVxrCDQIdvjKKoHp/P?=
 =?iso-8859-1?Q?ksvGYjTcG+97vpEs+DecY2xVONgysFKbzGtKuFK6OvpHO0esu+88gZISI6?=
 =?iso-8859-1?Q?5r3UA4BXT6am+GmT18IsNHszwXoWfuR6juePr8CuefFgVU9WReq/p5EI/b?=
 =?iso-8859-1?Q?d6BQAYadbVgIBvBVq3NhWIphaMjQaJRkzeIYuL9o2bVbxZO5fE+4MHQd9t?=
 =?iso-8859-1?Q?hyLal0bGaYEEP3Bth2WiwrHOsb2kbOogaOe2u9+GjUy4/YsNgYvzY0RsGX?=
 =?iso-8859-1?Q?VgqCmIS0mcB/ydtlqbn2l0WDLN+z6Xgm70emB08eKvKLOyp2KzlZt6Ajer?=
 =?iso-8859-1?Q?r10yVxHM4CMpAtQwP08+i4cPSb2SJrACp1zWnyaRQHMMjbKvxeoHIyLgi6?=
 =?iso-8859-1?Q?NsYmolI8e5FzYMbaI00yXVQCneu772TpwB12nQN81qo+PgAa2m4ZKWDAts?=
 =?iso-8859-1?Q?431wYWAXLc2g46wonGEU7NHEKJ6J8Y89ziE/ocjVJ9wgclmWylTfmiVabX?=
 =?iso-8859-1?Q?dx7x53iyCEm71/C7RaA7XCPnPpfKCPdFKrIJQn1agy+8KZMXobTDux+XcT?=
 =?iso-8859-1?Q?/Dx5QowXQhQOhiPjDAnASOmbNw76DYGqwg0p2bhXlx9/1a7H5cTDpdVnTf?=
 =?iso-8859-1?Q?ouiy2PmInAitwat0Uvwsr1vPHRAxW3wNGPHtnkZLjnDf6KcRWRTZ6EMzEh?=
 =?iso-8859-1?Q?coH9/s/syXfarAt+O11rUM+cPT/OpvnH2nfbcrheHPsy7UIKXSWO/W1xnm?=
 =?iso-8859-1?Q?sZvES3G+XCuGfDSkB3cfpar4RN52jtHKzrq07uYUUPV0OYJmX3yuyIoh5W?=
 =?iso-8859-1?Q?XlgDrSe6vlkHW04asOP2IkoXz6ba3PzeIcqOPGGmIH7Z3PYOOGe4VHBTbA?=
 =?iso-8859-1?Q?mtTQqBlowkfHydjJex5VY2De25BSQcwNFddQksS5jtfU2wglPO3xziRKWi?=
 =?iso-8859-1?Q?npT8rfwCwrB5quEOu6Pw+s3AouGcIpjkLipuQiPJ4DzuWrrnvLNIUJb0et?=
 =?iso-8859-1?Q?MDm0+5F4aLhHCqlj9es0jM/juRInLFjhrNsanXNgkkV2E4wrBqMWT/yaIn?=
 =?iso-8859-1?Q?237VS8W3z6DEDIfhtTKEA39q7w3nbPAnizU7+iIwcX+rfqwjAJYN0vlNVy?=
 =?iso-8859-1?Q?d6Pe7SK4KVNiqboF5LQDFyoDUol6cH7u0cK1aLTd/e2Jd+pq01L23OQVrz?=
 =?iso-8859-1?Q?qybSouLNPNSzkeeiga6nRwaPXC4/G68iMPS3PrJoEZp1QakiX5RPaAxneR?=
 =?iso-8859-1?Q?ke42/0leCnYyUQ1zA9POacnVdkG3YX7oF4xZzEw6bww6sVLgwVj0SFRIwW?=
 =?iso-8859-1?Q?+chwSmfnugKpYGgO7YizEEGH9jBJXs/0snxWTD10cUPN9+i26EWxVHazpv?=
 =?iso-8859-1?Q?Qut2LjGXV4Uzfpnpv58T79iWzuzqq+Dv45x/LtAv6lrfebHtN8j4ywpHaK?=
 =?iso-8859-1?Q?NSzdp/mfkP8Kd19p+5doWEMGCAl2w2Rcuj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d2d0cf-028e-4f18-0a74-08dab8cccf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 10:11:41.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URaqg0YW1sz7c76gUyFwhvu0VGvr4ilBrth/b/Sd8HbqApZLNCL+K8zTOpSHB6Uw9VdZcqv00Fl1F1Yl/8Agtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5206
X-Proofpoint-GUID: rFlQ53ykZPTTvScQImjc18QsPTUltsBZ
X-Proofpoint-ORIG-GUID: rFlQ53ykZPTTvScQImjc18QsPTUltsBZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_04,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280064
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Deepak R Varma <drv@mailo.com>
> Sent: Thursday, October 27, 2022 11:48 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> iio@vger.kernel.org; linux-staging@lists.linux.dev; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] staging: iio: frequency: ad9834: Use div64_ul instead of
> do_div
>=20
> [External]
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation. Issue identified using the
> coccicheck tool.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

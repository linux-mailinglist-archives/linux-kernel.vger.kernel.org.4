Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A675FA0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJJPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJJPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:12:25 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867522A407;
        Mon, 10 Oct 2022 08:12:23 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AERwQR019849;
        Mon, 10 Oct 2022 15:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=xpNlWS5jdDOarcSBBtU9ylj3rJCywMBRDy78CERzSK8=;
 b=npIiCk6E37hRWIE9x42nCqlGaYP/4PDEbulpYUALPtktLe97n55pm/CibN1E62s5FXH9
 I41pQp+FE/hh3vgT8r0IlDeC4nS0Fqa0cscj0rN4D6sQVobFRG32RwP0QJtiu2cuyucB
 /wAGp7KZwnHXd5ZTcleaeoPFNe2zNume1duEZlec4pAV3RtC8DlAhIVBzxRxeEODNHRW
 kfzQkA3PYskNZVWdqIcD+JAZLTCb8J+mMmbr0K7R1GNMYnEzE+KS78YbnsLNam+qdLWY
 +Wwl8w60oimEC+pwkYNjvbJIdBq4n5oSjBrr4m+PLFIxabciNBOiYMIjbz/p9kcSaWSH QQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k4n630env-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 15:12:21 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7F0171395C;
        Mon, 10 Oct 2022 15:12:20 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 10 Oct 2022 03:12:14 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 10 Oct 2022 03:12:13 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 10 Oct 2022 03:12:13 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 10 Oct 2022 15:12:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ0qMRJhZAPHO9U+oSnevtAiNACeEdTagiSIXmmrrYAM+JDeMOzIt2HtK+A/HIAFvxze1WvwSDtU109CB65DEXb8XMFCgZvYMROMvkSZFd+PJZ4fZ5+77QeIQFuc58YGSvo1oMVKiB19aMQRbE+XLfJXATpyL8k7sVyJ+wKuK9nK8HGNE1M8giz2un8IZYtfADNfY4/bKuM9G10auhwp+Wz7aZnqr/rvxHBRRi9x2wD6yZTpa5/pM8mmozlRbtPCpBf8N6bJmOr+qQuKV3fPWe9TfDsB1xXkipaEOublPdPSKR97jn1JqricTx9/wumKYtVr9x8ISHiOODt5qeeXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpNlWS5jdDOarcSBBtU9ylj3rJCywMBRDy78CERzSK8=;
 b=FgaxDYlhrdIoWhqlYw7H/GNa8kJW+mHPZl3owEkUQ+V4j6FZlhWylUqxnu54oOevZCKf/vaNwV/CGUvN74kl6jDU548iDdlZwAfL0qUsPhZ75rx+7VC8fysRRjaRuIh34BCCIkT78MxYD+5kx3tQWDhJ4QfvcbD++JOI4ZgwV7ltcoHryq7ZDTfbmGshz+oeJLfSSaN8bPq+82iZMYJ26ZAVPEYp84yVCPl2qm1sxS7uz1A3/Z9x7KP8DPMHLu1xb+rvIlr3Vyz/YZD7gVpAA2CnTDzYHK/5dfLer8MLWHCwC7Z1tVo/AtThRZfGQbmxFstLYQW4Wt5X23PHXzPliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 15:12:12 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5676.032; Mon, 10 Oct 2022
 15:12:11 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Unloaded tainted modules list with tcrypt
Thread-Topic: Unloaded tainted modules list with tcrypt
Thread-Index: AdjcuQahMl2C8lRIQDeORTZxmzyv4A==
Date:   Mon, 10 Oct 2022 15:12:11 +0000
Message-ID: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1819:EE_
x-ms-office365-filtering-correlation-id: 9de08eeb-ae7a-4cd5-d6ef-08daaad1ceb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25WZf3IhfFIJ0q6LJlG9/5mCRlbosY3C42FC9IFy4KU2Gv5Ap2eoY3U6FeUkhImJ0mzP2492hKk/WLSftrjCNO/Z6Ut7Nu6yC4HoSSWsKtVInxg85u6JWfhIx16QinZbWp/XI21D7SxsQJz/Bv/HMwjVKxEbqNamw5ObFRYeLNP+6odmeG8xXMsp5RvwTIhH0aLk5mGwATQv9F6lWMQqlUvAAwyjwuaCC7qYTlluQ7hGo2b/5SYfAmtqPDrVzXVmTJPUF7xBgEDhprnMW3UlHyCXPXVGYjRqE6SHv+BWubSmiLk7tQb1HrV3tPrHVrBlxIx4hUohYLgQTSn2KmOE5i0X6uIE9BHy9CVnxYe6ngRpCWzPFKfvwxRCI0cMbE1CKG/ykSFQFYRjPB22Jt5miuQGpHheGiRKQArGZuigNUIODS3q0cowHcZWVrpLQkJIktoSJ+AnfcPe61+LSzlgr67+f4s89cBGLWB7tiiDx6s48ZUCaUZFTCAZ4eRDtTkKkeb+LxDqbERvNHB2mkXSbgySSFI6AjyVEU4Oq3f/7DPE9/rmFRzImfBJa9SrQoAwCMMXbo9B5XjvDzrMNkxbnmXyfNuDuQG8wewZkBw1XjwkTAh9qmf9vlnUSH69v90i3W6pEae5EVC8uvQjRG7ScEGS3/Cbx5jtskv6jc+OcndRx216XlJR6cGSpcszZs6U+/SPIIxWYxLejc4KDZdS+uuiH5+Gzv7TljVremrydF1Hb7B+t1/X1tF3BYaxb6HG2J8tV8bJ7iaw/LXMgBxf7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(55016003)(5660300002)(122000001)(8936002)(52536014)(38070700005)(110136005)(26005)(7696005)(6506007)(86362001)(33656002)(9686003)(71200400001)(478600001)(76116006)(66556008)(66476007)(64756008)(8676002)(66446008)(41300700001)(83380400001)(316002)(186003)(66946007)(2906002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9Hrxji72j6XXJxvVDo7rxcV4CCXR+yOIqe1E4QPnueEf6VNP401C037mrbE?=
 =?us-ascii?Q?yMxxrxkSn7epFBp01F4dJC0XPEG4aMn0Z99RtjF8fV8hhfbpcUX3ibu3v4vA?=
 =?us-ascii?Q?NgkeKNzrxcnjqKiseOJJwVEyXhKLma74B8wf1WdzampcSq8TpW0T3DuFcZeJ?=
 =?us-ascii?Q?KykC8P49lpMJCsH7KKRMDqSJdmv0UhGlANXug9MJA8YO1W1VOnwDBhLmmGwM?=
 =?us-ascii?Q?dpHH8hKdGigpUky4E4FWSHoCbMzAne0fRv6RJwh+Y8XEdCFFJf4vGzQTin7T?=
 =?us-ascii?Q?GRAEbQeI3YgH3M9u+Wt+r+PFbKYfNXxy75KY5s823XoODSfdil3nLiv0LZyn?=
 =?us-ascii?Q?DyUd/cGLKJxuBoUCwK1YtHHnZLKZ3NXZcA34cCCkBXBd6OW3/a20SFVbM0Dr?=
 =?us-ascii?Q?HiWYfZiHP7CIHG5oIy/pfsi3SNsG8mP5nClfWy5mRvYsA/kiRFFxwo1ZrBGy?=
 =?us-ascii?Q?1SuMv4gpBWAnKx0vMIgBzH8qYozAr+HuZI1BBDO3mUnZ6WIHJOGlDWs4vXkq?=
 =?us-ascii?Q?5oX4i07cqfwr2EUz9wTuTeUJtGyIxW/Wbap4/1s/L98YAtailV/xP3MrqRIa?=
 =?us-ascii?Q?QjivGJYCDinJRKZpd6RqsuOxdSEEzl5Az0uK/V0vxFG1DrBCH0GER/OYcno3?=
 =?us-ascii?Q?tZxsXjksicC5y9AlKb6LcYB7zfAmmi+/3lS/Z2UU5GO69xXu/Kdtr2mmauO8?=
 =?us-ascii?Q?4ftLsHNUF6lK8pBy3CgzoUceZ/QagkJo5T5dCFaMG34cUFimYLc7ul4FVTO8?=
 =?us-ascii?Q?I2J2gVoD3BxuOtb4UzSUC/wx+ulGkFVyjhEUAUUL8x2s+hc4og5x3n65c+d9?=
 =?us-ascii?Q?J9++yMqM6wn1gi0RRurwWqHbNnAiSueODDgl5TrF2NCKlhFLgsYrYu1HrfTt?=
 =?us-ascii?Q?GRA4WzkI0Ra5SzKnsQ6wUO2S+TgFkjaxywzKdqoY5nzXNCg6dOTmdziDRMLy?=
 =?us-ascii?Q?HwrmOeTVgMMOWFoWWRDJns1+jTTOpXHIZMLHV98fVvdvu5599YP7oGI8cKqy?=
 =?us-ascii?Q?vhMwVJLyRiADOF3XHaxGrGqw+OzFt3+Wd+yAML+hXrlmZEpl3ccPlHUPXowJ?=
 =?us-ascii?Q?1ECy9tG1pjdsvLkoS9OrfXqe+P3dFYu8YMKnfenfvVRFISRWithPVo4eHPUM?=
 =?us-ascii?Q?zqEWt+QugOWqvO2uyRlCM56Iwq/yKpdJVrYiVNvlz89FQJ1ko1Ofo9C5FJ1v?=
 =?us-ascii?Q?jhhdtvTKQV7COAUr9EXLo7o47S4H49+I1xQveX8872UFMEhF4LqTSsnXLFOP?=
 =?us-ascii?Q?d3Mkh06g3kuUlzoR5/qU0/YO0KPaFwY7cIvMuANpcd6ge/vlz2+Q2AaY5K8p?=
 =?us-ascii?Q?3o8PUvHz6OBfn6GhwfBu44SKeI1q2I42TEQ59dquv6G/HiRdmxWFy/yntaq5?=
 =?us-ascii?Q?2WtBUX5cxcmxNcs0i8oaZwVjaLcfWJy0+1tmuVxSOdffkQBQIJneX/D6j0ju?=
 =?us-ascii?Q?bZvudWQbuk2PWF1n+9q+Olw3WLb3tOHLZrBXaGJd4jwaGO8UXvjSQG3b8L5w?=
 =?us-ascii?Q?lGxeMpvK5zDJZIwVefWgTfeb1gqaAxrWzdx2/EjoUgNnyu/Skp9QuiSf3bXc?=
 =?us-ascii?Q?sysjYmhzL87bNIAFsyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de08eeb-ae7a-4cd5-d6ef-08daaad1ceb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 15:12:11.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7YnVYs0NOqYcMVeAuE073IlUIZlGoKFSBQsZ4TebpKOwUWIY3gNxAI6WCN62Aol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1819
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: dHxira89Q8BBuwjwFdgpnjaFOssn7IGz
X-Proofpoint-GUID: dHxira89Q8BBuwjwFdgpnjaFOssn7IGz
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_08,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1011 mlxlogscore=352
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When repeatedly using the tcrypt module (which is designed to never
load successfully), the "Unloaded tainted modules" list grows forever:

Unloaded tainted modules: tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1 tcrypt():1=20
tcrypt():1 tcrypt():1 padlock_aes():1 padlock_aes():1=20
isst_if_mbox_msr():1 acpi_cpufreq():1 pcc_cpufreq():1 isst_if_mbox_msr():1=
=20
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=20
pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1=20
pcc_cpufreq():1 isst_if_mbox_msr():1 acpi_cpufreq():1 acpi_cpufreq():1=20
isst_if_mbox_msr():1 isst_if_mbox_msr():1=20
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 isst_if_mbox_msr():1

Some other modules like acpi_cpufreq() are repeated too.

Maybe this check after the name comparison:
	mod_taint->taints & mod->taints
should be:
	mod_taint->taints =3D=3D mod->taints

or shouldn't be there at all?


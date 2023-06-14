Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0F72F443
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbjFNFqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242954AbjFNFqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:46:18 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F191BDB;
        Tue, 13 Jun 2023 22:46:14 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E3kjZF015622;
        Tue, 13 Jun 2023 22:45:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=8JRtuGHY6kkADsrlaehlzLEg+kAxPKaA84b573T4HFU=;
 b=izLZBVLsLufZHwAYbbNAw4JwZ9ie5KuKhHe0kpB3OtLrw1I9O8hSCLjkyeWY6QPYOzUo
 zJlJP5kR9N8lKB/s5tDyg0PReFLpiEYCFcO33uYyAkKxtaDE5SVGM5v3LvjFPnsGo2zh
 mCAqnQARf22Lok3jvYpY3Dxdrr0WY/hdHvXit0ukvxOhg/QRPvX4oTwLiMkEhXJ+SQpB
 ABYv/XrnPqKkazso6TEOdoOo5oJ1XCilbKQwSRBKCALz/N62CUqqESyvL5U1+vpjXJDo
 9V/FTWvdB976BiahQVTbBHfIv3+Cz14pPOM/ymI4i+ouzbw+r2ZpQZeKQPwd3tKrdn5D 8A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3r4mryp5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 22:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldgwQSP/WoWcCnixMtOEYKydxaTmeLbWgd9ugN7iSh8f0JL+Gezh8grJKX107VgbTPpGN/QUZOjK96O/yMs3wkXBQLQYYinRy9bmE1T+j5iMyr6U1j596Lz4lGOS5wT5g+hhYtJenWxyA1WSIT6GclfYEhtyTn7hZkLVojApDNClNCYj22IST1pC1ngJWONv6snk+TfrJo11TC7d/vSQF0h3gNnNQkgnMVApbk9loQyxkMb/xPT+IHtktMZHV7WjQDMSbJdZK68Tdpyj23EucKjw2jJhMiOhmVmFn5pj9RhULEIa47WH4Mpl7oSMbaZ7ah7Ags5FOEFyD0OQCdd2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JRtuGHY6kkADsrlaehlzLEg+kAxPKaA84b573T4HFU=;
 b=HNvkCu0O4SQ0ZCin31cu01JR5/vZ+HSINR+GXt4jZ9OJXSzXO3V/qtz4pbg3jQggJpWZJ1Ac4Ztc8olaw/oWqSw+seoLm4U3m7/wCipPdgirq6pQdXEZz2JgSRaY9q3BMb2GDzz9ZC6TjrM/JzB78IxHyQLvnS+r+QWCUYkBNNU8oYMoCipoF4fkzEOWQv4TQAR97AnX54AIl6ywEmiueKeeZIwcqc9QkxpLTfa9RSJHlD4LvbIFCT/we0HdY/+WGP5hwZYHK1zYRXQJZTtNcOJIL06KCQWWwWjAl5atY1a+qXoBhfk+Cm3t6Dp8iRvGP5/NZFeK+1lwOwkNw9V0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JRtuGHY6kkADsrlaehlzLEg+kAxPKaA84b573T4HFU=;
 b=Vp4gPvP7js5JxM43e6s6liqbvJ0AS4t54kkY8PgvK2PIAyNlCPG4LWteVcLKIsREgDtNEC8JpzvfHp35Nv1N5thKFzvJwnUhI9a/g+KUBCYpIy4t/Ni+1pyI6o6adqkinT2jHhlT5dDNdZS0e/oTngZ9gg4uJzmtKI+y3a6+FpI=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by DM6PR07MB6956.namprd07.prod.outlook.com (2603:10b6:5:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 05:45:48 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::44e:1359:ff02:2482]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::44e:1359:ff02:2482%4]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 05:45:47 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Daisy.Barrera@siriusxm.com" <Daisy.Barrera@siriusxm.com>,
        "Cliff.Holden@siriusxm.com" <Cliff.Holden@siriusxm.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
Subject: RE: [PATCH v4 4/4] MAINTAINERS: add Cadence USBHS driver entry
Thread-Topic: [PATCH v4 4/4] MAINTAINERS: add Cadence USBHS driver entry
Thread-Index: AQHZlTzm2JR5IbWAOU6uKWfB95k27a+IjXIAgAFLQUA=
Date:   Wed, 14 Jun 2023 05:45:46 +0000
Message-ID: <BYAPR07MB53817FEF19052C31CFC965C2DD5AA@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230602102644.77470-1-pawell@cadence.com>
 <20230602102644.77470-5-pawell@cadence.com>
 <2023061350-calcium-follow-8649@gregkh>
In-Reply-To: <2023061350-calcium-follow-8649@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYjNiOTViNzctMGE3Ni0xMWVlLWE4NmItNjBhNWUyNWI5NmEzXGFtZS10ZXN0XGIzYjk1Yjc5LTBhNzYtMTFlZS1hODZiLTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iMTMwOSIgdD0iMTMzMzExOTUxNDQyODQyNjk5IiBoPSJaaUdYU3BteW9TKzR1MUE5bWQxOG1JSW5uUm89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|DM6PR07MB6956:EE_
x-ms-office365-filtering-correlation-id: 539d4251-2e59-40da-23ef-08db6c9a9a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dp7iEaLJWdg+gSSq1wzrF9GylYLsU9WTb6so2gTHTfdY9QR+jorjroVjpDCgq7xeJx5/epnS6kcYoYJTR7+pf4UlJfUlFkX+pfsOuqQSsqce5VzO/dEF15WtTZm6FEjsRv6N/vxurMmjVY44rrSJTWv2XmrJsDcwLMgiOrU5X44zR6wTmObpx8d3iKK1laCdZdXrOHEhXItDcvWZ3ReM/isIkDVjBg6aBXxydaAwtpn2tsAio/zKKDbquGhCswq+mZjy8LagQf7Ecu/Y/SztBFMsYjm859avEto/Zb8Je1bz7iYw/odrCVmGKQPAfuxrLPrfvpNSfmwZ1WxmpCxx4HZse2G/OiXoMeyuTOTVl2QZKcX+cGekUQs8cT04gqbqvvK7zx4i8EYXPRF9lPIoYWOdfisRvcutKcbr2Ud2BcGDzHBk7CdNVcfyiNm7zyj4hLD5+M7Rnl67pIpr4LVH3lNP6MFJXN0NcgXispcQ3q713YGQB+sW8qxqQBKGN1vc0UTPc13PrICJkK6dZgaygU7E5UbHEs6Rb6A8VtQCeaGvyfRsYabsttzy0fpgGu4iwkv8WYfjcfhK5asiD6AXaa/bXDFyIcqYF/SjkvqsYSWGfKqJD8T6L5cQtJajHYre
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(36092001)(451199021)(6916009)(66946007)(4326008)(76116006)(66446008)(66556008)(64756008)(186003)(54906003)(478600001)(2906002)(66476007)(8676002)(316002)(41300700001)(86362001)(7696005)(7416002)(52536014)(6506007)(33656002)(38070700005)(122000001)(71200400001)(8936002)(9686003)(83380400001)(26005)(5660300002)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJkr8BX/qX2hL4Cf8tXPjkkteApfwyiMxFeyV+r+b5VZZtqDL79gFw8M9ixS?=
 =?us-ascii?Q?kAIaxxPRNoEAhOfXhqNdYoVWe5eQNgxN1fFS0m+yECYVN9/31NPzsjECrXqd?=
 =?us-ascii?Q?OSqQO6mbxvqEvX9m64cedcejAF/aBtiqKNPJpmUZdZcNXD5Ux3Ov63iVnmGa?=
 =?us-ascii?Q?gGdIsaG/9B56OJ7yqEnfD2GyrrFxHCM5bJyzurUu2re9lqC6Fdk+K1NGxrnu?=
 =?us-ascii?Q?fPJPvMex4hhDVc9nB2kspY9Q2fC+Ho6p5wsWSn5L5tTfc1SnjQIEO1g9fuP2?=
 =?us-ascii?Q?yXJnqbpOvXh0INJOGCC4XRlLVl7HInFJq/WqV3xeeVZ3XV5wHiSe8x0ocPWg?=
 =?us-ascii?Q?JV0RnATJDUG5oKWQxA2oFdpMm5rSizZkoVG0Jf6XDq7oBHDP4lq7kklQXAwp?=
 =?us-ascii?Q?Xt15X/sbK4RIMLzNB53qI4MmczOckcYHPSWnlSe3XhL42+Rm4q4v0u/EdZBs?=
 =?us-ascii?Q?Da2WeFeDK+nygKJmz780gD+zcHNsE9A394kTQdhfxisUBROmbpnfwmSa61ut?=
 =?us-ascii?Q?E8dobwbyr7vG4fgrOFJkaJufasJ1Xww4/ApvrVvdwpNsNpkvLJecXxdtB3r4?=
 =?us-ascii?Q?jSagt8LbnTzoDA/sLJO+5Mvs2WerKAPk04fbpyp7L8PM2Dab0wwis8oha6+O?=
 =?us-ascii?Q?bCspJta68uj/9g3cc5jWyt04HO56Pl2mwnuZZTRq9Cb2Jo9kHysw3Rqt0CLT?=
 =?us-ascii?Q?gs2dLqDp9/FmDnKH/SXA0+SGxm8b9ztgmId3x1OOzKB4DlOrcbiwk4AKF9qZ?=
 =?us-ascii?Q?rLpuneeMy8zito6SxtHan85KLE9LHYtgD5GkoAJ5DoRkm16oMDlsLw/y8ERh?=
 =?us-ascii?Q?QC3CDzK66vzqvNXxV3YAUWLoG2AQYmN8YJAOLclQhgrb0LqzaVgzOkd07i2V?=
 =?us-ascii?Q?O0wV+XI4IaT3Od/RX3ql09dzTmKHtw4RKy6VAnM8pplTDuvVd8bJQteleFNN?=
 =?us-ascii?Q?gYhfBQdenrML+OsLKEk4vf4GU7R+90tm2nG1srlkCqFY6hbanja1HGhKbgf/?=
 =?us-ascii?Q?KSD2rxA3IZG3FzwGffjh2T93w4jwR53TrNSAEDqOBdFWDf3yNUGEN2NejbBX?=
 =?us-ascii?Q?eOhd3uOxAoqyMyzA3KSlIHPAReAkyxxe7fo26GguXZmyko6Mn3ess0Rjcbjk?=
 =?us-ascii?Q?ms6tpMxhPG4OgvGoho9yA+cKYBYgnNsLuK3A4gpnMhTUBGtlMGzUjXZtaDg1?=
 =?us-ascii?Q?811dDSmxSP1QcYgrj3jSTOjgIrwcp36qFxxi7xZ+XHOfC+HFTqip003AzGgE?=
 =?us-ascii?Q?43Tj8n8aygOEg5J04dpE3FkjITYcSRGVZoZ53IjMxb8Nhb8qFHKRyRRzW0XJ?=
 =?us-ascii?Q?4unlZRmdOe21dH52d/eVNV0+RuhwuMXY9bRf9X/fUHL9ZfSUM08ccdVXOAy3?=
 =?us-ascii?Q?0SbkPe9hLw7KzBo3uSc9xmZxPhmLUy6Jjwjs8P64mFxysuVG0r0lJ6K8WQid?=
 =?us-ascii?Q?5URN+XFxOmxtQ1WUUX9tAD+pO86xYhxs15h1fCv6zLlhUhZeQLN/ai5UR1hB?=
 =?us-ascii?Q?SAdvWO1RKKtXYfdBzuHh8ZJuKwy7jGCImxoia/0ackykopmQlJJDmSzYx4sj?=
 =?us-ascii?Q?SylYuT3yF6hkrSRbR/aEkv7SLdkfnrdFMKkZrBIo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539d4251-2e59-40da-23ef-08db6c9a9a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 05:45:46.9644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qn0qYVzMgC3Y7Jb25m9mTpShkY67zEUNWvqjRIMSsEc1EmkXDDIcvLKaxMvgWCUQF9/xRRt1EUvAKd57QUXk/yuEnLMS6W6UWmOvSpR0UTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6956
X-Proofpoint-ORIG-GUID: qU6vZIpLRh4vvLxciMIQDTkpmsulfKZQ
X-Proofpoint-GUID: qU6vZIpLRh4vvLxciMIQDTkpmsulfKZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=895 impostorscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Fri, Jun 02, 2023 at 06:26:44AM -0400, Pawel Laszczak wrote:
>> Patch adds entry for USBHS (CDNS2) driver into MAINTARNERS file
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS index
>> c269a15609e2..8b289d52d983 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4523,6 +4523,12 @@ T:	git
>git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
>>  F:	drivers/usb/cdns3/
>>  X:	drivers/usb/cdns3/cdns3*
>>
>> +CADENCE USBHS DRIVER
>> +M:	Pawel Laszczak <pawell@cadence.com>
>> +L:	linux-usb@vger.kernel.org
>> +S:	Maintained
>
>This isn't part of your job description?  Why doesn't Cadence allow you to=
 do
>that?  That's not good on a bunch of levels, have you seen the
>Documentation/process/contribution-maturity-model.rst file yet?
>

I have read it now, but I don't understand where I made mistake.
I guess that I should not be added as maintainer. Am I right?

I responsible for:
1. developing USBHS driver
2. upstreaming USBH driver
3. fixing issue detected by me or by our customers.

Thanks,
Pawel

>thanks,
>
>greg k-h

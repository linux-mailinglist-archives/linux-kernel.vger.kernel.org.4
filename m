Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA4700786
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbjELMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:18:23 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAFA7DA2;
        Fri, 12 May 2023 05:18:22 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CBVsbl005889;
        Fri, 12 May 2023 12:18:08 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03lp2234.outbound.protection.outlook.com [104.47.51.234])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3qh6u0ar62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:18:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxi4poFl7M3S0SAreiB2ulQIKJNmy0xtf+chy4Mdj8E/GoLfIwV74RufYeMssMXKIpwpuA9IZGioygT6DaZOwst2I5bXdq6fnC46AsdJne5F5SRSKL45h+oBeRQxZw2aiPfvBj2aOJ8O80enaEfdZAYC7n5fuFznRL2vRUq6TNC9E/3+mKphV2BbmrKZLYPk0pC0S94AwOVMfdJPzMKsQ26G0DPyJfOzj37Qn9MURzN9e/7gTMWlAJfJlQKwFPFe3b/UJr1h4HFNLX6FXPdT9d1vmevBqaY67bIO16fWmN0Un+ozElTRyfEvCFVSouJVqCbJD4tIgkMQblxFtO1GKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caO53I9T6uU4/1sKhh+YHtxHJBZXQOqTPwrfdFRCTfs=;
 b=Zs5YuCcWpYr8vqGbnncniXmUNwMdDe0tZmCexumKiKkGfluL03jzrKFf06gSPU/x9G56LFwIUc8X8/KzL0V70V3YHjkFt7p2yotb2WV4VpRBt//a6R4JybZvGCAvDknGdd4kxPyMbjW4wHdZrUYE5zXV0BXGWwX3RWAszKS+Wf46gtgXkhyNjeWkKZ7AO2T5Jkyy4Wrg4+0GNzXj1ayL2NcQLgCz73gzVFjHm+T0nWMg9qofXONvrH9SdYNXwPY+L61y74SDDD/6tt6fXKhwtf9zEZN8PzH3E3LPfiqSgu1lxY5Q1uvIFmdOovylrzjUa4ZeF5vR1icATBH7DzGzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caO53I9T6uU4/1sKhh+YHtxHJBZXQOqTPwrfdFRCTfs=;
 b=UYRzGNkSO95ZaFkd32x8UKBmeYGbBlYZjEFDc3nc6IVAuNL4WIqLFTaUmiWfaJf1Iu7l5eNMtEj8rii59JLAiS9xbFOJB/RMLqf0LevXPvMEsuus1S9uFSwGz64/cSG/6/FWVycey9s1HXBjo+R8zAAUFeXMebOoTxkQJT3ii12exBjalZBPRAe/bOdUQ1bRZagW1tRFcYd8PQYNjqkn5z1ZIpy5yGXSHIwRVwhfj3IDXiFcVJ+8EjLkYpCLNgtJREYuJmKMbz9XkzkshWEkeAa08ShykK+KyDThuIq2jkBd0mjG/M6EydwuQ5ayCkhpnb21tWnghI1rCd+5M5HfcA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB9PR03MB7785.eurprd03.prod.outlook.com (2603:10a6:10:2ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Fri, 12 May
 2023 12:18:03 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%4]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 12:18:03 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Index: AQHZeEK66Y+E4GsA3km+qVBMGvAGK69MMbOAgAjzKoCAAUwwgIAANgSA
Date:   Fri, 12 May 2023 12:18:03 +0000
Message-ID: <20230512121801.GA3494263@EPUAKYIW0A6A>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
 <ZFVoiWnvq7UXSBBw@surfacebook>
 <152bbad1-a759-df18-1efa-4e25c54847d9@epam.com>
 <ZF4BKZkbLr2mKN0s@e120937-lin>
In-Reply-To: <ZF4BKZkbLr2mKN0s@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DB9PR03MB7785:EE_
x-ms-office365-filtering-correlation-id: edd7a8f8-9552-460e-26d4-08db52e2ef1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2BMKhPoGv1RKdR5Yv2WAoi+gceXu9TVriyAROQmg3lV/OBe3wkXZO5jtw44CwLJUHMHCcxFftDO+JoUGIt6mcpoHdZPDQj113mOXozk5bwHKlbCIsD2SKGQpSzmkdiw4cF0VINgCB9NcConeikQhi42fjgqSumLMoLMauNVsNglkevBUn3r6ckfiWbqQiCOHhcM1vjcevq9ptdiGBzWLVpNJQ/m3dMEPAXsHDyT0cXMQDEW73NT/cyXZs2Uh05HDOkWIydJEcxZdeJ+IZY9cXsizF/qsNKXsaBaEolNdZcNRalDwf9/kXAh0HozbQC0rZN01yBU7W8zGM0bLSy6r2FqifRuhNM60juwvjHHqwigObVk8z+OVIjI9gj6xgkEYEOZKUNquEmoxmEMNYp4ahWSFHfSGbCg4EJPPbIXBTjuESmGOqA3i2BiIpgvQLnPozGtq/2E8Ip/2QtK87yk5XOmwvvsQUL+WkJCrMHViRIDzINKBze20OGecJIU/qP7aIzbumgIs5HkIHqPjhEiE+BS6SPYxEc+echZmt3SQJy3PYmvMA4sEBMrDvNtCTgN9aJ5EAhv+nWMqjf2pAb5ut0l6zBlH01rnC0E2XXcOF5nr/otC7bjVhG6ga5B5I1mwa9ZtFdJi03DX+NYuFUemQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(66946007)(66446008)(66476007)(6916009)(66556008)(4326008)(91956017)(6486002)(76116006)(64756008)(478600001)(54906003)(316002)(86362001)(33656002)(83380400001)(186003)(26005)(1076003)(6512007)(9686003)(53546011)(6506007)(8676002)(41300700001)(33716001)(5660300002)(8936002)(38100700002)(38070700005)(122000001)(2906002)(71200400001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hi958AhsHXAVgU6brw8RVJGJeIp3tRqk8NkOhXiXzfSLV+DKpveQt6msx8UU?=
 =?us-ascii?Q?CFouLBZJ+nR5H/4Eo3d9+wU/VepdNdU4UGERBik5057JJrYaQhVkIozrUwlB?=
 =?us-ascii?Q?GhS9wYjFMv4pUkj++4wF8rEg0KNJRAnM8ZCLZT1eFZFEetiRC+YYMugKmHm4?=
 =?us-ascii?Q?faXWGXPx6apif0zESRFNPM3T+FXMP+h8WD1sKjIEK1N0bjBb9xusGadxxs+S?=
 =?us-ascii?Q?N7uE1H9BxHzY4zR2XlZgeUciOsTrBSN4WPiBBvDIC7FEbQPYmp2cwxCUWgdW?=
 =?us-ascii?Q?I1DlLxGjYUC3F3D6/KwZtz9lcTpz+KWJ792YSH+8qjHCCVhct+iChMb8C6DF?=
 =?us-ascii?Q?zQ80Mq/jGP+J87nyGx+xVqr+tSCfgdd8QDYkor3aq5MtHc91P1WVUJX29IGm?=
 =?us-ascii?Q?AlaZ4HHJk4aWhZ84/OcMabMlyuBiLuLZHniGz56BeJYROtqntS5MZx6/yPgf?=
 =?us-ascii?Q?rG31VLZG17BGHedRZHRl9jkMvjZ78ydDQYP7WWANIn9IGJLHV28NGViGDyM8?=
 =?us-ascii?Q?GYfYFMQ90VDwHsoHCoPECmsrgHH8i9ArNtAo3bA5puGMzhEaRnQ0FsBAAhI8?=
 =?us-ascii?Q?0ZmLMvjNs7rbu9IDE+2SWStBOUSFABzlR0n9ZlWkB+YvhOkwD/HTkdKUViHu?=
 =?us-ascii?Q?sjuvVgKbKqqEfVLo5u8Vg0FBdzujBvLY0e4fBgn+m6HcxkBZxttjWUfmpCSf?=
 =?us-ascii?Q?reHdlAlxrFM9SeYrum01Vlfu0vVsZmxvuonp28uWiGb1Nywl8mwXB8Ase7Ee?=
 =?us-ascii?Q?+X6JfJLT/92vq643dGwwI11cztAq646P/RtiQGH0NTg//eih3Za85YdTV3kj?=
 =?us-ascii?Q?y95Mb9q3HX0Ks6TM0HuXOR+vTs59EK6zwm+cZoozCdnT8kUA2OL27+OWfZ98?=
 =?us-ascii?Q?ca9dIohHsVICQk2DMm3a17pOfnERUX0eJLUxEJIianN2F1BIGcMbWLZVHltL?=
 =?us-ascii?Q?E8Zju5AiRxQyBuUBvNfZkFZTt0a+EvkjmF4A+mvrTElBAZQkuKz61CtikUBd?=
 =?us-ascii?Q?K/PmYajKTM7VIRhGSxRbrMRzX2neRNHrT1CCU0DIzfXbTHQ5vVhDzxdYRKEx?=
 =?us-ascii?Q?hwz9/p37uca5OVruK4WMVFgQBmokgtjNGNmtTgrwSmBrHp0wPP4L4L6wehCJ?=
 =?us-ascii?Q?XgpE4pYgsN6b373jWDZH4McSEamXisLGk4evzexjccMCHbHy3x34Gp3DcTjs?=
 =?us-ascii?Q?ncPX6WyPAjn1SIkQFNZl15VG6CpBLzntVG7Q9Vk0xH5GiFXXHtxfEXLMlZvZ?=
 =?us-ascii?Q?FsY9kW2hy7FSRu6RFzckJbm76WZWg3kLXLvmtti3y+VyxjDoTy6yPhUIzFRD?=
 =?us-ascii?Q?4PR0w/eRrW4ONnIEmDfZeaA+FF2WNnauoxdipyAYFAPhZtL0/AAxrpLgReUu?=
 =?us-ascii?Q?lO2ONKvmmQX/RciDqwUDlffzsOybDGuzJpzJTuyZLITduoDJ0y9W3Owf8G6s?=
 =?us-ascii?Q?SxRObvD4msJBZcAAntJ+pFso1rmOW5Ca8D3yveYFAYk9Ztvn+wrpMtNBvkok?=
 =?us-ascii?Q?XzuB0oa25d+7hg0JuAoBaevFoYI1fIBCyYA6pmr0vxRufuVAs8f86sIQjNqw?=
 =?us-ascii?Q?Bb5FuUlxufaV0AGOcJ3tNtmw/aNO725DAOczMg5lBTqkxICvbWDOau941oky?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D45A78653434314A971D2BBC2A38130A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7a8f8-9552-460e-26d4-08db52e2ef1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 12:18:03.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjXggMTQ3AJ5Egv6W43KbL/UhvI4YOCyK10j5D++xyeazySSe+Qx9CEUwJvKCpQ/iuKB7S3vEIiNj98PXoym232tLnUve3u3S9HB5jlVdks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7785
X-Proofpoint-ORIG-GUID: F_qENu-SenMNONOB45BD_DwBoIn7fqwI
X-Proofpoint-GUID: F_qENu-SenMNONOB45BD_DwBoIn7fqwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=978 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Cristian,

On Fri, May 12, 2023 at 10:04:41AM +0100, Cristian Marussi wrote:
> On Thu, May 11, 2023 at 01:15:46PM +0000, Oleksii Moisieiev wrote:
> > Hello Andy,
> >=20
> > On 05.05.23 23:35, andy.shevchenko@gmail.com wrote:
> > > Wed, Apr 26, 2023 at 01:26:37PM +0000, Oleksii Moisieiev kirjoitti:
> > >> scmi-pinctrl driver implements pinctrl driver interface and using
> > >> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> > >> SCP firmware, which does the changes in HW.
> > >>
> > >> This setup expects SCP firmware (or similar system, such as ATF)
> > >> to be installed on the platform, which implements pinctrl driver
> > >> for the specific platform.
> > >>
> > >> SCMI-Pinctrl driver should be configured from the device-tree and us=
es
> > >> generic device-tree mappings for the configuration.
> > >=20
> > > ...
> > >=20
> > >> +#include <linux/device.h>
> > >> +#include <linux/err.h>
> > >=20
> > >> +#include <linux/of.h>
> > >=20
> > > I do not see any user of this header. Do you?
> > >=20
> > Yes, thanks. Removing
> >=20
> > >> +#include <linux/module.h>
> > >> +#include <linux/seq_file.h>
> > >> +
> > >> +#include <linux/pinctrl/machine.h>
> > >> +#include <linux/pinctrl/pinconf.h>
> > >> +#include <linux/pinctrl/pinconf-generic.h>
> > >> +#include <linux/pinctrl/pinctrl.h>
> > >> +#include <linux/pinctrl/pinmux.h>
> > >=20
> > >> +#include <linux/scmi_protocol.h>
> > >> +#include <linux/slab.h>
> > >=20
> > > Please, move these two to the upper group of the generic headers.
> > >=20
> > Thanks, fixed.
> >=20
> > >> +struct scmi_pinctrl_funcs {
> > >> +	unsigned int num_groups;
> > >> +	const char **groups;
> > >> +};
> > >=20
> > > Please, use struct pinfunction.
> > >
> > I can't use pincfunction here because it has the following groups=20
> > definition:
> > const char * const *groups;
> >=20
> > Which is meant to be constantly allocated.
> > So I when I try to gather list of groups in=20
> > pinctrl_scmi_get_function_groups I will receive compilation error.
> >=20
>=20
> Maybe this is a further signal that we should re-evaluate the benefits of
> the lazy allocations you now perform during protocol initialization
> instead of querying and allocating statically all the info structs about
> existing resources.
>=20
> Not saying that is necessarily bad, I understood your points about reduci=
ng
> the number of SCMI queries during boot and let pinctrl subsystem trigger =
only
> the strictly needed one, just saying maybe good to reason a bit more abou=
t this
> once V3 is posted. (i.e. I could bother you more :P ..)
>=20
> Thanks,
> Cristian
>=20
> P.S. [off-topic]: remember to use get_maintainer.pl as advised elsewhere
> to include proper maintainers (and their bots)

That's a good point to think about. Actually, functions are the only
thing that should be cached on pinctrl side. And we need it specifically
because groups in each function are presented by names, not selectors.
Maybe It's better to move this caching to pinctrl scmi driver. But, from
the other side - storing group names for each function is Linux Kernel
specific implementation and we probably don't want to add some specific
case to the Generic protocol driver.

I think I would leave it as in V3 so we can continue discussion.

Oleksii.=

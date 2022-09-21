Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE115BF383
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIUCht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 22:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIUChp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 22:37:45 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A2C4F3BD;
        Tue, 20 Sep 2022 19:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEZIhJxqtUmRfnHAcT8dDbAOc6oVAUEZcseYNrQTvoe/FBFXm6GC7zwhqfApczncJwSIL1tZx014QpjpvpVN1NrF3UAmHjaCM3Yfx2FNSJNMWoIdE7FJaKgizLfXznJC0j8XDw3SfqFXuQCGuOosJZ8Zyhc+lSghwFI2WR97qBw6l4lq/Ek22PLToe2d8b1KhymDBULEFZUvnYLxm6qxCU9Cr1wYOoFMbMPHeIqf0B5ovwHaM/OhsKvnE0vUYh5cZOThZWtfju1jl8+a+L6YUDnuu/4hg2zq1K78SYBiR/DJHWskdYAgfq+UX3ZndIps5lM2cCfB4NMK+QuRdokASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=040P8xgMN+l+fWvUWJv9nsx5rxMaodGz7WBI+/4BOkk=;
 b=kMAXqz61hJPO06Q6It7qgatBDWl+HNvoF4uO7eSysp9UbS1wubssfgQFpXIQE8aBvHOKvEO6lfFSfhXwdGKLS5Z/Zia2I8sKxYsa0ihpmJPIwE7TQHlzfs6H69M/WU3A0d+WwzwtViXSRftNOd4u+4GiD0y8hWoBSQMBEccHZK0jUXvFzk0oTJ7l2KwNC+L15Jap3TwJC5DMxTwPTuJT9QqEFtD/vytQwIO3mXg1ViObCtCfq7nhhtqPTvp3moCImo/b2sb8jPwefgJLpwljuze7xkJGDWk7o/wfQ9lnta/mxe46oxy4Mft7aWm8WhwluCcG954QkLoXZE8ZrGmPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=040P8xgMN+l+fWvUWJv9nsx5rxMaodGz7WBI+/4BOkk=;
 b=c5EAb/UwFLqlv4nDr7RPimhK8/9sYR7NLE4rmBvScMMMQNFRnlCXgQaofmK60Mcu/D7Z+MjJdB5+lvSUWcQe5KEpE5xMt8B4F98XCfiBKnZynjfmJ9uibN3qLGljX7M34E5Ypb04o9om8WYcZ2FXG+wYVzFz4wig7oMOAUhoRck=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8737.eurprd04.prod.outlook.com (2603:10a6:20b:42a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 02:37:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Wed, 21 Sep 2022
 02:37:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 0/2] remoteproc: support self recovery
Thread-Topic: [PATCH V7 0/2] remoteproc: support self recovery
Thread-Index: AQHYkAx5W4uJ0cTEEUqsuvaJeDSHw63oHMyAgAA4t7CAAN8iAIAAbBDA
Date:   Wed, 21 Sep 2022 02:37:35 +0000
Message-ID: <DU0PR04MB94175CA5D85BA079E2C4D462884F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94177A3658A8B5E57D0C5DAC884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB94171E5A5D7EFD79E3C2D950884C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220920195128.GA1042164@p14s>
In-Reply-To: <20220920195128.GA1042164@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8737:EE_
x-ms-office365-filtering-correlation-id: 99c82b66-50cd-4aef-4881-08da9b7a3dfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6uXTJ2zHQdjefzNHp4qt9cBsQ92SvFjx3d+g+UbbnISEmthvWtYVvjolz/7SdgRu2v23Zl8lnzN5++XS8tWTlkO2ZV/1cP4OdXgh/BJ56p6mLS8kgEVdEHbE69saNwRw30Hhzw4n87DkJJ0cAlPYbJkUUCBMYHL9GglKwJJC1P9r8jHz1CraV3wEs8lfVB6UyECPtIyjscTw61wJsWbsfj5bambBpK5ogAGFllY9HjAzunlu2IIxK3Jo7/7HDQyN9mznIr+Nyo8xKOTb9SWGY4CXx833t+vGzbjiageM81oQKCIxX2R6UGsqnSPap2kzkrLK3RtBQdZvRXTAqOtjGlCD+lscq+9jG2ttcUVrfWxx+7C8UuJR4Io+aiTrE8aS7fkp1j0ThzJt1X6ShxD/1FoVYYw9ZttIXshJU0gk/Ii6vY1Ri2WZaRIhlFdftW9Hn7d5CLMMxI/M/RSUP9T+PpURWdjy6DuwBJr3v1CiWFVGWzYgZZOipWA4ukfjCCky1nmn3vMtT8F2NcrO+crDsMGsbY4x3tOtcrkxjOldBxssRB6TeGVv6p9wJrXJl+O2K8ZQuXtMtHpknTXT0eqLXldM4hbnP9ch7Q1QU0UWdwhAqdruswZLa0ouhVdiMQ07wWXT/CGyILsOt0FJfa8MPXRCWTy2AARlg5nIxCXS7Su+F7SP5uRektonvlesOy6J53BnKoC40KtfqtW59pE8uiOCXhXCXV8B5CG09cBMgjeGIFASp6a5Jq7Oavfk03Z7OebS7zxRaKwaw/u/dNZoM4o1NQciAb1aM6LCZ9yEoaU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199015)(33656002)(2906002)(86362001)(38100700002)(8936002)(52536014)(55016003)(5660300002)(44832011)(41300700001)(45080400002)(186003)(38070700005)(6916009)(54906003)(122000001)(316002)(966005)(478600001)(26005)(71200400001)(9686003)(6506007)(7696005)(76116006)(66476007)(66556008)(66946007)(66446008)(64756008)(4326008)(83380400001)(8676002)(66899012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+gRVyMtRSVJKIYB56LcfggfnULc9G2Bb45iINpkklGXLsdKlCBW7tfKWkCTi?=
 =?us-ascii?Q?KpO7OYIimj2AQWMJ7MdjOr/Xk1RUhbVug5sB/xFF6154PKp/UOQzvp5TjMGT?=
 =?us-ascii?Q?Nrise5kE56AKQk/j/02STSmAUEIUncjbOaVy4b1gT7C/3ZrEfLYlKXQ9wy6s?=
 =?us-ascii?Q?QAd90akGRmHhXEESMrBJoV6lW/nodnPCh2vtIkQFE5slQflC7i3Y0iXH2kom?=
 =?us-ascii?Q?jOH20YeU92fMkGXZSS6WQPbsx+kmydy3t94JpOPmdg8jvDhJbP8z8Vhh3doC?=
 =?us-ascii?Q?yAe1L3DQYjNzxCIP4awTGJqaQO6wgvndyeYUw11ggOzCOxpfsqkJc/vtvfAf?=
 =?us-ascii?Q?iixIt/Y1GNZuO0E83FWfypeCswKjENjiifAvT5NcxKEZ5J3OaLFRtM5RPuYH?=
 =?us-ascii?Q?EXoLh0as/RiorGhCASwuu3a5bDSmeuUxqAdzA7H9eloYHh7N9KOvlG01B3u7?=
 =?us-ascii?Q?Yup/R+ElfgkKztxRi5uWA26BIdbLkS1nwU4lshmR4WdwrCoTRJkjoaOgY4Wf?=
 =?us-ascii?Q?F1y4G+Z3rtUBJdMy0wG/fiYvgeEQx6Dn8gvarMwc3RxZo5eFrNR268jjluO9?=
 =?us-ascii?Q?cl5HA4lcmDhZeHe6r9AJP04San0NjcLI7WeenvOw7R2cB1f7H04u/9ny76va?=
 =?us-ascii?Q?aA1ukY3Uqk6HuGlJT8ro7IR78DHh4TXuEM1WYyEXbOR3fGve4m/TN70O36FL?=
 =?us-ascii?Q?L61508/QDI1otNIyv42vJRBP7qkqvWDlAGPliu5pM3WuHUhzVwQekj58xr56?=
 =?us-ascii?Q?IRqIQCTy2syk1uORpDMnDJqiH40hCA8axZr7c9krW6bHdjxpJOEeZ3L7XJzh?=
 =?us-ascii?Q?QA2druLOYPVPymHpQvzPBuHYeexXsbFG894tx//iXlpvnbmqleOAOnz6c//U?=
 =?us-ascii?Q?jpgdgidxojk7VLuUR4F1qbzYRw4TBWM9EkylskvYpahUaz7rkye6bcRAydOQ?=
 =?us-ascii?Q?wy3gMhmJatAnMX/+lTRSEgDNGDY11sskUc/vMOCYw2xW/zPESI1GrJNuKsdY?=
 =?us-ascii?Q?6HDqcqs5q3YKIH9dQL+SqMvbrt6F/KBPyMBW1kdmrte+Ot1F4pD4ZXDlJrLA?=
 =?us-ascii?Q?RFG7kBd0P1hsN942Se0QbCIZc/uv+q1Jalmgns8MFj31YspFTXHe5qj+ra8t?=
 =?us-ascii?Q?2VCc8fKQmuzyy/bSjidb7DkcTzPI+tdUk+AHUdZJ+Cz3DP0APUezHH5mP0dv?=
 =?us-ascii?Q?RpzOEIHurScOG3f4GeNDJaoNAo3mzBfbwjmPwBjK75OZTd8HWntQ+ClqGuiL?=
 =?us-ascii?Q?jaB2O2gkt9hke9rSbjoJ/V7G0vQBJE63O6kmPHHTr7doB6t3xPejRI1reqOt?=
 =?us-ascii?Q?Pl+Bv4FrggIVOh0SjUVeRy81koHKLFdUzff8DaOMEmQ/ARAB2hTdfeHF83l1?=
 =?us-ascii?Q?crAs+b5N58EqUPz9Nti5S8Ma1d0FzsbcpaKFz5ROQC0KfRPtRoD7jp6OFpxh?=
 =?us-ascii?Q?9U4JqdoqisrYMW0fU2gOMOIQzLZ5ce+0fFFe82MiIx1OFROFS6WD8sMtEJQD?=
 =?us-ascii?Q?RGluWOZLlSDxoHFNQLiGNc7IZPiI1z8//5QZ3AWpeYuVePr8QzNqM21D4Sk6?=
 =?us-ascii?Q?hU9DJn/RTdsj7a5apOY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c82b66-50cd-4aef-4881-08da9b7a3dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 02:37:35.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxAKpJcip6SIsAD85rMUP48fmj66+O2c0vk9cNjk3UXTKQqKtUdDv/BZ6p99C01vuvB1pRUCtyxOQgI8yBnvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V7 0/2] remoteproc: support self recovery
>=20
> On Tue, Sep 20, 2022 at 06:34:18AM +0000, Peng Fan wrote:
> > Correct Bjorn's mail address.
> >
> > > Subject: RE: [PATCH V7 0/2] remoteproc: support self recovery
> > >
> > > Hi Bjorn, Mathieu
> > >
> > > It almost two and a half month until now, I not got any response.
> > > You accept or not accept or suggestion?
> > >
> > > In V6, I got a typo  comment from Arnaud, then Mathieu replied
> dropped.
> > >
> > > In V7, I add A-b from Arnaud and no more response.
> > >
> > > I not understand why ignoring me.
>=20
> If you were subscribed to the remoteproc mailing list you would see that
> every two weeks I send an email that lists the patchsets in my queue and
> the order in which I intend to review them.
>=20
> That helps people know what kind of traffic maintainers currently deal wi=
th.
> If a patchset is not listed on that email it is likely because it slipped=
 through
> the cracks, as it is the case with this set.  You did not notify me and a=
s such it
> was impossible for me to know about it.

Well.  In future, I will ping you if patch is not on your list.

>=20
> Last but not least I do not recall you reviewing a single patchset on thi=
s list
> since the beginning of the year, which automatically negate your right to
> complain about how long it takes for patches to be reviewed.

ok,  I get your point. I could help review imx specific part and
remoterpoc common part, for other soc specific support, I may not
able to help.

Thanks,
Peng.

>=20
> > >
> >
> > Regards,
> > Peng.
> > > Regards,
> > > Peng.
> > >
> > > > Subject: [PATCH V7 0/2] remoteproc: support self recovery
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > V7:
> > > >  Per comments from Arnaud Pouliquen:
> > > >    Typo fixes
> > > >    Added A-b tag
> > > >
> > > > V6:
> > > >  Rename rproc_firmware_recovery to rproc_boot_recovery  Drop the
> > > > unlock/lock when do reproc_attach_recovery
> > > >
> > > > V5:
> > > >  Rename RPROC_FEAT_ATTACH_RECOVERY to
> > > > RPROC_FEAT_ATTACH_ON_RECOVERY  Add kerneldoc for rproc
> features
> > > Change
> > > > rproc_set_feature to return int type and add a max feature check
> > > > Use __rproc_detach and __rproc_attach when do attach recovery
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > > hwork.kernel.org%2Fproject%2Flinux-
> > > &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> > > >
> > >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > > d99c5c301
> > > >
> > >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > > yJWIjoiMC4wL
> > > >
> > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > > %7C%7C&
> > > >
> > >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > > mp;reserve
> > > > d=3D0 remoteproc/cover/20220615032048.465486-1-
> > > peng.fan@oss.nxp.com/
> > > >
> > > > V4:
> > > >   Based on Bjorn's comments on V2-2
> > > >   Move the rproc_has_feature/rproc_set_feature to
> > > > remoteproc_internal.h and  Keep rproc_features still in
> > > > remoteproc.h, because we use RPROC_MAX_FEATURES to declare
> bitmap.
> > > >   Update commit log for patch 2/2, and add comments
> > > >
> > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > > hwork.kernel.org%2Fproject%2Flinux-
> > > &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> > > >
> > >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > > d99c5c301
> > > >
> > >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > > yJWIjoiMC4wL
> > > >
> > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > > %7C%7C&
> > > >
> > >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > > mp;reserve
> > > > d=3D0 remoteproc/cover/20220323034405.976643-1-
> > > peng.fan@oss.nxp.com/
> > > >
> > > > V3:
> > > >  Resend the wrong labeled patchset
> > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > > hwork.kernel.org%2Fproject%2Flinux-
> > > &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> > > >
> > >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > > d99c5c301
> > > >
> > >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > > yJWIjoiMC4wL
> > > >
> > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > > %7C%7C&
> > > >
> > >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > > mp;reserve
> > > > d=3D0
> > > > remoteproc/list/?series=3D621311
> > > >
> > > >  Write a cover-letter
> > > >  To i.MX8QM/QXP, they have a M4 core self-recovery capability
> > > > without Linux loading firmware. The self recovery is done by
> > > > SCU(System Control Unit). Current remoteproc framework only
> > > > support Linux  help recovery remote processor(stop, loading
> > > > firmware, start). This patchset is support remote processor self
> recovery(attach recovery).
> > > >
> > > >  In order to avoid introducing a new variable(bool
> > > > support_self_recovery), patch 1 introduce a new function,
> > > > rproc_has_feature to make code easy to extend, cleaner, such as we
> > > > could move "bool has_iommu" to rproc_has_feature(rproc,
> > > RPROC_FEAT_IOMMU).
> > > >
> > > >  Patch 2 is introduce a new function rproc_attach_recovery for
> > > > self recovery, the original logic move to rproc_firmware_recovery
> > > > meaning needs linux to help recovery.
> > > >
> > > >  V2-version 2:
> > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > > hwork.kernel.org%2Fproject%2Flinux-
> > > &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> > > >
> > >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > > d99c5c301
> > > >
> > >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > > yJWIjoiMC4wL
> > > >
> > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > > %7C%7C&
> > > >
> > >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > > mp;reserve
> > > > d=3D0
> > > > remoteproc/list/?series=3D621311
> > > >  Introduce rproc_has_feature
> > > >
> > > >  V2-version 1:
> > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > > hwork.kernel.org%2Fproject%2Flinux-
> > > &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> > > >
> > >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > > d99c5c301
> > > >
> > >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > > yJWIjoiMC4wL
> > > >
> > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > > %7C%7C&
> > > >
> > >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > > mp;reserve
> > > > d=3D0 remoteproc/patch/20220126085120.3397450-1-
> > > peng.fan@oss.nxp.com/
> > > >  Nothing change in V2.
> > > >  Only move this patch out from
> > > >
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > > hwork.kernel.org%2Fproject%2Flinux-
> > > &amp;data=3D05%7C01%7Cpeng.fan%40nxp.
> > > >
> > >
> com%7C9dfde1d27090471a892208da9ab7bede%7C686ea1d3bc2b4c6fa92c
> > > d99c5c301
> > > >
> > >
> 635%7C0%7C0%7C637992411213950582%7CUnknown%7CTWFpbGZsb3d8e
> > > yJWIjoiMC4wL
> > > >
> > >
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > > %7C%7C&
> > > >
> > >
> amp;sdata=3DLHIDdh2f%2BKYD2dJmiEqBGV0D5p4qgiay5KhvuTdDjHQ%3D&a
> > > mp;reserve
> > > > d=3D0
> > > > remoteproc/list/?series=3D604364
> > > >
> > > >
> > > > Peng Fan (2):
> > > >   remoteproc: introduce rproc features
> > > >   remoteproc: support attach recovery after rproc crash
> > > >
> > > >  drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++----=
-
> ---
> > > >  drivers/remoteproc/remoteproc_internal.h | 15 ++++++
> > > >  include/linux/remoteproc.h               | 16 ++++++
> > > >  3 files changed, 74 insertions(+), 19 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> >

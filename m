Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592FE6A10B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBWTn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBWTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:43:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6A4216;
        Thu, 23 Feb 2023 11:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akoFbTgnyZHbAaQoF7vYBAIKFJ7fvUxStxe8iAoqboWvcQ8UBrZZatuPgRaB1BrFUQbJM/4W7Pcs5t7J2NkJ7smgzdI+etxN9pjvMqBBrJUvvHey3kBy2ZnskoTZ82rwEljTFLVGf849shwcyDoNAYbY4S9ee3aBx8xXkaFWYR86UbwZLvWiRZGbSeneTteJAJNwDkQ59hw0NRMyQJmWDe5QDLwORLnsJnCTXWR9aiyR5glmQSrX1AVXuWPuUEv/daUGGyfAbF9UUsONtfq3UWBpvQinUe39mStZ7Gon3ESvVr5MXWuCMnxHFhYxIIgVXw9c4XpUs3N4Z0h4Qoeu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0oPXSNmOyBggh8hItYftrGNRfEg0qYdh2+DV3wb1rc=;
 b=eLdnNuWUE+r9vFl/EJwhxZwRvEr4R5YGZE0cixJ7mc93ZkmD5iQqwB0yKGsrv4ETtcqsn4XDSauAcN0kK443U6gS9qUyb2RUTAd1lfPJghOsfFufegyKLa1EHrUMesVwhnKytG/J6Ef8FQj43fQhbxphM7DtxGB8OV3I11XV5JmRRuK6BL1JF0TPkpKHd/ARngmtLIwOEYqYACnhGEbAM0uXShy1CK35qdYVHAECWJPMmFwEe08LZxev55V0nGhtwaxyR9ByEYlBSlEi3uxXkU1RBdtqDlyejbGDqLaUV2ExmfnzAs26o+mm2riwhtAsx3pxg8sNuR5VHIOrfzuuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0oPXSNmOyBggh8hItYftrGNRfEg0qYdh2+DV3wb1rc=;
 b=106gkeUaoWMcYGk1mHrMH0O8wP0MTzOuF/brHOkg7QCIhld5aar8ejNymBvAW2fLK2oEtQUkNtxoJD/YAs9QVP2M/g1xiJDDZ5bpyYiNOc0WjSTj9XCC5BxfKhBgxMMLePxrW5VfIAzezkHzNkf8N8WlolAJoCaMIVhbzsB6KGw=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 19:43:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:43:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is
 disabled
Thread-Topic: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is
 disabled
Thread-Index: AQHZR1T7OhrtHMD+GES47/6Qk6ofl67cZ+yAgACHfQA=
Date:   Thu, 23 Feb 2023 19:43:21 +0000
Message-ID: <MN0PR12MB6101277E161A6A9E1C0B82D5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
 <Y/dQHXtdDWiZOADY@amd.com>
In-Reply-To: <Y/dQHXtdDWiZOADY@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-23T19:43:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b7f743fa-fa31-4729-bea6-15f5c56da5f0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-23T19:43:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 66239a61-ebd1-402a-b627-a1d2d42e9b9c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB8146:EE_
x-ms-office365-filtering-correlation-id: 86e9d6db-01cd-4ff2-96e4-08db15d6381d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgzQy+ZT+1W5EVcCSZVLwkhXj+WR8HBCmm16j5wVfyYSj+F921hlnf2LyjAG1FqCOAvge6BLDWVZUsrLjBrRWmsRxYB/SKd+FgGqqy/y2XnmHOYCkp/XxbX2/3W8wIfZR/hi+eK/lOZA34naOqOlH3zSvj9/Jy7LDLabzmLN3N6t8sckuVcvkU92/WZYUPnZKqQt487eyxjdNah84tfcSRJKeYJThKoIORbAMIS9aAfIhNVhet3CvpBqurQMDUNVLdPzftXR2/MdsxI3qL4Xtbqa8/YxjzUFYVNBCW/L5ugOqZgOypeGX/rv1gMt436A/TCPnBFyKThOTYixMETN2A5d1lnZho/7dzO1inwZs2/+1/0qKLXuxnUO/JB61QKeGRqi44+Vj94U2wk60xvsgFhAenKLlG1vNrAevt65hzlVh30Yh/KooGMC25IguK4RS00JwKy0bijyZVXP2ar1m5o6GdZse0JiMlWlMSBJHKEy4hSrPgJjXNuL5BdsehPACtQc5Kzg4cTB7ckn1TbNf7ITxfgAVkZd2uuRGHI3iKlN0EdV1520wnf6pz1QJaX/P8R/TA4WwzIvzX423c9NRiFQKmf9G34x/9dPoJERtPP5cbfV/Po2vGwb6oFlf4odbILelskbRmcP8WXXbMopJ7BXIEyxWEVoekWfHpBBCVe3LBFVzTHERmMAnR2Iu0iY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(71200400001)(76116006)(54906003)(4326008)(66446008)(8676002)(66556008)(110136005)(478600001)(41300700001)(66946007)(52536014)(5660300002)(8936002)(66476007)(64756008)(33656002)(38070700005)(86362001)(55016003)(6506007)(53546011)(26005)(966005)(186003)(122000001)(9686003)(316002)(2906002)(7696005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iEINeLSl5VhGLGbfbHRR4gpoFA1/ZMRK8KJluXVD6fxFY+aDbb9gTgRNOAMS?=
 =?us-ascii?Q?QC32OxUVwvJlHebuEA3UKoKuHgatKZd1DEZnkmX4KcS9rGyEw1y8RkjxQBZP?=
 =?us-ascii?Q?erbm+KcimYfOGsq9gg6hTw7/jfiFHPwZqCIPMayYRvNq3YW9DzQOX4Ttvxp8?=
 =?us-ascii?Q?ZaiQyaTfrySoCiVo1pF5d4Oj2HTl5mwZ5vm02Jb+gxsGvccwR0US/0A/rQGh?=
 =?us-ascii?Q?2vezp7JOZvDhVYqVZQFisH/lYjmQy4o4D2YPjK7wm/CN2o/6MycgOqHB22Lx?=
 =?us-ascii?Q?uUvj4qyXfkTsEMeY0HtWzAJnRPA1R3U6FyGLzQNdENGJ43/+7V6GLvvUUvjQ?=
 =?us-ascii?Q?e9OrzeFUjDMyW4XXggLhjj4lUdRQWzfKlMsYQWtLpLCuF92qq1H+eRB+qR9q?=
 =?us-ascii?Q?3l3yrL2rJtRYLziIM1wsvrM4N6iiObfn/ok9sOG4xWj0G/xiunv8tkihkLfV?=
 =?us-ascii?Q?eY8sOD2RwB0ojBGuFnx8bEiPV1QYdSbinZsa8aEo+1IYqv06ufOXCPrXk+Kz?=
 =?us-ascii?Q?e0IQ+MpZ34TBtlYD6MSqI50AvzQGSJbeEMpw6R9Fc/qlJUNRLx4HEnVpuaEO?=
 =?us-ascii?Q?ug8AvRY1rzkEXvt1DmAiL63taizR9rI5+Z+vCyrhNew0QZAIqGzIQBe7KoUB?=
 =?us-ascii?Q?NtlnVnW9CMt11gjDEayoevqOyrfkXVV1+Sh8I3dlzEq5E54drCRQriclXsb1?=
 =?us-ascii?Q?SZRLORzJtWzBQ+SzmQUfcM0USrE5Zh3sus6wmHvcP7MT4VRr0boyvN2ZQwP4?=
 =?us-ascii?Q?U+WueBXbstiZZi6NaMaBQDaf2T8mJtOxiq/Qeu5Fhh5U417m/bxDRyRoX16S?=
 =?us-ascii?Q?ZlGqmDx/aU7RxrBx9Unm6DwE5HvU2LMx9vrBGiqBEWBaXAi+tXy8e1NrPMtA?=
 =?us-ascii?Q?efH/GYQUTXobx874vPJYIVA4Ykj6AyURdX701yTb9g7n165+fLoNUyJ9bi3Q?=
 =?us-ascii?Q?HNc5o2GOOgzEmBApLBTBquqSMRHKhwDSOcJ0xcfQ3X//DxXvvl2RqkuB0ono?=
 =?us-ascii?Q?upGl9EEDUssUV/J0lDn1iXjq47y/Llu2jpJX55BzIVRg6D6XLLYGFhhLyqZ5?=
 =?us-ascii?Q?HgmgiFY7G8PP2tHjQpR9ZuyTB8IWfTAgc5lPN6oKaKzp/M1T/I+dSF6Au1nE?=
 =?us-ascii?Q?H7sGalS3kStOe/4fmY+vy72bI5XmjUMmXfFsKBccPpECcNjYQf73xjvITtgo?=
 =?us-ascii?Q?ENsDrwMig6lky4hUMzsjE7ba2spK+xqAw5SI/z6eTIzu2qmwy4LmyB3dFpe5?=
 =?us-ascii?Q?8t+EB4l1JbFMLOfMDdukhDSeiQho7z+cMGCwcmr1gw/c9E2S2zkswWaNobx1?=
 =?us-ascii?Q?rxkB0Z7346nU7pEmxPE5/JAUMbGjuLT+O4D8nBsmKTzOCuNkpk1cUBPc5vSB?=
 =?us-ascii?Q?Wxm0WXZRNm9Ash9/67epVqLd0lWjBAz2bHpqRgeeYsBaag7+oH6HySc6Jk2m?=
 =?us-ascii?Q?4rKl/uGte1b+wqKubtjYfeOABryeBNYBJ7tMgJN4n6D50QLlITirikcPV+Gi?=
 =?us-ascii?Q?xhM/JfFMP35IkvSmEqTH3ySv0LswB1cQ2VR7HEV4CbQoADThfC0+8eKf9cEm?=
 =?us-ascii?Q?WMtPygSOuL7B+/bOnQk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e9d6db-01cd-4ff2-96e4-08db15d6381d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:43:21.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41+R8LLgfbegtUyFyNKjw9mae+/XxviHnOVvIRFg6utCTgsl7FkQRBxiVSAGIFeX+OK5HSU4jLEmaS143azy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Thursday, February 23, 2023 05:38
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Rafael J. Wysocki
> <rafael@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is
> disabled
>=20
> On Thu, Feb 23, 2023 at 03:02:52PM +0800, Kai-Heng Feng wrote:
> > Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver
> > parameter for mode selection") changed the driver to be disabled by
> > default, and this can surprise users.
> >
> > Let users know what happened so they can decide what to do next.
> >
> > Link: https://bugs.launchpad.net/bugs/2006942
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>=20
> Please feel free to add my Acked on V2 as well.
>=20
> Acked-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>=20
> > ---
> > v2:
> >  - Remove redundancy in pr_info().
> >  - Fix spelling and URL tag.
> >
> >  drivers/cpufreq/amd-pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 45c88894fd8e..f965f54f7ae7 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
> >  	 * with amd_pstate=3Dpassive or other modes in kernel command line
> >  	 */
> >  	if (cppc_state =3D=3D AMD_PSTATE_DISABLE) {
> > -		pr_debug("driver load is disabled, boot with specific mode to
> enable this\n");
> > +		pr_info("driver load is disabled, boot with specific mode to
> enable this\n");
> >  		return -ENODEV;
> >  	}
> >
> > --
> > 2.34.1
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44C2625E18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiKKPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKKPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:16:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC1073405;
        Fri, 11 Nov 2022 07:16:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltTRRQRwvZTZs7nfbmKBSfvees0LIxTb5II1cM0r8lOUZwdWb2RxX0J6TePEPjvhv4/zevIV8TU2hyUOW+ZOwr835rUksQ/lKWzcSwlm8YuYjqOF25GxcquAu7qGAz03cYnZvzVA4Vd8ONfQgmP6ORb4r2sJYXd43ADRC6Wjfq9Ace0EbpvragNLqhA8r64HlnZXrZVQ6PqCJfxhBhh37Xu9rdbaKg+cHWK3FZUF/auMLCEP/Zfo0WnVLb02Us119xB3ce6//h+oTtZMtnPu1AZdLyBNWVyY3gcbARPnpNii1r+gK84Q2fjqDTljJQNO/4dFee1ShgfwKr52r6hVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UkwsuwH+Sa3tk31BCq02DCCSHMrnxAbWmAP9jhitwc=;
 b=jL6X2LR9P1VezueLxUbq/jpIed5MPk19eeonf5LtYu9o6a5bNsEKnPlA0cCxWbtCBB98tPQKbRYTmwfxIb963S3eUaaULnhpH/JUbtwPpD9tBSQSdLpHeCKs/c5sqSh6QTMnpxdIi3A4nzp0BUP9or0rtf4Dt7Ie7ikfRv0m99KhM1LU9cMUWSewBJCPLoGeIDyeHLm1RUAx5M0FpwJSF6N76e8oi5VsE7BNnR3G9F91aU7JAxoJoWuSilbHXw+eEXOWhaw8P3UC0hcHhqJFQNXc6FVk3o4fKsE6XgELDe8fGNKWic81D+V3ebddoEYrhM/6iLn/LIWJXrb0ppgYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UkwsuwH+Sa3tk31BCq02DCCSHMrnxAbWmAP9jhitwc=;
 b=hWgEikbcYcWhzDP7mMsDWSyXd79fqPP5Cmq9upj/N7CLZIriMw9zVn941g/bkycjfWM7r7+2XJsXYLy9Wwgh1yOOWnZdZBTUP8EJnEb3gmPEj1dvs8AvEuC+zsWM58KcCR89j5MaEU0lPkzD56OW2CvDfU38XIiHHpmCxwct/JY=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 15:16:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::44a:a337:ac31:d657%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 15:16:10 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Yupeng Li <liyupeng@zbhlos.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "caizp2008@163.com" <caizp2008@163.com>,
        "smf-linux@virginmedia.com" <smf-linux@virginmedia.com>
Subject: RE: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Thread-Topic: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency errors.
Thread-Index: AQHY6Q0hPjQJGq35bUuNA+oGhij1ha4zVVqA//+8rACABtyYAIAAAC3Q
Date:   Fri, 11 Nov 2022 15:16:10 +0000
Message-ID: <MN0PR12MB6101AB9F2AD8A41CE3EC5650E2009@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221026072531.346013-1-liyupeng@zbhlos.com>
 <0910bcc4-d55f-6f3a-b2df-4e30d164aeeb@redhat.com>
 <721f6a1a-1144-4fe4-e722-2ba2d7200680@amd.com> <Y25m8tPTtyfHOCfK@zn.tnic>
In-Reply-To: <Y25m8tPTtyfHOCfK@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-11T15:15:38Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5a134ac0-26af-4cd7-9072-6d65c10c9254;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-11-11T15:16:08Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 084fdf3d-0e60-4105-96fc-02fee1de9c13
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN2PR12MB4271:EE_
x-ms-office365-filtering-correlation-id: c9dd280f-b79e-42a9-1430-08dac3f7a9fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wg6gkjNLLEuY3ewgmBNaRU8PQ2S7xp7ObQRC0Soa13XtKQXKsmUHVW7zl0U98IbY8+GEO1bkmQI/7nwv3Z8Ryd4CU5RkkYvQZdv+ewzdYpiOHfIEwZxP0W0+ugtEEwJrkQ+hkGnEptpWI1zFZ4wU0MU80sk4V2XfRVWEOGFpwfVrO6vmgs8GqElzbexgSrpjiUQZrOEfixfKaohE4MRWPr64hYMZ0z+6wgrj4eS8KJKa8ZQsD/T9z7rDiPSGLluC+SWad5q83ci8NxLKGS3e7jCR2RaPuJQrKfk2XKlzzLCz1t4GMJC+LTApdpBfuLUMQChoK8t1NWsRZeeuUDuvtXMttZU4TqCPZlyeVagOUQ+V5z8WaTtb3fwJ/5Fdhvxp8cpLRskANwVvSRVDDrpcyE0pJQBdExWFPb4qAGueQAW50SZ+F6G7lxYv2t2/jfZkZSi+pqw/n8NlVPYUWP0YN6jwymM+6Qj1tqF+Az0xsCNrkEo88ZThhrCwMS4j44fLlJySFluZVoca+I5VAa6uEeKNpic/ND3T15qS4xf4UxYiY5CWW8vp94ou8F06GZCSPDG/wfFjsFGiHD4ivTvGio6spAihAx8oOm510kN00mzwTgZNBwcW7bpJTVsRxwIIwqC1ptOBvQgjafHGJbzViQTN0gnPJA1rTCVr69G0weWnG1UyZ7fh1LS4Myij88Y+kJDeCXYB15prh9wokpUKYbNifqvAXUELrhjwPrf/GtZ3R8j/UMfdjB+C0LwYNevPgdfh95xD69CINOkd6ss3pfiQmL2qFGr+T0m509DN5GyHMno+waYiox/o+Famog7EXAGnYakrJjh2Oj/GkblfIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(54906003)(86362001)(6916009)(26005)(9686003)(4326008)(76116006)(5660300002)(66946007)(66556008)(66446008)(186003)(64756008)(41300700001)(66476007)(8676002)(52536014)(55016003)(2906002)(83380400001)(316002)(33656002)(8936002)(6506007)(53546011)(7696005)(38070700005)(38100700002)(478600001)(966005)(122000001)(45080400002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z0lu3gtInpuBmjDB23Qhw4XuY5TEP4Ku1qVAr+dF/rg120Z+eAwjsL6Lxnee?=
 =?us-ascii?Q?qP2F/sXf9eS46fyeKc6C1iHS5i/b5ljwQpfBK+1VsWPLiQJWxldUVXEVR/fE?=
 =?us-ascii?Q?WuFba9qUQJ4AlwXrkAX1fbthHoMVAREd+WJGe4pzCdin9GBIyOB7/njs+pcV?=
 =?us-ascii?Q?Xniwup76pZoWHKrLBPe3YqAg9KzqKgN+tpzdW1j4GuG9OEXTdO6tk4BYAsKN?=
 =?us-ascii?Q?IUb3RySZBjVZ/smw5ptvixKeQ2xA5U+qjPi+8+ecaoxa2RAva7D2tPTGFv+I?=
 =?us-ascii?Q?DzNrPd2XMPpsgRkuhDEQSjZ7utJpXwwJnP47AeLV3b6REn1JIjJZcE4lk2Qw?=
 =?us-ascii?Q?qLUHAhfVOw8O20epnwcOMxwUpVWebd7ZYKS1UBz56BAEKpdURK6zh0UU7RfC?=
 =?us-ascii?Q?8SjYqX076ju3LQ35GDFZdeg585qiL1HIgD6mblFc//CKzGcfPC3vqKAFEt/2?=
 =?us-ascii?Q?Svl+2q1MDe8p9xBfNZoz0c0bY1f3hB7vGuKFNT2LXi3lZS07EQLev9jd1oxa?=
 =?us-ascii?Q?bbtWsDu/O+4PKRqI8xnnvuZXcx1ktl+IJoW5nur1DKvLSJkKBunVAlCqJ0jR?=
 =?us-ascii?Q?iz9XoULQzlSpsj66FPNvQ8tXeyt9SvSeZLX+7pGC7Ju5DdvRDay+iYiFCLSC?=
 =?us-ascii?Q?bZEovNc9tkDTElqNy1xRLLaWLwCCv8lTKENCI2d2lh8d/Aw++gAZaNzC/c+R?=
 =?us-ascii?Q?pNwooz9tURsBELjv9cafsQKWBmMs5Prij4BQ+rCKqhjVXR7PXtlcwtDma3Kv?=
 =?us-ascii?Q?tZqAF138jaDXsi0LDzHIs/igvbBm1hfLhLY3XhFKn6Laf2A0A1Qdxse+TcW1?=
 =?us-ascii?Q?LnSsfooatuzY085ghR/s8+cH17uQgd3Gnh8LBVpjsS/xVVJp0VtDrfJIE9L8?=
 =?us-ascii?Q?N2y99OQLFOZql+TTbCmc0ilqWB7amVYeUAxGf7lHKEZgQS4KJA+w6winA5XZ?=
 =?us-ascii?Q?dEkSz761z2gApjuDPlOeSlT7ti7XegYl7CNEDFY2yI0RAKUhwbdfKliV9n7k?=
 =?us-ascii?Q?IycesvJF4sVHf6tsRapBJhA1am9bNo4ndDieM0rh+tyggQTO+mCBxY6f7BEM?=
 =?us-ascii?Q?wW2BBv8CP6QnG1Joj4XaN1qnXA8JlJIQhzTejaUbhtGVATfVa/PdH+gziI/f?=
 =?us-ascii?Q?bcB+qwzwSYY1Vn1wdPjH0qY187Co28Ed5WVE7BmSmoIRM+1uxVy8O2He60M/?=
 =?us-ascii?Q?oY3RwvuL5UaMgISVQbezzsIaJRnahUPQE8MVhybhAc1yfcnCmglwhvj5UjKF?=
 =?us-ascii?Q?efs1N5EGRFs7WUaf7RvhQfCjumXtu1cUkHJw6YpNZk//ux1mNbi6U8+MjGv6?=
 =?us-ascii?Q?qU4BA5DA0y06b6iApyuatPbwptXmajIDFD5fN7R/O6KihYb7lKwnTOvXhJa0?=
 =?us-ascii?Q?nAf4okWfKLq6kQjFStnQCNNdPSsztb3y21j3C57nIosQGzSaoy3iTDo4sF2Z?=
 =?us-ascii?Q?4r7SFJX+TkdzX6FQSQp+6vKirshM8S7yL1xm4YwAipEMbpmdWZE/XPLzaAKE?=
 =?us-ascii?Q?Lmrv7C6OCkqpzWU9WjkYgUEI5CSweplKcnJFLeGMDrvOEs/FacGuY96PHWCj?=
 =?us-ascii?Q?HfnWyvVJ4gr3lcsOlM0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dd280f-b79e-42a9-1430-08dac3f7a9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 15:16:10.2463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRO4GJyWeC+ftVjZuW0BgFm6tS1LDLyhKSETPdZzy4vZImvjwBE7oNPaCaJoHWbY7P4hs5E14jjmXSksDopSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, November 11, 2022 09:15
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; Yupeng Li
> <liyupeng@zbhlos.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; markgross@kernel.org; platform-driver-x86@vger.kernel.org;
> linux-kernel@vger.kernel.org; caizp2008@163.com; smf-
> linux@virginmedia.com
> Subject: Re: [PATCH 1/1] platform/x86/amd: Fix pmc compile dependency
> errors.
>=20
> On Mon, Nov 07, 2022 at 06:27:52AM -0600, Mario Limonciello wrote:
> > On 11/7/22 04:28, Hans de Goede wrote:
> > > Hi,
> > >
> > > On 10/26/22 09:25, Yupeng Li wrote:
> > > > When disabled CONFIG_SUSPEND and CONFIG_DEBUG_FS,
> get_metrics_table
> > > > and amd_pmc_idlemask_read is defined under two conditions of this,
> > > > pmc build with implicit declaration of function error.Some build er=
ror
> > > > messages are as follows:
> > > >
> > > >   CC [M]  drivers/platform/x86/amd/pmc.o
> > > > drivers/platform/x86/amd/pmc.c: In function 'smu_fw_info_show':
> > > > drivers/platform/x86/amd/pmc.c:436:6: error: implicit declaration o=
f
> function 'get_metrics_table' [-Werror=3Dimplicit-function-declaration]
> > > >    436 |  if (get_metrics_table(dev, &table))
> > > >        |      ^~~~~~~~~~~~~~~~~
> > > > drivers/platform/x86/amd/pmc.c: In function
> 'amd_pmc_idlemask_show':
> > > > drivers/platform/x86/amd/pmc.c:508:8: error: implicit declaration o=
f
> function 'amd_pmc_idlemask_read'; did you mean
> 'amd_pmc_idlemask_show'? [-Werror=3Dimplicit-function-declaration]
> > > >    508 |   rc =3D amd_pmc_idlemask_read(dev, NULL, s);
> > > >        |        ^~~~~~~~~~~~~~~~~~~~~
> > > >        |        amd_pmc_idlemask_show
> > > > cc1: some warnings being treated as errors
> > > >
> > > > Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
> > > > Reviewed-by: Caicai <caizp2008@163.com>
> > >
> > > Thank you for your patch, however I do not believe that this is the c=
orrect
> fix:
> > >
> > > > ---
> > > >   drivers/platform/x86/amd/pmc.c | 5 ++++-
> > > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/platform/x86/amd/pmc.c
> b/drivers/platform/x86/amd/pmc.c
> > > > index ce859b300712..2b08039921b8 100644
> > > > --- a/drivers/platform/x86/amd/pmc.c
> > > > +++ b/drivers/platform/x86/amd/pmc.c
> > > > @@ -433,8 +433,10 @@ static int smu_fw_info_show(struct seq_file
> *s, void *unused)
> > > >   	struct smu_metrics table;
> > > >   	int idx;
> > > > +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
> > > >   	if (get_metrics_table(dev, &table))
> > > >   		return -EINVAL;
> > > > +#endif
> > > >   	seq_puts(s, "\n=3D=3D=3D SMU Statistics =3D=3D=3D\n");
> > > >   	seq_printf(s, "Table Version: %d\n", table.table_version);
> > >
> > > The table variable gets used here, but now it no longer has been
> initialized by
> > > get_metrics_table() so just #ifdef-ing out the get_metrics_table() ca=
ll is
> wrong.
> > >
> > > > @@ -503,11 +505,12 @@ static int amd_pmc_idlemask_show(struct
> seq_file *s, void *unused)
> > > >   		if (rc)
> > > >   			return rc;
> > > >   	}
> > > > -
> > > >   	if (dev->major > 56 || (dev->major >=3D 55 && dev->minor >=3D 37=
)) {
> > > > +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
> > > >   		rc =3D amd_pmc_idlemask_read(dev, NULL, s);
> > > >   		if (rc)
> > > >   			return rc;
> > > > +#endif
> > > >   	} else {
> > > >   		seq_puts(s, "Unsupported SMU version for Idlemask\n");
> > > >   	}
> > >
> > > Same thing except now nothing gets send to the struct seq_file *s,
> > > so this is wrong too.
> > >
> > > Shyam / Mario, can you take a look at the reported compile errors
> please?
> > >
> > > Regards,
> > >
> > > Hans
> > >
> >
> > What kernel is this?  Shyam removed CONFIG_DEBUGFS in b37fe34c83.  So
> is
> > this failure still happening in 6.1-rc4?
>=20
> It managed to trickle into stable too:
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216679&amp;data=3D05%7C01%7Cm
> ario.limonciello%40amd.com%7C29820718c1334539d74e08dac3f782f2%7C3dd
> 8961fe4884e608e11a82d994e183d%7C0%7C0%7C638037765076195581%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DNcjgeDsIS%2
> BcW84%2FMcl9hKFNfL5Cw%2F2rYU8yXXsh2H5E%3D&amp;reserved=3D0
>=20
> Adding bug reporter to Cc too.
>=20
> From a quick glance, I'd drop all that ifdeffery and add empty stubs.
> IMNSVHO.
>=20

I sent up a patch for it, but Hans hasn't applied it.
https://patchwork.kernel.org/project/platform-driver-x86/patch/202211080233=
23.19304-1-mario.limonciello@amd.com/

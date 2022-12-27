Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE7656783
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 07:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiL0GdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 01:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiL0Gc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 01:32:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16081150;
        Mon, 26 Dec 2022 22:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWymgOZ6rKVifJRTS+JbBCbB/y10NVUtR2ajw+qipYfCgN9mBQhHBT5RbA7fNoLp/Jc+z1c5VtPXbQIpecezes5dFsakUNqDzHcstMs5IrfmWy5ArBmvkjawfwI14A3QKZttIHJNs4gMVwrCEuzlh5eM7+bIjNoc/Xl/CdRKyjBgUb/F+1nA5ySQq5t8nN4XCO2rWM28X/kScHqLlULT3XHuIi0BYbJWKpJfaRMdbIko6JpU6Hu+FazJuzRwusr1LDsgHAiuOjtxdk0Lbq6wrK8wxbcOIwASnjZGsSAvR8KtF2YcWg/QWZmpmOj4T4YS8tbcjVfdNoCuJIZogVbVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjWHGenckhD16iDSCH2O0Op/JXQFR25z5oRedR7W7rY=;
 b=PM5RN0f7Zel3QRuGLNDBFR641XUyg4MRC6yhA57RzI6PArC7PunduTsxPlCehhEJ4in7jCNRR2WQtcnpL8bnmaWWek4xnD7jsY5Z6ip1sHjCUwyZ4G4rJqCRB7PzRVgSDaJb7i5AgkMt41v44e84A9T0/KeNe8810UjrnpX07dxEFo6NN14aLxozqqeGknYDB/tbVYFDryVp8WE77wOt7GNlQXAqQ3TK71/ElBjrsRbDv6/qqksXKcMeG3lgVy3QOYdze5j7w7p5SrUulKxUHd7sdaVrWahL5MTwjBCGmSlB+FaNksW/WmSROfsTxflu6gkHUkVxqRwulsTu9dNy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjWHGenckhD16iDSCH2O0Op/JXQFR25z5oRedR7W7rY=;
 b=pfO9HA6LvZNQqSgcT/AAGUPAFOZigKcSF5gd8Ms40ez8615hQJs6LayYJBVHaeZA5ESz2joiPQZwwjNf9F/0cVTIXgbTAbSSuBQsNLjAK/p+PVr/lqbwdp3OEc8nNpze4sjrJEqANtdSXB3h+myi6JQptZqRZ1XOT0f8lACqrUU=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 06:32:53 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 06:32:53 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 04/13] cpufreq: amd-pstate: fix kernel hang issue while
 amd-pstate unregistering
Thread-Topic: [PATCH v9 04/13] cpufreq: amd-pstate: fix kernel hang issue
 while amd-pstate unregistering
Thread-Index: AQHZGH7vRxnVcMpGo0CiDLBuoiyY0a6BC+qAgAAzD/A=
Date:   Tue, 27 Dec 2022 06:32:53 +0000
Message-ID: <DM4PR12MB52787E62D6B70F124182B2F39CED9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-5-perry.yuan@amd.com>
 <20221227025353.gbgdcmmi6vomhpqp@vireshk-i7>
In-Reply-To: <20221227025353.gbgdcmmi6vomhpqp@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-27T05:56:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7137478b-d5a5-406a-806e-611af51a1ee6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-27T06:32:51Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bb87317f-e60a-4149-b060-53e2601ff9d2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB8266:EE_
x-ms-office365-filtering-correlation-id: 02c1b33b-d9c1-48bc-28cc-08dae7d42f20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqCKfGIQ2jeiHu0vpwtL+AGDSGpTg2v9c/Wp2lwnwmCpyezNCrAVKidC/NyEYOkczkK+49twfxKIhzjOQr0EWaK/j3CKdQCooGFkiO/yEpsmGkOadmTSiPxlvsHW4xc15JQnanEXBAczEmAAUTOZIl/4gWpb7u/j9OsRm6ScZHkukM1NsAMRbCENvE9oxD/R2GNnm0vsQnVpaI4BiYLgRbHwufOzD2FnsF4KnLd2D5zLMk/4cNUMw91szjDJ0KWfcF7fHCM+wR9Yf17wAiJXiVYS9uf2GB6HxnlHnQx3EbmGJMrC0yVgcCnPu0+SpxKFUAlwWe1mjwO7adHEbIdhAFzmdy9OOxbwikAMMfU/J4+5BwNEdDWQzHS8yslfZwVSi8U9EHhvDqmmUpU//QMILQVfuLxYhQZwrsgFCPMnFDp/qwa7L4SGaurbRG89lJ0QIjBVLJk+SfaTrAhmecnphT8CHeBrehgtwlml9ff0aUELNWWlR8TFWAxAsR5x8io1an3wE4PyJTqQCNJFokrSJxe3EeNP5if7yYOPp9Jycobh4CaEBQPWFqZYWfZh8cNQeIYjLKuPBhVn2c7ZwghutWqaN0J4yAEvgKN/MQ1/QHt7byUkDTuQcsDO0qZ74nmG9tILhcVVU7COW1cSb2MGEEuvTFddmGMZZhQZq5FEe1akGLRzZwxL87kxR78uWe7sqb6h01p9anIDYCh0/fjtgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(38070700005)(53546011)(9686003)(478600001)(6506007)(55016003)(186003)(26005)(33656002)(54906003)(316002)(6916009)(86362001)(41300700001)(71200400001)(2906002)(52536014)(7696005)(8936002)(83380400001)(5660300002)(64756008)(8676002)(66476007)(66446008)(66556008)(122000001)(66946007)(76116006)(4326008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gc7dYbtHAGA4jZ73Nqs1HdhSODHgSptkMxUUaNU2I/WWdrfqO5m7wStAmUSU?=
 =?us-ascii?Q?k0DpkzynkAWTKYhSPuKr9FmbN6bZO4amcAA9y8hx35tIu++4TXDQHqv+jM3X?=
 =?us-ascii?Q?U8JVUq6Qus0BneVU3aWpgRiK8kzaFPKMNym52hS5o74HNrQNNTNHlf2Jy6Jq?=
 =?us-ascii?Q?V2TOd3nIiNOEzry6T5XH0HebD8Dm23TQ31Vv4csZGauTwpPiZ0FYMJtPTmfR?=
 =?us-ascii?Q?6TwvNmTwAUtXFScnwceZ9E/M2B2PBL91iwSnvg4BMvoTy50/hrlKXLxyCulC?=
 =?us-ascii?Q?TU+Y/gWjJKiIqBmsRoloq/yGH7gekgdFixt9Jyuf6M80ZKDljpWyVDrvq0dJ?=
 =?us-ascii?Q?guBsHXRKqCWgU1UbkFZ/msPFS3mWA91unQs1MwAvEPs+q92u6XbL7osWnOGH?=
 =?us-ascii?Q?lqWEfJrrpMnvVr+nVDTfEh9F3sE6Wcf+lCPP7BAlu0P+GopLI2Cbv7bFW7hd?=
 =?us-ascii?Q?92CjXZqZ7Co7MqOGHCYWYXd0qAhYUwzSRCgDteJRpYq4xnn/QJCmgKzQKCv/?=
 =?us-ascii?Q?4JDK+JwfI8OsixUf/n44R3Sh8MCx4D00MIR/40z5AbH7sZGdeeBKflBlJuxF?=
 =?us-ascii?Q?NChfm0FYqMQWymSMBEKz+GmNS8DDzFVp3SSf6oH5RJCRuLOno09nliL2jb3T?=
 =?us-ascii?Q?iP25NMhG8DdiYffGgRjO6LxNvCuXXdTV8sITaokpcwYnz6MF8Veg+9Zu2pT2?=
 =?us-ascii?Q?lozbKv3wkp0Qr3EA3UO2qIxyp2DLf6G20BGq+Fobm1Jt71xjanHXrN8kfMvz?=
 =?us-ascii?Q?gJoqPsIxHZ5amHNJb6LNn37ZSlpl53d0U2pXtDIiUtHLVjg6bL+hkassfeSa?=
 =?us-ascii?Q?pP8s6d5GHLdzLxGPM1JqbhMbt4vMU31Wu/nSj8slqgxnwgjCNnNe1AnrD8ur?=
 =?us-ascii?Q?Xnu+b9vL+ISEaP2wjrBgGLalxe6cSpxzfd9884etAA2bjqYNxiwK/Q9xCqEE?=
 =?us-ascii?Q?Lrw5ra2evSaif7YWci0N6BR2ob2hSdqDhMda04j7tmS0Gjo/D2IdQ8uTWVeC?=
 =?us-ascii?Q?Kf5YAd4RSYC0u+sYLtqVNdFnzIrc0qJQneXvQBStT5c/LXn/BFlt+b6ziLUq?=
 =?us-ascii?Q?n/TZ92YX0Li/z+vcU41on+pG5TeiZTiecWtLSZ6u5Xns5eOIIw+wrwwYWOx/?=
 =?us-ascii?Q?0amL1C5fOkk+hmGWNaKZ/WDn5TlKN94+fRomD0gS3HMpjUjJubeLpDd80Ird?=
 =?us-ascii?Q?u/bBG3XkYU6f6Xf92ZDFXyNAXbYnvrkBFZF6tSfEy4imkEL4f8rfVIcm48Ok?=
 =?us-ascii?Q?XwYI05NMpuFhQjTPWEs9L/PQP0rlaODTfxL9inn5qvxGM+ji2WqON+JpiBeB?=
 =?us-ascii?Q?gAW9mwubDuBUlRiGSmCWYPr8cHvhPipt/18ysFcw6pCQyeSOcNRvYp7M2JY6?=
 =?us-ascii?Q?lpLd59nJDpPlV8Aj6pS9iMjtWAkSidMYx7gsJQ7I0DK002bwmsasK7npGR9v?=
 =?us-ascii?Q?2EVAGzxuK3lIOBiPcbACrYI1YVxiz8qQ1w5bqcUFXMZIuVIs6C0+gEdxS20z?=
 =?us-ascii?Q?Q9vdj1Kixc1dHEfTTDEXXrGNTie7Wzzyr6Vo3Z03TY2jg6BefkpTc5N6Lblu?=
 =?us-ascii?Q?fZ49gy9zoqH1WFv62bt3oJe8wwbrZhj+TcXyo6oB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c1b33b-d9c1-48bc-28cc-08dae7d42f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 06:32:53.5909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGg3XFbacuwCrt0S6cORDud5zd+hPQCrvx7xH5fo7CSrmlsk42Vzk6shMQQjtQtS/QNOvQJjbBYWFmZzRyrxpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Viresh.

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Tuesday, December 27, 2022 10:54 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Huang, Ray <Ray.Huang@amd.com>;
> Sharma, Deepak <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v9 04/13] cpufreq: amd-pstate: fix kernel hang issue
> while amd-pstate unregistering
>=20
> On 26-12-22, 00:34, Perry Yuan wrote:
> > In the amd_pstate_adjust_perf(), there is one cpufreq_cpu_get() call
> > to increase increments the kobject reference count of policy and make
> > it as busy. Therefore, a corresponding call to cpufreq_cpu_put() is
> > needed to decrement the kobject reference count back, it will resolve
> > the kernel hang issue when unregistering the amd-pstate driver and
> > register the `amd_pstate_epp` driver instance.
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/cpufreq/amd-pstate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 204e39006dda..c17bd845f5fc 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -307,6 +307,7 @@ static void amd_pstate_adjust_perf(unsigned int
> cpu,
> >  		max_perf =3D min_perf;
> >
> >  	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
> > +	cpufreq_cpu_put(policy);
> >  }
> >
> >  static int amd_get_min_freq(struct amd_cpudata *cpudata)
>=20
> This should have been sent separately and not in this series. It is a bug=
 fix,
> which could have been merged in the 6.1 itself and now is candidate for 6=
.2-
> rc1, while the rest of the series needs to wait for 6.3.
>=20
> --
> Viresh

Thanks for your feedback, will extract the patch and send it out separately=
.

Perry.=20
=20

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F525FABF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJKFp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJKFpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:45:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD204C60E;
        Mon, 10 Oct 2022 22:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyVjHrvCjFO0EKQoZRDExHQu/BeS3bKXY2UspbzRJ/fOzReAHfqtvKDhomi1kOq/mpk86c3B5jUUfJayCAamrNVT11PcFg2b+P522g5cdMjEXFhyfgRMxQd+obqdD3Qpd6YGAuWOq3RsmEvUfjdERENobmvxvzZ4blRpAzwHUPE8JYmBHkoINsh+wv40oPHWiWT8ATpPAYBcjJLox/GLfPGT6W9Yn5q+/17BZXKAPGsyxVjeVD6nSjXvSPC1yNzauiTwhMByq7paQ6pSIECXPTRrS5Nvmopk+/0C5YtZAaVcfMele/xsKflhcPeoBw3FWF10WzGoEqxLLsbPetz0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upX4EhmpV+dF+0gv6BWMZC1Vesyg2FO/+wptxPBhrwk=;
 b=ggRrKSQ5pE/pQqfLarJ56+wilbFsOmVS/EyCHCpWB8hO2DoPc5+tyaFXUmuAHCUnmUTyaqewKlQ547Wv8Y+KRSURrCIVxjpQ8M9ElofZR8d9ICW3ia8eJcsWArAk05TIbgjqTeJAJrDpyNwJ53zg8VZGY+DxcoSxtt8Phc1QukGMypvR2KJe5FAEy5g//LEldDktkivanicPk+6XLBiDSL4WI4ZdxfmtUqvqaFnR0npSxtu6UTyMs9m9SfDMM/94bg6ZyGPaomlxyzD01frKFgf0KmUga4FDPEXZdRt6dXq4aZ3C7VmZ1p/hi5yM4MAKTHebRzFPDkO1wMmr9sOipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upX4EhmpV+dF+0gv6BWMZC1Vesyg2FO/+wptxPBhrwk=;
 b=cN9QfGR+97DcJbLk7wqXXm4wW37Dgtiwaw8inu+7XPksa+NcqEKDwQZxEJOxFvVEZRUKQdzdMKR8oVYJT1ZKXw5dTp9d/vkCNo1F12pUKImY4jEQHyTgSdAiqrAD/FFysb2i3wbnrT1juvUVfFfK3mNaX4VUlUC8Qs175K35Ht4=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 05:45:21 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::d862:67a:d93b:8128%5]) with mapi id 15.20.5676.036; Tue, 11 Oct 2022
 05:45:21 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH V2 7/9] cpufreq: amd_pstate: add AMD Pstate EPP
 support for the MSR based processors
Thread-Topic: [RESEND PATCH V2 7/9] cpufreq: amd_pstate: add AMD Pstate EPP
 support for the MSR based processors
Thread-Index: AQHY3MSzQ3Vflgb9QE2Zw3YiNLM+S64IgAIAgAAvS6A=
Date:   Tue, 11 Oct 2022 05:45:21 +0000
Message-ID: <DM4PR12MB52782A5F40C7F18CCC199A009C239@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-8-Perry.Yuan@amd.com>
 <20221011025426.xocfhvvkakdc4jzo@vireshk-i7>
In-Reply-To: <20221011025426.xocfhvvkakdc4jzo@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-11T05:43:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4c774621-81fb-458c-83a8-8a1a68c38bcb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-11T05:45:17Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9ab0b0fc-89b1-4465-971a-b3c3c35a423a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|BY5PR12MB4164:EE_
x-ms-office365-filtering-correlation-id: 95effcbb-d85a-41a0-ab9b-08daab4bc92f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQzEseMyWk8Ubg50JgjMmbJlfcYA9bxqSE//d4dLCFewJZv0fPHP+Ce1EWfK9i71igISM2mDMyeQJAMKkH+eUjOifchweMJ1u0teg/eSh5M1w+k3cvQiv7Z25XGYnnqIM+J0TB+1UerZj0AQyv4k0opbS4eeWJTBFtMjecxAd2dWGn9hPoRI04wmHcFpAxQmQXCn3ltfOIMaT5Pgx5DAZOF651Wlgz5QtsZnP6vTWykfuVLndkNxYRHIREVsSbUPI8nsXLH6G+R4hGIpnrnktNoPrnNTZZx6aGnZFbUHeEAEjZQn2OFj9AiOcdwAzhIzi375omvjGwG/PzAfjYdbeJN0J4uk3HavdpJ+NgqLxfpafCYuBq9zcEjAKZgM1uSoscvzzpKRfVafx8psFc75rfa9wCE88dPG/yBxz/idq9RbyiM1QE+AeH2tOtCKEERmfqsrpAgjZ4A4H5jZ5hZN+0WKBQX0HJwUbDbOFC1fd4smJv0OOBaETh7o5Bg1iTyquxhuGp1ETX51rx5RhnMnAcZtLCzFs/gSRqKNrYLIv3keoP/eAmD1es5MWv0rTJsWrrNOm5cHKyruErH4K+nfDkcCTT/EFcoXsQeCYmLFPmcXh2/M5jvJAv3Mpd7CeFJFAQs85lCpW23WAvWgM4btn3OqNZ/97UQkTOVmQr5cZEU/6V+IP3gmfWhZeDAe6QVn2ypNnbtmaZOKdHzqe0AG3C+qEG1w1+9F4xRJBsmxTYYyJSAKJh7No+pj7eEJB82UvBaQk4g1slZybd9qJvB5NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(38100700002)(2906002)(7696005)(33656002)(6916009)(316002)(186003)(38070700005)(122000001)(5660300002)(55016003)(6506007)(26005)(9686003)(53546011)(8936002)(52536014)(66476007)(66946007)(76116006)(66556008)(4326008)(8676002)(64756008)(66446008)(86362001)(83380400001)(71200400001)(54906003)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zDa4Z8mjeLJ+hfO9G/XrC3NiuKGCXb4Jej84UiN5d3X92jrL965u0pKjKQpr?=
 =?us-ascii?Q?zfQ7TYC77PFh6ovVZ47lnUVEMLc0XIIsH8ZnxnmG07xa23Y3lVcvzEwclK6K?=
 =?us-ascii?Q?mHSAatOwvx5Gs95BRCcgWn6k/1Jo75Mi2oV3UuUtN6aIoBK/rXpaPFFyaMV9?=
 =?us-ascii?Q?koAt5r65vpss9wP3nPbEVuNFwLr+YRvlQ+wEerIl4alD0KuqWGi2JfjhaQaP?=
 =?us-ascii?Q?PE1xwGgOgGQMBegCHYhBFDiTZ9kuvxma96pMFsBTgLkEUbhwzemXoPwYf6Pi?=
 =?us-ascii?Q?PvwZqQ2fx7o3IgCyNnGVlj1DsLTiAlaLTtPdfQGXmHvTAulFYP0MgS45ZofS?=
 =?us-ascii?Q?L6bK2ifF0Tew0Y07cjWxqgcSuvf8bW5yTH20saQj/Yk6dj4okOtDP9ywhDf8?=
 =?us-ascii?Q?wjXoxwWYygIc3cNOYE12LAftYpT7RmR8fZT7fzGmFVPIzUSOJSve8SNRHx3p?=
 =?us-ascii?Q?aI5/+lLIXs4kab4kZWS62aUZP2V81ogR4nL1P2PD5pDjPPQz8J54z9lDJx7k?=
 =?us-ascii?Q?cUdJdCKa8O4IEYkeQwzvsF6J+hzNmX1HW9gDdWlL7JymuT3uv4r3+AE3nS3B?=
 =?us-ascii?Q?A+uuVDcHAc3lTcdS+SGlIdO+zXUrqjlUY3FWZopCtLlJeAj4eezITQmrFHC4?=
 =?us-ascii?Q?9BH+tRsNylgpAmuYLZzwfnjZhtAavkgHFJPYK/AbExFz1xMBPRijEuzhagzz?=
 =?us-ascii?Q?eto993+F4MDsbr1XAMzi4wC7jgk8iSKY3MQRadpOH80Kx0odjr6hxXV5cHHy?=
 =?us-ascii?Q?1b9SQBDpKH6TnzfQAjaDXpOBupyqh/BO57Y56zKmGxGNr4oHyGRsfYHnSNPw?=
 =?us-ascii?Q?UL5aZQvGxlDqA6ZCH2CUydKD1kBK59gtKDp0oPePw2Qz8Oa4nFyB341mYBfx?=
 =?us-ascii?Q?LBil5BrSyxC7jQJi8wCXBdDtt8nc+oCx3Docf7rhOVpb82SYoU2EeMPBri2o?=
 =?us-ascii?Q?Jz3jmT2m+Qm2DmYaLVWqF8XHCsv66YHTioKERqOD96EgiIQOT7CGnDog7JWg?=
 =?us-ascii?Q?RwYGvGntGMFSlNYl53QXtSOj8jzDmUeJdOw37ATNND5n0GfYNV80rE/V6vXj?=
 =?us-ascii?Q?2MLTp+dFgzUJLa5M4bUr5sWQMHXVRiM97OcVdngWz5dcVwBJaBawj7fhQrng?=
 =?us-ascii?Q?Iayo+L9H5HbCB2TLsH1sLUra4FtwRbQemWMS1oP5MQ9tf+nEVIiK3RUi1xx+?=
 =?us-ascii?Q?DS7T2Hi7dlqOzFp2K2XRJUaupdK/IG7+OPBy8xUtVDN6ivtkIfKlqHQ7s+P4?=
 =?us-ascii?Q?F6gTJkC1MzQiQfJdYim19mX9GC586KHEgvuF2vVrYzpRvbmi8bNkN72wL7My?=
 =?us-ascii?Q?NWe85EzIcMxmIsw3zLUtXX35Q2XFlYHZneJ8S+sWC7Y+4mX7THrR7fXauLzT?=
 =?us-ascii?Q?b4ZFMNk4KS6idlcHkwwSUjFDXszqtQdUiRBRmMaq/mMGJ9pHlXQVUzszU6iJ?=
 =?us-ascii?Q?FdXFeq8SxeFXz6GJkXfHLxVmpa1waZA/t9TZhW1IJfxAzfqoJ15pM6A1sW87?=
 =?us-ascii?Q?liIKcbymaVrtSClUegFDmzIWus2dYBfvyWAedUKSu2LmiFtmMlrah/INsLYj?=
 =?us-ascii?Q?Phh4Z+CBxs8wQD8b0F0cVGdQ7HUfNWv97XgZBmeg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95effcbb-d85a-41a0-ab9b-08daab4bc92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 05:45:21.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOrsyYENJZSs/1+I+q+ibe8e8eS/VmVrNYaKW2pqyPOXZMPgFkluwm/FqnvBi6YBDdrVPCoQSvYxHI93fAXPNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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

Hi Viresh.=20

> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Tuesday, October 11, 2022 10:54 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>; Sharma,
> Deepak <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li
> (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [RESEND PATCH V2 7/9] cpufreq: amd_pstate: add AMD Pstate EP=
P
> support for the MSR based processors
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> On 11-10-22, 00:22, Perry Yuan wrote:
> > +static void amd_pstate_update_max_freq(unsigned int cpu) {
> > +     struct cpufreq_policy *policy =3D cpufreq_cpu_acquire(cpu);
>=20
> Why isn't cpufreq_cpu_get() enough here ? cpufreq_cpu_acquire() is specia=
l as it
> takes policy->rwsem as well and you shouldn't need it.
>=20
> > +
> > +     if (!policy)
> > +             return;
> > +
> > +     refresh_frequency_limits(policy);
> > +     cpufreq_cpu_release(policy);
> > +}
>=20
> --
> Viresh

Thanks for your suggestion. I will try the cpufreq_cpu_get() and get this f=
ixed in v3.

Perry .

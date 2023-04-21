Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD826EB1D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjDUSsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjDUSsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:48:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555E188;
        Fri, 21 Apr 2023 11:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOp6MxkZ8clDLg/sWM1XUzMTSbQidBdPS7kt0TJl/4AyH0xjWk7vXisH5ClQcMVce/LELcLGdY3sdpERy/e0KHCO6j0YhaQMs7IpyIcJeaxdQbPwU8jbH9rz+WJ9WZpkecVr5Dwe8jTGPWmKja8dyplDWAEkW3T6mCOt6yYz9gWtLUXTAFwNtkU92wSP4CDOCkbzUyT6YdARALqb8K48xSopIQX+1dw7rnF7tprg91qlJ/NolSNUe0NbindRpX3yM/29mXRyK2oOyhPwFhb3Y0Ehus5ZLdtBEIzHI02hFXSJRWyactMLHQpJ8/owcUsu1BAXefL0EQOYdHjVQ7zEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba9BW0u1Ujz0cbrKbGfG8+ddVymxym4XV0k2njdIp70=;
 b=CkylOaEzZK4i2bmDWg/wkaLxQFVUMVVEeQ0QLUqqIq4NrrOhZkIrg5Fl08HHj75ysp/x1Bb30BR9wXkkAFad+UD6JENXNRGyiQtYL7S2yuiWq6qaFMxX8FdQSwJp7X3YOwTXVRlfR3ESq9fqITCC0R+YQfSwwkMqmqlu9/+JLKfkCO1nRHrpbili1KEVgVrb7IIIBxY7edsbagbH3kDvmr5NocgfQdsdU9aJzARTVG6dv/gm7XQJ67qxSddUb/gPp5Y33CyP6Q+8+iJxJ5h5p5uBxIoYfJFGbDeofzgtGAQ6b6xsKBX52VkgHY29JBPPySqLCn99WtcNMizDgps9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba9BW0u1Ujz0cbrKbGfG8+ddVymxym4XV0k2njdIp70=;
 b=qO+huP7593hHAEVi3mbRqTCf4nZWroV0HmOMhogHT+XDHtNlKAcZjXG8ibEjKWLjO2U6TIjuzMEBtgBlvqvB00p0BmBlwYIvXe22zAmpLJ+7ISb9+F/Kk0AnXSR1tn0+5gi/WvxtRR4PaptunoJ9nm8w8MjpMQWdgiZDiTUDjr4=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 18:47:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 18:47:58 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
 debug option
Thread-Topic: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted with
 debug option
Thread-Index: AQHZcYVFe4Kw2QyGKUeIFETbFlcnCq8yoHoA///t9ICAAVtIgIACNJgw
Date:   Fri, 21 Apr 2023 18:47:58 +0000
Message-ID: <MW3PR12MB4553359D41816826AA001A1095609@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177451010.1758847.568218491528297451.stgit@bmoger-ubuntu>
 <56497126-8f60-e590-bb13-b3739114375@linux.intel.com>
 <933d8ae2-d8b7-7436-5918-f639405c9ecb@amd.com>
 <346622f4-3ea9-c19c-6175-3346ffc6016@linux.intel.com>
In-Reply-To: <346622f4-3ea9-c19c-6175-3346ffc6016@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T18:47:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6fc0cb64-d472-4e26-9a22-b2307ee9ccef;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-21T18:47:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b4042e09-1a1a-4ef5-baf4-f9c8dde2a74e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|BN9PR12MB5273:EE_
x-ms-office365-filtering-correlation-id: bf2d2380-8868-4658-e9a8-08db4298ed13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCjyRIvYQtvk///SXpMq6XhTy1kcJh9j90Y1JUPLgJ9VPM8b0CIKD8vz2EEfqdkRgRAmWmgb88YeiUcjsWlOt/uFobJb0VOGKxJeGi2adLs+24iVo56Ttgc6bc08t4y3uwpIMAzu1gahVbp17vRkgBjJ0/vgwk29rMhCEzM6lHHU0l6+IydouXoVcf2jYraK2UcVYljxlOKuiyjJYiecHZBI1eSCu8s0PA0X654GCJU+jaxzLVoh41dUH3Pw/AWX14DtmnHPfISjcG7RlMKOGIlLV/V7dwgql4TWiEHwSOiyBnXGvsjm+L0byRGJnOOwqfSJdKWncY6MskRxrAD0aVFQfucEhsgqJRP6Scw0yZMezW3Je0K3nlGXd99qWhfC5oySa0rRJMzCJQBWSr6WODjQoppllqfkmOd2wxZG8DEg4+LWQw9TKTp9Frm/d8+3NL0fL77bzFf9MYJE4MFfe8VDHNacjzv+NuAs7oxIFAI1NUVhBtpvvPoC4cPqbvsM6YYaUN5Fg/avZcxkQHN5Ggu9XUPnvI67QjrOU3ZySG6OpsdtvH94aI0LR+ncVobOEcpaQFy1srdSeMr7A/Q2A+sUstRT9t1N4I7O8W+uGXzY9iYbrEix1BoNWhTk9/hq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(38100700002)(33656002)(38070700005)(2906002)(86362001)(55016003)(71200400001)(7696005)(186003)(66574015)(53546011)(83380400001)(9686003)(6506007)(26005)(316002)(66556008)(66476007)(76116006)(66946007)(66446008)(478600001)(64756008)(4326008)(6916009)(7406005)(41300700001)(7416002)(52536014)(122000001)(8676002)(54906003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?taL6a0nxR2eAIlhNx4lbxSVD2Ez21q8Y+ZV5yP3Rx+7dkjbYE61THARR8t?=
 =?iso-8859-1?Q?1ZLzIJCzw6xIXgVUYVTtqBCMdfDdf35UPD5RZUy6RV0P9l192KqThShUW8?=
 =?iso-8859-1?Q?3tPP4iK8ji8KWSh7i+CwCw2SOm714WpZBqWyD060Ah9JHi7OSFWMrtYT6Z?=
 =?iso-8859-1?Q?US5pk+utZUESnPBEjM2LoFzcvbe0mt4cUmddWLYO2z4tqw3xVDtubOsser?=
 =?iso-8859-1?Q?soMin5qtkzgrXRk5Di/YgHC7xEOteAOPRxBZXxR9HOc2YsTRXTMce3S7bN?=
 =?iso-8859-1?Q?FhFVSDeGm7me3zOY2Q6sc3qvjx8yIK50zBHs0HhEJIISrcBYxjCJCcM0Iu?=
 =?iso-8859-1?Q?MsOZ2u/jT4yZnZn3PykQCO+ohtvzO/rA4O0nN/OJxmoimOf8waHH0KLmId?=
 =?iso-8859-1?Q?6cpMvygwXwliKkovIwwUv+1s7CdO1dRnfrWYNs85o+pIWoSIkb/Reeef8w?=
 =?iso-8859-1?Q?pAp2J5DpIClu5gRHBVHRflrQaWAcOdAZW2X8hVZO3dScz2eIXmMWRvBV3a?=
 =?iso-8859-1?Q?KFYKehsG8Vul3ao7b4AVIs1hD4eViqG56YL/bL4iLMDI+XBUG+VNkLCO/s?=
 =?iso-8859-1?Q?xGRjG46LCycbYLIjocQfgObuvevk965+UuuSMs6Hrc5lPRfRivWRfl8vwG?=
 =?iso-8859-1?Q?bp9KUOVtuZCeJhJUgYYCzF/qrgQFh0xcUCxPPEcWmTTsafspGKHpTYkmzI?=
 =?iso-8859-1?Q?xUnC7nM1vK0x6S7KsonuUOzN8h3nqjlivXdnfw/eBDTQRRYiq77UnJCvPA?=
 =?iso-8859-1?Q?nRf8o6XnvoN94OQQQ4I9djsdMZvt7CKWTxBQc2WeY5uVE+0Rf8IY902lRd?=
 =?iso-8859-1?Q?NaU/Kiuc3QunCpo1GL7xZWenNmJojKVjDk9FRO/pkNn/ZSH4GH5C8AF9Bc?=
 =?iso-8859-1?Q?jUUPPPM9Etm+fG1iU/1uia+U26szGgoL+sEkOR0jHouMxmY+ZAIvD3lxJ0?=
 =?iso-8859-1?Q?+X3AFSwi63NyYIORHuVDesgfYOZsOORctyKYPqXpAr8Rv0ICVuekgqM5iU?=
 =?iso-8859-1?Q?DZjYuzYGSSFvFX4jC5BPdI/1h6EGqFSHe9E2REk4pT4lbrKeFAeaocjA+/?=
 =?iso-8859-1?Q?MvqVnt09GLKJHjWMEl84L2hopG8FCiDf5QlJbCoCdkpTrsAkDzzTwIWlQW?=
 =?iso-8859-1?Q?zJu+Lh8bk0iDrXDP12bwKF5kGmRggQn7Omj99pHzr0UPM8IA8yxUhn7Tt4?=
 =?iso-8859-1?Q?JqzAqrLjsc/EaImA4OlBdPxOwKXkzXdjmewDRvJs/a/QwJSuCHbpwqSG5M?=
 =?iso-8859-1?Q?MRjeAlNCxWqDtkr8tQQimLp0B3oNTOqE7xW5gf9qbWP2c2KmvaDhbCg0uW?=
 =?iso-8859-1?Q?7r/WvWeTWaoyUuqpjo58P0kvKzaGU7w2RKXL/cVLA6vsX8Tt+9ZftJhVho?=
 =?iso-8859-1?Q?Li2yf/C3i5TUsP7i1yUzGjYZpAtyOyuMs4kdF6I5jM9ROugJxIYwDXlCbU?=
 =?iso-8859-1?Q?0rSG+BCsEMdT8f8fGAGGzI3htX+72+NU466A4FjZ9J9EtBBdg65vO6H9Xy?=
 =?iso-8859-1?Q?cdXrfjqG/7mFlbVdLng++JAaRbkeRGhtiLeTTL2ZVo+fWlBdqXtsDiCchm?=
 =?iso-8859-1?Q?jsoOm9TTeaR5EJEvN0sY7LMUh0/3RXdSAYRW9TyrIqTudsp00I+YqLcV6U?=
 =?iso-8859-1?Q?Ba4AGi4t837eQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2d2380-8868-4658-e9a8-08db4298ed13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 18:47:58.2508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLsfUcs5pWMcG7jjkTSmVpcFm1Lev3FM7e0AZY5egl5HGsuUHGOvUcvicUc6w1qD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, April 20, 2023 3:59 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: corbet@lwn.net; Reinette Chatre <reinette.chatre@intel.com>;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; fenghua.yu@intel.com;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> paulmck@kernel.org; akpm@linux-foundation.org; quic_neeraju@quicinc.com;
> rdunlap@infradead.org; damien.lemoal@opensource.wdc.com;
> songmuchun@bytedance.com; peterz@infradead.org; jpoimboe@kernel.org;
> pbonzini@redhat.com; chang.seok.bae@intel.com;
> pawan.kumar.gupta@linux.intel.com; jmattson@google.com;
> daniel.sneddon@linux.intel.com; Das1, Sandipan <Sandipan.Das@amd.com>;
> tony.luck@intel.com; james.morse@arm.com; linux-doc@vger.kernel.org;
> LKML <linux-kernel@vger.kernel.org>; bagasdotme@gmail.com;
> eranian@google.com; christophe.leroy@csgroup.eu; jarkko@kernel.org;
> adrian.hunter@intel.com; quic_jiles@quicinc.com; peternewman@google.com
> Subject: Re: [PATCH v4 7/7] x86/resctrl: Add debug files when mounted wit=
h
> debug option
>=20
> On Wed, 19 Apr 2023, Moger, Babu wrote:
>=20
> >
> >
> > On 4/19/23 08:20, Ilpo J=E4rvinen wrote:
> > > On Mon, 17 Apr 2023, Babu Moger wrote:
> > >
> > >> Add the debug files to the resctrl hierarchy.
> > >>
> > >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> > >> ---
> > >>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
> > >>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   54
> +++++++++++++++++++++++++++++++-
> > >>  2 files changed, 54 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> > >> b/arch/x86/kernel/cpu/resctrl/internal.h
> > >> index 1eac07ebc31b..855109abb480 100644
> > >> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > >> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > >> @@ -288,6 +288,7 @@ struct rdtgroup {
> > >>  #define RFTYPE_TOP			BIT(4)
> > >>  #define RFTYPE_RES_CACHE		BIT(5)
> > >>  #define RFTYPE_RES_MB			BIT(6)
> > >> +#define RFTYPE_DEBUG			BIT(7)
> > >>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO |
> RFTYPE_CTRL)
> > >>  #define RFTYPE_MON_INFO			(RFTYPE_INFO |
> RFTYPE_MON)
> > >>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO |
> RFTYPE_TOP)
> > >> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > >> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > >> index 15ded0dd5b09..1ec4359348c2 100644
> > >> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > >> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > >> @@ -1880,6 +1880,7 @@ static struct rftype res_common_files[] =3D {
> > >>  		.mode		=3D 0444,
> > >>  		.kf_ops		=3D &rdtgroup_kf_single_ops,
> > >>  		.seq_show	=3D rdtgroup_rmid_show,
> > >> +		.fflags		=3D RFTYPE_BASE | RFTYPE_DEBUG,
> > >>  	},
> > >>  	{
> > >>  		.name		=3D "schemata",
> > >> @@ -1909,6 +1910,7 @@ static struct rftype res_common_files[] =3D {
> > >>  		.mode		=3D 0444,
> > >>  		.kf_ops		=3D &rdtgroup_kf_single_ops,
> > >>  		.seq_show	=3D rdtgroup_closid_show,
> > >> +		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> > >>  	},
> > >>
> > >>  };
> > >> @@ -2420,6 +2422,49 @@ static int mkdir_mondata_all(struct
> kernfs_node *parent_kn,
> > >>  			     struct rdtgroup *prgrp,
> > >>  			     struct kernfs_node **mon_data_kn);
> > >>
> > >> +static void resctrl_add_debug_files(void) {
> > >> +	struct rftype *rfts, *rft;
> > >> +	int len;
> > >> +
> > >> +	rfts =3D res_common_files;
> > >> +	len =3D ARRAY_SIZE(res_common_files);
> > >> +
> > >> +	lockdep_assert_held(&rdtgroup_mutex);
> > >> +
> > >> +	for (rft =3D rfts; rft < rfts + len; rft++) {
> > >> +		if (rft->fflags & RFTYPE_DEBUG) {
> > >> +			rft->fflags &=3D ~RFTYPE_DEBUG;
> > >
> > > I don't fully follow why you need to play with ->fflags like this.
> > >
> > > Is it for the ->fflags test in rdtgroup_add_files()? Can't you just
> > > do some extra masking there for RFTYPE_DEBUG based on resctrl_debug
> > > which you already keep?
> >
> > Actually with this change, I can remove all these tricks here.
> > I don't have to change the check "if (rft->fflags && ((fflags &
> > rft->fflags) =3D=3D rft->fflags)) {"
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 1ec4359348c2..b560c44817bb 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1925,6 +1925,9 @@ static int rdtgroup_add_files(struct kernfs_node
> > *kn, unsigned long fflags)
> >
> >         lockdep_assert_held(&rdtgroup_mutex);
> >
> > +       if (resctrl_debug)
> > +               fflags |=3D RFTYPE_DEBUG;
>=20
> Yes, looks good.
>=20
> It matches to the idea I had in my mind but doesn't require putting it in=
to the if
> condition itself.
Without if condition?  How?  Let me know.
Thanks
Babu

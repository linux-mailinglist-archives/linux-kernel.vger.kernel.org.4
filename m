Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65720666812
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjALArx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjALAru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:47:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167144084F;
        Wed, 11 Jan 2023 16:47:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crCK5YU0qKMk6wDc4AJOMdM++rJZjiiAtGj7Cg392mEnTvVR4KwdfjZPJ0O+YZabBNY0MwmjhpqdgC3nHIvMdg33xD6IOCPu61WLxjj3KL/ee36RP+iDuYRj+VFhdOcaGenS7w5veWSm5zxeck5dMyEPEZzmKVyIq7ikhPFvB5pWz9M2m/TpPw8K1chTz3v5dojU5Mrqnm3ghC4F0teAuRgn93aMdqK7nD1HaKBov6+gm/Sf7bs9cxBF7SeGV3ozIFzDoL1VzvcMvkQlnigsUbOQooJF4NA1fMiaQXrTmOK3oYBw4pcuvveZRDu8CW8j3K0Mz6m4zgyNe1Nu7a6HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3044/er0jUIXlUzr9FQT0TzeP7kFbQb1DuiAKnZYfA=;
 b=VBgtNe+vGtojSETdvvpbWArimRFiNGDcRWZaUlFqZzD07aUlR7dS5BfRKA+VUP/KsJAcfY8ucLIQVPnWSHMEI5Ch9pRv7fXH50kEcLUZ/xZcGh5DqhccTT5v6aRhkP0Z3er8UoJFS+pHtujRH4+QVoSm9iJFEm5DBrt8Qc07EJWWY68OcrWa+fliG5jtWNW0fDEJQjpqu1A8gdOgnWR/YIdU4zZ7IPaXOUgbON81YNlSmeyGgkL7clPVz8ulBHYM/KtyqA+NuZ+8J8q2Ozslt3vkeOElw02LNaFSWF5tWos5rBFZGEE+UGI9eUGFG3FK4wNOE2WvY3p6ihk1x0z8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3044/er0jUIXlUzr9FQT0TzeP7kFbQb1DuiAKnZYfA=;
 b=G5x/HAidRSNZ3EjMKxNxqaUP+tBNXWXmLaIGYBbs1QWSQO+u39exA9Bktw6jh9ZRE6txGaQQTQhPMKxYA6HRDVjE7YHSU7HH8BEjt3EVFETCtoSCozEOJl6oQuQ/Htt8h8Cb8FN0vGYU/0B42wDd7L8O5Fe2GllaadzW45EfSIU=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 00:47:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 00:47:47 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Thread-Topic: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Thread-Index: AQHZJEmrk2z3hSULUk6NOZBmDO6S+K6ZyWMAgAAHQRCAAAaKAIAAHsxg
Date:   Thu, 12 Jan 2023 00:47:46 +0000
Message-ID: <MW3PR12MB45534504C044EBAEABA9E9E295FD9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-14-babu.moger@amd.com>
 <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
 <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
In-Reply-To: <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-12T00:46:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d868266b-999e-48a3-814f-802ae4db8d8e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-12T00:47:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 66777d23-3dd6-42d7-81e4-d48224ffc20f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DM4PR12MB6063:EE_
x-ms-office365-filtering-correlation-id: 0cf1e2bd-44ef-499c-b513-08daf4369f9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HURc+YjrqdX3c/VnAEvARkbKmFJ1QwHimQljdXfhPVY7vs1Ft5+CQPjEuL1sezFI/1xIPQES7KeJU2U9mqCUvbYJwCM0iFan+Ni+bdxHSbzXTfiLl1rsR33tP7Sjq/Q3o9306T+dlIDf5/Ks6Pc9rC8w5HWrZprTDwVNrOC7XYBqYYP5fwRyrdFqANFcNa+torwqLjl9rjaT9Wb6NMKlUvMnZUmROOVN9E9tUyIQoTk8GKEh11B2gxDRUir1KuKPbEhjOy5hOTvQ4bbke3Sq3OnFZywyyGaeALVNlJJeG+pZ0/eBt9S8Sk/K1fKdNc1ckyT5KdDO9qHtEHHFhAGyEBjaCJ5oABjal5p8xa12m1EN45cWe7bfigD05s0RfYqbHMo7J7xwPFbvRUGvAAciZEv37I4vdiMFZ9DUpRORwT9lMiA7WS2SyFFczBRx6mFDUIIhODOIsk8yrhadw78fCiRMTZSoQGgYdp9gS7Ug196Hdst4VZpRc4JeIQFmoThOW0uY4PJWkjbOEThevgKsydkuR/UCQuF4S7Y1aZdjGaaGDFfNKmbC1P9B+IoTmIqSeBEJU0R3Onqv/rteXertkRYInQrVQkQr6KVsflUXk9mPwJVIHebFcaU5pHEwBTQokAdwZJysYZhxcGXcZxZQRCWfPVUzSXKCO/TZt+H5u/f4NGczbGXEm8C5GxnuAQEF0dfeHH6+qZ+IiQscGihHWydNV8P+rUeCzN9Kr1wL4AU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(122000001)(38100700002)(83380400001)(86362001)(38070700005)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(41300700001)(55016003)(76116006)(54906003)(110136005)(316002)(2906002)(71200400001)(15650500001)(8936002)(52536014)(5660300002)(7406005)(7416002)(9686003)(186003)(26005)(966005)(478600001)(45080400002)(7696005)(6506007)(53546011)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c5ia5+1/QBuR4x29yatBbgY0Q5vEy/TcD/gJnL0ntgLUUX/eHd5EwjN3AHQJ?=
 =?us-ascii?Q?kvvV6MoQa+hkpvIYeCdw0ivGmSLeaFekAkG2wz3I/4VKVbxysYB6QlW47SV9?=
 =?us-ascii?Q?EqfUvP/wWREhMHUvftNnT1DgnqsdIoyZ/XJs5oV7hceQBP+8+2YRjhVUZtO4?=
 =?us-ascii?Q?Sk4wqKI1MiJA9ifNgMk+3TlyMxTY2JGwVXTGd/rVfU4KUVAQOYwlqIh1iuv0?=
 =?us-ascii?Q?9GdB+WtFsgBrTYJt0XVpODYK6nJiKJwaj483oCKVU88iD8L8TVqruPLbDqjN?=
 =?us-ascii?Q?8IVllr83XCU7SdeKwUstSM6KXQeH8V9lmb0nIqjP0LGIa63WRjBxFHqVlE+y?=
 =?us-ascii?Q?rs/TJEpYQFHEiLgWXxdccQ1mameTL8CFqTqXnJYe/YYyTe7LDs/m5+jXRoDd?=
 =?us-ascii?Q?r+lEZYzfIgc3ErulsCfzK/+rVu8GgSsND0yzVCGGBrELzeN3VaGCTPp6dwNo?=
 =?us-ascii?Q?xoyp2adlAXoPorfIwRWdlXsRYxpZZs8bIM+plsl07K24MlIMhhqX8i2bLAkV?=
 =?us-ascii?Q?0Trt3DzCnoM+aUHWeBKU8q5ObzCZJG7pvctPehvxKARJ9MW3qAd0YH5sdNGx?=
 =?us-ascii?Q?pI4+r4OQpXYWlh9uSfNeZzmPhx2FjXopjl/iU+eC5ToQp9Rx0CH59OrkVjxW?=
 =?us-ascii?Q?p+kiAzMMcUR+uKUx7e2mpJcc/m99XAl548gQog+jjfIbWFlENP3q9sQ9aLXa?=
 =?us-ascii?Q?+37Few+5V+86xoWZb/QkL1ITotCr/0FZBsw5dzvZ6tiBEYoF2BYDYMSCsNO/?=
 =?us-ascii?Q?lqMSLQHCPebfCZAvyOXf89gGJl2IpUlH5X+K4TjP26KYVLpJ1s880171opbB?=
 =?us-ascii?Q?XS6rFYtCOP5jBZDvteNehFxgWrOsR7rvLfDNpn/mo7aO7Ig6jqTynh/5uzyC?=
 =?us-ascii?Q?Z278xAKGLXLS7SLP6JjO9hgLbplygo5Vm/iPcZzErGcmlmhXLgjVBd4bA1wr?=
 =?us-ascii?Q?OYFSEcGVcgtupH2zz0dwDqd+NcAFLp3yKdzGvR6Krfv7IL3dvNFyA3FPM4nw?=
 =?us-ascii?Q?6kYvqCjgpzLAsox41OnzXOLdHNVyY1SH5V8K4ucQLTaz7PvgQ1uiXn0hI3kz?=
 =?us-ascii?Q?Mxzyh0W9EFFBV+eslsoATA3EyhWz58oAORSHY4smWHfC9mpjAFd5nU4AVdnD?=
 =?us-ascii?Q?Iw3DOKznrr1aMxIasCpz1vYA5Fn9Xj9CwjUHRCr+hCndSgBTAZlq4hfw8tfg?=
 =?us-ascii?Q?aiBOp2+xyWQdBKzI5ZoYGuo7OR2oT79XzsFlLLHyy49QlfLO41gKAm6UNhyN?=
 =?us-ascii?Q?1bIqIUqE/zMU8TOMfeSau/ShO3cPwUmLr5AFbl8lCXxkoiGZHNTaqpCoDjI4?=
 =?us-ascii?Q?zXhmYoTipAR2/jfNZorTHfwHYrUgaeiFG+MFi64ulnruk29Rytj7d/O6QmIO?=
 =?us-ascii?Q?P1qRkHhAEtmeXGtfhjwPmJ5w/hLzP/ctRIth6WbrxnrwNTCp5hjAi8PR1Vdi?=
 =?us-ascii?Q?EvlfrKVvdxET05nUlmaZzpcQAQEuCTgujCLuk9MnGhsBmsLEIRGoQarQU8TN?=
 =?us-ascii?Q?V5Cxa3dzG11zx7qAkMGiq/gr7GdYngEB9q9jbV7I6fDIbV10ybjsTWXOh3Dt?=
 =?us-ascii?Q?K1pg2CuB5JYGqbZYqt4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf1e2bd-44ef-499c-b513-08daf4369f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 00:47:46.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cHyTbqiPTEFsP30974v/y/G0Sy9aTM3j0Dhe+xUxf3bGRl46TlBcV9ZMLp8RyhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

Hi Reinette,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Wednesday, January 11, 2023 4:56 PM
> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
> quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
> peternewman@google.com
> Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for =
new
> features
>=20
> Hi Babu,
>=20
> On 1/11/2023 2:39 PM, Moger, Babu wrote:
> > [AMD Official Use Only - General]
> >
> > Hi Reinette,
> >
> >> -----Original Message-----
> >> From: Reinette Chatre <reinette.chatre@intel.com>
> >> Sent: Wednesday, January 11, 2023 4:07 PM
> >> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> >> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
> >> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com;
> >> x86@kernel.org; hpa@zytor.com; paulmck@kernel.org;
> >> akpm@linux-foundation.org; quic_neeraju@quicinc.com;
> >> rdunlap@infradead.org; damien.lemoal@opensource.wdc.com;
> >> songmuchun@bytedance.com; peterz@infradead.org;
> jpoimboe@kernel.org;
> >> pbonzini@redhat.com; chang.seok.bae@intel.com;
> >> pawan.kumar.gupta@linux.intel.com;
> >> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
> >> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
> >> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> bagasdotme@gmail.com; eranian@google.com;
> >> christophe.leroy@csgroup.eu; jarkko@kernel.org;
> >> adrian.hunter@intel.com; quic_jiles@quicinc.com;
> >> peternewman@google.com
> >> Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst
> >> for new features
> >>
> >> Hi Babu,
> >>
> >> On 1/9/2023 8:44 AM, Babu Moger wrote:
> >>> Update the documentation for the new features:
> >>> 1. Slow Memory Bandwidth allocation (SMBA).
> >>>    With this feature, the QOS  enforcement policies can be applied
> >>>    to the external slow memory connected to the host. QOS enforcement
> >>>    is accomplished by assigning a Class Of Service (COS) to a process=
or
> >>>    and specifying allocations or limits for that COS for each resourc=
e
> >>>    to be allocated.
> >>>
> >>> 2. Bandwidth Monitoring Event Configuration (BMEC).
> >>>    The bandwidth monitoring events mbm_total_bytes and
> mbm_local_bytes
> >>>    are set to count all the total and local reads/writes respectively=
.
> >>>    With the introduction of slow memory, the two counters are not
> >>>    enough to count all the different types of memory events. With the
> >>>    feature BMEC, the users have the option to configure mbm_total_byt=
es
> >>>    and mbm_local_bytes to count the specific type of events.
> >>>
> >>> Also add configuration instructions with examples.
> >>>
> >>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>> ---
> >>>  Documentation/x86/resctrl.rst | 142
> >>> +++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 140 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/x86/resctrl.rst
> >>> b/Documentation/x86/resctrl.rst index 71a531061e4e..2860856f4463
> >>> 100644
> >>> --- a/Documentation/x86/resctrl.rst
> >>> +++ b/Documentation/x86/resctrl.rst
> >>> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform
> >>> Quality
> >> of Service(AMD QoS).
> >>>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86
> >>> /proc/cpuinfo  flag bits:
> >>>
> >>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>  RDT (Resource Director Technology) Allocation	"rdt_a"
> >>>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
> >>>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
> >>>  CQM (Cache QoS Monitoring)			"cqm_llc",
> >> "cqm_occup_llc"
> >>>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total",
> >> "cqm_mbm_local"
> >>>  MBA (Memory Bandwidth Allocation)		"mba"
> >>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
> >>> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>
> >> I expect that you will follow Boris's guidance here and not make
> >> these flags visible in /proc/cpuinfo. That would imply that this
> >> addition will have no entries in the second column. Perhaps this
> >> could be made easier to parse by using empty quotes ("") in the
> >> second column to match syntax used in the existing flags as well as th=
e
> cpufeatures.h change?
> >
> > Hmm.. I thought we dropped that idea for now. Did I miss understand tha=
t?
>=20
> I referred to the guidance in
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2FY7xjxUj%2BKnOEJssZ%40zn.tnic%2F&data=3D05%7C01%7CBabu
> .Moger%40amd.com%7C900eb41c0e6049dd342208daf4270d2b%7C3dd8961fe
> 4884e608e11a82d994e183d%7C0%7C0%7C638090745842366944%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D%2F5GVOhnxq1%2B3nJwGtlAp
> vLfC%2FeX3X9RDaUZa9R92NiY%3D&reserved=3D0
> Since the SMBA and BMEC features have never appeared in /proc/cpuinfo
> there cannot be a user space that expects these flags in /proc/cpuinfo an=
d thus
> no risk of breaking user space. User space can get information about SMBA=
 and
> BMEC from the info directory.
>=20
> Later that thread discussed removal of existing resctrl feature flags fro=
m
> /proc/cpuinfo - that is what I think we shouldn't do since there are user=
 space
> consumers of those flags. I thus agree that the task described in
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2FMW3PR12MB455384130AF0BDE3AF88BCF095FE9%40MW3P
> R12MB4553.namprd12.prod.outlook.com%2F&data=3D05%7C01%7CBabu.Moger
> %40amd.com%7C900eb41c0e6049dd342208daf4270d2b%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C638090745842366944%7CUnknown%7CTW
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000%7C%7C%7C&sdata=3DkE7d0cFYyJq1n4ZKKeeF%2FC%2FFDDJ
> y0Sc%2Fd5MZ%2Bc56WQw%3D&reserved=3D0
> can be dropped.
>=20
> I do not think this is a big change ... just add the empty quotes to the =
two
> cpufeatures.h patches and a new snippet to the resctrl documentation.

Previous one got garbled. Here is the correct one.

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 2860856f4463..7df5889237f4 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -24,10 +24,15 @@ CDP (Code and Data Prioritization)          "cdp_l3", "=
cdp_l2"
 CQM (Cache QoS Monitoring)                     "cqm_llc", "cqm_occup_llc"
 MBM (Memory Bandwidth Monitoring)              "cqm_mbm_total", "cqm_mbm_l=
ocal"
 MBA (Memory Bandwidth Allocation)              "mba"
-SMBA (Slow Memory Bandwidth Allocation)         "smba"
-BMEC (Bandwidth Monitoring Event Configuration) "bmec"
+SMBA (Slow Memory Bandwidth Allocation)         ""
+BMEC (Bandwidth Monitoring Event Configuration) ""
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

+Historically, new features were made visible by default in /proc/cpuinfo. =
This
+resulted in the feature flags becoming hard to parse by the humans. Adding=
 a new
+flag to /proc/cpuinfo should be avoided if user space can obtain informati=
on
+about the feature from resctrl's info directory.
+
 To use the feature mount the file system::

  # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D9651372
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiLSTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiLSTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:50:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8672B7;
        Mon, 19 Dec 2022 11:50:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSou38S/QGB/5aN++f8tYB38lK0YcxoeGviUs8w3aGSnPV5oQuKWlabGvfeQrAqqtLpvbCkjRTEZEQB6lCDRmOPufbHcgtWqMsYWROnTgxIvZQTXucI0p80A//ubuO423TfE+SXUzZLvEwb+8o5HLGXDIGQB+jnWLa14wz5kNXdPDqzyXSNrdp+jtg/t25DJvUlNxWUyUNJYIHP+KBw0AWmGRTvVDbOBrzYOlxEvVjMKlkaQuW8IPU4TWl47pUvXKkYrpnzJ5tEAsq1kmVNKWgVcUFNQoi74dxPk+5g/xI/5/o2OBJY/+vt4ksk9WNbDGjbhcRJOGsyGPBK7asiS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJoexmoNmjT4rjkNCxI53+yjD58DwdZUTEI2JuMpqVg=;
 b=QUjepEkMYhIm38wVctfz6UOkdbpJRKhf2cHgC0sO6Uly8I5W7ID+ZJzu7qz0PO1XxrTflKBKOuZ+1AXMmVNSD3/GP2d+nJKyp6nfGhpZrOz8UW7Ha/pD1nWGz/HQF1nwATNpLfL3TPGOsh/vQ/dVWqEB0U7i5e5Kr5rqF6w1iikQU8Jv7kTluf5s7JyQCSUWb3tC/Scj+z3ZnbIiBsbEqnYlBHBHR5AGPRIXDbs6zMl+HG+cw/zheVYQmEGBmDxLyTtwlznUrARMlHP43CcutVlZkA5qoB7WWCgB3sUB6S1pone/tmkbRyrYrLUg0me8qJoqOFsApnGCt1DfvqtF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJoexmoNmjT4rjkNCxI53+yjD58DwdZUTEI2JuMpqVg=;
 b=DdDg0NDxbgJuhYjDCKwz3D+6Z+PV4k4IAeyDWo9JpsIGeObFlbiEWeLSfaQ8/uHbXbbZLO5GWZPZK/CDLh22go7cZwc9MVZRmirf4SqGWljMWyXqzyn9lqtN9EAVDws2E4aE5kUs5S8ThL7Eqpd3aktHmZNgDONBJ8zfeeA7w0Y=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 19:50:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 19:50:35 +0000
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
Subject: RE: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Thread-Topic: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Thread-Index: AQHZBZrSquDNk6pznU61qmw2jh4ld65vWcwAgAZf0WA=
Date:   Mon, 19 Dec 2022 19:50:35 +0000
Message-ID: <MW3PR12MB455337B3EFAE3A0E37D042AF95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
 <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
In-Reply-To: <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T19:45:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=76a27686-da22-4bd9-8762-f76d6d0045ae;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T19:50:34Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 273ae31d-fca3-40f0-9dcb-26755c21a7f8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|LV2PR12MB5752:EE_
x-ms-office365-filtering-correlation-id: 7a5c355b-558f-4dbc-eb5d-08dae1fa4bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCA5BFyGr7tAoIHHBWvH2g0OdFGc80N7ZIPdHzqsr7LfPoEtb/zW/IR4brIqCarWGWMv694LaNeJzaOmlbUPr4vKmpryCwXjUUvQ6eYkfWnPPysGu9mr1EY8VVoggdaRJ2zOK7j06RdQ07aDFJ/26Barsagk7OioWpgOmT3h0NNKOL4wp9QwfSTuiaIKUkU+vMelZSXBAiplix4SP9c3/FQ3vkv2G94s8Dt+N8Ka81Bk9/A8pAy3vSS63UD92RaEqLCDNnxiMUkjn2N6d8XUeBOQOHDmNFHr31Swsoglw7xerjPFqkp4NkCaNIGHnS1jEmdnvLZGOL9Je+zF5d7MzAJcqDCfeAM9xMoImsR0hvVIDjPM9QnuvCpYq5t5PECJ16d33YFuNLUCctAvz06pixE6WZZ+le9LM5NGUfnV1K0aQQb/O4JBLZ1aZzTOf+AV2jn2yDsw4qxl8pcTs6TExQAE8ljPvqoiZEJoPi/XWDB9bHaSINQ+7QrgUElIZgQdLCkk3FRBgpIdtEwJQLqf+HY5f20G49xvad4XpxX1e/EZY/0lpEQFduc3CrED4BcgNykF3HynADdNWKJ7kYq+z7zD3J4FK4yKYqtpOP9UDNOdhvSIQr9gtUWdo+/OEuDAEU5LnIfhTG01kWE+6HVpZiD1aSsynvSGGq0GhTc3t7weMImxpdH2JZpR9rM56rXEax0XfCWz1DGqU2Gx1HVnCVZTswYi58N8p+6Z5YvN7TY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(478600001)(71200400001)(110136005)(54906003)(76116006)(966005)(7696005)(316002)(53546011)(6506007)(8676002)(66476007)(66556008)(64756008)(66946007)(66446008)(186003)(26005)(9686003)(45080400002)(4326008)(8936002)(52536014)(7416002)(41300700001)(5660300002)(7406005)(83380400001)(30864003)(2906002)(38100700002)(38070700005)(122000001)(33656002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DRB2/Ib6Zkb+CG+gNvmP0NcFCj7Vcgbxfah1KlOKA+qnR3mN0YAbCPGVgApV?=
 =?us-ascii?Q?r36YmIrYHAX1/eATmctBfY9DxHZw5D2gyy/QAPr8BnoghoS8kXn6iDiWbpjd?=
 =?us-ascii?Q?bRSAwBP+WFHnANVOPePSS3wwCAsa07tGgFJz7DL9+XuHbrE6hP4j722Z8BHk?=
 =?us-ascii?Q?L+kGelh40DTXvrVpg9uBJuR2XX6pfVZUg6YTzy3fPkJBWfv8toNXuCVZ0/OV?=
 =?us-ascii?Q?bwFDU9t3ndJILSDg0MyNMgDHjG5ASAmHBerwq8fKRz02aTdilTJw2MjqyfuM?=
 =?us-ascii?Q?cuGhdJ99OEw8swnA6Burc0z/CUsRk9Vf0F4RAzikXDGuirV74iB4HBJKAo0G?=
 =?us-ascii?Q?m5FtqTrczJIrf6uL1I0Ogy6nSBMLl+yNcJCIOfeYmrE5mS6j6syomdfxiySz?=
 =?us-ascii?Q?yHw3fBeT0EbsMTyKlSkPp0kLTEXGPMDMCOIJ+HgOqeufcWmqXtFDYuw6S2R1?=
 =?us-ascii?Q?iJ5x5ebflGpP4LWChdG/AL8V4txNGXJBJRavB4SJDSwEHApXq78xhLsZh+n5?=
 =?us-ascii?Q?kiL2gH0ZaYj1m9jHpPpZHVSNe6rURktZsyhRejLL18YrenbQScJHHv1PFrEt?=
 =?us-ascii?Q?UPT79Bw0iYLljFc4/3jVqTlB1HpMCn0iU2UlsmBN2K0cmNXI9qyh9oJPHk4m?=
 =?us-ascii?Q?bleZF9uhJRtGv79fhYa5C3v2WrNvREZG5x/J71+tZtsViG3MqWXzQgStexEM?=
 =?us-ascii?Q?QFKCLTF6T4CrAyfsZkgtX3Lm6osyPA7cEspgFjPscGnSPaJcq6AdWCeObLiO?=
 =?us-ascii?Q?lUfoQDQYltC+sU9yQl+uAtPFnnYrBK2fMq/sn7ZZibs3SW7rnofV8BQ3dPlv?=
 =?us-ascii?Q?ahSbHpF3lugQuwNSlmwgTQ8A/xWwK8riaFu+UHrVokppcF3cnAN+KZqqBt8E?=
 =?us-ascii?Q?6oLK32FG9n+W6a0Lw/r1cktKBO4qw27NyPGANWLHU40sENfLCGVXTs+LWKS5?=
 =?us-ascii?Q?9Eo97PuwOM5LEsAodcSo3koismaJkO3JKtEvYtHnCJhqCnlnpqGyINP7XE5s?=
 =?us-ascii?Q?1RxydXCiuJ7yz2vZBgarPhN8jcSpXjO8bHLzyptT1susCshnvdDrppYrn+dt?=
 =?us-ascii?Q?sh4DkcCaKOoRuq48KbHTO0Hb/60gZecmAHs63BCwWEEL78qlxgBQzx+v9OCw?=
 =?us-ascii?Q?8WYzrlaZ/pyp4In4CXQ2Wu4NQiLR7tuPHcvMWgo7KXwD166S90VvchYs3Gkg?=
 =?us-ascii?Q?Xo2r0e0PsaNRpVISaLIqUfpkuKaOu7Cm2VAI8l5NqsjKfEX5JfJplhaO4yTS?=
 =?us-ascii?Q?SmtN8RCJOzQpY47NWgtLCpPNXG+sSdQf1JleDBsiAUKT3hfGnB1bqAoWyh6a?=
 =?us-ascii?Q?n6bSqrUUm/MfHfXiwlv9GGlzQ4VrBO4G4FqXnT29aMsIDM/SdDTwAQCJfGOg?=
 =?us-ascii?Q?/1dacdLamV+z/MFHtGZi9xOQZ/uwo0kXao39mWHTUkkd3ahv3UKAXI8FP481?=
 =?us-ascii?Q?nKfBfXTquiHZlR1yrjEBW0hWb5jscPpfSLLCq9YK3mkYnVMGo0T6ZXL8tYDt?=
 =?us-ascii?Q?Tkm/3BCzHVZwY/Tkgp5I/W4sWbu/3k7bZSs45HzdOC/F/d8pHbvHtPcX9TKI?=
 =?us-ascii?Q?DORc/JlianczsvzNV5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5c355b-558f-4dbc-eb5d-08dae1fa4bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 19:50:35.4860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIgHR+ACzHneaeHJesRIe3uwNos0qOJcc7G22+OLY7ZkRDoTw07UMDo6oLEm5OuI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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
> Sent: Thursday, December 15, 2022 12:25 PM
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
> Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
> mbm_total_bytes_config
>=20
> Hi Babu,
>=20
> On 12/1/2022 7:37 AM, Babu Moger wrote:
> > The current event configuration for mbm_total_bytes can be changed by
> > the user by writing to the file
> > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
>=20
> Please drop "current" from above
>=20
> >
> > The event configuration settings are domain specific and will affect
> > all the CPUs in the domain.
>=20
> please drop "will"
>=20
> >
> > Following are the types of events supported:
> >
> > =3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Bits   Description
> > =3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 6      Dirty Victims from the QOS domain to all types of memory
> > 5      Reads to slow memory in the non-local NUMA domain
> > 4      Reads to slow memory in the local NUMA domain
> > 3      Non-temporal writes to non-local NUMA domain
> > 2      Non-temporal writes to local NUMA domain
> > 1      Reads to memory in the non-local NUMA domain
> > 0      Reads to memory in the local NUMA domain
> > =3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > For example:
> > To change the mbm_total_bytes to count only reads on domain 0, the
> > bits 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33).
> > Run the command.
> > 	$echo  0=3D0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> >
> > To change the mbm_total_bytes to count all the slow memory reads on
> > domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x3=
0).
> > Run the command.
> > 	$echo  1=3D0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/monitor.c  |   13 +++
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  127
> ++++++++++++++++++++++++++++++++
> >  include/linux/resctrl.h                |   10 +++
> >  3 files changed, 149 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> > b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 7c8a3a745041..b265856835de 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -176,6 +176,19 @@ void resctrl_arch_reset_rmid(struct rdt_resource *=
r,
> struct rdt_domain *d,
> >  		memset(am, 0, sizeof(*am));
> >  }
> >
> > +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct
> > +rdt_domain *d) {
> > +	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d);
> > +
> > +	if (is_mbm_total_enabled())
> > +		memset(hw_dom->arch_mbm_total, 0,
> > +		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
> > +
> > +	if (is_mbm_local_enabled())
> > +		memset(hw_dom->arch_mbm_local, 0,
> > +		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid); }
> > +
>=20
> We learned a lot more about this area after Peter's discovery:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F20221207112924.3602960-1-
> peternewman%40google.com%2F&amp;data=3D05%7C01%7Cbabu.moger%40am
> d.com%7Cc9ca23a7b3c643d2385508dadec9f83d%7C3dd8961fe4884e608e11a8
> 2d994e183d%7C0%7C0%7C638067256273943013%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&amp;sdata=3DPmvi2L4L727GqALGaeEO0MbpcnuRcqKc
> opNNXuu%2BbFM%3D&amp;reserved=3D0
>=20
> Since this is a new generic function it should be clear in which scenario=
s it is
> valid.
> Could you please add a function comment that warns future developers abou=
t
> consequences if a new usage is considered? Something like:
>=20
> /*
>  * Assumes that hardware counters are also reset and thus that there is n=
o
> need
>  * to record initial non-zero counts.
>  */
>=20
> >  static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int
> > width)  {
> >  	u64 shift =3D 64 - width, chunks;
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 580f3cce19e2..8a22a652a6e8 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1517,6 +1517,130 @@ static int mbm_local_bytes_config_show(struct
> kernfs_open_file *of,
> >  	return 0;
> >  }
> >
> > +static void mon_event_config_write(void *info) {
> > +	struct mon_config_info *mon_info =3D info;
> > +	u32 index;
> > +
>=20
> index does not need to be u32 ... mon_event_config_index_get() returns
> "unsigned int"
> and wrmsr expects "unsigned int", it can also just be "unsigned int".
>=20
>=20
> > +	index =3D mon_event_config_index_get(mon_info->evtid);
> > +	if (index =3D=3D INVALID_CONFIG_INDEX) {
> > +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> > +		return;
> > +	}
> > +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> }
> > +
> > +static int mbm_config_write_domain(struct rdt_resource *r,
> > +				   struct rdt_domain *d, u32 evtid, u32 val) {
> > +	struct mon_config_info mon_info =3D {0};
> > +	int ret =3D 0;
> > +
> > +	/* mon_config cannot be more than the supported set of events */
> > +	if (val > MAX_EVT_CONFIG_BITS) {
> > +		rdt_last_cmd_puts("Invalid event configuration\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * Read the current config value first. If both are the same then
> > +	 * no need to write it again.
> > +	 */
> > +	mon_info.evtid =3D evtid;
> > +	mondata_config_read(d, &mon_info);
> > +	if (mon_info.mon_config =3D=3D val)
> > +		goto out;
> > +
> > +	mon_info.mon_config =3D val;
> > +
> > +	/*
> > +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in the
> > +	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> > +	 * are scoped at the domain level. Writing any of these MSRs
> > +	 * on one CPU is supposed to be observed by all CPUs in the
> > +	 * domain. However, the hardware team recommends to update
> > +	 * these MSRs on all the CPUs in the domain.
> > +	 */
> > +	on_each_cpu_mask(&d->cpu_mask, mon_event_config_write,
> &mon_info,
> > +1);

Forgot about this.  This snippet is going to change. I have tested and work=
s fine.
How about this?

        /*
         * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
         * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
         * are scoped at the domain level. Writing any of these MSRs
         * on one CPU is supposed to be observed by all CPUs in the domain.
         */
        smp_call_function_any(&d->cpu_mask, mon_event_config_write, &mon_in=
fo, 1);


/*
> +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in the
> +	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> +	 * are scoped at the domain level. Writing any of these MSRs
> +	 * on one CPU is supposed to be observed by all CPUs in the
> +	 * domain. However, the hardware team recommends to update
> +	 * these MSRs on all the CPUs in the domain.
> +	 */
> +	on_each_cpu_mask(&d->cpu_mask, mon_event_config_write, &mon_info, 1);


> > +
> > +	/*
> > +	 * When an Event Configuration is changed, the bandwidth counters
> > +	 * for all RMIDs and Events will be cleared by the hardware. The
> > +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> > +	 * every RMID on the next read to any event for every RMID.
> > +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> > +	 * cleared while it is tracked by the hardware. Clear the
> > +	 * mbm_local and mbm_total counts for all the RMIDs.
> > +	 */
> > +	resctrl_arch_reset_rmid_all(r, d);
>=20
> If I understand correctly the expectation is that when user space read co=
unters
> (via mon_data files) right after the configuration was changed then this =
read
> will return "Unavailable" and then the next read will return data.
>=20
> If this is the case then I think a snippet about this user experience wou=
ld be
> helpful to add to the documentation.
>=20
> Have you considered doing a preemptive read on the RMIDs that are in use =
to
> avoid users encountering "Unavailable"? I assume doing so on a busy syste=
m
> could potentially involve hundreds of register reads/writes.
>=20
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int mon_config_write(struct rdt_resource *r, char *tok, u32
> > +evtid) {
> > +	char *dom_str =3D NULL, *id_str;
> > +	unsigned long dom_id, val;
> > +	struct rdt_domain *d;
> > +	int ret =3D 0;
> > +
> > +next:
> > +	if (!tok || tok[0] =3D=3D '\0')
> > +		return 0;
> > +
> > +	/* Start processing the strings for each domain */
> > +	dom_str =3D strim(strsep(&tok, ";"));
> > +	id_str =3D strsep(&dom_str, "=3D");
> > +
> > +	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> > +		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain id\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
> > +		rdt_last_cmd_puts("Non-numeric event configuration
> value\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	list_for_each_entry(d, &r->domains, list) {
> > +		if (d->id =3D=3D dom_id) {
> > +			ret =3D mbm_config_write_domain(r, d, evtid, val);
> > +			if (ret)
> > +				return -EINVAL;
> > +			goto next;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *o=
f,
> > +					    char *buf, size_t nbytes,
> > +					    loff_t off)
> > +{
> > +	struct rdt_resource *r =3D of->kn->parent->priv;
> > +	int ret;
> > +
> > +	/* Valid input requires a trailing newline */
> > +	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
> > +		return -EINVAL;
> > +
> > +	cpus_read_lock();
> > +	mutex_lock(&rdtgroup_mutex);
> > +
> > +	rdt_last_cmd_clear();
> > +
> > +	buf[nbytes - 1] =3D '\0';
> > +
> > +	ret =3D mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> > +
> > +	mutex_unlock(&rdtgroup_mutex);
> > +	cpus_read_unlock();
> > +
> > +	return ret ?: nbytes;
> > +}
> > +
> >  /* rdtgroup information files for one cache resource. */  static
> > struct rftype res_common_files[] =3D {
> >  	{
> > @@ -1617,9 +1741,10 @@ static struct rftype res_common_files[] =3D {
> >  	},
> >  	{
> >  		.name		=3D "mbm_total_bytes_config",
> > -		.mode		=3D 0444,
> > +		.mode		=3D 0644,
> >  		.kf_ops		=3D &rdtgroup_kf_single_ops,
> >  		.seq_show	=3D mbm_total_bytes_config_show,
> > +		.write		=3D mbm_total_bytes_config_write,
> >  	},
> >  	{
> >  		.name		=3D "mbm_local_bytes_config",
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> > 0cee154abc9f..e4dc65892446 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -250,6 +250,16 @@ int resctrl_arch_rmid_read(struct rdt_resource
> > *r, struct rdt_domain *d,  void resctrl_arch_reset_rmid(struct rdt_reso=
urce
> *r, struct rdt_domain *d,
> >  			     u32 rmid, enum resctrl_event_id eventid);
> >
> > +/**
> > + * resctrl_arch_reset_rmid_all() - Reset any private state associated =
with
> > + * 				   all the rmids.
>=20
> It could be more explicit:
> "Reset all private state associated with all rmids and eventids."
>=20
> > + * @r:		The domain's resource.
> > + * @d:		The rmid's domain.
>=20
> This copy&paste needs some changes to match this new utility.
> How about:
> @r: The resctrl resource.
> @d: The domain for which all architectural counter state will be cleared.
>=20
> I think it can be improved more but the above could be a start (please do=
 not
> copy verbatim but ensure style is correct.)
>=20
> Keep in mind that this utility does not clear the non-architectural count=
er state.
> This does not apply to AMD since that state is used by the software contr=
oller,
> but it needs to be kept in mind if another usage for this utility arises.
>=20
> > + *
> > + * This can be called from any CPU.
> > + */
> > +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct
> > +rdt_domain *d);
> > +
> >  extern unsigned int resctrl_rmid_realloc_threshold;  extern unsigned
> > int resctrl_rmid_realloc_limit;
> >
> >
> >
>=20
> The above hunk fails the "no spaces before tabs" checkpatch check.
>=20
> Reinette

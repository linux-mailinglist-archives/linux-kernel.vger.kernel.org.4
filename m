Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67865134E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiLST3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiLST25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:28:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2066C15F0F;
        Mon, 19 Dec 2022 11:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP1yXOGbU9KMtIIjUzgqbcPma6YaSbyO86lCEAkFGFMDvN/Jprl0zMCbxF30uV+fkPtBh2BrfWfM5s/oZrSXBY5AE6RoL3ujjHf/F4hckMM/Sv0FFSbBtnS/w/NLes3vw8R7MJM285hWfV1gJ7WSQ6JCtp+TJieefqUI9lGIzAdd6PdF1YBTH7U1i31WxAA+5KGa6PdZLLEhsvc3Kt2c8vYCgbBh13YhWKkyPh11f/F1lGE9GFQ6zfXZk/ApWgJ1GTNXZIZTCqOImOUpXyh1oIj57MyDXfHzAozqKWcaNZAkOztzvI9prTqP1v0Qz6b02rVJagwRalIhdFd1cQer0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqiUYF1ZwEcb0W9fMl+8/Prq8ersr6MGwaxEh3F+Di4=;
 b=DnZ25B2HDOaco0gzUMI0VIkDlcxSi2B0e8Im/t8vvTjGFTJN802C4Gklut43NqYgsjdWBewNj9Qps131p2cME0tbhRD5f263yzsGMSsszP4RvxeUm7Xd0cYfEnZbKnRNMRo+cLtjKoczotpNa1COze/glXsOfTw+czGzILbEWD6JUFh1uRHy0lq6pL8flR60YiD6s+97dTw92uNTp3j0eyDyGHeEBAofXlBf2FqtSjGVAX+4fWih3FlvucQGiNj3/i7jq3GGS3gzgWny1TUTPOFcJZCCp9ijbv/+lmv3TXs7NB8IQLnu8daT5m+ajJeo9u+gp+T3Mzu3SXs24txpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqiUYF1ZwEcb0W9fMl+8/Prq8ersr6MGwaxEh3F+Di4=;
 b=XV9LxE2tRgpITeX2dNDkavRaN55lPcr5ZznpoZD3gO5+vP9Pt2bj51VMoo2O4y/ZBP3gKUTEtqAd77tlu/bwD+iA9hV7Rpvwm/UucohSZnGfo0Qk/2xX6bAt8jqQeSFYWUbnO3hD8WkMgtRnId93Vka7JBPx0jwJUIbmJD6y9+Q=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 19:28:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 19:28:52 +0000
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
Thread-Index: AQHZBZrSquDNk6pznU61qmw2jh4ld65vWcwAgAZO4MA=
Date:   Mon, 19 Dec 2022 19:28:52 +0000
Message-ID: <MW3PR12MB4553A194B951DAFBA116894995E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
 <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
In-Reply-To: <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T18:44:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=931650e3-ef01-4f56-bc94-c2200826f8e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T19:28:50Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a06cad12-f54b-4fbc-8f5e-678f0b623c61
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DS0PR12MB7512:EE_
x-ms-office365-filtering-correlation-id: 8edf0f36-79fc-4f34-a2bd-08dae1f742de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ldOgDqN83GHDI1F4Kc6hYnCz/5yZ+ZdhqjtgSv5BvsF3FM7X3POYkVZLbXCtzHsSHZ+8ftRwKazJBjPOM9UM7fwG6i6GvP46joAaFz2bAiRO5DbpIprBp/Njdr6MDF12wM98mq248rsicZ857GRS5R3qCvEuiW17ojkRE5n95xo830aK0XQuAACy8frHiMCQLXV6GWt/qmu9dXurBezbHN1NobAnPlNBzi0BHiOeynBHimQSZrJo03fA58UnPqxDELqEdQfr8IuXyrW2B2DnA7k9rwvwja7SUtkPTlmldE3mZrhIUJHxcGKDqJkzkW+b+6NvvI5EmgrJsUhkNm2C9866kaSuANiZXDERYs0Cd4mlp2f0V8MaOB7UKO48I930Li+I2DzZRmlx5KBTK1uVm13fWgGC4b47apD/I0fqfwCjBkI9VDG+mNnDcbYTTqTN3PEKADqT5iDGVi/tW5w/2zgFFGY8DE0N+nMUuMnFvtkA1MjGHRoLfjlxgb3LVNxZtQUa8KX3vCYYv41uLuqfOd4V7g24q9VgRgp87vwkLyMMxrd/xG73YVGeYUzb+jProgGnuu+ZSFhyYBUGy6H4y9FhnR4paQoWjjLIisiiJtnb1ukAvd0/F4f8il6cQh0gL4GjBkDi8QjyfEFM313K0TGtP4A+jWCC5atEr/NTcHtpftzdiTqWhR6Uhkqjkan01fYofGCHDyGpIKIWuig2pE3T3d6YwdW/4M6uFCcRlHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(38070700005)(53546011)(7696005)(54906003)(6506007)(316002)(7406005)(966005)(478600001)(38100700002)(4326008)(110136005)(8676002)(76116006)(66556008)(7416002)(66946007)(86362001)(66446008)(71200400001)(45080400002)(122000001)(66476007)(64756008)(5660300002)(30864003)(83380400001)(52536014)(33656002)(8936002)(9686003)(2906002)(186003)(55016003)(26005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rBg7y8V/AS7ShoWCpp5kG/jgUXhsPmeXGAGavnMvrgKHXKEZ/gCn8uHFbNVY?=
 =?us-ascii?Q?XCnx1yFqyiNj6mp4DXh1THEcsVqQXp8bm/dUHmXCPl79OzubMS3xYo2ZkbZo?=
 =?us-ascii?Q?mnxZ8E31q64/ZrdwUdsQTepK5vIY+HFyMqBXqLUzRLa3QxdkmMa1n9qel8Uv?=
 =?us-ascii?Q?Zn7XIuKtM4LQn/UwaLkGoyxR733uPjp0DoSSgCWAM29fWMhQrh8w1xKY0jQW?=
 =?us-ascii?Q?k5EMhus1USHtNf4/XkmVcewWzt9Tjz+7zT5hHG3wZQeikyKqw55xZJ8lI3iI?=
 =?us-ascii?Q?EuniP2CP7N2LDOQs5CEY/d1p9C/JbaxK1AezKHbBBhl8KM5z1J+Ox4q7+PKp?=
 =?us-ascii?Q?XDU5H/DjbKjWOK1YqXZISypEGUfsQEQtmXii80hyQ3GblhHqYJ7FlT2YBGTt?=
 =?us-ascii?Q?ZsPv6O0A1fuT1umhVOmflwN4/TnFIE4ILuLwEnd3D4RkMmqq5Humtaj14agh?=
 =?us-ascii?Q?wa3cTq7Iqg1QkEMLb7UKI/Gh6U9MCZBiaeBa4326Hq6pOXN1jHwMfURf/Q1G?=
 =?us-ascii?Q?wr3Wuw6kS0XKw7n+vD/jN61UtfLJvsQ5bA68KLS5juHlfKjEtaDw5F/NdTlV?=
 =?us-ascii?Q?pw3MYfy/eaidUNmfnHVSjO8aCIB/R5GAK4Xj6TzNiXx4N2rLdxF8/oWqih5e?=
 =?us-ascii?Q?p/7pNnnFRf5qILzIqfmYeROOda2N4cOjUZb4KpC/H56Qcu3IkhGR2i0QODLR?=
 =?us-ascii?Q?rOaUB93S8z9zBSjIHtX2SEYCkneKoe2hH6gDHK0Xen8hyldhS2U2pzVcv0bY?=
 =?us-ascii?Q?zKpeVl03gLEUpWLUt+w2Cd3yPLBKub5NvueAGwU6wNN9jDpkqecM7QSuu1jb?=
 =?us-ascii?Q?fOAeq74b2qMe3D9iB7/nyl0UfvO3rQkfN1WwfjfErHr9x9jJOJAu1mI77/nd?=
 =?us-ascii?Q?4QqV8+7TvgMScRY+710W3jgtISiKya0gM0CvM7EVdvx0B35rC/rSI23QdVBe?=
 =?us-ascii?Q?apwZl55Iz4+zJ8dWZqoQjzfF1p4aTbWsNKlbC9vMcJaM3Xh0CHXZAZ898321?=
 =?us-ascii?Q?Yv8GAH0wGBhB91EeCBnXBmUqxviyef8e+oOOuhBig5yX3B7Q1+6TniJU8m43?=
 =?us-ascii?Q?RnapDvdXBKuxmrgHqKee0xCHBzMREb0+ALN48KQVD7Ccxr6711nhvd9YoQyc?=
 =?us-ascii?Q?w8W+/L7fTSduhclb3NaiMpGQ2Wd15mRFpm/eaSn6bw8vjUZRsewugVsxQUFw?=
 =?us-ascii?Q?E1WCFna0Ef9rU+WXjMsLUarTZ4RHvR6QjpDOCWH9D+LRra3lvvS6ASsiYhGj?=
 =?us-ascii?Q?Pk3mr1Az+RLG2zygyulAIcEG1wWY4UKQ7cXBh1FbVlrGfQDZ3RZjLP5AM4Q2?=
 =?us-ascii?Q?PRhDFAYwxL7KXk8Pbc1qS9UKSTvmR5E7o5sdcbdfTrY3tGX9tjXFTTiICevp?=
 =?us-ascii?Q?GXjMUmze4/xeHONJZbzEz+empZypvraWjJ77gBAy9XWJRikttd6h+oQF+kT/?=
 =?us-ascii?Q?ZIczu3gnTPgnpOtkP8Jzyb5RkL1+W6MeFdk52ckyFGIEbWkfVRZbFDfQC4zD?=
 =?us-ascii?Q?vO3ijVNLl7DFGzz6OxlZGxDzqdOm/lel9CGhuAp6X5qxMFNcDipfPIDdlJ5j?=
 =?us-ascii?Q?8/Zmh3o7eSYaXOask6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edf0f36-79fc-4f34-a2bd-08dae1f742de
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 19:28:52.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXFlZDNwQIl2nOEZMT3Tmulv0vdA5wKgTJMfHA+uXbbv6uLu5dRJMn/CtTNvumGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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
Sure.
>=20
> >
> > The event configuration settings are domain specific and will affect
> > all the CPUs in the domain.
>=20
> please drop "will"

Ok

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

Ok. Sure.
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

Ok.

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

Ok.  How about this in the documentation?

"When an event configuration is changed, the bandwidth counters for all the=
 RMIDs and the events will be cleared for that domain.
The next read for every RMID will report "Unavailable" and subsequent reads=
 will report the valid value."


>=20
> Have you considered doing a preemptive read on the RMIDs that are in use =
to
> avoid users encountering "Unavailable"? I assume doing so on a busy syste=
m
> could potentially involve hundreds of register reads/writes.

No. I have not tried that.

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

Sure.

>=20
> > + * @r:		The domain's resource.
> > + * @d:		The rmid's domain.
>=20
> This copy&paste needs some changes to match this new utility.
> How about:
> @r: The resctrl resource.
> @d: The domain for which all architectural counter state will be cleared.

Sure.=20
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

Sure. Will add this text in the description.

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

Sure. Will check.
Thanks
Babu
>=20
> Reinette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20210650EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiLSPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiLSPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:31:14 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC518FFC;
        Mon, 19 Dec 2022 07:31:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k92/UB+j3yonZbi7wqT+PvxcDbSF16n5dwNfEUL+N1JhCWYZhwOR7yCQgAUR3LesCV2IwLhINVPO9BpnpBrmWGR7AXxMSi3TgPP+pAYXDDesw50yKx0OueHeRKjrNWdzolIQ1kuGp8CsuevQmPsx55AQgucyyk2I6Y7voPysyvMC76BpBp0A0Agoy4EVhvT0Ae45UZRl6OQb9AN7U8DMaJAtWZxtEUszYndEcS/kCIfUQbeIb1zd+8BSKiXdcLElHNe8OjuNExj3rtafP+8gkRJyFSmZKwTNJKkECvBZF1eUZUwPERHkpatZlrbW4OOoVMhm4DGKxIQHLuIKHRC0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwIVqijXvqPTk19P3YLQl2jNdMsmNHhY6gkTnz7FYFQ=;
 b=SVIr3eS5fBXEC+TeQLUA9A30UNSwfsNW8RYU62C8hhBsr1I8Vi4w+WvdNk34xrWlL/LGsNNrPYxezf/VJI0BZMVmOU5Ufgf57P1w/RgbftbYqZ48BDwd9svcJk5ueyU5v+nDiyWizNt+jm60fiVMuvtzfFaAGFTsLlfim+1DxefvARd81TbogAIAo+dnJbt2mSfK87XFjxSuGIcyT08IyoWZETGIIsjTTu0a5t7nuWktT4Nfsucn2Np/ElgvsdRQtMS9PlhIAeuVgPLS8q3hVavrJzsxdEu/rRbg3KtnYz09NYGgs5g2rxVLrHCSdyE08hLlOttImf5sMfWK1wP72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwIVqijXvqPTk19P3YLQl2jNdMsmNHhY6gkTnz7FYFQ=;
 b=xPIorronZsDWXEmqabuBv5LrkVMCvsYlPsJzC5qPr3yFht4/OdRsmXtsNwG8t7DX9DmU6HJ7Z8sebsXFauoF/PUZV7CLiLDoGYI+/EXBlvvn+6nXPjsCiBxKECqtHdxOni8hcd6iErFgUEXHlhYglLRksXdTMtEIkq5os/IWAWs=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:31:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:31:05 +0000
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
Subject: RE: [PATCH v9 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Topic: [PATCH v9 03/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Index: AQHZBZqtxL2FEr1HBkWkNixV6amAXa5vRVOAgAYs+2A=
Date:   Mon, 19 Dec 2022 15:31:05 +0000
Message-ID: <MW3PR12MB45538840E7357CCDF353929795E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990897968.17806.16187773270520553795.stgit@bmoger-ubuntu>
 <b5c6c0c2-6ec7-a01e-75cb-113324298324@intel.com>
In-Reply-To: <b5c6c0c2-6ec7-a01e-75cb-113324298324@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T15:30:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=54497eee-65fa-49ea-a024-1fdd4d578e02;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T15:31:03Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 26f31385-3d72-4aaa-a990-0816a6ab0a08
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SN7PR12MB8059:EE_
x-ms-office365-filtering-correlation-id: c15f2872-9c29-4c11-d56e-08dae1d60b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6aAWdk1qqUq5ngSh46fDzSnZQk+4pC6FipkPVmWDhCxprihGAn4hTNOKApt8V2Vxiw1x7MsR1MoZ5n84v0mCxG9pSN4qy/ma3fCUgzzO0R7VoCJ5JYnLA8r5ArgFc/1MZ658+BuX80m1LeryJtzgfp3Fd3t78yp3H69lj1hdGfZVTr0AkiwJdwoF0Rg/qSu2RxJ6/ghbZGkl+oeVmyeiasON+oD5lQFttDK+obfAf61ZhmjO0hArCjYkKI22Zz2KAiTGgNktv03tMUGWcWvFGWRapOZQH3UEnaT4CWO3TiReXFzAtyQhpic94DJ9QxU4SV6x2ZdYdOVMA4KMPy+E9Jn40zbAMeZUi5fhMYiX6xkQYzIwO+CAC3je7wYJmXHVXpnc4ZQaeZKkTbpYAZSW8Gmwuljt2k7tLDwTw90r8ZAy5t7UAl1OeUvlPHD5bmegN9tJ244I8LbwIVkXF7/8oq4xPmT+gdft51423u06D5DbssniYO7vb6xHWdrltX+dtqvoY5ooX35moL3pQS4/xbqgsI7QBDQ/++saQEbIAL7CN+3/V+wWin2uJc3NnYiPsWwu2EnVV3dhdznL93KkoaZYnwhDPZKRk09NgcKLBn3fG/ijiIFS1UzwkhhFiIm6ix9VjSeE51Klc1eP2jL+WMhBjQPEIF9GfUErAaZ6V2ZMmB/ytd7T+vno1YQs4hKCybkGr4w0vlhkh0tXIuwEcRgoHHKctHbd2/6j19efDMKcyAbn2Q/F/mnggzc9CTtnXFwcMAl43xR431MnCFKdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(55016003)(38100700002)(86362001)(2906002)(54906003)(478600001)(110136005)(122000001)(38070700005)(316002)(966005)(71200400001)(45080400002)(26005)(186003)(7406005)(7416002)(5660300002)(8936002)(52536014)(33656002)(4326008)(8676002)(76116006)(9686003)(66946007)(41300700001)(64756008)(66556008)(66446008)(53546011)(83380400001)(7696005)(6506007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KmdTFG5yKBdnitV2t6siSugHUMRu2f7g9wvbbnqgzxl4c57fO6q4YFuya76E?=
 =?us-ascii?Q?m1cLZCM1xO1aMX9igU6lLlY1dT1MIlE+pemIn9IDnOQtNJzQtOnX9yPNiMbY?=
 =?us-ascii?Q?zjzLIPpvkZljW17weC0Dpnr2mH61FdRViObIhTaOd0QTC0/PrXyliu3Jv7Uy?=
 =?us-ascii?Q?VZTTxch04R4q6tkKSjRadxMYv5sGe4NAR4X2SwjPB3hr4TbqpV9rSv5N40qa?=
 =?us-ascii?Q?3uC3jnjmrpxaeobwmW5TOGwcHT5J2R0LV8J4aRGIpJLPHw8WZTEHrJ3hPSqa?=
 =?us-ascii?Q?vAA+zu0ez6FkUCNozjLkoHXVOxDQ+agXLiy53fc9YIVhbgFNA/GfOpqD7FCs?=
 =?us-ascii?Q?EyVLBH91PnZS/Hm+wd3+mjVfAWxfeZs26npnZr0IDQYvUXoEtiv43vY7AJ1c?=
 =?us-ascii?Q?Q8F+tyQNLXq9Quc93kRyPzyKkTWV5HO48GpoFA/aYk8qUv+fkovDZko/dBXP?=
 =?us-ascii?Q?5hrHP14DnwGiWxEqgZIptc3502EE5OngYmCq7x1kWYxTvelRGkuahd1w03Fs?=
 =?us-ascii?Q?RiaF9eRPXwHl60c3Lfl5NMvv4r1a9hKq8oOfmB0XxJZkpFwsL5519K9n6+G8?=
 =?us-ascii?Q?OsArIjgIdJkniwRtaPfgvShznGR05Pu7kBQBoW4GwKv762lwOM9ph8BWZx2h?=
 =?us-ascii?Q?CNxlRmOOlQcqAz5k/Ugm219VOH5N033Sr49r2f8PyInMg+nuSUfaH/190MbW?=
 =?us-ascii?Q?Dc08mtiaeygTsvQKINmyBRTCCzRKh2bMyAUYhdohGUBgCAIoEr07MiKsDZyg?=
 =?us-ascii?Q?d5yGrMYF+GM2DvCCTnsf0mgRWVXXPZwEfChQ647bc1/90/oThXvN8acOKbLb?=
 =?us-ascii?Q?JXjQlqyMxbgvEf7gRbdC+4enFFmJ6TCMKLYUyzt1iieGHYoFqYSogsH7Al3x?=
 =?us-ascii?Q?9trDMTV1caAeV/XI5vIbRbHLoQcne8U/A/qh/f1BhOfHFaKxwwycu+Q3XyUX?=
 =?us-ascii?Q?Go3IHiwgiARvb/RBbedkzOJhJ8bOjmoatFIrwOAmJdY+IwEoqcV5oy7bsLDo?=
 =?us-ascii?Q?3Ma7XmX8Wf3do3lZ1nv5jd9MgO40yrvXLihH1hjjrG74aGNf7xHtwMmXkUw2?=
 =?us-ascii?Q?HDkRqetnZql4H01/rb+wnLPs/jIBmg5f4pp03fbNyWslvVj4sd9gXbrDpNFy?=
 =?us-ascii?Q?q1WkI7WdL721L2rRz0FtFATM3usKpTV0eVNfvt/RfptOZD2pmLxO7iAetqnQ?=
 =?us-ascii?Q?hdd8dyjmAPZxWSGBaUHTf62uY9beH98ChzPUAPs5cz+8RNz8jgBKumbWiYa+?=
 =?us-ascii?Q?dV999TIGVuOvcE/UrjYU+kFG/9jWxaMX729I1cw2/+qcMn+Eer+bKU04E9IS?=
 =?us-ascii?Q?qxb9nEewG/PSyQKuQOqXVuQqiVXTSAxKyktPCCKKTC9KOr3X0oHqfzHC2coL?=
 =?us-ascii?Q?1VCcd3twW41Qg+LS/6HZX1AYeldtYWVjOP2C+noOXiYLtdk3FLhevt84oAjt?=
 =?us-ascii?Q?tD9vNcfP7Ur4wuuSxBtwJzJQT7nqLt8xisxoSH9tKA4bjcII5Oxn4+pPHdxt?=
 =?us-ascii?Q?hWvRjIdHUQOOhZ+s8p9aS+/GFhxU7Y3NLVt+D3KPZJ9jMQck6qsj+gIdWYU5?=
 =?us-ascii?Q?D0DtMeDjoAtPd008HUw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15f2872-9c29-4c11-d56e-08dae1d60b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 15:31:05.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0urYcbJGsUh9T7ftil921fEbY6QwT1rP8wI/9z1FK9JhhqpHqWPbvDdoKDerHMdv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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
> Sent: Thursday, December 15, 2022 11:11 AM
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
> Subject: Re: [PATCH v9 03/13] x86/cpufeatures: Add Bandwidth Monitoring
> Event Configuration feature flag
>=20
> Hi Babu,
>=20
> On 12/1/2022 7:36 AM, Babu Moger wrote:
> > Newer AMD processors support the new feature Bandwidth Monitoring
> > Event Configuration (BMEC).
> >
> > The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=3D0=
).
> > Bits    Field Name    Description
> > 3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)
> >
> > Currently, the bandwidth monitoring events mbm_total_bytes and
>=20
> Please drop "Currently,".
Sure.
>=20
> > mbm_local_bytes are set to count all the total and local reads/writes
> > respectively. With the introduction of slow memory, the two counters
> > are not enough to count all the different types of memory events. With
> > the feature BMEC, the users have the option to configure
> > mbm_total_bytes and mbm_local_bytes to count the specific type of
> > events.
> >
> > Each BMEC event has a configuration MSR, which contains one field for
> > each bandwidth type that can be used to configure the bandwidth event
> > to track any combination of supported bandwidth types. The event will
> > count requests from every bandwidth type bit that is set in the
> > corresponding configuration register.
> >
> > Following are the types of events supported:
> >
> > =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Bits    Description
> > =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 6       Dirty Victims from the QOS domain to all types of memory
> > 5       Reads to slow memory in the non-local NUMA domain
> > 4       Reads to slow memory in the local NUMA domain
> > 3       Non-temporal writes to non-local NUMA domain
> > 2       Non-temporal writes to local NUMA domain
> > 1       Reads to memory in the non-local NUMA domain
> > 0       Reads to memory in the local NUMA domain
> > =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > By default, the mbm_total_bytes configuration is set to 0x7F to count
> > all the event types and the mbm_local_bytes configuration is set to
> > 0x15 to count all the local memory events.
> >
> > Feature description is available in the specification, "AMD64
> > Technology Platform Quality of Service Extensions, Revision: 1.03
> > Publication
>=20
> Missing end quote above.
Ok.
>=20
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> > amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-
> quality
> > -service-
> extensions&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cbf8c3716
> >
> eed74809726508dadebfbee2%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C
> >
> 638067212372390994%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3DnLkb
> >
> Wj%2FCed7gAf%2B8qfEec%2FMa1lKgi83EsPZs%2FU%2FOLWc%3D&amp;reserv
> ed=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D05%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7Cbf8c3716eed74809726508dadebfbee2%7C3dd8961fe488
> 4e608e
> >
> 11a82d994e183d%7C0%7C0%7C638067212372390994%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >
> 0%7C%7C%7C&amp;sdata=3DDTiTxeQYtjCz50emuxvoHFJbOPJUO0qcUHjwnQAxP3
> o%3D&am
> > p;reserved=3D0
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> Same comment about "Link:" ordering as for patch 1.

Sure.
>=20
> > ---
> >  arch/x86/include/asm/cpufeatures.h |    1 +
> >  arch/x86/kernel/cpu/cpuid-deps.c   |    2 ++
> >  arch/x86/kernel/cpu/scattered.c    |    1 +
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h
> > b/arch/x86/include/asm/cpufeatures.h
> > index b6a45e56cd0c..415796d7b309 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -308,6 +308,7 @@
> >  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth
> tracking for RSB stuffing */
> >  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR
> IA32_TSX_CTRL (Intel) implemented */
> >  #define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory
> Bandwidth Allocation */
> > +#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth
> Monitoring Event Configuration */
> >
> >  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12=
 */
> >  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI
> instructions */
> > diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
> > b/arch/x86/kernel/cpu/cpuid-deps.c
> > index d95221117129..f6748c8bd647 100644
> > --- a/arch/x86/kernel/cpu/cpuid-deps.c
> > +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> > @@ -68,6 +68,8 @@ static const struct cpuid_dep cpuid_deps[] =3D {
> >  	{ X86_FEATURE_CQM_OCCUP_LLC,
> 	X86_FEATURE_CQM_LLC   },
> >  	{ X86_FEATURE_CQM_MBM_TOTAL,
> 	X86_FEATURE_CQM_LLC   },
> >  	{ X86_FEATURE_CQM_MBM_LOCAL,
> 	X86_FEATURE_CQM_LLC   },
> > +	{ X86_FEATURE_BMEC,
> 	X86_FEATURE_CQM_MBM_TOTAL   },
> > +	{ X86_FEATURE_BMEC,
> 	X86_FEATURE_CQM_MBM_LOCAL   },
> >  	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
> >  	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
> >  	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES
> },
> > diff --git a/arch/x86/kernel/cpu/scattered.c
> > b/arch/x86/kernel/cpu/scattered.c index d925753084fb..0dad49a09b7a
> > 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -46,6 +46,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
> >  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> >  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> >  	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
> > +	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
> >  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
> >  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
> >  	{ 0, 0, 0, 0, 0 }
> >
> >
>=20
> With changelog comments addressed:
>=20
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks Babu
>=20
> Reinette

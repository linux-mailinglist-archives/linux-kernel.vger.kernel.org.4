Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8D6A8B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCBVTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:19:44 -0500
Received: from mail-eastus2azon11021015.outbound.protection.outlook.com ([52.101.57.15]:65459
        "EHLO BN6PR00CU002-vft-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229602AbjCBVT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0bm2LHQRYYSRCac6oskoDjt6mzrY5Axp6do6ToeK4ekmUmFiFlKH9c3hFVBlYrzrTc80vOeLzo5/mBrTFOA0kyhizCwC8Ku/o/uWJ8uwgRQ43HMA630Hw2LTOVnZpB7CTH2JxUf2O3Xm8BCxTmQ9Gi/vQc1Jut+KTQHKrbUDStJdWOHyJ200vPJXexsci+00IbevYKMhT6RqjA30sIXSfoO+dKNcDV34UKf4bE8d6zuFK3n1WaQmBjyZRs+kgt3suY6+klf+wtwxhd8FPbq6qEWTdVVfzE+yEc1Bf8hMcEjR5Ud0HjTUhC55KVUnPXgnLpCJ7JqxC54/lE6FqxedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HroUVPSWH1mEUYdwajoA0/Z942lc4QFN2UkKu29NRuI=;
 b=VxKs3XqgU0Ftw/xrofhcxAvR/iB9dCRMnIhdymEzp/iZaW5IwBGwlUGVCf5wPkr3+d5vIQ5ZyQQMrsH/OUNbxc5r/uxRDj9+2BcAExOhrf8aaIUyYGZEJPcVTLvpwKMJ49QNWfdjEpFgXhunHdEA0j4FeFgB8/s+n79z7VO+Zl8CaI30rYiKFSEzng4o+SRAcNYylykz4aF8cOLX9wcPbNSyCpwzBqRjKPxr/tub4TLJJpfi2v42wAaPq3WTPp6Hf/YDsxHHbPzXN3voKW98SZ5JAdGI+wsBZe49SjVzAyucODguVPAHF9z5ZYoLXMzb1dX67DHV7GuDpMqrsx6vRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HroUVPSWH1mEUYdwajoA0/Z942lc4QFN2UkKu29NRuI=;
 b=HZvUmiEZU6aeBlf9uKYcxxtaYDtUjZr/JIYQUibRE1mLgdw9gpmNZYbZXTZjjqA/Qc96EzIwUqVAZGB8Klh9w9gQu5eegxm9HsCAcRIZd9S7y5aJqOy3GPOOMgLsJPak0hUPCrXcuDy0PQ1hIIGwZvAgy+KTot7yaBnepzPcmAQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN6PR2101MB1327.namprd21.prod.outlook.com (2603:10b6:805:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.7; Thu, 2 Mar
 2023 21:17:59 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6178.007; Thu, 2 Mar 2023
 21:17:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Andy Lutomirski <luto@kernel.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morris <James.Morris@microsoft.com>
Subject: RE: [GIT PULL] x86/urgent for v5.13-rc5
Thread-Topic: [GIT PULL] x86/urgent for v5.13-rc5
Thread-Index: AQHXWqlnAKc2uywMC0GvJuk61QX3pKsHYb0AgAAWV4CAAAbygIAADHgAgAAQEYCAAUoDAIABgUXAg+En3ACAAFPb0A==
Date:   Thu, 2 Mar 2023 21:17:56 +0000
Message-ID: <BYAPR21MB168804172E30E8B0463E89DCD7B29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic> <YL1UucKH0GfXddZo@sashalap>
 <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
 <MWHPR21MB159330952629D36EEDE706B3D7379@MWHPR21MB1593.namprd21.prod.outlook.com>
 <51e60223-0d5d-428e-9126-2754020f19a1@app.fastmail.com>
In-Reply-To: <51e60223-0d5d-428e-9126-2754020f19a1@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b2ab386d-0f26-47a4-bf99-498f95422615;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-02T21:14:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN6PR2101MB1327:EE_
x-ms-office365-filtering-correlation-id: ba487f6d-3d9b-4126-2656-08db1b6397a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPGQTHupdBAPFdl1DLg94xmrCN1j9l9vN0B0Wtydyl4w0cUKTUjV1EjUbt1Gaqm4xhEyeU1QZfTOdxOBEXol2x3N+Npa+7sVqW+5Q/8UIcJOAU3hx9YnKPsFqeln5ZmlYJY4Gs3ko1TSnHgfRb7DBU0jqS2PZ1cPpt7blonr78Lw+wA86rWrW8e5wHRmz1BGdVBQ5k0vvRJqVKimYemWJjQfs4+Imgfi7p54NlY9e09ZlIeH/outPoUVUik4t3t99Vt2ekVYImiVCPcfmi4WzIbDw3Kgiukc6BLduUUMmvnA7+LUl6rPigDCAHZFdYWo50VL/wq0b3nVOWifCkMr3hu3HJslYMSCUFgmrxttEnFcHhpkb+4kaHZre6JZQZIHM1FswlOPLWxU1d0kaRo6BqcXa9V1q0JUUyPenRQZRT0N0U8a7/c+83SgVlJ3mWjCCLSnui2KhlnkpAoIt5YZiPGcPp5PtuCJ7D/vgY4RuFv7PNC9V8gebc2F5CAmvDTT8bQEOxGOKiY4CE/8PnNCeDrP5iaIxlWE89X+eQh4+wVj1a3DkgF0242g8imcrFmcSB45umHVBsFMe1efUttMiQVsCCJ2sT/dWC+9NIWcU0UvLJZKLF+xslc8CzAkXDQghM48s6ETekdjQt+uAeNMJgeBykg/9fY2m4Tsx3WFLPrxBF//5to3tndiShSF96LuVGGkvp1rGHctMTWsJGnSenWLNzAbTgrFWrZW0HKHmRwPU6iOi7Hddvjt9wZDy+Z4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(38070700005)(86362001)(55016003)(82960400001)(33656002)(82950400001)(122000001)(38100700002)(66556008)(66476007)(64756008)(4326008)(66446008)(8676002)(66946007)(316002)(54906003)(10290500003)(41300700001)(110136005)(52536014)(8936002)(8990500004)(2906002)(5660300002)(71200400001)(478600001)(76116006)(7696005)(186003)(26005)(9686003)(107886003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tnAPj3wwnIGmGnMTewpWTxGCOBgTqPiO6mZDm3mruwrxAH4yHzp8X2sg6240?=
 =?us-ascii?Q?bhj6o+qWV/q/WCALeqJGNTC3qzx47Eb9x2xEnAlirVa1o9eCTTu3CalbFRgL?=
 =?us-ascii?Q?tag2DlIuxicQ8Ha0nrIFQ70OqLKf/YwXLyT5MiwE5R7NVyP/arR4wOq3MQWw?=
 =?us-ascii?Q?vc3cemo97GQNOSsSQ2qMK9uspJ6tZAKblTsvGkbY1/eGtw3CO1ZHBdgX0Wd9?=
 =?us-ascii?Q?UnD4q4RA5o1A4v73yVNa3SFzUnpdlUO19hIrt51sjfbWNBvWXdS1SH4mEsoH?=
 =?us-ascii?Q?xOPHdLLL4TbwEyJozEW2yP7ORqqk6ZocIxAVVVPjvz2QW0OIBZxmYZba6E51?=
 =?us-ascii?Q?xjrmzxTQOW8RMQpBkmwp57BDc4p+Et7I+wB5wuVmUHjyzJAwnlQdgVyCpn1I?=
 =?us-ascii?Q?as/WNkwIn+1+Xx3mKm4uJnHqeJZpNocXMSMu31+daK0Ue7CGy1Zg4wjdzp1T?=
 =?us-ascii?Q?TEOkUZwwgSs3Gjd05IraIDkJ0+ZGQBxEi3Z08YxkXVt0Ly1DakZ5FxK0A40v?=
 =?us-ascii?Q?KhGiXtB+ONoA5uJ9LM8vgKJX2wxFQMg4tTsuCoJC5rphm5kFdpKcQnkBOBi9?=
 =?us-ascii?Q?scsXGbDBoyuCmVTSdVkjEZ+ychtuvAyk8TAEwQoBpMGQx5A9UuY6tPnEDhb1?=
 =?us-ascii?Q?urOPr2/6MPs6LS27t7ftWn6eDf54eXrxldnK3DoM9Ip91L44FM3PZZJSOdd0?=
 =?us-ascii?Q?CY4WGc2S5YMQv8AzQBbYhXWrSgcEdXVMb/l99Y514RW81YvfsXVF//vg3+xg?=
 =?us-ascii?Q?az7lIEkjq3IL8ljoL4oINgqic5CbEwKjOaode2enFEeeCFtAi+f3/JxI4517?=
 =?us-ascii?Q?n4XLfuyYVeIOLnZ+h0IKnaljKbk4WvwQhR3unpgjeW4cfV/ortrd8hum6D+G?=
 =?us-ascii?Q?BfiuNTnVW8lAj1BsbaddwTvWJNVcTme6CL3+YRBmmLWnJfdcVlkzguB3GkOd?=
 =?us-ascii?Q?EG/1+Zr3lJnmHClVFD59G3ADIu3bJhH4ylgJD6+c+aGaBY7KKems6Nu3vcI6?=
 =?us-ascii?Q?CY8UpZzhOTbyqfuDJ5q3dCqbMoI+mMvSziwiyw5qOnIY4rZCqBqeK7ulzzw/?=
 =?us-ascii?Q?GNeHQ+S+TZa//2901Sr92ks4SnxOF/IJkXuwf6HSc1LsbavJqHh9EP4+vVdB?=
 =?us-ascii?Q?9xlQ144uU4fv9IQaf2MR3v94MjXlEogoV2oUn0fdvMPLyAe/fa1ImqiJYkD6?=
 =?us-ascii?Q?W0Avei3+p4UQAQT6r1SnYaqquIYL7jMrMo193mBJ/7r210NjjBno35vqYHbG?=
 =?us-ascii?Q?pQRLrd+SE3eY8QTVswwlae5VHldRcXXyVDuqTIta6hMtFvwob5GIkLY9U/wf?=
 =?us-ascii?Q?/lYLoWX8X8wv3/cWa0v+Nut3HbWt9rCELQ0VdpnXLifPpVTuOOnoHgLGb0hD?=
 =?us-ascii?Q?HxaJwEyLHXYWKlyhic1d6u9oembXPoWzFJB9jCZHC34EHr49QSvTSDJNuPoj?=
 =?us-ascii?Q?4Z4q/Ysm9so5q3s1bwI40dnWB8LNkPCFho1AKyQXpyUlCMB33LMoqcCJKmkn?=
 =?us-ascii?Q?pfeuGLnEFhLQGk2qFqULZ5iAMI692HJkFrsRSNl7ObcKb/8W48aV24C7W8V9?=
 =?us-ascii?Q?FswNc8tVqcVF0bT9lgoxD0283+B7UEUiBJVamgry8b/ghOLXH2TCCc1ygZYI?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba487f6d-3d9b-4126-2656-08db1b6397a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 21:17:56.2236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5sEugyUGPQ1beH1iYbFaNQ2vwWUB2td6xzGdQOpXmGJXu5/fu4lrbJCo0tiqWsCQ1iseN36BtC8g0oAsBjpRnAZyzYtJB54oy9PbpNU5dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1327
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org> Sent: Thursday, March 2, 2023 8:14 =
AM
>=20
> On Tue, Jun 8, 2021, at 10:53 AM, Michael Kelley wrote:
> > From: James Morris <jmorris@namei.org> Sent: Monday, June 7, 2021 11:47=
 AM
> >>
> >> On Sun, 6 Jun 2021, Sasha Levin wrote:
> >>
> >> > >
> >> > >Let's see if Sasha can dig out something... CCed.
> >> > >
> >> > >@Sasha, can you figure out who we can talk to whether Windoze reser=
ves
> >> > >the first megabyte of memory unconditionally?
> >> >
> >> > That's a great question, but I can't help there anymore :)
> >> >
> >> > Adding James Morris...
> >>
> >> Adding Michael Kelley.
> >>
> >
> > I checked with the Windows team.  Peter Anvin's statement from 11
> > years ago is true.  On Intel and AMD processors, Windows unconditionall=
y
> > reserves the 1st megabyte of memory, minus one page used for real
> > mode startup.   This is done to work around BIOS bugs.
>=20
> Sorry to dredge up old skeletons.  Do you know *where* Windows allocates =
that one
> page used for real mode startup?  The current code in Linux has some bugs=
 allocating
> that page, and it would be nice to sort it out.

The Windows folks tell me that the single page is typically allocated at ph=
ysical address
0x1000.   They don't allocate physical page 0, so they scan upward starting=
 at physical
page 1 and use the first page that is not reserved by firmware.  That's usu=
ally page 1.

Michael

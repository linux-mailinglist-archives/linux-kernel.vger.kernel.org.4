Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7F5BB305
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIPTvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:50:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0FA926C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663357857; x=1694893857;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kNdIOQTvdz9DbT7nDj4QmRv0rSCmglmhgZtRdaq+1c=;
  b=hITEU0x8yyiNJzy/mHI7R9ufcnmFytB0iJ8ii8bucHHJUF4Kv0MnnKpQ
   g1n8tCXH6z0LGZxufsQXdl0I+GkmpyW5w2R3hA5Xq/ZiVK/Sdoqa3os0X
   +4E8Fec2yFLWLaAw8aYq4rnYHD7JCaoRdl3gmRU1fi4fYZdGUPK/0DXTk
   TSWbn99fLArTOQXyYf/9tcdt3QhF7ED1QUa9K8R5ZjJFz9BZNrfL/ewOx
   Te2JhLdHFzRHvoQU+4lAS4nMlZuZZhlVEY78YsUmDyaQDJOc+4oYF4vyz
   +Vy5Mi/YyLi7MttyjOxGJSHJH4DjXxNEbjwG9evDlsvYAcBU3zmwmySi4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299058933"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299058933"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 12:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="617787203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2022 12:50:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 12:50:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 12:50:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 12:50:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 12:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPxbtNjretj9oWOE0G0PjGvQ1Mxh+jWa5ctU4r377LghyyouhYXVQw84qH+Ac8tCAK4pxw6B8u1FYBWP8fzV9bk2oSK1ksNMEHluJqFg/Q1tait6LCmUox6c/4Q6xpqKtRP/xpnoGJyPplDW8y22pYi1ZrMYVHq1f7MGroNNa6ptBfg6ZOwuRCjHtQ8JUYy6Wj4Hl99LM31G3/inbA1QF/bMFvfFNcwmg0L0/6kVJWHADNLzQjTGBe+eyebuwj4Dv6v3ifNj/vdL1FH9MnPvHwI6IsPEKjNr2jurQIR4QDSEbnUwtLIhceKofXOIGtEAszWY9ArXS11VNZWrFSe9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfi9rnCUn6UTkcbRJt009Gs5oUDQs3Gg79mpkgYSSYU=;
 b=MZUMaSfGVWyyoHxGaQYSuFGtKkLi0v5XuoWMiXS/ZxSKyhVsBsMewv4l2C8QjhWx74hemHi0HYcoJH+rM6oYw4VDN+1C7qvmO5o31bK2cv9YLTuOmTefOzRrdk+BY3+InR6xB3mOc1Sck2k8d1yyd7UVPJf2CA2dTdHjjVn6IRRx/iyS8AoAHcwjzpEmlMp61z5y92uTqExIZRJs+PMs/l2IX6WIfk/Q3oCJwTSNzhe+Q9kOhyfyMkDUbsyw7Y99i8YKYcYbG9zwvrPQjOD5Uvb34d9/rreTBkHOlTSt8BKnDk+NmcZQuqFctWs/rclAnqMo94A8TVrdJv/Jz5S2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5357.namprd11.prod.outlook.com (2603:10b6:5:394::11)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 19:50:51 +0000
Received: from DM4PR11MB5357.namprd11.prod.outlook.com
 ([fe80::d539:80cb:2876:b6e8]) by DM4PR11MB5357.namprd11.prod.outlook.com
 ([fe80::d539:80cb:2876:b6e8%5]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 19:50:51 +0000
From:   "Arava, Jairaj" <jairaj.arava@intel.com>
To:     Takashi Iwai <tiwai@suse.de>, Pshou <pshou@realtek.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        "Prabhu, Swarna" <swarna.prabhu@intel.com>,
        "Afzal, Naeem M" <naeem.m.afzal@intel.com>,
        "Hsu, Shui-Wen" <swhsu4021@realtek.com>,
        "Perati, RK" <rk.perati@intel.com>,
        "Mandri, Padmashree" <padmashree.mandri@intel.com>,
        Kailang <kailang@realtek.com>
Subject: RE: Sarien/Dorset device: After system resumed from suspend, 3.5m
 jack is still shown as detected when unplugged during suspend 
Thread-Topic: Sarien/Dorset device: After system resumed from suspend, 3.5m
 jack is still shown as detected when unplugged during suspend 
Thread-Index: AdjI33vqg778sLHVSWSHqfAWugAyCQA1K1KAABNBNlA=
Date:   Fri, 16 Sep 2022 19:50:51 +0000
Message-ID: <DM4PR11MB53570968A455F76371004B689F489@DM4PR11MB5357.namprd11.prod.outlook.com>
References: <ee87941f7f654213924aa1bc79db32f7@realtek.com>
 <874jx7vdhs.wl-tiwai@suse.de>
In-Reply-To: <874jx7vdhs.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pshou@realtek.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5357:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: 543a7a45-0c6c-4300-a143-08da981cc298
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmDO6Sln/f+JlU8C+pSKDnCM+O1pEj5HFOBiAp/IA6ZZiWAH4SA8uYApmw/f653bIbHnE61Tgz93jlntIWt9kyTlKVDL3CauweiHFbWEQ4GxyzqEsT+E/7TgzSzj0GUpnLJpIbf8faZTh0fmRybh/TN1YLWbze2Gr8cpRJPE/3y9ohHDkdW3iLkjAE2rMfNMz6PypylquOgyrTSc8Jf0imISmZ1KtDAX7rhiHYrC8W2SFtUsCanyfzK5K3VBFFVwFYzytKy2ybIQnj72IZyEa8N7IEmgwEHOJ1DXrGKsZA/2rJfQSl+HY8nD3ShGZvpD0PDF831w19hKpfwSDcsIzqUEVqoP11lGX372wVc3zuJWvsF7coH1EqcCJg150Q1T4im+WhpFIWNsMbXaDNwoniQeQLOKiyo9DlFHZngw20cUPKsOFaO7R/0FpR+ImBvkLz8i5xaIEvXsZ0JtBq0op/pAKioi2LcfqrXGVqmJjrtLufculgutwYeJu85361oKdUu1JMAw6QHY5TVA5pWeBWzmN0FworNkpbbeBeKhQZJpfyQ1SJfcdNr8iBVmcBDIM8koJzcNdf6/wGUoEo9GjJed3HmP5Xvn8Cp9RhhBpDfE4msbuByxn0TZwYkZWC/lvNdnGmTav+p5l5KgHzQ4oylDx+MMyXTHCFSvfJsVj0kdZVQCGTaLI17DvqTpLrjC2/2zkB2x92NcmjxnoK4+zWhd6deUY0i49sHBnEibRN37mrQdF0wByMUEMrxXlvUNERmi+u4qLEmEEXhcnQH7GHgK1RahrGigv0IJnNu7RdK4aUbHnSHBGrEVgyG9rDsknWcYRp1+ANZ40xybOAsWOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5357.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(84040400005)(451199015)(54906003)(55016003)(110136005)(478600001)(316002)(71200400001)(966005)(2906002)(82960400001)(5660300002)(26005)(15650500001)(41300700001)(38100700002)(8936002)(9686003)(6506007)(8676002)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(7696005)(52536014)(186003)(33656002)(83380400001)(4326008)(4743002)(53546011)(86362001)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HFWWQDW9WSgA/Kx7Ggl5CCVbaqhu4lg800Pvs54cIAr+yJPwmGeZnDQVdjkO?=
 =?us-ascii?Q?ZsMl21cY4PUqCWfz2FtQW8SUwNa1wOYmVs/MegGGtV23YHZSIOdsozX6NGro?=
 =?us-ascii?Q?Cgz5+YtRo2lBziPLGY1MLOT/0vqKOiFF6pnsR6jNINLuMtfv9wFNcqm7jCOc?=
 =?us-ascii?Q?ZCXUNCMtMm5hDcLxuccVbw+0wm5ksPsaLLwWY+9IKybvoSbl0b0KHN8eQ4Nz?=
 =?us-ascii?Q?MiqzuXyYPMLvdKTZb/60B2V19LyiBYMJyy69xOVfrA7VuXWQ0fAikFVRibVY?=
 =?us-ascii?Q?h2LvMT1jl2LBU0mwXB+uYq3T8cpMLTX3utpOOv6UpbgY7md5Mt9qggIpEuGW?=
 =?us-ascii?Q?ZIfXp4Bj5nA404F36ZOp9lIKBB5gzsjunTkx24gWpVOuA16EclURlVWjBIKR?=
 =?us-ascii?Q?DUU5DaKT5uFh2QVXuhltYCiaL2jE+d7J6k6e8RlGymukB9iOVodkVBl37goH?=
 =?us-ascii?Q?2VUagVNIinrItD9AvfxSJNjgxPdhfQOqBJCWLg3gSur/LihGjXi0eAWZP7Jx?=
 =?us-ascii?Q?KtbJrJsLBZW3jjjeXDV9He9E7+tDo/C8y6KMYHWfxOQijBUiKKSFofNvxAFq?=
 =?us-ascii?Q?aaGS+5QiB46xMMX9G1St0z2IzlNZ79XJahwKysD2Ti//hbpgcEhfL0xG1ZHx?=
 =?us-ascii?Q?QQRbn2UunVEdcflueYJj14I2kVEZn2RUXE35b7Ud9EO+16CrOCCF7OOdVEuF?=
 =?us-ascii?Q?JOQ2c3lWXz8pAOh3NIidmivnetl7BpvFCp+kmfOarAzBpbcHZlsyGGLmUsml?=
 =?us-ascii?Q?xeMFbB5HI1pveObVeMiPnMJYj5Nl0lyGYr57Ry9R/vGUhIYsfqFOyXfqqE6W?=
 =?us-ascii?Q?w2fO3hmod+WsRRg+4eO/Wut5wNmTB55Owxqa2wmXhl2YubS4z+pJbFUTsLv7?=
 =?us-ascii?Q?LVkbisJ5gP2UabCELvf6jjGpzrggM52x6FiKsQARMIig8B2PcZEt0wRvj+jU?=
 =?us-ascii?Q?nU14tafOwyEHIN+I5bHVg0p+V3mjvfly5Ov7i7gTOeZtdVUT6ZAxhzOEsF7G?=
 =?us-ascii?Q?ZMZKmC26CcZfofq46H9bAtD1VTqkjdi9l12Qe2VtCY0HrFuoQezfn2LZ01LZ?=
 =?us-ascii?Q?LlzG75h9m2JyF3H0ow/5awQu/SvBHH/Aao4rNEkyWP8kq89lFeZ4l6dBpKZp?=
 =?us-ascii?Q?H518a/e3NMwg7zRpxEfEPZQyBY1w8JActdNegGIu+Z8dTW9V9vONT00/E0As?=
 =?us-ascii?Q?fzwTqsUYLol1VXXxsJwcU7I92b+bZSlP49mKvHeazOmTfU1UP0ddCSF7Ht8J?=
 =?us-ascii?Q?w9f2iNHbcbjtWCCL8FvUnlVHSjpXBB0UlSW35l2zMiaFv29ejjzEx2t8lpGm?=
 =?us-ascii?Q?ZKiMGjo7UKbDU6qToeSpcL1PhZFrFVF0CTwrRe2UaH5Aom0NvXd6kF1bIpVU?=
 =?us-ascii?Q?OdPfY2lGg6/Q7Htukn1hmP4Y/Q5U74hnGXTVujwzhcHF2mMYAvwtt1yONNJl?=
 =?us-ascii?Q?qB9DmgmdlqqGQ+VZVrJj16yOhddY0Qi7EJT3syBkGGwRj5dQJ4vKMPNvLjAF?=
 =?us-ascii?Q?2PRjfzfsL7jFPTxM7MltnT//d6MAcLJ1JxsFtPvkp3G/vNpYjwJH6jTZR8hq?=
 =?us-ascii?Q?6FWArkmNmVYwATBDUiMKzr99+rDADBLI52gINlAg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5357.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a7a45-0c6c-4300-a143-08da981cc298
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 19:50:51.7478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbcGGKpN1ZpB7ZVsM4u9VKS06l283pP2tKzZWbfBkPX+dXYXJW65PoC7fmQXc6tL5br8G95EpYm/jxVcLKsAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

This discussion is regarding the bug https://bugzilla.kernel.org/show_bug.c=
gi?id=3D215297.

As we know https://lore.kernel.org/alsa-devel/20210310112809.9215-3-tiwai@s=
use.de/ is causing the 3.5mm headset jack detection issue during system sus=
pend resume. So after reverting this patch the issue is not seen since the =
unsol event is handled without this patch.

Since we  see in https://elixir.bootlin.com/linux/latest/source/sound/pci/h=
da/patch_realtek.c#L992 the codec driver has  snd_hda_jack_unsol_event as t=
he unsol event handler. Hence after reverting your patch, from https://elix=
ir.bootlin.com/linux/latest/source/sound/pci/hda/hda_bind.c#L56  the driver=
 is calling https://elixir.bootlin.com/linux/latest/source/sound/pci/hda/hd=
a_jack.c#L713 to handle the unsolv event.

Based on above observance, seems snd_hda_jack_unsol_event is mandatory for =
the intel platform Realtek codec driver to handle such unsolv enets.  Hence=
, @Pshou added the PM flag check as the patch was tested by Nvidia.

Thanks,
Jai=20
-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Friday, September 16, 2022 3:08 AM
To: Pshou <pshou@realtek.com>
Cc: linux-kernel@vger.kernel.org; Takashi Iwai <tiwai@suse.de>; Arava, Jair=
aj <jairaj.arava@intel.com>; Nujella, Sathyanarayana <sathyanarayana.nujell=
a@intel.com>; Prabhu, Swarna <swarna.prabhu@intel.com>; Afzal, Naeem M <nae=
em.m.afzal@intel.com>; Hsu, Shui-Wen <swhsu4021@realtek.com>; Perati, RK <r=
k.perati@intel.com>; Mandri, Padmashree <padmashree.mandri@intel.com>; Kail=
ang <kailang@realtek.com>
Subject: Re: Sarien/Dorset device: After system resumed from suspend, 3.5m =
jack is still shown as detected when unplugged during suspend=20

On Fri, 16 Sep 2022 07:34:38 +0200,
Pshou wrote:
>=20
>=20
> Hi Takashi Iwai:
>=20
> Can you help me update this PATCH file?
>=20
> Check if ignore unsol events duing system suspend/resume and NVIDIA=20
> chip in hda_codec_unsol_event().
>=20
> Signed-off-by:PeiSen Hou<pshou@realtek.com>
>=20
> Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
>=20
> diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
>=20
> index 1a868dd9dc4b..75560ff6eb83 100644
>=20
> --- a/sound/pci/hda/hda_bind.c
>=20
> +++ b/sound/pci/hda/hda_bind.c
>=20
> @@ -50,7 +50,8 @@ static void hda_codec_unsol_event(struct hdac_device=20
> *dev, unsigned int ev)
>=20
>        /* ignore unsol events during system suspend/resume */
>=20
>       if (codec->core.dev.power.power_state.event !=3D PM_EVENT_ON)
>=20
> -               return;
>=20
> +              if (codec->core.vendor_id =3D=3D PCI_VENDOR_ID_NVIDIA)
>=20
> +                      return;
>=20
>        if (codec->patch_ops.unsol_event)
>=20
>               codec->patch_ops.unsol_event(codec, ev);

Hmm, this doesn't look safe.  We also want to avoid the unsol event handlin=
g during the PM state transition, too.  So, if any, this should be allowed =
only at PM_EVENT_SUSPEND or PM_EVENT_HIBERNATE.

Also, checking the codec vendor ID here is no good way.  We may add a new f=
lag for the special behavior (either allowing the unsol handling or prohibi=
ting).

But, from your patch, I don't see any reason *why* this has to be changed i=
n that way.  Could you give more backgrounds?


thanks,

Takashi

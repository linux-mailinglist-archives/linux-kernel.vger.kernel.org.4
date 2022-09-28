Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042995ED2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiI1CGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiI1CGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:06:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8C10AB32
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664330808; x=1695866808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jo5GHeAnZWL/h6Bou2gZUfgCsfvM/Tw5yu5ylX7lsSY=;
  b=DWHHp+C2aVImnFDbEF0Gp6trTyWbrlGbP3i+NanKj67OGcIW9FFjtD+X
   hWsHyvC8TXr4QwWctTZxwUDpyDbfvYi6wjPYUkSMw9Znvjl57U1Ubj6+I
   ElthH5uu2Yw8cWW0Hrc2X+scvX5hX+XiisvLiCUpS9s87vPscdqHzyMgh
   jTBBP+J+JEOgT7hStI7WzkX92r2yAx8D1goQYketZ1CM7nKRXeFwk5RPT
   rRZTIfNf/6xBTig7es1PDNkp04FNEO92THmUo3W5djnKiFIxlpNXtCieG
   wC1nkgHkPaLR3Ypi2A5LhXtL7c/19gRNBLnwvh4pqokGsu/wulO9mqFfB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363321645"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="363321645"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 19:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="690215581"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="690215581"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2022 19:06:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 19:06:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 19:06:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 19:06:47 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 19:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiPkWm8IZ/hYqmjGb0Qv173RmUv0aZ56aqxU/abEObIiT5ZjZJHJmyawosfp8eFocifXsyzY7+bvG8gkdkkBp2k1nsy0ivqX71FwHphkxMesrCUGcp539Qo1FRRTpA5ifEZGqnnYn8ops5HN3zWAn33k8uLdMQWvBmo0WJh84r3wlhb1cvFnPwmYBC4wC70kupeltfgfdEPtVGJ/RGR3elXGQZb+0B4L0s3Xg9cNBZplFGwzupjVUc7B8uRssIlZCsP82dc4ZSeqW5NaT2oE6EoeORlMWAF+ScocfSq2ofIEzjBzCgherPq5PbPQT3elyfjlP8cKV8TGw9ss2TXQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vqSelBh2Jsl3rSY20g6FjDPOXE4IGEcuwrKtBK8wF4=;
 b=CWXR200fIbnrFsjG5R6+7JSXxW451Nl9d3ol84rOc7FKpAOL8nnUAMfVIINwhQlSqwkuApbxXtAY4lBCMLboypUbmZ7qC43Onlj7rfW+XT1rUx/2QllVpc+eFalh9EgFXTyOTtLZ+xaANzk/4xgfPV+ZZRd/wOLTZRsAMtc0Au1vX5z6BuSR75jndXGgZP3zqQwe8ePyRNKBX0jDpdeXmWKovM+IyOcv8rIGl/ZhfnLuiRnMX+tEFLpOjYM5BKI823mbbTyZKETM0nXh3jytVracdY5+RIzltX3p31jQDhInGQl+j6CxpSgyAfPlrzLp//IABQh6h0GNKo/5alO4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 02:06:45 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 02:06:45 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mohan Kumar <mkumard@nvidia.com>,
        =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/hdmi: run eld notify in delay work
Thread-Topic: [PATCH] ALSA: hda/hdmi: run eld notify in delay work
Thread-Index: AQHY0nlqZat1Y5WzgkyD+5XdJ6OJtq3zUR2AgADBjQA=
Date:   Wed, 28 Sep 2022 02:06:45 +0000
Message-ID: <CY5PR11MB6257CB33E1EDA90CE2B2F99D97549@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20220927135807.4097052-1-brent.lu@intel.com>
 <87ill8gb5c.wl-tiwai@suse.de>
In-Reply-To: <87ill8gb5c.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|SA1PR11MB5828:EE_
x-ms-office365-filtering-correlation-id: 99bef1ca-084c-407a-71e5-08daa0f61866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dLRu1UPWCV4uD1yWzGyCUSMed681Z/yTVcn6bxTgKJAUFV/8VQi6DJX1/ggwaaMPxNndnvHVezBJSkyIyh9UYcDTk7cDTnKkJfIiGtUOQXqqlYM6cfkEoVP+asfsw358vq/o7XfB+hCr5llAPjyG1/cadn1SIqACS8L93acs+RWrT8ji2rm5MT4VtltaL+I/U3ahBfEREDSVuccR4q0jrMdKTFmGbSPoxUcgx7dxHLENuuCXKvGoTna09qpFHGPvPN96uyokVeJRr4q9xZ/IO/ebWWeIimxOjjjxffGO+eeygvWVognn3lhOTpEoODxhiuX7qqHjQ9daZGa9Nm575mjkwj9rp7yYrza5nrGnQWr27ZPfxA5mwEmf9YsW5wDORlcTHoQRQeseOUFr057MU5sowvmzTY7MUU+HdS2+vm8t/gpfdVAi7iXrRlaZjaLlbtmc7Yaj3k4Wr2ecrpfuVaNlYSSRIfKVrotDuWrXN1rBaxklwxNEMl8kCrbd0b+QFuoTJPERvliOBZHNl4STf57Tko3Z/VcwDE7iD/9WgDcb41eY4Ri4ghKiEzucbMXV/44VNar7HA6RvNzvc4zOuep7Q3e731MwFzSTgUPGmM7ZxF+PckueSIy+0MxcYvoRZJInkC7HGvhtPiJuonIj+Q39GZvwtlT8UlDvtWxbzrUFoeT50FEpuPSKx+8VzhZysCdV4cCOkBa4UvJbKDN+JNx6ZXVKXQDAdlYai2M21sxV8tF2He0hLx/Ur5ovI/QpOYf+qZbquXWcn+zdEwI9/PMe4Eqf62mHexHk0xMgDlg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(82960400001)(86362001)(38100700002)(33656002)(38070700005)(122000001)(186003)(5660300002)(55016003)(9686003)(26005)(478600001)(71200400001)(6506007)(7696005)(41300700001)(83380400001)(76116006)(316002)(8676002)(2906002)(54906003)(6916009)(66476007)(66446008)(66946007)(4326008)(66556008)(8936002)(52536014)(64756008)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X+siVkxOtSQUuWF01XRxSxYjKdOC9oFSvzkOLpounx3PH6cTPpkAbLqv9c?=
 =?iso-8859-1?Q?tQF9z5AeGtVKcxxB+fhX1n6M27+4AJw2I6OpuBw7ZfVrXQiJkS/ReoKSXq?=
 =?iso-8859-1?Q?nD8LZ++s7sneXlENjKKnTfAx+wAy7SSSEE/zMrc5Qnz9ydgyuO6tzSt2hs?=
 =?iso-8859-1?Q?QVfBOf5+bdQEQqha1UjxcY82jtS1zUhl9LN48OkcxZnXyQHYg7qMH51Z6h?=
 =?iso-8859-1?Q?ghIsHE+Rr49lubgnEdiHviFIV8ClVm0XqSDI/FVKLrV2PyiWVAwteCiBM1?=
 =?iso-8859-1?Q?wehZk14XL6yfu4oxUPXyuczCyU8JUMnElZ38hlsolov0K/y3lTVeP/Djj+?=
 =?iso-8859-1?Q?ALpuIkLDsTLk0OxdKE4BioqpsK692ilv3uZ4l+DSu9WHuqJHiD5jFXbs24?=
 =?iso-8859-1?Q?zC0l8S7MTb14667FCMLBD3EeJSTRFn4wIiVcFjQuS6+HOktYdwNbKqNhKd?=
 =?iso-8859-1?Q?jBvzxEaayB1Xs3HTDgR89E+yYpDkk/IIIO/yUdk2KuGLH2uVd1eXAody3v?=
 =?iso-8859-1?Q?wNe6Mp10VL2IVbdWRkPXgSF4v9wnK7oMMBB1hempBXR1TUdvBdiyZeA92P?=
 =?iso-8859-1?Q?pWKZSQbVbwr6K1IAaXrfDw2JMx93q3lZ1k0x+KWRtsTpadNcvOkMucC61F?=
 =?iso-8859-1?Q?zFIVOk9/a+JODujOE/2/1iPEo/DYWZLH6roCucwEPlXAMPCrj51nI4OnJP?=
 =?iso-8859-1?Q?AtO5zicse5MG4XEXSMPH/nenrI/gYTKdnLALwr6yoG9m20xXE0dx9AXTuA?=
 =?iso-8859-1?Q?+sHr2B8FjJWY4hgjofXcHEB0+TARjbHvGTXiNysTCjniB/YcxdyE2tfrcS?=
 =?iso-8859-1?Q?7fuUwA+NnZeI5q9BjFv2IVc61g7AZmXnHng/BtO13GDu5w+XyAkB/MdYf0?=
 =?iso-8859-1?Q?VYD5d89TalhPROgfE7EEDYcqfKZ5g+p9JymL4OZ22r5kGq41sCEuQrm7rj?=
 =?iso-8859-1?Q?KeHNl4qwD1tmWV7W+Cyu6POPcT+gslqQwNZ/uBFsYO7qUq6atn9Pvgqs/C?=
 =?iso-8859-1?Q?gkgCWiJweoSV9fj/2ki51vX2smenLYY/ZnpIjOUDVhzoiVlnJD7U+PnYf/?=
 =?iso-8859-1?Q?M02JzayWu9om2XDc+zR4JwaZ8O6NqfGDpu6VQYJoDNmVieoglmLxJhZpkU?=
 =?iso-8859-1?Q?q11ttr6v7gYo6iSgDn6N/nPIySOGyz05IUOBJRpIGdUZIxdGJKW2Z/dm0u?=
 =?iso-8859-1?Q?uVEkVViq2i5++BWy0PbDT8zq+1zqOZyYhv9bzgwpkPQ83ITi2eN0way210?=
 =?iso-8859-1?Q?RWIChiL/zBVgxMJzPFKBA0nan4PdyRTQnmRldLIEFK7om9qBzu0CcVbhL5?=
 =?iso-8859-1?Q?SLLIO+JoofJMLH4tgZaT8v3or2ReaODV7BxEcA7fLQBk0MfKroC4GneHCZ?=
 =?iso-8859-1?Q?y29wcAoh7MGTWXj/R+C3BnVzakcYJzbtQ7AssFEahH7jGQDoMFwScAavE9?=
 =?iso-8859-1?Q?nBsuvvxDlapma8x/OclLnlAB3Ln0mIUCAxpLmPsUAJckPyvI7RjjCt8iq1?=
 =?iso-8859-1?Q?OQ0tch/uNBe1zvibyw0nqi/d6MId2y4ng+QPl0lqT5/3TeqCyXvXIrLgBH?=
 =?iso-8859-1?Q?AIVdZniOXu5cvt1RiUrUJjK3Q+r/Gh45atuLyIeh00Lu0s7rPG6Iljqtwp?=
 =?iso-8859-1?Q?soDB1Wy8qpcIARAvvVAYhHATaJHfH+L4ou?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bef1ca-084c-407a-71e5-08daa0f61866
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 02:06:45.7487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AinFqgkLHxqyPNkx5R9m7YxDMmlctNFatJH0jbcK4o4UxSNZ33d6KXnO3zaUhmqR+venwtPNYHn/cA8wlv1PBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > During resolution change, display driver would disable HDMI audio then
> > enable it in a short time. There is possibility that eld notify for
> > HDMI audio enable is called when previous runtime suspend is still
> > running. In this case, the elf nofity just returns and not updating
> > the status of corresponding HDMI pin/port. Here we move the eld nofity
> > to a delay work so we don't lose it.
> >
> > Signed-off-by: Brent Lu <brent.lu@intel.com>
>=20
> We have already a dedicated per-pin work for the delayed ELD check.
> Can we reuse it instead of inventing yet another work?
> More work needs more cares, and better to avoid unless really needed (e.g=
.
> you forgot cleanup at suspend/removal in this patch).
>=20
>=20
> thanks,
>=20
> Takashi

Hi Takashi,

I've checked the hdmi_repoll_eld() and check_presence_and_report() function=
 to see
if we can reuse the per-pin work. I've some questions about reusing the per=
-pin work:

1. hdmi_repoll_eld() calls snd_hda_jack_tbl_get_mst() function while
   check_presence_and_report() doesn't. Is it ok?=20
2. snd_hdac_i915_set_bclk() is called in intel_pin_eld_notify() function. S=
ince it's
   skipped, we need to call it in the per-pin work. Need to add a flag in h=
dmi_spec_per_pin
   to indicate this situation.
3. We can schedule the per-pin work in intel_pin_eld_notify() when snd_hdac=
_is_in_pm()
   returns true but there is no guarantee the runtime suspend will finished=
 when the per-pin
  work is schedule to run.

static void hdmi_repoll_eld(struct work_struct *work)
{
	struct hdmi_spec_per_pin *per_pin =3D
	container_of(to_delayed_work(work), struct hdmi_spec_per_pin, work);
	struct hda_codec *codec =3D per_pin->codec;
	struct hdmi_spec *spec =3D codec->spec;
	struct hda_jack_tbl *jack;

	jack =3D snd_hda_jack_tbl_get_mst(codec, per_pin->pin_nid,
					per_pin->dev_id);
	if (jack)
		jack->jack_dirty =3D 1;

	if (per_pin->repoll_count++ > 6)
		per_pin->repoll_count =3D 0;

	mutex_lock(&spec->pcm_lock);
	hdmi_present_sense(per_pin, per_pin->repoll_count);
	mutex_unlock(&spec->pcm_lock);
}

static void check_presence_and_report(struct hda_codec *codec, hda_nid_t ni=
d,
				      int dev_id)
{
	struct hdmi_spec *spec =3D codec->spec;
	int pin_idx =3D pin_id_to_pin_index(codec, nid, dev_id);

	if (pin_idx < 0)
		return;
	mutex_lock(&spec->pcm_lock);
	hdmi_present_sense(get_pin(spec, pin_idx), 1);
	mutex_unlock(&spec->pcm_lock);
}

Regards,
Brent


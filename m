Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35126EDAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 06:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjDYEjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 00:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYEj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 00:39:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC047D94
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682397567; x=1713933567;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=S6WWvRwCD0e0XoSE0cljXpKpggQYkFh27yOwWEvEsTg=;
  b=QK7B5pXxpo8Bxmr5GA6BxBwYZtFvbQUvWWENunTXTFrBumlMvdrlzx2W
   B2E0/PqoI8KZBHFr58cVAYtWxU2hIPRO3uWylyF21WT1l6r9omjq7hND1
   EomaLHdcRZf9F22w8XLWfPCGVGGmOEKRdlyiK6DDCkt+we4pS7tKXjwWg
   SKqRHgR6VmUeJxhInY4aTX1sh/kLQ1VqiGMLy7hRjlCDWHMTT8WC/9XYN
   eUMdG36IqXOm6YAdANFyPmj7jyXG+TedrQzdGw3O3riZhghueJlSE8qBR
   zWeF/1cGqDgT8FA1xbPCztkC7Cy+rLhxtfbTmJEU2iJ7IxbdZ6EzRiIT/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="409590388"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="409590388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 21:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="762718244"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="762718244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2023 21:39:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 21:39:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 21:39:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 24 Apr 2023 21:39:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 21:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsGl3tcyjBGtZG1AMNOPrUbOlMK2P4Yhz9CUb+7QDn15Zm7J18b/It9uqGHSjbxAcaBWsqYykxUvIKMZAfGbLOnS9f5+qxaMR4ylIvL45s3aDV/vCFzMqjprYRw0a3I129DMXb8p7VuUqKC7e1dTkqR6/VaIt4Oir0bsF10pibM9/adDxDnWSgkK5uAJYNf9jkhyvYKQOekIGu46/i1dB2Dg43YMyOyQ/cFGBwYUSe22N87lqhDEt88m0pzvgrxNdLNWcUjSyEGHwKsALzpfxSKD2RjvdqM9h9QVYmRCGo5Ca3IKEUoAn0QWZQwoHb1PlkJcmADZWPjayovlD7XFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfzP+OdhIyANEnoFww+t9Pmshd5wY564vLBWGXa8BHk=;
 b=fSfAwk+FSIb5Z+WfqLiZz4spLVSDG/GyL13SHPEktPtfDwLbbdJdXWkk9YmiCW3o6gH+mPQzaONmS+Upfu5xMFO4SGwoM1HhdpTY6upkuLcle3GK+UnGOyglXFqVAlM250QDsZrJul8aQaTeKKdNGEg/ZX3ZXPIbkeY9O3UqtfgHbnIJvggRhPVBKgAly47QAHVDO7Ji2YOKO8KqVNSdXhCEWhXi9ClfDqohN3u/3s8YOCYtoK1/F0jqUfJDIArO1KO3LNw717jHkACxbokgtLnnslf3w7+7IN1dPQFzV5SZ1eo5FiWEt5cHUW619LzfXYQMGqEdKg8LG1TKyqbkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 04:39:24 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::377f:416d:7be1:8f9a]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::377f:416d:7be1:8f9a%4]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 04:39:24 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "kilobyte@angband.pl" <kilobyte@angband.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Thread-Topic: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Thread-Index: AQHZderH+wsq6lIxj02Y7iezAU/Pd687czNQ
Date:   Tue, 25 Apr 2023 04:39:23 +0000
Message-ID: <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230423135124.55196-1-kilobyte@angband.pl>
In-Reply-To: <20230423135124.55196-1-kilobyte@angband.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|CH3PR11MB7795:EE_
x-ms-office365-filtering-correlation-id: f701eb44-8bd6-449e-8dd5-08db45470b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciDWz3QPCj/g+vcRq222Ijq5HEUUGJElr4qoSl6RkViw1wgllOUOZv4P9jZ1bDcAftnnbnvkULokq+sZyo4ZKExsrrg8rjKm5174W8nR7wi8I1t6Ublbp0aNHtejB7MXgMq7Gt7477UyB5DRIe7WhrX4S7FXOWdBPx3Fqvx5QuMd5EefjI1a4x1NdEaSSL4OkAFivT4YitIDi/c713WWPoTNrViz4Rk2L+20VvBjk8SQXGwVkr0/DVWBBan9mo9+W+1pn5NbXNDX5/Bq7QyxWT+a4r/PtxeyKjomfjI3KouDiXdrlQFbjVZ1gNEHI3//AVqVIdJxiSC/e+8akzCG5NiexCpq6nmfbndtwa0fyg2Xrdm3828USysV8q1QthyySqHbwMvOCZhTAtcfDVspBqRmU5KbjlLV3V4nWpi7pz7PngdodX1KriB0FJlM1xW43huiWAxhNjiFaiWcaYf0EONGHjvDwgyQoWDa6EWSdAdgBOCIDWEiVhFbqZbLGtiChdW21j8Q+DOrEDGMUZ1Gh4ta48C0yF3dspdqCro3rQjc6UO2j7XC/9DfXCVlwz9kXAw6FAUJnyHL1oHOV08R++9PY2x+4nEgE/qAMUK6yqI6jbiLS5/ut43UrcJS3Dfu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(110136005)(38070700005)(478600001)(82960400001)(316002)(6636002)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(55016003)(122000001)(41300700001)(2906002)(8936002)(8676002)(52536014)(5660300002)(38100700002)(9686003)(6506007)(26005)(86362001)(186003)(33656002)(83380400001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uJFXqoyrMYqixK79W2bFsmlBReyc4Gl5LRgLWYsd5Aui7sj2A192qiNEmF8r?=
 =?us-ascii?Q?5WIRGIkkpHfa+LFwEMsQQN51lbqhosCoCjWp/JCIqDHobX6jQskUFFhWgGeu?=
 =?us-ascii?Q?IdyqE8Iud7Zl5AgbwpLsZSYvp5iD55MLRIUAw41xYPr+sheraySg49zdqrdw?=
 =?us-ascii?Q?puBLXiCf7jrXDroHgaRIn9ea1YorP38Myfk6rCMSukEnT+4g0QCI2E3nmw3U?=
 =?us-ascii?Q?nCuJ3mDryx+bKAGBjcC+uIureKMg8JIQbbjCFhZTgVhYYFuog17XeV+FKaZM?=
 =?us-ascii?Q?2U0AL3TwmaziNRkl07V+h5lcrlI45UkjzYqssLzj9bUtSu2D1wLS95RdWwbZ?=
 =?us-ascii?Q?KX7GRRBQiCQ4MCFi60oYV+8eq+eeyxCrG5iEePT0UTZ8iellhCOlZgOZ/S6Z?=
 =?us-ascii?Q?VS/zBzzQxLbc5QTVXhC2ZNCtNyS4s2u24sogpHFBfF39/gpFXNXVTYVOcY+G?=
 =?us-ascii?Q?P8o9MRe/2ZexbH2JEDysw/wgfouR4xIzvsSlVeaZvZw+zvlr4nKO5eqMI2op?=
 =?us-ascii?Q?YajsjCbbqMQGP/rTSz2qxoThEVLyFkJi9PdHESnnYE7zPxGY1YkW47x9enyZ?=
 =?us-ascii?Q?z0P0gavwzAxWKvyh70WqqDBiBJl3IYP/p9j6GYJktgI9is4kTLcgis3jTk5i?=
 =?us-ascii?Q?kIm4Pg0puqpxgvXMJuW0gTLcI5QBYV/b6mdl4E0/6wK1FV7MUKIWST9kLdd0?=
 =?us-ascii?Q?RFoK12Zs71WGOkRli1AQrdQRaNwLbKwupZ62Eysh53EXSGwK6ImkJjLz6zm1?=
 =?us-ascii?Q?IkFo5C6rB9L2mK6/C44cNL3VNvrRgdxaTLzckeqg1kIFxaARL3E92B5gLHe1?=
 =?us-ascii?Q?is1BnTZurHz5b5GNic1WtKhOld7I53MPgy5/sQjAtEFXWlRXRxxY1dic0CPX?=
 =?us-ascii?Q?GcM0PIA2/WgWX8JbE3jNOgOo5u/ldUvlZJAMy9L1yiLPCtiN/XSxXoOWqJem?=
 =?us-ascii?Q?sOO8flylPYtzqqgYLo2IuMRuuaNYD34bcleZqTiGfKNl9WmZdRCI8FqohmJG?=
 =?us-ascii?Q?e0QVLHxSCwwlK7nzqPuMJQh2ngA42KdsBstkbmR5QvDLyrHLAIgkSWILwYyr?=
 =?us-ascii?Q?1gIjfly2j6N73jPY+ZRx3KrbFDpVldqndNzHicnONciIIAHlqaNpBzm+giij?=
 =?us-ascii?Q?O+B4ku6l+3X8OdBB23UCVW9oxzdlcsGEwnUIzFeQj7yHCUtXtV680p6ox0zn?=
 =?us-ascii?Q?wi4YSdPiWGEFaEyr6PrJQjDmpRRKaa+9EW1B6Ykt+I9B1uWg3zcrEN+p9jhN?=
 =?us-ascii?Q?S6SeN1ep0Vw+aOEjvMYZKMAUoKoY9bQg5psojln4qqzoFKTsBHwQVw0GsEdV?=
 =?us-ascii?Q?IV6uw6TuES4KpVJl1VGsk51uxzbAEUtMnz17TWAfumwRryZsmMwzYUMcd/MQ?=
 =?us-ascii?Q?l1O4xx2InVvcZzqZaMRpZDg3YOaLXGPlt/5a3GVLJr9xporiz+AkG7enL2Nj?=
 =?us-ascii?Q?n64f4kyJbk/+bvnF+F+JkYdZWO7Rzi4YHCUWIA0M1h2ZP2T1iIHDS5NudLu3?=
 =?us-ascii?Q?PWfEHUbdvh6HHP0aP+BTRWrzHDAbkDbUo6cvhuHIxRPdZkYz93t3VP/UOLRh?=
 =?us-ascii?Q?5Vl24eYg0S0wTiaeAsyyHG24kk7QTOekl0JVOkpm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f701eb44-8bd6-449e-8dd5-08db45470b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 04:39:23.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC8df68S5Bnj8wruf9bGFEPH/qJ1i7ysv/0rhQJYFGQMcOiCrGiSjkVNzZrQ4t+8mxIGrB+MeUKXE6GZvx7sgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What is the exact issue you are experiencing, can you add the error message=
 this fixes?=20

>=20
> From: Adam Borowski <kilobyte@angband.pl>
>=20
> All other MEI configs do so already.  This fixes a Kconfig gripe if I915 =
gets
> ported to other archs (such as RISC-V in Intel Horse Creek...).
>=20
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  drivers/misc/mei/hdcp/Kconfig | 1 +
>  drivers/misc/mei/pxp/Kconfig  | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfi=
g
> index 54e1c9526909..83e67771ac6b 100644
> --- a/drivers/misc/mei/hdcp/Kconfig
> +++ b/drivers/misc/mei/hdcp/Kconfig
> @@ -4,6 +4,7 @@
>  config INTEL_MEI_HDCP
>  	tristate "Intel HDCP2.2 services of ME Interface"
>  	select INTEL_MEI_ME
> +	depends on X86 && PCI
>  	depends on DRM_I915
>  	help
>  	  MEI Support for HDCP2.2 Services on Intel platforms.
> diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
> index 4029b96afc04..95f2c2470d28 100644
> --- a/drivers/misc/mei/pxp/Kconfig
> +++ b/drivers/misc/mei/pxp/Kconfig
> @@ -5,6 +5,7 @@
>  config INTEL_MEI_PXP
>  	tristate "Intel PXP services of ME Interface"
>  	select INTEL_MEI_ME
> +	depends on X86 && PCI
>  	depends on DRM_I915
>  	help
>  	  MEI Support for PXP Services on Intel platforms.
> --
> 2.40.0


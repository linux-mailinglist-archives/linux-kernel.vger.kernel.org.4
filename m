Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650B86A5317
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 07:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjB1GgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 01:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjB1GgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:36:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24646A0;
        Mon, 27 Feb 2023 22:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677566168; x=1709102168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xA1vjfByi9dc009ANdz7tQ+zCh4tlogykAcEZv8g7dQ=;
  b=VoaoMxheVlS+IeRXJgdpvZTPwR9At3bcX+2l9wWhyXRP8lDmARHLSJ0r
   yyRbErj5JdtQKtsT5S4jTNLRxXBxy2cI++HSz/1nbaRlgijTVIEtGMQyZ
   Kxza7V7Vn939/AzYs0Wfbpy5AMRSIl9RBW7mbzuT481gQVBhvTpPcVUhc
   riaYRus86HhNlXe6Di1PMRU7h+DjSzNG2XwBABk5FYU+dYOn7kw3l/X0m
   aTexAX6BEEL8qXiibtmvN6LC1CVAnwFE39AK3LxnWKnAcokIld9YF8gRp
   ghuiGDyoo5XaMNoAYAcwG9hzd7vrltjF5jRs1lEwW5MjF34aobM/S9euJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332785733"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="332785733"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 22:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="763054775"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="763054775"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Feb 2023 22:36:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 22:36:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 22:36:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 22:36:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 22:36:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av57GrGbsBOEc8MurJQV167JFyqZRxCqNzegQTmnKQGe/K5pFu7I/jMqB1xm0440iW0RyPAXU5SGJXr3DBKncwJVVHt5fxsRRn+PCXQLb0OFmObuRO1v/ZR5ish1xsR1hWY0FboM52/5PJAplk/notfYft6dtfGPGHj3m+haThxkPUKfeEFXxY88D1qoENSuTBDXR2J3tgTMs8A2wDfkr5uNwttZG6zwpdqKM1rjSz2NnW2cQcGfAiZ62jOP6f8RXk80YasLx6MNsgnGTzVXlbdtC8IBYE140li25+lb7zQQ1hnGh5BwW7gsu54WcMqspZUUSMd55RzdI/hDjhdbFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA1vjfByi9dc009ANdz7tQ+zCh4tlogykAcEZv8g7dQ=;
 b=musSV2glDwDu9/HMbccPqP2oEp0pUIkaiRAU6+1du4FLkgnWo7Fv8sm9WN9W2wkz94Ub1PEAgJHlYz8fB3aF8JUubfn9uwD2k/+EUZduE3v1CagsX5zqOgKlI3MuP0uyfrjjQ8ksJQGAY+ePXPuEZ3E+s9AKUz8sR8MdhsKlfk/XqLA6MAEZ/mmrbEjSYKT4rIZqpkE7QQgaTkH5jkxKhaq5CZIZsa3sNAeJOrjeeChnqbDtmRgfEscOnN2V5+whN34a+6ZM0r3zqRrIJIiSSO97wpBosI6jPfSW8Y/kiVXp6qP6ARazO6XNh4xyB8jSeOvKo/WDwbFjPHjFl7/5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 06:36:05 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 06:35:41 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Topic: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Index: AQHZP1Hum/btr+ww/kiynrKipZgIc67OndeAgBVeV6A=
Date:   Tue, 28 Feb 2023 06:35:41 +0000
Message-ID: <DM6PR11MB43169FAE93274F64AA7E06F28DAC9@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
In-Reply-To: <Y+uxbQi7seGf+adP@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: d394c9d5-d42c-4dff-4b32-08db19560366
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMZ2AFPHHFymnOB6lHwBDl3kAch/rOMCdv637wS/nh6zxSnfVs2ZeaskM7k614HM2lnoL6+tO2EFz0m1wBisYla8fWYvcmWcYoufpXxVcvMoYc3p6HIAfZiGgjtbmtJe4cfFM76n4BJ8SVEtRbBjs/YKn9BWnpUDiPwCuqdsBMn9p4YqH4rXxIb3m4dU1JHyQBi+aChdHokFVaemaEmh5GPU9nlwSDtf6wtPbShTVrWdjRuEl9sjXZne4n1Osrw1x16m2+JNvGQ8fRFv0UAVZvfedDw5GPLR6VuOhCTRc899xvmlUJC5UU/6xEHcHG4ZCycNoOY7/4OyKvf4yR7cPfvDYW0Krv9dX0ELLX9YGkp585mOfHH0FfT8S0l6EiTyPsQPu/v5ZjyKircZebBJ2/gI85at3FjRwPwNDMAhaYNBt6epJbXMdss+Nu3ilQn6eTFpIVD6pmPI2tPl9QuCIoRhlTktBh5bTQNu8oNzgssvj1CoZs8G563SpF+d1VwhdqwhsmnIhkukyXJKijizcYYDq/DkJcs9U7+uBXv5G8QrE/ClS73fnuW7aj6j8BMc/khIbROaUroXPBQ2+kF6Fc8wPRj+icLujCGe6qlrYjLFh946d1aWWbh8FBzn3BOUP25x3F5lyonDHohcb4PzOyNYyJpUNwfA/aYaoiLTypF3+h77dR4iYHte/fgrIvNyzhNOJFNApWEL3z2wBNRu9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199018)(66899018)(83380400001)(66574015)(33656002)(54906003)(316002)(478600001)(82960400001)(38070700005)(122000001)(7696005)(26005)(41300700001)(186003)(71200400001)(9686003)(6506007)(5660300002)(38100700002)(66946007)(76116006)(86362001)(52536014)(2906002)(66556008)(8936002)(55016003)(64756008)(4326008)(8676002)(6916009)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l9f0W3Bam1CWw5q5I6RE5liW+eEoTEDeKNrqSHp2GbpY2yCVLKqghwHpkpZa?=
 =?us-ascii?Q?d3PGLfNLysdIXJCOrz10e0KosG+H+PczcNwqLdg41nSbvKao+U2bObzhcCg1?=
 =?us-ascii?Q?H2zhGOYCGI42OuxNVDoav9O9v+Mprj9N6ueriKPQLjUhogjFkoVifUFXJXxc?=
 =?us-ascii?Q?X9Kz09/E/zUSNa4f2vrgq8+vRW9rPMK789L3g4MWRCzytfyAd4DIYKVgcSxd?=
 =?us-ascii?Q?+2to1mkpCZvQKAaaya4nYik3c3DIWLK8XGn6uZRomlslslG3iaW0LXKxtQh9?=
 =?us-ascii?Q?7o5Slu0grdFFJjwGdX/TB3TPkC6FVyfXJszAnw7aK6pa/VvjPTubiB/sj0SE?=
 =?us-ascii?Q?84Po9HYoq8QDSo9TTx+Crs1jCeGiRIQP6n7JUNPUjMAzav433mRjGYS4/C2x?=
 =?us-ascii?Q?geZDIKHEA1vae5VYspkyd1hPncB6zhXZlUXb1MB0z7n/ieIUNLGNvi/XG4p4?=
 =?us-ascii?Q?36fes62PBL7PgjmPcerlR/YB+9lMLL5028k4XFwUtpsJZETZpDM/4Ll651xE?=
 =?us-ascii?Q?dZ5xt72bkmdsa+N62PjZ33W76SrtkGyIhUj4uLmsSr4orqGCJYaDIV59s4uZ?=
 =?us-ascii?Q?W9NTlMbfoVyyTcQ+lLvW4/HoOZzsi+sKhiy3cxDELZUw+xYPvyZXPrAqZHkd?=
 =?us-ascii?Q?Gs8xhSkfq9IAubAWVMgt72nWa8ImPYzeJL/5F0gw3g3LvFSqokkLnbvc38XA?=
 =?us-ascii?Q?DWeAUtGAiT8g9d8FVgeIFxPX0+XT4hBmy9BydUnishzFVT9q1uu04XX3NFHt?=
 =?us-ascii?Q?8vculjgKAWO2GjTi3c4cw/8IGCSemnUuhc+WKlqGoBW6kwJ4GWMcgtKOuD8e?=
 =?us-ascii?Q?FYcCQzi1hvDTpaLCtSZRX9IOCF61/Zy3LwYOeW17ZiaaeYHjn1i/9PIqdx97?=
 =?us-ascii?Q?7ty4ccuM2z+v5vwBghQxHK8qy8Dp2lUdOGGM0p3r8mNRkYbwZjhDe6WY/fFO?=
 =?us-ascii?Q?6HlEpgfEUfCJOY1bZQ2lSpWQg+FGmbkgGSkqpGf3EFvsgZ804NrJOxQG5ymC?=
 =?us-ascii?Q?+OQrUUkxQqWNoPP0TRreUNjYRJC9fHa1O0t91BjRhYPfUy+eJWWlXqXjlMZD?=
 =?us-ascii?Q?0zhks7/YM1GYwNjAL09sVXtiWhY17rMq4wzvW+rknf+R9Wi6eKVOIXIOgZDu?=
 =?us-ascii?Q?eWUczCZCLITzLmIDat3TBYcDCTtqbburJZMKXPTj8UN0srWAB3ev59fEZ/i9?=
 =?us-ascii?Q?r6YJ4r0bpCiFFjDECqWdA4yYTn979fieblMeNz4vJRPhkEOKPDjvuMUFpe4Z?=
 =?us-ascii?Q?6YarocM7ZdVUXf8vv1d3BdXGcj2nr76OLVcE4et1Q1ksQ/IjkVPYu2YHZLbc?=
 =?us-ascii?Q?4UOmPDh2PVNqsBezb04OahIh80631YSaBHsNf1QYyrMKEJZeIb8d98rNCHfy?=
 =?us-ascii?Q?PKhQNzmwpE5Wj3SiRv5f2tFs6Yy6Ic3MxhWRmmcxOzu82TZ0Kp/FAWavlgBO?=
 =?us-ascii?Q?JaCC6NR8N5rlP/YpY0qfM/FgccdnPaZ5y84lj7ZoSgzI5whYc0ZpCDJsBM3q?=
 =?us-ascii?Q?OSq2MoDUBHMz42e+6C1rx3ROsPUWwfhBIqm8knLEKc8rAvulo7boaz0LHCfX?=
 =?us-ascii?Q?ho7qQxG0QJb4SZXHGy6A2v2nUpdDtXt7kW9PGAHX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d394c9d5-d42c-4dff-4b32-08db19560366
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:35:41.7662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2koSEh1mUsjwlB+MvUPv19kVrmW0kjO02cKCuSOgzDZrfM6LVtqE+n2kBC4NgvZq3THlxLAyn2cgomjLuTLQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

few questions as switching to v4l2 sub-dev framework.

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Wednesday, February 15, 2023 12:06 AM
>=20
> Hi Wentong,
>=20
> Thanks for the patchset.
>=20
> On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > IVSC directly connects to camera sensor on source side, and on output
> > side it not only connects ISH via I2C, but also exposes MIPI CSI-2
> > interface to output camera sensor data. IVSC can use the camera sensor
> > data to do AI algorithm, and send the results to ISH. On the other
> > end, IVSC can share camera sensor to host by routing the raw camera
> > sensor data to the exposed MIPI CSI-2 interface. But they can not work
> > at the same time, so software APIs are defined to sync the ownership.
> >
> > This commit defines the interfaces between IVSC and camera sensor
> > driver in include/linux/ivsc.h. The camera driver controls ownership
> > of the CSI-2 link and sensor with the acquire/release APIs. When
> > acquiring camera, lane number and link freq are also required by IVSC
> > frame router.
>=20
> The more I learn about this system, the more I'm inclined to think this
> functionality should be exposed as a V4L2 sub-device. IVSC doesn't really=
 do
> anything to the data (as long as it directs it towards the CSI-2 receiver=
 in the
> SoC), but it is definitely part of the image pipeline.
>=20
> I suppose the intended use cases assume a single instance of IVSC (as wel=
l as
> MEI) but there can, and often are, be multiple camera sensors in the syst=
em. The
> decision whether to request pass-through from IVCS can't be done in the c=
amera
> sensor driver, and should not be visible to the camera sensor driver. Exp=
osing
> IVSC as a V4L2 sub-device makes this trivial to address, as the IVSC driv=
er's V4L2
> sub-device video s_stream() operation gets called before streaming is sta=
rted.
>=20
> The information whether IVSC is found between the camera sensor and the
> host's CSI-2 receiver (IPU in this case) should come from system firmware=
 and
> accessed most probably by what is called cio2-bridge at the moment.
>=20
> The privacy status can be a V4L2 control.

This should be a control or event? If control, how user-space handle privac=
y stuff?

For the required link freq and lane number, is v4l2 control the correct way=
 to configure
them? If yes, seems there is no CID value for them so that we should custom=
 some
CID value(link freqm, lane number, and privacy) for ivsc in linux/v4l2-cont=
rols.h, is this
acceptable?

Thanks,
Wentong
>=20
> Also cc Hans.
>=20
> >

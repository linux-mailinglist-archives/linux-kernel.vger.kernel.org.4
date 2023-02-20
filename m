Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69A69C710
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjBTI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBTI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:57:52 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F7F212A;
        Mon, 20 Feb 2023 00:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676883471; x=1708419471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zsOBz4v91L/qODoGbKu8Nf53ngCV7YRpLrqFAKGVgcM=;
  b=YrrdBpS5D+CWGsKr021XGADFWofcAJwjyIoln4hhOxtwxKLnD8NPOu7b
   PclsTq3EuS/t0jRwJNEA+v6SQ07DR53F2Yxrsz2ssnWvBbqDDQNe2l9H1
   GmRQfLiy43Ep3C42BV5H92y8ccq1zcNxBuQLR/h/BBba0e0wdDXjv1NiV
   M3lwPFcY8nZw3a7mFueB0vkJNnFHJm0320I7Rrm9kTiW4TOmRojSQmri7
   v3ygGjAXuaC9mpkePV+0oGVHeHbg8SYZVW7PD3sxPYw4AjAz0VuWLyCP2
   5ahv6fKIEOsK74j7j8Ub87dPVFtqh3MKLD4jAW337efiwvukvbXjxQ9x8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="394837518"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="394837518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 00:57:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="814065165"
X-IronPort-AV: E=Sophos;i="5.97,312,1669104000"; 
   d="scan'208";a="814065165"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2023 00:57:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 00:57:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 00:57:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 00:57:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 00:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLrvADOSDZwEqZoCYpCkr+OxBenpLpG3njZcbLfFUFOnzNbDAOXLdbU9PD6XU/xv1eZsob4CQOEsLefe8TEX8vQQLMHy5ZwQBlTT+hYJN9Adn78bea8gP54CZGi1aX+9CAr3XYlz4UEaH220/LQc11onkRd9wZPGcziB+JlWUjJKb8LcrU/aNzXeYOExsNORz43dXS2AvtdUCi3Vjq+aYIqFH7GzKfAXLJagDSdUxlCGOVFnFiVcIZKB3keCkwR8DoR0pJPfYi3inoRlwCzYZCN7L54G1lOwpi6KhEPpVyddoDe5M+iQUgEJhufHr5GCk6FoWi0wzdZ4OJ8efjP9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAP199SdaY1OnJv805YsIeSPQdqy4awG5EBA4HMJjeA=;
 b=ir+Yl/j3aL509zMjsNDHUJxha3fWUAcoOmKI4Zy4L1fSpX+ywDKLDcXmssIi+/VUMDiQv5Clx+upCRMVLX9RSNWQtz+Agu2yo/IKxOU0Gq25TsEpsEY5SPA7GjGm0BP3HaR6lEv0W5CqLBsyFrxV+Bi0SCgqS3b5wXwRyVcGT2kx9PR5uTFookcPyvQiwa2nmV0CqLis7jgwynFt1p5iWzBFqfUHGeg+++SlLVVH4h09YoxaVkjq3IvSs44lkCnEQ+8VkC1leo1OtgkFO47vpVQMbH12f6AN96z3/LWHoSB0dB7tmDWxPQcl7PPP+lzJ0VW6wxTrQHOX/46aqgDTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 08:57:47 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 08:57:47 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "Ye, Xiang" <xiang.ye@intel.com>,
        "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Topic: [PATCH v2 3/3] media: pci: intel: ivsc: Add acquire/release API
 for ivsc
Thread-Index: AQHZP1Hum/btr+ww/kiynrKipZgIc67OndeAgAEcQoCAAAvHAIAC4+MggABa/gCABDg8QIAAUUiAgAAFpoA=
Date:   Mon, 20 Feb 2023 08:57:47 +0000
Message-ID: <DM6PR11MB4316B3105394F258D8205DBC8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213022347.2480307-4-wentong.wu@intel.com>
 <Y+uxbQi7seGf+adP@kekkonen.localdomain>
 <0457831e-a347-8278-01fe-52c011759d90@redhat.com>
 <Y+ypwnRVwReIEjUo@pendragon.ideasonboard.com>
 <DM6PR11MB43166A8D4225C8460C29803B8DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y+9iwMbW0kk6eJKe@pendragon.ideasonboard.com>
 <DM6PR11MB4316A36ACA077501B92C1D0E8DA49@DM6PR11MB4316.namprd11.prod.outlook.com>
 <Y/MxGRrKsgVat3zZ@kekkonen.localdomain>
In-Reply-To: <Y/MxGRrKsgVat3zZ@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: 3e7eea57-c0c2-465e-74e8-08db132089ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOdhkUxK/LgpTvtaCFKcUcsfocdybSFVxPFt0T4nJ+uM2wBhsj9BObqaXzmz8SzLTyBuzVvw32uvjhJDoUgiTzEJ/9hyssbirEWg/WdQyNaNYbs5lMst5W1SB3KFguGPgRLScZ0rD4GzktQ7mzmBuXnIdu81RsNjG/O+yYEyD3ujoDBpw/PgJ2MJgGfgHViHJAa2oQi+yuUJ7djOoFm4ax8Bb39D5egwM4a5sSSdx+u/bFbpQAXHIhltrQS2aHmZhYDsY3Boz89LC/WLVX23fppAr6kzIu6jTaHHJpo91cfswXNcPKhtWppypzxTvwFU4bF5d+SURp3u/VqVt7XRGU8NR0Ob84atKJ2cetJm7t7gweR+6l5a3FiTI3elxe7Uv5zb84cO/lLHifM7fdkpbcaDr8NQqXWYCfO1P0IKA7xwKBwO0jhukzE8D0qFG75/FUa2KPHrphjG60fiINmpsXytxfuGexsxL04SCUU5hUP4PZLjAIBCKzr68mXRJhoWmNonNItE1npVaLcBvtWrhBJKPRdUqsOJf7EgyyMxwNbKrL2JnPSnF0fOmkPvZeuTi18QdpTJ7TTgfQcTmjmnJcryXo62Bznou7+b1Kw+1WMXpIt84p62NI/KDE7/DZL+BXhv+KWDlxzvipFcEBDtNftWbLUtyLNCkXVYpeXSF3hjZkAGVuJsE81a+8+iklNu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199018)(55016003)(86362001)(33656002)(38070700005)(6916009)(66476007)(64756008)(66446008)(66556008)(76116006)(4326008)(8676002)(52536014)(8936002)(41300700001)(5660300002)(966005)(7696005)(316002)(66946007)(54906003)(2906002)(83380400001)(122000001)(82960400001)(9686003)(38100700002)(6506007)(186003)(26005)(53546011)(478600001)(71200400001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dEEV/vpQgaAo+U3XuITiH/URuxMjIfjIdE+AxoH1fEteg5TbWXhF6XGLT6?=
 =?iso-8859-1?Q?jPalNOyj+zgGFl7nhdm4PG/P5Wt872p7bUAX1IP4c6TYaYZLi/cqfehd5I?=
 =?iso-8859-1?Q?9IRBycqptbsVshrLP4Y3RP9Hh4HHArBMHmk7EMwgduM7lyq42cV4ZPAshm?=
 =?iso-8859-1?Q?IaVuc2Xfc+ec6FtWGlqvxVw+LmPlPEDKzZoJmyo0zqBRjsx5y+GvIHf5v/?=
 =?iso-8859-1?Q?/YfRXkgaGC0awYiMEJIujiwse7RVgE7Cc/nDilsAxI1DG8Bg02wCg0UxgM?=
 =?iso-8859-1?Q?Bpszs78m6KhrHRKa5djsoFX+PHIuQaPY0LRPzWBXRea2sIXcEOwccKQr5T?=
 =?iso-8859-1?Q?U/B0NOIRH72CwIOc4N+b435QZnDo6yyQaI0yafkstiSdpGp2AH5apvAnId?=
 =?iso-8859-1?Q?Pgunsa6NBvorO8N6KbE7QboeUYtGIv3oKG1V1aA375T3wfREdrAz9NJgfS?=
 =?iso-8859-1?Q?JNx58XZMmyTifqy/sQvo65bC6WDxMhZVIeJnINYegxYKUbr9tjih7vZIS9?=
 =?iso-8859-1?Q?dYGyCv8m/JHJ1X8DPCrWEyqH5TgMPxR1bcuAKhT/RvPy1Pl/TGf9KAwAPh?=
 =?iso-8859-1?Q?bepk7+r7qLI2cdw/ViRwwqiNPLD+H1T5vI/LIUwqEtbt2FZFaX1syngdGA?=
 =?iso-8859-1?Q?U3Yf1ho4NCSoGJHEwr9SoKdLxh/bwic+cs8iZkvSBCw+4duRy+yatw/iZ/?=
 =?iso-8859-1?Q?Z6PwABbOtxWWkb7wHiSsr2P0WZHo5KdRsaAsd6Ia+Pb6FiNbdBnlDZADVd?=
 =?iso-8859-1?Q?zYy9Qxc3x6mhfQIa8j8gUUxfCUOC7phV8AGxBmyyOICa40VgXnIjMdn/ZV?=
 =?iso-8859-1?Q?t77mExuPcF68VG83zPpvctIyS6NNNSyDkh9xQ8qUjHtxIbybp/cVqEa4Qt?=
 =?iso-8859-1?Q?CV0ZrDYyYPtsu89l7vJBO5Gj3RAqIkmY87MfLBctKNg2I1jn7VSvpqB5Lj?=
 =?iso-8859-1?Q?cyeGL4FEQF+9h6fuzOb3u5zYBgWydSU8/nEc7M+fePxsPZ5kzy7UAs9tc/?=
 =?iso-8859-1?Q?H1IJ4NhlyydSyaojvVSMVqGplaz7I+IeTXW/YCzwxT3QEHwYljozlF9wNt?=
 =?iso-8859-1?Q?kY8rJm/4AHFuUaS9mp7jtf1riMATyWUPizNWJ0E7jp8bdGdOnOIc9SQlyY?=
 =?iso-8859-1?Q?N7QN0YinbDLwT53R0Yid1M+1LAdMO7GDk+Fb6CuDKso9BAGxIsPyTa29hE?=
 =?iso-8859-1?Q?xij0AAWClLz7wCKLyexLT+CDikvykL92fpYOWl54baaa8LetmFk7TgJUUs?=
 =?iso-8859-1?Q?ru22fNqFRdc8t1gA1HYBso5nDeXCnmg8/O/G77/fGcLV5kqvhgOM57cB7U?=
 =?iso-8859-1?Q?sE4EJ6Kz+8OoErIhEmqiMXOaL2IxwWMmEyggOZoC+OdTqVkNPoYqEHtqmX?=
 =?iso-8859-1?Q?35i4vHwea31tQefUtS+nhGBxH29RoMFMdhgWpb48UfQJyNvpzaCdduDWNF?=
 =?iso-8859-1?Q?Ss38RA8THxXHCKORu+5mZFRDWArVVw/NN+tXre1sNIq2V9SomkPbampKMo?=
 =?iso-8859-1?Q?RCYwBEcKgjoHVrbQSrSgXYWKpOluikAYw9Z3K+3vRZQZebS+0JlbPoGOgC?=
 =?iso-8859-1?Q?jNSAKKM67h4qUFS+FgHYQOPtmSdDtZbXIz0xwrGDjz6z85jlfZRdbLZjES?=
 =?iso-8859-1?Q?4CWpVN4CtVTMOqFPAxEN6igne3Cb2tTvti?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7eea57-c0c2-465e-74e8-08db132089ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 08:57:47.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1H9381Pbxf5LDNrVGjDiv95ErP+p96g7RxdaU0/hndFPQB3q5p7faRodhRHr0KYWVLqW43uha6shRlN4+eN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> Sent: Monday, February 20, 2023 4:37 PM
>=20
> Hi Wentong,
>=20
> On Mon, Feb 20, 2023 at 03:50:55AM +0000, Wu, Wentong wrote:
> >
> >
> > > -----Original Message-----
> > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Sent: Friday, February 17, 2023 7:19 PM
> > >
> > > Hi Wentong,
> > >
> > > On Fri, Feb 17, 2023 at 06:10:22AM +0000, Wu, Wentong wrote:
> > > > On Sent: Wednesday, February 15, 2023 5:46 PM, Laurent Pinchart wro=
te:
> > > > > On Wed, Feb 15, 2023 at 10:03:29AM +0100, Hans de Goede wrote:
> > > > > > On 2/14/23 17:06, Sakari Ailus wrote:
> > > > > > > On Mon, Feb 13, 2023 at 10:23:47AM +0800, Wentong Wu wrote:
> > > > > > >> IVSC directly connects to camera sensor on source side, and
> > > > > > >> on output side it not only connects ISH via I2C, but also
> > > > > > >> exposes MIPI
> > > > > > >> CSI-2 interface to output camera sensor data. IVSC can use
> > > > > > >> the camera sensor data to do AI algorithm, and send the resu=
lts to
> ISH.
> > > > > > >> On the other end, IVSC can share camera sensor to host by
> > > > > > >> routing the raw camera sensor data to the exposed MIPI
> > > > > > >> CSI-2 interface. But they can not work at the same time, so
> > > > > > >> software APIs are defined to sync the ownership.
> > > > > > >>
> > > > > > >> This commit defines the interfaces between IVSC and camera
> > > > > > >> sensor driver in include/linux/ivsc.h. The camera driver
> > > > > > >> controls ownership of the CSI-2 link and sensor with the
> > > > > > >> acquire/release APIs. When acquiring camera, lane number
> > > > > > >> and link freq are also required by IVSC frame router.
> > > > > > >
> > > > > > > The more I learn about this system, the more I'm inclined to
> > > > > > > think this functionality should be exposed as a V4L2 sub-devi=
ce.
> > > > > > > IVSC doesn't really do anything to the data (as long as it
> > > > > > > directs it towards the CSI-2 receiver in the SoC), but it is
> > > > > > > definitely part of the image pipeline.
> > > > > >
> > > > > > Yes I happened to discuss this exact same thing with Laurent
> > > > > > at FOSDEM and we also came to the conclusion that the IVSC
> > > > > > chip should be modeled as a V4L2 sub-device.
> > > > >
> > > > > Agreed.
> > > >
> > > > Thanks for your quick review and conclusion, I'm fresh to media
> > > > sub-system, is there any convention that I should follow to
> > > > upstream this kind of v4l2 sub-device driver so that not too much
> > > > back and forth?
> > >
> > > This is a tentative proposal, as I'm not very familiar with the
> > > hardware
> > > architecture:
> > >
> > > - The subdev should have two pads, a sink pad connected to the camera
> > >   sensor, and a source pad connected to the CSI-2 receiver in the IPU=
.
> > >
> > > - As for any new driver, the subdev driver should use the active stat=
e
> > >   managed by the v4l2-subdev core. This requires calling
> > >   v4l2_subdev_init_finalize() at probe time. See
> > >   https://git.linuxtv.org/media_tree.git/commit/?id=3Da2514b9a634a fo=
r an
> > >   example of a subdev driver converted to this mechanism.
> > >
> > > - As we're talking about CSI-2, the subdev driver should use the stre=
ams
> > >   API that was recently merged, and in particular support the
> > >   .get_frame_desc(), .set_routing(), .enable_streams() and
> > >   .disable_streams() operations.
> > >
> > > - I don't see a need to support V4L2 controls in the subdev driver, b=
ut
> > >   I may be missing something.
> > >
> > > - The driver should be validated with v4l2-compliance, part of
> > >   v4l-utils.
> > >
> >
> > Thanks for the detail, but I have one more question, during probe of
> > sensor(v4l2-sudev) driver, it will configure camera sensor connected
> > to IVSC via I2C, but before that it should acquire camera sensor's
> > ownership from IVSC, how v4l2 framework guarantee this?
>=20
> Please wrap the lines at 74 characters or so when replying.

Thanks, I will.

>=20
> Do you mean accessing the sensor via I=B2C also requires acquiring the se=
nsor
> from IVSC?

Yes

>=20
> --
> Regards,
>=20
> Sakari Ailus

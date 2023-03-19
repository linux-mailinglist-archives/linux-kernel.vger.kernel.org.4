Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9326C01ED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCSNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCSNJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:09:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B08D72AC;
        Sun, 19 Mar 2023 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679231369; x=1710767369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xa8uXaymSMmCVGDvBqrtrDcfyZ36++aKengDSXWT0No=;
  b=kuhvgs/gj5EPTfPdvlIFIbjfB+L/SKt/+hW4zEPQljUKIpY8tdN8Oset
   /yE9lz0zJbFXjqYN371e3ox1/7IoOdFdB1jJpkgr4Ww1r693l8mErILlM
   r1gXd5BpEMcguMJx4NYXkNxd0VBn2Qwq7RQo/L+CZsGoCcQYRSKuC0rvG
   ZSlsM+dHgjzHX+9/bcmsHXMEL6eeS1YnROfHZZKL8TvqPOThFCjO15eOs
   O/aFT2lzhZGv3o2wUNCSB5CcTCAf17RTDhqoaLKkaUY8US660tWE0hAZ2
   DDzd9JScU/qLMcwQBsXH64X5aWMQHG3gNyIx+YC3Cb7W/1q3lnytVOiUX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="340867367"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="340867367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 06:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="855009812"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="855009812"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2023 06:09:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 06:09:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 19 Mar 2023 06:09:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 19 Mar 2023 06:09:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 19 Mar 2023 06:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz2zEwxM7SOqLQVHkplaX1eF3nd1tEsfaY9nT/QFncHzn+/EFxM9PPBU5VFZaaoILRevkNlUU+bRLnkBmkLb7I4UDxE+f2XVoULZ6/2J4ojaE9mtEfj3FcsvbvYD4GJ6Yz/CDWyK6WHBE0ZJchsOZ401OC4pq2mpG/o1gWTERDsThydHJOTvWZ5LaVaqoti+QtL6B02YWPtJNwqihO3jRCa6DhnKURPh05/5DQVz+pNWzYvcT7GuL1ZVEts4FxxvMLYRELGNQ73BiIEmsQs7VPbVoPe+e7h5OziE7WWAHAaiQHp6NM+9wUloW7WkoEa/oVpJX4HSmeIuvUct03N4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyBrrRk2ZqQMbz/2EvMPop/ulNAr9t5Pf7tkBvkdX40=;
 b=fDss6cc0SkviJSafvdM7zKp+/M48gb8Z375yjXLpxIijYtRxKKsHjPLQ6woz/1+1B+CSps4gGoOudLMiU1uvAvN4KZ5H/UyR0uDMnU1YDBIQk+MM8Qq5A1WkAuWCAJPqnR7WVbOHhlLvt/EsCTQZiMibLV8E87tRoaaSpAOKA+ai34nlw2h2Vl2SISXZXVJfupzhJ5+0qYQ+TFvyesF2S1lptxTN5iQlozsOUHpoITEoAGMKRXm55SrHs2BqeVIkIGsn1v3lI/bzxwrvmYGc2b7pDNYDzyLezm4it2BZImtXmJ1Wu5QigPdLBuYM3x5+1INcwXZIsqa/AZ/Y7rFC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 13:09:25 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 13:09:25 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
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
Subject: RE: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Topic: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7l1BmAgAACFoCACULV0IAABnKAgAABmnCAAAmBAIAClEUggACVcoCAAEDPMIAAIp0AgAotPRCAAGjUAIABdfkQgAAa7ACAA2oH8A==
Date:   Sun, 19 Mar 2023 13:09:24 +0000
Message-ID: <DM6PR11MB4316348D7B7AAC58DA0E62ED8D839@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <ZAb2G7kqsEvrBhpG@kekkonen.localdomain>
 <DM6PR11MB4316B4F865472CA998E696FC8DB79@DM6PR11MB4316.namprd11.prod.outlook.com>
 <4c3ba301-6241-f2f4-f139-b4f4a0cd6223@redhat.com>
 <DM6PR11MB43166ADFA7D0775BA2C223C78DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
 <e12fe65e-0b1f-a058-75e6-fa3e0a292c5b@redhat.com>
 <DM6PR11MB4316B02E112305F411B1A5158DB59@DM6PR11MB4316.namprd11.prod.outlook.com>
 <bb608934-23a6-213b-ab28-5dd66afd88e5@redhat.com>
 <MN2PR11MB43183F350CB575F94B1F05748DBC9@MN2PR11MB4318.namprd11.prod.outlook.com>
 <346c376e-01ed-267e-b1c8-ee42c345d03f@redhat.com>
 <DM6PR11MB4316F0F7B7A0F52FA5DF03BE8DBD9@DM6PR11MB4316.namprd11.prod.outlook.com>
 <ZBQrulUBX1rYD9EN@kekkonen.localdomain>
In-Reply-To: <ZBQrulUBX1rYD9EN@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|IA1PR11MB7679:EE_
x-ms-office365-filtering-correlation-id: ddfcb174-49c4-4102-1cf5-08db287b299a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7t4OBNCYpI3A3vEqVnLGqoLA6gEgaDXGukSkzcm8aN2ynqpT+Y6iiqkX2PN1YEK5gXtRoqeAUnTnKBSxcpkGBn6f9wX/LsX4pE8pvkRfwdEHMhpnyektA2XpluAwNAiBLPxA+bkBe9dZTjUoZqMdkf41plaxbzgRqggmMfLKonYcjrRPk6fAnuBPA5dQd8tpKvPcUNS+7BRBoJ1wYZ3rUpryBIk+GySAErcNpPL6GxMFcGx4pckweAqYi6ilhXKMtEZHP2SS2YsdGDtJ8uVxmcw4JlQXxmHs+/2XyVXhIzSqI9O+1vSKn9CfOw4xoQU4s/uOHtd0Ni1amtjLoDjq2+1umxal0lOUSCYmOGeNtQzMc9I2JJIMrdfF0rCs6Vgmmq55k/cfYSbtIiDJt/QMWt9GTcggD2hoOkBZeBsHeVO3PK93ckynOEDcSS++wpzEkbM9gO/Y1iAmmM/0RAC93J2+6GIJkTq//BXZMKUUrwBoSFqoA1nFUrtLxe2hHUrwxbwlX/1mRED0+0HdA8kqkgF/qoJg/j97qn4l6iVBcQ1ZuFkpoeUMFIE5SwjdJWS35z5P4VabqWUURMx8EcrzDiVghtCdc5E4EtXaOs6pOlhRbLHOOCwzeMrf096IMUPQlpNz5lMbbeayU9AEN5KXD0y9e4zwBdZB2ufbHgKqosYhiwjkbjBbqw2lhILiN09E7J2uxswjm1PYMfRib7L7ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199018)(83380400001)(38100700002)(86362001)(38070700005)(55016003)(122000001)(82960400001)(76116006)(4326008)(6916009)(41300700001)(8676002)(64756008)(66446008)(66476007)(66556008)(52536014)(2906002)(8936002)(66946007)(5660300002)(33656002)(71200400001)(9686003)(26005)(186003)(7696005)(53546011)(316002)(478600001)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pL1qTSJKwAppBbAU1FWfchh2tdNlJwppH2U745v0gomXonVe5IV4qyC9jop9?=
 =?us-ascii?Q?4OpBE13bwI/RaPbi/deZtm6PbRx4kHS0R8DdjRQKFRMmDHcMqop2K5kQMLA0?=
 =?us-ascii?Q?ttgTJCeffF9JcKpGS8GHtERw+WPTq5P/cjP5J9cw6fYA5i6cA2R7lUIMghLz?=
 =?us-ascii?Q?HXOO/UCXvgHAcyQJ+n46AS04lrGqJcc2+VN76GXXf5H3qxJlCzewSzl2cbDg?=
 =?us-ascii?Q?1dR8Lc6qhh+ifSbxlzF7q1R/9D6vpJOt8XZDaegH2AtIlgKiC2bUgXcAROly?=
 =?us-ascii?Q?e6098YTouyur0L0oeU6Yv04HcKWghiZIn5U9teDYI4khmRw17p0v6R8Qqua0?=
 =?us-ascii?Q?797/zxdd2OmUuCuEr2fj3n1RdhQUGDqyPtZzbgbfTFiCRtNzZgckUdEDg7t6?=
 =?us-ascii?Q?iktvEIKFfe+3tJIHhBlKaKvmO8elipjQgTlw/H8dyT8Oy0R9S86C05PuXGZL?=
 =?us-ascii?Q?zgyThqI7UY3eH4nUy4DXHuVpP+5K0iRsUXg3KixBdj62mbV0dOQGiBf45oAc?=
 =?us-ascii?Q?qkOUpKaRTptVNNb5z6PdcnHKb+fTeBSIqF1cWjrIiALU0yGPra+4f50hTZik?=
 =?us-ascii?Q?aSWUtxdhsvVlOfuJ7VIbJnyhSWCA6Bt3C6wJWz5L4S7RAbXrQxmA3qSGTwRX?=
 =?us-ascii?Q?gkXpBTRdiPKqeygzl6cG7oqrr7AQG62vsA9Kk/0EM5zmWZy1jJLLeTXNd/Pc?=
 =?us-ascii?Q?GyftJfyny1y51Vl4fxkf70adXvXcNKXSbic0+hbevZ1UugLdAM2/nlKW9h1K?=
 =?us-ascii?Q?afeU3oqk/RH7faLeWgzDw5UeoiLPT4OeyVmV9gD6S1BqKbwvawYUonFVN8cx?=
 =?us-ascii?Q?QD1GcV/fdkZSNwaacB3KGruRXrc5hj9776MVTwtPR7UcBfR/qT1MvY8BEYxo?=
 =?us-ascii?Q?qpBCOURjVBLYMWTKvyMBAnehfOoFEOrOI+84qgGSH9AdoWgI30eq8vwkJVCD?=
 =?us-ascii?Q?SUkcBIXNtP8QrXzQl6lXrIUivikXuyA3ueLlo0Ra+PE0E41QLQJoKtq/Y1Hz?=
 =?us-ascii?Q?V4mVRmKgpKTO/uZq1hfKZRA89qVjpeveMah5SuKFqq5T7OHKsWlkjMM1QTYb?=
 =?us-ascii?Q?6OxyzVr8VESNsfS+DiofVk1tVDBOTtoMP2ib6wsrKS8R8xR4AjnLQ7hL6F5M?=
 =?us-ascii?Q?qle3zgXdnJ9q2bgS37morITADwJngAlTd0icxO+t8mf7DNBektTWKimh4E7G?=
 =?us-ascii?Q?2+QJX7lVGmycYft8UvnD4aej5O/4z7QaPl22CtpH0yKR/BLDworxoExcBLVz?=
 =?us-ascii?Q?MVoAnUBQJZpOXvIi01GNW2z1vssQHEJ6ZgYxebA7Nkkqg9+6kXn56ZUMpsky?=
 =?us-ascii?Q?LB0L0TF1e6SMLe0D5yeIO/YCIp/eLjB6PtkHJjDpaxQGKET6vkBJBIkm96YU?=
 =?us-ascii?Q?OA3KarFgLmVEL5EvMGwH7ovr0vDehzmbdDvsoT73sJDsmIl/eR8wLAnt9LAS?=
 =?us-ascii?Q?lL3owuZHhJtpeqpKN8iR3UFfxOB69bIzdtDRsprtzvHRDiV5VYlpq/7OWg8S?=
 =?us-ascii?Q?tWg7zd+R1wFPwbF+i0DBwuKt78OdXP7K7LUwoO9IlC7l4DBrRjNqCqHeR+sb?=
 =?us-ascii?Q?no5yrB8g4W4WlFBn1J0PhLs42KABYydz5gC/3WTD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfcb174-49c4-4102-1cf5-08db287b299a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2023 13:09:24.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEMOAhMNM8qasWi/ukz5kq+Hsse27uPcQDpVEFrhzMbCJwUhwj56l+DFM9kFPGlRi18gKI5ntsVacKWfDpltFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
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
> Sent: Friday, March 17, 2023 4:59 PM
>=20
> Hi Wentong,
>=20
> On Fri, Mar 17, 2023 at 07:30:19AM +0000, Wu, Wentong wrote:
> >
> >
> > > -----Original Message-----
> > > From: Hans de Goede <hdegoede@redhat.com>
> > > Sent: Thursday, March 16, 2023 5:04 PM
> > >
> > > Hi,
> > >
> > > On 3/16/23 03:58, Wu, Wentong wrote:
> > > >
> > > >
> > > >> -----Original Message-----
> > > >> From: Hans de Goede <hdegoede@redhat.com>
> > > >> Sent: Thursday, March 9, 2023 11:24 PM
> > > >>
> > > >> <re-added the previous Cc list, which I dropped because of the
> > > >> large
> > > >> attachments>
> > > >>
> > > >> Hi Wentong,
> > > >>
> > > >> On 3/9/23 15:29, Wu, Wentong wrote:
> > > >>> Hi Hans,
> > > >>>
> > > >>> Thanks
> > > >>>
> > > >>> And AFAICT, there is no IVSC device on your Dell Latitude 9420
> > > >>> where the
> > > >> platform is based on TGL instead of ADL, and I have never heard
> > > >> IVSC runs on TGL,  if no IVSC, INT3472 will control sensor's power=
.
> > > >>> And I will double confirm with people who know dell product well
> tomorrow.
> > > >>
> > > >> Ah, I was under the impression that there was an IVSC there becaus=
e:
> > > >>
> > > >> 1. The sensor driver for the used sensor (tries to) poke the IVSC =
2.
> > > >> Things did not work without building the IVSC drivers, but that mi=
ght
> > > >>    be due to a dependency on the LCJA GPIO expander instead
> > > >
> > > > Below is your dmesg log, the required SPI controller for IVSC isn't=
 here.
> > > >
> > > > [   35.538114] ljca 2-6:1.0: acked sem wait timed out ret:0 timeout=
:20
> ack:0
> > > > [   35.538129] ljca 2-6:1.0: MNG_ENUM_SPI failed ret:-110 len:7 num=
:0
> > > > [   35.538621] ljca 2-6:1.0: LJCA USB device init success
> > > > [   35.538776] usbcore: registered new interface driver ljca
> > > >
> > > > Also I checked your SSDT, there is no IVSC device and the sensor
> > > > device depends on
> > > > INT3472 instead of IVSC device as on my setup.
> > >
> > > Ack.
> > >
> > > >> But you might very well be right, that would also explain the
> > > >> "intel vsc not
> > > ready"
> > > >> messages in dmesg.
> > > >>
> > > >> If with the IVSC case the IVSC controls the power to the sensor
> > > >> too, then another option might be to model the I2C-switch + the
> > > >> power-control as a powerdown GPIO for the sensor, which most
> > > >> sensor
> > > drivers already try to use.
> > > >> The advantage of doing this would be that GPIO lookups can
> > > >> reference the GPIO provider + consumer by device-name so then we
> > > >> don't need to have both devices instantiated at the time of
> > > >> adding the GPIO lookup.   And in that case we could e.g. add the l=
ookup
> > > >> before registering the I2C controller.
> > > >
> > > > Can we add IVSC device to acpi_honor_dep_ids, so that when
> > > > everything is done during mei_ace probe,
> > > > acpi_dev_clear_dependencies can make sensor
> > > start probe?
> > >
> > > Does the sensor ACPI device node have an ACPI _DEP on the IVSC device=
 ?
> >
> > Yes,
> >
> > >
> > > If yes, then yes we can add the IVSC device to acpi_honor_dep_id and
> > > make mei_ace probe call acpi_dev_clear_dependencies().
> >
> > But I prefer the powerdown gpio model, because we have to follow the
> > commands sequences as below which is required by firmware, runtime pm i=
s
> hard to achieve this.
>=20
> How so?

But we have to find a way to download commands to firmware following below
sequence before writing camera sensor's registers to start camera sensor's =
steam.

BR,
Wentong

>=20
> I don't insist on the runtime PM based solution but I'd rather not have c=
hanges
> to virtually all sensor drivers --- this is an external chip to them.
>=20
> > +	/* switch camera sensor ownership to host */
> > +	ret =3D ace_set_camera_owner(ACE_CAMERA_HOST);
> > +	if (ret)
> > +		goto error;
> > +
> > +	/* switch CSI-2 link to host */
> > +	ret =3D csi_set_link_owner(CSI_LINK_HOST, callback, context);
> > +	if (ret)
> > +		goto release_camera;
> > +
> > +	/* configure CSI-2 link */
> > +	ret =3D csi_set_link_cfg(nr_of_lanes, link_freq);
> > +	if (ret)
> > +		goto release_csi;
>=20
> --
> Kind regards,
>=20
> Sakari Ailus

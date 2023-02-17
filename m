Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A369A59C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBQG2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQG2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:28:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79C12F16;
        Thu, 16 Feb 2023 22:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676615317; x=1708151317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vs2Tz2aRCd7XgjeyOXpO+vAubyyEY+1KSuaiLYkdM2g=;
  b=JVQySm32PryPoEJdZEoqgvmKFY7GPFMFWU8u/OQUrLGhXHwlybJ5X/9B
   RpQiwzuhQdixTJPnfotwRiXNGHslDOC0RzYwFv61GPXxK95RVCGaL6hRC
   DgU+vBH4ejwTCbkVYQuFLrwoxJwR4+nQsBIvrzztu/gnjVfT7FZ8gVorU
   bVqmotooDLOT5cMGmfupAaBvE9KRMeuyMsIBPIPO3Ms/51t8t++0vnxqv
   n8N6fkCmjbcIBqSEyTmG2y1P4E8c7i9GaXI1eKbzoqalTTKtEI1GxpGeq
   1P2Zf5s2CQrUk+PN2JUbsUqXGq68ARajCUUrr+KlmU1vgVUqDf0/msAtJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333281846"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="333281846"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 22:28:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999345335"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999345335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2023 22:28:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 22:28:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 22:28:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 22:28:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 22:28:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHJvk7HZdjH2sRjmK9pO6u4EPobtCovHFmK3yQrllOCSIwG3oP+qP2rYeGHgI3FxXHJ0Ns5PhvTQ8IRj3o3KnPUQ0h1FfCvJh0SbBKX2T83vSVFcXQX9fx19eOAOldcCCSr3+pS/mbcKlY3sMqW069uhNml9VSkmIEMbubDTFLiIdWoeAFT8V6UU8ICKlaY9iaKDUCHLeTVn+cr0nQZpHPjENbwpVGBatqIG6FwMVRlCs+nYaT/ROAMtn7MtYkKlS97aDX9IQwK0q446UoI5owJbVSV7O5ts/HjKQEirQFrCdBbzMarOOP9Q+KpBAf73q7DtWkUlREiHbr6onC6z3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMqFGNn6eA4UQAwUYO0GBpS8Bl5zQGkmr/7d6dmoTAw=;
 b=Ns5qgBfvkIR5lv0cDUzXQ50vtyF7xylEGJ1utRFkk3nQNborHHhO22T15DI/J4BRMI/C45kymPIlofRPLJFMv44tlwkqtndJ6ZCyAbWBlBEpJRpQxraslGPNfQNIlpC9VsXan8h0duxRq5l/rH0Jmz5oVuArQu++uUyZgX7OT8YMikeBqDlPBB147jAYTjPPJy4jwuSsiGFPH9uCMuLr133ejqf7IaQh7SdW9VJ92w3F2au5sYaZOmNZCek467EV4oDfnsJyEDjZclVMNka1s0QOvXURj9k1gm+7QQ4QqtdzkxbcBYuEKnUmBM2JezHEDo4yKY6viQrjagVfFpbrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 06:28:33 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 06:28:33 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Thread-Index: AQHZP1HlDdnw2M/ymEOJ6dDL3JcZGa7PxSqAgAApAACAAaPNgIAA0d4AgABNrbA=
Date:   Fri, 17 Feb 2023 06:28:32 +0000
Message-ID: <DM6PR11MB4316F7C9854B113556466BF58DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
 <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
 <Y+4rtSMArg5ow0Sh@kekkonen.localdomain>
 <8022b9da-e033-b77b-914c-d35a31aac2e2@linux.intel.com>
In-Reply-To: <8022b9da-e033-b77b-914c-d35a31aac2e2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: 8533c315-0243-4a55-b459-08db10b030fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIcTlFLOMd+6WoTLk/TonOTwHxbA03KlmMLD/yCHfVm2cMDSUMm3NLxZhV5Ki2t4Oi+vSPsgHaaANg5duQjYQnGEJ8R7VM/VinU7mp6MFkFwKbWVw18DN5dwYAAWbMChPvZtb908JCmSVldVjJgBOTuFkeu/kWfb/5qGSyaHw0fSAMrf8vM6dRAfP+CMW/JIVkebhq0bf5UUIbJktAtkapEbHzs8U1I7JXrxcAzYs+9dFjUvpqfryUmojNmN8Yv0+COaW8dn0ysIONAj0K36to3u6yPIBWG/NkVUkmdJi4gmjC/uEJ68OF6IJ7plDLE7nguR3Hs9cfLDcIHaKHIVWEl1nsiudrdLWTQxb61osLGDEoQddGvXflR3WjzWJOy/Ydt5EihNJZAik6DYQi4oAyrjadSFyBMI4dF9156hK43vrr+kL6CkvK1BooN55wUuZGr+7gQo1RbFRPF41elnYchomf52bA05pGxuhIgwCI/fqD81Zwk4oBVc84xVFNzaFQJIQ0D9hPT+U/GL/WYObHPmt+xdprtAB0waCiSUZxenDO20iSxkCQW3O8NJSAxh4Wv4Vdfxf0awfQWimiM0DkIipsSeq2sATyZzATbG4PAKHj7NMzJnoF6ABzlJs67X3aDBu0Dj+czM3QMjR2LLYCJJsv0ql9Y9Qi8yeRc1z4Vphbv4Igw8L8zewE+HK9ElQMmp6o6X8mJyN0di3pwjvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199018)(66899018)(86362001)(38070700005)(82960400001)(2906002)(122000001)(38100700002)(71200400001)(7696005)(110136005)(6506007)(53546011)(54906003)(26005)(186003)(478600001)(33656002)(55016003)(9686003)(41300700001)(83380400001)(66446008)(66476007)(66556008)(66946007)(8676002)(64756008)(4326008)(316002)(76116006)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zuVPp8kk6fcrlLq2Urt7BkLmr3lSVE3WizUy81mvVTVWp+Y0YqrnCpIbY3Pf?=
 =?us-ascii?Q?XvYn8/9Kijibq+7fOSmwYVj7DhTm7g+Mi27dXz+xaqL2psjVUWdGY3XM7Quw?=
 =?us-ascii?Q?A0U5AnCSc39CeDtwNFXLohWlb0rmWcEbo+tqy+C7iSCDgE3G10Q043uv+tnD?=
 =?us-ascii?Q?P9q45jK+p06dJGLPbR+GaVvRkCP+e41nhNoqazhA71lOhVm45iLcSyvtQqid?=
 =?us-ascii?Q?ucrVCYEqAafJe9t+cwSxSQR9q2O6mZ9syJCB+pxRLEBshgS9N9dEGAJZb2YT?=
 =?us-ascii?Q?mtVvG/Wt4Vw125qJQVm7P4QyzlbUJUzerJdK99VPBOQqSwB/R7jqmsSCA/L+?=
 =?us-ascii?Q?ilqF42NpkuP/Oy4plsMRxtBor4wpVI/nJsgOu+p68oJGBWuvKuYjoz0Xjjfn?=
 =?us-ascii?Q?fPm/mqN3TZp2bqnZYR+3ikwOtZewOSqIS0h1d+PYol0P2SFMFl9NPv4B0lH6?=
 =?us-ascii?Q?Mq8GtZdhDY+F1FcfhbaINLJRM2Gu+yoqGEZPDMvj+RGKuVtreMfvMJhT/37c?=
 =?us-ascii?Q?hYK3SBhwUpBJpNTeRz7tVk91zlr5BYpVIG5g/R6/wNAM6X4tdYjNhEb9rgy6?=
 =?us-ascii?Q?Tl0nu5rFmg54mbMwWAb7yY5ockl9mjtJeIpp8Nz/g/0h3mJ+mr7tY8okDiX5?=
 =?us-ascii?Q?eJgsN39rlRhW40rwiWcnzd5WRIubaMr971nj4ZbT7yyw4BtaMa0UDe+td/NN?=
 =?us-ascii?Q?Pi1BJsv6/DHZMgCrHO7dJfvCsCSkKfTKcbeoGAdG+Ks2YKkzy/Xm8oAZFS4e?=
 =?us-ascii?Q?uDTxIpBimhuCiP8Hb5LN/jDVWfnZqOXt4dAMqOQ+RI1T8/vL0/OqYvQpvG3c?=
 =?us-ascii?Q?DbUoGapl+xYHKGiPfgGzfSaqFP58lI5nJsUSGch/NBQYip72CuC2rH5bKWuZ?=
 =?us-ascii?Q?qtKCAMW/SHrVi9R+8ESkEwntQpDgubcgmrklWRJVm+G5eJnK+WyTKWTes8jX?=
 =?us-ascii?Q?jPLSNSg1CC2nv5oWHZeN+BbS3m4Nk5tf362UNkCQXOnJpJSZZx3BCz8dVSs+?=
 =?us-ascii?Q?jldRSzDJkJS1zyCO6vB/7mRpwSY1ywSEblf5yTlGznzxVVHefWZCT3WkO3eU?=
 =?us-ascii?Q?6IXisjvg/PQBO7z36AAu+dWt58A0eIO+4pg5GicbVacrlnFJjx+Bi45eXS8h?=
 =?us-ascii?Q?zzLzLIHUVy6Im+l5EzhBsSNAlcyHV8fBlOB5t+97GvnozNjGY4ErTfX22PLd?=
 =?us-ascii?Q?dIVFDmAKIcXfh/WbqkyVQRiF8Xjr4yHDIUCI1+/YU7LffZqwZ8ABKHT/GIhj?=
 =?us-ascii?Q?Adsw0+3JNwAVa3fVvsMHof/Lxfl2i3NECV9JOj8/Gu9vnbjxWhHH5glGPgTX?=
 =?us-ascii?Q?iMGzxN7TFDOd5gWrZslinYJxKaz9aoh4qJUFw3e9wqCtRjOoDjkK2KVp2z4T?=
 =?us-ascii?Q?eX73gULQ3pq30QOl2ws9nMRvJdkgxi3f3ps84583mRGc2pG+dOoLDN9QQHxD?=
 =?us-ascii?Q?eXWPl0ShNEoKssmSkA/4usybn3OYH2IrZnFD+fKFugY0Ps6OWGj1j8paYoiN?=
 =?us-ascii?Q?HTWWrtv0aO5t8R1SbakFWjifnkdlruQU7kaEHqgzdW2/LoCqqasjrVCU38Ui?=
 =?us-ascii?Q?BV1O59MsTky6J45kedBBitUwB6m+je5CluzySSMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8533c315-0243-4a55-b459-08db10b030fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 06:28:32.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqAjsqyXFUdNdwPuwtqOCXA61WHdEG3lbPMY/Wo6HQx+wS46cuprxUFmHB7rhG0QWL4PCGart8LGWm0SmbOl3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bingbu Cao <bingbu.cao@linux.intel.com>
> Sent: Friday, February 17, 2023 9:44 AM
>=20
> Hi, Sakari,
>=20
> On 2/16/23 9:12 PM, Sakari Ailus wrote:
> > Hi Bingbu, Wentong,
> >
> > On Wed, Feb 15, 2023 at 08:09:50PM +0800, Bingbu Cao wrote:
> >>
> >> Hi, Wentong,
> >>
> >> On 2/15/23 5:43 PM, Laurent Pinchart wrote:
> >>> Hello Wentong,
> >>>
> >>> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
> >>>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls",
> >>>> is a companion chip designed to provide secure and low power vision
> >>>> capability to IA platforms. IVSC is available in existing
> >>>> commercial platforms from multiple OEMs.
> >>>>
> >>>> The primary use case of IVSC is to bring in context awareness. IVSC
> >>>> interfaces directly with the platform main camera sensor via a
> >>>> CSI-2 link and processes the image data with the embedded AI
> >>>> engine. The detected events are sent over I2C to ISH (Intel Sensor
> >>>> Hub) for additional data fusion from multiple sensors. The fusion
> >>>> results are used to implement advanced use cases like:
> >>>>  - Face detection to unlock screen
> >>>>  - Detect user presence to manage backlight setting or waking up
> >>>> system
> >>>
> >>> Do you have plan to support these features in the ivsc driver in the
> >>> future ?
> >>>
> >>>> Since the Image Processing Unit(IPU) used on the host processor
> >>>> needs to configure the CSI-2 link in normal camera usages, the
> >>>> CSI-2 link and camera sensor can only be used in mutually-exclusive
> >>>> ways by host IPU and IVSC. By default the IVSC owns the CSI-2 link
> >>>> and camera sensor. The IPU driver can take ownership of the CSI-2
> >>>> link and camera sensor using interfaces provided by this IVSC driver=
.
> >>>>
> >>>> Switching ownership requires an interface with two different
> >>>> hardware modules inside IVSC. The software interface to these
> >>>> modules is via Intel MEI (The Intel Management Engine) commands.
> >>>> These two hardware modules have two different MEI UUIDs to enumerate=
.
> These hardware modules are:
> >>>>  - ACE (Algorithm Context Engine): This module is for algorithm
> >>>> computing when IVSC owns camera sensor. Also ACE module controls
> >>>> camera sensor's ownership. This hardware module is used to set owner=
ship
> of camera sensor.
> >>>>  - CSI (Camera Serial Interface): This module is used to route
> >>>> camera sensor data either to IVSC or to host for IPU driver and appl=
ication.
> >>>>
> >>>> IVSC also provides a privacy mode. When privacy mode is turned on,
> >>>> camera sensor can't be used. This means that both ACE and host IPU
> >>>> can't get image data. And when this mode is turned on, host IPU
> >>>> driver is informed via a registered callback, so that user can be no=
tified.
> >>>
> >>> How does the privacy mode work, and how can the user trust that the
> >>> closed-source IVSC and IME firmwares will honour the privacy settings=
 ?
>=20
> As I know, without IVSC, once user enable the privacy mode, the Intel
> Converged Security Engine will configure the IPU camera mask (security re=
gister),
> which will mask the specific CSI2 port and produce dummy imaging data. Fo=
r the
> case with IVSC, there is no final solution on Linux so far I think.
>=20
> Wentong, is IVSC trying to cut off the stream and then notify user and IP=
U?

yes

>=20
> >>>
> >>
> >> Continue with question from Laurent,
> >>
> >> How IVSC handle the privacy request from user? Is there some
> >> notification mechanism to user-space?

IVSC has already defined privacy callback for host IPU/camera driver.

> > I'd have concern if IVSC driver
> >> need private callback to request back-end(e.g. ISP driver) to handle s=
tream
> cutting.
> >
> > How does the privacy mode work, does it just pass zeroes (or other
> > dummy
> > data) towards the host or nothing?

No data on CSI transmitter side

> >
> > A V4L2 control can be used for the purpose of passing the information
> > to the user space at least.

I will take some time to review V4L2 sub-device and control mechanism, and =
then update the driver.

BR,
Wentong =20

> >
>=20
> --
> Best regards,
> Bingbu Cao

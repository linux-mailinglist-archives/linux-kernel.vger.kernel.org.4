Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7543718747
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjEaQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEaQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:23:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA819D;
        Wed, 31 May 2023 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685550208; x=1717086208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zXPo/M05lh6Pm/HBoINvAzrBs1ux7CusaHa6UxvRhxw=;
  b=GFKBA8CdyWV0Xui1m7nSw5Vf4Ocf5fLJGUo+sKJyCncTRWlCZOgFbeIw
   apsPahqHEbXvdsUhywRzyB/PMB4USzkSzAqI3hxgrIe7wIW6aTvzvoOPy
   7nL/3M5Cy6g8w7AYkinYh8Fezd2SodZiKyZ9dxiVBAauYm9ZpdHphexKy
   5I4KyFV8+QtO+PQKw2ZAwu03pNntkI125FjPHiqXXtSwP9M4W4Vs2RGCO
   rF1q0fP1SKUPF2p1oVgtsnYiNS87VxyoUtm9d6T9tofNCfDgwxIzfeJgp
   F6a5g4TXBHUMPTO/nbYurSYebf9jo7j6RLS1jCrmJKSuuQpo64PAeD+gp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="334911674"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="334911674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 09:23:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="881249743"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="881249743"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 31 May 2023 09:23:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 09:23:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 09:23:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 09:23:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 09:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlSusR5+KC2JRE9o0Vru+pQhGpZgEDRQVvzXdiZgA7OhCkAtPXjq3JioRywlyQ34RWO2VG/jqUn04vnaqmBVHQpj1s+GCOPhO+h6ut9emr8gNslGkVQI+kHrO8cpm9lZ2H83OBldr7B1ZDwwopGNodRFlnDgMPh3PLlqIyzDNYlcVoOsDz/QDF7Bqal5gMzbw2w44sLxM4KK2u2hPYsuey2HcUnbmNS9ltypyW9tBj5976/d5/YcPyOgTUOONYrPHkyZRFEhURKkCgsOln1oa71S0mZArAwI5OBfXCNKqN4MSxGR+CLfAWYVagMuxLVwDFd6zxKdh1a+QEeaMSNfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXPo/M05lh6Pm/HBoINvAzrBs1ux7CusaHa6UxvRhxw=;
 b=RMeo5wfcBaIEGykATWeX2pyXHThsnN5qieumQyCmMdDRfuCrpr5tWaZtMpCO+HIcA1Ct1bP8ficghOcCBj2q3xEa/a6QWasJ1kfwPBQ/dbha0f94oN0RW7zqEcBCFDJ7RTshnSi/tTw0EgC/qDgJXpc3kAlrS1ktU/+U6F5FNfNhPZHPf5CQ94+YSy3UZnRuUoxxS5hUJ5TcCT5vN/a2JuL2Q+akHzM42mq2s8WGYHfO/KagAkLKTE2qo5cANJMsnkMNPJHQ0yw8apPW6pnoe93ldauFbyjuyoirQJM5qAlz+iw5prPJ1O7/G0GYrp4y40qVIbcbkCIX0UCPcwyhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 16:23:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%5]) with mapi id 15.20.6433.017; Wed, 31 May 2023
 16:23:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: RE: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Topic: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Index: AQHZfoz/HoY7ASH3bUeV4msZv1/xf69KTa1QgABJGICAB3OngIAALJJAgCDtGgCAAYD7AIAAEZgw
Date:   Wed, 31 May 2023 16:23:23 +0000
Message-ID: <SJ1PR11MB608333C6628FE2FDBEB64C19FC489@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230509143721.GA10616@Dell2s-9>
 <SJ1PR11MB60831FCB30F2A642B95C9D9FFC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4376a7ba-2f85-6160-b7d4-d5c08b5b3429@intel.com>
 <20230531150342.GA13601@Dell2s-9>
In-Reply-To: <20230531150342.GA13601@Dell2s-9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4902:EE_
x-ms-office365-filtering-correlation-id: fd2d2ef7-0121-4f7e-2dc3-08db61f35b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKHjoTiw9Ji+TCZhZRGG06QiwhpZk907xC4X27aB/wP930NT5JoTrw4EtOO1Qj+ndFVWC5grC4/A+47+8bQrRB/cOs/svsF/wnxmig/FPqARpSvzpMHcWSm5P1cpNZM1647Pi71h5Nl3iy8xXzD+GrRmVXU5NAZXXvOnneDspzvuEhEkBBHhvHeP7wsfhpoTzZaaZtt/0bs6E0dXuLN30HYTBvtjzTiNyXb8HYSAqPXgUh0cpEnH3Jqu3VnDvIhv1JjrvILk9psEMJbMY2Ndy3NUgk3F7QaB79iSVs3e1IVMfMHeACEhbyL0xMVHkBHuYQHMNOHflH5lkJoU8z98XFjPmkKXl++hBws9v216ZDIzDyzW44fjrKzK29coyrfvC+2DA+hNtE+StJnHH3yF5uiRdw+8mihOksShXrl2zfA1uPYgJ8S7T3GNuhvMrLfIzEO6CwSELIlugVyV4dq0ThZtCwcuyFfZDza4GLWTk/xF0tpjyVs+aYg2kxJDa8kuAvxaAKTA7eF0ZSmyUdhxdevHl/WcvGg7Lvgndb4YyxehXZAtVpp95s3BJhyX89RxoSunZqpe2J59AzrbQupY70ld9HuOlnKd7TTA4RRxV5SmEiTiYdJV9fluRUAkKtRM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(186003)(2906002)(9686003)(26005)(6506007)(52536014)(5660300002)(122000001)(82960400001)(38100700002)(8936002)(8676002)(54906003)(110136005)(83380400001)(86362001)(38070700005)(7696005)(41300700001)(33656002)(316002)(66946007)(71200400001)(4326008)(76116006)(7416002)(66446008)(66556008)(66476007)(64756008)(478600001)(55016003)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4XDVVW27MZcvZgatdz9Y+LoA+EghDujqkKWb1Aap06VNHtRX92nI+1b7GwAG?=
 =?us-ascii?Q?cthM3YnbK4xIiBsQKUNVBVx10Y4mcSBob7PKbNtuWevUfLQ3uDW75AFTEpu1?=
 =?us-ascii?Q?0a/uSr/wQ2dQpVRE7iWB7C979oOUmadyPa0paTA4lUHG//KO3Ag09hzm9nh0?=
 =?us-ascii?Q?mNEOCiOANpGPwAkLCZrDiLoBmOFpK/Gxj+h8VM9jKYqZJultf7XUEYm3gW9r?=
 =?us-ascii?Q?rs+MY1eb6A+VCAUE3NwQ/o8nHlQk9KzujPrItN18jxyBFYFas55Y5BgNnpBD?=
 =?us-ascii?Q?ujEUDrd/pzKZxW7R3eGaeQsgeFCYmGsNM6iXsFf13XWU9DX8kVBXqx6doTbn?=
 =?us-ascii?Q?HDprdJ/6sr6aKTI0ZLQ2UPvbJ3akfXPA+5/l8r0iQ6vzgSTdJ+TacY4bBChL?=
 =?us-ascii?Q?JFii/kE3IaqsIroDR/wVvZdLf98hUbVHnjIwUp0hq7m3ALW4KptuBN4NwGME?=
 =?us-ascii?Q?M6SaYLJivC4TnQVUsrVdpmoDG2Xow92qdc1fC6SsyWzRGuMtpeqdQxZwgr3O?=
 =?us-ascii?Q?WWgqKmiI84nXxwSeVjehDJZdHK7wZTWt5U2yL+v0X+eAHIRCyWNH29YVf7og?=
 =?us-ascii?Q?F+qy4BprrdvRMewDQjuxUeUsVH9ONb/QeCLytzy6lemzkp7W/oe40d3lb3wT?=
 =?us-ascii?Q?4O6umlzAP86DQ5keZrkoO2DjjZVFUBiNiGVHcO8Kl+sv5b/4taYa0inN3SUq?=
 =?us-ascii?Q?EVzfuB3BY54+o+1Hup4ILrXb9ZdKtePxnBrskE0dTPQhd5ye4ippaYRyXDhM?=
 =?us-ascii?Q?hcgkp4HuZ+/Cjp7XXbZ/OHNax6+9+xmhMhTYfEp0b+vUgLwCLVqCRKNGhh04?=
 =?us-ascii?Q?3AuJnnRb2oiSS+wCk/ILDa9QLXQ10E3bqchavNQle5sQMeXr64NJdl6w8YPy?=
 =?us-ascii?Q?3484ZKfrDOqReTHZPox3BvizhWf6OlvePAhOn01/aPPnd91eHcJUNmRiBhhc?=
 =?us-ascii?Q?YMujVRWZvcLWnhdq8gD7kEI8GJIaZRhEXsohZybih5ewlQ1xesSzFFiMffKt?=
 =?us-ascii?Q?N0YmzwVeFz8mltdI5w3RRPl8/9GaTcKYRyeCu5wIyy8ztgcLr7RPdQvCm7WP?=
 =?us-ascii?Q?Cizf985K1pWtI5UjK7Y6oJIiHYHHlcs14YOpG8U4p4fYTF3IB6WtgibxSmJk?=
 =?us-ascii?Q?PF9J4V/yn+BvyOrNJCsB01pjmwngv+WCcraYCE1KAdP5rbwIFTSS7qgki4qn?=
 =?us-ascii?Q?o1mN9N9ma/CdPPKzTTBneeQf5MNliFYkj26qDGTMENcjyUmgs7fAJJZ0oFjn?=
 =?us-ascii?Q?7jmtF4QixyUUm4aFWrxmz6VepQ3jTiAkCJ0i5bJJtx0aHNEJUDZQJBX2HBWu?=
 =?us-ascii?Q?enXd428EuggohJ0ha8Z/ujNOQ3RbPiOo3F+bdbrYgTBfoL/4Kg9bA7yKsTmn?=
 =?us-ascii?Q?pSf10mXmT5fnP9oze5aVqEZsCAG1SwmgDUkwp59rhrOGHRtVjGPFKXBGNayF?=
 =?us-ascii?Q?nTmzS87epIKVFsxiKEiAFklYfS08/tnf6U0Jjg2UeFHM0PurWF6jnRLB8EV7?=
 =?us-ascii?Q?f2cUbSqMg9FVBadxG+2w7HKaYNqcdXUrer5P9FqDnjS6hnnKWRRwrPlKEfmx?=
 =?us-ascii?Q?2R86FuIZQIpzL8ivicg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2d2ef7-0121-4f7e-2dc3-08db61f35b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 16:23:23.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUEZJIhB4XAp3tczkax/+5OlBWohJy+64S3iTLBx5oIwM85RPN7OCm2Bf1acJ/H6GTJaq5Tz4h5O+rhZQ/5Jyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I get that we have to support v1 and v2 for backward compatibility, but f=
or the point no.2
> made by Tony -=20
> "2) Incremental systems that have both V1 and V2 interfaces.",
> just wanted to understand if we expect any use case where if EINJ V2 is s=
upported, both v1
> and v2 interfaces shall be required at the same time for error injection,=
 as from the spec,
> if V2 is supported, EINJV2_SET_ERROR_TYPE takes precedence.
>
> This seems to be similar with V1 action types - whether to go with SET_ER=
ROR_TYPE_WITH_ADDRESS or
> SET_ERROR_TYPE, is based on the action entry in the EINJ table where "SET=
_ERROR_TYPE_WITH_ADDRESS"
> gets precedence.

I don't think it will be required to support users mix and matching v1 and =
v2 in the middle of an injection.
So will need some locking between the einj/error_inject and the einjv2/erro=
r_inject action phase.

I'd still like to see the einjv2 injection supply all parameters in a singl=
e write to a debugfs file
and have the driver parse the values.

E.g.

# echo "corrected memory 0x1234567890 notrigger" > /sys/kernel/debug/apei/e=
injv2/error_inject

That would make injection a user-level atomic operation, and avoid all the =
confusion that results
from updating the param1, param2, ... files individually.

-Tony

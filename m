Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC86BF3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCQVZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCQVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:25:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1361DCA26;
        Fri, 17 Mar 2023 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679088304; x=1710624304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpccXvRfZhgmfkJ/RgSdSma+cifq/HkihV7eqOo6/5c=;
  b=R0X6EuTt+G0hJoQbVamzb8XTWGcfc/rjv+tAfgAc4hP3nIkl9l/0GGzb
   Nx/44ZLtlr6ZUNtcM5GzqyrbX1aGCYWTcBidTyL/KcBKcZh6dHRJ1CLan
   RUu89Bd2+o+Ym6v/sQGStw1k/3udUTDKs4u07pOWbgkWB/9iHd8fUP/Wc
   usyVqT6sPNeYoQcNqK2S0bLSMSn5EzBPy1QOGS0YrKoZ+aRF1eZbBfhwC
   hJPqJqlT09Fu/xoWHcFYjBQGCBoAkQcBI7HZALf7W0mA8CfzBNWc9vpxL
   gNzAQJFYncF3SJjKvrHGq2T8osotZYaykHtnP/3+4yupV09x4bGXuZgIK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="335860821"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="335860821"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 14:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="926273084"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="926273084"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 17 Mar 2023 14:24:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 14:24:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 14:24:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 14:24:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 14:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq6ptKL4Unll96Gh0ERLtjo5ttYVSLgEzTSu88Gw6oZOyiNozTDgr10OU5Wiwu34P69u5qBydTwUW5i5ECWkxDuHOOLb5oGz2e3C81fPH9Ap6nrLcfUT0N/lOmIO00TkLNlTFfMve+P7+gQ48+pJCHJsRMSi3hrklE/p0EKduwj2SkErtTJfL31g6J+dzxFk67psOvD6YCr/bu9azhawdW/O5t0nQeTE+dB+dZwOm5I8B572rZy/c5+tL5IxMzG+EhpAIpk/+VxjD3oA8AHw7/4dShj9iwDr9sJhtsRxLXY4/9xKE2T4i0gdIkXVFUBuvOJBnwXhmFvNtQTpyyVXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qx1nqJf319lrlEkXEgZQMBY3Y73d5vo+GWrhgrBhHE=;
 b=ItYs0QiOM3C+JVY0NdFb2zO5YJNpWx7rF1cgYoPCE1GtsTm7lUFlVIcm35NV1kZozpNQSzmBf37zgiqWeofE4H7AGieCTf2STeeKSzLaHugdVMIOLuP1h+256sTzD8ZxOG3MP49khTvoY0tJxqN4Kr0NIU4OkHjvj85JNKohW8uUcap4XBPleZpbQbaGtRgsw3ZrQ08gRx9OaivlTxEbxaW0IoPZZpNbSHuw2c6tt93VWXznIhtS0Tvjc3GOl+f/pNs1SeGCiDtijBzCntzsVK5ndVFgOieP/m4UJrXOmBzRCeB3xP/RWTnJ9UEIAUlN1oDugB62RkDoYbATZAKU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 21:24:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.024; Fri, 17 Mar 2023
 21:24:25 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Thread-Topic: [PATCH] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
Thread-Index: AQHZWKLi/0R39JELJU+i6OTnfLpOoa7/fDzw
Date:   Fri, 17 Mar 2023 21:24:25 +0000
Message-ID: <SJ1PR11MB60836145DD10108B1FE13A4FFCBD9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20230317073310.4237-1-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: 5ca499a0-02f2-425f-ea78-08db272dfb98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhCeZeft93F8JxpPEetoBu7BRFNwZIEvwU1ccF8QGqqKbGG5+wDBIOzPiCQslYmpg/QwWSzSo45Um4nqdBCjSUdsOOiL+Eq5DJdMPPl5W2OxrJd5k2EPDk8G0D/YjDfAZMTlbRRwUOin/uUOtGf/8g5sHr7UK6i8ukTP/JUn/m7GKLfDgB23gpsTk7xHJm1+St6uQ8m/Bc580EaTuRsWyxUouvNpfakUmPaNdyiwnLRIuFvKSZFjTuLXDi4IXaGvFuttJTFapbtzmZq92jMQ9KPBaPE0qys5c8LtIlr9o/LyggIqlKCq4WRkb0lxqhYJPa9gfSpga0iaqmpueCNdRz0l7TVtlpkrGlqAVyLZo8nqNR0JuzFD+ial13VYdaiz8EHWbKx6xm0C9v6pWDGcuWJ22bHYL+jokQkSn47Nit9TH91ZJ3CMtAKYsnl41LwaVlkIdj07xNAnWyVyXo+UoiicOjR5xdcQLINGVyWAs+oAa/UXLNLxTOU5cz4Q/GxSaA2vRqMc3LksCbpLaeHTzzh6lUPRPzsS7nh4Iu5MAa0kJ0AmxlIWOAJyVfWg5Kyhvag44wq4BfYj3s7cOadRU0L67rK1L3Ckm5YHqo0uHG1RjGoDD42n4VcCLCN4nFRYgIBD+1fQ/bfPjswpQcLfCsaPQdxhhup3LRtsMXENSp/bp54yZG4i+BnlFUjNtbkdBpCzTdpwNUcEX0lMEl4wrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199018)(7416002)(5660300002)(4744005)(6916009)(4326008)(52536014)(66556008)(41300700001)(55016003)(33656002)(86362001)(38070700005)(38100700002)(122000001)(8936002)(82960400001)(2906002)(83380400001)(478600001)(7696005)(71200400001)(186003)(6506007)(9686003)(66476007)(64756008)(66446008)(26005)(66946007)(76116006)(54906003)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?an71zlE/5YrdBbmi95QqesBNYFag0KDDpJgJfjwHqk9fFacQGHkVDSZ/gBGh?=
 =?us-ascii?Q?3fXbb6Z+0zthhZSlxia6lJbm6bmAWma29ej1p5I4mTnFlSb9dU8Y8UbEJAkV?=
 =?us-ascii?Q?HS5b2pPSiWY+Ee7HVchOVsuc05tjCvEObgcZ6QJCahgR6VetZiotMSgHWo0J?=
 =?us-ascii?Q?U4S7Y+j4Axp+KdR2twRVBywvQOKIIm5k4sZejW9OE/WGR2BQ+KH7q8wGk1HN?=
 =?us-ascii?Q?jrqQl3YTAjJaXRhxZJWY/3gKoxW3meAr4K+iqkpSJaiSfXZR3f4L4GaDiE3S?=
 =?us-ascii?Q?XFTdKB5edW45qmbrVzAEljWuykdPMBPJz8HHcSiKk7P4R7F8e3SXkfqZakg9?=
 =?us-ascii?Q?NRth/SN5HZaYe0BzKU1gro+OZ+lgdhGTdj4Vm0GgfTKHuCEGv+PXe6SsYBca?=
 =?us-ascii?Q?VG3R9XDoWfZTuxwtoU9bOBjb6lSaYvjBLzaS0qNZc2j5sADdbe8te9NpOCZ+?=
 =?us-ascii?Q?8LguJ9Ve1TGwHZigVVT74P4TKqBZ2hk8gaXGhuUCN2uLYrhPVvwpeDV0Gmwx?=
 =?us-ascii?Q?lf0wybVdtrCkLZ94Bg7m9SH1FXtbKyzHBXqgjw/yYr2JI1dbgd86VZ0KaumR?=
 =?us-ascii?Q?cwnSiZ4P/Qw366ZQGGgruO6mYr9q+aTZOR1E5t4lftREfnCI2JSeeiL2xDbC?=
 =?us-ascii?Q?0UIgd1dyyHb51cu1rUETQdGTkid2N344RiZWCzqBcj16a1Qfs+WGT8U5GkQU?=
 =?us-ascii?Q?NsmAtN6Xf973qxobBmjHIE6D7FQntR3etqa63xtp4j7CQ/U3g3WbTNKsfLgw?=
 =?us-ascii?Q?5P1Lbc/D8XHlRKYdaQIhcD98/Q1ob7ZK4Y/HPA3LWjAxKPcaWIu9CTcCsKcT?=
 =?us-ascii?Q?DzjbOfQrOK+Wa51B+6kPLWDXi7sX+ezQgp3B3iDiY9qhlNf5NyXT9kWch+td?=
 =?us-ascii?Q?tKDYoTs7cauTedIcXdf/azDiOOy/Eq916giK9WEtkYyiy7lwEMR1YOHhgoxv?=
 =?us-ascii?Q?KB2Zcj7EOW2Rb81YVq7CTkcjnPnqmOIkqSzWqhz7Mw4m9okIkqkTq30HuapF?=
 =?us-ascii?Q?sErtE5qCX8khnBQBjVi7VwdHrgFH36SwiabubRlaq2urOfV6oFQWvCvwGl4H?=
 =?us-ascii?Q?y3NuhLWO9oiX4t3eDvpIPGTWUChjKSCjgPBy9mQFG8CWRbQSKbGjRVQxByCo?=
 =?us-ascii?Q?tGMkpbZN6VC6iYj9hybqYh6KI4/boHaJl3q8oDm3nL6ENZBfyw5TQAL+YYja?=
 =?us-ascii?Q?Dumzj9zGcrpyqcD6agPcHFdMjSxByYONwUgXpOnnMpzP5/OAQbGwLzDAzK7z?=
 =?us-ascii?Q?3SwOR2zKrACpQHfni26phQKRAcrZXvImoTj3Fm1ja2ehiGCrLyaBFjyP2TFv?=
 =?us-ascii?Q?wZz9nKZBzWJKAFaSyE6VtynNCO/urN0zocGcbcVMbV5c2nFfhCjn7H0Ncmrf?=
 =?us-ascii?Q?B7HxooYM8/3h2jnHkhqjULcN0GtmveI63WXKQWAooB3dp+FmS+ztfADDuhi8?=
 =?us-ascii?Q?PN623ybyeEEeKtyE4Iw5HmfDVXvylg2XjQP1ujvdn5MfvcliEz1CNVAdc0BL?=
 =?us-ascii?Q?H6joeNxlPDiH8/vd56/p9eQ7O1BD5xesFrlLglhHX3+vPztfAmcsOtjRxFqd?=
 =?us-ascii?Q?64p0nZFz7EMOGB6ed4vOV6saFJKwiKQYFJ3jxdRN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca499a0-02f2-425f-ea78-08db272dfb98
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 21:24:25.0858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wruY5F77SL7akfbC2EQk8Xn3/UfpvbnSnkkQtixDV/AoACONNUSVl3rx6xaMP0sKrr93OSYfvdjovXKUqVvHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-	if (val !=3D EINJ_STATUS_SUCCESS)
+	if (val =3D=3D EINJ_STATUS_FAIL)
 		return -EBUSY;
+	else if (val =3D=3D EINJ_STATUS_INVAL)
+		return -EINVAL;

The ACPI Specification is really vague here. Documented error codes are

0 =3D Success (Linux #define EINJ_STATUS_SUCCESS)
1 =3D Unknown failure (Linux #define EINJ_STATUS_FAIL)
2 =3D Invalid Access (Linux #define EINJ_STATUS_INVAL)

I don't see how reporting -EBUSY for the "Unknown Failure" case is
actually better.

-Tony

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84E267E523
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjA0M15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjA0M1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:27:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662E5359C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674822384; x=1706358384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ea/m7Hsp/Vz6ctz1d09DB2wIT/RwOEzGVwXKlNLCWK0=;
  b=FpSPdJ7d+7FCS4JOtw08YcqJVNYtZ6Njj1uUGNXkxCaWk7IR+krLacXH
   MTOMkU0tsFsxkOD8DRDPTd2UhEC96xXjYAfPPdabNDRoHyfXpCGjGfFca
   H1FyCEEKi0IEfst0uttGjwfR9yuC1Hl46Nq/vXxg/qvNXEikwt35M4xZs
   Vj3euKtBJc2i4WkOot2lEKwClvkss2cjIXnCv8eCVCl+q2+ff2zzLsd4S
   0hwy8sgw0s+kEcfklPuR0LuDBrLdhamX4UP9oWecAdsyltsiTOOdfKR68
   mh91r7tcqPhxqXr4gX1rP4umxt+XEgqHBBV/0TEJ9pzGrIm4560+LLx2i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306725998"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="306725998"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 04:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="665232296"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="665232296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 04:25:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 04:25:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 04:25:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 04:25:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 04:25:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llq8IOCWSlQMHAZm+m4GpVDZ3sxgSkmjsRTb6ENv23PION1k3QOJ8v7R3LTBROVKeYRzw/Qz+btYBNqKb+evxVfduwhIrZglYzH/jgaRCVnKPoqfeDIjCDgEmjgsUwVPV268nZW6rz27RsXzakyOzanoFmyreBSIXAxDNfMRi1+1OxP4rHceN1iBOBHCFh7JN//qfNV2lC2XCE5hBXDtV3nNtJ02M4sujyYg4LfnbLyplj3vlfZsxhmezr/3v5wjwBzeV/HyA6jhyFuKzYLAF7a82pPoq795s0wuLwq/fnW2dFjiYJHRIS7Wm+YMZTOJ/WUKYWeozs9I/5KTLdwb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea/m7Hsp/Vz6ctz1d09DB2wIT/RwOEzGVwXKlNLCWK0=;
 b=RfyaCw/Dru1Rw45/t61BPrdg+yCgwNJCZXyqZYvIQYP2CDMS2bIVijxg/r0orkYQuOYjyyxWASW/ZbX7IizMx5K/SXk8x20VNzJgtHaaHlMAyg+ranS9Hia2I4Wyht4pmHrfOnqZUR35pMV5PKfcb8cfExTqrvAqJHPzPBRRfvqHEWUeKXSdvWsQNp4hGfkh7ck9YpQuQgDpdxZ2vzimL9QWeNB1VjTL8IgmdOsFubqVt7n2JHXs+GmXRxtSnBuW03rwv0MXZkNPZo7kTHRZfpivC3gUtpZiZ111AQ10ojMF1taqxBDVe9hHHhBBC94A4xigoaNVhxg6d1XTHoRUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SJ0PR11MB5040.namprd11.prod.outlook.com (2603:10b6:a03:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 12:25:10 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 12:25:09 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AANbNtAAAhqAlgAAMw/wAABEXvwA==
Date:   Fri, 27 Jan 2023 12:25:09 +0000
Message-ID: <DM8PR11MB57501BD39CC1E88206E6CD5FE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230126105618-mutt-send-email-mst@kernel.org>
 <DM8PR11MB5750678B5F639F6C2848FC3CE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230127044508-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127044508-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SJ0PR11MB5040:EE_
x-ms-office365-filtering-correlation-id: 92e502c9-6e37-44da-7d69-08db00618815
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NiKrkPYQy3lR2nWw+Sgw3upF7OXvQBKfEr+CBivnD1AsR6NRkUlUVO6PduoZnzQgxSa45luE1l+BwruXWn3QRvtNmn2pyVyV36Ftc8HXKpRJyEJd6lxRq9xxnK09S6m0oFMOtpPVeTNG9W69wI5+FpWLLV/d5Dv0DcXabEK8U95h3bUrmIAdpN+OCEUxfgyn8YJlN43Csifn0lclaxjqWp853hCGXqfd86QBkh/bhlm4/EY7gxameHoLSO6xQneQg+v0lazuAKZnicMGfSD06cg1onfb2huu4JI6Ws/fV82F/D6Ot6oXy1LGHjw4bu04ZT13Q+J17Wxjc084lYwXzkByWg8VO79B/iYasct48/gexbcrCPvPACy2HnnA+7R0D7ZBgBWHi65iATh0SmTRmTRbBvch7bIQYJPNwpyJILxXFoYgnyWZ9pxo7BqZB/zx7IUKD5ivDnoCPtwYO/qVHdBU8rp2tilyncdNHfdY2Zf8rXvBgBTlxrgTn5r7765VR2tIiOSX8f7kOA4A7W/kh//6HJDMcW6DaZ+YXwL9c3zM/KBHCiCWesC2924WuNro/S5bCFGzo2CudK54LxsclxPYdjhIQihIQKnMwHHjOtMkqMtkdWhNksBGC64z66qNhYtPe1CU2KgB1LWh8esBYh42bRRIHExdebXbNk9q+4wV64xabPTrHO9BRiXqzn/4CcPBYMEpZ0BT1oM2GU76nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(478600001)(82960400001)(26005)(9686003)(186003)(83380400001)(76116006)(4326008)(41300700001)(6506007)(8936002)(66446008)(66946007)(66556008)(64756008)(6916009)(66476007)(8676002)(55016003)(38100700002)(7696005)(316002)(122000001)(2906002)(86362001)(71200400001)(5660300002)(33656002)(7416002)(54906003)(52536014)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dThHWmR0Q1g1clBheUVhbThNL2FuWnBsV2ZkZk8vVDFuSHVDS3grZ0lUbzlU?=
 =?utf-8?B?LzJWWnUzWTdBWGVodWRmcEtFMWp4UlU1amltdDZURVczYm56dWxodEtjRDVH?=
 =?utf-8?B?ZmhxallORWhISk52eHVVTmJUMDgvaWFodTMwU2Q1OHZialFGc056MEpiMzdF?=
 =?utf-8?B?WC81UEl4eU9tMXlSbVplcExwVDNHWFEzMFRicFVPSXYrMy9ZZnVVVXN6UWhY?=
 =?utf-8?B?R1BETXRBYW9tNlZkM2V4MEszcHZkRnpIajBVNWFpQzFFaUpDR3R2NUtrcFgv?=
 =?utf-8?B?L0F3K1FicGZCOTZrNWQ0TnlWQ0xFcEl2K1E2UnE3dVBvOGI1NGlSSDJEVW4w?=
 =?utf-8?B?M0lDbFFpd3RaZitpT1J0YjhDb1ZTYWZ5U3REaEIrNXRaZmdNUHN1NXNWbUR4?=
 =?utf-8?B?d2FXL3dianRRditkYmxabnVDUWN2TTg3MDA3T1NHV3hVUFVIbnBaNzRZOGlY?=
 =?utf-8?B?TTdaWkw4YUNLcXk3TE9aRWlPQkdBcDZEbXhBTjU2c0phL3g4VkZYREM2eVRL?=
 =?utf-8?B?VWpNeTkyQjFWT2lKTjZSWmhKV3I0VkRSUWlndXJaaTk4dTRCSnBIa3p2cGM1?=
 =?utf-8?B?UHJaOUoyRnIrQnY3N2YzdHZHeC96c1RJdmI5KzRzWmxzbVpETk9UOTZEdGwr?=
 =?utf-8?B?cCtueFF2WHFoL0JVc2RTRmM1MkJOaGRabWRIT0s2dUxiSldQMS9UYU82RjdT?=
 =?utf-8?B?cHMvNWhNQ0pzUmVnWkYvZUdVaUxsTms4b2lmZTJHMmU0TDY4U1U0Zjdqb0Fv?=
 =?utf-8?B?NUdJblkrS2tYdWd6ZE56QmhSMTF0dHBPWTRzSkI5RVdLbmpsVllqR3hPa0Qw?=
 =?utf-8?B?d3Jab1pXbUl0UDh0MUM3ZTdjUFh3cGxPTU1SSmIwZzhGQzE1UlJWSEU0cHd3?=
 =?utf-8?B?TWRSTGRiMTB6emtCZk0wN3pDOHhwWDh4WlBIc243QzBGb0V6aGRpeW5LeDF3?=
 =?utf-8?B?VGcxYjh0amFGNHAxdjA2K1piMDR3a1lBOVJBVkpjbVJUM0gvd3l1bmJBQUNK?=
 =?utf-8?B?dTNlN1FmSXBjTlR5d1g2UmZrSHhGYlVocDJ6UTgwMWpUbUhHcVdLWjZNL2FC?=
 =?utf-8?B?Zk9qWkhnc2ZnaUU1cjNadjJHaFJvekdvQW5laVMyR3VMR2JMQ0xaQkUzMlBv?=
 =?utf-8?B?cUMxM3BXMkdCZzZXZFBlenduSzVIbG16U2NlZStnZERjTVREa0ZNL3YzcVVq?=
 =?utf-8?B?Q0owQjlPeGcyeVF1ak5OT09nakluTlZTZW56Sml0TUY0cWpubDBYQ2NJR2hn?=
 =?utf-8?B?dGUyRzFUblhSNEdLNCthdTh1Y09ad0gyZHpXZXgrNDZEclJvQlpIVHJScVJr?=
 =?utf-8?B?QXY0NmFVbGVkelhjTld6WTZvZEZHbU85MHViRFdHUGo4a0cvOXJzc1JvTlBv?=
 =?utf-8?B?TXNDU2pBSFg2aHNwMFh2bjEvbG5nL0lJdzF2YkU1cm56MS9ZMm1GeEN2T25H?=
 =?utf-8?B?YWxNQXA4bFB1UXRSUWRVd1lLcUR4bWw3NXA3Zk1GYmN0ZXJsTk5VTlFzcDVJ?=
 =?utf-8?B?dWZkdk42S3d6Yno5dXgycXpxVkZ3SW5RRkxURGhaUEIxYy9kYkR2a1ozbExx?=
 =?utf-8?B?ZXM0Tk5IQkhCdG1ZTXdLcW9lcnoyZ3JGdkxKMzdoNHIxaHhKWjFtUDFsRDBQ?=
 =?utf-8?B?d0FRcEVic041OEMxWUdtcVB3Q1Qva2d3QzZoRjhSRWZNN2haeWxYZElRNmdS?=
 =?utf-8?B?ZWhoaWtJU3dJcXdEdVBGbHRsQlMzYURLNEd4aGlQL1VENEkxSXdyV3B1ZzJ3?=
 =?utf-8?B?Rk5RSElQdndiV0NNbFYxT2VTY1had1d3amwrRWdRWHl6MUtrMXhJOFZSMWVa?=
 =?utf-8?B?RUZkSVMxZXdPT0VtaW4vL1RDSnYwa3R6Y2lyM1YrbW4raXJoVDJwZlNDRWN6?=
 =?utf-8?B?dDJJYU1lQUpYZnUwN3hDdVB0cXN5QXloT1BUYlFjMnZXS2g2RUgxNndSZk1j?=
 =?utf-8?B?UkxyWGk1L0lzUHpmOWJUV2tFZXJDZGI5ODI1NzZLcVR3Q0lsTFo2bzlRaVBB?=
 =?utf-8?B?WEsrQ1VObnFVVktjWTFzdE1ndGdGWDhVU2p3UDlBSFd2UWZLRGI1MGRndVpy?=
 =?utf-8?B?Sm1zSnNrellBWTdpdytxcHVGcWxEOUJVaGpJaW9Bb21OWm5MNVpFZEgzNURH?=
 =?utf-8?Q?kDUPZWVCBY2QQ2m+uKD+dAZQ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e502c9-6e37-44da-7d69-08db00618815
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 12:25:09.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWQJpJ6VxEkAn4y9UU6da24Lwy/VdY1hk0r8dbTm+fY6T1i+ygj6wf9vB/BQ/UXVjg63G6xDrp2K4IkkcCkN6lkdOHcaA1iDlx6gLaEmX6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5040
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEZyaSwgSmFuIDI3LCAyMDIzIGF0IDA4OjUyOjIyQU0gKzAwMDAsIFJlc2hldG92YSwg
RWxlbmEgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEphbiAyNSwgMjAyMyBhdCAwMzoyOTowN1BNICsw
MDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3RlOg0KPiA+ID4gPiBBbmQgdGhpcyBpcyBhIHZlcnkg
c3BlY2lhbCBhc3BlY3Qgb2YgJ2hhcmRlbmluZycgc2luY2UgaXQgaXMgYWJvdXQgaGFyZGVuaW5n
IGENCj4gPiA+IGtlcm5lbA0KPiA+ID4gPiB1bmRlciBkaWZmZXJlbnQgdGhyZWF0IG1vZGVsL2Fz
c3VtcHRpb25zLg0KPiA+ID4NCj4gPiA+IEkgYW0gbm90IHN1cmUgaXQncyB0aGF0IHNwZWNpYWwg
aW4gdGhhdCBoYXJkZW5pbmcgSU1ITyBpcyBub3QgYSBzcGVjaWZpYw0KPiA+ID4gdGhyZWF0IG1v
ZGVsIG9yIGEgc2V0IG9mIGFzc3VtcHRpb25zLiBJSVVDIGl0J3MganVzdCBzb21ldGhpbmcgdGhh
dA0KPiA+ID4gaGVscHMgcmVkdWNlIHNldmVyaXR5IG9mIHZ1bG5lcmFiaWxpdGllcy4gIFNpbWls
YXJseSwgb25lIGNhbiB1c2UgdGhlIENDDQo+ID4gPiBoYXJkd2FyZSBpbiBhIHZhcmlldHkgb2Yg
d2F5cyBJIGd1ZXNzLiBBbmQgb25lIHdheSBpcyBqdXN0IHRoYXQgLQ0KPiA+ID4gaGFyZGVuaW5n
IGxpbnV4IHN1Y2ggdGhhdCBhYmlsaXR5IHRvIGNvcnJ1cHQgZ3Vlc3QgbWVtb3J5IGRvZXMgbm90
DQo+ID4gPiBhdXRvbWF0aWNhbGx5IGVzY2FsYXRlIGludG8gZ3Vlc3QgY29kZSBleGVjdXRpb24u
DQo+ID4NCj4gPiBJIGFtIG5vdCBzdXJlIGlmIEkgZnVsbHkgZm9sbG93IHlvdSBvbiB0aGlzLiBJ
IGRvIGFncmVlIHRoYXQgaXQgaXMgaW4gcHJpbmNpcGxlDQo+ID4gdGhlIHNhbWUgJ2hhcmRlbmlu
ZycgdGhhdCB3ZSBoYXZlIGJlZW4gZG9pbmcgaW4gTGludXggZm9yIGRlY2FkZXMganVzdA0KPiA+
IGFwcGxpZWQgdG8gYSBuZXcgYXR0YWNrIHN1cmZhY2UsIGhvc3QgPC0+IGd1ZXN0LCB2cyB1c2Vy
c3BhY2UgPC0+a2VybmVsLg0KPiANCj4gU29ycnkgYWJvdXQgYmVpbmcgdW5jbGVhciB0aGlzIGlz
IG5vdCB0aGUgdHlwZSBvZiBoYXJkZW5pbmcgSSBtZWFudA0KPiByZWFsbHkuICBUaGUgImhhcmRl
bmluZyIgeW91IG1lYW50IGlzIHByZXZlbnRpbmcga2VybmVsIHZ1bG5lcmFiaWxpdGllcywNCj4g
cmlnaHQ/IFRoaXMgaXMgd2hhdCB3ZSd2ZSBiZWVuIGRvaW5nIGZvciBkZWNhZGVzLg0KPiBCdXQg
SSBtZWFudCBzbGlnaHRseSBuZXdlciB0aGluZ3MgbGlrZSBlLmcuIEtBU0xSIG9yIGluZGVlZCBB
U0xSIGdlbmVyYWxseSAtDQo+IHdlIGFyZSB0cnlpbmcgdG8gcmVkdWNlIGEgY2hhbmNlIGEgdnVs
bmVyYWJpbGl0eSBjYXVzZXMgcmFuZG9tDQo+IGNvZGUgZXhlY3V0aW9uIGFzIG9wcG9zZWQgdG8g
YSBET1MuIFRvIHRoaW5rIGluIHRoZXNlIHRlcm1zIHlvdSBkbyBub3QNCj4gbmVlZCB0byB0aGlu
ayBhYm91dCBhdHRhY2sgc3VyZmFjZXMgLSBpbiB0aGUgc3lzdGVtIGluY2x1ZGluZw0KPiBhIGh5
cGVydmlzb3IsIGd1ZXN0IHN1cGVydmlzb3IgYW5kIGd1ZXN0IHVzZXJzcGFjZSBoaWRpbmcNCj4g
b25lIGNvbXBvbmVudCBmcm9tIG90aGVycyBpcyBoZWxwZnVsIGV2ZW4gaWYgdGhleSBzaGFyZQ0K
PiBhIHByaXZlbGVnZSBsZXZlbC4NCg0KRG8geW91IG1lYW4gdGhhdCB0aGUgZmFjdCB0aGF0IENv
Q28gZ3Vlc3QgaGFzIG1lbW9yeSBlbmNyeXB0ZWQNCmNhbiBoZWxwIGV2ZW4gaW4gbm9uLUNvQ28g
c2NlbmFyaW9zPyBJIGFtIHNvcnJ5LCBJIHN0aWxsIHNlZW0gbm90IHRvIGJlIGFibGUNCnRvIGdy
YXNwIHlvdXIgaWRlYSBmdWxseS4gV2hlbiB0aGUgcHJpdmlsZWdlIGxldmVsIGlzIHNoYXJlZCwg
dGhlcmUgaXMgbm8NCmluY2VudGl2ZSB0byBwZXJmb3JtIHByaXZpbGVnZSBlc2NhbGF0aW9uIGF0
dGFja3MgYWNyb3NzIGNvbXBvbmVudHMsDQpzbyB3aHkgaGlkZSB0aGVtIGZyb20gZWFjaCBvdGhl
cj8gRGF0YSBwcm90ZWN0aW9uPyBCdXQgSSBkb27igJl0IHRoaW5rIHlvdQ0KYXJlIHRhbGtpbmcg
YWJvdXQgdGhpcz8gSSBkbyBhZ3JlZSB0aGF0IEtBU0xSIGlzIHN0cm9uZ2VyIHdoZW4geW91IHJl
bW92ZQ0KdGhlIHBvc3NpYmlsaXR5IHRvIHJlYWQgdGhlIG1lbW9yeSAobWFrZSBzdXJlIGtlcm5l
bCBjb2RlIGlzIGV4ZWN1dGUgb25seSkNCnlvdSBhcmUgdHJ5aW5nIHRvIGF0dGFjaywgYnV0IGFn
YWluIG5vdCBzdXJlIGlmIHlvdSBtZWFuIHRoaXMuIA0KDQo+IA0KPiANCj4gDQo+ID4gSW50ZXJm
YWNlcyBoYXZlIGNoYW5nZWQsIGJ1dCB0aGUgdHlwZXMgb2YgdnVsbmVyYWJpbGl0aWVzLCBldGMg
YXJlIHRoZSBzYW1lLg0KPiA+IFRoZSBhdHRhY2tlciBtb2RlbCBpcyBzb21ld2hhdCBkaWZmZXJl
bnQgYmVjYXVzZSB3ZSBoYXZlDQo+ID4gZGlmZmVyZW50IGV4cGVjdGF0aW9ucyBvbiB3aGF0IGhv
c3QvaHlwZXJ2aXNvciBzaG91bGQgYmUgYWJsZSB0byBkbw0KPiA+IHRvIHRoZSBndWVzdCAoZm9s
bG93aW5nIGJ1c2luZXNzIHJlYXNvbnMgYW5kIHVzZS1jYXNlcyksIHZlcnN1cyB3aGF0IHdlDQo+
ID4gZXhwZWN0IG5vcm1hbCB1c2Vyc3BhY2UgYmVpbmcgYWJsZSB0byAiZG8iIHRvd2FyZHMga2Vy
bmVsLiBUaGUgaG9zdCBhbmQNCj4gPiBoeXBlcnZpc29yIHN0aWxsIGhhcyBhIGxvdCBvZiBjb250
cm9sIG92ZXIgdGhlIGd1ZXN0IChhYmlsaXR5IHRvIHN0YXJ0L3N0b3AgaXQsDQo+ID4gbWFuYWdl
IGl0cyByZXNvdXJjZXMsIGV0YykuIEJ1dCB0aGUgcmVhc29ucyBiZWhpbmQgdGhpcyBkb2VzbuKA
mXQgY29tZQ0KPiA+IGZyb20gdGhlIGZhY3QgdGhhdCBzZWN1cml0eSBDb0NvIEhXIG5vdCBiZWlu
ZyBhYmxlIHRvIHN1cHBvcnQgdGhpcyBzdHJpY3Rlcg0KPiA+IHNlY3VyaXR5IG1vZGVsIChpdCBj
YW5ub3Qgbm93IGluZGVlZCwgYnV0IHRoaXMgaXMgYSBkZXNpZ24gZGVjaXNpb24pLCBidXQNCj4g
PiBmcm9tIHRoZSBmYWN0IHRoYXQgaXQgaXMgaW1wb3J0YW50IGZvciBDbG91ZCBzZXJ2aWNlIHBy
b3ZpZGVycyB0byByZXRhaW4gdGhhdA0KPiA+IGxldmVsIG9mIGNvbnRyb2wgb3ZlciB0aGVpciBp
bmZyYXN0cnVjdHVyZS4NCj4gDQo+IFN1cmVseSB0aGV5IG5lZWQgYWJpbGl0eSB0byBjb250cm9s
IHJlc291cmNlIHVzYWdlLCBub3QgYWJpbGl0eSB0byBleGVjdXRlIERPUw0KPiBhdHRhY2tzLiBD
dXJyZW50IGhhcmR3YXJlIGp1c3QgZG9lcyBub3QgaGF2ZSBhYmlsaXR5IHRvIGFsbG93IHRoZSBm
b3JtZXINCj4gd2l0aG91dCB0aGUgbGF0ZXIuDQoNCkkgZG9u4oCZdCBzZWUgd2h5IGl0IGNhbm5v
dCBiZSBhZGRlZCB0byBIVyBpZiByZXF1aXJlbWVudCBjb21lcy4gSG93ZXZlciwgSSB0aGluayAN
CmluIGNsb3VkIHByb3ZpZGVyIHdvcmxkIGJlaW5nIGFibGUgdG8gY29udHJvbCByZXNvdXJjZXMg
ZXF1YWxzIHRvIGJlaW5nIGFibGUNCnRvIGRlbnkgdGhlc2UgcmVzb3VyY2VzIHdoZW4gcmVxdWly
ZWQsIHNvIGJlaW5nIGFibGUgdG8gZGVuaWFsIG9mIHNlcnZpY2UgaXRzIGNsaWVudHMNCmlzIGtp
bmQgb2YgYnVpbGQtaW4gZXhwZWN0YXRpb24gdGhhdCBldmVyeW9uZSBqdXN0IGFncmVlcyBvbi4g
IA0KDQo+IA0KPiA+ID4NCj4gPiA+IElmIHlvdSBwdXQgaXQgdGhpcyB3YXksIHlvdSBnZXQgdG8g
cGFydGljaXBhdGUgaW4gYSB3ZWxsIHVuZGVyc3Rvb2QNCj4gPiA+IHByb2JsZW0gc3BhY2UgaW5z
dGVhZCBvZiBjb25zdGFudGx5IHNheWluZyAieWVzIGJ1dCBDQyBpcyBzcGVjaWFsIi4gIEFuZA0K
PiA+ID4gZnVydGhlciwgeW91IHdpbGwgbm93IHRhbGsgYWJvdXQgZmVhdHVyZXMgYXMgb3Bwb3Nl
ZCB0byBmaXhpbmcgYnVncy4NCj4gPiA+IFdoaWNoIHdpbGwgc3RvcCBhbm5veWluZyBwZW9wbGUg
d2hvIGN1cnJlbnRseSBzZWVtIGFubm95ZWQgYnkgdGhlDQo+ID4gPiBpbXBsaWNhdGlvbiB0aGF0
IHRoZWlyIGNvZGUgaXMgYnVnZ3kgc2ltcGx5IGJlY2F1c2UgaXQgZG9lcyBub3QgY2FjaGUgaW4N
Cj4gPiA+IG1lbW9yeSBhbGwgZGF0YSByZWFkIGZyb20gaGFyZHdhcmUuIEZpbmFsbHksIHlvdSB0
aGVuIGRvbid0IHJlYWxseSBuZWVkDQo+ID4gPiB0byBleHBsYWluIHdoeSBlLmcuIERvUyBpcyBu
b3QgYSBwcm9ibGVtIGJ1dCBpbmZvIGxlYWsgaXMgYSBwcm9ibGVtIC0gd2hlbg0KPiA+ID4gZm9y
IG1hbnkgdXNlcnMgaXQncyBhY3R1YWxseSB0aGUgcmV2ZXJzZSAtIHRoZSByZWFzb24gaXMgbm90
IHRoYXQgaXQncw0KPiA+ID4gbm90IHBhcnQgb2YgYSB0aHJlYXQgbW9kZWwgLSB3aGljaCB0aGVu
IG1ha2VzIHlvdSB3b3JrIGhhcmQgdG8gZGVmaW5lDQo+ID4gPiB0aGUgdGhyZWF0IG1vZGVsIC0g
YnV0IHNpbXBseSB0aGF0IENDIGhhcmR3YXJlIGRvZXMgbm90IHN1cHBvcnQgdGhpcw0KPiA+ID4g
a2luZCBvZiBoYXJkZW5pbmcuDQo+ID4NCj4gPiBCdXQgdGhpcyB3b24ndCBiZSBjb3JyZWN0IHN0
YXRlbWVudCwgYmVjYXVzZSBpdCBpcyBub3QgbGltaXRhdGlvbiBvZiBIVywgYnV0IHRoZQ0KPiA+
IHRocmVhdCBhbmQgYnVzaW5lc3MgbW9kZWwgdGhhdCBDb25maWRlbnRpYWwgQ29tcHV0aW5nIGV4
aXN0cyBpbi4gSSBhbSBub3QNCj4gPiBhd2FyZSBvZiBhIHNpbmdsZSBjbG91ZCBwcm92aWRlciB3
aG8gd291bGQgYmUgd2lsbGluZyB0byB1c2UgdGhlIEhXIHRoYXQNCj4gPiB0YWtlcyB0aGUgZnVs
bCBjb250cm9sIG9mIHRoZWlyIGluZnJhc3RydWN0dXJlIGFuZCBydW5uaW5nIGNvbmZpZGVudGlh
bCBndWVzdHMsDQo+ID4gbGVhdmluZyB0aGVtIHdpdGggbm8gbWVjaGFuaXNtcyB0byBjb250cm9s
IHRoZSBsb2FkIGJhbGFuY2luZywgZW5mb3JjZQ0KPiA+IHJlc291cmNlIHVzYWdlLCBldGMuIFNv
LCBnaXZlbiB0aGF0IG5vYm9keSBuZWVkcy93aWxsaW5nIHRvIHVzZSBzdWNoIEhXLA0KPiA+IHN1
Y2ggSFcgc2ltcGx5IGRvZXNu4oCZdCBleGlzdC4NCj4gPg0KPiA+IFNvLCBJIHdvdWxkIHN0aWxs
IHNheSB0aGF0IHRoZSBtb2RlbCB3ZSBvcGVyYXRlIGluIENvQ28gdXNlY2FzZXMgaXMgc29tZXdo
YXQNCj4gPiBzcGVjaWFsLCBidXQgSSBkbyBhZ3JlZSB0aGF0IGdpdmVuIHRoYXQgd2UgbGlzdCBh
IGNvdXBsZSBvZiB0aGVzZSBzcGVjaWFsDQo+IGFzc3VtcHRpb25zDQo+ID4gKG92ZXIgd2hpY2gg
b25lcyB3ZSBoYXZlIG5vIGNvbnRyb2wgb3IgYWJpbGl0eSB0byBpbmZsdWVuY2UsIG5vbmUgb2Yg
dXMgYXJlDQo+IGJ1c2luZXNzDQo+ID4gcGVvcGxlKSwgdGhlbiB0aGUgcmVzdCBiZWNvbWVzIGp1
c3QgY2FyZWZ1bCBlbnVtZXJhdGlvbiBvZiBhdHRhY2sgc3VyZmFjZQ0KPiBpbnRlcmZhY2VzDQo+
ID4gYW5kIGJyZWFrIHVwIG9mIHBvdGVudGlhbCBtaXRpZ2F0aW9ucy4NCj4gPg0KPiA+IEJlc3Qg
UmVnYXJkcywNCj4gPiBFbGVuYS4NCj4gPg0KPiANCj4gSSdkIHNheSBlYWNoIGJ1c2luZXNzIGhh
cyBhIHNsaWdodGx5IGRpZmZlcmVudCBidXNpbmVzcyBtb2RlbCwgbm8/DQo+IEZpbmRpbmcgY29t
bW9uIGdyb3VuZCBpcyB3aGF0IGhlbHBzIHVzIHNoYXJlIGNvZGUgLi4uDQoNCkZ1bGx5IGFncmVl
LCBhbmQgYSBnb29kIGRpc2N1c3Npb24gd2l0aCBldmVyeW9uZSB3aWxsaW5nIHRvIGxpc3RlbiBh
bmQgY29vcGVyYXRlDQpjYW4gZ28gYSBsb25nIHdheSBpbnRvIGRlZmluaW5nIHRoZSBiZXN0IGlt
cGxlbWVudGF0aW9uLiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuIA0K

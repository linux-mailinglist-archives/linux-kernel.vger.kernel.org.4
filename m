Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6A689B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjBCOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBCOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:09:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A61B330
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675433198; x=1706969198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W85NxQ5IKgg33UNmQGmEsVe7xqqDjCopP0kPWnYaDME=;
  b=dx6ONjPcC+0p+hcbtpwrEXJRtIndjFRQEhDilFu+8PezdRvyeyPAtDSW
   vzTVA0hAoArgFgGsSt8nMqE2YWQVRa8aT1TxnHQudEYoE7ttbY3u4R1tq
   EZpfmpdGi8U7Z+hizov4s2WK0Ql2mU/HrUTQI1VWnCZ2L70KXageukzwV
   f4+keZQvgVIWddMhfYQy1pGHv4aj2Gl2fEu/oBiCmfqJD/xedoIYy5ha9
   luXiO2uLsjTH36ypR69ndIY8LTuL2Fa5GZuP1EXdWWJgkJ9ot3t50ZBQI
   v0A7++WjaNiUm4KBGDAA5yqxy7RJF0R+1SqlxUrwu3evX5OIq19TRpm3f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="330039403"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="330039403"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 06:06:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="667655604"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="667655604"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2023 06:06:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 06:06:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 06:06:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 06:06:01 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 06:06:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEIO7MJ3u+KJAbgly1Ho0Yyj6E1y2ol7i3XsbogJmWggmxNeDDNOg2jq2c+zgmGYttkLnZig1qxw9Cjdn9F4+RZHkOxQcIWCpBiaeT2c1PbWm1JUGX/BLOkKpouOYdYWinMMl/MF5MZA1n34XY251D5zxJ5QAm+a8w83eKBfJ9XlvmWKc9zrohfVpH3j4I4M2TyIwbu/Wipm6i1YHg2yBbJcHJEwWQ01ux/XMkU7P77CMczo8wMVmFQgiE6do0jC4NjZLg9xo7j9P6gDS4MzgLjsWYOQXNwpEhF/VnBhJnQo992Q7oWP5Y2QIT1Y6Ge+xOUdcBk1KNLqm/CPRaLxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W85NxQ5IKgg33UNmQGmEsVe7xqqDjCopP0kPWnYaDME=;
 b=W4qe8+0OxzSC/+JGXTZj/QEIwjx/HKO7Y4sGOk9MfXao030Dg5/o92QXRncPaQ49FiJYj5hB+Bly5YVIHXyTHGG7xao0ILgajegboh1HbILvu1crTj7ZDHldwWji8etHV4n3/uy2wi3E9iwFHU0srQn538sj99z7NCc39EeJPpsd6QEBGZCYn7lE2egECWp4k/tn4zTJciOjYq+jZpSfB43cBR9VZRwZwAYEMD4RqGPCbAwE9Q5KOfEboOuwm5534+3bdvLgpPerGAY6MtRHfii+m/1pVzoMbsr5dzkPn4cml6X4u42T978+1ozXwKBaGVQTjmfG61xRcrnNcXsFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.29; Fri, 3 Feb 2023 14:05:57 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 14:05:56 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEwAAJJbIAAAYhDQAA/PSiAAH3FjMAACv0HgAAuiKcwAGzrbwAAMEi6UA==
Date:   Fri, 3 Feb 2023 14:05:56 +0000
Message-ID: <DM8PR11MB575031CB13ED7347AED1733CE7D79@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9Jh2x9XJE1KEUg6@unreal>
 <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9JyW5bUqV7gWmU8@unreal>
 <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
 <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
 <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230202145154.GA10621@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230202145154.GA10621@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH0PR11MB5109:EE_
x-ms-office365-filtering-correlation-id: 74365d2f-3798-409a-6043-08db05efc536
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FpbI4ouh8e+0SCndUfFU+dhfYDmgJcKcaPOzCUoEsGy96syoj3y6Xz49M0qUN6g4Zb2jioiNMaGtpKP7slUG2oJ77ABMxTD5EAyUDBkNrCetUVMdYct6Rahllhfvfj7DZuXZCDuaV8ZL5/6mCuqCBGokvi+WCf14ZI1gC+zjuK3tFXhcJNiOk2H/0UuT6Q4GoLB9yHl5Ln7c9cOuBGbilX2CSjgPnTYXmDDR2Ndm+LX3YyTcVyFXHyQxuLdHqy++uMpvdOTuDH+Gf0vE/klS+hI0hxaHmllh/0GVGgEWWM7VctEnpF3RCVln1bLV7vKqQM7jMG9MiG54DIe0zd2CBjgfJV5Qs2z//izVAO+tzIsBa7J3g8g4sEU3sme9bza/WvLUK2iVoPCvYNqzJs0p5+ktj5ZyppqbYki+j+fqV5cn0aUrAmb8MSoVRVkSdsPtNH7lM8SoQshfZ5g8PBXra8CUjiRGcMvFmcIhA3TK+Zjuf6q7+zsLzSHBbO9CtTBsiiNGfEaNWHsrwHkvz3Sz9hRZ0iKRLKxWC5/9PrCcezL/SgqP3foNBNv4hsytud0bWJIrqBHn50RmQroxQReMGFYm84h3JQ7TVX+VfPqEpxJUi9LZ9UUTjCL2lzKWDNIMfwUvvnnvKD/zGatDCHdAABjjFY20JxCLNKAc3GUnGlNnU5YeRqIL948e64W5okxPMRsWPUnf27DWo7ipKO+Q1XJa9XOFbW5nFEa5HOG22N4yAcy/zW9F1VscpOLfoOKhGHNd8YHqKUAxT9mUMjCVUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199018)(38070700005)(38100700002)(122000001)(82960400001)(54906003)(5660300002)(316002)(52536014)(7416002)(83380400001)(33656002)(55016003)(86362001)(7696005)(186003)(9686003)(26005)(2906002)(71200400001)(478600001)(966005)(66946007)(64756008)(66556008)(66476007)(4326008)(66446008)(76116006)(6916009)(6506007)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KytFQ21TTDQrb0tCZUtkU0thbkY5WkNVTmQwT2FwWTJpTXZtbGpOUDVsZXVU?=
 =?utf-8?B?L0hkejdrRDJKK2RSamxCZ2FHeG5EdUlha2R4TXlYclBONWZ4VXZkZ0lYN1B1?=
 =?utf-8?B?aE82YjhvMkdPaWN6QnRyaks4Ym5YdXlRUXNVbkVCWWN6Ulg1aFdGV0NDTkxZ?=
 =?utf-8?B?M1c4WkdOQzQ3cG9FY3Z2OU1MbnN5d25PODNLbU5Md1N5bUJVaE5mMWc1b2l0?=
 =?utf-8?B?N282elppU0E2ajgyVmhON1FlR0VrMm5FWWhNZjNzYkJ3ZXdzTTVxT2NVdy9W?=
 =?utf-8?B?dW8vVGY4eHZ1KzRNd1c2MlU5VVNyanlseG1RUkh1aUM1Mmt3dHhtTVlHWllC?=
 =?utf-8?B?UXBtYk11R3kvbjlCSDBYQzFFR040WmRxdVJXWVlqd0VGM2syajRxbEZlY1pu?=
 =?utf-8?B?R3B6dW84aHZESU1ITU9uTkUyUUdxWFhWVjF2VnQwaHFXejgxMHVCcnU0MURv?=
 =?utf-8?B?Ym5LcWdQNHdmM2p0QTIydEtkVzZHSDRqODRNbWhtMEMyYUZQa3pqWHBvd1pw?=
 =?utf-8?B?OTFReVpNd1RVeWFOcEM4U2N4SXh4Rk9ycU9abFN5K1BFU2NoQ2Q1dm4rT1JB?=
 =?utf-8?B?b1BNblNQLzRtc1ovcE5TRXVHWUFlKy83aWRpdzhlZ2hkb0lxQmNaWi81MUxq?=
 =?utf-8?B?b2pZQTVueTl2MmZQMy9QVUlSZ2Vnc1RiNWpsbVlUTUd4YU04eDhVTUdvZzdQ?=
 =?utf-8?B?Um1Lem4yblNIY3ZnNDc1cG5jbWFmRzhYZHRnS1IxVVRJbE1uVkxQTzR3cjZJ?=
 =?utf-8?B?MzI1blRkaWVNM2VZeWtJRTV6TDVISVVnMzNWb0R3aXV3eStUQ09PS3FZM0xi?=
 =?utf-8?B?dHdBTHJvUCt6N2ZIVkwya25SQlVpRzdqb3RDQ1NPZ3pwY0Q4Z2ZoWDNQT3RY?=
 =?utf-8?B?U2pnTmRHLzZLZzdxQVUxY052eFd0TTVPcXZ1N29KaW53SThEVmlkYitoTkRx?=
 =?utf-8?B?WWtMeGI5YS8wWng2S2h1bjVYVjd5SHg2QXMwMFBiaXIwNFMvNVBEVElIdzlX?=
 =?utf-8?B?R2hZNktsakN6RXhIajZUU3hWcndRbzByNTBoYzVPS2dCSTUrYmxmNnE2Tmkv?=
 =?utf-8?B?VmVQT2VQSlIrbGJ4NEVBN0dNUVNEbGptTjQ1ZUZ2RDJKUTZtVmlBOEtZQkpD?=
 =?utf-8?B?bnd4SWpFa1JBU3hnWm0xSFloQTFUSGI0OEhWVDBoaEFMYjRHSGxITWt0aVgr?=
 =?utf-8?B?dkRUMDV5czgzdXJ6alEwV1k2SjlPQmJOSEs5akVDSVJkYTNTL2pPY3hHbXA5?=
 =?utf-8?B?ZGw2NzZSd3RXOXIzR2VUWGZUNmw0YVFKNjZnT0VBN3ZmTkllVnE4VmlLdW5o?=
 =?utf-8?B?eWxKOUxyWmNSeWJvMUk4TlV1UUNxQmRkd1hWWTQ3bjRaZkU4YUJyUGswdXNI?=
 =?utf-8?B?cFYxaHRnbkxUR2grcXFQUVBvTTdtQS9nMTlTR2lod3JmWG1uSzRDeHJ6TlM5?=
 =?utf-8?B?cUJieE1FQjNXQ0IxRnFPbVIyTXZGaFdLRFNkMUlma08wNHY2b3pTOHh1L0dt?=
 =?utf-8?B?SjJsc1lYaTV5eFdKR1lvN1E1SjN4ckNxWFJrK2tjYWdwUDRLaUVYcjZweEpi?=
 =?utf-8?B?bEFjVlpuVzRhMkdSd09zQk4zOSt5RWdhdjJVaDNsdzNlS3I4bFo2VnVoQVdD?=
 =?utf-8?B?V2ZncG93UXMxQ0hyZGU3QUJ6U2w2cUV5c0wvZHh1VHhqWUNvTGNiT2dsNTJj?=
 =?utf-8?B?UUVTV203cGdPQWJodmxDVHljcEtUbDcyRTV4cm93ZTlaa0FLWlFRcER2NFlx?=
 =?utf-8?B?WStRc3JldExoMFlySWY1WWVNQ29YZWlIYUdXdHdnZktqZjNDN0pjS1V3ZWlH?=
 =?utf-8?B?UlRQczBkK0g4akZJNkRTdnZ6ejJlWm1wa0VKdkhzYzBPT3Q2Y1VIdEJDVEN4?=
 =?utf-8?B?SUY5eFduU2M1TmJ5WFNDZksyTWs1YjIxKzNtVmk1V1VtVXJ1VUJNejVBbVV2?=
 =?utf-8?B?ZUMzaDBwVE9JWklWUEVKWjNHbW5hcVg0VWx1QURueXJkNldxRFhocWxjc2s1?=
 =?utf-8?B?QW8zeFFOWXdnTzQ0aWR3aHdKWFRzeVlJYTNhUVRIRHljWnQ3cXR6UDdZSlF0?=
 =?utf-8?B?dHBOVmVObklQYWZnNFJJc2hrbFp2R3NCeTRMQi9tL0tJeGVNN3NvdjZ3SXJo?=
 =?utf-8?Q?ojqPNaDseehpSd5Po56tR8y79?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74365d2f-3798-409a-6043-08db05efc536
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 14:05:56.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LVXodqk7xMe16S1jVEL3Ox8FoDShT0yDVEdfLHEmf7/bqDc9k0Sp3+ZhyQNM1nawO+2CvOVdRQp1EwPpA2SzkyO+Igtzlu4+XgYniJqelg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
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

DQo+IE9uIFR1ZSwgSmFuIDMxLCAyMDIzIGF0IDExOjMxOjI4QU0gKzAwMDAsIFJlc2hldG92YSwg
RWxlbmEgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDIwMjMtMDEtMzAgYXQgMDc6NDIgKzAwMDAsIFJl
c2hldG92YSwgRWxlbmEgd3JvdGU6DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+IFRoZSBiaWcgdGhy
ZWF0IGZyb20gbW9zdCBkZXZpY2VzIChpbmNsdWRpbmcgdGhlIHRodW5kZXJib2x0DQo+ID4gPiA+
ID4gY2xhc3NlcykgaXMgdGhhdCB0aGV5IGNhbiBETUEgYWxsIG92ZXIgbWVtb3J5LsKgIEhvd2V2
ZXIsIHRoaXMgaXNuJ3QNCj4gPiA+ID4gPiByZWFsbHkgYSB0aHJlYXQgaW4gQ0MgKHdlbGwgdW50
aWwgUENJIGJlY29tZXMgYWJsZSB0byBkbyBlbmNyeXB0ZWQNCj4gPiA+ID4gPiBETUEpIGJlY2F1
c2UgdGhlIGRldmljZSBoYXMgc3BlY2lmaWMgdW5lbmNyeXB0ZWQgYnVmZmVycyBzZXQgYXNpZGUN
Cj4gPiA+ID4gPiBmb3IgdGhlIGV4cGVjdGVkIERNQS4gSWYgaXQgd3JpdGVzIG91dHNpZGUgdGhh
dCBDQyBpbnRlZ3JpdHkgd2lsbA0KPiA+ID4gPiA+IGRldGVjdCBpdCBhbmQgaWYgaXQgcmVhZHMg
b3V0c2lkZSB0aGF0IGl0IGdldHMgdW5pbnRlbGxpZ2libGUNCj4gPiA+ID4gPiBjaXBoZXJ0ZXh0
LsKgIFNvIHdlJ3JlIGxlZnQgd2l0aCB0aGUgZGV2aWNlIHRyeWluZyB0byB0cmljayBzZWNyZXRz
DQo+ID4gPiA+ID4gb3V0IG9mIHVzIGJ5IHJldHVybmluZyB1bmV4cGVjdGVkIGRhdGEuDQo+ID4g
PiA+DQo+ID4gPiA+IFllcywgYnkgc3VwcGx5aW5nIHRoZSBpbnB1dCB0aGF0IGhhc27igJl0IGJl
ZW4gZXhwZWN0ZWQuIFRoaXMgaXMNCj4gPiA+ID4gZXhhY3RseSB0aGUgY2FzZSB3ZSB3ZXJlIHRy
eWluZyB0byBmaXggaGVyZSBmb3IgZXhhbXBsZToNCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjMwMTE5MTcwNjMzLjQwOTQ0LTItDQo+ID4gPiBhbGV4YW5kZXIuc2hpc2hr
aW5AbGludXguaW50ZWwuY29tLw0KPiA+ID4gPiBJIGRvIGFncmVlIHRoYXQgdGhpcyBjYXNlIGlz
IGxlc3Mgc2V2ZXJlIHdoZW4gb3RoZXJzIHdoZXJlIG1lbW9yeQ0KPiA+ID4gPiBjb3JydXB0aW9u
L2J1ZmZlciBvdmVycnVuIGNhbiBoYXBwZW4sIGxpa2UgaGVyZToNCj4gPiA+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMTE5MTM1NzIxLjgzMzQ1LTYtDQo+ID4gPiBhbGV4YW5k
ZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tLw0KPiA+ID4gPiBCdXQgd2UgYXJlIHRyeWluZyB0
byBmaXggYWxsIGlzc3VlcyB3ZSBzZWUgbm93IChwcmlvcml0aXppbmcgdGhlDQo+ID4gPiA+IHNl
Y29uZCBvbmVzIHRob3VnaCkuDQo+ID4gPg0KPiA+ID4gSSBkb24ndCBzZWUgaG93IE1TSSB0YWJs
ZSBzaXppbmcgaXMgYSBidWcgaW4gdGhlIGNhdGVnb3J5IHdlJ3ZlDQo+ID4gPiBkZWZpbmVkLiAg
VGhlIHZlcnkgdGV4dCBvZiB0aGUgY2hhbmdlbG9nIHNheXMgInJlc3VsdGluZyBpbiBhIGtlcm5l
bA0KPiA+ID4gcGFnZSBmYXVsdCBpbiBwY2lfd3JpdGVfbXNnX21zaXgoKS4iICB3aGljaCBpcyBh
IGNyYXNoLCB3aGljaCBJIHRob3VnaHQNCj4gPiA+IHdlIHdlcmUgYWdyZWVpbmcgd2FzIG91dCBv
ZiBzY29wZSBmb3IgQ0MgYXR0YWNrcz8NCj4gPg0KPiA+IEFzIEkgc2FpZCB0aGlzIGlzIGFuIGV4
YW1wbGUgb2YgYSBjcmFzaCBhbmQgb24gdGhlIGZpcnN0IGxvb2sNCj4gPiBtaWdodCBub3QgbGVh
ZCB0byB0aGUgZXhwbG9pdGFibGUgY29uZGl0aW9uIChhbGJlaXQgYXR0YWNrZXJzIGFyZSBjcmVh
dGl2ZSkuDQo+ID4gQnV0IHdlIG5vdGljZWQgdGhpcyBvbmUgd2hpbGUgZnV6emluZyBhbmQgaXQg
d2FzIGNvbW1vbiBlbm91Z2gNCj4gPiB0aGF0IHByZXZlbnRlZCBmdXp6ZXIgZ29pbmcgZGVlcGVy
IGludG8gdGhlIHZpcnRpbyBkZXZpY2VzIGRyaXZlciBmdXp6aW5nLg0KPiA+IFRoZSBjb3JlIFBD
SS9NU0kgZG9lc27igJl0IHNlZW0gdG8gaGF2ZSB0aGF0IG1hbnkgZWFzaWx5IHRyaWdnZXJhYmxl
DQo+ID4gT3RoZXIgZXhhbXBsZXMgaW4gdmlydGlvIHBhdGNoc2V0IGFyZSBtb3JlIHNldmVyZS4N
Cj4gPg0KPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElmIEkgc2V0IHRoaXMgYXMgdGhlIHBy
b2JsZW0sIHZlcmlmeWluZyBkZXZpY2UgY29ycmVjdCBvcGVyYXRpb24gaXMNCj4gPiA+ID4gPiBh
IHBvc3NpYmxlIHNvbHV0aW9uIChhbGJlaXQgaHVnZWx5IGV4cGVuc2l2ZSkgYnV0IHRoZXJlIGFy
ZSBsaWtlbHkNCj4gPiA+ID4gPiBtYW55IG90aGVyIGNoZWFwZXIgd2F5cyB0byBkZWZlYXQgb3Ig
ZGV0ZWN0IGEgZGV2aWNlIHRyeWluZyB0bw0KPiA+ID4gPiA+IHRyaWNrIHVzIGludG8gcmV2ZWFs
aW5nIHNvbWV0aGluZy4NCj4gPiA+ID4NCj4gPiA+ID4gV2hhdCBkbyB5b3UgaGF2ZSBpbiBtaW5k
IGhlcmUgZm9yIHRoZSBhY3R1YWwgZGV2aWNlcyB3ZSBuZWVkIHRvDQo+ID4gPiA+IGVuYWJsZSBm
b3IgQ0MgY2FzZXM/DQo+ID4gPg0KPiA+ID4gV2VsbCwgdGhlIG1vc3QgZGFuZ2Vyb3VzIGRldmlj
ZXMgc2VlbSB0byBiZSB0aGUgdmlydGlvIHNldCBhIENDIHN5c3RlbQ0KPiA+ID4gd2lsbCByZWx5
IG9uIHRvIGJvb3QgdXAuICBBZnRlciB0aGF0LCB0aGVyZSBhcmUgb3RoZXIgd2F5cyAobGlrZSBT
UERNKQ0KPiA+ID4gdG8gdmVyaWZ5IGEgcmVhbCBQQ0kgZGV2aWNlIGlzIG9uIHRoZSBvdGhlciBl
bmQgb2YgdGhlIHRyYW5zYWN0aW9uLg0KPiA+DQo+ID4gWWVzLCBpdCB0aGUgZnV0dXJlLCBidXQg
bm90IHlldC4gT3RoZXIgdmVuZG9ycyB3aWxsIG5vdCBuZWNlc3NhcnkgYmUNCj4gPiB1c2luZyB2
aXJ0aW8gZGV2aWNlcyBhdCB0aGlzIHBvaW50LCBzbyB3ZSB3aWxsIGhhdmUgbm9uLXZpcnRpbyBh
bmQgbm90DQo+ID4gQ0MgZW5hYmxlZCBkZXZpY2VzIHRoYXQgd2Ugd2FudCB0byBzZWN1cmVseSBh
ZGQgdG8gdGhlIGd1ZXN0Lg0KPiA+DQo+ID4gPg0KPiA+ID4gPiBXZSBoYXZlIGJlZW4gdXNpbmcg
aGVyZSBhIGNvbWJpbmF0aW9uIG9mIGV4dGVuc2l2ZSBmdXp6aW5nIGFuZCBzdGF0aWMNCj4gPiA+
ID4gY29kZSBhbmFseXNpcy4NCj4gPiA+DQo+ID4gPiBieSBmdXp6aW5nLCBJIGFzc3VtZSB5b3Ug
bWVhbiBmdXp6aW5nIGZyb20gdGhlIFBDSSBjb25maWd1cmF0aW9uIHNwYWNlPw0KPiA+ID4gRmly
c3RseSBJJ20gbm90IHNvIHN1cmUgaG93IHVzZWZ1bCBhIHRvb2wgZnV6emluZyBpcyBpZiB3ZSB0
YWtlIE9vcHNlcw0KPiA+ID4gb2ZmIHRoZSB0YWJsZSBiZWNhdXNlIGZ1enppbmcgcHJpbWFyaWx5
IHRyaWdnZXJzIHRob3NlDQo+ID4NCj4gPiBJZiB5b3UgZW5hYmxlIG1lbW9yeSBzYW5pdGl6ZXJz
IHlvdSBjYW4gZGV0ZWN0IG1vcmUgc2VydmVyIGNvbmRpdGlvbnMgbGlrZQ0KPiA+IG91dCBvZiBi
b3VuZHMgYWNjZXNzZXMgYW5kIHN1Y2guIEkgdGhpbmsgZ2l2ZW4gdGhhdCB3ZSBoYXZlIGEgd2F5
IHRvDQo+ID4gdmVyaWZ5IHRoYXQgZnV6emluZyBpcyByZWFjaGluZyB0aGUgY29kZSBsb2NhdGlv
bnMgd2Ugd2FudCBpdCB0byByZWFjaCwgaXQNCj4gPiBjYW4gYmUgcHJldHR5IGVmZmVjdGl2ZSBt
ZXRob2QgdG8gZmluZCBhdCBsZWFzdCBsb3ctaGFuZ2luZyBidWdzLiBBbmQgdGhlc2UNCj4gPiB3
aWxsIGJlIHRoZSBidWdzIHRoYXQgbW9zdCBvZiB0aGUgYXR0YWNrZXJzIHdpbGwgZ28gYWZ0ZXIg
YXQgdGhlIGZpcnN0IHBsYWNlLg0KPiA+IEJ1dCBvZiBjb3Vyc2UgaXQgaXMgbm90IGEgZm9ybWFs
IHZlcmlmaWNhdGlvbiBvZiBhbnkga2luZC4NCj4gPg0KPiA+ICBzbyBpdHMgaGFyZCB0bw0KPiA+
ID4gc2VlIHdoYXQgZWxzZSBpdCBjb3VsZCBkZXRlY3QgZ2l2ZW4gdGhlIHNpZ25hbCB3aWxsIGJl
IHNtb3RoZXJlZCBieQ0KPiA+ID4gb29wc2VzIGFuZCBzZWNvbmRseSBJIHRoaW5rIHRoZSBQQ0kg
aW50ZXJmYWNlIGlzIGxpa2VseSB0aGUgd3JvbmcgcGxhY2UNCj4gPiA+IHRvIGJlZ2luIGFuZCB5
b3Ugc2hvdWxkIHByb2JhYmx5IGJlZ2luIG9uIHRoZSB2aXJ0aW8gYnVzIGFuZCB0aGUNCj4gPiA+
IGh5cGVydmlzb3IgZ2VuZXJhdGVkIGNvbmZpZ3VyYXRpb24gc3BhY2UuDQo+ID4NCj4gPiBUaGlz
IGlzIGV4YWN0bHkgd2hhdCB3ZSBkby4gV2UgZG9u4oCZdCBmdXp6IGZyb20gdGhlIFBDSSBjb25m
aWcgc3BhY2UsDQo+ID4gd2Ugc3VwcGx5IGlucHV0cyBmcm9tIHRoZSBob3N0L3ZtbSB2aWEgdGhl
IGxlZ2l0aW1hdGUgaW50ZXJmYWNlcyB0aGF0IGl0IGNhbg0KPiA+IGluamVjdCB0aGVtIHRvIHRo
ZSBndWVzdDogd2hlbmV2ZXIgZ3Vlc3QgcmVxdWVzdHMgYSBwY2kgY29uZmlnIHNwYWNlDQo+ID4g
KHdoaWNoIGlzIGNvbnRyb2xsZWQgYnkgaG9zdC9oeXBlcnZpc29yIGFzIHlvdSBzYWlkKSByZWFk
IG9wZXJhdGlvbiwNCj4gPiBpdCBnZXRzIGlucHV0IGluamVjdGVkIGJ5IHRoZSBrYWZsIGZ1enpl
ci4gIFNhbWUgZm9yIG90aGVyIGludGVyZmFjZXMgdGhhdA0KPiA+IGFyZSB1bmRlciBjb250cm9s
IG9mIGhvc3QvVk1NIChNU1JzLCBwb3J0IElPLCBNTUlPLCBhbnl0aGluZyB0aGF0IGdvZXMNCj4g
PiB2aWEgI1ZFIGhhbmRsZXIgaW4gb3VyIGNhc2UpLiBXaGVuIGl0IGNvbWVzIHRvIHZpcnRpbywg
d2UgZW1wbG95DQo+ID4gdHdvIGRpZmZlcmVudCBmdXp6aW5nIHRlY2huaXF1ZXM6IGRpcmVjdGx5
IGluamVjdGluZyBrYWZsIGZ1enogaW5wdXQgd2hlbg0KPiA+IHZpcnRpbyBjb3JlIG9yIHZpcnRp
byBkcml2ZXJzIGdldHMgdGhlIGRhdGEgcmVjZWl2ZWQgZnJvbSB0aGUgaG9zdA0KPiA+ICh2aWEg
aW5qZWN0aW5nIGlucHV0IGluIGZ1bmN0aW9ucyB2aXJ0aW8xNi8zMi82NF90b19jcHUgYW5kIG90
aGVycykgYW5kDQo+ID4gZGlyZWN0bHkgZnV6emluZyBETUEgbWVtb3J5IHBhZ2VzIHVzaW5nIGtm
eCBmdXp6ZXIuDQo+ID4gTW9yZSBpbmZvcm1hdGlvbiBjYW4gYmUgZm91bmQgaW4gaHR0cHM6Ly9p
bnRlbC5naXRodWIuaW8vY2NjLWxpbnV4LWd1ZXN0LQ0KPiBoYXJkZW5pbmctZG9jcy90ZHgtZ3Vl
c3QtaGFyZGVuaW5nLmh0bWwjdGQtZ3Vlc3QtZnV6emluZw0KPiA+DQo+ID4gQmVzdCBSZWdhcmRz
LA0KPiA+IEVsZW5hLg0KPiANCj4gSGkgRWxlbmEsDQoNCkhpIEplcmVtaSwgDQoNCj4gDQo+IEkg
dGhpbmsgaXQgbWlnaHQgYmUgYSBnb29kIGlkZWEgdG8gbmFycm93IGRvd24gYSBjb25maWd1cmF0
aW9uIHRoYXQgKmNhbioNCj4gcmVhc29uYWJseSBiZSBoYXJkZW5lZCB0byBiZSBzdWl0YWJsZSBm
b3IgY29uZmlkZW50aWFsIGNvbXB1dGluZywgYmVmb3JlDQo+IHByb2NlZWRpbmcgd2l0aCBmdXp6
aW5nLiBFZy4gYSBsb3Qgb2YgdGltZSB3YXMgc3BlbnQgZGlzY3Vzc2luZyBQQ0kgZGV2aWNlcw0K
PiBpbiB0aGUgY29udGV4dCBvZiB2aXJ0dWFsaXphdGlvbiwgYnV0IHdoYXQgYWJvdXQgdGFraW5n
IFBDSSBvdXQgb2Ygc2NvcGUNCj4gY29tcGxldGVseSBieSBzd2l0Y2hpbmcgdG8gdmlydGlvLW1t
aW8gZGV2aWNlcz8NCg0KSSBhZ3JlZSB0aGF0IG5hcnJvd2luZyBkb3duIGlzIGltcG9ydGFudCBh
bmQgd2Ugc3BlbnQgYSBzaWduaWZpY2FudCBlZmZvcnQNCmluIGRpc2FibGluZyB2YXJpb3VzIGNv
ZGUgd2UgZG9u4oCZdCBuZWVkIChpbmNsdWRpbmcgUENJIGNvZGUsIGxpa2UgcXVpcmtzLCANCmVh
cmx5IFBDSSwgZXRjKS4gVGhlIGRlY2lzaW9uIHRvIHVzZSB2aXJ0aW8gb3ZlciBwY2kgdnMuIG1t
aW8gSSBiZWxpZXZlIGNvbWVzDQpmcm9tIHBlcmZvcm1hbmNlIGFuZCB1c2FnZSBzY2VuYXJpb3Mg
YW5kIHdlIGhhdmUgdG8gYmVzdCB3ZSBjYW4gd2l0aCB0aGVzZQ0KbGltaXRhdGlvbnMuIA0KDQpN
b3Jlb3ZlciwgZXZlbiBpZiB3ZSBjb3VsZCByZW1vdmUgUENJIGZvciB0aGUgdmlydGlvIGRldmlj
ZXMgYnkNCnJlbW92aW5nIHRoZSB0cmFuc3BvcnQgZGVwZW5kZW5jeSwgdGhpcyBpc27igJl0IHBv
c3NpYmxlIGZvciBvdGhlciBkZXZpY2VzIHRoYXQgd2UNCmtub3cgYXJlIHVzZWQgaW4gc29tZSBD
QyBzZXR1cHM6IG5vdCBhbGwgQ1NQcyBhcmUgdXNpbmcgdmlydGlvLWJhc2VkIGRyaXZlcnMsDQpz
byBwcmV0dHkgcXVpY2tseSBQQ0kgY29tZXMgYmFjayBpbnRvIGhhcmRlbmluZyBzY29wZSBhbmQg
d2UgY2Fubm90IGp1c3QgcmVtb3ZlDQppdCB1bmZvcnR1bmF0ZWx5LiANCg0KQmVzdCBSZWdhcmRz
LA0KRWxlbmEuIA0K

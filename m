Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B793682B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAaLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjAaLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:33:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017E212580
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675164796; x=1706700796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SZpW6JEcK1vQahj9TwRgv6LWPDdPPDizbn7fhFQBnb8=;
  b=ZNZp5baLR4kA6qje1enq105hyY5QQvTaq1sh+ytX9Kesl0GMdNYo5dmx
   tZdbrDxfO1rjji1gSpgh4nTRxJT6DvNYZRJEb4V29a+cTDy02Vf3RMMwC
   9yQuECMcTZDMAsn/ieJqlNeCEyJKAJqSmu8c7ZYaUmieibwvPvlhprDnz
   lk0UXIGNKEQILeYsJkw0Pl4SDKb38IcGuCV93jI+p+uezzpXmQ38vpwWJ
   DUHdQwe90OCpFWIoycgdpBxm/vRHxOQB1H4AJAApkku1418yXJeUdxP+7
   X8y3v4p4847jQfHCL3C/2FLxFVC3jzenmPMwHbnS6SNXoWPxMSmBRhlWI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329086943"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="329086943"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 03:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="807083347"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="807083347"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2023 03:31:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 03:31:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 03:31:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 03:31:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 03:31:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhTiVSMYGXGNDSzPJvgh9XdH32LQEZespP0DxomnSjouKbCBHv4pJyRWWtEeF7sV0/xOiWz0X32IEyWGqH8936bQoJu3Bu85DFcPteSyTCP2O5VxZQl9FT0T1tbvkb9mZMoYC/O8Zh0I9u/hqalIKeCoAWUMHq7fwE311SYeEN4aWrADyn7XWilHbm55uh+29/cHmdunomngNa+RFau3EIqVj1SX3Wn+4/hrNSMtRpPqPrrGIozZfQA2/YdP2gLJLVp6/yADMX1zGlAXAsI/ABRv4S99XbEDHgFE1+mMUIiBMUVVDV/XXqlG8Var7Qu6O7N/8qyBohmWzXl3mX0bqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZpW6JEcK1vQahj9TwRgv6LWPDdPPDizbn7fhFQBnb8=;
 b=EpgAO5iZeGeYP6PJmHdv1VFRBEpZ1rERB92ak7wADzHoT0aW0PNspwYWevQSz3WgptrXK64w4t0QnVveCAO32UHFWZ6woSJVROcrWfChdNYqIFfGHpS5Oj/Y2rOZtPd/sdP5PtLvzEDbF8Azyvc3bcpJpHMcModvD5EAEjINGSY984X20IssJQjPxy24w1Rk66bzDqi0oxWbA3RGDDgGOKKwNW7+SKiYuqaWOxXQBVeZaGQIrxiVVQqujREzKvJLZLkEqVnjcZgp3YNzhaqJ+avdl/6joHMrJrnJAFwYHvU0/by1/Peb9DZSCUBG5aPlb0ZKUDB6dE8EB0nRnesbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5401.namprd11.prod.outlook.com (2603:10b6:408:11a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 11:31:29 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 11:31:29 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>
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
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AAKubQgAAALAEwAAJJbIAAAYhDQAA/PSiAAH3FjMAACv0HgAAuiKcw
Date:   Tue, 31 Jan 2023 11:31:28 +0000
Message-ID: <DM8PR11MB575074D3BCBD02F3DD677A57E7D09@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9EkCvAfNXnJ+ATo@kroah.com>
         <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9Jh2x9XJE1KEUg6@unreal>
         <DM8PR11MB5750414F6638169C7097E365E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <Y9JyW5bUqV7gWmU8@unreal>
         <DM8PR11MB57507D9C941D77E148EE9E87E7CF9@DM8PR11MB5750.namprd11.prod.outlook.com>
         <702f22df28e628d41babcf670c909f1fa1bb3c0c.camel@linux.ibm.com>
         <DM8PR11MB5750F939C0B70939AD3CBC37E7D39@DM8PR11MB5750.namprd11.prod.outlook.com>
 <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
In-Reply-To: <220b0be95a8c733f0a6eeddc08e37977ee21d518.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5401:EE_
x-ms-office365-filtering-correlation-id: abb2265a-cdc7-4b17-920e-08db037eb1c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2P067BzrtEgINs3ew6IAXPpYwwaf1omWCMDlcyUT7kzkyn7a+PFQ/VhCY/8SxPibgLt5lFMTy9tapd28l+QDreEUyUnqM8ITGn/lTqNOMnOEjBptHMFwVqt5p4+BKxITunH8hCvIAHhn0IMIgZUvruGIo858j44NeGjCbfgbvj3Oxd3erbpMsUbODpqYQZycRtffoG0Swf7EKrFXpGKYUUaq2pSF9jZlZrd1Cq+vB5bg52Aa4cfTOX4GaZkTfnL6LPSm2KjtN7y/OWlCMK6M29xA/lWg7dqmpLgu8P7x6NemzJJraGqSNxBDWZGdzemtpSybqreUdpuK/iAC3ozkoGkywnAhK1MBdvf8fjbJzEwOZf2QDadFt1lRgtZVSpDXbhhozuz/gi1K56UVLRnUfQGoi2pskqL6GNXqqgP8g5pX/3WnmAxEpAvc5aEEF47ZHOHHHqemuk/FGCNLWjgv8jE55A63TKbTYvL3afLDvUW8iYGRAZ7itO/Vxh0cknIhJZf0ogzCpWi6IgpaTz/srmdCrSwBNyF/BU4ebOEd6X9laNoA9ufwjXwiuviuA/ojUwqRhopRZauuEvcOSbOjUoEUsTafDdXvnOF+8S87ULuWcQmAjNOZbUxpKpCvH91hZ6AFhX4Zxgl8lQbNx/C87YHI+8BEkwD8UyVbKadbutBHAy6dQVLRpZ/yLI3VORUZD6ZLku+L68yO4Ex7RwJsYP1CBmdbHTz9MiFM26QMiEDxwwhAodZ+Iiszq/bLta7e45K83wZZ5HlqT9etnez7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(86362001)(38070700005)(33656002)(38100700002)(122000001)(82960400001)(41300700001)(8936002)(5660300002)(7416002)(52536014)(316002)(110136005)(54906003)(66556008)(66946007)(66446008)(66476007)(64756008)(76116006)(4326008)(8676002)(55016003)(2906002)(83380400001)(7696005)(478600001)(186003)(26005)(9686003)(966005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUFIbGZoNnYzaDVVWTZRMHJQdzRBMFJEamZnRTNlMXUzVFhJWW1GMnhqOXcx?=
 =?utf-8?B?dml4aUROdEttbGoySklNQzZGcmFkaWYzR2NmRVgxa2xYcDc4MEZiRTBaQ2px?=
 =?utf-8?B?QWFFU1hXQWgwUVNyTGFXUStxcW5NQWxIQWw4NkdlSExyLzdqVDFsbEltQTNU?=
 =?utf-8?B?cGJXb05mMlAxTkwxanBVcXNRamszd1BwYjFZTzFLQUlpVDJyT2hJd1FiQi9U?=
 =?utf-8?B?L29DQjloK3F5SURjeDJTSmtzdnpreGFLK09HajRFMnNpdHJaQ2FJT3NSTnF4?=
 =?utf-8?B?RGxEb2E0U1NNbkVqVjh3c3lqZDhhTjBWK1daNWpNS3htbDE2dk9LWjN6R2Rn?=
 =?utf-8?B?NStGcnBpOEtjbVlUejMzYU43b21VQ2dndlRKTHpRRFpjQSsvQ0ZCSFFNVm52?=
 =?utf-8?B?Yy95cGpxTjlRQkNzNWt6d1dyQ0U3Nlk5bjcyb3dEaXcybmQ5M1ZQdFBlelF0?=
 =?utf-8?B?QXlQNmxVb3JvUVdSZ2s2TTdOcGRqWGRRbjE3OEpYeSsvRUd3SjlPY3R4bmIr?=
 =?utf-8?B?a3cwbE9rSXpNV1kva1RzMTN5U1d1K3h3VWpsdElWS0V0YlNIS0pWZC9pQmJC?=
 =?utf-8?B?T2czY0tVY0FPZ01FQUJNcHdNTG9yclJ4dVRXZzE5djFVVkxFZkJpdVExdUkx?=
 =?utf-8?B?Q1lJcktMYitTNVpEWkdlRmhxV1F1UHFmd2xJdTlaRWFpak1iY1BoeFQvNUow?=
 =?utf-8?B?SUR3V002RlQ5Sit5V3g4TFJvL2NkS0hCRDFZWVBqbnFFcElvNlRWOUpTWjNP?=
 =?utf-8?B?ZEd1eVEvNFlnV2l0YVE1dDBJWnF1NC9vY1VaT0gvc3pzTVBUVWNhSkFCb05S?=
 =?utf-8?B?U2FCRmZDclNYR2h4MFlNeUdOVmQvNWhzSGEvTDM4anl4MFpFUUlrZWxQMEh0?=
 =?utf-8?B?a2MveWtoa1Q0M0NvcnR6RzlocW13ODdrVVAvdUZmTVFjV1dhdWNHOWNwYlg5?=
 =?utf-8?B?TndHT3NNZzBVWlU4R1R2dkswbWtBUTMrcUV4cnA0OXRQek53YlAyRUtDd1R3?=
 =?utf-8?B?K1ZHQXlpU040L3hVSklRZUNxcUt6ejMyc0RwRmZmMXMvTVNKV1kxaXJaOVd2?=
 =?utf-8?B?UEZmNmJKZjNMM3JHeDgzWDMyVG5RVTJEdHVCNDM4cU1aZ20wanFNZ0ZoUVF3?=
 =?utf-8?B?NGpUaDdPQnplVjdERnVCeTAwMzNyMmo4U3huUGhZOEFXYWIxZjc4SEZOU2Nr?=
 =?utf-8?B?RVZDUUJXdndyc3oyZHhPSmR0OW9GQTh4UGx0bEh2cVlJNUMwU1pJZ3JtZlUz?=
 =?utf-8?B?eW4vR1BrNkk2eXV5K0N2U29Yam5JMVhsY1dvUlJmRk5EdVB0N0VGTVBFdlJH?=
 =?utf-8?B?WU4weHNGemo1S3d4dUhxQjJ1K2U4REtrYndFSzY4bW5sdzRLZHlsc3BPN1R3?=
 =?utf-8?B?dUN6QlRmWEM4TVFPV1lJcWhYTUF6eVNZem0wSlJ6cjlnWEVYR2IvSEsyN2dZ?=
 =?utf-8?B?NGtHeGtFZk1UaEE2STV6Z3R3ckIzb05Ka2NxQmNuV290OEZHZWZKaGl4ZDdq?=
 =?utf-8?B?UTMwbGI3eGsvMytJZWhOd29GRzMyNUg2ZUpVSWlIVlVmc2VpUUMwcDAvLzhz?=
 =?utf-8?B?WHhyQWRFMW4zNFB4ODJXbFE4M2lRWlZ2elY2aDBEYlA3YzB4RXAwNHdzM3lw?=
 =?utf-8?B?Smt6a3QvVGFZNktaYmdEcTRCbVYzVC9ZN3lOc2Q5TEtzVDVCakZzWDR4dlIv?=
 =?utf-8?B?azRtVHZyWWQxbndZek5VV010Y0hYdjJLSDBXNnpiMEdsZ1JFYnFidDZkRGxD?=
 =?utf-8?B?STJRcmhNeG9laEQwM2x1U2tWcHg2MXdMMmhRRjN6N3hlYnpWN3BPLzlCQWJl?=
 =?utf-8?B?ZExjZElEajU1SFBKbmlJeDBRU244U2pRekZlTUxVUnFsZlV0L2RGUWxzQ0h2?=
 =?utf-8?B?SkF6SEtwU1F5YVJheStRTk9haEZIY0MvbDN2M0hUYS9naUxXWWkxU1NHZEEy?=
 =?utf-8?B?R2FQc3Y0U002aWJVWDBUZ3FZL0pVZWlISFZlTTdPNXNVbnpEQk1iK1V5eE5k?=
 =?utf-8?B?bmd4Y3pJaFlqdE5udjVBYjdPOFk0dGxDMEdpWWtXTlNyUmlTUWVtNHhhcnNi?=
 =?utf-8?B?anF1dlhhL0ZMdXJzYVB4QWpNZm5xNGZNUDhXZmZ0S3ltUkRoL2huOFZ6REx5?=
 =?utf-8?Q?g90r3vw7RCORrqEc/Vp0h6/hb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb2265a-cdc7-4b17-920e-08db037eb1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 11:31:28.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIxHt+i4p7opOx1q8r37kchOvUGEf5uzy6lVaA3eDph7eQX9vtJC76VsMBt1VN+ZxyOvIT8lcVBQ9Y2By/k41jYmcy8gwZQblYQBg1dGwoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5401
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

PiBPbiBNb24sIDIwMjMtMDEtMzAgYXQgMDc6NDIgKzAwMDAsIFJlc2hldG92YSwgRWxlbmEgd3Jv
dGU6DQo+IFsuLi5dDQo+ID4gPiBUaGUgYmlnIHRocmVhdCBmcm9tIG1vc3QgZGV2aWNlcyAoaW5j
bHVkaW5nIHRoZSB0aHVuZGVyYm9sdA0KPiA+ID4gY2xhc3NlcykgaXMgdGhhdCB0aGV5IGNhbiBE
TUEgYWxsIG92ZXIgbWVtb3J5LsKgIEhvd2V2ZXIsIHRoaXMgaXNuJ3QNCj4gPiA+IHJlYWxseSBh
IHRocmVhdCBpbiBDQyAod2VsbCB1bnRpbCBQQ0kgYmVjb21lcyBhYmxlIHRvIGRvIGVuY3J5cHRl
ZA0KPiA+ID4gRE1BKSBiZWNhdXNlIHRoZSBkZXZpY2UgaGFzIHNwZWNpZmljIHVuZW5jcnlwdGVk
IGJ1ZmZlcnMgc2V0IGFzaWRlDQo+ID4gPiBmb3IgdGhlIGV4cGVjdGVkIERNQS4gSWYgaXQgd3Jp
dGVzIG91dHNpZGUgdGhhdCBDQyBpbnRlZ3JpdHkgd2lsbA0KPiA+ID4gZGV0ZWN0IGl0IGFuZCBp
ZiBpdCByZWFkcyBvdXRzaWRlIHRoYXQgaXQgZ2V0cyB1bmludGVsbGlnaWJsZQ0KPiA+ID4gY2lw
aGVydGV4dC7CoCBTbyB3ZSdyZSBsZWZ0IHdpdGggdGhlIGRldmljZSB0cnlpbmcgdG8gdHJpY2sg
c2VjcmV0cw0KPiA+ID4gb3V0IG9mIHVzIGJ5IHJldHVybmluZyB1bmV4cGVjdGVkIGRhdGEuDQo+
ID4NCj4gPiBZZXMsIGJ5IHN1cHBseWluZyB0aGUgaW5wdXQgdGhhdCBoYXNu4oCZdCBiZWVuIGV4
cGVjdGVkLiBUaGlzIGlzDQo+ID4gZXhhY3RseSB0aGUgY2FzZSB3ZSB3ZXJlIHRyeWluZyB0byBm
aXggaGVyZSBmb3IgZXhhbXBsZToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MzAxMTkxNzA2MzMuNDA5NDQtMi0NCj4gYWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNv
bS8NCj4gPiBJIGRvIGFncmVlIHRoYXQgdGhpcyBjYXNlIGlzIGxlc3Mgc2V2ZXJlIHdoZW4gb3Ro
ZXJzIHdoZXJlIG1lbW9yeQ0KPiA+IGNvcnJ1cHRpb24vYnVmZmVyIG92ZXJydW4gY2FuIGhhcHBl
biwgbGlrZSBoZXJlOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDExOTEz
NTcyMS44MzM0NS02LQ0KPiBhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tLw0KPiA+
IEJ1dCB3ZSBhcmUgdHJ5aW5nIHRvIGZpeCBhbGwgaXNzdWVzIHdlIHNlZSBub3cgKHByaW9yaXRp
emluZyB0aGUNCj4gPiBzZWNvbmQgb25lcyB0aG91Z2gpLg0KPiANCj4gSSBkb24ndCBzZWUgaG93
IE1TSSB0YWJsZSBzaXppbmcgaXMgYSBidWcgaW4gdGhlIGNhdGVnb3J5IHdlJ3ZlDQo+IGRlZmlu
ZWQuICBUaGUgdmVyeSB0ZXh0IG9mIHRoZSBjaGFuZ2Vsb2cgc2F5cyAicmVzdWx0aW5nIGluIGEg
a2VybmVsDQo+IHBhZ2UgZmF1bHQgaW4gcGNpX3dyaXRlX21zZ19tc2l4KCkuIiAgd2hpY2ggaXMg
YSBjcmFzaCwgd2hpY2ggSSB0aG91Z2h0DQo+IHdlIHdlcmUgYWdyZWVpbmcgd2FzIG91dCBvZiBz
Y29wZSBmb3IgQ0MgYXR0YWNrcz8NCg0KQXMgSSBzYWlkIHRoaXMgaXMgYW4gZXhhbXBsZSBvZiBh
IGNyYXNoIGFuZCBvbiB0aGUgZmlyc3QgbG9vaw0KbWlnaHQgbm90IGxlYWQgdG8gdGhlIGV4cGxv
aXRhYmxlIGNvbmRpdGlvbiAoYWxiZWl0IGF0dGFja2VycyBhcmUgY3JlYXRpdmUpLg0KQnV0IHdl
IG5vdGljZWQgdGhpcyBvbmUgd2hpbGUgZnV6emluZyBhbmQgaXQgd2FzIGNvbW1vbiBlbm91Z2gN
CnRoYXQgcHJldmVudGVkIGZ1enplciBnb2luZyBkZWVwZXIgaW50byB0aGUgdmlydGlvIGRldmlj
ZXMgZHJpdmVyIGZ1enppbmcuDQpUaGUgY29yZSBQQ0kvTVNJIGRvZXNu4oCZdCBzZWVtIHRvIGhh
dmUgdGhhdCBtYW55IGVhc2lseSB0cmlnZ2VyYWJsZSANCk90aGVyIGV4YW1wbGVzIGluIHZpcnRp
byBwYXRjaHNldCBhcmUgbW9yZSBzZXZlcmUuIA0KDQo+IA0KPiA+ID4NCj4gPiA+IElmIEkgc2V0
IHRoaXMgYXMgdGhlIHByb2JsZW0sIHZlcmlmeWluZyBkZXZpY2UgY29ycmVjdCBvcGVyYXRpb24g
aXMNCj4gPiA+IGEgcG9zc2libGUgc29sdXRpb24gKGFsYmVpdCBodWdlbHkgZXhwZW5zaXZlKSBi
dXQgdGhlcmUgYXJlIGxpa2VseQ0KPiA+ID4gbWFueSBvdGhlciBjaGVhcGVyIHdheXMgdG8gZGVm
ZWF0IG9yIGRldGVjdCBhIGRldmljZSB0cnlpbmcgdG8NCj4gPiA+IHRyaWNrIHVzIGludG8gcmV2
ZWFsaW5nIHNvbWV0aGluZy4NCj4gPg0KPiA+IFdoYXQgZG8geW91IGhhdmUgaW4gbWluZCBoZXJl
IGZvciB0aGUgYWN0dWFsIGRldmljZXMgd2UgbmVlZCB0bw0KPiA+IGVuYWJsZSBmb3IgQ0MgY2Fz
ZXM/DQo+IA0KPiBXZWxsLCB0aGUgbW9zdCBkYW5nZXJvdXMgZGV2aWNlcyBzZWVtIHRvIGJlIHRo
ZSB2aXJ0aW8gc2V0IGEgQ0Mgc3lzdGVtDQo+IHdpbGwgcmVseSBvbiB0byBib290IHVwLiAgQWZ0
ZXIgdGhhdCwgdGhlcmUgYXJlIG90aGVyIHdheXMgKGxpa2UgU1BETSkNCj4gdG8gdmVyaWZ5IGEg
cmVhbCBQQ0kgZGV2aWNlIGlzIG9uIHRoZSBvdGhlciBlbmQgb2YgdGhlIHRyYW5zYWN0aW9uLg0K
DQpZZXMsIGl0IHRoZSBmdXR1cmUsIGJ1dCBub3QgeWV0LiBPdGhlciB2ZW5kb3JzIHdpbGwgbm90
IG5lY2Vzc2FyeSBiZSANCnVzaW5nIHZpcnRpbyBkZXZpY2VzIGF0IHRoaXMgcG9pbnQsIHNvIHdl
IHdpbGwgaGF2ZSBub24tdmlydGlvIGFuZCBub3QNCkNDIGVuYWJsZWQgZGV2aWNlcyB0aGF0IHdl
IHdhbnQgdG8gc2VjdXJlbHkgYWRkIHRvIHRoZSBndWVzdC4NCg0KPiANCj4gPiBXZSBoYXZlIGJl
ZW4gdXNpbmcgaGVyZSBhIGNvbWJpbmF0aW9uIG9mIGV4dGVuc2l2ZSBmdXp6aW5nIGFuZCBzdGF0
aWMNCj4gPiBjb2RlIGFuYWx5c2lzLg0KPiANCj4gYnkgZnV6emluZywgSSBhc3N1bWUgeW91IG1l
YW4gZnV6emluZyBmcm9tIHRoZSBQQ0kgY29uZmlndXJhdGlvbiBzcGFjZT8NCj4gRmlyc3RseSBJ
J20gbm90IHNvIHN1cmUgaG93IHVzZWZ1bCBhIHRvb2wgZnV6emluZyBpcyBpZiB3ZSB0YWtlIE9v
cHNlcw0KPiBvZmYgdGhlIHRhYmxlIGJlY2F1c2UgZnV6emluZyBwcmltYXJpbHkgdHJpZ2dlcnMg
dGhvc2UNCg0KSWYgeW91IGVuYWJsZSBtZW1vcnkgc2FuaXRpemVycyB5b3UgY2FuIGRldGVjdCBt
b3JlIHNlcnZlciBjb25kaXRpb25zIGxpa2UNCm91dCBvZiBib3VuZHMgYWNjZXNzZXMgYW5kIHN1
Y2guIEkgdGhpbmsgZ2l2ZW4gdGhhdCB3ZSBoYXZlIGEgd2F5IHRvIA0KdmVyaWZ5IHRoYXQgZnV6
emluZyBpcyByZWFjaGluZyB0aGUgY29kZSBsb2NhdGlvbnMgd2Ugd2FudCBpdCB0byByZWFjaCwg
aXQNCmNhbiBiZSBwcmV0dHkgZWZmZWN0aXZlIG1ldGhvZCB0byBmaW5kIGF0IGxlYXN0IGxvdy1o
YW5naW5nIGJ1Z3MuIEFuZCB0aGVzZQ0Kd2lsbCBiZSB0aGUgYnVncyB0aGF0IG1vc3Qgb2YgdGhl
IGF0dGFja2VycyB3aWxsIGdvIGFmdGVyIGF0IHRoZSBmaXJzdCBwbGFjZS4gDQpCdXQgb2YgY291
cnNlIGl0IGlzIG5vdCBhIGZvcm1hbCB2ZXJpZmljYXRpb24gb2YgYW55IGtpbmQuDQoNCiBzbyBp
dHMgaGFyZCB0bw0KPiBzZWUgd2hhdCBlbHNlIGl0IGNvdWxkIGRldGVjdCBnaXZlbiB0aGUgc2ln
bmFsIHdpbGwgYmUgc21vdGhlcmVkIGJ5DQo+IG9vcHNlcyBhbmQgc2Vjb25kbHkgSSB0aGluayB0
aGUgUENJIGludGVyZmFjZSBpcyBsaWtlbHkgdGhlIHdyb25nIHBsYWNlDQo+IHRvIGJlZ2luIGFu
ZCB5b3Ugc2hvdWxkIHByb2JhYmx5IGJlZ2luIG9uIHRoZSB2aXJ0aW8gYnVzIGFuZCB0aGUNCj4g
aHlwZXJ2aXNvciBnZW5lcmF0ZWQgY29uZmlndXJhdGlvbiBzcGFjZS4NCg0KVGhpcyBpcyBleGFj
dGx5IHdoYXQgd2UgZG8uIFdlIGRvbuKAmXQgZnV6eiBmcm9tIHRoZSBQQ0kgY29uZmlnIHNwYWNl
LA0Kd2Ugc3VwcGx5IGlucHV0cyBmcm9tIHRoZSBob3N0L3ZtbSB2aWEgdGhlIGxlZ2l0aW1hdGUg
aW50ZXJmYWNlcyB0aGF0IGl0IGNhbiANCmluamVjdCB0aGVtIHRvIHRoZSBndWVzdDogd2hlbmV2
ZXIgZ3Vlc3QgcmVxdWVzdHMgYSBwY2kgY29uZmlnIHNwYWNlDQood2hpY2ggaXMgY29udHJvbGxl
ZCBieSBob3N0L2h5cGVydmlzb3IgYXMgeW91IHNhaWQpIHJlYWQgb3BlcmF0aW9uLCANCml0IGdl
dHMgaW5wdXQgaW5qZWN0ZWQgYnkgdGhlIGthZmwgZnV6emVyLiAgU2FtZSBmb3Igb3RoZXIgaW50
ZXJmYWNlcyB0aGF0IA0KYXJlIHVuZGVyIGNvbnRyb2wgb2YgaG9zdC9WTU0gKE1TUnMsIHBvcnQg
SU8sIE1NSU8sIGFueXRoaW5nIHRoYXQgZ29lcw0KdmlhICNWRSBoYW5kbGVyIGluIG91ciBjYXNl
KS4gV2hlbiBpdCBjb21lcyB0byB2aXJ0aW8sIHdlIGVtcGxveSANCnR3byBkaWZmZXJlbnQgZnV6
emluZyB0ZWNobmlxdWVzOiBkaXJlY3RseSBpbmplY3Rpbmcga2FmbCBmdXp6IGlucHV0IHdoZW4N
CnZpcnRpbyBjb3JlIG9yIHZpcnRpbyBkcml2ZXJzIGdldHMgdGhlIGRhdGEgcmVjZWl2ZWQgZnJv
bSB0aGUgaG9zdCANCih2aWEgaW5qZWN0aW5nIGlucHV0IGluIGZ1bmN0aW9ucyB2aXJ0aW8xNi8z
Mi82NF90b19jcHUgYW5kIG90aGVycykgYW5kIA0KZGlyZWN0bHkgZnV6emluZyBETUEgbWVtb3J5
IHBhZ2VzIHVzaW5nIGtmeCBmdXp6ZXIuIA0KTW9yZSBpbmZvcm1hdGlvbiBjYW4gYmUgZm91bmQg
aW4gaHR0cHM6Ly9pbnRlbC5naXRodWIuaW8vY2NjLWxpbnV4LWd1ZXN0LWhhcmRlbmluZy1kb2Nz
L3RkeC1ndWVzdC1oYXJkZW5pbmcuaHRtbCN0ZC1ndWVzdC1mdXp6aW5nDQoNCkJlc3QgUmVnYXJk
cywNCkVsZW5hLg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EFE607F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJUUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:22:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E2270D24
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666383746; x=1697919746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0AvyuwW18gs3lytWRd0+Ar6ysaSDoe/SthL93sJ1M2Q=;
  b=gpomczGFIChRcyn2tKUYU6+irAJ+LsSCV6a6ui2ZUZLG9JvEm9/KniFI
   P7DYiF15VLzQs0qYFU+Dv1QQhNmbO4ccHBMWIsdqJ3AOZvufbSAeH00aX
   FvOOEPIwmU4wYIRUNjZ1fhXCRM5rSgqDbF1g00/OBzDTxLxYXV3Gwr7go
   5sl5YjBGUDJx+9GDduD3CqXP97Yf6qgcMXOBJ8yNN9+mmckZUQbiyUeFd
   UDy2Xv9pPf0NNKclU65dTMRhFGIggiWI8FFNcNYbaAccMQcdEo/1aBvTo
   +Ext0nMy6+Z/PpU2sivnCDsTeMV+n0fXQmruLq9Z+5mVXzRjfdznsyW+R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="371316456"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="371316456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693860082"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="693860082"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2022 13:22:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 13:22:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 13:22:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 13:22:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 13:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGuoiPzQqzeVpL0UtxT5LtVOW2nxYLBUueIhoH2otWJkojk4BOn4OQhS1R7zhEzeZ4B/gVp368TquQ2Mb/qPu58H1NgGWSeuw/Nv6LdOourplW0U4JT7j7rFWAQ+q4w2nJsObIvslOu7pTOckpAiXcCGEdgw6ClSFFXqSNlCsSKWp7hhHHMirFLMOnA8+bBFLVA8g8HU/WGSv+Q3zMdIMGerNwLHBMvU9Q9aIAb6rgl0EX21gUuIYYwYiyUaxs/Q0Ik2H/AK5lUvtE7PecfnOfCl9DJLq59AwqMH68IRzHqMwMs1PjHQjVZY513+zR47kfFS6zJ1pCYikvTaW7m90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AvyuwW18gs3lytWRd0+Ar6ysaSDoe/SthL93sJ1M2Q=;
 b=TbVD6ueriK41Cvvl5vmQXU6Fh6le61m/Zy0a2MgixJ2RHFso3UvNZNAT4Jw5nNLBzMPBl9VNVvRMy27dC18PSSth1V6zRRYOXZgx0NJoywVtlQHJF4oyP/28B3l+AfzCScf9zpARA5PbhW2QuUaO+VV01NoWfWIothTcTvL38+du3n0RG9IakZlj6bKNoVjEhSFa0zZ8M3+EaI42vj+0mQqPQX65d72PINuk33OvvYNQaUYxRUJRA+z1p7iPGUbFaONP0uI/yBAZo/ZqvQlIC0G/VBYiTivsbU8VKWK4lYe6BnJN0bJBWL7Fhf48xNWK9tmcOIoDN+g8zUzcAdqmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6044.namprd11.prod.outlook.com (2603:10b6:8:63::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Fri, 21 Oct 2022 20:22:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%6]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 20:22:18 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
Subject: RE: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Topic: [RFD] resctrl: reassigning a running container's CTRL_MON group
Thread-Index: AQHY2mKYK8CW+/1gwkudAvXiDjWW/64DEraAgAU6igOAAldkAIAAXYEAgAdrxwCAA2LlAIADjHKAgAAB/zA=
Date:   Fri, 21 Oct 2022 20:22:18 +0000
Message-ID: <SJ1PR11MB6083F027B7065C6DE873F516FC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
In-Reply-To: <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6044:EE_
x-ms-office365-filtering-correlation-id: 094428e7-9c39-44b8-b14f-08dab3a1f3d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTpX5m7q2IgqDrn9wkUTlEFl4xnM8/42O/YKyRqsn7tdSgmamSkt8U1H/I/FULwHVBGdpbcX/0J6RSZuvhVMsDBq/kaegmZBU0HQ7beB/UxbJIctJzzjDNBRlIjJmXdDKbGW/uszFAZCgRQbKEoAAR9Cfhq5ZaJ5mOZJTiFoVi4sl4Wp2g7nlJ5vXq3Ta4OhNI2lkONZ1zCOxagtY84g48AEXBYfGG6k3yoQOeRcBST4M8q2U7qB/2zsuFEBLAlJx244yXr9Nh/A5KurKS3KtddbptY+0nW2X0UdtKipt3M7zR1h9bhsl8Weq8ENL41bK11p5HGqOOO+Y9Yj2p9wMn/4sf4VntAsoxY6xOa/6W7mY4UpsPNAlrA8lZMkVFXBhA38veTk1FGVmKKGsTAdKcYca/XMwX9UqhYoxJZ0yrWbus7yE0bymdPJG44FtAm/FsQzvNAncPHqConaNHICBEoFT6BS2rhQCpbNC99U9HJ8YKt9m1jyghn4Y8ZdNaWcirDi1MtTdwI0AMzb8rgEgBC3MrKUgJZLdExO0XL1y3sfrN+PQsCGDHzY5FWf1GTZBKZtUAi8upemagEd7y9tx45meGeQrMvW+N8B4av1v/5eZ32RjoYrf+8uri9W+yArvjwlXdzwRrQtdCB+TDdJonw9on2Orm2cLfBf9NVBOgwY75mepnKH6q36u+lb3EaJtn8/6pbbAwEhy8KGbxGHMR56Eo9KUSBn3IqcOnPQfDSeou4u7ml8cDa+zYtzc6zdNuLXgFTaAQDbXs9SNEuRJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(122000001)(478600001)(26005)(110136005)(7696005)(55016003)(186003)(9686003)(4744005)(5660300002)(8936002)(66476007)(76116006)(316002)(66946007)(66446008)(64756008)(71200400001)(8676002)(6506007)(4326008)(66556008)(52536014)(41300700001)(54906003)(33656002)(86362001)(38100700002)(82960400001)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWh6SVNoWFZGM0FJZlBrWGlWekc4c0M2ZzRBV1ZRbVFRVGxaSUVFNkgrNEgy?=
 =?utf-8?B?SWc4QXY0dE03b0pFTDJQRC9MK0YzZ01qOTMrS0RDdHRwdTc3N0NpYkpRUXFX?=
 =?utf-8?B?M1pVanJRaHRFM3J0dTlYM3V0dlJQNDVqZmUvUDh2QW1zR0JZdC9LRkgyaEJm?=
 =?utf-8?B?VzhNaFZ2YVNOZk1CSkwyVUZhSWYwY0N4YWFoUnllcTg2eHpWV3liUkVnSGly?=
 =?utf-8?B?c3JacjZUcHk4cUdERUs3djRXYlhSMWdEb1FmVUhWMFJiMUxoNDBHZFQyZnpZ?=
 =?utf-8?B?Vy9RTFk1ci9UVlp3dzZUcXZ3Q3lNU3VQUTNqa2Q2MkExb3lVUk5GZE1rNHJv?=
 =?utf-8?B?UXh2MEo4T3FFSHRyY0M0MDNBMnRpZ3k1N0U4WHpkOVBKK25tN280TUwveGc5?=
 =?utf-8?B?ZHUwNVBDUmV3alJtT0lmOE5wTW0xRm1mbFVUTkhhZmoyZ252b09ldjNvNTc3?=
 =?utf-8?B?VUpnRDEzbzBmYlh1L3BKNDdicUJCZytPMHNVVUJrYVBWQjVpYWNtWUZCQk9C?=
 =?utf-8?B?cmdLWXUvMmdwWFNoMmpIRFEvZFFsK01MWWVDak5FSzJrM1ZOQmZGKzdHMnN4?=
 =?utf-8?B?c1RRTzJOUE1GTW01NnJUWFFCd2pPOUFZYjBQbkplb0dnME5teE5SRDYwTzY3?=
 =?utf-8?B?cXE5RkJCSXZZVlNoSldnQXduL0g4ZTIrVk8yT2RPMzRSdyswbks4bW8wTEk0?=
 =?utf-8?B?NXRtdkNCbWhnd2QxbVgzV21OV0MzQUQzVFdCTkE4M2I2NjA2ck1MMWZ4T2VQ?=
 =?utf-8?B?eXRMM0tLYTR6NmI5Um8vZWpTWTUxZTZrSmtYYWg3eG5JMTNKYzREZG5lMnVJ?=
 =?utf-8?B?Wml1VTlCc01NR1FOY0lZdVJBSGEvc1U5UDBTYjQ3aks4NlM5M0QyYXRZeDYw?=
 =?utf-8?B?K3ljQzAvMjZQbGNSMEM3UnhIZFZkTWhKV1ZQR3BpOGVGclA5TndId0dqcEhp?=
 =?utf-8?B?WUVyRWcvQ3JNcU9pRlpmWFZMVmIycmpDalVsdy9vQnFRZlBWZjNJRjRvUlFn?=
 =?utf-8?B?TmhlWnk3T3JoWURRKzNEd1ZPOUw3MzMyUUdEVVJrbnQ1bnJGNXJteVh3dklx?=
 =?utf-8?B?UUNrRVFoT0xsdUVIWXFUVytObGNZbnU0QU11V3dvajQ5Qkl5eExaL0ViWmpZ?=
 =?utf-8?B?ZEk1YXAxam5QODlvK2h2L2FlWTlqeld5OVUyTWE3bkNxTExZQ2E0YkVZNVV0?=
 =?utf-8?B?M0d1OG9Vam9jSDIwZzFNc1d5WUZiZXNYWkYzMWNoVUNLWUgxYXZWSUtVZWNw?=
 =?utf-8?B?R0JEUVdFV2VVL1g4ZHQ3cHl0V0gzY2JtdnJjVnRKd0p1Q013T3hySktUalFG?=
 =?utf-8?B?aE1wMVUxSUEvdzlza2NHcTd5cTdpQXFwWWorWkZ6R2VuRWJzQytUSEJ4bkVm?=
 =?utf-8?B?ZVdGTEN2dVgycVo1clpXT0tWVTlkL1M0a2ZjQ2FRU05ueUMyUkNkb1V3djM0?=
 =?utf-8?B?MGdSdS9ZaHZteEp5NjA5VWZKUDdQYXc5bUx6U2JFQ3hpUC8vb0JQWFZXZm5E?=
 =?utf-8?B?Y1BtUDJrYXZsbDF3RjM5bkNNeGdkNTdFQ1U5cUVqSXhqZE56NmVqdXE5VjVj?=
 =?utf-8?B?TndzdkFaTElQdXlMa3VsM0NCZXMvM2p4RzBFNlFJeGIyTmFzUzAxQ2wzaGxk?=
 =?utf-8?B?bmZkWDFsVFVoc1N0cFJkQWJKRWZ0ME1DNUtCVzhYOTVjeW1KallTc3ZtcHdZ?=
 =?utf-8?B?MzFSQlBsL0JKV2wzc21Ddm82OGJYdTFCU0k3UWxPOFJUaGNTTGhPcDlxeW4v?=
 =?utf-8?B?eC94Nkx3aW5wWlROZWlKQ1FSWDJ3a3dwaVJFMFJyTzBEbk1kYlNpRkVocGFR?=
 =?utf-8?B?U3VZa3lkYUxMVU5zQjllczI1Y0p4TlpMaXQ2THYrYUxwZHBSenNaZ0lidXEz?=
 =?utf-8?B?UGdPYVdwb1A1UjkrQlFjQUNnL2NKT3VXZ3dWa2tXMHNmSUdONFVZK1hKYk15?=
 =?utf-8?B?TW14eGFBdmdzZ29HZTBmVk9LQ3I1ekhZT0JJdkNncVdQelBCcGlwNFhNVEZw?=
 =?utf-8?B?TWpUbzdGdndaWWNkZncrWkZFYnVnUXpCSkJrVzhqanZuNU44cG5VejllYUJ5?=
 =?utf-8?B?bUFFNmpISStsaTVNeWQ3RzVqRXdTSlIvd203dkI4TVVKYVNYelR1akpPRmk2?=
 =?utf-8?Q?qOAmgmAKCMTy1fL+Qq5kVezfC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094428e7-9c39-44b8-b14f-08dab3a1f3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 20:22:18.8361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVa74y9citbHsP/yWaBrg03iAw6BXx97w1VLvH3RNO62u18hZ3+844JmmrIE3BJQdpRvJf9w+ucRyxA/dgGhCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGFtIG5vdCB2aWV3aW5nIHRoaXMgYXMgInNlY3JldGx5LXR3by1jb250cm9sLWdyb3VwcyIg
LSB0aGVyZSB3b3VsZCBzdGlsbCBiZQ0KPiBvbmx5IG9uZSBwYXJlbnQgQ1RSTF9NT04gZ3JvdXAg
dGhhdCBkaWN0YXRlcyBhbGwgdGhlIGFsbG9jYXRpb25zLiBNT04gZ3JvdXBzIGFscmVhZHkNCj4g
aGF2ZSBhIENMT1NJRCAoUEFSVElEKSBwcm9wZXJ0eSBidXQgYXQgdGhpcyB0aW1lIGl0IGlzIGFs
d2F5cyBpZGVudGljYWwgdG8gdGhlIHBhcmVudA0KPiBDVFJMX01PTiBncm91cC4gVGhlIGRpZmZl
cmVuY2UgaW50cm9kdWNlZCBpcyB0aGF0IHNvbWUgb2YgdGhlIGNoaWxkIE1PTiBncm91cHMNCj4g
bWF5IGhhdmUgYSBkaWZmZXJlbnQgQ0xPU0lEIChQQVJUSUQpIGZyb20gdGhlIHBhcmVudC4NCg0K
V2hhdCB3b3VsZCBiZSB0aGUgcmVzY3RybCBmaWxlIHN5c3RlbSBvcGVyYXRpb24gdG8gY2hhbmdl
IHRoZSBDTE9TSUQgb2YgYSBjaGlsZA0KQ1RSTF9NT04gZ3JvdXA/DQoNCkkgZm9sbG93ZWQgdGhl
ICJ1c2UgcmVuYW1lIiBzbyB0aGUgdXNlciB3b3VsZDoNCg0KCSMgbXYgL3N5cy9mcy9yZXNjdHJs
L2cxL21vbl9ncm91cHMvd29yazEgL3N5cy9mcy9yZXNjdHJsL2cyL21vbl9ncm91cHMvDQoNCnRv
IGtlZXAgdGhlIHNhbWUgUk1JRCwgYnV0IG1vdmUgZnJvbSAiZzEiIHRvICJnMiIgdG8gZ2V0IGEg
ZGlmZmVyZW50IGNsYXNzIG9mIHNlcnZpY2UuDQoNCi1Ub255DQo=

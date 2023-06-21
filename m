Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5D737BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjFUGnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjFUGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:43:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0462210F9;
        Tue, 20 Jun 2023 23:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687329786; x=1718865786;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AEWzNddab1IRmZulWCCCIs3E7ZT6HqwG5bjVt+QrFJU=;
  b=KBh6xZcd07NyOUT4IryphZ52qk3vN7sM83Xvpmx0cCP9i2y92NlogA1u
   dlMTBfTgujgqL05I7WmRL2tJYRfYJBb59XPNHbbZcSJBrQbTI/0PJ+VH/
   zqwb0b31jMo7lan9KKOFxKDeTpJC5HCPKflfenjaa1tGDjBuu5quYjBo1
   0veisSYd/aMtkkmjutWm90mmXSESaGGkKYj4lmYD8xdcFPFhtoHx26KcD
   volqy7aX7DHLJe6pKGV0qnHzFFH1UmKTLNIqgIDWgK2e6yCu84MlnfrFh
   Ddmw3Wa28ik1G+xGG1e8RzSUFXsqgqugQdkdd/2cFWCl1LKQor7WTHB9x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349819430"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="349819430"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="744052198"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="744052198"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 23:42:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 23:42:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 23:42:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 23:42:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 23:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPpZB06O3tck70qHH1lICmkULyip0POWEPKSePKZV6NC4UOuK2jLcYPI1pfsXdnrGk5MF43odwHawUnbgRQYBhTwdjy64eEmrQv58n2RDbwYqatu2TuOfdyjp+/q35XCDh1jURJgWiBHYqpuox/MLN1dhF53EXTSuS0wpeZmqrAGbcBcIbUcfrAk1cVnjmH7dg3cdXb+TQ+eFn5So1wQy8+Sz/0TzapICwJ/33utqwg6YXEAx5VIP/MSyq5G6DtZENlv89a5/jwUgeUGAAL+pv2YTH3SS5aQP97yCpewzAAMq0A1+OQLLC0gZPSCzDhJkbafI6dOGeuhbu64YxK/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEWzNddab1IRmZulWCCCIs3E7ZT6HqwG5bjVt+QrFJU=;
 b=VBTYM9vrJlFPvNhIlLaJBD3YQt7eoH+fQ3/lnIGXqdcQncT6VZWm924zSXPQMvMtnYS9Ufvteq1yuHhWEvIdeDsZJjKg/yjzM4hluhwVHz/EX5JfE77/WCvYhFqlnUUetDMkp4HBovgET7R9E6kv8avmeC0i9SLZcqYU8K3zcjR1PhxEAFa5ntILi1EPCOYIRugj45ZDsfUYrrLqipFWks0O9aXbO1vNTsAm5duwMmRw6Z/u8Oshioo03id9yJ2DxhD56B9MN7YLdJ8l+ryQDiwjlOPHcjR8TYoxVCsPtMKhnBibpwz5qIngYu5TGblacUxf7dH1yk6zCDapENZ6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 06:42:45 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803%6]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 06:42:45 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Schofield, Alison" <alison.schofield@intel.com>,
        "tsahu@linux.ibm.com" <tsahu@linux.ibm.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "jaypatel@linux.ibm.com" <jaypatel@linux.ibm.com>
Subject: Re: [PATCH] dax/kmem: Pass valid argument to
 memory_group_register_static
Thread-Topic: [PATCH] dax/kmem: Pass valid argument to
 memory_group_register_static
Thread-Index: AQHZo4RlAAgAMB9W+02gGaY9rIEsXq+UVBOAgAByEYCAAAn8gA==
Date:   Wed, 21 Jun 2023 06:42:45 +0000
Message-ID: <b7e620efa0de6b9f7a8ae9ce51d8dd562f384cdc.camel@intel.com>
References: <20230620140332.30578-1-tsahu@linux.ibm.com>
         <ZJIz07hQiXr/MghO@aschofie-mobl2> <87cz1p1h8c.fsf@linux.ibm.com>
In-Reply-To: <87cz1p1h8c.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.3 (3.48.3-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|MW4PR11MB6957:EE_
x-ms-office365-filtering-correlation-id: 9a36888f-77ff-454f-fb80-08db7222b87e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fE0rZzx+Ap3RiON6BWusMUb+0OP/NUgg71fqiAdrig7P9KmR3lwdNLByUBki7qA5LEqOIOzzx2LhwrtWeWKOq5kqVAGUuj3t9B22QdVe6oZqGsovn6PJxqF+52cIHqfksgDDnptnvRlAXjStNlCvebCHGCSSf3Hd/RdkGNghww34mrcvc0eUo69psguEPY477CvNLAG+5J1h+cfG/dot9p0RjxwYnN8J5WAlkHngYM9PhBgOm+Jy6l+exWDGxd/a2rXEsE8710yjQl58ejt2dwUEdz/e4zuHZyyjbdJr6DBuUC4aKacXAgmQhQCAS8F2ld/K2xnMlNG3mhEIsGQe0gnl+hF/7A5Vc3yuizwte2yYSo28P+CO7BQPwv76+KKhUU43TTwezU9tSAxNIowm8WREj5LdYfO7ezL5/ZpNZNwzXkbKdKOLypjzFFuguKgaDB4KjFxg+c/MK1lWcQtgQ6wnfz5Zgj/2oH9KygNC0/31HbIjdiw0+b1iCGfIAJlZnLIOD/YjgmPvG0vQCdbpL4Z9itJYq0HPPmE59pg+OU8n6I6fqIZqkNr4K9AZLZNTdktknbV9dp5/6XG/jPMkCWiPGIWoCXHTC65dWmS7cHc0zTSkZibNvnqJuxIc4nQa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(82960400001)(8936002)(83380400001)(38100700002)(8676002)(2906002)(186003)(38070700005)(6512007)(6506007)(26005)(41300700001)(6486002)(316002)(86362001)(71200400001)(76116006)(2616005)(54906003)(66946007)(64756008)(110136005)(66476007)(5660300002)(122000001)(66446008)(66556008)(36756003)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVpieEhEVXRJQytyQWdLSnVXd3RITmZ4b0lhd2xsenFJNGpMZTZvM1VnNlU4?=
 =?utf-8?B?RTNjdkMvNXlOcUxGRzVjZDh5aDBlbDVNRDJ2VWwvZmZqL3VLQ3RGV25iZ3Rk?=
 =?utf-8?B?L0ozZkJUOGtSNGpLbitEcDhaK1JIZ0lmY2ZaS0lrUHpma0dzUHA3QkFydUpC?=
 =?utf-8?B?RUNnL3JVOVJUMHZ2MllCYXh6Ump6Mm9nUVBXbGRTaWhOR3NoNW5GeENyTVgr?=
 =?utf-8?B?UGtnMWVKWnM0YWM3RzN6RzZyb3dpUkFibHBEbjQ0UkhZWnc0ZjFCbk1KSVBG?=
 =?utf-8?B?eUc4ZmVvN2VFSGFVOFFMYkwyQWV4eEVjSm1ReUpqT3FPeGQ1TzJnTWVRWHo4?=
 =?utf-8?B?dkJkaTFOMTVBYlY1eXZyQWQvK25XRXpuaXBqTjluTnMrZEdkN1A3QUNnWmto?=
 =?utf-8?B?ZVp1WlFHblBRdHVnK0lDLzJQRVhSdXlkWUpOQ09HenkrNER2Rlp4dlAyR3Fa?=
 =?utf-8?B?MHNkelJxYWdKd0NHcmxSQ1ZqN3RnTzREZDAvWW5ibldqckRZT1FQMGNuMUR2?=
 =?utf-8?B?QVlsN092RjE5QXlKWHEwUldEV2JEU2NqdmFGMU9TTktYQkNHYi9tZmpBUDh0?=
 =?utf-8?B?UWJrRXVzZlNVZjR2cTk0ZWFrNEJieDl1WlZMV0pBdk9mVFRIYzlzeW9TOHFU?=
 =?utf-8?B?ZlliMUtEYkZBRTVKRHFiaDU3MUJnM2U3Y2tDNjBLRmxtcktqWmZrWlNmOWpt?=
 =?utf-8?B?VWlwTnNkcE54azhiOXovNGthajA3cmVieDFsc3NQb1RQOVg0M1BSVHZHd2k1?=
 =?utf-8?B?R01IUUdiNklyQXRsamZuaEg1Wks4UTJNL2tKYzQ4cUdKR2wyandPL2lqQXZh?=
 =?utf-8?B?U3diNkRsQ0VmNDFvYXhpampKakdjU0dVRkxuMkpzc24zOGp6QmhJRjQxWFhK?=
 =?utf-8?B?d0psV1hRWHAwamo3ZmlSUkdSU3hicGIwWlFVOWxwbVVaUHArOVNwMUdPb3Qy?=
 =?utf-8?B?RWRKQnQ0aVhhQjF4QjFCMks3bjVxZ2M5K2JPeFR4bDh1TS9oYURNN25IMkNS?=
 =?utf-8?B?TzlZc0NJRnFNcC94L0tQOXdjcUNuSTN3WXFwRlBDWU1YaHl6RFZ6RFVnYVFG?=
 =?utf-8?B?dGJlWDBxNG1WMGVkenVsV3E3MnJqalluclVCY0pKQzYzY0wzRFBoLzZGVEpr?=
 =?utf-8?B?OCs4RXF2bmFLL1VOamhrNUFMZ2VwL1ZYMmN5cWFJM254NVYwa0docHdwODE3?=
 =?utf-8?B?QjZVellMTDZGQm5SM0ZKQkJ6bi9MdlAyd2N5dGc0R2hmTU0zbWVRem54Nk5S?=
 =?utf-8?B?Y01EV2FQWjIyeFlVUEdCRjVneFRjMldnd0Rma3BwNTZQS2NFdDhKZFNYcG5u?=
 =?utf-8?B?QVNDYndOcVVMaWl3ZmN2VUdCYS91TjdNVlhoVkYvOTJyUk1oZDk2Y01KVjBk?=
 =?utf-8?B?WlBvSGlIRVBFQmFFWkJmdXdzT1VPOGcyQ3NGUVVXOGpPOGhvVmJheVF5UG9S?=
 =?utf-8?B?UkNNa2tpdlVzdFBTK2VRVGExRjFMYkJyR2VtN2ttL3JZMSs5WEpxcGIrbUZt?=
 =?utf-8?B?YnpmS1E0Ri81VDRRZno5YXFwVUluRTJBYmV2VCsxRXhzczF4cnJTWnpzSnBo?=
 =?utf-8?B?WkVzOFBGSmprYitJZ1RlSGlvOVVsdzBWbnlMd0ZBZ3ZmQXQ5ZGRzeHlkUE1v?=
 =?utf-8?B?UjJ4UUlMYzJLSERuZWVKeithdVhSSlIyMUdEOGxTTmFnNzIyTVUydW5uY2lJ?=
 =?utf-8?B?ejNzdnR6bXFqdFVzenVUVitUaFFSNStMSVJJS01RL2lpYWRvemxvTnhPdmx3?=
 =?utf-8?B?cVFWM2VXMmpSWEh3c0d3c0EzaENpVEczTzNseitlNVFrQWNTbzVIMHhDZzkx?=
 =?utf-8?B?aG9CZVBkK3hxaXpPTmFVK2F0V2gwd1RCVElJODJkY0o4a2NMMXE5R0ZtQkVD?=
 =?utf-8?B?R1ZKaFRsaFJmbWZKcWNHeWhhVEg4RDRsTG5LajFJMXpIeE94RUhxc09aNXY5?=
 =?utf-8?B?SVIzUm5iNTI5YXA5c1pkVkEvclFZMTVMUEhYbGovZUc1WEZqWW1JN2xPZUJn?=
 =?utf-8?B?SGhIZFM4MjJ5ayt0MFd6NjBTWjc0VW5NRlVCT1FiY3FFL0ZISXRFTGEvZTFQ?=
 =?utf-8?B?TytzMTRGajE2b1FSdmNVa0xERHErUndYdkExdUc0UUt4YmpqWmVONlVFTEtt?=
 =?utf-8?B?NEJ3blhWQUFFZVNKTlJxZWRreXVuaXlVY20yKzFDUzQxQVN5YTNMVVc0TEhv?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A847A6A5AE548F4082E4DDF82DE55E68@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a36888f-77ff-454f-fb80-08db7222b87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 06:42:45.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3Sv9owyLwOaTE7rdq5fsWMrzxGTaBXATAzM0i5w80lEP23Tg5yMB8p97tjE1bffE+0vDcd3UgEBZympBVMc+fS/7fbzdVFrbwbc6YjXEGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTIxIGF0IDExOjM2ICswNTMwLCBUYXJ1biBTYWh1IHdyb3RlOg0KPiBI
aSBBbGlzb24sDQo+IA0KPiBBbGlzb24gU2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVs
LmNvbT4gd3JpdGVzOg0KPiANCj4gPiBPbiBUdWUsIEp1biAyMCwgMjAyMyBhdCAwNzozMzozMlBN
ICswNTMwLCBUYXJ1biBTYWh1IHdyb3RlOg0KPiA+ID4gbWVtb3J5X2dyb3VwX3JlZ2lzdGVyX3N0
YXRpYyB0YWtlcyBtYXhpbXVtIG51bWJlciBvZiBwYWdlcyBhcyB0aGUgYXJndW1lbnQNCj4gPiA+
IHdoaWxlIGRldl9kYXhfa21lbV9wcm9iZSBwYXNzZXMgdG90YWxfbGVuIChpbiBieXRlcykgYXMg
dGhlIGFyZ3VtZW50Lg0KPiA+IA0KPiA+IFRoaXMgc291bmRzIGxpa2UgYSBmaXguIEFuIGV4cGxh
bmF0aW9uIG9mIHRoZSBpbXBhY3QgYW5kIGEgZml4ZXMgdGFnDQo+ID4gbWF5IGJlIG5lZWRlZC4g
QWxzbywgd29uZGVyaW5nIGhvdyB5b3UgZm91bmQgaXQuDQo+ID4gDQo+IFllcywgaXQgaXMgYSBm
aXgsIEkgZm91bmQgaXQgZHVyaW5nIGRyeSBjb2RlIHdhbGstdGhyb3VnaC4NCj4gVGhlcmUgaXMg
bm90IGFueSBpbXBhY3QgYXMgc3VjaC4gQXMsDQo+IG1lbW9yeV9ncm91cF9yZWdpc3Rlcl9zdGF0
aWMganVzdCBzZXQgdGhlIG1heF9wYWdlcyBsaW1pdCB3aGljaA0KPiBpcyB1c2VkIGluIGF1dG9f
bW92YWJsZV96b25lX2Zvcl9wZm4gdG8gZGV0ZXJtaW5lIHRoZSB6b25lLg0KPiANCj4gd2hpY2gg
bWlnaHQgY2F1c2UgdGhlc2UgY29uZGl0aW9uIHRvIGJlaGF2ZSBkaWZmZXJlbnRseSwNCj4gDQo+
IFRoaXMgd2lsbCBiZSB0cnVlIGFsd2F5cyBzbyBqdW1wIHdpbGwgaGFwcGVuIHRvIGtlcm5lbF96
b25lDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIWF1dG9fbW92YWJsZV9jYW5fb25saW5lX21vdmFi
bGUoTlVNQV9OT19OT0RFLCBncm91cCwgbnJfcGFnZXMpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdvdG8ga2VybmVsX3pvbmU7DQo+IC0tLQ0KPiBrZXJuZWxfem9uZToNCj4g
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBkZWZhdWx0X2tlcm5lbF96b25lX2Zvcl9wZm4obmlkLCBw
Zm4sIG5yX3BhZ2VzKTsNCj4gDQo+IC0tLQ0KPiANCj4gSGVyZSwgSW4gYmVsb3csIHpvbmVfaW50
ZXJzZWN0cyBjb21wYXJlIHJhbmdlIHdpbGwgYmUgbGFyZ2VyIGFzIG5yX3BhZ2VzDQo+IHdpbGwg
YmUgaGlnaGVyIChkZXJpdmVkIGZyb20gdG90YWxfbGVuIHBhc3NlZCBpbiBkZXZfZGF4X2ttZW1f
cHJvYmUpLg0KPiANCj4gc3RhdGljIHN0cnVjdCB6b25lICpkZWZhdWx0X2tlcm5lbF96b25lX2Zv
cl9wZm4oaW50IG5pZCwgdW5zaWduZWQgbG9uZyBzdGFydF9wZm4sDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBucl9wYWdlcykNCj4gew0KPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHBnbGlzdF9kYXRhICpwZ2RhdCA9IE5PREVfREFUQShuaWQpOw0KPiDC
oMKgwqDCoMKgwqDCoMKgaW50IHppZDsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqBmb3IgKHppZCA9
IDA7IHppZCA8IFpPTkVfTk9STUFMOyB6aWQrKykgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCB6b25lICp6b25lID0gJnBnZGF0LT5ub2RlX3pvbmVzW3ppZF07DQo+
IA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh6b25lX2ludGVyc2VjdHMo
em9uZSwgc3RhcnRfcGZuLCBucl9wYWdlcykpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiB6b25lOw0KPiDCoMKgwqDCoMKgwqDCoMKgfQ0K
PiANCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAmcGdkYXQtPm5vZGVfem9uZXNbWk9ORV9OT1JN
QUxdOw0KPiB9DQo+IA0KPiBJbiBNb3N0bHkgY2FzZXMsIFpPTkVfTk9STUFMIHdpbGwgYmUgcmV0
dXJuZWQuIEJ1dCB0aGVyZSBpcyBubw0KPiBjcmFzaC9wYW5pYyBpc3N1ZXMgaW52b2x2ZWQgaGVy
ZSwgb25seSBkZWNpc2lvbiBtYWtpbmcgb24gc2VsZWN0aW5nIHpvbmUNCj4gaXMgYWZmZWN0ZWQu
DQo+IA0KDQpIaSBUYXJ1biwNCg0KR29vZCBmaW5kISBXaXRoIGEgRml4ZXMgdGFnLCBhbmQgcGVy
aGFwcyBpbmNsdXNpb24gb2YgYSBiaXQgbW9yZSBvZg0KdGhpcyBkZXRhaWwgZGVzY3JpYmVkIGlu
IHRoZSBjb21taXQgbWVzc2FnZSwgZmVlbCBmcmVlIHRvIGFkZDoNCg0KUmV2aWV3ZWQtYnk6IFZp
c2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0K

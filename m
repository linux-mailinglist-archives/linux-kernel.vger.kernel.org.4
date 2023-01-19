Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFF674B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjATEuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjATEt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:49:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C36BBF88F;
        Thu, 19 Jan 2023 20:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189825; x=1705725825;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=gpyn0RlSboNVLFa4ZzBGnhe0W7T/DEl+4qmB7U22ygo=;
  b=m98yejfpkc7o4Zji8o4KsNJj0xMFioTiwhSSMn/lz8Ev2NBp829Id5Pa
   0KjvOoDQxp6AqtSeVkT6+mNI0PHwxZRKbKGM47uDyNoDMAwN2b4N7JmJd
   VPnm5RG8zyFTfLTrlimovIuaZxO3fKIjQblGMPiJ+CERMHFmshCnDCnLb
   eIDrpo0OGXw1arqtpjvWGYuK6SZSRogqppIcT1V4vkJsXAsyeF0NM8ui5
   kN9vcFKwLkecfs1U8XozjOZbXhVGHTTRfH6RH4UwlVGI3aTpJHa8wDk1+
   Lo3BiZlei8Sod2qrznH7TudkC2+y9xo/v2a/zzat5siaqvcL3wHNgznW0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308778989"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="308778989"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802524399"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="802524399"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2023 23:52:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 23:52:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 23:52:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 23:52:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 23:52:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGyZJ0/cUnvTiLDOJdd3RFyC4iF+t+y2/oZ+dPYpvhPteWRHfjGNEujR+c/5Lj6NIgw9NOOLDmZUvhQQq+KI9wHJRvElIQoW79GzwRuyxKioAEmm0rJKyZeXvstoOzBTopPi6SG7GQwbFjBJ2Ug5PSZHx34Oa6rM94DCeyg32J7Rh9Ks0slxA0C7RsD2opgTTd13ixqn6jrKe2SqLxW9kqrmjoKnZaar5H0Y4n0pQxsC7bbveq8q4XQ+Btook8QL/fkcaknqxLT+BCnvfuF9gTP7seWzhjp9YvikFJvdT+pxN2S5RYp/2x/2/H6b/7xblZ/JvaVW5bIAqUFbFf/z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpyn0RlSboNVLFa4ZzBGnhe0W7T/DEl+4qmB7U22ygo=;
 b=XFR/re8mF72/Eeqhb+y+fBPGbRxYKR5VyNZ9yxDRR0egXT5zApKKe2uOtmQ7Aqp8LWqJSm5+jV+NHF0ygWlg70+ytUSaIE0E0D3c5R579YK9MK72717+mN3EyhSwYLB3wYamm6oyCAl7mxnw7FMNzPabqWx4RGnJ//y3w0xkaIcSl/SIJRa3Pf1keUMBZC+kNozJ3/yW4HIUj+A614gvdnLPZ51N7V6FW4wnQ4zBFgcqDzvpHr1MizIcoMxQueAu6LXRcC2VmfNneWNMC30Kcb+3A7X0BNJ1a5kTg/Cbm6z+gui8y/FqeJ/kGZCKD6uCkCqRXyF0ZxDc7yDpxcRwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 07:52:41 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 07:52:40 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
Thread-Topic: [PATCH] intel_idle: Add RaptorLake support
Thread-Index: AQHZK9QM69Ctt/8BWU2kz43rXhq0Oq6lXliA
Date:   Thu, 19 Jan 2023 07:52:40 +0000
Message-ID: <e11f89efc67ec90ba1fed21bbfeb4af8764119e9.camel@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
In-Reply-To: <20230119070205.90047-1-noltari@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB8129:EE_
x-ms-office365-filtering-correlation-id: 15cb079b-62a3-42d1-0b2d-08daf9f22413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WySaseT4PCdhPWUyXk325nlTHkCC7ee/JekP9XGyC5W8LRD8+8o8nCnysgQdkpZiNX6xqJL1HVXWaeqcBaCPdYqUFbcmRqzn64FUEp8boPJNqy/NzGulMOSAGXVEOrbVRe4t5fX2WFJXf5G0+2f/hPrSlRBE0FSzpOiPcyXF7bIoJNU8fkS+2lE63OgvXtH7PMXsQIBF7WYqioFZzAIboofj/bB0lvIQN6K/9Bwb/Dgsc6waKKMF+gyY/2WMRimFC2HcBnyeeziiXyQXob/dGiC8mcUd66MfuAVq7vR4ZaDzzgIJy/fuQl8rnRuAGb5LkzmMHUBDpDEfI6RNVZMk/ritXiSyd+uerZbXrihEACS+0GUw9YKRCd6rdOyxNaZ/Xii5EOvgmdYtWjDsksh4QgRguTSOD9PX10AERYhbUMhmY4ABOVKFPqBUhqIyB8jaNBkQ4QLNllo2YB3PGgNSxcay1fLlSLdQ5LbImLq7shF5mo3o0w/q6K3buzL4ju1SPYeE5Vk3ym4Fk8ziRZc9DNnyv5Zdkvo9EaqfSijTwZvMhj27BoBRkNFt5GwfJ/lcxYKUuDQN8jWQhJYnzPqEmmick3yz5umHR1oAP8LTNVWIPSTVIUx5fbdm64jDoLIMROP5O0xjGJrFs/VZNyMak8xZ7FltgP2ue0v3NM/6o/u9tpxMhkfP9IkN+IEF4WY88leoR1VnYaszhkJ/zdHNnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2906002)(66476007)(66446008)(6506007)(186003)(6512007)(26005)(82960400001)(71200400001)(38070700005)(122000001)(38100700002)(36756003)(64756008)(5660300002)(8936002)(2616005)(6486002)(478600001)(86362001)(66946007)(8676002)(66556008)(76116006)(91956017)(66574015)(41300700001)(110136005)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3psbm5oYU91d01ZN1htS25uMEhRbmZhb0ZRTWxDSWtjcU5Md29Lb1JOR1pH?=
 =?utf-8?B?UnFpYVhlUE0rSFMrRW5EZXVTODVTV1BzSWk2c0NKVi9LdlZjRUpOSTNZWEFR?=
 =?utf-8?B?ZHAyWmRXWkFoRkRHR0paYnNvVnFzQ1p1dmVGTXNjTklGbUo1aHd5a2VHVGJI?=
 =?utf-8?B?Mm4wZVNjL0NubkZJMWYrQmhFNjBHUFRGNVFQVDBGOWlVSHpUVlhUV0YvZ3BL?=
 =?utf-8?B?L2NwUnhxNThFRXpZZWQwZGJvYnJKdnB2OS9ITnRwaWdueUE4eTc4N3JubXRN?=
 =?utf-8?B?a3g0ZUZtZ0tNODd6M1VnV2JZUjZNWGVRZExtUG5MT01KcW9WQXBndDE3NE9J?=
 =?utf-8?B?RDg0TG5hRWw0ZW1EQURUN3lmdkJQYzA2K2pOcXpmVms3R1pYTUtlL3RXeTNq?=
 =?utf-8?B?ZXkvTFovNU9qOHBxejYweTVCc3htL2ZLRWV5K1RBcnJHV3FadUFrYlhqQWN1?=
 =?utf-8?B?K05GSzU2M3FQRFpTSmw2bGdmSUFqYzVNWVZhazllc0t0SU02T0R3akFUajNl?=
 =?utf-8?B?OWtYbmxqOWZBWXM0cmU1K3dTV3V3UER2Q05xWVh2NFZibStkVGVxVGNWcVpP?=
 =?utf-8?B?b3dwQXRsMStGOWx6bWtJZmhxZmVxdFRCTmxsdTVmdU1jM3pSNXRXdXNYRml2?=
 =?utf-8?B?WTZzMFZJVFJYeldjbmNmQS9HeVcyWTFVZVVXeHo5eXJ2aUJqbUU0ekxrMkx6?=
 =?utf-8?B?KzZuMGt5UWNiOVcxOU8wOERwMEw0dHFnbVJrajZTWmtwYWRsQWJPQTFHQUNN?=
 =?utf-8?B?NGdhald6Vm5PSEErMWI2elRNWCtiQWt1MytCUHI3enczb2tqaWM4WTRpVUZO?=
 =?utf-8?B?N3BVekZlRHA3Q2hCWlgzRXFBODJxbTFVNTQ2NUpTNFR3NWplbmNjdnVScWZo?=
 =?utf-8?B?b25BWS84dFhndVcrVVNBa09EcVViT0p4Um5JdDJXekJmQTRUcjR6VW5VYXlQ?=
 =?utf-8?B?ZmpiQUFKZXdZNkxaUWlUOC9SbDBmSWgxM3Z0TU53dnRtZEtpeHExNUxBZWtt?=
 =?utf-8?B?MWJoRk1ZSW1icHhqaGwyQmtDdFhkVkVmK0IxakxadXlmSWNzM2FYYjU3M3Vt?=
 =?utf-8?B?MDlrWURyRnpPZEFReFhhSEhNbVZnanBSUkcvNDd5bWxLV0lKd3JZalBiMllH?=
 =?utf-8?B?eGdVelBkTll2RGVMamNiLzh4Sk8xWnRkZ2lLaGF1VHNNMkdyS1NURTNJOWp0?=
 =?utf-8?B?TE5ReS85akR1NTNSd3craXFUZHBZK1lVelc4NStEVDdFSE9QWlBaL2dOQ3dv?=
 =?utf-8?B?TkJOenJ4dlYxeXdBemdnd3JoblM4V0NwQjVxV0w1b0Y0TEJPWlJlM0dpMDhr?=
 =?utf-8?B?NWt4ZUNIZnhHSDlOcEoxMzB4dWMxVUNpbUtVcHZ4cDljVnNiMGtIWUNYbFRz?=
 =?utf-8?B?TnNpbXNjb0UwbDl3d0E0NUtwbUlHSlFVM2pScFVydlFERkU2WlI1bkV1dldv?=
 =?utf-8?B?MUg5UExJdkhVc1dwd2h3bVJvVDBkQ0s1cDZVNDhabS9hZUIvb05RNCszVmtD?=
 =?utf-8?B?M3Q4eFlwYUliYllmd1k4eTN4cjhoZ2lJV1VENXpVNmdKWm9pdlhTa3FEQjhy?=
 =?utf-8?B?UUFtMFNLbHhhUDg1dWtPSkgzYS9FSWlxTjgzQkJEd3lCbXB1MmlwTE1KMm9I?=
 =?utf-8?B?blpTbnhRVTlWdXJEQVZYQ3pWQUpaWlA2WTEyYWhHZUZ2ejV0Y2ZPVHpqTmxC?=
 =?utf-8?B?citYc1R2enUzZHFhb0VwZmFvTy9TOC8yclNKeEh6MnZzWXprcnhWbzlQOGZL?=
 =?utf-8?B?SW9qeE9JMHNQOEh3YnN0SVUzZE1Cc0RsMTZxQXRFTzVKNUhtNmZFd1dKMURk?=
 =?utf-8?B?YkdmYmUzQTM5Mk9uZ2xDZGhoYjg1Q0FacG03VkFqUlkzL2J3bGQ0eUNhcFYy?=
 =?utf-8?B?Qnp4eGxzMEI4bE9WV3VxWHUyVTVERlJKWi9wSStQckdYSDRoUkoza3hqTkU0?=
 =?utf-8?B?dGF5RkQxY2lMWEk4UzBUNlNqcUZjSU9wM2hvNG96elB2SHZTOGJsdkNmeHE0?=
 =?utf-8?B?ZWZaSENLNW1saFgxcnRpMHBHQTlTbzJpazQxbnYyU3NGNS9QR29FS1lTbWxD?=
 =?utf-8?B?RjRHVmRwQUlMSTF1NlpMQTBXS1YxQ0crUjk3aTdoNThydmU3MG9lbGR0QWZE?=
 =?utf-8?B?UENzTTUvci9NNDdGUGZFUWRwdmNzR1YzRzd6N2NtdzlEMG1zMFJwWSt1emdY?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EA4490D79F4E943AD9D8BE3C7C8E393@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cb079b-62a3-42d1-0b2d-08daf9f22413
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 07:52:40.8507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7v2sA84bC9R/aBEOgUOko6xWtuqZJrdzPlMoaLUblHKKAKzcHB4QCj8LeX+7dD8myOC37O6ARriQhkvLn97Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAxLTE5IGF0IDA4OjAyICswMTAwLCDDgWx2YXJvIEZlcm7DoW5kZXogUm9q
YXMgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyBSYXB0b3JMYWtlIHN1cHBvcnQgdG8gdGhlIGlu
dGVsX2lkbGUgZHJpdmVyLg0KPiANCj4gU2luY2UgUmFwdG9yTGFrZSBhbmQgQWxkZXJMYWtlIEMt
c3RhdGUgYXJlIGNoYXJhY3RlcmlzdGljcyB0aGUgc2FtZSwNCj4gd2UgdXNlDQo+IEFsZGVyTGFr
ZSBDLXN0YXRlcyB0YWJsZXMgZm9yIFJhcHRvckxha2UgYXMgd2VsbC4NCg0KVGhleSBtYXkgdXNl
IHRoZSBzYW1lIG13YWl0IGhpbnRzLCBidXQgdGhlIHRoZSBsYXRlbmN5IG9mIGVhY2ggYy1zdGF0
ZQ0KYXJlIHN0aWxsIGRpZmZlcmVudCBvbiBkaWZmZXJlbnQgcGxhdGZvcm1zLg0KDQpKdXN0IEZZ
SSwgdGhlcmUgaXMgYW4gZWZmb3J0IG9uZ29pbmcgdGhhdCBtZWFzdXJlcyB0aGUgbGF0ZW5jeSBv
ZiBlYWNoDQpjc3RhdGUgb24gdGhlIFJQTCBwbGF0Zm9ybXMuIEFuZCBiYXNlZCBvbiB0aGUgbWVh
c3VyZW1lbnQgcmVzdWx0LCB3ZQ0KY2FuIGRlY2lkZSBpZiBhIG5ldyBjdXN0b20gdGFibGUgaXMg
bmVlZGVkIG9yIHdlIGNhbiBqdXN0IGNvcHkgdGhlDQpwcmV2aW91cyBwbGF0Zm9ybS4NCg0KdGhh
bmtzLA0KcnVpDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IMOBbHZhcm8gRmVybsOhbmRleiBSb2ph
cyA8bm9sdGFyaUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pZGxlL2ludGVsX2lkbGUu
YyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRl
bF9pZGxlLmMNCj4gaW5kZXggY2ZlYjI0ZDQwZDM3Li4xYTM1Yjk4ZDliYWUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gKysrIGIvZHJpdmVycy9pZGxlL2ludGVs
X2lkbGUuYw0KPiBAQCAtMTQyOSw2ICsxNDI5LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB4ODZf
Y3B1X2lkIGludGVsX2lkbGVfaWRzW10NCj4gX19pbml0Y29uc3QgPSB7DQo+ICAJWDg2X01BVENI
X0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFLAkJJmlkbGVfY3B1X2FkbA0KPiApLA0KPiAgCVg4
Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFMREVSTEFLRV9MLAkJJmlkbGVfY3B1X2FkbA0KPiBf
bCksDQo+ICAJWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQUxERVJMQUtFX04sCQkmaWRsZV9j
cHVfYWRsDQo+IF9uKSwNCj4gKwlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChSQVBUT1JMQUtF
LAkJJmlkbGVfY3B1X2FkbA0KPiApLA0KPiArCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJB
UFRPUkxBS0VfUCwJJmlkbGVfY3B1X2FkbF9uKSwNCj4gKwlYODZfTUFUQ0hfSU5URUxfRkFNNl9N
T0RFTChSQVBUT1JMQUtFX1MsCSZpZGxlX2NwdV9hZGwpLA0KPiAgCVg4Nl9NQVRDSF9JTlRFTF9G
QU02X01PREVMKFNBUFBISVJFUkFQSURTX1gsCSZpZGxlX2NwdV9zcHINCj4gKSwNCj4gIAlYODZf
TUFUQ0hfSU5URUxfRkFNNl9NT0RFTChYRU9OX1BISV9LTkwsCSZpZGxlX2NwdV9rbmwpLA0KPiAg
CVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFhFT05fUEhJX0tOTSwJJmlkbGVfY3B1X2tubCks
DQo+IEBAIC0xODY3LDYgKzE4NzAsOSBAQCBzdGF0aWMgdm9pZCBfX2luaXQNCj4gaW50ZWxfaWRs
ZV9pbml0X2NzdGF0ZXNfaWNwdShzdHJ1Y3QgY3B1aWRsZV9kcml2ZXIgKmRydikNCj4gIAljYXNl
IElOVEVMX0ZBTTZfQUxERVJMQUtFOg0KPiAgCWNhc2UgSU5URUxfRkFNNl9BTERFUkxBS0VfTDoN
Cj4gIAljYXNlIElOVEVMX0ZBTTZfQUxERVJMQUtFX046DQo+ICsJY2FzZSBJTlRFTF9GQU02X1JB
UFRPUkxBS0U6DQo+ICsJY2FzZSBJTlRFTF9GQU02X1JBUFRPUkxBS0VfUDoNCj4gKwljYXNlIElO
VEVMX0ZBTTZfUkFQVE9STEFLRV9TOg0KPiAgCQlhZGxfaWRsZV9zdGF0ZV90YWJsZV91cGRhdGUo
KTsNCj4gIAkJYnJlYWs7DQo+ICAJfQ0K

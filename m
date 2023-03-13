Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D26B7F73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCMR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCMR0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:26:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165012878;
        Mon, 13 Mar 2023 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678728321; x=1710264321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gbjG7kAWoFAmU9gAiiQi9DYE3JT5THbae8Omc+z/eBc=;
  b=eOlKxi9rvqOTjkaIaroonhw9IabxKPcqo5X4Fo24445mbtDLWY4LOG9R
   jXFPuAqIW0OgocONOwMtPUNGSRLJMALZWgRu2sTepxQ9jGfWNvuV9CKwr
   uhlB37KKG3PvBU4VO7ECHuqqkxKyvsFZAgPRtpeBsi7ugCK8noYfH/AuF
   g7ZH+IdaYuVcRrYUcWFMimBk2f/B/7cXDgCYHb7Z4uIoujQX/ztnpp2mx
   8q73G60qChEoUuXGPjQByf4eJN4FaEJzjXnD0gmxWNNRFSktLiQr7cyx+
   vZR4SpBvfhAduv7Gc5ruphwqI5wUUYyOyPD5BkQms33PMEzFJk4rgaY4o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325572430"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325572430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628714580"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="628714580"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2023 10:21:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 10:21:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 10:21:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 10:21:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 10:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPcEZkSxLkBwMaO4ufnUqKB496hTYPW0GeDO0V4CLHwO4/fzOAXtOB562HvfJQyduc8GtKaHduLpYK1YKKxzWoa3lCMkxeakBduOqPhGTq9yhyMR3g0M4/3jjU6f5k43+2Oj3MEzugMiqhDfR0oLwsipveB/wjvhDrZdkC475H+Z4uGjNrV3ViiGsAaIQubW6/1vH2C8nVqkjxJJZk0vQfuL2oq5APZtD6223vAqnOkwKzn8BMqXiER1xfrSXJWvJseqUkCv4JHjwXYH2gH+nwrPzegOfXUPO/T46y8GLYAhm3Gk8AkGMbYx5fmOY2gemMgtyCbQozgp69LG2MSWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbjG7kAWoFAmU9gAiiQi9DYE3JT5THbae8Omc+z/eBc=;
 b=Mun+3v6HJ2bkgQPE9jGwBg+MLItoJuU03rpM/5TQHl9jrRs1xQMxEx4JKyisBSbRe/dchX/WIcin94ztaLSpR1IT/CYTYtTP4FhqA+ik5JIEJCoYpMaNvtZLJTi09qH4cGGmxvPEoaDjX5eZ4UghPo5sISuBB9CdR+WjGDZGayEDc5bBIjCn7U84JJuJR0TjmWhQz40jfx/U4k7audP7iBHJjQGwxQV/dkx+XtUZQ3yGhdsOWgiichGmFieaWJjhzx3AwrSJ0YM9mq/4qH5tHotVpMCPlD4HkBKNKDwxiVfzABDbjtKlFXSJ/y3p7abKL1TeqrlEK5BiW4+9sYRIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 17:21:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a47:481:d644:a8b5%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:21:37 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Thread-Topic: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Thread-Index: AQHZS+G/UVVPr/AokUavzZblP7FWM6749OCAgAAFcICAAAheEA==
Date:   Mon, 13 Mar 2023 17:21:37 +0000
Message-ID: <SJ1PR11MB60831C996C2EC462262948CDFCB99@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-5-jithu.joseph@intel.com>
 <7f82f241-39ee-15e0-1ae7-e98e50730c95@redhat.com>
 <275d2f04-782f-2c9d-187a-7a510bf34f41@redhat.com>
In-Reply-To: <275d2f04-782f-2c9d-187a-7a510bf34f41@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6210:EE_
x-ms-office365-filtering-correlation-id: 45d6f1e0-24ff-4855-0c8b-08db23e7671c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlOkm49EKJ6uUScEOVoArWUN41HNj7z6L0HwIxXBqNEMZqPWg/sZi0VWBWseFABomigRr9q6jv2hm4q/V8EX2uZV8kDADC8I4NVidb0H/HFjf3vFaUiI6Okmf5l93dvqSrkhoh5dL0AJk5+o0rQc3qafk2zmNMAAdDbUTG0JfCPxGknWhMfFrpkdOuWePPe7p4dRV2hTRqVhDxCddz1DOJAuAdK3hz4tLG5JtRyMYKITfOV5JERHWEcnTX6MbQ3r5F3xcbEeoSDPsP+arAAMCqSKpMaImEpMzxY2RFNiEvHUpZKGZCsA7UgLKv6IuqyThBZxFjavev66VXju1Pq06Ce1+P/d5iS10Yi9459AWqnSIF2v/TBbCqQgB5+sJaWGUb1PwQ5b+vZK97du/1yxi054uazX6g3VM7dV0OiLw8MjoIsIKboxG4Z4yp5MQ/jyb4Xn487vNQtBQq9xF4f4g6v4TkrevFcc4XuHMpBT1mKtwmq8gy1a5U5RW7CN9bsm0vn/ogZrnxPnxRFL/gceORnvwViQiyPqWwJZJRDZ2JX3fg7DBM5SxAc/kD9pk/5xOMCTLNZgYYQDzvK4XN4smUZkRsChAkkb/+2mn2y+RzWRCkwqtnOBxOOXx0ULbkIGRoA2BJ6/6DSv9sswGoEInej0POHImGnS8fDpYf9d5NlDtsfjxTvH/1fY21QcLP4v/EZLuCFlBZN9uIe4ksmSYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199018)(82960400001)(122000001)(2906002)(83380400001)(5660300002)(7416002)(76116006)(8676002)(55016003)(66476007)(52536014)(110136005)(66946007)(186003)(33656002)(86362001)(8936002)(38070700005)(41300700001)(4326008)(66446008)(38100700002)(316002)(54906003)(64756008)(478600001)(9686003)(7696005)(71200400001)(66556008)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aThEa3E4SDEyYUpEZEUyTDM5V3FjUGVWeVl0Q1BtUzIzU2gxV21Gb1VreGhy?=
 =?utf-8?B?MkVTQUlKSEJUWDA1aEUvVENTVENLaDBpT24vbkwxR3JyUUY3OGRLaXA4MHYr?=
 =?utf-8?B?RUtGSHRFU1J1c2l3MzliY1puOWg2THFGYmdKTUpDb3d5cnJCWi91NjNsdkdK?=
 =?utf-8?B?TjNBR3ZEekQrNzZZczJJOXMwN0NZZ0U0cjNoVXRvc0dyUDRYa2NEQmUrRkdt?=
 =?utf-8?B?T2ZTL29uSElDQVFMNnZoNmVmRzBoVlN0cW93a1pCak5HbXJhUnNPTnFabmt4?=
 =?utf-8?B?VFFxemZNM2FnSHB6VnYycW00aHQ4SmxtcG13YWRpMzcvS3I5N05YWlZOeGZE?=
 =?utf-8?B?c2czS1FJQnJUNnZkeHlaOG1jdmRiUkxqTVNlcEUrSTRmdTFnN2JHQXJ6bVRi?=
 =?utf-8?B?UVdjWC8wWDdOSFNkanJIN3NZYTg4RG12QjE3c3BVT2Iwd25Xa3h0QkozNUEv?=
 =?utf-8?B?TTBGNG1UNnYybk9PMURqNEo2YXFiRlRMdWZMSlFmVDhIeTZWZEhQc3NtWmNu?=
 =?utf-8?B?a2ExK25oK1Mva25kQnZLMXBLenAyZWwxQjRjVEd5b1A3U1Q3b3BDc2x2WFhL?=
 =?utf-8?B?UnZsam1ZaU1XTDR6RGhjZkhBTjVBZ3NqVVJVR3VzYk5DRkFlbnJ5SzZtbnU2?=
 =?utf-8?B?VHhFZUVqcGgzS2hRS05scExzT292RmF6eURORUF0cWY2RnAza3dGb3ZiZ0Nh?=
 =?utf-8?B?NlY2eUxRQUJ2NzJBaDJ6Wm9ESDFrbTFvVVhBR0ZZRjZYTGx1cnA1dTNKWXFq?=
 =?utf-8?B?Zmhma3ZYOG5POHhuN3pWYjAwdlM4elJNV3VZb0c0aW9tQnZWM1dwTU5lM3lu?=
 =?utf-8?B?TDdqcXhlaTdON0NNVzNycUVPb0JpTzZsSkhoNlUrV2lpcUt1QzQ0Zlp6YmdR?=
 =?utf-8?B?dGUyajFMMGY3aENhRUVtdUpwNy8vdFJlbjdhNXljYmNGUW94ZGdMM0dhU24w?=
 =?utf-8?B?cmpHaERxa244TFFJT05WQ1R0ZzlIYXhia1grQnlvdlZDOFRiZ3hCMnJmWndD?=
 =?utf-8?B?dzU2MTJYczZjalVlaUZzT01XNGJCWElFUUVKZzFJMVlOY2RSN3dicm9UQ0pO?=
 =?utf-8?B?Z011MXlncGRNQkRsNkVFT2FITE5TV0lGcDRISEhxSFJoemY2bUJldldCVjY0?=
 =?utf-8?B?ayt3d25zRS9TZVdKVHg4dWpWVTNIUjhvTU11bWl6NWxyWHFsV0h2NHNSRmsx?=
 =?utf-8?B?djRFbWxaVTRaZjZraDRINkZzdnFNNk40UnZnK3haWTVXZnNzV3Q1aDl5Q2Mv?=
 =?utf-8?B?cWNSWTd3UGE1d20yT3lwOTRPS0dLeGZyQm1NNTJSKzBFQnVYMkIveXlSdUtU?=
 =?utf-8?B?Y05aSmxyc3M0ak9rQWhzemVxU09PSzkyM0JuU2dLbm9FbjRQSWRYVjZOUVo1?=
 =?utf-8?B?MjZKd2JnOFNtWHhpT1E5Ry9ndXB3c25ncDZ2U2ZPQXBGN1ErQjZnTWZVK2E1?=
 =?utf-8?B?YXFta2pEVlZNRk52eU0ra09aVmluQmEzS01qbVhtTXMzZjNZM2E2ejhFWm5s?=
 =?utf-8?B?OHFCZjE5VVNIL1hyb1grY0RaZUszUHNId1JNT2E2Z3BlZTMvR0FrY1VnNG9B?=
 =?utf-8?B?S21PS25HQnFiTnJoZ2NIeGg3K2hGcUN4NW45OGZVUmRzT2M3b0NCTXNoYTlm?=
 =?utf-8?B?a0kxeHBFYktsRkYyRHUvdEpyY05vdCtlSlRjdW84Y0lGMnEybHdHcElFVkF2?=
 =?utf-8?B?ZHp3R1JRTHRVZWszYU9sSnNyd1NnNzdQek01S0t4RVdwdC9aVWhZRG1LeEh4?=
 =?utf-8?B?MUdsYnAzaWQ5VHBKUU8yUlFDMTV4U3VaWCtXNFd4Ukp0dDYzV2VvRUlXV29j?=
 =?utf-8?B?M200aU1sTnNrR2o0RFNreEQyV29ZdmZtcDhQNzluZXgxc29aSTRIUTZBUmd4?=
 =?utf-8?B?S0kwa29uYkFuem5pQmZ1YjhoMkpuekpPRGZHcnNJcWZVN0J6ZUxINTJKNUpP?=
 =?utf-8?B?KzdwMzNhK0d3Ry9WZE5UeGx1ODhOUlJQVG5VRDZUQmM0SGxDQjJTUDNTWmZQ?=
 =?utf-8?B?eUE2eE5GK0pqeUdsN2NLV2hjdkg1NVRNKzZRejUycXFSNFd0MGJkTUJiaTZk?=
 =?utf-8?B?S3hXNG5JQ2V0L1NULzU0ZTJZdno2dmNPejQ0ODV0QVBvUVhyV3BQL2xTMnBB?=
 =?utf-8?Q?z/rg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d6f1e0-24ff-4855-0c8b-08db23e7671c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 17:21:37.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtAHVR8J8fT7vbW609plONZ8mZ0qMcjPESo540QD2brOPFU8gCsnyGSMxqmjZBRe5s6wwN6ucJSXUmjtpo/HBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
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

PiBVcG9uIHJlYWRpbmcgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcywgSSB0aGluayB0aGUgYWJvdmUg
bWlnaHQgYmUgYmFzZWQNCj4gb24gbWUgbWlzdW5kZXJzdGFuZGluZyB0aGlzIGJpdC4NCj4NCj4g
SWYgSSB1bmRlcnN0YW5kIHRoaW5ncyBjb3JyZWN0bHkgdGhlbiB3aGF0IGlzIG5ldyB3aXRoIGVt
ZXJhbGRfcmFwaWRzDQo+IGlzIHN1cHBvcnQgZm9yIGEgc2Vjb25kIHNldC90eXBlIG9mIHRlc3Rz
IGNhbGxlZCAiIEFycmF5IFNjYW4gdGVzdCINCj4gYW5kIHRoZSBvbGQgdGVzdCBtZXRob2QgLyB0
ZXN0LXR5cGUgaXMgYWxzbyBzdGlsbCBzdXBwb3J0ZWQuDQoNClllcy4gRW1lcmFsZCBSYXBpZHMg
c3VwcG9ydHMgdGhlIG5ldyBhcnJheSBzY2FuIHRlc3QgKmluIGFkZGl0aW9uIHRvKg0KdGhlIGV4
aXN0aW5nIHNjYW4gdGVzdC4gIEZ1dHVyZSBDUFVzIHdpbGwgc3VwcG9ydCBib3RoIG9mIHRoZXNl
IHRlc3RzDQphbmQgbWF5IGFkZCBhZGRpdGlvbmFsIHRlc3RzLiBGdXJ0aGVyIGluIHRoZSBmdXR1
cmUgaWYgc29tZSBuZXcgdGVzdHMNCmNvdmVyIHRoZSBzYW1lIGZ1bmN0aW9uYWxpdHkgYXMgb2xk
ZXIgdGVzdHMsIHNvbWUgb2YgdGhlIG9sZGVyIHRlc3RzDQptYXkgYmUgZHJvcHBlZC4NCg0KU28g
dGhlIElOVEVHUklUWV9DQVBBQklMSVRJRVMgTVNSIGlzIGEgYml0bWFwIGVudW1lcmF0aW5nDQp3
aGljaCB0ZXN0cyBhcmUgc3VwcG9ydGVkIG9uIGVhY2ggbW9kZWwuDQoNCj4gQW5kIHlvdSBoYXZl
IGNob3NlbiB0byByZWdpc3RlciAyIG1pc2MtZGV2aWNlcyAsIG9uZSBwZXIgc3VwcG9ydGVkDQo+
IHRlc3QgdHlwZSA/DQo+DQo+IEhhdmUgSSB1bmRlcnN0b29kIHRoYXQgY29ycmVjdGx5Pw0KDQpZ
ZXMuDQoNCj4gTWF5IEkgYXNrIHdoeSB1c2UgMSBtaXNjIGRldmljZSBwZXIgdGVzdC10eXBlLiBX
aHkgbm90IGp1c3QgYWRkDQo+IGEgc2luZ2xlIG5ldyBzeXNmc19hdHRyIHRvIHRoZSBleGlzdGlu
ZyBtaXNjIGRldmljZSB0byB0cmlnZ2VyDQo+IHRoZSBuZXcgdGVzdC10eXBlID8NCg0KVGhhdCdz
IGFuIGludGVyZXN0aW5nIGlkZWEuIFNvIHdlJ2QgaGF2ZToNCg0KIyBlY2hvICRjcHUgPiBydW5f
dGVzdA0KIyBjYXQgc3RhdHVzDQouLi4NCiMgY2F0IGRldGFpbHMNCi4uLg0KDQpmb3Igb3VyIGZp
cnN0IHR5cGUgb2YgdGVzdCAoaW50cm9kdWNlZCB3aXRoIFNhcHBoaXJlIFJhcGlkcykuIFRoZW4N
CmluIHRoZSBzYW1lIGRpcmVjdG9yeSBhZGQgYSBuZXcgZmlsZSB0byBydW4gdGhlIGFycmF5IHRl
c3QgKG9uIEVtZXJhbGQNClJhcGlkcyBhbmRvdGhlciBmdXR1cmUgQ1BVcyB0aGF0IHN1cHBvcnQg
aXQpDQoNCiMgZWNobyAkY3B1ID4gcnVuX2FycmF5X3Rlc3QNCiMgY2F0IHN0YXR1cw0KLi4uDQoj
IGNhdCBkZXRhaWxzDQouLi4NCg0KQnV0IEkgc2VlIGEgcHJvYmxlbSB3aXRoIHRoZSAiY3VycmVu
dF9iYXRjaCIgZmlsZSAodGhhdCB3aWxsIHNob3cgdXAgaWYgYSBmdXR1cmUNCnRlc3QgYWxzbyBu
ZWVkcyB0byBsb2FkIHNvbWUgdGVzdCBkYXRhIC4uLiBzcG9pbGVyIC4uLiBpdCB3aWxsKS4NCg0K
V2UgY2FuJ3QgZG86DQoNCiMgZWNobyAyID4gY3VycmVudF9iYXRjaA0KICAuLi4gd2hhdCBzaG91
bGQgdGhpcyBsb2FkLCBkb24ndCBrbm93IHVudGlsIHRoZSB1c2VyIHR5cGVzIG9uZSBvZg0KDQoj
IGVjaG8gJGNwdSA+IHJ1bl90ZXN0DQoNCm9yDQoNCiMgZWNobyAkY3B1ID4gcnVuXyR7bmFtZX1f
dGVzdA0KDQpQZXJoYXBzIGFsc28gaGF2ZSBwZXIgdGVzdCB0eXBlIG5hbWVzIHRvIGxvYWQgdGhl
IHRlc3QgaW1hZ2VzPw0KDQojIGVjaG8gMiA+IGN1cnJlbnRfJHtuYW1lfV9iYXRjaA0KIyBlY2hv
ICRjcHUgPiBydW5fJHtuYW1lfV90ZXN0DQoNCg0KSSdtIG5vdCBzdXJlIHRoaXMgaXMgYmV0dGVy
IHRoYW4gc3BsaXR0aW5nIHRoZSB0ZXN0cyBpbnRvIGRpZmZlcmVudCBkaXJlY3Rvcmllcy4NCg0K
LVRvbnkNCg0KDQoNCg==

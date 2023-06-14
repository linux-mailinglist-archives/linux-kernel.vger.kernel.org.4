Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67BB72F684
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbjFNHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbjFNHiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:38:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100B1FD8;
        Wed, 14 Jun 2023 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686728299; x=1718264299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mpx7O4G/6o60LT/8EGEbjLNpR/Y00vZsmIiUPQLIvbo=;
  b=hbZTcv4xOET0wvcrG1sWcOqDeOyFxK9OPCku7a8q7sqFflyB5+BD8GaB
   fAUAslqc67CiwxXGvAUyHLp8feNvhFVanL8xK19rmVqGI1MyJIyccggNq
   aD45RS9qhu1zMy2JyAnortMoWsx0WDF75AdIIx9a360SWKQ5Zs60xHwFz
   lDHeOc3w+XUFU3sE9g/tgG0ltIOaEz6ir/F/ORZMVhdP42YrowfQqYiSN
   IakLLh+UTmGXlRPUojKN3yVYVFXtBck+RKXm0PZAJ1Tjy7lnxsx0de9xg
   1rBYCovs82PO8lMg0BZI78UYYlB1c0tf2gbJCNGH9iRUw4rAevgcqWV1k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343241702"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="343241702"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 00:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="706111685"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="706111685"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2023 00:37:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 00:37:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 00:37:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 00:37:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 00:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z28Qde5GmV2kkbHpYeBNWVx/EjVnjLU2kDrNG3Nm+wk+4hnVbduXsLeGw789NUpTS6PHu6rmvi7JcaMo7B5Bkvh96X6KbJIoio3dNgXiubiserxZ8Rdxwfyg5CrGwHKxrY5Hx2kSGilLDD5RTNWEIe8WmqW+qiZBAyf3rlDuDOgqtwrger2DMiF6HCyu0NrR5VXFC4ER+kKJrvN86K8b1KxwHIDafjyNIC/aSg4u0bIalV9Ls27pnXjntUE62rVPJMrn1YzJEvfWWgRy2BLrR+g/byH+sFjCghLpzlBeKkHl+4TI8FRXxcGXVs5MxabcEVZwE7l8jHcyW2ij1J9t2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpx7O4G/6o60LT/8EGEbjLNpR/Y00vZsmIiUPQLIvbo=;
 b=JEaVPBUNisKMpLRqL7tyFXIFN4Tmlao+9FLhTZOoZlHZpKqA69D0EP4oa51Tnl8Wl7Xv3nVKjxMvE2cB2JvIjVGUQC0143ER7SS4kPEB2pdD31jH1DybUG1cs850+bs+EM7SsQw1s2sDK+vUkuY+bihYnLp3a7UveGkkGKqWEgg7YJUTEy/KMC/2fnEDxL58GoFqbSGzPrUoxR0X1biRQhP/fgrBcQPJw/DcS6aw7i4gmGemr8v4v5gWQXwxNQJyka0ylRemJKlBvyKijGrRF+59YoyNFZ0hirHwKW/KG6O7PP+nl+k/WX77D6sCOmD0+T9wsrHylVVf1O3W30mNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CH0PR11MB5507.namprd11.prod.outlook.com (2603:10b6:610:d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Wed, 14 Jun 2023 07:37:50 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::da07:d06e:a4ca:6d24]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::da07:d06e:a4ca:6d24%3]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 07:37:50 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>
Subject: RE: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Thread-Topic: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Thread-Index: AQHZnU2j++oR5Nh9vEmr05LOPnMSQ6+I9zcAgADlQLA=
Date:   Wed, 14 Jun 2023 07:37:50 +0000
Message-ID: <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com>
In-Reply-To: <ZIihRqZljMaMRGcK@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CH0PR11MB5507:EE_
x-ms-office365-filtering-correlation-id: 15f0495a-d961-400c-a421-08db6caa41ce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNQu4gGvi43FTJDKUdfAopAZuE9OclvunVY3cn80p+lplqVSulzXRh5EDB156fvAVLpM3d0fAQW7jWys2Q+1tYTIm7Vx0tBUSjqQFgejGroY2/lMpnPDRPBRU3Xv6ISiWNPH/tI9zfx0Le/oFnNrd7eiw81KuaQtbVLDxuOX4TXk1trvjyO7ks4Rx9jJ6jct0dyusSk5NVBt8yKqjlG9HIVh0uD0frrjmLuLLIRC7UAPq5PxXxr+qRoC+/hcSeP2vnF5K3mMRTTf0O0/glEalBSpgB7tmHgpakV+Q0A7SDSc3GDXacl7R9ihX1NOPNR9Uam2cTpyr8wMWyymLqxKN76D19BbJasGxzHCieLaNso63TTiHeRBpGjxrh+2o626bM8rnDpOux3WpEw4XHTSNpyiz4dw8B6hMvkMGd6FtpZph2+m5zABWcMtZumSJOpu1My+0Q7ncrDLisGHbP/J3E/M0VRcNmu7cbLAEDkpG6HR1mBk/tSgoO12IOigs+uqAKartQkH+Jkh0RkcHeSVFrl7ycWUXlJwaFguArGZBelLVJW4nESSiPDXeiznVFlQMadUWUeTv519HhlRVy1I0ycshmxf24NcWFGJzpccpL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(7696005)(8936002)(9686003)(26005)(8676002)(41300700001)(38100700002)(478600001)(82960400001)(86362001)(71200400001)(66946007)(66476007)(6636002)(4326008)(76116006)(64756008)(66446008)(66556008)(316002)(122000001)(38070700005)(33656002)(110136005)(54906003)(6506007)(55016003)(5660300002)(83380400001)(52536014)(186003)(7406005)(15650500001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlZnSVQwbFJFL1paNWVlaG1zZlp5SGJzbDhJRjkxcWdyYzJLSXhoYjFVK0Y1?=
 =?utf-8?B?TkY1ZVVRUFYwejNYelM3ZmdpMkZCWkpSZUxna0kzYUhoaitNc092ZmJJVW5j?=
 =?utf-8?B?bnd3UmJuaVdvTmw0aGdZTDRpeFJmckR1bUF2SEs0Qm5TRkZ6N0ZJbHk2cGFy?=
 =?utf-8?B?RXJURS9zWGx0RWFhbHJ0bTBWQmwzMlkyL0tiVGtDUXk0YlhZUE84cU1HOTMx?=
 =?utf-8?B?akVHQU5ZMzBHWUR6R1p1em9VcnpENWJLRW14Mm0wWllpMDVzaExBTmx5TEVD?=
 =?utf-8?B?eDNYd1NkNWFpY3BKV3A3YTcrTnZla1kvcDdTc0RTRGpaaDdkakplSUJ0U3hl?=
 =?utf-8?B?R2hkMW02WVUyM3Q3MlBVekMyWmlmMnByUzVyb2dCd1RlZ1gwek0vaWFDd2NZ?=
 =?utf-8?B?Sy9uNDZaZTRLaVJ0SnhoYjQwa0ZxcDR5V3Y5aFpId3crcDRYcDV0V2pCRGh4?=
 =?utf-8?B?UDZPMXJCY3VxaEFwd0YvY0VhK1d6MmMxSHlxR0kzVGh0L1RPVXpxNUV2VUdI?=
 =?utf-8?B?cVRpZnN1NFJlVmlyaTRnZk0yUjZXNmttT3NXUDA4OXllVG1wbzg5RVU1Wjc1?=
 =?utf-8?B?bW5GVG93M1A2T25kRE95ODJjK2lxcHRZN0FBOG1IS1NnL3hnSlEycWNleWtW?=
 =?utf-8?B?cVoyZFRqRk1ZckhFYTluVlpPbmljT3BhZjJLQ0Yza0hJaXp2U3UwcUVUcWNC?=
 =?utf-8?B?bTMyUDJaRGlTT29PcGhaVnYvQkJsaU9ZaFdmM2VXdUFFYXdJRkpSN0hHT0RN?=
 =?utf-8?B?M0VjZXJWVVBaYUtrTUpxRXZsR1FvMmY4OFRTRTVRTWZjaW9nV1c1Y004djdM?=
 =?utf-8?B?N2NLRUJxa281OGwzUDdXUDN3TVJzMTRoMkV2K2JMVG1tVGNxM2sxT1F1WWdJ?=
 =?utf-8?B?SlFCY3p1QVdMZEJyRGhFQ3k0RzVxZlFTOFg0aFFzbnFiZ3dnUVRwOW9YcGR0?=
 =?utf-8?B?dFdsQmYxTkJlU2pocmZGNGdrZXd2M0ora0o2Q1g2NDd4M3d4TXNlZXRWZkZL?=
 =?utf-8?B?Y1FxRVdpVXBza1ZqMXdqa3d1RmRTZXBwUTFuL1lRbVNCR0tGMUhwbE5CVzBW?=
 =?utf-8?B?MkV2djF1U0k3U2JTZGZlKzIxMkxqaFhYbUcrd0dSVHRNVjdRNWo2NnNLaDhs?=
 =?utf-8?B?NUZVYWRrcmJ6MUZJRU5wa2toT1ZhZWorVWNPemdrRTN5Wm5rSmpVdFhpcXdk?=
 =?utf-8?B?TlFlc01sWjk1TzMrMDFMb2FYTW1Pb2QxcVlYRmVIUU9JbHhBQ1Y4eENwNUov?=
 =?utf-8?B?Y0hOZ3hiNnlzMHh0L290Z1M4YTFvZGh0QWtzWU8wWCtFdXJQcFZLL1U4UDZU?=
 =?utf-8?B?RG16eDc4UFl4a2hhR2ZyMy9iWEp1emprOG4wbHNSQ2lnYlplUC9lVUZLTzNT?=
 =?utf-8?B?TkpXTmx5K2RFcGZwa2hpR0UwczVJMUhhbm9Cd3c0WlArN2ZLQkdWRG5TRHFt?=
 =?utf-8?B?S1lidWtmZGZIcndtaWpKMHNrY3RvZlNCZXpaZ0xYYlF3OVlHUjhQMXFPQTJs?=
 =?utf-8?B?eitLT0thWHhlR1dOeEJJUHhHVGtPQUNycWpZdDI5c2w3RHJ4Q09jV3hqWFox?=
 =?utf-8?B?Ykt0YVNGQ3NCQlI0U0FmcWhLYmM3a3hIbHpHMkc1RzlrTUxyQUNKaFhDaFZ4?=
 =?utf-8?B?TlFiYkN6QjdUZ254WU9vVVVYcVpEK1dVbDU3RzFmd1cvNHpOK2FrRjMvQlZS?=
 =?utf-8?B?RDhrcy8xMmQ0SWV3eFRydzNMa095WktNN0k5bTNFR0t2ZlAyeEd0Ymh5RzFy?=
 =?utf-8?B?amg4UGFpRHJ1MDJJT1JVSEUwbjc2cVFTaEhTelIzY0dYUzZScG1iV09ENVkw?=
 =?utf-8?B?VTNYdzdmQXc3SjRjWFNvQlhoejE0Qm9yNTgwTTdlU05IaHN2RllvVlJZRXNM?=
 =?utf-8?B?ZVg1ak9qekxiK2MvdmdIalZEWEczeEwrOE55eVN5UU9vK2J4b2NzdlFTcUpF?=
 =?utf-8?B?WTB6VzhGd3VWU1RCVzkyOVZ1TjQ3OXlOU0hjVW5nSUxMY0JBb3ZFdE82OVhL?=
 =?utf-8?B?WElucFlzdGlhOGd1N1NYcFZPckh6Y1BCajlZZjlMYmkwdXpTRWdPSFJ5UFZJ?=
 =?utf-8?B?cUo2eHFHeDVYY1EyUVU5czFOZjZnRC9ESkY1SEdGM0U2THJJdkZhSkZqUXJO?=
 =?utf-8?Q?8FuwwcwLo3CV6tl7fMcLlGdFX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f0495a-d961-400c-a421-08db6caa41ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:37:50.7322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcfAB27+g7cu+89R4BJAj0QQQpBrUjMG8IHCsvx5FhXzfqhuzSnEnOVopVK3FFvf8CmCwLwiQ5CPKCQ36gUfiORsdrvrfEIm+mc64/6U1Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBNb24sIEp1biAxMiwgMjAyMywgQ2FybG9zIEJpbGJhbyB3cm90ZToNCj4gPiBLZXJuZWwg
ZGV2ZWxvcGVycyB3b3JraW5nIG9uIGNvbmZpZGVudGlhbCBjb21wdXRpbmcgZm9yIHZpcnR1YWxp
emVkDQo+ID4gZW52aXJvbm1lbnRzIGluIHg4NiBvcGVyYXRlIHVuZGVyIGEgc2V0IG9mIGFzc3Vt
cHRpb25zIHJlZ2FyZGluZyB0aGUgTGludXgNCj4gDQo+IE5vLCAieDg2IiBpc24ndCBzcGVjaWFs
LCBTTlAgYW5kIFREWCBhbmQgczM5MCdzIFVWIGFyZSBzcGVjaWFsLiAgcEtWTSBpcyBzaW1pbGFy
LA0KPiBidXQgKGEpIGl0J3Mgbm90IGFzIHBhcmFub2lkIGFzIFNOUCBhbmQgVERYLCBhbmQgKGIp
IHRoZSBrbm93biB1c2UgY2FzZSBmb3IgcEtWTQ0KPiBvbiB4ODYgaXMgdG8gaGFyZGVuIHVzYWdl
IG9mIGhhcmR3YXJlIGRldmljZXMsIGkuZS4gcEtWTSB4ODYgImd1ZXN0cyIgbGlrZWx5DQo+IGRv
bid0DQo+IGhhdmUgdGhlIHNhbWUgInVudHJ1c3RlZCB2aXJ0dWFsIGRldmljZSIgYXR0YWNrIHN1
cmZhY2VzIGEgU05QL1REWC9VViBndWVzdHMuDQoNCisgSmFzb24gQ2hlbiB0byBoZWxwIGNsYXJp
ZnlpbmcgdGhlIHBLVk0gb24geDg2IGNhc2UuDQoNCk15IGltcHJlc3Npb24gd2FzIHRoYXQgcEtW
TSBvbiB4ODYgd291bGQgc2ltaWxhcmx5IGNhcmUgYWJvdXQgaGFyZGVuaW5nIGl0cw0KcEtWTSBn
dWVzdCBrZXJuZWwgYWdhaW5zdCBob3N0IGF0dGFja3MuIEJlY2F1c2UgaW4gc2VjdXJpdHkgd29y
bGQsDQppZiB5b3UgdHJ5IHRvIHB1dCBzbXRoIG91dHNpZGUgb2YgeW91ciBUQ0IgKGhvc3QgU1cg
c3RhY2sgaW4gdGhpcyBjYXNlKSwNCnlvdSBhdXRvbWF0aWNhbGx5IG5lZWQgdG8gcHJldmVudCBw
cml2aWxlZ2UgZXNjYWxhdGlvbiBhdHRhY2tzIGZyb20gDQpvdXRzaWRlIHRvIGluc2lkZSBhbmQg
dGhhdCBpbXBsaWVzIGNhcmluZyBhYm91dCBhdHRhY2tzIHRoYXQgaG9zdCBjYW4NCmRvIHZpYSBs
ZXQncyBzYXkgbWFsaWNpb3VzIHBjaSBkcml2ZXJzIGFuZCBzdWNoLg0KV2hhdCBwcmV2ZW50cyBo
b3N0IGRvaW5nIHN1Y2ggYXR0YWNrcyBpbiBwS1ZNIGNhc2U/IA0KDQo+IA0KPiA+ICtLZXJuZWwg
ZGV2ZWxvcGVycyB3b3JraW5nIG9uIGNvbmZpZGVudGlhbCBjb21wdXRpbmcgZm9yIHZpcnR1YWxp
emVkDQo+ID4gK2Vudmlyb25tZW50cyBpbiB4ODYgb3BlcmF0ZSB1bmRlciBhIHNldCBvZiBhc3N1
bXB0aW9ucyByZWdhcmRpbmcgdGhlIExpbnV4DQo+IA0KPiBJIGRvbid0IHRoaW5rICJ2aXJ0dWFs
aXplZCBlbnZpcm9ubWVudHMiIGlzIHRoZSByaWdodCBkZXNjcmlwdGlvbi4gIElNTywgImNsb3Vk
DQo+IGNvbXB1dGluZyBlbnZpcm9ubWVudHMiIG9yIG1heWJlICJvZmYtcHJlbWlzZSBlbnZpcm9u
bWVudHMiIG1vcmUNCj4gYWNjdXJhdGVseQ0KPiBjYXB0dXJlcyB3aGF0IHlvdSB3YW50IHRvIGRv
Y3VtZW50LCB0aG91Z2ggdGhlIGxhdHRlciBmYWlscyB0byBpbXBseSB0aGUNCj4gInZpcnR1YWwi
DQo+IGFzcGVjdCBvZiB0aGluZ3MuDQoNCkhtLi4gImNsb3VkIGNvbXB1dGluZyBlbnZpcm9ubWVu
dHMiIGV4cGxpY2l0bHkgaW1wbGllcyAiY2xvdWQiLCB3aGljaCBpcyB3aGF0DQp3ZSB3ZXJlIHRy
eWluZyB0byBnZXQgYXdheSBmcm9tIGluIHYyLCBiZWNhdXNlIGl0IGRlc2NyaWJlcyBhICpwYXJ0
aWN1bGFyKiB1c2UgY2FzZQ0Kd2hlcmUgQ29DbyBWTXMgY2FuIGJlIHVzZWQgKGFuZCBwcm9iYWJs
eSB3aWxsIGJlIHVzZWQgYSBsb3QgaW4gcHJhY3RpY2UpLCBidXQNCndlIGRvbuKAmXQgd2FudCB0
byBsaW1pdCB0aGlzIHRvIGp1c3QgdGhhdCB1c2UgY2FzZSBhbmQgZXhjbHVkZSBvdGhlcnMuIA0K
Im9mZi1wcmVtaXNlIGVudmlyb25tZW50cyIgaXMgc28gdmFndWUgaW1vIHRoYXQgSSB3b3VsZCBu
b3Qga25vdyB3aGF0IGl0IG1lYW5zDQppbiB0aGlzIGNvbnRleHQsIGlmIEkgd291bGQgYmUgYSBw
ZXJzb24gbmV3IHRvIHRoZSB0b3BpYyBvZiBDb0NvLiBBbmQgYXMgeW91IHNhaWQNCml0IGRvZXNu
4oCZdCBldmVuIGltcGx5IHRoZSB2aXJ0dWFsIGFzcGVjdCBhdCBhbGwuIA0KDQo+IA0KPiA+ICtU
aGUgc3BlY2lmaWMgZGV0YWlscyBvZiB0aGUgQ29DbyBzZWN1cml0eSBtYW5hZ2VyIHZhc3RseSBk
aXZlcmdlIGJldHdlZW4NCj4gPiArdGVjaG5vbG9naWVzLiBGb3IgZXhhbXBsZSwgaW4gc29tZSBj
YXNlcywgaXQgd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBIVw0KPiA+ICt3aGlsZSBpbiBvdGhlcnMg
aXQgbWF5IGJlIHB1cmUgU1cuIEluIHNvbWUgY2FzZXMsIHN1Y2ggYXMgZm9yIHRoZQ0KPiA+ICtg
UHJvdGVjdGVkIGtlcm5lbC1iYXNlZCB2aXJ0dWFsIG1hY2hpbmUgKHBLVk0pIDxodHRwczovL2dp
dGh1Yi5jb20vaW50ZWwtDQo+IHN0YWdpbmcvcEtWTS1JQT5gLA0KPiA+ICt0aGUgQ29DbyBzZWN1
cml0eSBtYW5hZ2VyIGlzIGEgc21hbGwsIGlzb2xhdGVkIGFuZCBoaWdobHkgcHJpdmlsZWdlZA0K
PiA+ICsoY29tcGFyZWQgdG8gdGhlIHJlc3Qgb2YgU1cgcnVubmluZyBvbiB0aGUgaG9zdCkgcGFy
dCBvZiBhIHRyYWRpdGlvbmFsDQo+ID4gK1ZNTS4NCj4gDQo+IEkgc2F5IHRoYXQgInZpcnR1YWxp
emVkIGVudmlyb25tZW50cyIgaXNuJ3QgYSBnb29kIGRlc2NyaXB0aW9uIGJlY2F1c2Ugd2hpbGUN
Cj4gcEtWTQ0KPiBkb2VzIHV0aWxpemUgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24sIG15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCB0aGUgcHJpbWFyeSB1c2UNCj4gY2FzZXMgZm9yIHBLVk0gZG9uJ3Qg
aGF2ZSB0aGUgc2FtZSB0aHJlYXQgbW9kZWwgYXMgU05QL1REWCwgZS5nLiBJSVVDIG1hbnkNCj4g
KG1vc3Q/DQo+IGFsbD8pIHBLVk0gZ3Vlc3RzIGRvbid0IHJlcXVpcmUgbmV0d29yayBhY2Nlc3Mu
DQoNCk5vdCBoYXZpbmcgYSBuZXR3b3JrIGFjY2VzcyByZXF1aXJlbWVudCBkb2VzbuKAmXQgaW1w
bGljaXRseSBpbnZhbGlkYXRlIHRoZSANCnNlcGFyYXRpb24gZ3VhcmFudGVlcyBiZXR3ZWVuIHRo
ZSBob3N0IGFuZCBndWVzdCwgaXQganVzdCBtYWtlcyBpdCBlYXNpZXINCnNpbmNlIHlvdSBoYXZl
IG9uZSBpbnRlcmZhY2UgbGVzcyBiZXR3ZWVuIHRoZSBob3N0IGFuZCBndWVzdC4gDQpCdXQgYWdh
aW4gSSB3aWxsIGxldCBKYXNvbiB0byByZXBseSBvbiB0aGlzIHNpbmNlIGhlIGtub3dzIGRldGFp
bHMuIA0KDQpCdXQgd2hhdCB5b3UgYXJlIHNheWluZyBtb3JlIGdlbmVyYWxseSBoZXJlIGFuZCBh
Ym92ZSBpcyB0aGF0IHlvdSBkb27igJl0IHdhbnQNCnBLVk0gY2FzZSBpbmNsdWRlZCBpbnRvIHRo
aXMgdGhyZWF0IG1vZGVsLCBkaWQgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHk/IA0KDQo+IA0K
PiA+ICtDb25maWRlbnRpYWwgQ29tcHV0aW5nIGFkZHMgYSBuZXcgdHlwZSBvZiBhdHRhY2tlciB0
byB0aGUgYWJvdmUgbGlzdDogYQ0KPiANCj4gVGhpcyBzaG91bGQgYmUgcXVhbGlmaWVkIGFzICJD
b0NvIGZvciBjbG91ZCIsIG9yIHdoYXRldmVyIHN1YmxhYmVsIHdlIGxhbmQgb24uDQoNClllcywg
d2UganVzdCBuZWVkIHRvIGZpbmQgdGhpcyBsYWJlbC4gSWYgeW91IHJlbWVtYmVyLCB2MSBoYWQg
dGhlIG5hbWUgDQoiQ29uZmlkZW50aWFsIENsb3VkIENvbXB1dGluZyIsIHdoaWNoIHlvdSB3ZXJl
IHRoZSBmaXJzdCBvbmUgdG8gY29tcGxhaW4gYWJvdXQgKSkNCg0KPiANCj4gPiArcG90ZW50aWFs
bHkgbWlzYmVoYXZpbmcgaG9zdCAod2hpY2ggY2FuIGFsc28gaW5jbHVkZSBzb21lIHBhcnQgb2Yg
YQ0KPiA+ICt0cmFkaXRpb25hbCBWTU0gb3IgYWxsIG9mIGl0KSwgd2hpY2ggaXMgdHlwaWNhbGx5
IHBsYWNlZCBvdXRzaWRlIG9mIHRoZQ0KPiA+ICtDb0NvIFZNIFRDQiBkdWUgdG8gaXRzIGxhcmdl
IFNXIGF0dGFjayBzdXJmYWNlLiBJdCBpcyBpbXBvcnRhbnQgdG8gbm90ZQ0KPiA+ICt0aGF0IHRo
aXMgZG9lc27igJl0IGltcGx5IHRoYXQgdGhlIGhvc3Qgb3IgVk1NIGFyZSBpbnRlbnRpb25hbGx5
DQo+ID4gK21hbGljaW91cywgYnV0IHRoYXQgdGhlcmUgZXhpc3RzIGEgc2VjdXJpdHkgdmFsdWUg
aW4gaGF2aW5nIGEgc21hbGwgQ29Dbw0KPiA+ICtWTSBUQ0IuIFRoaXMgbmV3IHR5cGUgb2YgYWR2
ZXJzYXJ5IG1heSBiZSB2aWV3ZWQgYXMgYSBtb3JlIHBvd2VyZnVsIHR5cGUNCj4gPiArb2YgZXh0
ZXJuYWwgYXR0YWNrZXIsIGFzIGl0IHJlc2lkZXMgbG9jYWxseSBvbiB0aGUgc2FtZSBwaHlzaWNh
bCBtYWNoaW5lDQo+ID4gKy1pbiBjb250cmFzdCB0byBhIHJlbW90ZSBuZXR3b3JrIGF0dGFja2Vy
LSBhbmQgaGFzIGNvbnRyb2wgb3ZlciB0aGUgZ3Vlc3QNCj4gPiAra2VybmVsIGNvbW11bmljYXRp
b24gd2l0aCBtb3N0IG9mIHRoZSBIVzo6DQo+IA0KPiBJSVVDLCB0aGlzIGxhc3Qgc3RhdGVtZW50
IGRvZXNuJ3QgaG9sZCB0cnVlIGZvciB0aGUgcEtWTSBvbiB4ODYgdXNlIGNhc2UsIHdoaWNoDQo+
IHNwZWNpZmljYWxseSBhaW1zIHRvIGdpdmUgYSAiZ3Vlc3QiIGV4Y2x1c2l2ZSBhY2Nlc3MgdG8g
aGFyZHdhcmUgcmVzb3VyY2VzLg0KDQpEb2VzIGl0IGhvbGQgZm9yICphbGwqIEhXIHJlc291cmNl
cz8gSWYgeWVzLCBpbmRlZWQgdGhpcyB3b3VsZCBtYWtlIHBLVk0gb24NCng4NiBjb25zaWRlcmFi
bHkgZGlmZmVyZW50LiANCg0KPiANCj4gPiArVGhlICoqTGludXgga2VybmVsIENvQ28gVk0gc2Vj
dXJpdHkgb2JqZWN0aXZlcyoqIGNhbiBiZSBzdW1tYXJpemVkIGFzDQo+IGZvbGxvd3M6DQo+ID4g
Kw0KPiA+ICsxLiBQcmVzZXJ2ZSB0aGUgY29uZmlkZW50aWFsaXR5IGFuZCBpbnRlZ3JpdHkgb2Yg
Q29DbyBndWVzdCdzIHByaXZhdGUNCj4gPiArbWVtb3J5IGFuZCByZWdpc3RlcnMuDQo+IA0KPiBB
cyBJIGNvbXBsYWluZWQgaW4gdjEsIHRoaXMgZG9lc24ndCBob2xkIHRydWUgZm9yIGFsbCBvZiB4
ODYuICBNeSBjb21wbGFpbnQgZ29lcw0KPiBhd2F5IGlmIHRoZSBkb2N1bWVudCBpcyBzcGVjaWZp
YyB0byB0aGUgVERYL1NOUC9VViB0aHJlYXQgbW9kZWxzLCBidXQgZGVzY3JpYmluZw0KPiB0aGUg
ZG9jIGFzICJ4ODYgc3BlY2lmaWMiIGlzIG1pc2xlYWRpbmcsIGFzIHRoZSB0aHJlYXQgbW9kZWwg
aXNuJ3QgeDg2IHNwZWNpZmljLA0KPiBub3IgZG8gYWxsIGNvbmZpZGVudGlhbCBjb21wdXRlIHRl
Y2hub2xvZ2llcyB0aGF0IHJ1biBvbiB4ODYgc2hhcmUgdGhlc2UNCj4gb2JqZWN0aXZlcywNCj4g
ZS5nLiB2YW5pbGxhIFNFVi4NCg0KWWVzLCB0aGlzIGJyaW5ncyB1cyBiYWNrIHRvIHRoZSBuYW1p
bmcgaXNzdWUsIHNlZSBiZWxvdy4NCg0KPiANCj4gPiArd2VsbCBhcyBDb0NvIHRlY2hub2xvZ3kg
c3BlY2lmaWMgaHlwZXJjYWxscywgaWYgcHJlc2VudC4gQWRkaXRpb25hbGx5LCB0aGUNCj4gPiAr
aG9zdCBpbiBhIENvQ28gc3lzdGVtIHR5cGljYWxseSBjb250cm9scyB0aGUgcHJvY2VzcyBvZiBj
cmVhdGluZyBhIENvQ28NCj4gPiArZ3Vlc3Q6IGl0IGhhcyBhIG1ldGhvZCB0byBsb2FkIGludG8g
YSBndWVzdCB0aGUgZmlybXdhcmUgYW5kIGJvb3Rsb2FkZXINCj4gPiAraW1hZ2VzLCB0aGUga2Vy
bmVsIGltYWdlIHRvZ2V0aGVyIHdpdGggdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUuIEFsbCBvZiB0
aGlzDQo+ID4gK2RhdGEgc2hvdWxkIGFsc28gYmUgY29uc2lkZXJlZCB1bnRydXN0ZWQgdW50aWwg
aXRzIGludGVncml0eSBhbmQNCj4gPiArYXV0aGVudGljaXR5IGlzIGVzdGFibGlzaGVkIHZpYSBh
dHRlc3RhdGlvbi4NCj4gDQo+IEF0dGVzdGF0aW9uIGlzIFNOUCBhbmQgVERYIHNwZWNpZmljLiAg
QUlVSSwgbm9uZSBvZiBTRVYsIFNFVi1FUywgb3IgcEtWTSAod2hpY2gNCj4gZG9lc24ndCBldmVu
IHJlYWxseSBleGlzdCBvbiB4ODYgeWV0KSwgaGF2ZSBhdHRlc3RhdGlvbiBvZiB0aGVpciBvd24s
IGUuZy4gdGhlDQo+IHByb3Bvc2VkIHBLVk0gc3VwcG9ydCB3b3VsZCByZWx5IG9uIFNlY3VyZSBC
b290IG9mIHRoZSBvcmlnaW5hbCAiZnVsbCIgaG9zdA0KPiBrZXJuZWwuDQoNCkFncmVlIHRoZSBs
YXN0IHBocmFzZSBuZWVkcyB0byBiZSBjb3JyZWN0ZWQgdG8gYXBwbHkgZm9yIHBLVk0gY2FzZSAo
d2FzIG1pc3NlZA0KaW4gdjIpLCBzbyBwcm9wb3NlIHRvIGhhdmUgdGhpcyB0ZXh0IGluc3RlYWQ6
DQoNCiJBbGwgb2YgdGhpcyBkYXRhIHNob3VsZCBhbHNvIGJlIGNvbnNpZGVyZWQgdW50cnVzdGVk
IHVudGlsIGl0cyBpbnRlZ3JpdHkgYW5kDQphdXRoZW50aWNpdHkgaXMgZXN0YWJsaXNoZWQgdmlh
IGEgQ29DbyB0ZWNobm9sb2d5LWRlZmluZWQgcHJvY2VzcyBzdWNoIGFzIGF0dGVzdGF0aW9uDQpv
ciB2YXJpYW50cyBvZiBzZWN1cmUvdHJ1c3RlZC9hdXRoZW50aWNhdGVkIGJvb3QuIg0KDQpUaGUg
Z29hbCBvZiB0aGUgYWJvdmUgc2VudGVuY2UgaXMgb25seSB0byBzYXkgdGhhdCB0aGUgaW50ZWdy
aXR5L2F1dGhlbnRpY2l0eSANCm11c3QgYmUgZXN0YWJsaXNoZWQgdmlhIHdoYXRldmVyIG1ldGhv
ZCBhIGNvbmNyZXRlIHRlY2hub2xvZ3kgYnJpbmdzLA0Kb3RoZXJ3aXNlIHdlIGhhdmUgYSBiaWcg
cHJvYmxlbSBpbiBzZWN1cml0eS4gDQoNCj4gDQo+ID4gK0NPTkZJREVOVElBTCBDT01QVVRJTkcg
VEhSRUFUIE1PREVMIEZPUiBYODYgVklSVFVBTElaQVRJT04NCj4gPiArTTogICAgRWxlbmEgUmVz
aGV0b3ZhIDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPg0KPiA+ICtNOiAgICBDYXJsb3MgQmls
YmFvIDxjYXJsb3MuYmlsYmFvQGFtZC5jb20+DQo+ID4gK1M6ICAgIE1haW50YWluZWQNCj4gPiAr
RjogICAgRG9jdW1lbnRhdGlvbi9zZWN1cml0eS94ODYtY29uZmlkZW50aWFsLWNvbXB1dGluZy5y
c3QNCj4gDQo+IFRocm93aW5nICJ4ODYiIG9uIHRoZSBuYW1lIGRvZXNuJ3QgY2hhbmdlIG15IG9i
amVjdGlvbnMsIHRoaXMgaXMgc3RpbGwgYW4NCj4gU05QL1REWA0KPiBzcGVjaWZpYyBkb2MgcHJl
dGVuZGluZyB0byBiZSBtb3JlIGdlbmVyaWMgdGhlbiBpdCBhY3R1YWxseSBpcy4gIEkgZG9uJ3Qg
dW5kZXJzdGFuZA0KPiB0aGUgcmVzaXN0YW5jZSB0byBwaWNraW5nIGEgbmFtZSB0aGF0IG1ha2Vz
IGl0IGFidW5kYW50bHkgY2xlYXIgdGhlIGRvYyBjb3ZlcnMgYQ0KPiB2ZXJ5IHNwZWNpZmljIG5p
Y2hlIG9mIGNvbmZpZGVudGlhbCBjb21wdXRpbmcuDQoNCldlIHJlYWxseSBkb27igJl0IHByZXRl
bmQgdG8gIm92ZXJnZW5lcmljIiwgYnV0IHNpbmNlIG5vb25lIGVsc2Ugb3V0c2lkZSBvZiB4ODYg
aXMNCmludGVyZXN0ZWQgdG8gaGVscCB3cml0aW5nIHRoaXMgZG9jdW1lbnQgb3IgYmVjb21pbmcg
YSBjby1tYWludGFpbmVyLCB3ZSBjYW5ub3QNCmNsYWltIGNvdmVyaW5nIG1vcmUgdGhhbiBtZXJl
bHkgZGVzY3JpYmluZyB4ODYgc3BlY2lmaWMgc29sdXRpb25zIGluIHRoaXMgc3BhY2UuDQoNCkJ1
dCwgbGV04oCZcyBhZ3JlZSBvbiB0aGUgbmFtZSBhbmQgdGhlbiB3ZSBjYW4gcGx1ZyBpdCBldmVy
eXdoZXJlIGluIHYzLg0KdjEgdXNlZCAiQ29uZmlkZW50aWFsIENsb3VkIENvbXB1dGluZyINCnYy
IHVzZWQgIkNvbmZpZGVudGlhbCBDb21wdXRpbmcgZm9yIHZpcnR1YWxpemVkIGVudmlyb25tZW50
cyIgDQoNCllvdSBwcm9wb3NlZCBhYm92ZQ0KIkNvbmZpZGVudGlhbCBjb21wdXRpbmcgZm9yIGNs
b3VkIGNvbXB1dGluZyBlbnZpcm9ubWVudHMgIg0KYW5kDQoiQ29uZmlkZW50aWFsIENvbXB1dGlu
ZyBmb3Igb2ZmLXByZW1pc2UgZW52aXJvbm1lbnRzICIuDQoNCkkgc3RpbGwgZG9u4oCZdCBnZXQg
d2hhdCBpcyB3cm9uZyB3aXRoICJDb25maWRlbnRpYWwgQ29tcHV0aW5nIGZvcg0KdmlydHVhbGl6
ZWQgZW52aXJvbm1lbnRzIiBuYW1lOiB5b3UgbWVudGlvbmVkIGl0IGRvZXNu4oCZdA0KZGVzY3Jp
YmUgY29ycmVjdGx5IHdoYXQgd2Ugd2FudCB0byBleHByZXNzLCBidXQgeW91IGRpZG7igJl0IGV4
cGxhaW4NCndoeS4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/DQoNCkFsc28sIGlzIHRoZSBu
YW1lICp0aGF0KiBpbXBvcnRhbnQgZ2l2ZW4gdGhhdCB3ZSBoYXZlIGFscmVhZHkgc3BlbmQNCmEg
d2hvbGUgcGFyYWdyYXBoIGluIHYyIGV4cGxhaW5pbmcgd2hhdCB3ZSBtZWFuIGJ5IHRoaXMgbmFt
ZT8NCldlIGFyZSBhbGwgdGVjaCBwZW9wbGUgaGVyZSwgc28gd2UgZG9u4oCZdCBwbGFuIHRvIHVz
ZSB0aGlzIG5hbWUNCmZvciBtYXJrZXRpbmcgY2FtcGFpZ25zIDopDQoNCkJlc3QgUmVnYXJkcywN
CkVsZW5hLg0KDQoNCg0KDQo=

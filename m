Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431346F700C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjEDQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEDQoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:44:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942B358E;
        Thu,  4 May 2023 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683218638; x=1714754638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Lb6KnDhQ2MBUAbtj3CiZ9nO2NexhDDutJd0oB8qeDE=;
  b=NmL9etlL400Pj6cdL3MFIitthOtStjW05b/s4n0Jn7sm3qdRgp1ZhBHr
   lK3hwBu7nToEpGkp94at3rsiQG0CyIqMhrYBCMPbPwGxreyCFfnK7bwV4
   Gozg9FS499eEogueRE+d/eB229fr2FZdNx4/pv2TbZirU16vmP5lU+VSg
   4Mr1+qLyPwaLmOXo/ce2y0KGO4UBlknGeYVSDu+FslAJ1lOche4KQc8nl
   RD4HYVCvSsq+7BiGj2Po1NDBRxXkc6dYkBBMRkBjqKGR4VD4NXEDdAsxB
   esiXWbLNDGvwTOvUHs+RSofM7tUaKwvXgQF0t7pok/3a8C/w2jEuqZzSn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="346463797"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="346463797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="1027034216"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="1027034216"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2023 09:43:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 09:43:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 09:43:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 09:43:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 09:43:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTXa5HOnaqfNENbiZTywHaYn4io59g/XLzuEzAJMQYXxi8qfk4HU8eMDB2XXyd8B1d/FlrnYYmtaTPLnOWYwCVATTCRTfIDU4ep74jidenOynVcbjLVxbCOjUInWopH2A9KeM8snFNmaKnco0c3woyKz66WSDHx1WSuEA1MC7nEbljhHdMxW1cSEhkoE8HJmjTdHWiSzDQzvKkRin62GdjeePL4TqGrSty8XsKUIqQi1QK0KK6SqQjsfrpP00E/tDUd0iPcxb4knCq6nRqxbNKkv5zgNQWdOLNPqSsJzmP9bwfdPxrx1vBvjaB+NIWvHv8h2P2aA+dBWYzkvGAn39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x01Wl52csola50lGZavHK1LbF91mCfdIxb64vf4skQ=;
 b=gINYfjQ9SBdCvsKc9vUy2hvcLnuIi76Jlos5MH4vOETwEnx4oLnNF/VUcOlzA3aznIUvFc6juxXh5cyffiQfil5++0mfyWwvfjyJuToDDQjSB6AcnPfR0+Ont6mlqo06cNFwGvmyKjwuYgUzZb+5IYZUJXzK9dHbFkQkE9YbglISKVfalyg8XHKnfXVAJoxnE8Z90PqhLjvBXnqwEe8be0e6IQJbXeQ1zfOSxy+Q9/d7MHgowv2nc/HNU7SxTycJ7wZgYuAHHusSKvTtV8xt5PAqxKM4dzHWjW30kZwqNIa+pCbMbEh9KFSUF0hYcqk/D58VtDaQ7/w4W8V3nuVeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5560.namprd11.prod.outlook.com (2603:10b6:408:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 16:43:54 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 16:43:54 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "jaylu102@amd.com" <jaylu102@amd.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: RE: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Topic: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Index: AQHZfoz/HoY7ASH3bUeV4msZv1/xf69KTa1Q
Date:   Thu, 4 May 2023 16:43:53 +0000
Message-ID: <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
In-Reply-To: <20230504133224.2669-1-pmalgujar@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5560:EE_
x-ms-office365-filtering-correlation-id: e11b91c8-550f-4ff7-0201-08db4cbebf4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dv4pYxainnMpsmVzzqZWtOk+VX6RBwlZR0HoCmsnw2idYULg2ob99ofOVvydn6oWNbUO6UV4EqkayYSkEAqEQeXucMlYUAQIYc507+TasEp/3wc5JwD4Swjux+1kESzEnU7BQqCzMwQ2L20xKLx7w+o9kNs+gYtDq2apNFs2WAX8GeWaJbjv+nlYqdko6U56lbofPdGty/pKFQQ7CCP1YldZKUJi1JZp+0WnRFnxp5xU68JruG8utj4eZm4YX0y0mhmUy/VXSZxh4LDa5D4gLz1/EDVr8kHjY8WZ4QvdxB4kyLYs9XiY4f31cuiw53OjZcAQiJzN1oA+TDjfsMx3b7NqBCXS7gWJXm/yyxUPGmzmeNqzxKaJ+8ULckfIZab3j+6GkXEAWtKQBe80l/gsuyelEMEE+YkOfXD+DrxRKIt2Y8dpP1tysD7zXht6Awv1Z/LXFHxE7/SN64iSeCgpBYbpf8/MYR5A68p9enrPzRhyNPKkL0UmjkGYtHswFyfwCw782gYrnm00zqUqGrJelZ4r+Lc11uDwLcNCjj8yMJh192dhXuGjWA9dC/N28LnUHfR6aNAg9712UxMapLJDtsGvgFnlD0nAoL3d0/lLRpoNeUeqawgsXmh9tnp/aNaIMAkpWudx3YARIHFdvl1lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(41300700001)(478600001)(7696005)(71200400001)(55016003)(4326008)(82960400001)(66946007)(64756008)(76116006)(66446008)(66556008)(66476007)(921005)(316002)(122000001)(83380400001)(86362001)(38070700005)(38100700002)(8676002)(8936002)(52536014)(2906002)(7416002)(33656002)(5660300002)(6506007)(26005)(9686003)(110136005)(54906003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+M/eyZ4rflhYFzf37NFuebb5F8DOAQrCYaIBnYCOYGASZ/PqmrfZXeqSM0Rm?=
 =?us-ascii?Q?SEHT86V0gSak0q6B2Opouw1e7D9Oj1kdPk1+RAe0msK//hAxjK7aAYn5U+a3?=
 =?us-ascii?Q?EvRM0KpqjzzhWQCG9IdPENSSMh6lJwbwwLHQmEoR5Lc3FbioXXBr9sea3o+0?=
 =?us-ascii?Q?3FL/9e+03l72ECMIXiSzxHVbDhehv2qpb5X+Ysn2S71/JPtqg3KsdvttI9Ns?=
 =?us-ascii?Q?7fe/fE8nr+bLq210TkQZPyTFouKUZw82JeUcmf6vgkiJRw5dej9EVGpG2Rv2?=
 =?us-ascii?Q?aDkD80RyxhB+JrqmUD/ZyaluvMp39ic4UOGguAKL8aevWndgAka3yuomONR3?=
 =?us-ascii?Q?XHdgGK/T4EMmblR6xCJgRRNKw+A9P/4faRU6KVe6eS7xeTdLktY+z+3feJY8?=
 =?us-ascii?Q?nt9Az+4k18lijvBs/ZBRWm08ugCaEsS7/JgnlKtVCpjifv4jr3H39cyttlbB?=
 =?us-ascii?Q?kW6XXFpDpFHSWIrhhqizmn1l4QbwdaOlBdeErd60049yT8X52OQ3lj6EdrH+?=
 =?us-ascii?Q?Y6WMv/uaNdtqWjJuXjL4DfVUfTdvAul39XUBOYVvAZFOFmnzks7u0S/lJAmP?=
 =?us-ascii?Q?K64sBqCPWbBL8tLMOG34upUyr2waGZk9saX5/6EVJzTOjzhvqN2xAFIrSUOi?=
 =?us-ascii?Q?1RstcMHt/fiJr7TLR9XYViY96Y9+cK1q3tCJFGTz6ob7np7pbhL2CbcygK1w?=
 =?us-ascii?Q?zcRPtPFPqblmlnqimAbj9sU6G0krphptLiI7uuHqIUavvmahIMUclFkKHIsM?=
 =?us-ascii?Q?w55mbGzeGzC0uo+GBq7lNqEivjfBO+eGDf3F8AvtW7qf8RPeT01qNIMKayFc?=
 =?us-ascii?Q?9/BimMV2THHer0atTENCOyLn8RYRZBTuXjoQloIt7xnwmyyLbMqsjsyMFSDA?=
 =?us-ascii?Q?aootUcGHyBXHYKpjMjG7kRHUhcGHRL5XVFtPJevEDiom/C7AV+dqbRSQsEOZ?=
 =?us-ascii?Q?U4xGV2/GEYQPOnd02DHvt0OCjVW8PDQECI2pTb2fqQ0/+YNBJ2kS9X8DNCAc?=
 =?us-ascii?Q?KViiKS5yECyI2C2BnoXtFSg+9INKm4/9BxZ2TeRDgEU9Jt4l7kU5XjaxqU6Z?=
 =?us-ascii?Q?YrjkOKATYV+rcoefbpWWNpfElbeTorWcERa3PbQzkvHT86gLg87ZPTcqMPDN?=
 =?us-ascii?Q?gdtpGRNNoT63UT6F4CObnr6L0zdrdXCIjPXB6iasYujjOaJcR3GA3xM1USI4?=
 =?us-ascii?Q?4jjYvq3PfZ69fdURuYmX2ceAe4RoIMSgKnIZ7rjJRmt+IYFU1O3oVGzAUitM?=
 =?us-ascii?Q?GHJwrvDFHt3LLJH6+ABV+vllB2zbUcXxGg8l68dUq1Xc2dmi+UGdx6c06/7I?=
 =?us-ascii?Q?amjwRoywMRztKbEC/M49GICTRmV41BLh9ak+zvFWqH0f94iq5Sww3rThxY/J?=
 =?us-ascii?Q?HbyFb1T0ufBcIh4WrehM9Tjm77C9a6V311m6XTS++QIEJ68zIpAnj4HYFHOH?=
 =?us-ascii?Q?GV5ae/FEtKVMuH17+UbNlObxUIbfP1tHElfNIBgIBwsB9QawylQL1AunE/WM?=
 =?us-ascii?Q?W4PIf+Wzb5ltxjmDvR7p/nz3RZgAMgCzk+YKzPyKiW/7JHsAcy8wzLKPIalN?=
 =?us-ascii?Q?lExqRlFMGq2Y/p3sFQo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11b91c8-550f-4ff7-0201-08db4cbebf4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 16:43:53.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9M0H17dQ5eKF7UDFk1wn8GHWElw1Ge1gMGAbSSLupVI2/5fehpJ588XanNXbbbNsxUYD7tYndAcB6F132ywxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+An error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type		# See which errors can be injected
+  0x00000001	EINJV2 Processor Error
+  0x00000002	EINJV2 Memory Error
+  0x00000004	EINJV2 PCI Express Error
+  # echo 0x2 > error_type
+  # echo 0x5 > flags
+  # echo 0x12345000 > param1
+  # echo 0x2 > param5
+  # echo 1 > error_inject

Is the expectation that platforms that implement EINJV2 will not include le=
gacy
EINJ support?

The Linux error injection API is all in "debugfs", so maybe there shouldn't=
 be
an expectation that old injection tests will work on new systems. But this =
is
going to catch some by surprise.

Maybe it would be better to change the top-level directory to:

	/sys/kernel/debug/apei/einjv2

so that old scripts and programs will fail immediately, rather than do
weird things writing legacy einj values to the various files.

And ... since there is no expectation of backward compatibility ... perhaps
take this opportunity to re-think the entire API? Perhaps something like th=
is,
With just a single file for all parameters?

# echo "memory notrigger 0x12345 0x2" > /sys/kernel/debug/apei/einjv2/injec=
t

or separate files for each injection target:

# echo "0x12345 0x2 notrigger" > /sys/kernel/debug/apei/einjv2/inject_memor=
y

-Tony


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB32722B61
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjFEPkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFEPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:39:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE7494;
        Mon,  5 Jun 2023 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685979583; x=1717515583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W4YjFcXmdTrRMTYx2tv40hd/+D1IzeyZs/bpLz1GeMc=;
  b=VbMLUFLdxys9TU/YEFPPjSfZjeebaY9wCY813Xk69orb9nUc2jyrZN02
   pfTRcWkiQhYmx4XMo+NGI2Sdgsy+ao9wFIAtFIAxpiYPdKsOR4zEKf7OP
   k07uR97f6FiBvX4FptiJ6FMUeZdXtI0lOIqsJPce9WOYhkDVd7lOSR+iq
   +kj4zi69qpV7d7ED9KyBpbhNHZwaHewWZtXP9M8TqrKjSS3faCDXBcq4Q
   8tS1+sLdkJi0NW2GIGtl3hrEtvZhGnvTn5bFnwCXZzxaz44kKchmRdlVc
   Xl089iBEyl6tNTZgvOmotT6a5j3v0B7Fd6VvPZhoAq2DTH4fh9Ow8w92N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442774213"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="442774213"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="711850866"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="711850866"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2023 08:39:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 08:39:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 08:39:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 08:39:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 08:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlkFssTF1tpW+2URHLcE8A5UUsLwKwCAB+rtc6T4xFeN5DLjrKsOFDQVvgf0hDUqb767WxIamPUrNKiNeFiiobNNC0JxKmUdAeUSACSuPyqLLShjPi9mZyJvcfNz0S5GnWUSeU4dy57aQnicIk3/Gg+t0MwZKZmeoqe8+MRve9ZDCb/gktWmKATozVmAWzbBGYecPAAQd/+nQsttQvWJ8uqU/DLyJLIDO97hHF7rUUgyP2JCDYbQ4blsm8oSnAcEXml4r8aGjflrnVMckPKQFJOzZAJQHEsJ+K8zfeVt2I5UB4nFwshkk9wyGUNl47MC9Hxzj+QBTlxlbIcKNOx4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIxNSCJiUl4wWtcCVLWH2+iLZqvuC6W0QYcJBivZfWo=;
 b=FaKEUCiEe+cduhxWIJltFvOQ3pj7zh3obs25s1HphdtqYQcXirEVGyFsowum1C1DLlp0irA5wn1h6d7jjiH7+ttoD7JWqRPSqIs0do0ujNWSf0y25Cd0u+se0I8znbbV823cPhY17ClNB2bc5HLqNOSgd4HubmJqnPzVx/FWJ5NzPvS5vemzQ5Qqmy76B/nf+bTKrKw+YSKEdYmIFjOpOZZcaiVHk2tzYzu+mZ5uJXvNsTNA8z5Gbfl01V9t0Xb+XS1IeTJb8GzSU3ZbwbI/LoLBRPXCBZJ0usg3HHFUE+qm71yASMVN75EaG/Fh747kqRjJZ0mVAT4zrBzAiCGJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA1PR11MB6444.namprd11.prod.outlook.com (2603:10b6:208:3a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:39:38 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:39:38 +0000
From:   "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Muszynski, Damian" <damian.muszynski@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>, qat-linux <qat-linux@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Subject: RE: [PATCH] crypto: qat - fix adf_dbgfs_exit() typo
Thread-Topic: [PATCH] crypto: qat - fix adf_dbgfs_exit() typo
Thread-Index: AQHZl7xrESN0PM5+iEeBYby6azi2rq98WAjA
Date:   Mon, 5 Jun 2023 15:39:38 +0000
Message-ID: <CY5PR11MB6366A516B7B5D22CF9D4F57F824DA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230605144519.1225211-1-arnd@kernel.org>
In-Reply-To: <20230605144519.1225211-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA1PR11MB6444:EE_
x-ms-office365-filtering-correlation-id: 42409bf6-971b-491b-1222-08db65db127b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylgFBSXHgtixVMQccMgX4WdPcuslOJyXHWIR/mn66hKHd4bwoxY9fjb/qrJ1XH1vgPB260gY/d0UyGlrywgbrOmHSd7tthNm6NPZRQaOz2c0grWqfx2g0kDtwHoL8VTc2APzRJEx4JgePTAFVMqoWMhJjH2ZOZFcafTiBwAOa/FmXwl14JlrPXSOCweXZ8l20/NXw4cEplDfE2oFvK1zhgzZ+HIgWB6sH062795huv6XO+OR3uLc2tTb+w/0OvmmW/In/nh7efT3eVMI4pnrc6//VBYFOvRbqN5lXcZcsUjMd+IQ2NQ0Jg4JEbLYGWrkkDAmSsqCHZpsmBcKWNX7RSdqBbEsAfAKCCMH1OHAbx/45A9BLast+qNBkjWNwktIdToUPuBWkX7BXqAXY85S6NNqlNLQqhzktq5d/pJxWmvwn/66snKdUFXQ59x1fULt5qI6EawqiySYDei1MqMNqk7q/50SSuAvnhd65BNC+R9VbTI/iDe+Q7oOVQag/VjDFVb8XxYuxbcca668ieBT4JTjHbSMoB0jkn2SXIxFXSLTxQVLHxISLZd4VuL4aw9Nnu3C0H6rHO96mJHjrZo4veJR/Gqx1+gjyXQ4vflajzE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(107886003)(53546011)(9686003)(6506007)(38100700002)(41300700001)(7696005)(26005)(186003)(966005)(83380400001)(71200400001)(478600001)(110136005)(54906003)(4326008)(64756008)(66446008)(66476007)(66556008)(6636002)(122000001)(55016003)(82960400001)(76116006)(66946007)(316002)(8936002)(8676002)(5660300002)(52536014)(2906002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EwnwjBt2hMzM3SOygzQgX5vX4PfPJunswFBS2Ppj27Emdq9SQhhRBLkXcr6O?=
 =?us-ascii?Q?XqfM6NNoUZ8QlJKyoCdJeBCIvaQ+O5dBHgsb5CSVep0y/8yAC/4GPUXAPt9T?=
 =?us-ascii?Q?3l3Ev4bNKVHm+i0jjB5ppqOiJwdV1heP8jw4762AYqXwKh33lO1nEbbOIiPN?=
 =?us-ascii?Q?7zq5TK2tiJpwi+fRBnXsRJs3K/KCy2lNot/VuSShn558q2gf0nHj4q031sZh?=
 =?us-ascii?Q?LoCAyZBZgY6el0KgaabFEz2ddpX0Lq5s+IIqx9lsfCtQOT/GLW/2GN9wW1NG?=
 =?us-ascii?Q?YUfU/W3arpyoJZjo4UqLZVZkJQbEt4NzVIIpH1qLgyniybICTZCrEFn042zl?=
 =?us-ascii?Q?HmyFx47gPipJsZZhM9Syh3Vt49F2B1SusBfKxwVAeB5MpV9LUL6nOrMg2nsj?=
 =?us-ascii?Q?0V46Du0KkZq0bum8ZPf1xR/+mNgmCNBxfkTFj4x2EpXGVWrdzmM8gFipMWo9?=
 =?us-ascii?Q?g04/yierMwZ34d9UWB/gKkoyi7nVCC8wTKko7lbnxD5oCypnJ77WsHHWLSX6?=
 =?us-ascii?Q?mI0oo6zYp9/q6UMZkeF6TrIf4+nLW8wkMwG0eNO02YA7y0InR03CQySXwB0b?=
 =?us-ascii?Q?+urM3amep5yVRuMjqXMngXan1wprKo4uPIyhptHsv4cspqK2TjmLAQ3IHIzZ?=
 =?us-ascii?Q?YTleYrwry9ik3iorx/Xap0kku/+n6EBnp4ZkdrHdq67PQ/P4KLPTLbdP9dEG?=
 =?us-ascii?Q?pIBicedUgN0oNMQYQDkQ+tOt1J0TQioVrgdzXZhX6Lzt+3GtOdMxTk3E/6fC?=
 =?us-ascii?Q?ZDGUqZLqf30GZasZr+dYJMOweSa/6IJOcSuIpbYJVJQu0wW7ApMjoDIefP6G?=
 =?us-ascii?Q?TwZ3YWOrKxwFCbttqXbMzoXi0nb3DYo0Qb+SKC6MuMNnAFnj2ZTcgKCmT0c+?=
 =?us-ascii?Q?oezHWdPO/08AUW+K7wXw7UbWcM586jcSvvZ+DFH0NyKD7EpZEG4eFKV1Ufua?=
 =?us-ascii?Q?eQ8rlEw9WND2nnwrX3CD2wsLnkSj6LwBowW/YA3MT5FAMRYa5xFpMJXoLbbS?=
 =?us-ascii?Q?ZuBPeVkibumqN7Nzf3FfODAbK0VNvjUs+GzGvb3sO1T8e5F2Eytf/V7GL8gh?=
 =?us-ascii?Q?23cctN6vtL+ejd44l3KkvWjYyqkfN/iPQWuHzS4YoY1LRPChuzUUTMZmn40d?=
 =?us-ascii?Q?DdzhAhOzgWJn0DEFAYj9S2VhE26oBzCwX47MhV/b0owYsa0TmDes+xebAjLA?=
 =?us-ascii?Q?li1BAgq6zTMBpPNAkrD7X0C/sXk8IwT/ZQcJMKwMOerZnkrkEYpTJdwGoYBS?=
 =?us-ascii?Q?lDgd/hnZyw7TCk4EAILaeHOVdKU+tTofvZKOSmtMJPsKEr8uVe1VgJUyR3ef?=
 =?us-ascii?Q?mXN//yRtcQm8y7W+ap0wzzcFe/RZbrdk+G5YtUaQwmLk6jfk7q7ftfYYvTFf?=
 =?us-ascii?Q?vYkfakGI71hIe8yWZJm5rNK8q8BcB9XQ3tSr+1zgSUQLO8lKHN9SUXtAJ0ks?=
 =?us-ascii?Q?VBoXmmmhleXqys1eAH3cmunoAMg7o6BrgWj/iv9hNmc9tU+TQ0/RcvsSGwrX?=
 =?us-ascii?Q?mr4v97Wy0OLODa+PC/je7B5l20lR1cTPs0CbFigOHiEYpJXWgv6Cb9khG5rS?=
 =?us-ascii?Q?juvGZa7ZmlausSmAzrv7x9ZngDR1Ax+dMFwaRl5d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42409bf6-971b-491b-1222-08db65db127b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 15:39:38.5018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BV1m4BvRFY7g+Ebu/4BA1Pt+GPabaswLeRj0r/qJpCpXrN3er/SPRmq0u9+X39Zx7+BLnD5E1If6PVqlB5LquxhJuqbilWbujTtFTuBDcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd.
I already sent the same fix a few days ago: https://patchwork.kernel.org/pr=
oject/linux-crypto/patch/20230603082853.44631-1-giovanni.cabiddu@intel.com/

--=20
Giovanni

-----Original Message-----
From: Arnd Bergmann <arnd@kernel.org>=20
Sent: Monday, June 5, 2023 3:45 PM
To: Cabiddu, Giovanni <giovanni.cabiddu@intel.com>; Herbert Xu <herbert@gon=
dor.apana.org.au>; David S. Miller <davem@davemloft.net>; Muszynski, Damian=
 <damian.muszynski@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>; qat-linux <qat-linux@intel.com>; linux-c=
rypto@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qat - fix adf_dbgfs_exit() typo

From: Arnd Bergmann <arnd@arndb.de>

The stub function uses a different name from the normal one:

drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c:69:9: error: implicit declarat=
ion of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=
=3Dimplicit-function-declaration]
drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c:69:9: error: implicit decla=
ration of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werro=
r=3Dimplicit-function-declaration]
drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c:68:9: error: implicit declara=
tion of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=
=3Dimplicit-function-declaration]
drivers/crypto/intel/qat/qat_c62x/adf_drv.c:69:9: error: implicit declarati=
on of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=3D=
implicit-function-declaration]

Rename the function to match the normal one.

Fixes: 9260db6640a61 ("crypto: qat - move dbgfs init to separate file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h b/drivers/cryp=
to/intel/qat/qat_common/adf_dbgfs.h
index 1d64ad1a00374..e0cb2c2a2ed0b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h
@@ -22,7 +22,7 @@ static inline void adf_dbgfs_rm(struct adf_accel_dev *acc=
el_dev)  {  }
=20
-static inline void adf_dbgfs_cleanup(struct adf_accel_dev *accel_dev)
+static inline void adf_dbgfs_exit(struct adf_accel_dev *accel_dev)
 {
 }
 #endif
--
2.39.2


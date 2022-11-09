Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED2622AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKILhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKILgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:36:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E325EBE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667993809; x=1699529809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B7eAMcEzPM2KkQYXCxVi6xhZQMt/OsUrrY3j9R/ezjY=;
  b=hLfCw2zlofE0JTlAd46BArV+Vja/3zQfS3pdFECQ21Q8dc2czLDz0Iu0
   hWzVd38IEy9fHoNjsLJecBOvMs4h07cOjZb/aEYe2uQACVB0eN0C5EltR
   LIJHLrJnPJ4i7T6YLnA7J2arn9nIDjo9Y5C052ufhXQUzVd87zqbjQaRX
   5rpY509eK2ahCatPQx0wWeWIDinGh6vIopm9XsFkNaKf8KosZiQi6QBbg
   Y6S49rCN9jxO1BTiApTY704t7ESSY4r9jULHBuVL0SMQAiiv8CBZWOJ1s
   zbpb9tSPoezfQdrBCZQaMEKuiNoZaFbo9uza7b8vi7auLKbJNp3FSLjOO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="373100873"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="373100873"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="965961445"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="965961445"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 09 Nov 2022 03:36:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 03:36:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 03:36:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 03:36:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 03:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADEhziHhHdJ3oB0KtcoKB61g/4bW8fOJo0+LrMEsnYb/2I3hJaNr0qX/bOTJBllqshHFYlpxcTn9jSmOQFiQkMtC6M8Ct8MZ4NqQQR02H5fQQhtZKgEt2ChYp+9bmOH4okwO+VHaU2FubEZR1gY3nFNgrFAd09DwqhgH4Ln1DODNEYref/hyMiYTLs4Ifubenxqod5KiDEffYTlO2qj5o3zuJylVKZtVtpThj0RR0aB5jSPzIoX6WNFV9S4HpF5oYWvzLGOJTWZzcrFmxmbK1OUE5k3HSPB/BtLePw9ECiFBvK9zYl+9o28HZKhfomw+8ZedDB5JLnzpfwEY+trlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM7yQCuIM4wNgStuVZFsEbPjM/Ck18T25qCRGrc7V4s=;
 b=aIx1jTwqgkKNSR6sMaeMRAnwfwHYgSNrebnUjp/V9jA5petjGr2MLgZAT2sS1hBpqvT+pHKiFqOQQMqD28TJfJSG/Y6SjoFBEsr5XRu05CPcwpzRsdpPmsq+TduTGJNxjlqOVuM3h0IQqTvn5uU892/8thMSeGExO9TmBQpJ9GWzT+JZRBXLO2UlX0NgaLv14efnEsy/6Bq27hf4649BrvPe7hpYlGEZIcWYXO2LPygdne/HH5OG5VtX6y9wDPBtzRuuXraOl//lesaI5nkrE9gE3XZw4oshGjLxm0bvLGQXXqVv8zYdXyj14+lzeF36AC3rzKmEPfRBo6+enlq+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 11:36:45 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::acd8:2a14:5673:43e]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::acd8:2a14:5673:43e%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 11:36:45 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "mm: migration: fix the FOLL_GET failure on
 following huge page"
Thread-Topic: [PATCH] Revert "mm: migration: fix the FOLL_GET failure on
 following huge page"
Thread-Index: AQHY9BcDvagcT6C7uECM0PzSVGMzxa42dgOQ
Date:   Wed, 9 Nov 2022 11:36:45 +0000
Message-ID: <BYAPR11MB34957E86BA5A3CE0B72C06DBF73E9@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <496786039852aba90ffa68f10d0df3f4236a990b.1667983080.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <496786039852aba90ffa68f10d0df3f4236a990b.1667983080.git.baolin.wang@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_|CH3PR11MB7204:EE_
x-ms-office365-filtering-correlation-id: 38482028-8e69-4499-e291-08dac246ae2e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWcUsaMauQTzVkzFK7HCgdh4nlW2GqCQfhKMoEBzgE+S7KGgC4XIsSjzLICg2hm9Dia5SdlwbjY+95bKpa1kshGTqAWt0ifUhK4TK4H+WlVeOGew8EDLN+a9SnJW3anEUoWhxd2TYlCpdq9sFS+guMAzmq9+bnHfey4sbEP7Luc09L47vacArDjt7rWofH47LxXra4LazAPrnOXbtcFpnFkjmLihThCue0kJoXnHuDZ2ncxP+U2o2cf3bOMuJAWYDe6jSsxCi6OGhQ/wBes+jtZZ2Ss67Ot1qCDN45eALXCzAwNF6D7W1GslinlEOjSadGKubPK/KGvhxq7C8vYI5YX9GF8VFe94Z8i7dbUjFrcFz49oFRVeoLnHEyZx3sZa/VK9Qefkb+v3vDpx8hkZ6rPGfv9pMDhvW6QsYUPxk9vZjYZbCbEB4iTCyE3qUXj8GTrbDL2ZEIW/OL3r+ekwfAoNac6qCV2WdGr4DXV0Tmj7UyhIPyOrhG8hnHS5OTTWR8/vwl/6G9sXy+K98hTrmShme9Z7ik7BGVqHblSTyq/TTfdVtUUKrV4EtHKfvGPiPCb0XWKtO48R1nf3dyLpYihpi2cLevfSjjh5osAoNdTPcIz0v2Sj+S9yQWsjNBBy+OYI4ltyCs88jr4bGRZeIVQVEzDSXCYI3KM/bIB+4492FoGsB1gkPw6DFPdxT1ow3V2tEgx6gSDI8Ab0+T1HKmMcbVysaBTxPjMudo5jQ2THJgTaDbc5a24EWi6tKqaVrasmHn+Cbr3WAOXxmHFp3fPxA176GYP4mxDSxg+t9UQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(478600001)(38100700002)(4744005)(2906002)(82960400001)(38070700005)(71200400001)(83380400001)(186003)(122000001)(26005)(33656002)(9686003)(53546011)(6506007)(7696005)(66446008)(64756008)(316002)(66476007)(66556008)(4326008)(8676002)(66946007)(76116006)(86362001)(55016003)(8936002)(52536014)(5660300002)(54906003)(110136005)(41300700001)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?07j7+RIbRD/h+z+uQDEWv+EgnoAjeWBWH87hcqUk6vaNBu7KVdQ+Bul4D3F7?=
 =?us-ascii?Q?Tgu9g8J5tbkAZ/1wsilK+wpD0gj3ObbgRTTnU5512c3vgezJJTvkCuOTES1p?=
 =?us-ascii?Q?BZzRbJy7l0JMVYufZ1y/VYehhBRA+VkTc+hcvfqnv4D6zUJxlMz4+nmZAzD8?=
 =?us-ascii?Q?vbR2TB00MOMvJYxKa8G4u0e5JWBVLepN8QiS1khe3kasS5RlDf+eVvc0CoE4?=
 =?us-ascii?Q?zTGaLF+/6AZL6ufoNYLU/bLvcVkQNn7D86XOcRwAgo6R2TgbLNp0a0kJXQAg?=
 =?us-ascii?Q?JWhryeYKKk+YI0e3mpKkqSZX/NkPkdfUz2cplS87fGktyJBtghp3jME5GJKS?=
 =?us-ascii?Q?8QpWs7tZh16Tz3iVD2EGMekaYFz2b3l30qBhLxT/aSxgTR9G63pmYx1HOy84?=
 =?us-ascii?Q?LCq7m9kgltRKouWQCzAA2SkMr3D0JAYaJXsHdDJFgmCL9jdcr9wvbnszwtwn?=
 =?us-ascii?Q?c36HPIQcUdtDvmEOKbOOy6u913LWDZJA5ZrDQaDh1NPEsdFkSyyGEsJVhHxW?=
 =?us-ascii?Q?q9yXQqGn+kuZM771RJur6n7/HuT23rUSHCW1m0Tq4GJLs9PXxhhcUDdlkYSS?=
 =?us-ascii?Q?A+hEXBYHpxRO03+oRNVqj5OjUMbGCyL5mtp+rd8HBcY5ao6sCoppYmVk64Hr?=
 =?us-ascii?Q?hhemqknt9ZusYqrelp1d/JJAOvVda554Woy+E2bSZIREvR4h6j4hE6f9LyzD?=
 =?us-ascii?Q?EvwioNlOS4kdGweuJT2dsJi3iix5gBiGqCOGAqky7nwlY/G+g7VLu/tgP6cj?=
 =?us-ascii?Q?Bci9Sem58ECdjC+6JeF0ph9D5+g09XZmQ9amXgIUEXVDHtV7cC9eFCT6lato?=
 =?us-ascii?Q?gCt7uqFD9DE3IZBEDXkRLmEcQaJzvz4h1D6NnTL+PeIvXYRba6mUnDiJdfIr?=
 =?us-ascii?Q?g3I9SehXGfGoDVk++eDPFRjUv0N5ov51+5O1hWJYGl6Bf5UWQY6+fRAC7QcG?=
 =?us-ascii?Q?PNPZ6IX1YsNsSjYuPfLIEZzoE6otlvh6V006+kXxenuQajWC75+4rAhaOCtZ?=
 =?us-ascii?Q?vkWRw1UpcwnXTqXGwhwh0KqkhMK99k6ZxeJiHt0F7qI10UiKW/0hDtE386Gl?=
 =?us-ascii?Q?NFdfMx7i6i77M9zxrpE58gD/IFmYRiDQqxv9eq30AKiugUV+MYbyphXRvrft?=
 =?us-ascii?Q?c515UM9kOgBpojhrDAon2wtkxKnTZDhmRK9ZrtxfrS2/b6Vk3LiHHvl0ATq5?=
 =?us-ascii?Q?aSmm6vG4ncfFEaZMc+n9sCwd5ROzlNuqhRhv4rP4ZFkmtDsAucjhdA6uuZ+o?=
 =?us-ascii?Q?4G8vN4KkB1LHnNIULvgUv8vUOMDIhTI/tJWv9+sIUyR1QlucBL8VdGSdaB2m?=
 =?us-ascii?Q?H76HSsQmazwYqAximlD1Ta3324tmJl80eyXHDmfEcDFktBauoTxGTB5vc3H4?=
 =?us-ascii?Q?cOh7fXsHoy261u6sH1zKimli0D2DSmVhGa18gQfC3HTkq0eU1oSw4hgSJPU5?=
 =?us-ascii?Q?XEiy82g4a+mB1xIldxKY0I4AgLnFTreUdOEPmdAPhPWi+FVn4jG8XmXA6/68?=
 =?us-ascii?Q?+bXXzfQqvjYNOmvnB+M2TZjSsszkMjC6trXYgJ0s4Kv0/YytHGrfvXp2w4K2?=
 =?us-ascii?Q?S9vsjywaxvRQfksUxKSqiRBZbKoCC6TEASLgVQzx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38482028-8e69-4499-e291-08dac246ae2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 11:36:45.1685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUcVdtGRoEtyCcgjN+V8DO5ajmebQ7UEgr1EqikLo0pK82JR5ELMggpljKKp/6OXqOoFnCPgFPGN5atIWTc/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Baolin Wang <baolin.wang@linux.alibaba.com>
> Sent: Wednesday, November 9, 2022 16:40
> To: akpm@linux-foundation.org
> Cc: Wang, Haiyue <haiyue.wang@intel.com>; Huang, Ying <ying.huang@intel.c=
om>; mike.kravetz@oracle.com;
> songmuchun@bytedance.com; baolin.wang@linux.alibaba.com; linux-mm@kvack.o=
rg; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] Revert "mm: migration: fix the FOLL_GET failure on follo=
wing huge page"
>=20
> Revert commit 831568214883 ("mm: migration: fix the FOLL_GET failure on
> following huge page"), since after commit 1a6baaa0db73 ("s390/hugetlb:
> switch to generic version of follow_huge_pud()") and commit 57a196a58421
> ("hugetlb: simplify hugetlb handling in follow_page_mask") were merged,
> now all the following huge page routines can support FOLL_GET operation.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Cool, thanks, my ugly code is gone. ;-)

Acked-by: Haiyue Wang <haiyue.wang@intel.com>

>  mm/migrate.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> --
> 1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574C46BF7F4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 06:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCRFOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 01:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCRFOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 01:14:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3426421F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 22:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679116474; x=1710652474;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BRlO3ElCn1SJqwF79CMLHD14ytGAL75A77Nslf1dtn0=;
  b=VCNUteTWtyWe1R1KcMGBI4jA0zP4bRpAss8ev2gu2wfLvAKvORsx6mhf
   ZGO3AQNYvr3dBoyOARCYXz1MZP9gijWKWso4TrELpEjCIn+zw9KbeGrJH
   e6HfpEVAsNWBnyP5ZXZaicVSGaGlI49MPOaV/KJGuSC66kAui+pYE7lay
   cCA2K6d8pZ2O8xBgfM4gXOQwgFz5PTRHSFurqVicIbUsGQXwUNUvtdHwz
   XWAz1qLVS8oPgW/RESubXPRCbKM62xiTkEJg6vjSK8loY2MezIst+KlSn
   jfeebHYK0bDJkRBcwSzU6B9Ne7sZw8CHb4C9YzNWw2lG8XO6S9lJHLlQk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="339946987"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="339946987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 22:14:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="712992626"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="712992626"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2023 22:14:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 22:14:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 22:14:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 22:14:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 22:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWnyqTFaAgRpQkwMALFYHZWaNqsK6PJJWckAiehybrAyH44n75Pvk6ljs7Kf6hFTpmCdRuS5BbdyCsnjz6iL9OXoX+/NVnAtNNijhiOdhMuPoWEJ7weR6RvPUWaGu83FyeO/TtcFX/OjtcdKvianTbHpXdfwUEddaqO80yapdPHC9lUz4mevyxpk8i/6SqteNF7U6Msrm+z/gnqVciZt2zhT1xIeZnnqz6aXMoFQk8IcD0bne1w1OOkjwBGXrGZuyQ934oiLm9M+nDStgDKa/3yANsn5ABUIPtFeA5lkOpXXMhbQi06xjglkY9hRCAqjHrqnTT3no375Bez3hGmEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XECQNPClgviNZITcXzyGp0gvKNw0DnXJghI4G9u7GJU=;
 b=gtAKzrRMxrHZeY3mtOiJQz0GvWZEJ/TeWxMitxjLx218ZoT7rv/hWDQdNtLnwbCZ4ZFYxxw6QXz0WXOFH9V6QjhnSEkieoGkEC3Aml46Ue5YRvjZel0LaO8QDIjF9zEwvO4Nj26+Nlja9LMyymf5/BD8tcnPUpOirxb3DfF4wDo+CCAhVXCM9oG7V5HsjZ8VQaAdCM+5xaO6UIIbgiE8yoz/Bm1qknQK2Ddppm8WYvsCvYbwepeATenxt+4sPc3AvCHcwxK6q+T7htAmOTzizN+c8aYdyvrsdxPOCOz5DsxBM408LOsbUUsdd1uEBo+bDOD3dgYD5wFoJ9GOK9VEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Sat, 18 Mar
 2023 05:14:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Sat, 18 Mar 2023
 05:14:30 +0000
Date:   Fri, 17 Mar 2023 22:14:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     <teddy.wang@siliconmotion.com>, <sudipm.mukherjee@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-staging@lists.linux.dev>,
        <outreachy@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <641548b142559_28ae5229425@iweiny-mobl.notmuch>
References: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
 <ZBKDddHeKlWohA0T@debian.me>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBKDddHeKlWohA0T@debian.me>
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e03d22-5031-4ded-6935-08db276fa6ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cucyp5+6n0AxThKXru3OFvr/cK8RiZ+Kg+jkoVICv/wtHrOtr7N+TW+ZpQD2Pme5IlCdfSHXiGb25LnRlSgHd7o+M7eigHXP5HAXpo5xcnc82hGweRTm4aBLbvbcAENiYvY/zwk+6jKwzyDE86y3zRS4tgPy/wp14dI0yw3/Nm0en+8Xble9kw03kdYZQHl233xnY/oRwu3qX1Mea3kkRv0qJx7A6cMq0MFAcloZPE+Ggr8tOIVlTrNUloFV4ZPQtRtMR8uuWjD9FeyjHmpyXg5cOo6BvtiXdr/hduvyCZk5UlYeKuJ34VSK+wlEHEfVwTvwIuJRQN4mN9MIzR7YA6uG+rj4e2t6weuA8G3nKU9mWPEDAECPAo8KIN571eD9b0vHS4FXUWIJ1PAH3fD9bRAVY5mw+JR/OIIq9XBRZ7mjDlUFnX3ydpEhsZ1W2vc2DDFa24ja1P1lk8RUKYdcXPRQCcjvw60U+CRrDaluxwXN57WNuC1D1LbYmR8J0Hb/vhTbzv+oapfWD/qMfLnWWe42Ga2+cselH/UY4yH1WIBmw7coASBGXXUyYClLOt5kTttP3kCdaboX1PRgGJA+62RRY2hG7aCN2FbGreEwGb4xZASs6xdiX0KdE8x6/oc0787ZxkCa0WayT5+ZBstUZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(5660300002)(2906002)(8936002)(4744005)(41300700001)(82960400001)(38100700002)(66946007)(66476007)(6486002)(316002)(110136005)(44832011)(4326008)(8676002)(66556008)(6636002)(186003)(6666004)(478600001)(83380400001)(26005)(9686003)(6506007)(86362001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOKBXoDM3pWhB7HRwmmw8flxYuqOd6vmtuYsWnxSfRJEesOeO2FR4Ty7aRzv?=
 =?us-ascii?Q?M12RcZUqlCevl82Pea6RAD9X+SgolQCeYcjrl3/EtOtX2HefGOflUlz9YqVS?=
 =?us-ascii?Q?CK9lZcptx+F+vEux84hhTXlqvQACF0BYpw3mu4fqS9AOt0LwsGyJXvcXpBB/?=
 =?us-ascii?Q?V8L7mEsWU+oQsdG58/DJjPaB5rNnth5fhuaDIbKV545MM3rGjA3GTIyLYq2F?=
 =?us-ascii?Q?nghUFvJK85+Akt2UQRZRKAEA7x7Lav0FklwaWylU0CPAxIrvYJD9CwfiMYHc?=
 =?us-ascii?Q?m64uox2YFYEwBABsYJrA5PWBxXnFoxKDUxdhxGIAreAt87PFP7m8G1T6OYN3?=
 =?us-ascii?Q?3WYksSh4wtFNI/8bLdAaRixw1qJ7k1qjutSSBWQaJc1rGV2DwMIMNLYh9Tg5?=
 =?us-ascii?Q?BA/Pqwce6NGwwr/6yufcYqq7Kt23ZX8ARKLRu5uVE2i8XzCe5tqQWGBqUJ5k?=
 =?us-ascii?Q?7plyFhf/iBbjkbPus32925UhifRykVHxyhv5QlgC9AF1C15bcaUiomRbXD7b?=
 =?us-ascii?Q?UNtbsBGlba4R0hUAIPzHic0SyxNQPKDVA2Qr+zw6azkGjcAJS2ZObhfqB41l?=
 =?us-ascii?Q?QrcBWP1FlfCyLt+7GrGdPFyHffHiSIJsBFZZYnsOcZMiTKT6tGtBoW1BQbdc?=
 =?us-ascii?Q?RU2k3yV9VgCDFtKHDP+UUssgjHmDBtgtOCfH1ELCMwo6TXon5zejAdNFXeIV?=
 =?us-ascii?Q?gisUsMXaz71D/pfvsQCvmP7YG7TrjqcR5m9Yt/gsgZ+y4jyqqaavXh8WXEXj?=
 =?us-ascii?Q?L+RMOfcIwmUUDOPpxqJO81Qgi4+MofuM+JW3J4WysqEqdnvjG/k2skDrIrSD?=
 =?us-ascii?Q?en4rJyBP7OskAoG0cm1g0kEUKjt0YpwhCHIT4JT8NCIbcjIzOURt6/7j2gtO?=
 =?us-ascii?Q?yhZhVe+6tcIbTTBB/AMMJdx4CdrV+5oksAop88PJDqjT+nSn4uctxdo7Iluz?=
 =?us-ascii?Q?3Ovm2gLLbgZJrgnGuNHLW0MuK/22GNvdkP7kwOCSsRxEpBf4YiwHaR+pagep?=
 =?us-ascii?Q?I5Us8XYSKizx4IU7A3wDBtRmG+6gL1OSExI3M37ciHvRPRUmjF2N2oS+Tko5?=
 =?us-ascii?Q?pK19Am9BIwI6b1qD+ZzE0ycwRurBxpVquqtf1WoF49SJR+2x+GaQhyy//um4?=
 =?us-ascii?Q?qxPLHHy9Mmsk9kEuEVtLdLFNjZaZjaUpOjR1Lfa4LZpKIAXh0kn4b89Aahg+?=
 =?us-ascii?Q?GErN4Vw+YZqjHbVsVEIzBbfBlB1BvdLe/ctvdS6uFNGhYwBL06VFa5WmtR7B?=
 =?us-ascii?Q?iG2ni6DXOjEbIw7sTvdbOJdQZxQYwwQLOuP9u6wKKF9/QOjYatxHEQZjrtJi?=
 =?us-ascii?Q?Y4ZwXSXJPfisTBHM6LagIyOvKsAkntmgTLPBb0aAmqUICUL6IZaJ1lGYqLgZ?=
 =?us-ascii?Q?7fOlnqrcYnkeMrPDeqeHtiTdrRqMVB8WW9+cnY+SAST4M0W39ediShRhBYLF?=
 =?us-ascii?Q?C6qZrHCCJYv7OcixiKao2kyg2Ff99reCFDFYOMXK/DyOmzAlSmv6wX3I0e4T?=
 =?us-ascii?Q?HkYLLstXGDViL6UQpIu9KgiKVgoVJCTa86QECpVmtfqjjeA1SrjAKpXx9nna?=
 =?us-ascii?Q?6XEv50PJPAYuEFwqsbrcFIqO2BAQ5s5w/JhXdFvV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e03d22-5031-4ded-6935-08db276fa6ce
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 05:14:29.9267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkeWT4RB0PV/sderwUeZqPHOvDEbVFkwmydiDlnnAWHoZXCXui99oizZg+dxk2E+Ixjmoq0upg1EJBtU6n0AjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya wrote:
> On Wed, Mar 15, 2023 at 11:35:37PM +0800, Kloudifold wrote:
> > Subject: [PATCH v2] staging: sm750: Rename functions from CamelCase to snake case
> 
> If I only see the subject above, which functions are renamed? I have
> to see the actual diff if the patch description doesn't answer that.
> In this case, I think the proper subject would be `[PATCH v3] staging:
> sm750: Rename sm750_hw_cursor_* functions to snake_case`.

No.  The oneliner is a brief overview.

It is perfectly appropriate to have to look at the diff to see what was
done.  The commit message is to state what the problem was and how it was
fixed.

Ira

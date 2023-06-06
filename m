Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915E87250C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbjFFXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjFFXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:22:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE2518E;
        Tue,  6 Jun 2023 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686093770; x=1717629770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LYjQtsCKY9y43ae55XDUrcU9sxIRA7qgOrj9bKQMc8A=;
  b=DcqQqJ3/SeXCYpedFUSXZcV3d8Jhw1H4dwY7Y9NhJJvBLHIiNh8fQ0J+
   i7YvGlg6+gdehvc7HEIMaai1vwxdHr2uTS47mx2kxj+7rv2t15IRUiynq
   0ZKwsnNQLiRS/KssUXwW3Y96uzrlLcEO/shXANdkpSIW8UYxJl7IdBYx7
   ZP1hHw51TAcYCdX3RoIxR3fiSo3TeHd7GhAS8uDGR4CTFSc7VyTrUZtWQ
   sU+NFjRCDsCeK3sID7KETpXQQtzza2yhVPoQ285sECuRBaQOrCZLKDx5S
   2qwIPDW2ghzXouzeQ7iWOPb+CY+TsuUs347mQtLA/gkyc0yHBDEd6TWcb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422665522"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="422665522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774294135"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="774294135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 16:22:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 16:22:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 16:22:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 16:22:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 16:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIUWm+QUwA3rSfw+pjEq4XID3OI2hcs1b5ASyoPEcz1+uaCYgRvD0JLBlotChGSP6Ztc4WT0E9bvgWXZA6ojbqPuF7oOW07OkmxowWtcW6D64OgTo4FQFsuChwE7qpRjdCSorxhZ3acb7BNx6CSu4kTs/hlal3SiJkklXDu7+BgG3m39P7FotQ1bhqykIpHYNRHpx9PwSf3DN8f8E2s2BswzS5cRY/jmWx5s4+kL9EmjwbIm4R3UntCEhihty9nHi+GNRyaKcPd2w/LNqylHzztGpVmq83mxhi80iLCtaojTZB/NmMARsIgTddlLmsuAoCJF/UrnFfzijsDEUT4mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWpaTMZ+zP7m3XAesGipfHZn4D+oHLTreJcSixR33jE=;
 b=Bp+KVYgTYAp4yqRHZ0KbjXi7WfvrZMKzgz7v/M0y1kQOp29UtO6HnFjrzE2T9AmlWUvbwUFqDKqMfxgusFDwFVggqmBLf0lSwPjro0G4xDKwwMKKc94v6FNnoMTzvw/EytjblzqHJjEDSXceLH9e20+cbN8AUvpOopaIBXiYZKn7ZvJh3YftrDOD1cU9dK6nqXt2kqnveB5slwztnAGuZ2Pd1+Y/GIczUPpvwfAgQfEuWXkBXXCKK+KRUTU2Hf7c4h+xEtTn0ZHTAYy4+QsArxE1f+FItxDMXrPWLEP55m8+c9I4P8Gxnr5yoH96hWKv8qShRs0VT68UHRHVZ4SqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 by IA1PR11MB7919.namprd11.prod.outlook.com (2603:10b6:208:3fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 23:22:02 +0000
Received: from MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf]) by MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 23:22:02 +0000
Date:   Tue, 6 Jun 2023 16:21:59 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: dw: Add compatible for Intel Mount Evans SoC
Message-ID: <ZH+/l4kVIiz0D0j+@ekohande-desk2>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
 <20230606145402.474866-2-abe.kohandel@intel.com>
 <20230606172836.rbvhaxala2voaany@mobilestation>
 <ZH+EDLkdn+u2Rgwe@ekohande-desk2>
 <20230606191333.247ucbf7h3tlooxf@mobilestation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230606191333.247ucbf7h3tlooxf@mobilestation>
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To MW3PR11MB4729.namprd11.prod.outlook.com
 (2603:10b6:303:5d::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4729:EE_|IA1PR11MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: b17ed144-395b-4c89-016c-08db66e4d5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szuYijNgH/gbcIqfRWoHgawZtvdAs30kf0XBgkYxYbmr9Gjh2hFJKZGU/8lTP+zQeLtAriTls7hpB73DjQneJ0QlhU0IZc4ipGcmxCNnRjbEyaOW791eyz/oOrMyzahnsLP828DaOslt9yPap7mJYt6F68cRr9mUyhHd2SkgkUFSxX+vvxS2jl2MP2uXqnDb6f61XhkmX5SLRCetBuHpOdpuKJwNTPsD/dcMY9HhfxG0jkhBlWsfC14rj6fo3THAmAt0Nb48bxcnxL04UsFErgFNIV4s2blMMv0O3fMI1eJVu2WzOuoACThEMkdmSsSji3KsBLtZ89D8xmdshsYB5h4FVpOO6VzkFeTwv4h9iPtNZtWprmljWb8tYjavhY8490w2k4NAQyX2Glm+Xmt7foMIQX53FC90dG4BOwXZqaknmirBZwQar4+kG99ajmNKX6rqkrPNTHIAwMoIMdDyopdcwlytTXc9MVUiy9bUotfSIAK43K6oi38m9si0o71N6JtBuH3F5r0pVm4eanF0lpB86hhspub7lQkkugOffy6eWs456oV0/+QmdrdOgEq1RHHHMdno14NdYkdQJ5r5fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4729.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(66946007)(2906002)(478600001)(6916009)(316002)(8676002)(4744005)(4326008)(41300700001)(8936002)(54906003)(44832011)(66556008)(6666004)(5660300002)(6486002)(66476007)(6506007)(26005)(9686003)(966005)(6512007)(33716001)(186003)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cM2llSOgBQLOuPbmnHBF8N92lpicslzMJTrjSldNAvuAAYZkW/4v3j7CuBCE?=
 =?us-ascii?Q?0G5sAvsmr7XtROE61QKxu1O/XREzlILI2K/y3g85kXUNCWkFiflXTvoOgxEo?=
 =?us-ascii?Q?PzdwQOgBcmh5Db7Vha+/jdFTpZA7F7w2mitg85xLWJnUNUAewOyxdnUBA2l7?=
 =?us-ascii?Q?ZcCW4BhkN9urfLEhG5KhFu8dYm8fg41gv/ye/mBMg6n7j+EHy0S8rZyru8MT?=
 =?us-ascii?Q?t9x2o/8Yk7G4iF/Dm9ijRnY8/TcP5lEz7kZ7Hx+rqNlddaWGRUNA+Y0wMrMN?=
 =?us-ascii?Q?NzhQzkp5Y499go9ozq6fkgljXCLjLK0gekaVRLzUKFZ6coRue0NWjEjUIzyw?=
 =?us-ascii?Q?U4tcQV2NNjNzIuI+Kn6Z15i0UrxvFErYLFaAWaY0Y0MyN8Zk7HSvfFyzKFTh?=
 =?us-ascii?Q?d3pVbVXO2QytcXjlSBzNhr/PeSc8u2ncPDD0Te+pfvHWNsivgd8z1JfIKaxK?=
 =?us-ascii?Q?6EYjJ6Jf8cN1S3w2jmN5VntUt2xcveyFj4m8O1FIca1tgm7toH79civkckGu?=
 =?us-ascii?Q?/pS3f1fel3+2+00MOh1exLrkGcwiGVZTzWrV1Y1+nDH+MaLCDw7BeGc+OfUF?=
 =?us-ascii?Q?Ulwab6xR+/sxCIB5ncxCOT1ajVRir7VKrhfuOWckAff4xsVuerl4BjitZQZh?=
 =?us-ascii?Q?T/vlyAiYj1Z8uUgmqickcjGt9bOZU1cIbAPXStYdoGK9aqNzixiMgKYenmd7?=
 =?us-ascii?Q?Pk72cYVIq6kGtPuVwjEzZRdZd77zDfvyjcBn9IFzG9E/VIw2fSAFicRMZmwC?=
 =?us-ascii?Q?1O7+u0z8BArSfherI/AImlwgGIsAJVOF0zbti2upPP/t72/ElTU99ZqlBpjk?=
 =?us-ascii?Q?zJ/VilJXY6bLEV5actC0O3X6idheMeVQu1IoLhpDfzZJ9a51igi95eklbZ3T?=
 =?us-ascii?Q?XX8WiS4WlQnl5gV7HmB/MFqP62RuuMYari3WAS0+GqkM8FzoY+hRW2y/RCEg?=
 =?us-ascii?Q?OrGNhwMYEtrJgNlxP5NYSGxcIe083DgXUONBIhaopGz+dbSZpqF4sNj2ZAmN?=
 =?us-ascii?Q?zZJmM1tg3M0BHE+MpKZ3S8bVz1UxdeibKFRoIcUdxybGnN/HG7BSl/eLJU2d?=
 =?us-ascii?Q?NkNkdxI4TZHoUhb7wVaEzxsAZEXDWKu/keL6OUo1KfysbB1zi0hc1J/lP5Ko?=
 =?us-ascii?Q?URO+2e6TUEWEnChUxH6pggAqYEgZ/CW8Ow0FCRCVBNXupIw9rDf44IQVQBgW?=
 =?us-ascii?Q?qHUx+H6x5hYYU+heUBS2uSq7iizmimTo0vNmrMWXQRXKUISV1In0Yfr6yMAY?=
 =?us-ascii?Q?6i9rK8zFX/K2LDsOj3JoGc/2NvSn2ffQF8HxNSrXVoGltZFDCh1APGi4J6v8?=
 =?us-ascii?Q?Gbm+7OmyKSHPyuujpVsQNiUxs4k5vfwssfVoJx/6eJS9ET+Zd8xZuUNe3mn9?=
 =?us-ascii?Q?mP9cy4RyDYXkcqlgmmNE9vt7gnqgmWnd0YriH6OhE/XQpPPAYgeNdgns9oPq?=
 =?us-ascii?Q?gQ+/zKYLKV0rvPUPdX7fx3wMJo1pMrQ0TCdmjIeW9ZrWWly+GRPJ/EkhKnS+?=
 =?us-ascii?Q?dZ8Sitzy6mYRBSkbfe65JAVRCSFs10GAmHEqXbOUilY60N5xFp9GzbKWLrsR?=
 =?us-ascii?Q?M9T5ZveXFScgyCRAQz3Z1miUCekBIiKIAjp3hOR1ys8TMyrx3Ycm7RvaGCGT?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b17ed144-395b-4c89-016c-08db66e4d5a0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 23:22:02.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki2AiJm5KdoEiPlP1VF3VL19BjTGjicvGc6y7WhgtL7j4XSsRvCSTHmkQhaFcOnitFOEUzzuau+Rr602B+p/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7919
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

> Ok. Thanks. Could you submit a fixup patch then? Mark has already
> merged the series in as is:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=0760d5d0e9f0c0e2200a0323a61d1995bb745dee

Patch submited in:
  https://lore.kernel.org/linux-spi/20230606231844.726272-1-abe.kohandel@intel.com/

Thanks,
Abe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33FC6AFE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCHFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCHFQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:16:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3887A04;
        Tue,  7 Mar 2023 21:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678252571; x=1709788571;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8X/bJxfassAbTNpkrOdExHAlgGRa6JzWlzUtk6+EoeU=;
  b=gt4lK9H0+69mxavkafJtH5667T6bePTdnMWt0B9rfMyXXOxVfL8etqMQ
   Xy8siV3sb/+vROxMdNSt8ECKHpIKA28dS4lwoigUgBJ7Lp2UQMoj0Wvl3
   tZ8/KCL5XTgvZwx4jsONMmmRWiEgoADbpuRTPjRCAmbYnpnwMKSiXOJpV
   SY5yBoshsdxZzMroXmZUeTnVnI2V6DOqlRXVSmgdJ5SyNIzak+iicKZma
   aa+bIRRcCKht0KSb2TAay8LegY5/tOxptrIdSVSTe3O9Rk6Utclbqfmad
   u0QG2AREVMKUrBluo877yDksiKc5y3u90fJWD09f03ricYKNEaFtAPt25
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324376501"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="324376501"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 21:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="765888617"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="765888617"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2023 21:15:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 21:15:58 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 21:15:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 21:15:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 21:15:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4PaQ22xitN1h/TDrUgYkTD8tBKjyOw24gSbJFYN3yIFo8oed2WXVFBWQYvKTcpY2e5xOwQLNKAgeiJy1vMj3+CWuwNRUxnbpymFbQTFosbtc1zPrci+Rg84tvTdzUXOWRh0rUj6QeUJp39fPVFx6hAMrSN7IiSBPK3LppmOIiDkDycaL8k1A91vjjj2RAPoS3hSZ+Y//4zSovcWhFmhqMEKgJgW8vNSYYStOf73WDK5lHhA0WSSa6zs+sZwO4h9Y9mcLYu+3sXS6r8kv17EBS+rOXUVI/ikW9HRI/E89zk1POx5pRNSZ23B0XpEaqQOi8sR0ayPZ3bdpSXzZ6zqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yra1SAgvB9moLWwSwL4aICz1Q9uFy3+v0cBvhaZbYzU=;
 b=Nxm3UWY7CYf/a2x1NVnK+duxSoKP9L5whtQ0U032h/JdyQlEGVfusTtyIHlNXeMy4EvekBRSmE0NNS4WZ92XnjBHhybUJP2fG/EcE8srnvdgvZuw91Ce/eWYwTmml/uC9itGkhIzpF+MarajvtmktccrVlIqbEzOsGFSln6Wfj/h3P2bPWXrjY49wAFZ0lux8kyI1i23aoLkFXEIxUXfCgcYywIYUC04KQKGWjy7OEI5KgUpf3nBPdeIpmR7UnlkITQMQiKjerM+d/nw2iaPct5VBfTq1xFsiegIdx91aF34IvTW/04B4KJ0XKTBNz9XMqGO3kZ9p2Ip1H2DUGlTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 05:15:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%4]) with mapi id 15.20.6156.023; Wed, 8 Mar 2023
 05:15:55 +0000
Date:   Wed, 8 Mar 2023 13:15:43 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
CC:     <linux-acpi@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Subject: Re: [PATCH v2] ACPI: tools: pfrut: Check if the input of level and
 type is in the right numeric range
Message-ID: <ZAgZ/xlXl59WQLul@chenyu5-mobl1>
References: <20230308130902.18397-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308130902.18397-1-yu.c.chen@intel.com>
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 277930c0-9329-4169-4f58-08db1f9431f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjBHPuzd5KeYZcJH1+hoRfHi/1+sK/vy8LsqvqDs4XcEyUXsgG1Cjg18TXnak77zJOoIud5ZcP3+RnrjGCWNb79h38/hfz+lBh79/N544vPIea1b01R/5s3xZu7idbMQpL6cMdbXxtjPLailYAP3dzdW6rUZGYvG031s65nyQqUQJkawEQHIVXaOeFNz0bsZZA0SKWBO4YIRN73clySfDRBN2AF+2KzjjQ8XJM8QIG5gbiK4F3M4K0uDTQyUwItbxXOmi04ti5PiQzV1BuxojQCWusf6nZZ9y9ofPRFDUSPS5Chkf36Ox1w3wP56/K43cyaZwRohc95/Fpz1G6F2hXjdNxUDyFiL1qJH70FpspEp7kkfeo7T+q7vizAz5WwtrfRWsp4koMOHojt+Wf4SK09eiN/o8YeqH9Q8hBikJFUrtCGL8x0dfLI17X+Tc8ri08VrcSpi33SfcbRw2sGtaFP/EiGMRu18fSHxHQPd6H7F6y8DAtxYb+ypVoWFMSuHsSl/gmEcE2MRKc3rFkJzITmNYBCsg7p2f7YJVg2qL6EEIrYzuSoI5eBgmYVKXU+USNXQ4oLAs+zthy2NUwU6KlBaQN5gq2B+PYeSY/gkfRzCcEl1rD/fOfRUU4I6TgC5Hlx/rRIXXb4expMPJTZqBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199018)(66476007)(66556008)(4326008)(8676002)(107886003)(6666004)(8936002)(66946007)(5660300002)(41300700001)(86362001)(6486002)(33716001)(83380400001)(82960400001)(110136005)(2906002)(186003)(316002)(6636002)(38100700002)(478600001)(9686003)(6512007)(6506007)(26005)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8MEsk8eOgdDGMhLNV63b2PjDCA02BfgmiyQf0kUdwY7B7TIfhT3Z8pk5yk?=
 =?iso-8859-1?Q?GYg56tAuo/9kbHCLpJgTeJlH4WY47bAHec2A/2AoLnGXMIXPBDEGOaJiOE?=
 =?iso-8859-1?Q?xC9j0i37M6poqHgKmp9Vz9uwP3G/NTeW+Tfsx8DIpBXH+Y0gh0peIzn3zY?=
 =?iso-8859-1?Q?zK/AHL5JNipnNqZoiwhcxH8GFy96GZ8O7xW3jczJPjivmIF9uoWVYMN/i4?=
 =?iso-8859-1?Q?ZdLPBxHQTsyIe65BK9DETannm6OgW2k2nxlsPswvBJiGtKvdVW3YA+Z4/k?=
 =?iso-8859-1?Q?fyo2DHSbDoIUpG3rlOqT8z/Xfq1WI6B/XiZFK3Z/raNCDsGpMLAuxkq8Je?=
 =?iso-8859-1?Q?pTstxJ6thAF0rko5HjuFe8QrLlvNqUcFrzdXK/u8tIfTOHzf5sJ7hcSEcg?=
 =?iso-8859-1?Q?o+fg3deMkf7R+ivD3v+SGMnkkik/VdIPNE8AlwMBmddJjD3z9ZfWnIfmeu?=
 =?iso-8859-1?Q?Gh5p4OsXvUaxhmO8ty4QoRVzEILd1EQECsS+snA4GcZU/ac1y9tnnpYi5J?=
 =?iso-8859-1?Q?rJqLU9zCVO9HboOwIXnZFKBtrx0m250abPwdeCQ0RC24MXNn61S25lnODu?=
 =?iso-8859-1?Q?Wfz3R6QIogVVJve7pQRoTd40EiM6jhUZCXc0SJn9v4/bbAm3DsF21+XpnN?=
 =?iso-8859-1?Q?8Tp92ogi8lUOmeFis1BMmy1naGJlM+Uj7gzRhIkMv6UEvIO6Jm8XX/MVJ3?=
 =?iso-8859-1?Q?K1kPOwiQfV3lSix+K+8T0B7Fqsf0zCDlnaxPDOKQorOWI/ppnf3slZnhh8?=
 =?iso-8859-1?Q?PBAMU6NQjq+22yROXlsEApeTxq5t7HSomZstMI184ZlDih3zjZ2Llpc9BB?=
 =?iso-8859-1?Q?2gNeyWe686QkqBUDe5aPDgMkyVihY8s4eifCqgEKmECyDRAaJnt6JsdvPq?=
 =?iso-8859-1?Q?FDtRATorN4fLe2QAoKIW76aMNNcRRykZYAqvJo/OCXSdktL6Y/8NMt2iFX?=
 =?iso-8859-1?Q?hTFEJHUMvCN2yEgn+ml49HPUiDL4G1+/wt4Vbm5NzbN3gagujiraBUZPAq?=
 =?iso-8859-1?Q?2Sn7GJGxnXNSdUgKj4xi2fHxGQpvT8axMBYrscM75ZeSwbKTZCZChHd9C7?=
 =?iso-8859-1?Q?lGnNd+h0VTKIDDAdGG/MUbEBtRG0eKysGB8mFCohcQ+EkGbg7jsSI/E8Vx?=
 =?iso-8859-1?Q?bq/T9tI7xrxCSdB08v877WKJjimIodFCEEGSX6xAnsbk0eGhg5xREcnU98?=
 =?iso-8859-1?Q?/Zn2ZMJOur1ZntmG3YoI9OJ7mJ5qRs0VALQ8BY4q5q15yaamsS6zAModbB?=
 =?iso-8859-1?Q?tzQ7+5o+66n0j/VX2Bfe/qmlIVlf3xWgrn9Xf+gtKWPjeLvn026ZxOg+Va?=
 =?iso-8859-1?Q?DbHd0QxjjBcKGOlylKIdOgVRi8AyoQHZQLwtqitk1zon2h3Y02AWs/VTnx?=
 =?iso-8859-1?Q?WnUvaAcqVaNWiWWQWnnlJ8Xw9nsCgHQgYTXbrpj/ygpo9X6qCzBu3w3jxv?=
 =?iso-8859-1?Q?l/450PweuIg1gbE7LaB83u/iPB2aN0i6LIS5GDWQ3iSFJMXbgHtMIsaVPo?=
 =?iso-8859-1?Q?EZT6RqBxUINnoKFexSa1AjjkzlXphgwCEaw/QMuvrhD3zyMf141tsMfnMr?=
 =?iso-8859-1?Q?Ax1eZiykvjQ90o8AzBswTwY5UyTfyqcpNJKwOF+XKAXErNpz9MGfvI8E2L?=
 =?iso-8859-1?Q?NaQM+sro/kuSzj2Qjz9ksSVJjBfBxqW1mO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 277930c0-9329-4169-4f58-08db1f9431f8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 05:15:55.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S83bNIBdvhWR9/ODy+vZiSTDpriToL/fuV16xeemigBiD74KAu3wVS2DUhfdlf0nQisYQbMrsxofjc7j/2JAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
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

On 2023-03-08 at 21:09:02 +0800, Chen Yu wrote:
> The user provides arbitrary non-numeic value to level and type, which could
> bring expected bahavior. In this case the expected behavior would be to throw
> an error.
> 
>  pfrut -h
> usage: pfrut [OPTIONS]
> code injection:
> -l, --load
> -s, --stage
> -a, --activate
> -u, --update [stage and activate]
> -q, --query
> -d, --revid
> update telemetry:
> -G, --getloginfo
> -T, --type(0:execution, 1:history)
> -L, --level(0, 1, 2, 4)
> -R, --read
> -D, --revid log
> 
>  pfrut -T A
>  pfrut -G
> log_level:0
> log_type:0
> log_revid:2
> max_data_size:65536
> chunk1_size:0
> chunk2_size:1530
> rollover_cnt:0
> reset_cnt:17
> 
> Fix this by restricting the input to be in the expected range.
> 
> Reported-by: Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
> Suggested-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>
Please ignore this version due to broken format, I'll send a new one.
Sorry for the noise.

thanks,
Chenyu 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B4733342
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbjFPOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344844AbjFPOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:14:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1CF270B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686924895; x=1718460895;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C5GCGEnNiLPGQX2ThnlST5/bb1jm+HT+QpOaaTcLbpI=;
  b=aLGSb7sTazKW7THwQ4X+9r9MT+cVTv66LkehsJOouH0mkno1C/OyVgEh
   z1yesc5/q0mp6Rblov0AK+ryMljQYPCGJTn9JcARU67LbVnmFMre8ywiU
   OIzPidDhVz6w+dmOu3XQ6soSH10+NwOT9nSufPDg3aTItFbWOHJSp3CJv
   1yfOM22WujNOHlZS53+caO0lkRbUgp5VGqMI3uH54SGV0FDzw+HRrjmxX
   GMEGxNUQC1WG+P6K8OI9p1iEPRT2h9vB4pxi9imGC3tGm9u8ms3T0P2P6
   sa97+KpyYk599tDj/KCTMkU8Q6eRv4NFOqMNViUgnbpKkl5jR66tsnDo4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387956386"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="387956386"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 07:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959632331"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="959632331"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2023 07:13:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 07:13:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 07:13:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 07:13:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 07:13:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el59/p/6nHC3IGaFAHqqaPeSh0R0wu51QgSQJi23aR1YX4hCCqsb14a5vYBHkRpwdVArUcv6WZYrmSgDLdP3f/rVrXjlLfdtz/QvPWwmuZ+unqbKCAUhtrSv86V6ctDnmVlLZvCYc9V2izmNJnJ32ttYqeWriLT/Kfdf9uaDgPYHvE90Q0tWeuxYrxTOEa7q5XE4RHxs983L38YF4U83OIwwQh/rUXyZEP21BNggzlRqR7gfquoqlUPmFlevjDu90TAPqa7Q3xS44TufiYngXZ0ySCGDOk+vB8/yI07RtAfr2gZOkEZjGYytVxcxWPg9l+UrFCR66fOuRK/4p3SoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSvZfT48q0ThHr8rvv1Om6cunWb7FUMSOHuJSxE3F+8=;
 b=HPHEu6N6AQ9+yaIhfXNYW/iyV+XK4BbQn7kuH81JkqB2+SFNtrBZcyhFHkzngahAOsq5tuyhra9SfVfz6a29rwue4g2kiPdN3bOTTE1fpagwy4k+RSbfNb62JxF91BaQr2exEiPfgc6VEpj3tydEqbP07Pcwn717Mi3CHFf0PpjVoGruiaf0pgyYc6mFW4OK5jLBBa2XDkGzG/kBXNPmRUH35Lyj0tXEa55bRUHDDRJeAx4D10TByYMmpQaRV0q9JDMPD3AgJ0ik/dHCmf8aIStJE4iCZ377/fkHSnYQYeARTuCIEh7qLO+WhoMQCelulDKi6iSdZxn8Fwjlxt752Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 14:13:14 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 14:13:14 +0000
Date:   Fri, 16 Jun 2023 07:13:08 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
Message-ID: <ZIxt9Er5nJRjCUXh@a4bf019067fa.jf.intel.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
 <87mt0z7si2.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87mt0z7si2.ffs@tglx>
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW3PR11MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: fd98ee7b-3d56-4e06-2248-08db6e73d2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVARw346ONFCjxdXOhHN8cmu3kwDZlmuheOgwhKuim/cDuCTpG1M55QPeJd/4do+qbEcnxIw+Im59ndulwMO1pDsUusy1Sb69JqNSQrzSGAchU8TjLnRcEHbGvEdUJdqhBl4vTOFXXUTJrog7wHOXSA8fZWpfX5Au19TWOSsUPEKNohnvLSD9dwI7NhgIVrZcmWLQz3zafpdU1QGyjBvKdn42tsA5ji2dTy1Z1kxGWB7xYIDbQAdSDpzRGLpsl4vANYYDFP3YlLfFUaOHbJimrPyguJHAaUOPAXPXRr6E8QAct2R60kVIFPfcOgjCrLWPBOcN8xYaUjNUpmiHbhwVhr5jWpMmJbQdbMHzJbp13+3c9LMiDLjrytMUYl59ObEP4mHsh031u4HXdRcWvWolfPZiw9rMRWx/NP1w3XejoWEpLiyxyW0kE3r6XGFqxYNgF/uMuv4cMtTmDdK11G8U236/Oow89NN/uuoXJpa/LYVgmLcGyiMvRCexN/KaoJ4JANH5DZiAPR9YKbyawi0N4djLrjQemJivW82gJjHPEpVE3DYYRij3r3Ztq4k61yr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(186003)(2906002)(38100700002)(44832011)(86362001)(6512007)(26005)(6506007)(82960400001)(4326008)(316002)(6486002)(66476007)(66556008)(6666004)(6916009)(66946007)(478600001)(41300700001)(54906003)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EWgB9Nj0iWNrr5GoInyvZUL0MSk9ddnAFxN2P+SxGkfZKYLd/Oa7JGT7rHQI?=
 =?us-ascii?Q?UF2+aBKdZkxOagogkeup5AyNBSojxZQzSkALIz7W4dk+yJwLzEzyyS3A/Jv7?=
 =?us-ascii?Q?kFiDJIvrjRJvlgUBtUnDMvQ7e45mND9/4kjkEW+Scnc/Oy9KUgD+RjbRslw5?=
 =?us-ascii?Q?3w8M0J4C9DMzmJuRawYWSnqFkCm76ZJRCPSIIBw7w8cY1HOFLSlUkQVwC584?=
 =?us-ascii?Q?zW9Dos0B8qUZdby4XHLPdi5eqmgnlwlPyuOxuNn3ZsCwxLlpzDTpq09ODy7z?=
 =?us-ascii?Q?xi/sdpADtLm75NQSI3mFDMed2ki4oIJ7VvIk+fSXdZIekmJRFZNd6wGspVnm?=
 =?us-ascii?Q?2WRVaV55bzskwKjpLXVLW1Jk1QHLjIaobB6JAAzfOQIoPmSamJnNmckr88C8?=
 =?us-ascii?Q?iRlOnmvcaMT6MQz2igcnfVMNglnYn2Gu5jZsT1viJRqDqhPcXBn4QrVC04td?=
 =?us-ascii?Q?7ESVs5h/DhbIDJW9Gx3yW3cRSyaVRNPwMOVie7tb61FKdlAm1RwJOWwRKic4?=
 =?us-ascii?Q?uwHSUBuJqSbOVJOfMZ2upZ4vfDBxR3VP4M3XdDKPs0niGPpDpfLzpXlrIpB2?=
 =?us-ascii?Q?jsp3etz8zRo1P8Yaokj19DTNVzjj5RGNSV8XKgBilkX8wRbW1ZzEvE0elE7M?=
 =?us-ascii?Q?p4AsUh/MydkOtc7lZJb6O/CSGddluarOqY38EtM6IKWnT7S/Y4OnZ49/a86z?=
 =?us-ascii?Q?ORBibPM91UEhtFhHD7nJ2Qw7PpZN4a0oTbi2RX7oWKKXEG8WrkZ/QJGo5PnD?=
 =?us-ascii?Q?yBK/8wbgv/gpzvJ+SR6NEOkZj/7DQ1z6uKpIWQIXu9LWlqUF8tarN+Iid7Ut?=
 =?us-ascii?Q?80TAwwGbXEmnJ4lQlTy8FKBBivJxYCZ+Xpw2UGbZucnIy66bKuqQTtocKbXZ?=
 =?us-ascii?Q?HbOZ4YhEkwjWDLHri/EH/6HD8PQoCon/KWcwg6cj9sjE42/awI8RCLeRLYQo?=
 =?us-ascii?Q?dFgM3WdVl5mSXi6tXVo37sE8Gi3yC9EZWZqDTSXe5SsCwHmMsw9I07q5wSWJ?=
 =?us-ascii?Q?rlD2XfLYQHPODPaiMb+IOE4rIoEE0p5P0MaJfxHZokZdRN71y7B5kskmdtti?=
 =?us-ascii?Q?lPnhaKHIno+FN7gqr7Cit9ngfFmuUqPIFd4OdrHANhSmuasKLDah3Sfdr+PW?=
 =?us-ascii?Q?oa7f2f1TRhPqoorCY7jkweGgds1T0u3rxCQ/P+7EtqoV51i3AY9cYjsKJQlz?=
 =?us-ascii?Q?gTRIpA+P/vClE/kUghFWsgmo8NWLrvJ3k+63Z9YfaNEQ/AH/BJ9AuT6/Hmbj?=
 =?us-ascii?Q?3++S9zokQBh4dSo2Ns6OV8JEtZHHedSMxPHz2BVev+1Qkj4EBxnzGIwcU39m?=
 =?us-ascii?Q?Ghlw3FI09S5RAmkbicmB7pe+o028BcBNymuo6xNET2rZEqeUF7Y6cD4lPPg0?=
 =?us-ascii?Q?EW14yLifcFSUb1rUBr4NbKHn6sqXbPRpl5TjKbhALW98GY2QiDLYjIUojx9J?=
 =?us-ascii?Q?iNUYJy6u/m/QZLELasTS1n0v3rhj8Dc81t9nZacK3JTFFLmltnshljNjEy4J?=
 =?us-ascii?Q?3GxdW5IBcFqsKLk4mPS4gXXbpaGJP2aD/zRskQ/O+rssDaD8QLx+r96cgL9c?=
 =?us-ascii?Q?x7Khko0Vi0Q+BeSk1WAaOoK9dJOebOHiGhZDKIVukYdcYgUATOccLv/L59Gy?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd98ee7b-3d56-4e06-2248-08db6e73d2db
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 14:13:14.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgPFMjlhFtq93F4e6Z7qftEqcDsBeOuoPfhECng3zz6OBaF0CHI0BV3weX+1w6eFAUoT0uP5fYrtYK4hTP2wSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
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

On Fri, Jun 16, 2023 at 09:53:25AM +0200, Thomas Gleixner wrote:
> On Thu, Jun 15 2023 at 18:58, Ashok Raj wrote:
> > On Thu, Jun 15, 2023 at 10:33:50PM +0200, Thomas Gleixner wrote:
> >> +			dm = apic->dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
> >> +			dm |= APIC_DM_NMI;
> >> +
> >> +			for_each_cpu(cpu, &cpus_stop_mask) {
> >> +				u32 apicid = apic->cpu_present_to_apicid(cpu);
> >> +
> >> +				apic_icr_write(dm, apicid);
> >> +				apic_wait_icr_idle();
> >
> > can we simplify this by just apic->send_IPI(cpu, NMI_VECTOR); ??
> 
> That would not set APIC_DM_NMI in delivery mode and the IPI would be
> sent with APIC_DM_FIXED.

That's correct. 

Maybe if we use apic->send_IPI_mask(cpumask_of(cpu), NMI_VECTOR)

apic->send_IPI_mask(cpumask_of(cpu),NMI_VECTOR)
   __x2apic_send_IPI_mask() 
      __x2apic_send_IPI_dest()
	  unsigned long cfg = __prepare_ICR(0, vector, dest);
	  native_x2apic_icr_write(cfg, apicid);

__prepare_ICR() seems to have the magic for APIC_DM_NMI?

I suppose this works for non-x2apic parts as well

Cheers,
Ashok

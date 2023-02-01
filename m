Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0C6870B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBAVs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjBAVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:48:53 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E1E16337
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675288119; x=1706824119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qYhwM2AhzeHdFDy4sE4+PH66T02La21qCWurie9h/r0=;
  b=KvhzmJYG1B/5GElvXKxJyl6vnWYxQBpLCicMFsIlxMvmAM2V+5vKndy6
   p4ngyd6hnPBdW/Ql4nzlSoF6k0AbGZFd1LmEU6LTIL4TXP4dpgfciUzhM
   DOarqppsvgJKo1NBLUHBkw3NDlXVZY09FsWqG1ur6VNUPug8+C0nEiza1
   Mj+8VkrDi9WAl2Pqe3zSHY3ZoBsCvTHj5vdIFxM5kkdzf/MJlqwW++WkF
   vTrCOcUXiNxTIg/zrEqQiDhAT+DlhaLnsUIu97HpNHj5AUqg6HgH7tnGl
   mp5ImIfIKZYKOIgU65Y9lzjDOwJEKshJAswh0VgJdT6NqyIz4IrYHfHrQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="328293396"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="328293396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 13:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658486499"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="658486499"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2023 13:48:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 13:48:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 13:48:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 13:48:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 13:48:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjHL9KkUZciRjcxZSa2vipiA02fh2999XurgSE6upTSkPqbaD0S5uVSIeI8E+pLnfvT3u7dXYS9tJmnPVzNVoWsl2RB+dY3X51b2E0Yg0B89ofNf7CdcGCACpWidKia7tlhOCzcXRPmgvpSWQPh+85cGG0rtIkAS/DWBGeHxW9Haz6fH253hdR33PAaH4PmhTMq4jk5RFdwOuyPsxYZeXNTgCyg1WbV125taLPdP31vHJQj7i31jL2RQw9eUUXiX6fFatDUC0uFiNk1wNShfOua4Vx+9YgqriV2k1L+QxtReeOyKWofhDiIYCU9pMvzQTV73fvsb7LpAnDiNLXSGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MTcwkEj0cAPSKt68mfgbIsixWeye1N03xVOS1e6xcs=;
 b=BkdCZyPOrDZ45W6fMREXGNVWCFCb8RRV3bHYjqOYwl6dK+MJiOgpNj8qTP4q+Y2hZhGfT3SlsIl9alxR6uMzfRhx2VfDuD0qmWLnLZq2xUE2wS8WiVpru2EAqqsvVQT7MtRpX9rVNObvdA1yUrEdUsK912uBHSxw2luQhmvYOcNMnnLor2x71cb0kzuhsvx9WV0Hw7OKMbJ4ai5p0hHe+VmVtCnPuktJK74VVHYpzo7hTbhV2viE9S5yv0U77kfvbFWo6EwBBR6ZgtvRXAKbxbOHekyOVPFjyNFBHxyZ7l6ywTc0TFqOccpz7bZDymVuoRkwYLblrKVbg87SjGljeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 1 Feb
 2023 21:48:01 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 21:48:01 +0000
Date:   Wed, 1 Feb 2023 13:47:58 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        "Li, Aubrey" <aubrey.li@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9reDitxHgzcrsOY@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
 <Y9l4FdvytLqMc3jm@zn.tnic>
 <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
 <Y9perwfaheZqAJWl@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9perwfaheZqAJWl@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bc16aa-95c8-49a0-7caf-08db049dfd80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcB+v1Ez/8KK9iaczzuI0uzNBON2eKxMTWYr6TXasUzF8u07/5Pv5nN7y15b0ufUxSaH/ccWXW8RS++JIaNh9NyD7mdRhUa9KuPLxr41OQbRSYEtsp+ElPXGzOZstvi83hk/PiEIPdKn9+lGColSoTIVIrslG967vsZYEAnmZTRFXYomOZG9Eutl9bMpAPUzrc2xanaSoJBpvhbNlspT/O3ZNqfsmXrTCzUaFGgjCR4nDubyeu7vQw/6WHBjfi8b7XI22lcbjmbJ9udUqohyxOjv+FEZYn0fVtLV5BeGP08wH/KrjWr71ZiZ711KH20xfClg8kGe9IodxvoRRFFtoGvg0iwdPSc5lsQTHQERmw99zsSBYUpICgd5rwyCjVRNLppkKuV1qprNnXENEKpRHDJ1VLao4bShgXfppVN1J1WfpXz7N4BAwQksdMAT9zfYI7t1Wi6QCGtpcne0gVHME8sLGUy0u54by4/8fFL6qljVAM0hvPRvkvk1B/YJ9Mg7/XpOkejUCbI7qJVHci7c+BMdrFSdae3OM0vhEfa61MKl5Kfd4gtPgVw3UTm+Yc96s0kPAhXXJWPNwf4zc9eap/0jGu6fcuumNfTm8B39GXL6v/sr1SrmJtmeXmyHVmZ95Dkvu+wgPWjKEpO4Se5Df+lsz46GJ6f1dYj6Re50JJNbxyP3b1QVYq6g3bpIV3Iv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(5660300002)(6666004)(107886003)(6506007)(44832011)(7416002)(4326008)(2906002)(6916009)(66556008)(54906003)(66476007)(66946007)(8676002)(8936002)(478600001)(186003)(6512007)(26005)(316002)(6486002)(966005)(86362001)(41300700001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BKMsckp8HH9CtMZCOpN4Rl15IeI9RSyvWj23L7+Z7xkllq+4LbFPUY8SA8O4?=
 =?us-ascii?Q?TILluiu5JesZKToM/Me2+War2Pk//qrd9ecUeH7ADZ1c9kzJYbBsgwwo4V3F?=
 =?us-ascii?Q?4eGY8MMsfIgMXbjpwFxuBH7aM2MdPBoWX/MkrWselv3gJkxEaF1VKK6OiGTR?=
 =?us-ascii?Q?EO7IhEjenl2rv9p5VnSProgWLjkqn10AJdxBMf/nSlCwVXVURCqofpy/ZZ26?=
 =?us-ascii?Q?xqQv7omD09/RjNIBkGKr21UM9HE596/oC2/tiZaFqjCOYlv1ZZMauS+MeLpL?=
 =?us-ascii?Q?8/6/CNmLgMsGh/2Od7iO38lzvHjsTz6q4Gz03+ewP+tqNRyREwWNoUVIXq46?=
 =?us-ascii?Q?QtUati2bbcGAl74d60talJWbX9YUhaM2ZIcVgQCVQ5UaeFyjvZVWWuP+uh2W?=
 =?us-ascii?Q?SXG72YBluvsHanohU/Sp+zC8yIbtwQJsVdyc+WRiggB2iI5poGPfOzwx5wNV?=
 =?us-ascii?Q?TCUR/rvenERvMg880nbVrcWPov/h4r/PkIWzijXWaaZnw9GsA5cxwsAkbhbz?=
 =?us-ascii?Q?TZ3r4fCSG+vKb/o72sTYfyNmTRcerZu28rCP5iBwZMJ/Clcbt/TTGxQ07NF+?=
 =?us-ascii?Q?kpI9II8T6/DqERfncy7giX7J6kp4RBzAsF5CowiuvGOl4QIKTQqd1ZFHIoEH?=
 =?us-ascii?Q?ptDWQqYFtnfyav7S0BkjehSOPGj+bZDlQzW15dt4gZ9TrKtfEtkb3MzpjE1j?=
 =?us-ascii?Q?VWgw2VeL6TcI3OWDzXUVRxq35JCJX3BjUTQF+obwJPEgAKipiStQUhvsiFZm?=
 =?us-ascii?Q?fH4WyTWI/mk6tfsNNIoSMBShnuL9Rq/syV1HL6Qq8VBRKWVhRn4F8AMIOyCd?=
 =?us-ascii?Q?yWskv1cQd5bJozjV49FY+GM7kbIL3VxrfMvuDRiXEvXRPtcJzznQN3NuVqKh?=
 =?us-ascii?Q?65H+Tqt2iT/xaQY2+aZs3GvfMXBSxKuJgtMsZU9CwIags2ZxNLjQ87SjMVjM?=
 =?us-ascii?Q?tfnc3YLdCtgN/AO2BG9cVyyZyhM9G8s0EgSi4Esl6coGV8X4JleTrB+l0Fbi?=
 =?us-ascii?Q?3ZB9N6vvJE8WDUtE/udB6VkTqmhF05Ge/8Ubh/0AkjcPHASfs5b6TLY7+i03?=
 =?us-ascii?Q?1CZVmONYMDM0fOE/M23ja24u2X8dISG/6HJ3jYAKBnVmLqbrqWSprDTL0BRB?=
 =?us-ascii?Q?DEa4Jzra+R/4hQ8TshhEHhC5ymwR+4+fOhoUmxWK6OZBDQdmHB5HEH4Dbi9u?=
 =?us-ascii?Q?SuOs1eXbkmdzMmURLWpO2IPN2b/sinlvx1aD/XGI9UHDj6T3641/VlqPcGP5?=
 =?us-ascii?Q?70rhKgvy5ej8QRFf+837+x9V3G09UeYzsidJWamkduoRKHwevtNJNZp/Vhgi?=
 =?us-ascii?Q?TSQguGNw8Q3blkhpyME1+0/WhEkpvDogIE9y5V1xRLVWksisdLLWJA385V9s?=
 =?us-ascii?Q?4T3Szbbvf2d7Z7TOzeXJjQClHH1hRr6SsJ5xzNWQ7ktwBIwsxISae4g14Kpe?=
 =?us-ascii?Q?3nhOrw1vknUalI+U68Gy//vM20HfLca6PYooZHSxeod63VzvJPZmrpMv4Baj?=
 =?us-ascii?Q?mQLnyVodl9xUoFbr+2zp9VjzzyzKrUvat+Ubu1SOxuMdt2N4xKktzJMuI9nC?=
 =?us-ascii?Q?x9RI/dzhQ0BGTvPMsPNZXkInHJPlauXgGHzDXwUg9aV7yPDf/O5We0rIPC7S?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bc16aa-95c8-49a0-7caf-08db049dfd80
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 21:48:01.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkNoVbxkGd7W8w8YIgN3ooK+PCnZdrlQ5VdXhxFC0/rz06uLzrX8Yk7arAke7oLlJOEjo5bd6QcKo0mlRD8MNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

While reworking I thought while at this, there is a chance to fix other
things.


On Wed, Feb 01, 2023 at 01:44:31PM +0100, Borislav Petkov wrote:
> On Tue, Jan 31, 2023 at 02:54:03PM -0800, Ashok Raj wrote:
> > It's not an error, only when request_microcode() returns UCODE_ERROR, should
> > it return -EINVAL,
> 
> So looking at ->request_microcode_fw(), it looks like we return
> UCODE_ERROR when something with parsing the blob has gone wrong. So I
> guess we can return something more fitting here to state that we failed
> while parsing the microcode blob from userspace: it is corrupted,
> truncated, what not.
> 
> Looking at the error codes, this:
> 
> #define ELIBBAD         80      /* Accessing a corrupted shared library */
> 
> seems fitting as it has "corrupted" blob in the definition. EBADF sounds
> fitting too. In any case, it should be a distinct error value which
> hints at what goes wrong.

Along the same lines, when check_online_cpu() should we return -EBUSY which
would distinguish between -EINVAL vs something different?

And we have a pr_err() to indicate not all CPUs are online. I suppose this
can be dropped in the same patch to fix return code? Since the error code
should be indicative of the problem?

pr_err("Not all CPUs online, aborting microcode update.\n");

> 
> > This shouldn't be noisy, but if you think this isn't needed, it can go
> > away.
> 
> I think all this preemptive development - it might make sense so let's
> do it - needs to stop. If there's an *actual* real use and need for it
> sure, but let's issue a printk just because is not one of them.
> 
> > When it fails due to current_rev < min_rev, Isn't it good to add indication
> > to user space that it didn't succeed? Thomas wanted these return codes, so
> > someone scripting can get a status after an attempt to load.
> 
> Return codes: yes. Random, flaky, potentially overwritten in the dmesg
> ring buffer error strings - nope. Soon someone will come along and say,
> "hey, don't touch those printk formats - my tool parses them and it'll
> break if you do." Yeah, right.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

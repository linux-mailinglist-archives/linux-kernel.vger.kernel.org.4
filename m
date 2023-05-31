Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1671874E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEaQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjEaQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:26:16 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E8126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 09:26:14 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VDbF9u010917;
        Wed, 31 May 2023 16:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=wJ3nkcbtWpQeRYud6d/v0E9yA3+TK/OyMjtx3zzio/c=;
 b=XSAAVsza/4YifBLlrk/PrT7kUthYNzBdqtQuS/LpWP9H2SglPYxsoL0xivDiNhTV3L9+
 ipc/hkHzeZobPLgxXu3PAz7v8WBUAT2w8nEDhkPQ6y7Vpfv9PFJmm4OZ8OKR+VrksZ6g
 IBsdOOfWtwJ1kROO2U/KSUvCcNx3PrgfzBtSxD6LDaoAJEWeQom8SFT6sbQAq7Hdu2Sq
 svpsSK10nc5H72C4a8yUTWAoRdUSXw1ogG0fXmVxzdmtWyk/98HNoB2zh8OeTHmRsjn7
 VE2hJkwPj0rwT6ZVp4iPK62nnAb/vC3uGfN13qpNpZZQdruSlb7T9JbzMOLP9xG/F536 Og== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qx79a9psm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 16:25:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5290714796;
        Wed, 31 May 2023 16:25:47 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id A1215815C2F;
        Wed, 31 May 2023 16:25:45 +0000 (UTC)
Date:   Wed, 31 May 2023 11:25:43 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 0/8] Support sub-NUMA clustering on UV
Message-ID: <20230531162543.GA1008147@dog.eag.rdlabs.hpecorp.net>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-ORIG-GUID: PhcfKOWw2PdAkjjMP8MFSVKA22m45eSe
X-Proofpoint-GUID: PhcfKOWw2PdAkjjMP8MFSVKA22m45eSe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_11,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310140
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 02:07:44PM -0500, Steve Wahl wrote:
> Sub-NUMA clustering (SNC) invalidates previous assumptions of a 1:1
> relationship between blades, sockets, and nodes.  Make changes
> necessary to support this, including some general improvements along the
> way.
> 
> Steve Wahl (8):
>   x86/platform/uv: Add platform resolving #defines for misc
>     GAM_MMIOH_REDIRECT*
>   x86/platform/uv: Introduce helper function uv_pnode_to_socket.
>   x86/platform/uv: Fix incorrect mask define use in calc_mmioh_map
>   x86/platform/uv: When searching for minimums, start at INT_MAX not
>     99999
>   x86/platform/uv: helper functions for allocating and freeing
>     conversion tables
>   x86/platform/uv: UV support for sub-NUMA clustering
>   x86/platform/uv: Remove remaining BUG_ON() and BUG() calls
>   x86/platform/uv: Update UV[23] platform code for SNC
> 
>  arch/x86/include/asm/uv/uv_hub.h   |  32 ++-
>  arch/x86/include/asm/uv/uv_mmrs.h  |  18 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c | 318 ++++++++++++++++++-----------
>  3 files changed, 232 insertions(+), 136 deletions(-)
> 
> -- 
> v2: Include the subsystem name (x86/platform/uv:) on the first line of
> the commit (subject line).
> 
> v3: Use return from WARN_ON_ONCE() to simplify the code, remove memory
> leaks from memory allocation failure conditions, and remove an
> unnecessary set of curly braces, per comments from Ingo Molnar.
> 
> v4: Testing found that some configurations required adding a check for
> "uv_blade_to_node(bid) == SOCK_EMPTY" in uv_system_init_hub().
> Testing also found that some uv3 configurations didn't work correctly
> with the new blade number handling.  The range of blade numbers is now
> needed, not just the count, so calc_mmioh_map() and
> boot_init_possible_blades() needed some adjustment.  And a reviewer
> suggested using INT_MAX instead of 999999.
> 
> v5: Break up a single patch into smaller patches and re-factor a bit to
> make the changes more understandable.  Unfortunately, the fundamental
> change of the relationship between nodes, pnodes, and hubs touches a
> lot of places that need to be changed at the same time, so patch 6 is
> still rather large.

Gentle ping.  We would like to get this in before the hardware it
supports (Sapphire Rapids based) ships.  If there's some other avenue
I should be taking, please let me know!

Thanks,

--> Steve Wahl,  steve.wahl@hpe.com


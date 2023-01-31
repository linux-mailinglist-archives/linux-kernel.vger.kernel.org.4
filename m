Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89636833A3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjAaRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjAaRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:19:06 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA84A22D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:18:17 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGXriP031218;
        Tue, 31 Jan 2023 17:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=n13Qbs+81Hma7bEWH6okHak0zLeAk2ohGoduVT+n/ns=;
 b=h1bh4dqjYIZZB2fiKyThES/y3fED1fgWmKpe3RRYH7441u+6ednCPRftzjMnV4jAkFqk
 Rp+pq3Un49CAwij3azLXCuqy1a/0wmxJbdEv9A5Dxnc9/zqVlSdjPDi2NGJpCxb4rZyk
 n8j2Fgs6rr4AxTSp7csvixkLr/HB48/GORPic62IDvlhJ61yr22DzgLHEBh5UMKn4sES
 hHuK00rHZrQTgDUtLY1iQ+Q0blSAr+Q7KQyPGx9dRE3hc5Gp9kBoySJTI/EgxRIayWUG
 HDathIO6IT+AgceF9+uzls+sBvnfa+x2hMNiMdQmDuF+e5Ge0Bl/VA8kDWC5vanJFLp2 2A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nf6m98k78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 17:17:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 59687131A1;
        Tue, 31 Jan 2023 17:17:18 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id E421E804770;
        Tue, 31 Jan 2023 17:17:16 +0000 (UTC)
Date:   Tue, 31 Jan 2023 11:17:15 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, steve.wahl@hpe.com,
        alexander.antonov@linux.intel.com, ak@linux.intel.com,
        eranian@google.com, namhyung@kernel.org
Subject: Re: [PATCH RESEND 0/5] Fix UPI uncore issue on SPR
Message-ID: <Y9lNG+JnSFNFFAHQ@swahl-home.5wahls.com>
References: <20230112200105.733466-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112200105.733466-1-kan.liang@linux.intel.com>
X-Proofpoint-ORIG-GUID: 64f4TGacv6K1HqZ3UKdN8xpPcalMkr3_
X-Proofpoint-GUID: 64f4TGacv6K1HqZ3UKdN8xpPcalMkr3_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=622 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310153
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I reviewed this patch series, applied it to a kernel tree, and tested
it on two larger (12+ socket) systems, did not notice any adverse
affects.  So I believe it's appropriate to add both of these tags:

Tested-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

--> Steve

On Thu, Jan 12, 2023 at 12:01:00PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The discovery table of UPI on SPR MCC is broken. The patch series is
> to mitigate the issue by providing a hardcode pre-defined table.
> 
> The broken discovery table can trigger a kernel warning message, which
> is overkilled. The patch series also refine the error handling code.
> 
> Kan Liang (5):
>   perf/x86/uncore: Factor out uncore_device_to_die()
>   perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name
>   perf/x86/uncore: Ignore broken units in discovery table
>   perf/x86/uncore: Add a quirk for UPI on SPR
>   perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table
> 
>  arch/x86/events/intel/uncore.c           |  34 ++++-
>  arch/x86/events/intel/uncore.h           |   4 +
>  arch/x86/events/intel/uncore_discovery.c |  60 ++++++---
>  arch/x86/events/intel/uncore_discovery.h |  14 +-
>  arch/x86/events/intel/uncore_snbep.c     | 158 ++++++++++++++++++-----
>  5 files changed, 210 insertions(+), 60 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise

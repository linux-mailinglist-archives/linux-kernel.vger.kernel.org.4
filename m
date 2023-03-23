Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E46C728A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCWVqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCWVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:46:47 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08704EB70
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:46:30 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLK5cp004301;
        Thu, 23 Mar 2023 21:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=e508kaG0m/AfmOODYVA44mrCZ8Dl7WqMqeD/bHISZKQ=;
 b=PxyNcv/h2Dx0I4jAI8WJG9iA4ICYuITW4h1x607Mtu4XH+XeVutW0ZRBtVNHZecf8fcf
 ucrcMvKgA6MxpUfCdz9MNycK5CPCHZsP+oE8gsk/yR9xaGfmAFQBPyZ8Snv91E6Bw86S
 JshJkiYIm91tEnEmMitE3857pn5ePm7h9449zfEVO9W3N94KL0f+uPy+zRu7kB0Id3fC
 u5cN+a1gAdkFfsZJI1AGKIxTPgiGRGI10BE4sQFbfkDDRgcJ8+wBfSAShDcS+PkBsyTE
 JPpbegExu1STV2C1uI/0SQSPY9+rd1Ii1gyUXKO18fpWo7L0ZfJDBOKu48npf488NVsy Uw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pgxk8rdbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 21:46:14 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id CBF26800248;
        Thu, 23 Mar 2023 21:46:11 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id F02AB802A37;
        Thu, 23 Mar 2023 21:46:09 +0000 (UTC)
Date:   Thu, 23 Mar 2023 16:46:07 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/platform/uv: UV support for sub-NUMA clustering
Message-ID: <ZBzInwfGpzeoiWo6@swahl-home.5wahls.com>
References: <20230224225904.2618624-1-steve.wahl@hpe.com>
 <41a01b03-26f9-a9ae-d8f7-6b0eeb941cf5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a01b03-26f9-a9ae-d8f7-6b0eeb941cf5@intel.com>
X-Proofpoint-GUID: ea1SSK9epiZePWdTPQ9Qm3MGNNYzlV2R
X-Proofpoint-ORIG-GUID: ea1SSK9epiZePWdTPQ9Qm3MGNNYzlV2R
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303230157
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Thank you for taking the time to review. I will create another
version, doing my best to clarify and simplify.

--> Steve

On Thu, Mar 23, 2023 at 09:26:50AM -0700, Dave Hansen wrote:
> On 2/24/23 14:59, Steve Wahl wrote:
> > +			if (np) {
> > +				s = ((i * 64) + __ffs(np)) & s_mask;
> > +				if (sock_min > s)
> > +					sock_min = s;
> > +				s = ((i * 64) + __fls(np)) & s_mask;
> > +				if (sock_max < s)
> > +					sock_max = s;
> > +			}
> >  		}
> >  	}
> >  	if (UVH_NODE_PRESENT_0) {
> >  		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
> >  		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
> > -		uv_pb += hweight64(np);
> > +		if (np) {
> > +			s = __ffs(np) & s_mask;
> > +			if (sock_min > s)
> > +				sock_min = s;
> > +			s = __fls(np) & s_mask;
> > +			if (sock_max < s)
> > +				sock_max = s;
> > +		}
> >  	}
> >  	if (UVH_NODE_PRESENT_1) {
> >  		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
> >  		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
> > -		uv_pb += hweight64(np);
> > +		if (np) {
> > +			s = (64 + __ffs(np)) & s_mask;
> > +			if (sock_min > s)
> > +				sock_min = s;
> > +			s = (64 + __fls(np)) & s_mask;
> > +			if (sock_max < s)
> > +				sock_max = s;
> > +		}
> > +	}
> 
> I guess this patch is modifying code that very few people care about.
> But, this is kinda a mess.  This patch does a *TON* of different things
> and makes almost no effort to refactor the code before diving into the
> changes.
> 
> I quoted the above text because whatever that code is doing, it's
> gloriously uncommented.  That kind of thing demands a helper even if
> it's just used once so that a read can have _some_ idea what it's doing
> logically.
> 
> Could you please take another pass at this?  I think it demands to be
> broken up into at _least_ 5-10 individual patches.
> 
> For instance, you could introduce and use uv_pnode_to_socket() in one patch.
> 
> Or this:
> 
> > -		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG0_BASE_MASK;
> > +		nasid_mask =
> > +			is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :
> > +			is_uv(UV4)  ? UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :
> > +			UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK;
> >  		n = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG0_DEPTH;
> >  		min_nasid = min_pnode * 2;
> >  		max_nasid = max_pnode * 2;
> > @@ -1046,7 +1050,10 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
> >  		break;
> >  	case UVX_MMIOH1:
> >  		mmr = UVH_RH_GAM_MMIOH_REDIRECT_CONFIG1;
> > -		nasid_mask = UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_BASE_MASK;
> > +		nasid_mask =
> > +			is_uv(UV4A) ? UV4AH_RH_GAM_MMIOH_REDIRECT_CONFIG0_NASID_MASK :
> > +			is_uv(UV4)  ? UV4H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK :
> > +			UV3H_RH_GAM_MMIOH_REDIRECT_CONFIG1_NASID_MASK;
> 
> That could use a helper to reduce the duplication and add clarity and be
> done in a separate patch.

-- 
Steve Wahl, Hewlett Packard Enterprise

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7421F67B691
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjAYQGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjAYQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:06:17 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA85618F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:06:09 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEFdYF009571;
        Wed, 25 Jan 2023 16:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=R4/ji/oWIB41UUb9Z6bZKWNmzLOw7BtR6ZQcihC3S9s=;
 b=k1qCiE8DGlx6zOFsqMO4HikZxd9Yi4BwDwOlpYzDyDBhyy2i3JLieuFxqqbobz1Ad+OK
 7y0MRnmTGVAcNrjd+uI0x42CbU5AgFV1TWrir+uMct310UBGCP62wk6fE0P7gcn4cnqv
 IcgXdSmgkrve/VPlrtqLOT1CJZn81DFB2qMgs830AnU3p2fiMstQA6HFe0GYDpXdeHFw
 +Dl5PaNcSu86vZS6IQDcdLmhZQyKvwwNL44/H6VGthEFGNwB3y4pZJGefhoL+obYcPxk
 YeRv6dKPyYYImI1gqbcR4khU8e2WDOi5bcbQtDi8X8/fIyC8qkOz2lFm0h7PZku7hRCw zQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nb616s79n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 16:05:45 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 0CDC0809118;
        Wed, 25 Jan 2023 16:05:43 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id CDB7E80BA27;
        Wed, 25 Jan 2023 16:05:39 +0000 (UTC)
Date:   Wed, 25 Jan 2023 10:05:37 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/platform/uv: UV support for sub-NUMA clustering
Message-ID: <Y9FTURnqROHP5UUa@swahl-home.5wahls.com>
References: <20230123221812.3970769-1-steve.wahl@hpe.com>
 <Y9ESRzbzM0e8Kr1M@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ESRzbzM0e8Kr1M@gmail.com>
X-Proofpoint-ORIG-GUID: 5e1ECre_UckeXDcyxxuzYQeYxDWF0BpZ
X-Proofpoint-GUID: 5e1ECre_UckeXDcyxxuzYQeYxDWF0BpZ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_10,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 mlxlogscore=865 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:28:07PM +0100, Ingo Molnar wrote:
> 
> * Steve Wahl <steve.wahl@hpe.com> wrote:
> 
> > +static int __init alloc_conv_table(int num_elem, unsigned short **table)
> > +{
> > +	int i;
> > +	size_t bytes;
> > +
> > +	bytes = num_elem * sizeof(*table[0]);
> > +	*table = kmalloc(bytes, GFP_KERNEL);
> > +	WARN_ON_ONCE(!*table);
> > +	if (!*table)
> > +		return -ENOMEM;
> 
> WARN_ON_ONCE() is pass-through on the condition, so you can write this in a 
> shorter form:
> 
> 	if (!WARN_ON_ONCE(!*table))
> 		return -ENOMEM;

That is nicer.  I will incorporate this (including all the repeats).

...
> 
> > +		WARN_ON_ONCE(!new_hub);
> > +		if (!new_hub)
> > +			return;
> 
> Same. Also a memory leak of at least uv_hub_info_list_blade?

You're right, and this is not the only place.  I will rework.

...
> > +
> > +	for_each_node(nodeid) {
> > +		__uv_hub_info_list[nodeid] = uv_hub_info_list_blade[uv_node_to_blade_id(nodeid)];
> > +	}
> 
> Unnecessary curly braces.

I will fix.

> Looks good otherwise - presumably it's both tested and backwards compatible 
> with older UV hardware?

Yes, in fact there was a major re-work before letting it escape to the
world because the previous version didn't function on older hardware.

Thank you for taking the time to review!

--> Steve
-- 
Steve Wahl, Hewlett Packard Enterprise

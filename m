Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABA6C6D06
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCWQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCWQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:11:36 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435626CE0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:11:31 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NFlW4v008657;
        Thu, 23 Mar 2023 16:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=UcIvhkzkGuLo0g+xF50Km9vHChuy/Y2XH/s5lgfqbdU=;
 b=Yd0D3OUro2IX/wK2mMzz+CwOm36+lTWkCjZsiIiBEWajcjw6Owh81CUuskzOBzY8kSVA
 w1LOr/i67AC7yy8kkY2mqY8tVIjpztOeuCS/8tZUXMDQZlYZrdJ6wk7R3snHjA/BtrPy
 PMH8usX/1f+7N57EbL0+VojjKZpesp4On7P+Je5YZwy1IXvdTfwtPnaUdXS+ci1qe9jQ
 5Qm4MfN+SanPR4xmZ4fqbljuHffFV0MIp54gCmK7PA4seClZrg12crdRCaO0OgnGeHD2
 3V2Lq6do7CGmm3k28EYrHMEroXAbPEkS9dd1BF//g37oCA7jwHzPpmXC0sDD89R7vBg9 gg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pgsqcr6w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 16:10:54 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 46FEF804792;
        Thu, 23 Mar 2023 16:10:52 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 93228816D1C;
        Thu, 23 Mar 2023 16:10:50 +0000 (UTC)
Date:   Thu, 23 Mar 2023 11:10:24 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/platform/uv: UV support for sub-NUMA clustering
Message-ID: <20230323161024.GA3653487@dog.eag.rdlabs.hpecorp.net>
References: <20230224225904.2618624-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224225904.2618624-1-steve.wahl@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: ZIJ-BUJh7JrnlCdLT7Y0yuYOEiiD4r5P
X-Proofpoint-ORIG-GUID: ZIJ-BUJh7JrnlCdLT7Y0yuYOEiiD4r5P
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230118
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:59:04PM -0600, Steve Wahl wrote:
> Sub-NUMA clustering (SNC) invalidates previous assumptions of a 1:1
> relationship between blades, sockets, and nodes.  Fix these
> assumptions and build tables correctly when SNC is enabled.

Gentle ping, does anyone have comments for me on this patch?

Thanks,

--> Steve Wahl, <steve.wahl@hpe.com>


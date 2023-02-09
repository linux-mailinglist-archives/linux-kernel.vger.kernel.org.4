Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10460690022
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBIGDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBIGDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:03:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE70712F18
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:03:42 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3195loNK001539;
        Thu, 9 Feb 2023 06:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=joRFsh7ZoYD6l+lYzvF9igqn1kx9gTe9Q9Au5PPDFnI=;
 b=D1p0QStiEHppyLMBUCULMq2xvurCfmDHgtZeiJ8n7Onhhniiu/2uSXVomtq73fk18tcR
 Sz8RJnejmKD9PaCS+LviYGL4yC9q6JqgYAhII49FjZIh3P/98vczwyMNX7j3o6qZ123H
 WLTMCaTkIWWtKro9sMfoIiCW2GCKc9rSUMiFOYYWVdRSmfB3NhqRl/8SPJq5E+zB7FRc
 kUq5IdFbBToocNFI6b5Al26wACPLtAkHnCLaH4Ikn9/3zv3xp+xFndjzil54bPXSUqUz
 hriE9MMw8UjvvHCPQnQrSjrcud67Z3TU0t7Rc2iaygTqd6N2rbxymgZDIBDLH8FCRDYH fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmu0gr905-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 06:03:27 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3195ncQI006623;
        Thu, 9 Feb 2023 06:03:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmu0gr8yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 06:03:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3194FAY5017708;
        Thu, 9 Feb 2023 06:03:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf07y429-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 06:03:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31963OeU23462492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 06:03:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB495804E;
        Thu,  9 Feb 2023 06:03:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268F058052;
        Thu,  9 Feb 2023 06:03:21 +0000 (GMT)
Received: from [9.160.93.69] (unknown [9.160.93.69])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 06:03:20 +0000 (GMT)
Message-ID: <beea0477-f850-90dc-eb7e-7665492491b1@linux.ibm.com>
Date:   Thu, 9 Feb 2023 08:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RFC 0/7] revert RNG seed mess
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Dov Murik <dovmurik@linux.ibm.com>
References: <20230208211212.41951-1-mst@redhat.com>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20230208211212.41951-1-mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uW18-xpaXmvTQejrsTR9Se58srxS5D34
X-Proofpoint-ORIG-GUID: pZsRIQZiNvYrTRR0fqWINq2U6DkhyL1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_03,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090056
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 08/02/2023 23:12, Michael S. Tsirkin wrote:
> All attempts to fix up passing RNG seed via setup_data entry failed.
> Let's just rip out all of it.  We'll start over.
> 
> 
> Warning: all I did was git revert the relevant patches and resolve the
> (trivial) conflicts. Not even compiled - it's almost midnight here.
> 
> Jason this is the kind of approach I'd like to see, not yet another
> pointer math rich patch I need to spend time reviewing. Just get us back
> to where we started. We can redo "x86: use typedef for SetupData struct"
> later if we want, it's benign.
> 
> Could you do something like this pls?
> Or test and ack if this patchset happens to work by luck.
> 
> Michael S. Tsirkin (7):
>   Revert "x86: don't let decompressed kernel image clobber setup_data"
>   Revert "x86: do not re-randomize RNG seed on snapshot load"
>   Revert "x86: re-initialize RNG seed when selecting kernel"
>   Revert "x86: reinitialize RNG seed on system reboot"
>   Revert "x86: use typedef for SetupData struct"
>   Revert "x86: return modified setup_data only if read as memory, not as
>     file"
>   Revert "hw/i386: pass RNG seed via setup_data entry"
> 
>  include/hw/i386/microvm.h |   5 +-
>  include/hw/i386/pc.h      |   3 -
>  include/hw/i386/x86.h     |   3 +-
>  include/hw/nvram/fw_cfg.h |  31 ----------
>  hw/i386/microvm.c         |  17 ++----
>  hw/i386/pc.c              |   4 +-
>  hw/i386/pc_piix.c         |   2 -
>  hw/i386/pc_q35.c          |   2 -
>  hw/i386/x86.c             | 122 ++++++++++----------------------------
>  hw/nvram/fw_cfg.c         |  21 ++-----
>  10 files changed, 49 insertions(+), 161 deletions(-)
> 


I tested this series with SEV measured boot using AmdSev OVMF.  The boot
succeeds, and the hashes computed for kernel/initrd/cmdline are
identical to the ones computed by qemu 7.1.0, which are the hashes that
the guest owner would expect.

As for non-EFI (non-SEV) guests, I did a very simple test of starting a
non-EFI guest and it looks OK, but more testing is needed.

So:

Tested-by: Dov Murik <dovmurik@linux.ibm.com>


Thank you!

-Dov

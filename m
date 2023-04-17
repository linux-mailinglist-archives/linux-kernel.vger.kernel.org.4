Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164506E51F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDQUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:39:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC22702;
        Mon, 17 Apr 2023 13:39:38 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HJNbVI030245;
        Mon, 17 Apr 2023 20:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=5rMqc9PJ6T4OilW6n2ZAL51z0KrN+677eg159x3B6uE=;
 b=eIhmmXxosxD9PN5SDu98pFbXSI1fB20Qlg//56CP+0miC+nQLA6YpMBAq3Yx9XL+5TlW
 vglP7aPW4PbUTglt7oxJDqvYi2uvQQX8i5bl+e/+T7Qza87xzcMz6BUe1pP1X8BLJomp
 B0AwzV4gZ0682EwbNBolytxmCaToOkFpxp2FDx0hzdi2ui6jQreny2gNYqPAECjt55dJ
 ZAftdcCR4JYIh90it7vrUjHqH4+TSC18ftjIW7khbmQtDJ2/PeqpkoIj3etEPO+vhuQa
 hxlBdRZLXrukFzzMI2ySYETpPGkt+T2auk922m96ocri1OVOw+XowD/W3Czg1MSCaskR DQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1c7w25bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 20:39:22 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33HH0GOM012148;
        Mon, 17 Apr 2023 20:34:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3pykj759qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 20:34:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33HKYJRK9699884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Apr 2023 20:34:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1435804E;
        Mon, 17 Apr 2023 20:34:19 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 852845803F;
        Mon, 17 Apr 2023 20:34:19 +0000 (GMT)
Received: from localhost (unknown [9.163.32.114])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Apr 2023 20:34:19 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        axboe@kernel.dk, konrad.wilk@oracle.com, joe.jin@oracle.com,
        junxiao.bi@oracle.com
Subject: Re: [PATCH V2] debugfs: allow access relay files in lockdown mode
In-Reply-To: <20230412205316.7114-1-junxiao.bi@oracle.com>
References: <20230412205316.7114-1-junxiao.bi@oracle.com>
Date:   Mon, 17 Apr 2023 15:34:19 -0500
Message-ID: <878reqs0xg.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wnovF-HkGGUZW09nHQDHJLMxsZ9944uk
X-Proofpoint-GUID: wnovF-HkGGUZW09nHQDHJLMxsZ9944uk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junxiao Bi <junxiao.bi@oracle.com> writes:
> Relay files are used by kernel to transfer information to userspace, these
> files have permission 0400, but mmap is supported, so they are blocked by
> lockdown. But since kernel just generates the contents of those files while
> not reading it, it is saft to access relay files in lockdown mode.
>
> With this, blktrace can work well in lockdown mode.

Assuming that all relay users do not expose the kinds of information
that confidentiality mode tries to restrict, this change seems OK to
me. I think that assumption applies to blktrace; apart from that, there
is a handful of drivers that use relay files (I searched for
relay_open() call sites, maybe there is a better way).


> v2 <- v1:
> Fix build error when CONFIG_RELAY is not defined.
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304121714.6mahd9EW-lkp@intel.com/
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>  fs/debugfs/file.c     | 9 +++++++++
>  include/linux/relay.h | 8 ++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..c52c94e20366 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -21,6 +21,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/poll.h>
>  #include <linux/security.h>
> +#include <linux/relay.h>
>  
>  #include "internal.h"
>  
> @@ -142,6 +143,11 @@ EXPORT_SYMBOL_GPL(debugfs_file_put);
>   * Only permit access to world-readable files when the kernel is locked down.
>   * We also need to exclude any file that has ways to write or alter it as root
>   * can bypass the permissions check.
> + * Exception:
> + * Relay files are used by kernel to transfer information to userspace, these
> + * files have permission 0400, but mmap is supported, so they are blocked by
> + * lockdown. But since kernel just generates the contents of those files while
> + * not reading it, it is saft to access relay files in lockdown mode.
>   */
>  static int debugfs_locked_down(struct inode *inode,
>  			       struct file *filp,
> @@ -154,6 +160,9 @@ static int debugfs_locked_down(struct inode *inode,
>  	    !real_fops->mmap)
>  		return 0;
>  
> +	if (is_relay_file(real_fops))
> +		return 0;
> +
>  	if (security_locked_down(LOCKDOWN_DEBUGFS))
>  		return -EPERM;
>  
> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index 72b876dd5cb8..914f116d826e 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -279,8 +279,16 @@ extern const struct file_operations relay_file_operations;
>  
>  #ifdef CONFIG_RELAY
>  int relay_prepare_cpu(unsigned int cpu);
> +static inline int is_relay_file(const struct file_operations *fops)
> +{
> +	return fops == &relay_file_operations;
> +}
>  #else
>  #define relay_prepare_cpu     NULL
> +static inline int is_relay_file(const struct file_operations *fops)
> +{
> +	return 0;
> +}

The return type should be bool for predicate functions like this IMO.

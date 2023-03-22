Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513CA6C5A69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCVXbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCVXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:31:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EE44B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679527902; x=1711063902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q9SHaaGc/iP3oUCDDkuobziv3fI8u5euiS4kcHH3kx8=;
  b=HMMewl0CHgfpSKOzuw0+NIsXB8AWICeLIutrwms3FvS++TogX6kgLNrj
   EBchyP1U2w252EtryuRwDDx1WRLR+xGwmbVyQ3MBgrGIAVou62OUwlB+Z
   ENAiv260zlSHmgQ456WF3rVEtUB7xHLbi/KAeFrDf1uHIu+CrSBwIDqyJ
   SHb9JykYkBLkdLzis03jxaM4WaTfxCW4WuYLXLIPHFQlLMntTdW3wUp/1
   wZLFhKDU8eWYCkwrIpZGprS00+/IFkrXTE7cgRLd4cbbtf7l8zWomHPdf
   jGWooQOPK5wC21lZCWverorX5xsw+9bS2HUoFnMvHPoxbra5ZK5MM0QgD
   A==;
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="224559258"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:31:40 +0800
IronPort-SDR: r44k00YK0hNmcVwbz/KTQAnf4ucWoL1NLop81FtRgCj8/bNB1wmBKuuxvDdsa7fm3AWm4jzFwe
 tTtFe2dY3Cr/8qVlAX3Cm73dKdF11zsotA3RllJZ/pnQ7Vto6YdWJBxDZT8yDjhFZexaMrh6A0
 W3gCwbBMrqCqH/pX9Gja6FCU03BNWdcnGJ9vYOCi9oaaW5Uc3gezU4lnRSkISUnXkb+JJqt/bJ
 dSpCsAsfEJTr9guafI9Ug4JjdIPwX8tonmWJpxvuyNYOp3d0H55qNarrowNC3dYuf7ikRuuHeX
 Tpc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:47:57 -0700
IronPort-SDR: Hp2ZeCNti/lEGv+cQptiJzLxl1wKydSJNhprVNf+YVlZ+N+2oWyJ02IeWsgIWIcPGBQO1VXoCC
 PmBzWvdeiftqqe97169Vln0rM1agzc/U9ujFWYOE6zqjV2yj4x7q5GcKaz4FwCpfm7b1/Bi6pZ
 39Cev8pMg+GVLgRnLfkLbfip/kONesM7HoFlQTpHQJQJbSI+bXutBysQMUqsgPmr4qSQ27Mkk3
 eVto1TbXWHlDgrALJWg/3TeAHHIcN3gQVVVfLTwSHabli0EuCB9BqbbZsus2rbdxqT4xVfNOUk
 2tI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:31:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Phl9R4bvTz1RtW0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:31:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679527898; x=1682119899; bh=q9SHaaGc/iP3oUCDDkuobziv3fI8u5euiS4
        kcHH3kx8=; b=jXOcAHSjzQp3Y8DRAhI7Eqaykde0th0S9alUrID1c2LCC3wfAb9
        gKLpCqhNvhXIVpoACyCWdORhWPyVwcLyv+I3A4HyVbq47iykpBBgezzTIryrgP44
        YEKzud94Zk+Y8HC/UY2RnSvJBZedTJ3OfzPeXnPWHU3PAOtYg4P8hX2IvtQ6yBhi
        j4r/QQvfwmqbzwmimzdJGIuPI0o0MfJdBhX8DuQYGVDi4A2JABTEyXrQamz1e+uF
        +gUlyjlv0VsY1s6/lX1w99QOTvab/kA98gC8MKGuF5bkUAv65So0qyJzKTEypPY0
        ciNq+kgkTDjVCQlQD4ZfSdBBlYkyJL09/6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UlOc0osRfCXK for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:31:38 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Phl9H74fjz1RtVm;
        Wed, 22 Mar 2023 16:31:31 -0700 (PDT)
Message-ID: <5e7e8187-f514-c65e-2615-26762a329590@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:31:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/10] kobject: introduce kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, richard@nod.at, djwong@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230322165830.55071-1-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165830.55071-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 01:58, Yangtao Li wrote:
> There are plenty of using kobject_del() and kobject_put() together
> in the kernel tree. This patch wraps these two calls in a single helper.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -convert to inline helper
> v2:
> -add kobject_del_and_put() users
>  include/linux/kobject.h | 13 +++++++++++++
>  lib/kobject.c           |  3 +--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index bdab370a24f4..e21b7c22e355 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -112,6 +112,19 @@ extern struct kobject * __must_check kobject_get_unless_zero(
>  						struct kobject *kobj);
>  extern void kobject_put(struct kobject *kobj);
>  
> +/**
> + * kobject_del_and_put() - Delete kobject.
> + * @kobj: object.
> + *
> + * Unlink kobject from hierarchy and decrement the refcount.

Unlink kobject from hierarchy and decrement its refcount.

> + * If refcount is 0, call kobject_cleanup().

That is done by kobject_put() and not explicitly done directly in this helper.
So I would not mention this to avoid confusion as you otherwise have a
description that does not match the code we can see here.

With that fixed, this looks OK to me, so feel free to add:

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> + */
> +static inline void kobject_del_and_put(struct kobject *kobj)
> +{
> +	kobject_del(kobj);
> +	kobject_put(kobj);
> +}
> +
>  extern const void *kobject_namespace(const struct kobject *kobj);
>  extern void kobject_get_ownership(const struct kobject *kobj,
>  				  kuid_t *uid, kgid_t *gid);
> diff --git a/lib/kobject.c b/lib/kobject.c
> index f79a434e1231..e6c5a3ff1c53 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -876,8 +876,7 @@ void kset_unregister(struct kset *k)
>  {
>  	if (!k)
>  		return;
> -	kobject_del(&k->kobj);
> -	kobject_put(&k->kobj);
> +	kobject_del_and_put(&k->kobj);

Nit: You could simplify this one to be:

	if (k)
		kobject_del_and_put(&k->kobj);

and drop the return line.

>  }
>  EXPORT_SYMBOL(kset_unregister);
>  

-- 
Damien Le Moal
Western Digital Research


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A461FE0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiKGS6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiKGS6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F72D1F7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667847397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZhxxyYTlaIwmmIfK4vWroJcpNA8iZbDPuwQPDMKca0=;
        b=dX2761zAdlQZiGcusuV4kkT69ZH1oZs7GLy79KBz70XY7XBdf9chQuQOAXzARcgM45CGsT
        Vl+VCVa225baxIan0a8iifL0oKSQQuBzhyz1NQ+YJLq3TW7B04Ht1vFWcrJaEsbmwDyVKO
        6pEUtLMR62qlthRcUIdpk4GhNt7+o8c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-hnckvliBPSKUsGqTNWLX7A-1; Mon, 07 Nov 2022 13:56:32 -0500
X-MC-Unique: hnckvliBPSKUsGqTNWLX7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AA52185A78F;
        Mon,  7 Nov 2022 18:56:32 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 870E042222;
        Mon,  7 Nov 2022 18:56:30 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 37D9AC0519; Mon,  7 Nov 2022 13:56:30 -0500 (EST)
Date:   Mon, 7 Nov 2022 13:56:30 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     Wang Weiyang <wangweiyang2@huawei.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        serge.hallyn@canonical.com, akpm@linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
Message-ID: <20221107185630.dwcffktczjrayagn@redhat.com>
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025113101.41132-1-wangweiyang2@huawei.com>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:31:01PM +0800, Wang Weiyang wrote:
> When add the 'a *:* rwm' entry to devcgroup A's whitelist, at first A's
> exceptions will be cleaned and A's behavior is changed to
> DEVCG_DEFAULT_ALLOW. Then parent's exceptions will be copyed to A's
> whitelist. If copy failure occurs, just return leaving A to grant
> permissions to all devices. And A may grant more permissions than
> parent.
> 
> Backup A's whitelist and recover original exceptions after copy
> failure.
> 
> Fixes: 4cef7299b478 ("device_cgroup: add proper checking when changing default behavior")
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>  security/device_cgroup.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index a9f8c63a96d1..bef2b9285fb3 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -82,6 +82,17 @@ static int dev_exceptions_copy(struct list_head *dest, struct list_head *orig)
>  	return -ENOMEM;
>  }
>  
> +static void dev_exceptions_move(struct list_head *dest, struct list_head *orig)
> +{
> +	struct dev_exception_item *ex, *tmp;
> +
> +	lockdep_assert_held(&devcgroup_mutex);
> +
> +	list_for_each_entry_safe(ex, tmp, orig, list) {
> +		list_move_tail(&ex->list, dest);
> +	}
> +}
> +
>  /*
>   * called under devcgroup_mutex
>   */
> @@ -604,11 +615,13 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
>  	int count, rc = 0;
>  	struct dev_exception_item ex;
>  	struct dev_cgroup *parent = css_to_devcgroup(devcgroup->css.parent);
> +	struct dev_cgroup tmp_devcgrp;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	memset(&ex, 0, sizeof(ex));
> +	memset(&tmp_devcgrp, 0, sizeof(tmp_devcgrp));
>  	b = buffer;
>  
>  	switch (*b) {
> @@ -620,15 +633,27 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
>  
>  			if (!may_allow_all(parent))
>  				return -EPERM;
> -			dev_exception_clean(devcgroup);
> -			devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> -			if (!parent)
> +			if (!parent) {
> +				devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> +				dev_exception_clean(devcgroup);
>  				break;
> +			}
>  
> +			INIT_LIST_HEAD(&tmp_devcgrp.exceptions);
> +			rc = dev_exceptions_copy(&tmp_devcgrp.exceptions,
> +						 &devcgroup->exceptions);
> +			if (rc)
> +				return rc;
> +			dev_exception_clean(devcgroup);
>  			rc = dev_exceptions_copy(&devcgroup->exceptions,
>  						 &parent->exceptions);
> -			if (rc)
> +			if (rc) {
> +				dev_exceptions_move(&devcgroup->exceptions,
> +						    &tmp_devcgrp.exceptions);
>  				return rc;
> +			}
> +			devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> +			dev_exception_clean(&tmp_devcgrp);
>  			break;
>  		case DEVCG_DENY:
>  			if (css_has_online_children(&devcgroup->css))

Reviewed-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu


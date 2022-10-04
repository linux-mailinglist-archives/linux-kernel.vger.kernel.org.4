Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D65F405F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJDJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJDJxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:53:08 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC731237;
        Tue,  4 Oct 2022 02:52:11 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C6FE542F7E;
        Tue,  4 Oct 2022 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664877127;
        bh=auXXm/gRfpR6ooMtURJxM7kzyBAv5R3HRiNjDlYasY8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NdygnKiEBbLYsBVhagqcZFPeH6gw7AwSBU3gERc2PG9245RQsoyUQlxWzyNKDufOI
         Y71IFTwmcuT36fA7fIpyDOhNXRUjjD78JAtAe6W9CFoNiPLKUkU0CfkeXL/e3Ce0Pa
         uY+VOyJgLg2wQQzLsIs2FDh198vuS3rz3bVk5a+m0ktdFjltKF+7pt0FXTqpz7OfmK
         1x8ZP3Xpz9eQvKl+nW+fQDqIfJw4OizdA3BArDc9xdS6DJFkT59dfe4Xq1vk1Lqexc
         jeulOMyrYR6Zln+0TCGlD49bZNPmpmIDhH5Ju5ZrxfCtuigz5sN8bgDmXmvoUawWie
         PqVUtf0y3WtxA==
Message-ID: <3c47940d-06e2-6c08-280c-76f7a365cf0b@canonical.com>
Date:   Tue, 4 Oct 2022 02:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] apparmor: store return value of unpack_perms_table() to
 signed variable
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kernel@collabora.com, kernel-janitors@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221004084515.659441-1-usama.anjum@collabora.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221004084515.659441-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 01:45, Muhammad Usama Anjum wrote:
> The unpack_perms_table() can return error which is negative value. Store
> the return value to a signed variable. policy->size is unsigned
> variable. It shouldn't be used to store the return status.
> 
> Fixes: 2d6b2dea7f3c ("apparmor: add the ability for policy to specify a permission table")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

yep, thanks I have pulled this in

Acked-by: john.johansen@canonical.com <john.johansen@canonical.com>

> ---
>   security/apparmor/policy_unpack.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 45c9dfdc8e0d..09f316943951 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -734,14 +734,18 @@ static int unpack_pdb(struct aa_ext *e, struct aa_policydb *policy,
>   {
>   	void *pos = e->pos;
>   	int i, flags, error = -EPROTO;
> +	ssize_t size;
>   
> -	policy->size = unpack_perms_table(e, &policy->perms);
> -	if (policy->size < 0) {
> -		error = policy->size;
> +	size = unpack_perms_table(e, &policy->perms);
> +	if (size < 0) {
> +		error = size;
>   		policy->perms = NULL;
>   		*info = "failed to unpack - perms";
>   		goto fail;
> -	} else if (policy->perms) {
> +	}
> +	policy->size = size;
> +
> +	if (policy->perms) {
>   		/* perms table present accept is index */
>   		flags = TO_ACCEPT1_FLAG(YYTD_DATA32);
>   	} else {


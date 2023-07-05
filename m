Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52A748B37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjGESCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjGESCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:02:37 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467819A2;
        Wed,  5 Jul 2023 11:02:32 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C2F0E414C5;
        Wed,  5 Jul 2023 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688580150;
        bh=Ml6u5VGqvgonexNAqzQPeVeGEc4fEqTY9Ir/lPqp668=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=AzfHjPOox/m5CoOulzZnHpGWwEKBBxqulnzx2rQ2j1AYoBK1KhcgztMTACpRInTn0
         xx7EU/9BRkeGy2QGWjuDDUrjCVThjXLQrjq8UVAKOppxbD9uy9gSk2V35n3vz35Ema
         LEFJHwuJowPA6ZayZDET+gFpG9BZtQ8G2QpqfleIgEFwTRuntLyS7m9P6OBOaTAf1C
         ZRfyMWZami/mCsutIfPqphb8dagEYXv7GSx0/a5CczOUuhakm4B161EEbF4PPU6V+j
         huJeHxppPElk79gu8QRdQKHC/eNEClVXqAuIhhVnCvP+AI/NlalhwgQxj4ViLlYZ0x
         sp0FDsk8t2xTQ==
Message-ID: <30faaa83-bdb3-69b8-1fa9-7c1f4f011045@canonical.com>
Date:   Wed, 5 Jul 2023 11:02:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] security: remove duplicate logical judgments in return
To:     Minjie Du <duminjie@vivo.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Terrell <terrelln@fb.com>,
        "moderated list:APPARMOR SECURITY MODULE" <apparmor@lists.ubuntu.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230704085653.6443-1-duminjie@vivo.com>
Content-Language: en-US
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230704085653.6443-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 01:56, Minjie Du wrote:
> Fix: delate duplicate logical judgments:
> aa_unpack_u32(e, &perm->allow, NULL);
> Please check this. Thank you!
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

NAK, it is a bug but not in a way that we can do this, which will break the unpack. The first entry is reserved, and for the moment should be skipped. Double loading to
&perm->allow, effectively does that but was not what was intended either. There is a patch coming that loads the first entry to a tmp variable and does a check that it is 0.

> ---
>   security/apparmor/policy_unpack.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 694fb7a09..2069adf0a 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -646,7 +646,6 @@ static bool unpack_perm(struct aa_ext *e, u32 version, struct aa_perms *perm)
>   		return false;
>   
>   	return	aa_unpack_u32(e, &perm->allow, NULL) &&
> -		aa_unpack_u32(e, &perm->allow, NULL) &&
>   		aa_unpack_u32(e, &perm->deny, NULL) &&
>   		aa_unpack_u32(e, &perm->subtree, NULL) &&
>   		aa_unpack_u32(e, &perm->cond, NULL) &&


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE33647700
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLHUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLHUKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:10:43 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC971266;
        Thu,  8 Dec 2022 12:10:38 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0F15D420B2;
        Thu,  8 Dec 2022 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670530237;
        bh=bHLpKlVywAIn9Mz9IlXBf3CKnLTyGWwhq0WGPu4dJxE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FPYdiJn0Wv2IeXB64dV5hw9eDeK1e9mj5wKCVrFEZCzENSE3h7+xN8bo/rhftcL/M
         zE/BmMQuHVFw6UVsxw7QO6HyjUbwj1oUJnuyqfGyb6VJoHLoXAHZxC8SD3z2Eb9NwL
         VvTq+FgCdtJFBGs623+U+Mu5iLMDyQE5BzBI9lisgFHvzL6frtH1Fuf9+PRiUIc2Vc
         fMcj0upMdeIlroCOol+VqAoEbkSA1xOP4HLfeFU18SEjssBQv9zVZXKq05EJEBxpxe
         k8FOMfyNvYEEwQBHubTtGrEodn48SPWVuD9vIzX92aOjSWS1L53ZeMmgcSqv7thGJS
         vg82L9TbdrUjw==
Message-ID: <bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com>
Date:   Thu, 8 Dec 2022 12:10:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
References: <20221208135327.01364529@canb.auug.org.au>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221208135327.01364529@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 18:53, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kunit-next tree got a conflict in:
> 
>    security/apparmor/policy_unpack.c
> 
> between commits:
> 
>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
> (and probably others)
> 
> from the apparmor tree and commit:
> 
>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
> 
> from the kunit-next tree.
> 
> This is somewhat of a mess ... pity there is not a shared branch (or
> better routing if the patches).
> 
sorry, there was a miscommunication/misunderstanding, probably all on me, I
thought the kunit stuff that is conflicting here was going to merge next
cycle.

> I fixed it up (hopefully - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> I also had to add this patch:
> 
this needs to be modified to build if kunit is not enabled, basically
the defines need to move up outside the #if IS_ENABLED(CONFIG_KUNIT)

ie.
diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
index 8fdf8f703bd0..dcf7d1bbf96b 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -165,6 +165,11 @@ static inline void aa_put_loaddata(struct aa_loaddata *data)
  		kref_put(&data->count, aa_loaddata_kref);
  }
  
+#define tri int
+#define TRI_TRUE 1
+#define TRI_NONE 0
+#define TRI_FALSE -1
+
  #if IS_ENABLED(CONFIG_KUNIT)
  bool aa_inbounds(struct aa_ext *e, size_t size);
  size_t aa_unpack_u16_chunk(struct aa_ext *e, char **chunk);
@@ -173,11 +178,6 @@ bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
  bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
  bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
  
-#define tri int
-#define TRI_TRUE 1
-#define TRI_NONE 0
-#define TRI_FALSE -1
-
  tri aa_unpack_array(struct aa_ext *e, const char *name, u16 *size);
  size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
  int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);


feel free to apply that to your patch and then add my
Acked-by: John Johansen <john.johansen@canonical.com>

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 8 Dec 2022 13:47:43 +1100
> Subject: [PATCH] fixup for "apparmor: make unpack_array return a trianary value"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   security/apparmor/include/policy_unpack.h | 8 +++++++-
>   security/apparmor/policy_unpack.c         | 5 -----
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/include/policy_unpack.h
> index 940da8a33e0c..8fdf8f703bd0 100644
> --- a/security/apparmor/include/policy_unpack.h
> +++ b/security/apparmor/include/policy_unpack.h
> @@ -172,7 +172,13 @@ bool aa_unpack_X(struct aa_ext *e, enum aa_code code);
>   bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name);
>   bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
>   bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
> -size_t aa_unpack_array(struct aa_ext *e, const char *name);
> +
> +#define tri int
> +#define TRI_TRUE 1
> +#define TRI_NONE 0
> +#define TRI_FALSE -1
> +
> +tri aa_unpack_array(struct aa_ext *e, const char *name, u16 *size);
>   size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
>   int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);
>   int aa_unpack_strdup(struct aa_ext *e, char **string, const char *name);
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 6513545dad5e..173d832fc4ee 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -30,11 +30,6 @@
>   #include "include/policy_unpack.h"
>   #include "include/policy_compat.h"
>   
> -#define tri int
> -#define TRI_TRUE 1
> -#define TRI_NONE 0
> -#define TRI_FALSE -1
> -
>   /* audit callback for unpack fields */
>   static void audit_cb(struct audit_buffer *ab, void *va)
>   {


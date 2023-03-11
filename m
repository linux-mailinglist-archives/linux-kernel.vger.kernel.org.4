Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4F6B6166
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCKWNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCKWNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABE43901
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:13:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BB96B801C0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 22:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD34DC433EF;
        Sat, 11 Mar 2023 22:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678572829;
        bh=6oEMKc9rlUbLvMMd2Dwv84kkX3Dqbwq511MpE3tzLBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X9SbL/i8saxXr/aTHY+lKrahKja2U7ADcPLUzLE0FJUWuoNtKk1H+O6selQS/5teg
         fMFvsLUk6/ub/oNGbTFopR9vLG5AyQoG/XFgBU58Jss4Ri2rfTEXIyFlYasBferguN
         4n6UhQJc9vP4MHA9RV6uY8h1cmKsgvsZZNY49Kr5EIRSnKcH3FC7LwxDqyr+iXmWMO
         kCT2VogzzAGLebgu5aKVpJN90ei38r1A/J68MN2FrhzHm+BYhp2nHOMrLUDR+BWpfu
         1BS73V/7AwluCSc4YGiyRyIykGevLT09QgaMhKbnev4jNanC4n8ae60Vgm9vB+rLdY
         0aYAlMrdtvqXw==
Date:   Sun, 12 Mar 2023 00:13:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     arnd@arndb.de, akpm@linux-foundation.org, keescook@chromium.org,
        herbert@gondor.apana.org.au, josh@joshtriplett.org,
        jani.nikula@intel.com, corbet@lwn.net, jgg@mellanox.com,
        dmatlack@google.com, mizhang@google.com, pbonzini@redhat.com,
        seanjc@google.com, linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v1 1/3] security: keys: don't use data type as variable
 name
Message-ID: <ZAz9Gi/nHL8TLrRn@kernel.org>
References: <20230304041932.847133-1-wei.w.wang@intel.com>
 <20230304041932.847133-2-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304041932.847133-2-wei.w.wang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 12:19:30PM +0800, Wei Wang wrote:
> 'bool' is a specific name for the data type that is an alias for
> the C99 _Bool type. It shoudn't be used as variable names as that causes
> too much confusion either for the reader or the compilier.
> 
> CC: James.Bottomley@HansenPartnership.com
> CC: jarkko@kernel.org
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 2b2c8eb258d5..390d7314f5a6 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -54,12 +54,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			       asn1_oid_len(tpm2key_oid));
>  
>  	if (options->blobauth_len == 0) {
> -		unsigned char bool[3], *w = bool;
> +		unsigned char bool_val[3], *w = bool_val;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
>  		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
>  			return PTR_ERR(w);
> -		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> +		work = asn1_encode_tag(work, end_work, 0,
> +				       bool_val, w - bool_val);
>  	}
>  
>  	/*
> -- 
> 2.27.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

BR, Jarkko

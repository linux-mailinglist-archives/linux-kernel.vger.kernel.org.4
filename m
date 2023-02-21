Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38A69E8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBUT4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjBUT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:56:35 -0500
X-Greylist: delayed 1797 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Feb 2023 11:56:20 PST
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D6302B2;
        Tue, 21 Feb 2023 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NQ9y6d+u8IOAhn/68k3desHT+L1FgOkL/Tc4VshJ/UM=; b=R8uw4hiBc7w0szJJ1qTiYqMc5C
        ph63bqRFcTMglOApx+zNeiHk3C6CQSFz++942pI5s++lu4o7JVuJ9ni564if2/UkWw6FZJaScAPad
        buOS6s4s41Im2Q0wnVHV6pGXNbngOTpeOMzyi3skhwD1G6y23LnfvcqWzIgxoZGFoqFA=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.96)
        (envelope-from <kilobyte@angband.pl>)
        id 1pUWUz-001RlR-22;
        Tue, 21 Feb 2023 18:32:17 +0100
Date:   Tue, 21 Feb 2023 18:32:17 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] certs: fips test: fix build failure with
 PKCS7_MESSAGE_PARSER=m
Message-ID: <Y/UAIfuP/EhD+pIx@angband.pl>
References: <20230221171919.55714-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230221171919.55714-1-kilobyte@angband.pl>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 06:19:19PM +0100, Adam Borowski wrote:
> ld: crypto/asymmetric_keys/selftest.o: in function `fips_signature_selftest':
> selftest.c:(.init.text+0xcd): undefined reference to `pkcs7_parse_message'

... and a fix for this has just been applied, I somehow missed it being on
the way.  That's 0f5d4a0b995faa6537c4de79973817a4f8da206a which wasn't yet
in yesterday evening's pull.

Sorry for noise.

> ld: selftest.c:(.init.text+0x103): undefined reference to `pkcs7_supply_detached_data'
> ld: selftest.c:(.init.text+0x10d): undefined reference to `pkcs7_verify'
> ld: selftest.c:(.init.text+0x135): undefined reference to `pkcs7_validate_trust'
> ld: selftest.c:(.init.text+0x157): undefined reference to `pkcs7_free_message'
> 
> Fixes: 3cde3174eb91 ("certs: Add FIPS selftests")
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> This fail still happens on randconfig runs.
> 
> v2: expanded the Fixes tag to include that commit's subject
> 
>  crypto/asymmetric_keys/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> index 3df3fe4ed95f..fe007db96c69 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -83,6 +83,6 @@ config FIPS_SIGNATURE_SELFTEST
>  	  for FIPS.
>  	depends on KEYS
>  	depends on ASYMMETRIC_KEY_TYPE
> -	depends on PKCS7_MESSAGE_PARSER
> +	depends on PKCS7_MESSAGE_PARSER=y
>  
>  endif # ASYMMETRIC_KEY_TYPE
> -- 

Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Q: Is it ok to combine wired, wifi, and/or bluetooth connections
⢿⡄⠘⠷⠚⠋⠀    in wearable computing?
⠈⠳⣄⠀⠀⠀⠀ A: No, that would be mixed fabric, which Lev19:19 forbids.

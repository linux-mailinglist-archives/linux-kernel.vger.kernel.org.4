Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E3722E57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjFESHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjFESHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E010C0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB3A4628F8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17CAC433D2;
        Mon,  5 Jun 2023 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685988393;
        bh=140neydbH4NqzueFi/85G/gtjGnfr6/Oyl6MerHqEJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ho2ugw8Dg07or4Fp1vy7jflDC1s+g84MnwRmDDKuGLEQbpTxvhPn5lsrmZTyKsD18
         nqzwogkfebsMUdpKDyJ/jGyyfnpLb8j9OyJKBHGy28xtpT7a59QohfImK07jz9nPC1
         AuBjAV1HON8TDCSyGs1qY7jNAFkihFTaZc8quFVfvjg7Ttd1oNBBVXlBQ1vZCO4Cox
         H5maUUFbo7YwAgZmMBHQ6mvbO6bTXu4ItY2cqKsWrVQTbzEAZlYXeTWulQ7WUHbPei
         rMvaDg2QC0FTXcFdwcb23Ahc6dX1fQ1crzYhS4d9pTsO5t7hefF9Z42N/DAYRgbSGG
         nClEkX1QwEvRA==
Date:   Mon, 5 Jun 2023 11:06:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
        chuck.lever@oracle.com
Subject: Re: [PATCH 66/69] ynl: fix nested policy attribute type
Message-ID: <20230605110631.5a7d8074@kernel.org>
In-Reply-To: <20230605094617.3564079-1-arkadiusz.kubalewski@intel.com>
References: <20230605094617.3564079-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Jun 2023 11:46:17 +0200 Arkadiusz Kubalewski wrote:
> When nested attribute is used, generated type in the netlink policy
> is NLA_NEST, which is wrong as there is no such type. Fix be adding
> `ed` sufix for policy generated for 'nest' type attribute.
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  tools/net/ynl/ynl-gen-c.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 28afb0846143..89603866d4a0 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -113,7 +113,10 @@ class Type(SpecAttr):
>          return '{ .type = ' + policy + ', }'
>  
>      def attr_policy(self, cw):
> -        policy = c_upper('nla-' + self.attr['type'])
> +        if (self.attr['type'] == 'nest'):
> +            policy = c_upper('nla-' + self.attr['type'] + 'ed')
> +        else:
> +            policy = c_upper('nla-' + self.attr['type'])
>  
>          spec = self._attr_policy(policy)
>          cw.p(f"\t[{self.enum_name}] = {spec},")

For nests the policy should come from

  class TypeNest -> def _attr_policy()

why do we need to tweak the default implementation in the parent class?
-- 
pw-bot: cr

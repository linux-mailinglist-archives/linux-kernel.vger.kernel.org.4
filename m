Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612DF74FE09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGLD76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGLD74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6FD10F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 20:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FBB616B1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4A7C433C8;
        Wed, 12 Jul 2023 03:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689134394;
        bh=jivmgpmc6JQfUtDNCPIZH5elztkn4Na7q9BT74Iv6i8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVEei7kfnJpWlavWG0wwDbSPgVxo19cQ7Ubv7KKcPzdR5xTjjTYa84dTEpTRwC+u0
         wE2QTr+9PDu+b93TNKdA/DiJR3VnqRRqn53Zfwf+kmSiYo8wU8QoJfCl9/WwQNs405
         C98jcVCx4FFrsHkVQzEqu5QNhDGfxL+ehiiAtwnJl3SehzCBT8nl6hbP9RoYliKjAQ
         SYPZNzPHDlSG6QQHCYi4WXu4WIfLNl/8FTg0D/vcgLwU2IenvzEjg/Y0Nft01pkZFC
         a52yRIVNL88B4nP6B5ds6f3lqfBZGmvBxnWVoPykGlEmEkvD6IwbB0fMVM7jfiDKKH
         eI88klINV8+uA==
Date:   Tue, 11 Jul 2023 20:59:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
        chuck.lever@oracle.com
Subject: Re: [PATCH net-next] tools: ynl-gen: fix parse multi-attr enum
 attribute
Message-ID: <20230711205953.346e883b@kernel.org>
In-Reply-To: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
References: <20230711095323.121131-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 11:53:23 +0200 Arkadiusz Kubalewski wrote:
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 3b343d6cbbc0..553d82dd6382 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -407,7 +407,14 @@ class YnlFamily(SpecFamily):
>                  raw >>= 1
>                  i += 1
>          else:
> -            value = enum.entries_by_val[raw - i].name
> +            if attr_spec.is_multi:
> +                for index in range(len(raw)):
> +                    if (type(raw[index]) == int):
> +                        enum_name = enum.entries_by_val[raw[index] - i].name
> +                        rsp[attr_spec['name']][index] = enum_name
> +                return
> +            else:
> +                value = enum.entries_by_val[raw - i].name
>          rsp[attr_spec['name']] = value

Two asks:

First this function stupidly looks at value-start. Best I can tell this
is a leftover from when enum set was an array, but potentially "indexed
with an offset" (ie. if value start = 10, first elem would have value
11, second 12 etc.). When we added support for sparse enums this was
carried forward, but it's actually incorrect. entries_by_val is indexed
with the real value, we should not subtract the start-value. So please
send a patch to set i to 0 at the start and ignore start-value here
(or LMK if I should send one).

Second, instead of fixing the value up here, after already putting it
in the rsp - can we call this function to decode the enum before?
A bit hard to explain, let me show you the diff of what I have in mind
for the call site:

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1b3a36fbb1c3..e2e8a8c5fb6b 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -466,15 +466,15 @@ genl_family_name_to_id = None
             else:
                 raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
 
+            if 'enum' in attr_spec:
+                decoded = self._decode_enum(rsp, attr_spec)
+
             if not attr_spec.is_multi:
                 rsp[attr_spec['name']] = decoded
             elif attr_spec.name in rsp:
                 rsp[attr_spec.name].append(decoded)
             else:
                 rsp[attr_spec.name] = [decoded]
-
-            if 'enum' in attr_spec:
-                self._decode_enum(rsp, attr_spec)
         return rsp
 
     def _decode_extack_path(self, attrs, attr_set, offset, target):

Then _decode_enum() only has to ever deal with single values,
and the caller will take care of mutli_attr like it would for any other
type?
-- 
pw-bot: cr
